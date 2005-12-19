Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVLSWgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVLSWgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 17:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbVLSWgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 17:36:08 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:30391 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965014AbVLSWgG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 17:36:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FmYCv3iow60TXSSBnJ7NBOBmcxgB0otckFfpsabiatJJX+T1c+DR0wYtobMiBrj2NqMcjVZhemaRHR6ItB9WTaOmcRsRlySqfJxborjR1pexk1y8PMFXt7qoxHmt+SCGMGOFHbH239Tk1D9SjSAk1UvbdXi1p94B23sXTRpJk8c=
Message-ID: <4807377b0512191436i5b68da0blf640e8a4922b2000@mail.gmail.com>
Date: Mon, 19 Dec 2005 14:36:05 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [BUG][PATCH] e1000: Fix invalid memory reference
Cc: kaneshige.kenji@jp.fujitsu.com, NetDEV list <netdev@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <439EA1F4.3000204@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <439EA1F4.3000204@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch!
Jeff, if you would be so kind as to apply this, thanks...

This patch fixes invalid memory reference in the e1000 driver which
would cause kernel panic.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

---------- Forwarded message ----------
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Dec 13, 2005 2:27 AM
Subject: [BUG][PATCH] e1000: Fix invalid memory reference
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>


Hi,

I encountered a kernel panic which was caused by the invalid memory
access by e1000 driver. The following patch fixes this issue.

Thanks,
Kenji Kaneshige


This patch fixes invalid memory reference in the e1000 driver which
would cause kernel panic.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/net/e1000/e1000_param.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

Index: linux-2.6.15-rc5/drivers/net/e1000/e1000_param.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/net/e1000/e1000_param.c
+++ linux-2.6.15-rc5/drivers/net/e1000/e1000_param.c
@@ -545,7 +545,7 @@ e1000_check_fiber_options(struct e1000_a
 static void __devinit
 e1000_check_copper_options(struct e1000_adapter *adapter)
 {
-       int speed, dplx;
+       int speed, dplx, an;
        int bd = adapter->bd_number;

        { /* Speed */
@@ -641,8 +641,12 @@ e1000_check_copper_options(struct e1000_
                                         .p = an_list }}
                };

-               int an = AutoNeg[bd];
-               e1000_validate_option(&an, &opt, adapter);
+               if (num_AutoNeg > bd) {
+                       an = AutoNeg[bd];
+                       e1000_validate_option(&an, &opt, adapter);
+               } else {
+                       an = opt.def;
+               }
                adapter->hw.autoneg_advertised = an;
        }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

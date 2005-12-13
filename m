Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVLMK2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVLMK2V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbVLMK2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:28:21 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:14992 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932611AbVLMK2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:28:20 -0500
Message-ID: <439EA1F4.3000204@jp.fujitsu.com>
Date: Tue, 13 Dec 2005 19:27:00 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [BUG][PATCH] e1000: Fix invalid memory reference
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
-	int speed, dplx;
+	int speed, dplx, an;
 	int bd = adapter->bd_number;
 
 	{ /* Speed */
@@ -641,8 +641,12 @@ e1000_check_copper_options(struct e1000_
 					 .p = an_list }}
 		};
 
-		int an = AutoNeg[bd];
-		e1000_validate_option(&an, &opt, adapter);
+		if (num_AutoNeg > bd) {
+			an = AutoNeg[bd];
+			e1000_validate_option(&an, &opt, adapter);
+		} else {
+			an = opt.def;
+		}
 		adapter->hw.autoneg_advertised = an;
 	}
 

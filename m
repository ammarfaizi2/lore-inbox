Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270578AbUJTWy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270578AbUJTWy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270553AbUJTWyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:54:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:62888 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270590AbUJTWvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:51:13 -0400
Date: Wed, 20 Oct 2004 15:53:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6 IrDA] Stir driver usb reset fix
Message-Id: <20041020155349.4514de82.akpm@osdl.org>
In-Reply-To: <20041020010733.GJ12932@bougret.hpl.hp.com>
References: <20041020010733.GJ12932@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:
>
> 	o [CORRECT] stir4200 - get rid of reset on speed change
> The Sigmatel 4200 doesn't accept the address setting which gets done on
> USB reset.  The USB core recently changed to resend address (or
> something like that), so usb_reset_device is failing.

This needs fixups due to competing changes.  Please review:


From: Jean Tourrilhes <jt@bougret.hpl.hp.com>

From: Stephen Hemminger

o [CORRECT] stir4200 - get rid of reset on speed change The Sigmatel 4200
  doesn't accept the address setting which gets done on USB reset.  The USB
  core recently changed to resend address (or something like that), so
  usb_reset_device is failing.

The device works without doing the USB reset on speed change, it just
will be less robust in recovering when things get wedged (like coming
out of FIR mode).

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/net/irda/stir4200.c |    3 ---
 1 files changed, 3 deletions(-)

diff -puN drivers/net/irda/stir4200.c~irda-stir-driver-usb-reset-fix drivers/net/irda/stir4200.c
--- 25/drivers/net/irda/stir4200.c~irda-stir-driver-usb-reset-fix	Wed Oct 20 15:51:39 2004
+++ 25-akpm/drivers/net/irda/stir4200.c	Wed Oct 20 15:52:50 2004
@@ -528,11 +528,8 @@ static int change_speed(struct stir_cb *
 		err = rc;
 		goto out;
 	}
-	err = usb_reset_device(stir->usbdev);
 	if (rc)
 		usb_unlock_device(stir->usbdev);
-	if (err)
-		goto out;
 
 	/* Reset modulator */
 	err = write_reg(stir, REG_CTRL1, CTRL1_SRESET);
_


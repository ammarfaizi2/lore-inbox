Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWGTQA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWGTQA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 12:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWGTQA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 12:00:28 -0400
Received: from assei2bl6.telenet-ops.be ([195.130.133.69]:27864 "EHLO
	assei2bl6.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1030350AbWGTQAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 12:00:18 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: dustin@sensoria.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] smc911x: Re-release spinlock on spurious interrupt
Date: Thu, 20 Jul 2006 05:59:15 +0200
Message-ID: <87psg1hqp8.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The smc911x driver forgets to release the spinlock on spurious
interrupts. This little patch fixes it.

diff -Naur linux-2.6.18-rc2.orig/drivers/net/smc911x.c linux-2.6.18-rc2/drivers/net/smc911x.c
--- linux-2.6.18-rc2.orig/drivers/net/smc911x.c	2006-07-20 10:26:20.000000000 +0200
+++ linux-2.6.18-rc2/drivers/net/smc911x.c	2006-07-20 17:44:26.000000000 +0200
@@ -1092,6 +1092,7 @@
 	/* Spurious interrupt check */
 	if ((SMC_GET_IRQ_CFG() & (INT_CFG_IRQ_INT_ | INT_CFG_IRQ_EN_)) !=
 		(INT_CFG_IRQ_INT_ | INT_CFG_IRQ_EN_)) {
+		spin_unlock_irqrestore(&lp->lock, flags);
 		return IRQ_NONE;
 	}

-- 
Bye, Peter Korsgaard

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266610AbUAWR5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266614AbUAWR5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:57:16 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:44046 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266610AbUAWR5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:57:08 -0500
To: Andreas Happe <andreashappe@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [net/8139cp] still crashes my notebook
References: <slrnc104io.mp.andreashappe@flatline.ath.cx>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 24 Jan 2004 02:56:56 +0900
In-Reply-To: <slrnc104io.mp.andreashappe@flatline.ath.cx>
Message-ID: <87vfn24kgn.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Happe <andreashappe@gmx.net> writes:

> hi,
> 
> my notebook (hp/compaq nx7000) still crashes when using 8139cp (runs
> rock solid with 8139too driver). The computer just locks up, there is no
> dmesg output. This has happened since I've got this laptop (around
> november '03).

It seems 8139cp.c has the race condition of rx_poll and interrupt.
Does the following patch fix this problem?

NOTE, since I don't have this device, patch is untested. Sorry.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

---

 drivers/net/8139cp.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff -puN drivers/net/8139cp.c~8139cp-napi-race-fix drivers/net/8139cp.c
--- linux-2.6.2-rc1/drivers/net/8139cp.c~8139cp-napi-race-fix	2004-01-24 02:22:36.000000000 +0900
+++ linux-2.6.2-rc1-hirofumi/drivers/net/8139cp.c	2004-01-24 02:37:43.000000000 +0900
@@ -615,8 +615,10 @@ rx_next:
 		if (cpr16(IntrStatus) & cp_rx_intr_mask)
 			goto rx_status_loop;
 
-		netif_rx_complete(dev);
+		local_irq_disable();
 		cpw16_f(IntrMask, cp_intr_mask);
+		__netif_rx_complete(dev);
+		local_irq_enable();
 
 		return 0;	/* done */
 	}
@@ -643,6 +645,12 @@ cp_interrupt (int irq, void *dev_instanc
 
 	spin_lock(&cp->lock);
 
+	/* close possible race's with dev_close */
+	if (unlikely(!netif_running(dev))) {
+		cpw16(IntrMask, 0);
+		goto out;
+	}
+
 	if (status & (RxOK | RxErr | RxEmpty | RxFIFOOvr)) {
 		if (netif_rx_schedule_prep(dev)) {
 			cpw16_f(IntrMask, cp_norx_intr_mask);
@@ -664,7 +672,7 @@ cp_interrupt (int irq, void *dev_instanc
 
 		/* TODO: reset hardware */
 	}
-
+out:
 	spin_unlock(&cp->lock);
 	return IRQ_HANDLED;
 }

_

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269033AbTGTXVp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269084AbTGTXVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:21:45 -0400
Received: from mailb.telia.com ([194.22.194.6]:46587 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S269033AbTGTXUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:20:55 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software suspend and RTL 8139too in 2.6.0-test1
References: <m2wuelqo6c.fsf@telia.com> <20030720201050.GB292@elf.ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 21 Jul 2003 00:03:36 +0200
In-Reply-To: <20030720201050.GB292@elf.ucw.cz>
Message-ID: <m27k6c6ekn.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
> 
> > This patch is needed to make software suspend work with the 8139too
> > driver loaded.
> 
> There's more complicated patch at
> http://mrohne.home.cern.ch/mrohne/P2120/P2120_Linux_S3.html. Could you
> test it, perhaps?

It works even better than my patch. With my patch the NIC would not
work for a few seconds after resume, until the driver realized
something was wrong and reinitialized the card. With this patch I
don't see that problem.

Here is the patch for 2.6.0-test1 with only the 8139too changes.

--- linux/drivers/net/8139too.c.old	Sun Jul 20 23:56:19 2003
+++ linux/drivers/net/8139too.c	Sun Jul 20 22:54:37 2003
@@ -109,6 +109,7 @@
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/completion.h>
+#include <linux/suspend.h>
 #include <linux/crc32.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -565,6 +566,7 @@
 	void *mmio_addr;
 	int drv_flags;
 	struct pci_dev *pci_dev;
+	u32 pci_state[16];
 	struct net_device_stats stats;
 	unsigned char *rx_ring;
 	unsigned int cur_rx;	/* Index into the Rx buffer of next Rx pkt. */
@@ -1597,6 +1599,8 @@
 		timeout = next_tick;
 		do {
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_IOTHREAD);
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
@@ -2566,6 +2570,9 @@
 	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
 	RTL_W32 (RxMissed, 0);
 
+	pci_save_state (pdev, tp->pci_state);
+	pci_set_power_state (pdev, 3);
+
 	spin_unlock_irqrestore (&tp->lock, flags);
 	return 0;
 }
@@ -2574,11 +2581,15 @@
 static int rtl8139_resume (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
+	struct rtl8139_private *tp = dev->priv;
 
 	if (!netif_running (dev))
 		return 0;
-	netif_device_attach (dev);
+	pci_set_power_state (pdev, 0);
+	pci_restore_state (pdev, tp->pci_state);
+	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
+	netif_device_attach (dev);
 	return 0;
 }
 

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270783AbTGVK4B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270752AbTGVKzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:55:38 -0400
Received: from maild.telia.com ([194.22.190.101]:27123 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S270688AbTGVKzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:55:36 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Pavel Machek <pavel@ucw.cz>, ole.rohne@cern.ch,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 8390too, radeonfb support
References: <20030720213014.GA810@elf.ucw.cz> <20030721184400.GA32754@gtf.org>
From: Peter Osterlund <petero2@telia.com>
Date: 22 Jul 2003 13:10:24 +0200
In-Reply-To: <20030721184400.GA32754@gtf.org>
Message-ID: <m24r1eolzz.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> On Sun, Jul 20, 2003 at 11:30:14PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > Ole put some patches on his webpage. I ported them to
> > 2.6.0-test1. Could someone who has hardware test them/push them to
> > linus?
> 
> Please push net driver patches to the net driver maintainer, who has
> already applied the simple 8139too-refrigerator patch.

Here is an incremental patch. 

Correctly initialize the NIC in 8139too.c after software
suspend/resume, so that we don't get Tx/Rx DMA timeouts.

Tested and works fine on my computer. This patch originates from Ole
Myren Rohne's web page:

        http://mrohne.home.cern.ch/mrohne/P2120/P2120_Linux_S3.html

 drivers/net/8139too.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN drivers/net/8139too.c~rtl8139-suspend-2 drivers/net/8139too.c
--- linux/drivers/net/8139too.c~rtl8139-suspend-2	Tue Jul 22 12:50:36 2003
+++ linux-petero/drivers/net/8139too.c	Tue Jul 22 12:50:36 2003
@@ -566,6 +566,7 @@ struct rtl8139_private {
 	void *mmio_addr;
 	int drv_flags;
 	struct pci_dev *pci_dev;
+	u32 pci_state[16];
 	struct net_device_stats stats;
 	unsigned char *rx_ring;
 	unsigned int cur_rx;	/* Index into the Rx buffer of next Rx pkt. */
@@ -2570,6 +2571,9 @@ static int rtl8139_suspend (struct pci_d
 	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
 	RTL_W32 (RxMissed, 0);
 
+	pci_save_state (pdev, tp->pci_state);
+	pci_set_power_state (pdev, 3);
+
 	spin_unlock_irqrestore (&tp->lock, flags);
 	return 0;
 }
@@ -2578,11 +2582,15 @@ static int rtl8139_suspend (struct pci_d
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
 

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

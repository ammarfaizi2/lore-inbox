Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVGaUJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVGaUJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 16:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVGaUJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 16:09:57 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:1232 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261960AbVGaUJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 16:09:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: revert yenta free_irq on suspend
Date: Sun, 31 Jul 2005 22:15:03 +0200
User-Agent: KMail/1.8.1
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com> <Pine.LNX.4.61.0507302318090.5286@goblin.wat.veritas.com> <200507310109.16876.rjw@sisk.pl>
In-Reply-To: <200507310109.16876.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507312215.04494.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 31 of July 2005 01:09, Rafael J. Wysocki wrote:
> On Sunday, 31 of July 2005 00:24, Hugh Dickins wrote:
> > On Sun, 31 Jul 2005, Rafael J. Wysocki wrote:
> > > On Saturday, 30 of July 2005 23:32, Hugh Dickins wrote:
> > > > On Sat, 30 Jul 2005, Rafael J. Wysocki wrote:
> > > > > 
> > > > > Could you please send the /proc/interrupts from your box?
> > > > 
> > > >  11:      57443          XT-PIC  yenta, yenta, eth0
> > > 
> > > Thanks.  It looks like eth0 gets a yenta's interrupt and goes awry.
> > > Could you please tell me what driver the eth0 is?
> > 
> > CONFIG_VORTEX drivers/net/3c59x.c:
> > 0000:02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.19
> 
> Thanks again.  From the first look the suspend/resume routines of the driver
> are missing some calls.  In particular, with the IRQ-freeing patch for yenta it is
> likely to get an out-of-order interrupt as I suspected.
> 
> Linus has apparently dropped that patch for yenta, but in case it is
> reintroduced in the future you will probably need a patch to make the network
> driver cooperate.  I'll try to prepare one tomorrow, if I can, but I have no hardware
> to test it.

The patch follows.  It compiles and should work, though I haven't tested it.

Greets,
Rafael

Index: linux-2.6.13-rc4-git3/drivers/net/3c59x.c
===================================================================
--- linux-2.6.13-rc4-git3.orig/drivers/net/3c59x.c
+++ linux-2.6.13-rc4-git3/drivers/net/3c59x.c
@@ -973,6 +973,11 @@ static int vortex_suspend (struct pci_de
 			netif_device_detach(dev);
 			vortex_down(dev, 1);
 		}
+		pci_save_state(pdev);
+		pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
+		free_irq(dev->irq, dev);
+		pci_disable_device(pdev);
+		pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	}
 	return 0;
 }
@@ -980,8 +985,19 @@ static int vortex_suspend (struct pci_de
 static int vortex_resume (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
+	struct vortex_private *vp = netdev_priv(dev);
 
-	if (dev && dev->priv) {
+	if (dev && vp) {
+		pci_set_power_state(pdev, PCI_D0);
+		pci_restore_state(pdev);
+		pci_enable_device(pdev);
+		pci_set_master(pdev);
+		if (request_irq(dev->irq, vp->full_bus_master_rx ?
+				&boomerang_interrupt : &vortex_interrupt, SA_SHIRQ, dev->name, dev)) {
+			printk(KERN_WARNING "%s: Could not reserve IRQ %d\n", dev->name, dev->irq);
+			pci_disable_device(pdev);
+			return -EBUSY;
+		}
 		if (netif_running(dev)) {
 			vortex_up(dev);
 			netif_device_attach(dev);


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

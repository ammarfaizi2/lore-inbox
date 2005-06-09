Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVFIDDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVFIDDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 23:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVFIDDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 23:03:39 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:65239 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S262231AbVFIDDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 23:03:05 -0400
Date: Wed, 8 Jun 2005 21:48:03 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>,
       Davide Rossetti <davide.rossetti@roma1.infn.it>,
       Karsten Keil <kkeil@suse.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050609014803.GA29932@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>,
	Davide Rossetti <davide.rossetti@roma1.infn.it>,
	Karsten Keil <kkeil@suse.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050606224645.GA23989@pingi3.kke.suse.de> <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org> <20050607025054.GC3289@neo.rr.com> <20050607105552.GA27496@pingi3.kke.suse.de> <20050607205800.GB8300@neo.rr.com> <20050608063940.GA31237@pingi3.kke.suse.de> <42A734D8.5000909@roma1.infn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A734D8.5000909@roma1.infn.it>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 08:11:36PM +0200, Davide Rossetti wrote:
> 
> >Looks OK and also work on my HW.
> >
> >Andrew, can you please take this updated version, it is much cleaner and
> >safer, because it handle the IRQ correctly.
> >
> > 
> >
> >>--- a/drivers/net/tulip/tulip_core.c	2005-05-27 22:06:00.000000000 -0400
> >>+++ b/drivers/net/tulip/tulip_core.c	2005-06-07 16:34:13.641177456 -0400
> >>@@ -1756,11 +1756,19 @@
> >>{
> >>	struct net_device *dev = pci_get_drvdata(pdev);
> >>
> >>-	if (dev && netif_running (dev) && netif_device_present (dev)) {
> >>-		netif_device_detach (dev);
> >>-		tulip_down (dev);
> >>-		/* pci_power_off(pdev, -1); */
> >>-	}
> >>+	if (!dev)
> >>+		return -EINVAL;
> >>+
> >>+	if (netif_running(dev))
> >>+		tulip_down(dev);
> >>+
> >>+	netif_device_detach(dev);
> >>+	pci_save_state(pdev);
> >>+
> >>+	free_irq(dev->irq, dev);
> >>   
> >>
> isn't it safer to swap these last two guys ?? in theory there could be 
> an IRQ betwen pci_save_state() and free_irq()...

Well, so not exactly.  The issue here was that we might access the hardware
while it's:
a.) physically powered down
b.) making a power transition

In this case, the device is still powered on, so there shouldn't be a problem.
However, changing the order shouldn't break anything.  If you think it would
be cleaner this way and someone is willing to confirm that it still works,
then we can change it to the patch below.

Thanks,
Adam

Here's an updated patch:


[PM] fix suspend/resume for tulip based cards

This patch allows the tulip driver to suspend and resume properly.  It was
originally written by Karsten Keil and then modified by Adam Belay.

Signed-off-by: Karsten Keil <kkeil@suse.de>
Signed-off-by: Adam Belay <abelay@novell.com>

--- a/drivers/net/tulip/tulip_core.c	2005-05-27 22:06:00.000000000 -0400
+++ b/drivers/net/tulip/tulip_core.c	2005-06-08 21:28:26.111797528 -0400
@@ -1756,11 +1756,19 @@
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
-	if (dev && netif_running (dev) && netif_device_present (dev)) {
-		netif_device_detach (dev);
-		tulip_down (dev);
-		/* pci_power_off(pdev, -1); */
-	}
+	if (!dev)
+		return -EINVAL;
+
+	if (netif_running(dev))
+		tulip_down(dev);
+
+	netif_device_detach(dev);
+	free_irq(dev->irq, dev);
+
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+
 	return 0;
 }
 
@@ -1768,15 +1776,26 @@
 static int tulip_resume(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
+	int retval;
 
-	if (dev && netif_running (dev) && !netif_device_present (dev)) {
-#if 1
-		pci_enable_device (pdev);
-#endif
-		/* pci_power_on(pdev); */
-		tulip_up (dev);
-		netif_device_attach (dev);
+	if (!dev)
+		return -EINVAL;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+
+	pci_enable_device(pdev);
+
+	if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev))) {
+		printk (KERN_ERR "tulip: request_irq failed in resume\n");
+		return retval;
 	}
+
+	netif_device_attach(dev);
+
+	if (netif_running(dev))
+		tulip_up(dev);
+
 	return 0;
 }
 

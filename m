Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWH0EPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWH0EPT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 00:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWH0EPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 00:15:19 -0400
Received: from mga07.intel.com ([143.182.124.22]:37507 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751156AbWH0EPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 00:15:17 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,173,1154934000"; 
   d="scan'208"; a="108104639:sNHT24346878997"
Date: Sat, 26 Aug 2006 21:15:04 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 08/10] [TULIP] Handle pci_enable_device() errors in resume
Message-ID: <20060827041504.GE25003@goober>
References: <20060826000227.818796000@linux.intel.com> <20060826000304.251263000@linux.intel.com> <1156610518.3007.287.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156610518.3007.287.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 05:41:58PM +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-25 am 17:02 -0700, ysgrifennodd Valerie Henson:
> >  	pci_set_power_state(pdev, PCI_D0);
> >  	pci_restore_state(pdev);
> >  
> > -	pci_enable_device(pdev);
> > +	if ((retval = pci_enable_device(pdev))) {
> > +		printk (KERN_ERR "tulip: pci_enable_device failed in resume\n");
> > +		return retval;
> > +	}
> Should you not stick it back in D3 if you are being neat about this ?

I don't know.  Any thoughts from the peanut gallery?  I've spent some
time trolling both docs and other drivers, but I haven't yet found an
example of a driver that correctly handles all the resume error cases.
Also, at least one other driver does a pci_disable_device() if the
request_irq() fails - should tulip do this too?

> NAK: What about rtnl_lock()

Gah.  Thanks, how about the patch below instead?

-VAL

Subject: [TULIP] Handle pci_enable_device() errors in resume

Signed-off-by: Valerie Henson <val_henson@linux.intel.com>
Cc: Jeff Garzik <jeff@garzik.org>

---
 drivers/net/tulip/de2104x.c     |   16 ++++++++++------
 drivers/net/tulip/tulip_core.c  |    5 ++++-
 drivers/net/tulip/winbond-840.c |   12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

--- linux-2.6.18-rc4-mm1-tulip.orig/drivers/net/tulip/tulip_core.c
+++ linux-2.6.18-rc4-mm1-tulip/drivers/net/tulip/tulip_core.c
@@ -1780,7 +1780,10 @@ static int tulip_resume(struct pci_dev *
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 
-	pci_enable_device(pdev);
+	if ((retval = pci_enable_device(pdev))) {
+		printk (KERN_ERR "tulip: pci_enable_device failed in resume\n");
+		return retval;
+	}
 
 	if ((retval = request_irq(dev->irq, &tulip_interrupt, IRQF_SHARED, dev->name, dev))) {
 		printk (KERN_ERR "tulip: request_irq failed in resume\n");
--- linux-2.6.18-rc4-mm1-tulip.orig/drivers/net/tulip/winbond-840.c
+++ linux-2.6.18-rc4-mm1-tulip/drivers/net/tulip/winbond-840.c
@@ -1626,14 +1626,18 @@ static int w840_resume (struct pci_dev *
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
+	int retval = 0;
 
 	rtnl_lock();
 	if (netif_device_present(dev))
 		goto out; /* device not suspended */
 	if (netif_running(dev)) {
-		pci_enable_device(pdev);
-	/*	pci_power_on(pdev); */
-
+		if ((retval = pci_enable_device(pdev))) {
+			printk (KERN_ERR
+				"%s: pci_enable_device failed in resume\n",
+				dev->name);
+			goto out;
+		}
 		spin_lock_irq(&np->lock);
 		iowrite32(1, np->base_addr+PCIBusCfg);
 		ioread32(np->base_addr+PCIBusCfg);
@@ -1651,7 +1655,7 @@ static int w840_resume (struct pci_dev *
 	}
 out:
 	rtnl_unlock();
-	return 0;
+	return retval;
 }
 #endif
 
--- linux-2.6.18-rc4-mm1-tulip.orig/drivers/net/tulip/de2104x.c
+++ linux-2.6.18-rc4-mm1-tulip/drivers/net/tulip/de2104x.c
@@ -2138,17 +2138,21 @@ static int de_resume (struct pci_dev *pd
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct de_private *de = dev->priv;
+	int retval = 0;
 
 	rtnl_lock();
 	if (netif_device_present(dev))
 		goto out;
-	if (netif_running(dev)) {
-		pci_enable_device(pdev);
-		de_init_hw(de);
-		netif_device_attach(dev);
-	} else {
-		netif_device_attach(dev);
+	if (!netif_running(dev))
+		goto out_attach;
+	if ((retval = pci_enable_device(pdev))) {
+		printk (KERN_ERR "%s: pci_enable_device failed in resume\n",
+			dev->name);
+		goto out;
 	}
+	de_init_hw(de);
+out_attach:
+	netif_device_attach(dev);
 out:
 	rtnl_unlock();
 	return 0;

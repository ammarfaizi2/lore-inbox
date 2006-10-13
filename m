Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWJMBNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWJMBNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 21:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWJMBNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 21:13:22 -0400
Received: from twin.jikos.cz ([213.151.79.26]:3302 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750711AbWJMBNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 21:13:21 -0400
Date: Fri, 13 Oct 2006 03:12:55 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Hemminger <shemminger@osdl.org>, mlindner@syskonnect.de,
       rroesler@syskonnect.de, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] sk98lin: handle pci_enable_device() return value in
 skge_resume() properly
In-Reply-To: <20061012175013.87564a57.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610130310120.29022@twin.jikos.cz>
References: <Pine.LNX.4.64.0610130002320.29022@twin.jikos.cz>
 <20061012152512.66f147b8@freekitty> <Pine.LNX.4.64.0610130028450.29022@twin.jikos.cz>
 <20061012154714.6924f465@freekitty> <Pine.LNX.4.64.0610130052440.29022@twin.jikos.cz>
 <20061012175013.87564a57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006, Andrew Morton wrote:

> >  	pci_set_power_state(pdev, PCI_D0);
> >  	pci_restore_state(pdev);
> > -	pci_enable_device(pdev);
> > +	ret = pci_enable_device(pdev);
> > +	if (ret) {
> > +		printk(KERN_ERR "sk98lin: Cannot enable PCI device %s during resume\n", 
> > +				dev->name);
> > +		unregister_netdev(dev);
> This looks rather wrong - skge_exit() will run unregister_netdev() again.

You are of course right (the problem was also spotted by Russell King). 
This I believe is the correct one for the sk98lin case.

[PATCH] fix sk98lin driver, ignoring return value from pci_enable_device()

add check of return value to _resume() function of sk98lin driver.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

---

 drivers/net/sk98lin/skge.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
index d4913c3..3a9323d 100644
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -5070,7 +5070,12 @@ static int skge_resume(struct pci_dev *p
 
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		printk(KERN_WARNING "sk98lin: unable to enable device %s in resume\n",
+				dev->name);
+		goto out_err;
+	}	
 	pci_set_master(pdev);
 	if (pAC->GIni.GIMacsFound == 2)
 		ret = request_irq(dev->irq, SkGeIsr, IRQF_SHARED, "sk98lin", dev);
@@ -5078,10 +5083,8 @@ static int skge_resume(struct pci_dev *p
 		ret = request_irq(dev->irq, SkGeIsrOnePort, IRQF_SHARED, "sk98lin", dev);
 	if (ret) {
 		printk(KERN_WARNING "sk98lin: unable to acquire IRQ %d\n", dev->irq);
-		pAC->AllocFlag &= ~SK_ALLOC_IRQ;
-		dev->irq = 0;
-		pci_disable_device(pdev);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_err;
 	}
 
 	netif_device_attach(dev);
@@ -5098,6 +5101,13 @@ static int skge_resume(struct pci_dev *p
 	}
 
 	return 0;
+out_err:
+	pAC->AllocFlag &= ~SK_ALLOC_IRQ;
+	dev->irq = 0;
+	pci_disable_device(pdev);
+
+	return ret;
+
 }
 #else
 #define skge_suspend NULL

-- 
Jiri Kosina

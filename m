Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWJLW5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWJLW5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWJLW5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:57:49 -0400
Received: from twin.jikos.cz ([213.151.79.26]:25812 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751288AbWJLW5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:57:47 -0400
Date: Fri, 13 Oct 2006 00:57:18 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Stephen Hemminger <shemminger@osdl.org>
cc: mlindner@syskonnect.de, rroesler@syskonnect.de,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] sk98lin: handle pci_enable_device() return value in
 skge_resume() properly
In-Reply-To: <20061012154714.6924f465@freekitty>
Message-ID: <Pine.LNX.4.64.0610130052440.29022@twin.jikos.cz>
References: <Pine.LNX.4.64.0610130002320.29022@twin.jikos.cz>
 <20061012152512.66f147b8@freekitty> <Pine.LNX.4.64.0610130028450.29022@twin.jikos.cz>
 <20061012154714.6924f465@freekitty>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006, Stephen Hemminger wrote:

> > > Having the device unregister seems harsh.
> > What would be the proper way? As the initialization failed, accessing 
> > the device would not make sense any more (therefore I don't think that 
> > calling skge_remove_one() would be OK, as it issues calls to 
> > SkEventQueue() and SkEventDispatcher(), trying to send something to 
> > the card).
> I guess, its just not clear what the state of the machine is anyway
> if you can't enable the device something is hosed (or the device was
> hot removed).

Well, it depends on definition of 'hot'. What would for example happen in 
the case suspend-to-disk -> remove the card when the machine is switched 
off -> resume-from-disk? I guess that exactly this pci_enable_device() 
will fail, so we definitely have to handle this case, as it can easily 
happen.

> > > Why put condtional on same line?
> > Pardon me?
> I prefer:
> 	ret = pci_enable_device(pdev);

As you wish. 

[PATCH] fix sk98lin driver, ignoring return value from pci_enable_device()

add check of return value to _resume() function of sk98lin driver.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

---

 drivers/net/sk98lin/skge.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
index d4913c3..d691811 100644
--- a/drivers/net/sk98lin/skge.c
+++ b/drivers/net/sk98lin/skge.c
@@ -5070,7 +5070,13 @@ static int skge_resume(struct pci_dev *p
 
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
-	pci_enable_device(pdev);
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		printk(KERN_ERR "sk98lin: Cannot enable PCI device %s during resume\n", 
+				dev->name);
+		unregister_netdev(dev);
+		return ret;
+	}
 	pci_set_master(pdev);
 	if (pAC->GIni.GIMacsFound == 2)
 		ret = request_irq(dev->irq, SkGeIsr, IRQF_SHARED, "sk98lin", dev);

-- 
Jiri Kosina

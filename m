Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVFFTwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVFFTwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVFFTt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:49:59 -0400
Received: from mailhost.somanetworks.com ([216.126.67.42]:60579 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S261642AbVFFTsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:48:16 -0400
Date: Mon, 6 Jun 2005 15:48:04 -0400 (EDT)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Greg K-H <greg@kroah.com>
cc: Prarit Bhargava <prarit@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI Hotplug: more CPCI updates
In-Reply-To: <Pine.LNX.4.58.0506012257120.32742@rancor.yyz.somanetworks.com>
Message-ID: <Pine.LNX.4.58.0506061539380.19525@rancor.yyz.somanetworks.com>
References: <11176025242587@kroah.com> <429E71CB.3010609@sgi.com>
 <429E7304.3060702@sgi.com> <Pine.LNX.4.58.0506012257120.32742@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Scott Murray wrote:

> On Wed, 1 Jun 2005, Prarit Bhargava wrote:
> 
> > Prarit Bhargava wrote:
> > > Greg KH wrote:
> > > 
> > >> [PATCH] PCI Hotplug: more CPCI updates
> > > 
> > > 
> > >> - Switch to pci_get_slot instead of deprecated pci_find_slot.
> > >> - A bunch of CodingStyle fixes.
> > > 
> > > 
> > >> -            }
> > >> +        dev = pci_get_slot(slot->bus, PCI_DEVFN(slot->number, 0));
> > >> +        if (dev) {
> > >> +            if (update_adapter_status(slot->hotplug_slot, 1))
> > >> +                warn("failure to update adapter file");
> > >> +            if (update_latch_status(slot->hotplug_slot, 1))
> > >> +                warn("failure to update latch file");
> > >> +            slot->dev = dev;
> > >>          }
> > >>      }
> > > 
> > > 
> > > I don't claim to know the code as well as Scott or Greg does, but I 
> > > don't see a pci_put_dev for the slot->dev to clean up the usage count?
> > 
> > s/pci_put_dev/pci_dev_put/g
> 
> Sorry Prarit, when you suggested I switch over to pci_get_slot in your 
> previous comments to me, I didn't look that closely and missed the 
> reference counting.  Greg, I think the required fix is just a couple of 
> lines in my hotplug slot release function, I'll code it up and test it 
> ASAP tomorrow with an eye on getting a patch off by early afternoon EDT.

Greg, sorry for the delay, here's a patch that fixes up the pci_dev 
refcounting in the CPCI code.  I've done some testing against it and it 
seems fine here.

 cpci_hotplug_core.c |    2 ++
 cpci_hotplug_pci.c  |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

Signed-Off-By: scottm@somanetworks.com

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet --exclude=SOMA linux-2.6/drivers/pci/hotplug/cpci_hotplug_core.c linux-2.6-cpci/drivers/pci/hotplug/cpci_hotplug_core.c
--- linux-2.6/drivers/pci/hotplug/cpci_hotplug_core.c	2005-06-02 15:10:19.000000000 -0400
+++ linux-2.6-cpci/drivers/pci/hotplug/cpci_hotplug_core.c	2005-06-02 15:18:40.000000000 -0400
@@ -217,6 +217,8 @@
 	kfree(slot->hotplug_slot->info);
 	kfree(slot->hotplug_slot->name);
 	kfree(slot->hotplug_slot);
+	if (slot->dev)
+		pci_dev_put(slot->dev);
 	kfree(slot);
 }
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet --exclude=SOMA linux-2.6/drivers/pci/hotplug/cpci_hotplug_pci.c linux-2.6-cpci/drivers/pci/hotplug/cpci_hotplug_pci.c
--- linux-2.6/drivers/pci/hotplug/cpci_hotplug_pci.c	2005-06-02 15:10:19.000000000 -0400
+++ linux-2.6-cpci/drivers/pci/hotplug/cpci_hotplug_pci.c	2005-06-02 15:22:12.000000000 -0400
@@ -315,9 +315,12 @@
 				    PCI_DEVFN(PCI_SLOT(slot->devfn), i));
 		if (dev) {
 			pci_remove_bus_device(dev);
-			slot->dev = NULL;
+			pci_dev_put(dev);
 		}
 	}
+	pci_dev_put(slot->dev);
+	slot->dev = NULL;
+
 	dbg("%s - exit", __FUNCTION__);
 	return 0;
 }


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

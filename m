Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422830AbWBNWBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422830AbWBNWBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422829AbWBNWBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:01:48 -0500
Received: from fmr18.intel.com ([134.134.136.17]:39141 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422826AbWBNWBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:01:47 -0500
Subject: Re: AMD 8131 and MSI quirk
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060214212145.GC14113@mellanox.co.il>
References: <524q799p2t.fsf@cisco.com>
	 <20060214165222.GC12974@mellanox.co.il> <1139940226.18044.3.camel@whizzy>
	 <20060214212145.GC14113@mellanox.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 14:06:19 -0800
Message-Id: <1139954779.26803.3.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 14 Feb 2006 22:01:36.0298 (UTC) FILETIME=[395D18A0:01C631B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 23:21 +0200, Michael S. Tsirkin wrote:
> Quoting Kristen Accardi <kristen.c.accardi@intel.com>:
> > > It turns out AMD 8131 quirk only affects MSI for devices behind the 8131
> > > bridge.  Handle this by adding a flags field in pci_bus, inherited from
> > > parent to child.
> > 
> > It seems like we have a way to turn of msi already (the no_msi bit in
> > the pci_dev structure).  Does it make sense to just have the child bus
> > pci_dev structure inherit the no_msi bit from the parent's pci_dev
> > structure when doing an allocation, or does that unnecessarily remove
> > the msi capability for devices that may not need it?
> > 
> > Kristen
> 
> This bit is already used to mean that msi is disabled for a specific device,
> which appears to be a PCI Express to PCI bridge (PCI_DEVICE_ID_INTEL_PXH).  So
> it seems that disabling MSI for child devices as well might break things (i.e.
> disable msi unnecessarily).
> Working for Intel, I guess you would know about the PCI_DEVICE_ID_INTEL_PXH
> best: what do you say?
> 
> In my opinion, it is cleaner to separate the two concepts: suppress msi
> for child devices versus suppress it for the specific device.
> 
> Right?
> 

I was thinking something along these lines might work for you.  I think
it does the same thing as the other patch, without needing to add extra
flags to pci_bus.  I guess the assumption I made was that if msi is
turned off for a bridge, then all devices under the bridge may not use
msi.   

---
 drivers/pci/msi.c   |    2 +-
 drivers/pci/probe.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- linux-dock-mm.orig/drivers/pci/msi.c
+++ linux-dock-mm/drivers/pci/msi.c
@@ -701,7 +701,7 @@ int pci_enable_msi(struct pci_dev* dev)
 	if (!pci_msi_enable || !dev)
  		return status;
 
-	if (dev->no_msi)
+	if (dev->no_msi || dev->bus->self->no_msi)
 		return status;
 
 	temp = dev->irq;
--- linux-dock-mm.orig/drivers/pci/probe.c
+++ linux-dock-mm/drivers/pci/probe.c
@@ -344,6 +344,7 @@ pci_alloc_child_bus(struct pci_bus *pare
 		return NULL;
 
 	child->self = bridge;
+	child->self->no_msi = parent->self->no_msi;
 	child->parent = parent;
 	child->ops = parent->ops;
 	child->sysdata = parent->sysdata;


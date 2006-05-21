Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWEUN2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWEUN2i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWEUN2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 09:28:38 -0400
Received: from [194.90.237.34] ([194.90.237.34]:43341 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S964867AbWEUN2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 09:28:38 -0400
Date: Sun, 21 May 2006 16:29:50 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Brice Goglin <brice@myri.com>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
Message-ID: <20060521132950.GT30211@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de> <20060521101656.GM30211@mellanox.co.il> <447047F2.2070607@myri.com> <20060521121726.GQ30211@mellanox.co.il> <44705DA4.2020807@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44705DA4.2020807@myri.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 21 May 2006 13:32:36.0156 (UTC) FILETIME=[05AD3FC0:01C67CDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Brice Goglin <brice@myri.com>:
> Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
> 
> Michael S. Tsirkin wrote:
> > MSI is an optional feature so things are supposed to work even without MSI - are
> > you getting that great a benefit from MSI?
> >   
> 
> Not great, I would say small.
> 
> > All mellanox PCI-X devices have a bridge inside them, so ...
> >   
> 
> Ok so you really need something for 2.6.17. What about the attached
> patch to fix the fact that bus flags are not inherited ?
> 
> Signed-off-by: Brice Goglin <brice@myri.com>

The following applies this quirk for MSI-X as well.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.17-rc4/drivers/pci/msi.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/pci/msi.c	2006-05-21 12:49:52.000000000 +0300
+++ linux-2.6.17-rc4/drivers/pci/msi.c	2006-05-21 16:14:50.000000000 +0300
@@ -865,6 +865,7 @@ static int msix_capability_init(struct p
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
+	struct pci_bus *bus;
 	int pos, temp, status = -EINVAL;
 	u16 control;
 
@@ -874,8 +875,9 @@ int pci_enable_msi(struct pci_dev* dev)
 	if (dev->no_msi)
 		return status;
 
-	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-		return -EINVAL;
+	for (bus = dev->bus; bus; bus = bus->parent)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return -EINVAL;
 
 	temp = dev->irq;
 
@@ -1108,6 +1110,7 @@ static int reroute_msix_table(int head, 
  **/
 int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
 {
+	struct pci_bus *bus;
 	int status, pos, nr_entries, free_vectors;
 	int i, j, temp;
 	u16 control;
@@ -1116,6 +1119,10 @@ int pci_enable_msix(struct pci_dev* dev,
 	if (!pci_msi_enable || !dev || !entries)
  		return -EINVAL;
 
+	for (bus = dev->bus; bus; bus = bus->parent)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return -EINVAL;
+
 	status = msi_init();
 	if (status < 0)
 		return status;

-- 
MST

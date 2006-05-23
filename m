Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWEWHFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWEWHFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 03:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWEWHFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 03:05:52 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:14039 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932066AbWEWHFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 03:05:52 -0400
Date: Tue, 23 May 2006 03:05:27 -0400
From: Brice Goglin <brice@myri.com>
To: Greg KH <gregkh@suse.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
Message-ID: <20060523070526.GA30499@myri.com>
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de> <20060521101656.GM30211@mellanox.co.il> <447047F2.2070607@myri.com> <20060521121726.GQ30211@mellanox.co.il> <44705DA4.2020807@myri.com> <20060521131025.GR30211@mellanox.co.il> <447069F7.1010407@myri.com> <20060523041958.GA8415@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060523041958.GA8415@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 09:19:58PM -0700, Greg KH wrote:
> On Sun, May 21, 2006 at 03:24:07PM +0200, Brice Goglin wrote:
> > 
> > Right, thanks. Greg, what do you think of putting the attached patch in
> > 2.6.17 ?
> 
> Ok, does everyone agree that this patch fixes the issues for them?  I've
> had a few other private emails saying that the current code doesn't work
> properly and hadn't been able to determine what was happening.  Thanks
> for these patches.
> 
> > By the way, do we need to check dev->no_msi in pci_enable_msix() too ?
> 
> Yes, good catch, care to respin the patch and give it a good changelog
> entry?

Here you are:

The PCI_BUS_FLAGS_NO_MSI bus flags does not appear do be inherited
correctly from the amd8131 MSI quirk to its parent busses. It makes
devices behind a bridge behind amd8131 try to enable MSI while the
amd8131 does not support it.
We fix this by looking at flags of all parent busses in
pci_enable_msi() and pci_enable_msix().

By the way, also add the missing dev->no_msi check in pci_enable_msix()

Signed-off-by: Brice Goglin <brice@myri.com>

Index: linux-mm/drivers/pci/msi.c
===================================================================
--- linux-mm.orig/drivers/pci/msi.c	2006-05-21 15:12:04.000000000 +0200
+++ linux-mm/drivers/pci/msi.c	2006-05-23 08:31:02.000000000 +0200
@@ -916,6 +916,7 @@
  **/
 int pci_enable_msi(struct pci_dev* dev)
 {
+	struct pci_bus *bus;
 	int pos, temp, status = -EINVAL;
 	u16 control;
 
@@ -925,8 +926,9 @@
 	if (dev->no_msi)
 		return status;
 
-	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
-		return -EINVAL;
+	for (bus = dev->bus; bus; bus = bus->parent)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return -EINVAL;
 
 	temp = dev->irq;
 
@@ -1162,6 +1164,7 @@
  **/
 int pci_enable_msix(struct pci_dev* dev, struct msix_entry *entries, int nvec)
 {
+	struct pci_bus *bus;
 	int status, pos, nr_entries, free_vectors;
 	int i, j, temp;
 	u16 control;
@@ -1170,6 +1173,13 @@
 	if (!pci_msi_enable || !dev || !entries)
  		return -EINVAL;
 
+	if (dev->no_msi)
+		return -EINVAL;
+
+	for (bus = dev->bus; bus; bus = bus->parent)
+		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return -EINVAL;
+
 	status = msi_init();
 	if (status < 0)
 		return status;


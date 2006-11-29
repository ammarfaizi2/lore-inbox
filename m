Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758154AbWK2VxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758154AbWK2VxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 16:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758155AbWK2VxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 16:53:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:12476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758154AbWK2VxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 16:53:21 -0500
Date: Wed, 29 Nov 2006 13:53:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Greg KH" <greg@kroah.com>, "Greg KH" <gregkh@suse.de>,
       "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org,
       myles@mouselemur.cs.byu.edu
Subject: Re: PCI: check szhi when sz is 0 when 64 bit iomem bigger than 4G
Message-Id: <20061129135310.10f1b041.akpm@osdl.org>
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907252@ssvlexmb2.amd.com>
References: <5986589C150B2F49A46483AC44C7BCA4907252@ssvlexmb2.amd.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 13:33:12 -0800
"Lu, Yinghai" <yinghai.lu@amd.com> wrote:

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> 
> >Can you please send me the latest version of this patch, due to all of
> >the different changes that it has gone through, I'm a bit confused...
> 
> Please check 
> 
> http://lkml.org/lkml/2006/11/24/160
> 
> for updated version by Andrew.
> 

This patch has been lost altogether - Greg dropped the base patch so I
dropped the three fixes.

Here it is, all put back together again, against Greg's tree.

It has no changelog.  We're still waiting for a complete description of the
patch: why it is needed, what it does, how it does it.  Please provide
that.


 drivers/pci/probe.c |   69 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 56 insertions(+), 13 deletions(-)

diff -puN drivers/pci/probe.c~gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g drivers/pci/probe.c
--- a/drivers/pci/probe.c~gregkh-pci-pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g
+++ a/drivers/pci/probe.c
@@ -144,6 +144,32 @@ static u32 pci_size(u32 base, u32 maxbas
 	return size;
 }
 
+static u64 pci_size64(u64 base, u64 maxbase, u64 mask)
+{
+	u64 size = mask & maxbase;	/* Find the significant bits */
+	if (!size)
+		return 0;
+
+	/* Get the lowest of them to find the decode size, and
+	   from that the extent.  */
+	size = (size & ~(size-1)) - 1;
+
+	/* base == maxbase can be valid only if the BAR has
+	   already been programmed with all 1s.  */
+	if (base == maxbase && ((base | size) & mask) != mask)
+		return 0;
+
+	return size;
+}
+
+static inline int is_64bit_memory(u32 mask)
+{
+	if ((mask & (PCI_BASE_ADDRESS_SPACE|PCI_BASE_ADDRESS_MEM_TYPE_MASK)) ==
+	    (PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64))
+		return 1;
+	return 0;
+}
+
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg, next;
@@ -151,6 +177,10 @@ static void pci_read_bases(struct pci_de
 	struct resource *res;
 
 	for(pos=0; pos<howmany; pos = next) {
+		u64 l64;
+		u64 sz64;
+		u32 raw_sz;
+
 		next = pos+1;
 		res = &dev->resource[pos];
 		res->name = pci_name(dev);
@@ -163,9 +193,16 @@ static void pci_read_bases(struct pci_de
 			continue;
 		if (l == 0xffffffff)
 			l = 0;
-		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
+		raw_sz = sz;
+		if ((l & PCI_BASE_ADDRESS_SPACE) ==
+				PCI_BASE_ADDRESS_SPACE_MEMORY) {
 			sz = pci_size(l, sz, (u32)PCI_BASE_ADDRESS_MEM_MASK);
-			if (!sz)
+			/*
+			 * For 64bit prefetchable memory sz could be 0, if the
+			 * real size is bigger than 4G, so we need to check
+			 * szhi for that.
+			 */
+			if (!is_64bit_memory(l) && !sz)
 				continue;
 			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
 			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
@@ -178,30 +215,36 @@ static void pci_read_bases(struct pci_de
 		}
 		res->end = res->start + (unsigned long) sz;
 		res->flags |= pci_calc_resource_flags(l);
-		if ((l & (PCI_BASE_ADDRESS_SPACE | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
-		    == (PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+		if (is_64bit_memory(l)) {
 			u32 szhi, lhi;
+
 			pci_read_config_dword(dev, reg+4, &lhi);
 			pci_write_config_dword(dev, reg+4, ~0);
 			pci_read_config_dword(dev, reg+4, &szhi);
 			pci_write_config_dword(dev, reg+4, lhi);
-			szhi = pci_size(lhi, szhi, 0xffffffff);
+			sz64 = ((u64)szhi << 32) | raw_sz;
+			l64 = ((u64)lhi << 32) | l;
+			sz64 = pci_size64(l64, sz64, PCI_BASE_ADDRESS_MEM_MASK);
 			next++;
 #if BITS_PER_LONG == 64
-			res->start |= ((unsigned long) lhi) << 32;
-			res->end = res->start + sz;
-			if (szhi) {
-				/* This BAR needs > 4GB?  Wow. */
-				res->end |= (unsigned long)szhi<<32;
+			if (!sz64) {
+				res->start = 0;
+				res->end = 0;
+				res->flags = 0;
+				continue;
 			}
+			res->start = l64 & PCI_BASE_ADDRESS_MEM_MASK;
+			res->end = res->start + sz64;
 #else
-			if (szhi) {
-				printk(KERN_ERR "PCI: Unable to handle 64-bit BAR for device %s\n", pci_name(dev));
+			if (sz64 > 0x100000000ULL) {
+				printk(KERN_ERR "PCI: Unable to handle 64-bit "
+					"BAR for device %s\n", pci_name(dev));
 				res->start = 0;
 				res->flags = 0;
 			} else if (lhi) {
 				/* 64-bit wide address, treat as disabled */
-				pci_write_config_dword(dev, reg, l & ~(u32)PCI_BASE_ADDRESS_MEM_MASK);
+				pci_write_config_dword(dev, reg,
+					l & ~(u32)PCI_BASE_ADDRESS_MEM_MASK);
 				pci_write_config_dword(dev, reg+4, 0);
 				res->start = 0;
 				res->end = sz;
_


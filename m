Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753454AbWKGAFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbWKGAFA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 19:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753850AbWKGAE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 19:04:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753454AbWKGAE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 19:04:59 -0500
Date: Mon, 6 Nov 2006 16:04:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Greg KH" <gregkh@suse.de>, "Andi Kleen" <ak@suse.de>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] PCI: check szhi when sz is 0 for 64 bit pref mem
Message-Id: <20061106160441.1a06bf76.akpm@osdl.org>
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA490719C@ssvlexmb2.amd.com>
References: <5986589C150B2F49A46483AC44C7BCA490719C@ssvlexmb2.amd.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006 14:15:23 -0800
"Lu, Yinghai" <yinghai.lu@amd.com> wrote:

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org] 
> >I don't really understand what this patch does.
> >We have a PCI device with a 64-bit BAR and the size is also 64-bit and
> is
> >larger than 4G, yes?
> 
> Yes
> 
> >But the code appears to already be attempting to handle such devices. 
> >Confused.
> 
> The old code will 
> Try to calculate the sz from lo 32 bit addr reg, and sz is 0 if the 64
> bit resource size if 4G above, so it will continue can skip that
> register, and it will go on try to treat the hi 32bit addr reg as
> another 32 bit resource addr reg.
> 

OK...  I still don't know what a "pref" is though.

I reworked the path a bit, as below.  Look OK?


From: "Yinghai Lu" <yinghai.lu@amd.com>

If the PCI device is 64-bit memory and has a size of 0xnnnnnnnn00000000 then
pci_read_bases() will incorrectly assume that it has a size of zero.

Cc: Myles Watson <myles@mouselemur.cs.byu.edu>
Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pci/probe.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff -puN drivers/pci/probe.c~pci-check-szhi-when-sz-is-0-for-64-bit-pref-mem drivers/pci/probe.c
--- a/drivers/pci/probe.c~pci-check-szhi-when-sz-is-0-for-64-bit-pref-mem
+++ a/drivers/pci/probe.c
@@ -144,6 +144,14 @@ static u32 pci_size(u32 base, u32 maxbas
 	return size;
 }
 
+static inline bool is_64_bit_memory(u32 v)
+{
+	if ((v & (PCI_BASE_ADDRESS_SPACE|PCI_BASE_ADDRESS_MEM_TYPE_MASK)) ==
+	    (PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64))
+		return true;
+	return false;
+}
+
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg, next;
@@ -165,7 +173,11 @@ static void pci_read_bases(struct pci_de
 			l = 0;
 		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
 			sz = pci_size(l, sz, (u32)PCI_BASE_ADDRESS_MEM_MASK);
-			if (!sz)
+			/*
+			 * For a 64bit BAR, sz could be 0 if the real size is
+			 * bigger than 4G so we need to check szhi for that.
+			 */
+			if (!is_64_bit_memory(l) && !sz)
 				continue;
 			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
 			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
@@ -178,8 +190,7 @@ static void pci_read_bases(struct pci_de
 		}
 		res->end = res->start + (unsigned long) sz;
 		res->flags |= pci_calc_resource_flags(l);
-		if ((l & (PCI_BASE_ADDRESS_SPACE | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
-		    == (PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+		if (is_64_bit_memory(l)) {
 			u32 szhi, lhi;
 			pci_read_config_dword(dev, reg+4, &lhi);
 			pci_write_config_dword(dev, reg+4, ~0);
@@ -188,6 +199,12 @@ static void pci_read_bases(struct pci_de
 			szhi = pci_size(lhi, szhi, 0xffffffff);
 			next++;
 #if BITS_PER_LONG == 64
+			if (!sz && !szhi) {
+				res->start = 0;
+				res->end = 0;
+				res->flags = 0;
+				continue;
+			}
 			res->start |= ((unsigned long) lhi) << 32;
 			res->end = res->start + sz;
 			if (szhi) {
_


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285241AbRLSLKR>; Wed, 19 Dec 2001 06:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285250AbRLSLKH>; Wed, 19 Dec 2001 06:10:07 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:54022 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285246AbRLSLJw>; Wed, 19 Dec 2001 06:09:52 -0500
Date: Tue, 18 Dec 2001 23:50:31 +0000
From: Russell King <rmk@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI updates - handle resource flags correctly
Message-ID: <20011218235031.O13126@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a problem noticed on ARM while the generic PCI
code allocates bus addresses.

The region flags ended up containing some of the low-order bits of the IO
address that was read initially.  This carries over some of the old PCI
address bits after the PCI resource allocator has reassigned them.

Obviously not good.  The following patch correctly masks the resource flags
depending on the resource type.

This patch is being sent for only review at this time, but is ultimately
targeted at both the 2.4 and 2.5 kernel series.

diff -ur orig/drivers/pci/pci.c linux/drivers/pci/pci.c
--- orig/drivers/pci/pci.c	Fri Nov 23 10:12:15 2001
+++ linux/drivers/pci/pci.c	Tue Dec 18 19:31:15 2001
@@ -914,13 +914,15 @@
 			l = 0;
 		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
 			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
+			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
 			sz = pci_size(sz, PCI_BASE_ADDRESS_MEM_MASK);
 		} else {
 			res->start = l & PCI_BASE_ADDRESS_IO_MASK;
+			res->flags |= l & ~PCI_BASE_ADDRESS_IO_MASK;
 			sz = pci_size(sz, PCI_BASE_ADDRESS_IO_MASK & 0xffff);
 		}
 		res->end = res->start + (unsigned long) sz;
-		res->flags |= (l & 0xf) | pci_calc_resource_flags(l);
+		res->flags |= pci_calc_resource_flags(l);
 		if ((l & (PCI_BASE_ADDRESS_SPACE | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
 		    == (PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
 			pci_read_config_dword(dev, reg+4, &l);


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


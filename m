Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSCONMg>; Fri, 15 Mar 2002 08:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292270AbSCONM0>; Fri, 15 Mar 2002 08:12:26 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:53516 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S292229AbSCONMQ>; Fri, 15 Mar 2002 08:12:16 -0500
Date: Fri, 15 Mar 2002 13:12:08 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>, davej@suse.de,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.5 and 2.4: fix PCI IO BAR flags
Message-ID: <20020315131208.B24984@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem where the resource flags sometimes contain bits from
the address part of the PCI BAR, especially when you have the low address
bit set for an IO BAR.

(bit 3 of a PCI IO BAR is an address bit, and (bar & 0xf) propagates this
to res->flags).

This exists in Ivan Kokshaysky PCI patches, and so far hasn't made it into
the kernel.  It's required for IDE on certain ARM machines to even work.

This patch fixes this.  Please apply.

--- orig/drivers/pci/pci.c	Fri Mar 15 10:13:53 2002
+++ linux/drivers/pci/pci.c	Mon Mar 11 11:44:54 2002
@@ -1011,13 +1011,15 @@
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


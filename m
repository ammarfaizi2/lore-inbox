Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSE1PzJ>; Tue, 28 May 2002 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316833AbSE1PzI>; Tue, 28 May 2002 11:55:08 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:48133 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316832AbSE1PzH>; Tue, 28 May 2002 11:55:07 -0400
Date: Tue, 28 May 2002 19:54:45 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.18: unnamed PCI bus resources
Message-ID: <20020528195445.A5419@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Russell King, resource name pointers
of the secondary PCI buses are left uninitialized in the
non-x86 PCI allocation path.
Assigning these pointers in pci_add_new_bus() fixes the problem.

Ivan.

--- 2.5.18/drivers/pci/probe.c	Sat May 25 05:55:20 2002
+++ linux/drivers/pci/probe.c	Tue May 28 15:52:05 2002
@@ -151,7 +151,6 @@ void __devinit pci_read_bridge_bases(str
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
 		res->start = base;
 		res->end = limit + 0xfff;
-		res->name = child->name;
 	} else {
 		/*
 		 * Ugh. We don't know enough about this bridge. Just assume
@@ -170,7 +169,6 @@ void __devinit pci_read_bridge_bases(str
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
 		res->start = base;
 		res->end = limit + 0xfffff;
-		res->name = child->name;
 	} else {
 		/* See comment above. Same thing */
 		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 1);
@@ -201,7 +199,6 @@ void __devinit pci_read_bridge_bases(str
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		res->start = base;
 		res->end = limit + 0xfffff;
-		res->name = child->name;
 	} else {
 		/* See comments above */
 		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 2);
@@ -248,9 +245,11 @@ struct pci_bus * __devinit pci_add_new_b
 	child->primary = parent->secondary;
 	child->subordinate = 0xff;
 
-	/* Set up default resource pointers.. */
-	for (i = 0; i < 4; i++)
+	/* Set up default resource pointers and names.. */
+	for (i = 0; i < 4; i++) {
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
+		child->resource[i]->name = child->name;
+	}
 
 	return child;
 }

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbTCTKty>; Thu, 20 Mar 2003 05:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbTCTKty>; Thu, 20 Mar 2003 05:49:54 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:6917 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261377AbTCTKtw>; Thu, 20 Mar 2003 05:49:52 -0500
Date: Thu, 20 Mar 2003 13:59:50 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: David Brownell <david-b@pacbell.net>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] PCI MWI cacheline size fix
Message-ID: <20030320135950.A2333@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is rather conservative variant of previous patch:
- no changes required for drivers or architectures with HAVE_ARCH_PCI_MWI;
- do respect BIOS settings: if the cacheline size is multiple
  of that we have expected, assume that this is on purpose;
- assume cacheline size of 32 bytes for all x86s except K7/K8 and P4.
  Actually it's good for 386/486s as quite a few PCI devices do not support
  smaller values.

If you all are fine with it, I can make a 2.4 counterpart.

As for more aggressive changes: I'd prefer to wait until pending
stuff from rmk and myself gets in and the whole thing stabilizes.
Then we can start fine tuning of MWI, FBB, latency timers and so on.

Ivan.

--- 2.5/drivers/pci/pci.c	Tue Feb 18 11:49:44 2003
+++ linux/drivers/pci/pci.c	Thu Mar 20 11:55:38 2003
@@ -584,6 +584,9 @@ pci_set_master(struct pci_dev *dev)
 }
 
 #ifndef HAVE_ARCH_PCI_MWI
+/* This can be overridden by arch code. */
+u8 pci_cache_line_size = L1_CACHE_BYTES >> 2;
+
 /**
  * pci_generic_prep_mwi - helper function for pci_set_mwi
  * @dev: the PCI device for which MWI is enabled
@@ -597,32 +600,29 @@ pci_set_master(struct pci_dev *dev)
 static int
 pci_generic_prep_mwi(struct pci_dev *dev)
 {
-	int rc = 0;
-	u8 cache_size;
+	u8 cacheline_size;
+
+	if (!pci_cache_line_size)
+		return -EINVAL;		/* The system doesn't support MWI. */
+
+	/* Validate current setting: the PCI_CACHE_LINE_SIZE must be
+	   equal to or multiple of the right value. */
+	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &cacheline_size);
+	if (cacheline_size >= pci_cache_line_size &&
+	    (cacheline_size % pci_cache_line_size) == 0)
+		return 0;
+
+	/* Write the correct value. */
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, pci_cache_line_size);
+	/* Read it back. */
+	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &cacheline_size);
+	if (cacheline_size == pci_cache_line_size)
+		return 0;
 
-	/*
-	 * Looks like this is necessary to deal with on all architectures,
-	 * even this %$#%$# N440BX Intel based thing doesn't get it right.
-	 * Ie. having two NICs in the machine, one will have the cache
-	 * line set at boot time, the other will not.
-	 */
-	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &cache_size);
-	cache_size <<= 2;
-	if (cache_size != SMP_CACHE_BYTES) {
-		printk(KERN_WARNING "PCI: %s PCI cache line size set "
-		       "incorrectly (%i bytes) by BIOS/FW, ",
-		       dev->slot_name, cache_size);
-		if (cache_size > SMP_CACHE_BYTES) {
-			printk("expecting %i\n", SMP_CACHE_BYTES);
-			rc = -EINVAL;
-		} else {
-			printk("correcting to %i\n", SMP_CACHE_BYTES);
-			pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
-					      SMP_CACHE_BYTES >> 2);
-		}
-	}
+	printk(KERN_WARNING "PCI: cache line size of %d is not supported "
+	       "by device %s\n", pci_cache_line_size << 2, dev->slot_name);
 
-	return rc;
+	return -EINVAL;
 }
 #endif /* !HAVE_ARCH_PCI_MWI */
 
--- 2.5/arch/i386/pci/common.c	Tue Mar 18 11:05:39 2003
+++ linux/arch/i386/pci/common.c	Thu Mar 20 00:28:55 2003
@@ -120,12 +120,22 @@ struct pci_bus * __devinit pcibios_scan_
 	return pci_scan_bus(busnum, pci_root_ops, NULL);
 }
 
+extern u8 pci_cache_line_size;
+
 static int __init pcibios_init(void)
 {
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
 	if (!pci_root_ops) {
 		printk("PCI: System does not support PCI\n");
 		return 0;
 	}
+
+	pci_cache_line_size = 32 >> 2;
+	if (c->x86 >= 6 && c->x86_vendor == X86_VENDOR_AMD)
+		pci_cache_line_size = 64 >> 2;	/* K7 & K8 */
+	else if (c->x86 > 6)
+		pci_cache_line_size = 128 >> 2;	/* P4 */
 
 	pcibios_resource_survey();
 

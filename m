Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262907AbTCVQrI>; Sat, 22 Mar 2003 11:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263667AbTCVQrI>; Sat, 22 Mar 2003 11:47:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41992 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262907AbTCVQpj>; Sat, 22 Mar 2003 11:45:39 -0500
Date: Sat, 22 Mar 2003 16:56:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PCI patches (3/3)
Message-ID: <20030322165641.G8712@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030322165525.D8712@flint.arm.linux.org.uk> <20030322165556.E8712@flint.arm.linux.org.uk> <20030322165620.F8712@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030322165620.F8712@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Mar 22, 2003 at 04:56:20PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1132  -> 1.1133 
#	   drivers/pci/pci.c	1.52    -> 1.53   
#	arch/i386/pci/common.c	1.36    -> 1.37   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/22	ink@ru.rmk.(none)	1.1133
# [PCI] Fix incorrect PCI cache line size assumptions.
# 
# Fix incorrect PCI cache line size assumptions on i386 and thus
# avoid potential memory corruption with Memory Write-and-Invalidate.
# --------------------------------------------
#
diff -Nru a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c	Sat Mar 22 16:53:43 2003
+++ b/arch/i386/pci/common.c	Sat Mar 22 16:53:43 2003
@@ -120,12 +120,27 @@
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
+	/*
+	 * Assume PCI cacheline size of 32 bytes for all x86s except K7/K8
+	 * and P4. It's also good for 386/486s (which actually have 16)
+	 * as quite a few PCI devices do not support smaller values.
+	 */
+	pci_cache_line_size = 32 >> 2;
+	if (c->x86 >= 6 && c->x86_vendor == X86_VENDOR_AMD)
+		pci_cache_line_size = 64 >> 2;	/* K7 & K8 */
+	else if (c->x86 > 6)
+		pci_cache_line_size = 128 >> 2;	/* P4 */
 
 	pcibios_resource_survey();
 
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Sat Mar 22 16:53:43 2003
+++ b/drivers/pci/pci.c	Sat Mar 22 16:53:43 2003
@@ -584,6 +584,9 @@
 }
 
 #ifndef HAVE_ARCH_PCI_MWI
+/* This can be overridden by arch code. */
+u8 pci_cache_line_size = L1_CACHE_BYTES >> 2;
+
 /**
  * pci_generic_prep_mwi - helper function for pci_set_mwi
  * @dev: the PCI device for which MWI is enabled
@@ -597,32 +600,29 @@
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
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTGRNsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271716AbTGRNsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:48:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8581
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262116AbTGRNr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:47:56 -0400
Date: Fri, 18 Jul 2003 15:02:14 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181402.h6IE2EL3017640@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: mtrr fixes
Cc: davej@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix cyrix mtrr ((Zoltán Böszörményi)
Back port 2.4 handling for the Intel bug
Add printk levels

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/arch/i386/kernel/cpu/mtrr/main.c linux-2.6.0-test1-ac2/arch/i386/kernel/cpu/mtrr/main.c
--- linux-2.6.0-test1/arch/i386/kernel/cpu/mtrr/main.c	2003-07-10 21:04:45.000000000 +0100
+++ linux-2.6.0-test1-ac2/arch/i386/kernel/cpu/mtrr/main.c	2003-07-15 18:08:48.000000000 +0100
@@ -64,7 +64,7 @@
 static void set_mtrr(unsigned int reg, unsigned long base,
 		     unsigned long size, mtrr_type type);
 
-static unsigned int arr3_protected;
+extern int arr3_protected;
 
 void set_mtrr_ops(struct mtrr_ops * ops)
 {
@@ -75,23 +75,25 @@
 /*  Returns non-zero if we have the write-combining memory type  */
 static int have_wrcomb(void)
 {
-	struct pci_dev *dev = NULL;
-
-	/* WTF is this?
-	 * Someone, please shoot me.
-	 */
-
-	/* ServerWorks LE chipsets have problems with write-combining 
-	   Don't allow it and leave room for other chipsets to be tagged */
-
+	struct pci_dev *dev;
+	
 	if ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) != NULL) {
-		if ((dev->vendor == PCI_VENDOR_ID_SERVERWORKS) &&
-		    (dev->device == PCI_DEVICE_ID_SERVERWORKS_LE)) {
-			printk(KERN_INFO
-			       "mtrr: Serverworks LE detected. Write-combining disabled.\n");
+		/* ServerWorks LE chipsets have problems with write-combining 
+		   Don't allow it and leave room for other chipsets to be tagged */
+		if (dev->vendor == PCI_VENDOR_ID_SERVERWORKS &&
+		    dev->device == PCI_DEVICE_ID_SERVERWORKS_LE) {
+			printk(KERN_INFO "mtrr: Serverworks LE detected. Write-combining disabled.\n");
 			return 0;
 		}
-	}
+		/* Intel 450NX errata # 23. Non ascending cachline evictions to
+		   write combining memory may resulting in data corruption */
+		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
+		    dev->device == PCI_DEVICE_ID_INTEL_82451NX)
+		{
+			printk(KERN_INFO "mtrr: Intel 450NX MMC detected. Write-combining disabled.\n");
+			return 0;
+		}
+	}		
 	return (mtrr_if->have_wrcomb ? mtrr_if->have_wrcomb() : 0);
 }
 
@@ -121,7 +123,7 @@
 	max = num_var_ranges;
 	if ((usage_table = kmalloc(max * sizeof *usage_table, GFP_KERNEL))
 	    == NULL) {
-		printk("mtrr: could not allocate\n");
+		printk(KERN_ERR "mtrr: could not allocate\n");
 		return;
 	}
 	for (i = 0; i < max; i++)
@@ -310,7 +312,7 @@
 		return error;
 
 	if (type >= MTRR_NUM_TYPES) {
-		printk("mtrr: type: %u illegal\n", type);
+		printk(KERN_WARNING "mtrr: type: %u invalid\n", type);
 		return -EINVAL;
 	}
 
@@ -322,7 +324,7 @@
 	}
 
 	if (base & size_or_mask || size & size_or_mask) {
-		printk("mtrr: base or size exceeds the MTRR width\n");
+		printk(KERN_WARNING "mtrr: base or size exceeds the MTRR width\n");
 		return -EINVAL;
 	}
 
@@ -348,7 +350,7 @@
 		if (ltype != type) {
 			if (type == MTRR_TYPE_UNCACHABLE)
 				continue;
-			printk ("mtrr: type mismatch for %lx000,%lx000 old: %s new: %s\n",
+			printk (KERN_WARNING "mtrr: type mismatch for %lx000,%lx000 old: %s new: %s\n",
 			     base, size, attrib_to_str(ltype),
 			     attrib_to_str(type));
 			goto out;
@@ -364,7 +366,7 @@
 		set_mtrr(i, base, size, type);
 		usage_table[i] = 1;
 	} else
-		printk("mtrr: no more MTRRs available\n");
+		printk(KERN_INFO "mtrr: no more MTRRs available\n");
 	error = i;
  out:
 	up(&main_lock);
@@ -412,8 +414,8 @@
 	 char increment)
 {
 	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
-		printk("mtrr: size and base must be multiples of 4 kiB\n");
-		printk("mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+		printk(KERN_WARNING "mtrr: size and base must be multiples of 4 kiB\n");
+		printk(KERN_DEBUG "mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
 		return -EINVAL;
 	}
 	return mtrr_add_page(base >> PAGE_SHIFT, size >> PAGE_SHIFT, type,
@@ -458,28 +460,28 @@
 			}
 		}
 		if (reg < 0) {
-			printk("mtrr: no MTRR for %lx000,%lx000 found\n", base,
+			printk(KERN_DEBUG "mtrr: no MTRR for %lx000,%lx000 found\n", base,
 			       size);
 			goto out;
 		}
 	}
 	if (reg >= max) {
-		printk("mtrr: register: %d too big\n", reg);
+		printk(KERN_WARNING "mtrr: register: %d too big\n", reg);
 		goto out;
 	}
 	if (is_cpu(CYRIX) && !use_intel()) {
 		if ((reg == 3) && arr3_protected) {
-			printk("mtrr: ARR3 cannot be changed\n");
+			printk(KERN_WARNING "mtrr: ARR3 cannot be changed\n");
 			goto out;
 		}
 	}
 	mtrr_if->get(reg, &lbase, &lsize, &ltype);
 	if (lsize < 1) {
-		printk("mtrr: MTRR %d not used\n", reg);
+		printk(KERN_WARNING "mtrr: MTRR %d not used\n", reg);
 		goto out;
 	}
 	if (usage_table[reg] < 1) {
-		printk("mtrr: reg: %d has count=0\n", reg);
+		printk(KERN_WARNING "mtrr: reg: %d has count=0\n", reg);
 		goto out;
 	}
 	if (--usage_table[reg] < 1)
@@ -508,8 +510,8 @@
 mtrr_del(int reg, unsigned long base, unsigned long size)
 {
 	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
-		printk("mtrr: size and base must be multiples of 4 kiB\n");
-		printk("mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
+		printk(KERN_INFO "mtrr: size and base must be multiples of 4 kiB\n");
+		printk(KERN_DEBUG "mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
 		return -EINVAL;
 	}
 	return mtrr_del_page(reg, base >> PAGE_SHIFT, size >> PAGE_SHIFT);
@@ -677,7 +679,7 @@
 			break;
 		}
 	}
-	printk("mtrr: v%s\n",MTRR_VERSION);
+	printk(KERN_INFO "mtrr: v%s\n",MTRR_VERSION);
 
 	if (mtrr_if) {
 		set_num_var_ranges();

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUA0Q4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 11:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbUA0Q4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 11:56:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:33951 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262731AbUA0Q4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 11:56:00 -0500
Subject: [PATCH][2.6] PCI Scan all functions
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-frXhy3kR0wnjGnE8eBht"
Message-Id: <1075222501.1030.45.camel@magik>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 10:55:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-frXhy3kR0wnjGnE8eBht
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

There are some arch, like PPC64, that need to be able to scan all the
PCI functions.  The problem comes in on a logically partitioned system
where function 0 on a PCI-PCI bridge is assigned to one partition and
say function 2 is assiged to another partition.  On the second
partition, it would appear that function 0 does not exist, but function
2 does.  If all the functions are not scanned, everything under function
2 would not be detected.

Thanks,
Jake


--=-frXhy3kR0wnjGnE8eBht
Content-Disposition: attachment; filename=linux-2.6.1-pcibios-scan-all-fns-1.patch
Content-Type: text/x-patch; name=linux-2.6.1-pcibios-scan-all-fns-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urpN linux-2.6.1/drivers/pci/probe.c linux-2.6.1-pcibios-scan-all-fns/drivers/pci/probe.c
--- linux-2.6.1/drivers/pci/probe.c	Fri Jan  9 00:59:47 2004
+++ linux-2.6.1-pcibios-scan-all-fns/drivers/pci/probe.c	Tue Jan 27 10:36:52 2004
@@ -7,6 +7,8 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#include <asm/pci.h>
+
 #undef DEBUG
 
 #ifdef DEBUG
@@ -553,7 +555,7 @@ int __devinit pci_scan_slot(struct pci_b
 
 		dev = pci_scan_device(bus, devfn);
 		pci_scan_msi_device(dev);
-		if (func == 0) {
+		if (!pcibios_scan_all_fns() && func == 0) {
 			if (!dev)
 				break;
 		} else {
diff -urpN linux-2.6.1/include/asm-alpha/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-alpha/pci.h
--- linux-2.6.1/include/asm-alpha/pci.h	Fri Jan  9 00:59:02 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-alpha/pci.h	Tue Jan 27 10:36:07 2004
@@ -51,6 +51,7 @@ struct pci_controller {
    bus numbers.  */
 
 #define pcibios_assign_all_busses()	1
+#define pcibios_scan_all_fns()		0
 
 #define PCIBIOS_MIN_IO		alpha_mv.min_io_address
 #define PCIBIOS_MIN_MEM		alpha_mv.min_mem_address
diff -urpN linux-2.6.1/include/asm-arm/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-arm/pci.h
--- linux-2.6.1/include/asm-arm/pci.h	Fri Jan  9 00:59:19 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-arm/pci.h	Tue Jan 27 10:36:07 2004
@@ -20,6 +20,8 @@
 #endif
 
 
+#define pcibios_scan_all_fns()		0
+
 static inline void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
diff -urpN linux-2.6.1/include/asm-arm26/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-arm26/pci.h
--- linux-2.6.1/include/asm-arm26/pci.h	Fri Jan  9 00:59:46 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-arm26/pci.h	Tue Jan 27 10:36:07 2004
@@ -1,5 +1,6 @@
 /* Should not be needed. IDE stupidity */
 /* JMA 18.05.03 - is kinda needed, if only to tell it we don't have a PCI bus */
 
-#define PCI_DMA_BUS_IS_PHYS  0
+#define PCI_DMA_BUS_IS_PHYS  		0
+#define pcibios_scan_all_fns()		0
 
diff -urpN linux-2.6.1/include/asm-generic/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-generic/pci.h
--- linux-2.6.1/include/asm-generic/pci.h	Fri Jan  9 00:59:33 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-generic/pci.h	Tue Jan 27 10:36:07 2004
@@ -22,4 +22,6 @@ pcibios_resource_to_bus(struct pci_dev *
 	region->end = res->end;
 }
 
+#define pcibios_scan_all_fns()		0
+
 #endif
diff -urpN linux-2.6.1/include/asm-h8300/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-h8300/pci.h
--- linux-2.6.1/include/asm-h8300/pci.h	Fri Jan  9 00:59:42 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-h8300/pci.h	Tue Jan 27 10:36:07 2004
@@ -8,6 +8,7 @@
  */
 
 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns()		0
 
 extern inline void pcibios_set_master(struct pci_dev *dev)
 {
diff -urpN linux-2.6.1/include/asm-i386/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-i386/pci.h
--- linux-2.6.1/include/asm-i386/pci.h	Fri Jan  9 00:59:26 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-i386/pci.h	Tue Jan 27 10:36:07 2004
@@ -15,6 +15,7 @@ extern unsigned int pcibios_assign_all_b
 #else
 #define pcibios_assign_all_busses()	0
 #endif
+#define pcibios_scan_all_fns()		0
 
 extern unsigned long pci_mem_start;
 #define PCIBIOS_MIN_IO		0x1000
diff -urpN linux-2.6.1/include/asm-ia64/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-ia64/pci.h
--- linux-2.6.1/include/asm-ia64/pci.h	Fri Jan  9 01:00:02 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-ia64/pci.h	Tue Jan 27 10:36:07 2004
@@ -16,6 +16,7 @@
  * loader.
  */
 #define pcibios_assign_all_busses()     0
+#define pcibios_scan_all_fns()		0
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -urpN linux-2.6.1/include/asm-m68k/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-m68k/pci.h
--- linux-2.6.1/include/asm-m68k/pci.h	Fri Jan  9 00:59:33 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-m68k/pci.h	Tue Jan 27 10:36:07 2004
@@ -36,6 +36,7 @@ struct pci_bus_info
 };
 
 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns()		0
 
 extern inline void pcibios_set_master(struct pci_dev *dev)
 {
diff -urpN linux-2.6.1/include/asm-m68knommu/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-m68knommu/pci.h
--- linux-2.6.1/include/asm-m68knommu/pci.h	Fri Jan  9 00:59:56 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-m68knommu/pci.h	Tue Jan 27 10:36:07 2004
@@ -11,6 +11,8 @@
 #define PCIBIOS_MIN_IO		0x100
 #define PCIBIOS_MIN_MEM		0x00010000
 
+#define pcibios_scan_all_fns()		0
+
 /*
  * Return whether the given PCI device DMA address mask can
  * be supported properly.  For example, if your device can
diff -urpN linux-2.6.1/include/asm-mips/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-mips/pci.h
--- linux-2.6.1/include/asm-mips/pci.h	Fri Jan  9 00:59:46 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-mips/pci.h	Tue Jan 27 10:36:07 2004
@@ -20,6 +20,7 @@ extern unsigned int pcibios_assign_all_b
 #else
 #define pcibios_assign_all_busses()	0
 #endif
+#define pcibios_scan_all_fns()		0
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -urpN linux-2.6.1/include/asm-parisc/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-parisc/pci.h
--- linux-2.6.1/include/asm-parisc/pci.h	Fri Jan  9 00:59:48 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-parisc/pci.h	Tue Jan 27 10:36:07 2004
@@ -174,6 +174,7 @@ extern inline void pcibios_register_hba(
 **   to zero for legacy platforms and one for PAT platforms.
 */
 #define pcibios_assign_all_busses()     (pdc_type == PDC_TYPE_PAT)
+#define pcibios_scan_all_fns()		0
 
 #define PCIBIOS_MIN_IO          0x10
 #define PCIBIOS_MIN_MEM         0x1000 /* NBPG - but pci/setup-res.c dies */
diff -urpN linux-2.6.1/include/asm-ppc/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-ppc/pci.h
--- linux-2.6.1/include/asm-ppc/pci.h	Fri Jan  9 00:59:48 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-ppc/pci.h	Tue Jan 27 10:36:07 2004
@@ -26,6 +26,7 @@ struct pci_dev;
 extern int pci_assign_all_busses;
 
 #define pcibios_assign_all_busses()	(pci_assign_all_busses)
+#define pcibios_scan_all_fns()		0
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -urpN linux-2.6.1/include/asm-ppc64/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-ppc64/pci.h
--- linux-2.6.1/include/asm-ppc64/pci.h	Fri Jan  9 00:59:26 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-ppc64/pci.h	Tue Jan 27 10:36:07 2004
@@ -19,6 +19,12 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+/*
+ * ppc64 can have multifunction devices that do not respond to function 0. 
+ * In this case we must scan all functions.
+ */
+#define pcibios_scan_all_fns()     1
+
 static inline void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
diff -urpN linux-2.6.1/include/asm-sh/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-sh/pci.h
--- linux-2.6.1/include/asm-sh/pci.h	Fri Jan  9 00:59:45 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-sh/pci.h	Tue Jan 27 10:36:07 2004
@@ -12,6 +12,7 @@
    or architectures with incomplete PCI setup by the loader */
 
 #define pcibios_assign_all_busses()	1
+#define pcibios_scan_all_fns()		0
 
 #if defined(CONFIG_CPU_SUBTYPE_ST40STB1)
 /* These are currently the correct values for the STM overdrive board. 
diff -urpN linux-2.6.1/include/asm-sparc/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-sparc/pci.h
--- linux-2.6.1/include/asm-sparc/pci.h	Fri Jan  9 00:59:48 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-sparc/pci.h	Tue Jan 27 10:36:07 2004
@@ -8,6 +8,7 @@
  * or architectures with incomplete PCI setup by the loader.
  */
 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns()		0
 
 #define PCIBIOS_MIN_IO		0UL
 #define PCIBIOS_MIN_MEM		0UL
diff -urpN linux-2.6.1/include/asm-sparc64/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-sparc64/pci.h
--- linux-2.6.1/include/asm-sparc64/pci.h	Fri Jan  9 00:59:10 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-sparc64/pci.h	Tue Jan 27 10:36:07 2004
@@ -11,6 +11,7 @@
  * or architectures with incomplete PCI setup by the loader.
  */
 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns()		0
 
 #define PCIBIOS_MIN_IO		0UL
 #define PCIBIOS_MIN_MEM		0UL
diff -urpN linux-2.6.1/include/asm-um/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-um/pci.h
--- linux-2.6.1/include/asm-um/pci.h	Fri Jan  9 00:59:27 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-um/pci.h	Tue Jan 27 10:36:07 2004
@@ -2,5 +2,6 @@
 #define __UM_PCI_H
 
 #define PCI_DMA_BUS_IS_PHYS     (1)
+#define pcibios_scan_all_fns()		0
 
 #endif
diff -urpN linux-2.6.1/include/asm-v850/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-v850/pci.h
--- linux-2.6.1/include/asm-v850/pci.h	Fri Jan  9 00:59:19 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-v850/pci.h	Tue Jan 27 10:36:07 2004
@@ -17,6 +17,8 @@
 /* Get any platform-dependent definitions.  */
 #include <asm/machdep.h>
 
+#define pcibios_scan_all_fns()		0
+
 /* Generic declarations.  */
 
 struct scatterlist;
diff -urpN linux-2.6.1/include/asm-x86_64/pci.h linux-2.6.1-pcibios-scan-all-fns/include/asm-x86_64/pci.h
--- linux-2.6.1/include/asm-x86_64/pci.h	Fri Jan  9 00:59:26 2004
+++ linux-2.6.1-pcibios-scan-all-fns/include/asm-x86_64/pci.h	Tue Jan 27 10:36:07 2004
@@ -17,6 +17,7 @@ extern unsigned int pcibios_assign_all_b
 #else
 #define pcibios_assign_all_busses()	0
 #endif
+#define pcibios_scan_all_fns()		0
 
 extern int no_iommu, force_iommu;
 

--=-frXhy3kR0wnjGnE8eBht--


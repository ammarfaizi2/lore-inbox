Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUA2XLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUA2XLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:11:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:8942 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266499AbUA2XL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:11:29 -0500
Subject: Re: Fw: [PATCH][2.6] PCI Scan all functions
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       External List <linuxppc64-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.58.0401271559230.10794@home.osdl.org>
References: <20040127130803.10b666f3.akpm@osdl.org>
	 <Pine.LNX.4.58.0401271345060.10794@home.osdl.org>
	 <1075241556.681.19.camel@magik>
	 <Pine.LNX.4.58.0401271428340.10794@home.osdl.org>
	 <1075247559.672.33.camel@magik>
	 <Pine.LNX.4.58.0401271559230.10794@home.osdl.org>
Content-Type: multipart/mixed; boundary="=-Cz3rvvqqbQ6hp260Stfv"
Message-Id: <1075417841.679.139.camel@magik>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 17:10:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Cz3rvvqqbQ6hp260Stfv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-01-27 at 18:09, Linus Torvalds wrote:
> On Tue, 27 Jan 2004, Jake Moilanen wrote:
> > 
> > I tried this patch on my one (and only) machine that exibits this
> > issue.  Everything was detected correctly.  
> 
> Ok. This at least looks more palatable in that it's now confined a bit 
> better. 
> 
> However, looking at the logic, we really only want to do the 
> "pcibios_scan_all_fns()" once per device, not once for each function, no?
> 
> 		Linus

Here's a patch that addresses Linus's concerns.  Andrew, if you have no
objections, please apply.

Thanks,
Jake



--=-Cz3rvvqqbQ6hp260Stfv
Content-Disposition: attachment; filename=linux-2.6.1-pcibios-scan-all-fns-3.patch
Content-Type: text/x-patch; name=linux-2.6.1-pcibios-scan-all-fns-3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urpN linux-2.6.1/arch/ppc64/kernel/pSeries_pci.c linux-2.6.1-pci-scan-all-fns/arch/ppc64/kernel/pSeries_pci.c
--- linux-2.6.1/arch/ppc64/kernel/pSeries_pci.c	Fri Jan  9 01:00:13 2004
+++ linux-2.6.1-pci-scan-all-fns/arch/ppc64/kernel/pSeries_pci.c	Tue Jan 27 17:36:27 2004
@@ -568,3 +568,29 @@ pci_find_hose_for_OF_device(struct devic
 	}
 	return NULL;
 }
+
+/*
+ * ppc64 can have multifunction devices that do not respond to function 0. 
+ * In this case we must scan all functions.
+ */
+int
+pcibios_scan_all_fns(struct pci_bus *bus, int devfn)
+{
+       struct device_node *busdn, *dn;
+
+       if (bus->self)
+               busdn = pci_device_to_OF_node(bus->self);
+       else
+               busdn = bus->sysdata;   /* must be a phb */
+
+       /*
+        * Check to see if there is any of the 8 functions are in the
+        * device tree.  If they are then we need to scan all the
+        * functions of this slot.
+        */
+       for (dn = busdn->child; dn; dn = dn->sibling)
+               if ((dn->devfn >> 3) == (devfn >> 3))
+                       return 1;
+
+       return 0;
+}
diff -urpN linux-2.6.1/drivers/pci/probe.c linux-2.6.1-pci-scan-all-fns/drivers/pci/probe.c
--- linux-2.6.1/drivers/pci/probe.c	Fri Jan  9 00:59:47 2004
+++ linux-2.6.1-pci-scan-all-fns/drivers/pci/probe.c	Wed Jan 28 08:50:09 2004
@@ -7,6 +7,8 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#include <asm/pci.h>
+
 #undef DEBUG
 
 #ifdef DEBUG
@@ -547,13 +549,16 @@ pci_scan_device(struct pci_bus *bus, int
 int __devinit pci_scan_slot(struct pci_bus *bus, int devfn)
 {
 	int func, nr = 0;
+	int scan_all_fns;
+
+	scan_all_fns = pcibios_scan_all_fns(bus, devfn);
 
 	for (func = 0; func < 8; func++, devfn++) {
 		struct pci_dev *dev;
 
 		dev = pci_scan_device(bus, devfn);
 		pci_scan_msi_device(dev);
-		if (func == 0) {
+		if (!scan_all_fns && func == 0) {
 			if (!dev)
 				break;
 		} else {
diff -urpN linux-2.6.1/include/asm-alpha/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-alpha/pci.h
--- linux-2.6.1/include/asm-alpha/pci.h	Fri Jan  9 00:59:02 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-alpha/pci.h	Tue Jan 27 17:36:27 2004
@@ -51,6 +51,7 @@ struct pci_controller {
    bus numbers.  */
 
 #define pcibios_assign_all_busses()	1
+#define pcibios_scan_all_fns(a, b)	0
 
 #define PCIBIOS_MIN_IO		alpha_mv.min_io_address
 #define PCIBIOS_MIN_MEM		alpha_mv.min_mem_address
diff -urpN linux-2.6.1/include/asm-arm/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-arm/pci.h
--- linux-2.6.1/include/asm-arm/pci.h	Fri Jan  9 00:59:19 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-arm/pci.h	Tue Jan 27 17:36:27 2004
@@ -20,6 +20,8 @@
 #endif
 
 
+#define pcibios_scan_all_fns(a, b)	0
+
 static inline void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
diff -urpN linux-2.6.1/include/asm-arm26/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-arm26/pci.h
--- linux-2.6.1/include/asm-arm26/pci.h	Fri Jan  9 00:59:46 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-arm26/pci.h	Tue Jan 27 17:36:27 2004
@@ -1,5 +1,6 @@
 /* Should not be needed. IDE stupidity */
 /* JMA 18.05.03 - is kinda needed, if only to tell it we don't have a PCI bus */
 
-#define PCI_DMA_BUS_IS_PHYS  0
+#define PCI_DMA_BUS_IS_PHYS  		0
+#define pcibios_scan_all_fns(a, b)	0
 
diff -urpN linux-2.6.1/include/asm-generic/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-generic/pci.h
--- linux-2.6.1/include/asm-generic/pci.h	Fri Jan  9 00:59:33 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-generic/pci.h	Tue Jan 27 17:36:27 2004
@@ -22,4 +22,6 @@ pcibios_resource_to_bus(struct pci_dev *
 	region->end = res->end;
 }
 
+#define pcibios_scan_all_fns(a, b)	0
+
 #endif
diff -urpN linux-2.6.1/include/asm-h8300/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-h8300/pci.h
--- linux-2.6.1/include/asm-h8300/pci.h	Fri Jan  9 00:59:42 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-h8300/pci.h	Tue Jan 27 17:36:27 2004
@@ -8,6 +8,7 @@
  */
 
 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns(a, b)	0
 
 extern inline void pcibios_set_master(struct pci_dev *dev)
 {
diff -urpN linux-2.6.1/include/asm-i386/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-i386/pci.h
--- linux-2.6.1/include/asm-i386/pci.h	Fri Jan  9 00:59:26 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-i386/pci.h	Tue Jan 27 17:36:27 2004
@@ -15,6 +15,7 @@ extern unsigned int pcibios_assign_all_b
 #else
 #define pcibios_assign_all_busses()	0
 #endif
+#define pcibios_scan_all_fns(a, b)	0
 
 extern unsigned long pci_mem_start;
 #define PCIBIOS_MIN_IO		0x1000
diff -urpN linux-2.6.1/include/asm-ia64/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-ia64/pci.h
--- linux-2.6.1/include/asm-ia64/pci.h	Fri Jan  9 01:00:02 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-ia64/pci.h	Tue Jan 27 17:36:27 2004
@@ -16,6 +16,7 @@
  * loader.
  */
 #define pcibios_assign_all_busses()     0
+#define pcibios_scan_all_fns(a, b)	0
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -urpN linux-2.6.1/include/asm-m68k/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-m68k/pci.h
--- linux-2.6.1/include/asm-m68k/pci.h	Fri Jan  9 00:59:33 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-m68k/pci.h	Tue Jan 27 17:36:27 2004
@@ -36,6 +36,7 @@ struct pci_bus_info
 };
 
 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns(a, b)	0
 
 extern inline void pcibios_set_master(struct pci_dev *dev)
 {
diff -urpN linux-2.6.1/include/asm-m68knommu/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-m68knommu/pci.h
--- linux-2.6.1/include/asm-m68knommu/pci.h	Fri Jan  9 00:59:56 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-m68knommu/pci.h	Tue Jan 27 17:36:27 2004
@@ -11,6 +11,8 @@
 #define PCIBIOS_MIN_IO		0x100
 #define PCIBIOS_MIN_MEM		0x00010000
 
+#define pcibios_scan_all_fns(a, b)	0
+
 /*
  * Return whether the given PCI device DMA address mask can
  * be supported properly.  For example, if your device can
diff -urpN linux-2.6.1/include/asm-mips/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-mips/pci.h
--- linux-2.6.1/include/asm-mips/pci.h	Fri Jan  9 00:59:46 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-mips/pci.h	Tue Jan 27 17:36:27 2004
@@ -20,6 +20,7 @@ extern unsigned int pcibios_assign_all_b
 #else
 #define pcibios_assign_all_busses()	0
 #endif
+#define pcibios_scan_all_fns(a, b)	0
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -urpN linux-2.6.1/include/asm-parisc/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-parisc/pci.h
--- linux-2.6.1/include/asm-parisc/pci.h	Fri Jan  9 00:59:48 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-parisc/pci.h	Tue Jan 27 17:36:27 2004
@@ -174,6 +174,7 @@ extern inline void pcibios_register_hba(
 **   to zero for legacy platforms and one for PAT platforms.
 */
 #define pcibios_assign_all_busses()     (pdc_type == PDC_TYPE_PAT)
+#define pcibios_scan_all_fns(a, b)	0
 
 #define PCIBIOS_MIN_IO          0x10
 #define PCIBIOS_MIN_MEM         0x1000 /* NBPG - but pci/setup-res.c dies */
diff -urpN linux-2.6.1/include/asm-ppc/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-ppc/pci.h
--- linux-2.6.1/include/asm-ppc/pci.h	Fri Jan  9 00:59:48 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-ppc/pci.h	Tue Jan 27 17:36:27 2004
@@ -26,6 +26,7 @@ struct pci_dev;
 extern int pci_assign_all_busses;
 
 #define pcibios_assign_all_busses()	(pci_assign_all_busses)
+#define pcibios_scan_all_fns(a, b)	0
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -urpN linux-2.6.1/include/asm-ppc64/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-ppc64/pci.h
--- linux-2.6.1/include/asm-ppc64/pci.h	Fri Jan  9 00:59:26 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-ppc64/pci.h	Tue Jan 27 17:37:13 2004
@@ -19,6 +19,8 @@
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
+extern int pcibios_scan_all_fns(struct pci_bus *bus, int devfn);
+
 static inline void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
diff -urpN linux-2.6.1/include/asm-sh/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-sh/pci.h
--- linux-2.6.1/include/asm-sh/pci.h	Fri Jan  9 00:59:45 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-sh/pci.h	Tue Jan 27 17:36:27 2004
@@ -12,6 +12,7 @@
    or architectures with incomplete PCI setup by the loader */
 
 #define pcibios_assign_all_busses()	1
+#define pcibios_scan_all_fns(a, b)	0
 
 #if defined(CONFIG_CPU_SUBTYPE_ST40STB1)
 /* These are currently the correct values for the STM overdrive board. 
diff -urpN linux-2.6.1/include/asm-sparc/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-sparc/pci.h
--- linux-2.6.1/include/asm-sparc/pci.h	Fri Jan  9 00:59:48 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-sparc/pci.h	Tue Jan 27 17:36:27 2004
@@ -8,6 +8,7 @@
  * or architectures with incomplete PCI setup by the loader.
  */
 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns(a, b)	0
 
 #define PCIBIOS_MIN_IO		0UL
 #define PCIBIOS_MIN_MEM		0UL
diff -urpN linux-2.6.1/include/asm-sparc64/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-sparc64/pci.h
--- linux-2.6.1/include/asm-sparc64/pci.h	Fri Jan  9 00:59:10 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-sparc64/pci.h	Tue Jan 27 17:36:27 2004
@@ -11,6 +11,7 @@
  * or architectures with incomplete PCI setup by the loader.
  */
 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns(a, b)	0
 
 #define PCIBIOS_MIN_IO		0UL
 #define PCIBIOS_MIN_MEM		0UL
diff -urpN linux-2.6.1/include/asm-um/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-um/pci.h
--- linux-2.6.1/include/asm-um/pci.h	Fri Jan  9 00:59:27 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-um/pci.h	Tue Jan 27 17:36:27 2004
@@ -2,5 +2,6 @@
 #define __UM_PCI_H
 
 #define PCI_DMA_BUS_IS_PHYS     (1)
+#define pcibios_scan_all_fns(a, b)	0
 
 #endif
diff -urpN linux-2.6.1/include/asm-v850/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-v850/pci.h
--- linux-2.6.1/include/asm-v850/pci.h	Fri Jan  9 00:59:19 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-v850/pci.h	Tue Jan 27 17:36:27 2004
@@ -17,6 +17,8 @@
 /* Get any platform-dependent definitions.  */
 #include <asm/machdep.h>
 
+#define pcibios_scan_all_fns(a, b)	0
+
 /* Generic declarations.  */
 
 struct scatterlist;
diff -urpN linux-2.6.1/include/asm-x86_64/pci.h linux-2.6.1-pci-scan-all-fns/include/asm-x86_64/pci.h
--- linux-2.6.1/include/asm-x86_64/pci.h	Fri Jan  9 00:59:26 2004
+++ linux-2.6.1-pci-scan-all-fns/include/asm-x86_64/pci.h	Tue Jan 27 17:36:27 2004
@@ -17,6 +17,7 @@ extern unsigned int pcibios_assign_all_b
 #else
 #define pcibios_assign_all_busses()	0
 #endif
+#define pcibios_scan_all_fns(a, b)	0
 
 extern int no_iommu, force_iommu;
 

--=-Cz3rvvqqbQ6hp260Stfv--


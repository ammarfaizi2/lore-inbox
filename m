Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbTIDP4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTIDP4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:56:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:63958 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265085AbTIDPzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:55:45 -0400
Date: Thu, 4 Sep 2003 10:55:36 -0500 (CDT)
From: Jake Moilanen <moilanen@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
cc: Anton Blanchard <anton@samba.org>
Subject: [PATCH] linux-2.4.22 pci-scan-all-functions
Message-ID: <Pine.A41.4.51.0309041015390.27258@wolverines.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a port of some work that Anton Blanchard did for 2.6.

While doing a pci scan there are some architechtures that can have
multifunction devices that do not respond to function 0.  In that case we
must scan all functions.

Thanks,
Jake


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Thu Sep  4 10:07:00 2003
+++ b/drivers/pci/pci.c	Thu Sep  4 10:07:00 2003
@@ -1472,17 +1472,22 @@
 	u8 hdr_type;

 	for (func = 0; func < 8; func++, temp->devfn++) {
-		if (func && !is_multi)		/* not a multi-function device */
-			continue;
 		if (pci_read_config_byte(temp, PCI_HEADER_TYPE, &hdr_type))
 			continue;
 		temp->hdr_type = hdr_type & 0x7f;

 		dev = pci_scan_device(temp);
-		if (!dev)
-			continue;
+		if (!pcibios_scan_all_fns() && func == 0) {
+			if (!dev)
+				break;
+		} else {
+			if (!dev)
+				continue;
+			is_multi = 1;
+		}
+
 		pci_name_device(dev);
-		if (!func) {
+		if (!first_dev) {
 			is_multi = hdr_type & 0x80;
 			first_dev = dev;
 		}
@@ -1496,6 +1501,14 @@

 		/* Fix up broken headers */
 		pci_fixup_device(PCI_FIXUP_HEADER, dev);
+
+		/*
+		 * If this is a single function device
+		 * don't scan past the first function.
+		 */
+		if (!is_multi)
+			break;
+
 	}
 	return first_dev;
 }
diff -Nru a/include/asm-alpha/pci.h b/include/asm-alpha/pci.h
--- a/include/asm-alpha/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-alpha/pci.h	Thu Sep  4 10:07:00 2003
@@ -50,6 +50,7 @@
    bus numbers.  */

 #define pcibios_assign_all_busses()	1
+#define pcibios_scan_all_fns()		0

 #define PCIBIOS_MIN_IO		alpha_mv.min_io_address
 #define PCIBIOS_MIN_MEM		alpha_mv.min_mem_address
diff -Nru a/include/asm-arm/pci.h b/include/asm-arm/pci.h
--- a/include/asm-arm/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-arm/pci.h	Thu Sep  4 10:07:00 2003
@@ -53,6 +53,8 @@
 	/* We don't do dynamic PCI IRQ allocation */
 }

+#define pcibios_scan_all_fns()		0
+
 struct pci_dev;

 /* Allocate and map kernel buffer using consistent mode DMA for a device.
diff -Nru a/include/asm-i386/pci.h b/include/asm-i386/pci.h
--- a/include/asm-i386/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-i386/pci.h	Thu Sep  4 10:07:00 2003
@@ -14,6 +14,7 @@
 #else
 #define pcibios_assign_all_busses()	0
 #endif
+#define pcibios_scan_all_fns()		0

 extern unsigned long pci_mem_start;
 #define PCIBIOS_MIN_IO		0x1000
diff -Nru a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-ia64/pci.h	Thu Sep  4 10:07:00 2003
@@ -15,6 +15,7 @@
  * loader.
  */
 #define pcibios_assign_all_busses()     0
+#define pcibios_scan_all_fns()		0

 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -Nru a/include/asm-m68k/pci.h b/include/asm-m68k/pci.h
--- a/include/asm-m68k/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-m68k/pci.h	Thu Sep  4 10:07:00 2003
@@ -34,6 +34,7 @@
 };

 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns()		0

 extern inline void pcibios_set_master(struct pci_dev *dev)
 {
diff -Nru a/include/asm-mips/pci.h b/include/asm-mips/pci.h
--- a/include/asm-mips/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-mips/pci.h	Thu Sep  4 10:07:00 2003
@@ -19,6 +19,7 @@
 #else
 #define pcibios_assign_all_busses()	0
 #endif
+#define pcibios_scan_all_fns()		0

 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -Nru a/include/asm-mips64/pci.h b/include/asm-mips64/pci.h
--- a/include/asm-mips64/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-mips64/pci.h	Thu Sep  4 10:07:00 2003
@@ -19,6 +19,7 @@
 #else
 #define pcibios_assign_all_busses()	0
 #endif
+#define pcibios_scan_all_fns()		0

 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -Nru a/include/asm-parisc/pci.h b/include/asm-parisc/pci.h
--- a/include/asm-parisc/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-parisc/pci.h	Thu Sep  4 10:07:00 2003
@@ -259,6 +259,7 @@
 **   to zero for legacy platforms and one for PAT platforms.
 */
 #define pcibios_assign_all_busses()     (pdc_type == PDC_TYPE_PAT)
+#define pcibios_scan_all_fns()		0

 #define PCIBIOS_MIN_IO          0x10
 #define PCIBIOS_MIN_MEM         0x1000 /* NBPG - but pci/setup-res.c dies */
diff -Nru a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
--- a/include/asm-ppc/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-ppc/pci.h	Thu Sep  4 10:07:00 2003
@@ -16,6 +16,7 @@
 extern int pci_assign_all_busses;

 #define pcibios_assign_all_busses()	(pci_assign_all_busses)
+#define pcibios_scan_all_fns()		0

 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -Nru a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-ppc64/pci.h	Thu Sep  4 10:07:00 2003
@@ -25,6 +25,12 @@
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
diff -Nru a/include/asm-sh/pci.h b/include/asm-sh/pci.h
--- a/include/asm-sh/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-sh/pci.h	Thu Sep  4 10:07:00 2003
@@ -10,6 +10,7 @@
    or architectures with incomplete PCI setup by the loader */

 #define pcibios_assign_all_busses()	1
+#define pcibios_scan_all_fns()		0

 #if defined(CONFIG_CPU_SUBTYPE_ST40)
 /* These are currently the correct values for the ST40 based chips.
diff -Nru a/include/asm-sparc/pci.h b/include/asm-sparc/pci.h
--- a/include/asm-sparc/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-sparc/pci.h	Thu Sep  4 10:07:00 2003
@@ -8,6 +8,7 @@
  * or architectures with incomplete PCI setup by the loader.
  */
 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns()		0

 #define PCIBIOS_MIN_IO		0UL
 #define PCIBIOS_MIN_MEM		0UL
diff -Nru a/include/asm-sparc64/pci.h b/include/asm-sparc64/pci.h
--- a/include/asm-sparc64/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-sparc64/pci.h	Thu Sep  4 10:07:00 2003
@@ -11,6 +11,7 @@
  * or architectures with incomplete PCI setup by the loader.
  */
 #define pcibios_assign_all_busses()	0
+#define pcibios_scan_all_fns()		0

 #define PCIBIOS_MIN_IO		0UL
 #define PCIBIOS_MIN_MEM		0UL
diff -Nru a/include/asm-x86_64/pci.h b/include/asm-x86_64/pci.h
--- a/include/asm-x86_64/pci.h	Thu Sep  4 10:07:00 2003
+++ b/include/asm-x86_64/pci.h	Thu Sep  4 10:07:00 2003
@@ -17,6 +17,7 @@
 #else
 #define pcibios_assign_all_busses()	0
 #endif
+#define pcibios_scan_all_fns()		0

 extern unsigned long pci_mem_start;
 #define PCIBIOS_MIN_IO		0x1000

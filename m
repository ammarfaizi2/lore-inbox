Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVANUkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVANUkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVANUkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:40:35 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:41917 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262157AbVANUZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:25:24 -0500
Subject: [PATCH] prevent pci_name_bus() buffer overflows
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: akpm@osdl.org
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 14 Jan 2005 13:25:04 -0700
Message-Id: <1105734304.7034.25.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix pci_name_bus() so it can't overflow caller's buffer.
Noticed by David Mosberger.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== arch/ppc64/kernel/pci.c 1.62 vs edited =====
--- 1.62/arch/ppc64/kernel/pci.c	2005-01-11 17:42:39 -07:00
+++ edited/arch/ppc64/kernel/pci.c	2005-01-14 13:03:48 -07:00
@@ -301,16 +301,16 @@
 EXPORT_SYMBOL(pci_domain_nr);
 
 /* Set the name of the bus as it appears in /proc/bus/pci */
-int pci_name_bus(char *name, struct pci_bus *bus)
+int pci_name_bus(char *name, size_t size, struct pci_bus *bus)
 {
 #ifndef CONFIG_PPC_ISERIES
 	struct pci_controller *hose = pci_bus_to_host(bus);
 
 	if (hose->buid)
-		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
+		snprintf(name, size, "%04x:%02x", pci_domain_nr(bus), bus->number);
 	else
 #endif
-		sprintf(name, "%02x", bus->number);
+		snprintf(name, size, "%02x", bus->number);
 
 	return 0;
 }
===== arch/sparc64/kernel/pci.c 1.43 vs edited =====
--- 1.43/arch/sparc64/kernel/pci.c	2004-11-16 23:10:38 -07:00
+++ edited/arch/sparc64/kernel/pci.c	2005-01-14 13:04:09 -07:00
@@ -794,9 +794,9 @@
 }
 EXPORT_SYMBOL(pci_domain_nr);
 
-int pci_name_bus(char *name, struct pci_bus *bus)
+int pci_name_bus(char *name, size_t size, struct pci_bus *bus)
 {
-	sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
+	snprintf(name, size, "%04x:%02x", pci_domain_nr(bus), bus->number);
 	return 0;
 }
 
===== drivers/pci/proc.c 1.41 vs edited =====
--- 1.41/drivers/pci/proc.c	2004-10-06 10:44:51 -06:00
+++ edited/drivers/pci/proc.c	2005-01-14 12:58:22 -07:00
@@ -391,7 +391,7 @@
 		return -EACCES;
 
 	if (!(de = bus->procdir)) {
-		if (pci_name_bus(name, bus))
+		if (pci_name_bus(name, sizeof(name), bus))
 			return -EEXIST;
 		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
 		if (!de)
===== include/asm-alpha/pci.h 1.23 vs edited =====
--- 1.23/include/asm-alpha/pci.h	2004-08-31 09:27:27 -06:00
+++ edited/include/asm-alpha/pci.h	2005-01-14 13:01:02 -07:00
@@ -229,14 +229,14 @@
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 static inline int
-pci_name_bus(char *name, struct pci_bus *bus)
+pci_name_bus(char *name, size_t size, struct pci_bus *bus)
 {
 	struct pci_controller *hose = bus->sysdata;
 
 	if (likely(hose->need_domain_info == 0)) {
-		sprintf(name, "%02x", bus->number);
+		snprintf(name, size, "%02x", bus->number);
 	} else {
-		sprintf(name, "%04x:%02x", hose->index, bus->number);
+		snprintf(name, size, "%04x:%02x", hose->index, bus->number);
 	}
 	return 0;
 }
===== include/asm-ia64/pci.h 1.28 vs edited =====
--- 1.28/include/asm-ia64/pci.h	2005-01-10 15:04:31 -07:00
+++ edited/include/asm-ia64/pci.h	2005-01-14 13:02:47 -07:00
@@ -121,12 +121,12 @@
 
 extern struct pci_ops pci_root_ops;
 
-static inline int pci_name_bus(char *name, struct pci_bus *bus)
+static inline int pci_name_bus(char *name, size_t size, struct pci_bus *bus)
 {
 	if (pci_domain_nr(bus) == 0) {
-		sprintf(name, "%02x", bus->number);
+		snprintf(name, size, "%02x", bus->number);
 	} else {
-		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
+		snprintf(name, size, "%04x:%02x", pci_domain_nr(bus), bus->number);
 	}
 	return 0;
 }
===== include/asm-mips/pci.h 1.19 vs edited =====
--- 1.19/include/asm-mips/pci.h	2004-11-29 06:11:43 -07:00
+++ edited/include/asm-mips/pci.h	2005-01-14 13:02:37 -07:00
@@ -138,14 +138,14 @@
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 static inline int
-pci_name_bus(char *name, struct pci_bus *bus)
+pci_name_bus(char *name, size_t size, struct pci_bus *bus)
 {
 	struct pci_controller *hose = bus->sysdata;
 
 	if (likely(hose->need_domain_info == 0)) {
-		sprintf(name, "%02x", bus->number);
+		snprintf(name, size, "%02x", bus->number);
 	} else {
-		sprintf(name, "%04x:%02x", hose->index, bus->number);
+		snprintf(name, size, "%04x:%02x", hose->index, bus->number);
 	}
 	return 0;
 }
===== include/asm-ppc/pci.h 1.29 vs edited =====
--- 1.29/include/asm-ppc/pci.h	2004-05-31 17:44:01 -06:00
+++ edited/include/asm-ppc/pci.h	2005-01-14 13:02:27 -07:00
@@ -79,9 +79,9 @@
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 /* Set the name of the bus as it appears in /proc/bus/pci */
-static inline int pci_name_bus(char *name, struct pci_bus *bus)
+static inline int pci_name_bus(char *name, size_t size, struct pci_bus *bus)
 {
-	sprintf(name, "%02x", bus->number);
+	snprintf(name, size, "%02x", bus->number);
 	return 0;
 }
 
===== include/asm-ppc64/pci.h 1.26 vs edited =====
--- 1.26/include/asm-ppc64/pci.h	2004-10-25 20:18:38 -06:00
+++ edited/include/asm-ppc64/pci.h	2005-01-14 13:00:10 -07:00
@@ -191,7 +191,7 @@
 extern int pci_domain_nr(struct pci_bus *bus);
 
 /* Set the name of the bus as it appears in /proc/bus/pci */
-extern int pci_name_bus(char *name, struct pci_bus *bus);
+extern int pci_name_bus(char *name, size_t size, struct pci_bus *bus);
 
 struct vm_area_struct;
 /* Map a range of PCI memory or I/O space for a device into user space */
===== include/asm-sparc64/pci.h 1.23 vs edited =====
--- 1.23/include/asm-sparc64/pci.h	2004-10-31 19:27:13 -07:00
+++ edited/include/asm-sparc64/pci.h	2005-01-14 13:00:26 -07:00
@@ -223,7 +223,7 @@
 /* Return the index of the PCI controller for device PDEV. */
 
 extern int pci_domain_nr(struct pci_bus *bus);
-extern int pci_name_bus(char *name, struct pci_bus *bus);
+extern int pci_name_bus(char *name, size_t size, struct pci_bus *bus);
 
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
===== include/linux/pci.h 1.147 vs edited =====
--- 1.147/include/linux/pci.h	2005-01-10 12:28:15 -07:00
+++ edited/include/linux/pci.h	2005-01-14 13:03:21 -07:00
@@ -966,9 +966,9 @@
  */
 #ifndef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
-static inline int pci_name_bus(char *name, struct pci_bus *bus)
+static inline int pci_name_bus(char *name, size_t size, struct pci_bus *bus)
 {
-	sprintf(name, "%02x", bus->number);
+	snprintf(name, size, "%02x", bus->number);
 	return 0;
 }
 #endif



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263260AbVCDVr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbVCDVr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbVCDVqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:46:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:47009 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263137AbVCDUyV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:21 -0500
Cc: matthew@wil.cx
Subject: [PATCH] PCI: pci_proc_domain
In-Reply-To: <11099696361222@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:56 -0800
Message-Id: <1109969636798@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.9, 2005/02/07 14:38:06-08:00, matthew@wil.cx

[PATCH] PCI: pci_proc_domain

There's no need for the architectures to know how to name busses,
so replace pci_name_bus with pci_proc_domain -- a predicate to allow
architectures to choose whether domains are included in /proc/bus/pci
or not.  I've converted all architectures but only tested ia64 and a
CONFIG_PCI_DOMAINS=n build.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc64/kernel/pci.c   |   16 ++++++----------
 arch/sparc64/kernel/pci.c |    6 ------
 drivers/pci/proc.c        |   20 +++++++++++++-------
 include/asm-alpha/pci.h   |   11 ++---------
 include/asm-ia64/pci.h    |    9 ++-------
 include/asm-mips/pci.h    |   11 ++---------
 include/asm-ppc/pci.h     |    3 +--
 include/asm-ppc64/pci.h   |    4 ++--
 include/asm-sparc64/pci.h |    5 ++++-
 include/linux/pci.h       |    3 +--
 10 files changed, 33 insertions(+), 55 deletions(-)


diff -Nru a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c	2005-03-04 12:43:13 -08:00
+++ b/arch/ppc64/kernel/pci.c	2005-03-04 12:43:13 -08:00
@@ -300,19 +300,15 @@
 
 EXPORT_SYMBOL(pci_domain_nr);
 
-/* Set the name of the bus as it appears in /proc/bus/pci */
-int pci_name_bus(char *name, struct pci_bus *bus)
+/* Decide whether to display the domain number in /proc */
+int pci_proc_domain(struct pci_bus *bus)
 {
-#ifndef CONFIG_PPC_ISERIES
+#ifdef CONFIG_PPC_ISERIES
+	return 0;
+#else
 	struct pci_controller *hose = pci_bus_to_host(bus);
-
-	if (hose->buid)
-		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
-	else
+	return hose->buid;
 #endif
-		sprintf(name, "%02x", bus->number);
-
-	return 0;
 }
 
 /*
diff -Nru a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
--- a/arch/sparc64/kernel/pci.c	2005-03-04 12:43:13 -08:00
+++ b/arch/sparc64/kernel/pci.c	2005-03-04 12:43:13 -08:00
@@ -794,12 +794,6 @@
 }
 EXPORT_SYMBOL(pci_domain_nr);
 
-int pci_name_bus(char *name, struct pci_bus *bus)
-{
-	sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
-	return 0;
-}
-
 int pcibios_prep_mwi(struct pci_dev *dev)
 {
 	/* We set correct PCI_CACHE_LINE_SIZE register values for every
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	2005-03-04 12:43:13 -08:00
+++ b/drivers/pci/proc.c	2005-03-04 12:43:13 -08:00
@@ -384,26 +384,32 @@
 int pci_proc_attach_device(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
-	struct proc_dir_entry *de, *e;
+	struct proc_dir_entry *e;
 	char name[16];
 
 	if (!proc_initialized)
 		return -EACCES;
 
-	if (!(de = bus->procdir)) {
-		if (pci_name_bus(name, bus))
-			return -EEXIST;
-		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
-		if (!de)
+	if (!bus->procdir) {
+		if (pci_proc_domain(bus)) {
+			sprintf(name, "%04x:%02x", pci_domain_nr(bus),
+					bus->number);
+		} else {
+			sprintf(name, "%02x", bus->number);
+		}
+		bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
+		if (!bus->procdir)
 			return -ENOMEM;
 	}
+
 	sprintf(name, "%02x.%x", PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	e = dev->procent = create_proc_entry(name, S_IFREG | S_IRUGO | S_IWUSR, de);
+	e = create_proc_entry(name, S_IFREG | S_IRUGO | S_IWUSR, bus->procdir);
 	if (!e)
 		return -ENOMEM;
 	e->proc_fops = &proc_bus_pci_operations;
 	e->data = dev;
 	e->size = dev->cfg_size;
+	dev->procent = e;
 
 	return 0;
 }
diff -Nru a/include/asm-alpha/pci.h b/include/asm-alpha/pci.h
--- a/include/asm-alpha/pci.h	2005-03-04 12:43:13 -08:00
+++ b/include/asm-alpha/pci.h	2005-03-04 12:43:13 -08:00
@@ -228,17 +228,10 @@
 
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
-static inline int
-pci_name_bus(char *name, struct pci_bus *bus)
+static inline int pci_proc_domain(struct pci_bus *bus)
 {
 	struct pci_controller *hose = bus->sysdata;
-
-	if (likely(hose->need_domain_info == 0)) {
-		sprintf(name, "%02x", bus->number);
-	} else {
-		sprintf(name, "%04x:%02x", hose->index, bus->number);
-	}
-	return 0;
+	return hose->need_domain_info;
 }
 
 static inline void
diff -Nru a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h	2005-03-04 12:43:13 -08:00
+++ b/include/asm-ia64/pci.h	2005-03-04 12:43:13 -08:00
@@ -121,14 +121,9 @@
 
 extern struct pci_ops pci_root_ops;
 
-static inline int pci_name_bus(char *name, struct pci_bus *bus)
+static inline int pci_proc_domain(struct pci_bus *bus)
 {
-	if (pci_domain_nr(bus) == 0) {
-		sprintf(name, "%02x", bus->number);
-	} else {
-		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
-	}
-	return 0;
+	return (pci_domain_nr(bus) != 0);
 }
 
 static inline void pcibios_add_platform_entries(struct pci_dev *dev)
diff -Nru a/include/asm-mips/pci.h b/include/asm-mips/pci.h
--- a/include/asm-mips/pci.h	2005-03-04 12:43:13 -08:00
+++ b/include/asm-mips/pci.h	2005-03-04 12:43:13 -08:00
@@ -137,17 +137,10 @@
 
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
-static inline int
-pci_name_bus(char *name, struct pci_bus *bus)
+static inline int pci_proc_domain(struct pci_bus *bus)
 {
 	struct pci_controller *hose = bus->sysdata;
-
-	if (likely(hose->need_domain_info == 0)) {
-		sprintf(name, "%02x", bus->number);
-	} else {
-		sprintf(name, "%04x:%02x", hose->index, bus->number);
-	}
-	return 0;
+	return hose->need_domain_info;
 }
 
 #endif /* CONFIG_PCI_DOMAINS */
diff -Nru a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
--- a/include/asm-ppc/pci.h	2005-03-04 12:43:13 -08:00
+++ b/include/asm-ppc/pci.h	2005-03-04 12:43:13 -08:00
@@ -79,9 +79,8 @@
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 /* Set the name of the bus as it appears in /proc/bus/pci */
-static inline int pci_name_bus(char *name, struct pci_bus *bus)
+static inline int pci_proc_domain(struct pci_bus *bus)
 {
-	sprintf(name, "%02x", bus->number);
 	return 0;
 }
 
diff -Nru a/include/asm-ppc64/pci.h b/include/asm-ppc64/pci.h
--- a/include/asm-ppc64/pci.h	2005-03-04 12:43:13 -08:00
+++ b/include/asm-ppc64/pci.h	2005-03-04 12:43:13 -08:00
@@ -190,8 +190,8 @@
 
 extern int pci_domain_nr(struct pci_bus *bus);
 
-/* Set the name of the bus as it appears in /proc/bus/pci */
-extern int pci_name_bus(char *name, struct pci_bus *bus);
+/* Decide whether to display the domain number in /proc */
+extern int pci_proc_domain(struct pci_bus *bus);
 
 struct vm_area_struct;
 /* Map a range of PCI memory or I/O space for a device into user space */
diff -Nru a/include/asm-sparc64/pci.h b/include/asm-sparc64/pci.h
--- a/include/asm-sparc64/pci.h	2005-03-04 12:43:13 -08:00
+++ b/include/asm-sparc64/pci.h	2005-03-04 12:43:13 -08:00
@@ -223,7 +223,10 @@
 /* Return the index of the PCI controller for device PDEV. */
 
 extern int pci_domain_nr(struct pci_bus *bus);
-extern int pci_name_bus(char *name, struct pci_bus *bus);
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return 1;
+}
 
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-03-04 12:43:13 -08:00
+++ b/include/linux/pci.h	2005-03-04 12:43:13 -08:00
@@ -964,9 +964,8 @@
  */
 #ifndef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
-static inline int pci_name_bus(char *name, struct pci_bus *bus)
+static inline int pci_proc_domain(struct pci_bus *bus)
 {
-	sprintf(name, "%02x", bus->number);
 	return 0;
 }
 #endif


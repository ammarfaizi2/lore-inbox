Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVAQTXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVAQTXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVAQTXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:23:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26595 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262841AbVAQTXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:23:37 -0500
Date: Mon, 17 Jan 2005 19:23:35 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] pci_proc_domain
Message-ID: <20050117192335.GI30982@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's no need for the architectures to know how to name busses,
so replace pci_name_bus with pci_proc_domain -- a predicate to allow
architectures to choose whether domains are included in /proc/bus/pci
or not.  I've converted all architectures but only tested ia64 and a
CONFIG_PCI_DOMAINS=n build.

Index: linux-2.6/drivers/pci/proc.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/proc.c,v
retrieving revision 1.6
diff -u -p -r1.6 proc.c
--- linux-2.6/drivers/pci/proc.c	21 Oct 2004 18:59:15 -0000	1.6
+++ linux-2.6/drivers/pci/proc.c	17 Jan 2005 19:03:01 -0000
@@ -384,26 +384,32 @@ static struct proc_dir_entry *proc_bus_p
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
Index: linux-2.6/arch/ppc64/kernel/pci.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ppc64/kernel/pci.c,v
retrieving revision 1.12
diff -u -p -r1.12 pci.c
--- linux-2.6/arch/ppc64/kernel/pci.c	12 Jan 2005 20:15:46 -0000	1.12
+++ linux-2.6/arch/ppc64/kernel/pci.c	17 Jan 2005 19:03:02 -0000
@@ -300,19 +300,15 @@ int pci_domain_nr(struct pci_bus *bus)
 
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
Index: linux-2.6/arch/sparc64/kernel/pci.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/sparc64/kernel/pci.c,v
retrieving revision 1.7
diff -u -p -r1.7 pci.c
--- linux-2.6/arch/sparc64/kernel/pci.c	4 Dec 2004 07:02:25 -0000	1.7
+++ linux-2.6/arch/sparc64/kernel/pci.c	17 Jan 2005 19:03:02 -0000
@@ -794,12 +794,6 @@ int pci_domain_nr(struct pci_bus *pbus)
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
Index: linux-2.6/include/asm-alpha/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-alpha/pci.h,v
retrieving revision 1.7
diff -u -p -r1.7 pci.h
--- linux-2.6/include/asm-alpha/pci.h	13 Sep 2004 15:23:56 -0000	1.7
+++ linux-2.6/include/asm-alpha/pci.h	17 Jan 2005 19:03:02 -0000
@@ -228,17 +228,10 @@ extern void pcibios_resource_to_bus(stru
 
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
Index: linux-2.6/include/asm-ia64/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ia64/pci.h,v
retrieving revision 1.8
diff -u -p -r1.8 pci.h
--- linux-2.6/include/asm-ia64/pci.h	29 Nov 2004 19:56:42 -0000	1.8
+++ linux-2.6/include/asm-ia64/pci.h	17 Jan 2005 19:03:02 -0000
@@ -107,14 +107,9 @@ struct pci_controller {
 
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
Index: linux-2.6/include/asm-mips/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-mips/pci.h,v
retrieving revision 1.9
diff -u -p -r1.9 pci.h
--- linux-2.6/include/asm-mips/pci.h	4 Dec 2004 07:02:57 -0000	1.9
+++ linux-2.6/include/asm-mips/pci.h	17 Jan 2005 19:03:02 -0000
@@ -137,17 +137,10 @@ extern void pcibios_resource_to_bus(stru
 
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
Index: linux-2.6/include/asm-ppc/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ppc/pci.h,v
retrieving revision 1.11
diff -u -p -r1.11 pci.h
--- linux-2.6/include/asm-ppc/pci.h	16 Jun 2004 18:48:12 -0000	1.11
+++ linux-2.6/include/asm-ppc/pci.h	17 Jan 2005 19:03:02 -0000
@@ -79,9 +79,8 @@ extern unsigned long pci_bus_to_phys(uns
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
 /* Set the name of the bus as it appears in /proc/bus/pci */
-static inline int pci_name_bus(char *name, struct pci_bus *bus)
+static inline int pci_proc_domain(struct pci_bus *bus)
 {
-	sprintf(name, "%02x", bus->number);
 	return 0;
 }
 
Index: linux-2.6/include/asm-ppc64/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-ppc64/pci.h,v
retrieving revision 1.12
diff -u -p -r1.12 pci.h
--- linux-2.6/include/asm-ppc64/pci.h	29 Nov 2004 19:56:45 -0000	1.12
+++ linux-2.6/include/asm-ppc64/pci.h	17 Jan 2005 19:03:02 -0000
@@ -190,8 +190,8 @@ static inline int pci_dma_mapping_error(
 
 extern int pci_domain_nr(struct pci_bus *bus);
 
-/* Set the name of the bus as it appears in /proc/bus/pci */
-extern int pci_name_bus(char *name, struct pci_bus *bus);
+/* Decide whether to display the domain number in /proc */
+extern int pci_proc_domain(struct pci_bus *bus);
 
 struct vm_area_struct;
 /* Map a range of PCI memory or I/O space for a device into user space */
Index: linux-2.6/include/asm-sparc64/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-sparc64/pci.h,v
retrieving revision 1.9
diff -u -p -r1.9 pci.h
--- linux-2.6/include/asm-sparc64/pci.h	29 Nov 2004 19:56:46 -0000	1.9
+++ linux-2.6/include/asm-sparc64/pci.h	17 Jan 2005 19:03:02 -0000
@@ -223,7 +223,10 @@ static inline int pci_dma_mapping_error(
 /* Return the index of the PCI controller for device PDEV. */
 
 extern int pci_domain_nr(struct pci_bus *bus);
-extern int pci_name_bus(char *name, struct pci_bus *bus);
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return 1;
+}
 
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
Index: linux-2.6/include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/pci.h,v
retrieving revision 1.25
diff -u -p -r1.25 pci.h
--- linux-2.6/include/linux/pci.h	12 Jan 2005 20:17:57 -0000	1.25
+++ linux-2.6/include/linux/pci.h	17 Jan 2005 19:03:02 -0000
@@ -966,9 +966,8 @@ static inline int pci_enable_wake(struct
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

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

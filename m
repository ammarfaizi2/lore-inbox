Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTFTNeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTFTNeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:34:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30103 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261566AbTFTNeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:34:14 -0400
Date: Fri, 20 Jun 2003 14:48:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, David Mosberger <davidm@hpl.hp.com>
Subject: [PATCH] reimplement pci proc name
Message-ID: <20030620134811.GR24357@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg.  Ivan's not happy with the solution I came up with for naming
/proc/bus/pci and Anton would prefer something slightly different too,
so I abstracted the name out so each architecture can do its own thing.

This is against 2.5.72 so won't apply cleanly to your tree (it
applies to bitkeeper as of a few minutes ago with only minor offsets).
I've implemented the original name for non-PCI-domain machines; done what
ia64 and alpha need, respectively (assuming I didn't misunderstand Ivan),
and plopped in the Old Way of doing things for Sparc64, PPC and PPC64.
Maintainers may alter this to whatever degree of complexity they wish.

Index: drivers/pci/proc.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/pci/proc.c,v
retrieving revision 1.9
diff -u -p -r1.9 proc.c
--- drivers/pci/proc.c	14 Jun 2003 22:15:29 -0000	1.9
+++ drivers/pci/proc.c	17 Jun 2003 19:36:50 -0000
@@ -383,7 +383,8 @@ int pci_proc_attach_device(struct pci_de
 		return -EACCES;
 
 	if (!(de = bus->procdir)) {
-		sprintf(name, "%02x", bus->number);
+		if (!pci_name_bus(name, bus))
+			return -EEXIST;
 		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
 		if (!de)
 			return -ENOMEM;
Index: include/asm-alpha/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-alpha/pci.h,v
retrieving revision 1.10
diff -u -p -r1.10 pci.h
--- include/asm-alpha/pci.h	14 Jun 2003 22:15:52 -0000	1.10
+++ include/asm-alpha/pci.h	20 Jun 2003 12:44:23 -0000
@@ -194,6 +194,18 @@ pcibios_resource_to_bus(struct pci_dev *
 
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
+/* Bus number == domain number until we get above 256 busses */
+static inline int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	int domain = pci_domain_nr(bus)
+	if (domain < 256) {
+		sprintf(name, "%02x", domain);
+	} else {
+		sprintf(name, "%04x:%02x", domain, bus->number);
+	}
+	return 0;
+}
+
 #endif /* __KERNEL__ */
 
 /* Values for the `which' argument to sys_pciconfig_iobase.  */
Index: include/asm-ia64/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-ia64/pci.h,v
retrieving revision 1.8
diff -u -p -r1.8 pci.h
--- include/asm-ia64/pci.h	14 Jun 2003 22:15:56 -0000	1.8
+++ include/asm-ia64/pci.h	17 Jun 2003 19:37:45 -0000
@@ -93,6 +93,16 @@ struct pci_controller {
 
 #define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
 #define pci_domain_nr(busdev)    (PCI_CONTROLLER(busdev)->segment)
+
+static inline int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	if (pci_domain_nr(bus) == 0) {
+		sprintf(name, "%02x", bus->number);
+	} else {
+		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
+	}
+	return 0;
+}
 
 /* generic pci stuff */
 #include <asm-generic/pci.h>
Index: include/asm-ppc/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-ppc/pci.h,v
retrieving revision 1.8
diff -u -p -r1.8 pci.h
--- include/asm-ppc/pci.h	17 Jun 2003 11:54:26 -0000	1.8
+++ include/asm-ppc/pci.h	20 Jun 2003 13:25:29 -0000
@@ -269,6 +269,13 @@ pci_dac_dma_sync_single(struct pci_dev *
 /* Return the index of the PCI controller for device PDEV. */
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
+/* Set the name of the bus as it appears in /proc/bus/pci */
+static inline int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	sprintf(name, "%02x", bus->number);
+	return 0;
+}
+
 /* Map a range of PCI memory or I/O space for a device into user space */
 int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine);
Index: include/asm-ppc64/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-ppc64/pci.h,v
retrieving revision 1.6
diff -u -p -r1.6 pci.h
--- include/asm-ppc64/pci.h	14 Jun 2003 22:15:59 -0000	1.6
+++ include/asm-ppc64/pci.h	20 Jun 2003 13:25:48 -0000
@@ -88,6 +88,13 @@ static inline int pci_dma_supported(stru
 
 extern int pci_domain_nr(struct pci_bus *bus);
 
+/* Set the name of the bus as it appears in /proc/bus/pci */
+static inline int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	sprintf(name, "%02x", bus->number);
+	return 0;
+}
+
 struct vm_area_struct;
 /* Map a range of PCI memory or I/O space for a device into user space */
 int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
Index: include/asm-sparc64/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/asm-sparc64/pci.h,v
retrieving revision 1.8
diff -u -p -r1.8 pci.h
--- include/asm-sparc64/pci.h	14 Jun 2003 22:16:00 -0000	1.8
+++ include/asm-sparc64/pci.h	20 Jun 2003 13:25:52 -0000
@@ -191,6 +191,13 @@ pci_dac_dma_sync_single(struct pci_dev *
 
 extern int pci_domain_nr(struct pci_bus *bus);
 
+/* Set the name of the bus as it appears in /proc/bus/pci */
+static inline int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	sprintf(name, "%02x", bus->number);
+	return 0;
+}
+
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
 #define HAVE_PCI_MMAP
Index: include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/linux/pci.h,v
retrieving revision 1.17
diff -u -p -r1.17 pci.h
--- include/linux/pci.h	14 Jun 2003 22:16:01 -0000	1.17
+++ include/linux/pci.h	19 Jun 2003 00:55:35 -0000
@@ -808,6 +815,11 @@ extern int pci_pci_problems;
 
 #ifndef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
+static inline int pci_name_bus(char *name, struct pci_bus *bus)
+{
+	sprintf(name, "%02x", bus->number);
+	return 0;
+}
 #endif
 
 #endif /* __KERNEL__ */

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk

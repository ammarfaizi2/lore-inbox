Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbSJCWkT>; Thu, 3 Oct 2002 18:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbSJCWj5>; Thu, 3 Oct 2002 18:39:57 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:28685 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261411AbSJCWiu>;
	Thu, 3 Oct 2002 18:38:50 -0400
Date: Thu, 3 Oct 2002 15:41:32 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021003224132.GD2289@kroah.com>
References: <20021003224011.GA2289@kroah.com> <20021003224055.GB2289@kroah.com> <20021003224116.GC2289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003224116.GC2289@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.684   -> 1.685  
#	drivers/net/tulip/de4x5.c	1.14    -> 1.15   
#	drivers/pci/syscall.c	1.1     -> 1.2    
#	drivers/pci/compat.c	1.5     -> 1.6    
#	 drivers/net/hp100.c	1.8     -> 1.9    
#	 include/linux/pci.h	1.44    -> 1.45   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/03	greg@kroah.com	1.685
# PCI: removed pcibios_present()
# --------------------------------------------
#
diff -Nru a/drivers/net/hp100.c b/drivers/net/hp100.c
--- a/drivers/net/hp100.c	Thu Oct  3 14:24:12 2002
+++ b/drivers/net/hp100.c	Thu Oct  3 14:24:12 2002
@@ -412,7 +412,7 @@
 	/* First: scan PCI bus(es) */
 
 #ifdef CONFIG_PCI
-	if (pcibios_present()) {
+	if (pci_present()) {
 		int pci_index;
 		struct pci_dev *pci_dev = NULL;
 		int pci_id_index;
@@ -2960,7 +2960,7 @@
 {
 	int i, cards;
 
-	if (hp100_port == 0 && !EISA_bus && !pcibios_present())
+	if (hp100_port == 0 && !EISA_bus && !pci_present())
 		printk("hp100: You should not use auto-probing with insmod!\n");
 
 	/* Loop on all possible base addresses */
diff -Nru a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
--- a/drivers/net/tulip/de4x5.c	Thu Oct  3 14:24:12 2002
+++ b/drivers/net/tulip/de4x5.c	Thu Oct  3 14:24:12 2002
@@ -2190,7 +2190,7 @@
 
     if (lastPCI == NO_MORE_PCI) return;
 
-    if (!pcibios_present()) {
+    if (!pci_present()) {
 	lastPCI = NO_MORE_PCI;
 	return;          /* No PCI bus in this machine! */
     }
@@ -5872,7 +5872,7 @@
 	if (EISA_signature(name, EISA_ID)) j++;
     }
 #endif
-    if (!pcibios_present()) return j;
+    if (!pci_present()) return j;
 
     for (i=0; (pdev=pci_find_class(class, pdev))!= NULL; i++) {
 	vendor = pdev->vendor;
diff -Nru a/drivers/pci/compat.c b/drivers/pci/compat.c
--- a/drivers/pci/compat.c	Thu Oct  3 14:24:12 2002
+++ b/drivers/pci/compat.c	Thu Oct  3 14:24:12 2002
@@ -13,12 +13,6 @@
 
 /* Obsolete functions, these will be going away... */
 
-int
-pcibios_present(void)
-{
-	return !list_empty(&pci_devices);
-}
-
 #define PCI_OP(rw,size,type)							\
 int pcibios_##rw##_config_##size (unsigned char bus, unsigned char dev_fn,	\
 				  unsigned char where, unsigned type val)	\
@@ -35,8 +29,6 @@
 PCI_OP(write, word, short)
 PCI_OP(write, dword, int)
 
-
-EXPORT_SYMBOL(pcibios_present);
 EXPORT_SYMBOL(pcibios_read_config_byte);
 EXPORT_SYMBOL(pcibios_read_config_word);
 EXPORT_SYMBOL(pcibios_read_config_dword);
diff -Nru a/drivers/pci/syscall.c b/drivers/pci/syscall.c
--- a/drivers/pci/syscall.c	Thu Oct  3 14:24:12 2002
+++ b/drivers/pci/syscall.c	Thu Oct  3 14:24:12 2002
@@ -98,7 +98,7 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (!pcibios_present())
+	if (!pci_present())
 		return -ENOSYS;
 
 	dev = pci_find_slot(bus, dfn);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Oct  3 14:24:12 2002
+++ b/include/linux/pci.h	Thu Oct  3 14:24:12 2002
@@ -322,15 +322,6 @@
 
 #define PCI_ANY_ID (~0)
 
-#define pci_present pcibios_present
-
-
-#define pci_for_each_dev_reverse(dev) \
-	for(dev = pci_dev_g(pci_devices.prev); dev != pci_dev_g(&pci_devices); dev = pci_dev_g(dev->global_list.prev))
-
-#define pci_for_each_bus(bus) \
-for(bus = pci_bus_b(pci_root_buses.next); bus != pci_bus_b(&pci_root_buses); bus = pci_bus_b(bus->node.next))
-
 /*
  * The pci_dev structure is used to describe both PCI and ISAPnP devices.
  */
@@ -503,8 +494,17 @@
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
+static inline int pci_present(void)
+{
+	return !list_empty(&pci_devices);
+}
+
 #define pci_for_each_dev(dev) \
 	for(dev = pci_dev_g(pci_devices.next); dev != pci_dev_g(&pci_devices); dev = pci_dev_g(dev->global_list.next))
+#define pci_for_each_dev_reverse(dev) \
+	for(dev = pci_dev_g(pci_devices.prev); dev != pci_dev_g(&pci_devices); dev = pci_dev_g(dev->global_list.prev))
+#define pci_for_each_bus(bus) \
+	for(bus = pci_bus_b(pci_root_buses.next); bus != pci_bus_b(&pci_root_buses); bus = pci_bus_b(bus->node.next))
 
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);
@@ -520,7 +520,6 @@
 
 /* Backward compatibility, don't use in new code! */
 
-int pcibios_present(void);
 int pcibios_read_config_byte (unsigned char bus, unsigned char dev_fn,
 			      unsigned char where, unsigned char *val);
 int pcibios_read_config_word (unsigned char bus, unsigned char dev_fn,
@@ -656,7 +655,7 @@
  */
 
 #ifndef CONFIG_PCI
-static inline int pcibios_present(void) { return 0; }
+static inline int pci_present(void) { return 0; }
 
 #define _PCI_NOP(o,s,t) \
 	static inline int pcibios_##o##_config_##s (u8 bus, u8 dfn, u8 where, t val) \

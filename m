Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbVKDAme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbVKDAme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbVKDAme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:42:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:25504 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161002AbVKDAmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:42:33 -0500
Date: Thu, 3 Nov 2005 18:42:26 -0600
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/42] ppc64: uniform usage of bus unit id interfaces
Message-ID: <20051104004226.GQ19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103235918.GA25616@mail.gnucash.org>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


01-pci-dn-uniformization.patch

This patch changes the rtas_pci interface to use the new struct pci_dn 
structure for two routines that work with pci device nodes.

This patch also does some minor janitorial work: it uses some handy macros 
and cleans up some trailing whitespace in the affected file.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-git3/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/ppc64/kernel/eeh.c	2005-10-31 11:59:11.879644789 -0600
+++ linux-2.6.14-git3/arch/ppc64/kernel/eeh.c	2005-10-31 12:01:21.403477910 -0600
@@ -71,10 +71,6 @@
  *  and sent out for processing.
  */
 
-/** Bus Unit ID macros; get low and hi 32-bits of the 64-bit BUID */
-#define BUID_HI(buid) ((buid) >> 32)
-#define BUID_LO(buid) ((buid) & 0xffffffff)
-
 /* EEH event workqueue setup. */
 static DEFINE_SPINLOCK(eeh_eventlist_lock);
 LIST_HEAD(eeh_eventlist);
Index: linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-powerpc/ppc-pci.h	2005-10-31 11:59:11.880644649 -0600
+++ linux-2.6.14-git3/include/asm-powerpc/ppc-pci.h	2005-10-31 12:01:21.404477769 -0600
@@ -26,6 +26,10 @@
 
 extern struct pci_dev *ppc64_isabridge_dev;	/* may be NULL if no ISA bus */
 
+/** Bus Unit ID macros; get low and hi 32-bits of the 64-bit BUID */
+#define BUID_HI(buid) ((buid) >> 32)
+#define BUID_LO(buid) ((buid) & 0xffffffff)
+
 /* PCI device_node operations */
 struct device_node;
 typedef void *(*traverse_func)(struct device_node *me, void *data);
Index: linux-2.6.14-git3/arch/ppc64/kernel/rtas_pci.c
===================================================================
--- linux-2.6.14-git3.orig/arch/ppc64/kernel/rtas_pci.c	2005-10-31 11:59:11.879644789 -0600
+++ linux-2.6.14-git3/arch/ppc64/kernel/rtas_pci.c	2005-10-31 12:01:21.407477349 -0600
@@ -5,19 +5,19 @@
  * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
  *
  * RTAS specific routines for PCI.
- * 
+ *
  * Based on code from pci.c, chrp_pci.c and pSeries_pci.c
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- *    
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
@@ -47,7 +47,7 @@
 static int ibm_read_pci_config;
 static int ibm_write_pci_config;
 
-static int config_access_valid(struct pci_dn *dn, int where)
+static inline int config_access_valid(struct pci_dn *dn, int where)
 {
 	if (where < 256)
 		return 1;
@@ -72,16 +72,14 @@
         return 0;
 }
 
-static int rtas_read_config(struct device_node *dn, int where, int size, u32 *val)
+static int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 {
 	int returnval = -1;
 	unsigned long buid, addr;
 	int ret;
-	struct pci_dn *pdn;
 
-	if (!dn || !dn->data)
+	if (!pdn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	pdn = dn->data;
 	if (!config_access_valid(pdn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -90,7 +88,7 @@
 	buid = pdn->phb->buid;
 	if (buid) {
 		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,
-				addr, buid >> 32, buid & 0xffffffff, size);
+				addr, BUID_HI(buid), BUID_LO(buid), size);
 	} else {
 		ret = rtas_call(read_pci_config, 2, 2, &returnval, addr, size);
 	}
@@ -100,7 +98,7 @@
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (returnval == EEH_IO_ERROR_VALUE(size) &&
-	    eeh_dn_check_failure (dn, NULL))
+	    eeh_dn_check_failure (pdn->node, NULL))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	return PCIBIOS_SUCCESSFUL;
@@ -118,23 +116,23 @@
 		busdn = bus->sysdata;	/* must be a phb */
 
 	/* Search only direct children of the bus */
-	for (dn = busdn->child; dn; dn = dn->sibling)
-		if (dn->data && PCI_DN(dn)->devfn == devfn
+	for (dn = busdn->child; dn; dn = dn->sibling) {
+		struct pci_dn *pdn = PCI_DN(dn);
+		if (pdn && pdn->devfn == devfn
 		    && of_device_available(dn))
-			return rtas_read_config(dn, where, size, val);
+			return rtas_read_config(pdn, where, size, val);
+	}
 
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
-int rtas_write_config(struct device_node *dn, int where, int size, u32 val)
+int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 {
 	unsigned long buid, addr;
 	int ret;
-	struct pci_dn *pdn;
 
-	if (!dn || !dn->data)
+	if (!pdn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	pdn = dn->data;
 	if (!config_access_valid(pdn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -142,7 +140,8 @@
 		(pdn->devfn << 8) | (where & 0xff);
 	buid = pdn->phb->buid;
 	if (buid) {
-		ret = rtas_call(ibm_write_pci_config, 5, 1, NULL, addr, buid >> 32, buid & 0xffffffff, size, (ulong) val);
+		ret = rtas_call(ibm_write_pci_config, 5, 1, NULL, addr,
+			BUID_HI(buid), BUID_LO(buid), size, (ulong) val);
 	} else {
 		ret = rtas_call(write_pci_config, 3, 1, NULL, addr, size, (ulong)val);
 	}
@@ -165,10 +164,12 @@
 		busdn = bus->sysdata;	/* must be a phb */
 
 	/* Search only direct children of the bus */
-	for (dn = busdn->child; dn; dn = dn->sibling)
-		if (dn->data && PCI_DN(dn)->devfn == devfn
+	for (dn = busdn->child; dn; dn = dn->sibling) {
+		struct pci_dn *pdn = PCI_DN(dn);
+		if (pdn && pdn->devfn == devfn
 		    && of_device_available(dn))
-			return rtas_write_config(dn, where, size, val);
+			return rtas_write_config(pdn, where, size, val);
+	}
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
@@ -221,7 +222,7 @@
 	/* Python's register file is 1 MB in size. */
 	chip_regs = ioremap(reg_struct.address & ~(0xfffffUL), 0x100000);
 
-	/* 
+	/*
 	 * Firmware doesn't always clear this bit which is critical
 	 * for good performance - Anton
 	 */
@@ -292,7 +293,7 @@
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		return 1;
  	}
- 
+
 	phb->first_busno =  bus_range[0];
 	phb->last_busno  =  bus_range[1];
 

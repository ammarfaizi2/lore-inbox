Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbUKCJkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbUKCJkE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUKCJit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:38:49 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:29329 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261503AbUKCJK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:10:57 -0500
Date: Wed, 3 Nov 2004 01:10:39 -0800
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] deprecate pci_module_init
Message-ID: <20041103091039.GA22469@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A separate pci_module_init doesn't really exist anymore so we should
deprecate this.  Whilst we are at it we should insist any (old) users
of this and also users of pci_register_driver check their return
codes.  Whilst doing this we may as well remove some old (unused)
preprocessor tokens whilst we are at it.

Signed-off-by: Chris Wedgwood <cw@f00f.org>
---

FWIW I have some cleanups for drivers that I'll post in the next day
or so...


===== Documentation/pci.txt 1.15 vs edited =====
--- 1.15/Documentation/pci.txt	2004-10-06 09:47:03 -07:00
+++ edited/Documentation/pci.txt	2004-11-02 11:32:43 -08:00
@@ -230,8 +230,6 @@ pci_find_slot()			Find pci_dev correspon
 pci_set_power_state()		Set PCI Power Management state (0=D0 ... 3=D3)
 pci_find_capability()		Find specified capability in device's capability
 				list.
-pci_module_init()		Inline helper function for ensuring correct
-				pci_driver initialization and error handling.
 pci_resource_start()		Returns bus start address for a given PCI region
 pci_resource_end()		Returns bus end address for a given PCI region
 pci_resource_len()		Returns the byte length of a PCI region
===== drivers/pci/pci-driver.c 1.42 vs edited =====
--- 1.42/drivers/pci/pci-driver.c	2004-10-19 16:56:40 -07:00
+++ edited/drivers/pci/pci-driver.c	2004-11-02 11:32:44 -08:00
@@ -400,7 +400,7 @@ pci_populate_driver_dir(struct pci_drive
  * If no error occured, the driver remains registered even if 
  * no device was claimed during registration.
  */
-int pci_register_driver(struct pci_driver *drv)
+int __must_check pci_register_driver(struct pci_driver *drv)
 {
 	int error;
 
===== include/linux/pci.h 1.139 vs edited =====
--- 1.139/include/linux/pci.h	2004-10-05 15:56:26 -07:00
+++ edited/include/linux/pci.h	2004-11-02 11:32:44 -08:00
@@ -41,13 +41,9 @@
 #define PCI_STATUS		0x06	/* 16 bits */
 #define  PCI_STATUS_CAP_LIST	0x10	/* Support Capability List */
 #define  PCI_STATUS_66MHZ	0x20	/* Support 66 Mhz PCI 2.1 bus */
-#define  PCI_STATUS_UDF		0x40	/* Support User Definable Features [obsolete] */
 #define  PCI_STATUS_FAST_BACK	0x80	/* Accept fast-back to back */
 #define  PCI_STATUS_PARITY	0x100	/* Detected parity error */
 #define  PCI_STATUS_DEVSEL_MASK	0x600	/* DEVSEL timing */
-#define  PCI_STATUS_DEVSEL_FAST	0x000	
-#define  PCI_STATUS_DEVSEL_MEDIUM 0x200
-#define  PCI_STATUS_DEVSEL_SLOW 0x400
 #define  PCI_STATUS_SIG_TARGET_ABORT 0x800 /* Set on target abort */
 #define  PCI_STATUS_REC_TARGET_ABORT 0x1000 /* Master ack of " */
 #define  PCI_STATUS_REC_MASTER_ABORT 0x2000 /* Set on master abort */
@@ -681,7 +677,13 @@ struct pci_driver {
  * pci_module_init is obsolete, this stays here till we fix up all usages of it
  * in the tree.
  */
-#define pci_module_init	pci_register_driver
+static inline __deprecated __must_check int pci_module_init(struct pci_driver *drv)
+{
+	int __must_check pci_register_driver(struct pci_driver *drv);
+
+	return pci_register_driver(drv);
+}
+
 
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
@@ -816,7 +818,7 @@ int pci_bus_alloc_resource(struct pci_bu
 void pci_enable_bridges(struct pci_bus *bus);
 
 /* New-style probing supporting hot-pluggable devices */
-int pci_register_driver(struct pci_driver *);
+int __must_check pci_register_driver(struct pci_driver *);
 void pci_unregister_driver(struct pci_driver *);
 void pci_remove_behind_bridge(struct pci_dev *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);
@@ -907,7 +909,7 @@ static inline void pci_disable_device(st
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
 static inline int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
-static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
+static inline int __must_check pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }


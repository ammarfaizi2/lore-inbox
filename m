Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbUJ0R42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbUJ0R42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUJ0Rxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:53:50 -0400
Received: from gprs214-134.eurotel.cz ([160.218.214.134]:60032 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262525AbUJ0RwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:52:02 -0400
Date: Wed, 27 Oct 2004 19:48:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Type checking for PCI layer
Message-ID: <20041027174831.GA21269@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There are way too many u32's near power managment, leading to all
sorts of bad problems. This adds typechecking for sparse, so that at
least checking compile warns about problems. I'm not sure if
PCI_D3cold should be included in this kind of states, but I was told
some drivers use it. Please apply,
								Pavel

--- clean/include/linux/pci.h	2004-10-01 00:30:30.000000000 +0200
+++ linux/include/linux/pci.h	2004-10-25 23:25:41.000000000 +0200
@@ -480,6 +480,14 @@
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
+typedef int __bitwise pci_power_t;
+
+#define PCI_D0	((pci_power_t __force) 0)
+#define PCI_D1	((pci_power_t __force) 1)
+#define PCI_D2	((pci_power_t __force) 2)
+#define PCI_D3hot	((pci_power_t __force) 3)
+#define PCI_D3cold	((pci_power_t __force) 4)
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -508,7 +516,7 @@
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
 
-	u32             current_state;  /* Current operating state. In ACPI-speak,
+	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
 
@@ -645,7 +653,7 @@
 	struct pci_dynids dynids;
 };
 
-#define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
+#define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
 
 /**
  * PCI_DEVICE - macro used to describe a specific pci device
@@ -781,8 +789,8 @@
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev, u32 *buffer);
 int pci_restore_state(struct pci_dev *dev, u32 *buffer);
-int pci_set_power_state(struct pci_dev *dev, int state);
-int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
+int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 void pci_bus_assign_resources(struct pci_bus *bus);
--- clean/drivers/pci/pci.c	2004-10-01 00:30:16.000000000 +0200
+++ linux/drivers/pci/pci.c	2004-10-25 23:24:37.000000000 +0200
@@ -242,7 +242,7 @@
  */
 
 int
-pci_set_power_state(struct pci_dev *dev, int state)
+pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	int pm;
 	u16 pmcsr;
@@ -422,7 +422,7 @@
  * 0 if operation is successful.
  * 
  */
-int pci_enable_wake(struct pci_dev *dev, u32 state, int enable)
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
 	int pm;
 	u16 value;

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbUKCVwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUKCVwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUKCVt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:49:56 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:12931 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261891AbUKCVr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:47:29 -0500
Date: Wed, 3 Nov 2004 22:47:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Subject: Type-checking for pci layer
Message-ID: <20041103214711.GA1885@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds type-checking to PCI layer. u32 has been replaced with
defines, so it is no longer easy to confuse it with system suspend
level. Patrick included it in his power tree, but I guess direct
merging to you (Andrew) is faster/easier way to go? Please apply,

								Pavel

Acked-by: Greg KH <greg@kroah.com>
Acked-by: Patrick Mochel

--- clean/include/linux/pci.h	2004-10-01 00:30:30.000000000 +0200
+++ linux/include/linux/pci.h	2004-11-01 21:24:17.000000000 +0100
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
@@ -508,7 +526,7 @@
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
 
-	u32             current_state;  /* Current operating state. In ACPI-speak,
+	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
 
@@ -645,7 +663,7 @@
 	struct pci_dynids dynids;
 };
 
-#define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
+#define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
 
 /**
  * PCI_DEVICE - macro used to describe a specific pci device
@@ -781,8 +799,8 @@
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

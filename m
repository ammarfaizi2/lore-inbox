Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbUK0DsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUK0DsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUK0Dr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:47:59 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262585AbUKZTeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:34:04 -0500
Date: Thu, 25 Nov 2004 12:36:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041125113631.GB1027@elf.ucw.cz>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124234057.GF4649@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > This is step 0 before adding type-safety to PCI layer... It introduces
> > > > constants and uses them to clean driver up. I'd like this to go in
> > > > now, so that I can convert drivers during 2.6.10... Please apply,
> > > 
> > > The tree is in "bugfix only" mode right now.  Changes like this need to
> > > wait for 2.6.10 to come out before I can send it upward.
> > > 
> > > So, care to hold on to it for a while?  Or I can add it to my "to apply
> > > after 2.6.10 comes out" tree, which will mean it will end up in the -mm
> > > releases till that happens.
> > 
> > I think I'd prefer visibility of "to apply after 2.6.10" tree... Thanks,
> 
> Care to resend this, I seem to have lost them :(

Okay, here it is, slightly expanded version. It actually makes use of
newly defined type for type-checking purposes; still no code changes.

								Pavel

--- clean/include/linux/pci.h	2004-10-01 00:30:30.000000000 +0200
+++ linux/include/linux/pci.h	2004-11-14 23:36:46.000000000 +0100
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
+++ linux/drivers/pci/pci.c	2004-11-14 23:36:46.000000000 +0100
@@ -229,7 +229,7 @@
 /**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to be suspended
- * @state: Power state we're entering
+ * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
  *
  * Transition a device to a new power state, using the Power Management 
  * Capabilities in the device's config space.
@@ -242,7 +242,7 @@
  */
 
 int
-pci_set_power_state(struct pci_dev *dev, int state)
+pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	int pm;
 	u16 pmcsr;
@@ -365,7 +389,7 @@
 {
 	int err;
 
-	pci_set_power_state(dev, 0);
+	pci_set_power_state(dev, PCI_D0);
 	if ((err = pcibios_enable_device(dev, bars)) < 0)
 		return err;
 	return 0;
@@ -422,7 +446,7 @@
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVAJRqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVAJRqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVAJRpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:45:41 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:15835 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262352AbVAJRVD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:03 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776574174@kroah.com>
Date: Mon, 10 Jan 2005 09:20:58 -0800
Message-Id: <11053776582@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.9, 2004/12/17 14:01:35-08:00, pavel@ucw.cz

[PATCH] PCI: Cleanup PCI power states

> > > > This is step 0 before adding type-safety to PCI layer... It introduces
> > > > constants and uses them to clean driver up. I'd like this to go in
> > > > now, so that I can convert drivers during 2.6.10... Please apply,

Okay, here it is, slightly expanded version. It actually makes use of
newly defined type for type-checking purposes; still no code changes.

From: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.c   |    8 ++++----
 include/linux/pci.h |   14 +++++++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2005-01-10 09:02:17 -08:00
+++ b/drivers/pci/pci.c	2005-01-10 09:02:17 -08:00
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
 	u16 pmcsr, pmc;
@@ -354,7 +354,7 @@
 {
 	int err;
 
-	pci_set_power_state(dev, 0);
+	pci_set_power_state(dev, PCI_D0);
 	if ((err = pcibios_enable_device(dev, bars)) < 0)
 		return err;
 	return 0;
@@ -428,7 +428,7 @@
  * 0 if operation is successful.
  * 
  */
-int pci_enable_wake(struct pci_dev *dev, u32 state, int enable)
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
 {
 	int pm;
 	u16 value;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-01-10 09:02:17 -08:00
+++ b/include/linux/pci.h	2005-01-10 09:02:17 -08:00
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
 
@@ -797,8 +805,8 @@
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev);
 int pci_restore_state(struct pci_dev *dev);
-int pci_set_power_state(struct pci_dev *dev, int state);
-int pci_enable_wake(struct pci_dev *dev, u32 state, int enable);
+int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 void pci_bus_assign_resources(struct pci_bus *bus);


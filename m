Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbUKIIuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUKIIuU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 03:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbUKIIuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 03:50:20 -0500
Received: from fmr12.intel.com ([134.134.136.15]:21698 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261449AbUKIIrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 03:47:37 -0500
Subject: acpi_pci_irq_enable (RE: 2.6.9-rc2-mm1)
From: Len Brown <len.brown@intel.com>
To: Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Jesse Barnes <jbarnes@sgi.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1095403811.2046.51.camel@d845pe>
References: <452548B29F0CCE48B8ABB094307EBA1C0651E9A9@USRV-EXCH2.na.uis.unisys.com>
	 <1095403811.2046.51.camel@d845pe>
Content-Type: multipart/mixed; boundary="=-Yvfd6kjnpXj2lWceW9o7"
Organization: 
Message-Id: <1099990045.6091.110.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Nov 2004 03:47:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Yvfd6kjnpXj2lWceW9o7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-09-17 at 02:50, Len Brown wrote:
> On Fri, 2004-09-17 at 01:18, Protasevich, Natalie wrote:
> > > On Thursday 16 September 2004 11:14 am, Jesse Barnes wrote:
> > > > On Thursday, September 16, 2004 2:40 am, Andrew Morton wrote:
> > > >  bk-acpi.patch
> > > >
> > > > Looks like some changes in this patch break sn2.  In particular,
> > this
> > > > hunk in acpi_pci_irq_enable():
> > > >
> > > > -                       return_VALUE(0);
> > > > +                       return_VALUE(-EINVAL);
> > > > 

> I think the patch has pointed out that this routine really should be returning 0
> for success and non zero for failure; and returning dev->irq was
> probably a latent bug all along.

Jesse,
I think this one is correct, please let me know if you have any trouble
with it.

thanks,
-Len



--=-Yvfd6kjnpXj2lWceW9o7
Content-Disposition: attachment; filename=irq0.patch
Content-Type: text/plain; name=irq0.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/09 03:08:42-05:00 len.brown@intel.com 
#   [ACPI] acpi_pci_irq_enable() now returns 0 on success.
#   This bubbles all the way up to pci_enable_device().
#   This allows IRQ0 to be used as a legal PCI device IRQ.
#   
#   The ES7000 uses an interrupt source override to assign pin20 to IRQ0.
#   Then platform_rename_gsi assigns pin0 a high-numbered IRQ -- available
#   for PCI devices.  But IRQ0 needs to be a legal PCI IRQ in the lookup code
#   to make it as far as the re-name code. 
#   
#   Signed-off-by: Natalie Protasevich <Natalie.Protasevich@UNISYS.com>
#   Signed-off-by: Len Brown <len.brown@intel.com>
# 
# drivers/acpi/pci_link.c
#   2004/11/09 03:08:36-05:00 len.brown@intel.com +10 -5
#   Import patch irq0_checks3.patch
# 
# drivers/acpi/pci_irq.c
#   2004/11/09 03:08:36-05:00 len.brown@intel.com +28 -13
#   Import patch irq0_checks3.patch
# 
diff -Nru a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c	2004-11-09 03:45:33 -05:00
+++ b/drivers/acpi/pci_irq.c	2004-11-09 03:45:33 -05:00
@@ -227,6 +227,11 @@
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
 
+/*
+ * acpi_pci_irq_lookup
+ * success: return IRQ >= 0
+ * failure: return -1
+ */
 static int
 acpi_pci_irq_lookup (
 	struct pci_bus		*bus,
@@ -249,14 +254,14 @@
 	entry = acpi_pci_irq_find_prt_entry(segment, bus_nr, device, pin); 
 	if (!entry) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PRT entry not found\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 	
 	if (entry->link.handle) {
 		irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, edge_level, active_high_low);
-		if (!irq) {
+		if (irq < 0) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
-			return_VALUE(0);
+			return_VALUE(-1);
 		}
 	} else {
 		irq = entry->link.index;
@@ -269,6 +274,11 @@
 	return_VALUE(irq);
 }
 
+/*
+ * acpi_pci_irq_derive
+ * success: return IRQ >= 0
+ * failure: return < 0
+ */
 static int
 acpi_pci_irq_derive (
 	struct pci_dev		*dev,
@@ -277,7 +287,7 @@
 	int			*active_high_low)
 {
 	struct pci_dev		*bridge = dev;
-	int			irq = 0;
+	int			irq = -1;
 	u8			bridge_pin = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_derive");
@@ -289,7 +299,7 @@
 	 * Attempt to derive an IRQ for this device from a parent bridge's
 	 * PCI interrupt routing entry (eg. yenta bridge and add-in card bridge).
 	 */
-	while (!irq && bridge->bus->self) {
+	while (irq < 0 && bridge->bus->self) {
 		pin = (pin + PCI_SLOT(bridge->devfn)) % 4;
 		bridge = bridge->bus->self;
 
@@ -299,7 +309,7 @@
 			if (!bridge_pin) {
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 					"No interrupt pin configured for device %s\n", pci_name(bridge)));
-				return_VALUE(0);
+				return_VALUE(-1);
 			}
 			/* Pin is from 0 to 3 */
 			bridge_pin --;
@@ -310,9 +320,9 @@
 			pin, edge_level, active_high_low);
 	}
 
-	if (!irq) {
+	if (irq < 0) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Unable to derive IRQ for device %s\n", pci_name(dev)));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Derive IRQ %d for device %s from %s\n",
@@ -321,6 +331,11 @@
 	return_VALUE(irq);
 }
 
+/*
+ * acpi_pci_irq_enable
+ * success: return 0
+ * failure: return < 0
+ */
 
 int
 acpi_pci_irq_enable (
@@ -358,20 +373,20 @@
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
-	if (!irq)
+	if (irq < 0)
  		irq = acpi_pci_irq_derive(dev, pin, &edge_level, &active_high_low);
  
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
 	 * driver reported one, then use it. Exit in any case.
 	 */
-	if (!irq) {
+	if (irq < 0) {
 		printk(KERN_WARNING PREFIX "PCI interrupt %s[%c]: no GSI",
 			pci_name(dev), ('A' + pin));
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq && (dev->irq <= 0xF)) {
+		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
-			return_VALUE(dev->irq);
+			return_VALUE(0);
 		}
 		else {
 			printk("\n");
@@ -388,5 +403,5 @@
 		(active_high_low == ACPI_ACTIVE_LOW) ? "low" : "high",
 		dev->irq);
 
-	return_VALUE(dev->irq);
+	return_VALUE(0);
 }
diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c	2004-11-09 03:45:33 -05:00
+++ b/drivers/acpi/pci_link.c	2004-11-09 03:45:33 -05:00
@@ -577,6 +577,11 @@
 	return_VALUE(0);
 }
 
+/*
+ * acpi_pci_link_get_irq
+ * success: return IRQ >= 0
+ * failure: return -1
+ */
 
 int
 acpi_pci_link_get_irq (
@@ -594,27 +599,27 @@
 	result = acpi_bus_get_device(handle, &device);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link device\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	link = (struct acpi_pci_link *) acpi_driver_data(device);
 	if (!link) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	/* TBD: Support multiple index (IRQ) entries per Link Device */
 	if (index) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid index %d\n", index));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	if (acpi_pci_link_allocate(link))
-		return_VALUE(0);
+		return_VALUE(-1);
 	   
 	if (!link->irq.active) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link active IRQ is 0!\n"));
-		return_VALUE(0);
+		return_VALUE(-1);
 	}
 
 	if (edge_level) *edge_level = link->irq.edge_level;

--=-Yvfd6kjnpXj2lWceW9o7--


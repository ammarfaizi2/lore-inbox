Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267407AbSKPXlD>; Sat, 16 Nov 2002 18:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267410AbSKPXlD>; Sat, 16 Nov 2002 18:41:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29203 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267407AbSKPXkq>;
	Sat, 16 Nov 2002 18:40:46 -0500
Date: Sat, 16 Nov 2002 23:47:39 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <willy@debian.org>,
       linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] eliminate pci_dev name
Message-ID: <20021116234739.T20070@parcelfarce.linux.theplanet.co.uk>
References: <3DD3EB3D.8050606@pobox.com> <Pine.LNX.4.44.0211141031500.3323-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211141031500.3323-100000@home.transmeta.com>; from torvalds@transmeta.com on Thu, Nov 14, 2002 at 10:36:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 10:36:03AM -0800, Linus Torvalds wrote:
> Actually, I think we should do the reverse (for testing), and make the
> name be something small like 8 bytes, and make sure that everybody who
> writes the name uses strncpy()  and snprintf() instead of just blindly
> writing whatever is in the database.
> 
> Otherwise we'll always end up having fragile magic constants.
> 
> Anybody willing to do that cleanup?

I've done something slightly different.  I've trimmed it down to 50 bytes
and limited the length of the vendor & device descriptions to 20 bytes each.
Now we have three cases:

unknown vendor & unknown device -> "PCI device %04x:%04x".
	Clearly limited to 21 chars.
known vendor, unknown device -> "PCI device %04x:%04x (%.20s)"
	24 + 20 chars
known vendor, known device -> "%.20s %.20s"
	20 + 1 + 20 + 1, EXCEPT:
multiple devices of the same type add " (#%d)"
	so 42 + 4 + 4 = 50.  This is the point where an IBMer tells me they
	intend to sell a machine with > 9999 PCI devices of the same type ;-)

Yeah, I could have done what you asked for, but that looks like needless
additional paranoia to me.  This limits the PCI IDs to a reasonable amount
of space.

For release, I think we do want to go back up to 80.  Here's /proc/pci on
cl009 at osdl:

root@cl009:~# cat /proc/pci |grep '^    [^ ]'
    Host bridge: ServerWorks CNB20LE Host Bridge (rev 5).
    Host bridge: ServerWorks CNB20LE Host Bridge (#2) (rev 5).
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet  (rev 8).
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet  (#2) (rev 8).
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 101).
    ISA bridge: ServerWorks OSB4 South Bridge (rev 79).
    IDE interface: ServerWorks OSB4 IDE Controller (rev 0).
    USB Controller: ServerWorks OSB4/CSB5 USB Contro (rev 4).
    SCSI storage controller: LSI Logic / Symbios  53c896 (rev 7).
    SCSI storage controller: LSI Logic / Symbios  53c896 (#2) (rev 7).

It's usable, but ugly.

Here's the patch:

diff -urpNX dontdiff linux-2.5.47/drivers/net/eepro100.c linux-2.5.47-pci/drivers/net/eepro100.c
--- linux-2.5.47/drivers/net/eepro100.c	2002-10-31 11:23:22.000000000 -0500
+++ linux-2.5.47-pci/drivers/net/eepro100.c	2002-11-16 16:16:51.000000000 -0500
@@ -734,7 +734,7 @@ static int __devinit speedo_found1(struc
 	if (eeprom[3] & 0x0100)
 		product = "OEM i82557/i82558 10/100 Ethernet";
 	else
-		product = pdev->name;
+		product = pdev->dev.name;
 
 	printk(KERN_INFO "%s: %s, ", dev->name, product);
 
diff -urpNX dontdiff linux-2.5.47/drivers/pci/names.c linux-2.5.47-pci/drivers/pci/names.c
--- linux-2.5.47/drivers/pci/names.c	2002-10-01 03:06:17.000000000 -0400
+++ linux-2.5.47-pci/drivers/pci/names.c	2002-11-16 17:54:29.000000000 -0500
@@ -56,7 +56,7 @@ void __devinit pci_name_device(struct pc
 {
 	const struct pci_vendor_info *vendor_p = pci_vendor_list;
 	int i = VENDORS;
-	char *name = dev->name;
+	char *name = dev->dev.name;
 
 	do {
 		if (vendor_p->vendor == dev->vendor)
@@ -80,12 +80,15 @@ void __devinit pci_name_device(struct pc
 		}
 
 		/* Ok, found the vendor, but unknown device */
-		sprintf(name, "PCI device %04x:%04x (%s)", dev->vendor, dev->device, vendor_p->name);
+		sprintf(name, "PCI device %04x:%04x (%." DEVICE_NAME_HALF "s)",
+				dev->vendor, dev->device, vendor_p->name);
 		return;
 
 		/* Full match */
 		match_device: {
-			char *n = name + sprintf(name, "%s %s", vendor_p->name, device_p->name);
+			char *n = name + sprintf(name, "%." DEVICE_NAME_HALF
+					"s %." DEVICE_NAME_HALF "s",
+					vendor_p->name, device_p->name);
 			int nr = device_p->seen + 1;
 			device_p->seen = nr;
 			if (nr > 1)
diff -urpNX dontdiff linux-2.5.47/drivers/pci/probe.c linux-2.5.47-pci/drivers/pci/probe.c
--- linux-2.5.47/drivers/pci/probe.c	2002-11-14 10:52:13.000000000 -0500
+++ linux-2.5.47-pci/drivers/pci/probe.c	2002-11-16 10:39:22.000000000 -0500
@@ -52,7 +52,7 @@ static void pci_read_bases(struct pci_de
 	for(pos=0; pos<howmany; pos = next) {
 		next = pos+1;
 		res = &dev->resource[pos];
-		res->name = dev->name;
+		res->name = dev->dev.name;
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
 		pci_read_config_dword(dev, reg, &l);
 		pci_write_config_dword(dev, reg, ~0);
@@ -112,7 +112,7 @@ static void pci_read_bases(struct pci_de
 			sz = pci_size(sz, PCI_ROM_ADDRESS_MASK);
 			res->end = res->start + (unsigned long) sz;
 		}
-		res->name = dev->name;
+		res->name = dev->dev.name;
 	}
 }
 
@@ -129,7 +129,7 @@ void __devinit pci_read_bridge_bases(str
 		return;
 
 	if (dev->transparent) {
-		printk("Transparent bridge - %s\n", dev->name);
+		printk("Transparent bridge - %s\n", dev->dev.name);
 		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
 			child->resource[i] = child->parent->resource[i];
 		return;
@@ -355,7 +355,7 @@ int pci_setup_device(struct pci_dev * de
 	u32 class;
 
 	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	sprintf(dev->name, "PCI device %04x:%04x", dev->vendor, dev->device);
+	sprintf(dev->dev.name, "PCI device %04x:%04x", dev->vendor, dev->device);
 	INIT_LIST_HEAD(&dev->pools);
 	
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
@@ -447,7 +447,6 @@ struct pci_dev * __devinit pci_scan_devi
 	pci_name_device(dev);
 
 	/* now put in global tree */
-	strcpy(dev->dev.name,dev->name);
 	strcpy(dev->dev.bus_id,dev->slot_name);
 
 	device_register(&dev->dev);
diff -urpNX dontdiff linux-2.5.47/drivers/pci/proc.c linux-2.5.47-pci/drivers/pci/proc.c
--- linux-2.5.47/drivers/pci/proc.c	2002-10-01 03:07:05.000000000 -0400
+++ linux-2.5.47-pci/drivers/pci/proc.c	2002-11-16 10:40:04.000000000 -0500
@@ -511,7 +511,7 @@ static int show_dev_config(struct seq_fi
 		seq_printf(m, "    %s", class);
 	else
 		seq_printf(m, "    Class %04x", class_rev >> 16);
-	seq_printf(m, ": %s (rev %d).\n", dev->name, class_rev & 0xff);
+	seq_printf(m, ": %s (rev %d).\n", dev->dev.name, class_rev & 0xff);
 
 	if (dev->irq)
 		seq_printf(m, "      IRQ %d.\n", dev->irq);
diff -urpNX dontdiff linux-2.5.47/drivers/pci/quirks.c linux-2.5.47-pci/drivers/pci/quirks.c
--- linux-2.5.47/drivers/pci/quirks.c	2002-11-14 10:52:13.000000000 -0500
+++ linux-2.5.47-pci/drivers/pci/quirks.c	2002-11-16 10:40:24.000000000 -0500
@@ -203,7 +203,7 @@ static void __devinit quirk_io_region(st
 	if (region) {
 		struct resource *res = dev->resource + nr;
 
-		res->name = dev->name;
+		res->name = dev->dev.name;
 		res->start = region;
 		res->end = region + size - 1;
 		res->flags = IORESOURCE_IO;
diff -urpNX dontdiff linux-2.5.47/drivers/pci/setup-irq.c linux-2.5.47-pci/drivers/pci/setup-irq.c
--- linux-2.5.47/drivers/pci/setup-irq.c	2002-10-01 03:06:59.000000000 -0400
+++ linux-2.5.47-pci/drivers/pci/setup-irq.c	2002-11-16 10:41:53.000000000 -0500
@@ -53,7 +53,7 @@ pdev_fixup_irq(struct pci_dev *dev,
 		irq = 0;
 	dev->irq = irq;
 
-	DBGC((KERN_ERR "PCI fixup irq: (%s) got %d\n", dev->name, dev->irq));
+	DBGC((KERN_ERR "PCI fixup irq: (%s) got %d\n", dev->dev.name, dev->irq));
 
 	/* Always tell the device, so the driver knows what is
 	   the real IRQ to use; the device does not use it. */
diff -urpNX dontdiff linux-2.5.47/drivers/pci/setup-res.c linux-2.5.47-pci/drivers/pci/setup-res.c
--- linux-2.5.47/drivers/pci/setup-res.c	2002-10-01 03:07:36.000000000 -0400
+++ linux-2.5.47-pci/drivers/pci/setup-res.c	2002-11-16 10:41:43.000000000 -0500
@@ -46,11 +46,11 @@ pci_claim_resource(struct pci_dev *dev, 
 		if (err) {
 			printk(KERN_ERR "PCI: Address space collision on "
 			       "region %d of device %s [%lx:%lx]\n",
-			       resource, dev->name, res->start, res->end);
+			       resource, dev->dev.name, res->start, res->end);
 		}
 	} else {
 		printk(KERN_ERR "PCI: No parent found for region %d "
-		       "of device %s\n", resource, dev->name);
+		       "of device %s\n", resource, dev->dev.name);
 	}
 
 	return err;
@@ -155,7 +155,7 @@ pdev_sort_resources(struct pci_dev *dev,
 		if (!r_align) {
 			printk(KERN_WARNING "PCI: Ignore bogus resource %d "
 					    "[%lx:%lx] of %s\n",
-					    i, r->start, r->end, dev->name);
+					    i, r->start, r->end, dev->dev.name);
 			continue;
 		}
 		r_align = (i < PCI_BRIDGE_RESOURCES) ? r_align + 1 : r->start;
diff -urpNX dontdiff linux-2.5.47/drivers/pcmcia/cardbus.c linux-2.5.47-pci/drivers/pcmcia/cardbus.c
--- linux-2.5.47/drivers/pcmcia/cardbus.c	2002-11-14 10:52:13.000000000 -0500
+++ linux-2.5.47-pci/drivers/pcmcia/cardbus.c	2002-11-16 10:42:05.000000000 -0500
@@ -284,7 +284,6 @@ int cb_alloc(socket_info_t * s)
 
 		pci_setup_device(dev);
 
-		strcpy(dev->dev.name, dev->name);
 		strcpy(dev->dev.bus_id, dev->slot_name);
 
 		/* FIXME: Do we need to enable the expansion ROM? */
diff -urpNX dontdiff linux-2.5.47/drivers/pcmcia/yenta.c linux-2.5.47-pci/drivers/pcmcia/yenta.c
--- linux-2.5.47/drivers/pcmcia/yenta.c	2002-10-15 09:32:33.000000000 -0400
+++ linux-2.5.47-pci/drivers/pcmcia/yenta.c	2002-11-16 10:42:55.000000000 -0500
@@ -585,7 +585,7 @@ static void yenta_open_bh(void * data)
 	/* It's OK to overwrite this now */
 	INIT_WORK(&socket->tq_task, yenta_bh, socket);
 
-	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->name, socket)) {
+	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->dev.name, socket)) {
 		/* No IRQ or request_irq failed. Poll */
 		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
 		socket->poll_timer.function = yenta_interrupt_wrapper;
diff -urpNX dontdiff linux-2.5.47/drivers/usb/core/hcd-pci.c linux-2.5.47-pci/drivers/usb/core/hcd-pci.c
--- linux-2.5.47/drivers/usb/core/hcd-pci.c	2002-10-16 08:34:38.000000000 -0400
+++ linux-2.5.47-pci/drivers/usb/core/hcd-pci.c	2002-11-16 10:43:30.000000000 -0500
@@ -137,7 +137,7 @@ clean_2:
 	hcd->description = driver->description;
 	hcd->pdev = dev;
 	hcd->self.bus_name = dev->slot_name;
-	hcd->product_desc = dev->name;
+	hcd->product_desc = dev->dev.name;
 
 	if ((retval = hcd_buffer_create (hcd)) != 0) {
 clean_3:
@@ -145,7 +145,7 @@ clean_3:
 		goto clean_2;
 	}
 
-	info ("%s @ %s, %s", hcd->description,  dev->slot_name, dev->name);
+	info ("%s @ %s, %s", hcd->description,  dev->slot_name, dev->dev.name);
 
 #ifndef __sparc__
 	sprintf (buf, "%d", dev->irq);
diff -urpNX dontdiff linux-2.5.47/include/linux/device.h linux-2.5.47-pci/include/linux/device.h
--- linux-2.5.47/include/linux/device.h	2002-11-05 09:16:05.000000000 -0500
+++ linux-2.5.47-pci/include/linux/device.h	2002-11-16 11:01:39.000000000 -0500
@@ -23,14 +23,17 @@
 #ifndef _DEVICE_H_
 #define _DEVICE_H_
 
-#include <linux/types.h>
 #include <linux/config.h>
 #include <linux/ioport.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/sched.h>
-#include <linux/kobject.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <asm/atomic.h>
 
-#define DEVICE_NAME_SIZE	80
+#define DEVICE_NAME_SIZE	50
+#define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
 #define DEVICE_ID_SIZE		32
 #define BUS_ID_SIZE		16
 
diff -urpNX dontdiff linux-2.5.47/include/linux/pci.h linux-2.5.47-pci/include/linux/pci.h
--- linux-2.5.47/include/linux/pci.h	2002-11-14 10:52:17.000000000 -0500
+++ linux-2.5.47-pci/include/linux/pci.h	2002-11-16 10:43:44.000000000 -0500
@@ -371,7 +371,6 @@ struct pci_dev {
 	struct resource dma_resource[DEVICE_COUNT_DMA];
 	struct resource irq_resource[DEVICE_COUNT_IRQ];
 
-	char		name[90];	/* device name */
 	char		slot_name[8];	/* slot name */
 	int		active;		/* ISAPnP: device is active */
 	int		ro;		/* ISAPnP: read only */

-- 
Revolutions do not require corporate support.

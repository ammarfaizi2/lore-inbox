Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVAHGHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVAHGHf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVAHGGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:06:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:20101 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261805AbVAHFr6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:58 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632683808@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:48 -0800
Message-Id: <11051632682199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.40, 2004/12/20 14:17:44-08:00, stern@rowland.harvard.edu

[PATCH] USB: Create usb_hcd structures within usbcore [1/13]

This patch changes the usbcore routines, making them fully responsible for
the entire lifecycle of each usb_hcd.  It also splits up registration of
the USB host class_device into an _init and an _add phase, to match the
initialization and registration of the USB bus belonging to the host.


Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/hcd-pci.c |   21 +++-------------
 drivers/usb/core/hcd.c     |   59 ++++++++++++++++++++++++++++++++++++---------
 drivers/usb/core/hcd.h     |   27 +++++++++-----------
 3 files changed, 66 insertions(+), 41 deletions(-)


diff -Nru a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
--- a/drivers/usb/core/hcd-pci.c	2005-01-07 15:44:04 -08:00
+++ b/drivers/usb/core/hcd-pci.c	2005-01-07 15:44:04 -08:00
@@ -124,7 +124,7 @@
 	// driver->reset(), later on, will transfer device from
 	// control by SMM/BIOS to control by Linux (if needed)
 
-	hcd = driver->hcd_alloc ();
+	hcd = usb_create_hcd (driver);
 	if (hcd == NULL){
 		dev_dbg (&dev->dev, "hcd alloc fail\n");
 		retval = -ENOMEM;
@@ -144,20 +144,16 @@
 	hcd->region = region;
 
 	pci_set_drvdata (dev, hcd);
-	hcd->driver = driver;
-	hcd->description = driver->description;
 	hcd->self.bus_name = pci_name(dev);
 #ifdef CONFIG_PCI_NAMES
 	hcd->product_desc = dev->pretty_name;
-#else
-	if (hcd->product_desc == NULL)
-		hcd->product_desc = "USB Host Controller";
 #endif
 	hcd->self.controller = &dev->dev;
 
 	if ((retval = hcd_buffer_create (hcd)) != 0) {
 clean_3:
-		kfree (hcd);
+		pci_set_drvdata (dev, NULL);
+		usb_put_hcd (hcd);
 		goto clean_2;
 	}
 
@@ -168,7 +164,6 @@
 		dev_err (hcd->self.controller, "can't reset\n");
 		goto clean_3;
 	}
-	hcd->state = USB_STATE_HALT;
 
 	pci_set_master (dev);
 #ifndef __sparc__
@@ -177,7 +172,7 @@
 	bufp = __irq_itoa(dev->irq);
 #endif
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
-				hcd->description, hcd);
+				hcd->driver->description, hcd);
 	if (retval != 0) {
 		dev_err (hcd->self.controller,
 				"request interrupt %s failed\n", bufp);
@@ -189,12 +184,6 @@
 		(driver->flags & HCD_MEMORY) ? "pci mem" : "io base",
 		resource);
 
-	usb_bus_init (&hcd->self);
-	hcd->self.op = &usb_hcd_operations;
-	hcd->self.release = &usb_hcd_release;
-	hcd->self.hcpriv = (void *) hcd;
-	init_timer (&hcd->rh_timer);
-
 	usb_register_bus (&hcd->self);
 
 	if ((retval = driver->start (hcd)) < 0) {
@@ -409,7 +398,7 @@
 		pci_set_power_state (dev, 0);
 	dev->dev.power.power_state = 0;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
-				hcd->description, hcd);
+				hcd->driver->description, hcd);
 	if (retval < 0) {
 		dev_err (hcd->self.controller,
 			"can't restore IRQ after resume!\n");
diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	2005-01-07 15:44:04 -08:00
+++ b/drivers/usb/core/hcd.c	2005-01-07 15:44:04 -08:00
@@ -312,7 +312,7 @@
  	// id 3 == vendor description
 	} else if (id == 3) {
                 sprintf (buf, "%s %s %s", UTS_SYSNAME, UTS_RELEASE,
-			hcd->description);
+			hcd->driver->description);
 
 	// unsupported IDs --> "protocol stall"
 	} else
@@ -676,6 +676,8 @@
 	bus->bandwidth_isoc_reqs = 0;
 
 	INIT_LIST_HEAD (&bus->bus_list);
+
+	class_device_initialize(&bus->class_dev);
 }
 EXPORT_SYMBOL (usb_bus_init);
 
@@ -734,7 +736,7 @@
 	snprintf(bus->class_dev.class_id, BUS_ID_SIZE, "usb%d", busnum);
 	bus->class_dev.class = &usb_host_class;
 	bus->class_dev.dev = bus->controller;
-	retval = class_device_register(&bus->class_dev);
+	retval = class_device_add(&bus->class_dev);
 	if (retval) {
 		clear_bit(busnum, busmap.busmap);
 		up(&usb_bus_list_lock);
@@ -1430,12 +1432,8 @@
 
 /*
  * usb_hcd_operations - adapts usb_bus framework to HCD framework (bus glue)
- *
- * When registering a USB bus through the HCD framework code, use this
- * usb_operations vector.  The PCI glue layer does so automatically; only
- * bus glue for non-PCI system busses will need to use this.
  */
-struct usb_operations usb_hcd_operations = {
+static struct usb_operations usb_hcd_operations = {
 	.get_frame_number =	hcd_get_frame_number,
 	.submit_urb =		hcd_submit_urb,
 	.unlink_urb =		hcd_unlink_urb,
@@ -1447,7 +1445,6 @@
 	.hub_resume =		hcd_hub_resume,
 #endif
 };
-EXPORT_SYMBOL (usb_hcd_operations);
 
 /*-------------------------------------------------------------------------*/
 
@@ -1549,11 +1546,51 @@
 
 /*-------------------------------------------------------------------------*/
 
-void usb_hcd_release(struct usb_bus *bus)
+static void hcd_release (struct usb_bus *bus)
 {
 	struct usb_hcd *hcd;
 
-	hcd = container_of (bus, struct usb_hcd, self);
+	hcd = container_of(bus, struct usb_hcd, self);
 	kfree(hcd);
 }
-EXPORT_SYMBOL (usb_hcd_release);
+
+/**
+ * usb_create_hcd - create and initialize an HCD structure
+ * @driver: HC driver that will use this hcd
+ * Context: !in_interrupt()
+ *
+ * Allocate a struct usb_hcd, with extra space at the end for the
+ * HC driver's private data.  Initialize the generic members of the
+ * hcd structure.
+ *
+ * If memory is unavailable, returns NULL.
+ */
+struct usb_hcd *usb_create_hcd (const struct hc_driver *driver)
+{
+	struct usb_hcd *hcd;
+
+	hcd = kcalloc(1, sizeof(*hcd) + driver->hcd_priv_size, GFP_KERNEL);
+	if (!hcd)
+		return NULL;
+
+	usb_bus_init(&hcd->self);
+	hcd->self.op = &usb_hcd_operations;
+	hcd->self.hcpriv = hcd;
+	hcd->self.release = &hcd_release;
+
+	init_timer(&hcd->rh_timer);
+
+	hcd->driver = driver;
+	hcd->product_desc = (driver->product_desc) ? driver->product_desc :
+			"USB Host Controller";
+	hcd->state = USB_STATE_HALT;
+
+	return hcd;
+}
+EXPORT_SYMBOL (usb_create_hcd);
+
+void usb_put_hcd (struct usb_hcd *hcd)
+{
+	usb_bus_put(&hcd->self);
+}
+EXPORT_SYMBOL (usb_put_hcd);
diff -Nru a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
--- a/drivers/usb/core/hcd.h	2005-01-07 15:44:04 -08:00
+++ b/drivers/usb/core/hcd.h	2005-01-07 15:44:04 -08:00
@@ -63,14 +63,13 @@
 	struct usb_bus		self;		/* hcd is-a bus */
 
 	const char		*product_desc;	/* product/vendor string */
-	const char		*description;	/* "ehci-hcd" etc */
 
 	struct timer_list	rh_timer;	/* drives root hub */
 
 	/*
 	 * hardware info/state
 	 */
-	struct hc_driver	*driver;	/* hw-specific hooks */
+	const struct hc_driver	*driver;	/* hw-specific hooks */
 	unsigned		saw_irq : 1;
 	unsigned		can_wakeup:1;	/* hw supports wakeup? */
 	unsigned		remote_wakeup:1;/* sw should use wakeup? */
@@ -103,6 +102,12 @@
 	 * input size of periodic table to an interrupt scheduler. 
 	 * (ohci 32, uhci 1024, ehci 256/512/1024).
 	 */
+
+	/* The HC driver's private data is stored at the end of
+	 * this structure.
+	 */
+	unsigned long hcd_priv[0]
+			__attribute__ ((aligned (sizeof(unsigned long))));
 };
 
 /* 2.4 does this a bit differently ... */
@@ -152,6 +157,8 @@
 
 struct hc_driver {
 	const char	*description;	/* "ehci-hcd" etc */
+	const char	*product_desc;	/* product/vendor string */
+	size_t		hcd_priv_size;	/* size of private data */
 
 	/* irq handler */
 	irqreturn_t	(*irq) (struct usb_hcd *hcd, struct pt_regs *regs);
@@ -180,15 +187,6 @@
 	/* return current frame number */
 	int	(*get_frame_number) (struct usb_hcd *hcd);
 
-	/* memory lifecycle */
-	/* Note: The absence of hcd_free reflects a temporary situation;
-	 * in the near future hcd_alloc will disappear as well and all
-	 * allocations/deallocations will be handled by usbcore.  For the
-	 * moment, drivers are required to return a pointer that the core
-	 * can pass to kfree, i.e., the struct usb_hcd must be the _first_
-	 * member of a larger driver-specific structure. */
-	struct usb_hcd	*(*hcd_alloc) (void);
-
 	/* manage i/o requests, device state */
 	int	(*urb_enqueue) (struct usb_hcd *hcd,
 					struct usb_host_endpoint *ep,
@@ -213,6 +211,10 @@
 extern void usb_hcd_giveback_urb (struct usb_hcd *hcd, struct urb *urb, struct pt_regs *regs);
 extern void usb_bus_init (struct usb_bus *bus);
 
+extern struct usb_hcd *usb_create_hcd (const struct hc_driver *driver);
+extern void usb_put_hcd (struct usb_hcd *hcd);
+
+
 #ifdef CONFIG_PCI
 struct pci_dev;
 struct pci_device_id;
@@ -237,7 +239,6 @@
 	void *addr, dma_addr_t dma);
 
 /* generic bus glue, needed for host controllers that don't use PCI */
-extern struct usb_operations usb_hcd_operations;
 extern irqreturn_t usb_hcd_irq (int irq, void *__hcd, struct pt_regs *r);
 extern void usb_hc_died (struct usb_hcd *hcd);
 
@@ -356,8 +357,6 @@
 
 	return usb_register_root_hub (usb_dev, hcd->self.controller);
 }
-
-extern void usb_hcd_release (struct usb_bus *);
 
 extern void usb_set_device_state(struct usb_device *udev,
 		enum usb_device_state new_state);


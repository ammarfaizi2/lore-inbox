Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVFUELE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVFUELE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVFUCn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:43:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:24036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261686AbVFTW7n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:43 -0400
Cc: gregkh@suse.de
Subject: [PATCH] USB: move the usb hcd code to use the new class code.
In-Reply-To: <11193083622806@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:22 -0700
Message-Id: <11193083623136@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] USB: move the usb hcd code to use the new class code.

This moves a kref into the main hcd structure, which detaches it from
the class device structure.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8561b10f6e7ef0a085709ffc844f74130a067abe
tree b25d023ce2d7397081735d20fd0c11ebdfcd603c
parent 1235686f6e67cf30c460eb77d90a6cb4be57b92f
author gregkh@suse.de <gregkh@suse.de> Tue, 15 Mar 2005 15:10:13 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:07 -0700

 drivers/usb/core/hcd.c      |   61 +++++++++++++++++++------------------------
 drivers/usb/host/ehci-dbg.c |   10 ++++---
 drivers/usb/host/ohci-dbg.c |   10 ++++---
 include/linux/usb.h         |    5 +---
 4 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -651,50 +651,45 @@ static int usb_rh_urb_dequeue (struct us
 /*-------------------------------------------------------------------------*/
 
 /* exported only within usbcore */
-struct usb_bus *usb_bus_get (struct usb_bus *bus)
+struct usb_bus *usb_bus_get(struct usb_bus *bus)
 {
-	struct class_device *tmp;
+	if (bus)
+		kref_get(&bus->kref);
+	return bus;
+}
 
-	if (!bus)
-		return NULL;
+static void usb_host_release(struct kref *kref)
+{
+	struct usb_bus *bus = container_of(kref, struct usb_bus, kref);
 
-	tmp = class_device_get(&bus->class_dev);
-	if (tmp)        
-		return to_usb_bus(tmp);
-	else
-		return NULL;
+	if (bus->release)
+		bus->release(bus);
 }
 
 /* exported only within usbcore */
-void usb_bus_put (struct usb_bus *bus)
+void usb_bus_put(struct usb_bus *bus)
 {
 	if (bus)
-		class_device_put(&bus->class_dev);
+		kref_put(&bus->kref, usb_host_release);
 }
 
 /*-------------------------------------------------------------------------*/
 
-static void usb_host_release(struct class_device *class_dev)
-{
-	struct usb_bus *bus = to_usb_bus(class_dev);
-
-	if (bus->release)
-		bus->release(bus);
-}
-
-static struct class usb_host_class = {
-	.name		= "usb_host",
-	.release	= &usb_host_release,
-};
+static struct class *usb_host_class;
 
 int usb_host_init(void)
 {
-	return class_register(&usb_host_class);
+	int retval = 0;
+
+	usb_host_class = class_create(THIS_MODULE, "usb_host");
+	if (IS_ERR(usb_host_class))
+		retval = PTR_ERR(usb_host_class);
+	return retval;
 }
 
 void usb_host_cleanup(void)
 {
-	class_unregister(&usb_host_class);
+	class_destroy(usb_host_class);
 }
 
 /**
@@ -719,8 +714,7 @@ static void usb_bus_init (struct usb_bus
 
 	INIT_LIST_HEAD (&bus->bus_list);
 
-	class_device_initialize(&bus->class_dev);
-	bus->class_dev.class = &usb_host_class;
+	kref_init(&bus->kref);
 }
 
 /**
@@ -761,7 +755,6 @@ struct usb_bus *usb_alloc_bus (struct us
 static int usb_register_bus(struct usb_bus *bus)
 {
 	int busnum;
-	int retval;
 
 	down (&usb_bus_list_lock);
 	busnum = find_next_zero_bit (busmap.busmap, USB_MAXBUS, 1);
@@ -774,15 +767,15 @@ static int usb_register_bus(struct usb_b
 		return -E2BIG;
 	}
 
-	snprintf(bus->class_dev.class_id, BUS_ID_SIZE, "usb%d", busnum);
-	bus->class_dev.dev = bus->controller;
-	retval = class_device_add(&bus->class_dev);
-	if (retval) {
+	bus->class_dev = class_device_create(usb_host_class, MKDEV(0,0), bus->controller, "usb%d", busnum);
+	if (IS_ERR(bus->class_dev)) {
 		clear_bit(busnum, busmap.busmap);
 		up(&usb_bus_list_lock);
-		return retval;
+		return PTR_ERR(bus->class_dev);
 	}
 
+	class_set_devdata(bus->class_dev, bus);
+
 	/* Add it to the local list of buses */
 	list_add (&bus->bus_list, &usb_bus_list);
 	up (&usb_bus_list_lock);
@@ -820,7 +813,7 @@ static void usb_deregister_bus (struct u
 
 	clear_bit (bus->busnum, busmap.busmap);
 
-	class_device_del(&bus->class_dev);
+	class_device_unregister(bus->class_dev);
 }
 
 /**
diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -450,7 +450,7 @@ show_async (struct class_device *class_d
 
 	*buf = 0;
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ehci = hcd_to_ehci (hcd);
 	next = buf;
@@ -496,7 +496,7 @@ show_periodic (struct class_device *clas
 		return 0;
 	seen_count = 0;
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ehci = hcd_to_ehci (hcd);
 	next = buf;
@@ -633,7 +633,7 @@ show_registers (struct class_device *cla
 	static char		fmt [] = "%*s\n";
 	static char		label [] = "";
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ehci = hcd_to_ehci (hcd);
 	next = buf;
@@ -735,7 +735,7 @@ static CLASS_DEVICE_ATTR (registers, S_I
 
 static inline void create_debug_files (struct ehci_hcd *ehci)
 {
-	struct class_device *cldev = &ehci_to_hcd(ehci)->self.class_dev;
+	struct class_device *cldev = ehci_to_hcd(ehci)->self.class_dev;
 
 	class_device_create_file(cldev, &class_device_attr_async);
 	class_device_create_file(cldev, &class_device_attr_periodic);
@@ -744,7 +744,7 @@ static inline void create_debug_files (s
 
 static inline void remove_debug_files (struct ehci_hcd *ehci)
 {
-	struct class_device *cldev = &ehci_to_hcd(ehci)->self.class_dev;
+	struct class_device *cldev = ehci_to_hcd(ehci)->self.class_dev;
 
 	class_device_remove_file(cldev, &class_device_attr_async);
 	class_device_remove_file(cldev, &class_device_attr_periodic);
diff --git a/drivers/usb/host/ohci-dbg.c b/drivers/usb/host/ohci-dbg.c
--- a/drivers/usb/host/ohci-dbg.c
+++ b/drivers/usb/host/ohci-dbg.c
@@ -481,7 +481,7 @@ show_async (struct class_device *class_d
 	size_t			temp;
 	unsigned long		flags;
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ohci = hcd_to_ohci(hcd);
 
@@ -514,7 +514,7 @@ show_periodic (struct class_device *clas
 		return 0;
 	seen_count = 0;
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ohci = hcd_to_ohci(hcd);
 	next = buf;
@@ -611,7 +611,7 @@ show_registers (struct class_device *cla
 	char			*next;
 	u32			rdata;
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ohci = hcd_to_ohci(hcd);
 	regs = ohci->regs;
@@ -684,7 +684,7 @@ static CLASS_DEVICE_ATTR (registers, S_I
 
 static inline void create_debug_files (struct ohci_hcd *ohci)
 {
-	struct class_device *cldev = &ohci_to_hcd(ohci)->self.class_dev;
+	struct class_device *cldev = ohci_to_hcd(ohci)->self.class_dev;
 
 	class_device_create_file(cldev, &class_device_attr_async);
 	class_device_create_file(cldev, &class_device_attr_periodic);
@@ -694,7 +694,7 @@ static inline void create_debug_files (s
 
 static inline void remove_debug_files (struct ohci_hcd *ohci)
 {
-	struct class_device *cldev = &ohci_to_hcd(ohci)->self.class_dev;
+	struct class_device *cldev = ohci_to_hcd(ohci)->self.class_dev;
 
 	class_device_remove_file(cldev, &class_device_attr_async);
 	class_device_remove_file(cldev, &class_device_attr_periodic);
diff --git a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -287,15 +287,14 @@ struct usb_bus {
 
 	struct dentry *usbfs_dentry;	/* usbfs dentry entry for the bus */
 
-	struct class_device class_dev;	/* class device for this bus */
+	struct class_device *class_dev;	/* class device for this bus */
+	struct kref kref;		/* handles reference counting this bus */
 	void (*release)(struct usb_bus *bus);	/* function to destroy this bus's memory */
 #if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
 	struct mon_bus *mon_bus;	/* non-null when associated */
 	int monitored;			/* non-zero when monitored */
 #endif
 };
-#define	to_usb_bus(d) container_of(d, struct usb_bus, class_dev)
-
 
 /* -------------------------------------------------------------------------- */
 


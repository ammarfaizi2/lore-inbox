Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVCORN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVCORN5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVCORNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:13:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:52167 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261524AbVCORL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:11:29 -0500
Date: Tue, 15 Mar 2005 09:11:20 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315171119.GE25475@kroah.com>
References: <20050315170834.GA25475@kroah.com> <20050315170935.GB25475@kroah.com> <20050315171000.GC25475@kroah.com> <20050315171033.GD25475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315171033.GD25475@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 4 of 4

 Subject: USB: move the usb hcd code to use the new class code.

This moves a kref into the main hcd structure, which detaches it from
the class device structure.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	2005-03-15 08:54:43 -08:00
+++ b/drivers/usb/core/hcd.c	2005-03-15 08:54:43 -08:00
@@ -650,41 +650,43 @@
 struct usb_bus *usb_bus_get(struct usb_bus *bus)
 {
 	if (bus)
-		class_device_get(&bus->class_dev);
+		kref_get(&bus->kref);
 	return bus; 
 }
 EXPORT_SYMBOL_GPL(usb_bus_get);
 
+static void usb_host_release(struct kref *kref)
+{
+	struct usb_bus *bus = container_of(kref, struct usb_bus, kref);
+
+	if (bus->release)
+		bus->release(bus);
+}
+
 void usb_bus_put(struct usb_bus *bus)
 {
 	if (bus)
-		class_device_put(&bus->class_dev);
+		kref_put(&bus->kref, usb_host_release);
 }
 EXPORT_SYMBOL_GPL(usb_bus_put);
 
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
@@ -709,8 +711,7 @@
 
 	INIT_LIST_HEAD (&bus->bus_list);
 
-	class_device_initialize(&bus->class_dev);
-	bus->class_dev.class = &usb_host_class;
+	kref_init(&bus->kref);
 }
 EXPORT_SYMBOL (usb_bus_init);
 
@@ -753,7 +754,6 @@
 int usb_register_bus(struct usb_bus *bus)
 {
 	int busnum;
-	int retval;
 
 	down (&usb_bus_list_lock);
 	busnum = find_next_zero_bit (busmap.busmap, USB_MAXBUS, 1);
@@ -766,15 +766,15 @@
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
@@ -813,7 +813,7 @@
 
 	clear_bit (bus->busnum, busmap.busmap);
 
-	class_device_del(&bus->class_dev);
+	class_device_unregister(bus->class_dev);
 }
 EXPORT_SYMBOL (usb_deregister_bus);
 
diff -Nru a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
--- a/drivers/usb/host/ehci-dbg.c	2005-03-15 08:54:43 -08:00
+++ b/drivers/usb/host/ehci-dbg.c	2005-03-15 08:54:43 -08:00
@@ -450,7 +450,7 @@
 
 	*buf = 0;
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ehci = hcd_to_ehci (hcd);
 	next = buf;
@@ -496,7 +496,7 @@
 		return 0;
 	seen_count = 0;
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ehci = hcd_to_ehci (hcd);
 	next = buf;
@@ -633,7 +633,7 @@
 	static char		fmt [] = "%*s\n";
 	static char		label [] = "";
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ehci = hcd_to_ehci (hcd);
 	next = buf;
@@ -735,7 +735,7 @@
 
 static inline void create_debug_files (struct ehci_hcd *ehci)
 {
-	struct class_device *cldev = &ehci_to_hcd(ehci)->self.class_dev;
+	struct class_device *cldev = ehci_to_hcd(ehci)->self.class_dev;
 
 	class_device_create_file(cldev, &class_device_attr_async);
 	class_device_create_file(cldev, &class_device_attr_periodic);
@@ -744,7 +744,7 @@
 
 static inline void remove_debug_files (struct ehci_hcd *ehci)
 {
-	struct class_device *cldev = &ehci_to_hcd(ehci)->self.class_dev;
+	struct class_device *cldev = ehci_to_hcd(ehci)->self.class_dev;
 
 	class_device_remove_file(cldev, &class_device_attr_async);
 	class_device_remove_file(cldev, &class_device_attr_periodic);
diff -Nru a/drivers/usb/host/ohci-dbg.c b/drivers/usb/host/ohci-dbg.c
--- a/drivers/usb/host/ohci-dbg.c	2005-03-15 08:54:43 -08:00
+++ b/drivers/usb/host/ohci-dbg.c	2005-03-15 08:54:43 -08:00
@@ -477,7 +477,7 @@
 	size_t			temp;
 	unsigned long		flags;
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ohci = hcd_to_ohci(hcd);
 
@@ -510,7 +510,7 @@
 		return 0;
 	seen_count = 0;
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ohci = hcd_to_ohci(hcd);
 	next = buf;
@@ -607,7 +607,7 @@
 	char			*next;
 	u32			rdata;
 
-	bus = to_usb_bus(class_dev);
+	bus = class_get_devdata(class_dev);
 	hcd = bus->hcpriv;
 	ohci = hcd_to_ohci(hcd);
 	regs = ohci->regs;
@@ -678,7 +678,7 @@
 
 static inline void create_debug_files (struct ohci_hcd *ohci)
 {
-	struct class_device *cldev = &ohci_to_hcd(ohci)->self.class_dev;
+	struct class_device *cldev = ohci_to_hcd(ohci)->self.class_dev;
 
 	class_device_create_file(cldev, &class_device_attr_async);
 	class_device_create_file(cldev, &class_device_attr_periodic);
@@ -688,7 +688,7 @@
 
 static inline void remove_debug_files (struct ohci_hcd *ohci)
 {
-	struct class_device *cldev = &ohci_to_hcd(ohci)->self.class_dev;
+	struct class_device *cldev = ohci_to_hcd(ohci)->self.class_dev;
 
 	class_device_remove_file(cldev, &class_device_attr_async);
 	class_device_remove_file(cldev, &class_device_attr_periodic);
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	2005-03-15 08:54:43 -08:00
+++ b/include/linux/usb.h	2005-03-15 08:54:43 -08:00
@@ -287,15 +287,14 @@
 
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
 

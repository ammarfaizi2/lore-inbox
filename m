Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVBAFbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVBAFbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 00:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVBAFbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 00:31:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21915 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261549AbVBAF3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 00:29:10 -0500
Date: Mon, 31 Jan 2005 21:29:03 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Patch to add usbmon
Message-ID: <20050131212903.6e3a35e5@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds so-called "usbmon", or USB monitoring framework, similar
to what tcpdump provides for Ethernet. This is an initial version, but
it should be safe and useful. It adds an overhead of an if () statement
into submission and giveback paths even when not monitoring, but this
was deemed a lesser evil than stealth manipulation of function pointers.

The patch makes two changes to hcd.c which make usbmon more useful:
 - Change the way we determine that DMA should not be mapped for root
   hubs, so that usbmon knows easily when it's safe to capture data.
 - Return exports of usb_bus_list and usb_bus_list_lock for those who
   wish to build usbmon as a module.

Signed-off-by: Pete Zaitcev

diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/core/hcd.c linux-2.6.11-rc2-lem/drivers/usb/core/hcd.c
--- linux-2.6.11-rc2/drivers/usb/core/hcd.c	2005-01-22 14:54:24.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/usb/core/hcd.c	2005-01-23 17:19:18.000000000 -0800
@@ -86,6 +86,7 @@
 
 /* host controllers we manage */
 LIST_HEAD (usb_bus_list);
+EXPORT_SYMBOL_GPL (usb_bus_list);
 
 /* used when allocating bus numbers */
 #define USB_MAXBUS		64
@@ -96,6 +97,7 @@ static struct usb_busmap busmap;
 
 /* used when updating list of hcds */
 DECLARE_MUTEX (usb_bus_list_lock);	/* exported only for usbfs */
+EXPORT_SYMBOL_GPL (usb_bus_list_lock);
 
 /* used when updating hcd data */
 static DEFINE_SPINLOCK(hcd_data_lock);
@@ -103,6 +105,10 @@ static DEFINE_SPINLOCK(hcd_data_lock);
 /* wait queue for synchronous unlinks */
 DECLARE_WAIT_QUEUE_HEAD(usb_kill_urb_queue);
 
+#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+struct usb_mon_operations *mon_ops;
+#endif /* CONFIG_USB_MON */
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -746,6 +752,7 @@ int usb_register_bus(struct usb_bus *bus
 	up (&usb_bus_list_lock);
 
 	usbfs_add_bus (bus);
+	usbmon_notify_bus_add (bus);
 
 	dev_info (bus->controller, "new USB bus registered, assigned bus number %d\n", bus->busnum);
 	return 0;
@@ -773,6 +780,7 @@ void usb_deregister_bus (struct usb_bus 
 	list_del (&bus->bus_list);
 	up (&usb_bus_list_lock);
 
+	usbmon_notify_bus_remove (bus);
 	usbfs_remove_bus (bus);
 
 	clear_bit (bus->busnum, busmap.busmap);
@@ -1058,9 +1066,7 @@ static int hcd_submit_urb (struct urb *u
 	 * as simple as possible.
 	 */
 
-	// NOTE:  a generic device/urb monitoring hook would go here.
-	// hcd_monitor_hook(MONITOR_URB_SUBMIT, urb)
-	// It would catch submission paths for all urbs.
+	usbmon_urb_submit(&hcd->self, urb);
 
 	/*
 	 * Atomically queue the urb,  first to our records, then to the HCD.
@@ -1087,6 +1093,7 @@ static int hcd_submit_urb (struct urb *u
 	spin_unlock_irqrestore (&hcd_data_lock, flags);
 	if (status) {
 		INIT_LIST_HEAD (&urb->urb_list);
+		usbmon_urb_submit_error(&hcd->self, urb, status);
 		return status;
 	}
 
@@ -1103,8 +1110,6 @@ static int hcd_submit_urb (struct urb *u
 		 * valid and usb_buffer_{sync,unmap}() not be needed, since
 		 * they could clobber root hub response data.
 		 */
-		urb->transfer_flags |= (URB_NO_TRANSFER_DMA_MAP
-					| URB_NO_SETUP_DMA_MAP);
 		status = rh_urb_enqueue (hcd, urb);
 		goto done;
 	}
@@ -1139,6 +1144,7 @@ done:
 		if (urb->reject)
 			wake_up (&usb_kill_urb_queue);
 		usb_put_urb (urb);
+		usbmon_urb_submit_error(&hcd->self, urb, status);
 	}
 	return status;
 }
@@ -1461,14 +1467,13 @@ static struct usb_operations usb_hcd_ope
  */
 void usb_hcd_giveback_urb (struct usb_hcd *hcd, struct urb *urb, struct pt_regs *regs)
 {
-	urb_unlink (urb);
+	int at_root_hub;
 
-	// NOTE:  a generic device/urb monitoring hook would go here.
-	// hcd_monitor_hook(MONITOR_URB_FINISH, urb, dev)
-	// It would catch exit/unlink paths for all urbs.
+	at_root_hub = (urb->dev == hcd->self.root_hub);
+	urb_unlink (urb);
 
 	/* lower level hcd code should use *_dma exclusively */
-	if (hcd->self.controller->dma_mask) {
+	if (hcd->self.controller->dma_mask && !at_root_hub) {
 		if (usb_pipecontrol (urb->pipe)
 			&& !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
 			dma_unmap_single (hcd->self.controller, urb->setup_dma,
@@ -1484,6 +1489,7 @@ void usb_hcd_giveback_urb (struct usb_hc
 					    : DMA_TO_DEVICE);
 	}
 
+	usbmon_urb_complete (&hcd->self, urb);
 	/* pass ownership to the completion handler */
 	urb->complete (urb, regs);
 	atomic_dec (&urb->use_count);
@@ -1591,3 +1597,43 @@ void usb_put_hcd (struct usb_hcd *hcd)
 	usb_bus_put(&hcd->self);
 }
 EXPORT_SYMBOL (usb_put_hcd);
+
+/*-------------------------------------------------------------------------*/
+
+#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+
+struct usb_mon_operations *mon_ops;
+
+/*
+ * The registration is unlocked.
+ * We do it this way because we do not want to lock in hot paths.
+ *
+ * Notice that the code is minimally error-proof. Because usbmon needs
+ * symbols from usbcore, usbcore gets referenced and cannot be unloaded first.
+ */
+ 
+int usb_mon_register (struct usb_mon_operations *ops)
+{
+
+	if (mon_ops)
+		return -EBUSY;
+
+	mon_ops = ops;
+	mb();
+	return 0;
+}
+EXPORT_SYMBOL_GPL (usb_mon_register);
+
+void usb_mon_deregister (void)
+{
+
+	if (mon_ops == NULL) {
+		printk(KERN_ERR "USB: monitor was not registered\n");
+		return;
+	}
+	mon_ops = NULL;
+	mb();
+}
+EXPORT_SYMBOL_GPL (usb_mon_deregister);
+
+#endif /* CONFIG_USB_MON */
diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/core/hcd.h linux-2.6.11-rc2-lem/drivers/usb/core/hcd.h
--- linux-2.6.11-rc2/drivers/usb/core/hcd.h	2005-01-22 14:54:24.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/usb/core/hcd.h	2005-01-23 17:19:43.000000000 -0800
@@ -411,6 +411,63 @@ static inline void usbfs_cleanup(void) {
 
 /*-------------------------------------------------------------------------*/
 
+#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+
+struct usb_mon_operations {
+	void (*urb_submit)(struct usb_bus *bus, struct urb *urb);
+	void (*urb_submit_error)(struct usb_bus *bus, struct urb *urb, int err);
+	void (*urb_complete)(struct usb_bus *bus, struct urb *urb);
+	/* void (*urb_unlink)(struct usb_bus *bus, struct urb *urb); */
+	void (*bus_add)(struct usb_bus *bus);
+	void (*bus_remove)(struct usb_bus *bus);
+};
+
+extern struct usb_mon_operations *mon_ops;
+
+#define usbmon_urb_submit(bus, urb)				\
+	do {							\
+		if ((bus)->monitored)				\
+			(*mon_ops->urb_submit)(bus, urb);	\
+	} while(0)
+
+#define usbmon_urb_submit_error(bus, urb, err)			\
+	do {							\
+		if ((bus)->monitored)				\
+			(*mon_ops->urb_submit_error)(bus, urb, err);	\
+	} while(0)
+
+#define usbmon_urb_complete(bus, urb)				\
+	do {							\
+		if ((bus)->monitored)				\
+			(*mon_ops->urb_complete)(bus, urb);	\
+	} while(0)
+ 
+#define usbmon_notify_bus_add(bus)			\
+	do {						\
+		if (mon_ops)				\
+			(*mon_ops->bus_add)(bus);	\
+	} while(0)
+#define usbmon_notify_bus_remove(bus)			\
+	do {						\
+		if (mon_ops)				\
+			(*mon_ops->bus_remove)(bus);	\
+	} while(0)
+
+int usb_mon_register(struct usb_mon_operations *ops);
+void usb_mon_deregister(void);
+
+#else
+
+#define usbmon_urb_submit(bus, urb)		/* */
+#define usbmon_urb_submit(bus, urb, error)	/* */
+#define usbmon_urb_complete(bus, urb)		/* */
+#define usbmon_notify_bus_add(bus)		/* */
+#define usbmon_notify_bus_remove(bus)		/* */
+
+#endif /* CONFIG_USB_MON */
+
+/*-------------------------------------------------------------------------*/
+
 /* hub.h ... DeviceRemovable in 2.4.2-ac11, gone in 2.4.10 */
 // bleech -- resurfaced in 2.4.11 or 2.4.12
 #define bitmap 	DeviceRemovable
diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/Kconfig linux-2.6.11-rc2-lem/drivers/usb/Kconfig
--- linux-2.6.11-rc2/drivers/usb/Kconfig	2005-01-05 00:37:56.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/usb/Kconfig	2005-01-22 18:59:42.000000000 -0800
@@ -56,6 +56,8 @@ source "drivers/usb/media/Kconfig"
 
 source "drivers/usb/net/Kconfig"
 
+source "drivers/usb/mon/Kconfig"
+
 comment "USB port drivers"
 	depends on USB
 
diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/Makefile linux-2.6.11-rc2-lem/drivers/usb/Makefile
--- linux-2.6.11-rc2/drivers/usb/Makefile	2005-01-22 14:54:24.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/usb/Makefile	2005-01-22 18:59:42.000000000 -0800
@@ -6,6 +6,8 @@
 
 obj-$(CONFIG_USB)		+= core/
 
+obj-$(CONFIG_USB_MON)		+= mon/
+
 obj-$(CONFIG_USB_EHCI_HCD)	+= host/
 obj-$(CONFIG_USB_OHCI_HCD)	+= host/
 obj-$(CONFIG_USB_UHCI_HCD)	+= host/
diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/mon/Kconfig linux-2.6.11-rc2-lem/drivers/usb/mon/Kconfig
--- linux-2.6.11-rc2/drivers/usb/mon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/usb/mon/Kconfig	2005-01-22 18:59:42.000000000 -0800
@@ -0,0 +1,22 @@
+#
+# USB Monitor configuration
+#
+
+# In normal life, it makes little sense to have usbmon as a module, and in fact
+# it is harmful, because there is no way to autoload the module.
+# The 'm' option is allowed for hackers who debug the usbmon itself,
+# and for those who have usbcore as a module.
+config USB_MON
+	tristate "USB Monitor"
+	depends on USB
+	default y
+	help
+	  If you say Y here, a component which captures the USB traffic
+	  between peripheral-specific drivers and HC drivers will be built.
+	  The USB_MON is similar in spirit and may be compatible with Dave
+	  Harding's USBMon.
+
+	  This is somewhat experimental at this time, but it should be safe,
+	  as long as you aren't building this as a module and then removing it.
+
+	  If unsure, say Y. Do not say M.
diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/mon/Makefile linux-2.6.11-rc2-lem/drivers/usb/mon/Makefile
--- linux-2.6.11-rc2/drivers/usb/mon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/usb/mon/Makefile	2005-01-22 18:59:42.000000000 -0800
@@ -0,0 +1,7 @@
+#
+# Makefile for USB Core files and filesystem
+#
+
+usbmon-objs	:= mon_main.o mon_stat.o mon_text.o
+
+obj-$(CONFIG_USB_MON)	+= usbmon.o
diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/mon/mon_main.c linux-2.6.11-rc2-lem/drivers/usb/mon/mon_main.c
--- linux-2.6.11-rc2/drivers/usb/mon/mon_main.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/usb/mon/mon_main.c	2005-01-23 17:47:58.000000000 -0800
@@ -0,0 +1,377 @@
+/*
+ * The USB Monitor, inspired by Dave Harding's USBMon.
+ *
+ * mon_main.c: Main file, module initiation and exit, registrations, etc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/debugfs.h>
+#include <linux/smp_lock.h>
+
+#include "usb_mon.h"
+#include "../core/hcd.h"
+
+static void mon_submit(struct usb_bus *ubus, struct urb *urb);
+static void mon_complete(struct usb_bus *ubus, struct urb *urb);
+static void mon_stop(struct mon_bus *mbus);
+static void mon_dissolve(struct mon_bus *mbus, struct usb_bus *ubus);
+static void mon_bus_drop(struct kref *r);
+static void mon_bus_init(struct dentry *mondir, struct usb_bus *ubus);
+
+DECLARE_MUTEX(mon_lock);
+
+static struct dentry *mon_dir;		/* /dbg/usbmon */
+static LIST_HEAD(mon_buses);		/* All buses we know: struct mon_bus */
+
+/*
+ * Link a reader into the bus.
+ *
+ * This must be called with mon_lock taken because of mbus->ref.
+ */
+void mon_reader_add(struct mon_bus *mbus, struct mon_reader *r)
+{
+	unsigned long flags;
+	struct usb_bus *ubus;
+
+	spin_lock_irqsave(&mbus->lock, flags);
+	if (mbus->nreaders == 0) {
+		ubus = mbus->u_bus;
+		if (ubus->monitored) {
+			/*
+			 * Something is really broken, refuse to go on and
+			 * possibly corrupt ops pointers or worse.
+			 */
+			printk(KERN_ERR TAG ": bus %d is already monitored\n",
+			    ubus->busnum);
+			spin_unlock_irqrestore(&mbus->lock, flags);
+			return;
+		}
+		ubus->monitored = 1;
+	}
+	mbus->nreaders++;
+	list_add_tail(&r->r_link, &mbus->r_list);
+	spin_unlock_irqrestore(&mbus->lock, flags);
+
+	kref_get(&mbus->ref);
+}
+
+/*
+ * Unlink reader from the bus.
+ *
+ * This is called with mon_lock taken, so we can decrement mbus->ref.
+ */
+void mon_reader_del(struct mon_bus *mbus, struct mon_reader *r)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mbus->lock, flags);
+	list_del(&r->r_link);
+	--mbus->nreaders;
+	if (mbus->nreaders == 0)
+		mon_stop(mbus);
+	spin_unlock_irqrestore(&mbus->lock, flags);
+
+	kref_put(&mbus->ref, mon_bus_drop);
+}
+
+/*
+ */
+static void mon_submit(struct usb_bus *ubus, struct urb *urb)
+{
+	struct mon_bus *mbus;
+	unsigned long flags;
+	struct list_head *pos;
+	struct mon_reader *r;
+
+	mbus = ubus->mon_bus;
+	if (mbus == NULL)
+		goto out_unlocked;
+
+	spin_lock_irqsave(&mbus->lock, flags);
+	if (mbus->nreaders == 0)
+		goto out_locked;
+
+	list_for_each (pos, &mbus->r_list) {
+		r = list_entry(pos, struct mon_reader, r_link);
+		r->rnf_submit(r->r_data, urb);
+	}
+
+	spin_unlock_irqrestore(&mbus->lock, flags);
+	return;
+
+out_locked:
+	spin_unlock_irqrestore(&mbus->lock, flags);
+out_unlocked:
+	return;
+}
+
+/*
+ */
+static void mon_submit_error(struct usb_bus *ubus, struct urb *urb, int err)
+{
+	struct mon_bus *mbus;
+
+	mbus = ubus->mon_bus;
+	if (mbus == NULL)
+		goto out_unlocked;
+
+	/*
+	 * XXX Capture the error code and the 'E' event.
+	 */
+
+	return;
+
+out_unlocked:
+	return;
+}
+
+/*
+ */
+static void mon_complete(struct usb_bus *ubus, struct urb *urb)
+{
+	struct mon_bus *mbus;
+	unsigned long flags;
+	struct list_head *pos;
+	struct mon_reader *r;
+
+	mbus = ubus->mon_bus;
+	if (mbus == NULL) {
+		/*
+		 * This should not happen.
+		 * At this point we do not even know the bus number...
+		 */
+		printk(KERN_ERR TAG ": Null mon bus in URB, pipe 0x%x\n",
+		    urb->pipe);
+		return;
+	}
+
+	spin_lock_irqsave(&mbus->lock, flags);
+	list_for_each (pos, &mbus->r_list) {
+		r = list_entry(pos, struct mon_reader, r_link);
+		r->rnf_complete(r->r_data, urb);
+	}
+	spin_unlock_irqrestore(&mbus->lock, flags);
+}
+
+/* int (*unlink_urb) (struct urb *urb, int status); */
+
+/*
+ * Stop monitoring.
+ * Obviously this must be well locked, so no need to play with mb's.
+ */
+static void mon_stop(struct mon_bus *mbus)
+{
+	struct usb_bus *ubus = mbus->u_bus;
+
+	/*
+	 * A stop can be called for a dissolved mon_bus in case of
+	 * a reader staying across an rmmod foo_hcd.
+	 */
+	if (ubus != NULL) {
+		ubus->monitored = 0;
+		mb();
+	}
+}
+
+/*
+ * Add a USB bus (usually by a modprobe foo-hcd)
+ *
+ * This does not return an error code because the core cannot care less
+ * if monitoring is not established.
+ */
+static void mon_bus_add(struct usb_bus *ubus)
+{
+	mon_bus_init(mon_dir, ubus);
+}
+
+/*
+ * Remove a USB bus (either from rmmod foo-hcd or from a hot-remove event).
+ */
+static void mon_bus_remove(struct usb_bus *ubus)
+{
+	struct mon_bus *mbus = ubus->mon_bus;
+
+	down(&mon_lock);
+	list_del(&mbus->bus_link);
+	debugfs_remove(mbus->dent_t);
+	debugfs_remove(mbus->dent_s);
+
+	mon_dissolve(mbus, ubus);
+	kref_put(&mbus->ref, mon_bus_drop);
+	up(&mon_lock);
+}
+
+/*
+ * Ops
+ */
+static struct usb_mon_operations mon_ops_0 = {
+	.urb_submit =	mon_submit,
+	.urb_submit_error = mon_submit_error,
+	.urb_complete =	mon_complete,
+	.bus_add =	mon_bus_add,
+	.bus_remove =	mon_bus_remove,
+};
+
+/*
+ * Tear usb_bus and mon_bus apart.
+ */
+static void mon_dissolve(struct mon_bus *mbus, struct usb_bus *ubus)
+{
+
+	/*
+	 * Never happens, but...
+	 */
+	if (ubus->monitored) {
+		printk(KERN_ERR TAG ": bus %d is dissolved while monitored\n",
+		    ubus->busnum);
+		ubus->monitored = 0;
+		mb();
+	}
+
+	ubus->mon_bus = NULL;
+	mbus->u_bus = NULL;
+	mb();
+	// usb_bus_put(ubus);
+}
+
+/*
+ */
+static void mon_bus_drop(struct kref *r)
+{
+	struct mon_bus *mbus = container_of(r, struct mon_bus, ref);
+	kfree(mbus);
+}
+
+/*
+ * Initialize a bus for us:
+ *  - allocate mon_bus
+ *  - refcount USB bus struct
+ *  - link
+ */
+static void mon_bus_init(struct dentry *mondir, struct usb_bus *ubus)
+{
+	struct dentry *d;
+	struct mon_bus *mbus;
+	enum { NAMESZ = 10 };
+	char name[NAMESZ];
+	int rc;
+
+	if ((mbus = kmalloc(sizeof(struct mon_bus), GFP_KERNEL)) == NULL)
+		goto err_alloc;
+	memset(mbus, 0, sizeof(struct mon_bus));
+	kref_init(&mbus->ref);
+	spin_lock_init(&mbus->lock);
+	INIT_LIST_HEAD(&mbus->r_list);
+
+	/*
+	 * This usb_bus_get here is superfluous, because we receive
+	 * a notification if usb_bus is about to be removed.
+	 */
+	// usb_bus_get(ubus);
+	mbus->u_bus = ubus;
+	ubus->mon_bus = mbus;
+
+	rc = snprintf(name, NAMESZ, "%dt", ubus->busnum);
+	if (rc <= 0 || rc >= NAMESZ)
+		goto err_print_t;
+	d = debugfs_create_file(name, 0600, mondir, mbus, &mon_fops_text);
+	if (d == NULL)
+		goto err_create_t;
+	mbus->dent_t = d;
+
+	rc = snprintf(name, NAMESZ, "%ds", ubus->busnum);
+	if (rc <= 0 || rc >= NAMESZ)
+		goto err_print_s;
+	d = debugfs_create_file(name, 0600, mondir, mbus, &mon_fops_stat);
+	if (d == NULL)
+		goto err_create_s;
+	mbus->dent_s = d;
+
+	down(&mon_lock);
+	list_add_tail(&mbus->bus_link, &mon_buses);
+	up(&mon_lock);
+	return;
+
+err_create_s:
+err_print_s:
+	debugfs_remove(mbus->dent_t);
+err_create_t:
+err_print_t:
+	kfree(mbus);
+err_alloc:
+	return;
+}
+
+static int __init mon_init(void)
+{
+	struct usb_bus *ubus;
+	struct dentry *mondir;
+
+	mondir = debugfs_create_dir("usbmon", NULL);
+	if (IS_ERR(mondir)) {
+		printk(KERN_NOTICE TAG ": debugs is not available\n");
+		return -ENODEV;
+	}
+	if (mondir == NULL) {
+		printk(KERN_NOTICE TAG ": unable to create usbmon directory\n");
+		return -ENODEV;
+	}
+	mon_dir = mondir;
+
+	if (usb_mon_register(&mon_ops_0) != 0) {
+		printk(KERN_NOTICE TAG ": unable to register with the core\n");
+		debugfs_remove(mondir);
+		return -ENODEV;
+	}
+	// MOD_INC_USE_COUNT(which_module?);
+
+	down(&usb_bus_list_lock);
+	list_for_each_entry (ubus, &usb_bus_list, bus_list) {
+		mon_bus_init(mondir, ubus);
+	}
+	up(&usb_bus_list_lock);
+	return 0;
+}
+
+static void __exit mon_exit(void)
+{
+	struct mon_bus *mbus;
+	struct list_head *p;
+
+	usb_mon_deregister();
+
+	down(&mon_lock);
+	while (!list_empty(&mon_buses)) {
+		p = mon_buses.next;
+		mbus = list_entry(p, struct mon_bus, bus_link);
+		list_del(p);
+
+		debugfs_remove(mbus->dent_t);
+		debugfs_remove(mbus->dent_s);
+
+		/*
+		 * This never happens, because the open/close paths in
+		 * file level maintain module use counters and so rmmod fails
+		 * before reaching here. However, better be safe...
+		 */
+		if (mbus->nreaders) {
+			printk(KERN_ERR TAG
+			    ": Outstanding opens (%d) on usb%d, leaking...\n",
+			    mbus->nreaders, mbus->u_bus->busnum);
+			atomic_set(&mbus->ref.refcount, 2);	/* Force leak */
+		}
+
+		mon_dissolve(mbus, mbus->u_bus);
+		kref_put(&mbus->ref, mon_bus_drop);
+	}
+	up(&mon_lock);
+
+	debugfs_remove(mon_dir);
+}
+
+module_init(mon_init);
+module_exit(mon_exit);
+
+MODULE_LICENSE("GPL");
diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/mon/mon_stat.c linux-2.6.11-rc2-lem/drivers/usb/mon/mon_stat.c
--- linux-2.6.11-rc2/drivers/usb/mon/mon_stat.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/usb/mon/mon_stat.c	2005-01-23 17:30:14.000000000 -0800
@@ -0,0 +1,74 @@
+/*
+ * The USB Monitor, inspired by Dave Harding's USBMon.
+ *
+ * This is the 's' or 'stat' reader which debugs usbmon itself.
+ * Note that this code blows through locks, so make sure that
+ * /dbg/usbmon/0s is well protected from non-root users.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/usb.h>
+#include <asm/uaccess.h>
+
+#include "usb_mon.h"
+
+#define STAT_BUF_SIZE  80
+
+struct snap {
+	int slen;
+	char str[STAT_BUF_SIZE];
+};
+
+static int mon_stat_open(struct inode *inode, struct file *file)
+{
+	struct mon_bus *mbus;
+	struct snap *sp;
+
+	if ((sp = kmalloc(sizeof(struct snap), GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
+	mbus = inode->u.generic_ip;
+
+	sp->slen = snprintf(sp->str, STAT_BUF_SIZE,
+	    "nreaders %d text_lost %u\n",
+	    mbus->nreaders, mbus->cnt_text_lost);
+
+	file->private_data = sp;
+	return 0;
+}
+
+static ssize_t mon_stat_read(struct file *file, char __user *buf,
+				size_t nbytes, loff_t *ppos)
+{
+	struct snap *sp = file->private_data;
+	loff_t pos = *ppos;
+	int cnt;
+
+	if (pos < 0 || pos >= sp->slen)
+		return 0;
+	if (nbytes == 0)
+		return 0;
+	if ((cnt = sp->slen - pos) > nbytes)
+		cnt = nbytes;
+	if (copy_to_user(buf, sp->str + pos, cnt))
+		return -EFAULT;
+	*ppos = pos + cnt;
+	return cnt;
+}
+
+static int mon_stat_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+struct file_operations mon_fops_stat = {
+	.owner =	THIS_MODULE,
+	.open =		mon_stat_open,
+	.llseek =	no_llseek,
+	.read =		mon_stat_read,
+	/* .write =	mon_stat_write, */
+	/* .poll =		mon_stat_poll, */
+	/* .ioctl =	mon_stat_ioctl, */
+	.release =	mon_stat_release,
+};
diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/mon/mon_text.c linux-2.6.11-rc2-lem/drivers/usb/mon/mon_text.c
--- linux-2.6.11-rc2/drivers/usb/mon/mon_text.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/usb/mon/mon_text.c	2005-01-23 17:30:09.000000000 -0800
@@ -0,0 +1,395 @@
+/*
+ * The USB Monitor, inspired by Dave Harding's USBMon.
+ *
+ * This is a text format reader.
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/usb.h>
+#include <linux/time.h>
+#include <asm/uaccess.h>
+
+#include "usb_mon.h"
+
+/*
+ * No, we do not want arbitrarily long data strings.
+ * Use the binary interface if you want to capture bulk data!
+ */
+#define DATA_MAX  32
+
+/*
+ * This limit exists to prevent OOMs when the user process stops reading.
+ */
+#define EVENT_MAX  25
+
+#define PRINTF_DFL  120
+
+struct mon_event_text {
+	struct list_head e_link;
+	int type;		/* submit, complete, etc. */
+	unsigned int pipe;	/* Pipe */
+	unsigned long id;	/* From pointer, most of the time */
+	unsigned int tstamp;
+	int length;		/* Depends on type: xfer length or act length */
+	int status;
+	char data_flag;
+	unsigned char data[DATA_MAX];
+};
+
+#define SLAB_NAME_SZ  30
+struct mon_reader_text {
+	kmem_cache_t *e_slab;
+	int nevents;
+	struct list_head e_list;
+	struct mon_reader r;	/* In C, parent class can be placed anywhere */
+
+	wait_queue_head_t wait;
+	int printf_size;
+	char *printf_buf;
+	struct semaphore printf_lock;
+
+	char slab_name[SLAB_NAME_SZ];
+};
+
+static void mon_text_ctor(void *, kmem_cache_t *, unsigned long);
+static void mon_text_dtor(void *, kmem_cache_t *, unsigned long);
+
+/*
+ * mon_text_submit
+ * mon_text_complete
+ *
+ * May be called from an interrupt.
+ *
+ * This is called with the whole mon_bus locked, so no additional lock.
+ */
+
+static inline char mon_text_get_data(struct mon_event_text *ep, struct urb *urb,
+    int len, char ev_type)
+{
+	int pipe = urb->pipe;
+	unsigned char *data;
+
+	/*
+	 * The check to see if it's safe to poke at data has an enormous
+	 * number of corner cases, but it seems that the following is
+	 * more or less safe.
+	 *
+	 * We do not even try to look transfer_buffer, because it can
+	 * contain non-NULL garbage in case the upper level promised to
+	 * set DMA for the HCD.
+	 */
+	if (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)
+		return 'D';
+
+	if (len <= 0)
+		return 'L';
+
+	if ((data = urb->transfer_buffer) == NULL)
+		return 'Z';	/* '0' would be not as pretty. */
+
+	/*
+	 * Bulk is easy to shortcut reliably. 
+	 * XXX Control needs setup packet taken.
+	 * XXX Other pipe types need consideration. Currently, we overdo it
+	 * and collect garbage for them: better more than less.
+	 */
+	if (usb_pipebulk(pipe) || usb_pipecontrol(pipe)) {
+		if (usb_pipein(pipe)) {
+			if (ev_type == 'S')
+				return '<';
+		} else {
+			if (ev_type == 'C')
+				return '>';
+		}
+	}
+
+	if (len >= DATA_MAX)
+		len = DATA_MAX;
+	memcpy(ep->data, urb->transfer_buffer, len);
+	return 0;
+}
+
+static inline unsigned int mon_get_timestamp(void)
+{
+	struct timeval tval;
+	unsigned int stamp;
+
+	do_gettimeofday(&tval);
+	stamp = tval.tv_sec & 0xFFFF;	/* 2^32 = 4294967296. Limit to 4096s. */
+	stamp = stamp * 1000000 + tval.tv_usec;
+	return stamp;
+}
+
+static void mon_text_event(struct mon_reader_text *rp, struct urb *urb,
+    char ev_type)
+{
+	struct mon_event_text *ep;
+	unsigned int stamp;
+
+	stamp = mon_get_timestamp();
+
+	if (rp->nevents >= EVENT_MAX ||
+	    (ep = kmem_cache_alloc(rp->e_slab, SLAB_ATOMIC)) == NULL) {
+		rp->r.m_bus->cnt_text_lost++;
+		return;
+	}
+
+	ep->type = ev_type;
+	ep->pipe = urb->pipe;
+	ep->id = (unsigned long) urb;
+	ep->tstamp = stamp;
+	ep->length = (ev_type == 'S') ?
+	    urb->transfer_buffer_length : urb->actual_length;
+	/* Collecting status makes debugging sense for submits, too */
+	ep->status = urb->status;
+
+	ep->data_flag = mon_text_get_data(ep, urb, ep->length, ev_type);
+
+	rp->nevents++;
+	list_add_tail(&ep->e_link, &rp->e_list);
+	wake_up(&rp->wait);
+}
+
+static void mon_text_submit(void *data, struct urb *urb)
+{
+	struct mon_reader_text *rp = data;
+	mon_text_event(rp, urb, 'S');
+}
+
+static void mon_text_complete(void *data, struct urb *urb)
+{
+	struct mon_reader_text *rp = data;
+	mon_text_event(rp, urb, 'C');
+}
+
+/*
+ * Fetch next event from the circular buffer.
+ */
+static struct mon_event_text *mon_text_fetch(struct mon_reader_text *rp,
+    struct mon_bus *mbus)
+{
+	struct list_head *p;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mbus->lock, flags);
+	if (list_empty(&rp->e_list)) {
+		spin_unlock_irqrestore(&mbus->lock, flags);
+		return NULL;
+	}
+	p = rp->e_list.next;
+	list_del(p);
+	--rp->nevents;
+	spin_unlock_irqrestore(&mbus->lock, flags);
+	return list_entry(p, struct mon_event_text, e_link);
+}
+
+/*
+ */
+static int mon_text_open(struct inode *inode, struct file *file)
+{
+	struct mon_bus *mbus;
+	struct usb_bus *ubus;
+	struct mon_reader_text *rp;
+	int rc;
+
+	down(&mon_lock);
+	mbus = inode->u.generic_ip;
+	ubus = mbus->u_bus;
+
+	rp = kmalloc(sizeof(struct mon_reader_text), GFP_KERNEL);
+	if (rp == NULL) {
+		rc = -ENOMEM;
+		goto err_alloc;
+	}
+	memset(rp, 0, sizeof(struct mon_reader_text));
+	INIT_LIST_HEAD(&rp->e_list);
+	init_waitqueue_head(&rp->wait);
+	init_MUTEX(&rp->printf_lock);
+
+	rp->printf_size = PRINTF_DFL;
+	rp->printf_buf = kmalloc(rp->printf_size, GFP_KERNEL);
+	if (rp->printf_buf == NULL) {
+		rc = -ENOMEM;
+		goto err_alloc_pr;
+	}
+
+	rp->r.m_bus = mbus;
+	rp->r.r_data = rp;
+	rp->r.rnf_submit = mon_text_submit;
+	rp->r.rnf_complete = mon_text_complete;
+
+	snprintf(rp->slab_name, SLAB_NAME_SZ, "mon%dt_%lx", ubus->busnum,
+	    (long)rp);
+	rp->e_slab = kmem_cache_create(rp->slab_name,
+	    sizeof(struct mon_event_text), sizeof(long), 0,
+	    mon_text_ctor, mon_text_dtor);
+	if (rp->e_slab == NULL) {
+		rc = -ENOMEM;
+		goto err_slab;
+	}
+
+	mon_reader_add(mbus, &rp->r);
+
+	file->private_data = rp;
+	up(&mon_lock);
+	return 0;
+
+// err_busy:
+//	kmem_cache_destroy(rp->e_slab);
+err_slab:
+	kfree(rp->printf_buf);
+err_alloc_pr:
+	kfree(rp);
+err_alloc:
+	up(&mon_lock);
+	return rc;
+}
+
+/*
+ * For simplicity, we read one record in one system call and throw out
+ * what does not fit. This means that the following does not work:
+ *   dd if=/dbg/usbmon/0t bs=10
+ * Also, we do not allow seeks and do not bother advancing the offset.
+ */
+static ssize_t mon_text_read(struct file *file, char __user *buf,
+				size_t nbytes, loff_t *ppos)
+{
+	struct mon_reader_text *rp = file->private_data;
+	struct mon_bus *mbus = rp->r.m_bus;
+	DECLARE_WAITQUEUE(waita, current);
+	struct mon_event_text *ep;
+	int cnt, limit;
+	char *pbuf;
+	int data_len, i;
+
+	add_wait_queue(&rp->wait, &waita);
+	set_current_state(TASK_INTERRUPTIBLE);
+	while ((ep = mon_text_fetch(rp, mbus)) == NULL) {
+		if (file->f_flags & O_NONBLOCK) {
+			set_current_state(TASK_RUNNING);
+			remove_wait_queue(&rp->wait, &waita);
+			return -EWOULDBLOCK;	/* Same as EAGAIN in Linux */
+		}
+		/*
+		 * We do not count nwaiters, because ->release is supposed
+		 * to be called when all openers are gone only.
+		 */
+		schedule();
+		if (signal_pending(current)) {
+			remove_wait_queue(&rp->wait, &waita);
+			return -EINTR;
+		}
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&rp->wait, &waita);
+
+	down(&rp->printf_lock);
+	cnt = 0;
+	pbuf = rp->printf_buf;
+	limit = rp->printf_size;
+
+	cnt += snprintf(pbuf + cnt, limit - cnt,
+	    "%lx %u %c %08x %d %d",
+	    ep->id, ep->tstamp, ep->type, ep->pipe, ep->status, ep->length);
+
+	if ((data_len = ep->length) > 0) {
+		if (ep->data_flag == 0) {
+			cnt += snprintf(pbuf + cnt, limit - cnt, " =");
+			if (data_len >= DATA_MAX)
+				data_len = DATA_MAX;
+			for (i = 0; i < data_len; i++) {
+				if (i % 4 == 0) {
+					cnt += snprintf(pbuf + cnt, limit - cnt,
+					    " ");
+				}
+				cnt += snprintf(pbuf + cnt, limit - cnt,
+				    "%02x", ep->data[i]);
+			}
+			cnt += snprintf(pbuf + cnt, limit - cnt, "\n");
+		} else {
+			cnt += snprintf(pbuf + cnt, limit - cnt,
+			    " %c\n", ep->data_flag);
+		}
+	} else {
+		cnt += snprintf(pbuf + cnt, limit - cnt, "\n");
+	}
+
+	if (copy_to_user(buf, rp->printf_buf, cnt))
+		cnt = -EFAULT;
+	up(&rp->printf_lock);
+	kmem_cache_free(rp->e_slab, ep);
+	return cnt;
+}
+
+static int mon_text_release(struct inode *inode, struct file *file)
+{
+	struct mon_reader_text *rp = file->private_data;
+	struct mon_bus *mbus;
+	/* unsigned long flags; */
+	struct list_head *p;
+	struct mon_event_text *ep;
+
+	down(&mon_lock);
+	mbus = inode->u.generic_ip;
+
+	if (mbus->nreaders <= 0) {
+		printk(KERN_ERR TAG ": consistency error on close\n");
+		up(&mon_lock);
+		return 0;
+	}
+	mon_reader_del(mbus, &rp->r);
+
+	/*
+	 * In theory, e_list is protected by mbus->lock. However,
+	 * after mon_reader_del has finished, the following is the case:
+	 *  - we are not on reader list anymore, so new events won't be added;
+	 *  - whole mbus may be dropped if it was orphaned.
+	 * So, we better not touch mbus.
+	 */
+	/* spin_lock_irqsave(&mbus->lock, flags); */
+	while (!list_empty(&rp->e_list)) {
+		p = rp->e_list.next;
+		ep = list_entry(p, struct mon_event_text, e_link);
+		list_del(p);
+		--rp->nevents;
+		kmem_cache_free(rp->e_slab, ep);
+	}
+	/* spin_unlock_irqrestore(&mbus->lock, flags); */
+
+	kmem_cache_destroy(rp->e_slab);
+	kfree(rp->printf_buf);
+	kfree(rp);
+
+	up(&mon_lock);
+	return 0;
+}
+
+struct file_operations mon_fops_text = {
+	.owner =	THIS_MODULE,
+	.open =		mon_text_open,
+	.llseek =	no_llseek,
+	.read =		mon_text_read,
+	/* .write =	mon_text_write, */
+	/* .poll =		mon_text_poll, */
+	/* .ioctl =	mon_text_ioctl, */
+	.release =	mon_text_release,
+};
+
+/*
+ * Slab interface: constructor.
+ */
+static void mon_text_ctor(void *mem, kmem_cache_t *slab, unsigned long sflags)
+{
+	/*
+	 * Nothing to initialize. No, really!
+	 * So, we fill it with garbage to emulate a reused object.
+	 */
+	memset(mem, 0xe5, sizeof(struct mon_event_text));
+}
+
+static void mon_text_dtor(void *mem, kmem_cache_t *slab, unsigned long sflags)
+{
+	;
+}
diff -urpN -X dontdiff linux-2.6.11-rc2/drivers/usb/mon/usb_mon.h linux-2.6.11-rc2-lem/drivers/usb/mon/usb_mon.h
--- linux-2.6.11-rc2/drivers/usb/mon/usb_mon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.11-rc2-lem/drivers/usb/mon/usb_mon.h	2005-01-22 23:41:57.000000000 -0800
@@ -0,0 +1,51 @@
+/*
+ * The USB Monitor, inspired by Dave Harding's USBMon.
+ */
+
+#ifndef __USB_MON_H
+#define __USB_MON_H
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/kref.h>
+/* #include <linux/usb.h> */	/* We use struct pointers only in this header */
+
+#define TAG "usbmon"
+
+struct mon_bus {
+	struct list_head bus_link;
+	spinlock_t lock;
+	struct dentry *dent_s;		/* Debugging file */
+	struct dentry *dent_t;		/* Text interface file */
+	struct usb_bus *u_bus;
+
+	/* Ref */
+	int nreaders;			/* Under mon_lock AND mbus->lock */
+	struct list_head r_list;	/* Chain of readers (usually one) */
+	struct kref ref;		/* Under mon_lock */
+
+	/* Stats */
+	unsigned int cnt_text_lost;
+};
+
+/*
+ * An instance of a process which opened a file (but can fork later)
+ */
+struct mon_reader {
+	struct list_head r_link;
+	struct mon_bus *m_bus;
+	void *r_data;		/* Use container_of instead? */
+
+	void (*rnf_submit)(void *data, struct urb *urb);
+	void (*rnf_complete)(void *data, struct urb *urb);
+};
+
+void mon_reader_add(struct mon_bus *mbus, struct mon_reader *r);
+void mon_reader_del(struct mon_bus *mbus, struct mon_reader *r);
+
+extern struct semaphore mon_lock;
+
+extern struct file_operations mon_fops_text;
+extern struct file_operations mon_fops_stat;
+
+#endif /* __USB_MON_H */
diff -urpN -X dontdiff linux-2.6.11-rc2/include/linux/usb.h linux-2.6.11-rc2-lem/include/linux/usb.h
--- linux-2.6.11-rc2/include/linux/usb.h	2005-01-22 14:54:39.000000000 -0800
+++ linux-2.6.11-rc2-lem/include/linux/usb.h	2005-01-23 00:42:32.000000000 -0800
@@ -285,6 +285,10 @@ struct usb_bus {
 
 	struct class_device class_dev;	/* class device for this bus */
 	void (*release)(struct usb_bus *bus);	/* function to destroy this bus's memory */
+#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+	struct mon_bus *mon_bus;	/* non-null when associated */
+	int monitored;			/* non-zero when monitored */
+#endif
 };
 #define	to_usb_bus(d) container_of(d, struct usb_bus, class_dev)
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbULTIQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbULTIQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbULTIB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:01:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54193 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261485AbULTHFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 02:05:04 -0500
Date: Sun, 19 Dec 2004 23:04:54 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: zaitcev@redhat.com
Cc: linux-usb-devel@lists.sourcefoge.net, linux-kernel@vger.kernel.org,
       <laforge@gnumonks.org>, greg@kroah.com
Subject: My vision of usbmon
Message-ID: <20041219230454.5b7f83e3@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guys:

This is usbmon which I cooked up because I got tired from adding dbg()'s
and polluting my dmesg. I use it to hunt bugs in USB storage devices so
far, and it's useful, although limited at this stage.

I looked at the Harding's USBmon patch, and I think he got a few things right.
The main of them is that I underestimated the benefits of placing the special
files into the filesystem namespace. When we discussed it with Greg in the
airport, we decided that having some sort of Netlink-style socket would be
the best option. I decided to make a u-turn and attach those sockets into
the namespace (currently under /dbg, but it can change). What this buys us is:

 1. cat(1): never bet against it. It's too handy. And netcat is just
    not the same.
 2. USBmon userland in Java. Just try to hack in JNI a little as I have
    and you'll see.

He also got some parts wrong. They are small things, but unfortunately,
pervasive. For example, he relies on urb->dev, which is not a good idea
in case of HCD which zero it far away from the completion call site, such
as usb-ohci in 2.4. And it's error-prone and a maintenance problem to
audit all HCDs and add usbmon calls. Races by design, too. Small things
like that, but many. Eventually, I wrote everything from scratch. It's
rather embarrassing that I could not save USBmon and gave in to NIH.

Since it's a big NIH, usbmon is not compatible with USBmon's userland.
It can be made compatible, but it needs a small adaptation layer,
because Harding aggregated at a device, and I do it on a bus
(I can explain why, but it's rather long; it has to do with hotplug
and races).

The architecture to support various output formats is present. Obvious
candidates are Old USBmon format and a Binary format. But it's not done.

Please ask if something is not obvious in the code.

Bye,
-- Pete

diff -urpN -X dontdiff linux-2.6.10-rc3/drivers/usb/Kconfig linux-2.6.10-rc3-usb/drivers/usb/Kconfig
--- linux-2.6.10-rc3/drivers/usb/Kconfig	2004-12-15 02:01:05.000000000 -0800
+++ linux-2.6.10-rc3-usb/drivers/usb/Kconfig	2004-12-15 13:36:33.000000000 -0800
@@ -56,6 +56,8 @@ source "drivers/usb/media/Kconfig"
 
 source "drivers/usb/net/Kconfig"
 
+source "drivers/usb/mon/Kconfig"
+
 comment "USB port drivers"
 	depends on USB
 
diff -urpN -X dontdiff linux-2.6.10-rc3/drivers/usb/Makefile linux-2.6.10-rc3-usb/drivers/usb/Makefile
--- linux-2.6.10-rc3/drivers/usb/Makefile	2004-12-15 02:01:05.000000000 -0800
+++ linux-2.6.10-rc3-usb/drivers/usb/Makefile	2004-12-15 13:49:26.000000000 -0800
@@ -6,6 +6,8 @@
 
 obj-$(CONFIG_USB)		+= core/
 
+obj-$(CONFIG_USB_MON)		+= mon/
+
 obj-$(CONFIG_USB_EHCI_HCD)	+= host/
 obj-$(CONFIG_USB_OHCI_HCD)	+= host/
 obj-$(CONFIG_USB_UHCI_HCD)	+= host/
diff -urpN -X dontdiff linux-2.6.10-rc3/drivers/usb/mon/Kconfig linux-2.6.10-rc3-usb/drivers/usb/mon/Kconfig
--- linux-2.6.10-rc3/drivers/usb/mon/Kconfig	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-rc3-usb/drivers/usb/mon/Kconfig	2004-12-15 19:56:54.000000000 -0800
@@ -0,0 +1,21 @@
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
+	depends on USB && SYSFS
+	default y
+	help
+	  If you say Y here, a component which captures the USB traffic
+	  between peripheral-specific drivers and HC drivers will be built.
+	  The USB_MON is similar in spirit and may be compatible with Dave
+	  Harding's USBMon.
+
+	  This is somewhat experimental at this time, but it should be safe.
+
+	  If unsure, say Y.
diff -urpN -X dontdiff linux-2.6.10-rc3/drivers/usb/mon/Makefile linux-2.6.10-rc3-usb/drivers/usb/mon/Makefile
--- linux-2.6.10-rc3/drivers/usb/mon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-rc3-usb/drivers/usb/mon/Makefile	2004-12-17 18:33:05.000000000 -0800
@@ -0,0 +1,7 @@
+#
+# Makefile for USB Core files and filesystem
+#
+
+usbmon-objs	:= mon_main.o mon_stat.o mon_text.o
+
+obj-$(CONFIG_USB_MON)	+= usbmon.o
diff -urpN -X dontdiff linux-2.6.10-rc3/drivers/usb/mon/mon_main.c linux-2.6.10-rc3-usb/drivers/usb/mon/mon_main.c
--- linux-2.6.10-rc3/drivers/usb/mon/mon_main.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-rc3-usb/drivers/usb/mon/mon_main.c	2004-12-19 21:04:13.852433525 -0800
@@ -0,0 +1,306 @@
+/*
+ * The USB Monitor, inspired by Dave Harding's USBMon.
+ *
+ * mon_main.c: Main file, module initiation and exit, registrations, etc.
+ *
+ * - If an URB was submitted before a reader opened a pipe, it's not tracked.
+ *   The only solution is to reject intercept-on-open and do intercept-always.
+ * - Hotplugging HCs will cause usbmon to crash on unload
+ * - Type files as fifos, sockets, or character specials? /proc/kmsg is regular.
+ * - Awaken rmmod when outstanding URBs and opens are gone.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/debugfs.h>
+#include <linux/smp_lock.h>
+
+#include "usb_mon.h"
+
+/* XXX Currently in drivers/usb/core/hcd.h */
+extern struct list_head usb_bus_list;
+extern struct semaphore usb_bus_list_lock;
+
+static int mon_submit(struct urb *urb, int mem_flags);
+static void mon_complete(struct urb *urb, struct pt_regs *regs);
+static void mon_cleanup(struct mon_bus *mbus);
+
+DECLARE_MUTEX(mon_lock);
+
+static struct dentry *mon_dir;		/* /dbg/usbmon */
+static LIST_HEAD(mon_buses);		/* All buses we know: struct mon_bus */
+
+/*
+ * Link a reader into the bus.
+ */
+void mon_reader_add(struct mon_bus *mbus, struct mon_reader *r)
+{
+	unsigned long flags;
+	struct usb_bus *ubus;
+
+	spin_lock_irqsave(&mbus->lock, flags);
+	if (mbus->nreaders == 0 && mbus->nurbs == 0) {
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
+		memcpy(&mbus->shim_ops, ubus->op, sizeof(struct usb_operations));
+		mbus->shim_ops.submit_urb = mon_submit;
+		mbus->saved_op = ubus->op;
+		ubus->op = &mbus->shim_ops;
+		ubus->monitored = 1;
+	}
+	mbus->nreaders++;
+
+	list_add_tail(&r->r_link, &mbus->r_list);
+	spin_unlock_irqrestore(&mbus->lock, flags);
+}
+
+/*
+ * Unlink reader from the bus.
+ */
+void mon_reader_del(struct mon_bus *mbus, struct mon_reader *r)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mbus->lock, flags);
+	list_del(&r->r_link);
+	--mbus->nreaders;
+	if (mbus->nreaders == 0 && mbus->nurbs == 0)
+		mon_cleanup(mbus);
+	spin_unlock_irqrestore(&mbus->lock, flags);
+}
+
+/*
+ */
+static int mon_submit(struct urb *urb, int mem_flags)
+{
+	struct mon_bus *mbus;
+	unsigned long flags;
+	struct list_head *pos;
+	struct mon_reader *r;
+
+	mbus = urb->dev->bus->mon_bus;
+	if (mbus == NULL)
+		goto out_unlocked;
+
+	spin_lock_irqsave(&mbus->lock, flags);
+	if (mbus->nreaders == 0)
+		goto out_locked;
+
+	urb->mon_bus = mbus;
+	urb->mon_saved_complete = urb->complete;
+	urb->complete = mon_complete;
+	mbus->nurbs++;
+
+	list_for_each (pos, &mbus->r_list) {
+		r = list_entry(pos, struct mon_reader, r_link);
+		r->rnf_submit(r->r_data, urb);
+	}
+out_locked:
+	spin_unlock_irqrestore(&mbus->lock, flags);
+out_unlocked:
+	return mbus->saved_op->submit_urb(urb, mem_flags);
+	/* Woops, we forgot to deliver success or failure to the reader */
+}
+
+/*
+ * This is called by an HC driver directly.
+ */
+static void mon_complete(struct urb *urb, struct pt_regs *regs)
+{
+	struct mon_bus *mbus;
+	unsigned long flags;
+	struct list_head *pos;
+	struct mon_reader *r;
+
+	mbus = urb->mon_bus;
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
+
+	/*
+	 * Drop the URB from tracking.
+	 * XXX ISOs and Interrupt get lost after the first complete this way.
+	 */
+	urb->complete = urb->mon_saved_complete;
+	urb->mon_bus = NULL;
+	--mbus->nurbs;
+	if (mbus->nurbs == 0 && mbus->nreaders == 0)
+		mon_cleanup(mbus);
+	spin_unlock_irqrestore(&mbus->lock, flags);
+
+	(*urb->complete)(urb, regs);
+}
+
+/* int (*unlink_urb) (struct urb *urb, int status); */
+
+/*
+ * Stop monitoring.
+ * Obviously this must be well locked, so no need to play with mb's.
+ */
+static void mon_cleanup(struct mon_bus *mbus)
+{
+	struct usb_bus *ubus = mbus->u_bus;
+
+	ubus->op = mbus->saved_op;
+	ubus->monitored = 0;
+	mbus->saved_op = NULL;
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
+	spin_lock_init(&mbus->lock);
+	INIT_LIST_HEAD(&mbus->r_list);
+
+	/* XXX Is this how I pin struct bus? Ask linux-usb-devel */
+	kobject_get(&ubus->class_dev.kobj);
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
+	struct usb_bus *ubus;
+	struct list_head *p;
+
+	down(&usb_bus_list_lock);	/* Needed for kobject_put's ? */
+	down(&mon_lock);
+	while (!list_empty(&mon_buses)) {
+		p = mon_buses.next;
+		mbus = list_entry(p, struct mon_bus, bus_link);
+		list_del(p);
+
+		if (mbus->nurbs) {
+			printk(KERN_ERR TAG
+			    ": Stuck URBs (%d) on usb%d, hanging...\n",
+			    mbus->nurbs, mbus->u_bus->busnum);
+			up(&mon_lock);
+			up(&usb_bus_list_lock);
+			for (;;) {
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule();
+			}
+		}
+		if (mbus->nreaders) {
+			printk(KERN_ERR TAG
+			    ": Outstanding opens (%d) on usb%d, hanging...\n",
+			    mbus->nreaders, mbus->u_bus->busnum);
+			up(&mon_lock);
+			up(&usb_bus_list_lock);
+			for (;;) {
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule();
+			}
+		}
+
+		ubus = mbus->u_bus;
+		ubus->mon_bus = NULL;
+		mb();
+
+		/* XXX This also should be done in hot-remove path */
+		debugfs_remove(mbus->dent_t);
+		debugfs_remove(mbus->dent_s);
+		kobject_put(&ubus->class_dev.kobj);
+		kfree(mbus);
+	}
+	up(&mon_lock);
+	up(&usb_bus_list_lock);
+
+	debugfs_remove(mon_dir);
+}
+
+module_init(mon_init);
+module_exit(mon_exit);
+
+MODULE_LICENSE("GPL");
diff -urpN -X dontdiff linux-2.6.10-rc3/drivers/usb/mon/mon_stat.c linux-2.6.10-rc3-usb/drivers/usb/mon/mon_stat.c
--- linux-2.6.10-rc3/drivers/usb/mon/mon_stat.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-rc3-usb/drivers/usb/mon/mon_stat.c	2004-12-19 14:06:03.306311947 -0800
@@ -0,0 +1,75 @@
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
+#include <linux/module.h>
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
+	    "nreaders %d saved_op 0x%lx nurbs %d text_lost %u\n",
+	    mbus->nreaders, (long) mbus->saved_op, mbus->nurbs,
+	    mbus->cnt_text_lost);
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
+	.open =		mon_stat_open,
+	.llseek =	no_llseek,
+	.read =		mon_stat_read,
+	/* .write =	mon_stat_write, */
+	/* .poll =		mon_stat_poll, */
+	/* .ioctl =	mon_stat_ioctl, */
+	.release =	mon_stat_release,
+};
diff -urpN -X dontdiff linux-2.6.10-rc3/drivers/usb/mon/mon_text.c linux-2.6.10-rc3-usb/drivers/usb/mon/mon_text.c
--- linux-2.6.10-rc3/drivers/usb/mon/mon_text.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-rc3-usb/drivers/usb/mon/mon_text.c	2004-12-19 21:14:55.726702896 -0800
@@ -0,0 +1,295 @@
+/*
+ * The USB Monitor, inspired by Dave Harding's USBMon.
+ *
+ * This is a text format reader.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/usb.h>
+#include <asm/uaccess.h>
+
+#include "usb_mon.h"
+
+/*
+ * The limit exists to prevent OOMs when the user process stops reading.
+ */
+#define EVENT_MAX  100
+
+#define PRINTF_DFL  100
+
+struct mon_event_text {
+	struct list_head e_link;
+	int type;		/* submit, complete, etc. */
+	unsigned int pipe;	/* Pipe */
+	unsigned long id;	/* From pointer, most of the time */
+	/* To add: timestamp */
+	int length;		/* Depends on type: xfer length or act length */
+	int status;
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
+ * May be called from an interrupt.
+ *
+ * This is called with the whole mon_bus locked, so no additional lock.
+ */
+static void mon_text_submit(void *data, struct urb *urb)
+{
+	struct mon_reader_text *rp = data;
+	struct mon_event_text *ep;
+
+	if (rp->nevents >= EVENT_MAX ||
+	    (ep = kmem_cache_alloc(rp->e_slab, SLAB_ATOMIC)) == NULL) {
+		rp->r.m_bus->cnt_text_lost++;
+		return;
+	}
+
+	ep->type = 'S';
+	ep->pipe = urb->pipe;
+	ep->id = (unsigned long) urb;
+	ep->length = urb->transfer_buffer_length;
+	ep->status = urb->status;	/* Let's watch what dirt ULPs supply */
+
+	rp->nevents++;
+	list_add_tail(&ep->e_link, &rp->e_list);
+	wake_up(&rp->wait);
+}
+
+/*
+ * May be called from an interrupt.
+ *
+ * This is called with the whole mon_bus locked, so no additional lock.
+ */
+static void mon_text_complete(void *data, struct urb *urb)
+{
+	struct mon_reader_text *rp = data;
+	struct mon_event_text *ep;
+
+	if (rp->nevents >= EVENT_MAX ||
+	    (ep = kmem_cache_alloc(rp->e_slab, SLAB_ATOMIC)) == NULL) {
+		rp->r.m_bus->cnt_text_lost++;
+		return;
+	}
+
+	ep->type = 'C';
+	ep->pipe = urb->pipe;
+	ep->id = (unsigned long) urb;
+	ep->length = urb->actual_length;
+	ep->status = urb->status;
+
+	rp->nevents++;
+	list_add_tail(&ep->e_link, &rp->e_list);
+	wake_up(&rp->wait);
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
+	int cnt;
+
+	add_wait_queue(&rp->wait, &waita);
+	while ((ep = mon_text_fetch(rp, mbus)) == NULL) {
+		if (file->f_flags & O_NONBLOCK) {
+			remove_wait_queue(&rp->wait, &waita);
+			return -EWOULDBLOCK;	/* Same as EAGAIN in Linux */
+		}
+		/*
+		 * We do not count nwaiters, because ->release is supposed
+		 * to be called when all openers are gone only.
+		 */
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+		if (signal_pending(current)) {
+			remove_wait_queue(&rp->wait, &waita);
+			return -EINTR;
+		}
+	}
+	remove_wait_queue(&rp->wait, &waita);
+
+	down(&rp->printf_lock);
+	cnt = snprintf(rp->printf_buf, rp->printf_size,
+	    "%lx 0 %c %08x %d %d\n",
+	    ep->id, ep->type, ep->pipe, ep->status, ep->length);
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
+	struct usb_bus *ubus;
+	unsigned long flags;
+	struct list_head *p;
+	struct mon_event_text *ep;
+
+	down(&mon_lock);
+	mbus = inode->u.generic_ip;
+	ubus = mbus->u_bus;
+
+	if (mbus->nreaders <= 0) {
+		printk(KERN_ERR TAG ": consistency error on close\n");
+		up(&mon_lock);
+		return 0;
+	}
+	mon_reader_del(mbus, &rp->r);
+
+	spin_lock_irqsave(&mbus->lock, flags);
+	while (!list_empty(&rp->e_list)) {
+		p = rp->e_list.next;
+		ep = list_entry(p, struct mon_event_text, e_link);
+		list_del(p);
+		--rp->nevents;
+		kmem_cache_free(rp->e_slab, ep);
+	}
+	spin_unlock_irqrestore(&mbus->lock, flags);
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
diff -urpN -X dontdiff linux-2.6.10-rc3/drivers/usb/mon/usb_mon.h linux-2.6.10-rc3-usb/drivers/usb/mon/usb_mon.h
--- linux-2.6.10-rc3/drivers/usb/mon/usb_mon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.10-rc3-usb/drivers/usb/mon/usb_mon.h	2004-12-19 14:07:51.351399563 -0800
@@ -0,0 +1,59 @@
+/*
+ * The USB Monitor, inspired by Dave Harding's USBMon.
+ */
+
+#ifndef __USB_MON_H
+#define __USB_MON_H
+
+#include <linux/list.h>
+#include <linux/slab.h>
+/* #include <linux/usb.h> */
+#include "../core/hcd.h"   /* XXX Move mon to core or move this to include/ */
+
+#define TAG "usbmon"
+
+struct mon_urb {
+	struct list_head link;
+	struct urb *urb;
+	// struct usb_dev *dev;
+};
+
+struct mon_bus {
+	struct list_head bus_link;
+	spinlock_t lock;
+	int nurbs;			/* Number of tracked URBs */
+	struct dentry *dent_s;		/* Debugging file */
+	struct dentry *dent_t;		/* Text interface file */
+	struct usb_bus *u_bus;
+
+	/* Ref */
+	int nreaders;
+	struct list_head r_list;	/* Chain of readers (usually one) */
+	struct usb_operations *saved_op;
+	struct usb_operations shim_ops;
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
diff -urpN -X dontdiff linux-2.6.10-rc3/include/linux/usb.h linux-2.6.10-rc3-usb/include/linux/usb.h
--- linux-2.6.10-rc3/include/linux/usb.h	2004-12-15 02:01:18.000000000 -0800
+++ linux-2.6.10-rc3-usb/include/linux/usb.h	2004-12-19 15:13:03.289200450 -0800
@@ -254,6 +254,7 @@ struct usb_bus {
 	u8 otg_port;			/* 0, or number of OTG/HNP port */
 	unsigned is_b_host:1;		/* true during some HNP roleswitches */
 	unsigned b_hnp_enable:1;	/* OTG: did A-Host enable HNP? */
+	unsigned monitored:1;		/* usbmon is active on this bus */
 
 	int devnum_next;		/* Next open device number in round-robin allocation */
 
@@ -277,6 +278,9 @@ struct usb_bus {
 
 	struct class_device class_dev;	/* class device for this bus */
 	void (*release)(struct usb_bus *bus);	/* function to destroy this bus's memory */
+#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+	struct mon_bus *mon_bus;
+#endif
 };
 #define	to_usb_bus(d) container_of(d, struct usb_bus, class_dev)
 
@@ -804,6 +808,10 @@ struct urb
 	int error_count;		/* (return) number of ISO errors */
 	void *context;			/* (in) context for completion */
 	usb_complete_t complete;	/* (in) completion routine */
+#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
+	usb_complete_t mon_saved_complete;	/* (core private) */
+	struct mon_bus *mon_bus;		/* (core private) */
+#endif
 	struct usb_iso_packet_descriptor iso_frame_desc[0];	/* (in) ISO ONLY */
 };
 

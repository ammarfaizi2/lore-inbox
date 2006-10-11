Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWJKI4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWJKI4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 04:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030682AbWJKI4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 04:56:48 -0400
Received: from smtp-out1.email.it ([80.247.70.36]:16282 "EHLO
	smtp-out1.email.it") by vger.kernel.org with ESMTP id S1030681AbWJKI4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 04:56:46 -0400
Subject: [PATCH] usbmon: add binary interface
From: Paolo Abeni <paolo.abeni@email.it>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Type: text/plain
Date: Wed, 11 Oct 2006 10:57:45 +0200
Message-Id: <1160557065.9547.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-Copyrighted-Material: Please visit http://www.email.it/ita/privacy.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <paolo.abeni@email.it>

A binary interface is added to usbmon. For each USB bus present on the host system a new file is added to the debugfs directory, in the form "usb%db".

USB records are stored in a liked list, alike current text interface implementation, so most code is shared from binary and text interface.
This code has been moved into mon_commom.c.

The binary interface support resizing the amount of USB data stored in each record via an ioctl method.

Signed-off-by: Paolo Abeni <paolo.abeni@email.it>

---
patch against linux 2.6.18
 Makefile     |    2
 mon_binary.c |  203 ++++++++++++++++++++++++++++++++++++
 mon_common.c |  329 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mon_main.c   |   13 ++
 mon_stat.c   |    4
 mon_text.c   |  319 +++++++--------------------------------------------------
 usb_mon.h    |   46 ++++++++

diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/drivers/usb/mon/Makefile linux-2.6.18-monioctl/drivers/usb/mon/Makefile
--- linux-2.6.18-vanilla/drivers/usb/mon/Makefile	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18-monioctl/drivers/usb/mon/Makefile	2006-10-10 10:18:25.000000000 +0200
@@ -2,7 +2,7 @@
 # Makefile for USB Core files and filesystem
 #
 
-usbmon-objs	:= mon_main.o mon_stat.o mon_text.o mon_dma.o
+usbmon-objs	:= mon_main.o mon_stat.o mon_text.o mon_dma.o mon_common.o mon_binary.o
 
 # This does not use CONFIG_USB_MON because we want this to use a tristate.
 obj-$(CONFIG_USB)	+= usbmon.o
diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/drivers/usb/mon/mon_binary.c linux-2.6.18-monioctl/drivers/usb/mon/mon_binary.c
--- linux-2.6.18-vanilla/drivers/usb/mon/mon_binary.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.18-monioctl/drivers/usb/mon/mon_binary.c	2006-10-11 10:52:16.000000000 +0200
@@ -0,0 +1,203 @@
+/*
+ * The USB Monitor, inspired by Dave Harding's USBMon.
+ *
+ * This is a binary format reader.
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/usb.h>
+#include <linux/time.h>
+#include <linux/mutex.h>
+#include <linux/ioctl.h>
+#include <asm/uaccess.h>
+
+#include "usb_mon.h"
+
+/* ioctl macros */
+#define MON_IOC_MAGIC 0x92
+
+#define MON_IOCT_DATA_MAX _IO(MON_IOC_MAGIC, 1)
+#define MON_IOCG_DATA_MAX _IOR(MON_IOC_MAGIC, 2, u32)
+
+#define MON_IOC_MAXNR	2
+
+/*
+ */
+static int mon_binary_open(struct inode *inode, struct file *file)
+{
+	struct mon_bus *mbus;
+	struct mon_reader_list *rp;
+	int rc;
+
+	mutex_lock(&mon_lock);
+	mbus = inode->u.generic_ip;
+
+	rp = kzalloc(sizeof(struct mon_reader_list), GFP_KERNEL);
+	if (rp == NULL) {
+		rc = -ENOMEM;
+		goto err_alloc;
+	}
+	
+	if ((rc = mon_list_init(rp, mbus, 'b')) < 0)
+	    	goto err_alloc_pr;
+
+	mon_reader_add(mbus, &rp->r);
+
+	file->private_data = rp;
+	mutex_unlock(&mon_lock);
+	return 0;
+
+err_alloc_pr:
+	kfree(rp);
+err_alloc:
+	mutex_unlock(&mon_lock);
+	return rc;
+}
+
+/*
+ * For simplicity, we read one record in one system call and throw out
+ * what does not fit. This means that the following does not work:
+ *   dd if=/dbg/usbmon/0t bs=10
+ * Also, we do not allow seeks and do not bother advancing the offset.
+ */
+static ssize_t mon_binary_read(struct file *file, char __user *buf,
+				size_t nbytes, loff_t *ppos)
+{
+	struct mon_reader_list *rp = file->private_data;
+	struct mon_bus *mbus = rp->r.m_bus;
+	DECLARE_WAITQUEUE(waita, current);
+	struct mon_event_list *ep;
+	int cnt, hdr_bytes, data_bytes, setup_bytes;
+	int data_len = 0;
+	int setup_len = 0;
+	
+	add_wait_queue(&rp->wait, &waita);
+	set_current_state(TASK_INTERRUPTIBLE);
+	while ((ep = mon_list_fetch(rp, mbus)) == NULL) {
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
+	/* check out how much URB data is present in this buffer*/
+	if ((ep->hdr.length > 0) && (ep->hdr.data_flag == 0))
+		data_len = (ep->hdr.length > rp->data_max) ? rp->data_max: 
+								ep->hdr.length;
+	
+	/* avoid overrun user buffer; copy as much data as possible*/
+	hdr_bytes = sizeof(struct mon_event_list) > nbytes ? nbytes: 
+						sizeof(struct mon_event_list);
+	nbytes -= hdr_bytes;
+	if (ep->hdr.setup_flag == 0)
+		setup_len = SETUP_MAX;
+	setup_bytes =  setup_len > nbytes ? nbytes : setup_len;
+	nbytes -= setup_bytes;
+	data_bytes = data_len > nbytes ? nbytes: data_len;
+	
+	cnt = hdr_bytes + setup_bytes + data_bytes;
+	if (copy_to_user(buf, ep, hdr_bytes))
+	{
+		cnt = -EFAULT;
+		goto out;
+	}
+	if ((setup_bytes > 0) && copy_to_user(buf+hdr_bytes, ep->setup, 
+								setup_bytes))
+	{
+		cnt = -EFAULT;
+		goto out;
+	}
+	if ((data_bytes > 0) && copy_to_user(buf+hdr_bytes, ep->data, 
+								data_bytes))
+		cnt = -EFAULT;
+out:        
+	kmem_cache_free(rp->e_slab, ep);
+	return cnt;
+}
+
+static int mon_binary_release(struct inode *inode, struct file *file)
+{
+	struct mon_reader_list *rp = file->private_data;
+	struct mon_bus *mbus;
+	/* unsigned long flags; */
+
+	mutex_lock(&mon_lock);
+	mbus = inode->u.generic_ip;
+
+	if (mbus->nreaders <= 0) {
+		printk(KERN_ERR TAG ": consistency error on close\n");
+		mutex_unlock(&mon_lock);
+		return 0;
+	}
+	mon_reader_del(mbus, &rp->r);
+	
+	mon_list_destroy(rp);
+	kfree(rp);
+
+	mutex_unlock(&mon_lock);
+	return 0;
+}
+
+static int mon_binary_ioctl(struct inode *inode, struct file *file, 
+    unsigned int cmd, unsigned long arg)
+{
+	unsigned new_data_max;
+	struct mon_reader_list *rp;
+	int ret = 0;
+	 
+	/* basic sanity check */	
+	if (!(rp = file->private_data))
+		return -ENODEV;
+	if (_IOC_TYPE(cmd) != MON_IOC_MAGIC)
+		return -ENOTTY;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	
+	switch (cmd) {
+	case MON_IOCG_DATA_MAX:
+		if (put_user(rp->data_max, (u32 __user *)arg))
+			ret = -EFAULT;
+		break;
+		
+	case MON_IOCT_DATA_MAX:
+		new_data_max = arg;
+		if (new_data_max == rp->data_max)
+			break;
+		
+		/* try to allocate new buffer before relasing old one
+		 * to be safe*/
+		ret = mon_list_resize(rp, new_data_max);
+		break;
+		
+	default:
+		ret = -ENOTTY;
+		break;		
+	}
+
+	return ret;    	
+}
+
+struct file_operations mon_fops_binary = {
+	.owner =	THIS_MODULE,
+	.open =		mon_binary_open,
+	.llseek =	no_llseek,
+	.read =		mon_binary_read,
+	/* .write =	mon_text_write, */
+	/* .poll =		mon_text_poll, */
+	.ioctl =	mon_binary_ioctl,
+	.release =	mon_binary_release,
+};
diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/drivers/usb/mon/mon_common.c linux-2.6.18-monioctl/drivers/usb/mon/mon_common.c
--- linux-2.6.18-vanilla/drivers/usb/mon/mon_common.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.18-monioctl/drivers/usb/mon/mon_common.c	2006-10-10 22:04:23.000000000 +0200
@@ -0,0 +1,329 @@
+/*
+ * The USB Monitor, inspired by Dave Harding's USBMon.
+ *
+ * This are common function used by both text and binary reader
+ */
+ 
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/usb.h>
+#include <linux/time.h>
+#include <linux/mutex.h>
+#include <asm/uaccess.h>
+
+#include "usb_mon.h"
+
+/*
+ * This limit can be changed using ioctl
+ */
+#define DATA_DFL  32
+#define DATA_MIN  16
+#define DATA_MAX  1024
+
+/*
+ * This limit exists to prevent OOMs when the user process stops reading.
+ * If usbmon were available to unprivileged processes, it might be open
+ * to a local DoS. But we have to keep to root in order to prevent
+ * password sniffing from HID devices.
+ */
+#define EVENT_MAX  (2*PAGE_SIZE / sizeof(struct mon_event_list))
+
+static void mon_list_ctor(void *, kmem_cache_t *, unsigned long);
+
+/*
+ * mon_list_submit
+ * mon_list_complete
+ *
+ * May be called from an interrupt.
+ *
+ * This is called with the whole mon_bus locked, so no additional lock.
+ */
+
+static inline char mon_list_get_setup(struct mon_event_list *ep,
+    struct urb *urb, char ev_type)
+{
+
+	if (!usb_pipecontrol(urb->pipe) || ev_type != 'S')
+		return '-';
+
+	if (urb->transfer_flags & URB_NO_SETUP_DMA_MAP)
+		return mon_dmapeek(ep->setup, urb->setup_dma, SETUP_MAX);
+	if (urb->setup_packet == NULL)
+		return 'Z';	/* '0' would be not as pretty. */
+
+	memcpy(ep->setup, urb->setup_packet, SETUP_MAX);
+	return 0;
+}
+
+static inline char mon_list_get_data(struct mon_event_list *ep, struct urb *urb,
+    int len, char ev_type, int data_max)
+{
+	int pipe = urb->pipe;
+
+	if (len <= 0)
+		return 'L';
+	if (len >= data_max)
+		len = data_max;
+
+	if (usb_pipein(pipe)) {
+		if (ev_type == 'S')
+			return '<';
+	} else {
+		if (ev_type == 'C')
+			return '>';
+	}
+
+	/*
+	 * The check to see if it's safe to poke at data has an enormous
+	 * number of corner cases, but it seems that the following is
+	 * more or less safe.
+	 *
+	 * We do not even try to look at transfer_buffer, because it can
+	 * contain non-NULL garbage in case the upper level promised to
+	 * set DMA for the HCD.
+	 */
+	if (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)
+		return mon_dmapeek(ep->data, urb->transfer_dma, len);
+
+	if (urb->transfer_buffer == NULL)
+		return 'Z';	/* '0' would be not as pretty. */
+
+	memcpy(ep->data, urb->transfer_buffer, len);
+	return 0;
+}
+
+/*
+ * [Re]allocate slab cache accoring to specified sizes.
+ * Temporary remove reader from reader list during resize.
+ */
+int mon_list_resize(struct mon_reader_list* rp, int data_max)
+{
+	unsigned long flags;
+	int pos;
+	kmem_cache_t * new_e_slab;
+	char id;
+	char new_name[SLAB_NAME_SZ];
+	int ret=0;
+    
+	/* we want to avoil large memory consumption and have an usable amount
+	 * of data */
+	if ((data_max < DATA_MIN)|| (data_max > DATA_MAX))
+		return -EINVAL;
+	    
+    	/* remove this reader from list to avoid urb_submit accessing slab 
+	 * cache*/
+    	mutex_lock(&mon_lock);
+    	mon_reader_del(rp->r.m_bus, &rp->r);
+    	mutex_unlock(&mon_lock);
+    
+	/* avoid trying to create two slab with same name: it will fail
+	 * swap the last char from '0' to '1' and vice versa*/
+	strcpy(new_name, rp->slab_name);
+	pos = strlen(new_name) - 1;
+	id = new_name[pos];
+	new_name[pos] = (1 - (id - '0')) + '0';
+	
+	if ((new_e_slab = kmem_cache_create(new_name,
+	    sizeof(struct mon_event_list)+data_max, sizeof(long), 0,
+	    mon_list_ctor, NULL)) == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* event list must be flushed because old entries have different size */
+	spin_lock_irqsave(&rp->r.m_bus->lock, flags);
+	INIT_LIST_HEAD(&rp->e_list);
+	rp->nevents = 0;
+	spin_unlock_irqrestore(&rp->r.m_bus->lock, flags);
+	rp->data_max = data_max;
+	strcpy(rp->slab_name, new_name);
+	
+out:	
+	mutex_lock(&mon_lock);
+	mon_reader_add(rp->r.m_bus, &rp->r);
+	mutex_unlock(&mon_lock);
+	return ret;
+}
+
+static inline struct mon_event_list * mon_event_alloc(
+    struct mon_reader_list *rp)
+{
+	struct mon_event_list *ep = kmem_cache_alloc(rp->e_slab, SLAB_ATOMIC);
+	if (!ep)
+		return 0;
+	ep->data = ((unsigned char*)ep) + sizeof(struct mon_event_list);
+	return ep;
+}
+
+/* 
+ * Convert a pointer to u64, avoiding arch dependent issue
+ */
+static u64 mon_make_id(void* urb)
+{
+	union {
+		void * ptr;
+		u64 data;
+	} converter;
+	converter.data = 0;
+	converter.ptr = urb;
+	return converter.data;
+}
+
+static void mon_list_event(struct mon_reader_list *rp, struct urb *urb,
+    char ev_type)
+{
+	struct mon_event_list *ep;
+
+	if (rp->nevents >= EVENT_MAX ||
+	    (ep = mon_event_alloc(rp)) == NULL) {
+		rp->r.m_bus->cnt_lost++;
+		return;
+	}
+
+	ep->hdr.type = ev_type;
+	ep->hdr.pipe = urb->pipe;
+	ep->hdr.id = mon_make_id(urb);
+	do_gettimeofday(&ep->hdr.tstamp);
+	ep->hdr.length = (ev_type == 'S') ?
+	    urb->transfer_buffer_length : urb->actual_length;
+	/* Collecting status makes debugging sense for submits, too */
+	ep->hdr.status = urb->status;
+
+	ep->hdr.setup_flag = mon_list_get_setup(ep, urb, ev_type);
+	ep->hdr.data_flag = mon_list_get_data(ep, urb, ep->hdr.length, ev_type, 
+	    rp->data_max);
+
+	rp->nevents++;
+	list_add_tail(&ep->e_link, &rp->e_list);
+	wake_up(&rp->wait);
+}
+
+static void mon_list_submit(void *data, struct urb *urb)
+{
+	struct mon_reader_list *rp = data;
+	mon_list_event(rp, urb, 'S');
+}
+
+static void mon_list_complete(void *data, struct urb *urb)
+{
+	struct mon_reader_list *rp = data;
+	mon_list_event(rp, urb, 'C');
+}
+
+static void mon_list_error(void *data, struct urb *urb, int error)
+{
+	struct mon_reader_list *rp = data;
+	struct mon_event_list *ep;
+
+	if (rp->nevents >= EVENT_MAX ||
+	    (ep = mon_event_alloc(rp)) == NULL) {
+		rp->r.m_bus->cnt_lost++;
+		return;
+	}
+
+	ep->hdr.type = 'E';
+	ep->hdr.pipe = urb->pipe;
+	ep->hdr.id = mon_make_id(urb);
+	ep->hdr.tstamp.tv_sec = 0;
+	ep->hdr.tstamp.tv_usec = 0;
+	ep->hdr.length = 0;
+	ep->hdr.status = error;
+
+	ep->hdr.setup_flag = '-';
+	ep->hdr.data_flag = 'E';
+
+	rp->nevents++;
+	list_add_tail(&ep->e_link, &rp->e_list);
+	wake_up(&rp->wait);
+}
+
+/*
+ * Fetch next event from the circular buffer.
+ */
+struct mon_event_list *mon_list_fetch(struct mon_reader_list *rp,
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
+	return list_entry(p, struct mon_event_list, e_link);
+}
+
+/* 
+ * Initialize list reader. Must be called with mon_lock hold and before 
+ * mon_reader_add
+ */
+int mon_list_init(struct mon_reader_list* rp, struct mon_bus *mbus, char type)
+{
+    	struct usb_bus *ubus = mbus->u_bus;
+	    
+	INIT_LIST_HEAD(&rp->e_list);
+	init_waitqueue_head(&rp->wait);
+    
+	rp->r.m_bus = mbus;
+	rp->r.r_data = rp;
+	rp->r.rnf_submit = mon_list_submit;
+	rp->r.rnf_error = mon_list_error;
+	rp->r.rnf_complete = mon_list_complete;
+
+	snprintf(rp->slab_name, SLAB_NAME_SZ, "mon%d%c_%lx", ubus->busnum, type,
+	    (long)rp);
+	rp->data_max = DATA_DFL;
+	rp->e_slab = kmem_cache_create(rp->slab_name,
+	    sizeof(struct mon_event_list)+rp->data_max, sizeof(long), 0,
+	    mon_list_ctor, NULL);
+	if (rp->e_slab == NULL) 
+		return -ENOMEM;
+	return 0;
+}
+
+/* 
+ * Destroy list reader. Must be called after mon_reader_del. 
+ * rp must be deallocated explicitly out of here
+ */
+void mon_list_destroy(struct mon_reader_list* rp)
+{
+	struct list_head *p;
+	struct mon_event_list *ep;
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
+		ep = list_entry(p, struct mon_event_list, e_link);
+		list_del(p);
+		--rp->nevents;
+		kmem_cache_free(rp->e_slab, ep);
+	}
+	/* spin_unlock_irqrestore(&mbus->lock, flags); */
+
+	kmem_cache_destroy(rp->e_slab);
+}
+
+
+/*
+ * Slab interface: constructor.
+ */
+static void mon_list_ctor(void *mem, kmem_cache_t *slab, unsigned long sflags)
+{
+	/*
+	 * Nothing to initialize. No, really!
+	 * So, we fill it with garbage to emulate a reused object.
+	 */
+	memset(mem, 0xe5, kmem_cache_size(slab));
+}
diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/drivers/usb/mon/mon_main.c linux-2.6.18-monioctl/drivers/usb/mon/mon_main.c
--- linux-2.6.18-vanilla/drivers/usb/mon/mon_main.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18-monioctl/drivers/usb/mon/mon_main.c	2006-10-10 22:04:58.000000000 +0200
@@ -214,6 +214,7 @@ static void mon_bus_remove(struct usb_bu
 	list_del(&mbus->bus_link);
 	debugfs_remove(mbus->dent_t);
 	debugfs_remove(mbus->dent_s);
+	debugfs_remove(mbus->dent_b);
 
 	mon_dissolve(mbus, ubus);
 	kref_put(&mbus->ref, mon_bus_drop);
@@ -320,11 +321,22 @@ static void mon_bus_init(struct dentry *
 		goto err_create_s;
 	mbus->dent_s = d;
 
+	rc = snprintf(name, NAMESZ, "%db", ubus->busnum);
+	if (rc <= 0 || rc >= NAMESZ)
+		goto err_print_b;
+	d = debugfs_create_file(name, 0600, mondir, mbus, &mon_fops_binary);
+	if (d == NULL)
+		goto err_create_b;
+	mbus->dent_b = d;
+
 	mutex_lock(&mon_lock);
 	list_add_tail(&mbus->bus_link, &mon_buses);
 	mutex_unlock(&mon_lock);
 	return;
 
+err_create_b:
+err_print_b:
+	debugfs_remove(mbus->dent_s);
 err_create_s:
 err_print_s:
 	debugfs_remove(mbus->dent_t);
@@ -384,6 +396,7 @@ static void __exit mon_exit(void)
 
 		debugfs_remove(mbus->dent_t);
 		debugfs_remove(mbus->dent_s);
+		debugfs_remove(mbus->dent_b);
 
 		/*
 		 * This never happens, because the open/close paths in
diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/drivers/usb/mon/mon_stat.c linux-2.6.18-monioctl/drivers/usb/mon/mon_stat.c
--- linux-2.6.18-vanilla/drivers/usb/mon/mon_stat.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18-monioctl/drivers/usb/mon/mon_stat.c	2006-10-10 11:57:03.000000000 +0200
@@ -31,8 +31,8 @@ static int mon_stat_open(struct inode *i
 	mbus = inode->u.generic_ip;
 
 	sp->slen = snprintf(sp->str, STAT_BUF_SIZE,
-	    "nreaders %d events %u text_lost %u\n",
-	    mbus->nreaders, mbus->cnt_events, mbus->cnt_text_lost);
+	    "nreaders %d events %u lost %u\n",
+	    mbus->nreaders, mbus->cnt_events, mbus->cnt_lost);
 
 	file->private_data = sp;
 	return 0;
diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/drivers/usb/mon/mon_text.c linux-2.6.18-monioctl/drivers/usb/mon/mon_text.c
--- linux-2.6.18-vanilla/drivers/usb/mon/mon_text.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18-monioctl/drivers/usb/mon/mon_text.c	2006-10-11 10:35:33.000000000 +0200
@@ -9,245 +9,54 @@
 #include <linux/usb.h>
 #include <linux/time.h>
 #include <linux/mutex.h>
+#include <linux/ioctl.h>
 #include <asm/uaccess.h>
 
 #include "usb_mon.h"
 
-/*
- * No, we do not want arbitrarily long data strings.
- * Use the binary interface if you want to capture bulk data!
- */
-#define DATA_MAX  32
-
-/*
- * Defined by USB 2.0 clause 9.3, table 9.2.
- */
-#define SETUP_MAX  8
+#define PRINTF_DFL  160
+#define PRINTF_MIN  120
 
-/*
- * This limit exists to prevent OOMs when the user process stops reading.
- * If usbmon were available to unprivileged processes, it might be open
- * to a local DoS. But we have to keep to root in order to prevent
- * password sniffing from HID devices.
- */
-#define EVENT_MAX  (2*PAGE_SIZE / sizeof(struct mon_event_text))
+/* ioctl macros */
+#define MON_IOC_MAGIC 0x92
 
-#define PRINTF_DFL  160
+#define MON_IOCT_DATA_MAX _IO(MON_IOC_MAGIC, 1)
+#define MON_IOCG_DATA_MAX _IOR(MON_IOC_MAGIC, 2, u32)
 
-struct mon_event_text {
-	struct list_head e_link;
-	int type;		/* submit, complete, etc. */
-	unsigned int pipe;	/* Pipe */
-	unsigned long id;	/* From pointer, most of the time */
-	unsigned int tstamp;
-	int length;		/* Depends on type: xfer length or act length */
-	int status;
-	char setup_flag;
-	char data_flag;
-	unsigned char setup[SETUP_MAX];
-	unsigned char data[DATA_MAX];
-};
+#define MON_IOC_MAXNR	2
 
-#define SLAB_NAME_SZ  30
 struct mon_reader_text {
-	kmem_cache_t *e_slab;
-	int nevents;
-	struct list_head e_list;
-	struct mon_reader r;	/* In C, parent class can be placed anywhere */
-
-	wait_queue_head_t wait;
+    	struct mon_reader_list l;
 	int printf_size;
 	char *printf_buf;
 	struct mutex printf_lock;
-
-	char slab_name[SLAB_NAME_SZ];
 };
 
-static void mon_text_ctor(void *, kmem_cache_t *, unsigned long);
-
-/*
- * mon_text_submit
- * mon_text_complete
- *
- * May be called from an interrupt.
- *
- * This is called with the whole mon_bus locked, so no additional lock.
- */
-
-static inline char mon_text_get_setup(struct mon_event_text *ep,
-    struct urb *urb, char ev_type)
-{
-
-	if (!usb_pipecontrol(urb->pipe) || ev_type != 'S')
-		return '-';
-
-	if (urb->transfer_flags & URB_NO_SETUP_DMA_MAP)
-		return mon_dmapeek(ep->setup, urb->setup_dma, SETUP_MAX);
-	if (urb->setup_packet == NULL)
-		return 'Z';	/* '0' would be not as pretty. */
-
-	memcpy(ep->setup, urb->setup_packet, SETUP_MAX);
-	return 0;
-}
-
-static inline char mon_text_get_data(struct mon_event_text *ep, struct urb *urb,
-    int len, char ev_type)
-{
-	int pipe = urb->pipe;
-
-	if (len <= 0)
-		return 'L';
-	if (len >= DATA_MAX)
-		len = DATA_MAX;
-
-	if (usb_pipein(pipe)) {
-		if (ev_type == 'S')
-			return '<';
-	} else {
-		if (ev_type == 'C')
-			return '>';
-	}
-
-	/*
-	 * The check to see if it's safe to poke at data has an enormous
-	 * number of corner cases, but it seems that the following is
-	 * more or less safe.
-	 *
-	 * We do not even try to look at transfer_buffer, because it can
-	 * contain non-NULL garbage in case the upper level promised to
-	 * set DMA for the HCD.
-	 */
-	if (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)
-		return mon_dmapeek(ep->data, urb->transfer_dma, len);
-
-	if (urb->transfer_buffer == NULL)
-		return 'Z';	/* '0' would be not as pretty. */
-
-	memcpy(ep->data, urb->transfer_buffer, len);
-	return 0;
-}
-
-static inline unsigned int mon_get_timestamp(void)
+static inline unsigned int mon_get_timestamp(struct timeval* tval)
 {
-	struct timeval tval;
 	unsigned int stamp;
 
-	do_gettimeofday(&tval);
-	stamp = tval.tv_sec & 0xFFFF;	/* 2^32 = 4294967296. Limit to 4096s. */
-	stamp = stamp * 1000000 + tval.tv_usec;
+	stamp = tval->tv_sec & 0xFFFF;	/* 2^32 = 4294967296. Limit to 4096s. */
+	stamp = stamp * 1000000 + tval->tv_usec;
 	return stamp;
 }
 
-static void mon_text_event(struct mon_reader_text *rp, struct urb *urb,
-    char ev_type)
-{
-	struct mon_event_text *ep;
-	unsigned int stamp;
-
-	stamp = mon_get_timestamp();
-
-	if (rp->nevents >= EVENT_MAX ||
-	    (ep = kmem_cache_alloc(rp->e_slab, SLAB_ATOMIC)) == NULL) {
-		rp->r.m_bus->cnt_text_lost++;
-		return;
-	}
-
-	ep->type = ev_type;
-	ep->pipe = urb->pipe;
-	ep->id = (unsigned long) urb;
-	ep->tstamp = stamp;
-	ep->length = (ev_type == 'S') ?
-	    urb->transfer_buffer_length : urb->actual_length;
-	/* Collecting status makes debugging sense for submits, too */
-	ep->status = urb->status;
-
-	ep->setup_flag = mon_text_get_setup(ep, urb, ev_type);
-	ep->data_flag = mon_text_get_data(ep, urb, ep->length, ev_type);
-
-	rp->nevents++;
-	list_add_tail(&ep->e_link, &rp->e_list);
-	wake_up(&rp->wait);
-}
-
-static void mon_text_submit(void *data, struct urb *urb)
-{
-	struct mon_reader_text *rp = data;
-	mon_text_event(rp, urb, 'S');
-}
-
-static void mon_text_complete(void *data, struct urb *urb)
-{
-	struct mon_reader_text *rp = data;
-	mon_text_event(rp, urb, 'C');
-}
-
-static void mon_text_error(void *data, struct urb *urb, int error)
-{
-	struct mon_reader_text *rp = data;
-	struct mon_event_text *ep;
-
-	if (rp->nevents >= EVENT_MAX ||
-	    (ep = kmem_cache_alloc(rp->e_slab, SLAB_ATOMIC)) == NULL) {
-		rp->r.m_bus->cnt_text_lost++;
-		return;
-	}
-
-	ep->type = 'E';
-	ep->pipe = urb->pipe;
-	ep->id = (unsigned long) urb;
-	ep->tstamp = 0;
-	ep->length = 0;
-	ep->status = error;
-
-	ep->setup_flag = '-';
-	ep->data_flag = 'E';
-
-	rp->nevents++;
-	list_add_tail(&ep->e_link, &rp->e_list);
-	wake_up(&rp->wait);
-}
-
-/*
- * Fetch next event from the circular buffer.
- */
-static struct mon_event_text *mon_text_fetch(struct mon_reader_text *rp,
-    struct mon_bus *mbus)
-{
-	struct list_head *p;
-	unsigned long flags;
-
-	spin_lock_irqsave(&mbus->lock, flags);
-	if (list_empty(&rp->e_list)) {
-		spin_unlock_irqrestore(&mbus->lock, flags);
-		return NULL;
-	}
-	p = rp->e_list.next;
-	list_del(p);
-	--rp->nevents;
-	spin_unlock_irqrestore(&mbus->lock, flags);
-	return list_entry(p, struct mon_event_text, e_link);
-}
-
 /*
  */
 static int mon_text_open(struct inode *inode, struct file *file)
 {
 	struct mon_bus *mbus;
-	struct usb_bus *ubus;
 	struct mon_reader_text *rp;
 	int rc;
 
 	mutex_lock(&mon_lock);
 	mbus = inode->u.generic_ip;
-	ubus = mbus->u_bus;
 
 	rp = kzalloc(sizeof(struct mon_reader_text), GFP_KERNEL);
 	if (rp == NULL) {
 		rc = -ENOMEM;
 		goto err_alloc;
 	}
-	INIT_LIST_HEAD(&rp->e_list);
-	init_waitqueue_head(&rp->wait);
 	mutex_init(&rp->printf_lock);
 
 	rp->printf_size = PRINTF_DFL;
@@ -256,24 +65,10 @@ static int mon_text_open(struct inode *i
 		rc = -ENOMEM;
 		goto err_alloc_pr;
 	}
+	if ((rc = mon_list_init(&rp->l, mbus, 't')) < 0)
+	    	goto err_list;
 
-	rp->r.m_bus = mbus;
-	rp->r.r_data = rp;
-	rp->r.rnf_submit = mon_text_submit;
-	rp->r.rnf_error = mon_text_error;
-	rp->r.rnf_complete = mon_text_complete;
-
-	snprintf(rp->slab_name, SLAB_NAME_SZ, "mon%dt_%lx", ubus->busnum,
-	    (long)rp);
-	rp->e_slab = kmem_cache_create(rp->slab_name,
-	    sizeof(struct mon_event_text), sizeof(long), 0,
-	    mon_text_ctor, NULL);
-	if (rp->e_slab == NULL) {
-		rc = -ENOMEM;
-		goto err_slab;
-	}
-
-	mon_reader_add(mbus, &rp->r);
+	mon_reader_add(mbus, &rp->l.r);
 
 	file->private_data = rp;
 	mutex_unlock(&mon_lock);
@@ -281,7 +76,7 @@ static int mon_text_open(struct inode *i
 
 // err_busy:
 //	kmem_cache_destroy(rp->e_slab);
-err_slab:
+err_list:
 	kfree(rp->printf_buf);
 err_alloc_pr:
 	kfree(rp);
@@ -300,20 +95,20 @@ static ssize_t mon_text_read(struct file
 				size_t nbytes, loff_t *ppos)
 {
 	struct mon_reader_text *rp = file->private_data;
-	struct mon_bus *mbus = rp->r.m_bus;
+	struct mon_bus *mbus = rp->l.r.m_bus;
 	DECLARE_WAITQUEUE(waita, current);
-	struct mon_event_text *ep;
+	struct mon_event_list *ep;
 	int cnt, limit;
 	char *pbuf;
 	char udir, utype;
 	int data_len, i;
 
-	add_wait_queue(&rp->wait, &waita);
+	add_wait_queue(&rp->l.wait, &waita);
 	set_current_state(TASK_INTERRUPTIBLE);
-	while ((ep = mon_text_fetch(rp, mbus)) == NULL) {
+	while ((ep = mon_list_fetch(&rp->l, mbus)) == NULL) {
 		if (file->f_flags & O_NONBLOCK) {
 			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&rp->wait, &waita);
+			remove_wait_queue(&rp->l.wait, &waita);
 			return -EWOULDBLOCK;	/* Same as EAGAIN in Linux */
 		}
 		/*
@@ -322,21 +117,21 @@ static ssize_t mon_text_read(struct file
 		 */
 		schedule();
 		if (signal_pending(current)) {
-			remove_wait_queue(&rp->wait, &waita);
+			remove_wait_queue(&rp->l.wait, &waita);
 			return -EINTR;
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&rp->wait, &waita);
+	remove_wait_queue(&rp->l.wait, &waita);
 
 	mutex_lock(&rp->printf_lock);
 	cnt = 0;
 	pbuf = rp->printf_buf;
 	limit = rp->printf_size;
 
-	udir = usb_pipein(ep->pipe) ? 'i' : 'o';
-	switch (usb_pipetype(ep->pipe)) {
+	udir = usb_pipein(ep->hdr.pipe) ? 'i' : 'o';
+	switch (usb_pipetype(ep->hdr.pipe)) {
 	case PIPE_ISOCHRONOUS:	utype = 'Z'; break;
 	case PIPE_INTERRUPT:	utype = 'I'; break;
 	case PIPE_CONTROL:	utype = 'C'; break;
@@ -344,10 +139,11 @@ static ssize_t mon_text_read(struct file
 	}
 	cnt += snprintf(pbuf + cnt, limit - cnt,
 	    "%lx %u %c %c%c:%03u:%02u",
-	    ep->id, ep->tstamp, ep->type,
-	    utype, udir, usb_pipedevice(ep->pipe), usb_pipeendpoint(ep->pipe));
+	    (long unsigned) ep->hdr.id, mon_get_timestamp(&ep->hdr.tstamp), 
+            ep->hdr.type, utype, udir, usb_pipedevice(ep->hdr.pipe), 
+            usb_pipeendpoint(ep->hdr.pipe));
 
-	if (ep->setup_flag == 0) {   /* Setup packet is present and captured */
+	if (ep->hdr.setup_flag == 0) {   /* Setup packet is present and captured */
 		cnt += snprintf(pbuf + cnt, limit - cnt,
 		    " s %02x %02x %04x %04x %04x",
 		    ep->setup[0],
@@ -355,19 +151,19 @@ static ssize_t mon_text_read(struct file
 		    (ep->setup[3] << 8) | ep->setup[2],
 		    (ep->setup[5] << 8) | ep->setup[4],
 		    (ep->setup[7] << 8) | ep->setup[6]);
-	} else if (ep->setup_flag != '-') { /* Unable to capture setup packet */
+	} else if (ep->hdr.setup_flag != '-') { /* Unable to capture setup packet */
 		cnt += snprintf(pbuf + cnt, limit - cnt,
-		    " %c __ __ ____ ____ ____", ep->setup_flag);
+		    " %c __ __ ____ ____ ____", ep->hdr.setup_flag);
 	} else {                     /* No setup for this kind of URB */
-		cnt += snprintf(pbuf + cnt, limit - cnt, " %d", ep->status);
+		cnt += snprintf(pbuf + cnt, limit - cnt, " %d", ep->hdr.status);
 	}
-	cnt += snprintf(pbuf + cnt, limit - cnt, " %d", ep->length);
+	cnt += snprintf(pbuf + cnt, limit - cnt, " %d", ep->hdr.length);
 
-	if ((data_len = ep->length) > 0) {
-		if (ep->data_flag == 0) {
+	if ((data_len = ep->hdr.length) > 0) {
+		if (ep->hdr.data_flag == 0) {
 			cnt += snprintf(pbuf + cnt, limit - cnt, " =");
-			if (data_len >= DATA_MAX)
-				data_len = DATA_MAX;
+			if (data_len >= rp->l.data_max)
+				data_len = rp->l.data_max;
 			for (i = 0; i < data_len; i++) {
 				if (i % 4 == 0) {
 					cnt += snprintf(pbuf + cnt, limit - cnt,
@@ -379,7 +175,7 @@ static ssize_t mon_text_read(struct file
 			cnt += snprintf(pbuf + cnt, limit - cnt, "\n");
 		} else {
 			cnt += snprintf(pbuf + cnt, limit - cnt,
-			    " %c\n", ep->data_flag);
+			    " %c\n", ep->hdr.data_flag);
 		}
 	} else {
 		cnt += snprintf(pbuf + cnt, limit - cnt, "\n");
@@ -388,7 +184,7 @@ static ssize_t mon_text_read(struct file
 	if (copy_to_user(buf, rp->printf_buf, cnt))
 		cnt = -EFAULT;
 	mutex_unlock(&rp->printf_lock);
-	kmem_cache_free(rp->e_slab, ep);
+	kmem_cache_free(rp->l.e_slab, ep);
 	return cnt;
 }
 
@@ -397,8 +193,6 @@ static int mon_text_release(struct inode
 	struct mon_reader_text *rp = file->private_data;
 	struct mon_bus *mbus;
 	/* unsigned long flags; */
-	struct list_head *p;
-	struct mon_event_text *ep;
 
 	mutex_lock(&mon_lock);
 	mbus = inode->u.generic_ip;
@@ -408,26 +202,10 @@ static int mon_text_release(struct inode
 		mutex_unlock(&mon_lock);
 		return 0;
 	}
-	mon_reader_del(mbus, &rp->r);
+	mon_reader_del(mbus, &rp->l.r);
+	
+	mon_list_destroy(&rp->l);
 
-	/*
-	 * In theory, e_list is protected by mbus->lock. However,
-	 * after mon_reader_del has finished, the following is the case:
-	 *  - we are not on reader list anymore, so new events won't be added;
-	 *  - whole mbus may be dropped if it was orphaned.
-	 * So, we better not touch mbus.
-	 */
-	/* spin_lock_irqsave(&mbus->lock, flags); */
-	while (!list_empty(&rp->e_list)) {
-		p = rp->e_list.next;
-		ep = list_entry(p, struct mon_event_text, e_link);
-		list_del(p);
-		--rp->nevents;
-		kmem_cache_free(rp->e_slab, ep);
-	}
-	/* spin_unlock_irqrestore(&mbus->lock, flags); */
-
-	kmem_cache_destroy(rp->e_slab);
 	kfree(rp->printf_buf);
 	kfree(rp);
 
@@ -445,16 +223,3 @@ struct file_operations mon_fops_text = {
 	/* .ioctl =	mon_text_ioctl, */
 	.release =	mon_text_release,
 };
-
-/*
- * Slab interface: constructor.
- */
-static void mon_text_ctor(void *mem, kmem_cache_t *slab, unsigned long sflags)
-{
-	/*
-	 * Nothing to initialize. No, really!
-	 * So, we fill it with garbage to emulate a reused object.
-	 */
-	memset(mem, 0xe5, sizeof(struct mon_event_text));
-}
-
diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/drivers/usb/mon/usb_mon.h linux-2.6.18-monioctl/drivers/usb/mon/usb_mon.h
--- linux-2.6.18-vanilla/drivers/usb/mon/usb_mon.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18-monioctl/drivers/usb/mon/usb_mon.h	2006-10-11 10:34:48.000000000 +0200
@@ -19,6 +19,7 @@ struct mon_bus {
 	spinlock_t lock;
 	struct dentry *dent_s;		/* Debugging file */
 	struct dentry *dent_t;		/* Text interface file */
+	struct dentry *dent_b;		/* Binary interface file */
 	struct usb_bus *u_bus;
 
 	/* Ref */
@@ -28,7 +29,7 @@ struct mon_bus {
 
 	/* Stats */
 	unsigned int cnt_events;
-	unsigned int cnt_text_lost;
+	unsigned int cnt_lost;
 };
 
 /*
@@ -44,6 +45,48 @@ struct mon_reader {
 	void (*rnf_complete)(void *data, struct urb *urb);
 };
 
+/*
+ * Defined by USB 2.0 clause 9.3, table 9.2.
+ */
+#define SETUP_MAX  8
+
+struct mon_event_hdr {
+	s32 type;	/* submit, complete, etc. */
+	u32 pipe;	/* Pipe */
+	u64 id;	        /* Incremental id */
+	struct timeval tstamp;
+	u32 length;	/* Depends on type: xfer length or act length */
+	s32 status;
+	s8 setup_flag;
+	s8 data_flag;
+};
+
+struct mon_event_list {
+	struct list_head e_link;
+        struct mon_event_hdr hdr;
+	unsigned char setup[SETUP_MAX];
+	unsigned char* data;
+};
+
+#define SLAB_NAME_SZ  30
+struct mon_reader_list {
+	kmem_cache_t *e_slab;
+    	unsigned data_max;
+	int nevents;
+	struct list_head e_list;
+	struct mon_reader r;	/* In C, parent class can be placed anywhere */
+
+	wait_queue_head_t wait;
+	char slab_name[SLAB_NAME_SZ];
+};
+
+/* list reader operation */
+int mon_list_init(struct mon_reader_list* rp, struct mon_bus *mbus, char type);
+struct mon_event_list *mon_list_fetch(struct mon_reader_list *rp,
+    struct mon_bus *mbus);
+int mon_list_resize(struct mon_reader_list* rp, int data_max);	
+void mon_list_destroy(struct mon_reader_list* rp);	
+
 void mon_reader_add(struct mon_bus *mbus, struct mon_reader *r);
 void mon_reader_del(struct mon_bus *mbus, struct mon_reader *r);
 
@@ -53,6 +96,7 @@ extern char mon_dmapeek(unsigned char *d
 
 extern struct mutex mon_lock;
 
+extern struct file_operations mon_fops_binary;
 extern struct file_operations mon_fops_text;
 extern struct file_operations mon_fops_stat;
 




 --
 Email.it, the professional e-mail, gratis per te: http://www.email.it/f
 
 Sponsor:
 Acquista i tuoi gioielli in tutta sicurezza ed a prezzi veramente imbattibili. Sfoglia il nostro catalogo on-line!
 Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=5634&d=11-10

 
 
 --
 Email.it, the professional e-mail, gratis per te: http://www.email.it/f
 
 Sponsor:
 Refill s.r.l. - Tutto per la tua stampante a prezzi incredibili: su cartucce, toner, inchiostri, carta speciale risparmi fino al 90%!
 Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=5189&d=11-10

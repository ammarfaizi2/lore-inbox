Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbTDLEEf (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 00:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTDLEEf (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 00:04:35 -0400
Received: from fmr03.intel.com ([143.183.121.5]:59106 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263124AbTDLEEZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 00:04:25 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAB1B@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Greg KH'" <greg@kroah.com>,
       "'Miquel van Smoorenburg'" <miquels@cistron-office.nl>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Simple Kernel-User Event Interface (Was: RE: [ANNOUNCE] udev 0.1 
	release)
Date: Fri, 11 Apr 2003 21:16:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Greg KH [mailto:greg@kroah.com]
> 
> On Fri, Apr 11, 2003 at 11:39:07PM +0000, Miquel van Smoorenburg wrote:
> > In article <20030411190717.GH1821@kroah.com>,
> > Greg KH  <greg@kroah.com> wrote:
> > >I agree too.  Having /sbin/hotplug send events to a pipe where a daemon
> > >can get them from makes a lot of sense.  It will handle most of the
> > >synchronization and spawning a zillion tasks problems.
> >
> > Why not serialize /sbin/hotplug at the kernel level. Queue hotplug
> > events and only allow one /sbin/hotplug to run at the same time.
> 
> We don't want the kernel to stop based on a user program.

Okay, so what about this:

I started playing with a simple event interface, that would allow:

- queuing events and recalling-queued events
- not consume (almost) memory when two bazillion events are queued
- be accessible by different processes at the same time on 
  different fds

And I came with the attached patch. Now it is kind of lame, as I am
a lazy bastard and don't remember too much on the current state of
the art for device access (and I have no idea on how to code a 
poll() fop, so need help there) - whatever - now it is a misc device,
but that should be changed.

The idea is you queue from the kernel a message and the user space
reads it -entirely, no half things-, starting with a header (unsigned
long size) and then the actual bytes. If the user provides a buffer
big enough, more entire messages are copied. If no messages are
available, -EAGAIN.

Now, each fd keeps a pointer to the queue list and only when the
event has been read by all the open fds, it is then disposed. I
think I got right all the maintenance so no event is left dangling,
even if you close all the fds (at this point, a queue flush is
performed, however, new events will be queued).

Now the catch is that the message data can or cannot be kmalloced. 
For example, when we plug a device, part of the device structure
can be the message data, and once plugged, we queue the event.
Once read, it won't be freed (set the flag for it), and when
the device is unplugged, the event is recalled, just in case it
wasn't read yet. This means we can have as many of these as we
want, they won't take much extra space, as at the end, somebody
will dispose of them. For removal events, for example, we can
dynamically allocate one.

Caveats:

- Currently using semaphores, so cannot be called from atomic
  functions - need to fix that.

Now, I haven't bothered to look at other interfaces around
(ACPI - need to ask Andy), networking ... but I am pretty 
sure this one is generic enough as to work for everyone.
Maybe add a type field in the header or stuff like that,
but it should do.

Tested under 2.5.66 - didn't test the multiple readers part, though

 drivers/char/Makefile   |    2 
 drivers/char/kue-test.c |   60 +++++++++
 drivers/char/kue.c      |  314
++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/kue.h     |   76 +++++++++++

Index: drivers/char/Makefile
diff -u drivers/char/Makefile:1.1.1.4 drivers/char/Makefile:1.1.1.4.2.1
--- drivers/char/Makefile:1.1.1.4	Wed Mar 26 15:30:30 2003
+++ drivers/char/Makefile	Fri Apr 11 20:51:38 2003
@@ -78,6 +78,8 @@
 obj-$(CONFIG_IPMI_HANDLER) += ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
+obj-m += kue.o
+obj-m += kue-test.o
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
Index: drivers/char/kue-test.c
diff -u /dev/null drivers/char/kue-test.c:1.1.2.1
--- /dev/null	Fri Apr 11 21:05:30 2003
+++ drivers/char/kue-test.c	Fri Apr 11 20:52:03 2003
@@ -0,0 +1,60 @@
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kue.h>
+
+struct msg
+{
+	struct kue kue;
+	char data[];
+};
+
+struct msg m3 = {
+	.kue = KUE_INIT(m3.kue, 0, 9),
+	.data = "123456789"
+};
+
+struct msg m2 = {
+	.kue = KUE_INIT(m2.kue, 0, 3),
+	.data = "123"
+};
+
+struct msg m1 = {
+	.kue = KUE_INIT(m1.kue, 0, 4),
+	.data = "1234"
+};
+
+struct msg m4 = {
+	.kue = KUE_INIT(m4.kue, 0, 16),
+	.data = "123456789abcdef"
+};
+
+	
+static
+int __init kue_test_init (void)
+{
+	struct msg *_m4;
+	
+	kue_send_event (&m3.kue);
+	kue_send_event (&m2.kue);
+	kue_send_event (&m1.kue);
+
+	_m4 = kmalloc (sizeof (*_m4), GFP_KERNEL);
+	memcpy (_m4, &m4, sizeof (m4));
+	_m4->kue.flags = KUE_KFREE;
+	kue_send_event (&_m4->kue);
+	return 0;
+}
+
+static
+void __exit kue_test_exit (void)
+{
+	kue_recall_event (&m3.kue);
+	kue_recall_event (&m2.kue);
+	kue_recall_event (&m1.kue);	
+}
+
+
+module_init(kue_test_init);
+module_exit(kue_test_exit);
+MODULE_LICENSE("GPL");
Index: drivers/char/kue.c
diff -u /dev/null drivers/char/kue.c:1.1.2.1
--- /dev/null	Fri Apr 11 21:05:30 2003
+++ drivers/char/kue.c	Fri Apr 11 20:51:49 2003
@@ -0,0 +1,314 @@
+
+/* Kernel-User Events
+ *
+ * Simple event interface for the kernel to pass on stuff to the user
+ * space. When some part of the kernel wants to send a message to user
+ * space (binary chunk of data of a given size), it defines the
+ * following:
+ *
+ * #include <linux/kue.h>
+ *
+ * struct some_msg {
+ *         struct kue kue; // FIRST MEMBER!! 
+ *         char data[];
+ * } msg = { .kue = KUE_INIT(msg.kue, FLAGS, SIZE), data = "Hello world!"
};
+ *
+ * In this case, SIZE would be [onetwothreefourfiv...] thirteen with
+ * the \0. FLAGS is either 0 or KUE_KFREE (with 0, we own the data,
+ * with KUE_KFREE, KUE will kfree() the data when the message is
+ * delivered. 
+ *
+ * Now, queue with:
+ *
+ * kue_send_event (&msg.kue);
+ *
+ * Now, the message is queued. There is a char device that user space
+ * programs can open for reading; if they read and there are no
+ * messages, they get a -EAGAIN. KUE will try to fit as many *whole*
+ * messages as possible in the read buffer, and then advance each fd
+ * specific 'current' pointer through the queue of messages. Next time
+ * it reads, it will get the following ones, and so on. If you get
+ * -EFBIG, the buffer is too small for the first message, so make it
+ * bigger. 
+ *
+ * When a message has been read by all the current open fds, it is
+ * removed from the queue and if KUE_KFREE was set, kfree()d.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <asm/semaphore.h>
+#include <linux/kue.h>
+#include <asm/uaccess.h>
+
+#define DEBUG
+#ifdef DEBUG
+#define debug(a...) printk (KERN_ERR a)
+#else
+#define debug(a...)
+#endif
+
+static DECLARE_MUTEX(kue_lock);
+static struct list_head kue_list = LIST_HEAD_INIT (kue_list);
+static struct list_head kue_fd_list = LIST_HEAD_INIT (kue_fd_list);
+static unsigned kue_fds = 0;
+struct kue_fd
+{
+	struct list_head list;
+	struct list_head *itr;
+	struct file *file;
+};
+
+/* Internal: de/queue/query event */
+
+static inline
+void __kue_queue (struct kue *kue)
+{
+	debug ("Queuing %p\n", kue);
+	kue->fds_done = 0;
+	list_add_tail (&kue->list, &kue_list);
+}
+
+static inline
+void __kue_dequeue (struct kue *kue)
+{
+	debug ("Dequeuing %p%s\n", kue,
+	       kue->flags & KUE_KFREE? " (kfree()d)" : "");
+	list_del (&kue->list);
+	if (kue->flags & KUE_KFREE)
+		kfree (kue);
+}
+
+static inline
+struct kue * __kue_locate_event (const struct kue *kue)
+{
+	struct list_head *itr;
+	struct kue *kue_itr;
+	
+	list_for_each (itr, &kue_list) {
+		kue_itr = container_of (itr, struct kue, list);
+		if (kue_itr == kue)
+			goto out;
+	}
+	kue_itr = NULL;
+out:
+	return kue_itr;
+}
+
+static inline
+void __kue_recall_event (struct kue *kue)
+{
+	struct list_head *itr, *kue_itr;
+	struct kue_fd *kue_fd;
+	
+	debug ("__Recalling %p\n", kue);
+	
+	kue_itr = &kue->list;
+	list_for_each (itr, &kue_fd_list) {
+		kue_fd = container_of (itr, struct kue_fd, list);
+		if (kue_fd->itr == kue_itr)
+			kue_fd->itr = kue_itr->prev;
+	}
+	__kue_dequeue (kue);
+}
+
+	/* Kernel interface */
+
+void kue_send_event (struct kue *kue)
+{
+	debug ("Sending %p\n", kue);
+	down (&kue_lock);
+	__kue_queue (kue);
+	up (&kue_lock);
+}
+
+
+int kue_recall_event (struct kue *kue)
+{
+	int result = -ENOENT;
+	
+	debug ("Recalling %p\n", kue);
+	
+	down (&kue_lock);
+	if (__kue_locate_event (kue) != NULL) {
+		__kue_recall_event (kue);
+		result = 0;
+	}
+	up (&kue_lock);
+	return result;
+}
+
+
+unsigned kue_delivered_event (const struct kue *kue)
+{
+	down (&kue_lock);
+	kue = __kue_locate_event (kue);
+	up (&kue_lock);
+	return kue == NULL;
+}
+
+
+	/* File operations */
+
+static
+int kue_open (struct inode *inode, struct file *file)
+{
+	struct kue_fd *kue_fd = kmalloc (sizeof (*kue_fd), GFP_KERNEL);
+	
+	if (kue_fd == NULL)
+		return -ENOMEM;
+	kue_fd->itr = &kue_list;
+	kue_fd->file = file;
+	down (&kue_lock);
+	list_add_tail (&kue_fd->list, &kue_fd_list);
+	kue_fds++;
+	up (&kue_lock);
+	file->private_data = kue_fd;
+	debug ("Open kue_fd %p kue_fds %d\n", kue_fd, kue_fds);
+	return 0;
+}
+
+static
+ssize_t kue_read (struct file *file, char *dest, size_t size,
+		  loff_t *offset)
+{
+	struct kue_fd *kue_fd = file->private_data;
+	struct kue *kue;
+	ssize_t result, total_copied = 0;
+	struct list_head *itr;
+
+	if (kue_fd == NULL)
+		return -EIO;
+	
+	debug ("Read kue_fd %p kue_itr %p\n", kue_fd, kue_fd->itr);
+	
+	down (&kue_lock);
+	itr = kue_fd->itr;
+	while (1)
+	{
+		result = -EAGAIN;
+		if (itr->next == &kue_list)
+			break;
+		result = -EFBIG;
+		kue = container_of (itr->next, struct kue, list);
+		if (kue->kue_user.size > size)
+			break;
+		debug ("Read kue_fd %p kue_itr %p dest %p size %u kue %p\n",
+		       kue_fd, kue_fd->itr,
+		       dest, size, kue);
+		result = copy_to_user (dest, &kue->kue_user,
kue->kue_user.size);
+		if (result != 0) {
+			result = -EFAULT;
+			break;
+		}
+		size -= kue->kue_user.size;
+		dest += kue->kue_user.size;
+		total_copied += kue->kue_user.size;
+		result = 0;
+		kue->fds_done++;
+		/* All read it? wipe it */
+		if (kue->fds_done >= kue_fds)
+			__kue_dequeue (kue);
+		else
+			itr = itr->next;
+		kue_fd->itr = itr;
+	}
+	debug ("Read-finish kue_fd %p kue_itr %p dest %p size %u\n"
+	       "            total_copied %d result %d\n",
+	       kue_fd, kue_fd->itr,
+	       dest, size, 
+	       total_copied, result);
+	up (&kue_lock);
+	return total_copied == 0? result : total_copied;
+}
+
+static
+unsigned int kue_poll (struct file *file, struct poll_table_struct *pt)
+{
+		/* FIXME: need help with this one */
+	return -ENOSYS;
+}
+
+static
+int kue_release (struct inode *inode, struct file *file)
+{
+	struct kue_fd *kue_fd = file->private_data;
+	struct kue *kue;
+	struct list_head *itr, *next;
+	
+	debug ("Release kue_fd %p\n", kue_fd);
+	
+	if (kue_fd == NULL)
+		return 0;
+	
+	down (&kue_lock);
+	list_del (&kue_fd->list);
+	kue_fds--;
+	kfree (kue_fd);
+	/* Now recall any events that could have been released by this
+	 * guy */
+	list_for_each_safe (itr, next, &kue_list) {
+		kue = container_of (itr, struct kue, list);
+		if (kue->fds_done >= kue_fds)
+			__kue_recall_event (kue);
+	}
+	up (&kue_lock);
+	return 0;
+}
+
+static struct file_operations kue_fops = {
+	.owner = THIS_MODULE,
+	.open = kue_open,
+	.read = kue_read,
+	.poll = kue_poll,
+	.release = kue_release
+};
+
+static struct miscdevice kue_misc = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "kue",
+	.fops = &kue_fops
+};
+
+static
+int __init kue_init (void)
+{
+	return misc_register (&kue_misc);
+}
+
+static
+void __exit kue_exit (void)
+{
+	struct list_head *itr, *next;
+	struct kue_fd *kue_fd;
+	struct kue *kue;
+	
+	/* Release all FDs */
+	down (&kue_lock);
+	list_for_each (itr, &kue_fd_list) {
+		kue_fd = container_of (itr, struct kue_fd, list);
+		debug ("Exit kue_fd %p\n", kue_fd);
+		kue_fd->file->private_data = NULL;
+		kfree (kue_fd);
+	}
+	list_del_init (&kue_fd_list); /* call me pedantic */
+	/* Now wipe all of the events */
+	list_for_each_safe (itr, next, &kue_list) {
+		kue = container_of (itr, struct kue, list);
+		debug ("Exit kue %p\n", kue);
+		__kue_dequeue (kue);
+	}	
+	up (&kue_lock);
+	misc_deregister (&kue_misc);
+}
+
+
+EXPORT_SYMBOL(kue_send_event);
+EXPORT_SYMBOL(kue_recall_event);
+EXPORT_SYMBOL(kue_delivered_event);
+module_init(kue_init);
+module_exit(kue_exit);
+MODULE_LICENSE("GPL");
Index: include/linux/kue.h
diff -u /dev/null include/linux/kue.h:1.1.2.1
--- /dev/null	Fri Apr 11 21:05:37 2003
+++ include/linux/kue.h	Fri Apr 11 21:01:24 2003
@@ -0,0 +1,76 @@
+#ifndef _LINUX_EVENTS_H
+#define _LINUX_EVENTS_H
+
+#include <linux/list.h>
+
+struct kue_user /* Kernel - User generic event */
+{
+	size_t size; /* size of data + sizeof (struct kue_user) */	
+	char data[];
+};
+
+#ifdef __KERNEL__
+struct kue /* Kernel - User generic event - kernel internal*/
+{
+	int flags; /* indicate your flags here */
+
+	/* No user serviceable parts below */
+	
+	struct list_head list; 
+	size_t fds_done;
+	
+	struct kue_user kue_user;
+	
+	/* FIXME: maybe add a TTL? */
+};
+
+/* @_kue Member name to the kue structure
+ * @_flags 0 or KU_KFREE
+ * @_size Size of the data, header size will be added
+ */
+#define KUE_INIT(_kue, _flags, _size)					\
+{									\
+	.flags = (_flags),						\
+	.list = LIST_HEAD_INIT ((_kue).list),				\
+	.fds_done = 0,							\
+	.kue_user = { .size = ((_size) + sizeof (struct kue_user)) }	\
+}
+
+
+enum kue_flags {
+	KUE_KFREE = 0x01
+};
+
+/* Queue an event for delivery
+ *
+ * The event will be on the list of events until all open fds have
+ * read it. If the KUE_FREE flag is set, then it will be kfree()d when
+ * removed from the list.
+ */
+
+extern void kue_send_event (struct kue *);
+
+/* Recall a queued event
+ *
+ * Go over the list of open fds and if their current
+ * pointer is set on the event we are recalling,
+ * advance it to the next before deleting.
+ *
+ * If the event has the KUE_FREE flag set, then it'll
+ * be kfree()d.
+ *
+ * Return 0 if ok, < 0 errno code on error.
+ */
+
+extern int kue_recall_event (struct kue *);
+
+/* Query an event
+ *
+ * Return !0 if event delivered or not found, 0 if not delivered
+ */
+
+extern unsigned kue_delivered_event (const struct kue *);
+
+#endif /* __KERNEL__ */
+
+#endif /* #ifndef _LINUX_EVENTS_H */

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

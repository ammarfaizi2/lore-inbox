Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUDUMkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUDUMkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 08:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUDUMkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 08:40:10 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:47322 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261563AbUDUMj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 08:39:29 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: Wed, 21 Apr 2004 22:38:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16518.27472.760406.691633@cse.unsw.edu.au>
Cc: arjanv@redhat.com, Andrew Morton <akpm@osdl.org>,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>, b-gruber@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
In-Reply-To: message from Sau Dan Lee on  April 21
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	<Pine.GSO.4.58.0404191124220.21825@stekt37>
	<20040419015221.07a214b8.akpm@osdl.org>
	<xb77jwci86o.fsf@savona.informatik.uni-freiburg.de>
	<1082372020.4691.9.camel@laptop.fenrus.com>
	<16518.20890.380763.581386@cse.unsw.edu.au>
	<xb71xmhfu9j.fsf@savona.informatik.uni-freiburg.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  April 21, danlee@informatik.uni-freiburg.de wrote:
> >>>>> "Neil" == Neil Brown <neilb@cse.unsw.edu.au> writes:
> 
>     Neil> I agree that it is good for the kernel to provide hardware
>     Neil> abstractions, and that "mouse" is an appropriate device to
>     Neil> provide an abstract interface for.
> 
> So, the next  step is to port efax or Hylafax  into kernel space.  Why
> leave the /dev/ttyS? hanging out there?  Why not encapsulated them and
> provide a /dev/fax that does what efax or Hylafax do?

Simple debating technique:  start of by agreeing with someone and they
are more likely to listen to your argument. The key issue is where the
driver should be, not where the interface should be, so focus on that.

> 
> 
> BTW, how did you hack the /dev/psaux?
> 

It's not suitable for inclusion, but with this patch, I get two
modules, psdev and psmouse.
I load psdev and /dev/psaux is raw.  I load psmouse  and /dev/psaux is
normal 2.6 behaviour.

NeilBrown


 ----------- Diffstat output ------------
 ./drivers/input/Kconfig        |    2 
 ./drivers/input/mouse/Kconfig  |    7 +
 ./drivers/input/mouse/Makefile |    1 
 ./drivers/input/mouse/psdev.c  |  256 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 265 insertions(+), 1 deletion(-)

diff ./drivers/input/Kconfig~current~ ./drivers/input/Kconfig
--- ./drivers/input/Kconfig~current~	2004-04-05 14:18:30.000000000 +1000
+++ ./drivers/input/Kconfig	2004-04-05 14:18:30.000000000 +1000
@@ -42,7 +42,7 @@ config INPUT_MOUSEDEV
 
 config INPUT_MOUSEDEV_PSAUX
 	bool "Provide legacy /dev/psaux device" if EMBEDDED
-	default y
+	default n
 	depends on INPUT_MOUSEDEV
 
 config INPUT_MOUSEDEV_SCREEN_X

diff ./drivers/input/mouse/Kconfig~current~ ./drivers/input/mouse/Kconfig
--- ./drivers/input/mouse/Kconfig~current~	2004-04-05 14:18:30.000000000 +1000
+++ ./drivers/input/mouse/Kconfig	2004-04-05 14:18:30.000000000 +1000
@@ -141,3 +141,10 @@ config MOUSE_PC9800
 	  To compile this driver as a module, choose M here: the
 	  module will be called 98busmouse.
 
+config MOUSE_PSDEV
+	tristate "Raw PS/AUX driver for mouse"
+	default y
+	depends on INPUT && INPUT_MOUSE && SERIO
+	---help---
+	  Say Y if you want /dev/psaux to really be /dev/psaux
+

diff ./drivers/input/mouse/Makefile~current~ ./drivers/input/mouse/Makefile
--- ./drivers/input/mouse/Makefile~current~	2004-04-05 14:18:30.000000000 +1000
+++ ./drivers/input/mouse/Makefile	2004-04-05 14:18:30.000000000 +1000
@@ -4,6 +4,7 @@
 
 # Each configuration option enables a list of files.
 
+obj-$(CONFIG_MOUSE_PSDEV)	+= psdev.o
 obj-$(CONFIG_MOUSE_AMIGA)	+= amimouse.o
 obj-$(CONFIG_MOUSE_RISCPC)	+= rpcmouse.o
 obj-$(CONFIG_MOUSE_INPORT)	+= inport.o

diff ./drivers/input/mouse/psdev.c~current~ ./drivers/input/mouse/psdev.c
--- ./drivers/input/mouse/psdev.c~current~	2004-04-05 14:18:30.000000000 +1000
+++ ./drivers/input/mouse/psdev.c	2004-04-05 14:18:30.000000000 +1000
@@ -0,0 +1,256 @@
+/*
+ * PS/2 mouse driver
+ *
+ * Copyright (c) 2003 Neil Brown
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/poll.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/device.h>
+
+
+MODULE_AUTHOR("Neil Brown <neilb@cse.unsw.edu.au>");
+MODULE_DESCRIPTION("PS/2 Aux port driver");
+MODULE_LICENSE("GPL");
+
+#define	BUFSIZE	128
+struct psreader {
+	struct list_head	list;
+	struct psdev		*dev;
+	char			buf[BUFSIZE];
+	int			head, tail; /* (head==tail) => empty */
+};
+static LIST_HEAD(psreaders);
+
+struct psdev {
+	struct list_head 	list;
+	struct serio		*serio;
+	struct psreader		*reader;
+};
+static LIST_HEAD(psdevs);
+static DECLARE_WAIT_QUEUE_HEAD(waitq);
+static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+
+static ssize_t psaux_read(struct file * file, char * buffer, size_t count, loff_t *ppos)
+{
+	struct psreader *pr = file->private_data;
+	int copied = 0;
+	int err = 0;
+	DEFINE_WAIT(wait);
+
+	if (!count) return 0;
+	while(!copied && !err) {
+		prepare_to_wait(&waitq, &wait, TASK_INTERRUPTIBLE);
+		while (count && pr->head != pr->tail) {
+			int h = pr->head;
+			int t = pr->tail;
+			if (t < h)
+				t = BUFSIZE;
+			if (t - h > count)
+				t = h + count;
+			if (copy_to_user(buffer+copied, pr->buf+h, t-h)) {
+				err = -EFAULT;
+				break;
+			}
+			copied += t-h;
+			count -= t-h;
+			if (t == BUFSIZE) t = 0;
+			pr->head = t;
+		}
+		if (err || copied) break;
+		if ((file->f_flags & O_NONBLOCK))
+			err = -EAGAIN;
+		else 
+			schedule();
+		if (signal_pending(current))
+			err = -EINTR;
+	}
+	finish_wait(&waitq, &wait);
+	if (copied)
+		return copied;
+	else
+		return err;
+}
+
+static ssize_t psaux_write(struct file * file, const char * buffer, size_t count, loff_t *ppos)
+{
+	unsigned char c;
+	int i;
+	struct psreader *pr = file->private_data;
+	struct psdev *ps = pr->dev;
+
+	if (count == 0 ) return 0;
+	for (i = 0; i < count ; i++) {
+
+		if (get_user(c, buffer + i))
+			return -EFAULT;
+
+		if (ps == NULL && !list_empty(&psdevs))
+			ps = list_entry(psdevs.next, struct psdev, list);
+		if (ps)
+			if (serio_write(ps->serio, c))
+				break;
+	}
+	if (i == 0) return -EIO;
+	return i;
+}
+
+static unsigned int psaux_poll(struct file *file, poll_table *wait)
+{
+	struct psreader *pr = file->private_data;
+	poll_wait(file, &waitq, wait);
+
+	if (pr->head != pr->tail) 
+		return POLLIN | POLLRDNORM;
+	return 0;
+}
+
+static int psaux_open(struct inode * inode, struct file * file)
+{
+	struct psreader *pr = kmalloc(sizeof(*pr), GFP_KERNEL);
+	if (pr == NULL)
+		return -ENOMEM;
+	memset(pr, 0, sizeof(*pr));
+	spin_lock_irq(&lock);
+	list_add(&pr->list, &psreaders);
+	file->private_data = pr;
+	spin_unlock_irq(&lock);
+	return 0;
+}
+
+static int psaux_release(struct inode * inode, struct file * file)
+{
+	struct psreader *pr = file->private_data;
+	spin_lock_irq(&lock);
+	list_del(&pr->list);
+	if (pr->dev)
+		pr->dev->reader = NULL;
+	spin_unlock_irq(&lock);
+	kfree(pr);
+	return 0;
+}
+
+
+struct file_operations psaux_fops = {
+	.owner =	THIS_MODULE,
+	.read =		psaux_read,
+	.write =	psaux_write,
+	.poll =		psaux_poll,
+	.open =		psaux_open,
+	.release =	psaux_release,
+/*	.fasync =	psaux_fasync, */
+};
+
+static struct miscdevice psaux = {
+	PSMOUSE_MINOR, "psaux", &psaux_fops
+};
+
+
+static irqreturn_t psaux_interrupt(struct serio *serio,
+				   unsigned char data, unsigned int flags,
+				   struct pt_regs *regs)
+{
+	struct psdev *ps = serio->private;
+	struct psreader *pr = ps->reader;
+	unsigned long iflags;
+
+/*	printk("got %x\n", data); */
+	spin_lock_irqsave(lock, iflags);
+	if (pr) {
+		if ((pr->tail+1) % BUFSIZE != pr->head) {
+			/* there is room */
+			pr->buf[pr->tail] = data;
+			pr->tail = (pr->tail+1) % BUFSIZE;
+		}
+	} else
+	list_for_each_entry(pr, &psreaders, list) {
+		if (pr->dev == NULL) {
+			if ((pr->tail+1) % BUFSIZE != pr->head) {
+				/* there is room */
+				pr->buf[pr->tail] = data;
+				pr->tail = (pr->tail+1) % BUFSIZE;
+			}
+		}
+	}
+	spin_unlock_irqrestore(lock, iflags);
+	wake_up(&waitq);
+	return IRQ_HANDLED;
+}
+
+static void psaux_connect(struct serio *serio, struct serio_dev *dev)
+{
+	struct psdev *ps;
+	printk("psaux connect\n");
+	if ((serio->type & SERIO_TYPE) != SERIO_8042)
+		return;
+	ps = kmalloc(sizeof(*ps), GFP_KERNEL);
+	if (!ps)
+		return;
+
+	if (serio_open(serio, dev)) {
+		kfree(ps);
+		return; 
+	}
+	printk("Connect succeeded\n");
+	ps->serio = serio;
+	ps->reader = NULL;
+	serio->private = ps;
+	spin_lock_irq(&lock);
+	list_add(&ps->list, &psdevs);
+	spin_unlock_irq(&lock);
+}
+
+static void psaux_disconnect(struct serio *serio)
+{
+	struct psdev *ps = serio->private;
+
+	if (ps->reader)
+		ps->reader->dev = NULL;
+	spin_lock_irq(&lock);
+	list_del(&ps->list);
+	spin_unlock_irq(&lock);
+	serio_close(serio);
+	kfree(ps);
+}
+
+static void psaux_cleanup(struct serio *serio)
+{
+}
+
+
+static struct serio_dev psaux_dev = {
+	.interrupt =	psaux_interrupt,
+	.connect =	psaux_connect,
+	.disconnect =	psaux_disconnect,
+	.cleanup =	psaux_cleanup,
+};
+
+
+int __init psaux_init(void)
+{
+	serio_register_device(&psaux_dev);
+	misc_register(&psaux);
+	return 0;
+}
+
+void __exit psaux_exit(void)
+{
+	misc_deregister(&psaux);
+	serio_unregister_device(&psaux_dev);
+}
+
+module_init(psaux_init);
+module_exit(psaux_exit);

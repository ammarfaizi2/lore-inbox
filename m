Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263177AbSJHNp3>; Tue, 8 Oct 2002 09:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263181AbSJHNp3>; Tue, 8 Oct 2002 09:45:29 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:50836 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263177AbSJHNoc>;
	Tue, 8 Oct 2002 09:44:32 -0400
Date: Tue, 8 Oct 2002 15:50:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Use lists.h in event handlers [12/23]
Message-ID: <20021008155003.K18546@ucw.cz>
References: <20021008153926.A18546@ucw.cz> <20021008154029.B18546@ucw.cz> <20021008154132.C18546@ucw.cz> <20021008154246.D18546@ucw.cz> <20021008154415.E18546@ucw.cz> <20021008154549.F18546@ucw.cz> <20021008154631.G18546@ucw.cz> <20021008154733.H18546@ucw.cz> <20021008154824.I18546@ucw.cz> <20021008154904.J18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008154904.J18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:49:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.42, 2002-09-25 17:05:02+02:00, vojtech@suse.cz
  Convert more of input to list.h usage.


 evdev.c               |  104 ++++++++++++--------------------------------------
 gameport/emu10k1-gp.c |    1 
 gameport/ns558.c      |   52 ++++++++++---------------
 joydev.c              |   91 +++++++++++--------------------------------
 mousedev.c            |   97 ++++++++++++----------------------------------
 tsdev.c               |  103 ++++++++++++++-----------------------------------
 6 files changed, 130 insertions(+), 318 deletions(-)

===================================================================

diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Tue Oct  8 15:26:21 2002
+++ b/drivers/input/evdev.c	Tue Oct  8 15:26:21 2002
@@ -1,29 +1,11 @@
 /*
- * $Id: evdev.c,v 1.48 2002/05/26 14:28:26 jdeneux Exp $
+ * Event char devices, giving access to raw input device events.
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
+ * Copyright (c) 1999-2002 Vojtech Pavlik
  *
- *  Event char devices, giving access to raw input device events.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #define EVDEV_MINOR_BASE	64
@@ -38,7 +20,7 @@
 #include <linux/smp_lock.h>
 #include <linux/device.h>
 
-struct evdev {
+struct evdev{
 	int exist;
 	int open;
 	int minor;
@@ -46,7 +28,7 @@
 	struct input_handle handle;
 	wait_queue_head_t wait;
 	devfs_handle_t devfs;
-	struct evdev_list *list;
+	struct list_head list;
 };
 
 struct evdev_list {
@@ -55,17 +37,17 @@
 	int tail;
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
-	struct evdev_list *next;
+	struct list_head node;
 };
 
-static struct evdev *evdev_table[EVDEV_MINORS] = { NULL, /* ... */ };
+static struct evdev *evdev_table[EVDEV_MINORS];
 
 static void evdev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
 {
 	struct evdev *evdev = handle->private;
-	struct evdev_list *list = evdev->list;
+	struct evdev_list *list;
 
-	while (list) {
+	list_for_each_entry(list, &evdev->list, node) {
 
 		do_gettimeofday(&list->buffer[list->head].time);
 		list->buffer[list->head].type = type;
@@ -74,8 +56,6 @@
 		list->head = (list->head + 1) & (EVDEV_BUFFER_SIZE - 1);
 
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
-
-		list = list->next;
 	}
 
 	wake_up_interruptible(&evdev->wait);
@@ -91,7 +71,7 @@
 
 static int evdev_flush(struct file * file)
 {
-	struct evdev_list *list = (struct evdev_list*)file->private_data;
+	struct evdev_list *list = file->private_data;
 	if (!list->evdev->exist) return -ENODEV;
 	return input_flush_device(&list->evdev->handle, file);
 }
@@ -99,14 +79,9 @@
 static int evdev_release(struct inode * inode, struct file * file)
 {
 	struct evdev_list *list = file->private_data;
-	struct evdev_list **listptr;
 
-	listptr = &list->evdev->list;
 	evdev_fasync(-1, file, 0);
-
-	while (*listptr && (*listptr != list))
-		listptr = &((*listptr)->next);
-	*listptr = (*listptr)->next;
+	list_del(&list->node);
 
 	if (!--list->evdev->open) {
 		if (list->evdev->exist) {
@@ -132,19 +107,15 @@
 	if (i >= EVDEV_MINORS || !evdev_table[i])
 		return -ENODEV;
 
-	/* Ask the driver if he wishes to accept the open() */
-	if ((accept_err = input_accept_process(&(evdev_table[i]->handle), file))) {
+	if ((accept_err = input_accept_process(&(evdev_table[i]->handle), file)))
 		return accept_err;
-	}
 
 	if (!(list = kmalloc(sizeof(struct evdev_list), GFP_KERNEL)))
 		return -ENOMEM;
 	memset(list, 0, sizeof(struct evdev_list));
 
 	list->evdev = evdev_table[i];
-	list->next = evdev_table[i]->list;
-	evdev_table[i]->list = list;
-
+	list_add_tail(&list->node, &evdev_table[i]->list);
 	file->private_data = list;
 
 	if (!list->evdev->open++)
@@ -175,40 +146,21 @@
 
 static ssize_t evdev_read(struct file * file, char * buffer, size_t count, loff_t *ppos)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct evdev_list *list = file->private_data;
-	int retval = 0;
-
-	if (list->head == list->tail) {
-
-		add_wait_queue(&list->evdev->wait, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		while (list->head == list->tail) {
-
-			if (!list->evdev->exist) {
-				retval = -ENODEV;
-				break;
-			}
-			if (file->f_flags & O_NONBLOCK) {
-				retval = -EAGAIN;
-				break;
-			}
-			if (signal_pending(current)) {
-				retval = -ERESTARTSYS;
-				break;
-			}
+	int retval;
 
-			schedule();
-		}
+	if (list->head == list->tail && list->evdev->exist && (file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
 
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&list->evdev->wait, &wait);
-	}
+	retval = wait_event_interruptible(list->evdev->wait,
+		list->head != list->tail && list->evdev->exist);
 
 	if (retval)
 		return retval;
 
+	if (!list->evdev->exist)
+		return -ENODEV;
+
 	while (list->head != list->tail && retval + sizeof(struct input_event) <= count) {
 		if (copy_to_user(buffer + retval, list->buffer + list->tail,
 			 sizeof(struct input_event))) return -EFAULT;
@@ -433,21 +385,19 @@
 		return NULL;
 	memset(evdev, 0, sizeof(struct evdev));
 
+	INIT_LIST_HEAD(&evdev->list);
 	init_waitqueue_head(&evdev->wait);
 
+	evdev->exist = 1;
 	evdev->minor = minor;
-	evdev_table[minor] = evdev;
-	
-	sprintf(evdev->name, "event%d", minor);
-
 	evdev->handle.dev = dev;
 	evdev->handle.name = evdev->name;
 	evdev->handle.handler = handler;
 	evdev->handle.private = evdev;
+	sprintf(evdev->name, "event%d", minor);
 
+	evdev_table[minor] = evdev;
 	evdev->devfs = input_register_minor("event%d", minor, EVDEV_MINOR_BASE);
-
-	evdev->exist = 1;
 
 	return &evdev->handle;
 }
diff -Nru a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
--- a/drivers/input/gameport/emu10k1-gp.c	Tue Oct  8 15:26:21 2002
+++ b/drivers/input/gameport/emu10k1-gp.c	Tue Oct  8 15:26:21 2002
@@ -44,7 +44,6 @@
 
 struct emu {
 	struct pci_dev *dev;
-	struct emu *next;
 	struct gameport gameport;
 	int size;
 	char phys[32];
diff -Nru a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
--- a/drivers/input/gameport/ns558.c	Tue Oct  8 15:26:21 2002
+++ b/drivers/input/gameport/ns558.c	Tue Oct  8 15:26:21 2002
@@ -53,13 +53,13 @@
 	int type;
 	int size;
 	struct pci_dev *dev;
-	struct ns558 *next;
+	struct list_head node;
 	struct gameport gameport;
 	char phys[32];
 	char name[32];
 };
 	
-static struct ns558 *ns558;
+static LIST_HEAD(ns558_list);
 
 /*
  * ns558_isa_probe() tries to find an isa gameport at the
@@ -67,7 +67,7 @@
  * A joystick must be attached for this to work.
  */
 
-static struct ns558* ns558_isa_probe(int io, struct ns558 *next)
+static void ns558_isa_probe(int io)
 {
 	int i, j, b;
 	unsigned char c, u, v;
@@ -78,7 +78,7 @@
  */
 
 	if (check_region(io, 1))
-		return next;
+		return;
 
 /*
  * We must not be able to write arbitrary values to the port.
@@ -89,7 +89,7 @@
 	outb(~c & ~3, io);
 	if (~(u = v = inb(io)) & 3) {
 		outb(c, io);
-		return next;
+		return;
 	}
 /*
  * After a trigger, there must be at least some bits changing.
@@ -99,7 +99,7 @@
 
 	if (u == v) {
 		outb(c, io);
-		return next;
+		return;
 	}
 	wait_ms(3);
 /*
@@ -110,7 +110,7 @@
 	for (i = 0; i < 1000; i++)
 		if ((u ^ inb(io)) & 0xf) {
 			outb(c, io);
-			return next;
+			return;
 		}
 /* 
  * And now find the number of mirrors of the port.
@@ -134,11 +134,10 @@
 
 	if (!(port = kmalloc(sizeof(struct ns558), GFP_KERNEL))) {
 		printk(KERN_ERR "ns558: Memory allocation failed.\n");
-		return next;
+		return;
 	}
        	memset(port, 0, sizeof(struct ns558));
 	
-	port->next = next;
 	port->type = NS558_ISA;
 	port->size = (1 << i);
 	port->gameport.io = io & (-1 << i);
@@ -157,7 +156,7 @@
 	if (port->size > 1) printk(" size %d", port->size);
 	printk(" speed %d kHz\n", port->gameport.speed);
 
-	return port;
+	list_add(&port->node, &ns558_list);
 }
 
 #ifdef __ISAPNP__
@@ -194,22 +193,22 @@
 
 MODULE_DEVICE_TABLE(isapnp, pnp_devids);
 
-static struct ns558* ns558_pnp_probe(struct pci_dev *dev, struct ns558 *next)
+static void ns558_pnp_probe(struct pci_dev *dev)
 {
 	int ioport, iolen;
 	struct ns558 *port;
 
 	if (dev->prepare && dev->prepare(dev) < 0)
-		return next;
+		return;
 
 	if (!(dev->resource[0].flags & IORESOURCE_IO)) {
 		printk(KERN_WARNING "ns558: No i/o ports on a gameport? Weird\n");
-		return next;
+		return;
 	}
 
 	if (dev->activate && dev->activate(dev) < 0) {
 		printk(KERN_ERR "ns558: PnP resource allocation failed\n");
-		return next;
+		return;
 	}
 	
 	ioport = pci_resource_start(dev, 0);
@@ -224,7 +223,6 @@
 	}
 	memset(port, 0, sizeof(struct ns558));
 
-	port->next = next;
 	port->type = NS558_PNP;
 	port->size = iolen;
 	port->dev = dev;
@@ -247,12 +245,12 @@
 	if (iolen > 1) printk(" size %d", iolen);
 	printk(" speed %d kHz\n", port->gameport.speed);
 
-	return port;
+	list_add_tail(&port->node, &ns558_list);
+	return;
 
 deactivate:
 	if (dev->deactivate)
 		dev->deactivate(dev);
-	return next;
 }
 #endif
 
@@ -269,28 +267,26 @@
  */
 
 	while (ns558_isa_portlist[i]) 
-		ns558 = ns558_isa_probe(ns558_isa_portlist[i++], ns558);
+		ns558_isa_probe(ns558_isa_portlist[i++]);
 
 /*
  * Probe for PnP ports.
  */
 
 #ifdef __ISAPNP__
-	for (devid = pnp_devids; devid->vendor; devid++) {
-		while ((dev = isapnp_find_dev(NULL, devid->vendor, devid->function, dev))) {
-			ns558 = ns558_pnp_probe(dev, ns558);
-		}
-	}
+	for (devid = pnp_devids; devid->vendor; devid++)
+		while ((dev = isapnp_find_dev(NULL, devid->vendor, devid->function, dev)))
+			ns558_pnp_probe(dev);
 #endif
 
-	return ns558 ? 0 : -ENODEV;
+	return list_empty(&ns558_list) ? -ENODEV : 0;
 }
 
 void __exit ns558_exit(void)
 {
-	struct ns558 *next, *port = ns558;
+	struct ns558 *port;
 
-	while (port) {
+	list_for_each_entry(port, &ns558_list, node) {
 		gameport_unregister_port(&port->gameport);
 		switch (port->type) {
 
@@ -308,10 +304,6 @@
 			default:
 				break;
 		}
-		
-		next = port->next;
-		kfree(port);
-		port = next;
 	}
 }
 
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	Tue Oct  8 15:26:21 2002
+++ b/drivers/input/joydev.c	Tue Oct  8 15:26:21 2002
@@ -1,30 +1,13 @@
 /*
- * $Id: joydev.c,v 1.43 2002/04/09 23:59:01 jsimmons Exp $
+ * Joystick device driver for the input driver suite.
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik 
- *  Copyright (c) 1999 Colin Van Dyke 
+ * Copyright (c) 1999-2002 Vojtech Pavlik 
+ * Copyright (c) 1999 Colin Van Dyke 
  *
- *  Joystick device driver for the input driver suite.
- */
-
-/*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or 
  * (at your option) any later version.
- * 
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <asm/io.h>
@@ -63,8 +46,7 @@
 	struct input_handle handle;
 	wait_queue_head_t wait;
 	devfs_handle_t devfs;
-	struct joydev *next;
-	struct joydev_list *list;
+	struct list_head list;
 	struct js_corr corr[ABS_MAX];
 	struct JS_DATA_SAVE_TYPE glue;
 	int nabs;
@@ -83,7 +65,7 @@
 	int startup;
 	struct fasync_struct *fasync;
 	struct joydev *joydev;
-	struct joydev_list *next;
+	struct list_head node;
 };
 
 static struct joydev *joydev_table[JOYDEV_MINORS];
@@ -111,7 +93,7 @@
 static void joydev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
 {
 	struct joydev *joydev = handle->private;
-	struct joydev_list *list = joydev->list;
+	struct joydev_list *list;
 	struct js_event event;
 
 	switch (type) {
@@ -137,7 +119,7 @@
 
 	event.time = MSECS(jiffies);
 
-	while (list) {
+	list_for_each_entry(list, &joydev->list, node) {
 
 		memcpy(list->buffer + list->head, &event, sizeof(struct js_event));
 
@@ -146,8 +128,6 @@
 				list->startup = 0;
 
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
-
-		list = list->next;
 	}
 
 	wake_up_interruptible(&joydev->wait);
@@ -164,14 +144,10 @@
 static int joydev_release(struct inode * inode, struct file * file)
 {
 	struct joydev_list *list = file->private_data;
-	struct joydev_list **listptr;
 
-	listptr = &list->joydev->list;
 	joydev_fasync(-1, file, 0);
 
-	while (*listptr && (*listptr != list))
-		listptr = &((*listptr)->next);
-	*listptr = (*listptr)->next;
+	list_del(&list->node);
 
 	if (!--list->joydev->open) {
 		if (list->joydev->exist) {
@@ -201,9 +177,7 @@
 	memset(list, 0, sizeof(struct joydev_list));
 
 	list->joydev = joydev_table[i];
-	list->next = joydev_table[i]->list;
-	joydev_table[i]->list = list;	
-
+	list_add_tail(&list->node, &joydev_table[i]->list);
 	file->private_data = list;
 
 	if (!list->joydev->open++)
@@ -220,12 +194,14 @@
 
 static ssize_t joydev_read(struct file *file, char *buf, size_t count, loff_t *ppos)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct joydev_list *list = file->private_data;
 	struct joydev *joydev = list->joydev;
 	struct input_dev *input = joydev->handle.dev;
 	int retval = 0;
 
+	if (!list->joydev->exist)
+		return -ENODEV;
+
 	if (count < sizeof(struct js_event))
 		return -EINVAL;
 
@@ -248,36 +224,19 @@
 		return sizeof(struct JS_DATA_TYPE);
 	}
 
-	if (list->head == list->tail && list->startup == joydev->nabs + joydev->nkey) {
-
-		add_wait_queue(&list->joydev->wait, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		while (list->head == list->tail) {
-
-			if (!joydev->exist) {
-				retval = -ENODEV;
-				break;
-			}
-			if (file->f_flags & O_NONBLOCK) {
-				retval = -EAGAIN;
-				break;
-			}
-			if (signal_pending(current)) {
-				retval = -ERESTARTSYS;
-				break;
-			}
-
-			schedule();
-		}
+	if (list->startup == joydev->nabs + joydev->nkey
+		&& list->head == list->tail && (file->f_flags & O_NONBLOCK))
+			return -EAGAIN;
 
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&list->joydev->wait, &wait);
-	}
+	retval = wait_event_interruptible(list->joydev->wait, list->joydev->exist
+		&& (list->startup < joydev->nabs + joydev->nkey || list->head != list->tail));
 
 	if (retval)
 		return retval;
 
+	if (!list->joydev->exist)
+		return -ENODEV;
+
 	while (list->startup < joydev->nabs + joydev->nkey && retval + sizeof(struct js_event) <= count) {
 
 		struct js_event event;
@@ -431,17 +390,16 @@
 		return NULL;
 	memset(joydev, 0, sizeof(struct joydev));
 
+	INIT_LIST_HEAD(&joydev->list);
 	init_waitqueue_head(&joydev->wait);
 
 	joydev->minor = minor;
-	joydev_table[minor] = joydev;
-
-	sprintf(joydev->name, "js%d", minor);
-
+	joydev->exist = 1;
 	joydev->handle.dev = dev;
 	joydev->handle.name = joydev->name;
 	joydev->handle.handler = handler;
 	joydev->handle.private = joydev;
+	sprintf(joydev->name, "js%d", minor);
 
 	for (i = 0; i < ABS_MAX; i++)
 		if (test_bit(i, dev->absbit)) {
@@ -482,9 +440,8 @@
 		joydev->abs[i] = joydev_correct(dev->abs[j], joydev->corr + i);
 	}
 
+	joydev_table[minor] = joydev;
 	joydev->devfs = input_register_minor("js%d", minor, JOYDEV_MINOR_BASE);
-
-	joydev->exist = 1;
 
 	return &joydev->handle;
 }
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Tue Oct  8 15:26:21 2002
+++ b/drivers/input/mousedev.c	Tue Oct  8 15:26:21 2002
@@ -1,29 +1,11 @@
 /*
- * $Id: mousedev.c,v 1.42 2002/04/09 20:51:26 jdeneux Exp $
+ * Input driver to ExplorerPS/2 device driver module.
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
+ * Copyright (c) 1999-2002 Vojtech Pavlik
  *
- *  Input driver to ExplorerPS/2 device driver module.
- */
-
-/*
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
- * (at your option) any later version.
- * 
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ * it under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #define MOUSEDEV_MINOR_BASE 	32
@@ -61,7 +43,7 @@
 	int minor;
 	char name[16];
 	wait_queue_head_t wait;
-	struct mousedev_list *list;
+	struct list_head list;
 	struct input_handle handle;
 	devfs_handle_t devfs;
 };
@@ -69,7 +51,7 @@
 struct mousedev_list {
 	struct fasync_struct *fasync;
 	struct mousedev *mousedev;
-	struct mousedev_list *next;
+	struct list_head node;
 	int dx, dy, dz, oldx, oldy;
 	signed char ps2[6];
 	unsigned long buttons;
@@ -98,9 +80,10 @@
 	int index, size, wake;
 
 	while (*mousedev) {
+
 		wake = 0;
-		list = (*mousedev)->list;
-		while (list) {
+
+		list_for_each_entry(list, &(*mousedev)->list, node)
 			switch (type) {
 				case EV_ABS:
 					if (test_bit(BTN_TRIGGER, handle->dev->keybit))
@@ -116,6 +99,7 @@
 								list->oldx += list->dx;
 							}
 							break;
+
 						case ABS_Y:
 							size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
 							if (size != 0) {
@@ -170,10 +154,10 @@
 							break;
 					}
 			}
-			list = list->next;
-		}
+
 		if (wake)
 			wake_up_interruptible(&((*mousedev)->wait));
+
 		mousedev++;
 	}
 }
@@ -189,21 +173,17 @@
 static int mousedev_release(struct inode * inode, struct file * file)
 {
 	struct mousedev_list *list = file->private_data;
-	struct mousedev_list **listptr;
+	struct input_handle *handle;
+	struct mousedev *mousedev;
 
-	listptr = &list->mousedev->list;
 	mousedev_fasync(-1, file, 0);
 
-	while (*listptr && (*listptr != list))
-		listptr = &((*listptr)->next);
-	*listptr = (*listptr)->next;
+	list_del(&list->node);
 
 	if (!--list->mousedev->open) {
 		if (list->mousedev->minor == MOUSEDEV_MIX) {
-			struct list_head * node;
-			list_for_each(node,&mousedev_handler.h_list) {
-				struct input_handle *handle = to_handle_h(node);
-				struct mousedev *mousedev = handle->private;
+			list_for_each_entry(handle, &mousedev_handler.h_list, h_node) {
+				mousedev = handle->private;
 				if (!mousedev->open) {
 					if (mousedev->exist) {
 						input_close_device(&mousedev->handle);
@@ -252,8 +232,7 @@
 	memset(list, 0, sizeof(struct mousedev_list));
 
 	list->mousedev = mousedev_table[i];
-	list->next = mousedev_table[i]->list;
-	mousedev_table[i]->list = list;
+	list_add_tail(&list->node, &mousedev_table[i]->list);
 	file->private_data = list;
 
 	if (!list->mousedev->open++) {
@@ -373,35 +352,13 @@
 
 static ssize_t mousedev_read(struct file * file, char * buffer, size_t count, loff_t *ppos)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct mousedev_list *list = file->private_data;
 	int retval = 0;
 
-	if (!list->ready && !list->buffer) {
-
-		add_wait_queue(&list->mousedev->wait, &wait);
-
-		for (;;) {
-			set_current_state(TASK_INTERRUPTIBLE);
-
-			retval = 0;
-			if (list->ready || list->buffer)
-				break;
-
-			retval = -EAGAIN;
-			if (file->f_flags & O_NONBLOCK)
-				break;
+	if (!list->ready && !list->buffer && (file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
 
-			retval = -ERESTARTSYS;
-			if (signal_pending(current))
-				break;
-
-			schedule();
-		}
-
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&list->mousedev->wait, &wait);
-	}
+	retval = wait_event_interruptible(list->mousedev->wait, list->ready || list->buffer);
 
 	if (retval)
 		return retval;
@@ -454,23 +411,23 @@
 	if (!(mousedev = kmalloc(sizeof(struct mousedev), GFP_KERNEL)))
 		return NULL;
 	memset(mousedev, 0, sizeof(struct mousedev));
+
+	INIT_LIST_HEAD(&mousedev->list);
 	init_waitqueue_head(&mousedev->wait);
 
 	mousedev->minor = minor;
-	mousedev_table[minor] = mousedev;
-	sprintf(mousedev->name, "mouse%d", minor);
-
+	mousedev->exist = 1;
 	mousedev->handle.dev = dev;
 	mousedev->handle.name = mousedev->name;
 	mousedev->handle.handler = handler;
 	mousedev->handle.private = mousedev;
-
-	mousedev->devfs = input_register_minor("mouse%d", minor, MOUSEDEV_MINOR_BASE);
+	sprintf(mousedev->name, "mouse%d", minor);
 
 	if (mousedev_mix.open)
 		input_open_device(&mousedev->handle);
 
-	mousedev->exist = 1;
+	mousedev_table[minor] = mousedev;
+	mousedev->devfs = input_register_minor("mouse%d", minor, MOUSEDEV_MINOR_BASE);
 
 	return &mousedev->handle;
 }
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	Tue Oct  8 15:26:21 2002
+++ b/drivers/input/tsdev.c	Tue Oct  8 15:26:21 2002
@@ -55,7 +55,7 @@
 	int minor;
 	char name[16];
 	wait_queue_head_t wait;
-	struct tsdev_list *list;
+	struct list_head list;
 	struct input_handle handle;
 	devfs_handle_t devfs;
 };
@@ -70,7 +70,7 @@
 
 struct tsdev_list {
 	struct fasync_struct *fasync;
-	struct tsdev_list *next;
+	struct list_head node;
 	struct tsdev *tsdev;
 	int head, tail;
 	int oldx, oldy, pendown;
@@ -106,8 +106,7 @@
 	memset(list, 0, sizeof(struct tsdev_list));
 
 	list->tsdev = tsdev_table[i];
-	list->next = tsdev_table[i]->list;
-	tsdev_table[i]->list = list;
+	list_add_tail(&list->node, &tsdev_table[i]->list);
 	file->private_data = list;
 
 	if (!list->tsdev->open++)
@@ -119,14 +118,9 @@
 static int tsdev_release(struct inode *inode, struct file *file)
 {
 	struct tsdev_list *list = file->private_data;
-	struct tsdev_list **listptr;
 
-	listptr = &list->tsdev->list;
 	tsdev_fasync(-1, file, 0);
-
-	while (*listptr && (*listptr != list))
-		listptr = &((*listptr)->next);
-	*listptr = (*listptr)->next;
+	list_del(&list->node);
 
 	if (!--list->tsdev->open) {
 		if (list->tsdev->exist) {
@@ -144,45 +138,28 @@
 static ssize_t tsdev_read(struct file *file, char *buffer, size_t count,
 			  loff_t * ppos)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct tsdev_list *list = file->private_data;
 	int retval = 0;
 
-	if (list->head == list->tail) {
-		add_wait_queue(&list->tsdev->wait, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		while (list->head == list->tail) {
-			if (!list->tsdev->exist) {
-				retval = -ENODEV;
-				break;
-			}
-			if (file->f_flags & O_NONBLOCK) {
-				retval = -EAGAIN;
-				break;
-			}
-			if (signal_pending(current)) {
-				retval = -ERESTARTSYS;
-				break;
-			}
-			schedule();
-		}
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&list->tsdev->wait, &wait);
-	}
+	if (list->head == list->tail && list->tsdev->exist && (file->f_flags & O_NONBLOCK))
+		return -EAGAIN;
+
+	retval = wait_event_interruptible(list->tsdev->wait,
+		(list->head != list->tail) && list->tsdev->exist);
 
 	if (retval)
 		return retval;
 
-	while (list->head != list->tail
-	       && retval + sizeof(TS_EVENT) <= count) {
-		if (copy_to_user
-		    (buffer + retval, list->event + list->tail,
-		     sizeof(TS_EVENT)))
+	if (!list->tsdev->exist)
+		return -ENODEV;
+
+	while (list->head != list->tail && retval + sizeof(TS_EVENT) <= count) {
+		if (copy_to_user (buffer + retval, list->event + list->tail, sizeof(TS_EVENT)))
 			return -EFAULT;
 		list->tail = (list->tail + 1) & (TSDEV_BUFFER_SIZE - 1);
 		retval += sizeof(TS_EVENT);
 	}
+
 	return retval;
 }
 
@@ -232,54 +209,35 @@
 			unsigned int code, int value)
 {
 	struct tsdev *tsdev = handle->private;
-	struct tsdev_list *list = tsdev->list;
+	struct tsdev_list *list;
 	struct timeval time;
 	int size;
 
-	while (list) {
+	list_for_each_entry(list, &tsdev->list, node) {
 		switch (type) {
 		case EV_ABS:
 			switch (code) {
 			case ABS_X:
 				if (!list->pendown)
 					return;
-
-				size =
-				    handle->dev->absmax[ABS_X] -
-				    handle->dev->absmin[ABS_X];
+				size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
 				if (size > 0)
-					list->oldx =
-					    ((value -
-					      handle->dev->absmin[ABS_X]) *
-					     xres / size);
+					list->oldx = ((value - handle->dev->absmin[ABS_X]) * xres / size);
 				else
-					list->oldx =
-					    ((value -
-					      handle->dev->absmin[ABS_X]));
+					list->oldx = ((value - handle->dev->absmin[ABS_X]));
 				break;
 			case ABS_Y:
 				if (!list->pendown)
 					return;
-
-				size =
-				    handle->dev->absmax[ABS_Y] -
-				    handle->dev->absmin[ABS_Y];
+				size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
 				if (size > 0)
-					list->oldy =
-					    ((value -
-					      handle->dev->absmin[ABS_Y]) *
-					     yres / size);
+					list->oldy = ((value - handle->dev->absmin[ABS_Y]) * yres / size);
 				else
-					list->oldy =
-					    ((value -
-					      handle->dev->absmin[ABS_Y]));
+					list->oldy = ((value - handle->dev->absmin[ABS_Y]));
 				break;
 			case ABS_PRESSURE:
-				list->pendown =
-				    ((value >
-				      handle->dev->
-				      absmin[ABS_PRESSURE])) ? value -
-				    handle->dev->absmin[ABS_PRESSURE] : 0;
+				list->pendown = ((value > handle->dev-> absmin[ABS_PRESSURE])) ?
+				    value - handle->dev->absmin[ABS_PRESSURE] : 0;
 				break;
 			}
 			break;
@@ -289,7 +247,6 @@
 			case REL_X:
 				if (!list->pendown)
 					return;
-
 				list->oldx += value;
 				if (list->oldx < 0)
 					list->oldx = 0;
@@ -299,7 +256,6 @@
 			case REL_Y:
 				if (!list->pendown)
 					return;
-
 				list->oldy += value;
 				if (list->oldy < 0)
 					list->oldy = 0;
@@ -333,7 +289,6 @@
 		list->event[list->head].y = list->oldy;
 		list->head = (list->head + 1) & (TSDEV_BUFFER_SIZE - 1);
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
-		list = list->next;
 	}
 	wake_up_interruptible(&tsdev->wait);
 }
@@ -356,21 +311,23 @@
 	if (!(tsdev = kmalloc(sizeof(struct tsdev), GFP_KERNEL)))
 		return NULL;
 	memset(tsdev, 0, sizeof(struct tsdev));
+
+	INIT_LIST_HEAD(&tsdev->list);
 	init_waitqueue_head(&tsdev->wait);
 
-	tsdev->minor = minor;
-	tsdev_table[minor] = tsdev;
 	sprintf(tsdev->name, "ts%d", minor);
 
+	tsdev->exist = 1;
+	tsdev->minor = minor;
 	tsdev->handle.dev = dev;
 	tsdev->handle.name = tsdev->name;
 	tsdev->handle.handler = handler;
 	tsdev->handle.private = tsdev;
 
+	tsdev_table[minor] = tsdev;
 	tsdev->devfs =
 	    input_register_minor("ts%d", minor, TSDEV_MINOR_BASE);
 
-	tsdev->exist = 1;
 
 	return &tsdev->handle;
 }

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.42
## Wrapped with gzip_uu ##


begin 664 bkpatch18154
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
/7:$\1U7_#RDC9GTK*```
`
end

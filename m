Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVFPUYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVFPUYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVFPUX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:23:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:47043 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261804AbVFPUUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:20:33 -0400
Subject: [patch][3/4] ibmasm driver: redesign handling of remote control
	events
From: Max Asbock <masbock@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Vernon Mauery <vernux@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-Z+LqU4Th9gc++0XFPDrY"
Message-Id: <1118953219.8372.80.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 16 Jun 2005 13:20:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z+LqU4Th9gc++0XFPDrY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch rewrites the handling of remote control events.  Rather than
making them available from a special file in the ibmasmfs, now the
events from the RSA card get translated into kernel input events and
injected into the input subsystem.  The driver now will generate
two /dev/input/eventX nodes -- one for the keyboard and one for the
mouse.  The mouse node generates absolute events more like a touch pad
than a mouse.

Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
Signed-off-by: Max Asbock <masbock@us.ibm.com>

My apologies for this being sent as an attachment, but 
I can't get my mailer to accept the one umlaut in the patch.


--=-Z+LqU4Th9gc++0XFPDrY
Content-Disposition: attachment; filename=linux-2.6.12-rc6.ibmasm_remote.patch
Content-Type: text/x-patch; name=linux-2.6.12-rc6.ibmasm_remote.patch; charset=
Content-Transfer-Encoding: 8bit

diff -urN linux-2.6.12-rc6.test/drivers/misc/ibmasm/ibmasmfs.c linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/ibmasmfs.c
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/ibmasmfs.c	2005-06-09 18:02:54.832331088 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/ibmasmfs.c	2005-06-08 17:54:09.533985064 -0700
@@ -37,9 +37,7 @@
  *    |   |-- event
  *    |   |-- reverse_heartbeat
  *    |   `-- remote_video
- *    |       |-- connected
  *    |       |-- depth
- *    |       |-- events
  *    |       |-- height
  *    |       `-- width
  *    .
@@ -50,9 +48,7 @@
  *        |-- event
  *        |-- reverse_heartbeat
  *        `-- remote_video
- *            |-- connected
  *            |-- depth
- *            |-- events
  *            |-- height
  *            `-- width
  *
@@ -75,14 +71,6 @@
  * remote_video/width: control remote display settings
  * 	write: set value
  * 	read: read value
- *
- * remote_video/connected
- * 	read: return "1" if web browser VNC java applet is connected, 
- * 		"0" otherwise
- *
- * remote_video/events
- * 	read: sleep until a remote mouse or keyboard event occurs, then return
- * 		then event.
  */
 
 #include <linux/fs.h>
@@ -593,75 +581,6 @@
 	return count;
 }
 
-static int remote_event_file_open(struct inode *inode, struct file *file)
-{
-	struct service_processor *sp;
-	unsigned long flags;
-	struct remote_queue *q;
-	
-	file->private_data = inode->u.generic_ip;
-	sp = file->private_data;
-	q = &sp->remote_queue;
-
-	/* allow only one event reader */
-	spin_lock_irqsave(&sp->lock, flags);
-	if (q->open) {
-		spin_unlock_irqrestore(&sp->lock, flags);
-		return -EBUSY;
-	}
-	q->open = 1;
-	spin_unlock_irqrestore(&sp->lock, flags);
-
-	enable_mouse_interrupts(sp);
-	
-	return 0;
-}
-
-static int remote_event_file_close(struct inode *inode, struct file *file)
-{
-	struct service_processor *sp = file->private_data;
-
-	disable_mouse_interrupts(sp);
-	wake_up_interruptible(&sp->remote_queue.wait);
-	sp->remote_queue.open = 0;
-
-	return 0;
-}
-
-static ssize_t remote_event_file_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
-{
-	struct service_processor *sp = file->private_data;
-	struct remote_queue *q = &sp->remote_queue;
-	size_t data_size;
-	struct remote_event *reader = q->reader;
-	size_t num_events;
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count == 0 || count > 1024)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	if (wait_event_interruptible(q->wait, q->reader != q->writer))
-		return -ERESTARTSYS;
-
-	/* only get multiples of struct remote_event */
-	num_events = min((count/sizeof(struct remote_event)), ibmasm_events_available(q));
-	if (!num_events)
-		return 0;
-
-	data_size = num_events * sizeof(struct remote_event);
-
-	if (copy_to_user(buf, reader, data_size))
-		return -EFAULT;
-
-	ibmasm_advance_reader(q, num_events);
-
-	return data_size;
-}
-
-
 static struct file_operations command_fops = {
 	.open =		command_file_open,
 	.release =	command_file_close,
@@ -690,12 +609,6 @@
 	.write =	remote_settings_file_write,
 };
 
-static struct file_operations remote_event_fops = {
-	.open =		remote_event_file_open,
-	.release =	remote_event_file_close,
-	.read =		remote_event_file_read,
-};
-
 
 static void ibmasmfs_create_files (struct super_block *sb, struct dentry *root)
 {
@@ -721,7 +634,5 @@
 		ibmasmfs_create_file(sb, remote_dir, "width", &remote_settings_fops, (void *)display_width(sp), S_IRUSR|S_IWUSR);
 		ibmasmfs_create_file(sb, remote_dir, "height", &remote_settings_fops, (void *)display_height(sp), S_IRUSR|S_IWUSR);
 		ibmasmfs_create_file(sb, remote_dir, "depth", &remote_settings_fops, (void *)display_depth(sp), S_IRUSR|S_IWUSR);
-		ibmasmfs_create_file(sb, remote_dir, "connected", &remote_settings_fops, (void *)vnc_status(sp), S_IRUSR);
-		ibmasmfs_create_file(sb, remote_dir, "events", &remote_event_fops, (void *)sp, S_IRUSR);
 	}
 }
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/ibmasm.h	2005-06-09 18:02:54.833330936 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/ibmasm.h	2005-06-08 17:54:09.534984912 -0700
@@ -34,16 +34,27 @@
 #include <linux/version.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/input.h>
 
 /* Driver identification */
 #define DRIVER_NAME	"ibmasm"
-#define DRIVER_VERSION  "0.4"
-#define DRIVER_AUTHOR   "Max Asbock"
+#define DRIVER_VERSION  "1.0"
+#define DRIVER_AUTHOR   "Max Asbock <masbock@us.ibm.com>, Vernon Mauery <vernux@us.ibm.com>"
 #define DRIVER_DESC     "IBM ASM Service Processor Driver"
 
 #define err(msg) printk(KERN_ERR "%s: " msg "\n", DRIVER_NAME)
 #define info(msg) printk(KERN_INFO "%s: " msg "\n", DRIVER_NAME)
 
+extern int debug;
+#define dbg(STR, ARGS ...) do { if (debug) printk(KERN_DEBUG STR, ##ARGS); } while (0)
+
+static inline char *get_timestamp(char *buf)
+{
+	struct timeval now;
+	do_gettimeofday(&now);
+	sprintf(buf, "%lu.%lu", now.tv_sec, now.tv_usec);
+	return buf;
+}
 
 #define IBMASM_CMD_PENDING	0	
 #define IBMASM_CMD_COMPLETE	1	
@@ -121,41 +132,11 @@
 	unsigned int		stopped;
 };
 
-
-/* remote console events */
-struct mouse_event {
-	long		x;
-	long		y;
-	unsigned char	buttons;
-	unsigned char	transitions;
-};
-
-struct keyboard_event {
-	unsigned long	key_code;
-	unsigned char	key_down;
-};
-
-struct remote_event {
-	unsigned long	type;
-	union {
-		struct mouse_event	mouse;
-		struct keyboard_event	keyboard;
-	} data;
-};
-
-#define DRIVER_REMOTE_QUEUE_SIZE 240
-
-struct remote_queue {
-	struct remote_event	*start;
-	struct remote_event	*end;
-	struct remote_event	*reader;
-	struct remote_event	*writer;
-	unsigned int		size;
-	int			open;
-	wait_queue_head_t	wait;
+struct ibmasm_remote {
+	struct input_dev keybd_dev;
+	struct input_dev mouse_dev;
 };
 
-
 struct service_processor {
 	struct list_head	node;
 	spinlock_t		lock;
@@ -168,13 +149,13 @@
 	char			dirname[IBMASM_NAME_SIZE];
 	char			devname[IBMASM_NAME_SIZE];
 	unsigned int		number;
-	struct remote_queue	remote_queue;
+	struct ibmasm_remote	*remote;
 	int			serial_line;
 	struct device		*dev;
 };
 
 /* command processing */
-extern struct command *ibmasm_new_command(size_t buffer_size);
+extern struct command *ibmasm_new_command(size_t buffer_size);
 extern void ibmasm_exec_command(struct service_processor *sp, struct command *cmd);
 extern void ibmasm_wait_for_response(struct command *cmd, int timeout);
 extern void ibmasm_receive_command_response(struct service_processor *sp, void *response,  size_t size);
@@ -210,11 +191,9 @@
 extern irqreturn_t ibmasm_interrupt_handler(int irq, void * dev_id, struct pt_regs *regs);
 
 /* remote console */
-extern void ibmasm_handle_mouse_interrupt(struct service_processor *sp);
-extern int ibmasm_init_remote_queue(struct service_processor *sp);
-extern void ibmasm_free_remote_queue(struct service_processor *sp);
-extern void ibmasm_advance_reader(struct remote_queue *q, unsigned int n);
-extern size_t ibmasm_events_available(struct remote_queue *q);
+extern void ibmasm_handle_mouse_interrupt(struct service_processor *sp, struct pt_regs *regs);
+extern int ibmasm_init_remote_input_dev(struct service_processor *sp);
+extern void ibmasm_free_remote_input_dev(struct service_processor *sp);
 
 /* file system */
 extern int ibmasmfs_register(void);
diff -urN linux-2.6.12-rc6.test/drivers/misc/ibmasm/lowlevel.c linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/lowlevel.c
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/lowlevel.c	2005-06-09 18:02:28.022406816 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/lowlevel.c	2005-06-08 17:54:09.535984760 -0700
@@ -46,8 +46,8 @@
 
 	message = get_i2o_message(sp->base_address, mfa);
 
-	memcpy(&message->header, &header, sizeof(struct i2o_header));
-	memcpy(&message->data, command->buffer, command_size);
+	memcpy_toio(&message->header, &header, sizeof(struct i2o_header));
+	memcpy_toio(&message->data, command->buffer, command_size);
 
 	set_mfa_inbound(sp->base_address, mfa);
 
@@ -59,23 +59,27 @@
 	u32	mfa;
 	struct service_processor *sp = (struct service_processor *)dev_id;
 	void __iomem *base_address = sp->base_address;
+	char tsbuf[32];
 
 	if (!sp_interrupt_pending(base_address))
 		return IRQ_NONE;
 
+	dbg("respond to interrupt at %s\n", get_timestamp(tsbuf));
+
 	if (mouse_interrupt_pending(sp)) {
-		ibmasm_handle_mouse_interrupt(sp);
-		mfa = get_mfa_outbound(base_address);
+		ibmasm_handle_mouse_interrupt(sp, regs);
 		clear_mouse_interrupt(sp);
-		set_mfa_outbound(base_address, mfa);
-		return IRQ_HANDLED;
 	}
 
 	mfa = get_mfa_outbound(base_address);
 	if (valid_mfa(mfa)) {
 		struct i2o_message *msg = get_i2o_message(base_address, mfa);
 		ibmasm_receive_message(sp, &msg->data, incoming_data_size(msg));
-	}
+	} else
+		dbg("didn't get a valid MFA\n");
+
 	set_mfa_outbound(base_address, mfa);
+	dbg("finished interrupt at   %s\n", get_timestamp(tsbuf));
+
 	return IRQ_HANDLED;
 }
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/module.c	2005-06-09 18:02:28.021406968 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/module.c	2005-06-08 23:01:19.630184568 -0700
@@ -56,17 +56,26 @@
 #include "lowlevel.h"
 #include "remote.h"
 
+int debug = 0;
+module_param(debug, int , S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(debug, " Set debug mode on or off");
+
 
 static int __devinit ibmasm_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int err, result = -ENOMEM;
+	int result;
 	struct service_processor *sp;
 
-	if ((err = pci_enable_device(pdev))) {
-		printk(KERN_ERR "%s: can't enable PCI device at %s\n",
-			DRIVER_NAME, pci_name(pdev));
-		return err;
+	if ((result = pci_enable_device(pdev))) {
+		dev_err(&pdev->dev, "Failed to enable PCI device\n");
+		return result;
 	}
+	if ((result = pci_request_regions(pdev, DRIVER_NAME))) {
+		dev_err(&pdev->dev, "Failed to allocate PCI resources\n");
+		goto error_resources;
+	}
+	/* vnc client won't work without bus-mastering */
+	pci_set_master(pdev);
 
 	sp = kmalloc(sizeof(struct service_processor), GFP_KERNEL);
 	if (sp == NULL) {
@@ -76,6 +85,9 @@
 	}
 	memset(sp, 0, sizeof(struct service_processor));
 
+	sp->lock = SPIN_LOCK_UNLOCKED;
+	INIT_LIST_HEAD(&sp->command_queue);
+
 	pci_set_drvdata(pdev, (void *)sp);
 	sp->dev = &pdev->dev;
 	sp->number = pdev->bus->number;
@@ -101,15 +113,6 @@
 		goto error_ioremap;
 	}
 
-	result = ibmasm_init_remote_queue(sp);
-	if (result) {
-		dev_err(sp->dev, "Failed to initialize remote queue\n");
-		goto error_remote_queue;
-	}
-
-	spin_lock_init(&sp->lock);
-	INIT_LIST_HEAD(&sp->command_queue);
-
 	result = request_irq(sp->irq, ibmasm_interrupt_handler, SA_SHIRQ, sp->devname, (void*)sp);
 	if (result) {
 		dev_err(sp->dev, "Failed to register interrupt handler\n");
@@ -117,7 +120,12 @@
 	}
 
 	enable_sp_interrupts(sp->base_address);
-	disable_mouse_interrupts(sp);
+
+	result = ibmasm_init_remote_input_dev(sp);
+	if (result) {
+		dev_err(sp->dev, "Failed to initialize remote queue\n");
+		goto error_send_message;
+	}
 
 	result = ibmasm_send_driver_vpd(sp);
 	if (result) {
@@ -133,30 +141,25 @@
 
 	ibmasm_register_uart(sp);
 
-	dev_printk(KERN_DEBUG, &pdev->dev, "WARNING: This software may not be supported or function\n");
-	dev_printk(KERN_DEBUG, &pdev->dev, "correctly on your IBM server. Please consult the IBM\n");
-	dev_printk(KERN_DEBUG, &pdev->dev, "ServerProven website\n");
-	dev_printk(KERN_DEBUG, &pdev->dev, "http://www.pc.ibm.com/ww/eserver/xseries/serverproven\n");
-	dev_printk(KERN_DEBUG, &pdev->dev, "for information on the specific driver level and support\n");
-	dev_printk(KERN_DEBUG, &pdev->dev, "statement for your IBM server.\n");
-
 	return 0;
 
 error_send_message:
 	disable_sp_interrupts(sp->base_address);
+	ibmasm_free_remote_input_dev(sp);
 	free_irq(sp->irq, (void *)sp);
 error_request_irq:
-	ibmasm_free_remote_queue(sp);
-error_remote_queue:
 	iounmap(sp->base_address);
 error_ioremap:
 	ibmasm_heartbeat_exit(sp);
 error_heartbeat:
 	ibmasm_event_buffer_exit(sp);
 error_eventbuffer:
+	pci_set_drvdata(pdev, NULL);
 	kfree(sp);
 error_kmalloc:
-	pci_disable_device(pdev);
+        pci_release_regions(pdev);
+error_resources:
+        pci_disable_device(pdev);
 
 	return result;
 }
@@ -165,16 +168,24 @@
 {
 	struct service_processor *sp = (struct service_processor *)pci_get_drvdata(pdev);
 
+	dbg("Unregistering UART\n");
 	ibmasm_unregister_uart(sp);
-	ibmasm_send_os_state(sp, SYSTEM_STATE_OS_DOWN);
+	dbg("Sending OS down message\n");
+	if (ibmasm_send_os_state(sp, SYSTEM_STATE_OS_DOWN))
+		err("failed to get repsonse to 'Send OS State' command\n");
+	dbg("Disabling heartbeats\n");
+	ibmasm_heartbeat_exit(sp);
+	dbg("Disabling interrupts\n");
 	disable_sp_interrupts(sp->base_address);
-	disable_mouse_interrupts(sp);
+	dbg("Freeing SP irq\n");
 	free_irq(sp->irq, (void *)sp);
-	ibmasm_heartbeat_exit(sp);
-	ibmasm_free_remote_queue(sp);
+	dbg("Cleaning up\n");
+	ibmasm_free_remote_input_dev(sp);
 	iounmap(sp->base_address);
 	ibmasm_event_buffer_exit(sp);
+	pci_set_drvdata(pdev, NULL);
 	kfree(sp);
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
 
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/remote.c	2005-06-09 18:02:28.021406968 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/remote.c	2005-06-08 17:54:09.539984152 -0700
@@ -1,4 +1,3 @@
-
 /*
  * IBM ASM Service Processor Device Driver
  *
@@ -18,135 +17,256 @@
  *
  * Copyright (C) IBM Corporation, 2004
  *
- * Author: Max Asböck <amax@us.ibm.com> 
+ * Authors: Max Asböck <amax@us.ibm.com> 
+ *          Vernon Mauery <vernux@us.ibm.com>
  *
  */
 
 /* Remote mouse and keyboard event handling functions */
 
+#include <linux/pci.h>
 #include "ibmasm.h"
 #include "remote.h"
 
-int ibmasm_init_remote_queue(struct service_processor *sp)
-{
-	struct remote_queue *q = &sp->remote_queue;
+static int xmax = 1600;
+static int ymax = 1200;
 
-	disable_mouse_interrupts(sp);
 
-	q->open = 0;
-	q->size = 0;
+static unsigned short xlate_high[XLATE_SIZE] = {
+	[KEY_SYM_ENTER & 0xff] = KEY_ENTER,
+	[KEY_SYM_KPSLASH & 0xff] = KEY_KPSLASH,
+	[KEY_SYM_KPSTAR & 0xff] = KEY_KPASTERISK,
+	[KEY_SYM_KPMINUS & 0xff] = KEY_KPMINUS,
+	[KEY_SYM_KPDOT & 0xff] = KEY_KPDOT,
+	[KEY_SYM_KPPLUS & 0xff] = KEY_KPPLUS,
+	[KEY_SYM_KP0 & 0xff] = KEY_KP0,
+	[KEY_SYM_KP1 & 0xff] = KEY_KP1,
+	[KEY_SYM_KP2 & 0xff] = KEY_KP2, [KEY_SYM_KPDOWN & 0xff] = KEY_KP2,
+	[KEY_SYM_KP3 & 0xff] = KEY_KP3,
+	[KEY_SYM_KP4 & 0xff] = KEY_KP4, [KEY_SYM_KPLEFT & 0xff] = KEY_KP4,
+	[KEY_SYM_KP5 & 0xff] = KEY_KP5,
+	[KEY_SYM_KP6 & 0xff] = KEY_KP6, [KEY_SYM_KPRIGHT & 0xff] = KEY_KP6,
+	[KEY_SYM_KP7 & 0xff] = KEY_KP7,
+	[KEY_SYM_KP8 & 0xff] = KEY_KP8, [KEY_SYM_KPUP & 0xff] = KEY_KP8,
+	[KEY_SYM_KP9 & 0xff] = KEY_KP9,
+	[KEY_SYM_BK_SPC & 0xff] = KEY_BACKSPACE,
+	[KEY_SYM_TAB & 0xff] = KEY_TAB,
+	[KEY_SYM_CTRL & 0xff] = KEY_LEFTCTRL,
+	[KEY_SYM_ALT & 0xff] = KEY_LEFTALT,
+	[KEY_SYM_INSERT & 0xff] = KEY_INSERT,
+	[KEY_SYM_DELETE & 0xff] = KEY_DELETE,
+	[KEY_SYM_SHIFT & 0xff] = KEY_LEFTSHIFT,
+	[KEY_SYM_UARROW & 0xff] = KEY_UP,
+	[KEY_SYM_DARROW & 0xff] = KEY_DOWN,
+	[KEY_SYM_LARROW & 0xff] = KEY_LEFT,
+	[KEY_SYM_RARROW & 0xff] = KEY_RIGHT,
+	[KEY_SYM_ESCAPE & 0xff] = KEY_ESC,
+        [KEY_SYM_PAGEUP & 0xff] = KEY_PAGEUP,
+        [KEY_SYM_PAGEDOWN & 0xff] = KEY_PAGEDOWN,
+        [KEY_SYM_HOME & 0xff] = KEY_HOME,
+        [KEY_SYM_END & 0xff] = KEY_END,
+	[KEY_SYM_F1 & 0xff] = KEY_F1,
+	[KEY_SYM_F2 & 0xff] = KEY_F2,
+	[KEY_SYM_F3 & 0xff] = KEY_F3,
+	[KEY_SYM_F4 & 0xff] = KEY_F4,
+	[KEY_SYM_F5 & 0xff] = KEY_F5,
+	[KEY_SYM_F6 & 0xff] = KEY_F6,
+	[KEY_SYM_F7 & 0xff] = KEY_F7,
+	[KEY_SYM_F8 & 0xff] = KEY_F8,
+	[KEY_SYM_F9 & 0xff] = KEY_F9,
+	[KEY_SYM_F10 & 0xff] = KEY_F10,
+	[KEY_SYM_F11 & 0xff] = KEY_F11,
+	[KEY_SYM_F12 & 0xff] = KEY_F12,
+	[KEY_SYM_CAP_LOCK & 0xff] = KEY_CAPSLOCK,
+	[KEY_SYM_NUM_LOCK & 0xff] = KEY_NUMLOCK,
+	[KEY_SYM_SCR_LOCK & 0xff] = KEY_SCROLLLOCK,
+};
+static unsigned short xlate[XLATE_SIZE] = {
+	[NO_KEYCODE] = KEY_RESERVED,
+	[KEY_SYM_SPACE] = KEY_SPACE,
+	[KEY_SYM_TILDE] = KEY_GRAVE,        [KEY_SYM_BKTIC] = KEY_GRAVE,
+	[KEY_SYM_ONE] = KEY_1,              [KEY_SYM_BANG] = KEY_1,
+	[KEY_SYM_TWO] = KEY_2,              [KEY_SYM_AT] = KEY_2,
+	[KEY_SYM_THREE] = KEY_3,            [KEY_SYM_POUND] = KEY_3,
+	[KEY_SYM_FOUR] = KEY_4,             [KEY_SYM_DOLLAR] = KEY_4,
+	[KEY_SYM_FIVE] = KEY_5,             [KEY_SYM_PERCENT] = KEY_5,
+	[KEY_SYM_SIX] = KEY_6,              [KEY_SYM_CARAT] = KEY_6,
+	[KEY_SYM_SEVEN] = KEY_7,            [KEY_SYM_AMPER] = KEY_7,
+	[KEY_SYM_EIGHT] = KEY_8,            [KEY_SYM_STAR] = KEY_8,
+	[KEY_SYM_NINE] = KEY_9,             [KEY_SYM_LPAREN] = KEY_9,
+	[KEY_SYM_ZERO] = KEY_0,             [KEY_SYM_RPAREN] = KEY_0,
+	[KEY_SYM_MINUS] = KEY_MINUS,        [KEY_SYM_USCORE] = KEY_MINUS,
+	[KEY_SYM_EQUAL] = KEY_EQUAL,        [KEY_SYM_PLUS] = KEY_EQUAL,
+	[KEY_SYM_LBRKT] = KEY_LEFTBRACE,    [KEY_SYM_LCURLY] = KEY_LEFTBRACE,
+	[KEY_SYM_RBRKT] = KEY_RIGHTBRACE,   [KEY_SYM_RCURLY] = KEY_RIGHTBRACE,
+	[KEY_SYM_SLASH] = KEY_BACKSLASH,    [KEY_SYM_PIPE] = KEY_BACKSLASH,
+	[KEY_SYM_TIC] = KEY_APOSTROPHE,     [KEY_SYM_QUOTE] = KEY_APOSTROPHE,
+	[KEY_SYM_SEMIC] = KEY_SEMICOLON,    [KEY_SYM_COLON] = KEY_SEMICOLON,
+	[KEY_SYM_COMMA] = KEY_COMMA,        [KEY_SYM_LT] = KEY_COMMA,
+	[KEY_SYM_PERIOD] = KEY_DOT,         [KEY_SYM_GT] = KEY_DOT,
+	[KEY_SYM_BSLASH] = KEY_SLASH,       [KEY_SYM_QMARK] = KEY_SLASH,
+	[KEY_SYM_A] = KEY_A,                [KEY_SYM_a] = KEY_A,
+	[KEY_SYM_B] = KEY_B,                [KEY_SYM_b] = KEY_B,
+	[KEY_SYM_C] = KEY_C,                [KEY_SYM_c] = KEY_C,
+	[KEY_SYM_D] = KEY_D,                [KEY_SYM_d] = KEY_D,
+	[KEY_SYM_E] = KEY_E,                [KEY_SYM_e] = KEY_E,
+	[KEY_SYM_F] = KEY_F,                [KEY_SYM_f] = KEY_F,
+	[KEY_SYM_G] = KEY_G,                [KEY_SYM_g] = KEY_G,
+	[KEY_SYM_H] = KEY_H,                [KEY_SYM_h] = KEY_H,
+	[KEY_SYM_I] = KEY_I,                [KEY_SYM_i] = KEY_I,
+	[KEY_SYM_J] = KEY_J,                [KEY_SYM_j] = KEY_J,
+	[KEY_SYM_K] = KEY_K,                [KEY_SYM_k] = KEY_K,
+	[KEY_SYM_L] = KEY_L,                [KEY_SYM_l] = KEY_L,
+	[KEY_SYM_M] = KEY_M,                [KEY_SYM_m] = KEY_M,
+	[KEY_SYM_N] = KEY_N,                [KEY_SYM_n] = KEY_N,
+	[KEY_SYM_O] = KEY_O,                [KEY_SYM_o] = KEY_O,
+	[KEY_SYM_P] = KEY_P,                [KEY_SYM_p] = KEY_P,
+	[KEY_SYM_Q] = KEY_Q,                [KEY_SYM_q] = KEY_Q,
+	[KEY_SYM_R] = KEY_R,                [KEY_SYM_r] = KEY_R,
+	[KEY_SYM_S] = KEY_S,                [KEY_SYM_s] = KEY_S,
+	[KEY_SYM_T] = KEY_T,                [KEY_SYM_t] = KEY_T,
+	[KEY_SYM_U] = KEY_U,                [KEY_SYM_u] = KEY_U,
+	[KEY_SYM_V] = KEY_V,                [KEY_SYM_v] = KEY_V,
+	[KEY_SYM_W] = KEY_W,                [KEY_SYM_w] = KEY_W,
+	[KEY_SYM_X] = KEY_X,                [KEY_SYM_x] = KEY_X,
+	[KEY_SYM_Y] = KEY_Y,                [KEY_SYM_y] = KEY_Y,
+	[KEY_SYM_Z] = KEY_Z,                [KEY_SYM_z] = KEY_Z,
+};
 
-	q->start = kmalloc(DRIVER_REMOTE_QUEUE_SIZE * sizeof(struct remote_event), GFP_KERNEL);
-        if (q->start == 0)
-                return -ENOMEM;
-
-	q->end = q->start + DRIVER_REMOTE_QUEUE_SIZE;
-	q->reader = q->start;
-	q->writer = q->start;
-	q->size = DRIVER_REMOTE_QUEUE_SIZE;
-	init_waitqueue_head(&q->wait);
-
-	return 0;
-}
+static char remote_mouse_name[] = "ibmasm RSA I remote mouse";
+static char remote_keybd_name[] = "ibmasm RSA I remote keyboard";
 
-void ibmasm_free_remote_queue(struct service_processor *sp)
+static void print_input(struct remote_input *input)
 {
-	kfree(sp->remote_queue.start);
+	if (input->type == INPUT_TYPE_MOUSE) {
+		unsigned char buttons = input->mouse_buttons; 
+		dbg("remote mouse movement: (x,y)=(%d,%d)%s%s%s%s\n",
+			input->data.mouse.x, input->data.mouse.y,
+			(buttons)?" -- buttons:":"", 
+			(buttons & REMOTE_BUTTON_LEFT)?"left ":"",
+			(buttons & REMOTE_BUTTON_MIDDLE)?"middle ":"",
+			(buttons & REMOTE_BUTTON_RIGHT)?"right":""
+		      );
+	} else {
+		dbg("remote keypress (code, flag, down):"
+			   "%d (0x%x) [0x%x] [0x%x]\n",
+				input->data.keyboard.key_code,
+				input->data.keyboard.key_code,
+				input->data.keyboard.key_flag,
+				input->data.keyboard.key_down
+		      );
+	}
 }
 
-void ibmasm_advance_reader(struct remote_queue *q, unsigned int n)
+static void send_mouse_event(struct input_dev *dev, struct pt_regs *regs,
+		struct remote_input *input)
 {
-	q->reader += n;
-	if (q->reader >= q->end)
-		q->reader -= q->size;
-}
+	unsigned char buttons = input->mouse_buttons; 
 
-size_t ibmasm_events_available(struct remote_queue *q)
-{
-	ssize_t diff = q->writer - q->reader;
- 
-	return (diff >= 0) ? diff : q->end - q->reader;	
+	input_regs(dev, regs);
+	input_report_abs(dev, ABS_X, input->data.mouse.x);
+	input_report_abs(dev, ABS_Y, input->data.mouse.y);
+	input_report_key(dev, BTN_LEFT, buttons & REMOTE_BUTTON_LEFT);
+	input_report_key(dev, BTN_MIDDLE, buttons & REMOTE_BUTTON_MIDDLE);
+	input_report_key(dev, BTN_RIGHT, buttons & REMOTE_BUTTON_RIGHT);
+	input_sync(dev);
 }
-	
 
-static int space_free(struct remote_queue *q)
+static void send_keyboard_event(struct input_dev *dev, struct pt_regs *regs,
+		struct remote_input *input)
 {
-	if (q->reader == q->writer)
-		return q->size - 1;
+	unsigned int key;
+	unsigned short code = input->data.keyboard.key_code;
 
-	return ( (q->reader + q->size - q->writer) % q->size ) - 1;
+	if (code & 0xff00)
+		key = xlate_high[code & 0xff];
+	else
+		key = xlate[code];
+	input_regs(dev, regs);
+	input_report_key(dev, key, (input->data.keyboard.key_down) ? 1 : 0);
+	input_sync(dev);
 }
 
-static void set_mouse_event(struct remote_input *input, struct mouse_event *mouse)
+void ibmasm_handle_mouse_interrupt(struct service_processor *sp,
+		struct pt_regs *regs)
 {
-	static char last_buttons = 0;
+	unsigned long reader;
+	unsigned long writer;
+	struct remote_input input;
 
-	mouse->x = input->data.mouse.x;
-	mouse->y = input->data.mouse.y;
+	reader = get_queue_reader(sp);
+	writer = get_queue_writer(sp);
 
-	if (input->mouse_buttons == REMOTE_MOUSE_DOUBLE_CLICK) {
-		mouse->buttons = REMOTE_MOUSE_DOUBLE_CLICK;
-		last_buttons = 0;
-		return;
-	}
-	mouse->transitions = last_buttons ^ input->mouse_buttons;
-	mouse->buttons = input->mouse_buttons;
+	while (reader != writer) {
+		memcpy_fromio(&input, get_queue_entry(sp, reader),
+				sizeof(struct remote_input));
 
-	last_buttons = input->mouse_buttons;
-}
+		print_input(&input);
+		if (input.type == INPUT_TYPE_MOUSE) {
+			send_mouse_event(&sp->remote->mouse_dev, regs, &input);
+		} else if (input.type == INPUT_TYPE_KEYBOARD) {
+			send_keyboard_event(&sp->remote->keybd_dev, regs, &input);
+		} else
+			break;
 
-static void set_keyboard_event(struct remote_input *input, struct keyboard_event *keyboard)
-{
-	keyboard->key_code = input->data.keyboard.key_code;
-	keyboard->key_down = input->data.keyboard.key_down;
+		reader = advance_queue_reader(sp, reader);
+		writer = get_queue_writer(sp);
+	}
 }
 
-static int add_to_driver_queue(struct remote_queue *q, struct remote_input *input)
+int ibmasm_init_remote_input_dev(struct service_processor *sp)
 {
-	struct remote_event *event = q->writer;
-
-	if (space_free(q) < 1) {
-		return 1;
+	/* set up the mouse input device */
+	struct ibmasm_remote *remote;
+	struct pci_dev *pdev = to_pci_dev(sp->dev);
+	int i;
+
+	sp->remote = remote = kmalloc(sizeof(*remote), GFP_KERNEL);
+	if (!remote)
+		return -ENOMEM;
+
+	memset(remote, 0, sizeof(*remote));
+
+	remote->mouse_dev.private = remote;
+	init_input_dev(&remote->mouse_dev);
+	remote->mouse_dev.id.vendor = pdev->vendor;
+	remote->mouse_dev.id.product = pdev->device;
+	remote->mouse_dev.evbit[0]  = BIT(EV_KEY) | BIT(EV_ABS);
+	remote->mouse_dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) |
+		BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
+	set_bit(BTN_TOUCH, remote->mouse_dev.keybit);
+	remote->mouse_dev.name = remote_mouse_name;
+	input_set_abs_params(&remote->mouse_dev, ABS_X, 0, xmax, 0, 0);
+	input_set_abs_params(&remote->mouse_dev, ABS_Y, 0, ymax, 0, 0);
+
+	remote->keybd_dev.private = remote;
+	init_input_dev(&remote->keybd_dev);
+	remote->keybd_dev.id.vendor = pdev->vendor;
+	remote->keybd_dev.id.product = pdev->device;
+	remote->keybd_dev.evbit[0]  = BIT(EV_KEY);
+	remote->keybd_dev.name = remote_keybd_name;
+
+	for (i=0; i<XLATE_SIZE; i++) {
+		if (xlate_high[i])
+			set_bit(xlate_high[i], remote->keybd_dev.keybit);
+		if (xlate[i])
+			set_bit(xlate[i], remote->keybd_dev.keybit);
 	}
 
-	switch(input->type) {
-	case (INPUT_TYPE_MOUSE):
-		event->type = INPUT_TYPE_MOUSE;
-		set_mouse_event(input, &event->data.mouse);
-		break;
-	case (INPUT_TYPE_KEYBOARD):
-		event->type = INPUT_TYPE_KEYBOARD;
-		set_keyboard_event(input, &event->data.keyboard);
-		break;
-	default:
-		return 0;
-	}
-	event->type = input->type;
+	input_register_device(&remote->mouse_dev);
+	input_register_device(&remote->keybd_dev);
+	enable_mouse_interrupts(sp);
 
-	q->writer++;
-	if (q->writer == q->end)
-		q->writer = q->start;
+	printk(KERN_INFO "ibmasm remote responding to events on RSA card %d\n", sp->number);
 
 	return 0;
 }
-	
 
-void ibmasm_handle_mouse_interrupt(struct service_processor *sp)
+void ibmasm_free_remote_input_dev(struct service_processor *sp)
 {
-	unsigned long reader;
-	unsigned long writer;
-	struct remote_input input;
-
-	reader = get_queue_reader(sp);
-	writer = get_queue_writer(sp);
-
-	while (reader != writer) {
-		memcpy(&input, (void *)get_queue_entry(sp, reader), sizeof(struct remote_input));
-
-		if (add_to_driver_queue(&sp->remote_queue, &input))
-			break;
-
-		reader = advance_queue_reader(sp, reader);
-	}
-	wake_up_interruptible(&sp->remote_queue.wait);
+	disable_mouse_interrupts(sp);
+	input_unregister_device(&sp->remote->keybd_dev);
+	input_unregister_device(&sp->remote->mouse_dev);
+	kfree(sp->remote);
 }
+
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/remote.h	2005-06-09 18:02:28.021406968 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/remote.h	2005-06-08 17:54:09.544983392 -0700
@@ -51,11 +51,13 @@
 
 
 /* mouse button states received from SP */
-#define REMOTE_MOUSE_DOUBLE_CLICK	0xF0
-#define REMOTE_MOUSE_BUTTON_LEFT	0x01
-#define REMOTE_MOUSE_BUTTON_MIDDLE	0x02
-#define REMOTE_MOUSE_BUTTON_RIGHT	0x04
+#define REMOTE_DOUBLE_CLICK	0xF0
+#define REMOTE_BUTTON_LEFT	0x01
+#define REMOTE_BUTTON_MIDDLE	0x02
+#define REMOTE_BUTTON_RIGHT	0x04
 
+/* size of keysym/keycode translation matricies */
+#define XLATE_SIZE 256
 
 struct mouse_input {
 	unsigned short	y;
@@ -83,11 +85,13 @@
 	unsigned char	pad3;
 };
 
-#define mouse_addr(sp) 		sp->base_address + CONDOR_MOUSE_DATA
-#define display_width(sp)	mouse_addr(sp) + CONDOR_INPUT_DISPLAY_RESX
-#define display_height(sp)	mouse_addr(sp) + CONDOR_INPUT_DISPLAY_RESY
-#define display_depth(sp)	mouse_addr(sp) + CONDOR_INPUT_DISPLAY_BITS
-#define vnc_status(sp)		mouse_addr(sp) + CONDOR_OUTPUT_VNC_STATUS
+#define mouse_addr(sp) 		(sp->base_address + CONDOR_MOUSE_DATA)
+#define display_width(sp)	(mouse_addr(sp) + CONDOR_INPUT_DISPLAY_RESX)
+#define display_height(sp)	(mouse_addr(sp) + CONDOR_INPUT_DISPLAY_RESY)
+#define display_depth(sp)	(mouse_addr(sp) + CONDOR_INPUT_DISPLAY_BITS)
+#define desktop_info(sp)	(mouse_addr(sp) + CONDOR_INPUT_DESKTOP_INFO)
+#define vnc_status(sp)		(mouse_addr(sp) + CONDOR_OUTPUT_VNC_STATUS)
+#define isr_control(sp)		(mouse_addr(sp) + CONDOR_MOUSE_ISR_CONTROL)
 
 #define mouse_interrupt_pending(sp) 	readl(mouse_addr(sp) + CONDOR_MOUSE_ISR_STATUS)
 #define clear_mouse_interrupt(sp)	writel(0, mouse_addr(sp) + CONDOR_MOUSE_ISR_STATUS)
@@ -101,10 +105,10 @@
 #define get_queue_reader(sp)	readl(mouse_addr(sp) + CONDOR_MOUSE_Q_READER)
 #define set_queue_reader(sp, reader)	writel(reader, mouse_addr(sp) + CONDOR_MOUSE_Q_READER)
 
-#define queue_begin	mouse_addr(sp) + CONDOR_MOUSE_Q_BEGIN
+#define queue_begin	(mouse_addr(sp) + CONDOR_MOUSE_Q_BEGIN)
 
 #define get_queue_entry(sp, read_index) \
-	queue_begin + read_index * sizeof(struct remote_input)
+	((void*)(queue_begin + read_index * sizeof(struct remote_input)))
 
 static inline int advance_queue_reader(struct service_processor *sp, unsigned long reader)
 {
@@ -116,4 +120,151 @@
 	return reader;
 }
 
+#define NO_KEYCODE 0
+#define KEY_SYM_BK_SPC   0xFF08
+#define KEY_SYM_TAB      0xFF09
+#define KEY_SYM_ENTER    0xFF0D
+#define KEY_SYM_SCR_LOCK 0xFF14
+#define KEY_SYM_ESCAPE   0xFF1B
+#define KEY_SYM_HOME     0xFF50
+#define KEY_SYM_LARROW   0xFF51
+#define KEY_SYM_UARROW   0xFF52
+#define KEY_SYM_RARROW   0xFF53
+#define KEY_SYM_DARROW   0xFF54
+#define KEY_SYM_PAGEUP   0xFF55
+#define KEY_SYM_PAGEDOWN 0xFF56
+#define KEY_SYM_END      0xFF57
+#define KEY_SYM_INSERT   0xFF63
+#define KEY_SYM_NUM_LOCK 0xFF7F
+#define KEY_SYM_KPSTAR   0xFFAA
+#define KEY_SYM_KPPLUS   0xFFAB
+#define KEY_SYM_KPMINUS  0xFFAD
+#define KEY_SYM_KPDOT    0xFFAE
+#define KEY_SYM_KPSLASH  0xFFAF
+#define KEY_SYM_KPRIGHT  0xFF96
+#define KEY_SYM_KPUP     0xFF97
+#define KEY_SYM_KPLEFT   0xFF98
+#define KEY_SYM_KPDOWN   0xFF99
+#define KEY_SYM_KP0      0xFFB0
+#define KEY_SYM_KP1      0xFFB1
+#define KEY_SYM_KP2      0xFFB2
+#define KEY_SYM_KP3      0xFFB3
+#define KEY_SYM_KP4      0xFFB4
+#define KEY_SYM_KP5      0xFFB5
+#define KEY_SYM_KP6      0xFFB6
+#define KEY_SYM_KP7      0xFFB7
+#define KEY_SYM_KP8      0xFFB8
+#define KEY_SYM_KP9      0xFFB9
+#define KEY_SYM_F1       0xFFBE      // 1B 5B 5B 41
+#define KEY_SYM_F2       0xFFBF      // 1B 5B 5B 42 
+#define KEY_SYM_F3       0xFFC0      // 1B 5B 5B 43 
+#define KEY_SYM_F4       0xFFC1      // 1B 5B 5B 44 
+#define KEY_SYM_F5       0xFFC2      // 1B 5B 5B 45 
+#define KEY_SYM_F6       0xFFC3      // 1B 5B 31 37 7E
+#define KEY_SYM_F7       0xFFC4      // 1B 5B 31 38 7E 
+#define KEY_SYM_F8       0xFFC5      // 1B 5B 31 39 7E 
+#define KEY_SYM_F9       0xFFC6      // 1B 5B 32 30 7E 
+#define KEY_SYM_F10      0xFFC7      // 1B 5B 32 31 7E  
+#define KEY_SYM_F11      0xFFC8      // 1B 5B 32 33 7E  
+#define KEY_SYM_F12      0xFFC9      // 1B 5B 32 34 7E  
+#define KEY_SYM_SHIFT    0xFFE1
+#define KEY_SYM_CTRL     0xFFE3
+#define KEY_SYM_ALT      0xFFE9
+#define KEY_SYM_CAP_LOCK 0xFFE5
+#define KEY_SYM_DELETE   0xFFFF
+#define KEY_SYM_TILDE    0x60
+#define KEY_SYM_BKTIC    0x7E
+#define KEY_SYM_ONE      0x31
+#define KEY_SYM_BANG     0x21
+#define KEY_SYM_TWO      0x32
+#define KEY_SYM_AT       0x40
+#define KEY_SYM_THREE    0x33
+#define KEY_SYM_POUND    0x23
+#define KEY_SYM_FOUR     0x34
+#define KEY_SYM_DOLLAR   0x24
+#define KEY_SYM_FIVE     0x35
+#define KEY_SYM_PERCENT  0x25
+#define KEY_SYM_SIX      0x36
+#define KEY_SYM_CARAT    0x5E
+#define KEY_SYM_SEVEN    0x37
+#define KEY_SYM_AMPER    0x26
+#define KEY_SYM_EIGHT    0x38
+#define KEY_SYM_STAR     0x2A
+#define KEY_SYM_NINE     0x39
+#define KEY_SYM_LPAREN   0x28
+#define KEY_SYM_ZERO     0x30
+#define KEY_SYM_RPAREN   0x29
+#define KEY_SYM_MINUS    0x2D
+#define KEY_SYM_USCORE   0x5F
+#define KEY_SYM_EQUAL    0x2B
+#define KEY_SYM_PLUS     0x3D
+#define KEY_SYM_LBRKT    0x5B
+#define KEY_SYM_LCURLY   0x7B
+#define KEY_SYM_RBRKT    0x5D
+#define KEY_SYM_RCURLY   0x7D
+#define KEY_SYM_SLASH    0x5C
+#define KEY_SYM_PIPE     0x7C
+#define KEY_SYM_TIC      0x27
+#define KEY_SYM_QUOTE    0x22
+#define KEY_SYM_SEMIC    0x3B
+#define KEY_SYM_COLON    0x3A
+#define KEY_SYM_COMMA    0x2C
+#define KEY_SYM_LT       0x3C
+#define KEY_SYM_PERIOD   0x2E
+#define KEY_SYM_GT       0x3E
+#define KEY_SYM_BSLASH   0x2F
+#define KEY_SYM_QMARK    0x3F
+#define KEY_SYM_A        0x41
+#define KEY_SYM_B        0x42
+#define KEY_SYM_C        0x43
+#define KEY_SYM_D        0x44
+#define KEY_SYM_E        0x45
+#define KEY_SYM_F        0x46
+#define KEY_SYM_G        0x47
+#define KEY_SYM_H        0x48
+#define KEY_SYM_I        0x49
+#define KEY_SYM_J        0x4A
+#define KEY_SYM_K        0x4B
+#define KEY_SYM_L        0x4C
+#define KEY_SYM_M        0x4D
+#define KEY_SYM_N        0x4E
+#define KEY_SYM_O        0x4F
+#define KEY_SYM_P        0x50
+#define KEY_SYM_Q        0x51
+#define KEY_SYM_R        0x52
+#define KEY_SYM_S        0x53
+#define KEY_SYM_T        0x54
+#define KEY_SYM_U        0x55
+#define KEY_SYM_V        0x56
+#define KEY_SYM_W        0x57
+#define KEY_SYM_X        0x58
+#define KEY_SYM_Y        0x59
+#define KEY_SYM_Z        0x5A
+#define KEY_SYM_a        0x61
+#define KEY_SYM_b        0x62
+#define KEY_SYM_c        0x63
+#define KEY_SYM_d        0x64
+#define KEY_SYM_e        0x65
+#define KEY_SYM_f        0x66
+#define KEY_SYM_g        0x67
+#define KEY_SYM_h        0x68
+#define KEY_SYM_i        0x69
+#define KEY_SYM_j        0x6A
+#define KEY_SYM_k        0x6B
+#define KEY_SYM_l        0x6C
+#define KEY_SYM_m        0x6D
+#define KEY_SYM_n        0x6E
+#define KEY_SYM_o        0x6F
+#define KEY_SYM_p        0x70
+#define KEY_SYM_q        0x71
+#define KEY_SYM_r        0x72
+#define KEY_SYM_s        0x73
+#define KEY_SYM_t        0x74
+#define KEY_SYM_u        0x75
+#define KEY_SYM_v        0x76
+#define KEY_SYM_w        0x77
+#define KEY_SYM_x        0x78
+#define KEY_SYM_y        0x79
+#define KEY_SYM_z        0x7A
+#define KEY_SYM_SPACE    0x20
 #endif /* _IBMASM_REMOTE_H_ */

--=-Z+LqU4Th9gc++0XFPDrY--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130397AbRBLBE0>; Sun, 11 Feb 2001 20:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130853AbRBLBER>; Sun, 11 Feb 2001 20:04:17 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:53106 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130397AbRBLBEA>;
	Sun, 11 Feb 2001 20:04:00 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.1-ac10 warning cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Feb 2001 12:03:38 +1100
Message-ID: <7174.981939818@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another installment in the never ending battle to keep the kernel build
free from warnings.

diff -urp 2.4.1-ac10.orig/arch/i386/kernel/traps.c 2.4.1-ac10/arch/i386/kernel/traps.c
--- 2.4.1-ac10.orig/arch/i386/kernel/traps.c	Mon Feb 12 11:57:01 2001
+++ 2.4.1-ac10/arch/i386/kernel/traps.c	Mon Feb 12 11:14:59 2001
@@ -127,7 +127,7 @@ void show_trace(unsigned long * stack)
 
 void show_trace_task(struct task_struct *tsk)
 {
-	show_trace(tsk->thread.esp);
+	show_trace((unsigned long *)(tsk->thread.esp));
 }
 
 void show_stack(unsigned long * esp)
diff -urp 2.4.1-ac10.orig/drivers/net/ne.c 2.4.1-ac10/drivers/net/ne.c
--- 2.4.1-ac10.orig/drivers/net/ne.c	Mon Feb 12 11:57:35 2001
+++ 2.4.1-ac10/drivers/net/ne.c	Mon Feb 12 11:39:26 2001
@@ -87,7 +87,7 @@ isapnp_clone_list[] __initdata = {
 	{0}
 };
 
-MODULE_DEVICE_TABLE(isapnp, isapnp_clone_list);
+MODULE_DEVICE_TABLE(isapnp, (struct isapnp_device_id *)isapnp_clone_list);
 
 #ifdef SUPPORT_NE_BAD_CLONES
 /* A list of bad clones that we none-the-less recognize. */
diff -urp 2.4.1-ac10.orig/drivers/usb/serial/usbserial.c 2.4.1-ac10/drivers/usb/serial/usbserial.c
--- 2.4.1-ac10.orig/drivers/usb/serial/usbserial.c	Mon Feb 12 11:57:53 2001
+++ 2.4.1-ac10/drivers/usb/serial/usbserial.c	Mon Feb 12 11:41:10 2001
@@ -298,10 +298,10 @@ static int  generic_write_room		(struct 
 static int  generic_chars_in_buffer	(struct usb_serial_port *port);
 static void generic_read_bulk_callback	(struct urb *urb);
 static void generic_write_bulk_callback	(struct urb *urb);
-static void generic_shutdown		(struct usb_serial *serial);
 
 
 #ifdef CONFIG_USB_SERIAL_GENERIC
+static void generic_shutdown		(struct usb_serial *serial);
 static __u16	vendor	= 0x05f9;
 static __u16	product	= 0xffff;
 MODULE_PARM(vendor, "i");
@@ -968,6 +968,7 @@ static void generic_write_bulk_callback 
 }
 
 
+#ifdef CONFIG_USB_SERIAL_GENERIC
 static void generic_shutdown (struct usb_serial *serial)
 {
 	int i;
@@ -981,6 +982,7 @@ static void generic_shutdown (struct usb
 		}
 	}
 }
+#endif
 
 
 static void port_softint(void *private)
diff -urp 2.4.1-ac10.orig/fs/buffer.c 2.4.1-ac10/fs/buffer.c
--- 2.4.1-ac10.orig/fs/buffer.c	Mon Feb 12 11:57:57 2001
+++ 2.4.1-ac10/fs/buffer.c	Mon Feb 12 11:13:58 2001
@@ -1035,7 +1035,6 @@ repeat:
 int balance_dirty_state(kdev_t dev)
 {
 	unsigned long dirty, tot, hard_dirty_limit, soft_dirty_limit;
-	int shortage;
 
 	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
 	tot = nr_free_buffer_pages();
diff -urp 2.4.1-ac10.orig/fs/partitions/msdos.c 2.4.1-ac10/fs/partitions/msdos.c
--- 2.4.1-ac10.orig/fs/partitions/msdos.c	Mon Feb 12 11:58:00 2001
+++ 2.4.1-ac10/fs/partitions/msdos.c	Mon Feb 12 11:13:11 2001
@@ -70,8 +70,11 @@ static inline int is_extended_partition(
 /*
  * partition_name() formats the short partition name into the supplied
  * buffer, and returns a pointer to that buffer.
+ * Used by several partition types which makes conditional inclusion messy,
+ * use __attribute__ ((unused)) instead.
  */
-static char *partition_name (struct gendisk *hd, int minor, char *buf)
+static char __attribute__ ((unused))
+	*partition_name (struct gendisk *hd, int minor, char *buf)
 {
 #ifdef CONFIG_DEVFS_FS
 	sprintf(buf, "p%d", (minor & ((1 << hd->minor_shift) - 1)));


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

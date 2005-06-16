Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVFPUYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVFPUYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVFPUY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:24:29 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39137 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261801AbVFPUUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:20:35 -0400
Subject: [patch][2/4] ibmasm driver: correctly wake up sleeping threads
From: Max Asbock <masbock@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Vernon Mauery <vernux@us.ibm.com>
Content-Type: text/plain
Message-Id: <1118953211.8372.78.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 16 Jun 2005 13:20:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second of four patches for the ibmasm driver:

Due to my incomplete understanding of the wait_event_interruptible()
function threads waiting for service processor events were not 
woken up. This patch fixes that problem. 


Signed-off-by: Max Asbock <masbock@us.ibm.com>


diff -urN linux-2.6.12-rc6.test/drivers/misc/ibmasm/event.c linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/event.c
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/event.c	2005-06-08 18:34:06.517588168 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/event.c	2005-06-08 17:54:09.525986280 -0700
@@ -23,6 +23,7 @@
  */
 
 #include "ibmasm.h"
+#include "lowlevel.h"
 
 /*
  * ASM service processor event handling routines.
@@ -34,7 +35,6 @@
  * circular buffer.
  */
 
-
 static void wake_up_event_readers(struct service_processor *sp)
 {
 	struct event_reader *reader;
@@ -63,7 +63,7 @@
 	spin_lock_irqsave(&sp->lock, flags);
 	/* copy the event into the next slot in the circular buffer */
 	event = &buffer->events[buffer->next_index];
-	memcpy(event->data, data, data_size);
+	memcpy_fromio(event->data, data, data_size);
 	event->data_size = data_size;
 	event->serial_number = buffer->next_serial_number;
 
@@ -93,7 +93,10 @@
 	unsigned int index;
 	unsigned long flags;
 
-	if (wait_event_interruptible(reader->wait, event_available(buffer, reader)))
+	reader->cancelled = 0;
+
+	if (wait_event_interruptible(reader->wait,
+			event_available(buffer, reader) || reader->cancelled))
 		return -ERESTARTSYS;
 
 	if (!event_available(buffer, reader))
@@ -116,6 +119,12 @@
 	return event->data_size;
 }
 
+void ibmasm_cancel_next_event(struct event_reader *reader)
+{
+        reader->cancelled = 1;
+        wake_up_interruptible(&reader->wait);
+}
+
 void ibmasm_event_reader_register(struct service_processor *sp, struct event_reader *reader)
 {
 	unsigned long flags;
@@ -131,8 +140,6 @@
 {
 	unsigned long flags;
 
-	wake_up_interruptible(&reader->wait);
-
 	spin_lock_irqsave(&sp->lock, flags);
 	list_del(&reader->node);
 	spin_unlock_irqrestore(&sp->lock, flags);
@@ -164,6 +171,5 @@
 
 void ibmasm_event_buffer_exit(struct service_processor *sp)
 {
-	wake_up_event_readers(sp);
 	kfree(sp->event_buffer);
 }
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/ibmasmfs.c	2005-06-08 18:34:06.518588016 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/ibmasmfs.c	2005-06-08 17:54:09.533985064 -0700
@@ -374,6 +374,7 @@
 	ibmasm_event_reader_register(sp, &event_data->reader);
 
 	event_data->sp = sp;
+	event_data->active = 0;
 	file->private_data = event_data;
 	return 0;
 }
@@ -391,7 +392,9 @@
 {
 	struct ibmasmfs_event_data *event_data = file->private_data;
 	struct event_reader *reader = &event_data->reader;
+	struct service_processor *sp = event_data->sp;
 	int ret;
+	unsigned long flags;
 
 	if (*offset < 0)
 		return -EINVAL;
@@ -400,17 +403,32 @@
 	if (*offset != 0)
 		return 0;
 
-	ret = ibmasm_get_next_event(event_data->sp, reader);
+	spin_lock_irqsave(&sp->lock, flags);
+	if (event_data->active) {
+		spin_unlock_irqrestore(&sp->lock, flags);
+		return -EBUSY;
+	}
+	event_data->active = 1;
+	spin_unlock_irqrestore(&sp->lock, flags);
+		
+	ret = ibmasm_get_next_event(sp, reader);
 	if (ret <= 0)
-		return ret;
+		goto out;
 
-	if (count < reader->data_size)
-		return -EINVAL;
+	if (count < reader->data_size) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-        if (copy_to_user(buf, reader->data, reader->data_size))
-		return -EFAULT;
+        if (copy_to_user(buf, reader->data, reader->data_size)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = reader->data_size;
 
-	return reader->data_size;
+out:
+	event_data->active = 0;
+	return ret;
 }
 
 static ssize_t event_file_write(struct file *file, const char __user *buf, size_t count, loff_t *offset)
@@ -424,7 +442,7 @@
 	if (*offset != 0)
 		return 0;
 
-	wake_up_interruptible(&event_data->reader.wait);
+	ibmasm_cancel_next_event(&event_data->reader);
 	return 0;
 }
 
--- linux-2.6.12-rc6.test/drivers/misc/ibmasm/ibmasm.h	2005-06-08 18:40:46.069846992 -0700
+++ linux-2.6.12-rc6.ibmasm/drivers/misc/ibmasm/ibmasm.h	2005-06-08 17:54:09.534984912 -0700
@@ -108,6 +189,7 @@
 };
 
 struct event_reader {
+	int			cancelled;
 	unsigned int		next_serial_number;
 	wait_queue_head_t	wait;
 	struct list_head	node;
@@ -185,6 +267,7 @@
 extern void ibmasm_event_reader_register(struct service_processor *sp, struct event_reader *reader);
 extern void ibmasm_event_reader_unregister(struct service_processor *sp, struct event_reader *reader);
 extern int ibmasm_get_next_event(struct service_processor *sp, struct event_reader *reader);
+extern void ibmasm_cancel_next_event(struct event_reader *reader);
 
 /* heartbeat - from SP to OS */
 extern void ibmasm_register_panic_notifier(void);



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTDNRsA (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbTDNRrU (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:47:20 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:159 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S263592AbTDNRp3 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:29 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (4/16): s390 console changes.
Date: Mon, 14 Apr 2003 19:48:56 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141948.56146.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 console fixes for 3215 and sclp.

diffstat:
 char/tty_io.c        |    2 
 s390/char/con3215.c  |   13 ++--
 s390/char/sclp.c     |  151 +++++++++++++++++++++++++++++++--------------------
 s390/char/sclp.h     |    1 
 s390/char/sclp_con.c |   15 ++---
 s390/char/sclp_cpi.c |    2 
 s390/char/sclp_rw.c  |   46 ++-------------
 s390/char/sclp_tty.c |   59 ++++++++++++-------
 8 files changed, 153 insertions(+), 136 deletions(-)

diff -urN linux-2.5.67/drivers/char/tty_io.c linux-2.5.67-s390/drivers/char/tty_io.c
--- linux-2.5.67/drivers/char/tty_io.c	Mon Apr 14 19:11:35 2003
+++ linux-2.5.67-s390/drivers/char/tty_io.c	Mon Apr 14 19:11:51 2003
@@ -151,7 +151,7 @@
 extern int vme_scc_init (void);
 extern int serial167_init(void);
 extern int rs_8xx_init(void);
-extern void hwc_tty_init(void);
+extern void sclp_tty_init(void);
 extern void tty3215_init(void);
 extern void tub3270_init(void);
 extern void rs_360_init(void);
diff -urN linux-2.5.67/drivers/s390/char/con3215.c linux-2.5.67-s390/drivers/s390/char/con3215.c
--- linux-2.5.67/drivers/s390/char/con3215.c	Mon Apr  7 19:32:13 2003
+++ linux-2.5.67-s390/drivers/s390/char/con3215.c	Mon Apr 14 19:11:51 2003
@@ -872,7 +872,7 @@
  *  The console structure for the 3215 console
  */
 static struct console con3215 = {
-	.name	 = "tty3215",
+	.name	 = "ttyS",
 	.write	 = con3215_write,
 	.device	 = con3215_device,
 	.unblank = con3215_unblank,
@@ -884,7 +884,7 @@
  * 3215 console initialization code called from console_init().
  * NOTE: This is called before kmalloc is available.
  */
-static void __init
+static int __init
 con3215_init(void)
 {
 	struct ccw_device *cdev;
@@ -894,7 +894,7 @@
 
 	/* Check if 3215 is to be the console */
 	if (!CONSOLE_IS_3215)
-		return;
+		return -ENODEV;
 
 	/* Set the console mode for VM */
 	if (MACHINE_IS_VM) {
@@ -913,7 +913,7 @@
 
 	cdev = ccw_device_probe_console();
 	if (!cdev)
-		return;
+		return -ENODEV;
 
 	raw3215[0] = raw = (struct raw3215_info *)
 		alloc_bootmem_low(sizeof(struct raw3215_info));
@@ -938,10 +938,12 @@
 		free_bootmem((unsigned long) raw, sizeof(struct raw3215_info));
 		raw3215[0] = NULL;
 		printk("Couldn't find a 3215 console device\n");
-		return;
+		return -ENODEV;
 	}
 	register_console(&con3215);
+	return 0;
 }
+console_initcall(con3215_init);
 #endif
 
 /*
@@ -1122,7 +1124,6 @@
 		spin_unlock_irqrestore(raw->lock, flags);
 	}
 }
-console_initcall(con3215_init);
 
 /*
  * Disable writing to a 3215 tty
diff -urN linux-2.5.67/drivers/s390/char/sclp.c linux-2.5.67-s390/drivers/s390/char/sclp.c
--- linux-2.5.67/drivers/s390/char/sclp.c	Mon Apr  7 19:31:52 2003
+++ linux-2.5.67-s390/drivers/s390/char/sclp.c	Mon Apr 14 19:11:51 2003
@@ -9,7 +9,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kmod.h>
 #include <linux/bootmem.h>
@@ -25,14 +24,6 @@
 
 #define SCLP_CORE_PRINT_HEADER "sclp low level driver: "
 
-/*
- * decides whether we make use of the macro MACHINE_IS_VM to
- * configure the driver for VM at run time (a little bit
- * different behaviour); otherwise we use the default
- * settings in sclp_data.init_ioctls
- */
-#define USE_VM_DETECTION
-
 /* Structure for register_early_external_interrupt. */
 static ext_int_info_t ext_int_info_hwc;
 
@@ -111,30 +102,32 @@
 }
 
 static int
-__sclp_start_request(void)
+sclp_start_request(void)
 {
 	struct sclp_req *req;
 	int rc;
+	unsigned long flags;
 
 	/* quick exit if sclp is already in use */
 	if (test_bit(SCLP_RUNNING, &sclp_status))
 		return -EBUSY;
-	/* quick exit if queue is empty */
-	if (list_empty(&sclp_req_queue))
-		return -EINVAL;
-	/* try to start the first request on the request queue. */
-	req = list_entry(sclp_req_queue.next, struct sclp_req, list);
-	rc = __service_call(req->command, req->sccb);
-	switch (rc) {
-	case 0:
-		req->status = SCLP_REQ_RUNNING;
-		break;
-	case -EIO:
-		req->status = SCLP_REQ_FAILED;
-		if (req->callback != NULL)
-			req->callback(req, req->callback_data);
-		break;
-	}
+	spin_lock_irqsave(&sclp_lock, flags);
+	/* Get first request on queue if available */
+	req = NULL;
+	if (!list_empty(&sclp_req_queue))
+		req = list_entry(sclp_req_queue.next, struct sclp_req, list);
+	if (req) {
+		rc = __service_call(req->command, req->sccb);
+		if (rc) {
+			req->status = SCLP_REQ_FAILED;
+			list_del(&req->list);
+		} else
+			req->status = SCLP_REQ_RUNNING;
+	} else
+		rc = -EINVAL;
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	if (rc == -EIO && req->callback != NULL)
+		req->callback(req, req->callback_data);
 	return rc;
 }
 
@@ -156,8 +149,12 @@
 		list_for_each(l, &sclp_reg_list) {
 			t = list_entry(l, struct sclp_register, list);
 			if (t->receive_mask & (1 << (32 - evbuf->type))) {
-				if (t->receiver_fn != NULL)
+				if (t->receiver_fn != NULL) {
+					spin_unlock_irqrestore(&sclp_lock,
+							       flags);
 					t->receiver_fn(evbuf);
+					spin_lock_irqsave(&sclp_lock, flags);
+				}
 				break;
 			}
 			else
@@ -230,7 +227,7 @@
 }
 
 /*
- * Function to issue Read Event Data/Unconditional Read
+ * Function to queue Read Event Data/Unconditional Read
  */
 static void
 __sclp_unconditional_read(void)
@@ -278,45 +275,44 @@
 	struct list_head *l;
 	struct sclp_req *req, *tmp;
 
+	/*
+	 * Only process interrupt if sclp is initialized.
+	 * This avoids strange effects for a pending request
+	 * from before the last re-ipl.
+	 */
+	if (!test_bit(SCLP_INIT, &sclp_status))
+		return;
 	ext_int_param = S390_lowcore.ext_params;
 	finished_sccb = ext_int_param & EXT_INT_SCCB_MASK;
 	evbuf_pending = ext_int_param & (EXT_INT_EVBUF_PENDING |
 					 EXT_INT_STATECHANGE_PENDING);
 	irq_enter();
-	/*
-	 * Only do request callbacks if sclp is initialized.
-	 * This avoids strange effects for a pending request
-	 * from before the last re-ipl.
-	 */
-	if (test_bit(SCLP_INIT, &sclp_status)) {
-		spin_lock(&sclp_lock);
-		req = NULL;
-		if (finished_sccb != 0U) {
-			list_for_each(l, &sclp_req_queue) {
-				tmp = list_entry(l, struct sclp_req, list);
-				if (finished_sccb == (u32)(addr_t) tmp->sccb) {
-					list_del(&tmp->list);
-					req = tmp;
-					break;
-				}
+	req = NULL;
+	spin_lock(&sclp_lock);
+	if (finished_sccb != 0U) {
+		list_for_each(l, &sclp_req_queue) {
+			tmp = list_entry(l, struct sclp_req, list);
+			if (finished_sccb == (u32)(addr_t) tmp->sccb) {
+				list_del(&tmp->list);
+				req = tmp;
+				break;
 			}
 		}
-		spin_unlock(&sclp_lock);
-		if (req != NULL) {
-			req->status = SCLP_REQ_DONE;
-			if (req->callback != NULL)
-				req->callback(req, req->callback_data);
-		}
 	}
-	spin_lock(&sclp_lock);
 	/* Head queue a read sccb if an event buffer is pending */
 	if (evbuf_pending)
 		__sclp_unconditional_read();
+	spin_unlock(&sclp_lock);
+	/* Perform callback */
+	if (req != NULL) {
+		req->status = SCLP_REQ_DONE;
+		if (req->callback != NULL)
+			req->callback(req, req->callback_data);
+	}
 	/* Now clear the running bit */
 	clear_bit(SCLP_RUNNING, &sclp_status);
 	/* and start next request on the queue */
-	__sclp_start_request();
-	spin_unlock(&sclp_lock);
+	sclp_start_request();
 	irq_exit();
 }
 
@@ -368,15 +364,19 @@
 {
 	unsigned long flags;
 
-	if (!test_bit(SCLP_INIT, &sclp_status))
+	if (!test_bit(SCLP_INIT, &sclp_status)) {
+		req->status = SCLP_REQ_FAILED;
+		if (req->callback != NULL)
+			req->callback(req, req->callback_data);
 		return;
+	}
 	spin_lock_irqsave(&sclp_lock, flags);
 	/* queue the request */
 	req->status = SCLP_REQ_QUEUED;
 	list_add_tail(&req->list, &sclp_req_queue);
-	/* try to start the first request on the queue */
-	__sclp_start_request();
 	spin_unlock_irqrestore(&sclp_lock, flags);
+	/* try to start the first request on the queue */
+	sclp_start_request();
 }
 
 /* state change notification */
@@ -566,10 +566,9 @@
 	if (test_bit(SCLP_INIT, &sclp_status)) {
 		/* add request to sclp queue */
 		list_add_tail(&req->list, &sclp_req_queue);
-		/* and start if SCLP is idle */
-		if (!test_bit(SCLP_RUNNING, &sclp_status))
-			__sclp_start_request();
 		spin_unlock_irqrestore(&sclp_lock, flags);
+		/* and start if SCLP is idle */
+		sclp_start_request();
 		/* now wait for completion */
 		while (req->status != SCLP_REQ_DONE &&
 		       req->status != SCLP_REQ_FAILED)
@@ -730,7 +729,41 @@
 	sclp_init_mask();
 }
 
+#define	SCLP_EVBUF_PROCESSED	0x80
+
+/*
+ * Traverse array of event buffers contained in SCCB and remove all buffers
+ * with a set "processed" flag. Return the number of unprocessed buffers.
+ */
+int
+sclp_remove_processed(struct sccb_header *sccb)
+{
+	struct evbuf_header *evbuf;
+	int unprocessed;
+	u16 remaining;
+
+	evbuf = (struct evbuf_header *) (sccb + 1);
+	unprocessed = 0;
+	remaining = sccb->length - sizeof(struct sccb_header);
+	while (remaining > 0) {
+		remaining -= evbuf->length;
+		if (evbuf->flags & SCLP_EVBUF_PROCESSED) {
+			sccb->length -= evbuf->length;
+			memcpy((void *) evbuf,
+			       (void *) ((addr_t) evbuf + evbuf->length),
+			       remaining);
+		} else {
+			unprocessed++;
+			evbuf = (struct evbuf_header *)
+					((addr_t) evbuf + evbuf->length);
+		}
+	}
+
+	return unprocessed;
+}
+
 EXPORT_SYMBOL(sclp_add_request);
 EXPORT_SYMBOL(sclp_sync_wait);
 EXPORT_SYMBOL(sclp_register);
 EXPORT_SYMBOL(sclp_unregister);
+EXPORT_SYMBOL(sclp_error_message);
diff -urN linux-2.5.67/drivers/s390/char/sclp.h linux-2.5.67-s390/drivers/s390/char/sclp.h
--- linux-2.5.67/drivers/s390/char/sclp.h	Mon Apr  7 19:30:43 2003
+++ linux-2.5.67-s390/drivers/s390/char/sclp.h	Mon Apr 14 19:11:51 2003
@@ -126,6 +126,7 @@
 int sclp_register(struct sclp_register *reg);
 void sclp_unregister(struct sclp_register *reg);
 char *sclp_error_message(u16 response_code);
+int sclp_remove_processed(struct sccb_header *sccb);
 
 /* useful inlines */
 
diff -urN linux-2.5.67/drivers/s390/char/sclp_con.c linux-2.5.67-s390/drivers/s390/char/sclp_con.c
--- linux-2.5.67/drivers/s390/char/sclp_con.c	Mon Apr  7 19:31:21 2003
+++ linux-2.5.67-s390/drivers/s390/char/sclp_con.c	Mon Apr 14 19:11:51 2003
@@ -9,7 +9,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/kmod.h>
 #include <linux/console.h>
 #include <linux/init.h>
@@ -24,7 +23,7 @@
 
 #define sclp_console_major 4		/* TTYAUX_MAJOR */
 #define sclp_console_minor 64
-#define sclp_console_name  "console"
+#define sclp_console_name  "ttyS"
 
 /* Lock to guard over changes to global variables */
 static spinlock_t sclp_con_lock;
@@ -193,28 +192,29 @@
 	.write = sclp_console_write,
 	.device = sclp_console_device,
 	.unblank = sclp_console_unblank,
-	.flags = CON_PRINTBUFFER
+	.flags = CON_PRINTBUFFER,
+	.index = 0 /* ttyS0 */
 };
 
 /*
  * called by console_init() in drivers/char/tty_io.c at boot-time.
  */
-void __init
+static int __init
 sclp_console_init(void)
 {
 	void *page;
 	int i;
 
 	if (!CONSOLE_IS_SCLP)
-		return;
+		return 0;
 	if (sclp_rw_init() != 0)
-		return;
+		return 0;
 	/* Allocate pages for output buffering */
 	INIT_LIST_HEAD(&sclp_con_pages);
 	for (i = 0; i < MAX_CONSOLE_PAGES; i++) {
 		page = alloc_bootmem_low_pages(PAGE_SIZE);
 		if (page == NULL)
-			return;
+			return 0;
 		list_add_tail((struct list_head *) page, &sclp_con_pages);
 	}
 	INIT_LIST_HEAD(&sclp_con_outqueue);
@@ -236,6 +236,7 @@
 
 	/* enable printk-access to this driver */
 	register_console(&sclp_console);
+	return 0;
 }
 
 console_initcall(sclp_console_init);
diff -urN linux-2.5.67/drivers/s390/char/sclp_cpi.c linux-2.5.67-s390/drivers/s390/char/sclp_cpi.c
--- linux-2.5.67/drivers/s390/char/sclp_cpi.c	Mon Apr  7 19:31:24 2003
+++ linux-2.5.67-s390/drivers/s390/char/sclp_cpi.c	Mon Apr 14 19:11:51 2003
@@ -130,7 +130,7 @@
 	req = (struct sclp_req *) kmalloc(sizeof(struct sclp_req), GFP_KERNEL);
 	if (req == NULL)
 		return ERR_PTR(-ENOMEM);
-	sccb = (struct cpi_sccb *) __get_free_page(GFP_KERNEL);
+	sccb = (struct cpi_sccb *) __get_free_page(GFP_KERNEL | GFP_DMA);
 	if (sccb == NULL) {
 		kfree(req);
 		return ERR_PTR(-ENOMEM);
diff -urN linux-2.5.67/drivers/s390/char/sclp_rw.c linux-2.5.67-s390/drivers/s390/char/sclp_rw.c
--- linux-2.5.67/drivers/s390/char/sclp_rw.c	Mon Apr  7 19:31:15 2003
+++ linux-2.5.67-s390/drivers/s390/char/sclp_rw.c	Mon Apr 14 19:11:51 2003
@@ -9,7 +9,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/kmod.h>
 #include <linux/types.h>
 #include <linux/err.h>
@@ -374,39 +373,6 @@
 	return rc;
 }
 
-#define	SCLP_EVBUF_PROCESSED	0x80
-
-/*
- * Traverse array of event buffers contained in SCCB and remove all buffers
- * with a set "processed" flag. Return the number of unprocessed buffers.
- */
-static int
-sclp_remove_processed(struct sccb_header *sccb)
-{
-	struct evbuf_header *evbuf;
-	int unprocessed;
-	u16 remaining;
-
-	evbuf = (struct evbuf_header *) (sccb + 1);
-	unprocessed = 0;
-	remaining = sccb->length - sizeof(struct sccb_header);
-	while (remaining > 0) {
-		remaining -= evbuf->length;
-		if (evbuf->flags & SCLP_EVBUF_PROCESSED) {
-			sccb->length -= evbuf->length;
-			memcpy((void *) evbuf,
-			       (void *) ((addr_t) evbuf + evbuf->length),
-			       remaining);
-		} else {
-			unprocessed++;
-			evbuf = (struct evbuf_header *)
-					((addr_t) evbuf + evbuf->length);
-		}
-	}
-
-	return unprocessed;
-}
-
 static void
 sclp_buffer_retry(unsigned long data)
 {
@@ -480,10 +446,6 @@
 			rc = -ENOMEM;
 		else
 			rc = -EINVAL;
-		printk(KERN_WARNING SCLP_RW_PRINT_HEADER
-		       "sclp_writedata_callback: %s (response code=0x%x).\n",
-		       sclp_error_message(sccb->header.response_code),
-		       sccb->header.response_code);
 		break;
 	}
 	if (buffer->callback != NULL)
@@ -505,8 +467,11 @@
 		sclp_finalize_mto(buffer);
 
 	/* Are there messages in the output buffer ? */
-	if (buffer->mto_number == 0)
+	if (buffer->mto_number == 0) {
+		if (callback != NULL)
+			callback(buffer, 0);
 		return;
+	}
 
 	sccb = buffer->sccb;
 	if (sclp_rw_event.sclp_send_mask & EvTyp_Msg_Mask)
@@ -516,7 +481,8 @@
 		/* Use write priority message */
 		sccb->msg_buf.header.type = EvTyp_PMsgCmd;
 	else {
-		callback(buffer, -ENOSYS);
+		if (callback != NULL)
+			callback(buffer, -ENOSYS);
 		return;
 	}
 	buffer->request.command = SCLP_CMDW_WRITEDATA;
diff -urN linux-2.5.67/drivers/s390/char/sclp_tty.c linux-2.5.67-s390/drivers/s390/char/sclp_tty.c
--- linux-2.5.67/drivers/s390/char/sclp_tty.c	Mon Apr  7 19:30:43 2003
+++ linux-2.5.67-s390/drivers/s390/char/sclp_tty.c	Mon Apr 14 19:11:51 2003
@@ -9,7 +9,7 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
+#include <linux/module.h>
 #include <linux/kmod.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
@@ -81,9 +81,6 @@
 static int
 sclp_tty_open(struct tty_struct *tty, struct file *filp)
 {
-	/* only 1 SCLP terminal supported */
-	if (minor(tty->device) != tty->driver.minor_start)
-		return -ENODEV;
 	sclp_tty = tty;
 	tty->driver_data = NULL;
 	tty->low_latency = 0;
@@ -94,9 +91,6 @@
 static void
 sclp_tty_close(struct tty_struct *tty, struct file *filp)
 {
-	/* only 1 SCLP terminal supported */
-	if (minor(tty->device) != tty->driver.minor_start)
-		return;
 	if (tty->count > 1)
 		return;
 	sclp_tty = NULL;
@@ -294,8 +288,15 @@
 static inline void
 __sclp_ttybuf_emit(struct sclp_buffer *buffer)
 {
+	unsigned long flags;
+	int count;
+
+	spin_lock_irqsave(&sclp_tty_lock, flags);
 	list_add_tail(&buffer->list, &sclp_tty_outqueue);
-	if (sclp_tty_buffer_count++ == 0)
+	count = sclp_tty_buffer_count++;
+	spin_unlock_irqrestore(&sclp_tty_lock, flags);
+
+	if (count == 0)
 		sclp_emit_buffer(buffer, sclp_ttybuf_callback);
 }
 
@@ -307,13 +308,16 @@
 sclp_tty_timeout(unsigned long data)
 {
 	unsigned long flags;
+	struct sclp_buffer *buf;
 
 	spin_lock_irqsave(&sclp_tty_lock, flags);
-	if (sclp_ttybuf != NULL) {
-		__sclp_ttybuf_emit(sclp_ttybuf);
-		sclp_ttybuf = NULL;
-	}
+	buf = sclp_ttybuf;
+	sclp_ttybuf = NULL;
 	spin_unlock_irqrestore(&sclp_tty_lock, flags);
+
+	if (buf != NULL) {
+		__sclp_ttybuf_emit(buf);
+	}
 }
 
 /*
@@ -325,6 +329,7 @@
 	unsigned long flags;
 	void *page;
 	int written;
+	struct sclp_buffer *buf;
 
 	if (count <= 0)
 		return;
@@ -353,8 +358,11 @@
 		 * output buffer. Emit the buffer, create a new buffer
 		 * and then output the rest of the string.
 		 */
-		__sclp_ttybuf_emit(sclp_ttybuf);
+		buf = sclp_ttybuf;
 		sclp_ttybuf = NULL;
+		spin_unlock_irqrestore(&sclp_tty_lock, flags);
+		__sclp_ttybuf_emit(buf);
+		spin_lock_irqsave(&sclp_tty_lock, flags);
 		str += written;
 		count -= written;
 	} while (count > 0);
@@ -466,7 +474,8 @@
 /*
  * push input to tty
  */
-static void sclp_tty_input(unsigned char* buf, unsigned int count)
+static void
+sclp_tty_input(unsigned char* buf, unsigned int count)
 {
 	unsigned int cchar;
 
@@ -706,15 +715,21 @@
 {
 	void *page;
 	int i;
+	int rc;
 
 	if (!CONSOLE_IS_SCLP)
 		return;
-	if (sclp_rw_init() != 0)
+	rc = sclp_rw_init();
+	if (rc != 0) {
+		printk(KERN_ERR SCLP_TTY_PRINT_HEADER
+		       "could not register tty - "
+		       "sclp_rw_init returned %d\n", rc);
 		return;
+	}
 	/* Allocate pages for output buffering */
 	INIT_LIST_HEAD(&sclp_tty_pages);
 	for (i = 0; i < MAX_KMEM_PAGES; i++) {
-		page = (void *) get_zeroed_page(GFP_KERNEL);
+		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 		if (page == NULL)
 			return;
 		list_add_tail((struct list_head *) page, &sclp_tty_pages);
@@ -744,7 +759,7 @@
 	memset (&sclp_tty_driver, 0, sizeof(struct tty_driver));
 	sclp_tty_driver.magic = TTY_DRIVER_MAGIC;
 	sclp_tty_driver.owner = THIS_MODULE;
-	sclp_tty_driver.driver_name = "tty_sclp";
+	sclp_tty_driver.driver_name = "sclp_line";
 	sclp_tty_driver.name = "ttyS";
 	sclp_tty_driver.name_base = 0;
 	sclp_tty_driver.major = TTY_MAJOR;
@@ -795,9 +810,9 @@
 	sclp_tty_driver.read_proc = NULL;
 	sclp_tty_driver.write_proc = NULL;
 
-	if (tty_register_driver(&sclp_tty_driver))
-		panic("Couldn't register sclp_tty driver\n");
+	rc = tty_register_driver(&sclp_tty_driver);
+	if (rc != 0)
+		printk(KERN_ERR SCLP_TTY_PRINT_HEADER
+		       "could not register tty - "
+		       "sclp_drv_register returned %d\n", rc);
 }
-
-console_initcall(sclp_tty_init);
-


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTEZRVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTEZRU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:20:26 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:24530 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S261876AbTEZRO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:14:57 -0400
Date: Mon, 26 May 2003 19:27:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (8/10): console device drivers.
Message-ID: <20030526172710.GI3748@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 console driver fixes: 
 - Register console ttys via module_init. Remove sclp_tty_init and
   tty3215_init from tty_io.c
 - con3215: use set_current_state.
 - sclp: Fix race condition in sclp interrupt handler. Fix deadlock on
   sclp_conbuf_lock for certain error conditions.

diffstat:
 drivers/char/tty_io.c        |    5 ---
 drivers/s390/char/con3215.c  |    4 +--
 drivers/s390/char/sclp.c     |   42 +++++++++++++++++++++------------
 drivers/s390/char/sclp_con.c |   54 ++++++++++++++++++++++++-------------------
 drivers/s390/char/sclp_tty.c |   25 +++++++++++--------
 drivers/s390/char/sclp_tty.h |    4 +++
 6 files changed, 79 insertions(+), 55 deletions(-)

diff -urN linux-2.5/drivers/char/tty_io.c linux-2.5-s390/drivers/char/tty_io.c
--- linux-2.5/drivers/char/tty_io.c	Mon May 26 19:20:26 2003
+++ linux-2.5-s390/drivers/char/tty_io.c	Mon May 26 19:20:47 2003
@@ -145,8 +145,6 @@
 extern int vme_scc_init (void);
 extern int serial167_init(void);
 extern int rs_8xx_init(void);
-extern void sclp_tty_init(void);
-extern void tty3215_init(void);
 extern void tub3270_init(void);
 extern void rs_360_init(void);
 extern void tx3912_rs_init(void);
@@ -2480,9 +2478,6 @@
 #ifdef CONFIG_TN3270
 	tub3270_init();
 #endif
-#ifdef CONFIG_SCLP_TTY
-	sclp_tty_init();
-#endif
 #ifdef CONFIG_A2232
 	a2232board_init();
 #endif
diff -urN linux-2.5/drivers/s390/char/con3215.c linux-2.5-s390/drivers/s390/char/con3215.c
--- linux-2.5/drivers/s390/char/con3215.c	Mon May  5 01:53:35 2003
+++ linux-2.5-s390/drivers/s390/char/con3215.c	Mon May 26 19:20:47 2003
@@ -697,12 +697,12 @@
 	    raw->queued_read != NULL) {
 		raw->flags |= RAW3215_CLOSING;
 		add_wait_queue(&raw->empty_wait, &wait);
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irqrestore(raw->lock, flags);
 		schedule();
 		spin_lock_irqsave(raw->lock, flags);
 		remove_wait_queue(&raw->empty_wait, &wait);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		raw->flags &= ~(RAW3215_ACTIVE | RAW3215_CLOSING);
 	}
 	spin_unlock_irqrestore(raw->lock, flags);
diff -urN linux-2.5/drivers/s390/char/sclp.c linux-2.5-s390/drivers/s390/char/sclp.c
--- linux-2.5/drivers/s390/char/sclp.c	Mon May  5 01:53:32 2003
+++ linux-2.5-s390/drivers/s390/char/sclp.c	Mon May 26 19:20:47 2003
@@ -18,7 +18,9 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
+#include <linux/init.h>
 #include <asm/s390_ext.h>
+#include <asm/processor.h>
 
 #include "sclp.h"
 
@@ -49,7 +51,7 @@
 /* Timer for init mask retries. */
 static struct timer_list retry_timer;
 
-static unsigned long sclp_status = 0;
+static volatile unsigned long sclp_status = 0;
 /* some status flags */
 #define SCLP_INIT		0
 #define SCLP_RUNNING		1
@@ -275,20 +277,24 @@
 	struct list_head *l;
 	struct sclp_req *req, *tmp;
 
+	spin_lock(&sclp_lock);
 	/*
 	 * Only process interrupt if sclp is initialized.
 	 * This avoids strange effects for a pending request
 	 * from before the last re-ipl.
 	 */
-	if (!test_bit(SCLP_INIT, &sclp_status))
+	if (!test_bit(SCLP_INIT, &sclp_status)) {
+		/* Now clear the running bit */
+		clear_bit(SCLP_RUNNING, &sclp_status);
+		spin_unlock(&sclp_lock);
 		return;
+	}
 	ext_int_param = S390_lowcore.ext_params;
 	finished_sccb = ext_int_param & EXT_INT_SCCB_MASK;
 	evbuf_pending = ext_int_param & (EXT_INT_EVBUF_PENDING |
 					 EXT_INT_STATECHANGE_PENDING);
 	irq_enter();
 	req = NULL;
-	spin_lock(&sclp_lock);
 	if (finished_sccb != 0U) {
 		list_for_each(l, &sclp_req_queue) {
 			tmp = list_entry(l, struct sclp_req, list);
@@ -299,9 +305,6 @@
 			}
 		}
 	}
-	/* Head queue a read sccb if an event buffer is pending */
-	if (evbuf_pending)
-		__sclp_unconditional_read();
 	spin_unlock(&sclp_lock);
 	/* Perform callback */
 	if (req != NULL) {
@@ -309,8 +312,13 @@
 		if (req->callback != NULL)
 			req->callback(req, req->callback_data);
 	}
+	spin_lock(&sclp_lock);
+	/* Head queue a read sccb if an event buffer is pending */
+	if (evbuf_pending)
+		__sclp_unconditional_read();
 	/* Now clear the running bit */
 	clear_bit(SCLP_RUNNING, &sclp_status);
+	spin_unlock(&sclp_lock);
 	/* and start next request on the queue */
 	sclp_start_request();
 	irq_exit();
@@ -344,8 +352,10 @@
 		      : "=m" (psw_mask) : "a" (&psw_mask) : "memory");
 
 	/* wait until ISR signals receipt of interrupt */
-	while (test_bit(SCLP_RUNNING, &sclp_status))
+	while (test_bit(SCLP_RUNNING, &sclp_status)) {
 		barrier();
+		cpu_relax();
+	}
 
 	/* disable external interruptions */
 	asm volatile ("SSM 0(%0)"
@@ -631,6 +641,14 @@
 		/* Already initialized. */
 		return 0;
 
+	spin_lock_init(&sclp_lock);
+	INIT_LIST_HEAD(&sclp_req_queue);
+
+	/* init event list */
+	INIT_LIST_HEAD(&sclp_reg_list);
+	list_add(&sclp_state_change_event.list, &sclp_reg_list);
+	list_add(&sclp_quiesce_event.list, &sclp_reg_list);
+
 	/*
 	 * request the 0x2401 external interrupt
 	 * The sclp driver is initialized early (before kmalloc works). We
@@ -640,14 +658,6 @@
 					      &ext_int_info_hwc) != 0)
 		return -EBUSY;
 
-	spin_lock_init(&sclp_lock);
-	INIT_LIST_HEAD(&sclp_req_queue);
-
-	/* init event list */
-	INIT_LIST_HEAD(&sclp_reg_list);
-	list_add(&sclp_state_change_event.list, &sclp_reg_list);
-	list_add(&sclp_quiesce_event.list, &sclp_reg_list);
-
 	/* enable service-signal external interruptions,
 	 * Control Register 0 bit 22 := 1
 	 * (besides PSW bit 7 must be set to 1 sometimes for external
@@ -762,6 +772,8 @@
 	return unprocessed;
 }
 
+module_init(sclp_init);
+
 EXPORT_SYMBOL(sclp_add_request);
 EXPORT_SYMBOL(sclp_sync_wait);
 EXPORT_SYMBOL(sclp_register);
diff -urN linux-2.5/drivers/s390/char/sclp_con.c linux-2.5-s390/drivers/s390/char/sclp_con.c
--- linux-2.5/drivers/s390/char/sclp_con.c	Mon May  5 01:53:29 2003
+++ linux-2.5-s390/drivers/s390/char/sclp_con.c	Mon May 26 19:20:47 2003
@@ -15,9 +15,11 @@
 #include <linux/timer.h>
 #include <linux/jiffies.h>
 #include <linux/bootmem.h>
+#include <linux/err.h>
 
 #include "sclp.h"
 #include "sclp_rw.h"
+#include "sclp_tty.h"
 
 #define SCLP_CON_PRINT_HEADER "sclp console driver: "
 
@@ -69,10 +71,23 @@
 }
 
 static inline void
-__sclp_conbuf_emit(struct sclp_buffer *buffer)
+sclp_conbuf_emit(void)
 {
+	struct sclp_buffer* buffer;
+	unsigned long flags;
+	int count;
+
+	spin_lock_irqsave(&sclp_con_lock, flags);
+	buffer = sclp_conbuf;
+	sclp_conbuf = NULL;
+	if (buffer == NULL) {
+		spin_unlock_irqrestore(&sclp_con_lock, flags);
+		return;
+	}
 	list_add_tail(&buffer->list, &sclp_con_outqueue);
-	if (sclp_con_buffer_count++ == 0)
+	count = sclp_con_buffer_count++;
+	spin_unlock_irqrestore(&sclp_con_lock, flags);
+	if (count == 0)
 		sclp_emit_buffer(buffer, sclp_conbuf_callback);
 }
 
@@ -83,14 +98,7 @@
 static void
 sclp_console_timeout(unsigned long data)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&sclp_con_lock, flags);
-	if (sclp_conbuf != NULL) {
-		__sclp_conbuf_emit(sclp_conbuf);
-		sclp_conbuf = NULL;
-	}
-	spin_unlock_irqrestore(&sclp_con_lock, flags);
+	sclp_conbuf_emit();
 }
 
 /*
@@ -134,8 +142,9 @@
 		 * output buffer. Emit the buffer, create a new buffer
 		 * and then output the rest of the string.
 		 */
-		__sclp_conbuf_emit(sclp_conbuf);
-		sclp_conbuf = NULL;
+		spin_unlock_irqrestore(&sclp_con_lock, flags);
+		sclp_conbuf_emit();
+		spin_lock_irqsave(&sclp_con_lock, flags);
 		message += written;
 		count -= written;
 	} while (count > 0);
@@ -150,11 +159,11 @@
 	spin_unlock_irqrestore(&sclp_con_lock, flags);
 }
 
-/* returns the device number of the SCLP console */
-static kdev_t
-sclp_console_device(struct console *c)
+static struct tty_driver *
+sclp_console_device(struct console *c, int *index)
 {
-	return	mk_kdev(sclp_console_major, sclp_console_minor);
+	*index = c->index;
+	return &sclp_tty_driver;
 }
 
 /*
@@ -167,13 +176,10 @@
 {
 	unsigned long flags;
 
+	sclp_conbuf_emit();
 	spin_lock_irqsave(&sclp_con_lock, flags);
 	if (timer_pending(&sclp_con_timer))
 		del_timer(&sclp_con_timer);
-	if (sclp_conbuf != NULL) {
-		__sclp_conbuf_emit(sclp_conbuf);
-		sclp_conbuf = NULL;
-	}
 	while (sclp_con_buffer_count > 0) {
 		spin_unlock_irqrestore(&sclp_con_lock, flags);
 		sclp_sync_wait();
@@ -204,17 +210,19 @@
 {
 	void *page;
 	int i;
+	int rc;
 
 	if (!CONSOLE_IS_SCLP)
 		return 0;
-	if (sclp_rw_init() != 0)
-		return 0;
+	rc = sclp_rw_init();
+	if (rc)
+		return rc;
 	/* Allocate pages for output buffering */
 	INIT_LIST_HEAD(&sclp_con_pages);
 	for (i = 0; i < MAX_CONSOLE_PAGES; i++) {
 		page = alloc_bootmem_low_pages(PAGE_SIZE);
 		if (page == NULL)
-			return 0;
+			return -ENOMEM;
 		list_add_tail((struct list_head *) page, &sclp_con_pages);
 	}
 	INIT_LIST_HEAD(&sclp_con_outqueue);
diff -urN linux-2.5/drivers/s390/char/sclp_tty.c linux-2.5-s390/drivers/s390/char/sclp_tty.c
--- linux-2.5/drivers/s390/char/sclp_tty.c	Mon May  5 01:53:02 2003
+++ linux-2.5-s390/drivers/s390/char/sclp_tty.c	Mon May 26 19:20:47 2003
@@ -16,6 +16,8 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>
 
 #include "ctrlchar.h"
@@ -55,7 +57,7 @@
 static unsigned char sclp_tty_chars[SCLP_TTY_BUF_SIZE];
 static unsigned short int sclp_tty_chars_count;
 
-static struct tty_driver sclp_tty_driver;
+struct tty_driver sclp_tty_driver;
 static struct tty_struct * sclp_tty_table[1];
 static struct termios * sclp_tty_termios[1];
 static struct termios * sclp_tty_termios_locked[1];
@@ -710,7 +712,7 @@
 	.receiver_fn = sclp_tty_receiver
 };
 
-void
+int __init
 sclp_tty_init(void)
 {
 	void *page;
@@ -718,20 +720,20 @@
 	int rc;
 
 	if (!CONSOLE_IS_SCLP)
-		return;
+		return 0;
 	rc = sclp_rw_init();
-	if (rc != 0) {
+	if (rc) {
 		printk(KERN_ERR SCLP_TTY_PRINT_HEADER
 		       "could not register tty - "
 		       "sclp_rw_init returned %d\n", rc);
-		return;
+		return rc;
 	}
 	/* Allocate pages for output buffering */
 	INIT_LIST_HEAD(&sclp_tty_pages);
 	for (i = 0; i < MAX_KMEM_PAGES; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 		if (page == NULL)
-			return;
+			return -ENOMEM;
 		list_add_tail((struct list_head *) page, &sclp_tty_pages);
 	}
 	INIT_LIST_HEAD(&sclp_tty_outqueue);
@@ -753,8 +755,9 @@
 	sclp_tty_chars_count = 0;
 	sclp_tty = NULL;
 
-	if (sclp_register(&sclp_input_event) != 0)
-		return;
+	rc = sclp_register(&sclp_input_event);
+	if (rc)
+		return rc;
 
 	memset (&sclp_tty_driver, 0, sizeof(struct tty_driver));
 	sclp_tty_driver.magic = TTY_DRIVER_MAGIC;
@@ -810,8 +813,10 @@
 	sclp_tty_driver.write_proc = NULL;
 
 	rc = tty_register_driver(&sclp_tty_driver);
-	if (rc != 0)
+	if (rc)
 		printk(KERN_ERR SCLP_TTY_PRINT_HEADER
 		       "could not register tty - "
-		       "sclp_drv_register returned %d\n", rc);
+		       "tty_register_driver returned %d\n", rc);
+	return rc;
 }
+module_init(sclp_tty_init);
diff -urN linux-2.5/drivers/s390/char/sclp_tty.h linux-2.5-s390/drivers/s390/char/sclp_tty.h
--- linux-2.5/drivers/s390/char/sclp_tty.h	Mon May  5 01:53:31 2003
+++ linux-2.5-s390/drivers/s390/char/sclp_tty.h	Mon May 26 19:20:47 2003
@@ -12,6 +12,8 @@
 #define __SCLP_TTY_H__
 
 #include <linux/ioctl.h>
+#include <linux/termios.h>
+#include <linux/tty_driver.h>
 
 /* This is the type of data structures storing sclp ioctl setting. */
 struct sclp_ioctls {
@@ -64,4 +66,6 @@
 /* get the number of buffers/pages got from kernel at startup */
 #define TIOCSCLPGKBUF	_IOR(SCLP_IOCTL_LETTER, 20, unsigned short)
 
+extern struct tty_driver sclp_tty_driver;
+
 #endif	/* __SCLP_TTY_H__ */

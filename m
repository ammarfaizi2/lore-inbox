Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVLPN3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVLPN3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVLPN3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:29:54 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:35312 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932260AbVLPN3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:29:52 -0500
Date: Fri, 16 Dec 2005 14:29:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, wein@de.ibm.com, Horst.Hummel@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 3/3] s390: dasd extended error reporting module.
Message-ID: <20051216132953.GD8877@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Weinhuber <wein@de.ibm.com>

[patch 3/3] s390: dasd extended error reporting module.

The DASD extended error reporting is a facility that allows to
get detailed information about certain problems in the DASD I/O.
This information can be used to implement fail-over applications
that can recover these problems.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/kernel/compat_ioctl.c    |    2 
 drivers/s390/block/Kconfig         |   14 
 drivers/s390/block/Makefile        |    2 
 drivers/s390/block/dasd.c          |   76 ++
 drivers/s390/block/dasd_3990_erp.c |    5 
 drivers/s390/block/dasd_eckd.h     |    3 
 drivers/s390/block/dasd_eer.c      | 1091 +++++++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_int.h      |   37 +
 include/asm-s390/dasd.h            |   15 
 9 files changed, 1237 insertions(+), 8 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_ioctl.c linux-2.6-patched/arch/s390/kernel/compat_ioctl.c
--- linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-12-16 10:56:42.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/compat_ioctl.c	2005-12-16 10:57:24.000000000 +0100
@@ -63,6 +63,8 @@ COMPATIBLE_IOCTL(BIODASDSATTR)
 COMPATIBLE_IOCTL(BIODASDCMFENABLE)
 COMPATIBLE_IOCTL(BIODASDCMFDISABLE)
 COMPATIBLE_IOCTL(BIODASDREADALLCMB)
+COMPATIBLE_IOCTL(BIODASDEERSET)
+COMPATIBLE_IOCTL(BIODASDEERGET)
 
 COMPATIBLE_IOCTL(TUBICMD)
 COMPATIBLE_IOCTL(TUBOCMD)
diff -urpN linux-2.6/drivers/s390/block/dasd_3990_erp.c linux-2.6-patched/drivers/s390/block/dasd_3990_erp.c
--- linux-2.6/drivers/s390/block/dasd_3990_erp.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_3990_erp.c	2005-12-16 10:57:24.000000000 +0100
@@ -5,7 +5,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000, 2001
  *
- * $Revision: 1.36 $
+ * $Revision: 1.38 $
  */
 
 #include <linux/timer.h>
@@ -1109,6 +1109,9 @@ dasd_3990_handle_env_data(struct dasd_cc
 		case 0x0B:
 			DEV_MESSAGE(KERN_WARNING, device, "%s",
 				    "FORMAT F - Volume is suspended duplex");
+			/* call extended error reporting (EER) */
+			dasd_write_eer_trigger(DASD_EER_PPRCSUSPEND, device,
+					       erp->refers);
 			break;
 		case 0x0C:
 			DEV_MESSAGE(KERN_WARNING, device, "%s",
diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-12-16 10:57:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-12-16 10:57:24.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
+#include <linux/notifier.h>
 
 #include <asm/ccwdev.h>
 #include <asm/ebcdic.h>
@@ -57,6 +58,7 @@ static void dasd_int_handler(struct ccw_
 static void dasd_flush_ccw_queue(struct dasd_device *, int);
 static void dasd_tasklet(struct dasd_device *);
 static void do_kick_device(void *data);
+static void dasd_disable_eer(struct dasd_device *device);
 
 /*
  * SECTION: Operations on the device structure.
@@ -151,6 +153,8 @@ dasd_state_new_to_known(struct dasd_devi
 static inline void
 dasd_state_known_to_new(struct dasd_device * device)
 {
+	/* disable extended error reporting for this device */
+	dasd_disable_eer(device);
 	/* Forget the discipline information. */
 	device->discipline = NULL;
 	device->state = DASD_STATE_NEW;
@@ -870,6 +874,9 @@ dasd_handle_state_change_pending(struct 
 	struct dasd_ccw_req *cqr;
 	struct list_head *l, *n;
 
+	/* first of all call extended error reporting */
+	dasd_write_eer_trigger(DASD_EER_STATECHANGE, device, NULL);
+
 	device->stopped &= ~DASD_STOPPED_PENDING;
 
         /* restart all 'running' IO on queue */
@@ -1089,6 +1096,19 @@ restart:
 			}
 			goto restart;
 		}
+
+		/* first of all call extended error reporting */
+		if (device->eer && cqr->status == DASD_CQR_FAILED) {
+			dasd_write_eer_trigger(DASD_EER_FATALERROR,
+					       device, cqr);
+
+			/* restart request  */
+			cqr->status = DASD_CQR_QUEUED;
+			cqr->retries = 255;
+			device->stopped |= DASD_STOPPED_QUIESCE;
+			goto restart;
+		}
+
 		/* Process finished ERP request. */
 		if (cqr->refers) {
 			__dasd_process_erp(device, cqr);
@@ -1226,7 +1246,8 @@ __dasd_start_head(struct dasd_device * d
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
         /* check FAILFAST */
 	if (device->stopped & ~DASD_STOPPED_PENDING &&
-	    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags)) {
+	    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
+	    (!device->eer)) {
 		cqr->status = DASD_CQR_FAILED;
 		dasd_schedule_bh(device);
 	}
@@ -1921,6 +1942,9 @@ dasd_generic_notify(struct ccw_device *c
 	switch (event) {
 	case CIO_GONE:
 	case CIO_NO_PATH:
+		/* first of all call extended error reporting */
+		dasd_write_eer_trigger(DASD_EER_NOPATH, device, NULL);
+
 		if (device->state < DASD_STATE_BASIC)
 			break;
 		/* Device is active. We want to keep it. */
@@ -1978,6 +2002,51 @@ dasd_generic_auto_online (struct ccw_dri
 	put_driver(drv);
 }
 
+/*
+ * notifications for extended error reports
+ */
+static struct notifier_block *dasd_eer_chain;
+
+int
+dasd_register_eer_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_register(&dasd_eer_chain, nb);
+}
+
+int
+dasd_unregister_eer_notifier(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&dasd_eer_chain, nb);
+}
+
+/*
+ * Notify the registered error reporting module of a problem
+ */
+void
+dasd_write_eer_trigger(unsigned int id, struct dasd_device *device,
+		       struct dasd_ccw_req *cqr)
+{
+	if (device->eer) {
+		struct dasd_eer_trigger temp;
+		temp.id = id;
+		temp.device = device;
+		temp.cqr = cqr;
+		notifier_call_chain(&dasd_eer_chain, DASD_EER_TRIGGER,
+				    (void *)&temp);
+	}
+}
+
+/*
+ * Tell the registered error reporting module to disable error reporting for
+ * a given device and to cleanup any private data structures on that device.
+ */
+static void
+dasd_disable_eer(struct dasd_device *device)
+{
+	notifier_call_chain(&dasd_eer_chain, DASD_EER_DISABLE, (void *)device);
+}
+
+
 static int __init
 dasd_init(void)
 {
@@ -2059,6 +2128,11 @@ EXPORT_SYMBOL_GPL(dasd_generic_set_onlin
 EXPORT_SYMBOL_GPL(dasd_generic_set_offline);
 EXPORT_SYMBOL_GPL(dasd_generic_auto_online);
 
+EXPORT_SYMBOL(dasd_register_eer_notifier);
+EXPORT_SYMBOL(dasd_unregister_eer_notifier);
+EXPORT_SYMBOL(dasd_write_eer_trigger);
+
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.h linux-2.6-patched/drivers/s390/block/dasd_eckd.h
--- linux-2.6/drivers/s390/block/dasd_eckd.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.h	2005-12-16 10:57:24.000000000 +0100
@@ -5,7 +5,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.10 $
+ * $Revision: 1.11 $
  */
 
 #ifndef DASD_ECKD_H
@@ -30,6 +30,7 @@
 #define DASD_ECKD_CCW_PSF		 0x27
 #define DASD_ECKD_CCW_RSSD		 0x3e
 #define DASD_ECKD_CCW_LOCATE_RECORD	 0x47
+#define DASD_ECKD_CCW_SNSS               0x54
 #define DASD_ECKD_CCW_DEFINE_EXTENT	 0x63
 #define DASD_ECKD_CCW_WRITE_MT		 0x85
 #define DASD_ECKD_CCW_READ_MT		 0x86
diff -urpN linux-2.6/drivers/s390/block/dasd_eer.c linux-2.6-patched/drivers/s390/block/dasd_eer.c
--- linux-2.6/drivers/s390/block/dasd_eer.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_eer.c	2005-12-16 10:57:24.000000000 +0100
@@ -0,0 +1,1091 @@
+/*
+ *	character device driver for extended error reporting
+ *
+ *
+ *	Copyright (C) 2005 IBM Corporation
+ *	extended error reporting for DASD ECKD devices
+ *	Author(s): Stefan Weinhuber <wein@de.ibm.com>
+ *
+ *      $Revision: 1.4 $
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/workqueue.h>
+#include <linux/poll.h>
+#include <linux/notifier.h>
+
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+#include <asm/atomic.h>
+#include <asm/ebcdic.h>
+
+#include "dasd_int.h"
+#include "dasd_eckd.h"
+
+
+MODULE_LICENSE("GPL");
+
+MODULE_AUTHOR("Stefan Weinhuber <wein@de.ibm.com>");
+MODULE_DESCRIPTION("DASD extended error reporting module");
+
+
+#ifdef PRINTK_HEADER
+#undef PRINTK_HEADER
+#endif				/* PRINTK_HEADER */
+#define PRINTK_HEADER "dasd(eer):"
+
+
+
+
+
+/*****************************************************************************/
+/*      the internal buffer                                                  */
+/*****************************************************************************/
+
+/*
+ * The internal buffer is meant to store obaque blobs of data, so it doesn't
+ * know of higher level concepts like triggers.
+ * It consists of a number of pages that are used as a ringbuffer. Each data
+ * blob is stored in a simple record that consists of an integer, which
+ * contains the size of the following data, and the data bytes themselfes.
+ *
+ * To allow for multiple independent readers we create one internal buffer
+ * each time the device is opened and destroy the buffer when the file is
+ * closed again.
+ *
+ * One record can be written to a buffer by using the functions
+ * - dasd_eer_start_record (one time per record to write the size to the buffer
+ *                          and reserve the space for the data)
+ * - dasd_eer_write_buffer (one or more times per record to write the data)
+ * The data can be written in several steps but you will have to compute
+ * the total size up front for the invocation of dasd_eer_start_record.
+ * If the ringbuffer is full, dasd_eer_start_record will remove the required
+ * number of old records.
+ *
+ * A record is typically read in two steps, first read the integer that
+ * specifies the size of the following data, then read the data.
+ * Both can be done by
+ * - dasd_eer_read_buffer
+ *
+ * For all mentioned functions you need to get the bufferlock first and keep it
+ * until a complete record is written or read.
+ */
+
+
+/*
+ * Alle information necessary to keep track of an internal buffer is kept in
+ * a struct eerbuffer. The buffer specific to a file pointer is strored in
+ * the private_data field of that file. To be able to write data to all
+ * existing buffers, each buffer is also added to the bufferlist.
+ * If the user doesn't want to read a complete record in one go, we have to
+ * keep track of the rest of the record. residual stores the number of bytes
+ * that are still to deliver. If the rest of the record is invalidated between
+ * two reads then residual will be set to -1 so that the next read will fail.
+ * All entries in the eerbuffer structure are protected with the bufferlock.
+ * To avoid races between writing to a buffer on the one side and creating
+ * and destroying buffers on the other side, the bufferlock must also be used
+ * to protect the bufferlist.
+ */
+
+struct eerbuffer {
+	struct list_head list;
+	char **buffer;
+	int buffersize;
+	int buffer_page_count;
+	int head;
+        int tail;
+	int residual;
+};
+
+LIST_HEAD(bufferlist);
+
+static spinlock_t bufferlock = SPIN_LOCK_UNLOCKED;
+
+DECLARE_WAIT_QUEUE_HEAD(dasd_eer_read_wait_queue);
+
+/*
+ * How many free bytes are available on the buffer.
+ * needs to be called with bufferlock held
+ */
+static int
+dasd_eer_get_free_bytes(struct eerbuffer *eerb)
+{
+	if (eerb->head < eerb->tail) {
+		return eerb->tail - eerb->head - 1;
+	} else
+		return eerb->buffersize - eerb->head + eerb->tail -1;
+}
+
+/*
+ * How many bytes of buffer space are used.
+ * needs to be called with bufferlock held
+ */
+static int
+dasd_eer_get_filled_bytes(struct eerbuffer *eerb)
+{
+
+	if (eerb->head >= eerb->tail) {
+		return eerb->head - eerb->tail;
+	} else
+		return eerb->buffersize - eerb->tail + eerb->head;
+}
+
+/*
+ * The dasd_eer_write_buffer function just copies count bytes of data
+ * to the buffer. Make sure to call dasd_eer_start_record first, to
+ * make sure that enough free space is available.
+ * needs to be called with bufferlock held
+ */
+static void
+dasd_eer_write_buffer(struct eerbuffer *eerb, int count, char *data)
+{
+
+	unsigned long headindex,localhead;
+	unsigned long rest, len;
+	char *nextdata;
+
+	nextdata = data;
+	rest = count;
+	while (rest > 0) {
+ 		headindex = eerb->head / PAGE_SIZE;
+ 		localhead = eerb->head % PAGE_SIZE;
+		len = min(rest, (PAGE_SIZE - localhead));
+		memcpy(eerb->buffer[headindex]+localhead, nextdata, len);
+		nextdata += len;
+		rest -= len;
+		eerb->head += len;
+		if ( eerb->head == eerb->buffersize )
+			eerb->head = 0; /* wrap around */
+		if (eerb->head > eerb->buffersize) {
+			MESSAGE(KERN_ERR, "%s", "runaway buffer head.");
+			BUG();
+		}
+	}
+}
+
+/*
+ * needs to be called with bufferlock held
+ */
+static int
+dasd_eer_read_buffer(struct eerbuffer *eerb, int count, char *data)
+{
+
+	unsigned long tailindex,localtail;
+	unsigned long rest, len, finalcount;
+	char *nextdata;
+
+	finalcount = min(count, dasd_eer_get_filled_bytes(eerb));
+	nextdata = data;
+	rest = finalcount;
+	while (rest > 0) {
+ 		tailindex = eerb->tail / PAGE_SIZE;
+ 		localtail = eerb->tail % PAGE_SIZE;
+		len = min(rest, (PAGE_SIZE - localtail));
+		memcpy(nextdata, eerb->buffer[tailindex]+localtail, len);
+		nextdata += len;
+		rest -= len;
+		eerb->tail += len;
+		if ( eerb->tail == eerb->buffersize )
+			eerb->tail = 0; /* wrap around */
+		if (eerb->tail > eerb->buffersize) {
+			MESSAGE(KERN_ERR, "%s", "runaway buffer tail.");
+			BUG();
+		}
+	}
+	return finalcount;
+}
+
+/*
+ * Whenever you want to write a blob of data to the internal buffer you
+ * have to start by using this function first. It will write the number
+ * of bytes that will be written to the buffer. If necessary it will remove
+ * old records to make room for the new one.
+ * needs to be called with bufferlock held
+ */
+static int
+dasd_eer_start_record(struct eerbuffer *eerb, int count)
+{
+	int tailcount;
+	if (count + sizeof(count) > eerb->buffersize)
+		return -ENOMEM;
+	while (dasd_eer_get_free_bytes(eerb) < count + sizeof(count)) {
+		if (eerb->residual > 0) {
+			eerb->tail += eerb->residual;
+			if (eerb->tail >= eerb->buffersize)
+				eerb->tail -= eerb->buffersize;
+			eerb->residual = -1;
+		}
+		dasd_eer_read_buffer(eerb, sizeof(tailcount),
+				     (char*)(&tailcount));
+		eerb->tail += tailcount;
+		if (eerb->tail >= eerb->buffersize)
+			eerb->tail -= eerb->buffersize;
+	}
+	dasd_eer_write_buffer(eerb, sizeof(count), (char*)(&count));
+
+	return 0;
+};
+
+/*
+ * release pages that are not used anymore
+ */
+static void
+dasd_eer_free_buffer_pages(char **buf, int no_pages)
+{
+	int i;
+
+	for (i = 0; i < no_pages; ++i) {
+		free_page((unsigned long)buf[i]);
+	}
+}
+
+/*
+ * allocate a new set of memory pages
+ */
+static int
+dasd_eer_allocate_buffer_pages(char **buf, int no_pages)
+{
+	int i;
+
+	for (i = 0; i < no_pages; ++i) {
+		buf[i] = (char *) get_zeroed_page(GFP_KERNEL);
+		if (!buf[i]) {
+			dasd_eer_free_buffer_pages(buf, i);
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+/*
+ * empty the buffer by resetting head and tail
+ * In case there is a half read data blob in the buffer, we set residual
+ * to -1 to indicate that the remainder of the blob is lost.
+ */
+static void
+dasd_eer_purge_buffer(struct eerbuffer *eerb)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&bufferlock, flags);
+	if (eerb->residual > 0)
+		eerb->residual = -1;
+	eerb->tail=0;
+	eerb->head=0;
+	spin_unlock_irqrestore(&bufferlock, flags);
+}
+
+/*
+ * set the size of the buffer, newsize is the new number of pages to be used
+ * we don't try to copy any data back an forth, so any resize will also purge
+ * the buffer
+ */
+static int
+dasd_eer_resize_buffer(struct eerbuffer *eerb, int newsize)
+{
+	int i, oldcount, reuse;
+	char **new;
+	char **old;
+	unsigned long flags;
+
+	if (newsize < 1)
+		return -EINVAL;
+	if (eerb->buffer_page_count == newsize) {
+		/* documented behaviour is that any successfull invocation
+                 * will purge all records */
+		dasd_eer_purge_buffer(eerb);
+		return 0;
+	}
+	new = kmalloc(newsize*sizeof(char*), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	reuse=min(eerb->buffer_page_count, newsize);
+	for (i = 0; i < reuse; ++i) {
+		new[i] = eerb->buffer[i];
+	}
+	if (eerb->buffer_page_count < newsize) {
+		if (dasd_eer_allocate_buffer_pages(
+			    &new[eerb->buffer_page_count],
+			    newsize - eerb->buffer_page_count)) {
+			kfree(new);
+			return -ENOMEM;
+		}
+	}
+
+	spin_lock_irqsave(&bufferlock, flags);
+	old = eerb->buffer;
+	eerb->buffer = new;
+	if (eerb->residual > 0)
+		eerb->residual = -1;
+	eerb->tail = 0;
+	eerb->head = 0;
+	oldcount = eerb->buffer_page_count;
+	eerb->buffer_page_count = newsize;
+	spin_unlock_irqrestore(&bufferlock, flags);
+
+	if (oldcount > newsize) {
+		for (i = newsize; i < oldcount; ++i) {
+			free_page((unsigned long)old[i]);
+		}
+	}
+	kfree(old);
+
+	return 0;
+}
+
+
+/*****************************************************************************/
+/*      The extended error reporting functionality                           */
+/*****************************************************************************/
+
+/*
+ * When a DASD device driver wants to report an error, it calls the
+ * function dasd_eer_write_trigger (via a notifier mechanism) and gives the
+ * respective trigger ID as parameter.
+ * Currently there are four kinds of triggers:
+ *
+ * DASD_EER_FATALERROR:  all kinds of unrecoverable I/O problems
+ * DASD_EER_PPRCSUSPEND: PPRC was suspended
+ * DASD_EER_NOPATH:      There is no path to the device left.
+ * DASD_EER_STATECHANGE: The state of the device has changed.
+ *
+ * For the first three triggers all required information can be supplied by
+ * the caller. For these triggers a record is written by the function
+ * dasd_eer_write_standard_trigger.
+ *
+ * When dasd_eer_write_trigger is called to write a DASD_EER_STATECHANGE
+ * trigger, we have to gather the necessary sense data first. We cannot queue
+ * the necessary SNSS (sense subsystem status) request immediatly, since we
+ * are likely to run in a deadlock situation. Instead, we schedule a
+ * work_struct that calls the function dasd_eer_sense_subsystem_status to
+ * create and start an SNSS  request asynchronously.
+ *
+ * To avoid memory allocations at runtime, the necessary memory is allocated
+ * when the extended error reporting is enabled for a device (by
+ * dasd_eer_probe). There is one private eer data structure for each eer
+ * enabled DASD device. It contains memory for the work_struct, one SNSS cqr
+ * and a flags field that is used to coordinate the use of the cqr. The call
+ * to write a state change trigger can come in at any time, so we have one flag
+ * CQR_IN_USE that protects the cqr itself. When this flag indicates that the
+ * cqr is currently in use, dasd_eer_sense_subsystem_status cannot start a
+ * second request but sets the SNSS_REQUESTED flag instead.
+ *
+ * When the request is finished, the callback function dasd_eer_SNSS_cb
+ * is called. This function will invoke the function
+ * dasd_eer_write_SNSS_trigger to finally write the trigger. It will also
+ * check the SNSS_REQUESTED flag and if it is set it will call
+ * dasd_eer_sense_subsystem_status again.
+ *
+ * To avoid race conditions during the handling of the lock, the flags must
+ * be protected by the snsslock.
+ */
+
+struct dasd_eer_private {
+	struct dasd_ccw_req *cqr;
+	unsigned long flags;
+	struct work_struct worker;
+};
+
+static void dasd_eer_destroy(struct dasd_device *device,
+			     struct dasd_eer_private *eer);
+static int
+dasd_eer_write_trigger(struct dasd_eer_trigger *trigger);
+static void dasd_eer_sense_subsystem_status(void *data);
+static int dasd_eer_notify(struct notifier_block *self,
+			   unsigned long action, void *data);
+
+struct workqueue_struct *dasd_eer_workqueue;
+
+#define SNSS_DATA_SIZE 44
+static spinlock_t snsslock = SPIN_LOCK_UNLOCKED;
+
+#define DASD_EER_BUSID_SIZE 10
+struct dasd_eer_header {
+	__u32 total_size;
+	__u32 trigger;
+	__u64 tv_sec;
+	__u64 tv_usec;
+	char busid[DASD_EER_BUSID_SIZE];
+} __attribute__ ((packed));
+
+static struct notifier_block dasd_eer_nb = {
+	.notifier_call = dasd_eer_notify,
+};
+
+/*
+ * flags for use with dasd_eer_private
+ */
+#define CQR_IN_USE     0
+#define SNSS_REQUESTED 1
+
+/*
+ * This function checks if extended error reporting is available for a given
+ * dasd_device. If yes, then it creates and returns a struct dasd_eer,
+ * otherwise it returns an -EPERM error pointer.
+ */
+struct dasd_eer_private *
+dasd_eer_probe(struct dasd_device *device)
+{
+	struct dasd_eer_private *private;
+
+	if (!(device && device->discipline
+	      && !strcmp(device->discipline->name, "ECKD"))) {
+		return ERR_PTR(-EPERM);
+	}
+	/* allocate the private data structure */
+	private = (struct dasd_eer_private *)kmalloc(
+		sizeof(struct dasd_eer_private), GFP_KERNEL);
+	if (!private) {
+		return ERR_PTR(-ENOMEM);
+	}
+	INIT_WORK(&private->worker, dasd_eer_sense_subsystem_status,
+		  (void *)device);
+	private->cqr = dasd_kmalloc_request("ECKD",
+					    1 /* SNSS */ ,
+					    SNSS_DATA_SIZE ,
+					    device);
+	if (!private->cqr) {
+		kfree(private);
+		return ERR_PTR(-ENOMEM);
+	}
+	private->flags = 0;
+	return private;
+};
+
+/*
+ * If our private SNSS request is queued, remove it from the
+ * dasd ccw queue so we can free the requests memory.
+ */
+static void
+dasd_eer_dequeue_SNSS_request(struct dasd_device *device,
+			      struct dasd_eer_private *eer)
+{
+	struct list_head *lst, *nxt;
+	struct dasd_ccw_req *cqr, *erpcqr;
+	dasd_erp_fn_t erp_fn;
+
+	spin_lock_irq(get_ccwdev_lock(device->cdev));
+	list_for_each_safe(lst, nxt, &device->ccw_queue) {
+		cqr = list_entry(lst, struct dasd_ccw_req, list);
+		/* we are looking for two kinds or requests */
+		/* first kind: our SNSS request: */
+		if (cqr == eer->cqr) {
+			if (cqr->status == DASD_CQR_IN_IO)
+				device->discipline->term_IO(cqr);
+			list_del(&cqr->list);
+			break;
+		}
+		/* second kind: ERP requests for our SNSS request */
+		if (cqr->refers) {
+			/* If this erp request chain ends in our cqr, then */
+                        /* cal the erp_postaction to clean it up  */
+			erpcqr = cqr;
+			while (erpcqr->refers) {
+				erpcqr = erpcqr->refers;
+			}
+			if (erpcqr == eer->cqr) {
+				erp_fn = device->discipline->erp_postaction(
+					 cqr);
+				erp_fn(cqr);
+			}
+			continue;
+		}
+	}
+	spin_unlock_irq(get_ccwdev_lock(device->cdev));
+}
+
+/*
+ * This function dismantles a struct dasd_eer that was created by
+ * dasd_eer_probe. Since we want to free our private data structure,
+ * we must make sure that the memory is not in use anymore.
+ * We have to flush the work queue and remove a possible SNSS request
+ * from the dasd queue.
+ */
+static void
+dasd_eer_destroy(struct dasd_device *device, struct dasd_eer_private *eer)
+{
+	flush_workqueue(dasd_eer_workqueue);
+	dasd_eer_dequeue_SNSS_request(device, eer);
+	dasd_kfree_request(eer->cqr, device);
+	kfree(eer);
+};
+
+/*
+ * enable the extended error reporting for a particular device
+ */
+static int
+dasd_eer_enable_on_device(struct dasd_device *device)
+{
+	void *eer;
+	if (!device)
+		return -ENODEV;
+	if (device->eer)
+		return 0;
+	if (!try_module_get(THIS_MODULE)) {
+		return -EINVAL;
+	}
+	eer = (void *)dasd_eer_probe(device);
+	if (IS_ERR(eer)) {
+		module_put(THIS_MODULE);
+		return PTR_ERR(eer);
+	}
+	device->eer = eer;
+	return 0;
+}
+
+/*
+ * enable the extended error reporting for a particular device
+ */
+static int
+dasd_eer_disable_on_device(struct dasd_device *device)
+{
+	struct dasd_eer_private *eer = device->eer;
+
+	if (!device)
+		return -ENODEV;
+	if (!device->eer)
+		return 0;
+	device->eer = NULL;
+	dasd_eer_destroy(device,eer);
+	module_put(THIS_MODULE);
+
+	return 0;
+}
+
+/*
+ * Set extended error reporting (eer)
+ * Note: This will be registered as a DASD ioctl, to be called on DASD devices.
+ */
+static int
+dasd_ioctl_set_eer(struct block_device *bdev, int no, long args)
+{
+	struct dasd_device *device;
+	int intval;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (bdev != bdev->bd_contains)
+		/* Error-reporting is not allowed for partitions */
+		return -EINVAL;
+	if (get_user(intval, (int __user *) args))
+		return -EFAULT;
+	device =  bdev->bd_disk->private_data;
+	if (device == NULL)
+		return -ENODEV;
+
+	intval = (intval != 0);
+	DEV_MESSAGE (KERN_DEBUG, device,
+		     "set eer on device to %d", intval);
+	if (intval)
+		return dasd_eer_enable_on_device(device);
+	else
+		return dasd_eer_disable_on_device(device);
+}
+
+/*
+ * Get value of extended error reporting.
+ * Note: This will be registered as a DASD ioctl, to be called on DASD devices.
+ */
+static int
+dasd_ioctl_get_eer(struct block_device *bdev, int no, long args)
+{
+	struct dasd_device *device;
+
+	device =  bdev->bd_disk->private_data;
+	if (device == NULL)
+		return -ENODEV;
+	return put_user((device->eer != NULL), (int __user *) args);
+}
+
+/*
+ * The following function can be used for those triggers that have
+ * all necessary data available when the function is called.
+ * If the parameter cqr is not NULL, the chain of requests will be searched
+ * for valid sense data, and all valid sense data sets will be added to
+ * the triggers data.
+ */
+static int
+dasd_eer_write_standard_trigger(int trigger, struct dasd_device *device,
+				struct dasd_ccw_req *cqr)
+{
+	struct dasd_ccw_req *temp_cqr;
+	int data_size;
+	struct timeval tv;
+	struct dasd_eer_header header;
+	unsigned long flags;
+	struct eerbuffer *eerb;
+
+	/* go through cqr chain and count the valid sense data sets */
+	temp_cqr = cqr;
+	data_size = 0;
+	while (temp_cqr) {
+		if (temp_cqr->irb.esw.esw0.erw.cons)
+			data_size += 32;
+		temp_cqr = temp_cqr->refers;
+	}
+
+	header.total_size = sizeof(header) + data_size + 4; /* "EOR" */
+	header.trigger = trigger;
+	do_gettimeofday(&tv);
+	header.tv_sec = tv.tv_sec;
+	header.tv_usec = tv.tv_usec;
+	strncpy(header.busid, device->cdev->dev.bus_id, DASD_EER_BUSID_SIZE);
+
+	spin_lock_irqsave(&bufferlock, flags);
+	list_for_each_entry(eerb, &bufferlist, list) {
+		dasd_eer_start_record(eerb, header.total_size);
+		dasd_eer_write_buffer(eerb, sizeof(header), (char*)(&header));
+		temp_cqr = cqr;
+		while (temp_cqr) {
+			if (temp_cqr->irb.esw.esw0.erw.cons)
+				dasd_eer_write_buffer(eerb, 32, cqr->irb.ecw);
+			temp_cqr = temp_cqr->refers;
+		}
+		dasd_eer_write_buffer(eerb, 4,"EOR");
+	}
+	spin_unlock_irqrestore(&bufferlock, flags);
+
+	wake_up_interruptible(&dasd_eer_read_wait_queue);
+
+	return 0;
+}
+
+/*
+ * This function writes a DASD_EER_STATECHANGE trigger.
+ */
+static void
+dasd_eer_write_SNSS_trigger(struct dasd_device *device,
+			    struct dasd_ccw_req *cqr)
+{
+	int data_size;
+	int snss_rc;
+	struct timeval tv;
+	struct dasd_eer_header header;
+	unsigned long flags;
+	struct eerbuffer *eerb;
+
+	snss_rc = (cqr->status == DASD_CQR_FAILED) ? -EIO : 0;
+	if (snss_rc)
+		data_size = 0;
+	else
+		data_size = SNSS_DATA_SIZE;
+
+	header.total_size = sizeof(header) + data_size + 4; /* "EOR" */
+	header.trigger = DASD_EER_STATECHANGE;
+	do_gettimeofday(&tv);
+	header.tv_sec = tv.tv_sec;
+	header.tv_usec = tv.tv_usec;
+	strncpy(header.busid, device->cdev->dev.bus_id, DASD_EER_BUSID_SIZE);
+
+	spin_lock_irqsave(&bufferlock, flags);
+	list_for_each_entry(eerb, &bufferlist, list) {
+		dasd_eer_start_record(eerb, header.total_size);
+		dasd_eer_write_buffer(eerb, sizeof(header),(char*)(&header));
+		if (!snss_rc)
+			dasd_eer_write_buffer(eerb, SNSS_DATA_SIZE, cqr->data);
+		dasd_eer_write_buffer(eerb, 4,"EOR");
+	}
+	spin_unlock_irqrestore(&bufferlock, flags);
+
+	wake_up_interruptible(&dasd_eer_read_wait_queue);
+}
+
+/*
+ * callback function for use with SNSS request
+ */
+static void
+dasd_eer_SNSS_cb(struct dasd_ccw_req *cqr, void *data)
+{
+        struct dasd_device *device;
+	struct dasd_eer_private *private;
+	unsigned long irqflags;
+
+        device = (struct dasd_device *)data;
+	private = (struct dasd_eer_private *)device->eer;
+	dasd_eer_write_SNSS_trigger(device, cqr);
+	spin_lock_irqsave(&snsslock, irqflags);
+	if(!test_and_clear_bit(SNSS_REQUESTED, &private->flags)) {
+		clear_bit(CQR_IN_USE, &private->flags);
+		spin_unlock_irqrestore(&snsslock, irqflags);
+		return;
+	};
+	clear_bit(CQR_IN_USE, &private->flags);
+	spin_unlock_irqrestore(&snsslock, irqflags);
+	dasd_eer_sense_subsystem_status(device);
+	return;
+}
+
+/*
+ * clean a used cqr before using it again
+ */
+static void
+dasd_eer_clean_SNSS_request(struct dasd_ccw_req *cqr)
+{
+	struct ccw1 *cpaddr = cqr->cpaddr;
+	void *data = cqr->data;
+
+	memset(cqr, 0, sizeof(struct dasd_ccw_req));
+	memset(cpaddr, 0, sizeof(struct ccw1));
+	memset(data, 0, SNSS_DATA_SIZE);
+	cqr->cpaddr = cpaddr;
+	cqr->data = data;
+	strncpy((char *) &cqr->magic, "ECKD", 4);
+	ASCEBC((char *) &cqr->magic, 4);
+	set_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+}
+
+/*
+ * build and start an SNSS request
+ * This function is called from a work queue so we have to
+ * pass the dasd_device pointer as a void pointer.
+ */
+static void
+dasd_eer_sense_subsystem_status(void *data)
+{
+	struct dasd_device *device;
+	struct dasd_eer_private *private;
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+	unsigned long irqflags;
+
+	device = (struct dasd_device *)data;
+	private = (struct dasd_eer_private *)device->eer;
+	if (!private) /* device not eer enabled any more */
+		return;
+	cqr = private->cqr;
+	spin_lock_irqsave(&snsslock, irqflags);
+	if(test_and_set_bit(CQR_IN_USE, &private->flags)) {
+		set_bit(SNSS_REQUESTED, &private->flags);
+		spin_unlock_irqrestore(&snsslock, irqflags);
+		return;
+	};
+	spin_unlock_irqrestore(&snsslock, irqflags);
+	dasd_eer_clean_SNSS_request(cqr);
+	cqr->device = device;
+	cqr->retries = 0;
+	cqr->expires = 10 * HZ;
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_SNSS;
+	ccw->count = SNSS_DATA_SIZE;
+	ccw->flags = 0;
+	ccw->cda = (__u32)(addr_t)cqr->data;
+
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	cqr->callback = dasd_eer_SNSS_cb;
+	cqr->callback_data = (void *)device;
+        dasd_add_request_head(cqr);
+
+	return;
+}
+
+/*
+ * This function is called for all triggers. It calls the appropriate
+ * function that writes the actual trigger records.
+ */
+static int
+dasd_eer_write_trigger(struct dasd_eer_trigger *trigger)
+{
+	int rc;
+	struct dasd_eer_private *private = trigger->device->eer;
+
+	switch (trigger->id) {
+	case DASD_EER_FATALERROR:
+	case DASD_EER_PPRCSUSPEND:
+		rc = dasd_eer_write_standard_trigger(
+			trigger->id, trigger->device, trigger->cqr);
+		break;
+	case DASD_EER_NOPATH:
+		rc = dasd_eer_write_standard_trigger(
+			trigger->id, trigger->device, NULL);
+		break;
+	case DASD_EER_STATECHANGE:
+                if (queue_work(dasd_eer_workqueue, &private->worker)) {
+                        rc=0;
+                } else {
+                        /* If the work_struct was already queued, it can't
+                         * be queued again. But this is OK since we don't
+                         * need to have it queued twice.
+                         */
+                        rc = -EBUSY;
+                }
+		break;
+	default: /* unknown trigger, so we write it without any sense data */
+		rc = dasd_eer_write_standard_trigger(
+			trigger->id, trigger->device, NULL);
+		break;
+	}
+	return rc;
+}
+
+/*
+ * This function is registered with the dasd device driver and gets called
+ * for all dasd eer notifications.
+ */
+static int dasd_eer_notify(struct notifier_block *self,
+			    unsigned long action, void *data)
+{
+	switch (action) {
+	case DASD_EER_DISABLE:
+		dasd_eer_disable_on_device((struct dasd_device *)data);
+		break;
+	case DASD_EER_TRIGGER:
+		dasd_eer_write_trigger((struct dasd_eer_trigger *)data);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+
+/*****************************************************************************/
+/*      the device operations                                                */
+/*****************************************************************************/
+
+/*
+ * On the one side we need a lock to access our internal buffer, on the
+ * other side a copy_to_user can sleep. So we need to copy the data we have
+ * to transfer in a readbuffer, which is protected by the readbuffer_mutex.
+ */
+static char readbuffer[PAGE_SIZE];
+DECLARE_MUTEX(readbuffer_mutex);
+
+
+static int
+dasd_eer_open(struct inode *inp, struct file *filp)
+{
+	struct eerbuffer *eerb;
+	unsigned long flags;
+
+	eerb = kmalloc(sizeof(struct eerbuffer), GFP_KERNEL);
+	eerb->head = 0;
+	eerb->tail = 0;
+	eerb->residual = 0;
+	eerb->buffer_page_count = 1;
+	eerb->buffersize = eerb->buffer_page_count * PAGE_SIZE;
+        eerb->buffer = kmalloc(eerb->buffer_page_count*sizeof(char*),
+			       GFP_KERNEL);
+        if (!eerb->buffer)
+                return -ENOMEM;
+	if (dasd_eer_allocate_buffer_pages(eerb->buffer,
+					   eerb->buffer_page_count)) {
+		kfree(eerb->buffer);
+		return -ENOMEM;
+	}
+	filp->private_data = eerb;
+	spin_lock_irqsave(&bufferlock, flags);
+	list_add(&eerb->list, &bufferlist);
+	spin_unlock_irqrestore(&bufferlock, flags);
+
+	return nonseekable_open(inp,filp);
+}
+
+static int
+dasd_eer_close(struct inode *inp, struct file *filp)
+{
+	struct eerbuffer *eerb;
+	unsigned long flags;
+
+	eerb = (struct eerbuffer *)filp->private_data;
+	spin_lock_irqsave(&bufferlock, flags);
+	list_del(&eerb->list);
+	spin_unlock_irqrestore(&bufferlock, flags);
+	dasd_eer_free_buffer_pages(eerb->buffer, eerb->buffer_page_count);
+	kfree(eerb->buffer);
+	kfree(eerb);
+
+	return 0;
+}
+
+static long
+dasd_eer_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	int intval;
+	struct eerbuffer *eerb;
+
+	eerb = (struct eerbuffer *)filp->private_data;
+	switch (cmd) {
+	case DASD_EER_PURGE:
+		dasd_eer_purge_buffer(eerb);
+		return 0;
+	case DASD_EER_SETBUFSIZE:
+		if (get_user(intval, (int __user *)arg))
+			return -EFAULT;
+		return dasd_eer_resize_buffer(eerb, intval);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static ssize_t
+dasd_eer_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
+{
+	int tc,rc;
+	int tailcount,effective_count;
+        unsigned long flags;
+	struct eerbuffer *eerb;
+
+	eerb = (struct eerbuffer *)filp->private_data;
+	if(down_interruptible(&readbuffer_mutex))
+		return -ERESTARTSYS;
+
+	spin_lock_irqsave(&bufferlock, flags);
+
+	if (eerb->residual < 0) { /* the remainder of this record */
+		                  /* has been deleted             */
+		eerb->residual = 0;
+		spin_unlock_irqrestore(&bufferlock, flags);
+		up(&readbuffer_mutex);
+		return -EIO;
+	} else if (eerb->residual > 0) {
+		/* OK we still have a second half of a record to deliver */
+		effective_count = min(eerb->residual, (int)count);
+		eerb->residual -= effective_count;
+	} else {
+		tc = 0;
+		while (!tc) {
+			tc = dasd_eer_read_buffer(eerb,
+				sizeof(tailcount), (char*)(&tailcount));
+			if (!tc) {
+				/* no data available */
+				spin_unlock_irqrestore(&bufferlock, flags);
+				up(&readbuffer_mutex);
+				if (filp->f_flags & O_NONBLOCK)
+					return -EAGAIN;
+				rc = wait_event_interruptible(
+					dasd_eer_read_wait_queue,
+					eerb->head != eerb->tail);
+				if (rc) {
+					return rc;
+				}
+				if(down_interruptible(&readbuffer_mutex))
+					return -ERESTARTSYS;
+				spin_lock_irqsave(&bufferlock, flags);
+			}
+		}
+		WARN_ON(tc != sizeof(tailcount));
+		effective_count = min(tailcount,(int)count);
+		eerb->residual = tailcount - effective_count;
+	}
+
+	tc = dasd_eer_read_buffer(eerb, effective_count, readbuffer);
+	WARN_ON(tc != effective_count);
+
+	spin_unlock_irqrestore(&bufferlock, flags);
+
+	if (copy_to_user(buf, readbuffer, effective_count)) {
+		up(&readbuffer_mutex);
+		return -EFAULT;
+	}
+
+	up(&readbuffer_mutex);
+	return effective_count;
+}
+
+static unsigned int
+dasd_eer_poll (struct file *filp, poll_table *ptable)
+{
+	unsigned int mask;
+	unsigned long flags;
+	struct eerbuffer *eerb;
+
+	eerb = (struct eerbuffer *)filp->private_data;
+	poll_wait(filp, &dasd_eer_read_wait_queue, ptable);
+	spin_lock_irqsave(&bufferlock, flags);
+	if (eerb->head != eerb->tail)
+		mask = POLLIN | POLLRDNORM ;
+	else
+		mask = 0;
+	spin_unlock_irqrestore(&bufferlock, flags);
+	return mask;
+}
+
+static struct file_operations dasd_eer_fops = {
+	.open		= &dasd_eer_open,
+	.release	= &dasd_eer_close,
+	.unlocked_ioctl = &dasd_eer_ioctl,
+	.compat_ioctl	= &dasd_eer_ioctl,
+	.read		= &dasd_eer_read,
+	.poll		= &dasd_eer_poll,
+	.owner		= THIS_MODULE,
+};
+
+static struct miscdevice dasd_eer_dev = {
+	.minor	    = MISC_DYNAMIC_MINOR,
+	.name	    = "dasd_eer",
+	.fops	    = &dasd_eer_fops,
+};
+
+
+/*****************************************************************************/
+/*	Init and exit							     */
+/*****************************************************************************/
+
+static int
+__init dasd_eer_init(void)
+{
+	int rc;
+
+	dasd_eer_workqueue = create_singlethread_workqueue("dasd_eer");
+	if (!dasd_eer_workqueue) {
+		MESSAGE(KERN_ERR , "%s", "dasd_eer_init could not "
+		       "create workqueue \n");
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = dasd_register_eer_notifier(&dasd_eer_nb);
+	if (rc) {
+		MESSAGE(KERN_ERR, "%s", "dasd_eer_init could not "
+		       "register error reporting");
+		goto queue;
+	}
+
+	dasd_ioctl_no_register(THIS_MODULE, BIODASDEERSET, dasd_ioctl_set_eer);
+	dasd_ioctl_no_register(THIS_MODULE, BIODASDEERGET, dasd_ioctl_get_eer);
+
+	/* we don't need our own character device,
+	 * so we just register as misc device */
+	rc = misc_register(&dasd_eer_dev);
+	if (rc) {
+		MESSAGE(KERN_ERR, "%s", "dasd_eer_init could not "
+		       "register misc device");
+		goto unregister;
+	}
+
+	return 0;
+
+unregister:
+	dasd_unregister_eer_notifier(&dasd_eer_nb);
+	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDEERSET,
+				 dasd_ioctl_set_eer);
+	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDEERGET,
+				 dasd_ioctl_get_eer);
+queue:
+	destroy_workqueue(dasd_eer_workqueue);
+out:
+	return rc;
+
+}
+module_init(dasd_eer_init);
+
+static void
+__exit dasd_eer_exit(void)
+{
+	dasd_unregister_eer_notifier(&dasd_eer_nb);
+	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDEERSET,
+				 dasd_ioctl_set_eer);
+	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDEERGET,
+				 dasd_ioctl_get_eer);
+	destroy_workqueue(dasd_eer_workqueue);
+
+	WARN_ON(misc_deregister(&dasd_eer_dev) != 0);
+}
+module_exit(dasd_eer_exit);
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2005-12-16 10:57:09.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2005-12-16 10:57:24.000000000 +0100
@@ -276,6 +276,34 @@ struct dasd_discipline {
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
 
+
+/*
+ * Notification numbers for extended error reporting notifications:
+ * The DASD_EER_DISABLE notification is sent before a dasd_device (and it's
+ * eer pointer) is freed. The error reporting module needs to do all necessary
+ * cleanup steps.
+ * The DASD_EER_TRIGGER notification sends the actual error reports (triggers).
+ */
+#define DASD_EER_DISABLE 0
+#define DASD_EER_TRIGGER 1
+
+/* Trigger IDs for extended error reporting DASD_EER_TRIGGER notification */
+#define DASD_EER_FATALERROR  1
+#define DASD_EER_NOPATH      2
+#define DASD_EER_STATECHANGE 3
+#define DASD_EER_PPRCSUSPEND 4
+
+/*
+ * The dasd_eer_trigger structure contains all data that we need to send
+ * along with an DASD_EER_TRIGGER notification.
+ */
+struct dasd_eer_trigger {
+	unsigned int id;
+	struct dasd_device *device;
+	struct dasd_ccw_req *cqr;
+};
+
+
 struct dasd_device {
 	/* Block device stuff. */
 	struct gendisk *gdp;
@@ -289,6 +317,9 @@ struct dasd_device {
 	unsigned long flags;		/* per device flags */
 	unsigned short features;        /* copy of devmap-features (read-only!) */
 
+	/* extended error reporting stuff (eer) */
+	void *eer;
+
 	/* Device discipline stuff. */
 	struct dasd_discipline *discipline;
 	char *private;
@@ -489,6 +520,12 @@ int dasd_generic_set_online(struct ccw_d
 int dasd_generic_set_offline (struct ccw_device *cdev);
 int dasd_generic_notify(struct ccw_device *, int);
 void dasd_generic_auto_online (struct ccw_driver *);
+int dasd_register_eer_notifier(struct notifier_block *);
+int dasd_unregister_eer_notifier(struct notifier_block *);
+void dasd_write_eer_trigger(unsigned int , struct dasd_device *,
+			struct dasd_ccw_req *);
+
+
 
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
diff -urpN linux-2.6/drivers/s390/block/Kconfig linux-2.6-patched/drivers/s390/block/Kconfig
--- linux-2.6/drivers/s390/block/Kconfig	2005-12-16 10:57:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/Kconfig	2005-12-16 10:57:24.000000000 +0100
@@ -55,13 +55,21 @@ config DASD_DIAG
 	  Disks under VM.  If you are not running under VM or unsure what it is,
 	  say "N".
 
+config DASD_EER
+	tristate "Extended error reporting (EER)"
+	depends on DASD
+	help
+	  This driver provides a character device interface to the
+          DASD extended error reporting. This is only needed if you want to
+          use applications written for the EER facility.
+
 config DASD_CMB
 	tristate "Compatibility interface for DASD channel measurement blocks"
 	depends on DASD
 	help
-	  This driver provides an additional interface to the channel measurement
-	  facility, which is normally accessed though sysfs, with a set of
-	  ioctl functions specific to the dasd driver.
+	  This driver provides an additional interface to the channel
+          measurement facility, which is normally accessed though sysfs, with
+          a set of ioctl functions specific to the dasd driver.
 	  This is only needed if you want to use applications written for
 	  linux-2.4 dasd channel measurement facility interface.
 
diff -urpN linux-2.6/drivers/s390/block/Makefile linux-2.6-patched/drivers/s390/block/Makefile
--- linux-2.6/drivers/s390/block/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/Makefile	2005-12-16 10:57:24.000000000 +0100
@@ -5,6 +5,7 @@
 dasd_eckd_mod-objs := dasd_eckd.o dasd_3990_erp.o dasd_9343_erp.o
 dasd_fba_mod-objs  := dasd_fba.o dasd_3370_erp.o dasd_9336_erp.o
 dasd_diag_mod-objs := dasd_diag.o
+dasd_eer_mod-objs := dasd_eer.o
 dasd_mod-objs      := dasd.o dasd_ioctl.o dasd_proc.o dasd_devmap.o \
 			dasd_genhd.o dasd_erp.o
 
@@ -13,5 +14,6 @@ obj-$(CONFIG_DASD_DIAG) += dasd_diag_mod
 obj-$(CONFIG_DASD_ECKD) += dasd_eckd_mod.o
 obj-$(CONFIG_DASD_FBA)  += dasd_fba_mod.o
 obj-$(CONFIG_DASD_CMB)  += dasd_cmb.o
+obj-$(CONFIG_DASD_EER)  += dasd_eer.o
 obj-$(CONFIG_BLK_DEV_XPRAM) += xpram.o
 obj-$(CONFIG_DCSSBLK) += dcssblk.o
diff -urpN linux-2.6/include/asm-s390/dasd.h linux-2.6-patched/include/asm-s390/dasd.h
--- linux-2.6/include/asm-s390/dasd.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/dasd.h	2005-12-16 10:57:24.000000000 +0100
@@ -8,7 +8,7 @@
  * any future changes wrt the API will result in a change of the APIVERSION reported
  * to userspace by the DASDAPIVER-ioctl
  *
- * $Revision: 1.6 $
+ * $Revision: 1.7 $
  *
  */
 
@@ -206,7 +206,8 @@ typedef struct attrib_data_t {
  *
  * Here ist how the ioctl-nr should be used:
  *    0 -   31   DASD driver itself
- *   32 -  239   still open
+ *   32 -  229   still open
+ *  230 -  239   DASD extended error reporting
  *  240 -  255   reserved for EMC 
  *******************************************************************************/
 
@@ -238,12 +239,22 @@ typedef struct attrib_data_t {
 #define BIODASDPSRD    _IOR(DASD_IOCTL_LETTER,4,dasd_rssd_perf_stats_t)
 /* Get Attributes (cache operations) */
 #define BIODASDGATTR   _IOR(DASD_IOCTL_LETTER,5,attrib_data_t) 
+/* retrieve extended error-reporting value */
+#define BIODASDEERGET  _IOR(DASD_IOCTL_LETTER,6,int)
 
 
 /* #define BIODASDFORMAT  _IOW(IOCTL_LETTER,0,format_data_t) , deprecated */
 #define BIODASDFMT     _IOW(DASD_IOCTL_LETTER,1,format_data_t) 
 /* Set Attributes (cache operations) */
 #define BIODASDSATTR   _IOW(DASD_IOCTL_LETTER,2,attrib_data_t) 
+/* retrieve extended error-reporting value */
+#define BIODASDEERSET  _IOW(DASD_IOCTL_LETTER,3,int)
+
+
+/* remove all records from the eer buffer */
+#define DASD_EER_PURGE       _IO(DASD_IOCTL_LETTER,230)
+/* set the number of pages that are used for the internal eer buffer */
+#define DASD_EER_SETBUFSIZE  _IOW(DASD_IOCTL_LETTER,230,int)
 
 
 #endif				/* DASD_H */

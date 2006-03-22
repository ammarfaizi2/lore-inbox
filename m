Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWCVPXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWCVPXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWCVPXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:23:49 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:41349 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751295AbWCVPXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:23:46 -0500
Date: Wed, 22 Mar 2006 16:24:13 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, wein@de.ibm.com, linux-kernel@vger.kernel.org
Cc: horst.hummel@de.ibm.com, hch@lst.de
Subject: [patch 16/24] s390: dasd extended error reporting.
Message-ID: <20060322152413.GP5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Weinhuber <wein@de.ibm.com>

[patch 16/24] s390: dasd extended error reporting.

The DASD extended error reporting is a facility that allows to
get detailed information about certain problems in the DASD I/O.
This information can be used to implement fail-over applications
that can recover these problems.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/Kconfig         |    8 
 drivers/s390/block/Makefile        |    3 
 drivers/s390/block/dasd.c          |   29 +
 drivers/s390/block/dasd_3990_erp.c |    3 
 drivers/s390/block/dasd_devmap.c   |   41 ++
 drivers/s390/block/dasd_eckd.h     |    1 
 drivers/s390/block/dasd_eer.c      |  682 +++++++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_int.h      |   46 ++
 8 files changed, 812 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_3990_erp.c linux-2.6-patched/drivers/s390/block/dasd_3990_erp.c
--- linux-2.6/drivers/s390/block/dasd_3990_erp.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_3990_erp.c	2006-03-22 14:36:28.000000000 +0100
@@ -1108,6 +1108,9 @@ dasd_3990_handle_env_data(struct dasd_cc
 		case 0x0B:
 			DEV_MESSAGE(KERN_WARNING, device, "%s",
 				    "FORMAT F - Volume is suspended duplex");
+			/* call extended error reporting (EER) */
+			dasd_eer_write(device, erp->refers,
+				       DASD_EER_PPRCSUSPEND);
 			break;
 		case 0x0C:
 			DEV_MESSAGE(KERN_WARNING, device, "%s",
diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-03-22 14:36:20.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-03-22 14:36:28.000000000 +0100
@@ -151,6 +151,8 @@ dasd_state_new_to_known(struct dasd_devi
 static inline void
 dasd_state_known_to_new(struct dasd_device * device)
 {
+	/* Disable extended error reporting for this device. */
+	dasd_eer_disable(device);
 	/* Forget the discipline information. */
 	if (device->discipline)
 		module_put(device->discipline->owner);
@@ -892,6 +894,9 @@ dasd_handle_state_change_pending(struct 
 	struct dasd_ccw_req *cqr;
 	struct list_head *l, *n;
 
+	/* First of all start sense subsystem status request. */
+	dasd_eer_snss(device);
+
 	device->stopped &= ~DASD_STOPPED_PENDING;
 
         /* restart all 'running' IO on queue */
@@ -1111,6 +1116,19 @@ restart:
 			}
 			goto restart;
 		}
+
+		/* First of all call extended error reporting. */
+		if (dasd_eer_enabled(device) &&
+		    cqr->status == DASD_CQR_FAILED) {
+			dasd_eer_write(device, cqr, DASD_EER_FATALERROR);
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
@@ -1248,7 +1266,8 @@ __dasd_start_head(struct dasd_device * d
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, list);
         /* check FAILFAST */
 	if (device->stopped & ~DASD_STOPPED_PENDING &&
-	    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags)) {
+	    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
+	    (!dasd_eer_enabled(device))) {
 		cqr->status = DASD_CQR_FAILED;
 		dasd_schedule_bh(device);
 	}
@@ -1807,6 +1826,7 @@ dasd_exit(void)
 #ifdef CONFIG_PROC_FS
 	dasd_proc_exit();
 #endif
+	dasd_eer_exit();
         if (dasd_page_cache != NULL) {
 		kmem_cache_destroy(dasd_page_cache);
 		dasd_page_cache = NULL;
@@ -2003,6 +2023,9 @@ dasd_generic_notify(struct ccw_device *c
 	switch (event) {
 	case CIO_GONE:
 	case CIO_NO_PATH:
+		/* First of all call extended error reporting. */
+		dasd_eer_write(device, NULL, DASD_EER_NOPATH);
+
 		if (device->state < DASD_STATE_BASIC)
 			break;
 		/* Device is active. We want to keep it. */
@@ -2060,6 +2083,7 @@ dasd_generic_auto_online (struct ccw_dri
 	put_driver(drv);
 }
 
+
 static int __init
 dasd_init(void)
 {
@@ -2092,6 +2116,9 @@ dasd_init(void)
 	rc = dasd_parse();
 	if (rc)
 		goto failed;
+	rc = dasd_eer_init();
+	if (rc)
+		goto failed;
 #ifdef CONFIG_PROC_FS
 	rc = dasd_proc_init();
 	if (rc)
diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-03-22 14:36:28.000000000 +0100
@@ -715,10 +715,51 @@ dasd_discipline_show(struct device *dev,
 
 static DEVICE_ATTR(discipline, 0444, dasd_discipline_show, NULL);
 
+/*
+ * extended error-reporting
+ */
+static ssize_t
+dasd_eer_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dasd_devmap *devmap;
+	int eer_flag;
+
+	devmap = dasd_find_busid(dev->bus_id);
+	if (!IS_ERR(devmap) && devmap->device)
+		eer_flag = dasd_eer_enabled(devmap->device);
+	else
+		eer_flag = 0;
+	return snprintf(buf, PAGE_SIZE, eer_flag ? "1\n" : "0\n");
+}
+
+static ssize_t
+dasd_eer_store(struct device *dev, struct device_attribute *attr,
+	       const char *buf, size_t count)
+{
+	struct dasd_devmap *devmap;
+	int rc;
+
+	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(devmap))
+		return PTR_ERR(devmap);
+	if (!devmap->device)
+		return count;
+	if (buf[0] == '1') {
+		rc = dasd_eer_enable(devmap->device);
+		if (rc)
+			return rc;
+	} else
+		dasd_eer_disable(devmap->device);
+	return count;
+}
+
+static DEVICE_ATTR(eer_enabled, 0644, dasd_eer_show, dasd_eer_store);
+
 static struct attribute * dasd_attrs[] = {
 	&dev_attr_readonly.attr,
 	&dev_attr_discipline.attr,
 	&dev_attr_use_diag.attr,
+	&dev_attr_eer_enabled.attr,
 	NULL,
 };
 
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.h linux-2.6-patched/drivers/s390/block/dasd_eckd.h
--- linux-2.6/drivers/s390/block/dasd_eckd.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.h	2006-03-22 14:36:28.000000000 +0100
@@ -29,6 +29,7 @@
 #define DASD_ECKD_CCW_PSF		 0x27
 #define DASD_ECKD_CCW_RSSD		 0x3e
 #define DASD_ECKD_CCW_LOCATE_RECORD	 0x47
+#define DASD_ECKD_CCW_SNSS		 0x54
 #define DASD_ECKD_CCW_DEFINE_EXTENT	 0x63
 #define DASD_ECKD_CCW_WRITE_MT		 0x85
 #define DASD_ECKD_CCW_READ_MT		 0x86
diff -urpN linux-2.6/drivers/s390/block/dasd_eer.c linux-2.6-patched/drivers/s390/block/dasd_eer.c
--- linux-2.6/drivers/s390/block/dasd_eer.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_eer.c	2006-03-22 14:36:28.000000000 +0100
@@ -0,0 +1,682 @@
+/*
+ *  Character device driver for extended error reporting.
+ *
+ *  Copyright (C) 2005 IBM Corporation
+ *  extended error reporting for DASD ECKD devices
+ *  Author(s): Stefan Weinhuber <wein@de.ibm.com>
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/poll.h>
+
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+#include <asm/atomic.h>
+#include <asm/ebcdic.h>
+
+#include "dasd_int.h"
+#include "dasd_eckd.h"
+
+#ifdef PRINTK_HEADER
+#undef PRINTK_HEADER
+#endif				/* PRINTK_HEADER */
+#define PRINTK_HEADER "dasd(eer):"
+
+/*
+ * SECTION: the internal buffer
+ */
+
+/*
+ * The internal buffer is meant to store obaque blobs of data, so it does
+ * not know of higher level concepts like triggers.
+ * It consists of a number of pages that are used as a ringbuffer. Each data
+ * blob is stored in a simple record that consists of an integer, which
+ * contains the size of the following data, and the data bytes themselfes.
+ *
+ * To allow for multiple independent readers we create one internal buffer
+ * each time the device is opened and destroy the buffer when the file is
+ * closed again. The number of pages used for this buffer is determined by
+ * the module parmeter eer_pages.
+ *
+ * One record can be written to a buffer by using the functions
+ * - dasd_eer_start_record (one time per record to write the size to the
+ *                          buffer and reserve the space for the data)
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
+ * For all mentioned functions you need to get the bufferlock first and keep
+ * it until a complete record is written or read.
+ *
+ * All information necessary to keep track of an internal buffer is kept in
+ * a struct eerbuffer. The buffer specific to a file pointer is strored in
+ * the private_data field of that file. To be able to write data to all
+ * existing buffers, each buffer is also added to the bufferlist.
+ * If the user does not want to read a complete record in one go, we have to
+ * keep track of the rest of the record. residual stores the number of bytes
+ * that are still to deliver. If the rest of the record is invalidated between
+ * two reads then residual will be set to -1 so that the next read will fail.
+ * All entries in the eerbuffer structure are protected with the bufferlock.
+ * To avoid races between writing to a buffer on the one side and creating
+ * and destroying buffers on the other side, the bufferlock must also be used
+ * to protect the bufferlist.
+ */
+
+static int eer_pages = 5;
+module_param(eer_pages, int, S_IRUGO|S_IWUSR);
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
+static LIST_HEAD(bufferlist);
+static spinlock_t bufferlock = SPIN_LOCK_UNLOCKED;
+static DECLARE_WAIT_QUEUE_HEAD(dasd_eer_read_wait_queue);
+
+/*
+ * How many free bytes are available on the buffer.
+ * Needs to be called with bufferlock held.
+ */
+static int dasd_eer_get_free_bytes(struct eerbuffer *eerb)
+{
+	if (eerb->head < eerb->tail)
+		return eerb->tail - eerb->head - 1;
+	return eerb->buffersize - eerb->head + eerb->tail -1;
+}
+
+/*
+ * How many bytes of buffer space are used.
+ * Needs to be called with bufferlock held.
+ */
+static int dasd_eer_get_filled_bytes(struct eerbuffer *eerb)
+{
+
+	if (eerb->head >= eerb->tail)
+		return eerb->head - eerb->tail;
+	return eerb->buffersize - eerb->tail + eerb->head;
+}
+
+/*
+ * The dasd_eer_write_buffer function just copies count bytes of data
+ * to the buffer. Make sure to call dasd_eer_start_record first, to
+ * make sure that enough free space is available.
+ * Needs to be called with bufferlock held.
+ */
+static void dasd_eer_write_buffer(struct eerbuffer *eerb,
+				  char *data, int count)
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
+		len = min(rest, PAGE_SIZE - localhead);
+		memcpy(eerb->buffer[headindex]+localhead, nextdata, len);
+		nextdata += len;
+		rest -= len;
+		eerb->head += len;
+		if (eerb->head == eerb->buffersize)
+			eerb->head = 0; /* wrap around */
+		BUG_ON(eerb->head > eerb->buffersize);
+	}
+}
+
+/*
+ * Needs to be called with bufferlock held.
+ */
+static int dasd_eer_read_buffer(struct eerbuffer *eerb, char *data, int count)
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
+		len = min(rest, PAGE_SIZE - localtail);
+		memcpy(nextdata, eerb->buffer[tailindex] + localtail, len);
+		nextdata += len;
+		rest -= len;
+		eerb->tail += len;
+		if (eerb->tail == eerb->buffersize)
+			eerb->tail = 0; /* wrap around */
+		BUG_ON(eerb->tail > eerb->buffersize);
+	}
+	return finalcount;
+}
+
+/*
+ * Whenever you want to write a blob of data to the internal buffer you
+ * have to start by using this function first. It will write the number
+ * of bytes that will be written to the buffer. If necessary it will remove
+ * old records to make room for the new one.
+ * Needs to be called with bufferlock held.
+ */
+static int dasd_eer_start_record(struct eerbuffer *eerb, int count)
+{
+	int tailcount;
+
+	if (count + sizeof(count) > eerb->buffersize)
+		return -ENOMEM;
+	while (dasd_eer_get_free_bytes(eerb) < count + sizeof(count)) {
+		if (eerb->residual > 0) {
+			eerb->tail += eerb->residual;
+			if (eerb->tail >= eerb->buffersize)
+				eerb->tail -= eerb->buffersize;
+			eerb->residual = -1;
+		}
+		dasd_eer_read_buffer(eerb, (char *) &tailcount,
+				     sizeof(tailcount));
+		eerb->tail += tailcount;
+		if (eerb->tail >= eerb->buffersize)
+			eerb->tail -= eerb->buffersize;
+	}
+	dasd_eer_write_buffer(eerb, (char*) &count, sizeof(count));
+
+	return 0;
+};
+
+/*
+ * Release pages that are not used anymore.
+ */
+static void dasd_eer_free_buffer_pages(char **buf, int no_pages)
+{
+	int i;
+
+	for (i = 0; i < no_pages; i++)
+		free_page((unsigned long) buf[i]);
+}
+
+/*
+ * Allocate a new set of memory pages.
+ */
+static int dasd_eer_allocate_buffer_pages(char **buf, int no_pages)
+{
+	int i;
+
+	for (i = 0; i < no_pages; i++) {
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
+ * SECTION: The extended error reporting functionality
+ */
+
+/*
+ * When a DASD device driver wants to report an error, it calls the
+ * function dasd_eer_write and gives the respective trigger ID as
+ * parameter. Currently there are four kinds of triggers:
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
+ * The DASD_EER_STATECHANGE trigger is special since a sense subsystem
+ * status ccw need to be executed to gather the necessary sense data first.
+ * The dasd_eer_snss function will queue the SNSS request and the request
+ * callback will then call dasd_eer_write with the DASD_EER_STATCHANGE
+ * trigger.
+ *
+ * To avoid memory allocations at runtime, the necessary memory is allocated
+ * when the extended error reporting is enabled for a device (by
+ * dasd_eer_probe). There is one sense subsystem status request for each
+ * eer enabled DASD device. The presence of the cqr in device->eer_cqr
+ * indicates that eer is enable for the device. The use of the snss request
+ * is protected by the DASD_FLAG_EER_IN_USE bit. When this flag indicates
+ * that the cqr is currently in use, dasd_eer_snss cannot start a second
+ * request but sets the DASD_FLAG_EER_SNSS flag instead. The callback of
+ * the SNSS request will check the bit and call dasd_eer_snss again.
+ */
+
+#define SNSS_DATA_SIZE 44
+
+#define DASD_EER_BUSID_SIZE 10
+struct dasd_eer_header {
+	__u32 total_size;
+	__u32 trigger;
+	__u64 tv_sec;
+	__u64 tv_usec;
+	char busid[DASD_EER_BUSID_SIZE];
+};
+
+/*
+ * The following function can be used for those triggers that have
+ * all necessary data available when the function is called.
+ * If the parameter cqr is not NULL, the chain of requests will be searched
+ * for valid sense data, and all valid sense data sets will be added to
+ * the triggers data.
+ */
+static void dasd_eer_write_standard_trigger(struct dasd_device *device,
+					    struct dasd_ccw_req *cqr,
+					    int trigger)
+{
+	struct dasd_ccw_req *temp_cqr;
+	int data_size;
+	struct timeval tv;
+	struct dasd_eer_header header;
+	unsigned long flags;
+	struct eerbuffer *eerb;
+
+	/* go through cqr chain and count the valid sense data sets */
+	data_size = 0;
+	for (temp_cqr = cqr; temp_cqr; temp_cqr = temp_cqr->refers)
+		if (temp_cqr->irb.esw.esw0.erw.cons)
+			data_size += 32;
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
+		dasd_eer_write_buffer(eerb, (char *) &header, sizeof(header));
+		for (temp_cqr = cqr; temp_cqr; temp_cqr = temp_cqr->refers)
+			if (temp_cqr->irb.esw.esw0.erw.cons)
+				dasd_eer_write_buffer(eerb, cqr->irb.ecw, 32);
+		dasd_eer_write_buffer(eerb, "EOR", 4);
+	}
+	spin_unlock_irqrestore(&bufferlock, flags);
+	wake_up_interruptible(&dasd_eer_read_wait_queue);
+}
+
+/*
+ * This function writes a DASD_EER_STATECHANGE trigger.
+ */
+static void dasd_eer_write_snss_trigger(struct dasd_device *device,
+					struct dasd_ccw_req *cqr,
+					int trigger)
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
+		dasd_eer_write_buffer(eerb, (char *) &header , sizeof(header));
+		if (!snss_rc)
+			dasd_eer_write_buffer(eerb, cqr->data, SNSS_DATA_SIZE);
+		dasd_eer_write_buffer(eerb, "EOR", 4);
+	}
+	spin_unlock_irqrestore(&bufferlock, flags);
+	wake_up_interruptible(&dasd_eer_read_wait_queue);
+}
+
+/*
+ * This function is called for all triggers. It calls the appropriate
+ * function that writes the actual trigger records.
+ */
+void dasd_eer_write(struct dasd_device *device, struct dasd_ccw_req *cqr,
+		    unsigned int id)
+{
+	if (!device->eer_cqr)
+		return;
+	switch (id) {
+	case DASD_EER_FATALERROR:
+	case DASD_EER_PPRCSUSPEND:
+		dasd_eer_write_standard_trigger(device, cqr, id);
+		break;
+	case DASD_EER_NOPATH:
+		dasd_eer_write_standard_trigger(device, NULL, id);
+		break;
+	case DASD_EER_STATECHANGE:
+		dasd_eer_write_snss_trigger(device, cqr, id);
+		break;
+	default: /* unknown trigger, so we write it without any sense data */
+		dasd_eer_write_standard_trigger(device, NULL, id);
+		break;
+	}
+}
+EXPORT_SYMBOL(dasd_eer_write);
+
+/*
+ * Start a sense subsystem status request.
+ * Needs to be called with the device held.
+ */
+void dasd_eer_snss(struct dasd_device *device)
+{
+	struct dasd_ccw_req *cqr;
+
+	cqr = device->eer_cqr;
+	if (!cqr)	/* Device not eer enabled. */
+		return;
+	if (test_and_set_bit(DASD_FLAG_EER_IN_USE, &device->flags)) {
+		/* Sense subsystem status request in use. */
+		set_bit(DASD_FLAG_EER_SNSS, &device->flags);
+		return;
+	}
+	clear_bit(DASD_FLAG_EER_SNSS, &device->flags);
+	cqr->status = DASD_CQR_QUEUED;
+	list_add(&cqr->list, &device->ccw_queue);
+	dasd_schedule_bh(device);
+}
+
+/*
+ * Callback function for use with sense subsystem status request.
+ */
+static void dasd_eer_snss_cb(struct dasd_ccw_req *cqr, void *data)
+{
+        struct dasd_device *device = cqr->device;
+	unsigned long flags;
+
+	dasd_eer_write(device, cqr, DASD_EER_STATECHANGE);
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+	if (device->eer_cqr == cqr) {
+		clear_bit(DASD_FLAG_EER_IN_USE, &device->flags);
+		if (test_bit(DASD_FLAG_EER_SNSS, &device->flags))
+			/* Another SNSS has been requested in the meantime. */
+			dasd_eer_snss(device);
+		cqr = NULL;
+	}
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	if (cqr)
+		/*
+		 * Extended error recovery has been switched off while
+		 * the SNSS request was running. It could even have
+		 * been switched off and on again in which case there
+		 * is a new ccw in device->eer_cqr. Free the "old"
+		 * snss request now.
+		 */
+		dasd_kfree_request(cqr, device);
+}
+
+/*
+ * Enable error reporting on a given device.
+ */
+int dasd_eer_enable(struct dasd_device *device)
+{
+	struct dasd_ccw_req *cqr;
+	unsigned long flags;
+
+	if (device->eer_cqr)
+		return 0;
+
+	if (!device->discipline || strcmp(device->discipline->name, "ECKD"))
+		return -EPERM;	/* FIXME: -EMEDIUMTYPE ? */
+
+	cqr = dasd_kmalloc_request("ECKD", 1 /* SNSS */,
+				   SNSS_DATA_SIZE, device);
+	if (!cqr)
+		return -ENOMEM;
+
+	cqr->device = device;
+	cqr->retries = 255;
+	cqr->expires = 10 * HZ;
+
+	cqr->cpaddr->cmd_code = DASD_ECKD_CCW_SNSS;
+	cqr->cpaddr->count = SNSS_DATA_SIZE;
+	cqr->cpaddr->flags = 0;
+	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
+
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	cqr->callback = dasd_eer_snss_cb;
+
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+	if (!device->eer_cqr) {
+		device->eer_cqr = cqr;
+		cqr = NULL;
+	}
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	if (cqr)
+		dasd_kfree_request(cqr, device);
+	return 0;
+}
+
+/*
+ * Disable error reporting on a given device.
+ */
+void dasd_eer_disable(struct dasd_device *device)
+{
+	struct dasd_ccw_req *cqr;
+	unsigned long flags;
+	int in_use;
+
+	if (!device->eer_cqr)
+		return;
+	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
+	cqr = device->eer_cqr;
+	device->eer_cqr = NULL;
+	clear_bit(DASD_FLAG_EER_SNSS, &device->flags);
+	in_use = test_and_clear_bit(DASD_FLAG_EER_IN_USE, &device->flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
+	if (cqr && !in_use)
+		dasd_kfree_request(cqr, device);
+}
+
+/*
+ * SECTION: the device operations
+ */
+
+/*
+ * On the one side we need a lock to access our internal buffer, on the
+ * other side a copy_to_user can sleep. So we need to copy the data we have
+ * to transfer in a readbuffer, which is protected by the readbuffer_mutex.
+ */
+static char readbuffer[PAGE_SIZE];
+static DECLARE_MUTEX(readbuffer_mutex);
+
+static int dasd_eer_open(struct inode *inp, struct file *filp)
+{
+	struct eerbuffer *eerb;
+	unsigned long flags;
+
+	eerb = kzalloc(sizeof(struct eerbuffer), GFP_KERNEL);
+	eerb->buffer_page_count = eer_pages;
+	if (eerb->buffer_page_count < 1 ||
+	    eerb->buffer_page_count > INT_MAX / PAGE_SIZE) {
+		kfree(eerb);
+		MESSAGE(KERN_WARNING, "can't open device since module "
+			"parameter eer_pages is smaller then 1 or"
+			" bigger then %d", (int)(INT_MAX / PAGE_SIZE));
+		return -EINVAL;
+	}
+	eerb->buffersize = eerb->buffer_page_count * PAGE_SIZE;
+	eerb->buffer = kmalloc(eerb->buffer_page_count * sizeof(char *),
+			       GFP_KERNEL);
+        if (!eerb->buffer) {
+		kfree(eerb);
+                return -ENOMEM;
+	}
+	if (dasd_eer_allocate_buffer_pages(eerb->buffer,
+					   eerb->buffer_page_count)) {
+		kfree(eerb->buffer);
+		kfree(eerb);
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
+static int dasd_eer_close(struct inode *inp, struct file *filp)
+{
+	struct eerbuffer *eerb;
+	unsigned long flags;
+
+	eerb = (struct eerbuffer *) filp->private_data;
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
+static ssize_t dasd_eer_read(struct file *filp, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	int tc,rc;
+	int tailcount,effective_count;
+        unsigned long flags;
+	struct eerbuffer *eerb;
+
+	eerb = (struct eerbuffer *) filp->private_data;
+	if (down_interruptible(&readbuffer_mutex))
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
+		effective_count = min(eerb->residual, (int) count);
+		eerb->residual -= effective_count;
+	} else {
+		tc = 0;
+		while (!tc) {
+			tc = dasd_eer_read_buffer(eerb, (char *) &tailcount,
+						  sizeof(tailcount));
+			if (!tc) {
+				/* no data available */
+				spin_unlock_irqrestore(&bufferlock, flags);
+				up(&readbuffer_mutex);
+				if (filp->f_flags & O_NONBLOCK)
+					return -EAGAIN;
+				rc = wait_event_interruptible(
+					dasd_eer_read_wait_queue,
+					eerb->head != eerb->tail);
+				if (rc)
+					return rc;
+				if (down_interruptible(&readbuffer_mutex))
+					return -ERESTARTSYS;
+				spin_lock_irqsave(&bufferlock, flags);
+			}
+		}
+		WARN_ON(tc != sizeof(tailcount));
+		effective_count = min(tailcount,(int)count);
+		eerb->residual = tailcount - effective_count;
+	}
+
+	tc = dasd_eer_read_buffer(eerb, readbuffer, effective_count);
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
+static unsigned int dasd_eer_poll(struct file *filp, poll_table *ptable)
+{
+	unsigned int mask;
+	unsigned long flags;
+	struct eerbuffer *eerb;
+
+	eerb = (struct eerbuffer *) filp->private_data;
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
+int __init dasd_eer_init(void)
+{
+	int rc;
+
+	rc = misc_register(&dasd_eer_dev);
+	if (rc) {
+		MESSAGE(KERN_ERR, "%s", "dasd_eer_init could not "
+		       "register misc device");
+		return rc;
+	}
+
+	return 0;
+}
+
+void __exit dasd_eer_exit(void)
+{
+	WARN_ON(misc_deregister(&dasd_eer_dev) != 0);
+}
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-03-22 14:36:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-03-22 14:36:28.000000000 +0100
@@ -268,6 +268,23 @@ struct dasd_discipline {
 
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
 struct dasd_device {
 	/* Block device stuff. */
 	struct gendisk *gdp;
@@ -281,6 +298,9 @@ struct dasd_device {
 	unsigned long flags;		/* per device flags */
 	unsigned short features;        /* copy of devmap-features (read-only!) */
 
+	/* extended error reporting stuff (eer) */
+	struct dasd_ccw_req *eer_cqr;
+
 	/* Device discipline stuff. */
 	struct dasd_discipline *discipline;
 	struct dasd_discipline *base_discipline;
@@ -326,6 +346,8 @@ struct dasd_device {
 /* per device flags */
 #define DASD_FLAG_DSC_ERROR	2	/* return -EIO when disconnected */
 #define DASD_FLAG_OFFLINE	3	/* device is in offline processing */
+#define DASD_FLAG_EER_SNSS	4	/* A SNSS is required */
+#define DASD_FLAG_EER_IN_USE	5	/* A SNSS request is running */
 
 void dasd_put_device_wake(struct dasd_device *);
 
@@ -545,6 +567,30 @@ dasd_era_t dasd_9336_erp_examine(struct 
 dasd_era_t dasd_9343_erp_examine(struct dasd_ccw_req *, struct irb *);
 struct dasd_ccw_req *dasd_9343_erp_action(struct dasd_ccw_req *);
 
+/* externals in dasd_eer.c */
+#ifdef CONFIG_DASD_EER
+int dasd_eer_init(void);
+void dasd_eer_exit(void);
+int dasd_eer_enable(struct dasd_device *);
+void dasd_eer_disable(struct dasd_device *);
+void dasd_eer_write(struct dasd_device *, struct dasd_ccw_req *cqr,
+		    unsigned int id);
+void dasd_eer_snss(struct dasd_device *);
+
+static inline int dasd_eer_enabled(struct dasd_device *device)
+{
+	return device->eer_cqr != NULL;
+}
+#else
+#define dasd_eer_init()		(0)
+#define dasd_eer_exit()		do { } while (0)
+#define dasd_eer_enable(d)	(0)
+#define dasd_eer_disable(d)	do { } while (0)
+#define dasd_eer_write(d,c,i)	do { } while (0)
+#define dasd_eer_snss(d)	do { } while (0)
+#define dasd_eer_enabled(d)	(0)
+#endif	/* CONFIG_DASD_ERR */
+
 #endif				/* __KERNEL__ */
 
 #endif				/* DASD_H */
diff -urpN linux-2.6/drivers/s390/block/Kconfig linux-2.6-patched/drivers/s390/block/Kconfig
--- linux-2.6/drivers/s390/block/Kconfig	2006-03-22 14:36:27.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/Kconfig	2006-03-22 14:36:28.000000000 +0100
@@ -55,4 +55,12 @@ config DASD_DIAG
 	  Disks under VM.  If you are not running under VM or unsure what it is,
 	  say "N".
 
+config DASD_EER
+	bool "Extended error reporting (EER)"
+	depends on DASD
+	help
+	  This driver provides a character device interface to the
+	  DASD extended error reporting. This is only needed if you want to
+	  use applications written for the EER facility.
+
 endif
diff -urpN linux-2.6/drivers/s390/block/Makefile linux-2.6-patched/drivers/s390/block/Makefile
--- linux-2.6/drivers/s390/block/Makefile	2006-03-22 14:36:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/Makefile	2006-03-22 14:36:28.000000000 +0100
@@ -7,6 +7,9 @@ dasd_fba_mod-objs  := dasd_fba.o dasd_33
 dasd_diag_mod-objs := dasd_diag.o
 dasd_mod-objs      := dasd.o dasd_ioctl.o dasd_proc.o dasd_devmap.o \
 			dasd_genhd.o dasd_erp.o
+ifdef CONFIG_DASD_EER
+dasd_mod-objs      += dasd_eer.o
+endif
 
 obj-$(CONFIG_DASD) += dasd_mod.o
 obj-$(CONFIG_DASD_DIAG) += dasd_diag_mod.o

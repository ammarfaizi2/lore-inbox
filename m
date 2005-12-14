Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbVLNQOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbVLNQOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVLNQOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:14:31 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:53170 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932637AbVLNQOU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:14:20 -0500
Message-ID: <43A044E6.7060403@de.ibm.com>
Date: Wed, 14 Dec 2005 17:14:30 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, linux-scsi@vger.kernel.org
Subject: [patch 6/6] statistics infrastructure - exploitation: zfcp
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 6/6] statistics infrastructure - exploitation: zfcp

This patch instruments the zfcp driver and makes it feed statistics data
into the statistics infrastructure.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
Acked-by: Andreas Herrmann <aherrman@de.ibm.com>
---

  Makefile    |    4 -
  zfcp_aux.c  |   22 ++++++
  zfcp_ccw.c  |    7 ++
  zfcp_def.h  |   31 ++++++++-
  zfcp_erp.c  |    4 +
  zfcp_ext.h  |    6 +
  zfcp_fsf.c  |   60 +++++++++++++++++-
  zfcp_qdio.c |    5 +
  zfcp_scsi.c |   14 ++++
  zfcp_stat.c |  195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  10 files changed, 338 insertions(+), 10 deletions(-)

diff -Nurp f/drivers/s390/scsi/Makefile g/drivers/s390/scsi/Makefile
--- f/drivers/s390/scsi/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ g/drivers/s390/scsi/Makefile	2005-12-14 16:01:55.000000000 +0100
@@ -3,7 +3,7 @@
  #

  zfcp-objs := zfcp_aux.o zfcp_ccw.o zfcp_scsi.o zfcp_erp.o zfcp_qdio.o \
-	     zfcp_fsf.o zfcp_dbf.o zfcp_sysfs_adapter.o zfcp_sysfs_port.o \
-	     zfcp_sysfs_unit.o zfcp_sysfs_driver.o
+	     zfcp_fsf.o zfcp_dbf.o zfcp_stat.o zfcp_sysfs_adapter.o \
+	     zfcp_sysfs_port.o zfcp_sysfs_unit.o zfcp_sysfs_driver.o

  obj-$(CONFIG_ZFCP) += zfcp.o
diff -Nurp f/drivers/s390/scsi/zfcp_aux.c g/drivers/s390/scsi/zfcp_aux.c
--- f/drivers/s390/scsi/zfcp_aux.c	2005-12-14 12:51:26.000000000 +0100
+++ g/drivers/s390/scsi/zfcp_aux.c	2005-12-14 16:01:55.000000000 +0100
@@ -778,15 +778,20 @@ zfcp_unit_enqueue(struct zfcp_port *port
  	unit->sysfs_device.release = zfcp_sysfs_unit_release;
  	dev_set_drvdata(&unit->sysfs_device, unit);

+	if (zfcp_unit_statistic_register(unit))
+		return NULL;
+
  	/* mark unit unusable as long as sysfs registration is not complete */
  	atomic_set_mask(ZFCP_STATUS_COMMON_REMOVE, &unit->status);

  	if (device_register(&unit->sysfs_device)) {
+		zfcp_unit_statistic_unregister(unit);
  		kfree(unit);
  		return NULL;
  	}

  	if (zfcp_sysfs_unit_create_files(&unit->sysfs_device)) {
+		zfcp_unit_statistic_unregister(unit);
  		device_unregister(&unit->sysfs_device);
  		return NULL;
  	}
@@ -826,6 +831,7 @@ zfcp_unit_dequeue(struct zfcp_unit *unit
  	list_del(&unit->list);
  	write_unlock_irq(&zfcp_data.config_lock);
  	unit->port->units--;
+	zfcp_unit_statistic_unregister(unit);
  	zfcp_port_put(unit->port);
  	zfcp_sysfs_unit_remove_files(&unit->sysfs_device);
  	device_unregister(&unit->sysfs_device);
@@ -837,6 +843,16 @@ zfcp_mempool_alloc(gfp_t gfp_mask, void
  	return kmalloc((size_t) size, gfp_mask);
  }

+static void *
+zfcp_mempool_alloc_fsf_req_scsi(unsigned int __nocast gfp_mask, void *data)
+{
+	struct zfcp_adapter *adapter = (struct zfcp_adapter *)data;
+	void *ptr = kmalloc(sizeof(struct zfcp_fsf_req_pool_element), gfp_mask);
+	if (!ptr)
+		statistic_inc(adapter->stat_low_mem_scsi, 0);
+	return ptr;
+}
+
  static void
  zfcp_mempool_free(void *element, void *size)
  {
@@ -864,8 +880,8 @@ zfcp_allocate_low_mem_buffers(struct zfc

  	adapter->pool.fsf_req_scsi =
  		mempool_create(ZFCP_POOL_FSF_REQ_SCSI_NR,
-			       zfcp_mempool_alloc, zfcp_mempool_free, (void *)
-			       sizeof(struct zfcp_fsf_req_pool_element));
+			       zfcp_mempool_alloc_fsf_req_scsi,
+			       zfcp_mempool_free, (void *)adapter);

  	if (NULL == adapter->pool.fsf_req_scsi)
  		return -ENOMEM;
diff -Nurp f/drivers/s390/scsi/zfcp_ccw.c g/drivers/s390/scsi/zfcp_ccw.c
--- f/drivers/s390/scsi/zfcp_ccw.c	2005-10-28 02:02:08.000000000 +0200
+++ g/drivers/s390/scsi/zfcp_ccw.c	2005-12-14 16:01:55.000000000 +0100
@@ -163,6 +163,10 @@ zfcp_ccw_set_online(struct ccw_device *c
  	retval = zfcp_adapter_debug_register(adapter);
  	if (retval)
  		goto out;
+	retval = zfcp_adapter_statistic_register(adapter);
+	if (retval)
+		goto out_stat_create;
+
  	retval = zfcp_erp_thread_setup(adapter);
  	if (retval) {
  		ZFCP_LOG_INFO("error: start of error recovery thread for "
@@ -183,6 +187,8 @@ zfcp_ccw_set_online(struct ccw_device *c
   out_scsi_register:
  	zfcp_erp_thread_kill(adapter);
   out_erp_thread:
+	zfcp_adapter_statistic_unregister(adapter);
+ out_stat_create:
  	zfcp_adapter_debug_unregister(adapter);
   out:
  	up(&zfcp_data.config_sema);
@@ -209,6 +215,7 @@ zfcp_ccw_set_offline(struct ccw_device *
  	zfcp_erp_wait(adapter);
  	zfcp_adapter_scsi_unregister(adapter);
  	zfcp_erp_thread_kill(adapter);
+	zfcp_adapter_statistic_unregister(adapter);
  	zfcp_adapter_debug_unregister(adapter);
  	up(&zfcp_data.config_sema);
  	return 0;
diff -Nurp f/drivers/s390/scsi/zfcp_def.h g/drivers/s390/scsi/zfcp_def.h
--- f/drivers/s390/scsi/zfcp_def.h	2005-10-28 02:02:08.000000000 +0200
+++ g/drivers/s390/scsi/zfcp_def.h	2005-12-14 16:01:55.000000000 +0100
@@ -58,6 +58,8 @@
  #include <asm/qdio.h>
  #include <asm/debug.h>
  #include <asm/ebcdic.h>
+#include <asm/timex.h>
+#include <linux/statistic.h>
  #include <linux/mempool.h>
  #include <linux/syscalls.h>
  #include <linux/ioctl.h>
@@ -66,7 +68,7 @@
  /********************* GENERAL DEFINES *********************************/

  /* zfcp version number, it consists of major, minor, and patch-level number */
-#define ZFCP_VERSION		"4.5.0"
+#define ZFCP_VERSION		"4.6.0"

  /**
   * zfcp_sg_to_address - determine kernel address from struct scatterlist
@@ -978,6 +980,12 @@ struct zfcp_adapter {
  	struct zfcp_adapter_mempool	pool;      /* Adapter memory pools */
  	struct qdio_initialize  qdio_init_data;    /* for qdio_establish */
  	struct device           generic_services;  /* directory for WKA ports */
+	struct statistic_interface	*stat_if;
+	struct statistic		*stat_qdio_outb_full;
+	struct statistic		*stat_qdio_outb;
+	struct statistic		*stat_qdio_inb;
+	struct statistic		*stat_low_mem_scsi;
+	struct statistic		*stat_erp;
  };

  /*
@@ -1024,6 +1032,24 @@ struct zfcp_unit {
          struct scsi_device     *device;        /* scsi device struct pointer */
  	struct zfcp_erp_action erp_action;     /* pending error recovery */
          atomic_t               erp_counter;
+	atomic_t		read_num;
+	atomic_t		write_num;
+	struct statistic_interface	*stat_if;
+	struct statistic		*stat_sizes_scsi_write;
+	struct statistic		*stat_sizes_scsi_read;
+	struct statistic		*stat_sizes_scsi_nodata;
+	struct statistic		*stat_sizes_scsi_nofit;
+	struct statistic		*stat_sizes_scsi_nomem;
+	struct statistic		*stat_sizes_timedout_write;
+	struct statistic		*stat_sizes_timedout_read;
+	struct statistic		*stat_sizes_timedout_nodata;
+	struct statistic		*stat_latencies_scsi_write;
+	struct statistic		*stat_latencies_scsi_read;
+	struct statistic		*stat_latencies_scsi_nodata;
+	struct statistic		*stat_pending_scsi_write;
+	struct statistic		*stat_pending_scsi_read;
+	struct statistic		*stat_erp;
+	struct statistic		*stat_eh_reset;
  };

  /* FSF request */
@@ -1050,7 +1076,8 @@ struct zfcp_fsf_req {
  	mempool_t	       *pool;	       /* used if request was alloacted
  						  from emergency pool */
  	unsigned long long     issued;         /* request sent time (STCK) */
-	struct zfcp_unit       *unit;
+	unsigned long long	received;
+	struct zfcp_unit	*unit;
  };

  typedef void zfcp_fsf_req_handler_t(struct zfcp_fsf_req*);
diff -Nurp f/drivers/s390/scsi/zfcp_erp.c g/drivers/s390/scsi/zfcp_erp.c
--- f/drivers/s390/scsi/zfcp_erp.c	2005-12-14 12:51:26.000000000 +0100
+++ g/drivers/s390/scsi/zfcp_erp.c	2005-12-14 16:01:55.000000000 +0100
@@ -1624,10 +1624,12 @@ zfcp_erp_strategy_check_unit(struct zfcp
  	switch (result) {
  	case ZFCP_ERP_SUCCEEDED :
  		atomic_set(&unit->erp_counter, 0);
+		statistic_inc(unit->stat_erp, 1);
  		zfcp_erp_unit_unblock(unit);
  		break;
  	case ZFCP_ERP_FAILED :
  		atomic_inc(&unit->erp_counter);
+		statistic_inc(unit->stat_erp, -1);
  		if (atomic_read(&unit->erp_counter) > ZFCP_MAX_ERPS)
  			zfcp_erp_unit_failed(unit);
  		break;
@@ -1695,10 +1697,12 @@ zfcp_erp_strategy_check_adapter(struct z
  	switch (result) {
  	case ZFCP_ERP_SUCCEEDED :
  		atomic_set(&adapter->erp_counter, 0);
+		statistic_inc(adapter->stat_erp, 1);
  		zfcp_erp_adapter_unblock(adapter);
  		break;
  	case ZFCP_ERP_FAILED :
  		atomic_inc(&adapter->erp_counter);
+		statistic_inc(adapter->stat_erp, -1);
  		if (atomic_read(&adapter->erp_counter) > ZFCP_MAX_ERPS)
  			zfcp_erp_adapter_failed(adapter);
  		break;
diff -Nurp f/drivers/s390/scsi/zfcp_ext.h g/drivers/s390/scsi/zfcp_ext.h
--- f/drivers/s390/scsi/zfcp_ext.h	2005-10-28 02:02:08.000000000 +0200
+++ g/drivers/s390/scsi/zfcp_ext.h	2005-12-14 16:01:55.000000000 +0100
@@ -203,4 +203,10 @@ extern void zfcp_scsi_dbf_event_abort(co
  extern void zfcp_scsi_dbf_event_devreset(const char *, u8, struct zfcp_unit *,
  					 struct scsi_cmnd *);

+/*************************** stat ********************************************/
+extern int zfcp_adapter_statistic_register(struct zfcp_adapter *);
+extern int zfcp_adapter_statistic_unregister(struct zfcp_adapter *);
+extern int zfcp_unit_statistic_register(struct zfcp_unit *);
+extern int zfcp_unit_statistic_unregister(struct zfcp_unit *);
+
  #endif	/* ZFCP_EXT_H */
diff -Nurp f/drivers/s390/scsi/zfcp_fsf.c g/drivers/s390/scsi/zfcp_fsf.c
--- f/drivers/s390/scsi/zfcp_fsf.c	2005-12-14 12:51:26.000000000 +0100
+++ g/drivers/s390/scsi/zfcp_fsf.c	2005-12-14 16:01:55.000000000 +0100
@@ -219,6 +219,8 @@ zfcp_fsf_req_complete(struct zfcp_fsf_re
  	int retval = 0;
  	int cleanup;

+	fsf_req->received = get_clock();
+
  	if (unlikely(fsf_req->fsf_command == FSF_QTCB_UNSOLICITED_STATUS)) {
  		ZFCP_LOG_DEBUG("Status read response received\n");
  		/*
@@ -3471,6 +3473,12 @@ zfcp_fsf_send_fcp_command_task(struct zf
  			       unit->fcp_lun,
  			       unit->port->wwpn,
  			       zfcp_get_busid_by_adapter(adapter));
+		if (retval == -ENOMEM)
+			statistic_inc(unit->stat_sizes_scsi_nomem,
+				       scsi_cmnd->request_bufflen);
+		if (retval == -EIO)
+			statistic_inc(unit->stat_sizes_scsi_nofit,
+				       scsi_cmnd->request_bufflen);
  		goto failed_req_create;
  	}

@@ -3581,6 +3589,8 @@ zfcp_fsf_send_fcp_command_task(struct zf
  		zfcp_erp_unit_shutdown(unit, 0);
  		retval = -EINVAL;
  		}
+		statistic_inc(unit->stat_sizes_scsi_nofit,
+			       scsi_cmnd->request_bufflen);
  		goto no_fit;
  	}

@@ -3591,6 +3601,13 @@ zfcp_fsf_send_fcp_command_task(struct zf
  	ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
  		      (char *) scsi_cmnd->cmnd, scsi_cmnd->cmd_len);

+	if (scsi_cmnd->sc_data_direction == DMA_FROM_DEVICE)
+		statistic_inc(unit->stat_pending_scsi_read,
+				atomic_inc_return(&unit->read_num));
+	else if (scsi_cmnd->sc_data_direction == DMA_TO_DEVICE)
+		statistic_inc(unit->stat_pending_scsi_write,
+				atomic_inc_return(&unit->write_num));
+
  	/*
  	 * start QDIO request for this FSF request
  	 *  covered by an SBALE)
@@ -3613,6 +3630,11 @@ zfcp_fsf_send_fcp_command_task(struct zf
  	goto success;

   send_failed:
+	if (scsi_cmnd->sc_data_direction == DMA_FROM_DEVICE)
+		atomic_dec(&unit->read_num);
+	else if (scsi_cmnd->sc_data_direction == DMA_TO_DEVICE)
+		atomic_dec(&unit->write_num);
+
   no_fit:
   failed_scsi_cmnd:
  	zfcp_unit_put(unit);
@@ -3984,9 +4006,32 @@ zfcp_fsf_send_fcp_command_task_handler(s
  	u32 sns_len;
  	char *fcp_rsp_info = zfcp_get_fcp_rsp_info_ptr(fcp_rsp_iu);
  	unsigned long flags;
+	struct zfcp_adapter *adapter = fsf_req->adapter;
  	struct zfcp_unit *unit = fsf_req->unit;
+	long long unsigned latency;

-	read_lock_irqsave(&fsf_req->adapter->abort_lock, flags);
+	statistic_lock(unit->stat_if, flags);
+	latency = fsf_req->received - fsf_req->issued;
+	do_div(latency, 1000000);
+	latency++;
+	if (fcp_cmnd_iu->wddata == 1) {
+		statistic_inc_nolock(unit->stat_sizes_scsi_write,
+				      zfcp_get_fcp_dl(fcp_cmnd_iu));
+		statistic_inc_nolock(unit->stat_latencies_scsi_write, latency);
+		atomic_dec(&unit->write_num);
+	} else if (fcp_cmnd_iu->rddata == 1) {
+		statistic_inc_nolock(unit->stat_sizes_scsi_read,
+				      zfcp_get_fcp_dl(fcp_cmnd_iu));
+		statistic_inc_nolock(unit->stat_latencies_scsi_read, latency);
+		atomic_dec(&unit->read_num);
+	} else {
+		statistic_inc_nolock(unit->stat_sizes_scsi_nodata,
+				      zfcp_get_fcp_dl(fcp_cmnd_iu));
+		statistic_inc_nolock(unit->stat_latencies_scsi_nodata, latency);
+	}
+	statistic_unlock(unit->stat_if, flags);
+
+	read_lock_irqsave(&adapter->abort_lock, flags);
  	scpnt = (struct scsi_cmnd *) fsf_req->data;
  	if (unlikely(!scpnt)) {
  		ZFCP_LOG_DEBUG
@@ -4188,7 +4233,7 @@ zfcp_fsf_send_fcp_command_task_handler(s
  	 * Note: scsi_done must not block!
  	 */
   out:
-	read_unlock_irqrestore(&fsf_req->adapter->abort_lock, flags);
+	read_unlock_irqrestore(&adapter->abort_lock, flags);
  	return retval;
  }

@@ -4605,10 +4650,14 @@ zfcp_fsf_req_sbal_get(struct zfcp_adapte
  						       ZFCP_SBAL_TIMEOUT);
  		if (ret < 0)
  			return ret;
-		if (!ret)
+		if (!ret) {
+			statistic_inc(adapter->stat_qdio_outb_full, 1);
  			return -EIO;
-        } else if (!zfcp_fsf_req_sbal_check(lock_flags, req_queue, 1))
+		}
+        } else if (!zfcp_fsf_req_sbal_check(lock_flags, req_queue, 1)) {
+		statistic_inc(adapter->stat_qdio_outb_full, 1);
                  return -EIO;
+	}

          return 0;
  }
@@ -4774,6 +4823,9 @@ zfcp_fsf_req_send(struct zfcp_fsf_req *f
  	 * position of first one
  	 */
  	atomic_sub(fsf_req->sbal_number, &req_queue->free_count);
+	statistic_inc(adapter->stat_qdio_outb,
+			QDIO_MAX_BUFFERS_PER_Q -
+			atomic_read(&req_queue->free_count));
  	ZFCP_LOG_TRACE("free_count=%d\n", atomic_read(&req_queue->free_count));
  	req_queue->free_index += fsf_req->sbal_number;	  /* increase */
  	req_queue->free_index %= QDIO_MAX_BUFFERS_PER_Q;  /* wrap if needed */
diff -Nurp f/drivers/s390/scsi/zfcp_qdio.c g/drivers/s390/scsi/zfcp_qdio.c
--- f/drivers/s390/scsi/zfcp_qdio.c	2005-10-28 02:02:08.000000000 +0200
+++ g/drivers/s390/scsi/zfcp_qdio.c	2005-12-14 16:01:55.000000000 +0100
@@ -418,6 +418,7 @@ zfcp_qdio_response_handler(struct ccw_de
  	} else {
  		queue->free_index += count;
  		queue->free_index %= QDIO_MAX_BUFFERS_PER_Q;
+		statistic_inc(adapter->stat_qdio_inb, count);
  		atomic_set(&queue->free_count, 0);
  		ZFCP_LOG_TRACE("%i buffers enqueued to response "
  			       "queue at position %i\n", count, start);
@@ -662,6 +663,10 @@ zfcp_qdio_sbals_from_segment(struct zfcp
  		/* get next free SBALE for new piece */
  		if (NULL == zfcp_qdio_sbale_next(fsf_req, sbtype)) {
  			/* no SBALE left, clean up and leave */
+			statistic_inc(
+				fsf_req->adapter->stat_qdio_outb_full,
+				atomic_read(
+				 &fsf_req->adapter->request_queue.free_count));
  			zfcp_qdio_sbals_wipe(fsf_req);
  			return -EINVAL;
  		}
diff -Nurp f/drivers/s390/scsi/zfcp_scsi.c g/drivers/s390/scsi/zfcp_scsi.c
--- f/drivers/s390/scsi/zfcp_scsi.c	2005-12-14 12:51:26.000000000 +0100
+++ g/drivers/s390/scsi/zfcp_scsi.c	2005-12-14 16:01:55.000000000 +0100
@@ -449,6 +449,16 @@ zfcp_scsi_eh_abort_handler(struct scsi_c
  	ZFCP_LOG_INFO("aborting scsi_cmnd=%p on adapter %s\n",
  		      scpnt, zfcp_get_busid_by_adapter(adapter));

+	if (scpnt->sc_data_direction == DMA_TO_DEVICE)
+		statistic_inc(unit->stat_sizes_timedout_write,
+			      scpnt->request_bufflen);
+	else if (scpnt->sc_data_direction == DMA_FROM_DEVICE)
+		statistic_inc(unit->stat_sizes_timedout_read,
+			      scpnt->request_bufflen);
+	else
+		statistic_inc(unit->stat_sizes_timedout_nodata,
+			       scpnt->request_bufflen);
+
  	/* avoid race condition between late normal completion and abort */
  	write_lock_irqsave(&adapter->abort_lock, flags);

@@ -538,12 +548,14 @@ zfcp_scsi_eh_device_reset_handler(struct
  				atomic_set_mask
  				    (ZFCP_STATUS_UNIT_NOTSUPPUNITRESET,
  				     &unit->status);
+			statistic_inc(unit->stat_eh_reset, -1);
  			/* fall through and try 'target reset' next */
  		} else {
  			ZFCP_LOG_DEBUG("unit reset succeeded (unit=%p)\n",
  				       unit);
  			/* avoid 'target reset' */
  			retval = SUCCESS;
+			statistic_inc(unit->stat_eh_reset, 1);
  			goto out;
  		}
  	}
@@ -551,9 +563,11 @@ zfcp_scsi_eh_device_reset_handler(struct
  	if (retval) {
  		ZFCP_LOG_DEBUG("target reset failed (unit=%p)\n", unit);
  		retval = FAILED;
+		statistic_inc(unit->stat_eh_reset, -2);
  	} else {
  		ZFCP_LOG_DEBUG("target reset succeeded (unit=%p)\n", unit);
  		retval = SUCCESS;
+		statistic_inc(unit->stat_eh_reset, 2);
  	}
   out:
  	return retval;
diff -Nurp f/drivers/s390/scsi/zfcp_stat.c g/drivers/s390/scsi/zfcp_stat.c
--- f/drivers/s390/scsi/zfcp_stat.c	1970-01-01 01:00:00.000000000 +0100
+++ g/drivers/s390/scsi/zfcp_stat.c	2005-12-14 16:01:55.000000000 +0100
@@ -0,0 +1,195 @@
+/*
+ *
+ * linux/drivers/s390/scsi/zfcp_stat.c
+ *
+ * FCP adapter driver for IBM eServer zSeries
+ *
+ * Statistics
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define ZFCP_STAT_REVISION "$Revision: 1.9 $"
+
+#include <linux/statistic.h>
+#include <linux/ctype.h>
+#include "zfcp_ext.h"
+
+#define ZFCP_LOG_AREA			ZFCP_LOG_AREA_OTHER
+
+int zfcp_adapter_statistic_register(struct zfcp_adapter *adapter)
+{
+	int retval = 0;
+	char name[14];
+
+	sprintf(name, "zfcp-%s", zfcp_get_busid_by_adapter(adapter));
+	statistic_interface_create(&adapter->stat_if, name);
+
+	retval |=
+	    statistic_create(&adapter->stat_qdio_outb_full, adapter->stat_if,
+			     "occurrence_qdio_outb_full",
+			     "sbals_left/incidents");
+	statistic_define_value(adapter->stat_qdio_outb_full,
+			       STATISTIC_RANGE_MIN, STATISTIC_RANGE_MAX,
+			       STATISTIC_DEF_MODE_INC);
+
+	retval |= statistic_create(&adapter->stat_qdio_outb, adapter->stat_if,
+				   "util_qdio_outb",
+				   "slots-occupied/incidents");
+	statistic_define_range(adapter->stat_qdio_outb,
+			       0, QDIO_MAX_BUFFERS_PER_Q);
+
+	retval |= statistic_create(&adapter->stat_qdio_inb, adapter->stat_if,
+				   "util_qdio_inb", "slots-occupied/incidents");
+	statistic_define_range(adapter->stat_qdio_inb,
+			       0, QDIO_MAX_BUFFERS_PER_Q);
+
+	retval |=
+	    statistic_create(&adapter->stat_low_mem_scsi, adapter->stat_if,
+			     "occurrence_low_mem_scsi", "-/incidents");
+	statistic_define_value(adapter->stat_low_mem_scsi, STATISTIC_RANGE_MIN,
+			       STATISTIC_RANGE_MAX, STATISTIC_DEF_MODE_INC);
+
+	retval |= statistic_create(&adapter->stat_erp, adapter->stat_if,
+				   "occurrence_erp", "results/incidents");
+	statistic_define_value(adapter->stat_erp,
+			       STATISTIC_RANGE_MIN, STATISTIC_RANGE_MAX,
+			       STATISTIC_DEF_MODE_INC);
+
+	return retval;
+}
+
+int zfcp_adapter_statistic_unregister(struct zfcp_adapter *adapter)
+{
+	return statistic_interface_remove(&adapter->stat_if);
+}
+
+int zfcp_unit_statistic_register(struct zfcp_unit *unit)
+{
+	int retval = 0;
+	char name[64];
+
+	atomic_set(&unit->read_num, 0);
+	atomic_set(&unit->write_num, 0);
+
+	sprintf(name, "zfcp-%s-0x%016Lx-0x%016Lx",
+		zfcp_get_busid_by_unit(unit), unit->port->wwpn, unit->fcp_lun);
+	statistic_interface_create(&unit->stat_if, name);
+
+	retval |= statistic_create(&unit->stat_sizes_scsi_write, unit->stat_if,
+				   "request_sizes_scsi_write",
+				   "bytes/incidents");
+	statistic_define_list(unit->stat_sizes_scsi_write, 0,
+			      STATISTIC_RANGE_MAX, 256);
+
+	retval |= statistic_create(&unit->stat_sizes_scsi_read, unit->stat_if,
+				   "request_sizes_scsi_read",
+				   "bytes/incidents");
+	statistic_define_list(unit->stat_sizes_scsi_read, 0,
+			      STATISTIC_RANGE_MAX, 256);
+
+	retval |= statistic_create(&unit->stat_sizes_scsi_nodata, unit->stat_if,
+				   "request_sizes_scsi_nodata",
+				   "bytes/incidents");
+	statistic_define_value(unit->stat_sizes_scsi_nodata,
+			       STATISTIC_RANGE_MIN, STATISTIC_RANGE_MAX,
+			       STATISTIC_DEF_MODE_INC);
+
+	retval |= statistic_create(&unit->stat_sizes_scsi_nofit, unit->stat_if,
+				   "request_sizes_scsi_nofit",
+				   "bytes/incidents");
+	statistic_define_list(unit->stat_sizes_scsi_nofit, 0,
+			      STATISTIC_RANGE_MAX, 256);
+
+	retval |= statistic_create(&unit->stat_sizes_scsi_nomem, unit->stat_if,
+				   "request_sizes_scsi_nomem",
+				   "bytes/incidents");
+	statistic_define_value(unit->stat_sizes_scsi_nomem, STATISTIC_RANGE_MIN,
+			       STATISTIC_RANGE_MAX, STATISTIC_DEF_MODE_INC);
+
+	retval |=
+	    statistic_create(&unit->stat_sizes_timedout_write, unit->stat_if,
+			     "request_sizes_timedout_write", "bytes/incidents");
+	statistic_define_value(unit->stat_sizes_timedout_write,
+			       STATISTIC_RANGE_MIN, STATISTIC_RANGE_MAX,
+			       STATISTIC_DEF_MODE_INC);
+
+	retval |=
+	    statistic_create(&unit->stat_sizes_timedout_read, unit->stat_if,
+			     "request_sizes_timedout_read", "bytes/incidents");
+	statistic_define_value(unit->stat_sizes_timedout_read,
+			       STATISTIC_RANGE_MIN, STATISTIC_RANGE_MAX,
+			       STATISTIC_DEF_MODE_INC);
+
+	retval |=
+	    statistic_create(&unit->stat_sizes_timedout_nodata, unit->stat_if,
+			     "request_sizes_timedout_nodata",
+			     "bytes/incidents");
+	statistic_define_value(unit->stat_sizes_timedout_nodata,
+			       STATISTIC_RANGE_MIN, STATISTIC_RANGE_MAX,
+			       STATISTIC_DEF_MODE_INC);
+
+	retval |=
+	    statistic_create(&unit->stat_latencies_scsi_write, unit->stat_if,
+			     "latencies_scsi_write", "milliseconds/incidents");
+	statistic_define_array(unit->stat_latencies_scsi_write, 0, 1024, 1,
+			       STATISTIC_DEF_SCALE_LOG2);
+
+	retval |=
+	    statistic_create(&unit->stat_latencies_scsi_read, unit->stat_if,
+			     "latencies_scsi_read", "milliseconds/incidents");
+	statistic_define_array(unit->stat_latencies_scsi_read, 0, 1024, 1,
+			       STATISTIC_DEF_SCALE_LOG2);
+
+	retval |=
+	    statistic_create(&unit->stat_latencies_scsi_nodata, unit->stat_if,
+			     "latencies_scsi_nodata", "milliseconds/incidents");
+	statistic_define_array(unit->stat_latencies_scsi_nodata, 0, 1024, 1,
+			       STATISTIC_DEF_SCALE_LOG2);
+
+	retval |=
+	    statistic_create(&unit->stat_pending_scsi_write, unit->stat_if,
+			     "pending_scsi_write", "commands/incidents");
+	statistic_define_range(unit->stat_pending_scsi_write, 0,
+			       STATISTIC_RANGE_MAX);
+
+	retval |= statistic_create(&unit->stat_pending_scsi_read, unit->stat_if,
+				   "pending_scsi_read", "commands/incidents");
+	statistic_define_range(unit->stat_pending_scsi_read, 0,
+			       STATISTIC_RANGE_MAX);
+
+	retval |= statistic_create(&unit->stat_erp, unit->stat_if,
+				   "occurrence_erp", "results/incidents");
+	statistic_define_value(unit->stat_erp,
+			       STATISTIC_RANGE_MIN, STATISTIC_RANGE_MAX,
+			       STATISTIC_DEF_MODE_INC);
+
+	retval |= statistic_create(&unit->stat_eh_reset, unit->stat_if,
+				   "occurrence_eh_reset", "results/incidents");
+	statistic_define_value(unit->stat_eh_reset,
+			       STATISTIC_RANGE_MIN, STATISTIC_RANGE_MAX,
+			       STATISTIC_DEF_MODE_INC);
+
+	return retval;
+}
+
+int zfcp_unit_statistic_unregister(struct zfcp_unit *unit)
+{
+	return statistic_interface_remove(&unit->stat_if);
+}
+
+#undef ZFCP_LOG_AREA

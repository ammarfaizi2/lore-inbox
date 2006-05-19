Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWESQOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWESQOn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWESQOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:14:43 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:57912 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932431AbWESQOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:14:42 -0400
Subject: [Patch 6/6] statistics infrastructure - exploitation: zfcp
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 19 May 2006 18:14:39 +0200
Message-Id: <1148055280.2974.22.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch instruments the zfcp driver and makes it feed statistics data
into the statistics infrastructure.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
Acked-by: Andreas Herrmann <aherrman@de.ibm.com>
---

 zfcp_ccw.c  |   24 ++++++++++++++++++++++++
 zfcp_def.h  |   10 ++++++++++
 zfcp_erp.c  |    2 ++
 zfcp_fsf.c  |   13 ++++++++++---
 zfcp_qdio.c |    4 ++++
 5 files changed, 50 insertions(+), 3 deletions(-)

diff -Nurp a/drivers/s390/scsi/zfcp_ccw.c b/drivers/s390/scsi/zfcp_ccw.c
--- a/drivers/s390/scsi/zfcp_ccw.c	2006-03-20 06:53:29.000000000 +0100
+++ b/drivers/s390/scsi/zfcp_ccw.c	2006-05-19 16:02:38.000000000 +0200
@@ -140,6 +140,17 @@ zfcp_ccw_remove(struct ccw_device *ccw_d
 	up(&zfcp_data.config_sema);
 }
 
+static struct statistic_info zfcp_statinfo_a[] = {
+	{ /* ZFCP_STAT_A_QOF */
+	  "qdio_outb_full", "sbals_left", "", 0, "type=counter_inc" },
+	{ /* ZFCP_STAT_A_QO */
+	  "qdio_outb", "sbals_used", "", 0, "type=utilisation" },
+	{ /* ZFCP_STAT_A_QI */
+	  "qdio_inb", "sbals_used", "", 0, "type=utilisation" },
+	{ /* ZFCP_STAT_A_ERP */
+	  "erp", "", "", 0, "type=counter_inc" }
+};
+
 /**
  * zfcp_ccw_set_online - set_online function of zfcp driver
  * @ccw_device: pointer to belonging ccw device
@@ -153,6 +164,7 @@ static int
 zfcp_ccw_set_online(struct ccw_device *ccw_device)
 {
 	struct zfcp_adapter *adapter;
+	char name[14];
 	int retval;
 
 	down(&zfcp_data.config_sema);
@@ -161,6 +173,15 @@ zfcp_ccw_set_online(struct ccw_device *c
 	retval = zfcp_adapter_debug_register(adapter);
 	if (retval)
 		goto out;
+
+	sprintf(name, "zfcp-%s", zfcp_get_busid_by_adapter(adapter));
+	adapter->stat_if.stat = adapter->stat;
+	adapter->stat_if.info = zfcp_statinfo_a;
+	adapter->stat_if.number = _ZFCP_STAT_A_NUMBER;
+	retval = statistic_create(&adapter->stat_if, name);
+	if (retval)
+		goto out_stat_create;
+
 	retval = zfcp_erp_thread_setup(adapter);
 	if (retval) {
 		ZFCP_LOG_INFO("error: start of error recovery thread for "
@@ -181,6 +202,8 @@ zfcp_ccw_set_online(struct ccw_device *c
  out_scsi_register:
 	zfcp_erp_thread_kill(adapter);
  out_erp_thread:
+	statistic_remove(&adapter->stat_if);
+ out_stat_create:
 	zfcp_adapter_debug_unregister(adapter);
  out:
 	up(&zfcp_data.config_sema);
@@ -207,6 +230,7 @@ zfcp_ccw_set_offline(struct ccw_device *
 	zfcp_erp_wait(adapter);
 	zfcp_adapter_scsi_unregister(adapter);
 	zfcp_erp_thread_kill(adapter);
+	statistic_remove(&adapter->stat_if);
 	zfcp_adapter_debug_unregister(adapter);
 	up(&zfcp_data.config_sema);
 	return 0;
diff -Nurp a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
--- a/drivers/s390/scsi/zfcp_def.h	2006-03-20 06:53:29.000000000 +0100
+++ b/drivers/s390/scsi/zfcp_def.h	2006-05-19 16:02:38.000000000 +0200
@@ -56,6 +56,7 @@
 #include <asm/qdio.h>
 #include <asm/debug.h>
 #include <asm/ebcdic.h>
+#include <linux/statistic.h>
 #include <linux/mempool.h>
 #include <linux/syscalls.h>
 #include <linux/ioctl.h>
@@ -898,6 +899,13 @@ struct zfcp_erp_action {
 	struct timer_list timer;
 };
 
+enum zfcp_adapter_stats {
+	ZFCP_STAT_A_QOF,
+	ZFCP_STAT_A_QO,
+	ZFCP_STAT_A_QI,
+	ZFCP_STAT_A_ERP,
+	_ZFCP_STAT_A_NUMBER,
+};
 
 struct zfcp_adapter {
 	struct list_head	list;              /* list of adapters */
@@ -968,6 +976,8 @@ struct zfcp_adapter {
 	struct fc_host_statistics *fc_stats;
 	struct fsf_qtcb_bottom_port *stats_reset_data;
 	unsigned long		stats_reset;
+	struct statistic_interface stat_if;
+	struct statistic stat[_ZFCP_STAT_A_NUMBER];
 };
 
 /*
diff -Nurp a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
--- a/drivers/s390/scsi/zfcp_erp.c	2006-03-20 06:53:29.000000000 +0100
+++ b/drivers/s390/scsi/zfcp_erp.c	2006-05-19 16:02:38.000000000 +0200
@@ -1693,10 +1693,12 @@ zfcp_erp_strategy_check_adapter(struct z
 	switch (result) {
 	case ZFCP_ERP_SUCCEEDED :
 		atomic_set(&adapter->erp_counter, 0);
+		statistic_inc(adapter->stat, ZFCP_STAT_A_ERP, 1);
 		zfcp_erp_adapter_unblock(adapter);
 		break;
 	case ZFCP_ERP_FAILED :
 		atomic_inc(&adapter->erp_counter);
+		statistic_inc(adapter->stat, ZFCP_STAT_A_ERP, -1);
 		if (atomic_read(&adapter->erp_counter) > ZFCP_MAX_ERPS)
 			zfcp_erp_adapter_failed(adapter);
 		break;
diff -Nurp a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
--- a/drivers/s390/scsi/zfcp_fsf.c	2006-03-20 06:53:29.000000000 +0100
+++ b/drivers/s390/scsi/zfcp_fsf.c	2006-05-19 16:02:38.000000000 +0200
@@ -4647,10 +4647,14 @@ zfcp_fsf_req_sbal_get(struct zfcp_adapte
 						       ZFCP_SBAL_TIMEOUT);
 		if (ret < 0)
 			return ret;
-		if (!ret)
+		if (!ret) {
+			statistic_inc(adapter->stat, ZFCP_STAT_A_QOF, 1);
 			return -EIO;
-        } else if (!zfcp_fsf_req_sbal_check(lock_flags, req_queue, 1))
+		}
+        } else if (!zfcp_fsf_req_sbal_check(lock_flags, req_queue, 1)) {
+		statistic_inc(adapter->stat, ZFCP_STAT_A_QOF, 1);
                 return -EIO;
+	}
 
         return 0;
 }
@@ -4816,12 +4820,15 @@ zfcp_fsf_req_send(struct zfcp_fsf_req *f
 	 * position of first one
 	 */
 	atomic_sub(fsf_req->sbal_number, &req_queue->free_count);
+	statistic_inc(adapter->stat, ZFCP_STAT_A_QO,
+		      QDIO_MAX_BUFFERS_PER_Q -
+		      atomic_read(&req_queue->free_count));
 	ZFCP_LOG_TRACE("free_count=%d\n", atomic_read(&req_queue->free_count));
 	req_queue->free_index += fsf_req->sbal_number;	  /* increase */
 	req_queue->free_index %= QDIO_MAX_BUFFERS_PER_Q;  /* wrap if needed */
 	new_distance_from_int = zfcp_qdio_determine_pci(req_queue, fsf_req);
 
-	fsf_req->issued = get_clock();
+	fsf_req->issued = sched_clock();
 
 	retval = do_QDIO(adapter->ccw_device,
 			 QDIO_FLAG_SYNC_OUTPUT,
diff -Nurp a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
--- a/drivers/s390/scsi/zfcp_qdio.c	2006-03-20 06:53:29.000000000 +0100
+++ b/drivers/s390/scsi/zfcp_qdio.c	2006-05-19 16:02:38.000000000 +0200
@@ -416,6 +416,7 @@ zfcp_qdio_response_handler(struct ccw_de
 	} else {
 		queue->free_index += count;
 		queue->free_index %= QDIO_MAX_BUFFERS_PER_Q;
+		statistic_inc(adapter->stat, ZFCP_STAT_A_QI, count);
 		atomic_set(&queue->free_count, 0);
 		ZFCP_LOG_TRACE("%i buffers enqueued to response "
 			       "queue at position %i\n", count, start);
@@ -660,6 +661,9 @@ zfcp_qdio_sbals_from_segment(struct zfcp
 		/* get next free SBALE for new piece */
 		if (NULL == zfcp_qdio_sbale_next(fsf_req, sbtype)) {
 			/* no SBALE left, clean up and leave */
+			statistic_inc(fsf_req->adapter->stat, ZFCP_STAT_A_QOF,
+				      atomic_read(
+				 &fsf_req->adapter->request_queue.free_count));
 			zfcp_qdio_sbals_wipe(fsf_req);
 			return -EINVAL;
 		}



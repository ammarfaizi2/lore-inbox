Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWEPRs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWEPRs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWEPRsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:48:55 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:8785 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932466AbWEPRsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:48:14 -0400
Message-ID: <446A1053.9010902@de.ibm.com>
Date: Tue, 16 May 2006 19:48:03 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, ak@suse.de, hch@infradead.org, arjan@infradead.org,
       James.Smart@Emulex.Com, James.Bottomley@SteelEye.com
Subject: [RFC] [Patch 8/8] statistics infrastructure - exploitation: scsi
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is obviously broken.
It get's me latencies, request sizes and information about
TCQ utilisation, though.

Problem is that creating statistics requires process contexts,
mostly because we create debugfs directories and files.
SCSI device creation, and therewith SCSI device statistics
creation, doesn't provide process context. I think it's very
unfortunate that scsi_allocate_sdev isn't capable of being
interrupted by the scheduler.

Besides, I was surprised to see the scsi mid layer remove
a few sdev's (or their statistics, to be precise) twice.

I am quite sure my instrumentation of the SCSI mid layer is
far from perfect (additions of statistic_add & friends).
I would appriciate hints for refinements from the SCSI experts.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

  drivers/scsi/scsi_lib.c    |   33 ++++++++++++++++++++++++++++++++-
  drivers/scsi/scsi_scan.c   |   35 ++++++++++++++++++++++++++++++++++-
  drivers/scsi/scsi_sysfs.c  |    2 ++
  include/scsi/scsi_cmnd.h   |    2 ++
  include/scsi/scsi_device.h |   16 ++++++++++++++++
  5 files changed, 86 insertions(+), 2 deletions(-)

diff -Nurp a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	2006-05-15 12:42:10.000000000 +0200
+++ b/drivers/scsi/scsi_lib.c	2006-05-15 15:43:33.000000000 +0200
@@ -1522,6 +1522,35 @@ static void scsi_kill_request(struct req
  	__scsi_done(cmd);
  }

+static void scsi_stat_completion(struct scsi_cmnd *cmd, int disposition)
+{
+#ifdef CONFIG_STATISTICS
+	struct statistic *stat = cmd->device->stat;
+	unsigned size = cmd->request_bufflen;
+	long long unsigned latency = cmd->received - cmd->issued;
+	unsigned long flags;
+
+	do_div(latency, 1000000);
+	latency++;
+
+	get_cpu();
+	local_irq_save(flags);
+	statistic_inc_nolock(stat, SCSI_STAT_U_R, cmd->result);
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+		statistic_inc_nolock(stat, SCSI_STAT_U_SW, size);
+		statistic_inc_nolock(stat, SCSI_STAT_U_LW, latency);
+	} else if (cmd->sc_data_direction == DMA_FROM_DEVICE) {
+		statistic_inc_nolock(stat, SCSI_STAT_U_SR, size);
+		statistic_inc_nolock(stat, SCSI_STAT_U_LR, latency);
+	} else if (cmd->sc_data_direction == DMA_NONE) {
+		statistic_inc_nolock(stat, SCSI_STAT_U_SN, size);
+		statistic_inc_nolock(stat, SCSI_STAT_U_LN, latency);
+	}
+	local_irq_restore(flags);
+	put_cpu();
+#endif
+}
+
  static void scsi_softirq_done(struct request *rq)
  {
  	struct scsi_cmnd *cmd = rq->completion_data;
@@ -1538,7 +1567,8 @@ static void scsi_softirq_done(struct req
  			    wait_for/HZ);
  		disposition = SUCCESS;
  	}
-			
+
+	scsi_stat_completion(cmd, disposition);
  	scsi_log_completion(cmd, disposition);

  	switch (disposition) {
@@ -1616,6 +1646,7 @@ static void scsi_request_fn(struct reque
  		if (!(blk_queue_tagged(q) && !blk_queue_start_tag(q, req)))
  			blkdev_dequeue_request(req);
  		sdev->device_busy++;
+		statistic_inc(sdev->stat, SCSI_STAT_U_QUD, sdev->device_busy);

  		spin_unlock(q->queue_lock);
  		cmd = req->special;
diff -Nurp a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	2006-05-15 19:29:27.000000000 +0200
+++ b/drivers/scsi/scsi_scan.c	2006-05-15 19:30:14.000000000 +0200
@@ -187,6 +187,28 @@ static void print_inquiry(unsigned char
  		printk("\n");
  }

+static struct statistic_info scsi_statinfo_u[] = {
+	{ /* SCSI_STAT_U_SW */
+	  "size_write", "bytes", "request", 0, "type=sparse entries=256"},
+	{ /* SCSI_STAT_U_SR */
+	  "size_read", "bytes", "request", 0, "type=sparse entries=256"},
+	{ /* SCSI_STAT_U_SN */
+	  "size_nodata", "bytes", "request", 0, "type=counter_inc"},
+	{ /* SCSI_STAT_U_LW */
+	  "latency_write", "msec", "request", 0,
+	  "type=histogram_log2 entries=13 base_interval=1 range_min=0"},
+	{ /* SCSI_STAT_U_LR */
+	  "latency_read", "msec", "request", 0,
+	  "type=histogram_log2 entries=13 base_interval=1 range_min=0"},
+	{ /* SCSI_STAT_U_LN */
+	  "latency_nodata", "msec", "request", 0,
+	  "type=histogram_log2 entries=13 base_interval=1 range_min=0"},
+	{ /* SCSI_STAT_U_R */
+	  "result", "", "", 0, "type=sparse entries=256" },
+	{ /* SCSI_STAT_U_QUD */
+	  "queue_used_depth", "requests", "", 0, "type=utilisation" },
+};
+
  /**
   * scsi_alloc_sdev - allocate and setup a scsi_Device
   *
@@ -204,6 +226,7 @@ static struct scsi_device *scsi_alloc_sd
  	struct scsi_device *sdev;
  	int display_failure_msg = 1, ret;
  	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
+	char name[64];

  	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
  		       GFP_ATOMIC);
@@ -260,6 +283,14 @@ static struct scsi_device *scsi_alloc_sd

  	scsi_sysfs_device_initialize(sdev);

+	sprintf(name, "scsi-%d:%d:%d:%d", sdev->host->host_no, sdev->channel,
+		sdev->id, sdev->lun);
+	sdev->stat_if.stat = sdev->stat;
+	sdev->stat_if.info = scsi_statinfo_u;
+	sdev->stat_if.number = _SCSI_STAT_U_NUMBER;
+	if (statistic_create(&sdev->stat_if, name))
+		goto out_device_destroy;
+
  	if (shost->hostt->slave_alloc) {
  		ret = shost->hostt->slave_alloc(sdev);
  		if (ret) {
@@ -269,12 +300,14 @@ static struct scsi_device *scsi_alloc_sd
  			 */
  			if (ret == -ENXIO)
  				display_failure_msg = 0;
-			goto out_device_destroy;
+			goto out_stat_destroy;
  		}
  	}

  	return sdev;

+out_stat_destroy:
+	statistic_remove(&sdev->stat_if);
  out_device_destroy:
  	transport_destroy_device(&sdev->sdev_gendev);
  	put_device(&sdev->sdev_gendev);
diff -Nurp a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c	2006-05-15 12:42:10.000000000 +0200
+++ b/drivers/scsi/scsi_sysfs.c	2006-05-15 15:49:15.000000000 +0200
@@ -247,6 +247,8 @@ static void scsi_device_dev_release_user

  	scsi_target_reap(scsi_target(sdev));

+	statistic_remove(&sdev->stat_if);
+
  	kfree(sdev->inquiry);
  	kfree(sdev);

diff -Nurp a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
--- a/include/scsi/scsi_cmnd.h	2006-05-15 12:42:12.000000000 +0200
+++ b/include/scsi/scsi_cmnd.h	2006-05-15 16:04:10.000000000 +0200
@@ -58,6 +58,8 @@ struct scsi_cmnd {
  	 * been outstanding
  	 */
  	unsigned long jiffies_at_alloc;
+	unsigned long long issued;	/* sched_clock() */
+	unsigned long long received;	/* ditto */

  	int retries;
  	int allowed;
diff -Nurp a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
--- a/include/scsi/scsi_device.h	2006-05-15 12:42:12.000000000 +0200
+++ b/include/scsi/scsi_device.h	2006-05-15 16:06:13.000000000 +0200
@@ -5,6 +5,7 @@
  #include <linux/list.h>
  #include <linux/spinlock.h>
  #include <linux/workqueue.h>
+#include <linux/statistic.h>
  #include <asm/atomic.h>

  struct request_queue;
@@ -45,6 +46,18 @@ enum scsi_device_state {
  				 * to the scsi lld. */
  };

+enum scsi_unit_stats {
+	SCSI_STAT_U_SW,		/* size, write */
+	SCSI_STAT_U_SR,		/* size, read */
+	SCSI_STAT_U_SN,		/* size, no data */
+	SCSI_STAT_U_LW,		/* latency, write */
+	SCSI_STAT_U_LR,		/* latency, read */
+	SCSI_STAT_U_LN,		/* latency, no data */
+	SCSI_STAT_U_R,		/* result */
+	SCSI_STAT_U_QUD,	/* queue used depth */
+	_SCSI_STAT_U_NUMBER,
+};
+
  struct scsi_device {
  	struct Scsi_Host *host;
  	struct request_queue *request_queue;
@@ -133,6 +146,9 @@ struct scsi_device {
  	atomic_t iodone_cnt;
  	atomic_t ioerr_cnt;

+	struct statistic_interface stat_if;
+	struct statistic           stat[_SCSI_STAT_U_NUMBER];
+
  	int timeout;

  	struct device		sdev_gendev;


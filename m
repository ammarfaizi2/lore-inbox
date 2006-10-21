Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161481AbWJUM6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161481AbWJUM6m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 08:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161485AbWJUM6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 08:58:41 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:27637 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161481AbWJUM6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 08:58:39 -0400
Subject: [Patch 4/5] I/O statistics through request queues: SCSI
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 21 Oct 2006 14:58:35 +0200
Message-Id: <1161435516.3054.116.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gets us the following statistics data for SCSI devices:

[root@t2930041 statistics]# ll /sys/kernel/debug/statistics/
total 0
drwxr-xr-x  2 root root 0 Oct 21 12:02 blkq-scsi-0:0:0:0
drwxr-xr-x  2 root root 0 Oct 21 12:02 blkq-scsi-0:0:0:1
drwxr-xr-x  2 root root 0 Oct 21 12:02 blkq-scsi-0:0:0:2

[root@t2930041 statistics]# cat blkq-scsi-0\:0\:0\:2/data
size_write missed 0x0
size_write 0x1000 33937
size_write 0xc000 2959
size_write 0x2000 1311
size_write 0x14000 946
size_write 0x3000 829
...
size_write 0x7d000 41
size_read missed 0x0
size_read 0x14000 44949
size_read 0xd000 40757
size_read 0x1000 23945
size_read 0xc000 19119
size_read 0xb000 1633
...
size_read 0x60000 411
residual_write missed 0x0
residual_write 0x0 73785
residual_read missed 0x0
residual_read 0x0 189074
latency_write <=0 0
latency_write <=1 0
latency_write <=2 0
latency_write <=4 0
latency_write <=8 0
latency_write <=16 0
latency_write <=32 0
latency_write <=64 0
latency_write <=128 0
latency_write <=256 0
latency_write <=512 2076
latency_write <=1024 5105
latency_write <=2048 10543
latency_write <=4096 16315
latency_write <=8192 19894
latency_write <=16384 12245
latency_write <=32768 5576
latency_write <=65536 1347
latency_write <=131072 596
latency_write <=262144 67
latency_write <=524288 21
latency_write <=1048576 0
latency_write >1048576 0
latency_read <=0 0
latency_read <=1 0
latency_read <=2 0
latency_read <=4 0
latency_read <=8 0
latency_read <=16 0
latency_read <=32 0
latency_read <=64 0
latency_read <=128 0
latency_read <=256 1487
latency_read <=512 16950
latency_read <=1024 46219
latency_read <=2048 58288
latency_read <=4096 40161
latency_read <=8192 20781
latency_read <=16384 4945
latency_read <=32768 191
latency_read <=65536 32
latency_read <=131072 10
latency_read <=262144 7
latency_read <=524288 2
latency_read <=1048576 1
latency_read >1048576 0
times_issued_write <=0 0
times_issued_write <=1 73785
times_issued_write <=2 0
times_issued_write <=3 0
times_issued_write <=4 0
times_issued_write <=5 0
times_issued_write <=6 0
times_issued_write >6 0
times_issued_read <=0 0
times_issued_read <=1 189074
times_issued_read <=2 0
times_issued_read <=3 0
times_issued_read <=4 0
times_issued_read <=5 0
times_issued_read <=6 0
times_issued_read >6 0
queue_used_depth samples 262859
queue_used_depth minimum 1
queue_used_depth average 4.109
queue_used_depth maximum 32
queue_used_depth variance 61.196

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 scsi.c      |    3 +++
 scsi_scan.c |    4 ++++
 2 files changed, 7 insertions(+)

diff -urp a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	2006-09-28 15:51:21.000000000 +0200
+++ b/drivers/scsi/scsi_scan.c	2006-10-02 16:35:44.000000000 +0200
@@ -219,6 +219,7 @@ static struct scsi_device *scsi_alloc_sd
 	struct scsi_device *sdev;
 	int display_failure_msg = 1, ret;
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
+	char name[BUS_ID_SIZE + 5];
 
 	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
 		       GFP_ATOMIC);
@@ -275,6 +276,9 @@ static struct scsi_device *scsi_alloc_sd
 
 	scsi_sysfs_device_initialize(sdev);
 
+ 	sprintf(name, "scsi-%s", sdev->sdev_gendev.bus_id);
+	blk_queue_stat_create(sdev->request_queue, name);
+
 	if (shost->hostt->slave_alloc) {
 		ret = shost->hostt->slave_alloc(sdev);
 		if (ret) {
diff -urp a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	2006-10-08 22:28:01.000000000 +0200
+++ b/drivers/scsi/scsi.c	2006-10-08 22:27:56.000000000 +0200
@@ -577,6 +577,7 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 		cmd->result = (DID_NO_CONNECT << 16);
 		scsi_done(cmd);
 	} else {
+		blk_queue_stat_issue(sdev->request_queue, cmd->request);
 		rtn = host->hostt->queuecommand(cmd, scsi_done);
 	}
 	spin_unlock_irqrestore(host->host_lock, flags);
@@ -660,6 +661,8 @@ void __scsi_done(struct scsi_cmnd *cmd)
 
 	BUG_ON(!rq);
 
+	blk_queue_stat_complete(sdev->request_queue, rq);
+
 	/*
 	 * The uptodate/nbytes values don't matter, as we allow partial
 	 * completes and thus will check this in the softirq callback



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWGNJjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWGNJjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWGNJjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:39:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59453 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964812AbWGNJjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:39:09 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH 3/3] Remove ->rq_status from struct request
Date: Fri, 14 Jul 2006 11:41:56 +0200
Message-Id: <11528701161769-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11528701161633-git-send-email-axboe@suse.de>
References: <11528701161633-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After Christophs SCSI change, the only usage left is RQ_ACTIVE
and RQ_INACTIVE. The block layer sets RQ_INACTIVE right before freeing
the request, so any check for RQ_INACTIVE in a driver is a bug and
indicates use-after-free.

So kill/clean the remaining users, straight forward.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 arch/um/drivers/ubd_kern.c |    2 --
 block/ll_rw_blk.c          |    3 ---
 drivers/block/paride/pd.c  |    1 -
 drivers/block/swim3.c      |    4 ++--
 drivers/block/swim_iop.c   |    4 ++--
 drivers/fc4/fc.c           |    1 -
 drivers/ide/ide-floppy.c   |    3 +--
 drivers/ide/ide-io.c       |    1 -
 drivers/ide/ide-tape.c     |    4 ++--
 drivers/scsi/ide-scsi.c    |    2 +-
 drivers/scsi/scsi.c        |    2 +-
 include/linux/blkdev.h     |   13 +++++--------
 12 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 3408531..baa98eb 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -986,8 +986,6 @@ static int prepare_request(struct reques
 	__u64 offset;
 	int len;
 
-	if(req->rq_status == RQ_INACTIVE) return(1);
-
 	/* This should be impossible now */
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n",
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 06b1fec..09df381 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -283,7 +283,6 @@ static inline void rq_init(request_queue
 	INIT_LIST_HEAD(&rq->donelist);
 
 	rq->errors = 0;
-	rq->rq_status = RQ_ACTIVE;
 	rq->bio = rq->biotail = NULL;
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
@@ -2650,8 +2649,6 @@ void __blk_put_request(request_queue_t *
 
 	elv_completed_request(q, req);
 
-	req->rq_status = RQ_INACTIVE;
-
 	/*
 	 * Request may not have originated from ll_rw_blk. if not,
 	 * it didn't come out of our reserved rq pools
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 87f6828..975d071 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -719,7 +719,6 @@ static int pd_special_command(struct pd_
 
 	memset(&rq, 0, sizeof(rq));
 	rq.errors = 0;
-	rq.rq_status = RQ_ACTIVE;
 	rq.rq_disk = disk->gd;
 	rq.ref_count = 1;
 	rq.end_io_data = &wait;
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index cc42e76..f2305ee 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -319,8 +319,8 @@ #if 0
 		printk("do_fd_req: dev=%s cmd=%d sec=%ld nr_sec=%ld buf=%p\n",
 		       req->rq_disk->disk_name, req->cmd,
 		       (long)req->sector, req->nr_sectors, req->buffer);
-		printk("           rq_status=%d errors=%d current_nr_sectors=%ld\n",
-		       req->rq_status, req->errors, req->current_nr_sectors);
+		printk("           errors=%d current_nr_sectors=%ld\n",
+		       req->errors, req->current_nr_sectors);
 #endif
 
 		if (req->sector < 0 || req->sector >= fs->total_secs) {
diff --git a/drivers/block/swim_iop.c b/drivers/block/swim_iop.c
index 89e3c2f..dfda796 100644
--- a/drivers/block/swim_iop.c
+++ b/drivers/block/swim_iop.c
@@ -529,8 +529,8 @@ #if 0
 		printk("do_fd_req: dev=%s cmd=%d sec=%ld nr_sec=%ld buf=%p\n",
 		       CURRENT->rq_disk->disk_name, CURRENT->cmd,
 		       CURRENT->sector, CURRENT->nr_sectors, CURRENT->buffer);
-		printk("           rq_status=%d errors=%d current_nr_sectors=%ld\n",
-		       CURRENT->rq_status, CURRENT->errors, CURRENT->current_nr_sectors);
+		printk("           errors=%d current_nr_sectors=%ld\n",
+		      CURRENT->errors, CURRENT->current_nr_sectors);
 #endif
 
 		if (CURRENT->sector < 0 || CURRENT->sector >= fs->total_secs) {
diff --git a/drivers/fc4/fc.c b/drivers/fc4/fc.c
index 66d03f2..0c5a3b2 100644
--- a/drivers/fc4/fc.c
+++ b/drivers/fc4/fc.c
@@ -974,7 +974,6 @@ #if 0 /* broken junk, but if davem wants
 	 */
 
 	fc->rst_pkt->device->host->eh_action = &sem;
-	fc->rst_pkt->request->rq_status = RQ_SCSI_BUSY;
 
 	fc->rst_pkt->done = fcp_scsi_reset_done;
 
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index adbe9f7..908f3da 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1281,8 +1281,7 @@ static ide_startstop_t idefloppy_do_requ
 	idefloppy_pc_t *pc;
 	unsigned long block = (unsigned long)block_s;
 
-	debug_log(KERN_INFO "rq_status: %d, dev: %s, flags: %lx, errors: %d\n",
-			rq->rq_status,
+	debug_log(KERN_INFO "dev: %s, flags: %lx, errors: %d\n",
 			rq->rq_disk ? rq->rq_disk->disk_name : "?",
 			rq->flags, rq->errors);
 	debug_log(KERN_INFO "sector: %ld, nr_sectors: %ld, "
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 8753a50..f491b71 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1710,7 +1710,6 @@ int ide_do_drive_cmd (ide_drive_t *drive
 	int must_wait = (action == ide_wait || action == ide_head_wait);
 
 	rq->errors = 0;
-	rq->rq_status = RQ_ACTIVE;
 
 	/*
 	 * we need to hold an extra reference to request for safe inspection
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index acf2e4f..e0899d6 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2423,8 +2423,8 @@ static ide_startstop_t idetape_do_reques
 #if IDETAPE_DEBUG_LOG
 #if 0
 	if (tape->debug_level >= 5)
-		printk(KERN_INFO "ide-tape: rq_status: %d, "
-			"dev: %s, cmd: %ld, errors: %d\n", rq->rq_status,
+		printk(KERN_INFO "ide-tape:  %d, "
+			"dev: %s, cmd: %ld, errors: %d\n",
 			 rq->rq_disk->disk_name, rq->cmd[0], rq->errors);
 #endif
 	if (tape->debug_level >= 2)
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index f7b5d73..b6b223f 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -708,7 +708,7 @@ static ide_startstop_t idescsi_issue_pc 
 static ide_startstop_t idescsi_do_request (ide_drive_t *drive, struct request *rq, sector_t block)
 {
 #if IDESCSI_DEBUG_LOG
-	printk (KERN_INFO "rq_status: %d, dev: %s, cmd: %x, errors: %d\n",rq->rq_status, rq->rq_disk->disk_name,rq->cmd[0],rq->errors);
+	printk (KERN_INFO "dev: %s, cmd: %x, errors: %d\n", rq->rq_disk->disk_name,rq->cmd[0],rq->errors);
 	printk (KERN_INFO "sector: %ld, nr_sectors: %ld, current_nr_sectors: %d\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
 #endif /* IDESCSI_DEBUG_LOG */
 
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 2ab7df0..07161f3 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -1047,7 +1047,7 @@ int scsi_device_cancel(struct scsi_devic
 
 	spin_lock_irqsave(&sdev->list_lock, flags);
 	list_for_each_entry(scmd, &sdev->cmd_list, list) {
-		if (scmd->request && scmd->request->rq_status != RQ_INACTIVE) {
+		if (scmd->request) {
 			/*
 			 * If we are unable to remove the timer, it means
 			 * that the command has already timed out or
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1370687..73b0eeb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -160,8 +160,6 @@ struct request {
 
 	void *completion_data;
 
-	int rq_status;	/* should split this into a few status bits */
-	int errors;
 	struct gendisk *rq_disk;
 	unsigned long start_time;
 
@@ -179,14 +177,16 @@ struct request {
 
 	unsigned short ioprio;
 
-	int tag;
-
-	int ref_count;
 	request_queue_t *q;
 
 	void *special;
 	char *buffer;
 
+	int tag;
+	int errors;
+
+	int ref_count;
+
 	/*
 	 * when request is used as a packet command carrier
 	 */
@@ -441,9 +441,6 @@ struct request_queue
 	struct mutex		sysfs_lock;
 };
 
-#define RQ_INACTIVE		(-1)
-#define RQ_ACTIVE		1
-
 #define QUEUE_FLAG_CLUSTER	0	/* cluster several segments into 1 */
 #define QUEUE_FLAG_QUEUED	1	/* uses generic tag queueing */
 #define QUEUE_FLAG_STOPPED	2	/* queue is stopped */
-- 
1.4.1.ged0e0


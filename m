Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUIWXh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUIWXh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267440AbUIWXfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:35:40 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:64493 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267445AbUIWXcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:32:45 -0400
Date: Fri, 24 Sep 2004 08:32:33 +0900
From: Masao Fukuchi <fukuchi.masao@jp.fujitsu.com>
Subject: [RFC]transient transport error report for LLD timeout
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-id: <200409232332.AA03619@fukuchi.jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are now planning to use linux for enterprise system.
In enterprise system, response time is important factor and it requires 
response time within 30sec even if hardware(software) fails.
Currently, default value for LLD(SCSI) timeout is 30sec and it doesn't 
satisfy our requirement.
So, we consider to modify timeout value and recovery sequence to fit 30sec.

At first, I considered to shorten timeout value for LLD.
http://marc.theaimsgroup.com/?l=bk-commits-head&m=108431509014051&w=2
I tested timeout value at 10sec.
The result was SCSI layer detects timeout at 10sec, but then recovery 
sequence(abort, reset etc.) is performed and it takes over 20sec until 
it returns to upper(RAID/multipath) layer.

Therefore, I newly prepared timer in block layer.
When it detects timeout, it responds to upper(RAID/multipath) layer and
upper layer begins retry operation using alt-disk/alt-path.
Resource using in block and SCSI(LLD) layer is freed when it receives 
response from LLD(SCSI) layer.

The sequence is as follows.

 host          RAID          block         SCSI          disk          alt-disk
 ---request--->
               ----request-->
                             timer set(ex. 10sec)
                             ----request-->
                                           timer set(30sec)
                                           ----request-->
                             (ex. 10sec)
                             timeout detect
               <--response(error)
               ------------------------request------------------------>
               <------------------response(success)--------------------
 <--response(success)
                                           (30sec)
                                           timeout detect
                                           -recovery ope->
                             <--response(error)
                             free resources

I made sample patch and tested it.
- Explanation for this patch
  - kernel 2.6.9-rc2 basis
  - Prepares /proc/sys/block/req_timeout parameter to set timeout value in
    block layer.
    The default value of this parameter is 0 and it means no check timeout.
  - This function operates only when FASTFAIL flag is set in request 
    structure from upper(RAID/multipath) layer.

- Results
  I measured response time to host when no response from disk drive.
                           1 block read             1 block write
  default(req_timeout=0)       41sec                    47sec
  10sec  (req_timeout=10)      11sec                    11sec

This patch is just trial one and it is very dirty code.
I'd like to refine this code.
If you have any comments or questions, please let me know.

Thanks,
Masao Fukuchi


diff -uarN linux-2.6.9-rc2/drivers/block/ll_rw_blk.c linux-2.6.9-
rc2te/drivers/block/ll_rw_blk.c
--- linux-2.6.9-rc2/drivers/block/ll_rw_blk.c	2004-09-14 10:24:47.000000000 +0900
+++ linux-2.6.9-rc2te/drivers/block/ll_rw_blk.c	2004-09-21 14:50:01.923234742 +0900
@@ -28,12 +28,43 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
+#include <linux/sysctl.h>
 
 /*
  * for max sense size
  */
 #include <scsi/scsi_cmnd.h>
 
+/* for transient error response */
+unsigned int request_timeout;
+
+static ctl_table req_table[] = {
+  { .ctl_name = BLOCK_REQUEST_TIMEOUT,
+    .procname = "req_timeout",
+    .data = &request_timeout,
+    .maxlen = sizeof(request_timeout),
+    .mode = 0644,
+    .proc_handler = &proc_dointvec },
+  { }
+};
+
+static ctl_table blk_root_table[] = {
+  { .ctl_name     = CTL_BLK,
+    .procname     = "block",
+    .mode         = 0555,
+    .child        = req_table },
+  { }
+};
+
+int __init blk_init_sysctl(void);
+
+static struct ctl_table_header *blk_table_header;
+
+module_param(request_timeout, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(request_timeout, "Set timeout value for request");
+
+static void request_timer_expired(unsigned long data);
+
 static void blk_unplug_work(void *data);
 static void blk_unplug_timeout(unsigned long data);
 
@@ -2158,6 +2189,11 @@
 	req->q = NULL;
 	req->rl = NULL;
 
+	/* delete timer for transient error */
+	if ((req->flags & REQ_SET_TIMER) && !(req->flags & REQ_TE_RESPONSE)) {
+		del_timer(&req->te_timeout);
+	}
+
 	/*
 	 * Request may not have originated from ll_rw_blk. if not,
 	 * it didn't come out of our reserved rq pools
@@ -2465,6 +2501,17 @@
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
 
+	/* timer set for transient error */
+	/* req->flags |= REQ_FAILFAST; for transient error test */
+	if (blk_noretry_request(req) && unlikely(request_timeout)) {
+		req->flags |= REQ_SET_TIMER;
+		init_timer(&req->te_timeout);
+		req->te_timeout.data = (unsigned long)req;
+		req->te_timeout.expires = jiffies + request_timeout*HZ;
+		req->te_timeout.function = request_timer_expired;
+		add_timer(&req->te_timeout);
+	}
+
 	add_request(q, req);
 out:
 	if (freereq)
@@ -2787,6 +2834,11 @@
 	int total_bytes, bio_nbytes, error, next_idx = 0;
 	struct bio *bio;
 
+	if ((req->flags & REQ_SET_TIMER) && (req->flags & REQ_TE_RESPONSE)) {
+		printk("already set TE_RESPONSE\n");
+		return 0;
+	}
+
 	/*
 	 * extend uptodate bool to allow < 0 value to be direct io error
 	 */
@@ -3035,6 +3087,17 @@
 
 	blk_max_low_pfn = max_low_pfn;
 	blk_max_pfn = max_pfn;
+
+	blk_init_sysctl();
+
+	return 0;
+}
+
+int __init blk_init_sysctl(void)
+{
+	blk_table_header = register_sysctl_table(blk_root_table, 1);
+	if (!blk_table_header)
+		return -ENOMEM;
 	return 0;
 }
 
@@ -3310,3 +3373,19 @@
 		kobject_put(&disk->kobj);
 	}
 }
+
+static void
+request_timer_expired(unsigned long data)
+{
+	struct request *req = (struct request *)data;
+
+	printk("request_timer_expired()!\n");
+
+	while (end_that_request_first(req, 0, req->nr_sectors))
+		;
+	req->ref_count++;
+	req->flags |= REQ_TE_RESPONSE;
+	end_that_request_last(req);
+
+	return;
+}
diff -uarN linux-2.6.9-rc2/include/linux/blkdev.h linux-2.6.9-rc2te/include/linux/blkdev.h
--- linux-2.6.9-rc2/include/linux/blkdev.h	2004-09-14 10:24:49.000000000 +0900
+++ linux-2.6.9-rc2te/include/linux/blkdev.h	2004-09-14 13:24:31.000000000 +0900
@@ -163,6 +163,9 @@
 	 * For Power Management requests
 	 */
 	struct request_pm_state *pm;
+
+	/* Used to time out for transient error response */
+	struct timer_list te_timeout;
 };
 
 /*
@@ -197,6 +200,8 @@
 	__REQ_PM_SHUTDOWN,	/* shutdown request */
 	__REQ_BAR_PREFLUSH,	/* barrier pre-flush done */
 	__REQ_BAR_POSTFLUSH,	/* barrier post-flush */
+	__REQ_TE_RESPONSE,      /* return transient error response  */
+	__REQ_SET_TIMER,        /* set timer for transient error response */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -224,6 +229,8 @@
 #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
 #define REQ_BAR_PREFLUSH	(1 << __REQ_BAR_PREFLUSH)
 #define REQ_BAR_POSTFLUSH	(1 << __REQ_BAR_POSTFLUSH)
+#define REQ_TE_RESPONSE	(1 << __REQ_TE_RESPONSE)
+#define REQ_SET_TIMER	(1 << __REQ_SET_TIMER)
 
 /*
  * State information carried for REQ_PM_SUSPEND and REQ_PM_RESUME
diff -uarN linux-2.6.9-rc2/include/linux/sysctl.h linux-2.6.9-rc2te/include/linux/sysctl.h
--- linux-2.6.9-rc2/include/linux/sysctl.h	2004-09-14 10:24:49.000000000 +0900
+++ linux-2.6.9-rc2te/include/linux/sysctl.h	2004-09-14 13:44:34.000000000 +0900
@@ -61,7 +61,8 @@
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_BLK=11		/* Block */
 };
 
 /* CTL_BUS names: */
@@ -764,6 +765,11 @@
 	ABI_FAKE_UTSNAME=6,	/* fake target utsname information */
 };
 
+/* /proc/sys/block */
+enum {
+	BLOCK_REQUEST_TIMEOUT=1,
+};
+
 #ifdef __KERNEL__
 
 extern void sysctl_init(void);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUGDMlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUGDMlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbUGDMlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:41:39 -0400
Received: from av3-2-sn4.m-sp.skanova.net ([81.228.10.113]:41096 "EHLO
	av3-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S265660AbUGDMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:41:21 -0400
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix race in pktcdvd kernel thread handling
References: <m2lli36ec9.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 04 Jul 2004 14:30:08 +0200
In-Reply-To: <m2lli36ec9.fsf@telia.com>
Message-ID: <m28ye0uf8v.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running "pktsetup -d" immediately after running "pktsetup" can
deadlock, because if the kcdrwd thread hasn't flushed the pending
signals before pkt_remove_dev() calls kill_proc(), kcdrwd() will not
be woken up.

This patch fixes it by making sure the kcdrwd() thread has finished
its initialization before the thread creator returns from
pkt_new_dev().


Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/block/pktcdvd.c |    9 ++++++---
 linux-petero/include/linux/pktcdvd.h |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff -puN drivers/block/pktcdvd.c~packet-kthread-race-fix drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-kthread-race-fix	2004-07-04 14:09:40.183162592 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-07-04 14:09:40.192161224 +0200
@@ -1182,6 +1182,8 @@ static int kcdrwd(void *foobar)
 	siginitsetinv(&current->blocked, sigmask(SIGKILL));
 	flush_signals(current);
 
+	up(&pd->cdrw.thr_sem);
+
 	for (;;) {
 		DECLARE_WAITQUEUE(wait, current);
 
@@ -1276,7 +1278,7 @@ work_to_do:
 		pkt_iosched_process_queue(pd);
 	}
 
-	complete_and_exit(&pd->cdrw.thr_compl, 0);
+	up(&pd->cdrw.thr_sem);
 	return 0;
 }
 
@@ -2407,7 +2409,7 @@ static int pkt_new_dev(struct pktcdvd_de
 	sprintf(pd->name, "pktcdvd%d", minor);
 	atomic_set(&pd->refcnt, 0);
 	init_waitqueue_head(&pd->wqueue);
-	init_completion(&pd->cdrw.thr_compl);
+	init_MUTEX_LOCKED(&pd->cdrw.thr_sem);
 
 	pkt_init_queue(pd);
 
@@ -2418,6 +2420,7 @@ static int pkt_new_dev(struct pktcdvd_de
 		ret = -EBUSY;
 		goto out_thread;
 	}
+	down(&pd->cdrw.thr_sem);
 
 	create_proc_read_entry(pd->name, 0, pkt_proc, pkt_read_proc, pd);
 	DPRINTK("pktcdvd: writer %d mapped to %s\n", minor, bdevname(bdev, b));
@@ -2484,7 +2487,7 @@ static int pkt_remove_dev(struct pktcdvd
 			printk("pkt_remove_dev: can't kill kernel thread\n");
 			return ret;
 		}
-		wait_for_completion(&pd->cdrw.thr_compl);
+		down(&pd->cdrw.thr_sem);
 	}
 
 	/*
diff -puN include/linux/pktcdvd.h~packet-kthread-race-fix include/linux/pktcdvd.h
--- linux/include/linux/pktcdvd.h~packet-kthread-race-fix	2004-07-04 14:09:40.185162288 +0200
+++ linux-petero/include/linux/pktcdvd.h	2004-07-04 14:09:40.192161224 +0200
@@ -140,7 +140,7 @@ struct packet_cdrw
 	spinlock_t		active_list_lock; /* Serialize access to pkt_active_list */
 	pid_t			pid;
 	int			time_to_die;
-	struct completion	thr_compl;
+	struct semaphore	thr_sem;
 	elevator_merge_fn	*elv_merge_fn;
 	elevator_completed_req_fn *elv_completed_req_fn;
 	merge_requests_fn	*merge_requests_fn;
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

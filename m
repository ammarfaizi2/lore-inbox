Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSEaFxT>; Fri, 31 May 2002 01:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315155AbSEaFxS>; Fri, 31 May 2002 01:53:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62401 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315120AbSEaFxQ>;
	Fri, 31 May 2002 01:53:16 -0400
Date: Fri, 31 May 2002 07:53:12 +0200
From: Jens Axboe <axboe@suse.de>
To: system_lists@nullzone.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - raid1 erros on compile
Message-ID: <20020531055312.GF841@suse.de>
In-Reply-To: <5.1.0.14.2.20020530073357.00cba7d8@192.168.2.131> <5.1.0.14.2.20020530073357.00cba7d8@192.168.2.131> <5.1.0.14.2.20020530212421.02cb50e8@192.168.2.131>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30 2002, system_lists@nullzone.org wrote:
> Well its not on raid1.c file.
> It must be invoqued just from any funtion_structure_reference.

Here's the complete tq_disk update patch against 2.5.19, the raid part
was sent by way of William Brack.

diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Thu May 30 09:16:43 2002
+++ b/drivers/ide/ide.c	Thu May 30 09:16:43 2002
@@ -1020,8 +1020,7 @@
 		mod_timer(&channel->timer, sleep);
 		/* we purposely leave hwgroup busy while sleeping */
 	} else {
-		/* Ugly, but how can we sleep for the lock otherwise? perhaps
-		 * from tq_disk? */
+		/* Ugly, but how can we sleep for the lock otherwise? */
 		ide_release_lock(&irq_lock);/* for atari only */
 		clear_bit(IDE_BUSY, channel->active);
 	}
diff -Nru a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
--- a/fs/jfs/jfs_logmgr.c	Thu May 30 09:16:43 2002
+++ b/fs/jfs/jfs_logmgr.c	Thu May 30 09:16:43 2002
@@ -1813,7 +1813,7 @@
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
 	submit_bio(READ, bio);
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 
 	wait_event(bp->l_ioevent, (bp->l_flag != lbmREAD));
 
@@ -1958,7 +1958,7 @@
 	submit_bio(WRITE, bio);
 
 	INCREMENT(lmStat.submitted);
-	run_task_queue(&tq_disk);
+	blk_run_queues();
 
 	jFYI(1, ("lbmStartIO done\n"));
 }
diff -Nru a/include/linux/raid/md_k.h b/include/linux/raid/md_k.h
--- a/include/linux/raid/md_k.h	Thu May 30 09:16:43 2002
+++ b/include/linux/raid/md_k.h	Thu May 30 09:16:43 2002
@@ -355,7 +355,7 @@
 		if (condition)						\
 			break;						\
 		spin_unlock_irq(&lock);					\
-		run_task_queue(&tq_disk);				\
+		blk_run_queues();					\
 		schedule();						\
 		spin_lock_irq(&lock);					\
 	}								\
@@ -381,7 +381,7 @@
 		set_current_state(TASK_UNINTERRUPTIBLE);		\
 		if (condition)						\
 			break;						\
-		run_task_queue(&tq_disk);				\
+		blk_run_queues();					\
 		schedule();						\
 	}								\
 	current->state = TASK_RUNNING;					\
diff -Nru a/kernel/suspend.c b/kernel/suspend.c
--- a/kernel/suspend.c	Thu May 30 09:16:43 2002
+++ b/kernel/suspend.c	Thu May 30 09:16:43 2002
@@ -307,7 +307,8 @@
 static void do_suspend_sync(void)
 {
 	while (1) {
-		run_task_queue(&tq_disk);
+		blk_run_queues();
+#error this is broken, FIXME
 		if (!TQ_ACTIVE(tq_disk))
 			break;
 		printk(KERN_ERR "Hm, tq_disk is not empty after run_task_queue\n");
--- linux/fs/ufs/truncate.c~	2002-05-31 07:52:14.000000000 +0200
+++ linux/fs/ufs/truncate.c	2002-05-31 07:52:27.000000000 +0200
@@ -453,7 +453,7 @@
 			break;
 		if (IS_SYNC(inode) && (inode->i_state & I_DIRTY))
 			ufs_sync_inode (inode);
-		run_task_queue(&tq_disk);
+		blk_run_queues();
 		yield();
 	}
 	offset = inode->i_size & uspi->s_fshift;

-- 
Jens Axboe


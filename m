Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266946AbRGMERV>; Fri, 13 Jul 2001 00:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266950AbRGMERL>; Fri, 13 Jul 2001 00:17:11 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:24296 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267455AbRGMERA>; Fri, 13 Jul 2001 00:17:00 -0400
Message-ID: <3B4E7666.EFD7CC89@uow.edu.au>
Date: Fri, 13 Jul 2001 14:17:42 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <3B4CE556.9000608@switchmanagement.com> <Pine.LNX.4.31.0107120749520.21040-100000@llarsh-pc2.us.oracle.com> <3B4E6468.414EF6B5@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Lance Larsh wrote:
> >
> > And while we're talking about comparing configurations, I'll mention that
> > I'm currently trying to compare raw and ext2 (no lvm in either case).
> 
> It would be interesting to see some numbers for ext3 with full
> data journalling.
> 
> Some preliminary testing by Neil Brown shows that ext3 is 1.5x faster
> than ext2 when used with knfsd, mounted synchronously.  (This uses
> O_SYNC internally).

I just did some testing with local filesystems - running `dbench 4'
on ext2-on-iDE and ext3-on-IDE, where dbench was altered to open
files O_SYNC.  Journal size was 400 megs, mount options `data=journal'

ext2: Throughput 2.71849 MB/sec (NB=3.39812 MB/sec  27.1849 MBit/sec)
ext3: Throughput 12.3623 MB/sec (NB=15.4529 MB/sec  123.623 MBit/sec)

ext3 patches are at http://www.uow.edu.au/~andrewm/linux/ext3/

The difference will be less dramatic with large, individual writes.

Be aware though that ext3 breaks both RAID1 and RAID5.  This
RAID patch should help:


--- linux-2.4.6/drivers/md/raid1.c	Wed Jul  4 18:21:26 2001
+++ lk-ext3/drivers/md/raid1.c	Thu Jul 12 15:27:09 2001
@@ -46,6 +46,30 @@
 #define PRINTK(x...)  do { } while (0)
 #endif
 
+#define __raid1_wait_event(wq, condition) 				\
+do {									\
+	wait_queue_t __wait;						\
+	init_waitqueue_entry(&__wait, current);				\
+									\
+	add_wait_queue(&wq, &__wait);					\
+	for (;;) {							\
+		set_current_state(TASK_UNINTERRUPTIBLE);		\
+		if (condition)						\
+			break;						\
+		run_task_queue(&tq_disk);				\
+		schedule();						\
+	}								\
+	current->state = TASK_RUNNING;					\
+	remove_wait_queue(&wq, &__wait);				\
+} while (0)
+
+#define raid1_wait_event(wq, condition) 				\
+do {									\
+	if (condition)	 						\
+		break;							\
+	__raid1_wait_event(wq, condition);				\
+} while (0)
+
 
 static mdk_personality_t raid1_personality;
 static md_spinlock_t retry_list_lock = MD_SPIN_LOCK_UNLOCKED;
@@ -83,7 +107,7 @@ static struct buffer_head *raid1_alloc_b
 			cnt--;
 		} else {
 			PRINTK("raid1: waiting for %d bh\n", cnt);
-			wait_event(conf->wait_buffer, conf->freebh_cnt >= cnt);
+			raid1_wait_event(conf->wait_buffer, conf->freebh_cnt >= cnt);
 		}
 	}
 	return bh;
@@ -170,7 +194,7 @@ static struct raid1_bh *raid1_alloc_r1bh
 			memset(r1_bh, 0, sizeof(*r1_bh));
 			return r1_bh;
 		}
-		wait_event(conf->wait_buffer, conf->freer1);
+		raid1_wait_event(conf->wait_buffer, conf->freer1);
 	} while (1);
 }
 
--- linux-2.4.6/drivers/md/raid5.c	Wed Jul  4 18:21:26 2001
+++ lk-ext3/drivers/md/raid5.c	Thu Jul 12 21:31:55 2001
@@ -66,10 +66,11 @@ static inline void __release_stripe(raid
 			BUG();
 		if (atomic_read(&conf->active_stripes)==0)
 			BUG();
-		if (test_bit(STRIPE_DELAYED, &sh->state))
-			list_add_tail(&sh->lru, &conf->delayed_list);
-		else if (test_bit(STRIPE_HANDLE, &sh->state)) {
-			list_add_tail(&sh->lru, &conf->handle_list);
+		if (test_bit(STRIPE_HANDLE, &sh->state)) {
+			if (test_bit(STRIPE_DELAYED, &sh->state))
+				list_add_tail(&sh->lru, &conf->delayed_list);
+			else
+				list_add_tail(&sh->lru, &conf->handle_list);
 			md_wakeup_thread(conf->thread);
 		} else {
 			if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state)) {
@@ -1167,10 +1168,9 @@ static void raid5_unplug_device(void *da
 
 	raid5_activate_delayed(conf);
 	
-	if (conf->plugged) {
-		conf->plugged = 0;
-		md_wakeup_thread(conf->thread);
-	}	
+	conf->plugged = 0;
+	md_wakeup_thread(conf->thread);
+
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 }

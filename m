Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbRGLLd7>; Thu, 12 Jul 2001 07:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267479AbRGLLdt>; Thu, 12 Jul 2001 07:33:49 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:55430 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267478AbRGLLdd>; Thu, 12 Jul 2001 07:33:33 -0400
Message-ID: <3B4D8B5D.E9530B60@uow.edu.au>
Date: Thu, 12 Jul 2001 21:34:53 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au> <021801c10a03$62434540$e1de11cc@csihq.com> <3B4C729B.6352A443@uow.edu.au> <05c401c10ac1$0e81ad70$e1de11cc@csihq.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
> Nope -- still locked up on 8 threads....however...it's apparently not RAID1
> causing this.


Well, aside from the RAID problems which we're triggering, you're
seeing interactions between RAID, ext3 and the VM.   There's
another raid1 patch here, please.

> I'm repeating this now on my SCSI 7x36G RAID5 set and seeing similar
> behavior.  It's a little better though since its SCSI.

RAID5 had a bug which would cause long stalls - ext3 triggered
it.  It's fixed in 2.4.7-pre.  I include that diff here, although
it'd be surprising if you were hitting it with that workload.

> ...
> I've got a vmstat running in a window and it pauses a lot.  When I was
> testing the IDE RAID1 it paused (locked?) for a LONG time.

That's typical behaviour for an out-of-memory condition.

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

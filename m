Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbRGMMXD>; Fri, 13 Jul 2001 08:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267314AbRGMMWw>; Fri, 13 Jul 2001 08:22:52 -0400
Received: from picard.csihq.com ([204.17.222.1]:55766 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S267057AbRGMMWg>;
	Fri, 13 Jul 2001 08:22:36 -0400
Message-ID: <036e01c10b96$72ce57d0$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "Andrew Morton" <andrewm@uow.edu.au>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au> <021801c10a03$62434540$e1de11cc@csihq.com> <3B4C729B.6352A443@uow.edu.au> <05c401c10ac1$0e81ad70$e1de11cc@csihq.com> <3B4D8B5D.E9530B60@uow.edu.au>
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246
Date: Fri, 13 Jul 2001 08:22:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't done the RAID5 patch yet but I think one big problem is ext3
interaction with kswapd
My tiobench finally completed

tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  64.71 51.4% 0.826 2.00% 21.78 32.7% 1.218 0.85%
   .     4000   4096    2  23.28 21.7% 0.935 1.76% 7.374 39.1% 1.261 0.96%
   .     4000   4096    4  20.74 20.7% 1.087 2.50% 5.399 46.8% 1.278 1.09%
   .     4000   4096    8  18.60 19.1% 1.265 2.67% 3.106 63.6% 1.286 1.17%

The CPU culprit is kswapd...this is apparently why the system appears to
lock up.
I don't even have swap turned on.
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    3 root      14   0     0    0     0 RW   85.6  0.0  39:50 kswapd

And...when I switch back to ext2 and do the same test:kswapd barely gets
used at all:
tiobench.pl --size 4000
Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/secd . -T

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     4000   4096    1  62.54 46.0% 0.806 2.27% 29.97 27.7% 1.343 0.94%
   .     4000   4096    2  56.10 46.9% 1.030 3.03% 28.18 26.7% 1.320 1.30%
   .     4000   4096    4  39.46 35.0% 1.204 3.34% 17.16 16.2% 1.309 1.28%
   .     4000   4096    8  33.80 31.0% 1.384 3.74% 14.26 13.7% 1.309 1.21%


So...my question is why does ext3 cause kswapd to go nuts?

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Andrew Morton" <andrewm@uow.edu.au>
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>;
<ext2-devel@lists.sourceforge.net>
Sent: Thursday, July 12, 2001 7:34 AM
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246


Mike Black wrote:
>
> Nope -- still locked up on 8 threads....however...it's apparently not
RAID1
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

--- linux-2.4.6/drivers/md/raid1.c Wed Jul  4 18:21:26 2001
+++ lk-ext3/drivers/md/raid1.c Thu Jul 12 15:27:09 2001
@@ -46,6 +46,30 @@
 #define PRINTK(x...)  do { } while (0)
 #endif

+#define __raid1_wait_event(wq, condition) \
+do { \
+ wait_queue_t __wait; \
+ init_waitqueue_entry(&__wait, current); \
+ \
+ add_wait_queue(&wq, &__wait); \
+ for (;;) { \
+ set_current_state(TASK_UNINTERRUPTIBLE); \
+ if (condition) \
+ break; \
+ run_task_queue(&tq_disk); \
+ schedule(); \
+ } \
+ current->state = TASK_RUNNING; \
+ remove_wait_queue(&wq, &__wait); \
+} while (0)
+
+#define raid1_wait_event(wq, condition) \
+do { \
+ if (condition) \
+ break; \
+ __raid1_wait_event(wq, condition); \
+} while (0)
+

 static mdk_personality_t raid1_personality;
 static md_spinlock_t retry_list_lock = MD_SPIN_LOCK_UNLOCKED;
@@ -83,7 +107,7 @@ static struct buffer_head *raid1_alloc_b
  cnt--;
  } else {
  PRINTK("raid1: waiting for %d bh\n", cnt);
- wait_event(conf->wait_buffer, conf->freebh_cnt >= cnt);
+ raid1_wait_event(conf->wait_buffer, conf->freebh_cnt >= cnt);
  }
  }
  return bh;
@@ -170,7 +194,7 @@ static struct raid1_bh *raid1_alloc_r1bh
  memset(r1_bh, 0, sizeof(*r1_bh));
  return r1_bh;
  }
- wait_event(conf->wait_buffer, conf->freer1);
+ raid1_wait_event(conf->wait_buffer, conf->freer1);
  } while (1);
 }

--- linux-2.4.6/drivers/md/raid5.c Wed Jul  4 18:21:26 2001
+++ lk-ext3/drivers/md/raid5.c Thu Jul 12 21:31:55 2001
@@ -66,10 +66,11 @@ static inline void __release_stripe(raid
  BUG();
  if (atomic_read(&conf->active_stripes)==0)
  BUG();
- if (test_bit(STRIPE_DELAYED, &sh->state))
- list_add_tail(&sh->lru, &conf->delayed_list);
- else if (test_bit(STRIPE_HANDLE, &sh->state)) {
- list_add_tail(&sh->lru, &conf->handle_list);
+ if (test_bit(STRIPE_HANDLE, &sh->state)) {
+ if (test_bit(STRIPE_DELAYED, &sh->state))
+ list_add_tail(&sh->lru, &conf->delayed_list);
+ else
+ list_add_tail(&sh->lru, &conf->handle_list);
  md_wakeup_thread(conf->thread);
  } else {
  if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state)) {
@@ -1167,10 +1168,9 @@ static void raid5_unplug_device(void *da

  raid5_activate_delayed(conf);

- if (conf->plugged) {
- conf->plugged = 0;
- md_wakeup_thread(conf->thread);
- }
+ conf->plugged = 0;
+ md_wakeup_thread(conf->thread);
+
  spin_unlock_irqrestore(&conf->device_lock, flags);
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSGYPKj>; Thu, 25 Jul 2002 11:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSGYPKj>; Thu, 25 Jul 2002 11:10:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:5073 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315437AbSGYPKh>;
	Thu, 25 Jul 2002 11:10:37 -0400
Date: Thu, 25 Jul 2002 20:45:12 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Patch 2.5.25: Ensure xtime_lock and timerlist_lock are on difft cachelines
Message-ID: <20020725204512.E3594@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that xtime_lock and timerlist_lock ends up on the same
cacheline  all the time (atleaset on x86).  Not a good thing for
loads with high xxx_timer and do_gettimeofday counts I guess (networking etc).

Here's a 2.5.25 objdump:

c0302780 g     O .data  00000004 time_freq
c0302784 g     O .data  00000004 timerlist_lock
c0302788 g     O .data  00000004 tqueue_lock
c030278c g     O .data  00000004 xtime_lock
c0302790 l     O .data  00000004 count.3
c0302794 l     O .data  00000004 uidhash_lock
c0302798 g     O .data  00000018 root_user

Here's a trivial 2.5.28 based fix.  

-Kiran

diff -ruN -X dontdiff linux-2.5.28/kernel/timer.c align_locks/kernel/timer.c
--- linux-2.5.28/kernel/timer.c	Thu Jul 25 02:33:23 2002
+++ align_locks/kernel/timer.c	Thu Jul 25 18:17:46 2002
@@ -169,7 +169,7 @@
 }
 
 /* Initialize both explicitly - let's try to have them in the same cache line */
-spinlock_t timerlist_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t timerlist_lock ____cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 #ifdef CONFIG_SMP
 volatile struct timer_list * volatile running_timer;
@@ -327,7 +327,7 @@
 	spin_unlock_irq(&timerlist_lock);
 }
 
-spinlock_t tqueue_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t tqueue_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 void tqueue_bh(void)
 {
@@ -633,7 +633,7 @@
  * This read-write spinlock protects us from races in SMP while
  * playing with xtime and avenrun.
  */
-rwlock_t xtime_lock = RW_LOCK_UNLOCKED;
+rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
 unsigned long last_time_offset;
 
 static inline void update_times(void)

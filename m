Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264675AbSIWBk0>; Sun, 22 Sep 2002 21:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSIWBk0>; Sun, 22 Sep 2002 21:40:26 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:59402 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S264675AbSIWBkZ>; Sun, 22 Sep 2002 21:40:25 -0400
Message-ID: <3D8E7214.8020600@zk3.dec.com>
Date: Sun, 22 Sep 2002 21:44:52 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38
References: <Pine.LNX.4.44.0209222220490.9027-100000@alpha.bocc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Friedrich wrote:

>Hi,
>
>sorry for the first post as Alexander Viro already posted a fix. Now, this
>is a real Alpha problem, it seems (it has been there in 2.5.37, as well):
>
>build fails on Alpha:
>  
>
Patch below fixes the problem.  Linus, please apply.  Here's hoping Mozilla
doesn't blow up the patch; please let me know if it does and I'll try to create
a bk patch for this.

 - Pete

diff -Nru a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
--- a/arch/alpha/kernel/time.c  Sun Sep 22 08:01:47 2002
+++ b/arch/alpha/kernel/time.c  Sun Sep 22 08:01:47 2002
@@ -57,6 +57,8 @@
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
+#define TICK_SIZE (tick_nsec / 1000)
+
 /*
  * Shift amount by which scaled_ticks_per_cycle is scaled.  Shifting
  * by 48 gives us 16 bits for HZ while keeping the accuracy good even
@@ -129,8 +131,8 @@
         */
        if ((time_status & STA_UNSYNC) == 0
            && xtime.tv_sec > state.last_rtc_update + 660
-           && xtime.tv_usec >= 500000 - ((unsigned) tick) / 2
-           && xtime.tv_usec <= 500000 + ((unsigned) tick) / 2) {
+           && xtime.tv_nsec >= 500000 - ((unsigned) TICK_SIZE) / 2
+           && xtime.tv_nsec <= 500000 + ((unsigned) TICK_SIZE) / 2) {
                int tmp = set_rtc_mmss(xtime.tv_sec);
                state.last_rtc_update = xtime.tv_sec - (tmp ? 600 : 0);
        }
@@ -365,7 +367,7 @@
                year += 100;
 
        xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-       xtime.tv_usec = 0;
+       xtime.tv_nsec = 0;
 
        if (HZ > (1<<16)) {
                extern void __you_loose (void);
@@ -414,7 +416,7 @@
 
        delta_cycles = rpcc() - state.last_time;
        sec = xtime.tv_sec;
-       usec = xtime.tv_usec;
+       usec = (xtime.tv_nsec / 1000);
        partial_tick = state.partial_tick;
        lost = jiffies - wall_jiffies;
 
@@ -485,7 +487,7 @@
        }
 
        xtime.tv_sec = sec;
-       xtime.tv_usec = usec;
+       xtime.tv_nsec = (usec / 1000);
        time_adjust = 0;                /* stop active adjtime() */
        time_status |= STA_UNSYNC;
        time_maxerror = NTP_PHASE_LIMIT;
diff -Nru a/include/asm-alpha/hardirq.h b/include/asm-alpha/hardirq.h
--- a/include/asm-alpha/hardirq.h       Sun Sep 22 08:01:47 2002
+++ b/include/asm-alpha/hardirq.h       Sun Sep 22 08:01:47 2002
@@ -74,9 +74,12 @@
 
 #define irq_enter()            (preempt_count() += HARDIRQ_OFFSET)
 
+
 #if CONFIG_PREEMPT
+#define in_atomic()    (preempt_count() != kernel_locked())
 # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
+#define in_atomic()    (preempt_count() != 0)
 #define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 # endif
 #define irq_exit()                                             \
diff -Nru a/include/asm-alpha/spinlock.h b/include/asm-alpha/spinlock.h
--- a/include/asm-alpha/spinlock.h      Sun Sep 22 08:01:47 2002
+++ b/include/asm-alpha/spinlock.h      Sun Sep 22 08:01:47 2002
@@ -100,6 +100,7 @@
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 
 #define rwlock_init(x) do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define rwlock_is_locked(x)    (*(volatile int *)(x) != 0)
 
 #if CONFIG_DEBUG_RWLOCK
 extern void _raw_write_lock(rwlock_t * lock);






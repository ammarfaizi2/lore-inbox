Return-Path: <linux-kernel-owner+w=401wt.eu-S1751453AbXAPC5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbXAPC5G (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbXAPC5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:57:06 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:34645 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbXAPC5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:57:04 -0500
Date: Mon, 15 Jan 2007 18:56:44 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       ak@suse.de, shai@scalex86.org, pravin.shelar@calsoftinc.com
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
Message-ID: <20070116025644.GA3954@localhost.localdomain>
References: <20070112160104.GA5766@localhost.localdomain> <45A86291.8090408@yahoo.com.au> <20070113073643.GA4234@localhost.localdomain> <20070113000017.2ad2df12.akpm@osdl.org> <20070113195334.GC4234@localhost.localdomain> <20070113132023.0f8d2da8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070113132023.0f8d2da8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2007 at 01:20:23PM -0800, Andrew Morton wrote:
> 
> Seeing the code helps.

But there was a subtle problem with hold time instrumentation here.
The code assumed the critical section exiting through 
spin_unlock_irq entered critical section with spin_lock_irq, but that
might not be the case always, and the instrumentation for hold time goes bad
when that happens (as in shrink_inactive_list)

> 
> >  The
> > instrumentation goes like this:
> > 
> > void __lockfunc _spin_lock_irq(spinlock_t *lock)
> > {
> >         unsigned long long t1,t2;
> >         local_irq_disable();
> >         t1 = get_cycles_sync();
> >         preempt_disable();
> >         spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> >         _raw_spin_lock(lock);
> >         t2 = get_cycles_sync();
> >         lock->raw_lock.htsc = t2;
> >         if (lock->spin_time < (t2 - t1))
> >                 lock->spin_time = t2 - t1;
> > }
> > ...
> > 
> > void __lockfunc _spin_unlock_irq(spinlock_t *lock)
> > {
> >         unsigned long long t1 ;
> >         spin_release(&lock->dep_map, 1, _RET_IP_);
> >         t1 = get_cycles_sync();
> >         if (lock->cs_time < (t1 -  lock->raw_lock.htsc))
> >                 lock->cs_time = t1 -  lock->raw_lock.htsc;
> >         _raw_spin_unlock(lock);
> >         local_irq_enable();
> >         preempt_enable();
> > }
> > 
...
> 
> OK, now we need to do a dump_stack() each time we discover a new max hold
> time.  That might a bit tricky: the printk code does spinlocking too so
> things could go recursively deadlocky.  Maybe make spin_unlock_irq() return
> the hold time then do:

What I found now after fixing the above is that hold time is not bad --
249461 cycles on the 2.6 GHZ opteron with powernow disabled in the BIOS.
The spin time is still in orders of seconds.

Hence this looks like a hardware fairness issue.

Attaching the instrumentation patch with this email FR.


Index: linux-2.6.20-rc4.spin_instru/include/asm-x86_64/spinlock.h
===================================================================
--- linux-2.6.20-rc4.spin_instru.orig/include/asm-x86_64/spinlock.h	2007-01-14 22:36:46.694248000 -0800
+++ linux-2.6.20-rc4.spin_instru/include/asm-x86_64/spinlock.h	2007-01-15 15:40:36.554248000 -0800
@@ -6,6 +6,18 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 
+/* Like get_cycles, but make sure the CPU is synchronized. */
+static inline unsigned long long get_cycles_sync2(void)
+{
+	unsigned long long ret;
+	unsigned eax;
+	/* Don't do an additional sync on CPUs where we know
+	   RDTSC is already synchronous. */
+	alternative_io("cpuid", ASM_NOP2, X86_FEATURE_SYNC_RDTSC,
+			  "=a" (eax), "0" (1) : "ebx","ecx","edx","memory");
+	rdtscll(ret);
+	return ret;
+}
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  *
@@ -34,6 +46,7 @@ static inline void __raw_spin_lock(raw_s
 		"jle 3b\n\t"
 		"jmp 1b\n"
 		"2:\t" : "=m" (lock->slock) : : "memory");
+	lock->htsc = get_cycles_sync2();
 }
 
 /*
@@ -62,6 +75,7 @@ static inline void __raw_spin_lock_flags
 		"jmp 4b\n"
 		"5:\n\t"
 		: "+m" (lock->slock) : "r" ((unsigned)flags) : "memory");
+		lock->htsc = get_cycles_sync2();
 }
 #endif
 
@@ -74,11 +88,16 @@ static inline int __raw_spin_trylock(raw
 		:"=q" (oldval), "=m" (lock->slock)
 		:"0" (0) : "memory");
 
+	if (oldval)
+		lock->htsc = get_cycles_sync2();
 	return oldval > 0;
 }
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
+	unsigned long long t = get_cycles_sync2();
+	if (lock->hold_time <  t - lock->htsc)
+		lock->hold_time = t - lock->htsc;
 	asm volatile("movl $1,%0" :"=m" (lock->slock) :: "memory");
 }
 
Index: linux-2.6.20-rc4.spin_instru/include/asm-x86_64/spinlock_types.h
===================================================================
--- linux-2.6.20-rc4.spin_instru.orig/include/asm-x86_64/spinlock_types.h	2007-01-14 22:36:46.714248000 -0800
+++ linux-2.6.20-rc4.spin_instru/include/asm-x86_64/spinlock_types.h	2007-01-15 14:23:37.204248000 -0800
@@ -7,9 +7,11 @@
 
 typedef struct {
 	unsigned int slock;
+	unsigned long long hold_time;
+	unsigned long long htsc;
 } raw_spinlock_t;
 
-#define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
+#define __RAW_SPIN_LOCK_UNLOCKED	{ 1,0,0 }
 
 typedef struct {
 	unsigned int lock;
Index: linux-2.6.20-rc4.spin_instru/include/linux/spinlock.h
===================================================================
--- linux-2.6.20-rc4.spin_instru.orig/include/linux/spinlock.h	2007-01-14 22:36:48.464248000 -0800
+++ linux-2.6.20-rc4.spin_instru/include/linux/spinlock.h	2007-01-14 22:41:30.964248000 -0800
@@ -231,8 +231,8 @@ do {								\
 # define spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
 # define read_unlock(lock)		__raw_read_unlock(&(lock)->raw_lock)
 # define write_unlock(lock)		__raw_write_unlock(&(lock)->raw_lock)
-# define spin_unlock_irq(lock) \
-    do { __raw_spin_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
+# define spin_unlock_irq(lock) _spin_unlock_irq(lock)
+/*  do { __raw_spin_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)*/
 # define read_unlock_irq(lock) \
     do { __raw_read_unlock(&(lock)->raw_lock); local_irq_enable(); } while (0)
 # define write_unlock_irq(lock) \
Index: linux-2.6.20-rc4.spin_instru/include/linux/spinlock_types.h
===================================================================
--- linux-2.6.20-rc4.spin_instru.orig/include/linux/spinlock_types.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc4.spin_instru/include/linux/spinlock_types.h	2007-01-15 14:27:50.664248000 -0800
@@ -19,6 +19,7 @@
 
 typedef struct {
 	raw_spinlock_t raw_lock;
+	unsigned long long spin_time;
 #if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
 	unsigned int break_lock;
 #endif
@@ -78,7 +79,8 @@ typedef struct {
 				RW_DEP_MAP_INIT(lockname) }
 #else
 # define __SPIN_LOCK_UNLOCKED(lockname) \
-	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED,	\
+	(spinlock_t)	{	.raw_lock = __RAW_SPIN_LOCK_UNLOCKED,\
+				.spin_time = 0	\
 				SPIN_DEP_MAP_INIT(lockname) }
 #define __RW_LOCK_UNLOCKED(lockname) \
 	(rwlock_t)	{	.raw_lock = __RAW_RW_LOCK_UNLOCKED,	\
Index: linux-2.6.20-rc4.spin_instru/kernel/spinlock.c
===================================================================
--- linux-2.6.20-rc4.spin_instru.orig/kernel/spinlock.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.20-rc4.spin_instru/kernel/spinlock.c	2007-01-15 14:29:47.374248000 -0800
@@ -99,10 +99,15 @@ EXPORT_SYMBOL(_spin_lock_irqsave);
 
 void __lockfunc _spin_lock_irq(spinlock_t *lock)
 {
+	unsigned long long t1,t2;
 	local_irq_disable();
+	t1 = get_cycles_sync();
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_spin_lock(lock);
+ 	t2 = get_cycles_sync();
+ 	if (lock->spin_time < (t2 - t1))
+ 		lock->spin_time = t2 - t1;
 }
 EXPORT_SYMBOL(_spin_lock_irq);

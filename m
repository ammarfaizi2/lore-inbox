Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262160AbSIZEEg>; Thu, 26 Sep 2002 00:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262156AbSIZEEf>; Thu, 26 Sep 2002 00:04:35 -0400
Received: from packet.digeo.com ([12.110.80.53]:39128 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262160AbSIZED7>;
	Thu, 26 Sep 2002 00:03:59 -0400
Message-ID: <3D928864.23666D93@digeo.com>
Date: Wed, 25 Sep 2002 21:09:08 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 4/4] increase traffic on linux-kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 04:09:08.0934 (UTC) FILETIME=[765BCE60:01C26512]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[This has four scalps already.  Thomas Molina has agreed
 to track things as they are identified ]

Infrastructure to detect sleep-inside-spinlock bugs.  Really only
useful if compiled with CONFIG_PREEMPT=y.  It prints out a whiny
message and a stack backtrace if someone calls a function which might
sleep from within an atomic region.

This patch generates a storm of output at boot, due to
drivers/ide/ide-probe.c:init_irq() calling lots of things which it
shouldn't under ide_lock.

It'll find other bugs too.



 include/asm-i386/semaphore.h |    4 ++--
 include/linux/kernel.h       |    7 +++++++
 include/linux/rwsem.h        |    2 ++
 kernel/ksyms.c               |    4 +++-
 kernel/sched.c               |   17 +++++++++++++++++
 mm/page_alloc.c              |    3 +++
 mm/slab.c                    |    3 +++
 7 files changed, 37 insertions(+), 3 deletions(-)

--- 2.5.38/include/asm-i386/semaphore.h~might_sleep	Wed Sep 25 20:15:27 2002
+++ 2.5.38-akpm/include/asm-i386/semaphore.h	Wed Sep 25 20:15:27 2002
@@ -116,7 +116,7 @@ static inline void down(struct semaphore
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
 		LOCK "decl %0\n\t"     /* --sem->count */
@@ -142,7 +142,7 @@ static inline int down_interruptible(str
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
 		LOCK "decl %1\n\t"     /* --sem->count */
--- 2.5.38/include/linux/kernel.h~might_sleep	Wed Sep 25 20:15:27 2002
+++ 2.5.38-akpm/include/linux/kernel.h	Wed Sep 25 20:15:27 2002
@@ -40,6 +40,13 @@
 
 struct completion;
 
+#ifdef CONFIG_DEBUG_KERNEL
+void __might_sleep(char *file, int line);
+#define might_sleep() __might_sleep(__FILE__, __LINE__)
+#else
+#define might_sleep() do {} while(0)
+#endif
+
 extern struct notifier_block *panic_notifier_list;
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
--- 2.5.38/include/linux/rwsem.h~might_sleep	Wed Sep 25 20:15:27 2002
+++ 2.5.38-akpm/include/linux/rwsem.h	Wed Sep 25 20:15:27 2002
@@ -40,6 +40,7 @@ extern void FASTCALL(rwsemtrace(struct r
  */
 static inline void down_read(struct rw_semaphore *sem)
 {
+	might_sleep();
 	rwsemtrace(sem,"Entering down_read");
 	__down_read(sem);
 	rwsemtrace(sem,"Leaving down_read");
@@ -62,6 +63,7 @@ static inline int down_read_trylock(stru
  */
 static inline void down_write(struct rw_semaphore *sem)
 {
+	might_sleep();
 	rwsemtrace(sem,"Entering down_write");
 	__down_write(sem);
 	rwsemtrace(sem,"Leaving down_write");
--- 2.5.38/kernel/ksyms.c~might_sleep	Wed Sep 25 20:15:27 2002
+++ 2.5.38-akpm/kernel/ksyms.c	Wed Sep 25 20:15:27 2002
@@ -497,7 +497,9 @@ EXPORT_SYMBOL(jiffies_64);
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
-
+#ifdef CONFIG_DEBUG_KERNEL
+EXPORT_SYMBOL(__might_sleep);
+#endif
 #if !defined(__ia64__)
 EXPORT_SYMBOL(loops_per_jiffy);
 #endif
--- 2.5.38/kernel/sched.c~might_sleep	Wed Sep 25 20:15:27 2002
+++ 2.5.38-akpm/kernel/sched.c	Wed Sep 25 20:15:28 2002
@@ -2150,3 +2150,20 @@ void __init sched_init(void)
 	enter_lazy_tlb(&init_mm, current, smp_processor_id());
 }
 
+#ifdef CONFIG_DEBUG_KERNEL
+void __might_sleep(char *file, int line)
+{
+#if defined(in_atomic)
+	static unsigned long prev_jiffy;	/* ratelimiting */
+
+	if (in_atomic()) {
+		if (time_before(jiffies, prev_jiffy + HZ))
+			return;
+		prev_jiffy = jiffies;
+		printk("Sleeping function called from illegal"
+				" context at %s:%d\n", file, line);
+		dump_stack();
+	}
+#endif
+}
+#endif
--- 2.5.38/mm/page_alloc.c~might_sleep	Wed Sep 25 20:15:27 2002
+++ 2.5.38-akpm/mm/page_alloc.c	Wed Sep 25 20:15:28 2002
@@ -321,6 +321,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 	struct page * page;
 	int freed, i;
 
+	if (gfp_mask & __GFP_WAIT)
+		might_sleep();
+
 	KERNEL_STAT_ADD(pgalloc, 1<<order);
 
 	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
--- 2.5.38/mm/slab.c~might_sleep	Wed Sep 25 20:15:27 2002
+++ 2.5.38-akpm/mm/slab.c	Wed Sep 25 20:15:28 2002
@@ -1370,6 +1370,9 @@ static inline void * __kmem_cache_alloc 
 	unsigned long save_flags;
 	void* objp;
 
+	if (flags & __GFP_WAIT)
+		might_sleep();
+
 	kmem_cache_alloc_head(cachep, flags);
 try_again:
 	local_irq_save(save_flags);

.

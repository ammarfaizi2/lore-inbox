Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264651AbSIWBEz>; Sun, 22 Sep 2002 21:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbSIWBEz>; Sun, 22 Sep 2002 21:04:55 -0400
Received: from packet.digeo.com ([12.110.80.53]:29942 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264651AbSIWBEw>;
	Sun, 22 Sep 2002 21:04:52 -0400
Message-ID: <3D8E69E3.6677AFB5@digeo.com>
Date: Sun, 22 Sep 2002 18:09:55 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Adam Kropelin <akropel1@rochester.rr.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.38-mm1
References: <3D8E6647.8B02E613@digeo.com> <1032742790.967.997.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 01:09:56.0204 (UTC) FILETIME=[EDFE2AC0:01C2629D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Sun, 2002-09-22 at 20:54, Andrew Morton wrote:
> 
> > It found a bug.  Someone is calling kmem_cache_create() in an
> > atomic region.  Plus I think that during startup, in_atomic()
> > is (probably incorrectly) returning true.
> 
> Would you mind doing a
> 
>         printk(KERN_ERR "kmem_cache_create called atomically!\n");
> 
> too?  I was confused as to what debugging check he was tripping.  Yah
> yah, looking at the trace I should of known, but I didn't know you put a
> check in there... :)

Robert, I put checks in *everywhere*.

Because I put the checks in kmem_cache_alloc(), and alloc_pages(),
and down(), and down_read(), and they have quite a lot of callers.

Here's the (updated) patch:


--- 2.5.38/include/asm-i386/semaphore.h~might_sleep	Sun Sep 22 11:55:46 2002
+++ 2.5.38-akpm/include/asm-i386/semaphore.h	Sun Sep 22 11:55:46 2002
@@ -123,7 +123,7 @@ static inline void down(struct semaphore
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
 		LOCK "decl %0\n\t"     /* --sem->count */
@@ -149,7 +149,7 @@ static inline int down_interruptible(str
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
 		LOCK "decl %1\n\t"     /* --sem->count */
--- 2.5.38/include/linux/kernel.h~might_sleep	Sun Sep 22 11:55:46 2002
+++ 2.5.38-akpm/include/linux/kernel.h	Sun Sep 22 11:55:46 2002
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
--- 2.5.38/include/linux/rwsem.h~might_sleep	Sun Sep 22 11:55:46 2002
+++ 2.5.38-akpm/include/linux/rwsem.h	Sun Sep 22 11:55:46 2002
@@ -41,6 +41,7 @@ extern void FASTCALL(rwsemtrace(struct r
  */
 static inline void down_read(struct rw_semaphore *sem)
 {
+	might_sleep();
 	rwsemtrace(sem,"Entering down_read");
 	__down_read(sem);
 	rwsemtrace(sem,"Leaving down_read");
@@ -63,6 +64,7 @@ static inline int down_read_trylock(stru
  */
 static inline void down_write(struct rw_semaphore *sem)
 {
+	might_sleep();
 	rwsemtrace(sem,"Entering down_write");
 	__down_write(sem);
 	rwsemtrace(sem,"Leaving down_write");
--- 2.5.38/kernel/ksyms.c~might_sleep	Sun Sep 22 11:55:46 2002
+++ 2.5.38-akpm/kernel/ksyms.c	Sun Sep 22 17:58:09 2002
@@ -498,7 +498,9 @@ EXPORT_SYMBOL(jiffies_64);
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
--- 2.5.38/kernel/sched.c~might_sleep	Sun Sep 22 11:55:46 2002
+++ 2.5.38-akpm/kernel/sched.c	Sun Sep 22 18:01:31 2002
@@ -2166,3 +2166,18 @@ void __init sched_init(void)
 	enter_lazy_tlb(&init_mm, current, smp_processor_id());
 }
 
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
--- 2.5.38/mm/page_alloc.c~might_sleep	Sun Sep 22 11:55:46 2002
+++ 2.5.38-akpm/mm/page_alloc.c	Sun Sep 22 17:58:09 2002
@@ -321,6 +321,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 	struct page * page;
 	int freed, i;
 
+	if (gfp_mask & __GFP_WAIT)
+		might_sleep();
+
 	KERNEL_STAT_ADD(pgalloc, 1<<order);
 
 	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
--- 2.5.38/mm/slab.c~might_sleep	Sun Sep 22 11:55:46 2002
+++ 2.5.38-akpm/mm/slab.c	Sun Sep 22 17:58:09 2002
@@ -1374,6 +1374,9 @@ static inline void * __kmem_cache_alloc 
 	unsigned long save_flags;
 	void* objp;
 
+	if (flags & __GFP_WAIT)
+		might_sleep();
+
 	kmem_cache_alloc_head(cachep, flags);
 try_again:
 	local_irq_save(save_flags);

.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318170AbSHIH7q>; Fri, 9 Aug 2002 03:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318180AbSHIH7q>; Fri, 9 Aug 2002 03:59:46 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:4495 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S318170AbSHIH7j>;
	Fri, 9 Aug 2002 03:59:39 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask_t 
In-reply-to: Your message of "Thu, 08 Aug 2002 07:36:30 MST."
             <20020808.073630.37512884.davem@redhat.com> 
Date: Fri, 09 Aug 2002 16:04:12 +1000
Message-Id: <20020809080517.E4BE5443C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020808.073630.37512884.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Thu, 08 Aug 2002 17:39:18 +1000
> 
>    I've tested this now with making cpumask_t a struct, and it works fine
>    (at the moment it's unsigned long for every arch, no change).
> 
> It worked because you cast the thing to (unsigned long *) in every
> bitops.  We either:
> 
> 1) shouldn't need to do that, meaning cpumask_t must be a long
>    or array or longs

Yes, this is the other way.  It's probably neater to just make it
completely generic and explicit.

> 2) you need to abstract away bitops on cpumask_t so that one
>    _really_ could make cpumask_t a struct with things other
>    than the mask itself inside, so cpumask_test, cpumask_add,
>    cpumask_remove or however you'd like to name them

Naah, if I make it that flexible you'll do some godawful Sparc64 hack
just to be different 8)

> Didn't we go through a lot of effort to sanitize bitops types
> and kill the ugly casts? :-))))

I never claimed to be consistent 8)

Patch renames bitmap_member to DECLARE_BITMAP, then uses it for cpu
masks.  Arch adds "cpu_online_mask(res, src)" to clear offline bits in
src.

Rusty.
PS.  Yes, Dave, an asm-generic/smp.h is coming too 8)
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Bitops Cleanup
Author: Rusty Russell
Status: Trivial

D: This renames bitmap_member to DECLARE_BITMAP, and moves it to bitops.h.

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/drivers/zorro/zorro.c linux-2.5.28.31516.updated/drivers/zorro/zorro.c
--- linux-2.5.28.31516/drivers/zorro/zorro.c	Thu Jul 25 10:13:15 2002
+++ linux-2.5.28.31516.updated/drivers/zorro/zorro.c	Fri Jul 26 16:01:10 2002
@@ -80,7 +80,7 @@ struct zorro_dev *zorro_find_device(zorr
      *  FIXME: use the normal resource management
      */
 
-bitmap_member(zorro_unused_z2ram, 128);
+DECLARE_BITMAP(zorro_unused_z2ram, 128);
 
 
 static void __init mark_region(unsigned long start, unsigned long end,
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/include/linux/bitops.h linux-2.5.28.31516.updated/include/linux/bitops.h
--- linux-2.5.28.31516/include/linux/bitops.h	Mon Jun 24 00:53:24 2002
+++ linux-2.5.28.31516.updated/include/linux/bitops.h	Fri Jul 26 15:59:03 2002
@@ -2,6 +2,9 @@
 #define _LINUX_BITOPS_H
 #include <asm/bitops.h>
 
+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
+
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
@@ -106,8 +109,5 @@ static inline unsigned int generic_hweig
         res = (res & 0x33) + ((res >> 2) & 0x33);
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
-
-#include <asm/bitops.h>
-
 
 #endif
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/include/linux/types.h linux-2.5.28.31516.updated/include/linux/types.h
--- linux-2.5.28.31516/include/linux/types.h	Mon Jun 17 23:19:25 2002
+++ linux-2.5.28.31516.updated/include/linux/types.h	Fri Jul 26 15:59:03 2002
@@ -3,9 +3,6 @@
 
 #ifdef	__KERNEL__
 #include <linux/config.h>
-
-#define bitmap_member(name,bits) \
-	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
 #endif
 
 #include <linux/posix_types.h>
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/include/linux/zorro.h linux-2.5.28.31516.updated/include/linux/zorro.h
--- linux-2.5.28.31516/include/linux/zorro.h	Thu Jul 25 10:13:18 2002
+++ linux-2.5.28.31516.updated/include/linux/zorro.h	Fri Jul 26 16:00:30 2002
@@ -10,6 +10,7 @@
 
 #ifndef _LINUX_ZORRO_H
 #define _LINUX_ZORRO_H
+#include <linux/bitops.h>
 
 #ifndef __ASSEMBLY__
 
@@ -199,7 +200,7 @@ extern struct zorro_dev *zorro_find_devi
      *  the corresponding bits.
      */
 
-extern bitmap_member(zorro_unused_z2ram, 128);
+extern DECLARE_BITMAP(zorro_unused_z2ram, 128);
 
 #define Z2RAM_START		(0x00200000)
 #define Z2RAM_END		(0x00a00000)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/include/sound/ac97_codec.h linux-2.5.28.31516.updated/include/sound/ac97_codec.h
--- linux-2.5.28.31516/include/sound/ac97_codec.h	Fri Jun 21 09:41:55 2002
+++ linux-2.5.28.31516.updated/include/sound/ac97_codec.h	Fri Jul 26 15:59:03 2002
@@ -25,6 +25,7 @@
  *
  */
 
+#include <linux/bitops.h>
 #include "control.h"
 #include "info.h"
 
@@ -169,7 +170,7 @@ struct _snd_ac97 {
 	unsigned int rates_mic_adc;
 	unsigned int spdif_status;
 	unsigned short regs[0x80]; /* register cache */
-	bitmap_member(reg_accessed,0x80); /* bit flags */
+	DECLARE_BITMAP(reg_accessed, 0x80); /* bit flags */
 	union {			/* vendor specific code */
 		struct {
 			unsigned short unchained[3];	// 0 = C34, 1 = C79, 2 = C69
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/sound/core/seq/seq_clientmgr.h linux-2.5.28.31516.updated/sound/core/seq/seq_clientmgr.h
--- linux-2.5.28.31516/sound/core/seq/seq_clientmgr.h	Fri Jun 21 09:41:57 2002
+++ linux-2.5.28.31516.updated/sound/core/seq/seq_clientmgr.h	Fri Jul 26 15:59:03 2002
@@ -53,7 +53,7 @@ struct _snd_seq_client {
 	char name[64];		/* client name */
 	int number;		/* client number */
 	unsigned int filter;	/* filter flags */
-	bitmap_member(event_filter, 256);
+	DECLARE_BITMAP(event_filter, 256);
 	snd_use_lock_t use_lock;
 	int event_lost;
 	/* ports */
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/sound/core/seq/seq_queue.h linux-2.5.28.31516.updated/sound/core/seq/seq_queue.h
--- linux-2.5.28.31516/sound/core/seq/seq_queue.h	Fri Jun 21 09:41:57 2002
+++ linux-2.5.28.31516.updated/sound/core/seq/seq_queue.h	Fri Jul 26 15:59:03 2002
@@ -26,6 +26,7 @@
 #include "seq_lock.h"
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
 
 #define SEQ_QUEUE_NO_OWNER (-1)
 
@@ -51,7 +52,7 @@ struct _snd_seq_queue {
 	spinlock_t check_lock;
 
 	/* clients which uses this queue (bitmap) */
-	bitmap_member(clients_bitmap, SNDRV_SEQ_MAX_CLIENTS);
+ 	DECLARE_BITMAP(clients_bitmap, SNDRV_SEQ_MAX_CLIENTS);
 	unsigned int clients;	/* users of this queue */
 	struct semaphore timer_mutex;
 
Name: CPU mask patch
Author: Rusty Russell
Status: Trivial
Depends: Misc/bitops.patch.gz

D: This patch changes cpu masks to a generic bitmap.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/fs/partitions/check.c .28255-2.5.30-cpumask/fs/partitions/check.c
--- .28255-2.5.30-cpumask.pre/fs/partitions/check.c	2002-08-02 11:15:09.000000000 +1000
+++ .28255-2.5.30-cpumask/fs/partitions/check.c	2002-08-09 15:54:25.000000000 +1000
@@ -467,7 +467,7 @@ void devfs_register_partitions (struct g
 	for (part = 1; part < max_p; part++) {
 		if ( unregister || (p[part].nr_sects < 1) ) {
 			devfs_unregister(p[part].de);
-			dev->part[p].de = NULL;
+			dev->part[part].de = NULL;
 			continue;
 		}
 		devfs_register_partition (dev, minor, part);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/include/asm-i386/smp.h .28255-2.5.30-cpumask/include/asm-i386/smp.h
--- .28255-2.5.30-cpumask.pre/include/asm-i386/smp.h	2002-08-02 11:15:10.000000000 +1000
+++ .28255-2.5.30-cpumask/include/asm-i386/smp.h	2002-08-09 15:54:25.000000000 +1000
@@ -87,20 +87,29 @@ extern volatile int logical_apicid_to_cp
 
 extern volatile unsigned long cpu_callout_map;
 
+#if NR_CPUS > 32
+#error asm/smp.h needs fixing for > 32 CPUS.
+#endif
+
 #define cpu_possible(cpu) (cpu_callout_map & (1<<(cpu)))
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
 
+static inline void cpu_online_mask(unsigned long *res,
+				   const unsigned long *mask)
+{
+	res[0] = (mask[0] & cpu_online_map);
+}
+
 extern inline unsigned int num_online_cpus(void)
 {
 	return hweight32(cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+static inline int any_online_cpu(const unsigned long *mask)
 {
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
-
-	return -1;
+	if ((mask[0] & cpu_online_map) != 0UL)
+		return __ffs(mask[0] & cpu_online_map);
+	return NR_CPUS;
 }
 
 static __inline int hard_smp_processor_id(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/include/asm-ia64/smp.h .28255-2.5.30-cpumask/include/asm-ia64/smp.h
--- .28255-2.5.30-cpumask.pre/include/asm-ia64/smp.h	2002-06-20 01:28:51.000000000 +1000
+++ .28255-2.5.30-cpumask/include/asm-ia64/smp.h	2002-08-09 15:54:25.000000000 +1000
@@ -45,18 +45,28 @@ extern volatile int ia64_cpu_to_sapicid[
 
 extern unsigned long ap_wakeup_vector;
 
+#if NR_CPUS > 64
+#error asm/smp.h needs fixing for > 64 CPUS.
+#endif
+
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+
+static inline void cpu_online_mask(unsigned long *res,
+				   const unsigned long *mask)
+{
+	res[0] = (mask[0] & cpu_online_map);
+}
+
 extern inline unsigned int num_online_cpus(void)
 {
 	return hweight64(cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+static inline int any_online_cpu(const unsigned long *mask)
 {
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
-
-	return -1;
+	if ((mask[0] & cpu_online_map) != 0UL)
+		return __ffs(mask[0] & cpu_online_map);
+	return NR_CPUS;
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/include/asm-ppc/smp.h .28255-2.5.30-cpumask/include/asm-ppc/smp.h
--- .28255-2.5.30-cpumask.pre/include/asm-ppc/smp.h	2002-07-27 15:24:39.000000000 +1000
+++ .28255-2.5.30-cpumask/include/asm-ppc/smp.h	2002-08-09 15:54:25.000000000 +1000
@@ -48,20 +48,29 @@ extern void smp_local_timer_interrupt(st
 
 #define smp_processor_id() (current_thread_info()->cpu)
 
+#if NR_CPUS > 32
+#error asm/smp.h needs fixing for > 32 CPUS.
+#endif
+
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
 #define cpu_possible(cpu) (cpu_possible_map & (1<<(cpu)))
 
+static inline void cpu_online_mask(unsigned long *res,
+				   const unsigned long *mask)
+{
+	res[0] = (mask[0] & cpu_online_map);
+}
+
 extern inline unsigned int num_online_cpus(void)
 {
 	return hweight32(cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+static inline int any_online_cpu(const unsigned long *mask)
 {
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
-
-	return -1;
+	if ((mask[0] & cpu_online_map) != 0UL)
+		return __ffs(mask[0] & cpu_online_map);
+	return NR_CPUS;
 }
 
 extern int __cpu_up(unsigned int cpu);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/include/asm-ppc64/smp.h .28255-2.5.30-cpumask/include/asm-ppc64/smp.h
--- .28255-2.5.30-cpumask.pre/include/asm-ppc64/smp.h	2002-07-25 10:13:17.000000000 +1000
+++ .28255-2.5.30-cpumask/include/asm-ppc64/smp.h	2002-08-09 15:54:26.000000000 +1000
@@ -39,10 +39,20 @@ extern void smp_send_reschedule_all(void
 
 #define NO_PROC_ID		0xFF            /* No processor magic marker */
 
+#if NR_CPUS > 64
+#error asm/smp.h needs fixing for > 64 CPUS.
+#endif
+
 #define cpu_online(cpu)	test_bit((cpu), &cpu_online_map)
 
 #define cpu_possible(cpu)	paca[cpu].active
 
+static inline void cpu_online_mask(unsigned long *res,
+				   const unsigned long *mask)
+{
+	res[0] = (mask[0] & cpu_online_map);
+}
+
 static inline int num_online_cpus(void)
 {
 	int i, nr = 0;
@@ -53,6 +63,13 @@ static inline int num_online_cpus(void)
 	return nr;
 }
 
+static inline int any_online_cpu(const unsigned long *mask)
+{
+	if ((mask[0] & cpu_online_map) != 0UL)
+		return __ffs(mask[0] & cpu_online_map);
+	return NR_CPUS;
+}
+
 extern volatile unsigned long cpu_callin_map[NR_CPUS];
 
 #define smp_processor_id() (get_paca()->xPacaIndex)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/include/asm-sparc64/smp.h .28255-2.5.30-cpumask/include/asm-sparc64/smp.h
--- .28255-2.5.30-cpumask.pre/include/asm-sparc64/smp.h	2002-06-21 09:41:55.000000000 +1000
+++ .28255-2.5.30-cpumask/include/asm-sparc64/smp.h	2002-08-09 15:54:25.000000000 +1000
@@ -70,11 +70,17 @@ extern unsigned long cpu_online_map;
 extern atomic_t sparc64_num_cpus_online;
 #define num_online_cpus()	(atomic_read(&sparc64_num_cpus_online))
 
-static inline int any_online_cpu(unsigned long mask)
+static inline void cpu_online_mask(unsigned long *res,
+				   const unsigned long *mask)
 {
-	if ((mask &= cpu_online_map) != 0UL)
-		return __ffs(mask);
-	return -1;
+	res[0] = (mask[0] & cpu_online_map);
+}
+
+static inline int any_online_cpu(const unsigned long *mask)
+{
+	if ((mask[0] & cpu_online_map) != 0UL)
+		return __ffs(mask[0] & cpu_online_map);
+	return NR_CPUS;
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/include/linux/init_task.h .28255-2.5.30-cpumask/include/linux/init_task.h
--- .28255-2.5.30-cpumask.pre/include/linux/init_task.h	2002-07-25 10:13:18.000000000 +1000
+++ .28255-2.5.30-cpumask/include/linux/init_task.h	2002-08-09 15:54:25.000000000 +1000
@@ -48,7 +48,7 @@
     prio:		MAX_PRIO-20,					\
     static_prio:	MAX_PRIO-20,					\
     policy:		SCHED_NORMAL,					\
-    cpus_allowed:	-1,						\
+    cpus_allowed:	CPU_MASK_ALL,					\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/include/linux/sched.h .28255-2.5.30-cpumask/include/linux/sched.h
--- .28255-2.5.30-cpumask.pre/include/linux/sched.h	2002-08-02 11:15:10.000000000 +1000
+++ .28255-2.5.30-cpumask/include/linux/sched.h	2002-08-09 15:54:25.000000000 +1000
@@ -14,12 +14,14 @@ extern unsigned long event;
 #include <linux/jiffies.h>
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
+#include <linux/bitops.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/current.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
@@ -262,7 +264,7 @@ struct task_struct {
 	unsigned long sleep_timestamp;
 
 	unsigned long policy;
-	unsigned long cpus_allowed;
+	DECLARE_BITMAP(cpus_allowed, NR_CPUS);
 	unsigned int time_slice, first_time_slice;
 
 	struct list_head tasks;
@@ -410,10 +412,21 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define _STK_LIM	(8*1024*1024)
 
 #if CONFIG_SMP
-extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+extern void set_cpus_allowed(task_t *p, const unsigned long new_mask[]);
 #else
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
+#define CPU_MASK_NONE { 0 }
+#define CPU_MASK_ALL \
+	{ [0 ... ((NR_CPUS+BITS_PER_LONG-1)/BITS_PER_LONG)-1] = ~0UL }
+
+static inline void migrate_to_cpu(unsigned int cpu)
+{
+	DECLARE_BITMAP(mask, NR_CPUS) = CPU_MASK_NONE;
+	BUG_ON(!cpu_online(cpu));
+	__set_bit(cpu, mask);
+	set_cpus_allowed(current, mask);
+}
 
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
@@ -479,8 +492,6 @@ static inline struct task_struct *find_t
 extern struct user_struct * alloc_uid(uid_t);
 extern void free_uid(struct user_struct *);
 
-#include <asm/current.h>
-
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/include/linux/smp.h .28255-2.5.30-cpumask/include/linux/smp.h
--- .28255-2.5.30-cpumask.pre/include/linux/smp.h	2002-08-02 11:15:10.000000000 +1000
+++ .28255-2.5.30-cpumask/include/linux/smp.h	2002-08-09 15:54:25.000000000 +1000
@@ -93,12 +93,13 @@ int cpu_up(unsigned int cpu);
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
-#define cpu_online_map				1
 #define cpu_online(cpu)				({ cpu; 1; })
 #define num_online_cpus()			1
 #define __per_cpu_data
 #define per_cpu(var, cpu)			var
 #define this_cpu(var)				var
+#define cpu_online_mask(res,mask) do { *(res) = (*(mask) & 1); } while(0)
+#define any_online_cpu(mask) ((*(mask) & 1) ? 0 : 1)
 
 /* Need to know about CPUs going up/down? */
 static inline int register_cpu_notifier(struct notifier_block *nb)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/kernel/sched.c .28255-2.5.30-cpumask/kernel/sched.c
--- .28255-2.5.30-cpumask.pre/kernel/sched.c	2002-08-02 11:15:10.000000000 +1000
+++ .28255-2.5.30-cpumask/kernel/sched.c	2002-08-09 15:54:25.000000000 +1000
@@ -29,6 +29,7 @@
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/delay.h>
+#include <linux/bitops.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -415,7 +416,7 @@ repeat_lock_task:
 		 */
 		if (unlikely(sync && !task_running(rq, p) &&
 			(task_cpu(p) != smp_processor_id()) &&
-			(p->cpus_allowed & (1UL << smp_processor_id())))) {
+			(test_bit(smp_processor_id(), p->cpus_allowed)))) {
 
 			set_task_cpu(p, smp_processor_id());
 			task_rq_unlock(rq, &flags);
@@ -789,7 +790,7 @@ skip_queue:
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
 		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+			(test_bit(smp_processor_id(), p->cpus_allowed)))
 
 	curr = curr->prev;
 
@@ -1542,7 +1543,7 @@ out_unlock:
 asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
-	unsigned long new_mask;
+	DECLARE_BITMAP(new_mask, NR_CPUS);
 	int retval;
 	task_t *p;
 
@@ -1552,8 +1553,7 @@ asmlinkage int sys_sched_setaffinity(pid
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	if (any_online_cpu(new_mask) == NR_CPUS)
 		return -EINVAL;
 
 	read_lock(&tasklist_lock);
@@ -1595,7 +1595,7 @@ asmlinkage int sys_sched_getaffinity(pid
 				      unsigned long *user_mask_ptr)
 {
 	unsigned int real_len;
-	unsigned long mask;
+	DECLARE_BITMAP(mask, NR_CPUS);
 	int retval;
 	task_t *p;
 
@@ -1611,7 +1611,7 @@ asmlinkage int sys_sched_getaffinity(pid
 		goto out_unlock;
 
 	retval = 0;
-	mask = p->cpus_allowed & cpu_online_map;
+	cpu_online_mask(mask, p->cpus_allowed);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
@@ -1914,7 +1914,7 @@ typedef struct {
  * task must not exit() & deallocate itself prematurely.  The
  * call is not atomic; no spinlocks may be held.
  */
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
+void set_cpus_allowed(task_t *p, const unsigned long new_mask[])
 {
 	unsigned long flags;
 	migration_req_t req;
@@ -1928,12 +1928,12 @@ void set_cpus_allowed(task_t *p, unsigne
 
 	preempt_disable();
 	rq = task_rq_lock(p, &flags);
-	p->cpus_allowed = new_mask;
+	memcpy(p->cpus_allowed, new_mask, sizeof(p->cpus_allowed));
 	/*
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the thread off to a proper CPU.
 	 */
-	if (new_mask & (1UL << task_cpu(p))) {
+	if (test_bit(task_cpu(p), new_mask)) {
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1942,7 +1942,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && !task_running(rq, p)) {
-		set_task_cpu(p, __ffs(p->cpus_allowed));
+		set_task_cpu(p, any_online_cpu(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1972,7 +1972,7 @@ static int migration_thread(void * data)
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
 
-	set_cpus_allowed(current, 1UL << cpu);
+	migrate_to_cpu(cpu);
 
 	/*
 	 * Migration can happen without a migration thread on the
@@ -2010,7 +2010,7 @@ static int migration_thread(void * data)
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = any_online_cpu(p->cpus_allowed);
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .28255-2.5.30-cpumask.pre/kernel/softirq.c .28255-2.5.30-cpumask/kernel/softirq.c
--- .28255-2.5.30-cpumask.pre/kernel/softirq.c	2002-08-02 11:15:10.000000000 +1000
+++ .28255-2.5.30-cpumask/kernel/softirq.c	2002-08-09 15:54:25.000000000 +1000
@@ -361,8 +361,7 @@ static int ksoftirqd(void * __bind_cpu)
 	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
-	/* Migrate to the right CPU */
-	set_cpus_allowed(current, 1UL << cpu);
+	migrate_to_cpu(cpu);
 	if (smp_processor_id() != cpu)
 		BUG();
 

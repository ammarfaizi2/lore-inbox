Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293288AbSCRXb2>; Mon, 18 Mar 2002 18:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293277AbSCRXbX>; Mon, 18 Mar 2002 18:31:23 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31770 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293288AbSCRXbG>; Mon, 18 Mar 2002 18:31:06 -0500
Date: Mon, 18 Mar 2002 18:31:00 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre3 s390 patch for hwc_con.c
Message-ID: <20020318183100.A15251@devserv.devel.redhat.com>
In-Reply-To: <OF5991CEBE.CF23F14A-ONC1256B80.0042A9FE@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To: Pete Zaitcev <zaitcev@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
> Date: Mon, 18 Mar 2002 15:03:49 +0100

>[...]
> Yep makes sense as well. I actually made the same fix for the kernel
> 2.5.6. I have it basically going but SMP is still a bit broken. It
> hangs on boot with 5 cpus. Seems like the startup of the migration
> threads doesn't complete because load_balance isn't balancing...

Darn, I re-invented the wheel again, it seems.
Attached is the patch to have O(1) on 2.4.18-RH (I backported
some of your things from 2.4.19-pre3). I am not sure if it works
right at all. I would like to see yours, unless it's already in
Linus' tree.

-- Pete

diff -urN -X dontdiff linux-2.4.17-0.18/arch/s390/kernel/process.c linux-2.4.17-0.18-t1/arch/s390/kernel/process.c
--- linux-2.4.17-0.18/arch/s390/kernel/process.c	Mon Feb 18 20:02:26 2002
+++ linux-2.4.17-0.18-t1/arch/s390/kernel/process.c	Tue Feb 19 03:37:28 2002
@@ -52,12 +52,8 @@
 
 static psw_t wait_psw;
 
-int cpu_idle(void *unused)
+int cpu_idle(void)
 {
-	/* endless idle loop with no priority at all */
-        init_idle();
-	current->nice = 20;
-	current->counter = -100;
 	wait_psw.mask = _WAIT_PSW_MASK;
 	wait_psw.addr = (unsigned long) &&idle_wakeup | 0x80000000L;
 	while(1) {
@@ -82,7 +78,7 @@
 {
 	struct task_struct *tsk = current;
 
-        printk("CPU:    %d    %s\n", tsk->processor, print_tainted());
+	printk("CPU:    %d    %s\n", tsk->cpu, print_tainted());
         printk("Process %s (pid: %d, task: %08lx, ksp: %08x)\n",
 	       current->comm, current->pid, (unsigned long) tsk,
 	       tsk->thread.ksp);
diff -urN -X dontdiff linux-2.4.17-0.18/arch/s390/kernel/s390_ksyms.c linux-2.4.17-0.18-t1/arch/s390/kernel/s390_ksyms.c
--- linux-2.4.17-0.18/arch/s390/kernel/s390_ksyms.c	Mon Feb 18 20:05:29 2002
+++ linux-2.4.17-0.18-t1/arch/s390/kernel/s390_ksyms.c	Wed Feb 20 02:05:42 2002
@@ -11,6 +11,7 @@
 #if CONFIG_IP_MULTICAST
 #include <net/arp.h>
 #endif
+#include <linux/sched.h>	/* XXX sys_shed_yield - broken */
 
 /*
  * memory management
@@ -60,3 +60,4 @@
 EXPORT_SYMBOL(console_mode);
 EXPORT_SYMBOL(console_device);
 EXPORT_SYMBOL_NOVERS(do_call_softirq);
+EXPORT_SYMBOL_NOVERS(sys_sched_yield);	/* XXX */
diff -urN -X dontdiff linux-2.4.17-0.18/arch/s390/kernel/smp.c linux-2.4.17-0.18-t1/arch/s390/kernel/smp.c
--- linux-2.4.17-0.18/arch/s390/kernel/smp.c	Mon Feb 18 20:02:26 2002
+++ linux-2.4.17-0.18-t1/arch/s390/kernel/smp.c	Tue Feb 19 22:02:05 2002
@@ -38,7 +38,7 @@
 #include <asm/cpcmd.h>
 
 /* prototypes */
-extern int cpu_idle(void * unused);
+extern int cpu_idle(void);
 
 extern __u16 boot_cpu_addr;
 extern volatile int __cpu_logical_map[];
@@ -49,13 +49,13 @@
 static int       max_cpus = NR_CPUS;	  /* Setup configured maximum number of CPUs to activate	*/
 int              smp_num_cpus;
 struct _lowcore *lowcore_ptr[NR_CPUS];
-cycles_t         cacheflush_time=0;
 int              smp_threads_ready=0;      /* Set when the idlers are all forked. */
 static atomic_t  smp_commenced = ATOMIC_INIT(0);
 
 spinlock_t       kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 unsigned long	 cpu_online_map;
+unsigned long	cache_decay_ticks;
 
 /*
  *      Setup routine for controlling SMP activation
@@ -95,6 +95,8 @@
 static sigp_ccode smp_ext_bitcall(int, ec_bit_sig);
 static void smp_ext_bitcall_others(ec_bit_sig);
 
+static void do_task_migration(void);
+
 /*
  * Structure and data for smp_call_function(). This is designed to minimise
  * static memory requirements. It also looks cleaner.
@@ -259,6 +261,8 @@
 		do_machine_power_off();
 	if (test_bit(ec_call_function, &bits)) 
 		do_call_function();
+	if (test_bit(ec_task_migration, &bits))
+		do_task_migration();
 }
 
 /*
@@ -361,6 +365,35 @@
 	local_flush_tlb();
 }
 
+static spinlock_t migration_lock = SPIN_LOCK_UNLOCKED;
+static task_t *new_task;
+
+/*
+ * Task migration callback.
+ */
+static void do_task_migration(void)
+{
+	task_t *p;
+
+	p = new_task;
+	spin_unlock(&migration_lock);
+	sched_task_migrated(p);
+}
+
+/*
+ * This function sends a 'task migration' IPI to another CPU.
+ * Must be called from syscall contexts, with interrupts *enabled*.
+ */
+void smp_migrate_task(int cpu, task_t *p)
+{
+	/*
+	 * The target CPU will unlock the migration spinlock:
+	 */
+	spin_lock(&migration_lock);
+	new_task = p;
+	smp_ext_bitcall(cpu, ec_task_migration);
+}
+
 /*
  * this function sends a 'reschedule' IPI to another CPU.
  * it goes straight through and wastes no time serializing
@@ -372,6 +405,19 @@
         smp_ext_bitcall(cpu, ec_schedule);
 }
 
+#if 0 /* not used in current mingo code */
+/*
+ * this function sends a reschedule IPI to all (other) CPUs.
+ * This should only be used if some 'global' task became runnable,
+ * such as a RT task, that must be handled now. The first CPU
+ * that manages to grab the task will run it.
+ */
+void smp_send_reschedule_all(void)
+{
+	send_IPI_allbutself(RESCHEDULE_VECTOR);
+}
+#endif
+
 /*
  * parameter area for the set/clear control bit callbacks
  */
@@ -449,7 +495,7 @@
 {
         int curr_cpu;
 
-        current->processor = 0;
+        current->cpu = 0;
         smp_num_cpus = 1;
 	cpu_online_map = 1;
         for (curr_cpu = 0;
@@ -490,7 +536,7 @@
 	pfault_init();
 #endif
         /* cpu_idle will call schedule for us */
-        return cpu_idle(NULL);
+        return cpu_idle();
 }
 
 /*
@@ -528,12 +574,9 @@
         idle = init_task.prev_task;
         if (!idle)
                 panic("No idle process for CPU %d",cpu);
-        idle->processor = cpu;
-	idle->cpus_runnable = 1 << cpu; /* we schedule the first task manually */
+	init_idle(idle, cpu);
 
-        del_from_runqueue(idle);
         unhash_process(idle);
-        init_tasks[cpu] = idle;
 
         cpu_lowcore=&get_cpu_lowcore(cpu);
 	cpu_lowcore->save_area[15] = idle->thread.ksp;
@@ -585,7 +628,9 @@
                 panic("Couldn't request external interrupt 0x1202");
         smp_count_cpus();
         memset(lowcore_ptr,0,sizeof(lowcore_ptr));  
-        
+
+	cache_decay_ticks = (200 * HZ) / 1000;	/* Is 200ms ok? Robust? XXX */
+
         /*
          *      Initialize the logical to physical CPU number mapping
          */
diff -urN -X dontdiff linux-2.4.17-0.18/arch/s390/kernel/traps.c linux-2.4.17-0.18-t1/arch/s390/kernel/traps.c
--- linux-2.4.17-0.18/arch/s390/kernel/traps.c	Mon Feb 18 20:02:26 2002
+++ linux-2.4.17-0.18-t1/arch/s390/kernel/traps.c	Tue Feb 19 21:05:15 2002
@@ -135,12 +135,14 @@
 
 void show_trace_task(struct task_struct *tsk)
 {
+#if 0 /* Mingo's scheduler kills task_has_cpu, so we bite the bullet. */
 	/*
 	 * We can't print the backtrace of a running process. It is
 	 * unreliable at best and can cause kernel oopses.
 	 */
 	if (task_has_cpu(tsk))
 		return;
+#endif
 	show_trace((unsigned long *) tsk->thread.ksp);
 }
 
diff -urN -X dontdiff linux-2.4.17-0.18/arch/s390/mm/fault.c linux-2.4.17-0.18-t1/arch/s390/mm/fault.c
--- linux-2.4.17-0.18/arch/s390/mm/fault.c	Fri Nov  9 22:58:02 2001
+++ linux-2.4.17-0.18-t1/arch/s390/mm/fault.c	Tue Feb 19 03:09:46 2002
@@ -285,8 +285,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid == 1) {
-		tsk->policy |= SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN -X dontdiff linux-2.4.17-0.18/arch/s390x/kernel/process.c linux-2.4.17-0.18-t1/arch/s390x/kernel/process.c
--- linux-2.4.17-0.18/arch/s390x/kernel/process.c	Mon Feb 18 20:02:28 2002
+++ linux-2.4.17-0.18-t1/arch/s390x/kernel/process.c	Tue Feb 19 03:36:16 2002
@@ -52,12 +52,9 @@
 
 static psw_t wait_psw;
 
-int cpu_idle(void *unused)
+int cpu_idle(void)
 {
 	/* endless idle loop with no priority at all */
-        init_idle();
-	current->nice = 20;
-	current->counter = -100;
 	wait_psw.mask = _WAIT_PSW_MASK;
 	wait_psw.addr = (unsigned long) &&idle_wakeup;
 	while(1) {
diff -urN -X dontdiff linux-2.4.17-0.18/arch/s390x/kernel/smp.c linux-2.4.17-0.18-t1/arch/s390x/kernel/smp.c
--- linux-2.4.17-0.18/arch/s390x/kernel/smp.c	Mon Feb 18 20:02:28 2002
+++ linux-2.4.17-0.18-t1/arch/s390x/kernel/smp.c	Tue Feb 19 03:36:43 2002
@@ -38,7 +38,7 @@
 #include <asm/cpcmd.h>
 
 /* prototypes */
-extern int cpu_idle(void * unused);
+extern int cpu_idle(void);
 
 extern __u16 boot_cpu_addr;
 extern volatile int __cpu_logical_map[];
@@ -468,8 +468,9 @@
 	/* Enable pfault pseudo page faults on this cpu. */
 	pfault_init();
 #endif
+	init_idle();
         /* cpu_idle will call schedule for us */
-        return cpu_idle(NULL);
+        return cpu_idle();
 }
 
 /*
diff -urN -X dontdiff linux-2.4.17-0.18/arch/s390x/mm/fault.c linux-2.4.17-0.18-t1/arch/s390x/mm/fault.c
--- linux-2.4.17-0.18/arch/s390x/mm/fault.c	Fri Nov  9 22:58:02 2001
+++ linux-2.4.17-0.18-t1/arch/s390x/mm/fault.c	Tue Feb 19 03:10:28 2002
@@ -286,8 +286,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid == 1) {
-		tsk->policy |= SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN -X dontdiff linux-2.4.17-0.18/include/asm-s390/bitops.h linux-2.4.17-0.18-t1/include/asm-s390/bitops.h
--- linux-2.4.17-0.18/include/asm-s390/bitops.h	Wed Jul 25 23:12:02 2001
+++ linux-2.4.17-0.18-t1/include/asm-s390/bitops.h	Tue Feb 19 21:06:47 2002
@@ -752,6 +752,68 @@
 }
 
 /*
+ * Yet Another Bitop for mingo's scheduler. Don't use!
+ * Result is undefined if no bit exists, so code should check against 0 first.
+ *
+ * XXX Measure if this actually needs any optimization.
+ */
+static __inline__ int __ffs(unsigned long word)
+{
+	int num = 0;
+
+	if ((word & 0xffff) == 0) {
+		num += 16;
+		word >>= 16;
+	}
+	if ((word & 0xff) == 0) {
+		num += 8;
+		word >>= 8;
+	}
+	if ((word & 0xf) == 0) {
+		num += 4;
+		word >>= 4;
+	}
+	if ((word & 0x3) == 0) {
+		num += 2;
+		word >>= 2;
+	}
+	if ((word & 0x1) == 0)
+		num += 1;
+	return num;
+}
+
+/*
+ * Scheduler induced bitop, better not to use.
+ * The Ingo's brilliant design puts its find_first()
+ * counterpart into <asm/mmu_context.h>.
+ * Some implementations use void *addr as argument, which is
+ * totally broken, because we must be compatible with set_bit().
+ * The size is likely to be 140, but the map is padded with zeroes.
+ *
+ * find_next_bit - find the first set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
+static __inline__ int find_next_bit(unsigned long *addr, int size, int offset)
+{
+	unsigned long *p = addr + (offset >> 5);
+	int num = offset & ~0x1f;
+	unsigned long word;
+
+	word = *p++;
+	word &= ~((1 << (offset & 0x1f)) - 1);
+	while (num < size) {
+		if (word != 0) {
+			return __ffs(word) + num;
+		}
+		word = *p++;
+		num += 0x20;
+	}
+	return num;
+}
+
+/*
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
  */
diff -urN -X dontdiff linux-2.4.17-0.18/include/asm-s390/mmu_context.h linux-2.4.17-0.18-t1/include/asm-s390/mmu_context.h
--- linux-2.4.17-0.18/include/asm-s390/mmu_context.h	Tue Feb 13 23:13:44 2001
+++ linux-2.4.17-0.18-t1/include/asm-s390/mmu_context.h	Tue Feb 19 06:03:42 2002
@@ -10,6 +10,25 @@
 #define __S390_MMU_CONTEXT_H
 
 /*
+ * Every architecture must define this function. It's the fastest
+ * way of searching a 140-bit bitmap where the first 100 bits are
+ * unlikely to be set. It's guaranteed that at least one of the 140
+ * bits is cleared.
+ */
+static inline int sched_find_first_bit(unsigned long *b)
+{
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 32;
+	if (unlikely(b[2]))
+		return __ffs(b[2]) + 64;
+	if (b[3])
+		return __ffs(b[3]) + 96;
+	return __ffs(b[4]) + 128;
+}
+
+/*
  * get a new mmu context.. S390 don't know about contexts.
  */
 #define init_new_context(tsk,mm)        0
diff -urN -X dontdiff linux-2.4.17-0.18/include/asm-s390/sigp.h linux-2.4.17-0.18-t1/include/asm-s390/sigp.h
--- linux-2.4.17-0.18/include/asm-s390/sigp.h	Mon Feb 18 21:27:30 2002
+++ linux-2.4.17-0.18-t1/include/asm-s390/sigp.h	Tue Feb 19 21:07:33 2002
@@ -63,6 +63,7 @@
         ec_halt,
         ec_power_off,
 	ec_call_function,
+	ec_task_migration,
 	ec_bit_last
 } ec_bit_sig;
 
diff -urN -X dontdiff linux-2.4.17-0.18/include/asm-s390/smp.h linux-2.4.17-0.18-t1/include/asm-s390/smp.h
--- linux-2.4.17-0.18/include/asm-s390/smp.h   Mon Feb 18 21:27:34 2002
+++ linux-2.4.17-0.18-t1/include/asm-s390/smp.h        Tue Feb 19 21:07:36 2002
@@ -30,19 +30,7 @@
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
-/*
- *	This magic constant controls our willingness to transfer
- *	a process across CPUs. Such a transfer incurs misses on the L1
- *	cache, and on a P6 or P5 with multiple L2 caches L2 hits. My
- *	gut feeling is this will vary by board in value. For a board
- *	with separate L2 cache it probably depends also on the RSS, and
- *	for a board with shared L2 cache it ought to decay fast as other
- *	processes are run.
- */
- 
-#define PROC_CHANGE_PENALTY	20		/* Schedule penalty */
-
-#define smp_processor_id() (current->processor)
+#define smp_processor_id() (current->cpu)
 
 extern __inline__ int cpu_logical_map(int cpu)
 {
diff -ur -X dontdiff linux-2.4.18-0.1.s390/include/asm-s390x/smp.h linux-2.4.18-0.1-x.s390/include/asm-s390x/smp.h
--- linux-2.4.18-0.1.s390/include/asm-s390x/smp.h	Thu Oct 11 09:43:38 2001
+++ linux-2.4.18-0.1-x.s390/include/asm-s390x/smp.h	Wed Mar  6 21:17:30 2002
@@ -30,19 +30,7 @@
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
-/*
- *	This magic constant controls our willingness to transfer
- *	a process across CPUs. Such a transfer incurs misses on the L1
- *	cache, and on a P6 or P5 with multiple L2 caches L2 hits. My
- *	gut feeling is this will vary by board in value. For a board
- *	with separate L2 cache it probably depends also on the RSS, and
- *	for a board with shared L2 cache it ought to decay fast as other
- *	processes are run.
- */
- 
-#define PROC_CHANGE_PENALTY	20		/* Schedule penalty */
-
-#define smp_processor_id() (current->processor)
+#define smp_processor_id() (current->cpu)
 
 extern __inline__ int cpu_logical_map(int cpu)
 {
diff -ur -X dontdiff linux-2.4.18-0.1.s390/arch/s390/kernel/entry.S linux-2.4.18-0.1-x.s390/arch/s390/kernel/entry.S
--- linux-2.4.18-0.1.s390/arch/s390/kernel/entry.S	Mon Feb 25 11:37:56 2002
+++ linux-2.4.18-0.1-x.s390/arch/s390/kernel/entry.S	Wed Mar  6 19:18:22 2002
@@ -291,17 +289,16 @@
 ret_from_fork:  
         basr    %r13,0
         l       %r13,.Lentry_base-.(%r13)  # setup base pointer to &entry_base
+#ifdef CONFIG_SMP
+	# not saving R14 here because we go to sysc_return ultimately
+	l	%r1,BASED(.Lschedtail)
+	basr	%r14,%r1          # call schedule_tail (unlock stuff)
+#endif
         GET_CURRENT               # load pointer to task_struct to R9
         stosm   24(%r15),0x03     # reenable interrupts
         sr      %r0,%r0           # child returns 0
         st      %r0,SP_R2(%r15)   # store return value (change R2 on stack)
-#ifdef CONFIG_SMP
-        l       %r1,BASED(.Lschedtail)
-	la      %r14,BASED(sysc_return)
-        br      %r1               # call schedule_tail, return to sysc_return
-#else
         b       BASED(sysc_return)
-#endif
 
 #
 # clone, fork, vfork, exec and sigreturn need glue,
diff -ur -X dontdiff linux-2.4.18-0.1.s390/arch/s390x/kernel/entry.S linux-2.4.18-0.1-x.s390/arch/s390x/kernel/entry.S
--- linux-2.4.18-0.1.s390/arch/s390x/kernel/entry.S	Mon Feb 25 11:37:56 2002
+++ linux-2.4.18-0.1-x.s390/arch/s390x/kernel/entry.S	Wed Mar  6 19:41:58 2002
@@ -277,15 +275,13 @@
 #
         .globl  ret_from_fork
 ret_from_fork:  
+#ifdef CONFIG_SMP
+	brasl   %r14,schedule_tail
+#endif
         GET_CURRENT               # load pointer to task_struct to R9
         stosm   48(%r15),0x03     # reenable interrupts
 	xc      SP_R2(8,%r15),SP_R2(%r15) # child returns 0
-#ifdef CONFIG_SMP
-	larl    %r14,sysc_return
-        jg      schedule_tail     # return to sysc_return
-#else
         j       sysc_return
-#endif
 
 #
 # clone, fork, vfork, exec and sigreturn need glue,

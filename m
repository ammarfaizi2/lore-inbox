Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129219AbQKXEQ5>; Thu, 23 Nov 2000 23:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131443AbQKXEQi>; Thu, 23 Nov 2000 23:16:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11098 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129219AbQKXEQ1>; Thu, 23 Nov 2000 23:16:27 -0500
Date: Fri, 24 Nov 2000 04:46:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Henderson <rth@twiddle.net>
Cc: Reto Baettig <baettig@scs.ch>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org
Subject: Re: Alpha SMP problem
Message-ID: <20001124044615.A6807@athlon.random>
In-Reply-To: <3A08455E.F3583D1B@scs.ch> <20001107225749.B26542@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001107225749.B26542@twiddle.net>; from rth@twiddle.net on Tue, Nov 07, 2000 at 10:57:49PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 10:57:49PM -0800, Richard Henderson wrote:
> On Tue, Nov 07, 2000 at 10:09:34AM -0800, Reto Baettig wrote:
> > I have a problem whith Alpha SMP's which seems to be kernel-related. I
> > discussed this on the bug-glibc list but everybody seems to agree that
> > it cannot be a libc problem.
> 
> Indeed it does seem to be some sort of tlb flushing problem,

Yes it was.

> but I've been unable to figure out exactly what.

There were a few SMP races that could trigger only using threads:

1) flush_tlb_other could happen after we read the mm->context and we could
   miss a tlb flush
2) flush_tlb_current could bump up the asn of the current cpu and in turn
   change the asn version after we acquired a new context leading to
   an alias between our asn and a later one
3) a PAL_swpctx can't be done in the middle of alpha_switch_to

ppc/sparc64 may have similar issues and I didn't checked them (from a fast read
it looks like sparc64 is just safe but I don't know the sparc hardware
well enough to be sure).

I also noticed the horrible implementation of ASN in SMP so while I was
there I rewrote it.

The rewrote is based on the fact that mm->context makes no sense. It must be an
array of mm->context[NR_CPUS]. Almost certainly mips wants an array of NR_CPUS
too. Anyways for mips it's not a big deal since SMP isn't supported in 2.2.x ;).

In 2.2.x I added:

	#ifdef __alpha__

in the mm.h code, so that people can apply this patch kernel without breaking
compiles of all other architectures.

For 2.4.x I'd like to know what sparc64 and ppc wants as mm->context, alpha
definitely wants a per-CPU array (probably mips too).

With a single mm->context with threads both cpus was going to overwrite
the same field at the same time. This just made mm->context useless
and it leads to overflow of asn even if there's only 1 MM running in the
system.

And the old implementation wasn't only bad for threads but it was bad
also for regular processes. Every time a task was changing CPU an ASN
was wasted. After 512 changes of CPU of the same task the tlb was flushed
on both cpus even if there was only 1 or two programs running.

With this new design up to 256 different MM (they could belong to 10 threads
each or to a single task each) can run in a SMP system without generating any
tlb flush (aka ASN overflow) in any CPU regardless of the MM migration between
cpus or of the context switches between task and threads.

--- 2.2.18pre21aa2/arch/alpha/kernel/smp.c.~1~	Wed Nov 22 02:32:53 2000
+++ 2.2.18pre21aa2/arch/alpha/kernel/smp.c	Thu Nov 23 04:48:24 2000
@@ -95,8 +95,7 @@
 smp_store_cpu_info(int cpuid)
 {
 	cpu_data[cpuid].loops_per_jiffy = loops_per_jiffy;
-	cpu_data[cpuid].last_asn
-	  = (cpuid << WIDTH_HARDWARE_ASN) + ASN_FIRST_VERSION;
+	cpu_data[cpuid].last_asn = ASN_FIRST_VERSION;
 
         cpu_data[cpuid].irq_count = 0;
         cpu_data[cpuid].bh_count = 0;
@@ -905,6 +904,8 @@
 	struct mm_struct *mm = (struct mm_struct *) x;
 	if (mm == current->mm)
 		flush_tlb_current(mm);
+	else
+		flush_tlb_other(mm);
 }
 
 void
@@ -912,10 +913,17 @@
 {
 	if (mm == current->mm) {
 		flush_tlb_current(mm);
-		if (atomic_read(&mm->count) == 1)
+		if (atomic_read(&mm->count) == 1) {
+			int i, cpu, this_cpu = smp_processor_id();
+			for (i = 0; i < smp_num_cpus; i++) {
+				cpu = cpu_logical_map(i);
+				if (cpu == this_cpu)
+					continue;
+				mm->context[cpu] = 0;
+			}
 			return;
-	} else
-		flush_tlb_other(mm);
+		}
+	}
 
 	if (smp_call_function(ipi_flush_tlb_mm, mm, 1, 1)) {
 		printk(KERN_CRIT "flush_tlb_mm: timed out\n");
@@ -932,8 +940,12 @@
 ipi_flush_tlb_page(void *x)
 {
 	struct flush_tlb_page_struct *data = (struct flush_tlb_page_struct *)x;
-	if (data->mm == current->mm)
-		flush_tlb_current_page(data->mm, data->vma, data->addr);
+	struct mm_struct * mm = data->mm;
+
+	if (mm == current->mm)
+		flush_tlb_current_page(mm, data->vma, data->addr);
+	else
+		flush_tlb_other(mm);
 }
 
 void
@@ -944,10 +956,17 @@
 
 	if (mm == current->mm) {
 		flush_tlb_current_page(mm, vma, addr);
-		if (atomic_read(&current->mm->count) == 1)
+		if (atomic_read(&current->mm->count) == 1) {
+			int i, cpu, this_cpu = smp_processor_id();
+			for (i = 0; i < smp_num_cpus; i++) {
+				cpu = cpu_logical_map(i);
+				if (cpu == this_cpu)
+					continue;
+				mm->context[cpu] = 0;
+			}
 			return;
-	} else
-		flush_tlb_other(mm);
+		}
+	}
        
 	data.vma = vma;
 	data.mm = mm;
--- 2.2.18pre21aa2/arch/alpha/mm/fault.c.~1~	Wed Nov 22 02:32:53 2000
+++ 2.2.18pre21aa2/arch/alpha/mm/fault.c	Wed Nov 22 22:39:50 2000
@@ -41,7 +41,7 @@
 get_new_mmu_context(struct task_struct *p, struct mm_struct *mm)
 {
 	unsigned long new = __get_new_mmu_context();
-	mm->context = new;
+	mm->context[smp_processor_id()] = new;
 	p->tss.asn = new & HARDWARE_ASN_MASK;
 }
 
--- 2.2.18pre21aa2/include/asm-alpha/mmu_context.h.~1~	Wed Nov 22 02:32:53 2000
+++ 2.2.18pre21aa2/include/asm-alpha/mmu_context.h	Thu Nov 23 21:59:06 2000
@@ -65,12 +65,7 @@
 #endif /* __SMP__ */
 
 #define WIDTH_HARDWARE_ASN	8
-#ifdef __SMP__
-#define WIDTH_THIS_PROCESSOR	5
-#else
-#define WIDTH_THIS_PROCESSOR	0
-#endif
-#define ASN_FIRST_VERSION (1UL << (WIDTH_THIS_PROCESSOR + WIDTH_HARDWARE_ASN))
+#define ASN_FIRST_VERSION (1UL << WIDTH_HARDWARE_ASN)
 #define HARDWARE_ASN_MASK ((1UL << WIDTH_HARDWARE_ASN) - 1)
 
 /*
@@ -100,6 +95,7 @@
 	/* If we've wrapped, flush the whole user TLB.  */
 	if ((asn & HARDWARE_ASN_MASK) >= MAX_ASN) {
 		tbiap();
+		imb();
 		next = (asn & ~HARDWARE_ASN_MASK) + ASN_FIRST_VERSION;
 	}
 	cpu_last_asn(smp_processor_id()) = next;
@@ -125,19 +121,21 @@
 __EXTERN_INLINE void
 ev5_get_mmu_context(struct task_struct *p)
 {
-	/* Check if our ASN is of an older version, or on a different CPU,
-	   and thus invalid.  */
-	/* ??? If we have two threads on different cpus, we'll continually
-	   fight over the context.  Find a way to record a per-mm, per-cpu
-	   value for the asn.  */
-
-	unsigned long asn = cpu_last_asn(smp_processor_id());
-	struct mm_struct *mm = p->mm;
-	unsigned long mmc = mm->context;
+	/* Check if our ASN is of an older version, and thus invalid. */
+	int cpu;
+	unsigned long asn;
+	struct mm_struct *mm;
+	unsigned long mmc;
 	
+	cpu = smp_processor_id();
+	mm = p->mm;
+	ctx_cli();
+	asn = cpu_last_asn(cpu);
+	mmc = mm->context[cpu];
+
 	if ((mmc ^ asn) & ~HARDWARE_ASN_MASK) {
 		mmc = __get_new_mmu_context();
-		mm->context = mmc;
+		mm->context[cpu] = mmc;
 	}
 
 	/* Always update the PCB ASN.  Another thread may have allocated
@@ -159,7 +157,10 @@
 extern inline void
 init_new_context(struct mm_struct *mm)
 {
-	mm->context = 0;
+	int i;
+
+	for (i = 0; i < smp_num_cpus; i++)
+		mm->context[cpu_logical_map(i)] = 0;
 }
 
 extern inline void
@@ -213,6 +214,13 @@
 extern inline void
 activate_context(struct task_struct *task)
 {
+	int i, cpu, this_cpu = smp_processor_id();
+	for (i = 0; i < smp_num_cpus; i++) {
+		cpu = cpu_logical_map(i);
+		if (cpu == this_cpu)
+			continue;
+		task->mm->context[cpu] = 0;
+	}
 	get_new_mmu_context(task, task->mm);
 	reload_context(task);
 }
--- 2.2.18pre21aa2/include/asm-alpha/pgtable.h.~1~	Wed Nov 22 05:30:43 2000
+++ 2.2.18pre21aa2/include/asm-alpha/pgtable.h	Thu Nov 23 05:55:22 2000
@@ -73,7 +73,7 @@
 __EXTERN_INLINE void
 ev5_flush_tlb_other(struct mm_struct *mm)
 {
-	mm->context = 0;
+	mm->context[smp_processor_id()] = 0;
 }
 
 /*
--- 2.2.18pre21aa2/include/asm-alpha/system.h.~1~	Thu Nov 16 17:55:21 2000
+++ 2.2.18pre21aa2/include/asm-alpha/system.h	Thu Nov 23 21:58:57 2000
@@ -112,12 +112,21 @@
 
 extern void halt(void) __attribute__((noreturn));
 
+#ifdef CONFIG_SMP
+#define ctx_cli()	__cli()
+#define ctx_sti()	__sti()
+#else
+#define ctx_cli()	do { } while(0)
+#define ctx_sti()	do { } while(0)
+#endif
+
 #define switch_to(prev,next,last)			\
 do {							\
 	unsigned long pcbb;				\
 	current = (next);				\
 	pcbb = virt_to_phys(&current->tss);		\
 	(last) = alpha_switch_to(pcbb, (prev));		\
+	ctx_sti();					\
 } while (0)
 
 extern struct task_struct* alpha_switch_to(unsigned long, struct task_struct*);
--- 2.2.18pre21aa2/include/linux/sched.h.~1~	Wed Nov 22 02:32:53 2000
+++ 2.2.18pre21aa2/include/linux/sched.h	Thu Nov 23 22:02:53 2000
@@ -181,7 +181,11 @@
 	atomic_t count;
 	int map_count;				/* number of VMAs */
 	struct semaphore mmap_sem;
+#ifdef __alpha__
+	unsigned long context[NR_CPUS];
+#else
 	unsigned long context;
+#endif
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
@@ -197,12 +201,18 @@
 	void * segments;
 };
 
+#ifdef __alpha__
+#define CONTEXT_INIT	{ 0, }
+#else
+#define CONTEXT_INIT	0
+#endif
+
 #define INIT_MM {					\
 		&init_mmap, NULL, NULL,			\
 		swapper_pg_dir, 			\
 		ATOMIC_INIT(1), 1,			\
 		MUTEX,					\
-		0,					\
+		CONTEXT_INIT,				\
 		0, 0, 0, 0,				\
 		0, 0, 0, 				\
 		0, 0, 0, 0,				\

Also downloadable from here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre22/alpha-ASN-SMP-races-1

This is a small benchmark that I did hacking lat_ctx of lmbench, I wanted to
skip the calibration startup and to just run many context switches. lat_ctx
also doesn't benchmark the global time of the benchmark but it tries to
benchmark only the time of the context switch. I was interested exactly
in the opposite information (so the global time of the benchmark).

Numbers without the fix applied:

andrea@alpha:~/lmbench-2alpha11/src > time ../bin/alpha-linux/lat_ctx -s 0 3

"size=0k ovr=0.00
6

real    0m6.671s
user    0m0.974s
sys     0m6.318s
andrea@alpha:~/lmbench-2alpha11/src > time ../bin/alpha-linux/lat_ctx -s 1 3

"size=1k ovr=0.00
8

real    0m7.520s
user    0m1.636s
sys     0m6.659s
andrea@alpha:~/lmbench-2alpha11/src > time ../bin/alpha-linux/lat_ctx -s 0 3

"size=0k ovr=0.00
7

real    0m6.480s
user    0m0.829s
sys     0m6.025s
andrea@alpha:~/lmbench-2alpha11/src > time ../bin/alpha-linux/lat_ctx -s 1 3

"size=1k ovr=0.00
7

real    0m7.456s
user    0m1.748s
sys     0m6.334s

Numbers with the fix applied:

andrea@alpha:~/lmbench-2alpha11/src > time ../bin/alpha-linux/lat_ctx -s 0 3

"size=0k ovr=0.00
5

real    0m5.468s
user    0m0.168s
sys     0m5.735s
andrea@alpha:~/lmbench-2alpha11/src > time ../bin/alpha-linux/lat_ctx -s 1 3

"size=1k ovr=0.00
6

real    0m6.633s
user    0m0.938s
sys     0m6.011s
andrea@alpha:~/lmbench-2alpha11/src > time ../bin/alpha-linux/lat_ctx -s 0 3

"size=0k ovr=0.00
5

real    0m5.538s
user    0m0.164s
sys     0m5.885s
andrea@alpha:~/lmbench-2alpha11/src > time ../bin/alpha-linux/lat_ctx -s 1 3

"size=1k ovr=0.00
6

real    0m6.238s
user    0m1.019s
sys     0m5.972s


Patch to lmbench:

diff -urN lmbench-2alpha11.orig/src/lat_ctx.c lmbench-2alpha11/src/lat_ctx.c
--- lmbench-2alpha11.orig/src/lat_ctx.c	Fri Jul 31 21:55:18 1998
+++ lmbench-2alpha11/src/lat_ctx.c	Fri Nov 24 03:38:51 2000
@@ -21,7 +21,7 @@
 
 #define	MAXPROC	2048
 #define	CHUNK	(4<<10)
-#define	TRIPS	5
+#define	TRIPS	100000
 #ifndef	max
 #define	max(a, b)	((a) > (b) ? (a) : (b))
 #endif
@@ -67,11 +67,13 @@
 		process_size = atoi(av[2]) * 1024;
 		if (process_size > 0) {
 			data = (int *)calloc(1, max(process_size, CHUNK));
+#if 0
 			BENCHO(sumit(CHUNK), sumit(0), 0);
 			overhead = gettime();
 			overhead /= get_n();
 			overhead *= process_size;
 			overhead /= CHUNK;
+#endif
 		}
 		ac -= 2;
 		av += 2;
@@ -86,15 +88,21 @@
 		if (max_procs < procs) max_procs = procs;
 	}
 	max_procs = create_pipes(p, max_procs);
+#if 0
 	overhead += pipe_cost(p, max_procs);
+#endif
 	max_procs = create_daemons(p, pids, max_procs);
 	fprintf(stderr, "\n\"size=%dk ovr=%.2f\n", process_size/1024, overhead);
+	{
+	unsigned long before, after;
+	before = time(0);
 	for (i = 1; i < ac; ++i) {
 		double	time;
 		int	procs = atoi(av[i]);
 
 		if (procs > max_procs) continue;
 
+#if 0
 		BENCH(ctx(procs, max_procs), 0);
 		time = usecs_spent();
 		time /= get_n();
@@ -102,6 +110,12 @@
 		time /= TRIPS;
 		time -= overhead;
 	    	fprintf(stderr, "%d %.2f\n", procs, time);
+#else
+		ctx(procs, max_procs);
+#endif
+	}
+	after = time(0);
+	printf("%d\n", after-before);
 	}
 
 	/*


The above numbers are generated without using threads, the improvement with
threads is going to be much more visible but I didn't benchmarked it
(benchmarking that should be fairly easy, just run two threads in 2-way SMP
and generate the max number of context switch you can).

In some day I'll forward port to 2.4.x (that part is completly equivalent
between 2.2.x and 2.4.x). I'm also thinking if the context[] array should be
large context[L1_CACHE_SIZE*NR_CPUS] to avoid ping pong of cachelines while
flushing the MM of the threads.  One nice optimization that I didn't included
in the above patch is in flush_tlb_other() where we could first check if the
context[smp_processor_id()] is just zero, before writing to it.  That would
avoid the ping pong for example if all other threads are sleeping.

Just as reminder other alpha fixes that people should apply on top of 2.2.18pre
are here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre22/alpha-bottom-half-SMP-races-1
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.18pre15aa1/00_alpha-read-unlock-SMP-race-1
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.18pre21aa1/80_smp-locking-1
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.18pre15aa1/30_rtclight-2.2.15pre13aa1-1.gz
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.18pre21aa1/00_alpha-epoch-2

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUHUN4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUHUN4S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 09:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUHUNzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 09:55:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26345 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266237AbUHUNy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 09:54:57 -0400
Date: Sat, 21 Aug 2004 15:55:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>
Subject: [patch] context-switching overhead in X, ioport(), 2.6.8.1
Message-ID: <20040821135516.GA3872@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


while debugging/improving scheduling latencies i got the following
strange latency report from Lee Revell:

  http://krustophenia.net/testresults.php?dataset=2.6.8.1-P6#/var/www/2.6.8.1-P6

this trace shows a 120 usec latency caused by XFree86, on a 600 MHz x86
system. Looking closer reveals:

  00000002 0.006ms (+0.003ms): __switch_to (schedule)
  00000002 0.088ms (+0.082ms): finish_task_switch (schedule)

it took more than 80 usecs for XFree86 to do a context-switch!

it turns out that the reason for this (massive) context-switching
overhead is the following change in 2.6.8:

      [PATCH] larger IO bitmaps

To demonstrate the effect of this change i've written ioperm-latency.c
(attached), which gives the following on vanilla 2.6.8.1:

  # ./ioperm-latency
  default no ioperm:             scheduling latency: 2528 cycles
  turning on port 80 ioperm:     scheduling latency: 10563 cycles
  turning on port 65535 ioperm:  scheduling latency: 10517 cycles

the ChangeSet says:

        Now, with the lazy bitmap allocation and per-CPU TSS, this
        will really not drain any resources I think.

this is plain wrong. An increase in the IO bitmap size introduces
per-context-switch overhead as well: we now have to copy an 8K bitmap
every time XFree86 context-switches - even though XFree86 never uses
ports higher than 1024! I've straced XFree86 on a number of x86 systems
and in every instance ioperm() was used - so i'd say the majority of x86
Linux systems running 2.6.8.1 are affected by this problem.

This not only causes lots of overhead, it also trashes ~16K out of the
L1 and L2 caches, on every context-switch. It's as if XFree86 did a L1
cache flush on every context-switch ...

the simple solution would be to revert IO_BITMAP_BITS back to 1024 and
release 2.6.8.2?

I've implemented another solution as well, which tracks the
highest-enabled port # for every task and does the copying of the bitmap
intelligently. (patch attached) The patched kernel gives:

  # ./ioperm-latency
  default no ioperm:             scheduling latency: 2423 cycles
  turning on port 80 ioperm:     scheduling latency: 2503 cycles
  turning on port 65535 ioperm:  scheduling latency: 10607 cycles

this is much more acceptable - the full overhead only occurs in the very
unlikely event of a task using the high ioport range. X doesnt suffer
any significant overhead.

(tracking the maximum allowed port # also allows a simplification of
io_bitmap handling: e.g. we dont do the invalid-offset trick anymore -
the IO bitmap in the TSS is always valid and secure.)

I tested the patch on x86 SMP and UP, it works fine for me. I tested
boundary conditions as well, it all seems secure.

	Ingo

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ioperm-latency.c"

#include <errno.h>
#include <stdio.h>
#include <sched.h>
#include <signal.h>
#include <sys/io.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/unistd.h>

#define CYCLES(x) asm volatile ("rdtsc" :"=a" (x)::"edx")

#define __NR_sched_set_affinity 241
_syscall3 (int, sched_set_affinity, pid_t, pid, unsigned int, mask_len, unsigned long *, mask)

/*
 * Use a pair of RT processes bound to the same CPU to measure
 * context-switch overhead:
 */
static void measure(void)
{
	unsigned long i, min = ~0UL, pid, mask = 1, t1, t2;

	sched_set_affinity(0, sizeof(mask), &mask);

	pid = fork();
	if (!pid)
		for (;;) {
			asm volatile ("sti; nop; cli");
			sched_yield();
		}

	sched_yield();
	for (i = 0; i < 100; i++) {
		asm volatile ("sti; nop; cli");
		CYCLES(t1);
		sched_yield();
		CYCLES(t2);
		if (i > 10) {
			if (t2 - t1 < min)
				min = t2 - t1;
		}
	}
	asm volatile ("sti");

	kill(pid, 9);
	printf("scheduling latency: %ld cycles\n", min);
	sched_yield();
}

int main(void)
{
	struct sched_param p = { sched_priority: 2 };
	unsigned long mask = 1;

	if (iopl(3)) {
		printf("need to run as root!\n");
		exit(-1);
	}
	sched_setscheduler(0, SCHED_FIFO, &p);
	sched_set_affinity(0, sizeof(mask), &mask);

	printf("default no ioperm:             ");
	measure();

	printf("turning on port 80 ioperm:     ");
	ioperm(0x80,1,1);
	measure();

	printf("turning on port 65535 ioperm:  ");
	if (ioperm(0xffff,1,1))
		printf("FAILED - older kernel.\n");
	else
		measure();

	return 0;
}


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ioport-latency-fix-2.6.8.1.patch"


it taskes for X.org/XFree86 more than 80 usecs to do a context-switch!

it turns out that the reason for this (massive) context-switching
overhead is the following change in 2.6.8:

      [PATCH] larger IO bitmaps

the simple solution is to revert the change. I've implemented another
solution as well, which tracks the highest-enabled port # for every task
and does the copying of the bitmap intelligently. (patch attached) The
patched kernel gives:

  # ./ioperm-latency
  default no ioperm:             scheduling latency: 2423 cycles
  turning on port 80 ioperm:     scheduling latency: 2503 cycles
  turning on port 65535 ioperm:  scheduling latency: 10607 cycles

this is much more acceptable - the full overhead only occurs in the very
unlikely event of a task using the high ioport range.

tracking the maximum allowed port # also allows a simplification of
io_bitmap handling: e.g. we dont do the invalid-offset trick anymore -
the IO bitmap in the TSS is always valid and secure.

I tested the patch on x86 SMP and UP, it works fine for me. I tested
boundary conditions as well, it all seems secure.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/ioport.c.orig	
+++ linux/arch/i386/kernel/ioport.c	
@@ -56,6 +56,7 @@ static void set_bitmap(unsigned long *bi
  */
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
+	unsigned int i, max_long, bytes, bytes_updated;
 	struct thread_struct * t = &current->thread;
 	struct tss_struct * tss;
 	unsigned long *bitmap;
@@ -81,16 +82,34 @@ asmlinkage long sys_ioperm(unsigned long
 
 	/*
 	 * do it in the per-thread copy and in the TSS ...
+	 *
+	 * Disable preemption via get_cpu() - we must not switch away
+	 * because the ->io_bitmap_max value must match the bitmap
+	 * contents:
 	 */
-	set_bitmap(t->io_bitmap_ptr, from, num, !turn_on);
 	tss = init_tss + get_cpu();
-	if (tss->io_bitmap_base == IO_BITMAP_OFFSET) { /* already active? */
-		set_bitmap(tss->io_bitmap, from, num, !turn_on);
-	} else {
-		memcpy(tss->io_bitmap, t->io_bitmap_ptr, IO_BITMAP_BYTES);
-		tss->io_bitmap_base = IO_BITMAP_OFFSET; /* Activate it in the TSS */
-	}
+
+	set_bitmap(t->io_bitmap_ptr, from, num, !turn_on);
+
+	/*
+	 * Search for a (possibly new) maximum. This is simple and stupid,
+	 * to keep it obviously correct:
+	 */
+	max_long = 0;
+	for (i = 0; i < IO_BITMAP_LONGS; i++)
+		if (t->io_bitmap_ptr[i] != ~0UL)
+			max_long = i;
+
+	bytes = (max_long + 1) * sizeof(long);
+	bytes_updated = max(bytes, t->io_bitmap_max);
+
+	t->io_bitmap_max = bytes;
+
+	/* Update the TSS: */
+	memcpy(tss->io_bitmap, t->io_bitmap_ptr, bytes_updated);
+
 	put_cpu();
+
 	return 0;
 }
 
--- linux/arch/i386/kernel/process.c.orig	
+++ linux/arch/i386/kernel/process.c	
@@ -293,15 +293,20 @@ int kernel_thread(int (*fn)(void *), voi
  */
 void exit_thread(void)
 {
-	struct task_struct *tsk = current;
+	struct thread_struct *t = &current->thread;
 
 	/* The process may have allocated an io port bitmap... nuke it. */
-	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
+	if (unlikely(NULL != t->io_bitmap_ptr)) {
 		int cpu = get_cpu();
 		struct tss_struct *tss = init_tss + cpu;
-		kfree(tsk->thread.io_bitmap_ptr);
-		tsk->thread.io_bitmap_ptr = NULL;
-		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
+
+		kfree(t->io_bitmap_ptr);
+		t->io_bitmap_ptr = NULL;
+		/*
+		 * Careful, clear this in the TSS too:
+		 */
+		memset(tss->io_bitmap, 0xff, t->io_bitmap_max);
+		t->io_bitmap_max = 0;
 		put_cpu();
 	}
 }
@@ -369,8 +374,10 @@ int copy_thread(int nr, unsigned long cl
 	tsk = current;
 	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!p->thread.io_bitmap_ptr)
+		if (!p->thread.io_bitmap_ptr) {
+			p->thread.io_bitmap_max = 0;
 			return -ENOMEM;
+		}
 		memcpy(p->thread.io_bitmap_ptr, tsk->thread.io_bitmap_ptr,
 			IO_BITMAP_BYTES);
 	}
@@ -401,8 +408,10 @@ int copy_thread(int nr, unsigned long cl
 
 	err = 0;
  out:
-	if (err && p->thread.io_bitmap_ptr)
+	if (err && p->thread.io_bitmap_ptr) {
 		kfree(p->thread.io_bitmap_ptr);
+		p->thread.io_bitmap_max = 0;
+	}
 	return err;
 }
 
@@ -552,26 +561,18 @@ struct task_struct fastcall * __switch_t
 	}
 
 	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr)) {
-		if (next->io_bitmap_ptr) {
+		if (next->io_bitmap_ptr)
 			/*
-			 * 4 cachelines copy ... not good, but not that
-			 * bad either. Anyone got something better?
-			 * This only affects processes which use ioperm().
-			 * [Putting the TSSs into 4k-tlb mapped regions
-			 * and playing VM tricks to switch the IO bitmap
-			 * is not really acceptable.]
+			 * Copy the relevant range of the IO bitmap.
+			 * Normally this is 128 bytes or less:
 			 */
 			memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-				IO_BITMAP_BYTES);
-			tss->io_bitmap_base = IO_BITMAP_OFFSET;
-		} else
+				max(prev->io_bitmap_max, next->io_bitmap_max));
+		else
 			/*
-			 * a bitmap offset pointing outside of the TSS limit
-			 * causes a nicely controllable SIGSEGV if a process
-			 * tries to use a port IO instruction. The first
-			 * sys_ioperm() call sets up the bitmap properly.
+			 * Clear any possible leftover bits:
 			 */
-			tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
+			memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
 	}
 	return prev_p;
 }
--- linux/include/asm-i386/processor.h.orig	
+++ linux/include/asm-i386/processor.h	
@@ -422,6 +422,8 @@ struct thread_struct {
 	unsigned int		saved_fs, saved_gs;
 /* IO permissions */
 	unsigned long	*io_bitmap_ptr;
+/* max allowed port in the bitmap, in bytes: */
+	unsigned int	io_bitmap_max;
 };
 
 #define INIT_THREAD  {							\
@@ -442,7 +444,7 @@ struct thread_struct {
 	.esp1		= sizeof(init_tss[0]) + (long)&init_tss[0],	\
 	.ss1		= __KERNEL_CS,					\
 	.ldt		= GDT_ENTRY_LDT,				\
-	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,			\
+	.io_bitmap_base	= offsetof(struct tss_struct,io_bitmap),	\
 	.io_bitmap	= { [ 0 ... IO_BITMAP_LONGS] = ~0 },		\
 }
 

--J2SCkAp4GZ/dPZZf--

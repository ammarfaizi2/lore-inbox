Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266591AbUHXHUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUHXHUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 03:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUHXHUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 03:20:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1722 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266591AbUHXHUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 03:20:03 -0400
Date: Tue, 24 Aug 2004 09:19:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] ioport-cache-2.6.8.1.patch
Message-ID: <20040824071928.GA7697@elte.hu>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com> <20040823233249.09e93b86.ak@suse.de> <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


(skip the discussion section for a description of the attached patch.)

* Davide Libenzi <davidel@xmailserver.org> wrote:

> > > +	/*
> > > +	 * Perform the lazy TSS's I/O bitmap copy. If the TSS has an
> > > +	 * invalid offset set (the LAZY one) and the faulting thread has
> > > +	 * a valid I/O bitmap pointer, we copy the I/O bitmap in the TSS
> > > +	 * and we set the offset field correctly. Then we let the CPU to
> > > +	 * restart the faulting instruction.
> > > +	 */
> > 
> > I don't like it very much that most GPFs will be executed twice now
> > when the process has ioperm enabled.
> > This will confuse debuggers and could have other bad side effects.
> > Checking the EIP would be better.
> 
> The eventually double GPF would happen only on TSS-IObmp-lazy tasks, ie 
> tasks using the I/O bitmap. The check for the I/O opcode can certainly be 
> done though, even if it'd make the code a little bit more complex.

another issue is that this code doesnt solve the 64K ports issue: even
with a perfect decoder ioperm() apps still see a ~80 usecs copying
latency (plus related cache trash effects) upon the first GPF - either
IO related or not. I dont think coupling this into the GPF handler is
all that good.

since 100% of Linux ioperm() apps currently use 1024 ports or less, i'd
prefer the 128 bytes (one cacheline on a P4) copy over any asynchronous
solution. (if someone wants more ports the price goes up. It should be
rare. I dont think X will ever go above 1024 ports.) We've already had
one security exploit in the lazy IO bitmap code, which further underlies
how dangerous such asynchronity is.

there's yet another danger: apps that _do_ use IO ports frequently will
see the most serious overhead via the GPF solution. They will most
likely switch to iopl(3) - which is an even less safe API than ioperm()
- so robustness suffers. So i think it's wrong policy too. Sorry :-|

but there's one additional step we can do ontop of the ports-max code to
get rid of copying in X.org's case: cache the last task that set up the
IO bitmap. This means we can set the offset to invalid and keep the IO
bitmap of that task, and switch back to a valid offset (without any
copying) when switching back to that task. (or do a copy if there is
another ioperm task we switch to.)

I've attached ioport-cache-2.6.8.1.patch that implements this. When
there's a single active ioperm() using task in the system then the
context-switch overhead is very low and constant:

 # ./ioperm-latency
 default no ioperm:             scheduling latency: 2478 cycles
 turning on port 80 ioperm:     scheduling latency: 2499 cycles
 turning on port 65535 ioperm:  scheduling latency: 2481 cycles

(updated ioperm-latency.c attached)

This single-ioperm-user situation matches 99% of the actual ioperm()
usage scenarios and gets rid of any copying whatsoever - without relying
on any fault mechanism. I can see no advantage of the GPF approach over
this patch.

the patch is against the most recent BK tree, i've tested it on x86 SMP
and UP.

	Ingo

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ioport-cache-2.6.8.1.patch"


cache the IO bitmap contents. If there is a single active task using ioports
then there is a very low and constant context-switch overhead from using
ioports:

 # ./ioperm-latency
 default no ioperm:             scheduling latency: 2478 cycles
 turning on port 80 ioperm:     scheduling latency: 2499 cycles
 turning on port 65535 ioperm:  scheduling latency: 2481 cycles

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/ioport.c.orig	
+++ linux/arch/i386/kernel/ioport.c	
@@ -56,7 +56,7 @@ static void set_bitmap(unsigned long *bi
  */
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
-	unsigned int i, max_long, bytes, bytes_updated;
+	unsigned long i, max_long, bytes, bytes_updated;
 	struct thread_struct * t = &current->thread;
 	struct tss_struct * tss;
 	unsigned long *bitmap;
@@ -107,6 +107,9 @@ asmlinkage long sys_ioperm(unsigned long
 
 	/* Update the TSS: */
 	memcpy(tss->io_bitmap, t->io_bitmap_ptr, bytes_updated);
+	tss->io_bitmap_max = bytes;
+	tss->io_bitmap_owner = &current->thread;
+	tss->io_bitmap_base = IO_BITMAP_OFFSET;
 
 	put_cpu();
 
--- linux/arch/i386/kernel/process.c.orig	
+++ linux/arch/i386/kernel/process.c	
@@ -306,8 +306,11 @@ void exit_thread(void)
 		/*
 		 * Careful, clear this in the TSS too:
 		 */
-		memset(tss->io_bitmap, 0xff, t->io_bitmap_max);
+		memset(tss->io_bitmap, 0xff, tss->io_bitmap_max);
 		t->io_bitmap_max = 0;
+		tss->io_bitmap_owner = NULL;
+		tss->io_bitmap_max = 0;
+		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		put_cpu();
 	}
 }
@@ -477,6 +480,38 @@ int dump_task_regs(struct task_struct *t
 	return 1;
 }
 
+static inline void
+handle_io_bitmap(struct thread_struct *next, struct tss_struct *tss)
+{
+	if (!next->io_bitmap_ptr) {
+		/*
+		 * Disable the bitmap via an invalid offset. We still cache
+		 * the previous bitmap owner and the IO bitmap contents:
+		 */
+		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
+		return;
+	}
+	if (likely(next == tss->io_bitmap_owner)) {
+		/*
+		 * Previous owner of the bitmap (hence the bitmap content)
+		 * matches the next task, we dont have to do anything but
+		 * to set a valid offset in the TSS:
+		 */
+		tss->io_bitmap_base = IO_BITMAP_OFFSET;
+		return;
+	}
+	/*
+	 * The IO bitmap in the TSS needs updating: copy the relevant
+	 * range of the new task's IO bitmap. Normally this is 128 bytes
+	 * or less:
+	 */
+	memcpy(tss->io_bitmap, next->io_bitmap_ptr,
+		max(tss->io_bitmap_max, next->io_bitmap_max));
+	tss->io_bitmap_max = next->io_bitmap_max;
+	tss->io_bitmap_owner = next;
+	tss->io_bitmap_base = IO_BITMAP_OFFSET;
+}
+
 /*
  * This special macro can be used to load a debugging register
  */
@@ -561,20 +596,8 @@ struct task_struct fastcall * __switch_t
 		loaddebug(next, 7);
 	}
 
-	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr)) {
-		if (next->io_bitmap_ptr)
-			/*
-			 * Copy the relevant range of the IO bitmap.
-			 * Normally this is 128 bytes or less:
-			 */
-			memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-				max(prev->io_bitmap_max, next->io_bitmap_max));
-		else
-			/*
-			 * Clear any possible leftover bits:
-			 */
-			memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
-	}
+	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
+		handle_io_bitmap(next, tss);
 	return prev_p;
 }
 
--- linux/include/asm-i386/processor.h.orig	
+++ linux/include/asm-i386/processor.h	
@@ -358,6 +358,8 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
 
+struct thread_struct;
+
 struct tss_struct {
 	unsigned short	back_link,__blh;
 	unsigned long	esp0;
@@ -390,9 +392,14 @@ struct tss_struct {
 	 */
 	unsigned long	io_bitmap[IO_BITMAP_LONGS + 1];
 	/*
+	 * Cache the current maximum and the last task that used the bitmap:
+	 */
+	unsigned long io_bitmap_max;
+	struct thread_struct *io_bitmap_owner;
+	/*
 	 * pads the TSS to be cacheline-aligned (size is 0x100)
 	 */
-	unsigned long __cacheline_filler[37];
+	unsigned long __cacheline_filler[35];
 	/*
 	 * .. and then another 0x100 bytes for emergency kernel stack
 	 */
@@ -424,7 +431,7 @@ struct thread_struct {
 /* IO permissions */
 	unsigned long	*io_bitmap_ptr;
 /* max allowed port in the bitmap, in bytes: */
-	unsigned int	io_bitmap_max;
+	unsigned long	io_bitmap_max;
 };
 
 #define INIT_THREAD  {							\
@@ -444,7 +451,7 @@ struct thread_struct {
 	.ss0		= __KERNEL_DS,					\
 	.ss1		= __KERNEL_CS,					\
 	.ldt		= GDT_ENTRY_LDT,				\
-	.io_bitmap_base	= offsetof(struct tss_struct,io_bitmap),	\
+	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,			\
 	.io_bitmap	= { [ 0 ... IO_BITMAP_LONGS] = ~0 },		\
 }
 

--fdj2RfSjLxBAspz7
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
	unsigned long i, min = ~0UL, mask = 1, t1, t2;

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

	printf("scheduling latency: %ld cycles\n", min);
	sched_yield();
}

int main(void)
{
	struct sched_param p = { sched_priority: 2 };
	unsigned long mask = 1, pid;

	if (iopl(3)) {
		printf("need to run as root!\n");
		exit(-1);
	}
	sched_setscheduler(0, SCHED_FIFO, &p);
	sched_set_affinity(0, sizeof(mask), &mask);

	pid = fork();
	if (!pid)
		for (;;) {
			asm volatile ("sti; nop; cli");
			sched_yield();
		}

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
	kill(pid, 9);

	return 0;
}


--fdj2RfSjLxBAspz7--

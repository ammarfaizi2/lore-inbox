Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291333AbSBHBG3>; Thu, 7 Feb 2002 20:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291331AbSBHBGO>; Thu, 7 Feb 2002 20:06:14 -0500
Received: from are.twiddle.net ([64.81.246.98]:2689 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S291319AbSBHBGD>;
	Thu, 7 Feb 2002 20:06:03 -0500
Date: Thu, 7 Feb 2002 16:59:49 -0800
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <Jay.Estabrook@compaq.com>, andrea@suse.de,
        frival@zk3.dec.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Alpha update for 2.5.3
Message-ID: <20020207165949.A3759@are.twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
	Jay Estabrook <Jay.Estabrook@compaq.com>, andrea@suse.de,
	frival@zk3.dec.com, linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20020207211329.A861@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020207211329.A861@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Thu, Feb 07, 2002 at 09:13:29PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I guess I should have posted my incomplete patches instead of
making you duplicate effort.

On Thu, Feb 07, 2002 at 09:13:29PM +0300, Ivan Kokshaysky wrote:
> - new block layer
>   minor changes here - new BIO_VMERGE_BOUNDARY macro,
>   which hints to BIO that we're able to merge segments on the page
>   boundary;
>   max_pfn = max_low_pfn indicates that we don't need bounce buffers;

This isn't complete.  I suspect either (1) I'm missing something
fundamental or (2) this code is.  It appears to make fundamental
assumptions about "isa" and "low memory" that are not necessarily
correct on non-peecees.

In addition to your bits, I needed to hack ll_rw_blk in order to
boot from an aic7xxx.

> - new scheduler
>   [as usual, untested on SMP - anybody willing to give it a try? Peter?]

The following does *not* work on SMP.  CPU1 segfaults because 
context_switch is called with next=NULL.  I've not yet figured
out what I'm missing in the smp setup.  Ingo, is there anything
obvious?

>   new smp_migrate_task IPI; more or less obvious compile fixes.

Given the nature of the ipi, I prefer to streamline this
particular cross-call like so.

> - syscall "optimization"
>   several fields of task_struct have been squeezed to bytes,
>   so this required byte `xchg' - fortunately my old patch for
>   8 and 16 bit atomic `xchg' came in handy. :-)

Nope.  The xchg thing no longer works.  Look at the x86 code.

Your xchg hack is still cool, and should go in, but it is not
needed here.


r~

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=d-axp-20020207

diff -ruNp linux/arch/alpha/Makefile 2.5.3/arch/alpha/Makefile
--- linux/arch/alpha/Makefile	Sun Dec  3 17:45:20 2000
+++ 2.5.3/arch/alpha/Makefile	Sat Feb  2 16:32:39 2002
@@ -117,11 +117,13 @@ srmboot:
 archclean:
 	@$(MAKE) -C arch/alpha/kernel clean
 	@$(MAKEBOOT) clean
-	rm -f arch/alpha/vmlinux.lds
 
 archmrproper:
+	rm -f arch/alpha/vmlinux.lds
+	rm -f include/asm-alpha/asm_offsets.h
 
 archdep:
+	$(MAKE) -C arch/alpha/kernel asm_offsets
 	@$(MAKEBOOT) dep
 
 vmlinux: arch/alpha/vmlinux.lds
diff -ruNp linux/arch/alpha/kernel/Makefile 2.5.3/arch/alpha/kernel/Makefile
--- linux/arch/alpha/kernel/Makefile	Sun Aug 12 10:51:41 2001
+++ 2.5.3/arch/alpha/kernel/Makefile	Sat Feb  2 15:29:33 2002
@@ -8,9 +8,9 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 .S.s:
-	$(CPP) $(AFLAGS) -o $*.s $<
+	$(CPP) $(CFLAGS) $(AFLAGS) -o $*.s $<
 .S.o:
-	$(CC) $(AFLAGS) -c -o $*.o $<
+	$(CC) $(CFLAGS) $(AFLAGS) -c -o $*.o $<
 
 O_TARGET := kernel.o
 
@@ -102,11 +102,15 @@ endif # GENERIC
 
 all: kernel.o head.o
 
-asm_offsets: check_asm
-	./check_asm > $(TOPDIR)/include/asm-alpha/asm_offsets.h
-
-check_asm: check_asm.c
-	$(HOSTCC) -o $@ $< $(CPPFLAGS) -ffixed-8
+ASM_OFFSETS_H = $(TOPDIR)/include/asm-alpha/asm_offsets.h
+asm_offsets:
+	$(CC) $(CFLAGS) -S -o - check_asm.c | \
+	sed -e '/xyzzy/ { s/xyzzy //; p; }; d;' > asm_offsets.tmp
+	@if cmp -s asm_offsets.tmp $(ASM_OFFSETS_H); then \
+	  set -x; rm asm_offsets.tmp; \
+	else \
+	  set -x; mv asm_offsets.tmp $(ASM_OFFSETS_H); \
+	fi
 
 clean::
 	rm -f check_asm
diff -ruNp linux/arch/alpha/kernel/check_asm.c 2.5.3/arch/alpha/kernel/check_asm.c
--- linux/arch/alpha/kernel/check_asm.c	Mon Jan 28 15:14:22 2002
+++ 2.5.3/arch/alpha/kernel/check_asm.c	Sat Feb  2 15:27:37 2002
@@ -3,30 +3,38 @@
 #include <linux/sched.h>
 #include <asm/io.h>
 
-int main()
+#define OUT(x) \
+  asm ("\nxyzzy " x)
+#define DEF(name, val) \
+  asm volatile ("\nxyzzy #define " name " %0" : : "i"(val))
+
+void foo(void)
 {
-	printf("#ifndef __ASM_OFFSETS_H__\n#define __ASM_OFFSETS_H__\n");
+	OUT("#ifndef __ASM_OFFSETS_H__");
+	OUT("#define __ASM_OFFSETS_H__");
+	OUT("");
 
-	printf("#define TASK_STATE %ld\n",
-	       (long)offsetof(struct task_struct, state));
-	printf("#define TASK_FLAGS %ld\n",
-	       (long)offsetof(struct task_struct, flags));
-	printf("#define TASK_SIGPENDING %ld\n",
-#error	       (long)offsetof(struct task_struct, sigpending));
-	printf("#define TASK_ADDR_LIMIT %ld\n",
-	       (long)offsetof(struct task_struct, addr_limit));
-	printf("#define TASK_EXEC_DOMAIN %ld\n",
-	       (long)offsetof(struct task_struct, exec_domain));
-	printf("#define TASK_NEED_RESCHED %ld\n",
-#error	       (long)offsetof(struct task_struct, work.need_resched));
-	printf("#define TASK_SIZE %ld\n", sizeof(struct task_struct));
-	printf("#define STACK_SIZE %ld\n", sizeof(union task_union));
+	DEF("TASK_STATE", offsetof(struct task_struct, state));
+	DEF("TASK_FLAGS", offsetof(struct task_struct, flags));
+	DEF("TASK_WORK", offsetof(struct task_struct, work));
+	DEF("TASK_WORK_NEED_RESCHED",
+	    offsetof(struct task_struct, work.need_resched));
+	DEF("TASK_WORK_SYSCALL_TRACE",
+	    offsetof(struct task_struct, work.syscall_trace));
+	DEF("TASK_WORK_SIGPENDING",
+	    offsetof(struct task_struct, work.sigpending));
+	DEF("TASK_ADDR_LIMIT", offsetof(struct task_struct, addr_limit));
+	DEF("TASK_EXEC_DOMAIN", offsetof(struct task_struct, exec_domain));
+	DEF("TASK_PTRACE", offsetof(struct task_struct, ptrace));
+	DEF("TASK_SIZE", sizeof(struct task_struct));
+	DEF("STACK_SIZE", sizeof(union task_union));
+	DEF("PT_PTRACED", PT_PTRACED);
+	DEF("CLONE_VM", CLONE_VM);
+	DEF("SIGCHLD", SIGCHLD);
 
-	printf("#define HAE_CACHE %ld\n",
-	       (long)offsetof(struct alpha_machine_vector, hae_cache));
-	printf("#define HAE_REG %ld\n",
-	       (long)offsetof(struct alpha_machine_vector, hae_register));
+	DEF("HAE_CACHE", offsetof(struct alpha_machine_vector, hae_cache));
+	DEF("HAE_REG", offsetof(struct alpha_machine_vector, hae_register));
 
-	printf("#endif /* __ASM_OFFSETS_H__ */\n");
-	return 0;
+	OUT("");
+	OUT("#endif /* __ASM_OFFSETS_H__ */");
 }
diff -ruNp linux/arch/alpha/kernel/entry.S 2.5.3/arch/alpha/kernel/entry.S
--- linux/arch/alpha/kernel/entry.S	Mon Jan 28 15:14:22 2002
+++ 2.5.3/arch/alpha/kernel/entry.S	Sat Feb  2 15:27:37 2002
@@ -7,42 +7,15 @@
 #include <linux/config.h>
 #include <asm/system.h>
 #include <asm/cache.h>
-
-#define SIGCHLD 20
+#include <asm/asm_offsets.h>
 
 #define NR_SYSCALLS 378
 
 /*
- * These offsets must match with alpha_mv in <asm/machvec.h>.
- */
-#define HAE_CACHE	0
-#define HAE_REG		8
-
-/*
  * stack offsets
  */
-#define SP_OFF		184
-
-#define SWITCH_STACK_SIZE 320
-
-/*
- * task structure offsets
- */
-#define TASK_STATE		0
-#define TASK_FLAGS		8
-#error #define TASK_SIGPENDING		16
-#define TASK_ADDR_LIMIT		24
-#define TASK_EXEC_DOMAIN	32
-#error #define TASK_NEED_RESCHED	40
-#error #define TASK_PTRACE		48
-#define TASK_PROCESSOR		100
-
-/*
- * task flags (must match include/linux/sched.h):
- */
-#define	PT_PTRACED	0x00000001
-
-#define CLONE_VM        0x00000100 
+#define SP_OFF			184
+#define SWITCH_STACK_SIZE	320
 
 /*
  * This defines the normal kernel pt-regs layout.
@@ -121,9 +94,6 @@
 
 .text
 .set noat
-#if defined(__linux__) && !defined(__ELF__)
-  .set singlegp
-#endif
 
 .align 3
 .globl	entInt
@@ -559,10 +529,14 @@ entSys:
 	lda	$5,sys_call_table
 	lda	$27,sys_ni_syscall
 	cmpult	$0,$4,$4
-	ldq	$3,TASK_PTRACE($8)
+#ifdef __alpha_bwx__
+	ldbu	$3,TASK_WORK_SYSCALL_TRACE($8)
+#else
+	ldl	$3,TASK_WORK($8)
+	extbl	$3,TASK_WORK_SYSCALL_TRACE,$3
+#endif
 	stq	$17,SP_OFF+32($30)
 	s8addq	$0,$5,$5
-	and     $3,PT_PTRACED,$3
 	stq	$18,SP_OFF+40($30)
 	bne     $3,strace
 	beq	$4,1f
@@ -579,18 +553,47 @@ ret_from_sys_call:
 	ldq	$0,SP_OFF($30)
 	and	$0,8,$0
 	beq	$0,restore_all
-ret_from_reschedule:
-#error	ldq	$2,TASK_NEED_RESCHED($8)
-	lda	$4,init_task_union
-	bne	$2,reschedule
-	xor	$4,$8,$4
-#error	ldl	$5,TASK_SIGPENDING($8)
-	beq	$4,restore_all
-	bne	$5,signal_return
+	/* Make sure need_resched and sigpending don't change between
+	   sampling and the rti.  */
+	lda	$16,7
+	call_pal PAL_swpipl
+	ldl	$5,TASK_WORK($8)
+	zapnot	$5,0x0D,$5		/* clear syscall trace counter  */
+	bne	$5,work_pending
 restore_all:
 	RESTORE_ALL
 	call_pal PAL_rti
 
+.align 3
+work_pending:
+	extbl	$5,TASK_WORK_NEED_RESCHED,$2
+	beq	$2,work_notifysig
+
+	subq	$30,16,$30
+	stq	$19,0($30)		/* save syscall nr */
+	stq	$20,8($30)		/* and error indication (a3) */
+	jsr	$26,schedule
+	ldq	$19,0($30)
+	ldq	$20,8($30)
+	addq	$30,16,$30
+	/* Make sure need_resched and sigpending don't change between
+	   sampling and the rti.  */
+	lda	$16,7
+	call_pal PAL_swpipl
+	ldl	$5,TASK_WORK($8)
+	zapnot	$5,0x0D,$5		/* clear syscall trace counter  */
+	bne	$5,work_pending
+
+work_notifysig:
+	extbl	$5,TASK_WORK_SIGPENDING,$2
+	beq	$2,restore_all
+	mov	$30,$17
+	br	$1,do_switch_stack
+	mov	$30,$18
+	mov	$31,$16
+	jsr	$26,do_signal
+	bsr	$1,undo_switch_stack
+	br	restore_all
 
 /* PTRACE syscall handler */
 .align 3
@@ -677,16 +680,6 @@ ret_success:
 	stq	$0,0($30)
 	stq	$31,72($30)	/* a3=0 => no error */
 	br	ret_from_sys_call
-
-.align 3
-signal_return:
-	mov	$30,$17
-	br	$1,do_switch_stack
-	mov	$30,$18
-	mov	$31,$16
-	jsr	$26,do_signal
-	bsr	$1,undo_switch_stack
-	br	restore_all
 .end entSys
 
         .globl  ret_from_fork
@@ -697,19 +690,6 @@ ret_from_fork:
 	mov	$17,$16
 	jsr	$31,schedule_tail
 .end ret_from_fork
-
-.align 3
-.ent reschedule
-reschedule:
-	subq	$30,16,$30
-	stq	$19,0($30)	/* save syscall nr */
-	stq	$20,8($30)	/* and error indication (a3) */
-	jsr	$26,schedule
-	ldq	$19,0($30)
-	ldq	$20,8($30)
-	addq	$30,16,$30
-	br	ret_from_reschedule
-.end reschedule
 
 .align 3
 .ent sys_sigreturn
diff -ruNp linux/arch/alpha/kernel/process.c 2.5.3/arch/alpha/kernel/process.c
--- linux/arch/alpha/kernel/process.c	Mon Jan 28 15:14:22 2002
+++ 2.5.3/arch/alpha/kernel/process.c	Sat Feb  2 14:51:47 2002
@@ -30,6 +30,7 @@
 #include <linux/reboot.h>
 #include <linux/tty.h>
 #include <linux/console.h>
+#include <linux/init_task.h>
 
 #include <asm/reg.h>
 #include <asm/uaccess.h>
@@ -74,17 +75,12 @@ void
 cpu_idle(void)
 {
 	/* An endless idle loop with no priority at all.  */
-	current->nice = 20;
-
 	while (1) {
 		/* FIXME -- EV6 and LCA45 know how to power down
 		   the CPU.  */
 
-		/* Although we are an idle CPU, we do not want to 
-		   get into the scheduler unnecessarily.  */
-		long oldval = xchg(&current->work.need_resched, -1UL);
-		if (!oldval)
-			while (current->work.need_resched < 0);
+		while (! need_resched())
+			barrier();
 		schedule();
 		check_pgt_cache();
 	}
diff -ruNp linux/arch/alpha/kernel/ptrace.c 2.5.3/arch/alpha/kernel/ptrace.c
--- linux/arch/alpha/kernel/ptrace.c	Tue Sep 18 17:03:51 2001
+++ 2.5.3/arch/alpha/kernel/ptrace.c	Sat Feb  2 15:27:37 2002
@@ -334,10 +334,17 @@ sys_ptrace(long request, long pid, long 
 		ret = -EIO;
 		if ((unsigned long) data > _NSIG)
 			goto out;
-		if (request == PTRACE_SYSCALL)
-			child->ptrace |= PT_TRACESYS;
-		else
-			child->ptrace &= ~PT_TRACESYS;
+		if (request == PTRACE_SYSCALL) {
+			if (!(child->ptrace & PT_SYSCALLTRACE)) {
+				child->ptrace |= PT_SYSCALLTRACE;
+				child->work.syscall_trace++;
+			}
+		} else {
+			if (child->ptrace & PT_SYSCALLTRACE) {
+				child->ptrace &= ~PT_SYSCALLTRACE;
+				child->work.syscall_trace--;
+			}
+		}
 		child->exit_code = data;
 		wake_up_process(child);
 		/* make sure single-step breakpoint is gone. */
@@ -365,7 +372,10 @@ sys_ptrace(long request, long pid, long 
 		if ((unsigned long) data > _NSIG)
 			goto out;
 		child->thread.bpt_nsaved = -1;	/* mark single-stepping */
-		child->ptrace &= ~PT_TRACESYS;
+		if (child->ptrace & PT_SYSCALLTRACE) {
+			child->ptrace &= ~PT_SYSCALLTRACE;
+			child->work.syscall_trace--;
+		}
 		wake_up_process(child);
 		child->exit_code = data;
 		/* give it a chance to run. */
@@ -390,8 +400,8 @@ sys_ptrace(long request, long pid, long 
 asmlinkage void
 syscall_trace(void)
 {
-	if ((current->ptrace & (PT_PTRACED|PT_TRACESYS))
-	    != (PT_PTRACED|PT_TRACESYS))
+	if ((current->ptrace & (PT_PTRACED|PT_SYSCALLTRACE))
+	    != (PT_PTRACED|PT_SYSCALLTRACE))
 		return;
 	current->exit_code = SIGTRAP;
 	current->state = TASK_STOPPED;
diff -ruNp linux/arch/alpha/kernel/setup.c 2.5.3/arch/alpha/kernel/setup.c
--- linux/arch/alpha/kernel/setup.c	Tue Dec 25 15:39:20 2001
+++ 2.5.3/arch/alpha/kernel/setup.c	Thu Feb  7 15:25:40 2002
@@ -68,7 +68,7 @@ int boot_cpuid;
  * Using SRM callbacks for initial console output. This works from
  * setup_arch() time through the end of time_init(), as those places
  * are under our (Alpha) control.
-
+ *
  * "srmcons" specified in the boot command arguments allows us to
  * see kernel messages during the period of time before the true
  * console device is "registered" during console_init(). As of this
@@ -436,8 +436,8 @@ static void srm_console_write(struct con
 
 static kdev_t srm_console_device(struct console *c)
 {
-  /* Huh? */
-        return MKDEV(TTY_MAJOR, 64 + c->index);
+	/* Huh? */
+        return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 static int __init srm_console_setup(struct console *co, char *options)
diff -ruNp linux/arch/alpha/kernel/smp.c 2.5.3/arch/alpha/kernel/smp.c
--- linux/arch/alpha/kernel/smp.c	Tue Jan 15 10:56:35 2002
+++ 2.5.3/arch/alpha/kernel/smp.c	Thu Feb  7 14:51:03 2002
@@ -45,7 +45,7 @@
 #include "irq_impl.h"
 
 
-#define DEBUG_SMP 0
+#define DEBUG_SMP 1
 #if DEBUG_SMP
 #define DBGS(args)	printk args
 #else
@@ -62,6 +62,7 @@ static struct {
 
 enum ipi_message_type {
 	IPI_RESCHEDULE,
+	IPI_MIGRATION,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
 };
@@ -69,7 +70,7 @@ enum ipi_message_type {
 spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /* Set to a secondary's cpuid when it comes online.  */
-static unsigned long smp_secondary_alive;
+static int smp_secondary_alive __initdata = 0;
 
 /* Which cpus ids came online.  */
 unsigned long cpu_present_mask;
@@ -82,6 +83,7 @@ int smp_num_probed;		/* Internal process
 int smp_num_cpus = 1;		/* Number that came online.  */
 int smp_threads_ready;		/* True once the per process idle is forked. */
 cycles_t cacheflush_time;
+unsigned long cache_decay_ticks;
 
 int __cpu_number_map[NR_CPUS];
 int __cpu_logical_map[NR_CPUS];
@@ -132,7 +134,7 @@ smp_setup_percpu_timer(int cpuid)
 	cpu_data[cpuid].prof_multiplier = 1;
 }
 
-static void __init
+static inline void __init
 wait_boot_cpu_to_stop(int cpuid)
 {
 	long stop = jiffies + 10*HZ;
@@ -156,13 +158,6 @@ smp_callin(void)
 {
 	int cpuid = hard_smp_processor_id();
 
-	if (current != init_tasks[cpu_number_map(cpuid)]) {
-		printk("BUG: smp_calling: cpu %d current %p init_tasks[cpu_number_map(cpuid)] %p\n",
-		       cpuid, current, init_tasks[cpu_number_map(cpuid)]);
-	}
-
-	DBGS(("CALLIN %d state 0x%lx\n", cpuid, current->state));
-
 	/* Turn on machine checks.  */
 	wrmces(7);
 
@@ -178,19 +173,15 @@ smp_callin(void)
 	/* Must have completely accurate bogos.  */
 	__sti();
 
-	/*
-	 * Wait boot CPU to stop with irq enabled before
-	 * running calibrate_delay().
-	 */
+	/* Wait boot CPU to stop with irq enabled before running
+	   calibrate_delay.  */
 	wait_boot_cpu_to_stop(cpuid);
 	mb();
 	calibrate_delay();
 
 	smp_store_cpu_info(cpuid);
-	/*
-	 * Allow master to continue only after we written
-	 * the loops_per_jiffy.
-	 */
+
+	/* Allow master to continue only after we written loops_per_jiffy.  */
 	wmb();
 	smp_secondary_alive = 1;
 
@@ -201,12 +192,6 @@ smp_callin(void)
 	DBGS(("smp_callin: commencing CPU %d current %p\n",
 	      cpuid, current));
 
-	/* Setup the scheduler for this processor.  */
-	init_idle();
-
-	/* ??? This should be in init_idle.  */
-	atomic_inc(&init_mm.mm_count);
-	current->active_mm = &init_mm;
 	/* Do nothing.  */
 	cpu_idle();
 }
@@ -222,8 +207,9 @@ static void __init
 smp_tune_scheduling (int cpuid)
 {
 	struct percpu_struct *cpu;
-	unsigned long on_chip_cache;
-	unsigned long freq;
+	unsigned long on_chip_cache;	/* kB */
+	unsigned long freq;		/* Hz */
+	unsigned long bandwidth = 350;	/* MB/s */
 
 	cpu = (struct percpu_struct*)((char*)hwrpb + hwrpb->processor_offset
 				      + cpuid * hwrpb->processor_size);
@@ -244,43 +230,54 @@ smp_tune_scheduling (int cpuid)
 
 	case EV6_CPU:
 	case EV67_CPU:
-		on_chip_cache = 64 + 64;
-		break;
-
 	default:
-		on_chip_cache = 8 + 8;
+		on_chip_cache = 64 + 64;
 		break;
 	}
 
 	freq = hwrpb->cycle_freq ? : est_cycle_freq;
 
-#if 0
-	/* Magic estimation stolen from x86 port.  */
-	cacheflush_time = freq / 1024L * on_chip_cache / 5000L;
+	cacheflush_time = (freq / 1000000) * (on_chip_cache << 10) / bandwidth;
+	cache_decay_ticks = cacheflush_time / (freq / 1000) * HZ / 1000;
 
-        printk("Using heuristic of %d cycles.\n",
-               cacheflush_time);
-#else
-	/* Magic value to force potential preemption of other CPUs.  */
-	cacheflush_time = INT_MAX;
+        printk("per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
+	       cacheflush_time/(freq/1000000),
+	       (cacheflush_time*100/(freq/1000000)) % 100);
+        printk("task migration cache decay timeout: %ld msecs.\n",
+	       (cache_decay_ticks + 1) * 1000 / HZ);
+}
 
-        printk("Using heuristic of %d cycles.\n",
-               cacheflush_time);
-#endif
+/* Wait until hwrpb->txrdy is clear for cpu.  Return -1 on timeout.  */
+static int __init
+wait_for_txrdy (unsigned long cpumask)
+{
+	unsigned long timeout;
+
+	if (!(hwrpb->txrdy & cpumask))
+		return 0;
+
+	timeout = jiffies + 10*HZ;
+	while (time_before(jiffies, timeout)) {
+		if (!(hwrpb->txrdy & cpumask))
+			return 0;
+		udelay(10);
+		barrier();
+	}
+
+	return -1;
 }
 
 /*
  * Send a message to a secondary's console.  "START" is one such
  * interesting message.  ;-)
  */
-static void
+static void __init
 send_secondary_console_msg(char *str, int cpuid)
 {
 	struct percpu_struct *cpu;
 	register char *cp1, *cp2;
 	unsigned long cpumask;
 	size_t len;
-	long timeout;
 
 	cpu = (struct percpu_struct *)
 		((char*)hwrpb
@@ -288,9 +285,8 @@ send_secondary_console_msg(char *str, in
 		 + cpuid * hwrpb->processor_size);
 
 	cpumask = (1UL << cpuid);
-	if (hwrpb->txrdy & cpumask)
-		goto delay1;
-	ready1:
+	if (wait_for_txrdy(cpumask))
+		goto timeout;
 
 	cp2 = str;
 	len = strlen(cp2);
@@ -302,34 +298,12 @@ send_secondary_console_msg(char *str, in
 	wmb();
 	set_bit(cpuid, &hwrpb->rxrdy);
 
-	if (hwrpb->txrdy & cpumask)
-		goto delay2;
-	ready2:
+	if (wait_for_txrdy(cpumask))
+		goto timeout;
 	return;
 
-delay1:
-	/* Wait 10 seconds.  Note that jiffies aren't ticking yet.  */
-	for (timeout = 1000000; timeout > 0; --timeout) {
-		if (!(hwrpb->txrdy & cpumask))
-			goto ready1;
-		udelay(10);
-		barrier();
-	}
-	goto timeout;
-
-delay2:
-	/* Wait 10 seconds.  */
-	for (timeout = 1000000; timeout > 0; --timeout) {
-		if (!(hwrpb->txrdy & cpumask))
-			goto ready2;
-		udelay(10);
-		barrier();
-	}
-	goto timeout;
-
-timeout:
+ timeout:
 	printk("Processor %x not ready\n", cpuid);
-	return;
 }
 
 /*
@@ -439,9 +413,9 @@ secondary_cpu_start(int cpuid, struct ta
 
 	send_secondary_console_msg("START\r\n", cpuid);
 
-	/* Wait 10 seconds for an ACK from the console.  Note that jiffies 
-	   aren't ticking yet.  */
-	for (timeout = 1000000; timeout > 0; timeout--) {
+	/* Wait 10 seconds for an ACK from the console.  */
+	timeout = jiffies + 10*HZ;
+	while (time_before(jiffies, timeout)) {
 		if (cpu->flags & 1)
 			goto started;
 		udelay(10);
@@ -455,13 +429,12 @@ started:
 	return 0;
 }
 
-static int __init fork_by_hand(void)
+static inline int __init
+fork_by_hand(void)
 {
 	struct pt_regs regs;
-	/*
-	 * don't care about the regs settings since
-	 * we'll never reschedule the forked task.
-	 */
+	/* Don't care about the regs settings since we'll never
+	   reschedule the forked task.  */
 	return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
 }
 
@@ -477,66 +450,53 @@ smp_boot_one_cpu(int cpuid, int cpunum)
 	/* Cook up an idler for this guy.  Note that the address we give
 	   to kernel_thread is irrelevant -- it's going to start where
 	   HWRPB.CPU_restart says to start.  But this gets all the other
-	   task-y sort of data structures set up like we wish.  */
-	/*
-	 * We can't use kernel_thread since we must avoid to
-	 * reschedule the child.
-	 */
+	   task-y sort of data structures set up like we wish.  We can't
+	   use kernel_thread since we must avoid rescheduling the child.  */
 	if (fork_by_hand() < 0)
 		panic("failed fork for CPU %d", cpuid);
 
 	idle = init_task.prev_task;
 	if (!idle)
 		panic("No idle process for CPU %d", cpuid);
-	if (idle == &init_task)
-		panic("idle process is init_task for CPU %d", cpuid);
+	init_idle(idle, cpuid);
 
-	idle->processor = cpuid;
-	idle->cpus_runnable = 1 << cpuid; /* we schedule the first task manually */
 	__cpu_logical_map[cpunum] = cpuid;
 	__cpu_number_map[cpuid] = cpunum;
  
-	del_from_runqueue(idle);
 	unhash_process(idle);
-	init_tasks[cpunum] = idle;
 
 	DBGS(("smp_boot_one_cpu: CPU %d state 0x%lx flags 0x%lx\n",
 	      cpuid, idle->state, idle->flags));
 
-	/* The secondary will change this once it is happy.  Note that
-	   secondary_cpu_start contains the necessary memory barrier.  */
+	/* Signal the secondary CPU to wait a moment.  */
 	smp_secondary_alive = -1;
 
 	/* Whirrr, whirrr, whirrrrrrrrr... */
 	if (secondary_cpu_start(cpuid, idle))
 		return -1;
 
+	/* Notify the secondary CPU it can run calibrate_delay.  */
 	mb();
-	/* Notify the secondary CPU it can run calibrate_delay() */
 	smp_secondary_alive = 0;
 
-	/* We've been acked by the console; wait one second for the task
-	   to start up for real.  Note that jiffies aren't ticking yet.  */
-	for (timeout = 0; timeout < 1000000; timeout++) {
-		if (smp_secondary_alive == 1)
-			goto alive;
+	/* We've been acked by the console; wait one second for
+	   the task to start up for real.  */
+	timeout = jiffies + 1*HZ;
+	while (time_before(jiffies, timeout)) {
+		if (smp_secondary_alive == 1) {
+			/* Another "Red Snapper". */
+			return 0;
+		}
 		udelay(10);
 		barrier();
 	}
 
-	/* we must invalidate our stuff as we failed to boot the CPU */
+	/* We must invalidate our stuff as we failed to boot the CPU.  */
 	__cpu_logical_map[cpunum] = -1;
 	__cpu_number_map[cpuid] = -1;
 
-	/* the idle task is local to us so free it as we don't use it */
-	free_task_struct(idle);
-
 	printk(KERN_ERR "SMP: Processor %d is stuck.\n", cpuid);
 	return -1;
-
-alive:
-	/* Another "Red Snapper". */
-	return 0;
 }
 
 /*
@@ -605,21 +565,16 @@ smp_boot_cpus(void)
 
 	__cpu_number_map[boot_cpuid] = 0;
 	__cpu_logical_map[0] = boot_cpuid;
-	current->processor = boot_cpuid;
+	current->cpu = boot_cpuid;
 
 	smp_store_cpu_info(boot_cpuid);
 	smp_tune_scheduling(boot_cpuid);
 	smp_setup_percpu_timer(boot_cpuid);
 
-	init_idle();
-
-	/* ??? This should be in init_idle.  */
-	atomic_inc(&init_mm.mm_count);
-	current->active_mm = &init_mm;
-
 	/* Nothing to do on a UP box, or when told not to.  */
 	if (smp_num_probed == 1 || max_cpus == 0) {
 		printk(KERN_INFO "SMP mode deactivated.\n");
+		cpu_present_mask = 1UL << boot_cpuid;
 		return;
 	}
 
@@ -707,26 +662,38 @@ setup_profiling_timer(unsigned int multi
 static void
 send_ipi_message(unsigned long to_whom, enum ipi_message_type operation)
 {
-	long i, j;
-
-	/* Reduce the number of memory barriers by doing two loops,
-	   one to set the bits, one to invoke the interrupts.  */
+	unsigned long i, set, n;
 
-	mb();	/* Order out-of-band data and bit setting. */
-
-	for (i = 0, j = 1; i < NR_CPUS; ++i, j <<= 1) {
-		if (to_whom & j)
-			set_bit(operation, &ipi_data[i].bits);
-	}
+	/* Special case sending to one cpu.  */
 
-	mb();	/* Order bit setting and interrupt. */
+	set = to_whom & -to_whom;
+	if (to_whom == set) {
+		n = __ffs(set);
+		mb();
+		set_bit(operation, &ipi_data[n].bits);
+		mb();
+		wripir(n);
+	} else {
+		mb();
+		for (i = to_whom; i ; i &= ~set) {
+			set = i & -i;
+			n = __ffs(set);
+			set_bit(operation, &ipi_data[n].bits);
+		}
 
-	for (i = 0, j = 1; i < NR_CPUS; ++i, j <<= 1) {
-		if (to_whom & j)
-			wripir(i);
+		mb();
+		for (i = to_whom; i ; i &= ~set) {
+			set = i & -i;
+			n = __ffs(set);
+			wripir(n);
+		}
 	}
 }
 
+/* Data for IPI_MIGRATION.  */
+static spinlock_t migration_lock = SPIN_LOCK_UNLOCKED;
+static task_t *migration_task;
+
 /* Structure and data for smp_call_function.  This is designed to 
    minimize static memory requirements.  Plus it looks cleaner.  */
 
@@ -792,13 +759,23 @@ handle_ipi(struct pt_regs *regs)
 
 		which = ops & -ops;
 		ops &= ~which;
-		which = ffz(~which);
+		which = __ffs(which);
 
-		if (which == IPI_RESCHEDULE) {
+		switch (which) {
+		case IPI_RESCHEDULE:
 			/* Reschedule callback.  Everything to be done
 			   is done by the interrupt return path.  */
-		}
-		else if (which == IPI_CALL_FUNC) {
+			break;
+		case IPI_MIGRATION:
+		    {
+			task_t *t = migration_task;
+			mb();
+			spin_unlock(&migration_lock);
+			sched_task_migrated(t);
+			break;
+		    }
+		case IPI_CALL_FUNC:
+		    {
 			struct smp_call_struct *data;
 			void (*func)(void *info);
 			void *info;
@@ -821,13 +798,16 @@ handle_ipi(struct pt_regs *regs)
 			/* Notify the sending CPU that the task is done.  */
 			mb();
 			if (wait) atomic_dec (&data->unfinished_count);
-		}
-		else if (which == IPI_CPU_STOP) {
+			break;
+		    }
+		case IPI_CPU_STOP:
 			halt();
-		}
-		else {
+			break;
+
+		default:
 			printk(KERN_CRIT "Unknown IPI on CPU %d: %lu\n",
 			       this_cpu, which);
+			break;
 		}
 	  } while (ops);
 
@@ -849,6 +829,20 @@ smp_send_reschedule(int cpu)
 		       "smp_send_reschedule: Sending IPI to self.\n");
 #endif
 	send_ipi_message(1UL << cpu, IPI_RESCHEDULE);
+}
+
+void
+smp_migrate_task(int cpu, task_t *t)
+{
+#if DEBUG_IPI_MSG
+	if (cpu == hard_smp_processor_id())
+		printk(KERN_WARNING
+		       "smp_migrate_task: Sending IPI to self.\n");
+#endif
+	/* The target CPU will unlock the migration spinlock.  */
+	spin_lock(&migration_lock);
+	migration_task = t;
+	send_ipi_message(1UL << cpu, IPI_MIGRATION);
 }
 
 void
diff -ruNp linux/arch/alpha/mm/fault.c 2.5.3/arch/alpha/mm/fault.c
--- linux/arch/alpha/mm/fault.c	Mon Sep 17 16:15:02 2001
+++ 2.5.3/arch/alpha/mm/fault.c	Sat Feb  2 15:38:22 2002
@@ -196,8 +196,7 @@ no_context:
  */
 out_of_memory:
 	if (current->pid == 1) {
-		current->policy |= SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -ruNp linux/arch/alpha/vmlinux.lds.in 2.5.3/arch/alpha/vmlinux.lds.in
--- linux/arch/alpha/vmlinux.lds.in	Wed Jan 23 10:54:42 2002
+++ 2.5.3/arch/alpha/vmlinux.lds.in	Sat Feb  2 16:18:49 2002
@@ -32,6 +32,8 @@ SECTIONS
   . = ALIGN(8192);
   __init_begin = .;
   .text.init : { *(.text.init) }
+  /* Don't discard .text.exit yet -- too many problems remaining.  */
+  .text.exit : { *(.text.exit) }
   .data.init : { *(.data.init) }
 
   . = ALIGN(16);
@@ -100,5 +102,5 @@ SECTIONS
   .debug_typenames 0 : { *(.debug_typenames) }
   .debug_varnames  0 : { *(.debug_varnames) }
 
-  /DISCARD/ : { *(.text.exit) *(.data.exit) *(.exitcall.exit) }
+  /DISCARD/ : { *(.data.exit) *(.exitcall.exit) }
 }
diff -ruNp linux/drivers/base/core.c 2.5.3/drivers/base/core.c
--- linux/drivers/base/core.c	Mon Jan 28 16:57:27 2002
+++ 2.5.3/drivers/base/core.c	Sat Feb  2 14:31:08 2002
@@ -7,7 +7,8 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
+#include <linux/init.h>
 
 #undef DEBUG
 
diff -ruNp linux/drivers/base/fs.c 2.5.3/drivers/base/fs.c
--- linux/drivers/base/fs.c	Thu Jan 24 14:07:46 2002
+++ 2.5.3/drivers/base/fs.c	Sat Feb  2 14:45:19 2002
@@ -8,7 +8,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/string.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 
 extern struct driver_file_entry * device_default_files[];
 
diff -ruNp linux/drivers/block/ll_rw_blk.c 2.5.3/drivers/block/ll_rw_blk.c
--- linux/drivers/block/ll_rw_blk.c	Sat Jan 19 16:49:38 2002
+++ 2.5.3/drivers/block/ll_rw_blk.c	Thu Feb  7 14:41:15 2002
@@ -182,12 +182,14 @@ void blk_queue_bounce_limit(request_queu
 	static request_queue_t *last_q;
 
 	/*
-	 * set appropriate bounce gfp mask -- unfortunately we don't have a
+	 * Set appropriate bounce gfp mask -- unfortunately we don't have a
 	 * full 4GB zone, so we have to resort to low memory for any bounces.
 	 * ISA has its own < 16MB zone.
 	 */
 	if (bounce_pfn < blk_max_low_pfn) {
-		BUG_ON(dma_addr < BLK_BOUNCE_ISA);
+		/* Note that some systems have an ISA bridge that frobs
+		   addresses, so there may be no 16MB limit.  */
+		BUG_ON(dma_addr < BLK_BOUNCE_ISA && BLK_BOUNCE_ISA < ~0UL);
 		init_emergency_isa_pool();
 		q->bounce_gfp = GFP_NOIO | GFP_DMA;
 	} else
diff -ruNp linux/include/asm-alpha/asm_offsets.h 2.5.3/include/asm-alpha/asm_offsets.h
--- linux/include/asm-alpha/asm_offsets.h	Mon Oct 12 11:40:12 1998
+++ 2.5.3/include/asm-alpha/asm_offsets.h	Wed Dec 31 16:00:00 1969
@@ -1,13 +0,0 @@
-#ifndef __ASM_OFFSETS_H__
-#define __ASM_OFFSETS_H__
-#define TASK_STATE 0
-#define TASK_FLAGS 8
-#define TASK_SIGPENDING 16
-#define TASK_ADDR_LIMIT 24
-#define TASK_EXEC_DOMAIN 32
-#define TASK_NEED_RESCHED 40
-#define TASK_SIZE 1096
-#define STACK_SIZE 16384
-#define HAE_CACHE 0
-#define HAE_REG 8
-#endif /* __ASM_OFFSETS_H__ */
diff -ruNp linux/include/asm-alpha/bitops.h 2.5.3/include/asm-alpha/bitops.h
--- linux/include/asm-alpha/bitops.h	Fri Oct 12 15:35:54 2001
+++ 2.5.3/include/asm-alpha/bitops.h	Thu Feb  7 14:52:42 2002
@@ -74,11 +74,11 @@ clear_bit(unsigned long nr, volatile voi
  * WARNING: non atomic version.
  */
 static __inline__ void
-__change_bit(unsigned long nr, volatile void * addr)
+__clear_bit(unsigned long nr, volatile void * addr)
 {
 	int *m = ((int *) addr) + (nr >> 5);
 
-	*m ^= 1 << (nr & 31);
+	*m &= ~(1 << (nr & 31));
 }
 
 static inline void
@@ -99,6 +99,17 @@ change_bit(unsigned long nr, volatile vo
 	:"Ir" (1UL << (nr & 31)), "m" (*m));
 }
 
+/*
+ * WARNING: non atomic version.
+ */
+static __inline__ void
+__change_bit(unsigned long nr, volatile void * addr)
+{
+	int *m = ((int *) addr) + (nr >> 5);
+
+	*m ^= 1 << (nr & 31);
+}
+
 static inline int
 test_and_set_bit(unsigned long nr, volatile void *addr)
 {
@@ -181,20 +192,6 @@ __test_and_clear_bit(unsigned long nr, v
 	return (old & mask) != 0;
 }
 
-/*
- * WARNING: non atomic version.
- */
-static __inline__ int
-__test_and_change_bit(unsigned long nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	int *m = ((int *) addr) + (nr >> 5);
-	int old = *m;
-
-	*m = old ^ mask;
-	return (old & mask) != 0;
-}
-
 static inline int
 test_and_change_bit(unsigned long nr, volatile void * addr)
 {
@@ -220,6 +217,20 @@ test_and_change_bit(unsigned long nr, vo
 	return oldbit != 0;
 }
 
+/*
+ * WARNING: non atomic version.
+ */
+static __inline__ int
+__test_and_change_bit(unsigned long nr, volatile void * addr)
+{
+	unsigned long mask = 1 << (nr & 0x1f);
+	int *m = ((int *) addr) + (nr >> 5);
+	int old = *m;
+
+	*m = old ^ mask;
+	return (old & mask) != 0;
+}
+
 static inline int
 test_bit(int nr, volatile void * addr)
 {
@@ -264,17 +275,39 @@ static inline unsigned long ffz(unsigned
 #endif
 }
 
+/*
+ * __ffs = Find First set bit in word.  Undefined if no set bit exists.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+#if defined(__alpha_cix__) && defined(__alpha_fix__)
+	/* Whee.  EV67 can calculate it directly.  */
+	unsigned long result;
+	__asm__("cttz %1,%0" : "=r"(result) : "r"(word));
+	return result;
+#else
+	unsigned long bits, qofs, bofs;
+
+	__asm__("cmpbge $31,%1,%0" : "=r"(bits) : "r"(word));
+	qofs = ffz_b(bits);
+	__asm__("extbl %1,%2,%0" : "=r"(bits) : "r"(word), "r"(qofs));
+	bofs = ffz_b(~bits);
+
+	return qofs*8 + bofs;
+#endif
+}
+
 #ifdef __KERNEL__
 
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
+ * differs in spirit from the above ffo (man ffs).
  */
 
 static inline int ffs(int word)
 {
-	int result = ffz(~word);
+	int result = __ffs(word);
 	return word ? result+1 : 0;
 }
 
@@ -365,10 +398,53 @@ found_middle:
 }
 
 /*
- * The optimizer actually does good code for this case..
+ * Find next one bit in a bitmap reasonably efficiently.
+ */
+static inline unsigned long
+find_next_bit(void * addr, unsigned long size, unsigned long offset)
+{
+	unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
+	unsigned long result = offset & ~63UL;
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset &= 63UL;
+	if (offset) {
+		tmp = *(p++);
+		tmp &= ~0UL << offset;
+		if (size < 64)
+			goto found_first;
+		if (tmp)
+			goto found_middle;
+		size -= 64;
+		result += 64;
+	}
+	while (size & ~63UL) {
+		if ((tmp = *(p++)))
+			goto found_middle;
+		result += 64;
+		size -= 64;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+found_first:
+	tmp &= ~0UL >> (64 - size);
+	if (!tmp)
+		return result + size;
+found_middle:
+	return result + __ffs(tmp);
+}
+
+/*
+ * The optimizer actually does good code for this case.
  */
 #define find_first_zero_bit(addr, size) \
 	find_next_zero_bit((addr), (size), 0)
+#define find_first_bit(addr, size) \
+	find_next_bit((addr), (size), 0)
 
 #ifdef __KERNEL__
 
diff -ruNp linux/include/asm-alpha/io.h 2.5.3/include/asm-alpha/io.h
--- linux/include/asm-alpha/io.h	Tue Nov 27 09:23:27 2001
+++ 2.5.3/include/asm-alpha/io.h	Thu Feb  7 14:52:42 2002
@@ -18,6 +18,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <asm/system.h>
+#include <asm/pgtable.h>
 #include <asm/machvec.h>
 
 /*
@@ -60,7 +61,10 @@ static inline void * phys_to_virt(unsign
 	return (void *) (address + IDENT_ADDR);
 }
 
-#define page_to_phys(page)	(((page) - (page)->zone->zone_mem_map) << PAGE_SHIFT)
+#define page_to_phys(page)	PAGE_TO_PA(page)
+
+/* This depends on working iommu.  */
+#define BIO_VMERGE_BOUNDARY	(alpha_mv.mv_pci_tbi ? PAGE_SIZE : 0)
 
 /*
  * Change addresses as seen by the kernel (virtual) to addresses as
diff -ruNp linux/include/asm-alpha/mmu_context.h 2.5.3/include/asm-alpha/mmu_context.h
--- linux/include/asm-alpha/mmu_context.h	Fri Dec 29 14:07:23 2000
+++ 2.5.3/include/asm-alpha/mmu_context.h	Thu Feb  7 14:52:48 2002
@@ -21,6 +21,32 @@
 #include <asm/io.h>
 #endif
 
+/* ??? This does not belong here.  */
+/*
+ * Every architecture must define this function. It's the fastest
+ * way of searching a 168-bit bitmap where the first 128 bits are
+ * unlikely to be set. It's guaranteed that at least one of the 168
+ * bits is set.
+ */
+#if MAX_RT_PRIO != 128 || MAX_PRIO > 192
+# error update this function.
+#endif
+
+static inline int
+sched_find_first_bit(unsigned long *b)
+{
+	unsigned long b0 = b[0], b1 = b[1], b2 = b[2];
+	unsigned long offset = 128;
+
+	if (unlikely(b0 | b1)) {
+		b2 = (b0 ? b0 : b1);
+		offset = (b0 ? 0 : 64);
+	}
+
+	return __ffs(b2) + offset;
+}
+
+
 extern inline unsigned long
 __reload_thread(struct thread_struct *pcb)
 {
diff -ruNp linux/include/asm-alpha/smp.h 2.5.3/include/asm-alpha/smp.h
--- linux/include/asm-alpha/smp.h	Thu Sep 13 15:21:32 2001
+++ 2.5.3/include/asm-alpha/smp.h	Thu Feb  7 14:52:42 2002
@@ -55,7 +55,7 @@ extern int __cpu_logical_map[NR_CPUS];
 #define cpu_logical_map(cpu)  __cpu_logical_map[cpu]
 
 #define hard_smp_processor_id()	__hard_smp_processor_id()
-#define smp_processor_id()	(current->processor)
+#define smp_processor_id()	(current->cpu)
 
 extern unsigned long cpu_present_mask;
 #define cpu_online_map cpu_present_mask
diff -ruNp linux/include/asm-alpha/unistd.h 2.5.3/include/asm-alpha/unistd.h
--- linux/include/asm-alpha/unistd.h	Fri Nov  9 13:45:35 2001
+++ 2.5.3/include/asm-alpha/unistd.h	Thu Feb  7 14:52:42 2002
@@ -575,6 +575,9 @@ static inline long sync(void)
 	return sys_sync();
 }
 
+struct rusage;
+extern asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr,
+				 int options, struct rusage * ru);
 static inline pid_t waitpid(int pid, int * wait_stat, int flags)
 {
 	return sys_wait4(pid, wait_stat, flags, NULL);
diff -ruNp linux/include/linux/dcache.h 2.5.3/include/linux/dcache.h
--- linux/include/linux/dcache.h	Tue Jan 29 21:41:09 2002
+++ 2.5.3/include/linux/dcache.h	Thu Feb  7 13:16:40 2002
@@ -5,6 +5,8 @@
 
 #include <asm/atomic.h>
 #include <linux/mount.h>
+#include <asm/page.h>           /* BUG */
+
 
 /*
  * linux/include/linux/dcache.h
diff -ruNp linux/include/linux/nfs_fs.h 2.5.3/include/linux/nfs_fs.h
--- linux/include/linux/nfs_fs.h	Tue Jan 29 21:42:01 2002
+++ 2.5.3/include/linux/nfs_fs.h	Thu Feb  7 14:52:44 2002
@@ -22,6 +22,8 @@
 #include <linux/nfs3.h>
 #include <linux/nfs_xdr.h>
 
+#include <asm/page.h>		/* BUG */
+
 /*
  * Enable debugging support for nfs client.
  * Requires RPC_DEBUG.

--fdj2RfSjLxBAspz7--

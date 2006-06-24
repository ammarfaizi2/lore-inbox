Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWFXAVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWFXAVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbWFXAVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:21:47 -0400
Received: from mx1.suse.de ([195.135.220.2]:5520 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932490AbWFXAVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:21:46 -0400
Date: Sat, 24 Jun 2006 02:21:44 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       len.brown@intel.com, tony.luck@intel.com, npiggin@novell.com
Subject: [PATCH] [65/82] i386/x86-64/ia64: Move polling flag into 
 thread_info_status
Message-ID: <449C8598.mailDQN11II2P@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


During some profiling I noticed that default_idle causes a lot of
memory traffic. I think that is caused by the atomic operations 
to clear/set the polling flag in thread_info. There is actually
no reason to make this atomic - only the idle thread does it
to itself, other CPUs only read it. So I moved it into ti->status.

Converted i386/x86-64/ia64 for now because that was the easiest
way to fix ACPI which also manipulates these flags in its idle
function.

Cc: npiggin@novell.com
Cc: tony.luck@intel.com
Cc: len.brown@intel.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/apm.c           |    6 +++---
 arch/i386/kernel/process.c       |    6 +++---
 arch/ia64/kernel/process.c       |    4 ++--
 arch/x86_64/kernel/process.c     |    7 +++----
 drivers/acpi/processor_idle.c    |   12 ++++++------
 include/asm-i386/thread_info.h   |    7 ++++---
 include/asm-ia64/thread_info.h   |    5 +++++
 include/asm-x86_64/thread_info.h |    6 ++++--
 kernel/sched.c                   |    9 +++++++--
 9 files changed, 37 insertions(+), 25 deletions(-)

Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -110,7 +110,7 @@ static void default_idle(void)
 {
 	local_irq_enable();
 
-	clear_thread_flag(TIF_POLLING_NRFLAG);
+	current_thread_info()->status &= ~TS_POLLING;
 	smp_mb__after_clear_bit();
 	while (!need_resched()) {
 		local_irq_disable();
@@ -119,7 +119,7 @@ static void default_idle(void)
 		else
 			local_irq_enable();
 	}
-	set_thread_flag(TIF_POLLING_NRFLAG);
+	current_thread_info()->status |= TS_POLLING;
 }
 
 /*
@@ -202,8 +202,7 @@ static inline void play_dead(void)
  */
 void cpu_idle (void)
 {
-	set_thread_flag(TIF_POLLING_NRFLAG);
-
+	current_thread_info()->status |= TS_POLLING;
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
Index: linux/drivers/acpi/processor_idle.c
===================================================================
--- linux.orig/drivers/acpi/processor_idle.c
+++ linux/drivers/acpi/processor_idle.c
@@ -206,11 +206,11 @@ acpi_processor_power_activate(struct acp
 
 static void acpi_safe_halt(void)
 {
-	clear_thread_flag(TIF_POLLING_NRFLAG);
+	current_thread_info()->status &= ~TS_POLLING;
 	smp_mb__after_clear_bit();
 	if (!need_resched())
 		safe_halt();
-	set_thread_flag(TIF_POLLING_NRFLAG);
+	current_thread_info()->status |= TS_POLLING;
 }
 
 static atomic_t c3_cpu_count;
@@ -330,10 +330,10 @@ static void acpi_processor_idle(void)
 	 * Invoke the current Cx state to put the processor to sleep.
 	 */
 	if (cx->type == ACPI_STATE_C2 || cx->type == ACPI_STATE_C3) {
-		clear_thread_flag(TIF_POLLING_NRFLAG);
+		current_thread_info()->status &= ~TS_POLLING;
 		smp_mb__after_clear_bit();
 		if (need_resched()) {
-			set_thread_flag(TIF_POLLING_NRFLAG);
+			current_thread_info()->status |= TS_POLLING;
 			local_irq_enable();
 			return;
 		}
@@ -371,7 +371,7 @@ static void acpi_processor_idle(void)
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Re-enable interrupts */
 		local_irq_enable();
-		set_thread_flag(TIF_POLLING_NRFLAG);
+		current_thread_info()->status |= TS_POLLING;
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks =
 		    ticks_elapsed(t1, t2) - cx->latency_ticks - C2_OVERHEAD;
@@ -411,7 +411,7 @@ static void acpi_processor_idle(void)
 
 		/* Re-enable interrupts */
 		local_irq_enable();
-		set_thread_flag(TIF_POLLING_NRFLAG);
+		current_thread_info()->status |= TS_POLLING;
 		/* Compute time (ticks) that we were actually asleep */
 		sleep_ticks =
 		    ticks_elapsed(t1, t2) - cx->latency_ticks - C3_OVERHEAD;
Index: linux/include/asm-i386/thread_info.h
===================================================================
--- linux.orig/include/asm-i386/thread_info.h
+++ linux/include/asm-i386/thread_info.h
@@ -140,8 +140,7 @@ register unsigned long current_stack_poi
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
-#define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
-#define TIF_MEMDIE		17
+#define TIF_MEMDIE		16
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -153,7 +152,6 @@ register unsigned long current_stack_poi
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
-#define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
@@ -170,6 +168,9 @@ register unsigned long current_stack_poi
  * have to worry about atomic accesses.
  */
 #define TS_USEDFPU		0x0001	/* FPU was used by this task this quantum (SMP) */
+#define TS_POLLING		0x0002	/* True if in idle loop and not sleeping */
+
+#define tsk_is_polling(t) ((t)->thread_info->status & TS_POLLING)
 
 #endif /* __KERNEL__ */
 
Index: linux/include/asm-ia64/thread_info.h
===================================================================
--- linux.orig/include/asm-ia64/thread_info.h
+++ linux/include/asm-ia64/thread_info.h
@@ -27,6 +27,7 @@ struct thread_info {
 	__u32 flags;			/* thread_info flags (see TIF_*) */
 	__u32 cpu;			/* current CPU */
 	__u32 last_cpu;			/* Last CPU thread ran on */
+	__u32 status;			/* Thread synchronous flags */
 	mm_segment_t addr_limit;	/* user-level address space limit */
 	int preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
 	struct restart_block restart_block;
@@ -103,4 +104,8 @@ struct thread_info {
 /* like TIF_ALLWORK_BITS but sans TIF_SYSCALL_TRACE or TIF_SYSCALL_AUDIT */
 #define TIF_WORK_MASK		(TIF_ALLWORK_MASK&~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT))
 
+#define TS_POLLING		1 	/* true if in idle loop and not sleeping */
+
+#define tsk_is_polling(t) ((t)->thread_info->status & TS_POLLING)
+
 #endif /* _ASM_IA64_THREAD_INFO_H */
Index: linux/include/asm-x86_64/thread_info.h
===================================================================
--- linux.orig/include/asm-x86_64/thread_info.h
+++ linux/include/asm-x86_64/thread_info.h
@@ -101,7 +101,7 @@ static inline struct thread_info *stack_
 #define TIF_IRET		5	/* force IRET */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
-#define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+/* 16 free */
 #define TIF_IA32		17	/* 32bit process */ 
 #define TIF_FORK		18	/* ret_from_fork */
 #define TIF_ABI_PENDING		19
@@ -115,7 +115,6 @@ static inline struct thread_info *stack_
 #define _TIF_IRET		(1<<TIF_IRET)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
-#define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_IA32		(1<<TIF_IA32)
 #define _TIF_FORK		(1<<TIF_FORK)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
@@ -137,6 +136,9 @@ static inline struct thread_info *stack_
  */
 #define TS_USEDFPU		0x0001	/* FPU was used by this task this quantum (SMP) */
 #define TS_COMPAT		0x0002	/* 32bit syscall active */
+#define TS_POLLING		0x0004	/* true if in idle loop and not sleeping */
+
+#define tsk_is_polling(t) ((t)->thread_info->status & TS_POLLING)
 
 #endif /* __KERNEL__ */
 
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -818,6 +818,11 @@ static void deactivate_task(struct task_
  * the target CPU.
  */
 #ifdef CONFIG_SMP
+
+#ifndef tsk_is_polling
+#define tsk_is_polling(t) test_tsk_thread_flag(t, TIF_POLLING_NRFLAG)
+#endif
+
 static void resched_task(task_t *p)
 {
 	int cpu;
@@ -833,9 +838,9 @@ static void resched_task(task_t *p)
 	if (cpu == smp_processor_id())
 		return;
 
-	/* NEED_RESCHED must be visible before we test POLLING_NRFLAG */
+	/* NEED_RESCHED must be visible before we test polling */
 	smp_mb();
-	if (!test_tsk_thread_flag(p, TIF_POLLING_NRFLAG))
+	if (!tsk_is_polling(p))
 		smp_send_reschedule(cpu);
 }
 #else
Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -102,7 +102,7 @@ void default_idle(void)
 	local_irq_enable();
 
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
-		clear_thread_flag(TIF_POLLING_NRFLAG);
+		current_thread_info()->status &= ~TS_POLLING;
 		smp_mb__after_clear_bit();
 		while (!need_resched()) {
 			local_irq_disable();
@@ -111,7 +111,7 @@ void default_idle(void)
 			else
 				local_irq_enable();
 		}
-		set_thread_flag(TIF_POLLING_NRFLAG);
+		current_thread_info()->status |= TS_POLLING;
 	} else {
 		while (!need_resched())
 			cpu_relax();
@@ -174,7 +174,7 @@ void cpu_idle(void)
 {
 	int cpu = smp_processor_id();
 
-	set_thread_flag(TIF_POLLING_NRFLAG);
+	current_thread_info()->status |= TS_POLLING;
 
 	/* endless idle loop with no priority at all */
 	while (1) {
Index: linux/arch/ia64/kernel/process.c
===================================================================
--- linux.orig/arch/ia64/kernel/process.c
+++ linux/arch/ia64/kernel/process.c
@@ -272,9 +272,9 @@ cpu_idle (void)
 	/* endless idle loop with no priority at all */
 	while (1) {
 		if (can_do_pal_halt)
-			clear_thread_flag(TIF_POLLING_NRFLAG);
+			current_thread_info()->status &= ~TS_POLLING;
 		else
-			set_thread_flag(TIF_POLLING_NRFLAG);
+			current_thread_info()->status |= TS_POLLING;
 
 		if (!need_resched()) {
 			void (*idle)(void);
Index: linux/arch/i386/kernel/apm.c
===================================================================
--- linux.orig/arch/i386/kernel/apm.c
+++ linux/arch/i386/kernel/apm.c
@@ -764,9 +764,9 @@ static int apm_do_idle(void)
 	int	idled = 0;
 	int	polling;
 
-	polling = test_thread_flag(TIF_POLLING_NRFLAG);
+	polling = !!(current_thread_info()->status & TS_POLLING);
 	if (polling) {
-		clear_thread_flag(TIF_POLLING_NRFLAG);
+		current_thread_info()->status &= ~TS_POLLING;
 		smp_mb__after_clear_bit();
 	}
 	if (!need_resched()) {
@@ -774,7 +774,7 @@ static int apm_do_idle(void)
 		ret = apm_bios_call_simple(APM_FUNC_IDLE, 0, 0, &eax);
 	}
 	if (polling)
-		set_thread_flag(TIF_POLLING_NRFLAG);
+		current_thread_info()->status |= TS_POLLING;
 
 	if (!idled)
 		return 0;

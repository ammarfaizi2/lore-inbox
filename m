Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVJPTCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVJPTCr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 15:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVJPTCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 15:02:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:60872 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751355AbVJPTCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 15:02:47 -0400
Date: Mon, 17 Oct 2005 00:26:32 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Serge Belyshev <belyshev@depni.sinp.msu.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       khali@linux-fr.org, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051016185632.GE8303@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <87fyr2ape5.fsf@foo.vault.bofh.ru> <87slv23bw5.fsf@foo.vault.bofh.ru> <20051016162306.GA10410@in.ibm.com> <873bn1thwf.fsf@foo.vault.bofh.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873bn1thwf.fsf@foo.vault.bofh.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2005 at 10:51:12PM +0400, Serge Belyshev wrote:
> Dipankar Sarma <dipankar@in.ibm.com> writes:
> 
> > Serge, could you please try the following experimental patch
> > just to see if file counting is indeed the problem. The patch
> 
> I ran my test program with this patch applied on top of 2.6.14-rc4-git4
> and it worked.

Serge, thanks for the test.

The issue is however far from resolved. We need to find about
potential scalability problems with this approach.

Secondly, on subsequent repeated tests, I saw a very large number
of allocated objects (600000+) in filp cache. That does point to either RCU
grace period not happening or my sycall measurements completely
wrong. I did run with the following patch that adds syscall
exit as a queiescent state, but it didn't help. I am going
to have to instrument RCU to see what is really happening.

Thanks
Dipankar


It turns out that under some really heavy RCU updates under simulated
conditions, a syscall bound task that doesn't block may prevent
RCU from happening during its entire timeslice and that window
may be big enough to generate out-of-memory situations for RCU
protected objects. This patch starts counting completion of
syscalls as quiescent state in order to prevent the above situation
from happening.

It introduces a new field in thread_info called rcu_qs which
stores the RCU quiescent state counter pointer for the cpu
on which the thread runs. We increment the counter on every
syscall completion to move rcu forward. This patch adds that
support to i386 and x86_64 archs, but it doesn't break other arches. As and
when support for rcu_qs is added to thread_info structs of
other arches, we need to define ARCH_HAS_RCU_QS for that
arch.

Not-Yet-Signed-Off-By: Dipankar Sarma <dipankar@in.ibm.com>



diff -puN arch/i386/kernel/entry.S~rcu-syscall-quiescent arch/i386/kernel/entry.S
--- linux-2.6.14-rc1-test/arch/i386/kernel/entry.S~rcu-syscall-quiescent	2005-10-16 11:01:35.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/arch/i386/kernel/entry.S	2005-10-16 11:25:10.000000000 -0700
@@ -239,6 +239,8 @@ syscall_exit:
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
+	movl TI_rcu_qs(%ebp), %ecx      # Update RCU quiescent state flag
+	movl $1,(%ecx)
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx	# current->work
 	jne syscall_exit_work
diff -puN include/asm-i386/thread_info.h~rcu-syscall-quiescent include/asm-i386/thread_info.h
--- linux-2.6.14-rc1-test/include/asm-i386/thread_info.h~rcu-syscall-quiescent	2005-10-16 11:01:35.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/include/asm-i386/thread_info.h	2005-10-16 11:20:37.000000000 -0700
@@ -17,6 +17,8 @@
 #include <asm/processor.h>
 #endif
 
+#define ARCH_HAS_RCU_QS
+
 /*
  * low level task data that entry.S needs immediate access to
  * - this struct should fit entirely inside of one cache line
@@ -39,6 +41,7 @@ struct thread_info {
 						   0-0xFFFFFFFF for kernel-thread
 						*/
 	struct restart_block    restart_block;
+	int			*rcu_qs;	/* RCU quiescent state flag */
 
 	unsigned long           previous_esp;   /* ESP of the previous stack in case
 						   of nested (IRQ) stacks
diff -puN include/linux/rcupdate.h~rcu-syscall-quiescent include/linux/rcupdate.h
--- linux-2.6.14-rc1-test/include/linux/rcupdate.h~rcu-syscall-quiescent	2005-10-16 11:01:35.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/include/linux/rcupdate.h	2005-10-16 12:38:56.000000000 -0700
@@ -41,6 +41,7 @@
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
+#include <linux/thread_info.h>
 
 /**
  * struct rcu_head - callback structure for use with RCU
@@ -271,6 +272,16 @@ static inline int rcu_pending(int cpu)
  */
 #define synchronize_sched() synchronize_rcu()
 
+#ifdef ARCH_HAS_RCU_QS
+static inline void rcu_set_qs(struct thread_info *ti, int cpu)
+{
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+	ti->rcu_qs = &rdp->passed_quiesc;
+}
+#else
+static inline void rcu_set_qs(struct thread_info *ti, int cpu) { }
+#endif
+
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
diff -puN init/main.c~rcu-syscall-quiescent init/main.c
--- linux-2.6.14-rc1-test/init/main.c~rcu-syscall-quiescent	2005-10-16 11:01:35.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/init/main.c	2005-10-16 12:43:19.000000000 -0700
@@ -671,6 +671,9 @@ static int init(void * unused)
 	 */
 	child_reaper = current;
 
+	/* Set up rcu quiscent state counter before making any syscall */
+	rcu_set_qs(current_thread_info(), smp_processor_id());
+
 	/* Sets up cpus_possible() */
 	smp_prepare_cpus(max_cpus);
 
diff -puN kernel/sched.c~rcu-syscall-quiescent kernel/sched.c
--- linux-2.6.14-rc1-test/kernel/sched.c~rcu-syscall-quiescent	2005-10-16 11:01:35.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/kernel/sched.c	2005-10-16 12:43:53.000000000 -0700
@@ -3006,6 +3006,7 @@ switch_tasks:
 		rq->nr_switches++;
 		rq->curr = next;
 		++*switch_count;
+		rcu_set_qs(next->thread_info, task_cpu(prev));
 
 		prepare_task_switch(rq, next);
 		prev = context_switch(rq, prev, next);
diff -puN arch/i386/kernel/asm-offsets.c~rcu-syscall-quiescent arch/i386/kernel/asm-offsets.c
--- linux-2.6.14-rc1-test/arch/i386/kernel/asm-offsets.c~rcu-syscall-quiescent	2005-10-16 11:35:28.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/arch/i386/kernel/asm-offsets.c	2005-10-16 11:36:15.000000000 -0700
@@ -53,6 +53,7 @@ void foo(void)
 	OFFSET(TI_preempt_count, thread_info, preempt_count);
 	OFFSET(TI_addr_limit, thread_info, addr_limit);
 	OFFSET(TI_restart_block, thread_info, restart_block);
+	OFFSET(TI_rcu_qs, thread_info, rcu_qs);
 	BLANK();
 
 	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
diff -puN arch/x86_64/kernel/entry.S~rcu-syscall-quiescent arch/x86_64/kernel/entry.S
--- linux-2.6.14-rc1-test/arch/x86_64/kernel/entry.S~rcu-syscall-quiescent	2005-10-16 11:48:27.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/arch/x86_64/kernel/entry.S	2005-10-16 12:03:01.000000000 -0700
@@ -214,6 +214,8 @@ ret_from_sys_call:
 sysret_check:		
 	GET_THREAD_INFO(%rcx)
 	cli
+	movq threadinfo_rcu_qs(%rcx),%rdx
+	movq $1,(%rdx)
 	movl threadinfo_flags(%rcx),%edx
 	andl %edi,%edx
 	CFI_REMEMBER_STATE
@@ -310,6 +312,8 @@ ENTRY(int_ret_from_sys_call)
 	/* edi:	mask to check */
 int_with_check:
 	GET_THREAD_INFO(%rcx)
+	movq threadinfo_rcu_qs(%rcx),%rdx
+	movl $1,(%rdx)
 	movl threadinfo_flags(%rcx),%edx
 	andl %edi,%edx
 	jnz   int_careful
diff -puN include/asm-x86_64/thread_info.h~rcu-syscall-quiescent include/asm-x86_64/thread_info.h
--- linux-2.6.14-rc1-test/include/asm-x86_64/thread_info.h~rcu-syscall-quiescent	2005-10-16 11:50:25.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/include/asm-x86_64/thread_info.h	2005-10-16 11:54:47.000000000 -0700
@@ -23,6 +23,8 @@ struct task_struct;
 struct exec_domain;
 #include <asm/mmsegment.h>
 
+#define ARCH_HAS_RCU_QS
+
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
@@ -33,6 +35,7 @@ struct thread_info {
 
 	mm_segment_t		addr_limit;	
 	struct restart_block    restart_block;
+	int			*rcu_qs;
 };
 #endif
 
diff -puN arch/x86_64/kernel/asm-offsets.c~rcu-syscall-quiescent arch/x86_64/kernel/asm-offsets.c
--- linux-2.6.14-rc1-test/arch/x86_64/kernel/asm-offsets.c~rcu-syscall-quiescent	2005-10-16 11:52:13.000000000 -0700
+++ linux-2.6.14-rc1-test-dipankar/arch/x86_64/kernel/asm-offsets.c	2005-10-16 11:53:14.000000000 -0700
@@ -33,6 +33,7 @@ int main(void)
 	ENTRY(flags);
 	ENTRY(addr_limit);
 	ENTRY(preempt_count);
+	ENTRY(rcu_qs);
 	BLANK();
 #undef ENTRY
 #define ENTRY(entry) DEFINE(pda_ ## entry, offsetof(struct x8664_pda, entry))

_

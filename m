Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVHBTpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVHBTpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 15:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVHBTpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 15:45:52 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:34227 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261750AbVHBTpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 15:45:50 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050802101920.GA25759@elte.hu>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
	 <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 02 Aug 2005 15:45:28 -0400
Message-Id: <1123011928.1590.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 12:19 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > In my custom kernel, I have a wchan field of the task that records 
> > where the task calls something that might schedule. This way I can see 
> > where things locked up if I don't have a back trace of the task.  This 
> > field is always zero when it switches to usermode.  Something like 
> > this can also be used to check how long the process is in kernel mode.  
> > If a task is in the kernel for more than 10 seconds without sleeping, 
> > that would definitely be a good indication of something wrong.  I 
> > probably could write something to check for this if people are 
> > interested.  I wont waste my time if nobody would want it.
> 
> this would be a pretty useful extension of the softlockup checker!

Here it is (Finally).  I just had to be patient with the kjournal
lockup.  I had to wait some time before the lockup occurred, but when it
did, I got my message out:
--------------------------------------------
BUG: possible soft lockup detected on CPU#0! 1314840-1313839(1314839)
curr=kjournald:734 count=11
 [<c010410f>] dump_stack+0x1f/0x30 (20)
 [<c01441e0>] softlockup_tick+0x170/0x1a0 (44)
 [<c0125d32>] update_process_times+0x62/0x140 (28)
 [<c010861d>] timer_interrupt+0x4d/0x100 (20)
 [<c014450f>] handle_IRQ_event+0x6f/0x120 (48)
 [<c014469c>] __do_IRQ+0xdc/0x1a0 (48)
 [<c0105abe>] do_IRQ+0x4e/0x90 (28)
 [<c0103b67>] common_interrupt+0x1f/0x24 (112)
 [<c01edc36>] journal_commit_transaction+0x1206/0x1430 (112)
 [<c01f06d0>] kjournald+0xd0/0x1e0 (84)
 [<c01011ed>] kernel_thread_helper+0x5/0x18 (825638940)
---------------------------
| preempt count: 20010003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c013d49a>] .... add_preempt_count+0x1a/0x20
.....[<c01085ec>] ..   ( <= timer_interrupt+0x1c/0x100)
.. [<c013d49a>] .... add_preempt_count+0x1a/0x20
.....[<c014418d>] ..   ( <= softlockup_tick+0x11d/0x1a0)
.. [<c013d49a>] .... add_preempt_count+0x1a/0x20
.....[<c013e727>] ..   ( <= print_traces+0x17/0x50)

------------------------------
| showing all locks held by: |  (kjournald/734 [c13e20b0,  69]):
------------------------------
-----------------------------------------------

This does NOT detect lockups in user space. If a RT user program gets
stuck in an infinite loop, it's their problem. This only detects lockups
in the kernel. I also don't determine a difference if a kernel is stuck
as a RT task or not, as long as it tries to sleep once in a while this
message wont appear. I'm not aware of any kernel thread that spins in
the kernel, so I don't think this will be a problem. (I forgot about
swapper and it was showing up, hence the check for current->pid :-).

Note this currently only works with i386. If other archs want this, they
need to modify the thread_info to include the softlockup_count, and then
upon returning to user space it needs to be reset.  Then the
ARCH_HAS_SOFTLOCK_DETECT needs to be defined. This counter will be reset
at every time the kernel enters users space, so this includes the timer
interrupt.


-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_ernie/kernel/sched.c
===================================================================
--- linux_realtime_ernie/kernel/sched.c	(revision 266)
+++ linux_realtime_ernie/kernel/sched.c	(working copy)
@@ -3367,6 +3367,8 @@
 		send_sig(SIGUSR2, current, 1);
 	}
 	do {
+		if (current->state & ~TASK_RUNNING_MUTEX)
+			touch_light_softlockup_watchdog();
 		__schedule();
 	} while (unlikely(test_thread_flag(TIF_NEED_RESCHED) || test_thread_flag(TIF_NEED_RESCHED_DELAYED)));
 	raw_local_irq_enable(); // TODO: do sti; ret
Index: linux_realtime_ernie/kernel/softlockup.c
===================================================================
--- linux_realtime_ernie/kernel/softlockup.c	(revision 269)
+++ linux_realtime_ernie/kernel/softlockup.c	(working copy)
@@ -3,6 +3,10 @@
  *
  * started by Ingo Molnar, (C) 2005, Red Hat
  *
+ * Steven Rostedt, Kihon Technologies Inc.
+ *   Added light softlockup detection off of what Daniel Walker of
+ *   MontaVista started.
+ *
  * this code detects soft lockups: incidents in where on a CPU
  * the kernel does not reschedule for 10 seconds or more.
  */
@@ -20,9 +24,7 @@
 static DEFINE_PER_CPU(unsigned long, timeout) = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, timestamp) = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, print_timestamp) = INITIAL_JIFFIES;
-static DEFINE_PER_CPU(struct task_struct *, prev_task);
 static DEFINE_PER_CPU(struct task_struct *, watchdog_task);
-static DEFINE_PER_CPU(unsigned long, task_counter);
 
 static int did_panic = 0;
 static int softlock_panic(struct notifier_block *this, unsigned long event,
@@ -59,25 +61,25 @@
 		if (!per_cpu(watchdog_task, this_cpu))
 			return;
 
-		if (per_cpu(prev_task, this_cpu) != current || 
-			!rt_task(current)) {
-			per_cpu(prev_task, this_cpu) = current;
-			per_cpu(task_counter, this_cpu) = 0;
-		}
-		else if ((++per_cpu(task_counter, this_cpu) > 10) && printk_ratelimit()) {
-
-			spin_lock(&print_lock);
-			printk(KERN_ERR "BUG: possible soft lockup detected on CPU#%u! %lu-%lu(%lu)\n",
-				this_cpu, jiffies, timestamp, timeout);
-			printk("curr=%s:%d\n",current->comm,current->pid);
-			
-			dump_stack();
+#ifdef ARCH_HAS_SOFTLOCKUP_DETECT
+		if (current->pid) {
+			unsigned long count;
+			count = task_softlockup_count(current);
+			if (++count > 10) {
+				spin_lock(&print_lock);
+				printk(KERN_ERR "BUG: possible soft lockup detected on CPU#%u! %lu-%lu(%lu)\n",
+				       this_cpu, jiffies, timestamp, timeout);
+				printk("curr=%s:%d count=%ld\n",current->comm,current->pid,count);
+				dump_stack();
 #if defined(__i386__) && defined(CONFIG_SMP)
-			nmi_show_all_regs();
+				nmi_show_all_regs();
 #endif
-			spin_unlock(&print_lock);
-			per_cpu(task_counter, this_cpu) = 0;
+				spin_unlock(&print_lock);
+				count = 0;
+			}
+			set_task_softlockup_count(current,count);
 		}
+#endif /* ARCH_HAS_SOFTLOCKUP_DETECT */
 
 		wake_up_process(per_cpu(watchdog_task, this_cpu));
 		per_cpu(timeout, this_cpu) = jiffies + msecs_to_jiffies(1000);
@@ -101,7 +103,6 @@
 		nmi_show_all_regs();
 #endif
 		spin_unlock(&print_lock);
-		per_cpu(task_counter, this_cpu) = 0;
 	}
 }
 
Index: linux_realtime_ernie/include/asm-i386/thread_info.h
===================================================================
--- linux_realtime_ernie/include/asm-i386/thread_info.h	(revision 266)
+++ linux_realtime_ernie/include/asm-i386/thread_info.h	(working copy)
@@ -43,6 +43,13 @@
 	unsigned long           previous_esp;   /* ESP of the previous stack in case
 						   of nested (IRQ) stacks
 						*/
+#ifdef CONFIG_DETECT_SOFTLOCKUP
+#define ARCH_HAS_SOFTLOCKUP_DETECT
+	unsigned long		softlockup_count; /* Count to keep track how long the
+						     thread is in the kernel without
+						     sleeping.
+						  */
+#endif
 	__u8			supervisor_stack[0];
 };
 
Index: linux_realtime_ernie/include/linux/sched.h
===================================================================
--- linux_realtime_ernie/include/linux/sched.h	(revision 266)
+++ linux_realtime_ernie/include/linux/sched.h	(working copy)
@@ -1497,6 +1497,26 @@
 
 #endif /* CONFIG_SMP */
 
+#ifdef ARCH_HAS_SOFTLOCKUP_DETECT
+static inline unsigned long task_softlockup_count(const struct task_struct *p)
+{
+	return p->thread_info->softlockup_count;
+}
+static inline void set_task_softlockup_count(const struct task_struct *p,
+					     unsigned long count)
+{
+	p->thread_info->softlockup_count = count;
+}
+static inline void touch_light_softlockup_watchdog(void)
+{
+	set_task_softlockup_count(current, 0);
+}
+#else
+static inline void touch_light_softlockup_watchdog(void)
+{
+}
+#endif
+
 #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
 extern void arch_pick_mmap_layout(struct mm_struct *mm);
 #else
Index: linux_realtime_ernie/arch/i386/kernel/asm-offsets.c
===================================================================
--- linux_realtime_ernie/arch/i386/kernel/asm-offsets.c	(revision 266)
+++ linux_realtime_ernie/arch/i386/kernel/asm-offsets.c	(working copy)
@@ -53,6 +53,9 @@
 	OFFSET(TI_preempt_count, thread_info, preempt_count);
 	OFFSET(TI_addr_limit, thread_info, addr_limit);
 	OFFSET(TI_restart_block, thread_info, restart_block);
+#ifdef CONFIG_DETECT_SOFTLOCKUP
+	OFFSET(TI_softlockup_count, thread_info, softlockup_count);
+#endif
 	BLANK();
 
 	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
Index: linux_realtime_ernie/arch/i386/kernel/entry.S
===================================================================
--- linux_realtime_ernie/arch/i386/kernel/entry.S	(revision 266)
+++ linux_realtime_ernie/arch/i386/kernel/entry.S	(working copy)
@@ -155,6 +155,10 @@
 	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done on
 					# int/exception return?
 	jne work_pending
+#ifdef CONFIG_DETECT_SOFTLOCKUP
+	movl $0, TI_softlockup_count(%ebp)  # Zero out the count when going
+					# back to userland
+#endif
 	jmp restore_all
 
 #ifdef CONFIG_PREEMPT



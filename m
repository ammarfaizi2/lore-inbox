Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292169AbSBPEne>; Fri, 15 Feb 2002 23:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292314AbSBPEnZ>; Fri, 15 Feb 2002 23:43:25 -0500
Received: from nrg.org ([216.101.165.106]:9554 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S292169AbSBPEnQ>;
	Fri, 15 Feb 2002 23:43:16 -0500
Date: Fri, 15 Feb 2002 20:43:12 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Preemption logging
Message-ID: <Pine.LNX.4.40.0202152039330.16115-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the kernel preemption logging patch I mentioned a while ago,
against 2.5.5-pre1.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

diff -Nur -X /home/nigel/.diffignore linux_pre/Documentation/preempt_logging.txt linux_log/Documentation/preempt_logging.txt
--- linux_pre/Documentation/preempt_logging.txt	Wed Dec 31 16:00:00 1969
+++ linux_log/Documentation/preempt_logging.txt	Fri Feb 15 20:14:26 2002
@@ -0,0 +1,27 @@
+Kernel preemption debugging tool
+---------------------------------
+
+CONFIG_PREEMPT_LOG adds a kernel preemption log, which can be very
+useful in debugging unprotected critical regions.  The log records the
+instruction address where the preemption occurred, the PID of the
+process that was preempted, and a timestamp.
+
+show_preempt_log() dumps the most recent 20 events, most recent first.
+Printed for each event are the PID of the preempted process, the number
+of milliseconds since the most recent preemption and the instruction
+pointer address of where the process was preempted.  show_preempt_log()
+is added to the kernel Oops message, and can also be viewed with
+SysRq-G.  (The addresses are repeated in a format that can be fed to
+ksymoops for decoding into symbols.)
+
+save_preempt_log() can be used to take a snapshot of the preemption log
+after an "interesting" event has taken place.  For example, I used this
+to catch the preemption problem that turned out to be the page fault
+trap handler being called with interrupts enabled, leading to corruption
+of the fault address register if preemption occurred before it was
+saved.  I added a call to save_preemp_log() in fault.c at the point
+where a process is about to be killed with a SEGFAULT.  Sure enough, the
+preemption log showed a preemption on the first instruction of the trap
+handler whenever a process unexpectedly SEGVed.  (This problem was fixed
+in Linux subsequently, when it turned out to be a problem even without
+preemption.)
diff -Nur -X /home/nigel/.diffignore linux_pre/arch/i386/Config.help linux_log/arch/i386/Config.help
--- linux_pre/arch/i386/Config.help	Wed Feb 13 17:36:45 2002
+++ linux_log/arch/i386/Config.help	Fri Feb 15 20:20:38 2002
@@ -932,3 +932,9 @@
   of the BUG call as well as the EIP and oops trace.  This aids
   debugging but costs about 70-100K of memory.

+CONFIG_PREEMPT_LOG
+  Say Y here to include a log of kernel preemption events. This can
+  be very helpful when debugging problems caused by preemption taking
+  place in unprotected critical regions.
+  See Documentation/preempt_logging.txt.
+
diff -Nur -X /home/nigel/.diffignore linux_pre/arch/i386/config.in linux_log/arch/i386/config.in
--- linux_pre/arch/i386/config.in	Wed Feb 13 17:39:44 2002
+++ linux_log/arch/i386/config.in	Thu Feb 14 13:06:28 2002
@@ -403,6 +403,7 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
+   dep_bool '  Preemption logging' CONFIG_PREEMPT_LOG $CONFIG_PREEMPT
 fi

 endmenu
diff -Nur -X /home/nigel/.diffignore linux_pre/arch/i386/kernel/entry.S linux_log/arch/i386/kernel/entry.S
--- linux_pre/arch/i386/kernel/entry.S	Thu Feb 14 12:23:57 2002
+++ linux_log/arch/i386/kernel/entry.S	Fri Feb 15 13:48:27 2002
@@ -244,6 +244,12 @@
 	sti
 	movl TI_TASK(%ebx), %ecx		# ti->task
 	movl $0,(%ecx)			# current->state = TASK_RUNNING
+#ifdef CONFIG_PREEMPT_LOG
+	movl EIP(%esp),%ecx
+	pushl %ecx
+	call SYMBOL_NAME(log_preemption)
+	addl $4,%esp
+#endif
 	call SYMBOL_NAME(schedule)
 	jmp ret_from_intr
 #endif
diff -Nur -X /home/nigel/.diffignore linux_pre/arch/i386/kernel/traps.c linux_log/arch/i386/kernel/traps.c
--- linux_pre/arch/i386/kernel/traps.c	Wed Feb 13 17:36:45 2002
+++ linux_log/arch/i386/kernel/traps.c	Fri Feb 15 19:48:13 2002
@@ -84,6 +84,9 @@
 asmlinkage void alignment_check(void);
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
+#ifdef CONFIG_PREEMPT_LOG
+extern void show_preempt_log(void);
+#endif

 int kstack_depth_to_print = 24;

@@ -235,6 +238,9 @@
 		}
 	}
 	printk("\n");
+#ifdef CONFIG_PREEMPT_LOG
+	show_preempt_log();
+#endif
 }

 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
diff -Nur -X /home/nigel/.diffignore linux_pre/drivers/char/sysrq.c linux_log/drivers/char/sysrq.c
--- linux_pre/drivers/char/sysrq.c	Thu Jan  3 12:20:10 2002
+++ linux_log/drivers/char/sysrq.c	Fri Feb 15 19:47:12 2002
@@ -266,6 +266,18 @@
 	action_msg:	"Show State",
 };

+#ifdef CONFIG_PREEMPT_LOG
+extern void show_preempt_log(void);
+static void sysrq_handle_show_preempt_log(int key, struct pt_regs *pt_regs,
+		struct kbd_struct *kbd, struct tty_struct *tty) {
+	show_preempt_log();
+}
+static struct sysrq_key_op sysrq_show_preempt_log_op = {
+	handler:	sysrq_handle_show_preempt_log,
+	help_msg:	"showpreemptloG",
+	action_msg:	"Show Preempt Log",
+};
+#endif

 static void sysrq_handle_showmem(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
@@ -357,7 +369,11 @@
 /* d */	NULL,
 /* e */	&sysrq_term_op,
 /* f */	NULL,
+#ifdef CONFIG_PREEMPT_LOG
+/* g */	&sysrq_show_preempt_log_op,
+#else
 /* g */	NULL,
+#endif
 /* h */	NULL,
 /* i */	&sysrq_kill_op,
 /* j */	NULL,
diff -Nur -X /home/nigel/.diffignore linux_pre/include/linux/spinlock.h linux_log/include/linux/spinlock.h
--- linux_pre/include/linux/spinlock.h	Wed Feb 13 17:47:46 2002
+++ linux_log/include/linux/spinlock.h	Fri Feb 15 19:49:58 2002
@@ -157,7 +157,13 @@

 #ifdef CONFIG_PREEMPT

+#ifdef CONFIG_PREEMPT_LOG
+asmlinkage void preempt_schedule(void *);
+#define preempt_schedule_and_log(ip) preempt_schedule(ip)
+#else
 asmlinkage void preempt_schedule(void);
+#define preempt_schedule_and_log(ip) preempt_schedule()
+#endif

 #define preempt_get_count() (current_thread_info()->preempt_count)

@@ -178,7 +184,7 @@
 	--current_thread_info()->preempt_count; \
 	barrier(); \
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
-		preempt_schedule(); \
+		preempt_schedule_and_log(current_text_addr()); \
 } while (0)

 #define spin_lock(lock)	\
diff -Nur -X /home/nigel/.diffignore linux_pre/kernel/sched.c linux_log/kernel/sched.c
--- linux_pre/kernel/sched.c	Wed Feb 13 17:39:58 2002
+++ linux_log/kernel/sched.c	Fri Feb 15 19:02:43 2002
@@ -839,13 +839,145 @@
 /*
  * this is is the entry point to schedule() from in-kernel preemption.
  */
+#ifdef CONFIG_PREEMPT_LOG
+asmlinkage void log_preemption(void *ip);
+asmlinkage void preempt_schedule(void *ip)
+#else
 asmlinkage void preempt_schedule(void)
+#endif
 {
 	if (unlikely(preempt_get_count()))
 		return;
+#ifdef CONFIG_PREEMPT_LOG
+	log_preemption(ip);
+#endif
 	current->state = TASK_RUNNING;
 	schedule();
 }
+
+#ifdef CONFIG_PREEMPT_LOG
+typedef struct {
+	struct timeval tv;
+	void *ip;
+	pid_t pid;
+} preempt_entry;
+
+#define PREEMPT_LOG_LEN 100
+
+static preempt_entry preempt_log[PREEMPT_LOG_LEN] = {{{ 0, 0 }, 0, 0 }};
+static preempt_entry saved_preempt_log[PREEMPT_LOG_LEN] = {{{ 0, 0 }, 0, 0 }};
+
+static int pli = -1;
+static int saved_pli = 0;
+static spinlock_t preempt_log_lock = SPIN_LOCK_UNLOCKED;
+
+asmlinkage void log_preemption(void *ip)
+{
+	unsigned long flags;
+
+	if (!ip)
+		return;
+
+	/* Avoid unwanted preemption on unlock */
+	preempt_disable();
+	spin_lock_irqsave(&preempt_log_lock, flags);
+	/*
+	 * Compress the log by eliminating consecutive identical
+	 * preempted addresses.  Stops the log filling up with addresses
+	 * in default_idle.
+	 */
+	if (ip == preempt_log[pli].ip)
+		goto out;
+	if (++pli == PREEMPT_LOG_LEN)
+		pli = 0;
+	preempt_log[pli].pid = current->pid;
+	preempt_log[pli].ip = ip;
+	do_gettimeofday(&preempt_log[pli].tv);
+out:
+	spin_unlock_irqrestore(&preempt_log_lock, flags);
+	preempt_enable_no_resched();
+}
+
+static int preempt_log_saved = 0;
+
+void save_preempt_log()
+{
+
+	unsigned long flags;
+	spin_lock_irqsave(&preempt_log_lock, flags);
+	memcpy(saved_preempt_log, preempt_log, sizeof saved_preempt_log);
+	saved_pli = pli;
+	spin_unlock_irqrestore(&preempt_log_lock, flags);
+	preempt_log_saved = 1;
+}
+
+void show_preempt_log()
+{
+	int i;
+	struct timeval *t0;
+	struct timeval now;
+	long recent;
+
+	if (!preempt_log_saved)
+		save_preempt_log();
+
+	do_gettimeofday(&now);
+
+	t0 = &saved_preempt_log[saved_pli].tv;
+
+	recent = ((now.tv_sec - t0->tv_sec) * 1000000 +
+		 (now.tv_usec - t0->tv_usec)) / 1000;
+	printk("Most recently logged preemption event happened %ldms ago\n",
+		recent);
+
+	printk("  pid   time preempted_IP\n");
+
+	for (i = 0; i < 20; i++) {
+		int n = saved_pli - i;
+		long msecs;
+		struct timeval *t;
+
+		if (n < 0)
+			n += PREEMPT_LOG_LEN;
+
+		t = &saved_preempt_log[n].tv;
+
+		msecs = ((t0->tv_sec - t->tv_sec) * 1000000 +
+			(t0->tv_usec - t->tv_usec)) / 1000;
+
+		printk("%5d", saved_preempt_log[n].pid);
+		printk(" %6ld", msecs);
+#if (BITS_PER_LONG == 32)
+		printk(" [<%08lx>]\n", (unsigned long)(saved_preempt_log[n].ip));
+#else
+		printk(" [<%016lx>]\n", (unsigned long)(saved_preempt_log[n].ip));
+#endif
+	}
+
+	/*
+	 * Repeat the addresses while pretending to be a trace,
+	 * so that the existing version of ksymoops will helpfully
+	 * decode them.
+	 */
+	printk("Trace:");
+	for (i = 0; i < 20; i++) {
+		int n = saved_pli - i;
+
+		if (n < 0)
+			n += PREEMPT_LOG_LEN;
+
+#if (BITS_PER_LONG == 32)
+		printk(" [<%08lx>]", (unsigned long)(saved_preempt_log[n].ip));
+#else
+		printk(" [<%016lx>]", (unsigned long)(saved_preempt_log[n].ip));
+#endif
+	}
+	printk("\n");
+
+	preempt_log_saved = 0;
+}
+
+#endif /* CONFIG_PREEMPT_LOG */
 #endif /* CONFIG_PREEMPT */

 /*


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966227AbWKXWEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966227AbWKXWEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 17:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966256AbWKXWEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 17:04:20 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:61121 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966257AbWKXWES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 17:04:18 -0500
Date: Fri, 24 Nov 2006 17:04:13 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 15/16] LTTng 0.6.36 for 2.6.18 : Userspace tracing
Message-ID: <20061124220413.GP25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 17:03:36 up 93 days, 19:11,  3 users,  load average: 2.50, 1.14, 0.65
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace tracing : facility registration and event logging through system
call.

patch15-2.6.18-lttng-core-0.6.36-userspace-tracing.diff

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>


--BEGIN--
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -82,6 +82,7 @@ #include <linux/timer.h>
 #include <linux/hrtimer.h>
 
 #include <asm/processor.h>
+#include <linux/ltt-facilities.h>
 
 struct exec_domain;
 struct futex_pi_state;
@@ -996,6 +997,9 @@ #endif
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+#ifdef CONFIG_LTT_USERSPACE_GENERIC
+	ltt_facility_t ltt_facilities[LTT_FAC_PER_PROCESS];
+#endif //CONFIG_LTT_USERSPACE_GENERIC
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -111,6 +111,8 @@ cond_syscall(sys_vm86old);
 cond_syscall(sys_vm86);
 cond_syscall(compat_sys_ipc);
 cond_syscall(compat_sys_sysctl);
+cond_syscall(sys_ltt_trace_generic);
+cond_syscall(sys_ltt_register_generic);
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
--- /dev/null
+++ b/ltt/ltt-syscall.c
@@ -0,0 +1,184 @@
+/******************************************************************************
+ * ltt-syscall.c
+ *
+ * Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ * March 2006
+ *
+ * LTT userspace tracing syscalls
+ */
+
+#include <linux/errno.h>
+#include <linux/syscalls.h>
+#include <linux/sched.h>
+#include <linux/ltt-facilities.h>
+#include <ltt/ltt-tracer.h>
+
+#include <asm/uaccess.h>
+
+/* User event logging function */
+static inline int trace_user_event(unsigned int facility_id,
+		unsigned int event_id,
+		void __user *data, size_t data_size, int blocking,
+		int high_priority)
+{
+	int ret = 0;
+	unsigned int index;
+	struct ltt_channel_struct *channel;
+	struct ltt_trace_struct *trace;
+	void *transport_data;
+	void *buffer = NULL;
+	size_t real_to_base = 0; /* buffer allocated on arch_size alignment */
+	size_t *to_base = &real_to_base;
+	size_t real_to = 0;
+	size_t *to = &real_to;
+	size_t real_len = 0;
+	size_t *len = &real_len;
+	size_t reserve_size;
+	size_t slot_size;
+	u64 tsc;
+	size_t before_hdr_pad, after_hdr_pad, header_size;
+	struct user_dbg_data dbg;
+
+	dbg.avail_size = 0;
+	dbg.write = 0;
+	dbg.read = 0;
+
+	if (ltt_traces.num_active_traces == 0)
+		return 0;
+
+	/* Assume that the padding for alignment starts at a
+	 * sizeof(void *) address. */
+
+	reserve_size = data_size;
+
+	if (high_priority)
+		index = GET_CHANNEL_INDEX(processes);
+	else
+		index = GET_CHANNEL_INDEX(cpu);
+
+	preempt_disable();
+
+	if (blocking) {
+		/* User space requested blocking mode :
+		 * If one of the active traces has free space below a specific
+		 * threshold value, we reenable preemption and block. */
+block_test_begin:
+		list_for_each_entry_rcu(trace, &ltt_traces.head, list) {
+			if (!trace->active)
+  				continue;
+
+			if (trace->ops->user_blocking(trace, index, data_size,
+							&dbg))
+ 				goto block_test_begin;
+		}
+	}
+	ltt_nesting[smp_processor_id()]++;
+	list_for_each_entry_rcu(trace, &ltt_traces.head, list) {
+		if (!trace->active)
+			continue;
+		channel = ltt_get_channel_from_index(trace, index);
+		slot_size = 0;
+		buffer = ltt_reserve_slot(trace, channel, &transport_data,
+			reserve_size, &slot_size, &tsc,
+			&before_hdr_pad, &after_hdr_pad, &header_size);
+		if (!buffer) {
+			if (blocking)
+				trace->ops->user_errors(trace,
+					index, data_size, &dbg);
+			continue; /* buffer full */
+		}
+		*to_base = *to = *len = 0;
+		ltt_write_event_header(trace, channel, buffer,
+			facility_id, event_id,
+			reserve_size, before_hdr_pad, tsc);
+		*to_base += before_hdr_pad + after_hdr_pad + header_size;
+		/* Hope the user pages are not swapped out. In the rare case
+		 * where it is, the slot will be zeroed and EFAULT returned. */
+		if (__copy_from_user_inatomic(buffer+*to_base+*to, data,
+					data_size))
+			ret = -EFAULT;	/* Data is garbage in the slot */
+		ltt_commit_slot(channel, &transport_data, buffer, slot_size);
+		if (ret != 0)
+			break;
+	}
+	ltt_nesting[smp_processor_id()]--;
+	preempt_enable_no_resched();
+	return ret;
+}
+
+asmlinkage long sys_ltt_trace_generic(unsigned int facility_id,
+		unsigned int event_id,
+		void __user *data,
+		size_t data_size,
+		int blocking,
+		int high_priority)
+{
+	if (!ltt_facility_user_access_ok(facility_id))
+		return -EPERM;
+	if (!access_ok(VERIFY_READ, data, data_size))
+			return -EFAULT;
+	
+	return trace_user_event(facility_id, event_id, data, data_size,
+			blocking, high_priority);
+}
+
+asmlinkage long sys_ltt_register_generic(unsigned int __user *facility_id,
+		const struct user_facility_info __user *info)
+{
+	struct user_facility_info kinfo;
+	int fac_id;
+	unsigned int i;
+
+	/* Check if the process has already registered the maximum number of 
+	 * allowed facilities */
+	if (current->ltt_facilities[LTT_FAC_PER_PROCESS-1] != 0)
+		return -EPERM;
+	
+	if (copy_from_user(&kinfo, info, sizeof(*info)))
+		return -EFAULT;
+
+	/* Verify if facility is already registered */
+	printk(KERN_DEBUG "LTT register generic for %s\n", kinfo.name);
+	fac_id = ltt_facility_verify(LTT_FACILITY_TYPE_USER,
+				kinfo.name,
+				kinfo.num_events,
+				kinfo.checksum,
+				kinfo.int_size,
+				kinfo.long_size,
+				kinfo.pointer_size,
+				kinfo.size_t_size,
+				kinfo.alignment);
+	
+	printk(KERN_DEBUG "LTT verify return %d\n", fac_id);
+	if (fac_id > 0)
+		goto found;
+	
+	fac_id = ltt_facility_register(LTT_FACILITY_TYPE_USER,
+				kinfo.name,
+				kinfo.num_events,
+				kinfo.checksum,
+				kinfo.int_size,
+				kinfo.long_size,
+				kinfo.pointer_size,
+				kinfo.size_t_size,
+				kinfo.alignment);
+
+	printk(KERN_DEBUG "LTT register return %d\n", fac_id);
+	if (fac_id == 0)
+		return -EPERM;
+	if (fac_id < 0)
+		return fac_id;	/* Error */
+found:
+	get_task_struct(current->group_leader);
+	for (i = 0; i < LTT_FAC_PER_PROCESS; i++) {
+		if (current->group_leader->ltt_facilities[i] == 0) {
+			current->group_leader->ltt_facilities[i] =
+				(ltt_facility_t)fac_id;
+			break;
+		}
+	}
+	put_task_struct(current->group_leader);
+	/* Write facility_id */
+	put_user((unsigned int)fac_id, facility_id);
+	return 0;
+}
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -38,6 +38,7 @@ #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
+#include <linux/ltt-facilities.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -59,6 +60,17 @@ static void __unhash_process(struct task
 
 		list_del_rcu(&p->tasks);
 		__get_cpu_var(process_counts)--;
+#ifdef CONFIG_LTT_USERSPACE_GENERIC
+		{
+			int i;
+			for (i = 0; i < LTT_FAC_PER_PROCESS; i++) {
+				if (p->ltt_facilities[i] == 0)
+					break;
+				WARN_ON(ltt_facility_unregister(
+							p->ltt_facilities[i]));
+			}
+		}
+#endif //CONFIG_LTT_USERSPACE_GENERIC
 	}
 	list_del_rcu(&p->thread_group);
 	remove_parent(p);
@@ -170,6 +182,7 @@ repeat:
 	write_unlock_irq(&tasklist_lock);
 	proc_flush_task(p);
 	release_thread(p);
+	MARK(kernel_process_free, "%d", p->pid);
 	call_rcu(&p->rcu, delayed_put_task_struct);
 
 	p = leader;
@@ -913,6 +926,8 @@ #endif
 
 	if (group_dead)
 		acct_process();
+	MARK(kernel_process_exit, "%d", tsk->pid);
+	
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
@@ -1440,6 +1455,8 @@ static long do_wait(pid_t pid, int optio
 	struct task_struct *tsk;
 	int flag, retval;
 
+	MARK(kernel_process_wait, "%d", pid);
+
 	add_wait_queue(&current->signal->wait_chldexit,&wait);
 repeat:
 	/*
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -45,6 +45,7 @@ #include <linux/acct.h>
 #include <linux/cn_proc.h>
 #include <linux/delayacct.h>
 #include <linux/taskstats_kern.h>
+#include <linux/ltt-facilities.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -64,6 +65,7 @@ int max_threads;		/* tunable limit on nr
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
 __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
+EXPORT_SYMBOL(tasklist_lock);
 
 int nr_processes(void)
 {
@@ -1133,6 +1135,13 @@ #endif
 	 * of CLONE_PTRACE.
 	 */
 	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
+#ifdef CONFIG_MARKERS
+	/*
+	 * Syscall tracing must always be turned on when markers are enabled.
+	 * Use the syscall audit thread flag for now, as it is never cleared.
+	 */
+	set_tsk_thread_flag(p, TIF_SYSCALL_AUDIT);
+#endif
 #ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
 #endif
@@ -1142,6 +1151,20 @@ #endif
 	   
 	p->parent_exec_id = p->self_exec_id;
 
+#ifdef CONFIG_LTT_USERSPACE_GENERIC
+	if (clone_flags & CLONE_THREAD)
+		memset(p->ltt_facilities, 0, sizeof(p->ltt_facilities));
+	else {
+		int i;
+		for (i = 0; i < LTT_FAC_PER_PROCESS; i++) {
+			p->ltt_facilities[i] = current->ltt_facilities[i];
+			if (p->ltt_facilities[i] != 0)
+				ltt_facility_ref(p->ltt_facilities[i]);
+		}
+	}
+
+#endif //CONFIG_LTT_USERSPACE_GENERIC
+	
 	/* ok, now we should be set up.. */
 	p->exit_signal = (clone_flags & CLONE_THREAD) ? -1 : (clone_flags & CSIGNAL);
 	p->pdeath_signal = 0;
@@ -1198,7 +1221,7 @@ #endif
 		spin_unlock(&current->sighand->siglock);
 		write_unlock_irq(&tasklist_lock);
 		retval = -ERESTARTNOINTR;
-		goto bad_fork_cleanup_namespace;
+		goto bad_fork_cleanup_ltt_facilities;
 	}
 
 	if (clone_flags & CLONE_THREAD) {
@@ -1251,6 +1274,18 @@ #endif
 	proc_fork_connector(p);
 	return p;
 
+bad_fork_cleanup_ltt_facilities:
+#ifdef CONFIG_LTT_USERSPACE_GENERIC
+		{
+			int i;
+			for (i = 0; i < LTT_FAC_PER_PROCESS; i++) {
+				if (p->ltt_facilities[i] == 0)
+					break;
+				WARN_ON(ltt_facility_unregister(
+							p->ltt_facilities[i]));
+			}
+		}
+#endif //CONFIG_LTT_USERSPACE_GENERIC
 bad_fork_cleanup_namespace:
 	exit_namespace(p);
 bad_fork_cleanup_keys:
@@ -1364,6 +1399,9 @@ long do_fork(unsigned long clone_flags,
 	if (!IS_ERR(p)) {
 		struct completion vfork;
 
+		MARK(kernel_process_fork, "%d %d %d",
+			current->pid, p->pid, p->tgid);
+
 		if (clone_flags & CLONE_VFORK) {
 			p->vfork_done = &vfork;
 			init_completion(&vfork);
--- a/include/asm-arm/unistd.h
+++ b/include/asm-arm/unistd.h
@@ -347,6 +347,8 @@ #define __NR_inotify_rm_watch		(__NR_SYS
 #define __NR_mbind			(__NR_SYSCALL_BASE+319)
 #define __NR_get_mempolicy		(__NR_SYSCALL_BASE+320)
 #define __NR_set_mempolicy		(__NR_SYSCALL_BASE+321)
+#define	__NR_ltt_trace_generic		(__NR_SYSCALL_BASE+322)
+#define	__NR_ltt_register_generic	(__NR_SYSCALL_BASE+323)
 
 /*
  * The following SWIs are ARM private.
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -323,10 +323,12 @@ #define __NR_sync_file_range	314
 #define __NR_tee		315
 #define __NR_vmsplice		316
 #define __NR_move_pages		317
+#define __NR_ltt_trace_generic	318
+#define __NR_ltt_register_generic	319
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 318
+#define NR_syscalls 320
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
--- a/include/asm-mips/unistd.h
+++ b/include/asm-mips/unistd.h
@@ -329,16 +329,18 @@ #define __NR_sync_file_range		(__NR_Linu
 #define __NR_tee			(__NR_Linux + 306)
 #define __NR_vmsplice			(__NR_Linux + 307)
 #define __NR_move_pages			(__NR_Linux + 308)
+#define	__NR_ltt_trace_generic		(__NR_Linux + 309)
+#define	__NR_ltt_register_generic	(__NR_Linux + 310)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		308
+#define __NR_Linux_syscalls		310
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		308
+#define __NR_O32_Linux_syscalls		310
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -614,16 +616,18 @@ #define __NR_sync_file_range		(__NR_Linu
 #define __NR_tee			(__NR_Linux + 265)
 #define __NR_vmsplice			(__NR_Linux + 266)
 #define __NR_move_pages			(__NR_Linux + 267)
+#define	__NR_ltt_trace_generic		(__NR_Linux + 268)
+#define	__NR_ltt_register_generic	(__NR_Linux + 269)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		267
+#define __NR_Linux_syscalls		269
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		267
+#define __NR_64_Linux_syscalls		269
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -903,16 +907,19 @@ #define __NR_sync_file_range		(__NR_Linu
 #define __NR_tee			(__NR_Linux + 269)
 #define __NR_vmsplice			(__NR_Linux + 270)
 #define __NR_move_pages			(__NR_Linux + 271)
+#define	__NR_ltt_trace_generic		(__NR_Linux + 272)
+#define	__NR_ltt_register_generic	(__NR_Linux + 273)
+
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		271
+#define __NR_Linux_syscalls		273
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		271
+#define __NR_N32_Linux_syscalls		273
 
 #ifdef __KERNEL__
 
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -323,10 +323,12 @@ #define __NR_fchmodat		297
 #define __NR_faccessat		298
 #define __NR_get_robust_list	299
 #define __NR_set_robust_list	300
+#define __NR_ltt_trace_generic	301
+#define __NR_ltt_register_generic	302
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		301
+#define __NR_syscalls		303
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -304,3 +304,5 @@ SYSCALL_SPU(fchmodat)
 SYSCALL_SPU(faccessat)
 COMPAT_SYS_SPU(get_robust_list)
 COMPAT_SYS_SPU(set_robust_list)
+SYSCALL(ltt_trace_generic)
+SYSCALL(ltt_register_generic)
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -619,10 +619,14 @@ #define __NR_vmsplice		278
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages		279
 __SYSCALL(__NR_move_pages, sys_move_pages)
+#define __NR_ltt_trace_generic		280
+__SYSCALL(__NR_ltt_trace_generic,	sys_ltt_trace_generic)
+#define __NR_ltt_register_generic		281
+__SYSCALL(__NR_ltt_register_generic,	sys_ltt_register_generic)
 
 #ifdef __KERNEL__
 
-#define __NR_syscall_max __NR_move_pages
+#define __NR_syscall_max __NR_ltt_register_generic
 
 #ifndef __NO_STUBS
 
--END--

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

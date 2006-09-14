Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWINDsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWINDsw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 23:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWINDsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 23:48:52 -0400
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:28336 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751236AbWINDsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 23:48:51 -0400
Date: Wed, 13 Sep 2006 23:48:48 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 9/11] LTTng-core 0.5.108 : userspace-tracing
Message-ID: <20060914034848.GJ2194@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-29407-1158205728-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 23:47:31 up 22 days, 56 min,  6 users,  load average: 1.13, 0.76, 0.40
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-29407-1158205728-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

9 - User space tracing trough new system calls
patch-2.6.17-lttng-core-0.5.108-userspace-tracing.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-29407-1158205728-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-core-0.5.108-userspace-tracing.diff"

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -39,6 +39,8 @@ #include <linux/futex.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
+#include <linux/ltt-facilities.h>
+
 struct exec_domain;
 
 /*
@@ -888,6 +890,9 @@ #endif
 	 * cache last used pipe for splice
 	 */
 	struct pipe_inode_info *splice_pipe;
+#ifdef CONFIG_LTT_USERSPACE_GENERIC
+	ltt_facility_t ltt_facilities[LTT_FAC_PER_PROCESS];
+#endif //CONFIG_LTT_USERSPACE_GENERIC
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -110,6 +110,8 @@ cond_syscall(sys_vm86old);
 cond_syscall(sys_vm86);
 cond_syscall(compat_sys_ipc);
 cond_syscall(compat_sys_sysctl);
+cond_syscall(sys_ltt_trace_generic);
+cond_syscall(sys_ltt_register_generic);
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
--- /dev/null
+++ b/kernel/ltt-syscall.c
@@ -0,0 +1,175 @@
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
+#include <linux/ltt-core.h>
+#include <linux/ltt-facilities.h>
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
+	if(ltt_traces.num_active_traces == 0) return 0;
+
+	/* Assume that the padding for alignment starts at a
+	 * sizeof(void *) address. */
+
+	reserve_size = data_size;
+
+	if(high_priority) index = GET_CHANNEL_INDEX(processes);
+	else index = GET_CHANNEL_INDEX(cpu);
+
+	preempt_disable();
+
+	if(blocking) {
+		/* User space requested blocking mode :
+		 * If one of the active traces has free space below a specific
+		 * threshold value, we reenable preemption and block. */
+block_test_begin:
+		list_for_each_entry_rcu(trace, &ltt_traces.head, list) {
+			if(!trace->active)
+  				continue;
+
+			if (trace->ops->user_blocking(trace, index, data_size,
+							&dbg))
+ 				goto block_test_begin;
+		}
+	}
+	ltt_nesting[smp_processor_id()]++;
+	list_for_each_entry_rcu(trace, &ltt_traces.head, list) {
+		if(!trace->active) continue;
+		channel = ltt_get_channel_from_index(trace, index);
+		slot_size = 0;
+		buffer = ltt_reserve_slot(trace, channel, &transport_data,
+			reserve_size, &slot_size, &tsc,
+			&before_hdr_pad, &after_hdr_pad, &header_size);
+		if(!buffer) {
+			if(blocking) trace->ops->user_errors(trace,
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
+		if(__copy_from_user_inatomic(buffer+*to_base+*to, data,
+					data_size)) {
+			/* Data is garbage in the slot */
+			ret = -EFAULT;
+		}
+		ltt_commit_slot(channel, &transport_data, buffer, slot_size);
+		if(ret != 0) break;
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
+	if(!ltt_facility_user_access_ok(facility_id)) return -EPERM;
+	if(!access_ok(VERIFY_READ, data, data_size))
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
+	if(current->ltt_facilities[LTT_FAC_PER_PROCESS-1] != 0)
+		return -EPERM;
+	
+	if(copy_from_user(&kinfo, info, sizeof(*info))) return -EFAULT;
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
+	if(fac_id > 0) goto found;
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
+	if(fac_id == 0)	return -EPERM;
+	if(fac_id < 0) return fac_id;	/* Error */
+found:
+	spin_lock(&current->group_leader->proc_lock);
+	for(i=0; i<LTT_FAC_PER_PROCESS; i++) {
+		if(current->group_leader->ltt_facilities[i] == 0) {
+			current->group_leader->ltt_facilities[i] =
+				(ltt_facility_t)fac_id;
+			break;
+		}
+	}
+	spin_unlock(&current->group_leader->proc_lock);
+	/* Write facility_id */
+	put_user((unsigned int)fac_id, facility_id);
+	return 0;
+}
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/ltt-facilities.h>
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
@@ -36,6 +37,7 @@ #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
+#include <linux/ltt-core.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -59,6 +61,16 @@ static void __unhash_process(struct task
 
 		list_del_rcu(&p->tasks);
 		__get_cpu_var(process_counts)--;
+#ifdef CONFIG_LTT_USERSPACE_GENERIC
+		{
+			int i;
+			for(i=0; i<LTT_FAC_PER_PROCESS; i++) {
+				if(p->ltt_facilities[i] == 0) break;
+				WARN_ON(ltt_facility_unregister(
+							p->ltt_facilities[i]));
+			}
+		}
+#endif //CONFIG_LTT_USERSPACE_GENERIC
 	}
 	list_del_rcu(&p->thread_group);
 	remove_parent(p);
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -44,6 +44,8 @@ #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/ltt-core.h>
+#include <linux/ltt-facilities.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1095,6 +1097,20 @@ #endif
 	   
 	p->parent_exec_id = p->self_exec_id;
 
+#ifdef CONFIG_LTT_USERSPACE_GENERIC
+	if (clone_flags & CLONE_THREAD)
+		memset(p->ltt_facilities, 0, sizeof(p->ltt_facilities));
+	else {
+		int i;
+		for(i=0; i<LTT_FAC_PER_PROCESS; i++) {
+			p->ltt_facilities[i] = current->ltt_facilities[i];
+			if(p->ltt_facilities[i] != 0)
+				ltt_facility_ref(p->ltt_facilities[i]);
+		}
+	}
+
+#endif //CONFIG_LTT_USERSPACE_GENERIC
+	
 	/* ok, now we should be set up.. */
 	p->exit_signal = (clone_flags & CLONE_THREAD) ? -1 : (clone_flags & CSIGNAL);
 	p->pdeath_signal = 0;
@@ -1151,7 +1167,7 @@ #endif
 		spin_unlock(&current->sighand->siglock);
 		write_unlock_irq(&tasklist_lock);
 		retval = -ERESTARTNOINTR;
-		goto bad_fork_cleanup_namespace;
+		goto bad_fork_cleanup_ltt_facilities;
 	}
 
 	if (clone_flags & CLONE_THREAD) {
@@ -1164,7 +1180,7 @@ #endif
 			spin_unlock(&current->sighand->siglock);
 			write_unlock_irq(&tasklist_lock);
 			retval = -EAGAIN;
-			goto bad_fork_cleanup_namespace;
+			goto bad_fork_cleanup_ltt_facilities;
 		}
 
 		p->group_leader = current->group_leader;
@@ -1216,6 +1232,17 @@ #endif
 	proc_fork_connector(p);
 	return p;
 
+bad_fork_cleanup_ltt_facilities:
+#ifdef CONFIG_LTT_USERSPACE_GENERIC
+		{
+			int i;
+			for(i=0; i<LTT_FAC_PER_PROCESS; i++) {
+				if(p->ltt_facilities[i] == 0) break;
+				WARN_ON(ltt_facility_unregister(
+							p->ltt_facilities[i]));
+			}
+		}
+#endif //CONFIG_LTT_USERSPACE_GENERIC
 bad_fork_cleanup_namespace:
 	exit_namespace(p);
 bad_fork_cleanup_keys:
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -322,8 +322,10 @@ #define __NR_splice		313
 #define __NR_sync_file_range	314
 #define __NR_tee		315
 #define __NR_vmsplice		316
+#define __NR_ltt_trace_generic	317
+#define __NR_ltt_register_generic	318
 
-#define NR_syscalls 317
+#define NR_syscalls 319
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -323,8 +323,10 @@ #define __NR_fchmodat		297
 #define __NR_faccessat		298
 #define __NR_get_robust_list	299
 #define __NR_set_robust_list	300
+#define __NR_ltt_trace_generic	301
+#define __NR_ltt_register_generic	302
 
-#define __NR_syscalls		301
+#define __NR_syscalls		303
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
--- a/include/asm-x86_64/ia32_unistd.h
+++ b/include/asm-x86_64/ia32_unistd.h
@@ -317,4 +317,9 @@ #define __NR_ia32_pselect6		308
 #define __NR_ia32_ppoll			309
 #define __NR_ia32_unshare		310
 
+/* A few defines seem to have been forgotten by kernel developers.
+   See arch/x86_64/ia32/ia32entry.S and include/asm-i386/unistd.h */
+#define __NR_ia32_ltt_trace_generic	317
+#define __NR_ia32_ltt_register_generic	318
+
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -617,8 +617,12 @@ #define __NR_sync_file_range	277
 __SYSCALL(__NR_sync_file_range, sys_sync_file_range)
 #define __NR_vmsplice		278
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
+#define __NR_ltt_trace_generic	279
+__SYSCALL(__NR_ltt_trace_generic, sys_ltt_trace_generic)
+#define __NR_ltt_register_generic	280
+__SYSCALL(__NR_ltt_register_generic, sys_ltt_register_generic)
 
-#define __NR_syscall_max __NR_vmsplice
+#define __NR_syscall_max __NR_ltt_register_generic
 
 #ifndef __NO_STUBS
 

--=_Krystal-29407-1158205728-0001-2--

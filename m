Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWC2ACH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWC2ACH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWC2ABx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:01:53 -0500
Received: from [151.97.230.9] ([151.97.230.9]:27329 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964856AbWC2ABj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:01:39 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/7] uml: implement {get,set}_thread_area for i386
Date: Wed, 29 Mar 2006 01:56:58 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060328235657.13838.76588.stgit@zion.home.lan>
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Implement sys_[gs]et_thread_area and the corresponding ptrace operations for
UML. This is the main chunk, additional parts follow. This implementation is now
well tested and has run reliably for some time, and we've understood all the
previously existing problems.

Their implementation saves the new GDT content and then forwards the call to the
host when appropriate, i.e. immediately when the target process is running or on
context switch otherwise (i.e. on fork and on ptrace() calls).

In SKAS mode, we must switch registers on each context switch (because SKAS
does not switches tls_array together with current->mm).

Also, added get_cpu() locking; this has been done for SKAS mode, since TT
does not need it (it does not use smp_processor_id()).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h               |    4 
 arch/um/kernel/exec_kern.c         |   12 -
 arch/um/kernel/process_kern.c      |   20 ++
 arch/um/kernel/ptrace.c            |   10 +
 arch/um/kernel/skas/process_kern.c |    2 
 arch/um/os-Linux/Makefile          |    4 
 arch/um/os-Linux/tls.c             |   77 +++++++++
 arch/um/sys-i386/Makefile          |    2 
 arch/um/sys-i386/ptrace.c          |    2 
 arch/um/sys-i386/sys_call_table.S  |    2 
 arch/um/sys-i386/syscalls.c        |   14 +-
 arch/um/sys-i386/tls.c             |  326 ++++++++++++++++++++++++++++++++++++
 arch/um/sys-x86_64/Makefile        |    2 
 arch/um/sys-x86_64/tls.c           |   14 ++
 include/asm-um/desc.h              |   12 +
 include/asm-um/processor-i386.h    |   35 +++-
 include/asm-um/processor-x86_64.h  |    9 +
 include/asm-um/ptrace-generic.h    |   14 --
 include/asm-um/ptrace-i386.h       |   41 +++--
 include/asm-um/ptrace-x86_64.h     |   35 +++-
 include/asm-um/segment.h           |    2 
 21 files changed, 578 insertions(+), 61 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index d3d1bc6..90869a7 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -234,6 +234,10 @@ extern int run_helper_thread(int (*proc)
 			     int stack_order);
 extern int helper_wait(int pid);
 
+
+/* tls.c */
+extern int os_set_thread_area(void *data, int pid);
+extern int os_get_thread_area(void *data, int pid);
 /* umid.c */
 
 extern int umid_file_name(char *name, char *buf, int len);
diff --git a/arch/um/kernel/exec_kern.c b/arch/um/kernel/exec_kern.c
index 1ca8431..a308d3d 100644
--- a/arch/um/kernel/exec_kern.c
+++ b/arch/um/kernel/exec_kern.c
@@ -22,6 +22,7 @@
 
 void flush_thread(void)
 {
+	arch_flush_thread(&current->thread.arch);
 	CHOOSE_MODE(flush_thread_tt(), flush_thread_skas());
 }
 
@@ -74,14 +75,3 @@ long sys_execve(char *file, char __user 
 	unlock_kernel();
 	return(error);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff --git a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
index f9948fd..877a7ef 100644
--- a/arch/um/kernel/process_kern.c
+++ b/arch/um/kernel/process_kern.c
@@ -156,9 +156,25 @@ int copy_thread(int nr, unsigned long cl
 		unsigned long stack_top, struct task_struct * p, 
 		struct pt_regs *regs)
 {
+	int ret;
+
 	p->thread = (struct thread_struct) INIT_THREAD;
-	return(CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr, 
-				clone_flags, sp, stack_top, p, regs));
+	ret = CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr,
+				clone_flags, sp, stack_top, p, regs);
+
+	if (ret || !current->thread.forking)
+		goto out;
+
+	clear_flushed_tls(p);
+
+	/*
+	 * Set a new TLS for the child thread?
+	 */
+	if (clone_flags & CLONE_SETTLS)
+		ret = arch_copy_tls(p);
+
+out:
+	return ret;
 }
 
 void initial_thread_cb(void (*proc)(void *), void *arg)
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 98e0939..f03a7f5 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -187,6 +187,16 @@ long arch_ptrace(struct task_struct *chi
 		ret = set_fpxregs(data, child);
 		break;
 #endif
+	case PTRACE_GET_THREAD_AREA:
+		ret = ptrace_get_thread_area(child, addr,
+					     (struct user_desc __user *) data);
+		break;
+
+	case PTRACE_SET_THREAD_AREA:
+		ret = ptrace_set_thread_area(child, addr,
+					     (struct user_desc __user *) data);
+		break;
+
 	case PTRACE_FAULTINFO: {
                 /* Take the info from thread->arch->faultinfo,
                  * but transfer max. sizeof(struct ptrace_faultinfo).
diff --git a/arch/um/kernel/skas/process_kern.c b/arch/um/kernel/skas/process_kern.c
index 14360ac..38b1853 100644
--- a/arch/um/kernel/skas/process_kern.c
+++ b/arch/um/kernel/skas/process_kern.c
@@ -111,6 +111,8 @@ int copy_thread_skas(int nr, unsigned lo
 		if(sp != 0) REGS_SP(p->thread.regs.regs.skas.regs) = sp;
 
 		handler = fork_handler;
+
+		arch_copy_thread(&current->thread.arch, &p->thread.arch);
 	}
 	else {
 		init_thread_registers(&p->thread.regs.regs);
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 1659386..e7eb433 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-y = aio.o elf_aux.o file.o helper.o irq.o main.o mem.o process.o sigio.o \
-	signal.o start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o \
+	signal.o start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o tls.o \
 	user_syms.o util.o drivers/ sys-$(SUBARCH)/
 
 obj-$(CONFIG_MODE_SKAS) += skas/
@@ -12,7 +12,7 @@ obj-$(CONFIG_TTY_LOG) += tty_log.o
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
 USER_OBJS := $(user-objs-y) aio.o elf_aux.o file.o helper.o irq.o main.o mem.o \
-	process.o sigio.o signal.o start_up.o time.o trap.o tt.o tty.o \
+	process.o sigio.o signal.o start_up.o time.o trap.o tt.o tty.o tls.o \
 	uaccess.o umid.o util.o
 
 elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
diff --git a/arch/um/os-Linux/tls.c b/arch/um/os-Linux/tls.c
new file mode 100644
index 0000000..63dfcf7
--- /dev/null
+++ b/arch/um/os-Linux/tls.c
@@ -0,0 +1,77 @@
+#include <errno.h>
+#include <sys/ptrace.h>
+#include <asm/ldt.h>
+#include "uml-config.h"
+
+/* TLS support - we basically rely on the host's one.*/
+
+/* In TT mode, this should be called only by the tracing thread, and makes sense
+ * only for PTRACE_SET_THREAD_AREA. In SKAS mode, it's used normally.
+ *
+ */
+
+#ifndef PTRACE_GET_THREAD_AREA
+#define PTRACE_GET_THREAD_AREA 25
+#endif
+
+#ifndef PTRACE_SET_THREAD_AREA
+#define PTRACE_SET_THREAD_AREA 26
+#endif
+
+int os_set_thread_area(void *data, int pid)
+{
+	struct user_desc *info = data;
+	int ret;
+
+	ret = ptrace(PTRACE_SET_THREAD_AREA, pid, info->entry_number,
+		     (unsigned long) info);
+	if (ret < 0)
+		ret = -errno;
+	return ret;
+}
+
+#ifdef UML_CONFIG_MODE_SKAS
+
+int os_get_thread_area(void *data, int pid)
+{
+	struct user_desc *info = data;
+	int ret;
+
+	ret = ptrace(PTRACE_GET_THREAD_AREA, pid, info->entry_number,
+		     (unsigned long) info);
+	if (ret < 0)
+		ret = -errno;
+	return ret;
+}
+
+#endif
+
+#ifdef UML_CONFIG_MODE_TT
+#include "linux/unistd.h"
+
+_syscall1(int, get_thread_area, struct user_desc *, u_info);
+_syscall1(int, set_thread_area, struct user_desc *, u_info);
+
+int do_set_thread_area_tt(struct user_desc *info)
+{
+	int ret;
+
+	ret = set_thread_area(info);
+	if (ret < 0) {
+		ret = -errno;
+	}
+	return ret;
+}
+
+int do_get_thread_area_tt(struct user_desc *info)
+{
+	int ret;
+
+	ret = get_thread_area(info);
+	if (ret < 0) {
+		ret = -errno;
+	}
+	return ret;
+}
+
+#endif /* UML_CONFIG_MODE_TT */
diff --git a/arch/um/sys-i386/Makefile b/arch/um/sys-i386/Makefile
index f5fd5b0..90ae78c 100644
--- a/arch/um/sys-i386/Makefile
+++ b/arch/um/sys-i386/Makefile
@@ -1,6 +1,6 @@
 obj-y := bitops.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
 	ptrace_user.o semaphore.o signal.o sigcontext.o syscalls.o sysrq.o \
-	sys_call_table.o
+	sys_call_table.o tls.o
 
 obj-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 
diff --git a/arch/um/sys-i386/ptrace.c b/arch/um/sys-i386/ptrace.c
index bf896b8..b587b4b 100644
--- a/arch/um/sys-i386/ptrace.c
+++ b/arch/um/sys-i386/ptrace.c
@@ -18,10 +18,12 @@
 void arch_switch_to_tt(struct task_struct *from, struct task_struct *to)
 {
 	update_debugregs(to->thread.arch.debugregs_seq);
+	arch_switch_tls_tt(from, to);
 }
 
 void arch_switch_to_skas(struct task_struct *from, struct task_struct *to)
 {
+	arch_switch_tls_skas(from, to);
 }
 
 int is_syscall(unsigned long addr)
diff --git a/arch/um/sys-i386/sys_call_table.S b/arch/um/sys-i386/sys_call_table.S
index ad75c27..1ff6147 100644
--- a/arch/um/sys-i386/sys_call_table.S
+++ b/arch/um/sys-i386/sys_call_table.S
@@ -6,8 +6,6 @@
 
 #define sys_vm86old sys_ni_syscall
 #define sys_vm86 sys_ni_syscall
-#define sys_set_thread_area sys_ni_syscall
-#define sys_get_thread_area sys_ni_syscall
 
 #define sys_stime um_stime
 #define sys_time um_time
diff --git a/arch/um/sys-i386/syscalls.c b/arch/um/sys-i386/syscalls.c
index 83e9be8..8d5fb67 100644
--- a/arch/um/sys-i386/syscalls.c
+++ b/arch/um/sys-i386/syscalls.c
@@ -61,21 +61,27 @@ long old_select(struct sel_arg_struct __
 	return sys_select(a.n, a.inp, a.outp, a.exp, a.tvp);
 }
 
-/* The i386 version skips reading from %esi, the fourth argument. So we must do
- * this, too.
+/*
+ * The prototype on i386 is:
+ *
+ *     int clone(int flags, void * child_stack, int * parent_tidptr, struct user_desc * newtls, int * child_tidptr)
+ *
+ * and the "newtls" arg. on i386 is read by copy_thread directly from the
+ * register saved on the stack.
  */
 long sys_clone(unsigned long clone_flags, unsigned long newsp,
-	       int __user *parent_tid, int unused, int __user *child_tid)
+	       int __user *parent_tid, void *newtls, int __user *child_tid)
 {
 	long ret;
 
 	if (!newsp)
 		newsp = UPT_SP(&current->thread.regs.regs);
+
 	current->thread.forking = 1;
 	ret = do_fork(clone_flags, newsp, &current->thread.regs, 0, parent_tid,
 		      child_tid);
 	current->thread.forking = 0;
-	return(ret);
+	return ret;
 }
 
 /*
diff --git a/arch/um/sys-i386/tls.c b/arch/um/sys-i386/tls.c
new file mode 100644
index 0000000..e3c5bc5
--- /dev/null
+++ b/arch/um/sys-i386/tls.c
@@ -0,0 +1,326 @@
+/*
+ * Copyright (C) 2005 Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
+ * Licensed under the GPL
+ */
+
+#include "linux/config.h"
+#include "linux/kernel.h"
+#include "linux/sched.h"
+#include "linux/slab.h"
+#include "linux/types.h"
+#include "asm/uaccess.h"
+#include "asm/ptrace.h"
+#include "asm/segment.h"
+#include "asm/smp.h"
+#include "asm/desc.h"
+#include "choose-mode.h"
+#include "kern.h"
+#include "kern_util.h"
+#include "mode_kern.h"
+#include "os.h"
+#include "mode.h"
+
+#ifdef CONFIG_MODE_SKAS
+#include "skas.h"
+#endif
+
+#ifdef CONFIG_MODE_SKAS
+int do_set_thread_area_skas(struct user_desc *info)
+{
+	int ret;
+	u32 cpu;
+
+	cpu = get_cpu();
+	ret = os_set_thread_area(info, userspace_pid[cpu]);
+	put_cpu();
+	return ret;
+}
+
+int do_get_thread_area_skas(struct user_desc *info)
+{
+	int ret;
+	u32 cpu;
+
+	cpu = get_cpu();
+	ret = os_get_thread_area(info, userspace_pid[cpu]);
+	put_cpu();
+	return ret;
+}
+#endif
+
+/*
+ * sys_get_thread_area: get a yet unused TLS descriptor index.
+ * XXX: Consider leaving one free slot for glibc usage at first place. This must
+ * be done here (and by changing GDT_ENTRY_TLS_* macros) and nowhere else.
+ *
+ * Also, this must be tested when compiling in SKAS mode with dinamic linking
+ * and running against NPTL.
+ */
+static int get_free_idx(struct task_struct* task)
+{
+	struct thread_struct *t = &task->thread;
+	int idx;
+
+	if (!t->arch.tls_array)
+		return GDT_ENTRY_TLS_MIN;
+
+	for (idx = 0; idx < GDT_ENTRY_TLS_ENTRIES; idx++)
+		if (!t->arch.tls_array[idx].present)
+			return idx + GDT_ENTRY_TLS_MIN;
+	return -ESRCH;
+}
+
+#define O_FORCE 1
+
+static inline void clear_user_desc(struct user_desc* info)
+{
+	/* Postcondition: LDT_empty(info) returns true. */
+	memset(info, 0, sizeof(*info));
+
+	/* Check the LDT_empty or the i386 sys_get_thread_area code - we obtain
+	 * indeed an empty user_desc.
+	 */
+	info->read_exec_only = 1;
+	info->seg_not_present = 1;
+}
+
+static int load_TLS(int flags, struct task_struct *to)
+{
+	int ret = 0;
+	int idx;
+
+	for (idx = GDT_ENTRY_TLS_MIN; idx < GDT_ENTRY_TLS_MAX; idx++) {
+		struct uml_tls_struct* curr = &to->thread.arch.tls_array[idx - GDT_ENTRY_TLS_MIN];
+
+		/* Actually, now if it wasn't flushed it gets cleared and
+		 * flushed to the host, which will clear it.*/
+		if (!curr->present) {
+			if (!curr->flushed) {
+				clear_user_desc(&curr->tls);
+				curr->tls.entry_number = idx;
+			} else {
+				WARN_ON(!LDT_empty(&curr->tls));
+				continue;
+			}
+		}
+
+		if (!(flags & O_FORCE) && curr->flushed)
+			continue;
+
+		ret = do_set_thread_area(&curr->tls);
+		if (ret)
+			goto out;
+
+		curr->flushed = 1;
+	}
+out:
+	return ret;
+}
+
+/* Verify if we need to do a flush for the new process, i.e. if there are any
+ * present desc's, only if they haven't been flushed.
+ */
+static inline int needs_TLS_update(struct task_struct *task)
+{
+	int i;
+	int ret = 0;
+
+	for (i = GDT_ENTRY_TLS_MIN; i < GDT_ENTRY_TLS_MAX; i++) {
+		struct uml_tls_struct* curr = &task->thread.arch.tls_array[i - GDT_ENTRY_TLS_MIN];
+
+		/* Can't test curr->present, we may need to clear a descriptor
+		 * which had a value. */
+		if (curr->flushed)
+			continue;
+		ret = 1;
+		break;
+	}
+	return ret;
+}
+
+/* On a newly forked process, the TLS descriptors haven't yet been flushed. So
+ * we mark them as such and the first switch_to will do the job.
+ */
+void clear_flushed_tls(struct task_struct *task)
+{
+	int i;
+
+	for (i = GDT_ENTRY_TLS_MIN; i < GDT_ENTRY_TLS_MAX; i++) {
+		struct uml_tls_struct* curr = &task->thread.arch.tls_array[i - GDT_ENTRY_TLS_MIN];
+
+		/* Still correct to do this, if it wasn't present on the host it
+		 * will remain as flushed as it was. */
+		if (!curr->present)
+			continue;
+
+		curr->flushed = 0;
+	}
+}
+
+/* This in SKAS0 does not need to be used, since we have different host
+ * processes. Nor will this need to be used when we'll add support to the host
+ * SKAS patch. */
+int arch_switch_tls_skas(struct task_struct *from, struct task_struct *to)
+{
+	return load_TLS(O_FORCE, to);
+}
+
+int arch_switch_tls_tt(struct task_struct *from, struct task_struct *to)
+{
+	if (needs_TLS_update(to))
+		return load_TLS(0, to);
+
+	return 0;
+}
+
+static int set_tls_entry(struct task_struct* task, struct user_desc *info,
+			 int idx, int flushed)
+{
+	struct thread_struct *t = &task->thread;
+
+	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+		return -EINVAL;
+
+	t->arch.tls_array[idx - GDT_ENTRY_TLS_MIN].tls = *info;
+	t->arch.tls_array[idx - GDT_ENTRY_TLS_MIN].present = 1;
+	t->arch.tls_array[idx - GDT_ENTRY_TLS_MIN].flushed = flushed;
+
+	return 0;
+}
+
+int arch_copy_tls(struct task_struct *new)
+{
+	struct user_desc info;
+	int idx, ret = -EFAULT;
+
+	if (copy_from_user(&info,
+			   (void __user *) UPT_ESI(&new->thread.regs.regs),
+			   sizeof(info)))
+		goto out;
+
+	ret = -EINVAL;
+	if (LDT_empty(&info))
+		goto out;
+
+	idx = info.entry_number;
+
+	ret = set_tls_entry(new, &info, idx, 0);
+out:
+	return ret;
+}
+
+/* XXX: use do_get_thread_area to read the host value? I'm not at all sure! */
+static int get_tls_entry(struct task_struct* task, struct user_desc *info, int idx)
+{
+	struct thread_struct *t = &task->thread;
+
+	if (!t->arch.tls_array)
+		goto clear;
+
+	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+		return -EINVAL;
+
+	if (!t->arch.tls_array[idx - GDT_ENTRY_TLS_MIN].present)
+		goto clear;
+
+	*info = t->arch.tls_array[idx - GDT_ENTRY_TLS_MIN].tls;
+
+out:
+	/* Temporary debugging check, to make sure that things have been
+	 * flushed. This could be triggered if load_TLS() failed.
+	 */
+	if (unlikely(task == current && !t->arch.tls_array[idx - GDT_ENTRY_TLS_MIN].flushed)) {
+		printk(KERN_ERR "get_tls_entry: task with pid %d got here "
+				"without flushed TLS.", current->pid);
+	}
+
+	return 0;
+clear:
+	/* When the TLS entry has not been set, the values read to user in the
+	 * tls_array are 0 (because it's cleared at boot, see
+	 * arch/i386/kernel/head.S:cpu_gdt_table). Emulate that.
+	 */
+	clear_user_desc(info);
+	info->entry_number = idx;
+	goto out;
+}
+
+asmlinkage int sys_set_thread_area(struct user_desc __user *user_desc)
+{
+	struct user_desc info;
+	int idx, ret;
+
+	if (copy_from_user(&info, user_desc, sizeof(info)))
+		return -EFAULT;
+
+	idx = info.entry_number;
+
+	if (idx == -1) {
+		idx = get_free_idx(current);
+		if (idx < 0)
+			return idx;
+		info.entry_number = idx;
+		/* Tell the user which slot we chose for him.*/
+		if (put_user(idx, &user_desc->entry_number))
+			return -EFAULT;
+	}
+
+	ret = CHOOSE_MODE_PROC(do_set_thread_area_tt, do_set_thread_area_skas, &info);
+	if (ret)
+		return ret;
+	return set_tls_entry(current, &info, idx, 1);
+}
+
+/*
+ * Perform set_thread_area on behalf of the traced child.
+ * Note: error handling is not done on the deferred load, and this differ from
+ * i386. However the only possible error are caused by bugs.
+ */
+int ptrace_set_thread_area(struct task_struct *child, int idx,
+		struct user_desc __user *user_desc)
+{
+	struct user_desc info;
+
+	if (copy_from_user(&info, user_desc, sizeof(info)))
+		return -EFAULT;
+
+	return set_tls_entry(child, &info, idx, 0);
+}
+
+asmlinkage int sys_get_thread_area(struct user_desc __user *user_desc)
+{
+	struct user_desc info;
+	int idx, ret;
+
+	if (get_user(idx, &user_desc->entry_number))
+		return -EFAULT;
+
+	ret = get_tls_entry(current, &info, idx);
+	if (ret < 0)
+		goto out;
+
+	if (copy_to_user(user_desc, &info, sizeof(info)))
+		ret = -EFAULT;
+
+out:
+	return ret;
+}
+
+/*
+ * Perform get_thread_area on behalf of the traced child.
+ */
+int ptrace_get_thread_area(struct task_struct *child, int idx,
+		struct user_desc __user *user_desc)
+{
+	struct user_desc info;
+	int ret;
+
+	ret = get_tls_entry(child, &info, idx);
+	if (ret < 0)
+		goto out;
+
+	if (copy_to_user(user_desc, &info, sizeof(info)))
+		ret = -EFAULT;
+out:
+	return ret;
+}
diff --git a/arch/um/sys-x86_64/Makefile b/arch/um/sys-x86_64/Makefile
index a351091..fcb01ad 100644
--- a/arch/um/sys-x86_64/Makefile
+++ b/arch/um/sys-x86_64/Makefile
@@ -7,7 +7,7 @@
 #XXX: why into lib-y?
 lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o ldt.o mem.o memcpy.o \
 	ptrace.o ptrace_user.o sigcontext.o signal.o syscalls.o \
-	syscall_table.o sysrq.o thunk.o
+	syscall_table.o sysrq.o tls.o thunk.o
 lib-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 
 obj-y := ksyms.o
diff --git a/arch/um/sys-x86_64/tls.c b/arch/um/sys-x86_64/tls.c
new file mode 100644
index 0000000..ce1bf1b
--- /dev/null
+++ b/arch/um/sys-x86_64/tls.c
@@ -0,0 +1,14 @@
+#include "linux/sched.h"
+
+void debug_arch_force_load_TLS(void)
+{
+}
+
+void clear_flushed_tls(struct task_struct *task)
+{
+}
+
+int arch_copy_tls(struct task_struct *t)
+{
+        return 0;
+}
diff --git a/include/asm-um/desc.h b/include/asm-um/desc.h
index ac1d2a2..4ec34a5 100644
--- a/include/asm-um/desc.h
+++ b/include/asm-um/desc.h
@@ -1,6 +1,16 @@
 #ifndef __UM_DESC_H
 #define __UM_DESC_H
 
-#include "asm/arch/desc.h"
+/* Taken from asm-i386/desc.h, it's the only thing we need. The rest wouldn't
+ * compile, and has never been used. */
+#define LDT_empty(info) (\
+	(info)->base_addr	== 0	&& \
+	(info)->limit		== 0	&& \
+	(info)->contents	== 0	&& \
+	(info)->read_exec_only	== 1	&& \
+	(info)->seg_32bit	== 0	&& \
+	(info)->limit_in_pages	== 0	&& \
+	(info)->seg_not_present	== 1	&& \
+	(info)->useable		== 0	)
 
 #endif
diff --git a/include/asm-um/processor-i386.h b/include/asm-um/processor-i386.h
index 4108a57..595f1c3 100644
--- a/include/asm-um/processor-i386.h
+++ b/include/asm-um/processor-i386.h
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -6,21 +6,48 @@
 #ifndef __UM_PROCESSOR_I386_H
 #define __UM_PROCESSOR_I386_H
 
+#include "linux/string.h"
+#include "asm/host_ldt.h"
+#include "asm/segment.h"
+
 extern int host_has_xmm;
 extern int host_has_cmov;
 
 /* include faultinfo structure */
 #include "sysdep/faultinfo.h"
 
+struct uml_tls_struct {
+	struct user_desc tls;
+	unsigned flushed:1;
+	unsigned present:1;
+};
+
 struct arch_thread {
+	struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
 	unsigned long debugregs[8];
 	int debugregs_seq;
 	struct faultinfo faultinfo;
 };
 
-#define INIT_ARCH_THREAD { .debugregs  		= { [ 0 ... 7 ] = 0 }, \
-                           .debugregs_seq	= 0, \
-                           .faultinfo		= { 0, 0, 0 } }
+#define INIT_ARCH_THREAD { \
+	.tls_array  		= { [ 0 ... GDT_ENTRY_TLS_ENTRIES - 1 ] = \
+				    { .present = 0, .flushed = 0 } }, \
+	.debugregs  		= { [ 0 ... 7 ] = 0 }, \
+	.debugregs_seq		= 0, \
+	.faultinfo		= { 0, 0, 0 } \
+}
+
+static inline void arch_flush_thread(struct arch_thread *thread)
+{
+	/* Clear any TLS still hanging */
+	memset(&thread->tls_array, 0, sizeof(thread->tls_array));
+}
+
+static inline void arch_copy_thread(struct arch_thread *from,
+                                    struct arch_thread *to)
+{
+        memcpy(&to->tls_array, &from->tls_array, sizeof(from->tls_array));
+}
 
 #include "asm/arch/user.h"
 
diff --git a/include/asm-um/processor-x86_64.h b/include/asm-um/processor-x86_64.h
index e1e1255..10609af 100644
--- a/include/asm-um/processor-x86_64.h
+++ b/include/asm-um/processor-x86_64.h
@@ -28,6 +28,15 @@ extern inline void rep_nop(void)
                            .debugregs_seq	= 0, \
                            .faultinfo		= { 0, 0, 0 } }
 
+static inline void arch_flush_thread(struct arch_thread *thread)
+{
+}
+
+static inline void arch_copy_thread(struct arch_thread *from,
+                                    struct arch_thread *to)
+{
+}
+
 #include "asm/arch/user.h"
 
 #define current_text_addr() \
diff --git a/include/asm-um/ptrace-generic.h b/include/asm-um/ptrace-generic.h
index 46599ac..011c356 100644
--- a/include/asm-um/ptrace-generic.h
+++ b/include/asm-um/ptrace-generic.h
@@ -60,17 +60,9 @@ extern void show_regs(struct pt_regs *re
 extern void send_sigtrap(struct task_struct *tsk, union uml_pt_regs *regs,
 			 int error_code);
 
-#endif
+extern int arch_copy_tls(struct task_struct *new);
+extern void clear_flushed_tls(struct task_struct *task);
 
 #endif
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+#endif
diff --git a/include/asm-um/ptrace-i386.h b/include/asm-um/ptrace-i386.h
index fe882b9..30656c9 100644
--- a/include/asm-um/ptrace-i386.h
+++ b/include/asm-um/ptrace-i386.h
@@ -8,8 +8,11 @@
 
 #define HOST_AUDIT_ARCH AUDIT_ARCH_I386
 
+#include "linux/compiler.h"
 #include "sysdep/ptrace.h"
 #include "asm/ptrace-generic.h"
+#include "asm/host_ldt.h"
+#include "choose-mode.h"
 
 #define PT_REGS_EAX(r) UPT_EAX(&(r)->regs)
 #define PT_REGS_EBX(r) UPT_EBX(&(r)->regs)
@@ -38,15 +41,31 @@
 
 #define user_mode(r) UPT_IS_USER(&(r)->regs)
 
-#endif
+extern int ptrace_get_thread_area(struct task_struct *child, int idx,
+                                  struct user_desc __user *user_desc);
+
+extern int ptrace_set_thread_area(struct task_struct *child, int idx,
+                                  struct user_desc __user *user_desc);
+
+extern int do_set_thread_area_skas(struct user_desc *info);
+extern int do_get_thread_area_skas(struct user_desc *info);
+
+extern int do_set_thread_area_tt(struct user_desc *info);
+extern int do_get_thread_area_tt(struct user_desc *info);
+
+extern int arch_switch_tls_skas(struct task_struct *from, struct task_struct *to);
+extern int arch_switch_tls_tt(struct task_struct *from, struct task_struct *to);
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+static inline int do_get_thread_area(struct user_desc *info)
+{
+	return CHOOSE_MODE_PROC(do_get_thread_area_tt, do_get_thread_area_skas, info);
+}
+
+static inline int do_set_thread_area(struct user_desc *info)
+{
+	return CHOOSE_MODE_PROC(do_set_thread_area_tt, do_set_thread_area_skas, info);
+}
+
+struct task_struct;
+
+#endif
diff --git a/include/asm-um/ptrace-x86_64.h b/include/asm-um/ptrace-x86_64.h
index be51219..c894e68 100644
--- a/include/asm-um/ptrace-x86_64.h
+++ b/include/asm-um/ptrace-x86_64.h
@@ -8,6 +8,8 @@
 #define __UM_PTRACE_X86_64_H
 
 #include "linux/compiler.h"
+#include "asm/errno.h"
+#include "asm/host_ldt.h"
 
 #define signal_fault signal_fault_x86_64
 #define __FRAME_OFFSETS /* Needed to get the R* macros */
@@ -63,15 +65,26 @@ void signal_fault(struct pt_regs_subarch
 
 #define profile_pc(regs) PT_REGS_IP(regs)
 
-#endif
+static inline int ptrace_get_thread_area(struct task_struct *child, int idx,
+                                         struct user_desc __user *user_desc)
+{
+        return -ENOSYS;
+}
+
+static inline int ptrace_set_thread_area(struct task_struct *child, int idx,
+                                         struct user_desc __user *user_desc)
+{
+        return -ENOSYS;
+}
+
+static inline void arch_switch_to_tt(struct task_struct *from,
+                                     struct task_struct *to)
+{
+}
+
+static inline void arch_switch_to_skas(struct task_struct *from,
+                                       struct task_struct *to)
+{
+}
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+#endif
diff --git a/include/asm-um/segment.h b/include/asm-um/segment.h
index 55e4030..4877545 100644
--- a/include/asm-um/segment.h
+++ b/include/asm-um/segment.h
@@ -1,4 +1,6 @@
 #ifndef __UM_SEGMENT_H
 #define __UM_SEGMENT_H
 
+#include "asm/arch/segment.h"
+
 #endif

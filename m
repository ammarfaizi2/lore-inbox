Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWAOUuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWAOUuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWAOUty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:49:54 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:40355 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750795AbWAOUtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:49:45 -0500
Message-Id: <200601152139.k0FLdgug027726@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 5/11] UML - Move headers to arch/um/include
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 16:39:42 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves skas headers to arch/um/include.

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/Makefile
===================================================================
--- linux-2.6.15-mm.orig/arch/um/Makefile	2006-01-09 10:27:20.000000000 -0500
+++ linux-2.6.15-mm/arch/um/Makefile	2006-01-09 11:26:24.000000000 -0500
@@ -32,7 +32,7 @@ um-modes-$(CONFIG_MODE_TT) += tt
 um-modes-$(CONFIG_MODE_SKAS) += skas
 
 MODE_INCLUDE	+= $(foreach mode,$(um-modes-y),\
-		   -I$(srctree)/$(ARCH_DIR)/kernel/$(mode)/include)
+		   -I$(srctree)/$(ARCH_DIR)/include/$(mode))
 
 MAKEFILES-INCL	+= $(foreach mode,$(um-modes-y),\
 		   $(srctree)/$(ARCH_DIR)/Makefile-$(mode))
Index: linux-2.6.15-mm/arch/um/include/skas/mm_id.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/skas/mm_id.h	2006-01-09 11:26:24.000000000 -0500
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2005 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __MM_ID_H
+#define __MM_ID_H
+
+struct mm_id {
+	union {
+		int mm_fd;
+		int pid;
+	} u;
+	unsigned long stack;
+};
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/skas/mmu-skas.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/skas/mmu-skas.h	2006-01-09 11:28:14.000000000 -0500
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SKAS_MMU_H
+#define __SKAS_MMU_H
+
+#include "linux/config.h"
+#include "mm_id.h"
+#include "asm/ldt.h"
+
+struct mmu_context_skas {
+	struct mm_id id;
+	unsigned long last_page_table;
+#ifdef CONFIG_3_LEVEL_PGTABLES
+	unsigned long last_pmd;
+#endif
+	uml_ldt_t ldt;
+};
+
+extern void switch_mm_skas(struct mm_id * mm_idp);
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/skas/mode-skas.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/skas/mode-skas.h	2006-01-09 11:49:37.000000000 -0500
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __MODE_SKAS_H__
+#define __MODE_SKAS_H__
+
+#include <sysdep/ptrace.h>
+
+extern unsigned long exec_regs[];
+extern unsigned long exec_fp_regs[];
+extern unsigned long exec_fpx_regs[];
+extern int have_fpx_regs;
+
+extern void sig_handler_common_skas(int sig, void *sc_ptr);
+extern void halt_skas(void);
+extern void reboot_skas(void);
+extern void kill_off_processes_skas(void);
+extern int is_skas_winch(int pid, int fd, void *data);
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/skas/mode_kern_skas.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/skas/mode_kern_skas.h	2006-01-09 11:49:37.000000000 -0500
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SKAS_MODE_KERN_H__
+#define __SKAS_MODE_KERN_H__
+
+#include "linux/sched.h"
+#include "asm/page.h"
+#include "asm/ptrace.h"
+
+extern void flush_thread_skas(void);
+extern void switch_to_skas(void *prev, void *next);
+extern void start_thread_skas(struct pt_regs *regs, unsigned long eip,
+			      unsigned long esp);
+extern int copy_thread_skas(int nr, unsigned long clone_flags,
+			    unsigned long sp, unsigned long stack_top,
+			    struct task_struct *p, struct pt_regs *regs);
+extern void release_thread_skas(struct task_struct *task);
+extern void initial_thread_cb_skas(void (*proc)(void *), void *arg);
+extern void init_idle_skas(void);
+extern void flush_tlb_kernel_range_skas(unsigned long start,
+					unsigned long end);
+extern void flush_tlb_kernel_vm_skas(void);
+extern void __flush_tlb_one_skas(unsigned long addr);
+extern void flush_tlb_range_skas(struct vm_area_struct *vma,
+				 unsigned long start, unsigned long end);
+extern void flush_tlb_mm_skas(struct mm_struct *mm);
+extern void force_flush_all_skas(void);
+extern long execute_syscall_skas(void *r);
+extern void before_mem_skas(unsigned long unused);
+extern unsigned long set_task_sizes_skas(int arg, unsigned long *host_size_out,
+					 unsigned long *task_size_out);
+extern int start_uml_skas(void);
+extern int external_pid_skas(struct task_struct *task);
+extern int thread_pid_skas(struct task_struct *task);
+
+#define kmem_end_skas (host_task_size - 1024 * 1024)
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/skas/proc_mm.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/skas/proc_mm.h	2006-01-09 11:39:56.000000000 -0500
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SKAS_PROC_MM_H
+#define __SKAS_PROC_MM_H
+
+#define MM_MMAP 54
+#define MM_MUNMAP 55
+#define MM_MPROTECT 56
+#define MM_COPY_SEGMENTS 57
+
+struct mm_mmap {
+	unsigned long addr;
+	unsigned long len;
+	unsigned long prot;
+	unsigned long flags;
+	unsigned long fd;
+	unsigned long offset;
+};
+
+struct mm_munmap {
+	unsigned long addr;
+	unsigned long len;
+};
+
+struct mm_mprotect {
+	unsigned long addr;
+	unsigned long len;
+	unsigned int prot;
+};
+
+struct proc_mm_op {
+	int op;
+	union {
+		struct mm_mmap mmap;
+		struct mm_munmap munmap;
+	        struct mm_mprotect mprotect;
+		int copy_segments;
+	} u;
+};
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/skas/skas.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/skas/skas.h	2006-01-09 11:49:37.000000000 -0500
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SKAS_H
+#define __SKAS_H
+
+#include "mm_id.h"
+#include "sysdep/ptrace.h"
+
+extern int userspace_pid[];
+extern int proc_mm, ptrace_faultinfo, ptrace_ldt;
+extern int skas_needs_stub;
+
+extern void switch_threads(void *me, void *next);
+extern void thread_wait(void *sw, void *fb);
+extern void new_thread(void *stack, void **switch_buf_ptr, void **fork_buf_ptr,
+		       void (*handler)(int));
+extern int start_idle_thread(void *stack, void *switch_buf_ptr,
+			     void **fork_buf_ptr);
+extern int user_thread(unsigned long stack, int flags);
+extern void userspace(union uml_pt_regs *regs);
+extern void new_thread_proc(void *stack, void (*handler)(int sig));
+extern void new_thread_handler(int sig);
+extern void handle_syscall(union uml_pt_regs *regs);
+extern int map(struct mm_id * mm_idp, unsigned long virt,
+	       unsigned long len, int r, int w, int x, int phys_fd,
+	       unsigned long long offset, int done, void **data);
+extern int unmap(struct mm_id * mm_idp, void *addr, unsigned long len,
+		 int done, void **data);
+extern int protect(struct mm_id * mm_idp, unsigned long addr,
+		   unsigned long len, int r, int w, int x, int done,
+		   void **data);
+extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
+extern int new_mm(unsigned long stack);
+extern int start_userspace(unsigned long stub_stack);
+extern int copy_context_skas0(unsigned long stack, int pid);
+extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
+extern long execute_syscall_skas(void *r);
+extern unsigned long current_stub_stack(void);
+extern long run_syscall_stub(struct mm_id * mm_idp,
+			     int syscall, unsigned long *args, long expected,
+			     void **addr, int done);
+extern long syscall_stub_data(struct mm_id * mm_idp,
+			      unsigned long *data, int data_count,
+			      void **addr, void **stub_addr);
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/skas/stub-data.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/skas/stub-data.h	2006-01-09 11:26:24.000000000 -0500
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2005 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __STUB_DATA_H
+#define __STUB_DATA_H
+
+#include <sys/time.h>
+
+struct stub_data {
+	long offset;
+	int fd;
+	struct itimerval timer;
+	long err;
+};
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/skas/uaccess-skas.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/skas/uaccess-skas.h	2006-01-09 11:26:24.000000000 -0500
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SKAS_UACCESS_H
+#define __SKAS_UACCESS_H
+
+#include "asm/errno.h"
+
+/* No SKAS-specific checking. */
+#define access_ok_skas(type, addr, size) 0
+
+extern int copy_from_user_skas(void *to, const void __user *from, int n);
+extern int copy_to_user_skas(void __user *to, const void *from, int n);
+extern int strncpy_from_user_skas(char *dst, const char __user *src, int count);
+extern int __clear_user_skas(void __user *mem, int len);
+extern int clear_user_skas(void __user *mem, int len);
+extern int strnlen_user_skas(const void __user *str, int len);
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/tt/debug.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/tt/debug.h	2006-01-09 11:26:24.000000000 -0500
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2000, 2001, 2002  Jeff Dike (jdike@karaya.com) and
+ * Lars Brinkhoff.
+ * Licensed under the GPL
+ */
+
+#ifndef __UML_TT_DEBUG_H
+#define __UML_TT_DEBUG_H
+
+extern int debugger_proxy(int status, pid_t pid);
+extern void child_proxy(pid_t pid, int status);
+extern void init_proxy (pid_t pid, int waiting, int status);
+extern int start_debugger(char *prog, int startup, int stop, int *debugger_fd);
+extern void fake_child_exit(void);
+extern int gdb_config(char *str);
+extern int gdb_remove(int unused);
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/tt/mmu-tt.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/tt/mmu-tt.h	2006-01-09 11:26:24.000000000 -0500
@@ -0,0 +1,12 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __TT_MMU_H
+#define __TT_MMU_H
+
+struct mmu_context_tt {
+};
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/tt/mode-tt.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/tt/mode-tt.h	2006-01-09 11:26:24.000000000 -0500
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __MODE_TT_H__
+#define __MODE_TT_H__
+
+#include "sysdep/ptrace.h"
+
+enum { OP_NONE, OP_EXEC, OP_FORK, OP_TRACE_ON, OP_REBOOT, OP_HALT, OP_CB };
+
+extern int tracing_pid;
+
+extern int tracer(int (*init_proc)(void *), void *sp);
+extern void sig_handler_common_tt(int sig, void *sc);
+extern void syscall_handler_tt(int sig, union uml_pt_regs *regs);
+extern void reboot_tt(void);
+extern void halt_tt(void);
+extern int is_tracer_winch(int pid, int fd, void *data);
+extern void kill_off_processes_tt(void);
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/tt/mode_kern_tt.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/tt/mode_kern_tt.h	2006-01-09 11:26:24.000000000 -0500
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __TT_MODE_KERN_H__
+#define __TT_MODE_KERN_H__
+
+#include "linux/sched.h"
+#include "asm/page.h"
+#include "asm/ptrace.h"
+#include "asm/uaccess.h"
+
+extern void switch_to_tt(void *prev, void *next);
+extern void flush_thread_tt(void);
+extern void start_thread_tt(struct pt_regs *regs, unsigned long eip,
+			   unsigned long esp);
+extern int copy_thread_tt(int nr, unsigned long clone_flags, unsigned long sp,
+			  unsigned long stack_top, struct task_struct *p,
+			  struct pt_regs *regs);
+extern void release_thread_tt(struct task_struct *task);
+extern void initial_thread_cb_tt(void (*proc)(void *), void *arg);
+extern void init_idle_tt(void);
+extern void flush_tlb_kernel_range_tt(unsigned long start, unsigned long end);
+extern void flush_tlb_kernel_vm_tt(void);
+extern void __flush_tlb_one_tt(unsigned long addr);
+extern void flush_tlb_range_tt(struct vm_area_struct *vma,
+			       unsigned long start, unsigned long end);
+extern void flush_tlb_mm_tt(struct mm_struct *mm);
+extern void force_flush_all_tt(void);
+extern long execute_syscall_tt(void *r);
+extern void before_mem_tt(unsigned long brk_start);
+extern unsigned long set_task_sizes_tt(int arg, unsigned long *host_size_out,
+				       unsigned long *task_size_out);
+extern int start_uml_tt(void);
+extern int external_pid_tt(struct task_struct *task);
+extern int thread_pid_tt(struct task_struct *task);
+
+#define kmem_end_tt (host_task_size - ABOVE_KMEM)
+
+#endif
Index: linux-2.6.15-mm/arch/um/include/tt/tt.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/tt/tt.h	2006-01-09 11:26:24.000000000 -0500
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __TT_H__
+#define __TT_H__
+
+#include "sysdep/ptrace.h"
+
+extern int gdb_pid;
+extern int debug;
+extern int debug_stop;
+extern int debug_trace;
+
+extern int honeypot;
+
+extern int fork_tramp(void *sig_stack);
+extern int do_proc_op(void *t, int proc_id);
+extern int tracer(int (*init_proc)(void *), void *sp);
+extern void attach_process(int pid);
+extern void tracer_panic(char *format, ...);
+extern void set_init_pid(int pid);
+extern int set_user_mode(void *task);
+extern void set_tracing(void *t, int tracing);
+extern int is_tracing(void *task);
+extern void syscall_handler(int sig, union uml_pt_regs *regs);
+extern void exit_kernel(int pid, void *task);
+extern void do_syscall(void *task, int pid, int local_using_sysemu);
+extern void do_sigtrap(void *task);
+extern int is_valid_pid(int pid);
+extern void remap_data(void *segment_start, void *segment_end, int w);
+extern long execute_syscall_tt(void *r);
+
+#endif
+
Index: linux-2.6.15-mm/arch/um/include/tt/uaccess-tt.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/include/tt/uaccess-tt.h	2006-01-09 11:26:24.000000000 -0500
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __TT_UACCESS_H
+#define __TT_UACCESS_H
+
+#include "linux/string.h"
+#include "linux/sched.h"
+#include "asm/processor.h"
+#include "asm/errno.h"
+#include "asm/current.h"
+#include "asm/a.out.h"
+#include "uml_uaccess.h"
+
+#define ABOVE_KMEM (16 * 1024 * 1024)
+
+extern unsigned long end_vm;
+extern unsigned long uml_physmem;
+
+#define is_stack(addr, size) \
+	(((unsigned long) (addr) < STACK_TOP) && \
+	 ((unsigned long) (addr) >= STACK_TOP - ABOVE_KMEM) && \
+	 (((unsigned long) (addr) + (size)) <= STACK_TOP))
+
+#define access_ok_tt(type, addr, size) \
+	(is_stack(addr, size))
+
+extern unsigned long get_fault_addr(void);
+
+extern int __do_copy_from_user(void *to, const void *from, int n,
+			       void **fault_addr, void **fault_catcher);
+extern int __do_strncpy_from_user(char *dst, const char *src, size_t n,
+				  void **fault_addr, void **fault_catcher);
+extern int __do_clear_user(void *mem, size_t len, void **fault_addr,
+			   void **fault_catcher);
+extern int __do_strnlen_user(const char *str, unsigned long n,
+			     void **fault_addr, void **fault_catcher);
+
+extern int copy_from_user_tt(void *to, const void __user *from, int n);
+extern int copy_to_user_tt(void __user *to, const void *from, int n);
+extern int strncpy_from_user_tt(char *dst, const char __user *src, int count);
+extern int __clear_user_tt(void __user *mem, int len);
+extern int clear_user_tt(void __user *mem, int len);
+extern int strnlen_user_tt(const void __user *str, int len);
+
+#endif
Index: linux-2.6.15-mm/arch/um/kernel/skas/include/mm_id.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/include/mm_id.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,17 +0,0 @@
-/*
- * Copyright (C) 2005 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __MM_ID_H
-#define __MM_ID_H
-
-struct mm_id {
-	union {
-		int mm_fd;
-		int pid;
-	} u;
-	unsigned long stack;
-};
-
-#endif
Index: linux-2.6.15-mm/arch/um/kernel/skas/include/mmu-skas.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/include/mmu-skas.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,35 +0,0 @@
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SKAS_MMU_H
-#define __SKAS_MMU_H
-
-#include "linux/config.h"
-#include "mm_id.h"
-#include "asm/ldt.h"
-
-struct mmu_context_skas {
-	struct mm_id id;
-        unsigned long last_page_table;
-#ifdef CONFIG_3_LEVEL_PGTABLES
-        unsigned long last_pmd;
-#endif
-	uml_ldt_t ldt;
-};
-
-extern void switch_mm_skas(struct mm_id * mm_idp);
-
-#endif
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
Index: linux-2.6.15-mm/arch/um/kernel/skas/include/mode-skas.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/include/mode-skas.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,33 +0,0 @@
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __MODE_SKAS_H__
-#define __MODE_SKAS_H__
-
-#include <sysdep/ptrace.h>
-
-extern unsigned long exec_regs[];
-extern unsigned long exec_fp_regs[];
-extern unsigned long exec_fpx_regs[];
-extern int have_fpx_regs;
-
-extern void sig_handler_common_skas(int sig, void *sc_ptr);
-extern void halt_skas(void);
-extern void reboot_skas(void);
-extern void kill_off_processes_skas(void);
-extern int is_skas_winch(int pid, int fd, void *data);
-
-#endif
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
Index: linux-2.6.15-mm/arch/um/kernel/skas/include/proc_mm.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/include/proc_mm.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,55 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SKAS_PROC_MM_H
-#define __SKAS_PROC_MM_H
-
-#define MM_MMAP 54
-#define MM_MUNMAP 55
-#define MM_MPROTECT 56
-#define MM_COPY_SEGMENTS 57
-
-struct mm_mmap {
-	unsigned long addr;
-	unsigned long len;
-	unsigned long prot;
-	unsigned long flags;
-	unsigned long fd;
-	unsigned long offset;
-};
-
-struct mm_munmap {
-	unsigned long addr;
-	unsigned long len;	
-};
-
-struct mm_mprotect {
-	unsigned long addr;
-	unsigned long len;
-        unsigned int prot;
-};
-
-struct proc_mm_op {
-	int op;
-	union {
-		struct mm_mmap mmap;
-		struct mm_munmap munmap;
-	        struct mm_mprotect mprotect;
-		int copy_segments;
-	} u;
-};
-
-#endif
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
Index: linux-2.6.15-mm/arch/um/kernel/skas/include/skas.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/include/skas.h	2006-01-09 11:26:24.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,49 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SKAS_H
-#define __SKAS_H
-
-#include "mm_id.h"
-#include "sysdep/ptrace.h"
-
-extern int userspace_pid[];
-extern int proc_mm, ptrace_faultinfo, ptrace_ldt;
-extern int skas_needs_stub;
-
-extern void switch_threads(void *me, void *next);
-extern void thread_wait(void *sw, void *fb);
-extern void new_thread(void *stack, void **switch_buf_ptr, void **fork_buf_ptr,
-                       void (*handler)(int));
-extern int start_idle_thread(void *stack, void *switch_buf_ptr, 
-			     void **fork_buf_ptr);
-extern int user_thread(unsigned long stack, int flags);
-extern void userspace(union uml_pt_regs *regs);
-extern void new_thread_proc(void *stack, void (*handler)(int sig));
-extern void new_thread_handler(int sig);
-extern void handle_syscall(union uml_pt_regs *regs);
-extern int map(struct mm_id * mm_idp, unsigned long virt,
-	       unsigned long len, int r, int w, int x, int phys_fd,
-	       unsigned long long offset, int done, void **data);
-extern int unmap(struct mm_id * mm_idp, void *addr, unsigned long len,
-		 int done, void **data);
-extern int protect(struct mm_id * mm_idp, unsigned long addr,
-		   unsigned long len, int r, int w, int x, int done,
-		   void **data);
-extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
-extern int new_mm(unsigned long stack);
-extern int start_userspace(unsigned long stub_stack);
-extern int copy_context_skas0(unsigned long stack, int pid);
-extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
-extern long execute_syscall_skas(void *r);
-extern unsigned long current_stub_stack(void);
-extern long run_syscall_stub(struct mm_id * mm_idp,
-                             int syscall, unsigned long *args, long expected,
-                             void **addr, int done);
-extern long syscall_stub_data(struct mm_id * mm_idp,
-                              unsigned long *data, int data_count,
-                              void **addr, void **stub_addr);
-
-#endif
Index: linux-2.6.15-mm/arch/um/kernel/skas/include/stub-data.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/include/stub-data.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,18 +0,0 @@
-/*
- * Copyright (C) 2005 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __STUB_DATA_H
-#define __STUB_DATA_H
-
-#include <sys/time.h>
-
-struct stub_data {
-	long offset;
-	int fd;
-	struct itimerval timer;
-	long err;
-};
-
-#endif
Index: linux-2.6.15-mm/arch/um/kernel/skas/include/uaccess-skas.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/include/uaccess-skas.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,32 +0,0 @@
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SKAS_UACCESS_H
-#define __SKAS_UACCESS_H
-
-#include "asm/errno.h"
-
-/* No SKAS-specific checking. */
-#define access_ok_skas(type, addr, size) 0
-
-extern int copy_from_user_skas(void *to, const void __user *from, int n);
-extern int copy_to_user_skas(void __user *to, const void *from, int n);
-extern int strncpy_from_user_skas(char *dst, const char __user *src, int count);
-extern int __clear_user_skas(void __user *mem, int len);
-extern int clear_user_skas(void __user *mem, int len);
-extern int strnlen_user_skas(const void __user *str, int len);
-
-#endif
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
Index: linux-2.6.15-mm/arch/um/kernel/tt/include/debug.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/include/debug.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,18 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002  Jeff Dike (jdike@karaya.com) and
- * Lars Brinkhoff.
- * Licensed under the GPL
- */
-
-#ifndef __UML_TT_DEBUG_H
-#define __UML_TT_DEBUG_H
-
-extern int debugger_proxy(int status, pid_t pid);
-extern void child_proxy(pid_t pid, int status);
-extern void init_proxy (pid_t pid, int waiting, int status);
-extern int start_debugger(char *prog, int startup, int stop, int *debugger_fd);
-extern void fake_child_exit(void);
-extern int gdb_config(char *str);
-extern int gdb_remove(int unused);
-
-#endif
Index: linux-2.6.15-mm/arch/um/kernel/tt/include/mmu-tt.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/include/mmu-tt.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,23 +0,0 @@
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __TT_MMU_H
-#define __TT_MMU_H
-
-struct mmu_context_tt {
-};
-
-#endif
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
Index: linux-2.6.15-mm/arch/um/kernel/tt/include/tt.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/include/tt.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,46 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __TT_H__
-#define __TT_H__
-
-#include "sysdep/ptrace.h"
-
-extern int gdb_pid;
-extern int debug;
-extern int debug_stop;
-extern int debug_trace;
-
-extern int honeypot;
-
-extern int fork_tramp(void *sig_stack);
-extern int do_proc_op(void *t, int proc_id);
-extern int tracer(int (*init_proc)(void *), void *sp);
-extern void attach_process(int pid);
-extern void tracer_panic(char *format, ...);
-extern void set_init_pid(int pid);
-extern int set_user_mode(void *task);
-extern void set_tracing(void *t, int tracing);
-extern int is_tracing(void *task);
-extern void syscall_handler(int sig, union uml_pt_regs *regs);
-extern void exit_kernel(int pid, void *task);
-extern void do_syscall(void *task, int pid, int local_using_sysemu);
-extern void do_sigtrap(void *task);
-extern int is_valid_pid(int pid);
-extern void remap_data(void *segment_start, void *segment_end, int w);
-extern long execute_syscall_tt(void *r);
-
-#endif
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
Index: linux-2.6.15-mm/arch/um/kernel/tt/include/uaccess-tt.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/include/uaccess-tt.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,59 +0,0 @@
-/*
- * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
- * Licensed under the GPL
- */
-
-#ifndef __TT_UACCESS_H
-#define __TT_UACCESS_H
-
-#include "linux/string.h"
-#include "linux/sched.h"
-#include "asm/processor.h"
-#include "asm/errno.h"
-#include "asm/current.h"
-#include "asm/a.out.h"
-#include "uml_uaccess.h"
-
-#define ABOVE_KMEM (16 * 1024 * 1024)
-
-extern unsigned long end_vm;
-extern unsigned long uml_physmem;
-
-#define is_stack(addr, size) \
-	(((unsigned long) (addr) < STACK_TOP) && \
-	 ((unsigned long) (addr) >= STACK_TOP - ABOVE_KMEM) && \
-	 (((unsigned long) (addr) + (size)) <= STACK_TOP))
-
-#define access_ok_tt(type, addr, size) \
-	(is_stack(addr, size))
-
-extern unsigned long get_fault_addr(void);
-
-extern int __do_copy_from_user(void *to, const void *from, int n,
-			       void **fault_addr, void **fault_catcher);
-extern int __do_strncpy_from_user(char *dst, const char *src, size_t n,
-				  void **fault_addr, void **fault_catcher);
-extern int __do_clear_user(void *mem, size_t len, void **fault_addr,
-			   void **fault_catcher);
-extern int __do_strnlen_user(const char *str, unsigned long n,
-			     void **fault_addr, void **fault_catcher);
-
-extern int copy_from_user_tt(void *to, const void __user *from, int n);
-extern int copy_to_user_tt(void __user *to, const void *from, int n);
-extern int strncpy_from_user_tt(char *dst, const char __user *src, int count);
-extern int __clear_user_tt(void __user *mem, int len);
-extern int clear_user_tt(void __user *mem, int len);
-extern int strnlen_user_tt(const void __user *str, int len);
-
-#endif
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
Index: linux-2.6.15-mm/arch/um/kernel/skas/include/mode_kern-skas.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/include/mode_kern-skas.h	2006-01-09 10:27:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,52 +0,0 @@
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SKAS_MODE_KERN_H__
-#define __SKAS_MODE_KERN_H__
-
-#include "linux/sched.h"
-#include "asm/page.h"
-#include "asm/ptrace.h"
-
-extern void flush_thread_skas(void);
-extern void switch_to_skas(void *prev, void *next);
-extern void start_thread_skas(struct pt_regs *regs, unsigned long eip,
-			      unsigned long esp);
-extern int copy_thread_skas(int nr, unsigned long clone_flags,
-			    unsigned long sp, unsigned long stack_top,
-			    struct task_struct *p, struct pt_regs *regs);
-extern void release_thread_skas(struct task_struct *task);
-extern void initial_thread_cb_skas(void (*proc)(void *), void *arg);
-extern void init_idle_skas(void);
-extern void flush_tlb_kernel_range_skas(unsigned long start,
-					unsigned long end);
-extern void flush_tlb_kernel_vm_skas(void);
-extern void __flush_tlb_one_skas(unsigned long addr);
-extern void flush_tlb_range_skas(struct vm_area_struct *vma,
-				 unsigned long start, unsigned long end);
-extern void flush_tlb_mm_skas(struct mm_struct *mm);
-extern void force_flush_all_skas(void);
-extern long execute_syscall_skas(void *r);
-extern void before_mem_skas(unsigned long unused);
-extern unsigned long set_task_sizes_skas(int arg, unsigned long *host_size_out,
-					 unsigned long *task_size_out);
-extern int start_uml_skas(void);
-extern int external_pid_skas(struct task_struct *task);
-extern int thread_pid_skas(struct task_struct *task);
-
-#define kmem_end_skas (host_task_size - 1024 * 1024)
-
-#endif
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
Index: linux-2.6.15-mm/arch/um/include/mode_kern.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/mode_kern.h	2006-01-09 10:27:20.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/mode_kern.h	2006-01-09 11:26:24.000000000 -0500
@@ -9,22 +9,11 @@
 #include "linux/config.h"
 
 #ifdef CONFIG_MODE_TT
-#include "mode_kern-tt.h"
+#include "mode_kern_tt.h"
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-#include "mode_kern-skas.h"
+#include "mode_kern_skas.h"
 #endif
 
 #endif
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


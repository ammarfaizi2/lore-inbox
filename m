Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286768AbRLVLga>; Sat, 22 Dec 2001 06:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286766AbRLVLgW>; Sat, 22 Dec 2001 06:36:22 -0500
Received: from rj.sgi.com ([204.94.215.100]:11197 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S286768AbRLVLgJ>;
	Sat, 22 Dec 2001 06:36:09 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] Assigning syscall numbers for testing 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 22 Dec 2001 22:35:59 +1100
Message-ID: <8804.1009020959@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend, previous mail had the wrong version of the patch.

It is clear (to me at least) that developers have problems assigning
syscall numbers for testing, before their code is accepted into the
kernel.  Developers have to worry about collisions with everybody else
who is testing syscalls.  More importantly, the user space code has to
"know" what the testing syscall number is this week.  As a minor
problem, strace cannot report on testing syscalls, except to print the
number.

The patch below dynamically assigns a syscall number to a name and
exports the number and name via /proc.  Dynamic assignment removes the
collision problem.  Exporting via /proc allows user space code to
automatically find out what the syscall number is this week.  strace
could read the /proc output to print the syscall name, although it
still cannot print the arguments.

This facility must only be used while testing code, until the
developer's code is accepted by Linus when it should be assigned a
permanent syscall number.  Anybody caught using this kernel facility
for code that is in Linus's kernel will be hung, drawn, quartered then
forced to write in COBOL.

To dynamically register a syscall number, ignoring error checking :-

  #include <linux/dynamic_syscalls.h>

  printk(KERN_DEBUG "Assigned syscall number %d for %s\n",
     register_dynamic_syscall("attrctl", DYNAMIC_SYSCALL_FUNC(sys_attrctl)),
     "attrctl");

There is no deregister function.  Syscalls are _not_ supported in
modules, there is no architecture independent way of handling the
branch from the syscall handler to a module.  I know that people have
done syscalls in modules but unless they have coded some architecture
dependent assembler glue, I guarantee that their code will break on
ia64 and ppc64.  In any case, Linus has said that syscalls are not
supported in modules.  Ignore the modules howto, it is hopelessly out
of date.

User space code should open /proc/dynamic_syscalls, read the lines
looking for their syscall name, extract the number and call the glibc
syscall() function using that number.  Do not use the _syscalln()
functions, they require a constant syscall number at compile time.

If the code cannot open /proc/dynamic_syscalls or cannot find the
desired syscall name, fall back to the assigned syscall number (if any)
or fail if there is no assigned syscall number.  By falling back to the
assigned syscall number, new versions of the user space code are
backwards compatible, on older kernels it will use the dynamic syscall
number, on newer kernels it will use the assigned number.

The patch has support for i386 and ia64.  Each architecture needs
include/asm-$(ARCH)/dynamic_syscalls.h defining the range of dynamic
syscalls and information about entries in sys_call_table.  On archs
that use function pointers, DYNAMIC_SYSCALL_FUNCADDR must extract the
function address from the descriptor.

The patch is against 2.4.17 but should fit 2.4.16 and 2.5 as well.
Enjoy.

Index: 17.1/kernel/Makefile
--- 17.1/kernel/Makefile Tue, 18 Sep 2001 13:43:44 +1000 kaos (linux-2.4/k/3_Makefile 1.1.10.2 644)
+++ 17.1(w)/kernel/Makefile Sat, 22 Dec 2001 22:21:06 +1100 kaos (linux-2.4/k/3_Makefile 1.1.10.2 644)
@@ -14,7 +14,7 @@ export-objs = signal.o sys.o kmod.o cont
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o dynamic_syscalls.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
Index: 17.1/fs/proc/proc_misc.c
--- 17.1/fs/proc/proc_misc.c Thu, 22 Nov 2001 11:15:28 +1100 kaos (linux-2.4/o/b/48_proc_misc. 1.1.1.1.1.1.1.8 644)
+++ 17.1(w)/fs/proc/proc_misc.c Sat, 22 Dec 2001 22:13:37 +1100 kaos (linux-2.4/o/b/48_proc_misc. 1.1.1.1.1.1.1.8 644)
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
+#include <linux/dynamic_syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -320,6 +321,13 @@ static int devices_read_proc(char *page,
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+static int dynamic_syscalls_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	int len = get_dynamic_syscalls_list(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 static int partitions_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -511,6 +519,7 @@ void __init proc_misc_init(void)
 #endif
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
+		{"dynamic_syscalls",	dynamic_syscalls_read_proc},
 		{"partitions",	partitions_read_proc},
 #if !defined(CONFIG_ARCH_S390)
 		{"interrupts",	interrupts_read_proc},
Index: 17.1/kernel/dynamic_syscalls.c
--- 17.1/kernel/dynamic_syscalls.c Sat, 22 Dec 2001 22:21:58 +1100 kaos ()
+++ 17.1(w)/kernel/dynamic_syscalls.c Sat, 22 Dec 2001 22:18:29 +1100 kaos (linux-2.4/O/f/42_dynamic_sy  644)
@@ -0,0 +1,93 @@
+/*
+ *  kernel/dynamic_syscalls.c
+ *
+ *  (C) 2001 Keith owens <kaos@sgi.com>
+ *
+ *  Assign dynamic syscall numbers for testing.  Code that has not been assigned
+ *  an official syscall number can use these functions to get a dynamic syscall
+ *  number during testing.  It only works for syscall code that is built into
+ *  the kernel, there is no architecture independent way of handling a syscall
+ *  when the code is in a module, not to mention that such code would be
+ *  horribly racy against module unload.  None of the functions should be
+ *  exported, to prevent modules calling this code by mistake.
+ *
+ *  NOTE: This facility is only to be used during testing.  When your code is
+ *        ready to be included in the mainstream kernel, you must get official
+ *        syscall numbers from whoever controls the syscall numbers.
+ */
+
+#include <asm/dynamic_syscalls.h>
+
+#ifdef DYNAMIC_SYSCALL_FIRST
+
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/brlock.h>
+
+static rwlock_t dynamic_syscalls_lock = RW_LOCK_UNLOCKED;
+static const char *dynamic_syscalls_name[DYNAMIC_SYSCALL_LAST-DYNAMIC_SYSCALL_FIRST+1];
+extern DYNAMIC_SYSCALL_T sys_call_table[];
+
+/**
+ * get_dynamic_syscalls_list - print the list of dynamic syscall numbers
+ * @page: output buffer
+ *
+ * Description: Fill up a /proc buffer to print the dynamically assigned syscall
+ * numbers.  Assumes that the data will not exceed the size of the /proc page.
+ **/
+
+int get_dynamic_syscalls_list(char *page)
+{
+	int i, len;
+	len = sprintf(page, "Dynamic syscall numbers:\n");
+	read_lock(&dynamic_syscalls_lock);
+	for (i = 0; i < sizeof(dynamic_syscalls_name)/sizeof(dynamic_syscalls_name[0]) ; i++) {
+		if (dynamic_syscalls_name[i]) {
+			len += sprintf(page+len, "%d %s 0x%" DYNAMIC_SYSCALL_FMT "x\n",
+				i+DYNAMIC_SYSCALL_FIRST,
+				dynamic_syscalls_name[i],
+				sys_call_table[i+DYNAMIC_SYSCALL_FIRST]);
+		}
+	}
+	read_unlock(&dynamic_syscalls_lock);
+	return len;
+}
+
+/**
+ * register_dynamic_syscall - assign a dynamic syscall number.
+ * @name: the name of the syscall, used by user space code to find the number.
+ *        Use a unique name, if there is any possibility of conflict with
+ *        other test syscalls then include your company or initials in the name.
+ * @func: address of function to be invoked by this syscall name.  If the
+ *        function is in a module then the results are undefined.
+ *
+ * Description: Find the first syscall that has a null name pointer and the
+ *              syscall table entry is empty.
+ *
+ * Returns: < 0, an error occured, the return value is the error number.
+ *          > 0, the syscall number that has been assigned.
+ **/
+
+int register_dynamic_syscall(const char *name, void (*func)(void))
+{
+	int i, ret = -EBUSY;
+	write_lock(&dynamic_syscalls_lock);
+	for (i = 0; i < sizeof(dynamic_syscalls_name)/sizeof(dynamic_syscalls_name[0]) ; i++) {
+		if (dynamic_syscalls_name[i] == NULL && sys_call_table[i+DYNAMIC_SYSCALL_FIRST] == DYNAMIC_SYSCALL_EMPTY) {
+			dynamic_syscalls_name[i] = name;
+			sys_call_table[i+DYNAMIC_SYSCALL_FIRST] = DYNAMIC_SYSCALL_FUNCADDR(func);
+			ret = i+DYNAMIC_SYSCALL_FIRST+DYNAMIC_SYSCALL_OFFSET;
+			break;
+		}
+	}
+	write_unlock(&dynamic_syscalls_lock);
+	return ret;
+}
+
+/* No unregister_dynamic_syscall function.  Syscalls are not supported in
+ * modules.  
+ */
+
+#endif	/* DYNAMIC_SYSCALL_FIRST */
Index: 17.1/include/linux/dynamic_syscalls.h
--- 17.1/include/linux/dynamic_syscalls.h Sat, 22 Dec 2001 22:21:58 +1100 kaos ()
+++ 17.1(w)/include/linux/dynamic_syscalls.h Sat, 22 Dec 2001 22:13:37 +1100 kaos (linux-2.4/O/f/43_dynamic_sy  644)
@@ -0,0 +1,9 @@
+#ifndef _LINUX_DYNAMIC_SYSCALLS_H
+#define _LINUX_DYNAMIC_SYSCALLS_H
+
+extern int get_dynamic_syscalls_list(char *page);
+extern int register_dynamic_syscall(const char *name, void (*func)(void));
+
+#define DYNAMIC_SYSCALL_FUNC(f) (void (*)(void))(&f)
+
+#endif /* _LINUX_DYNAMIC_SYSCALLS_H */
Index: 17.1/include/asm-ia64/dynamic_syscalls.h
--- 17.1/include/asm-ia64/dynamic_syscalls.h Sat, 22 Dec 2001 22:21:58 +1100 kaos ()
+++ 17.1(w)/include/asm-ia64/dynamic_syscalls.h Sat, 22 Dec 2001 22:13:37 +1100 kaos (linux-2.4/O/f/44_dynamic_sy  644)
@@ -0,0 +1,28 @@
+#ifndef _ASM_DYNAMIC_SYSCALLS_H
+#define _ASM_DYNAMIC_SYSCALLS_H
+
+#include <linux/sys.h>
+
+#define DYNAMIC_SYSCALL_T		long long
+#define DYNAMIC_SYSCALL_FMT		"ll"
+
+/* IA64 function parameters do not point to the function itself, they point to a
+ * descriptor containing the 64 bit address of the function and the global
+ * pointer.  Dereference the function pointer to get the real function address,
+ * the syscall table requires direct addresses.
+ *
+ * This will almost certainly destroy your kernel if the syscall function is in
+ * a module because it will be entered with the wrong global pointer.
+ * Don't do that.
+ */
+
+#include <linux/types.h>
+#define DYNAMIC_SYSCALL_FUNCADDR(f)	({DYNAMIC_SYSCALL_T *fp = (DYNAMIC_SYSCALL_T *)(f); fp[0];})
+
+#define DYNAMIC_SYSCALL_OFFSET		1024
+#define DYNAMIC_SYSCALL_FIRST		240
+#define DYNAMIC_SYSCALL_LAST		NR_syscalls-1
+#define DYNAMIC_SYSCALL_EMPTY		DYNAMIC_SYSCALL_FUNCADDR(&ia64_ni_syscall)
+extern long ia64_ni_syscall(void);	/* No need to define parameters */
+
+#endif /* _ASM_DYNAMIC_SYSCALLS_H */
Index: 17.1/include/asm-i386/dynamic_syscalls.h
--- 17.1/include/asm-i386/dynamic_syscalls.h Sat, 22 Dec 2001 22:21:58 +1100 kaos ()
+++ 17.1(w)/include/asm-i386/dynamic_syscalls.h Sat, 22 Dec 2001 22:13:37 +1100 kaos (linux-2.4/O/f/45_dynamic_sy  644)
@@ -0,0 +1,21 @@
+#ifndef _ASM_DYNAMIC_SYSCALLS_H
+#define _ASM_DYNAMIC_SYSCALLS_H
+
+#include <linux/sys.h>
+
+#define DYNAMIC_SYSCALL_T		long
+#define DYNAMIC_SYSCALL_FMT		"l"
+
+/* This is a noop on most systems.  It does real work on architectures that use
+ * function descriptors.  See asm-ia64/dynamic_syscalls.h for an example.
+ */
+
+#define DYNAMIC_SYSCALL_FUNCADDR(f)	(DYNAMIC_SYSCALL_T)(f)
+
+#define DYNAMIC_SYSCALL_OFFSET		0
+#define DYNAMIC_SYSCALL_FIRST		240
+#define DYNAMIC_SYSCALL_LAST		NR_syscalls-1
+#define DYNAMIC_SYSCALL_EMPTY		DYNAMIC_SYSCALL_FUNCADDR(&sys_ni_syscall)
+extern long sys_ni_syscall(void);	/* No need to define parameters */
+
+#endif /* _ASM_DYNAMIC_SYSCALLS_H */


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287582AbSAHCvN>; Mon, 7 Jan 2002 21:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287579AbSAHCuz>; Mon, 7 Jan 2002 21:50:55 -0500
Received: from zok.SGI.COM ([204.94.215.101]:48771 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S287577AbSAHCun>;
	Mon, 7 Jan 2002 21:50:43 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [orphan patch] 2.5.2-pre9 Assign syscall numbers for testing
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Jan 2002 13:50:21 +1100
Message-ID: <4052.1010458221@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have sent this patch to Linus twice and got no reply.  I don't have
time to maintain it, this is now an orphan patch.  If anybody wants it,
they can have it.

To: torvalds@transmeta.com

Developers have problems getting syscall numbers for testing.  You
won't assign a number until the code has been tested, they cannot test
their code without an assigned number, catch-22.

Developers cannot pick an arbitrary number without worrying about
collisions with other testing code.  More importantly, the user space
code has to "know" what the testing syscall number is this week,
risking version skew between kernel and user space.  As a minor
problem, strace cannot report on testing syscalls, except to print the
number.

The patch below dynamically assigns a syscall number to a name and
exports the number and name via /proc.  Dynamic assignment removes the
collision problem.  Exporting via /proc allows user space code to
automatically find out what the syscall number is this week.  strace
could read the /proc output to print the syscall name, although it
still cannot print the arguments.

This facility must only be used while testing code, until the
developer's code is accepted by you when it will be assigned a
permanent syscall number.  Anybody caught using this facility for code
that is in the main kernel will be hung, drawn, quartered then forced
to write in COBOL.

To dynamically register a syscall number, ignoring error checking :-

  #include <linux/dynamic_syscalls.h>

  printk(KERN_DEBUG "Assigned syscall number %d for %s\n",
     register_dynamic_syscall("attrctl", DYNAMIC_SYSCALL_FUNC(sys_attrctl)),
     "attrctl");

There is no deregister function.  Syscalls are _not_ supported in
modules.

User space code should open /proc/dynamic_syscalls, read the lines
looking for their syscall name, extract the number and call the glibc
syscall() function using that number.

If the code cannot open /proc/dynamic_syscalls or cannot find the
desired syscall name, fall back to the assigned syscall number (if any)
or fail if there is no assigned syscall number.  By falling back to the
assigned syscall number, new versions of the user space code are
backwards compatible, on older kernels it will use the dynamic syscall
number, on newer kernels it will use the assigned number.

The patch supports all architectures, it is a noop on everything except
i386 and ia64.

Index: 2-pre8.1/kernel/dynamic_syscalls.c
--- 2-pre8.1/kernel/dynamic_syscalls.c Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/kernel/dynamic_syscalls.c Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/27_dynamic_sy 1.1 644)
@@ -0,0 +1,93 @@
+/*
+ *  kernel/dynamic_syscalls.c
+ *
+ *  (C) 2001 Keith Owens <kaos@ocs.com.au>
+ *
+ *  Assign dynamic syscall numbers for testing.  Code that has not been assigned
+ *  an official syscall number can use these functions to get a dynamic syscall
+ *  number during testing.  It only works for syscall code that is built into
+ *  the kernel, there is no architecture independent way of handling a syscall
+ *  when the code is in a module, not to mention that such code would be
+ *  horribly racy against module unload.  None of the functions below should be
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
Index: 2-pre8.1/include/linux/dynamic_syscalls.h
--- 2-pre8.1/include/linux/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/linux/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/28_dynamic_sy 1.1 644)
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
Index: 2-pre8.1/include/asm-ia64/dynamic_syscalls.h
--- 2-pre8.1/include/asm-ia64/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-ia64/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/39_dynamic_sy 1.1 644)
@@ -0,0 +1,30 @@
+#ifndef _ASM_DYNAMIC_SYSCALLS_H
+#define _ASM_DYNAMIC_SYSCALLS_H
+
+/* Dynamic syscall support for ia64.  Keith Owens <kaos@ocs.com.au> */
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
+#define DYNAMIC_SYSCALL_FIRST		(1217-DYNAMIC_SYSCALL_OFFSET)
+#define DYNAMIC_SYSCALL_LAST		(1226-DYNAMIC_SYSCALL_OFFSET)
+#define DYNAMIC_SYSCALL_EMPTY		DYNAMIC_SYSCALL_FUNCADDR(&ia64_ni_syscall)
+extern long ia64_ni_syscall(void);	/* No need to define parameters */
+
+#endif /* _ASM_DYNAMIC_SYSCALLS_H */
Index: 2-pre8.1/include/asm-i386/dynamic_syscalls.h
--- 2-pre8.1/include/asm-i386/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-i386/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/40_dynamic_sy 1.1 644)
@@ -0,0 +1,23 @@
+#ifndef _ASM_DYNAMIC_SYSCALLS_H
+#define _ASM_DYNAMIC_SYSCALLS_H
+
+/* Dynamic syscall support for i386.  Keith Owens <kaos@ocs.com.au> */
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
+#define DYNAMIC_SYSCALL_FIRST		226
+#define DYNAMIC_SYSCALL_LAST		235
+#define DYNAMIC_SYSCALL_EMPTY		DYNAMIC_SYSCALL_FUNCADDR(&sys_ni_syscall)
+extern long sys_ni_syscall(void);	/* No need to define parameters */
+
+#endif /* _ASM_DYNAMIC_SYSCALLS_H */
Index: 2-pre8.1/kernel/Makefile
--- 2-pre8.1/kernel/Makefile Sat, 01 Dec 2001 15:07:34 +1100 kaos (linux-2.5/w/d/27_Makefile 1.2 644)
+++ 2-pre8.2/kernel/Makefile Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/w/d/27_Makefile 1.3 644)
@@ -15,7 +15,7 @@ export-objs = signal.o sys.o kmod.o cont
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o device.o
+	    signal.o sys.o kmod.o context.o device.o dynamic_syscalls.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
Index: 2-pre8.1/fs/proc/proc_misc.c
--- 2-pre8.1/fs/proc/proc_misc.c Wed, 26 Dec 2001 14:32:39 +1100 kaos (linux-2.5/H/d/40_proc_misc. 1.4 644)
+++ 2-pre8.2/fs/proc/proc_misc.c Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/H/d/40_proc_misc. 1.5 644)
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
+#include <linux/dynamic_syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -308,6 +309,13 @@ static int devices_read_proc(char *page,
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
@@ -526,6 +534,7 @@ void __init proc_misc_init(void)
 #endif
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
+		{"dynamic_syscalls",	dynamic_syscalls_read_proc},
 		{"partitions",	partitions_read_proc},
 		{"filesystems",	filesystems_read_proc},
 		{"dma",		dma_read_proc},
Index: 2-pre8.1/arch/ia64/kernel/entry.S
--- 2-pre8.1/arch/ia64/kernel/entry.S Sat, 24 Nov 2001 05:28:08 +1100 kaos (linux-2.5/t/39_entry.S 1.1 644)
+++ 2-pre8.2/arch/ia64/kernel/entry.S Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/t/39_entry.S 1.2 644)
@@ -1130,16 +1130,16 @@ sys_call_table:
 	data8 sys_getdents64
 	data8 sys_getunwind			// 1215
 	data8 sys_readahead
-	data8 ia64_ni_syscall
-	data8 ia64_ni_syscall
-	data8 ia64_ni_syscall
-	data8 ia64_ni_syscall			// 1220
-	data8 ia64_ni_syscall
-	data8 ia64_ni_syscall
-	data8 ia64_ni_syscall
-	data8 ia64_ni_syscall
-	data8 ia64_ni_syscall			// 1225
-	data8 ia64_ni_syscall
+	data8 ia64_ni_syscall			//      Reserved for dynamic syscalls
+	data8 ia64_ni_syscall			//      Reserved for dynamic syscalls
+	data8 ia64_ni_syscall			//      Reserved for dynamic syscalls
+	data8 ia64_ni_syscall			// 1220 Reserved for dynamic syscalls
+	data8 ia64_ni_syscall			//      Reserved for dynamic syscalls
+	data8 ia64_ni_syscall			//      Reserved for dynamic syscalls
+	data8 ia64_ni_syscall			//      Reserved for dynamic syscalls
+	data8 ia64_ni_syscall			//      Reserved for dynamic syscalls
+	data8 ia64_ni_syscall			// 1225 Reserved for dynamic syscalls
+	data8 ia64_ni_syscall			//      Reserved for dynamic syscalls
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
Index: 2-pre8.1/arch/i386/kernel/entry.S
--- 2-pre8.1/arch/i386/kernel/entry.S Sat, 24 Nov 2001 05:28:08 +1100 kaos (linux-2.5/a/b/33_entry.S 1.1 644)
+++ 2-pre8.2/arch/i386/kernel/entry.S Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/a/b/33_entry.S 1.1.1.1 644)
@@ -622,6 +622,16 @@ ENTRY(sys_call_table)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_readahead)	/* 225 */
+	.long SYMBOL_NAME(sys_ni_syscall)	/*     Reserved for dynamic syscalls */
+	.long SYMBOL_NAME(sys_ni_syscall)	/*     Reserved for dynamic syscalls */
+	.long SYMBOL_NAME(sys_ni_syscall)	/*     Reserved for dynamic syscalls */
+	.long SYMBOL_NAME(sys_ni_syscall)	/*     Reserved for dynamic syscalls */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* 230 Reserved for dynamic syscalls */
+	.long SYMBOL_NAME(sys_ni_syscall)	/*     Reserved for dynamic syscalls */
+	.long SYMBOL_NAME(sys_ni_syscall)	/*     Reserved for dynamic syscalls */
+	.long SYMBOL_NAME(sys_ni_syscall)	/*     Reserved for dynamic syscalls */
+	.long SYMBOL_NAME(sys_ni_syscall)	/*     Reserved for dynamic syscalls */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* 235 Reserved for dynamic syscalls */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
Index: 2-pre8.1/include/asm-sparc64/dynamic_syscalls.h
--- 2-pre8.1/include/asm-sparc64/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-sparc64/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/29_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-sparc/dynamic_syscalls.h
--- 2-pre8.1/include/asm-sparc/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-sparc/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/30_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-sh/dynamic_syscalls.h
--- 2-pre8.1/include/asm-sh/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-sh/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/31_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-s390x/dynamic_syscalls.h
--- 2-pre8.1/include/asm-s390x/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-s390x/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/32_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-s390/dynamic_syscalls.h
--- 2-pre8.1/include/asm-s390/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-s390/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/33_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-ppc/dynamic_syscalls.h
--- 2-pre8.1/include/asm-ppc/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-ppc/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/34_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-parisc/dynamic_syscalls.h
--- 2-pre8.1/include/asm-parisc/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-parisc/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/35_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-mips64/dynamic_syscalls.h
--- 2-pre8.1/include/asm-mips64/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-mips64/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/36_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-mips/dynamic_syscalls.h
--- 2-pre8.1/include/asm-mips/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-mips/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/37_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-m68k/dynamic_syscalls.h
--- 2-pre8.1/include/asm-m68k/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-m68k/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/38_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-cris/dynamic_syscalls.h
--- 2-pre8.1/include/asm-cris/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-cris/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/41_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-arm/dynamic_syscalls.h
--- 2-pre8.1/include/asm-arm/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-arm/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/42_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */
Index: 2-pre8.1/include/asm-alpha/dynamic_syscalls.h
--- 2-pre8.1/include/asm-alpha/dynamic_syscalls.h Sat, 05 Jan 2002 23:00:25 +1100 kaos ()
+++ 2-pre8.2/include/asm-alpha/dynamic_syscalls.h Sat, 05 Jan 2002 22:59:58 +1100 kaos (linux-2.5/O/d/43_dynamic_sy 1.1 644)
@@ -0,0 +1,7 @@
+/*
+   This architecture does not support dynamic syscalls yet, replace this file
+   and reserve some syscall numbers to make it work.  Copy one of
+   include/asm-{i386,ia64}/dynamic_syscalls.h here and change to suit.  Use i386
+   as a starting point for most architectures, use ia64 as a starting point for
+   architectures that use function descriptors.
+ */



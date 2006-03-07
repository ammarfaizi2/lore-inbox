Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWCGPxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWCGPxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWCGPxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:53:51 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:64584 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751324AbWCGPxu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:53:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tRUj8fuwaoYHUBjQRHthVh22pmxtqD2Awt08G5nLhoQSVHoQ2mHNvVdJ7/7nypnBNM9M8v9hqqY1bqNjp2jE8iCcupUDb32AGcxa95teuuUrGuIZCaq7XUF9rSdtztrMbbl15MCEnP17mHxNHsXPbCeTHs2y6pMgA9NdcIIfHgk=
Message-ID: <db5f2c340603070753q23416c5byd7200257c0d83ff3@mail.gmail.com>
Date: Tue, 7 Mar 2006 16:53:49 +0100
From: "=?ISO-8859-1?Q?Fran=E7ois_Trahay?=" <ftrahay@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] UML : separated stack and libs randomization
Cc: ftrahay@gmail.com, "Stanislas Dourdin" <sdourdin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch for UML (but, it is easy to apply it to x86 architecture).
It allows you to randomize mmap and stack separately ( randomize_va_space is
replaced by randomize_stack_space and randomize_mmap_space). This is just
for study purposes but I'd like to have your opinion about it.



diff -BburN linux-2.6.15/arch/um/kernel/process_kern.c
linux-2.6.15.diff/arch/um/kernel/process_kern.c
--- linux-2.6.15/arch/um/kernel/process_kern.c	2006-01-03
04:21:10.000000000 +0100
+++ linux-2.6.15.diff/arch/um/kernel/process_kern.c	2006-03-05
13:19:09.000000000 +0100
@@ -465,7 +465,7 @@
 #ifndef arch_align_stack
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (randomize_va_space)
+	if (randomize_stack_space)
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }
diff -BburN linux-2.6.15/fs/binfmt_elf.c linux-2.6.15.diff/fs/binfmt_elf.c
--- linux-2.6.15/fs/binfmt_elf.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.diff/fs/binfmt_elf.c	2006-03-05 13:19:09.000000000 +0100
@@ -767,7 +767,7 @@
 	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;

-	if ( !(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	if ( !(current->personality & ADDR_NO_RANDOMIZE) && randomize_stack_space)
 		current->flags |= PF_RANDOMIZE;
 	arch_pick_mmap_layout(current->mm);

diff -BburN linux-2.6.15/include/linux/kernel.h
linux-2.6.15.diff/include/linux/kernel.h
--- linux-2.6.15/include/linux/kernel.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.diff/include/linux/kernel.h	2006-03-05 13:25:25.000000000 +0100
@@ -310,9 +310,11 @@
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))

 #ifdef CONFIG_SYSCTL
-extern int randomize_va_space;
+extern int randomize_stack_space;
+extern int randomize_mmap_space;
 #else
-#define randomize_va_space 1
+#define randomize_stack_space 1
+#define randomize_mmap_space 1
 #endif

 /* Trap pasters of __FUNCTION__ at compile-time */
diff -BburN linux-2.6.15/include/linux/sched.h
linux-2.6.15.diff/include/linux/sched.h
--- linux-2.6.15/include/linux/sched.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.diff/include/linux/sched.h	2006-03-05 13:20:57.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <linux/topology.h>
 #include <linux/seccomp.h>
+#include <linux/random.h>

 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */

@@ -1368,11 +1369,30 @@
 #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
 extern void arch_pick_mmap_layout(struct mm_struct *mm);
 #else
+#define MIN_GAP (128*1024*1024)
+#define MAX_GAP (TASK_SIZE/6*5)
+
+static inline unsigned long mmap_base(struct mm_struct *mm)
+{
+	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
+	unsigned long random_factor = 0;
+
+	if (randomize_mmap_space)
+		random_factor = get_random_int() % (1024*1024);
+
+	if (gap < MIN_GAP)
+		gap = MIN_GAP;
+	else if (gap > MAX_GAP)
+		gap = MAX_GAP;
+
+	return PAGE_ALIGN(TASK_SIZE - gap - random_factor);
+}
+
 static inline void arch_pick_mmap_layout(struct mm_struct *mm)
 {
-	mm->mmap_base = TASK_UNMAPPED_BASE;
-	mm->get_unmapped_area = arch_get_unmapped_area;
-	mm->unmap_area = arch_unmap_area;
+	mm->mmap_base = mmap_base(mm);
+	mm->get_unmapped_area = arch_get_unmapped_area_topdown;
+	mm->unmap_area = arch_unmap_area_topdown;
 }
 #endif

diff -BburN linux-2.6.15/include/linux/sysctl.h
linux-2.6.15.diff/include/linux/sysctl.h
--- linux-2.6.15/include/linux/sysctl.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.diff/include/linux/sysctl.h	2006-03-05 13:28:41.000000000 +0100
@@ -143,9 +143,10 @@
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
-	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
+	KERN_RANDOMIZE_STACK=71, /* int: randomize stack top */
+	KERN_RANDOMIZE_MMAP=72, /* int: randomize mmap adress */
 };


diff -BburN linux-2.6.15/kernel/sysctl.c linux-2.6.15.diff/kernel/sysctl.c
--- linux-2.6.15/kernel/sysctl.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.diff/kernel/sysctl.c	2006-03-05 13:26:26.000000000 +0100
@@ -124,7 +124,8 @@
 extern int acct_parm[];
 #endif

-int randomize_va_space = 1;
+int randomize_stack_space = 1;
+int randomize_mmap_space = 1;

 static int parse_table(int __user *, int, void __user *, size_t
__user *, void __user *, size_t,
 		       ctl_table *, void **);
@@ -639,9 +640,17 @@
 	},
 #endif
 	{
-		.ctl_name	= KERN_RANDOMIZE,
-		.procname	= "randomize_va_space",
-		.data		= &randomize_va_space,
+		.ctl_name	= KERN_RANDOMIZE_STACK,
+		.procname	= "randomize_stack_space",
+		.data		= &randomize_stack_space,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_RANDOMIZE_MMAP,
+		.procname	= "randomize_mmap_space",
+		.data		= &randomize_mmap_space,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,

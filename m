Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317954AbSGPUkV>; Tue, 16 Jul 2002 16:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317977AbSGPUkV>; Tue, 16 Jul 2002 16:40:21 -0400
Received: from draco.netpower.no ([212.33.133.34]:60945 "EHLO
	draco.netpower.no") by vger.kernel.org with ESMTP
	id <S317954AbSGPUkK>; Tue, 16 Jul 2002 16:40:10 -0400
Date: Tue, 16 Jul 2002 22:42:59 +0200
From: Erlend Aasland <erlend-a@innova.no>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5][TRIVIAL] {get,put}_binfmt()
Message-ID: <20020716224259.A20283@innova.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While browsing through kernel/{fork,exit}.c, I noticed that a pair of
{get,put}_binfmt() could make some code slightly more readable (imho).
After a few seconds of grepping, I found the function put_binfmt() in
fs/exec.c, and I made a little "sister-function" for it: get_binfmt().

This patch adds get_binfmt(). It gives {put,get}_binfmt() a new home:
include/linux/binfmts.h (so kernel/{fork,exit}.c can use them.) Minor
#include changes was needed in fork.c, exit.c and exec.c to make this
work.

If you think this is a bad idea, just ignore this patch :)


Regards,
	Erlend Aasland


diff -urN linux-2.5.25/fs/exec.c linux-2.5.25-dirty/fs/exec.c
--- linux-2.5.25/fs/exec.c	Wed Jun 19 04:11:52 2002
+++ linux-2.5.25-dirty/fs/exec.c	Tue Jul 16 21:19:10 2002
@@ -35,9 +35,9 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/personality.h>
-#include <linux/binfmts.h>
 #define __NO_VERSION__
 #include <linux/module.h>
+#include <linux/binfmts.h>
 #include <linux/namei.h>
 
 #include <asm/uaccess.h>
@@ -92,12 +92,6 @@
 	return -EINVAL;
 }
 
-static inline void put_binfmt(struct linux_binfmt * fmt)
-{
-	if (fmt->module)
-		__MOD_DEC_USE_COUNT(fmt->module);
-}
-
 /*
  * Note that a shared library must be both readable and executable due to
  * security reasons.
@@ -947,11 +941,9 @@
 void set_binfmt(struct linux_binfmt *new)
 {
 	struct linux_binfmt *old = current->binfmt;
-	if (new && new->module)
-		__MOD_INC_USE_COUNT(new->module);
+	get_binfmt(new);
 	current->binfmt = new;
-	if (old && old->module)
-		__MOD_DEC_USE_COUNT(old->module);
+	put_binfmt(old);
 }
 
 int do_coredump(long signr, struct pt_regs * regs)
diff -urN linux-2.5.25/include/linux/binfmts.h linux-2.5.25-dirty/include/linux/binfmts.h
--- linux-2.5.25/include/linux/binfmts.h	Wed Jun 19 04:11:55 2002
+++ linux-2.5.25-dirty/include/linux/binfmts.h	Tue Jul 16 21:06:48 2002
@@ -3,6 +3,7 @@
 
 #include <linux/ptrace.h>
 #include <linux/capability.h>
+#include <linux/module.h>
 
 /*
  * MAX_ARG_PAGES defines the number of pages allocated for arguments
@@ -60,6 +61,17 @@
 extern int do_coredump(long signr, struct pt_regs * regs);
 extern void set_binfmt(struct linux_binfmt *new);
 
+static inline void put_binfmt(struct linux_binfmt * fmt)
+{
+	if (fmt && fmt->module)
+		__MOD_DEC_USE_COUNT(fmt->module);
+}
+
+static inline void get_binfmt(struct linux_binfmt * fmt)
+{
+	if (fmt && fmt->module)
+		__MOD_INC_USE_COUNT(fmt->module);
+}
 
 #if 0
 /* this went away now */
diff -urN linux-2.5.25/kernel/exit.c linux-2.5.25-dirty/kernel/exit.c
--- linux-2.5.25/kernel/exit.c	Mon Jul  8 08:38:59 2002
+++ linux-2.5.25-dirty/kernel/exit.c	Tue Jul 16 21:13:26 2002
@@ -9,7 +9,6 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
-#include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/personality.h>
 #include <linux/tty.h>
@@ -551,8 +550,7 @@
 		disassociate_ctty(1);
 
 	put_exec_domain(tsk->thread_info->exec_domain);
-	if (tsk->binfmt && tsk->binfmt->module)
-		__MOD_DEC_USE_COUNT(tsk->binfmt->module);
+	put_binfmt(tsk->binfmt);
 
 	tsk->exit_code = code;
 	exit_notify();
diff -urN linux-2.5.25/kernel/fork.c linux-2.5.25-dirty/kernel/fork.c
--- linux-2.5.25/kernel/fork.c	Mon Jul  8 08:38:59 2002
+++ linux-2.5.25-dirty/kernel/fork.c	Tue Jul 16 21:12:06 2002
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/unistd.h>
 #include <linux/smp_lock.h>
-#include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/completion.h>
 #include <linux/namespace.h>
@@ -645,9 +644,7 @@
 		goto bad_fork_cleanup_count;
 	
 	get_exec_domain(p->thread_info->exec_domain);
-
-	if (p->binfmt && p->binfmt->module)
-		__MOD_INC_USE_COUNT(p->binfmt->module);
+	get_binfmt(p->binfmt);
 
 #ifdef CONFIG_PREEMPT
 	/*
@@ -818,8 +815,7 @@
 	exit_semundo(p);
 bad_fork_cleanup:
 	put_exec_domain(p->thread_info->exec_domain);
-	if (p->binfmt && p->binfmt->module)
-		__MOD_DEC_USE_COUNT(p->binfmt->module);
+	put_binfmt(p->binfmt);
 bad_fork_cleanup_count:
 	atomic_dec(&p->user->processes);
 	free_uid(p->user);

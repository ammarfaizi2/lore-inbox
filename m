Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130512AbQLSXkb>; Tue, 19 Dec 2000 18:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130653AbQLSXkV>; Tue, 19 Dec 2000 18:40:21 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:22542 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S130512AbQLSXkK>;
	Tue, 19 Dec 2000 18:40:10 -0500
Date: Wed, 20 Dec 2000 01:09:52 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: linux-kernel@vger.kernel.org
Subject: [patch] get_binfmt/put_binfmt macros
Message-ID: <Pine.LNX.4.10.10012200102430.18898-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

	this patch replaces the binfmt module handling parts with macro
calls which do the same thing similar do the get/put_exec_domain macros.
Also changes an internal function name in fs/exec.c (put_binfmt) which
does almost the same thing as put_binfmt (one check less) to avoid
compilation conflicts.
Files affected: fork.c, exit.c, fs/exec.c ,include/linux/binfmts.h

It is against test12 but test13pre3 does not affect these files.

Comments are welcome.

Jani.	


diff -uNr -X dontdiff /usr/src/clean/linux/fs/exec.c linux/fs/exec.c
--- /usr/src/clean/linux/fs/exec.c	Tue Dec 12 11:25:55 2000
+++ linux/fs/exec.c	Wed Dec 20 00:13:55 2000
@@ -87,7 +87,7 @@
 	return -EINVAL;
 }
 
-static inline void put_binfmt(struct linux_binfmt * fmt)
+static inline void _put_binfmt(struct linux_binfmt * fmt)
 {
 	if (fmt->module)
 		__MOD_DEC_USE_COUNT(fmt->module);
@@ -135,7 +135,7 @@
 			read_unlock(&binfmt_lock);
 			error = fmt->load_shlib(file);
 			read_lock(&binfmt_lock);
-			put_binfmt(fmt);
+			_put_binfmt(fmt);
 			if (error != -ENOEXEC)
 				break;
 		}
@@ -810,7 +810,7 @@
 			read_unlock(&binfmt_lock);
 			retval = fn(bprm, regs);
 			if (retval >= 0) {
-				put_binfmt(fmt);
+				_put_binfmt(fmt);
 				allow_write_access(bprm->file);
 				if (bprm->file)
 					fput(bprm->file);
@@ -819,7 +819,7 @@
 				return retval;
 			}
 			read_lock(&binfmt_lock);
-			put_binfmt(fmt);
+			_put_binfmt(fmt);
 			if (retval != -ENOEXEC)
 				break;
 			if (!bprm->file) {
@@ -924,11 +924,11 @@
 void set_binfmt(struct linux_binfmt *new)
 {
 	struct linux_binfmt *old = current->binfmt;
-	if (new && new->module)
-		__MOD_INC_USE_COUNT(new->module);
+
+	get_binfmt(new);
 	current->binfmt = new;
-	if (old && old->module)
-		__MOD_DEC_USE_COUNT(old->module);
+	put_binfmt(old);
+
 }
 
 int do_coredump(long signr, struct pt_regs * regs)
diff -uNr -X dontdiff /usr/src/clean/linux/include/linux/binfmts.h linux/include/linux/binfmts.h
--- /usr/src/clean/linux/include/linux/binfmts.h	Tue Dec 12 11:42:22 2000
+++ linux/include/linux/binfmts.h	Wed Dec 20 00:10:59 2000
@@ -59,6 +59,12 @@
 extern int do_coredump(long signr, struct pt_regs * regs);
 extern void set_binfmt(struct linux_binfmt *new);
 
+#define get_binfmt(bf)	\
+	if (bf && bf->module) __MOD_INC_USE_COUNT(bf->module)
+
+#define put_binfmt(bf)	\
+	if (bf && bf->module) __MOD_DEC_USE_COUNT(bf->module)
+	
 
 #if 0
 /* this went away now */
diff -uNr -X dontdiff /usr/src/clean/linux/kernel/exit.c linux/kernel/exit.c
--- /usr/src/clean/linux/kernel/exit.c	Tue Dec 12 11:25:58 2000
+++ linux/kernel/exit.c	Wed Dec 20 00:11:40 2000
@@ -448,8 +448,7 @@
 	tsk->exit_code = code;
 	exit_notify();
 	put_exec_domain(tsk->exec_domain);
-	if (tsk->binfmt && tsk->binfmt->module)
-		__MOD_DEC_USE_COUNT(tsk->binfmt->module);
+	put_binfmt(tsk->binfmt);
 	schedule();
 /*
  * In order to get rid of the "volatile function does return" message
diff -uNr -X dontdiff /usr/src/clean/linux/kernel/fork.c linux/kernel/fork.c
--- /usr/src/clean/linux/kernel/fork.c	Tue Dec 12 11:25:58 2000
+++ linux/kernel/fork.c	Wed Dec 20 00:10:44 2000
@@ -578,8 +578,7 @@
 	
 	get_exec_domain(p->exec_domain);
 
-	if (p->binfmt && p->binfmt->module)
-		__MOD_INC_USE_COUNT(p->binfmt->module);
+	get_binfmt(p->binfmt);
 
 	p->did_exec = 0;
 	p->swappable = 0;
@@ -701,8 +700,8 @@
 	exit_files(p); /* blocking */
 bad_fork_cleanup:
 	put_exec_domain(p->exec_domain);
-	if (p->binfmt && p->binfmt->module)
-		__MOD_DEC_USE_COUNT(p->binfmt->module);
+	put_binfmt(p->binfmt);
+	
 bad_fork_cleanup_count:
 	atomic_dec(&p->user->processes);
 	free_uid(p->user);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319104AbSHMS2P>; Tue, 13 Aug 2002 14:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319105AbSHMS2O>; Tue, 13 Aug 2002 14:28:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41179 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319104AbSHMS2M>;
	Tue, 13 Aug 2002 14:28:12 -0400
Date: Tue, 13 Aug 2002 20:32:06 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [patch] CLONE_SETTLS, CLONE_SETTID, 2.5.31-BK
In-Reply-To: <Pine.LNX.4.44.0208130916280.7291-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132025530.6752-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


okay, the attached patch gets rid of clone_startup() and adds two new
clone() flags instead:

    CLONE_SETTLS => if present then the third clone() syscall parameter
                    is the new TLS.

    CLONE_SETTID => if present then the child TID is written to the
                    address specified by the fourth clone() parameter.

the new parameters are handled in a safe way, clone() returns -EFAULT or
-EINVAL if there's some problem with them.

No current code is affected by these new flags. Patch was testbooted on
2.5.31-BK-current.

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Tue Aug 13 20:10:25 2002
+++ linux/arch/i386/kernel/process.c	Tue Aug 13 20:30:11 2002
@@ -559,6 +559,7 @@
 	unsigned long unused,
 	struct task_struct * p, struct pt_regs * regs)
 {
+	struct thread_struct *t = &p->thread;
 	struct pt_regs * childregs;
 	struct task_struct *tsk;
 
@@ -567,17 +568,45 @@
 	childregs->eax = 0;
 	childregs->esp = esp;
 
-	p->thread.esp = (unsigned long) childregs;
-	p->thread.esp0 = (unsigned long) (childregs+1);
+	t->esp = (unsigned long) childregs;
+	t->esp0 = (unsigned long) (childregs+1);
+	t->eip = (unsigned long) ret_from_fork;
 
-	p->thread.eip = (unsigned long) ret_from_fork;
-
-	savesegment(fs,p->thread.fs);
-	savesegment(gs,p->thread.gs);
+	savesegment(fs, t->fs);
+	savesegment(gs, t->gs);
 
 	tsk = current;
 	unlazy_fpu(tsk);
-	struct_cpy(&p->thread.i387, &tsk->thread.i387);
+	struct_cpy(&t->i387, &tsk->thread.i387);
+
+	/*
+	 * Set a new TLS for the child thread?
+	 */
+	if (clone_flags & CLONE_SETTLS) {
+		struct desc_struct *desc;
+		struct user_desc info;
+		int idx;
+
+		if (copy_from_user(&info, (void *)childregs->esi, sizeof(info)))
+			return -EFAULT;
+		if (LDT_empty(&info))
+			return -EINVAL;
+
+		idx = info.entry_number;
+		if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+			return -EINVAL;
+
+		desc = t->tls_array + idx - GDT_ENTRY_TLS_MIN;
+		desc->a = LDT_entry_a(&info);
+		desc->b = LDT_entry_b(&info);
+	}
+
+	/*
+	 * Notify the child of the TID?
+	 */
+	if (clone_flags & CLONE_SETTLS)
+		if (put_user(p->pid, (pid_t *)childregs->edx))
+			return -EFAULT;
 
 	if (unlikely(NULL != tsk->thread.ts_io_bitmap)) {
 		p->thread.ts_io_bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
@@ -747,8 +776,7 @@
 asmlinkage int sys_clone(struct pt_regs regs)
 {
 	struct task_struct *p;
-	unsigned long clone_flags;
-	unsigned long newsp;
+	unsigned long clone_flags, newsp;
 
 	clone_flags = regs.ebx;
 	newsp = regs.ecx;
--- linux/include/linux/sched.h.orig	Tue Aug 13 19:55:06 2002
+++ linux/include/linux/sched.h	Tue Aug 13 20:27:23 2002
@@ -45,6 +45,8 @@
 #define CLONE_THREAD	0x00010000	/* Same thread group? */
 #define CLONE_NEWNS	0x00020000	/* New namespace group? */
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
+#define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
+#define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 


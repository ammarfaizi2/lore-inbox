Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTBIMGB>; Sun, 9 Feb 2003 07:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTBIMEA>; Sun, 9 Feb 2003 07:04:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56976 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267256AbTBIMC5>;
	Sun, 9 Feb 2003 07:02:57 -0500
Date: Sun, 9 Feb 2003 13:18:16 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <200302091156.h19BuoH07869@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302091305180.5085-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Feb 2003, Roland McGrath wrote:

> >  - session-IDs and group-IDs are set outside the tasklist lock. This
> >    causes breakage in the USB code. The correct fix is to do this:
> 
> This is outside the part of the code that I've touched lately.

yes, i introduced the bug with the new pidhash. Here's the fix, against
BK-curr.

	Ingo

--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -503,6 +503,8 @@
 extern struct   mm_struct init_mm;
 
 extern struct task_struct *find_task_by_pid(int pid);
+extern void set_special_pids(pid_t session, pid_t pgrp);
+extern void __set_special_pids(pid_t session, pid_t pgrp);
 
 /* per-UID process charging. */
 extern struct user_struct * alloc_uid(uid_t);
--- linux/fs/jffs/intrep.c.orig	
+++ linux/fs/jffs/intrep.c	
@@ -3344,8 +3344,7 @@
 	lock_kernel();
 	exit_mm(c->gc_task);
 
-	current->session = 1;
-	current->pgrp = 1;
+	set_special_pids(1, 1);
 	init_completion(&c->gc_thread_comp); /* barrier */ 
 	spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
--- linux/kernel/exit.c.orig	
+++ linux/kernel/exit.c	
@@ -254,6 +254,29 @@
 	write_unlock_irq(&tasklist_lock);
 }
 
+void __set_special_pids(pid_t session, pid_t pgrp)
+{
+	struct task_struct *curr = current;
+
+	if (curr->session != session) {
+		detach_pid(curr, PIDTYPE_SID);
+		curr->session = session;
+		attach_pid(curr, PIDTYPE_SID, session);
+	}
+	if (curr->pgrp != pgrp) {
+		detach_pid(curr, PIDTYPE_PGID);
+		curr->pgrp = pgrp;
+		attach_pid(curr, PIDTYPE_PGID, pgrp);
+	}
+}
+
+void set_special_pids(pid_t session, pid_t pgrp)
+{
+	write_lock_irq(&tasklist_lock);
+	__set_special_pids(session, pgrp);
+	write_unlock_irq(&tasklist_lock);
+}
+
 /*
  *	Put all the gunge required to become a kernel thread without
  *	attached user resources in one place where it belongs.
@@ -271,8 +294,7 @@
 	 */
 	exit_mm(current);
 
-	current->session = 1;
-	current->pgrp = 1;
+	set_special_pids(1, 1);
 	current->tty = NULL;
 
 	/* Become as one with the init task */
--- linux/kernel/kmod.c.orig	
+++ linux/kernel/kmod.c	
@@ -100,8 +100,7 @@
 	int i;
 	struct task_struct *curtask = current;
 
-	curtask->session = 1;
-	curtask->pgrp = 1;
+	set_special_pids(1, 1);
 
 	use_init_fs_context();
 
--- linux/kernel/sys.c.orig	
+++ linux/kernel/sys.c	
@@ -1021,16 +1021,7 @@
 		goto out;
 
 	current->leader = 1;
-	if (current->session != current->pid) {
-		detach_pid(current, PIDTYPE_SID);
-		current->session = current->pid;
-		attach_pid(current, PIDTYPE_SID, current->pid);
-	}
-	if (current->pgrp != current->pid) {
-		detach_pid(current, PIDTYPE_PGID);
-		current->pgrp = current->pid;
-		attach_pid(current, PIDTYPE_PGID, current->pid);
-	}
+	__set_special_pids(current->pid, current->pid);
 	current->tty = NULL;
 	current->tty_old_pgrp = 0;
 	err = current->pgrp;


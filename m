Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSIOJCi>; Sun, 15 Sep 2002 05:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSIOJCi>; Sun, 15 Sep 2002 05:02:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7558 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317980AbSIOJCh>;
	Sun, 15 Sep 2002 05:02:37 -0400
Date: Sun, 15 Sep 2002 11:12:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] exit-thread-2.5.34-A0, BK-curr
Message-ID: <Pine.LNX.4.44.0209151103100.29356-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch optimizes sys_exit_group() to only take the siglock if
it's a true thread group. Boots & works fine.

	Ingo

--- linux/kernel/exit.c.orig	Sun Sep 15 10:59:15 2002
+++ linux/kernel/exit.c	Sun Sep 15 11:02:21 2002
@@ -681,21 +681,25 @@
  */
 asmlinkage long sys_exit_group(int error_code)
 {
-	struct signal_struct *sig = current->sig;
+	unsigned int exit_code = (error_code & 0xff) << 8;
 
-	spin_lock_irq(&sig->siglock);
-	if (sig->group_exit) {
-		spin_unlock_irq(&sig->siglock);
+	if (!list_empty(&current->thread_group)) {
+		struct signal_struct *sig = current->sig;
+
+		spin_lock_irq(&sig->siglock);
+		if (sig->group_exit) {
+			spin_unlock_irq(&sig->siglock);
 
-		/* another thread was faster: */
-		do_exit(sig->group_exit_code);
+			/* another thread was faster: */
+			do_exit(sig->group_exit_code);
+		}
+		sig->group_exit = 1;
+		sig->group_exit_code = exit_code;
+		__broadcast_thread_group(current, SIGKILL);
+		spin_unlock_irq(&sig->siglock);
 	}
-	sig->group_exit = 1;
-	sig->group_exit_code = (error_code & 0xff) << 8;
-	__broadcast_thread_group(current, SIGKILL);
-	spin_unlock_irq(&sig->siglock);
 
-	do_exit(sig->group_exit_code);
+	do_exit(exit_code);
 }
 
 static int eligible_child(pid_t pid, int options, task_t *p)


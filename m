Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261991AbSI3Jzh>; Mon, 30 Sep 2002 05:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261992AbSI3Jzh>; Mon, 30 Sep 2002 05:55:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36030 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261991AbSI3Jzg>;
	Mon, 30 Sep 2002 05:55:36 -0400
Date: Mon, 30 Sep 2002 12:10:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sigfix-2.5.39-D0, BK-curr
Message-ID: <Pine.LNX.4.44.0209301204200.16140-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes a procfs crash noticed by Anton Blanchard.

The procfs code can have a reference even to an already exited task, so it
needs to follow special rules accessing p->sig. The atomic-signals patch
made this bug happen at a much higher frequency, but procfs i believe was
buggy ever since, it potentially used the freed signal structure - which
just did not result in a crash like it does today.

The proper fix is to take the tasklist read-lock in
collect_sigign_sigcatch(), this excludes __exit_sighand() freeing the
signal structure prematurely.

	Ingo

--- linux/fs/proc/array.c.orig	Mon Sep 30 09:06:16 2002
+++ linux/fs/proc/array.c	Mon Sep 30 09:06:43 2002
@@ -228,8 +228,9 @@
 	sigemptyset(ign);
 	sigemptyset(catch);
 
-	spin_lock_irq(&p->sig->siglock);
+	read_lock(&tasklist_lock);
 	if (p->sig) {
+		spin_lock_irq(&p->sig->siglock);
 		k = p->sig->action;
 		for (i = 1; i <= _NSIG; ++i, ++k) {
 			if (k->sa.sa_handler == SIG_IGN)
@@ -237,8 +238,9 @@
 			else if (k->sa.sa_handler != SIG_DFL)
 				sigaddset(catch, i);
 		}
+		spin_unlock_irq(&p->sig->siglock);
 	}
-	spin_unlock_irq(&p->sig->siglock);
+	read_unlock(&tasklist_lock);
 }
 
 static inline char * task_sig(struct task_struct *p, char *buffer)


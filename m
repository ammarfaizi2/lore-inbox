Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319833AbSINKQM>; Sat, 14 Sep 2002 06:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319863AbSINKQM>; Sat, 14 Sep 2002 06:16:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35300 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319833AbSINKQK>;
	Sat, 14 Sep 2002 06:16:10 -0400
Date: Sat, 14 Sep 2002 12:27:27 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sys_exit() threading improvements, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209131207510.672-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209141226360.16829-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) fixes the Mozilla SMP lockup in the
exit path.

	Ingo

--- linux/kernel/signal.c.orig	Sat Sep 14 11:25:30 2002
+++ linux/kernel/signal.c	Sat Sep 14 11:42:29 2002
@@ -280,10 +284,12 @@
 		if (atomic_read(&sig->count) == 1 &&
 					leader->state == TASK_ZOMBIE) {
 			__remove_thread_group(tsk, sig);
+			spin_unlock(&sig->siglock);
 			do_notify_parent(leader, leader->exit_signal);
-		} else
+		} else {
 			__remove_thread_group(tsk, sig);
-		spin_unlock(&sig->siglock);
+			spin_unlock(&sig->siglock);
+		}
 	}
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
 	flush_sigqueue(&tsk->pending);


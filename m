Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269096AbTBXCuw>; Sun, 23 Feb 2003 21:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269095AbTBXCtF>; Sun, 23 Feb 2003 21:49:05 -0500
Received: from dp.samba.org ([66.70.73.150]:49354 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269023AbTBXCsz>;
	Sun, 23 Feb 2003 21:48:55 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [BUG] 2.5.62 kmod rewrite broke modprobe's install command 
In-reply-to: Your message of "Sun, 23 Feb 2003 14:00:04 BST."
             <200302231300.h1ND04Ch008890@harpo.it.uu.se> 
Date: Mon, 24 Feb 2003 13:52:18 +1100
Message-Id: <20030224025907.BCA452C274@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200302231300.h1ND04Ch008890@harpo.it.uu.se> you write:
> The reason this happens is that in 2.5.62, modprobe is started
> with SIGCHLD set to SIG_IGN and not blocked. The "install"
> command is run by system(), but due to SIGCHLD being SIG_IGN,
> the child (which terminates quickly) is reaped automatically.
> The parent process (modprobe) does a wait or waitpid, which fails
> with ECHILD since the child is already gone. system() returns -1,
> and modprobe logs a fatal error.

Yes.  Fixed below.

Thanks for the report!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Enable signals for usermode helpers
Author: Linus Torvalds
Status: Experimental

D: Stelian Pop reported that all signals are blocked in processes
D: execed from the kernel as usermode helpers.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.62-bk6/kernel/kmod.c working-2.5.62-bk6-usermode-sig/kernel/kmod.c
--- linux-2.5.62-bk6/kernel/kmod.c	2003-02-18 11:18:57.000000000 +1100
+++ working-2.5.62-bk6-usermode-sig/kernel/kmod.c	2003-02-24 12:18:55.000000000 +1100
@@ -152,6 +152,14 @@ static int ____call_usermodehelper(void 
 	struct subprocess_info *sub_info = data;
 	int retval;
 
+	/* Unblock all signals. */
+	flush_signals(curtask);
+	flush_signal_handlers(curtask);
+	spin_lock_irq(&curtask->sighand->siglock);
+	sigemptyset(&curtask->blocked);
+	recalc_sigpending();
+	spin_unlock_irq(&curtask->sighand->siglock);
+
 	retval = -EPERM;
 	if (current->fs->root)
 		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);

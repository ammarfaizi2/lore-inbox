Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTBXMs7>; Mon, 24 Feb 2003 07:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTBXMs7>; Mon, 24 Feb 2003 07:48:59 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:12988 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S266615AbTBXMs6>;
	Mon, 24 Feb 2003 07:48:58 -0500
Date: Mon, 24 Feb 2003 13:58:48 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200302241258.h1OCwmSs013918@harpo.it.uu.se>
To: rusty@rustcorp.com.au
Subject: Re: [BUG] 2.5.62 kmod rewrite broke modprobe's install command
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003 13:52:18 +1100, Rusty Russell wrote:
>--- linux-2.5.62-bk6/kernel/kmod.c	2003-02-18 11:18:57.000000000 +1100
>+++ working-2.5.62-bk6-usermode-sig/kernel/kmod.c	2003-02-24 12:18:55.000000000 +1100
>@@ -152,6 +152,14 @@ static int ____call_usermodehelper(void 
> 	struct subprocess_info *sub_info = data;
> 	int retval;
> 
>+	/* Unblock all signals. */
>+	flush_signals(curtask);
>+	flush_signal_handlers(curtask);
>+	spin_lock_irq(&curtask->sighand->siglock);
>+	sigemptyset(&curtask->blocked);
>+	recalc_sigpending();
>+	spin_unlock_irq(&curtask->sighand->siglock);
>+
> 	retval = -EPERM;
> 	if (current->fs->root)
> 		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
>

Doesn't compile (curtask undeclared) and doesn't work (SIGCHLD is
still SIG_IGN causing system() to fail). The problem is that
kernel/workqueue.c:worker_thread() [which is what runs modprobe now]
sets SIGCHLD to SIG_IGN, and your patch doesn't unbreak that.

The patch below, applied on top of your patch, makes it work for me.

/Mikael

--- linux-2.5.62/kernel/kmod.c.~2~	2003-02-24 12:39:01.000000000 +0100
+++ linux-2.5.62/kernel/kmod.c	2003-02-24 13:27:51.000000000 +0100
@@ -150,10 +150,12 @@
 static int ____call_usermodehelper(void *data)
 {
 	struct subprocess_info *sub_info = data;
+	struct task_struct *curtask = current;
 	int retval;
 
 	/* Unblock all signals. */
 	flush_signals(curtask);
+	curtask->sighand->action[SIGCHLD-1].sa.sa_handler = SIG_DFL;
 	flush_signal_handlers(curtask);
 	spin_lock_irq(&curtask->sighand->siglock);
 	sigemptyset(&curtask->blocked);

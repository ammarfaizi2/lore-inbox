Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263473AbTDSVXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 17:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbTDSVXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 17:23:19 -0400
Received: from [12.47.58.203] ([12.47.58.203]:28884 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263473AbTDSVXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 17:23:17 -0400
Date: Sat, 19 Apr 2003 14:35:19 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Private namespaces
Message-Id: <20030419143519.09289af0.akpm@digeo.com>
In-Reply-To: <20030419162147.GB19740@win.tue.nl>
References: <1052141040.355.12.camel@labunix>
	<20030416132324.GA18700@win.tue.nl>
	<20030419145239.GL29143@iucha.net>
	<20030419162147.GB19740@win.tue.nl>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2003 21:35:09.0999 (UTC) FILETIME=[8D8D13F0:01C306BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> Now you ask: but why ENOMEM?
> That is a tiny flaw in the kernel source.

That code's all fairly careless with its return values, isn't it?

How does this look?


 kernel/fork.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff -puN kernel/fork.c~clone-retval-fix kernel/fork.c
--- 25/kernel/fork.c~clone-retval-fix	2003-04-19 14:28:05.000000000 -0700
+++ 25-akpm/kernel/fork.c	2003-04-19 14:31:26.000000000 -0700
@@ -568,7 +568,7 @@ static inline int copy_fs(unsigned long 
 	}
 	tsk->fs = __copy_fs_struct(current->fs);
 	if (!tsk->fs)
-		return -1;
+		return -ENOMEM;
 	return 0;
 }
 
@@ -703,7 +703,7 @@ static inline int copy_sighand(unsigned 
 	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
 	tsk->sighand = sig;
 	if (!sig)
-		return -1;
+		return -ENOMEM;
 	spin_lock_init(&sig->siglock);
 	atomic_set(&sig->count, 1);
 	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
@@ -721,7 +721,7 @@ static inline int copy_signal(unsigned l
 	sig = kmem_cache_alloc(signal_cachep, GFP_KERNEL);
 	tsk->signal = sig;
 	if (!sig)
-		return -1;
+		return -ENOMEM;
 	atomic_set(&sig->count, 1);
 	sig->group_exit = 0;
 	sig->group_exit_code = 0;
@@ -866,23 +866,22 @@ static struct task_struct *copy_process(
 	p->security = NULL;
 	p->as_io_context = NULL;
 
-	retval = -ENOMEM;
-	if (security_task_alloc(p))
+	if ((retval = security_task_alloc(p)))
 		goto bad_fork_cleanup;
 	/* copy all the process information */
-	if (copy_semundo(clone_flags, p))
+	if ((retval = copy_semundo(clone_flags, p)))
 		goto bad_fork_cleanup_security;
-	if (copy_files(clone_flags, p))
+	if ((retval = copy_files(clone_flags, p)))
 		goto bad_fork_cleanup_semundo;
-	if (copy_fs(clone_flags, p))
+	if ((retval = copy_fs(clone_flags, p)))
 		goto bad_fork_cleanup_files;
-	if (copy_sighand(clone_flags, p))
+	if ((retval = copy_sighand(clone_flags, p)))
 		goto bad_fork_cleanup_fs;
-	if (copy_signal(clone_flags, p))
+	if ((retval = copy_signal(clone_flags, p)))
 		goto bad_fork_cleanup_sighand;
-	if (copy_mm(clone_flags, p))
+	if ((retval = copy_mm(clone_flags, p)))
 		goto bad_fork_cleanup_signal;
-	if (copy_namespace(clone_flags, p))
+	if ((retval = copy_namespace(clone_flags, p)))
 		goto bad_fork_cleanup_mm;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)

_


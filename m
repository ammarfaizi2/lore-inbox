Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUF3GJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUF3GJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUF3GJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:09:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:55780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266566AbUF3GJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:09:05 -0400
Date: Tue, 29 Jun 2004 23:08:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: zombie with CLONE_THREAD
Message-Id: <20040629230804.3e9ed144.akpm@osdl.org>
In-Reply-To: <20040630060016.GP13406@dualathlon.random>
References: <20040630060016.GP13406@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Hello,
> 
> I debugged a problem with CLONE_THREAD under strace generating zombies
> that cannot be reaped by init.
> 
> Basically what's going on is that release_task is never called on the
> clones, and in turn the parent thread will remain zombie forever because
> thread_group_empty == 0 (it never notifies init). the group can become
> empty only after release_task has been called on all the clones.
> 
> What's going on is that if the clone happen to be under strace by the
> time it exits its state will not be set to TASK_DEAD and nobody will
> ever call wait4 on the clone because the parent is being killed at the
> same time. But the parent cannot go away until the clone goes away too.
> I believe strace needs as well a little race where it has the sigchld
> disabled but what I'm discussing here is still a kernel bug generating
> zombie threads.
> 
> I think I could have fixed even with a strictier patch (adding a
> exit_signal == -1 check just to cover that case), but I believe that it
> makes no sense to leave ptrace enabled on a clone that is being killed,
> it happens to be safe without a thread-group just because there will be
> always init able to call wait4->release_task on it, that will call
> ptrace_unlink later in release_task, same goes for the "leader" of the
> thread group, that as well can be detached by ptrace via release_task).
> 
> so far this thing worked fine in practice. Would be nice to hear a
> comment from somebody who understand this CLONE_THREAD signal
> mess^Wstuff with ptrace better.

Maybe Linus or Roland could comment.

> --- sles/kernel/exit.c.~1~	2004-06-30 01:41:58.000000000 +0200
> +++ sles/kernel/exit.c	2004-06-30 07:49:21.705154000 +0200
> @@ -734,6 +734,13 @@ static void exit_notify(struct task_stru
>  		do_notify_parent(tsk, SIGCHLD);
>  	}
>  
> +	/*
> +	 * To allow the group leader of a thread group to be released
> +	 * we must really go away synchronously if exit_signal == -1.
> +	 */
> +	if (unlikely(tsk->ptrace) && tsk != tsk->group_leader)
> +		__ptrace_unlink(tsk);
> +

Should this be using thread_group_leader()?

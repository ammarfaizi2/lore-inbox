Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVF1HMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVF1HMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVF1HLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:11:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42680 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261878AbVF1HI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:08:27 -0400
Date: Tue, 28 Jun 2005 00:08:15 -0700
Message-Id: <200506280708.j5S78FtD027410@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
X-Fcc: ~/Mail/linus
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: eliminate unneccessary sighand locking
In-Reply-To: Ingo Molnar's message of  Tuesday, 28 June 2005 08:42:09 +0200 <20050628064209.GA29540@elte.hu>
Emacs: a learning curve that you can use as a plumb line.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i have checked it when acking the patch and it does not seem we do that 
> anywhere in the kernel. It would also be dangerous as per Oleg's 
> observations, unless something like this is done:
> 
> 	read_lock(&tasklist_lock);
> 	p = find_task_by_pid(pid);
> 	task_lock(p);
> 	spin_lock(&p->sighand->siglock);
> 	read_unlock(&tasklist_lock);
> 
> 	...
> 
> do you know any such code?

I was thinking it would look more like:

 	read_lock(&tasklist_lock);
 	p = find_task_by_pid(pid);
 	get_task_struct(p);
 	read_unlock(&tasklist_lock);
	...
	spin_lock_irq(&p->sighand->siglock);
	...

I am not sure whether such code exists or not.  It won't look quite like
that, in that the siglock use may be far away from the extraction.  There
are things that store pointers like that (like real_timer.data, and
posix_timers stuff).  But it may well be that all those places take
tasklist_lock before using the saved task_struct, in which case it's fine.
(Anything doing signals stuff usually needs tasklist_lock anyway in case it
has to traverse the thread group.)

> i have manually reviewed every .[ch] file that uses tasklist_lock, 
> siglock and lock_task:
> 
>   fs/proc/array.c
>   fs/exec.c
>   kernel/ptrace.c
>   kernel/fork.c
>   kernel/exit.c
>   kernel/sys.c
>   include/linux/sched.h
>   security/selinux/hooks.c
> 
> can other valid locking variations exist, other than the one i outlined 
> above?

You mean those are the files that use all three of those, or what?  That's
clearly not the complete list of siglock uses.  Any code using siglock
needs to be grokked adequately to see if tasklist_lock is always held
around looking at ->sighand.


Thanks,
Roland

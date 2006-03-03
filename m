Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWCCMDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWCCMDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 07:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWCCMDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 07:03:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50585 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750908AbWCCMDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 07:03:46 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: efault@gmx.de, nickpiggin@yahoo.com.au, laurent.riffard@free.fr,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       mbligh@mbligh.org, clameter@engr.sgi.com, pj@sgi.com
Subject: Re: [PATCH] proc: Use sane permission checks on the /proc/<pid>/fd/
 symlinks.
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr> <20060301023235.735c8c47.akpm@osdl.org>
	<1141221511.7775.10.camel@homer> <4405B4AA.7090207@free.fr>
	<1141227199.10460.2.camel@homer>
	<20060301121218.68fb3f76.akpm@osdl.org>
	<m1u0agkdkh.fsf_-_@ebiederm.dsl.xmission.com>
	<20060303004942.3b96a8ae.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 03 Mar 2006 05:00:09 -0700
In-Reply-To: <20060303004942.3b96a8ae.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 3 Mar 2006 00:49:42 -0800")
Message-ID: <m1y7zrg2ly.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> With all your latest patches I get a big spew lateish in the boot:
>
> Reverting just this patch prevents the above.
>
> This is with basically unaltered FC5 as of a few days ago.  The audit
> patches weren't applied.
>
> What is happening is that both `current' and get_proc_task(inode) are the
> same task_struct: `restorecon' is trying to read its own proc files.  But
> ptrace_may_attach()->security_ptrace() is returning -EACCES.
>
> So I bodged it in the obvious manner:

Ugh.  Unless I am misreading the code we have the exact same problem
with /proc/self/mem.  Which uses a stricter form of the same test.

> btw, it's surprising (to me) that security_ptrace(t1, t2) fails when
> t1==t2?

Same here.  ptrace_attach explicitly denies that case but that happens
outside of ptrace_may_attach to allow for the /proc usage.

> --- devel/fs/proc/base.c~proc-use-sane-permission-checks-on-the-proc-pid-fd-fix
> 2006-03-03 00:38:17.000000000 -0800
> +++ devel-akpm/fs/proc/base.c	2006-03-03 00:43:54.000000000 -0800
> @@ -521,8 +521,11 @@ static int proc_fd_access_allowed(struct
>  	 * allow access if we have the proper capability.
>  	 */
>  	task = get_proc_task(inode);
> -	if (task) {
> +	if (task == current)
> +		allowed = 1;
> +	if (task && !allowed) {
>  		int alive;
> +
>  		task_lock(task);
>  		alive = !!task->mm;
>  		task_unlock(task);
>
> And the messages went away.

Agreed.  Examining your self should always be valid.

I suspect this check get put in ptrace_may_attach, so we can always
read /proc/self/mem.

> But I have a bad feeling about these /proc permission changes, Eric.  I
> suspect we'll be chasing a gradually decreasing frequency of weird problems
> for a long time.

You may be right, but even if that is the case I think it is worth it.
The old checks were bizarre if not outright wrong.  And cause their
own share of weird cases when you start using things like namespaces.

The checks unify the two cases where we allow violating a tasks
privacy.  Which is an important case to get right, and unification
of permissions means it is easier to administer if you don't want
someone doing that.

/proc and ptrace have had a connection since at least 2.0 so this
is nothing new.  So if by using this on more than just /proc/<pid>/mem
I increase the frequency of usage and thus increase the frequency
of problem detection I think it is a good thing.

I think it is actually surprising no one noticed how bogus the
permissions on /proc/<pid>/fd/<fd#> have been, especially the people
concerned with security.

> That task_lock() you have in proc_fd_access_allowed() looks very fishy,
> btw.  As soon as the lock is dropped, local `alive' becomes meaningless. 
> Either that, or the lock wasn't needed.

Agreed.  That does look a fishy. 

I also spotted an outright bug. put_task_struct does not work on a
NULL pointer. Duh.

Sorry I obviously didn't switch levels very well when auditing that
code.

I will send in a patch to clean up those bits.

Eric



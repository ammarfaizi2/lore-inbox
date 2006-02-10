Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWBJU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWBJU3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWBJU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:29:54 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:41364 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932176AbWBJU3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:29:53 -0500
Message-ID: <43ECF803.8080404@sw.ru>
Date: Fri, 10 Feb 2006 23:30:59 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process
 id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

All my commments are inline below.

> This patch modifies the fork/exit, signal handling, and pid and
> process group manipulating syscalls to support multiple process
> spaces, and implements the data for allow multiple instaces of the pid
> namespace. 

[ ... skipped .... ]

> +extern struct pspace init_pspace;
> +
> +#define INVALID_PID 0x7fffffff
<<<< what is it for?

> +
> +static inline int pspace_task_visible(struct pspace *pspace, struct task_struct *tsk)
> +{
> +	return (tsk->pspace == pspace) || 
> +		((tsk->pspace->child_reaper.pspace == pspace) &&
> +		 (tsk->pspace->child_reaper.task == tsk));
<<< the logic with child_reaper which can be somehow partly inside 
pspace... and this check is not that abvious.

Actually I can't say your patch is cleaner somehow.
It is very big and most of the changes are trivial, which creates an 
illusion that it is straightforward and clean.

[ ... skipped .... ]

> @@ -788,6 +801,16 @@ fastcall NORET_TYPE void do_exit(long co
>  		panic("Attempted to kill the idle task!");
>  	if (unlikely(is_init(tsk)))
>  		panic("Attempted to kill init!");
> +
> +	/*
> +	 * If we are the pspace leader it is nonsense for the pspace
> +	 * to continue so kill everyone else in the pspace.
> +	 */
> +	if (pspace_leader(tsk)) {
> +		tsk->pspace->flags = PSPACE_EXIT;
> +		kill_pspace_info(SIGKILL, (void *)1, tsk->pspace);
> +	}
> +
<<<<

1.
flags are neither atomic nor protected with any lock.
So if it will be used later for something else in future, there will be 
100% race. You also assigns them here, while everywhere in other places 
a bit is checked.

2. due to 1) you code is buggy. in this respect do_exit() is not 
serialized with copy_process().

3. due to the same 1) reason
 > +		kill_pspace_info(SIGKILL, (void *)1, tsk->pspace);
can miss a task being forked. Bang!!!

4.
So you are effectively inserting a code for cleaning up pspace here and 
the same is actually required for other subsystems like networking/IPC etc.
I think you suppose that other resources are freed when the last 
reference is dropped, but to tell the truth this is a way to deadlocks. 
Because refs are put in too many places, where you can't make a real 
cleanup due to locking etc. You can't for example call syncronize_net() 
from bh, which is required for network cleanup.

Just an another argument why containers are easier/better and why you 
will eventually end up with it.

>  	if (tsk->io_context)
>  		exit_io_context();
>  

[ ... skipped ... ]

> @@ -1147,11 +1150,55 @@ retry:
>  }
>  
>  /*
> + * kill_pspace_info() sends a signal to all processes in a process space.
> + * This is what kill(-1, sig) does.
> + */
> +
> +int __kill_pspace_info(int sig, struct siginfo *info, struct pspace *pspace)
> +{
> +	struct task_struct *p = NULL;
> +	int retval = 0, count = 0;
> +
> +	for_each_process(p) {
> +		int err;
> +		/* Skip the current pspace leader */
> +		if (current_pspace_leader(p))
> +			continue;
> +
> +		/* Skip the sender of the signal */
> +		if (p->signal == current->signal)
> +			continue;
> +
> +		/* Skip processes outside the target process space */
> +		if (!in_pspace(pspace, p))
> +			continue;
> +
> +		/* Finally it is a good process send the signal. */
> +		err = group_send_sig_info(sig, info, p);
> +		++count;
> +		if (err != -EPERM)
> +			retval = err;
<<<<
why EPERM is ok?
do you want to miss some tasks?
> +	}
> +	return count ? retval : -ESRCH;
> +}
> +

Thanks,
Kirill


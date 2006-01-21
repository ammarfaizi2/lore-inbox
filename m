Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWAUOnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWAUOnK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 09:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWAUOnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 09:43:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64215 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750769AbWAUOnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 09:43:09 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>
	<20060117143326.283450000@sergelap>
	<1137511972.3005.33.camel@laptopd505.fenrus.org>
	<20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 21 Jan 2006 07:42:27 -0700
In-Reply-To: <43D14578.6060801@watson.ibm.com> (Hubertus Franke's message of
 "Fri, 20 Jan 2006 15:18:00 -0500")
Message-ID: <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> 2nd:
> ====	
> Issue: we don't need pid virtualization, instead simply use <container,pid>
> pair.
>
> This requires a bit more thought. Essentially that's what I was doing, but I
> mangled them into the same pid and using masking to add/remove the
> container for internal use.  As pointed out by Alan(?), we can
> indeed reused the same pid internally many times as long as we can
> distinguish during the pid-to-task_struct lookup. This is easily
> done because, the caller provides the context hence the container for the
> lookup.
>
> Actions: The vpid_to_pid will disappear and the check for whether we
> are in the same container needs to be pushed down into the task
> lookup. question remains to  figure out  whether the context of the
> task lookup (will always remain the caller ?). 

Any place the kernel saves a pid and then proceeds to signal it later.
At that later point in time it is possibly you will be in the wrong
context.

This probably justifies having a kpid_t that has both the process
space id and the pid in it.  For when the kernel is storing pids to
use as weak references, for signal purposes etc.

At least tty_io.c and fcntl.c have examples where you the caller
may not have the proper context.

> Doing so has an implication, namely that we are moving over to "system
> containers". The current implementation requires the vpid/pid only
> for the boundary condition at the top of the container (to rewrite
> pid=1) and its parent and the fact that we wanted a global look
> through container=0. If said boundary would be eliminated and we
> simply make a container a child of the initproc (pid=1), this would
> be unnecessary. 
>
> all together this would provide private namespaces (as just suggested by Eric).
>
> The feeling would be that large parts of patch could be reduce by
> this.

Simplified, and made easier to understand.  I don't know if the number
of lines affected can or should be reduced.  

One of my problems with your current approach is that it doesn't help
identify where you have problems.

I have found a specific example that your current patches get wrong,
because you make assumptions about which context is valid.

>From function kernel/khtread.c
> static void keventd_create_kthread(void *_create)
> {
> 	struct kthread_create_info *create = _create;
> 	int pid;
> 
> 	/* We want our own signal handler (we take no signals by default). */
> 	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
> 	if (pid < 0) {
> 		create->result = ERR_PTR(pid);
> 	} else {
> 		wait_for_completion(&create->started);
> 		create->result = find_task_by_pid(pid);
> 	}
> 	complete(&create->done);
> }

kernel_thread() is a light wrapper around do_fork().
do_fork returns a virtual pid.
find_task_by_pid takes a pid with the upper bits holding the process
   space id.

Therefore if this function or a cousin of it was ever triggered
by a userspace application in a virtual context find_task_by_pid
would fail to find the task structure.

The only way I know to make this change safely is to make compilation
of all functions that manipulate pids in possibly dangerous ways fail.
And then to manually and slowly fix them up.

That way if something is missed.  You get a compile error instead
of incorrect execution.

Eric

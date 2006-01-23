Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWAWSvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWAWSvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWAWSvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:51:03 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33953 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964891AbWAWSvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:51:02 -0500
Message-ID: <43D52592.8080709@watson.ibm.com>
Date: Mon, 23 Jan 2006 13:50:58 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com> <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
> 
> 
> 
> Any place the kernel saves a pid and then proceeds to signal it later.
> At that later point in time it is possibly you will be in the wrong
> context.
> 

Yes, that's possible.. In the current patch that is not a problem, because
the internal pid (aka kpid) == <vpid,containerid>  mangeled together.
So in those cases, the kernel would have to keep <pid, container_id>

> This probably justifies having a kpid_t that has both the process
> space id and the pid in it.  For when the kernel is storing pids to
> use as weak references, for signal purposes etc.
>

An that's what the current patch does. Only thing is we did not rename
everything to kpid_t!

> At least tty_io.c and fcntl.c have examples where you the caller
> may not have the proper context.

Can you point those out directly .. thanks..

> 
> 
>>Doing so has an implication, namely that we are moving over to "system
>>containers". The current implementation requires the vpid/pid only
>>for the boundary condition at the top of the container (to rewrite
>>pid=1) and its parent and the fact that we wanted a global look
>>through container=0. If said boundary would be eliminated and we
>>simply make a container a child of the initproc (pid=1), this would
>>be unnecessary. 
>>
>>all together this would provide private namespaces (as just suggested by Eric).
>>
>>The feeling would be that large parts of patch could be reduce by
>>this.
> 
> 
> Simplified, and made easier to understand.  I don't know if the number
> of lines affected can or should be reduced.

Unless we do it .. we won't know for sure.....

> 
> One of my problems with your current approach is that it doesn't help
> identify where you have problems.
> 
> I have found a specific example that your current patches get wrong,
> because you make assumptions about which context is valid.
> 
> From function kernel/khtread.c
> 
>>static void keventd_create_kthread(void *_create)
>>{
>>	struct kthread_create_info *create = _create;
>>	int pid;
>>
>>	/* We want our own signal handler (we take no signals by default). */
>>	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
>>	if (pid < 0) {
>>		create->result = ERR_PTR(pid);
>>	} else {
>>		wait_for_completion(&create->started);
>>		create->result = find_task_by_pid(pid);
>>	}
>>	complete(&create->done);
>>}
> 

So what we where thinking (and have experimented a bit with) is using
SPARSE for this. Didn't go too far, but is a potential.
Another possibility is to really introduce a pid_t (user perspective)
and a kpid_t (kernel pid <spaceid, pid>) type explicitely.
Then this would be solved.

> 
> kernel_thread() is a light wrapper around do_fork().
> do_fork returns a virtual pid.
> find_task_by_pid takes a pid with the upper bits holding the process
>    space id.
> 
> Therefore if this function or a cousin of it was ever triggered
> by a userspace application in a virtual context find_task_by_pid
> would fail to find the task structure.
> 
> The only way I know to make this change safely is to make compilation
> of all functions that manipulate pids in possibly dangerous ways fail.
> And then to manually and slowly fix them up.

See above (SPARSE or type strictness).
And yes, we internally discussed that, but the changes might be huge
to change all the occurences.
It would be good to know whether going this route will lead us to the
promise land or not.

> 
> That way if something is missed.  You get a compile error instead
> of incorrect execution.


> 
> Eric
> 



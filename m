Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWAVPtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWAVPtx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 10:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWAVPtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 10:49:53 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22246 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751279AbWAVPtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 10:49:52 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
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
	<m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	<CC5052ED-FEC1-4B0C-A8A7-3CD190ADF0D3@mac.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 22 Jan 2006 08:48:41 -0700
In-Reply-To: <CC5052ED-FEC1-4B0C-A8A7-3CD190ADF0D3@mac.com> (Kyle Moffett's
 message of "Sun, 22 Jan 2006 01:43:41 -0500")
Message-ID: <m18xt8mffq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> On Jan 21, 2006, at 09:42, Eric W. Biederman wrote:
>> Hubertus Franke <frankeh@watson.ibm.com> writes:
>>
>>> Actions: The vpid_to_pid will disappear and the check for whether  we are in
>>> the same container needs to be pushed down into the task  lookup. question
>>> remains to  figure out  whether the context of  the task lookup (will always
>>> remain the caller ?).
>>
>> Any place the kernel saves a pid and then proceeds to signal it  later. At
>> that later point in time it is possibly you will be in  the wrong context.
>>
>> This probably justifies having a kpid_t that has both the process
>> space id and the pid in it.  For when the kernel is storing pids to
>> use as weak references, for signal purposes etc.
>
> The kernel should not be saving a PID.  The kernel should be sticking a pointer
> to a struct task_struct somewhere (with appropriate refcounting) and using that.

That has all of the wrong semantics, and simply will not work.

>> The only way I know to make this change safely is to make  compilation of all
>> functions that manipulate pids in possibly  dangerous ways fail. And then to
>> manually and slowly fix them up.
>>
>> That way if something is missed.  You get a compile error instead  of
>> incorrect execution.
>
> I agree.  This is one of the things I really liked about the recent  mutex
> patch; it added a lot of checks to various codepaths to verify  at both compile
> time and run time that the code was correct.

And changing how we handle pids is if anything even more intrusive.
>
> My personal opinion is that we need to add a new race-free API, say
> open("/proc/fork"); that forks a process and returns an open "process  handle",
> essentially a filehandle that references a particular  process.  (Also, an
> open("/proc/self/handle") or something to return  a current-process handle)
> Through some method of signaling the  kernel (syscall, ioctl, some other?) a
> process can send a signal to  the process referenced by the handle, check its
> status, etc.  A  process handle might be passed to other processes using a
> UNIX-domain  socket.  You would be able to dup() a process handle and then
> restrict the set of valid operations on the new process handle, so  that it
> could be passed to another process  without giving that  process access to the
> full set of operations (check status only, not  able to send a signal, for
> example).

Ok. There are 2 sides to this, an internal kernel implementation,
and exporting to user space.  Until we have something inside
the kernel exporting it is silly.

A pointer to a task_struct while it kind of sort of works.  Is not
a good solution.  The problem is that in a lot of cases we register
a pid to get a signal or something similar and then we never unregister
it.  So by using a pointer to a trask_struct you effectively hold the
process in memory forever.

Then there is the second problem.  A pointer to a task_struct is
insufficient.  It does not handle the case of process groups which
are equally important.

Further a task_struct points at a thread not at a process so holding
a pointer to it would not do what you would expect.

Possibly holding a struct pid would be interesting.

> Obviously we would need to maintain support for the old interface for  some
> period of time, but I think the new one would make it much  easier to write
> simple race-free programs.

Well since this is the user space interface we would need to maintain
the old interface for as long as the kernel runs on existing architectures 
or their are user space programs using it.  Even in plan9 they weren't
creative enough to do away with PIDS.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWATUSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWATUSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWATUSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:18:04 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:7065 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932154AbWATUSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:18:03 -0500
Message-ID: <43D14578.6060801@watson.ibm.com>
Date: Fri, 20 Jan 2006 15:18:00 -0500
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
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain> <m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
> 
> 
>>On Tue, 2006-01-17 at 20:55 -0800, Greg KH wrote:
>>
>>>On Tue, Jan 17, 2006 at 09:25:14AM -0800, Dave Hansen wrote:
>>>
>>>>Arjan had a very good point last time we posted these: we should
>>>>consider getting rid of as many places in the kernel where pids are used
>>>>to uniquely identify tasks, and just stick with task_struct pointers.  
>>>
>>>That's a very good idea, why didn't you do that?
>>
>>Because we were being stupid and shoudn't have posted this massive set
>>of patches to LKML again before addressing the comments we got last
>>time, or doing _anything_ new with them.
> 
> 
> Actually a little progress has been made.  I think the patch set
> continues to the point of usability this time or at least is close.
> 
> Although it feels like there are still some gaps when I read through
> it.
> 
> Eric
> 

Let me just summarize the discussion that has taken place so far
and the consequences I/we seem to be drawing out of it.

We discussed the various approaches that are floating around now, enough
has been said about each, so I leave it at that ...
(a) GLIBC intercept LD_PRELOAD	
(b) Binary Rewrite of glibc
(c) syscall table intercept		(see ZAP)
(d) vpid approach			(see "IBM" patches posted)
(e) <pid,container> approach 		(see below, suggested by Alan?.. )

There are several issues that came up in the email exchange ( Arjen, Alan Cox, .. ).
[ Please feel free to tell me if I/we captured or misinterpregin these wrong ]

1st:	
====
Issue: we don't need all the task_pid() etc functions just stick to what
it was  task->pid !

Consens: It seems consensus is forming on that ..
Actions: remove the patches 1-12/34  and adopt the rest straight forward

2nd:
====	
Issue: we don't need pid virtualization, instead simply use <container,pid> pair.

This requires a bit more thought. Essentially that's what I was doing, but I mangled
them into the same pid and using masking to add/remove the container for internal use.
As pointed out by Alan(?), we can indeed reused the same pid internally many times
as long as we can distinguish during the pid-to-task_struct lookup. This is easily
done because, the caller provides the context hence the container for the lookup.

Actions: The vpid_to_pid will disappear and the check for whether we are in the same
container needs to be pushed down into the task lookup. question remains to figure out
whether the context of the task lookup (will always remain the caller ?).

Doing so has an implication, namely that we are moving over to "system containers".
The current implementation requires the vpid/pid only for the boundary condition at the
top of the container (to rewrite pid=1) and its parent and the fact that we wanted
a global look through container=0.
If said boundary would be eliminated and we simply make a container a child of the
initproc (pid=1), this would be unnecessary.

all together this would provide private namespaces (as just suggested by Eric).

The feeling would be that large parts of patch could be reduce by this.

What we need is a new system calls (similar to vserver) or maybe we can continue
the /proc approach for now...

sys_exec_container(const *char container_name, pid_t pid, unsigned int flags, const *char argv, const *char envp);

exec_container creates a new container (if indicated in flags) and a new task in it that reports to parent initproc.
if a non-zero pid is specified we use that pid, otherwise the system will allocate it. Finally
it create new session id ; chroot and exec's the specified program.

What we loose with this is the session and the tty, which Cedric described as application
container...

The sys_exec_container(...)  seems to be similar to what Eric just called clone_namespace()

-- Hubertus

______________________________________________________


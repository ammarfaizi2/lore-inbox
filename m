Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWAWSit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWAWSit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWAWSit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:38:49 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:8940 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964870AbWAWSit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:38:49 -0500
Message-ID: <43D522B2.5060308@watson.ibm.com>
Date: Mon, 23 Jan 2006 13:38:42 -0500
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
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com> <m1y819naio.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1y819naio.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
> 

> ...
> 
>>Actions: The vpid_to_pid will disappear and the check for whether we are in the
>>same
>>container needs to be pushed down into the task lookup. question remains to
>>figure out
>>whether the context of the task lookup (will always remain the caller ?).
> 
> 
> You don't need a same container check.  If something is in another container
> it becomes invisible to you.
> 

Eric, agreed.... that was implied by me (but poorly worded). What I meant (lets try this
again) is that the context defines/provides the namespace in which the lookup
is performed, hence as you say state.. naturally things in different containers
(namespaces) are invisible to you..

> 
>>Doing so has an implication, namely that we are moving over to "system
>>containers".
>>The current implementation requires the vpid/pid only for the boundary condition
>>at the
>>top of the container (to rewrite pid=1) and its parent and the fact that we
>>wanted
>>a global look through container=0.
>>If said boundary would be eliminated and we simply make a container a child of
>>the
>>initproc (pid=1), this would be unnecessary.
>>
>>all together this would provide private namespaces (as just suggested by Eric).
>>
>>The feeling would be that large parts of patch could be reduce by this.
> 
> 
> I concur.  Except I think the initial impact could still be large.
> It may be worth breaking all users of pids just so we audit them.
> 
> But that will certainly result in no long term cost, or runtime overhead.
> 
> 
>>What we need is a new system calls (similar to vserver) or maybe we can continue
>>the /proc approach for now...
>>
>>sys_exec_container(const *char container_name, pid_t pid, unsigned int flags,
>>const *char argv, const *char envp);
>>
>>exec_container creates a new container (if indicated in flags) and a new task in
>>it that reports to parent initproc.
>>if a non-zero pid is specified we use that pid, otherwise the system will
>>allocate it. Finally
>>it create new session id ; chroot and exec's the specified program.
>>
>>What we loose with this is the session and the tty, which Cedric described as
>>application
>>container...
>>
>>The sys_exec_container(...)  seems to be similar to what Eric just called
>>clone_namespace()
> 
> 
> Similar. But I was actually talking about just adding another flag to
> sys_clone the syscall underlying fork().  Basically it is just another
> resource not share or not-share.
> 
> Eric
> 

That's a good idea .. right now we simply did this through a flag left by the call
to the /proc/container fs ... (awkward at best, but didn't break the API).
I have a concern wrt doing it in during fork namely the sharing of resources.
Whe obviously are looking at some constraints here wrt to sharing. We need to
ensure that this ain't a thread etc that will share resources
across "containers" (which then later aren't migratable due to that sharing).
So doing the fork_exec() atomically would avoid that problem.




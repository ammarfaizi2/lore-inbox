Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWAUKZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWAUKZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 05:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWAUKZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 05:25:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64212 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932095AbWAUKZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 05:25:28 -0500
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
Date: Sat, 21 Jan 2006 03:25:03 -0700
In-Reply-To: <43D14578.6060801@watson.ibm.com> (Hubertus Franke's message of
 "Fri, 20 Jan 2006 15:18:00 -0500")
Message-ID: <m1y819naio.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> Eric W. Biederman wrote:

> Let me just summarize the discussion that has taken place so far
> and the consequences I/we seem to be drawing out of it.
>
> We discussed the various approaches that are floating around now, enough
> has been said about each, so I leave it at that ...
> (a) GLIBC intercept LD_PRELOAD	
> (b) Binary Rewrite of glibc
> (c) syscall table intercept		(see ZAP)
> (d) vpid approach			(see "IBM" patches posted)
> (e) <pid,container> approach 		(see below, suggested by Alan?.. )
      That seems to have been an observation of the current patchset.
>
> There are several issues that came up in the email exchange ( Arjen, Alan Cox,
> .. ).
> [ Please feel free to tell me if I/we captured or misinterpregin these wrong ]

...
> Actions: The vpid_to_pid will disappear and the check for whether we are in the
> same
> container needs to be pushed down into the task lookup. question remains to
> figure out
> whether the context of the task lookup (will always remain the caller ?).

You don't need a same container check.  If something is in another container
it becomes invisible to you.

> Doing so has an implication, namely that we are moving over to "system
> containers".
> The current implementation requires the vpid/pid only for the boundary condition
> at the
> top of the container (to rewrite pid=1) and its parent and the fact that we
> wanted
> a global look through container=0.
> If said boundary would be eliminated and we simply make a container a child of
> the
> initproc (pid=1), this would be unnecessary.
>
> all together this would provide private namespaces (as just suggested by Eric).
>
> The feeling would be that large parts of patch could be reduce by this.

I concur.  Except I think the initial impact could still be large.
It may be worth breaking all users of pids just so we audit them.

But that will certainly result in no long term cost, or runtime overhead.

> What we need is a new system calls (similar to vserver) or maybe we can continue
> the /proc approach for now...
>
> sys_exec_container(const *char container_name, pid_t pid, unsigned int flags,
> const *char argv, const *char envp);
>
> exec_container creates a new container (if indicated in flags) and a new task in
> it that reports to parent initproc.
> if a non-zero pid is specified we use that pid, otherwise the system will
> allocate it. Finally
> it create new session id ; chroot and exec's the specified program.
>
> What we loose with this is the session and the tty, which Cedric described as
> application
> container...
>
> The sys_exec_container(...)  seems to be similar to what Eric just called
> clone_namespace()

Similar. But I was actually talking about just adding another flag to
sys_clone the syscall underlying fork().  Basically it is just another
resource not share or not-share.

Eric

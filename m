Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWAXT2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWAXT2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 14:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWAXT2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 14:28:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30619 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030358AbWAXT2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 14:28:03 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
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
	<43D52592.8080709@watson.ibm.com>
	<m1oe22lp69.fsf@ebiederm.dsl.xmission.com>
	<1138050684.24808.29.camel@localhost.localdomain>
	<m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
	<1138062125.24808.47.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 24 Jan 2006 12:26:20 -0700
In-Reply-To: <1138062125.24808.47.camel@localhost.localdomain> (Alan Cox's
 message of "Tue, 24 Jan 2006 00:22:05 +0000")
Message-ID: <m17j8pl95v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Llu, 2006-01-23 at 14:30 -0700, Eric W. Biederman wrote:
>> The short observation is currently we use at most 22bits of the pid
>> space, and we don't need a huge number of containers so combining them
>> into one integer makes sense for an efficient implementation, and it
>> is cheaper than comparing pointers.
>
> Currently. In addition it becomes more costly the moment you have to
> start masking them. Remember the point of this was to virtualise the
> pid, so you are going to add a ton of masking versus a cheap extra
> comparison from the same cache line. And you lose pid space you may well
> need in the future for the sake of a quick hack.

I do disagree that as I am envisioning it will get in the way but I
do agree that putting them in the unsigned long may be overkill.

There is at least NFS lockd that appreciates having a single integer
per process unique identifier.  So there is a practical basis for
wanting such a thing.

At least for this first round I think talking about a kpid
as a container, pid pair makes a lot of sense for the moment, as
the other implementations just confuse things.

>> And there will be at least one processes id assigned to the pid space
>> from the outside pid space unless we choose to break waitpid, and friends.
>
> That comes out in the wash because it is already done by process tree
> pointers anyway. It has to be because using ->ppid would be racy.

Possibly.  Again, it is one of the more interesting cases, to get
just right.

However it looks to me that the biggest challenge right now about
development is the size of a patch to change any one of these things.
So it looks to me like the first step is to add wrappers for common idioms
that use pids, like printing the name of a task or testing if it is the
init task or if it is an idle task.

Or can you think of a case where it would be wise to leave
both the type and size of current->pid alone?

Eric

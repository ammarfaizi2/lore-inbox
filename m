Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWHPOYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWHPOYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWHPOYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:24:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47808 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750988AbWHPOYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:24:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@sw.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, containers@lists.osdl.org,
       linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Containers] [PATCH 6/7] vt: Update spawnpid to be a struct	pid_t
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<1155666193191-git-send-email-ebiederm@xmission.com>
	<1155667982.24077.307.camel@localhost.localdomain>
	<m13bbx96tm.fsf@ebiederm.dsl.xmission.com> <44E2D175.1010506@sw.ru>
Date: Wed, 16 Aug 2006 08:23:26 -0600
In-Reply-To: <44E2D175.1010506@sw.ru> (Kirill Korotaev's message of "Wed, 16
	Aug 2006 12:04:05 +0400")
Message-ID: <m1psf04v4x.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>>
>>>Ar Maw, 2006-08-15 am 12:23 -0600, ysgrifennodd Eric W. Biederman:
>>>
>>>>This keeps the wrong process from being notified if the
>>>>daemon to spawn a new console dies.
>>>
>>>Not sure why we count pids not task structs but within the proposed
>>>implementation this appears correct so
>> Basically struct pid is relatively cheap, 64bytes or so.
>> struct task is expensive 10K or so, when all of the stacks
>> and everything are included.
>> Counting pids allows the task to exit in user space and free up
>> all of it's memory.
>> When /proc used to count the task struct it was fairly easy to
>> deliberately oom a 32bit machine just by open up directories in
>> /proc and then having the process exit.  rlimits didn't help because
>> we don't count processes that have exited.
> hey, hey. your patch doesn't help in this situation (much)!
> inodes and dentries can still consume much memory.
> it just makes the situation a bit better.

It does help.  The size of the locked memory is better and we
account for the used inodes and dentries.  As I recall the inode+dentry
is less than 1k.  The number of open file handle rlimit at least
lets the existing limits work.  The core improvement is not allowing
an escape from our accounting mechanism for one of our biggest data
structures.

> I wonder whether it is easy to have the following done with your implementation:
> container tasks visible from host. theoretically having 2 pids (vpid, pid)
> it should be implementable. Do you see any obstacles?

I seen no problem for having tasks have N pid numbers.  The trick
is to create a hash table entry (struct pid) that when has a pointer
to the real struct pid. It won't be the classic pid,vpid.  All pids
will be equally real.

My intention is to give a process a pid in each namespace that it has
an ancestor in.

> in other regards patches look pretty good. Good job!

Thanks.

Eric


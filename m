Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbTBPSO7>; Sun, 16 Feb 2003 13:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbTBPSO7>; Sun, 16 Feb 2003 13:14:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46097 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267327AbTBPSO6>; Sun, 16 Feb 2003 13:14:58 -0500
Date: Sun, 16 Feb 2003 10:21:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.5.61 oops running SDET
In-Reply-To: <21410000.1045413579@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302161017500.2619-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Martin J. Bligh wrote:
> 
> Right, that's what I expected, and that may well explain the hang, but I 
> don't see how that explains the oops still happening. What exactly is 
> tasklist_lock protecting here anyway?
> 
>         read_lock(&tasklist_lock);
>         buffer += sprintf(buffer,
>                 "State:\t%s\n"
>                 "Tgid:\t%d\n"
>                 "Pid:\t%d\n"
>                 "PPid:\t%d\n"
>                 "TracerPid:\t%d\n"
>                 "Uid:\t%d\t%d\t%d\t%d\n"
>                 "Gid:\t%d\t%d\t%d\t%d\n",
>                 get_task_state(p), p->tgid,
>                 p->pid, p->pid ? p->real_parent->pid : 0,
>                 p->pid && p->ptrace ? p->parent->pid : 0,
>                 p->uid, p->euid, p->suid, p->fsuid,
>                 p->gid, p->egid, p->sgid, p->fsgid);
>         read_unlock(&tasklist_lock);
> 
> Is it these two accesses:
> 
> p->real_parent->pid ?
> p->parent->pid ?

Yup.

> Don't see what I can do for this apart from to invert the ordering and take
> tasklist_lock around the whole function, and nest task_lock inside that, or
> I suppose I could take the task_lock for each of the parents? I seem to 
> recall Linus reminding people recently that it was only the lock 
> acquisition order that was important, not release ... does something like 
> the following look OK?

This patch looks like it should certainly fix the problem, but that is 
still some god-awful ugly overkill in locking.

I'd rather make the rule be that you have to take the task lock before 
modifying things like the parent pointers (and all the other fundamntal 
pointers), since that's already the rule for most of it anyway.

And then the tasklist lock would go away _entirely_ from /proc (except for
task lookup in ->readdir/->lookup, of course, where it is fundamentally
needed and proper - and will probably some day be replaced by RCU, I
suspect).

			Linus


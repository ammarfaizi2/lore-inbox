Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSIIPEJ>; Mon, 9 Sep 2002 11:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317363AbSIIPEJ>; Mon, 9 Sep 2002 11:04:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:22657 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S317355AbSIIPEH>; Mon, 9 Sep 2002 11:04:07 -0400
Date: Mon, 09 Sep 2002 08:07:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>, linux-kernel@vger.kernel.org
cc: manfred@colorfullife.com
Subject: Re: [PATCH] pid_max hang again...
Message-ID: <307667352.1031558825@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.33.0209091836470.14828-100000@ccvsbarc.wipro.com>
References: <Pine.LNX.4.33.0209091836470.14828-100000@ccvsbarc.wipro.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks to Manfred, to clarfy me further that my patch doesn't
> work. But I am still in feeling that current pid allocation can
> be improved. If we assume that the atomicity problem with pid
> allocation and linking task struct into process list can be
> ignored (sorry Manfred), does it make any sense to maintain a
> list of `freed' pids ?  For me (some of others too !!), it makes
> lot of sense to re-use pids of exited processes.
> 
> If I am not wrong, an exiting process pid can be re-used (after
> the task dies) if its pid
> 
> 1) not used as session ID (i.e p->session != p->pid)
>    (or p->leader == 0)
> 2) not used as process group ID (p->pgrp != p->pid)
> 3) not used as thread group-ID (p->tgid != p->pid)

How do you track this? Can you keep a reference count for each
PID and score 1 for each of the above usages (and one for normal
use)? Or do you think it's better to just fall back to the current
system in the non-trivial case?
 
> Lets us maintain a list of atmost (PAGE_SIZE /sizeof(pid))
> entries for freed pids, protected by a spin_lock (freepid_lock)
> and let last_pid start from (300 + num_free_pids).

OK, well whilst you're at it, do you want make the free pid list
per CPU with no locking, and make it even more efficient? ;-) 
We now have plenty of free PIDs to play with, and you could refill
the list with 100 entries or so if you had to fall back to scanning.
Actually, you could do that even if your current proposal doesn't
work out ....

> Let me know if it is worth implementing this.

Personally, I think it'd be great ... the current scanning doesn't 
seem like an efficient algorithm at all.

M.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSIIOBH>; Mon, 9 Sep 2002 10:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSIIOBH>; Mon, 9 Sep 2002 10:01:07 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:22696 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S316512AbSIIOBG>; Mon, 9 Sep 2002 10:01:06 -0400
Date: Mon, 9 Sep 2002 19:52:31 +0530 (IST)
From: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>
To: <linux-kernel@vger.kernel.org>
cc: <manfred@colorfullife.com>
Subject: Re: [PATCH] pid_max hang again...
In-Reply-To: <3D79C195.90004@colorfullife.com>
Message-ID: <Pine.LNX.4.33.0209091836470.14828-100000@ccvsbarc.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Sep 2002, Manfred Spraul wrote:

>
> Doesn't work: find_task_by_pid() only checks task->pid. But
> the result of get_pid mustn't be in use as a session or tgid
> value either
>

Thanks to Manfred, to clarfy me further that my patch doesn't
work. But I am still in feeling that current pid allocation can
be improved. If we assume that the atomicity problem with pid
allocation and linking task struct into process list can be
ignored (sorry Manfred), does it make any sense to maintain a
list of `freed' pids ?  For me (some of others too !!), it makes
lot of sense to re-use pids of exited processes.

If I am not wrong, an exiting process pid can be re-used (after
the task dies) if its pid

1) not used as session ID (i.e p->session != p->pid)
   (or p->leader == 0)
2) not used as process group ID (p->pgrp != p->pid)
3) not used as thread group-ID (p->tgid != p->pid)

Lets us maintain a list of atmost (PAGE_SIZE /sizeof(pid))
entries for freed pids, protected by a spin_lock (freepid_lock)
and let last_pid start from (300 + num_free_pids).

get_pid() looks in freepid_list first to get one free pid.
If it finds one, sets its entry to zero and return this pid.
If it couldn't find any free pid, then it continues as usual
by incrementing last_pid and searching through entire task
list. The hang problem might be due to holding the lock
forever if pids are not free. Current approach does not
re-look at the pids of exiting processes which might be
waiting on tasklist_lock to free up its task_struct.


get_pid() {

	if(pid = get_free_pid()) return pid;
	// usual code of incrementing last_pid
        // and comparing next_safe + searching in
        // tasklist and exiting (with Paul's fix).
}

get_free_pid() searches in freepid_list returns a free
pid if it finds one, otherwise 0.

This approach reduces the search time and avoids holding
of tasklist_lock for longer times.

A process exiting releases its pid to the freepid_list
if its pid matches with about creteria.

Let me know if it is worth implementing this.



~Hanumanthu


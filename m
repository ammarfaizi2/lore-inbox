Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318991AbSIIWfg>; Mon, 9 Sep 2002 18:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318987AbSIIWfe>; Mon, 9 Sep 2002 18:35:34 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:46857 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S318986AbSIIWfX>; Mon, 9 Sep 2002 18:35:23 -0400
Date: Mon, 9 Sep 2002 15:39:56 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid_max hang again...
Message-ID: <20020909223956.GA2093@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0209091836470.14828-100000@ccvsbarc.wipro.com> <307667352.1031558825@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <307667352.1031558825@[10.10.2.3]>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 08:07:05AM -0700, Martin J. Bligh wrote:
> > Thanks to Manfred, to clarfy me further that my patch doesn't
> > work. But I am still in feeling that current pid allocation can
> > be improved. If we assume that the atomicity problem with pid
> > allocation and linking task struct into process list can be
> > ignored (sorry Manfred), does it make any sense to maintain a
> > list of `freed' pids ?  For me (some of others too !!), it makes
> > lot of sense to re-use pids of exited processes.
> > 
> > If I am not wrong, an exiting process pid can be re-used (after
> > the task dies) if its pid
> > 
> > 1) not used as session ID (i.e p->session != p->pid)
> >    (or p->leader == 0)
> > 2) not used as process group ID (p->pgrp != p->pid)
> > 3) not used as thread group-ID (p->tgid != p->pid)
> 
> How do you track this? Can you keep a reference count for each
> PID and score 1 for each of the above usages (and one for normal
> use)? Or do you think it's better to just fall back to the current
> system in the non-trivial case?
>  
> > Lets us maintain a list of atmost (PAGE_SIZE /sizeof(pid))
> > entries for freed pids, protected by a spin_lock (freepid_lock)
> > and let last_pid start from (300 + num_free_pids).
> 
> OK, well whilst you're at it, do you want make the free pid list
> per CPU with no locking, and make it even more efficient? ;-) 
> We now have plenty of free PIDs to play with, and you could refill
> the list with 100 entries or so if you had to fall back to scanning.
> Actually, you could do that even if your current proposal doesn't
> work out ....
> 
> > Let me know if it is worth implementing this.
> 
> Personally, I think it'd be great ... the current scanning doesn't 
> seem like an efficient algorithm at all.

I don't like the idea of reusing recent pids at all.

The current repeated scanning is awful.  I've been mulling this over
in my mind for awhile now and i've had two thoughts.

If we insist on scanning the task list we should at least
reap multiple pids.  Have an array of free pids managed
inside get_pid() that it pulls from until it runs out at which
point it would do the scan to refill the array + 1 for
immediate use.

Here is my better suggestion.

	Dont destroy the task_struct of exited tasks that
	are session, thread group or process group leaders
	until last group member exits.  Give them a status
	so that they don't show up in /proc.  Heck go ahead
	and mark them as zombies if you want though i'd
	rather another status.

	Preserved the pid number sort order of the
	prev_task/next_task list.  It looks to me like this
	is already the case.

	get_pid() continues to preserve next_safe.

	Also preserve a task_struct *last_safe which would be
	set to the last pid created.  release_task() whould update
	it to p->prev_task if last_safe == p.

 	get_pid() would use *last_safe->next_task to walk
	until it found a gap >= next_safe. (looping if it
	hits PID_MAX)

So by adding a couple of bits of logic in wait() and keeping
around a relatively small number of task_structs for exited
processes we can eliminate the scan alltogether.

Defering the release_task() for group leaders eliminates the
need for rescanning and opens the possiblity of using
find_task_by_pid() instead of scanning as someone recently
suggested.

What have i missed?  This seems much simpler than the other
aproaches i've seen proposed.  It should also be much more
deterministic in behavior.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTBPB3C>; Sat, 15 Feb 2003 20:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTBPB3C>; Sat, 15 Feb 2003 20:29:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3336 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265567AbTBPB3A>; Sat, 15 Feb 2003 20:29:00 -0500
Date: Sat, 15 Feb 2003 17:35:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.5.61 oops running SDET
In-Reply-To: <20030215172407.1fdd41fd.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302151723560.23951-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Feb 2003, Andrew Morton wrote:
>
> The recent change to fs/proc/array.c:task_sig()?
> 
>         buffer += sprintf(buffer, "ShdPnd:\t");
>         buffer = render_sigset_t(&p->signal->shared_pending.signal, buffer);

Yeah, but I think the bug has existed for much longer. 

It looks like "proc_pid_status()" doesn't actually lock the task at all, 
nor even bother to test whether the task has signal state. Which has 
_always_ been a bug. I don't know why it would start happening now, but it 
might just be unlucky timing.

I think the proper fix is to put a 

	task_lock()
	..
	task_unlock()

around the whole proc_pid_status() function, _and_ then verify that 
"tsk->sighand" is non-NULL.

(Oh, careful, that's already what "get_task_mm()" does internally, so look 
out for deadlocks - you'd need to open-code the get_task_mm() in there 
too, so the end result is something like

	task_lock(task)
	if (task->mm) {
		.. mm state
	}
	if (task->sighand) {
		.. signal state
	}
	..
	task_unlock(task);

instead).

		Linus


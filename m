Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270981AbUJUV7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270981AbUJUV7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271003AbUJUV6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:58:13 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:1490 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S270981AbUJUVwm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:52:42 -0400
Date: Thu, 21 Oct 2004 17:52:08 -0400
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Scott Wood <scott@timesys.com>, john cooper <john.cooper@timesys.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@suse.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021215207.GB28290@yoda.timesys>
References: <20041021184742.GB26530@yoda.timesys> <Pine.OSF.4.05.10410212232050.26965-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10410212232050.26965-100000@da410.ifa.au.dk>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 11:01:21PM +0200, Esben Nielsen wrote:
> You can implement the full scheduler structure in each mutex. That would
> be O(1) but would take take quite a lot of memory.

Are you talking about the thread's locks-held list, or the mutex's
blocked-threads list?  In the latter case, you could cut down on the
memory usage by allocating one such structure for each thread upon
creation, placing it into a pool, and associating them with a mutex
when it's contended (as you can't have more contended mutexes than
you have threads).  It's still a lot heavier than a linked list,
though.

In either case, you'd need to do whatever adjustments to the
scheduler's data structures are necessary whenever a task's priority
changes (including via PI).  It's worth it for at least one of the
lists, as if neither locks-held nor threads-blocked is kept in order,
priority recalculation becomes O(n^2) to find the highest priority
blocker among all held mutexes.  Ordering threads-blocked seems to
make more sense, as you don't have the imbalance between the
frequency adding to the list and searching the list.

> On the other hand a sorted list will not take more memory than now but
> will appear to be O(n) when inserting into the list. However, on a UP
> machine no lower priority task will run when higher priority tasks runs.
> I.e. you will always add to the beginning of the list. That is assuming
> ofcourse that nobody will sleep while holding a mutex - which is a bad
> bahaviour.

It's bad, but inevitable if this is also used to provide PI mutexes
to userspace.

> > On uniprocessor, one may wish to turn rwlocks into recursive non-rw
> > mutexes, where recursion checking would use a single owner field.
> >
> 
> 
> Why not use a simple counter? 

You'd need a counter as well, but you first have to check the owner
to make sure that the count reflects the calling thread's activity
rather than some other thread.

> The mutex protects it's own memory area.
> Anyway, I am not sure recursive acquisition is such a good idea: It will
> make the mutex more expensive to use and promote sloppy coding where you
> don't really know what mutexes are held right now.

I agree, but current code assumes rwlocks can be recursively obtained
for reading (unless that's changed recently).

> I am not sure this at all make sense on a SMP system. For performance
> reasons I think that one should stick to ordinary semaphores and in a lot
> of places spin-locks on such a system. Even with a dedicated RTOS you have
> to design your system from the bottum up to get a good real-time
> behaviour - and it depends a lot on the application of which you can only
> have one! That is very far from the world of SMP servers.

Things get weird on SMP, but it's possible to produce reasonable
real-time behavior, and there are people out there who are interested
in it.

> The ones who can use all the fancy mutexes are really embedded developer
> (like myself) who need a robust RTOS but also drivers for a lot of
> hardware, a good TCP/IP stack, firewall, good filesystems etc. which the
> commercial vendors have a hard time delivering all at once. 

And some embedded devices also need a lot of CPU power, and some of
those use SMP.

> On the desktop it can lead to good performance of multimedia but as soon
> as you want to use two applications, which considers themselves multimedia
> and thus gives themselves high priority, it wont work.

It can be made to work if you have CPU reservations, or some other
way of ensuring that the applications take their CPU in
appropriately sized chunks.

-Scott

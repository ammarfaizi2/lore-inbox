Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRB1Vyf>; Wed, 28 Feb 2001 16:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129291AbRB1Vy0>; Wed, 28 Feb 2001 16:54:26 -0500
Received: from mercury.ultramaster.com ([208.222.81.163]:39335 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S129164AbRB1VyS>; Wed, 28 Feb 2001 16:54:18 -0500
Message-ID: <3A9D7382.A020354E@dm.ultramaster.com>
Date: Wed, 28 Feb 2001 16:54:10 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: neelam_saboo@usa.net, linux-kernel@vger.kernel.org
Subject: Re: paging behavior in Linux
In-Reply-To: <3A9D6F05.F24D5558@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> >
> > When I run my program on a readhat linux machine, I dont get results as
> > expected, work thread seems to be stuck when prefetch thread is waiting on
> > a page fault
> >
> That's a known problem:
> 
> The paging io for a process is controlled with a per-process semaphore.
> The semaphore is held while waiting for the actual io. Thus the paging
> in multi threaded applications is single threaded.
> Probably your prefetch thread is waiting for disk io, and the worker
> thread causes a minor pagefault --> worker thread sleeps until the disk
> io is completed.

This behavior is actually pretty annoying.  There can be cases where a
process wakes up from a page fault, does some work, goes back to sleep
on a page fault, thereby keeping it's mmap_sem locked at all times (i.e.
vmstat, top, ps unusable) on a UP system.  I posted this complaint a
while ago, it was discussed by Linus and Andrew Morton about how it also
boiled down to semaphore wakeup unfairness (and bugs?).  The current
semaphore was determined to be too ugly to even look at.  So it was
dropped.

Is there any way that the mmap_sem could be dropped during the blocking
on I/O, and reclaimed after the handle_mm_fault?  Probably not, or it'd
be done.

It can be a real DOS though, a 'well-written' clobbering program can
make ps/vmstat useless.  (it's actually /proc/pid/stat that's the
killer, IIRC).

David

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com

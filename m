Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSEHIuY>; Wed, 8 May 2002 04:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSEHIuX>; Wed, 8 May 2002 04:50:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15124 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312447AbSEHIuX>; Wed, 8 May 2002 04:50:23 -0400
Date: Wed, 8 May 2002 10:50:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: rwhron@earthlink.net, mingo@elte.hu, gh@us.ibm.com,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020508105049.A31998@dualathlon.random>
In-Reply-To: <20020503093856.A27263@rushmore> <20020507151356.A18701@w-mikek.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 03:13:56PM -0700, Mike Kravetz wrote:
> I believe the decrease in pipe bandwidth is a direct result of the
> removal of the '__wake_up_sync' support.  I'm not exactly sure what
> the arguments were for adding this support to the 'old' scheduler.
> However, it was only used by the 'pipe_write' code when it had to
> block after waking up a the reader on the pipe.  The 'bw_pipe'
> test exercised this code path.  In the 'old' scheduler '__wake_up_sync'
> seemed to accomplish the following:
> 1) Eliminated (possibly) unnecessary schedules on 'remote' CPUs
> 2) Eliminated IPI latency by having both reader and writer
>    execute on the same CPU
> 3) ? Took advantage of pipe data being in the CPU cache, by
>    having the reader read data the writer just wrote into the
>    cache. ?
> As I said, I'm not sure of the arguments for introducing this
> functionality in the 'old' scheduler.  Hopefully, it was not
> just a 'benchmark enhancing' patch.
> 
> I have experimented with reintroducing '__wake_up_sync' support
> into the O(1) scheduler.  The modifications are limited to the
> 'try_to_wake_up' routine as they were before.  If the 'synchronous'
> flag is set, then 'try_to_wake_up' trys to put the awakened task
> on the same runqueue as the caller without forcing a reschedule.
> If the task is not already on a runqueue, this is easy.  If not,
> we give up.  Results, restore previous bandwidth results.
> 
> BEFORE
> ------
> Pipe latency:    6.5185 microseconds
> Pipe bandwidth: 86.35 MB/sec
> 
> AFTER
> -----
> Pipe latency:     6.5723 microseconds
> Pipe bandwidth: 540.13 MB/sec

So my hypothesis about the sync wakeup in the below email proven to be right:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=102050009725367&w=2

Many thanks for verifying this.

Personally if the two tasks ends blocking waiting each other, then I
prefer them to be in the same cpu. That was the whole point of the
optimization. If the pipe buffer is large enough not to require reader
or writer to block, then we don't do the sync wakeup just now (there's a
detail with the reader that may block simply because the writer is slow
at writing, but it probably doesn't matter much). There are many cases
where a PAGE_SIZE of buffer gets filled in much less then a timeslice,
and for all those cases rescheduling the two tasks one after the other
in the same cpu is a win, just like the benchmark shows.  Think the
normal pipes we do from the shell, like a "| grep something", they are
very common and they all wants to be handled as a sync wakeups.  In
short when loads of data pass through the pipe with max bandwith, the
sync-wakeup is a definitive win. If the pipe never gets filled then the
writer never sync-wakeup, it just returns the write call asynchronously,
but of course the pipe doesn't get filled because it's not a
max-bandiwth scenario, and so the producer and the consumer are allowed
to scale in multiple cpus by the design of the workload.

Comments?

I would like if you could pass over your changes to the O(1) scheduler
to resurrect the sync-wakeup.

Andrea

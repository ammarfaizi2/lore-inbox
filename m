Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314562AbSEGWPB>; Tue, 7 May 2002 18:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314609AbSEGWPA>; Tue, 7 May 2002 18:15:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:57758 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314562AbSEGWO6>;
	Tue, 7 May 2002 18:14:58 -0400
Date: Tue, 7 May 2002 15:13:56 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: rwhron@earthlink.net, mingo@elte.hu
Cc: gh@us.ibm.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        andrea@suse.de
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020507151356.A18701@w-mikek.des.beaverton.ibm.com>
In-Reply-To: <20020503093856.A27263@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 09:38:56AM -0400, rwhron@earthlink.net wrote:
> 
> A side effect of O(1) in ac2 and jam6 on the 4 way box is a decrease 
> in pipe bandwidth and an increase in pipe latency measured by lmbench:
> 

Believe it or not, the increase in pipe latency could be considered
a desirable result.  I believe that lat_pipe (the latency test) uses
two tasks that simply pass a token back and forth.  With the 'old'
scheduler these two tasks (mostly) got scheduled and ran on the same
CPU which produced the 'best results'.  With the O(1) scheduler, tasks
have some affinity to the CPUs they last ran on.  If the tasks end
up on different CPUs, then they will have a tendency to stay there.
In the case of lat_pipe, IPI latency (used to awaken/schedule a task
on another CPU) is added to every 'pipe transfer'.  This is bad for
the benchmark, but good for most workloads where it is more important
to run with warm caches than to be scheduled as fast as possible.

I believe the decrease in pipe bandwidth is a direct result of the
removal of the '__wake_up_sync' support.  I'm not exactly sure what
the arguments were for adding this support to the 'old' scheduler.
However, it was only used by the 'pipe_write' code when it had to
block after waking up a the reader on the pipe.  The 'bw_pipe'
test exercised this code path.  In the 'old' scheduler '__wake_up_sync'
seemed to accomplish the following:
1) Eliminated (possibly) unnecessary schedules on 'remote' CPUs
2) Eliminated IPI latency by having both reader and writer
   execute on the same CPU
3) ? Took advantage of pipe data being in the CPU cache, by
   having the reader read data the writer just wrote into the
   cache. ?
As I said, I'm not sure of the arguments for introducing this
functionality in the 'old' scheduler.  Hopefully, it was not
just a 'benchmark enhancing' patch.

I have experimented with reintroducing '__wake_up_sync' support
into the O(1) scheduler.  The modifications are limited to the
'try_to_wake_up' routine as they were before.  If the 'synchronous'
flag is set, then 'try_to_wake_up' trys to put the awakened task
on the same runqueue as the caller without forcing a reschedule.
If the task is not already on a runqueue, this is easy.  If not,
we give up.  Results, restore previous bandwidth results.

BEFORE
------
Pipe latency:    6.5185 microseconds
Pipe bandwidth: 86.35 MB/sec

AFTER
-----
Pipe latency:     6.5723 microseconds
Pipe bandwidth: 540.13 MB/sec

Comments?  If anyone would like to see/test the code (pretty simple
really) let me know.

-- 
Mike

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVC1Qef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVC1Qef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 11:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVC1Qef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 11:34:35 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:23304 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261939AbVC1Qeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 11:34:31 -0500
Date: Mon, 28 Mar 2005 18:33:45 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Eric Bambach <eric@cisu.net>
Cc: mingo@elte.hu, kernel@kolivas.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Scheduler latency : more precisions
Message-ID: <20050328163345.GA2261@pcw.home.local>
References: <20050328141449.GA2216@pcw.home.local> <200503280921.03851.eric@cisu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503280921.03851.eric@cisu.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

I have some more interesting tests showing that it's not a matter
of hard real-time latency. Everyone here knows the vmstat program.

If I only start 2 'lat3 4000' programs in parallel, it literally
freezes vmstat for up to 7.7 seconds. That is, the simple program
designed to observe system activity becomes unusable, as shown
below. Starting 4 processes gets worse, pauses reach 8.3-11 seconds,
and it's very hard to stop them because the console responds at
the same speed.

What's more interesting is that vmstat sees more processes in the
runqueue than there really are : with 2 'lat3', we often see 4
processes. With 4 'lat3', we see between 0 and 7 processes. It's
just as if vmstat sees several times the same processes, or as if
the processes really appeared several times in the queue.

$ ./lat3 4000 >/dev/null & ./lat3 4000 >/dev/null &
$ vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 235224 109020  57916    0    0     0     0 1036    52  0  0 100  0
 0  0      0 235224 109020  57916    0    0     0     0 1035    54  0  0 100  0
 0  0      0 235224 109020  57916    0    0     0     0 1025    46  0  0 100  0
 0  0      0 235224 109032  57916    0    0     0    16 1047    76  0  0 100  0
 0  0      0 235224 109032  57916    0    0     0     4 1043    69  0  0 100  0
 0  0      0 235224 109032  57916    0    0     0     0 1018    29  0  1 99  0
 0  0      0 235240 109032  57916    0    0     0     0 1016    27  0  1 99  0
 0  0      0 235240 109032  57916    0    0     0     0 1016    27  0  1 99  0
 2  0      0 235232 109032  57916    0    0     0     0 7674  2727 42 57  1  0
>4< 0      0 235040 109044  57916    0    0     0    20 7530  2750 44 56  0  0
 1  0      0 235040 109044  57916    0    0     0     0 4246  1536 39 61  0  0
 1  0      0 235040 109044  57916    0    0     0     0 6511  2367 43 57  0  0
>4< 0      0 235040 109044  57916    0    0     0     0 7766  2854 43 56  1  0
 1  0      0 235040 109044  57916    0    0     0     0 4485  1647 42 57  1  0
 1  0      0 235040 109044  57916    0    0     0     0 4932  1860 45 53  1  0

The 'in' column shows the number of interrupts since the previous line. As the
system timer is at 1 kHz, it shows that when the system does nothing, vmstat
sleeps 1 second between each line. When I start the two processes above, I get
long pauses, up to 7.7 seconds.

I will not copy the 4 process output, I will not be able to get access to
the machine and will have to sysrq-k it.

Cheers,
Willy

On Mon, Mar 28, 2005 at 09:21:03AM -0600, Eric Bambach wrote:
> No-where in your mail, unless I missed it because i've been awake for 15 
> minutes now, do you mention pre-emption. One of the major latency affecting 
> differences between 2.4 and 2.6 is the introduction of pre-emption and with 
> 2.6.10(ish?) you can pre-empt the big kernel lock.
> 
> Since you are experiencing odd latencies w.r.t. syscalls, pre-emption is a 
> major point to look at. In fact, the JACK and RT Linux people are working on 
> problems similiar to this right now. If your program for whatever reason has 
> *hard-time* latency requirements then I suggest you look at the Realtime 
> Patches for Linux 2.6.
> 
> I would suggest you try a few more test with various combinations of 
> pre-emption. The consesus in the documentation seems to be that pre-emption  
> make desktops only feel snappier and "real" workloads will suffer as a 
> result.


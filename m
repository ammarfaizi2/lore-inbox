Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269076AbRHGHBe>; Tue, 7 Aug 2001 03:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269188AbRHGHBY>; Tue, 7 Aug 2001 03:01:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269076AbRHGHBO>; Tue, 7 Aug 2001 03:01:14 -0400
Date: Tue, 7 Aug 2001 02:32:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Eric Taylor <et@rocketship1.com>
Cc: linux-kernel@vger.kernel.org, eric.a.tailor@jpl.nasa.gov
Subject: Re: "[KSWAPD] linux-2.4.8-pre4, <kswapd profile test results>
In-Reply-To: <5.1.0.14.2.20010806230342.00ac2850@pop.we.mediaone.net>
Message-ID: <Pine.LNX.4.21.0108070217590.11588-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2001, Eric Taylor wrote:

> Kswapd has been seen to get busy for minutes. I used the kernel
> profiler with a minor mod, to analyse what kswapd is doing during this
> time. I think that everyone agrees that it is probably running too
> often, but I wanted to see what it was doing when my system froze.
> 
> Eric
> please cc at et@rocketship1.com
> 
> 
> 
> 
> 
> My test case is simple, esentially the below loop: 
> 
> =================================================
> 32-bit int array = malloc(1.2 gigs of mem);
> for(I=0; I < 1.2gig/4 ; I++){
>    array[I] = I;
> }
> =================================================
> 
> 
> 
> =================================================
> Findings (with approximate numbers):
> =================================================
> 
> The time spent in kswapd is almost entirely in scan_swap_map (normally inlined in swapfile.c).
> Note that it is called like this:
> 
>                         swap_device_lock(p);
>                         offset = scan_swap_map(p, count);
>                         swap_device_unlock(p);
> 
> What does swap_device_lock lock, could it explain why nothing else runs while kswapd is scanning?

We hold the pagetable lock for the mm when scanning it.

> Over a typical run, scan_swap_map was called 461k (461,000) times.
> Only .6k times did it find a completely empty cluster (approx 1 /
> 1000). 175k times it found a free page, 286k times it did not find a
> free page. In this test, the clustering code is not finding many
> clusters, but seems to be doing a lot of work. The swapfile cluster
> value is 256 (perhaps this should become a tuning variable).

That code was written a long time ago.

I started to write a new clustering scheme for swapping 4h ago.  

I'll post code as soon as I get it stable. 


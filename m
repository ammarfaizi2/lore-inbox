Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281334AbRKEUrm>; Mon, 5 Nov 2001 15:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281331AbRKEUrW>; Mon, 5 Nov 2001 15:47:22 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:31245 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281326AbRKEUrV>; Mon, 5 Nov 2001 15:47:21 -0500
Date: Mon, 5 Nov 2001 17:28:05 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Sven Heinicke <sven@research.nj.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unwanted Swapping in 2.4.14-pre8, no swapping in 2.4.14-pre6aa1
In-Reply-To: <15334.61892.392055.542002@abasin.nj.nec.com>
Message-ID: <Pine.LNX.4.21.0111051719470.9105-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Sven Heinicke wrote:

> 
> We have a system with 4G of memory that process streams of information
> in the order of a Terabyte of information.  We worked hard to make is
> to we never have more then ~3G of data in memory at any one time, so
> we would not go into swap.  We tested our code, and the began to swap,
> I downloaded 2.4.14-pre8, and it still swaps.  But, if I turn off our
> swap partitions it works well, so swap was not needed.
> 
> With the 2.4.14-pre6aa1 kernel, with swap turned on, we have no
> problem.
> 
> In the beginning I though it was the same bug as the google bug, but
> following and asking stupid questions I realized it wasn't.  The
> following program, which approximates what our processing does on a
> small scale, can demonstrate the bug.  You need the chunk files as
> used in the google bug test code.  The comments of the code show a
> fast way to make the chunk files.
> 
> Any possibility of this being fixed in the stable kernel?  Any way to
> raise the priority of reclaiming cached memory over swapping out
> pages? 

Yes. Currently, the kernel "tries" to keep the LRU list of pages with 90%
of mapped pages and 10% of cache when there is memory pressure.

By looking at mm/vmscan.c::shrink_cache() you can see:

        int max_scan = nr_inactive_pages / priority;
        int max_mapped = nr_pages << (9 - priority);

"max_scan" is the max. number of pages the kernel will scan on the
inactive list (the inactive list is usually 1/3 of the total amount of
pages) each time "shrink_cache()" is called.

"max_mapped" is the (roughly) maximum number of non-cache (anonymous)
pages the kernel will scan _before_ it tries to search for data to map to
swap. So basically right now we will scan 

You should try to increase "max_mapped" to "nr_pages << (10 - priority)"
and so on until you get good tuning for your workload.

> I'd like to try to stay away from development kernels on what
> are meant to be stable systems, but for now it's aa kernels for me.


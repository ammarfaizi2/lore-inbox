Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279715AbRKFPjj>; Tue, 6 Nov 2001 10:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279728AbRKFPja>; Tue, 6 Nov 2001 10:39:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:7183 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S279715AbRKFPjN>; Tue, 6 Nov 2001 10:39:13 -0500
Date: Tue, 6 Nov 2001 12:19:48 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: out_of_memory() heuristic broken for different mem configurations
In-Reply-To: <Pine.LNX.4.33.0111060714070.1988-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0111061217110.9867-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Linus Torvalds wrote:

> 
> On Tue, 6 Nov 2001, Marcelo Tosatti wrote:
> >
> > Looking at out_of_memory() I've found out that we will only kill a task if
> > we happen to call out_of_memory() ten times in one second.
> 
> It should be "10 times in at _least_ one second, and at most 5 seconds
> apart", but yes, I can imagine that it doesn't work very well if you have
> tons of memory.
> 
> The problem became more pronounced when we started freeing the swap cache:
> it seems that allows the machine to shuffle memory around so efficiently
> that I've seen it go for half a minute with vmstat claiming zero IO, and
> yet very few out-of-memory messages - I don't know why shrink_cache()
> _claims_ success under those circumstances, but I've seen it myself.
> Shrink_cache _should_ only return success when it has actually dropped a
> page that needs re-loading, but..
> 
> > (end of swap)
> >
> > 23  1  1 4032960   2892    232   7648  16 24246    22 24252  235   997 0 72  28
> > 22  1  1 4032960   2872    232   7648   0   0     0     0  106    13   0 99   0
> > 23  0  2 4032960   2764    232   7648   0   0     0     0  116    11   0 100   0
> > 21  0  1 4032960   2856    232   7648   0   0     0     0  122    45   0 100   0
> > 21  0  1 4032960   2848    232   7648   0   0     0     0  117    21   0 100   0
> > 21  0  1 4032960   2588    232   7648  38   0    38     0  118    41   0 100 0
> > 21  0  1 4032960   2584    232   7648   0   0     0     0  123    10   0 100   0
> 
> Note how you also go for seconds with no IO and no shrinking of the
> caches, while shrink_cache() is apparently happy (and no, it does not take
> several seconds to traverse even a 16GB inactive queue, there's something
> else going on)
> 
> With the more aggressive max_mapped, the oom failure count could be
> dropped to something smaller, as a false positive from shrink_caches
> should be fairly rare. I don't think it needs to be tunable on memory
> size, I just didn't even try any other values on my machines (I noticed
> that the old values were too high once max_mapped was upped and the swap
> cache reclaiming was re-done, but I didn't try if five seconds and ten
> failures was any better than 10 seconds and five failures, for example)

Ok, I'll take a careful look at shrink_cache()/try_to_free_pages() path
later and find out "saner" magic numbers for big/small memory workloads.


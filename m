Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160671-27302>; Mon, 1 Feb 1999 02:07:51 -0500
Received: by vger.rutgers.edu id <160645-27302>; Mon, 1 Feb 1999 02:07:40 -0500
Received: from dm.cobaltmicro.com ([209.133.34.35]:3634 "EHLO dm.cobaltmicro.com" ident: "davem") by vger.rutgers.edu with ESMTP id <160548-27300>; Mon, 1 Feb 1999 02:07:16 -0500
Date: Sun, 31 Jan 1999 23:20:31 -0800
Message-Id: <199902010720.XAA31757@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: lm@bitmover.com
Cc: linux-kernel@vger.rutgers.edu
In-reply-to: <199901311924.LAA04620@bitmover.com> (lm@bitmover.com)
Subject: Re: Page coloring HOWTO [ans]
References: <199901311924.LAA04620@bitmover.com>
Sender: owner-linux-kernel@vger.rutgers.edu

   From: lm@bitmover.com (Larry McVoy)
   Date: 	Sun, 31 Jan 1999 11:24:39 -0800

   davem@redhat.com (Hey, look where Dave is :-) says:

   :    Page coloring, in the sense that we are talking about here,
   :    is %99 dealing with physically indexed secondary/third-level
   :    etc. caches.  Virtually indexed secondary/third-level caches
   :    are dinosaurs 

   Are you sure about that? We should come to agreement on terminology.
   I thought that the HyperSparc was virtually indexed and virtually tagged,
   with just about everything else being virtually indexed but physically
   tagged.

MBUS speaks physical address, L2 caches on sun4m MBUS systems speak to
MBUS, therefore cache is physically tagged and 2 + 2 == 4. :-)  The
same for the UPA bus on UltraSparc, busses and cache coherency schemes
work with a currency of physically addressable objects.

Anything made today that I know of is physically indexed and
physically tagged (PIPT for short).

   This has some nice attributes in that it will work well if a process
   chooses to touch memory at a stride of exactly cache size.  However,
   it's a little harder to tune for if you are an application writer because
   different inputs to the program will give you different page colors.

Can you be at least slightly more explicit?

There is another trick btw, change the plain increment into something
like:

	tsk->cur_color = (tsk->cur_color + SOME_NICE_PRIME) % NUM_COLORS

This is what the final implementation I was playing with used.
With the proper prime you can obtain a perfect cycle for any
reasonable NUM_COLORS value.

   You could argue it either way but I'm curious as to why not just use the
   (pageno + pid) % cachesize alg.  Did you try this and find that it gave
   consistently worse results?

No I did not try, I'm eager to try it out once I work on some sample
implementations again.  At the time I was so happy with the results of
the algorithm I described that I didn't bother looking further.

   I'd find that sort of hard to believe but your oblique reference to
   mmaped shared libraries gave me a hint that you might be onto
   something.  Can you explain the results please?

The results were (on 512K L2 UltraSparcs):

1) Kernel builds were faster by close to 40 seconds.

2) lat_ctx gave perfectly smooth graphs for all process sizes and
   numbers of processes up until the total size walked of the L2 cache
   size boundary (512K in this case).  (in fact Larry, my graphs
   looked cleaner than the HP ones you always dribbled over, check
   your email archives because I believe I sent these graphs to you
   while I was still at Rutgers)

3) Applications which were just data set number crunchers, which I
   knew gave wildly inconsistant results for each run before, gave
   completely reproducable results with the coloring.  Also I could
   run parallel copies of these programs up to where they would have a
   total resident set size of the L2, and get consistant results as
   well.

The technique of coloring per-inode is very important.  Just consider
a simple example (in your head, the point is to visualize this).
Picture the first few programs which run on the system and begin
paging in parts of shared libc.  As each subsequent program uses some
new part of shared libc, it will color it relative to the color state
at the time of the page in.  Therefore, libc itself is colored for
everyone, it is much like a shared context.

Local anonymous pages for a process and page table pages are like a
non-shared local context.

One area which could be tuned is to discover whether it makes sense to
reset the per-process color counter to zero even at fork.  And
actually by my original description (do this at creation of each new
address space) this can be implied.  I did not do this in the
implementation I played with.

Another way to obtain a similar effect is to use half the number of
colors as you really have in the L2 cache, it's like creating a pseudo
2-way set assosciative L2 cache.

In fact, in my experience, it seemed to make no sense to color past
a L2 cache size of 512K.

BTW, I am rather certain that the "color" terminology stems from the
fact that the problem being solved here in a mathematical sense
mirrors graph coloring (fixed number of colors, goal is to prevent
neighbouring nodes with the same color, it cannot be fully solved with
bounded complexity in all cases, etc.)  Much register allocation
technology in compilers use graph coloring to model the problem as
well.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

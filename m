Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154146AbQAXVch>; Mon, 24 Jan 2000 16:32:37 -0500
Received: by vger.rutgers.edu id <S154232AbQAXVGo>; Mon, 24 Jan 2000 16:06:44 -0500
Received: from [207.181.251.162] ([207.181.251.162]:2107 "EHLO bitmover.com") by vger.rutgers.edu with ESMTP id <S154141AbQAXUuN>; Mon, 24 Jan 2000 15:50:13 -0500
Message-Id: <200001250054.QAA24603@work.bitmover.com>
To: dg50@daimlerchrysler.com
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: SMP Theory (was: Re: Interesting analysis of linux kernel threading by IBM) 
In-Reply-To: Your message of "Mon, 24 Jan 2000 17:46:55 EST." <OFC8E00C6C.FBE80B06-ON85256870.007B8178@notes.chrysler.com> 
Date: Mon, 24 Jan 2000 16:54:38 -0800
From: Larry McVoy <lm@bitmover.com>
Sender: owner-linux-kernel@vger.rutgers.edu

: OK, if you have an n-way SMP box, then you have n processors with n (local)
: caches sharing a single block of main system memory. If you then run a
: threaded program (like a renderer) with a thread per processor, you wind up
: with n threads all looking at a single block of shared memory - right?

Yes.  A really good reference for all of this, at the sort of accessable
and general level, is ``Computer Architecture, A Quantitative Approach''
by Patterson and Hennessy, ISBN 1-55860-329-8.  I have the second edition
which was updated in '96.  It's an excellent book and think that if all
the members of this list read it and understood it, that would be of
enormous benefit.  It's a hardware book, but I'm of the school that says
OS people are part hardware people and should have more than a passing
understanding of hardware.

The chapter you want is Chapter 8: multiprocessors.  But read the whole
thing, it's one of the most approachable yet useful texts in the field.
Contrast it to Knuth's work, which are without a doubt the definitive
works in his area, but are also not at all for the faint of heart.
I personally can rarely make head or tail of what Knuth is saying
without some outside help, but I can understand all of P&H on my own -
you can too.

: OK, if a thread accesses (I assume writes, reading isn't destructive, is
: it?) a memory location that another processor is "interested" in, then
: you've invalidated that processor's local cache - so it has to be flushed
: and refreshed. 

Reading is better than writing, lots of people can read.  Where they
read from depends on if the L2 caches are write through or write back
(L1 caches I believe are 100% write through, I can't really see how a
write back one would ever work even on a uniprocessor unless all I/O's
caused a cache flush).

If you did your caches correctly, and you are using a snooping protocol,
then typically what happens is CPU 1 puts a request for location X on
the bus; CPU 5 has that data in a dirty cache line; CPU 5 invalidates 
the memory op and responds as if it were memory, saying here's X.
(It's not the CPUs at all, by the way, it's the cache controllers.
They are quite async when compared to CPUs, though there are a lot of
interdependencies).

I believe it was the SGI Challenge which had a busted cache controller 
and had to do a write back to main memory and then a read, causing
cache to cache transactions to actually be cache to memory, memory
to cache (which really hurts).

: Have enough cross-talk between threads, and you can achieve
: the worst-case scenario where every memory access flushes the cache of
: every processor, totally defeating the purpose of the cache, and perhaps
: even adding nontrivial cache-flushing overhead.

Yes, indeed.  At SGI, where they had a very finely threaded kernel, cache
misses in the OS became a major bottleneck and they did a great deal of
restructuring to make things work better.  The most typical thing was to
put the lock and the data most likely to be needed on the same cache line.
I.e.,

	struct widget {
		rwlock	w_lock;
		int	flags;
		struct	widget *next;
		/* more data after this */
	};

and then they would do

	for (p = list;
	    (read_lock(p) == OK) && (p->flags != whatever);
	    t = p->next, read_unlock(p), p = t);

with the idea being that the common case was that one cache line miss would
get you the lock and the data that you most cared about.

This, by the way, is a REALLY STUPID IDEA.  If you are locking at
this level, you really need to be looking for other ways to scale up
your system.   You're working like crazy to support a model that the
hardware can't really support.  As a part hardware and part software guy,
it breaks my heart to see the hardware guys bust their butts to give you
a system that works, only to watch the software guys abuse the sh*t out
of the system and make it look bad.  On the other side of the coin, the
hardware guys do advertise this stuff as working and only later come out
and explain the limitations.

A great case in point is that the hardware guys, when they first started
doing SMP boxes, talked about how anything could run anywhere.  Later,
they discovered that this was really false.  They never said that, they
wrote a bunch of papers on ``cache affinity'' which is a nice way of 
saying ``when you put a process on a CPU/cache, don't move it unless the
world will come to an end if you leave it there''.  Mark Hahn's equations
that he psoted about the scheduler have everything to do with this concept,
you have built up some state in the cache and the last thing you want to do
is have to rebuild it somewhere else.

This is an area, sorry to pick on them again, that SGI just completely
screwed up in their scheduler.  The simple and right answer is to put
processes on a CPU and leave them there until the system is dramatically
unbalanced.  The complicated and slow thing to do is to rethink the
decision at every context switch.  The SGI scheduler got it upside down,
you had to prove that you needed to stay on a cache rather than prove that
you needed to move.  So I/O bound jobs got screwed because they never 
ran long enough to have built up what was considered a cache foot print
so they were always consider candidates for movement.  I got substantial
improvements in BDS (an extension to NFS that did ~ 100Mbyte/sec I/O)
by locking the BDS daemons down to individual processors, something the
scheduler could have trivially done correctly itself.

: If this is indeed the case (please correct any misconceptions I have) then
: it strikes me that perhaps the hardware design of SMP is broken. That
: instead of sharing main memory, each processor should have it's own main
: memory. You connect the various main memory chunks to the "primary" CPU via
: some sort of very wide, very fast memory bus, and then when you spawn a
: thread, you instead do something more like a fork - copy the relevent
: process and data to the child cpu's private main memory (perhaps via some
: sort of blitter) over this bus, and then let that CPU go play in its own
: sandbox for a while.

What you have described is an SGI Origin.  Each node in an origin looks like

			[ 2x R10K CPU ]
			      |
		 memory ------+-------- I/O
		              |
			      |
	    interconnect to the rest of the nodes

Each card had 2 cpus, some memory, an I/O bus, and an interconnect bus
which connected the card to the rest of the system in a hypercube fabric
(think of that as a more scalable thing than a bus; more scalable yes,
but with a slight penalty for remote memory access).

The memory coherency was directory based rather than snoopy (snoopy
works when all caches see all transactions, but that doesn't scale.
Directory would appear to scale farther but guess what - the OS locks
completely thrashed the sh*t out of the directories, once again proving
that the illusion of shared, coherent memory if a false one).

Anyway, another thing that didn't work was moving memory.  This is called
"page migration" and the problem with it is that the work that you do
has to substantially outweigh the cost of moving the page in the first
place and it usually doesn't.  So in practice, at SGI and at customers,
the migration idea didn't pay off.  Maybe things have changed since I
left, my info is pretty dated.  I kind of doubt it but there must be
some SGI folks reading this who are willing to correct me.

: Which really is more like the "array of uni-processor boxen joined by a
: network" model than it is current SMP - just with a REALLY fast&wide
: network pipe that just happens to be in the same physical box.

Yup.  Take a look at the book and the short papers I pointed to the other
day.  You'll see a lot in both along these lines.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

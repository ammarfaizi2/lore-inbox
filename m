Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272374AbRH3R4a>; Thu, 30 Aug 2001 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272372AbRH3R4V>; Thu, 30 Aug 2001 13:56:21 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:56583 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272374AbRH3R4D>; Thu, 30 Aug 2001 13:56:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Thu, 30 Aug 2001 20:02:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com> <20010829232929Z16206-32383+2351@humbolt.nl.linux.org> <20010830164634.3706d8f8.skraw@ithnet.com>
In-Reply-To: <20010830164634.3706d8f8.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010830175615Z16280-32384+1119@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 30, 2001 04:46 pm, Stephan von Krawczynski wrote:
> On Thu, 30 Aug 2001 01:36:10 +0200
> Daniel Phillips <phillips@bonn-fries.net> wrote:
> 
> > > Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
> > > Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
> >
> > OK, I see what the problem is.  Regular memory users are consuming memory
> > right down to the emergency reserve limit, beyond which only PF_MEMALLOC
> > users can go.  Unfortunately, since atomic memory allocators can't wait,
> > they tend to fail with high frequency in this state.  Duh.
> 
> Aehm, excuse my ignorance, but why is a "regular memory user" effectively
> _consuming_ the memory? I mean how does CD reading and NFS writing 
> _consume_ memory (to such an extent)? Where _is_ this memory gone?

In essence, the memory isn't consumed, it's bound to data.  Once we have
data sitting on a page it's to our advantage to try to keep the page
around as long as possible so it doesn't have to be re-read if we need it
again.  So the normal situation is, we run with as little memory actually
free and empty of data as possible, around 1-2%.

But there's a distinction between "free" and "freeable".  Of the remaining
98% of memory, most of it is freeable.  This is fine if your memory
request is able to wait for the vm to go out and free some.  This happens
often, and while the preliminary scanning work is being done the system
tends to sit there in its absolute rock-bottom memory state (zone->pages
== zone->min).  Along comes an interrupt with a memory allocation request
and it must fail, because it can't wait.

> If I 
> stop I/O the memory is still gone. I can make at least quite a bit appear 
> again as free, if I delete all the files I have copied via NFS before. 
> After that I receive lots of free mem right away. Why?

Because the cached data pages are forcibly removed from the page cache and
freed, since the data can never be referenced again.

> I would not expect 
> the memory as validly consumed by knfsd during writing files. I mean what 
> for? I guess from "Inact_dirty" list being _huge_, that the mem is in fact 
> already freed again by the original allocator, but the vm holds it, until 
> ... well I don't know. Or am I wrong?

I hope it's clearer now.

> > First, there's an effective way to make these particular atomic failures
> > go away almost entirely.  The atomic memory user (in this case a network
> > interrupt handler) keeps a list of pages for its private use, starting with
> > an empty list.  Each time it needs a page it gets it from its private list,
> > but if that list is empty it gets it from alloc_pages, and when done with
> > it, returns it to its private list.  The alloc_pages call can still fail of
> > course, but now it will only fail a few times as it expands its list up to
> > the size required for normal traffic.  The effect on throughput should be
> > roughly nothing.
> 
> Uh, I would not do that. To a shared memory pool system this is really 
> contra-productive (is this english?). You simply let the mem vanish in some 
> private pools, so only _one_ process (or whatever) can use it.

It's not very much memory, that's the point.  But it sure hurts if it's not
available at the time it's needed.

> To tell the 
> full truth, you do not even know, if he really uses it. If he allocated it 
> in a heavy load situation and does not give it back (or has his own weird 
> strategy of returning it) you run out of mem only because of one flaky 
> driver. It will not be easy as external spectator of a driver to find out 
> if it performs well or has some memory leakage inside. You simply can't 
> tell.  In fact I do trust kernel mem management more :-), even if it isn't 
> performing very well currently.

Keep in mind we're solving an impossible problem here.  We have a task that
can't wait, but needs an unknown (to the system) amount of memory.  We dance
around this by decreeing that the allocation can fail, and the interrupt
handler has to be able to deal with that.  Well, that works, but often not
very fast.  In the network subsystem it translates into dropped packets.
That's very, very bad if it happens often.  So it's ok to use a little memory
in a less-than-frugal way if we reduce the frequency of packet dropping.

> > Let's try another way of dealing with it.  What I'm trying to do with the
> > patch below is leave a small reserve of 1/12 of pages->min, above the
> > emergency reserve, to be consumed by non-PF_MEMALLOC atomic allocators.
> > Please bear in mind this is completely untested, but would you try it
> > please and see if the failure frequency goes down?
> 
> Well, I will try. But must honestly mention, that the whole idea looks like 
> a patch to patch a patch. Especially because nobody can tell what the right 
> reserve may be. I guess this may very much depend on host layout. How do 
> you want to make an acceptable kernel-patch for all the world out of this 
> idea? The idea sounds obvious, but looks not very helpful for solving the 
> basic problem.

Lets see what it does.  I'd be the last to claim it's a pretty or efficient
way to express the idea.  The immediate goal is to determine if I analyzed 
the problem correctly, and if the logic of the patch is correct.

--
Daniel

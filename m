Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318177AbSHDRfJ>; Sun, 4 Aug 2002 13:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318184AbSHDRfJ>; Sun, 4 Aug 2002 13:35:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:63946 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318177AbSHDRfH>;
	Sun, 4 Aug 2002 13:35:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com
Subject: Re: large page patch (fwd) (fwd)
Date: Sun, 4 Aug 2002 13:31:24 -0400
User-Agent: KMail/1.4.1
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
References: <20020802.222024.21061449.davem@redhat.com> <Pine.LNX.4.44.0208031027330.3981-100000@home.transmeta.com> <20020803.172836.60864598.davem@redhat.com>
In-Reply-To: <20020803.172836.60864598.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208041331.24895.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 08:28 pm, David S. Miller wrote:
>    From: Linus Torvalds <torvalds@transmeta.com>
>    Date: Sat, 3 Aug 2002 10:35:00 -0700 (PDT)
>
>    David, you did page coloring once.
>
>    I bet your patches worked reasonably well to color into 4 or 8 colors.
>
>    How well do you think something like your old patches would work if
>
>     - you _require_ 1024 colors in order to get the TLB speedup on some
>       hypothetical machine (the same hypothetical machine that might
>       hypothetically run on 95% of all hardware ;)
>
>     - the machine is under heavy load, and heavy load is exactly when you
>       want this optimization to trigger.
>
>    Can you explain this difficulty to people?
>
> Actually, we need some clarification here.  I tried coloring several
> times, the problem with my diffs is that I tried to do the coloring
> all the time no matter what.
>
> I wanted strict coloring on the 2-color level for broken L1 caches
> that have aliasing problems.  If I could make this work, all of the
> dumb cache flushing I have to do on Sparcs could be deleted.  Because
> of this, I couldn't legitimately change the cache flushing rules
> unless I had absolutely strict coloring done on all pages where it
> mattered (basically anything that could end up in the user's address
> space).
>
> So I kept track of color existence precisely in the page lists.  The
> implementation was fast, but things got really bad fragmentation wise.
>
> No matter how I tweaked things, just running a kernel build 40 or 50
> times would fragment the free page lists to shreds such that 2-order
> and up pages simply did not exist.
>
> Another person did an implementation of coloring which basically
> worked by allocating a big-order chunk and slicing that up.  It's not
> strictly done and that is why his version works better.  In fact I
> like that patch a lot and it worked quite well for L2 coloring on
> sparc64.  Any time there is page pressure, he tosses away all of the
> color carving big-order pages.
>
>    I think we can at some point do the small cases completely
> transparently, with no need for a new system call, and not even any new
> hint flags. We'll just silently do 4/8-page superpages and be done with it.
> Programs don't need to know about it to take advantage of better TLB usage.
>
> Ok.  I think even 64-page ones are viable to attempt but we'll see.
> Most TLB's that do superpages seem to have a range from the base
> page size to the largest supported superpage with 2-powers of two
> being incrememnted between each supported size.
>
> For example on Sparc64 this is:
>
> 8K	PAGE_SIZE
> 64K	PAGE_SIZE * 8
> 512K	PAGE_SIZE * 64
> 4M	PAGE_SIZE * 512
>
> One of the transparent large page implementations just defined a
> small array that the core code used to try and see "hey how big
> a superpage can we try" and if the largest for the area failed
> (because page orders that large weren't available) it would simply
> fall back to the next smallest superpage size.


Well, that's exactly what we do !!!!

We also ensure that if one process opens with basic page size and 
the next one opens with super page size that we appropriately map
the second one to smaller pages to avoid conflict in case of shared
memory or memory mapped files.

As of the page coloring !
Can we tweak the buddy allocator to give us this additional functionality?
Seems like we can have a free-list per color and if that's empty we go back to
the buddy sys. There we should be able to do some magic based on the bit maps
to figure out where which page is to be used that fits the right color?

Fragmentation is an issue.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)



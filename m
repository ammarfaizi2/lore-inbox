Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSHDAi0>; Sat, 3 Aug 2002 20:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSHDAi0>; Sat, 3 Aug 2002 20:38:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15795 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318040AbSHDAiZ>;
	Sat, 3 Aug 2002 20:38:25 -0400
Date: Sat, 03 Aug 2002 17:28:36 -0700 (PDT)
Message-Id: <20020803.172836.60864598.davem@redhat.com>
To: torvalds@transmeta.com
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, gh@us.ibm.com,
       frankeh@watson.ibm.com, Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd) 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208031027330.3981-100000@home.transmeta.com>
References: <20020802.222024.21061449.davem@redhat.com>
	<Pine.LNX.4.44.0208031027330.3981-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sat, 3 Aug 2002 10:35:00 -0700 (PDT)

   David, you did page coloring once.
   
   I bet your patches worked reasonably well to color into 4 or 8 colors.
   
   How well do you think something like your old patches would work if
   
    - you _require_ 1024 colors in order to get the TLB speedup on some
      hypothetical machine (the same hypothetical machine that might
      hypothetically run on 95% of all hardware ;)
   
    - the machine is under heavy load, and heavy load is exactly when you
      want this optimization to trigger.
   
   Can you explain this difficulty to people?
   
Actually, we need some clarification here.  I tried coloring several
times, the problem with my diffs is that I tried to do the coloring
all the time no matter what.

I wanted strict coloring on the 2-color level for broken L1 caches
that have aliasing problems.  If I could make this work, all of the
dumb cache flushing I have to do on Sparcs could be deleted.  Because
of this, I couldn't legitimately change the cache flushing rules
unless I had absolutely strict coloring done on all pages where it
mattered (basically anything that could end up in the user's address
space).

So I kept track of color existence precisely in the page lists.  The
implementation was fast, but things got really bad fragmentation wise.

No matter how I tweaked things, just running a kernel build 40 or 50
times would fragment the free page lists to shreds such that 2-order
and up pages simply did not exist.

Another person did an implementation of coloring which basically
worked by allocating a big-order chunk and slicing that up.  It's not
strictly done and that is why his version works better.  In fact I
like that patch a lot and it worked quite well for L2 coloring on
sparc64.  Any time there is page pressure, he tosses away all of the
color carving big-order pages.

   I think we can at some point do the small cases completely transparently,
   with no need for a new system call, and not even any new hint flags. We'll
   just silently do 4/8-page superpages and be done with it. Programs don't
   need to know about it to take advantage of better TLB usage.
   
Ok.  I think even 64-page ones are viable to attempt but we'll see.
Most TLB's that do superpages seem to have a range from the base
page size to the largest supported superpage with 2-powers of two
being incrememnted between each supported size.

For example on Sparc64 this is:

8K	PAGE_SIZE
64K	PAGE_SIZE * 8
512K	PAGE_SIZE * 64
4M	PAGE_SIZE * 512

One of the transparent large page implementations just defined a
small array that the core code used to try and see "hey how big
a superpage can we try" and if the largest for the area failed
(because page orders that large weren't available) it would simply
fall back to the next smallest superpage size.

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316830AbSEVCb3>; Tue, 21 May 2002 22:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSEVCb2>; Tue, 21 May 2002 22:31:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39632 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316830AbSEVCb1>;
	Tue, 21 May 2002 22:31:27 -0400
Date: Tue, 21 May 2002 19:17:24 -0700 (PDT)
Message-Id: <20020521.191724.56166460.davem@redhat.com>
To: torvalds@transmeta.com
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.17
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205211752350.3589-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Tue, 21 May 2002 17:54:18 -0700 (PDT)

   That's the big one, actually. The exit case we _could_ do very differently
   anyway, and there are reasons that we probably should try to.
   
   (When we exit, we could flush the TLB and at the same time do a
   "speculative" switch to the mm of the next process on the run-queue of
   this CPU, so that when we actually tear down the MM we would have no TLB
   issues at all any more).

I think deferring this to the lazy TLB end at the next task switch is
worth pursuing.

I always wanted to also explore way to speed up these pieces of code
we have which walk the page table tree to kill everything off.
Something simple like a very small bitmap in the mm_struct.  It would
work by keeping track of which areas of the address space actually
have some mappings present.  The set bits would be kept track of
pessimistically, to keep it fast and simple.

So when you add a page mapping somewhere you'd go:

	set_mapping_bit(mm, address);

Then exit_mmap() would only traverse into parts of the page
tables where mappings actually existed.

Similarly for copy_page_range when dup'ing an address space.

This stuff shows up clearly on the fork/exit/exec microbenchmark
profiles.

Like I said, keep the bitmap very small, perhaps 4 unsigned longs
at the most.

Actually, what this suggests is that we blow away the page table
flushing guts of exit_mmap() and just have this
"anihilate_address_space()" thing that is %100 arch-specific and can
be used to optimize this as much as a platform wants to.  We can even
provide a "boring" generic implementation protected by
HAVE_ARCH_ANIHILATE_ADDRESS_SPACE that basically looks like what we
have there today.  (The interface name sucks, I know, sorry, we'll
will have to come up with a nicer name :-)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSLJJoG>; Tue, 10 Dec 2002 04:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbSLJJoG>; Tue, 10 Dec 2002 04:44:06 -0500
Received: from holomorphy.com ([66.224.33.161]:57755 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264647AbSLJJoF>;
	Tue, 10 Dec 2002 04:44:05 -0500
Date: Tue, 10 Dec 2002 01:51:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: george anzinger <george@mvista.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
Message-ID: <20021210095118.GG9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, george anzinger <george@mvista.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3DB9A314.6CECA1AC@mvista.com> <3DF2F965.59D7CD84@mvista.com> <3DF3D706.977AC5BB@digeo.com> <3DF4487C.67FD90EF@mvista.com> <3DF44E98.DD173EE8@digeo.com> <3DF5A62C.242E171@mvista.com> <3DF5B2D1.FD134082@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF5B2D1.FD134082@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 01:24:33AM -0800, Andrew Morton wrote:
> A simple way of doing the "find an empty slot" is to descend the
> tree, following the trail of nodes which have `count < 64' until
> you hit the bottom.  At each node you'll need to walk the slots[]
> array to locate the first empty one.
> That's quite a few cache misses.  It can be optimised by adding
> a 64-bit DECLARE_BITMAP to struct radix_tree_node.  This actually
> obsoletes `count', because you can just replace the test for
> zero count with a test for `all 64 bits are zero'.

I found that ffz() to find the index of the not-fully-populated child
node to search was efficient enough to provide a precisely K == 2*levels
constant within the O(1) for accesses in all non-failure cases.
Measuring by cachelines it would have been superior to provide a
cacheline-sized node at each level and perform ffz by hand.


On Tue, Dec 10, 2002 at 01:24:33AM -0800, Andrew Morton wrote:
> Such a search would be an extension to or variant of radix_tree_gang_lookup.
> Something like the (old, untested) code below.
> But it's a big job.  First thing to do is to write a userspace
> test harness for the radix-tree code.  That's something I need to
> do anyway, because radix_tree_gang_lookup fails for offests beyond
> the 8TB mark, and it's such a pita fixing that stuff in-kernel.

Userspace test harnesses are essential for this kind of work. They
were for several of mine.


Bill

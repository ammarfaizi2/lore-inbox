Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSLJXc2>; Tue, 10 Dec 2002 18:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266444AbSLJXc2>; Tue, 10 Dec 2002 18:32:28 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:35824 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265689AbSLJXc1>;
	Tue, 10 Dec 2002 18:32:27 -0500
Message-ID: <3DF67B41.4BC0254B@mvista.com>
Date: Tue, 10 Dec 2002 15:39:45 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
References: <3DB9A314.6CECA1AC@mvista.com> <3DF2F965.59D7CD84@mvista.com> <3DF3D706.977AC5BB@digeo.com> <3DF4487C.67FD90EF@mvista.com> <3DF44E98.DD173EE8@digeo.com> <3DF5A62C.242E171@mvista.com> <3DF5B2D1.FD134082@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> george anzinger wrote:
> >
> > ...
> > > radix-trees do not currently have a "find next empty slot from this
> > > offset" function but that is quite straightforward.  Not quite
> > > as fast, unless an occupancy bitmap is added to the radix-tree
> > > node.  That's something whcih I have done before - in fact it was
> > > an array of occupancy maps so I could do an efficient in-order
> > > gang lookup of "all dirty pages from this offset" and "all locked
> > > pages from this offset".  It was before its time, and mouldered.
> >
> > Gosh, I think this is what I have.  Is it already in the
> > kernel tree somewhere?  Oh, I found it.  I will look at
> > this, tomorrow...
> >
> 
> A simple way of doing the "find an empty slot" is to descend the
> tree, following the trail of nodes which have `count < 64' until
> you hit the bottom.  At each node you'll need to walk the slots[]
> array to locate the first empty one.
> 
> That's quite a few cache misses.  It can be optimised by adding
> a 64-bit DECLARE_BITMAP to struct radix_tree_node.  This actually
> obsoletes `count', because you can just replace the test for
> zero count with a test for `all 64 bits are zero'.

Uh, I tried something like this.  The flaw is that the count
is a count of used slots at in that node and does not say
anything about slots in any nodes below that one.  In my
tree the bit map is an indication of empty leaf node slots. 
This means that when a leaf slot becomes free it needs to be
reflected in each node in the path to that leaf and when a
leaf node fills, that also needs to be reflected in each
node in the path.
> 
> Such a search would be an extension to or variant of radix_tree_gang_lookup.
> Something like the (old, untested) code below.
> 
> But it's a big job.  First thing to do is to write a userspace
> test harness for the radix-tree code.  That's something I need to
> do anyway, because radix_tree_gang_lookup fails for offests beyond
> the 8TB mark, and it's such a pita fixing that stuff in-kernel.
> 
> Good luck ;)

Hm, the question becomes: 
a.)Should I add code to the radix-tree to make it do what I
need and, most likely take longer and be harder to debug, or
b.)Should I just enhance what I have to remove the
recursion, which should be rather easy to do and test, even
in kernel land?
> 
> .

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

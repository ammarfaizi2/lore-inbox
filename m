Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbSLFFRv>; Fri, 6 Dec 2002 00:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267603AbSLFFRv>; Fri, 6 Dec 2002 00:17:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:47786 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267602AbSLFFRu>;
	Fri, 6 Dec 2002 00:17:50 -0500
Message-ID: <3DF034BB.D5F863B5@digeo.com>
Date: Thu, 05 Dec 2002 21:25:15 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrea Arcangeli <andrea@suse.de>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 05:25:19.0531 (UTC) FILETIME=[DDF9CFB0:01C29CE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> Yes, it's necessary; no, I've never directly encountered the issue it
> fixes. Sorry about the miscommunication there.

The google thing.

The basic problem is in allowing allocations which _could_ use
highmem to use the normal zone as anon memory or pagecache.

Because the app could mlock that memory.   So for a simple
demonstration:

- mem=2G
- read a 1.2G file
- malloc 800M, now mlock it.

Those 800M will be in ZONE_NORMAL, simply because that was where the
free memory was.  And you're dead, even though you've only mlocked
800M.  The same thing happens if you have lots of anon memory in the
normal zone and there is no swapspace available.

Linus's approach was to raise the ZONE_NORMAL pages_min limit for
allocations which _could_ use highmem.  So a GFP_HIGHUSER allocation
has a pages_min limit of (say) 4M when considering the normal zone,
but a GFP_KERNEL allocation has a limit of 2M.

Andrea's patch does the same thing, via a separate table.   He has
set the threshold much higher (100M on a 4G box).   AFAICT, the
algorithms are identical - I was planning on just adding a multiplier
to set Linus's ratio - it is currently hardwired to "1".   Search for 
"mysterious" in mm/page_alloc.c ;)

It's not clear to me why -aa defaults to 100 megs when the problem
only occurs with no swap or when the app is using mlock.  The default
multiplier (of variable local_min) should be zero.  Swapless machines
or heavy mlock users can crank it up.

But mlocking 700M on a 4G box would kill it as well.  The google
application, IIRC, mlocks 1G on a 2G machine.  Daniel put them
onto the 2G+2G split and all was well.

Anyway, thanks.   I'll take another look at Andrea's implementation.

Now, regarding mlock(mmap(open(/dev/hda1))) ;)

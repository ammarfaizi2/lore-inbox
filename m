Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267670AbSLGAO7>; Fri, 6 Dec 2002 19:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267671AbSLGAO7>; Fri, 6 Dec 2002 19:14:59 -0500
Received: from [195.223.140.107] ([195.223.140.107]:27266 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267670AbSLGAOy>;
	Fri, 6 Dec 2002 19:14:54 -0500
Date: Sat, 7 Dec 2002 01:22:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021207002232.GW4335@dualathlon.random>
References: <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com> <3DF13A54.927C04C1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF13A54.927C04C1@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 04:01:24PM -0800, Andrew Morton wrote:
> William Lee Irwin III wrote:
> > 
> > ...
> > A 16KB or 64KB kernel allocation unit would then annihilate
> 
> You want to be careful about this:
> 
> 	CPU: L1 I cache: 16K, L1 D cache: 16K
> 
> Because instantiating a 16k page into user pagetables in
> one hit means that it must all be zeroed.  With these large
> pagesizes that means that the application is likely to get
> 100% L1 misses against the new page, whereas it currently
> gets 100% hits.
> 
> I'd expect this performance dropoff to occur when going from 8k
> to 16k.  By the time you get to 32k it would be quite bad.
> 
> One way to address this could be to find a way of making the
> pages present, but still cause a fault on first access.  Then
> have a special-case fastpath in the fault handler to really wipe
> the page just before it is used.  I don't know how though - maybe
> _PAGE_USER?

I think taking the page fault itself is the biggest overhead that would
be nice to avoid on every second virtually consecutive page, if we've to
take the page fault on every page we could as well do the rest of the
work that should not that big compared to the overhead of
entering/exiting kernel and preparing to handle the fault.

> 
> get_user_pages() would need attention too - you don't want to
> allow the user to perform O_DIRECT writes of uninitialised
> pages to their files...


Andrea

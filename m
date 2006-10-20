Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992732AbWJTWvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992732AbWJTWvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423324AbWJTWvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:51:03 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:17845 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1422831AbWJTWvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:51:00 -0400
Date: Fri, 20 Oct 2006 23:51:18 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
       linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
       James.Bottomley@SteelEye.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061020225118.GA30965@linux-mips.org>
References: <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org> <20061020214916.GA27810@linux-mips.org> <Pine.LNX.4.64.0610201500040.3962@g5.osdl.org> <20061020.152247.111203913.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020.152247.111203913.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 03:22:47PM -0700, David Miller wrote:

> > On Fri, 20 Oct 2006, Ralf Baechle wrote:
> > > When I delete the call (not part of my patchset) it means 12% faster 
> > > fork.  But I'm not proposing this for 2.6.19.
> > 
> > I just suspect it means a _buggy_ fork.
> > 
> > It so happens (I think), that fork is big enough that it probably flushes 
> > the L1 cache _anyway_. 

I doubt it; I've tested this on 64K I-cache VIPT, 64K D-cache VIPT.

> My understanding is that this works because in Ralf's original patch
> (which is the context in which he is removing the flush_cache_mm()
> call), he uses kmap()/kunmap() to map the page(s) being accessed at a
> kernel virtual address which will fall into the same cache color as
> the user virtual address --> no alias problems.
>
> Since he does this for every page touched on the kernel side during
> dup_mmap(), the existing flush_cache_mm() call in dup_mmap() does in
> fact become redundant.

Correct.

It means no cache flush operation to deal with aliases at all left in
fork and COW code.

Another advantage of this strategy is that we will never have to handle
less virtual coherency exceptions.  A virtual coherency exception is raised
on some MIPS processors when they detect the creation of a cache alias.
This allows the software to cleanup caches.  Neat as an alarm system for
alias debugging but rather expensive to service if large numbers are
raised, not available on all processors and also detects the creation of
harmless aliases of clean lines, thus a slight annoyance.

  Ralf

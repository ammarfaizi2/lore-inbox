Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTEaIRa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTEaIRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:17:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:24866 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S264218AbTEaIR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:17:29 -0400
Date: Sat, 31 May 2003 09:33:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Russell King <rmk@arm.linux.org.uk>
cc: Jun Sun <jsun@mvista.com>, <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Properly implement flush_dcache_page in 2.4?  (Or is it
    possible?)
In-Reply-To: <20030531085248.A19071@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305310919090.1481-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Russell King wrote:
> On Sat, May 31, 2003 at 08:24:00AM +0100, Hugh Dickins wrote:
> > On Sat, 31 May 2003, Russell King wrote:
> > > 
> > > I don't see a reason to worry about privately mapped pages on the i_mmap
> > > list since they are private, and therefore shouldn't be updated with
> > > modifications to other mappings, which I'd have thought would include
> > > writes to the file (although I'm not so sure atm.)
> > 
> > Be not so sure.  vmas on the private i_mmap list can still contain
> > shared pages, which should see writes to the file; but of course their
> > already-COWed private pages won't see subsequent writes to the file.
> 
> Hmm, looking at the posix spec (do we follow POSIX for mmap?) the
> behaviour of MAP_PRIVATE mappings when the underlying file is modified
> is unspecified.
> 
> I guess missing the cache handling for such mappings fits the POSIX
> spec, and is equally as yucky as the current behaviour on CPUs which
> don't require these flushes.
> 
> (unless someone tells me that POSIX is on drugs, I'm not going to be
> that bothered about the MAP_PRIVATE case.)

I was about to concede to you: just because the pages are shared doesn't
mean that _you_ have to be overanxious about immediately forcing changes
to be visible to userspace (though it would be unfriendly if updates were
to appear at lesser granularity than PAGE_SIZE: I've no idea whether
that's a possibility), the "unspecified" would allow that much - but
wouldn't allow you to show portions of entirely other files!

But I've just remembered the peculiar VM_SHARED handling in mm/mmap.c:
open a file O_RDONLY, mmap it PROT_READ MAP_SHARED, and the vma will be
put on the i_mmap list, not on the i_mmap_shared list.  So the i_mmap
list can actually contain shared mappings, not just private mappings.
Poor naming certainly: the i_mmap_shared list is for mappings though
which the object might be modified.

Hugh


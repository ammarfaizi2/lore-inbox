Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUBCWy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 17:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUBCWy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 17:54:57 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:58279 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S266153AbUBCWyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 17:54:55 -0500
Date: Tue, 3 Feb 2004 16:54:53 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Subject: avoiding dirty code pages with fixups
Message-ID: <20040203225453.GB18320@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The discussion of vsyscall got me thinking along a slightly different
line.  Since disks are *so* slow, and CPUs are so damn fast, the
tradeoff between computation and IO is different today than it was ten
years ago.  This means it can be fruitful to revisit issues which were
solved in a particular way, back then.

I think I just came up with a novel way to handle code fixups.  First, I
need a way to make a private "throwaway" copy of a page.  Define a new
mmap flag, MAP_SCRATCH.  This is sorta like MAP_PRIVATE, but instead of
writing the dirty page out to the swapfile, I want the page never to
leave RAM.  If the kernel decides to evict the page, it should just drop
it and invalidate the virtual address range.  When my program faults it
back in, provide me with the contents of the page *as they exist in the
backing file*.

Next, I need a way to read and write sizeof(void*) bytes atomicly (with
respect to the above eviction protocol).  Ideally, all icache reads and
all aligned sizeof(void*) reads would be atomic WRT MAP_SCRATCH.


The technique is as follows.  Suppose we have a library which contains a
page which contains a jmp that needs a fixup.  Map the library with
MAP_SCRATCH, and have the un-fixed-up code contain a jmp to the
appropriate code in ld.so which will perform the fixup.  The first time
the code is executed, ld.so writes into the page, triggering a COW, and
cloning a scratch copy of the page, which can then be populated with all
the needed fixups.  Until the kernel evicts the page, further
invocations of the code will result in direct jumps to the fixed-up
addresses.

When the kernel evicts the page, all the fixups are lost.

When the app faults the page back in, the fixups are gone.  The fixup
code executes again, exactly as it did in the first time the app invoked
that library page, giving correct results.

The benefit over standard MAP_PRIVATE fixups is that we can avoid IO
when many processes have fixups on the same page of libc.so (for
example).  With the current MAP_PRIVATE scheme, the page is written out
to swap *once for every process that has it fixed-up*.  With
MAP_SCRATCH, the page is never written out to swap.  Instead it's read
off the filesystem, once, when the first process faults it in; the
cached copy is used for every process that needs it.

The downside is the additional computation on page-in.  It is a function
of how many fixups there are per page, and of how much work ld.so does
to satisfy a fixup.  I don't have a good feel for how expensive ld.so's
fixup mechanism is... any comments?

(Now I just need to find somebody to code this.)

-andy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbULWXBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbULWXBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 18:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbULWXBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 18:01:21 -0500
Received: from ozlabs.org ([203.10.76.45]:27372 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261330AbULWXAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 18:00:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16843.19972.17026.69228@cargo.ozlabs.ibm.com>
Date: Fri, 24 Dec 2004 10:00:20 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@sgi.com, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
In-Reply-To: <20041223133745.1d95bb08.akpm@osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	<41C20E3E.3070209@yahoo.com.au>
	<Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
	<16843.13418.630413.64809@cargo.ozlabs.ibm.com>
	<20041223133745.1d95bb08.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> When the workload is a gcc run, the pagefault handler dominates the system
> time.  That's the page zeroing.

For a program which uses a lot of heap and doesn't fork, that sounds
reasonable.

> x86's movnta instructions provide a way of initialising memory without
> trashing the caches and it has pretty good bandwidth, I believe.  We should
> wire that up to these patches and see if it speeds things up.

Yes.  I don't know the movnta instruction, but surely, whatever scheme
is used, there has to be a snoop for every cache line's worth of
memory that is zeroed.

The other point is that having the page hot in the cache may well be a
benefit to the program.  Using any sort of cache-bypassing zeroing
might not actually make things faster, when the user time as well as
the system time is taken into account.

> > I did some measurements once on my G5 powermac (running a ppc64 linux
> > kernel) of how long clear_page takes, and it only takes 96ns for a 4kB
> > page.
> 
> 40GB/s.  Is that straight into L1 or does the measurement include writeback?

It is the average elapsed time in clear_page, so it would include the
writeback of any cache lines displaced by the zeroing, but not the
writeback of the newly-zeroed cache lines (which we hope will be
modified by the program before they get written back anyway).

This is using the dcbz (data cache block zero) instruction, which
establishes a cache line in modified state with zero contents without
any memory traffic other than a cache line kill transaction sent to
the other CPUs and possible writeback of a dirty cache line displaced
by the newly-zeroed cache line.  The new cache line is established in
the L2 cache, because the L1 is write-through on the G5, and all
stores and dcbz instructions have to go to the L2 cache.

Thus, on the G5 (and POWER4, which is similar) I don't think there
will be much if any benefit from having pre-zeroed cache-cold pages.
We can establish the zero lines in cache much faster using dcbz than
we can by reading them in from main memory.  If the program uses only
a few cache lines out of each new page, then reading them from memory
might be faster, but that seems unlikely.

Paul.

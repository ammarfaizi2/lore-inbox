Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264376AbRGCMsC>; Tue, 3 Jul 2001 08:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264352AbRGCMrw>; Tue, 3 Jul 2001 08:47:52 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:11524 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S264300AbRGCMrj>;
	Tue, 3 Jul 2001 08:47:39 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15169.48856.428247.217216@cargo.ozlabs.ibm.com>
Date: Tue, 3 Jul 2001 22:47:20 +1000 (EST)
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about kmap_high function
In-Reply-To: <20010703103809.A29868@redhat.com>
In-Reply-To: <3620762046.20010629150601@turbolinux.com.cn>
	<20010703103809.A29868@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie writes:

> kmap_high is intended to be called routinely for access to highmem
> pages.  It is coded to be as fast as possible as a result.  TLB
> flushes are expensive, especially on SMP, so kmap_high tries hard to
> avoid unnecessary flushes.

The code assumes that flushing a single TLB entry is expensive on SMP,
while flushing the whole TLB is relatively cheap - certainly cheaper
than flushing several individual entries.  And that assumption is of
course true on i386.

On PPC it is a bit different.  Flushing a single TLB entry is
relatively cheap - the hardware broadcasts the TLB invalidation on the
bus (in most implementations) so there are no cross-calls required.  But
flushing the whole TLB is expensive because we (strictly speaking)
have to flush the whole of the MMU hash table as well.

The MMU gets its PTEs from a hash table (which can be very large) and
we use the hash table as a kind of level-2 cache of PTEs, which means
that the flush_tlb_* routines have to flush entries from the MMU hash
table as well.  The hash table can store PTEs from many contexts, so
it can have a lot of PTEs in it at any given time.  So flushing the
whole TLB would imply going through every single entry in the hash
table and clearing it.  In fact, currently we cheat - flush_tlb_all
actually only flushes the kernel portion of the address space, which
is all that is required in the three places where flush_tlb_all is
called at the moment.

This is not a criticism, rather a request that we expand the
interfaces so that the architecture-specific code can make the
decisions about when and how to flush TLB entries.

For example, I would like to get rid of flush_tlb_all and define a
flush_tlb_kernel_range instead.  In all the places where flush_tlb_all
is currently used, we do actually know the range of addresses which
are affected, and having that information would let us do things a lot
more efficiently on PPC.  On other platforms we could define
flush_tlb_kernel_range to just flush the whole TLB, or whatever.

Note that there is already a flush_tlb_range which could be used, but
some architectures assume that it is only used on user addresses.

Regards,
Paul.

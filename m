Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318199AbSHDTKS>; Sun, 4 Aug 2002 15:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318201AbSHDTKS>; Sun, 4 Aug 2002 15:10:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54535 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318199AbSHDTKR>;
	Sun, 4 Aug 2002 15:10:17 -0400
Message-ID: <3D4D7F24.10AC4BDB@zip.com.au>
Date: Sun, 04 Aug 2002 12:23:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Hubertus Franke <frankeh@watson.ibm.com>,
       "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, gh@us.ibm.com, Martin.Bligh@us.ibm.com,
       wli@holomorpy.com, linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
References: <200208041331.24895.frankeh@watson.ibm.com> <Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 4 Aug 2002, Hubertus Franke wrote:
> >
> > As of the page coloring !
> > Can we tweak the buddy allocator to give us this additional functionality?
> 
> I would really prefer to avoid this, and get "95% coloring" by just doing
> read-ahead with higher-order allocations instead of the current "loop
> allocation of one block".
> 
> I bet that you will get _practically_ perfect coloring with just two small
> changes:
> 
>  - do_anonymous_page() looks to see if the page tables are empty around
>    the faulting address (and check vma ranges too, of course), and
>    optimistically does a non-blocking order-X allocation.
> 
>    If the order-X allocation fails, we're likely low on memory (this is
>    _especially_ true since the very fact that we do lots of order-X
>    allocations will probably actually help keep fragementation down
>    normally), and we just allocate one page (with a regular GFP_USER this
>    time).
> 
>    Map in all pages.

This would be a problem for short-lived processes. Because "map in
all pages" also means "zero them out".  And I think that performing
a 4k clear_user_highpage() immediately before returning to userspace
is optimal.  It's essentialy a cache preload for userspace.

If we instead clear out 4 or 8 pages, we trash a ton of cache and
the chances of userspace _using_ pages 1-7 in the short-term are
lower.   We could clear the pages with 7,6,5,4,3,2,1,0 ordering,
but the cache implications of faultahead are still there.

Could we establish the eight pte's but still arrange for pages 1-7
to trap, so the kernel can zero the out at the latest possible time?


>  - do the same for page_cache_readahead() (this, btw, is where radix trees
>    will kick some serious ass - we'd have had a hard time doing the "is
>    this range of order-X pages populated" efficiently with the old hashes.
> 

On the nopage path, yes.  That memory is cache-cold anyway.

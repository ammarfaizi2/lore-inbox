Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318186AbSHDSsI>; Sun, 4 Aug 2002 14:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318189AbSHDSsI>; Sun, 4 Aug 2002 14:48:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51983 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318186AbSHDSsF>; Sun, 4 Aug 2002 14:48:05 -0400
Date: Sun, 4 Aug 2002 11:38:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>,
       <davidm@napali.hpl.hp.com>, <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <200208041331.24895.frankeh@watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 Aug 2002, Hubertus Franke wrote:
> 
> As of the page coloring !
> Can we tweak the buddy allocator to give us this additional functionality?

I would really prefer to avoid this, and get "95% coloring" by just doing 
read-ahead with higher-order allocations instead of the current "loop 
allocation of one block".

I bet that you will get _practically_ perfect coloring with just two small 
changes:

 - do_anonymous_page() looks to see if the page tables are empty around 
   the faulting address (and check vma ranges too, of course), and 
   optimistically does a non-blocking order-X allocation.

   If the order-X allocation fails, we're likely low on memory (this is 
   _especially_ true since the very fact that we do lots of order-X
   allocations will probably actually help keep fragementation down
   normally), and we just allocate one page (with a regular GFP_USER this 
   time).

   Map in all pages.

 - do the same for page_cache_readahead() (this, btw, is where radix trees 
   will kick some serious ass - we'd have had a hard time doing the "is
   this range of order-X pages populated" efficiently with the old hashes.

I bet just those fairly small changes will give you effective coloring, 
_and_ they are also what you want for doing small superpages.

And no, I do not want separate coloring support in the allocator. I think 
coloring without superpage support is stupid and worthless (and 
complicates the code for no good reason).

		Linus


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132118AbRDFRRH>; Fri, 6 Apr 2001 13:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132127AbRDFRQ6>; Fri, 6 Apr 2001 13:16:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13681 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132121AbRDFRQu>; Fri, 6 Apr 2001 13:16:50 -0400
Date: Fri, 6 Apr 2001 19:36:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2 times faster rawio and several fixes (2.4.3aa3)
Message-ID: <20010406193621.M28118@athlon.random>
In-Reply-To: <20010406183440.B28118@athlon.random> <20010406190701.H28118@athlon.random> <20010406190232.A20258@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010406190232.A20258@gruyere.muc.suse.de>; from ak@suse.de on Fri, Apr 06, 2001 at 07:02:32PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 07:02:32PM +0200, Andi Kleen wrote:
> On Fri, Apr 06, 2001 at 07:07:01PM +0200, Andrea Arcangeli wrote:
> > However we can probably stay with the 512k atomic I/O otherwise the iobuf
> > structure will grow again of an order of 2. With 512k of atomic I/O the kiovec
> > structure is just 8756 in size (infact probably I should allocate some of the
> > structures dynamically instead of statics inside the kiobuf.. as it is now
> > with my patch it's not very reliable as it needs an allocation of order 2).
> 
> 8756bytes wastes most of an order 2 allocation. Wouldn't it make more sense to 
> round it up to 16k to use the four pages fully ?  (if the increased atomic

I prefer to get rid of the order 2 allocation to avoid having to deal with
fragmentation. The patch introduces arrays takes 1 page each (on x86 and alpha)
if the atomic IO is 512k so I can allocate them with a separate kmalloc.

OTOH on x86-64 we have PAGE_SIZE 4k and 8byte words so maybe I should use
vmalloc instead? Performance of vmalloc is not an issue because those
allocations doesn't happen anymore in any fast path, only worry in using
vmalloc are the additional global 3 tlb entries (but OTOH also with kmalloc
there's the chance the code will use a few more global tlb entries if the
memory returned for all the kiovec structures doesn't all fit in the same
2/4Mbytes naturally aligned area). so probably I will take the vmalloc way
that is more generic and it shouldn't hurt perormance (I will measure that
to be sure though).

Andrea

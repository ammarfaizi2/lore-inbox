Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269497AbUIZFbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269497AbUIZFbP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 01:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269498AbUIZFbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 01:31:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:25476 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269497AbUIZFbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 01:31:11 -0400
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all
	set_pte must be written in asm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040926013200.GT3309@dualathlon.random>
References: <20040925155404.GL3309@dualathlon.random>
	 <1096155207.475.40.camel@gaston> <20040926002037.GP3309@dualathlon.random>
	 <1096159487.18234.64.camel@gaston>
	 <20040926013200.GT3309@dualathlon.random>
Content-Type: text/plain
Message-Id: <1096176535.18235.293.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 26 Sep 2004 15:29:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-26 at 11:32, Andrea Arcangeli wrote:

> maybe I'm biased because I'm reading x86-64 code, but where? the
> software mkdirty and mkyoung seem to all be inside the page_table_lock.

ppc and ppc64 who treat their hash table as a kind of big tlb cache, and
embedded ppc's with software loaded TLBs all have the TLB or hash refill
mecanism "mimmic" a HW TLB load, that is it is assembly code that will
set the DIRTY or ACCESSED bits without taking the page table lock

> Not sure how could I get you were talking about those floating around
> patches. I still don't get any connetion with those patches and the
> above discussion.

Oh, I side-tracked a bit on the need to make the PTE update & hash flush
atomic on ppc64 using the per-PTE lock _PAGE_BUSY bit we have there if
we ever implement that lockless do_page_fault(), but that was a side
discussion, sorry for confusion.
 
> > Again, find me a single case where the compiler will generate anything 
> > but an "std" instruction for the above on ppc64 and you'll get a free
> > case of champagne :)
> 
> If something I can check x86-64 which has the same issue, not ppc64.
> 
> If you prefer to ignore those theoretical smp races, then I will save
> this email and I'll forward it to you when it triggers in production
> because gcc did something strange, and then you will send me the free
> case of champagne :)

We have a deal :)

> I'm also waiting the other bug for the lack of volatile variables where
> we access memory that can change under us to
> trigger anywhere in the kernel, only after it does I will have a good
> argument to convince people not to depend on subtle behaviour of gcc,
> and to write C language instead and to leave the atomic guarantees to
> asm statements that the C compiler isn't allowed to mess up.
> 
> Oh maybe it already triggers on Martin's machine... ;), this is another
> reason why I would like to see this can of warms closed, so I don't have
> to worry every time that gcc doesn't something silly that could never be
> catched by the gcc regression test suite, since gcc would be still C
> complaint despite the apparently silly thing (silly from the point of
> view of a kernel developer at least, not necessairly silly from the
> point of view of a gcc developer).

Oh, I agree the lack of volatile on a switch/case may be an issue, I've
seen really esoteric ways of generating switch/case...

> there is a perf issue, cmpxchg8b is a lot more costly than two movl and
> a smp_wmb in between. We only need atomic writes (not locked writes) in
> all set_pte, except ptep_establish which is the only overwriting a pte
> that is already present.

Right, in your hypotetical scenario, I'd just have to make sure an std
instruction is generated on ppc64 

Ben.



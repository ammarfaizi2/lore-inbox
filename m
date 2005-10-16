Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVJPTg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVJPTg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 15:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVJPTg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 15:36:29 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:32387 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751363AbVJPTg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 15:36:29 -0400
Date: Sun, 16 Oct 2005 23:36:00 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: andrea@suse.de, herbert@gondor.apana.org.au, nickpiggin@yahoo.com.au,
       benh@kernel.crashing.org, hugh@veritas.com, paulus@samba.org,
       anton@samba.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
Message-ID: <20051016233600.A13487@jurassic.park.msu.ru>
References: <20051015180018.GN18159@opteron.random> <20051015194855.GA1164@gondor.apana.org.au> <20051015200701.GP18159@opteron.random> <20051015.160702.128767261.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051015.160702.128767261.davem@davemloft.net>; from davem@davemloft.net on Sat, Oct 15, 2005 at 04:07:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 04:07:02PM -0700, David S. Miller wrote:
> From: Andrea Arcangeli <andrea@suse.de>
> Date: Sat, 15 Oct 2005 22:07:01 +0200
> 
> > sure see alpha:
> > 
> > 	__asm__ __volatile__(
> > 	"1:	ldq_l %0,%1\n"
> > 	"	addq %0,%3,%2\n"
> > 	"	addq %0,%3,%0\n"
> > 	"	stq_c %0,%1\n"
> > 	"	beq %0,2f\n"
> > 	"	mb\n"
> > 
> > the memory barrier is applied way after the write is visible to other
> > cpus, you can even get an irq before the mb and block there for some
> > usec.
> 
> For atomic operations returning values, there must be a memory
> barrier both before and after the atomic operation.  This is
> defined in Documentation/atomic_ops.txt, so Alpha needs to be
> fixed to add a memory barrier at the beginning of these
> assembler sequences.

My opinion is that we don't need a barrier even _after_ ll/sc sequences
on Alpha - it's redundant; perhaps it's just a historical baggage.
I strongly believe that ll/sc _does_ imply an SMP memory barrier, as can
be seen from instructions timing: a standalone mb takes tens of cycles,
the mb before/after ll/sc takes 0 to 1 cycle on ev6 (a bit more on ev56)
depending on instruction slotting.
Note that superfluous mb's around atomic stuff still can hurt -
Alpha mb instruction also flushes IO write buffers, so it can
be _extremely_ expensive under heavy IO...

Ivan.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVJOUHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVJOUHF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 16:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVJOUHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 16:07:05 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33848
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751207AbVJOUHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 16:07:04 -0400
Date: Sat, 15 Oct 2005 22:07:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, benh@kernel.crashing.org,
       hugh@veritas.com, paulus@samba.org, anton@samba.org, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
Message-ID: <20051015200701.GP18159@opteron.random>
References: <4350C4F6.4030807@yahoo.com.au> <E1EQkpc-0007FI-00@gondolin.me.apana.org.au> <20051015180018.GN18159@opteron.random> <20051015194855.GA1164@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051015194855.GA1164@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2005 at 05:48:55AM +1000, Herbert Xu wrote:
> On Sat, Oct 15, 2005 at 06:00:18PM +0000, Andrea Arcangeli wrote:
> > 
> > Note that the barrier in atomic_add_negative is useless here because it
> > happens way too late, _after_ the count is decremented (not _before_)
> > so the decreased count could be already visible to the other cpu.
> 
> Could you please point me to an architecture that does this?

sure see alpha:

	__asm__ __volatile__(
	"1:	ldq_l %0,%1\n"
	"	addq %0,%3,%2\n"
	"	addq %0,%3,%0\n"
	"	stq_c %0,%1\n"
	"	beq %0,2f\n"
	"	mb\n"

the memory barrier is applied way after the write is visible to other
cpus, you can even get an irq before the mb and block there for some
usec.

>From a common code point of view, the barrier you mentioned in
atomic_add_negative is absolutely useless for this specific case
(setpagedirty+put_page)

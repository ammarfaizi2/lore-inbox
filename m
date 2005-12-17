Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVLQEUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVLQEUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 23:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVLQEUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 23:20:14 -0500
Received: from hera.kernel.org ([140.211.167.34]:64738 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751079AbVLQEUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 23:20:12 -0500
Date: Sat, 17 Dec 2005 02:19:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC3 02/14] Basic counter functionality
Message-ID: <20051217041950.GA7710@dmt.cnet>
References: <20051215001415.31405.24898.sendpatchset@schroedinger.engr.sgi.com> <20051215001425.31405.74009.sendpatchset@schroedinger.engr.sgi.com> <20051217040115.GA6975@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217040115.GA6975@dmt.cnet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There is no need to disable interrupts AFAICS, but only preemption
> (which could cause problems as your comment above describes). I suppose
> that these counters are not accessed at interrupt time and are not meant
> to be, right?
> 
> Which means that if an interrupt happens at any point in the code,
> the state will be consistent after the IRQ(s) handler(s) finish and
> execution restarts where it had been interrupted.
> 
> Why not use preempt_disable/preempt_enable? Those would disappear
> if !CONFIG_PREEMPT, and could be faster than the interrupt
> disabling/enabling (no need to save "flags" on stack, but increment
> preempt count, which has a chance to be on cache, I guess).

Which is what local_t does for BITS_PER_LONG==32 arches:

#define LOCAL_INIT(i)   { ATOMIC_INIT(i) }

#define local_read(l)   ((unsigned long)atomic_read(&(l)->a))
#define local_set(l,i)  atomic_set((&(l)->a),(i))
#define local_inc(l)    atomic_inc(&(l)->a)
#define local_dec(l)    atomic_dec(&(l)->a)
#define local_add(i,l)  atomic_add((i),(&(l)->a))
#define local_sub(i,l)  atomic_sub((i),(&(l)->a))

/* Non-atomic variants, ie. preemption disabled and won't be touched
 * in interrupt, etc.  Some archs can optimize this case well. */
#define __local_inc(l)          local_set((l), local_read(l) + 1)
#define __local_dec(l)          local_set((l), local_read(l) - 1)
#define __local_add(i,l)        local_set((l), local_read(l) + (i))
#define __local_sub(i,l)        local_set((l), local_read(l) - (i))

> It would also be nice to have all code related to debugging only
> counters selectable at compile time, since it might not be interesting
> data for some scenarios (but unnecessary bloat) - seems that was the
> original intent by Andrew as you noted.

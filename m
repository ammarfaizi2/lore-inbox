Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbUKQJ3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbUKQJ3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 04:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUKQJ32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 04:29:28 -0500
Received: from mx1.elte.hu ([157.181.1.137]:37274 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262246AbUKQJZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 04:25:03 -0500
Date: Wed, 17 Nov 2004 11:26:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling bugs
Message-ID: <20041117102651.GA13768@elte.hu>
References: <20041116113209.GA1890@elte.hu> <419A7D09.4080001@bigpond.net.au> <20041116232827.GA842@elte.hu> <Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Wed, 17 Nov 2004, Ingo Molnar wrote:
> > 
> > maybe, but why? Atomic ops are still a tad slower than normal ops
> 
> A "tad" slower? 
> 
> An atomic op is pretty much as expensive as a spinlock/unlock pair on
> x86.  Not _quite_, but it's pretty close.

it really depends on the layout of the data structure. The main cost
that we typically see combined with atomic ops and spinlocks is if the
target of the atomic op is a global/shared variable, in which case the
cacheline bounce cost is prohibitive and controls over any micro-cost.

But in this particular rq->nr_uninterruptible case we have per-CPU
variables, so the cost of the atomic op is, in theory, quite close to
the cost of a normal op.

In practice this means it's 10 cycles more expensive on P3-style CPUs. 
(I think on P4 style CPUs it should be much closer to 0, but i havent
been able to reliably time it there - cycle measurements show a 76
cycles cost which is way out of line.)

On a UP Athlon64 the cost of a LOCK-ed op is exactly the same as without
the LOCK prefix - but here the CPU can take shortcuts because in theory
it can skip any cache coherency considerations altogether. (albeit the
atomic op should still have relevance to DMA-able data, perhaps UP-mode
CPUs ignore that case.)  Also, i think it ought to be near zero-cost on
a Crusoe-style CPU?

	Ingo

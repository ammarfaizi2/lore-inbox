Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUDHTCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUDHTCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:02:38 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63157
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262257AbUDHTCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:02:37 -0400
Date: Thu, 8 Apr 2004 21:02:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
Message-ID: <20040408190235.GR31667@dualathlon.random>
References: <20040408161610.GF31667@dualathlon.random> <1081441791.2105.295.camel@mulgrave> <20040408171017.GJ31667@dualathlon.random> <1081446226.2105.402.camel@mulgrave> <20040408175158.GK31667@dualathlon.random> <1081447654.1885.430.camel@mulgrave> <20040408181838.GN31667@dualathlon.random> <1081448897.2105.465.camel@mulgrave> <20040408184245.GO31667@dualathlon.random> <1081450196.1885.492.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081450196.1885.492.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 01:49:55PM -0500, James Bottomley wrote:
> Yes, I'll go for that.  The write need only be done on vma insert, which
> should be very fast.  So do we agree this is a generic solution, or were
> you still thinking of trying to abstract it per-arch?

I'm unsure, the semaphore simplifies a lot the need_resched() in the
vmtruncate/zap_pte path, plus it avoids to waste time in the other cpus
while vmtruncate it working on it (potentially for more than a timeslice).

btw, I already considered making the semaphore a rw semaphore (note not
a rwspinlock) to boost scalability of the paging too, but OTOH the
paging has a so small critical section under the lock (objrmap) that I
wasn't sure if it would payoff, the biggest cost will still be the
bouncing of the cacheline, so I desisted from the idea of making it a
rwsem and I thought the semaphore was ideal as Andrew told me a few days
before I had the rwsem idea.  Plus concurrent truncate aren't worth
optimizing since they're serialized from the i_sem in the first place.

Ideally it should be a semaphore for all archs but the ones who needs
to walk it from irqs that wants a rw_spinlock.

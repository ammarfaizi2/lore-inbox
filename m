Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263195AbVBDFaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbVBDFaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 00:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbVBDFaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 00:30:09 -0500
Received: from ozlabs.org ([203.10.76.45]:33771 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263098AbVBDF36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 00:29:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.2175.599702.827882@cargo.ozlabs.ibm.com>
Date: Fri, 4 Feb 2005 16:30:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: A scrub daemon (prezeroing)
In-Reply-To: <Pine.LNX.4.58.0502031650590.26551@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
	<1106828124.19262.45.camel@hades.cambridge.redhat.com>
	<20050202153256.GA19615@logos.cnet>
	<Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
	<20050202163110.GB23132@logos.cnet>
	<Pine.LNX.4.61.0502022204140.2678@chimarrao.boston.redhat.com>
	<16898.46622.108835.631425@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0502031650590.26551@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:

> You need to think about this in a different way. Prezeroing only makes
> sense if it can avoid using cache lines that the zeroing in the
> hot paths would have to use since it touches all cachelines on
> the page (the ppc instruction is certainly nice and avoids a cacheline
> read but it still uses a cacheline!). The zeroing in itself (within the

The dcbz instruction on the G5 (PPC970) establishes the new cache line
in the L2 cache and doesn't disturb the L1 cache (except to invalidate
the line in the L1 data cache if it is present there).  The L2 cache
is 512kB and 8-way set associative (LRU).  So zeroing a page is
unlikely to disturb the cache lines that the page fault handler is
using.  Then, when the page fault handler returns to the user program,
any cache lines that the program wants to touch are available in 12
cycles (L2 hit latency) instead of 200 - 300 (memory access latency).

> cpu caches) is extraordinarily fast and the zeroing of large portions of
> memory is so too. That is why the impact of scrubd is negligible since
> its extremely fast.

But that also disturbs cache lines that may well otherwise be useful.

> The point is to save activating cachelines not the time zeroing in itself
> takes. This only works if only parts of the page are needed immediately
> after the page fault. All of that has been documented in earlier posts on
> the subject.

As has my scepticism about pre-zeroing actually providing any benefit
on ppc64.  Nevertheless, the only definitive answer is to actually
measure the performance both ways.

Paul.

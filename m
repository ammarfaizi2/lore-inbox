Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbUJ3Wpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUJ3Wpy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUJ3Wpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:45:53 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:47827 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261376AbUJ3Wpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:45:32 -0400
Date: Sun, 31 Oct 2004 00:45:28 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041030224528.GB3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <20041030140732.2ccc7d22.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030140732.2ccc7d22.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 02:07:32PM -0700, Andrew Morton wrote:
> I wonder if it would help if the page zeroing in the idle thread was done
> with the CPU cache disabled.  It should be pretty easy to test - isn't it
> just a matter of setting the cache-disable bit in the kmap_atomic()
> operation?

it's certainly an improvement I agree, however I don't measure a
slowdown here, so I'm not sure if it will make any significant
difference either. Plus the idle clearing code in theory could be
disabled and what would remain after that shall be an improvement over
current code.

I share your concern on the fact there seems not to be any speedup in my
2-way boxes unless I microbenchmark (but if I microbenchmark the best
case the speedup is very huge). OTOH the same applies to the per-cpu
queues at large, they only are measurable on the big boxes. Overall if
we've to use slab for the pte just to cache zero (which for sure won't
be a measurable speedup either in any small box using a _macro_
benchmark), this looks better design IMHO since it boosts everything
zero related, not just the pte. Plus it fixes some mistake in the
current code (like the failure of utilizing properly all the quicklists
belonging to each classzone [current code falls back into the buddy
before falling back in the lower zone quicklist] and the waste of
resouces in keeping the hot and cold caches separated, and the no point
for low watermark in the quicklists and other very minor details).

> There are quite a few patches happening in this area - the
> make-kswapd-aware-of-higher-order-pages patches and the no-buddy-bitmap
> patches are queued in -mm.  It'll take some time to work through them
> all...

Sure take your time (and this is only an experiment so far anyways).
Only I'll do the reject fixup after they're in mainline so I've less
chance of doing useless rediff work.

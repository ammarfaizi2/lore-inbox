Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUCXEhn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 23:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUCXEhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 23:37:43 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34471
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263000AbUCXEhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 23:37:42 -0500
Date: Wed, 24 Mar 2004 05:38:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: nonlinear swapping w/o pte_chains [Re: VMA_MERGING_FIXUP and patch]
Message-ID: <20040324043833.GC2278@dualathlon.random>
References: <20040322175216.GJ3649@dualathlon.random> <Pine.LNX.4.44.0403221842060.12658-100000@localhost.localdomain> <20040322195826.GA22639@dualathlon.random> <20040323214459.GG3682@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323214459.GG3682@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 10:44:59PM +0100, Andrea Arcangeli wrote:
> +#ifdef __HAVE_ARCH_PAGE_TEST_AND_CLEAR_DIRTY
> +			get_page(page);
> +#endif
> +			unmap_pte_page(page, vma, address, ptep);
						  ^^^^^^^ + offset

I added some stuff in the shm threaded test program to verify
correctness after swapin and it showed userspace mm corruption on the
nonlinear pages, the above + offset is the fix.

I also merged anobjrmap-6 from Hugh so ppc and ppc64 compiles fine (plus
some other arch).

Also the race in do_anonymous_page couldn't trigger, the callers of
try_to_unmap always first check if the page is mapped after taking the
page_map_lock, so I'm backing it out.

The real race triggering such bug is that I'm not taking the
page_map_lock for all the pages before unmapping them so the
--page->mapcount aren't atomic while the page is unmapped by different
address spaces at the same time from multiple cpus.

It'll all be fixed in the next update.

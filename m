Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292500AbSBPUWt>; Sat, 16 Feb 2002 15:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292492AbSBPUWk>; Sat, 16 Feb 2002 15:22:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11283 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292491AbSBPUW0>; Sat, 16 Feb 2002 15:22:26 -0500
Date: Sat, 16 Feb 2002 12:21:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Page table sharing
In-Reply-To: <E16c9FS-0004In-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0202161212200.24268-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Feb 2002, Daniel Phillips wrote:
>
> I think this patch is ready to look at now.  It's been pretty stable, though
> I haven't gone as far as booting with it - page table sharing is still
> restricted to uid 9999.  I'm running it on a 2 way under moderate load without
> apparent problems.  The speedup on forking from a parent with large vm is
> *way* more than I expected.

I'd really like to hear what happens when you enable it unconditionally,
and then run various real loads along with things like "lmbench".

Also, when you test forking over a parent, do you test just the fork, or
do you test the "fork+wait" combination that waits for the child to exit
too? The latter is the only really meaningful thing to test.

Anyway, the patch certainly looks pretty simple and small. Great.

> I haven't fully analyzed the locking yet, but I'm beginning to suspect it
> just works as is, i.e., I haven't exposed any new critical regions.  I'd be
> happy to be corrected on that though.

What's the protection against two different MM's doing a
"zap_page_range()" concurrently, both thinking that they can just drop the
page table directory entry, and neither actually freeing it? I don't see
any such logic there..

I suspect that the only _good_ way to handle it is to do

	pmd_page = ..

	if (put_page_testzero(pmd_page)) {
		.. free the actual page table entries ..
		__free_pages_ok(pmd_page, 0);
	}

instead of using the free_page() logic. Maybe you do that already, I
didn't go through the patches _that_ closely.

Ie you'd do a "two-phase" page free - first do the count handling, and if
that indicates you should really free the pmd, you free the lower page
tables before you physically free the pmd page (ie the page is "live" even
though it has a count of zero).

		Linus


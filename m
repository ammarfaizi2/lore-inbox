Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTJUNr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 09:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbTJUNr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 09:47:58 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:53561 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S263084AbTJUNr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 09:47:56 -0400
Date: Tue, 21 Oct 2003 06:47:54 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@clyde
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Missing include in swap.h for some architectures
In-Reply-To: <20031020022536.796531c4.akpm@osdl.org>
Message-ID: <Pine.GSO.4.58.0310210421000.26573@clyde>
References: <Pine.GSO.4.58.0310171453450.13905@blinky> <20031020022536.796531c4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Oct 2003, Andrew Morton wrote:

> "Noah J. Misch" <noah@caltech.edu> wrote:
> >
> > # The linux/swap.h header uses the page_cache_release and release_pages
> >  # functions declared in linux/pagemap.h when CONFIG_SWAP is disabled.  Add
> >  # an include of linux/pagemap.h so swap.h finds those declarations on
> >  # architectures that don't include pagemap.h indirectly.
>
> This carries a small risk of breaking things.  I think I'd prefer that the
> offending .c files just include pagemap.h please.

I think I understand your argument, but consider this:

Adding includes very rarely breaks code, and when it does, the cause is a real
defect and the symptom is usually an easily fixed compilation error.

Furthermore, it's not, by and large, the .c files that are "offending" - it's
the static inline functions tlb_flush_mmu and tlb_remove page, both defined in
asm/tlb.h.  With the current swap.h, those functions need pagemap.h included to
compile cleanly with SWAP=n.  That means that every .c file that includes tlb.h,
directly or indirectly, _must_ somehow also include pagemap.h, regardless of why
it may be including tlb.h, or it gets slapped with a warning or worse.

If we make the file responsible for the pagemap.h dependency, swap.h, clean up
after itself, we can clear up ancillary breakage now.  MM code that doesn't
compile isn't likely to remain unfixed for long.  If we expect every .c file
that includes tlb.h to include pagemap.h, and we know that they may fail to do
so and build without a hitch on some architectures, that sets us up for fixing
odd breakage here and there over time.


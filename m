Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUCUXnK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUCUXnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:43:10 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6538
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261461AbUCUXnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:43:04 -0500
Date: Mon, 22 Mar 2004 00:43:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa1
Message-ID: <20040321234355.GB3649@dualathlon.random>
References: <20040321145547.GA3649@dualathlon.random> <20040321162401.A8778@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321162401.A8778@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 04:24:01PM +0000, Christoph Hellwig wrote:
> A bunch of rather cosmetic comments while looking over the patch:
> 
>  - all the binfmt handler seems to copy exactly the same vma setup,
>    maybe we should add a helper for that?

yes, this isn't related to my patch btw (my patch just shows the
duplication since I had to fixup many places).

>  - the struct anon_vma_s / anon_vma_t naming is awkward, why not just
>    struct anon_vma *insert reference to Documentation/CodingStyle here*

Andrew already complained about that, I don't mind either ways now that
it's implemented, it never needs forward declaration so it's not
required to be a struct and I don't see why we should restrict us to a
subset of the C language when a typedef can save characters. While
coding I want to be efficient so I want to save characters, typedefs
help in saving my time so I would been less efficient in not taking
advantage of them. if there's any religious issue against typedefs it will
be faster anyways to do a search and replace on the patch itself,
instead of doing it while coding where it's me typing chars.

just run a s/anon_vma_t/struct anon_vma/ on the patch and then apply it,
it should just work and it didn't waste my time while coding, this will
be fine with me of course.

>  - the inclusion guards in objrmap.h are wrong

can you elaborate? I hate including garbage inclusions especially now
that we've a reliable buildsystem (with the previous buildsystem no
matter how smart you coded the inclusions, I had to make distclean
anyways after every include change). I like strict always, if something
can be avoided I avoid it, the shorter the inclusion the more correct it
is to me (again, especially true with a reliable buildsystem like in 2.6).

>  - why is PG_swapcache bit 21?  You removed PG_direct so bit 16 is free now

indeed, I will cleanup this bit, it didn't make any difference in
practice due the fact 24bit are reserved anyways, so you could use bit
16 instead of bit 21 for the future bitflags but it's cleaner to follow
your suggestion of course. I will change it in the next version.

>  - I don't really like the swapper space special case in ___add_to_page_cache,
>    IIRC there's only one caller of it for the swapper space and IMHO you're
>    better off opencoding it
>  - dito for __remove_from_page_cache 

agreed, but those are microoptimizations, I agree they can be done, but
it's nothing I worry about right now. At the moment from my point of
view the most obvious and the less modifications the better, at least
it's included in some more official kernel like -mm or mainline.
Furthermore I much prefer keeping to cover only the entry/exit points
than having to deal with PageSwapCache checks in all generic pagecache
operations that the swapcache may be sharing at runtime (like sync_page
for example).  (again, at least until this is in some more official
kernel where it's not only me having to fixup and rediff when something
change in the pagecache layer in mainline and/or -mm)

>  - is renaming rmap.c to objrmap.c really nessecary?  It contains >  about
>    the same functions, and keeping the old, implementation-agnostic name
>    makes it easiert to follow the radical changes..

b*tkeeper will automagically notice the rename when Linus merges (at
least this was Miles's theory in the arch lists trying to figure out how
could some of his merges with Linus's tree via patches could be tracked
right despite he didn't post them with smart metadata like arch can
produce reliably), so if this theory is right you'll see the clean diff
(and you'll see the amount of sharing too).  I renamed it primarly
because rmap is the common name for the tecnique of traking the
pagetables with pte_chains (of course rmap for 2.4 is a lot more than
that since the patch grown a lot bigger to the point of merging elevator
read latency changes, but normally in l-k when we talk about rmap we
mean the tracking of ptes with the pte_chains). The code sharing between
the rmap.c and objrmap.c is a very little percentage, and such little
percentage is only the API with the VM callers and the
pte_test_and_clear in the unmap after we reached the pagetable with the
different anon_vma/objrmap methods which is again the same of the 2.4
pagetable walking code too.

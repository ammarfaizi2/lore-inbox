Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbUDBLei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 06:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUDBLei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 06:34:38 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:10339 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262733AbUDBLea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 06:34:30 -0500
Date: Fri, 2 Apr 2004 12:34:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-aa vma merging
In-Reply-To: <Pine.LNX.4.44.0403292044530.19124-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404021208500.4414-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to be boring, Andrea, but 2.6.5-rc3-aa2 is now out, and you
have still not fixed the vma merging issue: I don't believe you can.

I realize you're very busy doing lots else, but you seem oddly
unaware that anon_vma is broken in this plausible scenario -
you've traded some common cases of anon vma merging for an
admirable solution to the mremap move shared anon issue;
but the latter is much too rare to justify that trade.

If I'm wrong, please show us all.  Take out the "*ptr = pageno++;"
below and, yes, I'm sure it's just a trivial matter of adding a
little code to mprotect.c and removing the #if VMA_MERGING_FIXUPs;
but actually writing data into the pages before protecting them
readonly (a reasonable thing to do) spoils it all - each page
gets its own vma with its own anon_vma preventing merge.

Whole mail from before repeated.  Yes, I read your reply: thank
you for giving us anon vma merging in 2.4.10 (so it's important?);
but checking Red Hat 2.4.9 variants (merge_anon_vmas) shows they
also needed it: so I don't think you can now take back what you gave.

Hugh

On Mon, 29 Mar 2004, Hugh Dickins wrote:

> Andrea,
> 
> Again I beg you to attend to vma merging in your anon_vma tree.
> Still you have #if VMA_MERGING_FIXUP throughout mm/mprotect.c
> (and much less seriously in mremap.c), and that's just masking
> the real problem: that when you do enable vma merging there, your
> anon_vmas will get in the way of merging in significant cases.
> 
> Try the example below, on mainline and on anonmm and on anon_vma,
> even when you've done the VMA_MERGING_FIXUP: you're limited by the
> MAX_MAP_COUNT of vmas, one per page.  Now, I know there's a move
> afoot to have /proc/sys/vm/max_map_count tunable, but I don't
> think that's the right answer for you ;)
> 
> If I remember rightly, Linus tried to do away with a lot of the
> vma merging about three years ago, but some had to be reinstated.
> So I assume that what's there is needed, and the example below
> does looks plausible enough: add page, fill it, protect it, ...
> 
> How to fix this?  Clearly you could walk the pages, reassigning
> their anon_vmas; but if you're reduced to doing that in the
> common mprotect case, you're still worse off than anonmm which
> only has to do it in the unusal mremap move case, while it has
> to walk the pages anyway.
> 
> Until you can deal with this, I believe that the simpler
> anonmm method in my anobjrmap patches does the job better:
> less change, less overhead, more to the point.
> 
> Your anon_vma is good at connecting pages directly to their
> vma groups in swapout, where my anonmm has to use find_vma (and
> your anon_vma will fit more neatly with Andrew's vision of per-vma
> spinlocks, where mine will probably need to down_read_trylock).
> 
> But the cost to vma merging seems too high.  And besides,
> wasn't the point of this objrmap exercise, to move away from
> the memory and processing load of pte_chains on the fast paths,
> to using more cpu to solve it in the swapout paths?
> anonmm does that better.
> 
> Hugh

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

#define PAGE_SIZE	4096

int main(int argc, char *argv[])
{
	unsigned long *ptr;
	unsigned long pageno = 0;

	while (1) {
		ptr = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
				MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
		if (ptr == MAP_FAILED) {
			fflush(stdout);
			perror("mmap");
			printf("Type <Return> to exit ");
			getchar();
			exit(1);
		}
		*ptr = pageno++;
		if (mprotect(ptr, PAGE_SIZE, PROT_READ) == -1) {
			fflush(stdout);
			perror("mprotect");
			printf("Type <Return> to exit ");
			getchar();
			exit(1);
		}
		printf("%7lu kB\n", (PAGE_SIZE/1024) * pageno);
	}
}


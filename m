Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbQKQSmA>; Fri, 17 Nov 2000 13:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129942AbQKQSlj>; Fri, 17 Nov 2000 13:41:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:60978 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129216AbQKQSlg>; Fri, 17 Nov 2000 13:41:36 -0500
Date: Fri, 17 Nov 2000 19:11:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: schwidefsky@de.ibm.com
Cc: Linus Torvalds <torvalds@transmeta.com>, mingo@chiara.elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: Memory management bug
Message-ID: <20001117191125.B27834@athlon.random>
In-Reply-To: <C125699A.005B0F7E.00@d12mta07.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C125699A.005B0F7E.00@d12mta07.de.ibm.com>; from schwidefsky@de.ibm.com on Fri, Nov 17, 2000 at 05:35:53PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 05:35:53PM +0100, schwidefsky@de.ibm.com wrote:
> I did a little closer investigation. The BUG was triggered by a page with
> page->mapping pointing to an address space of a mapped ext2 file
> (page->mapping->a_ops == &ext2_aops). The page had PG_locked, PG_uptodate,
> PG_active and PG_swap_cache set. The stack backstrace showed that kswapd
> called do_try_to_free_pages, refill_inactive, swap_out, swap_out_mm,
> swap_out_vma, try_to_swap_out and add_to_swap_cache where BUG hit.  The
> registers look good, the struct page looks good. I don't think that this was
> a random memory corruption.

Agreed, that's almost sure _not_ random memory corruption of the page
structure. It looks like a VM bug (if you can reproduce trivially I'd give a
try to test8 too since test8 is rock solid for me while test10 lockups in VM
core at the second bonnie if using emulated highmem).

> I was refering to the "if (!order) goto try_again" ifs in alloc_pages, not
> the "if (something) BUG()" ifs.

Ah ok :), see Linus's answer: in your case the "don't do that" means to
implement the:

	#define SOFT_PAGE_SIZE (PAGE_SIZE<<2)

thing we were talking about yesterday of course.

Plus I add that the "if (!order) goto try_again" is an obvious deadlock prone
bug introduce in test9 that should be removed.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

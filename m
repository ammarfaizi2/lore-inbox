Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKQQPE>; Fri, 17 Nov 2000 11:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129575AbQKQQPB>; Fri, 17 Nov 2000 11:15:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:46357 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129148AbQKQQOq>; Fri, 17 Nov 2000 11:14:46 -0500
Date: Fri, 17 Nov 2000 16:44:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: schwidefsky@de.ibm.com
Cc: Linus Torvalds <torvalds@transmeta.com>, mingo@chiara.elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: Memory management bug
Message-ID: <20001117164422.B27098@athlon.random>
In-Reply-To: <C125699A.003D4D6A.00@d12mta07.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C125699A.003D4D6A.00@d12mta07.de.ibm.com>; from schwidefsky@de.ibm.com on Fri, Nov 17, 2000 at 11:41:58AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 11:41:58AM +0100, schwidefsky@de.ibm.com wrote:
> [..] But low on memory
> does mean low on real memory + swap space, doesn't it ? [..]

No. Low on memory here means that `grep MemFree </proc/meminfo' says
you still have only a few mbytes.

> enough swap space but it isn't using any of it when the BUG hits. I think

This is normal.

> the "if (!order)" statements before the "goto try_again" in __alloc_pages
> have something to do with it. To test this assumption I removed the ifs and

The right way to make allocation of order > 0 to work (when not impossible) is
to pass the "order" information from allocator to memory balancing code so you
don't waste resources by freeing and swapping pages that aren't physically
consecutive.  We'll need to teach the memory balancing about freeing only
physically consecutive worthwhile pages.

Actually memory balancing in 2.4.x doesn't get any information, not even the
information about which _classzone_ where to free the memory (NOTE: both 2.2.x
and 2.0.x _always_ got the classzone where to free memory at least). This
classzone missing information causes resources wastage indeed and I just fixed
it several times, BTW.

> I didn't see any "__alloc_pages: %lu-order allocation failed." message

So you probably didn't triggered the out-of-order-2-multipages problem, and
the bug you triggered is going to be another one. But still the above order > 1
thoguths applies to both 2.2.x and 2.4.x since once you'll fix the other
problem, you'll sure run into the failed order 2 allocations.

> before I hit yet another BUG in swap_state.c:60.

The bug in swap_state:60 shows a kernel bug in the VM or random memory
corruption. Make sure you can reproduce on x86 to be sure it's not a s390
that is randomly corrupting memory. If you read the oops after the BUG message
with asm at hand you will see in the registers the value of page->mapping and
you can guess if it's random memory corruption or bug in VM this way (for
example if `reg & 3 != 0' it's memory corruption for sure, you should also
if it's pointing to a suitable kernel-heap address).

> Whats the reasoning behind these ifs ?

To catch memory corruption or things running out of control in the kernel.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

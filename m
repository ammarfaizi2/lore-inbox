Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUDRQOF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 12:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUDRQOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 12:14:05 -0400
Received: from sitemail2.everyone.net ([216.200.145.36]:25749 "EHLO
	omta10.mta.everyone.net") by vger.kernel.org with ESMTP
	id S262079AbUDRQN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 12:13:58 -0400
X-Eon-Sig: AQHOS7NAgqlE4GG1jQIAAAAD,f6778f5b5a614192fe80f1aca51599eb
Date: Sun, 18 Apr 2004 12:13:55 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Questions on prio_tree
Message-ID: <20040418161355.GA1854@ohio.localdomain>
References: <20040414213613.GA21218@ohio.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414213613.GA21218@ohio.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajesh,

I've been reading through your recently posted prio tree code.  There are a
couple of things in the code that I do not understand, and I am concerned
that they may be bugs or omissions.  Hopefully, you'll be just able to
clarify the code for me.  :-)

1 - Why does prio_tree_expand use the max_heap_index to determine the
height of the radix tree?  The bits of the radix_index is only ever used
(never the bits in the heap_index), so shouldn't max_radix_index be used?
I understand that using the max_heap_index isn't necessary broken (it is
guaranteed to be greater than or equal to the max_radix_index), but it
seems inefficient.  As an example, consider the case where 100 vmas are
created all starting at address 0 and ending at addresses 0 through 100.
The current code will force the address part of the tree to a height of 7,
but since there is only one start address (0) the tree really could have a
height of just 1.

2 - When traversing the tree, after the first root->index_bits levels of
the tree have been walked, the code starts inspecting the "size" portion of
the radix key.  Why does the code set the start bit for the size portion to
root->index_bits?  Shouldn't the code set the start bit to (BITS_PER_LONG -
PAGE_SHIFT)?

Consider the case where 100 vmas are created all starting at address 0 and
ending at addresses 0 through 100, followed by the creation of a vma from
address 100,000 - 100,001.  After the first 100 vmas, the tree will have a
height of 7 (reasons sited above) for the start address and an additional
height of 7 for the size portion of the index.  This will cause the tree to
have 7 records in the start_address portion of the tree, and the remaining
93 will be distributed pretty evenly in the size portion of the radix tree
that hangs off the zero address.  When the 101st vma is added, the start
address portion of the tree will be expanded to a height of 17.  The
current code will expand the tree to contain 17 records in the size portion
of the radix tree and leave the remaining 84 records in the size portion of
the tree hanging off the zero address.

The problem, as I see it, is that new inserts into the tree that start at
address zero will not be inspecting the same bits that were used when the
first 100 were inserted.  (When the first 100 were inserted, bits 1-7 were
used to branch in the size portion of the tree, but inserts 102 and on will
use bits 1-17.)  I don't think this can cause a "crash", but I think it
skews the tree ordering and could disturb the O(log n + m) behavior of the
algorithm.

Did I miss something?
-Kevin

-- 
 ---------------------------------------------------------------------
 | Kevin O'Connor                  "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net               'IMHO', 'FAQ', 'BTW', etc. !"    |
 ---------------------------------------------------------------------

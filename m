Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263407AbUEQFSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUEQFSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 01:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbUEQFSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 01:18:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:3742 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263407AbUEQFSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 01:18:11 -0400
Date: Sun, 16 May 2004 22:17:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
cc: Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, hugh@veritas.com,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
In-Reply-To: <200405162136.24441.elenstev@mesatop.com>
Message-ID: <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com>
 <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org> <200405162136.24441.elenstev@mesatop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 May 2004, Steven Cole wrote:
> 
> I beat on this for last day without PREEMPT and no failures at all.
> Several kernels, rock solid all.
> Rebooted with an current (as of a couple hours ago) kernel and PREEMPT=y,
> and after about the third pull into a repository (I have several), splaaat!

Ok. Good. It's PREEMPT that triggers it. However, I doubt it is 
necessarily a preempt bug, I suspect that preempt just opens a window that 
is really small even on SMP, and makes it much wider. Wide enough to be 
seen.

> One of Larry's guys, Rick Smith, sent me a little program (the source
> is earlier in this thread) to check for null.  I called its executable
> saga (see subject line).
> 
> [steven@spc SCCS]$ saga <s.ChangeSet
> Found null start 0x1550b01 end 0x1551000 len 0x4ff line 535587
> Found null start 0x2030b01 end 0x2031000 len 0x4ff line 639039
> Found null start 0x2330b01 end 0x2331000 len 0x4ff line 663611

The fact that it's always zeroes, and it's an strange number but it always 
ends up being page-aligned at the _end_ makes me strongly suspect that we 
have one of the "don't write back data past i_size" things wrong.

There are several cases where we zero the "end of page" before writing
things back - basically everything past the size of the inode is supposed 
to be written back as zero. But your symptoms sure sound like we might be 
reading the size of the inode without holding the proper locks.

Under normal UP, no races exist, and even on SMP, the window is likely
that another CPU has to be _just_ updating something in between the read
of i_size and the clearing just a few instructions later. What preempt
does is likely that getting an interrupt at the right time inside that
window just makes the window _huge_.

Andrew, the obvious culprit would be the memset() in fs/buffer.c 
(block_write_full_page() to be precise):

	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);

imagine that the "write()" function updates i_size late - after having 
written out the new contents to the page, and _after_ havign unlocked the 
page, and now we get a writeback at the wrong time, and we decide to clear 
out the end of the page because we think it's past i_size.

Andrew, what do you think?

I think this race does exist, since generic_file_aio_write_nolock()
literally _does_ update i_size only after it has written all the pages, so
I don't see why a "block_write_full_page()" couldn't come in there between 
and zero them out again at the _old_ i_size boundary.

Do you see anything wrong in my analysis? I think the fix would be to make 
sure to update i_size as we go around writing each page, before we unlock 
the page.

The DIRECT_IO path does this completely wrong and needs to be taught to do
it page-for-page or something, while the generic_commit_write() path looks
like it should be fairly trivially fixable by just moving the
i_size_write() to _before_ the __block_commit_write() call (which will
unlock the page).

Who else knows this code? Maybe I'm missing something. wli? Hugh?

Alternatively, maybe we could remove the "memset()" entirely from the
block_write_full_page() thing (which is asynchronous and not such a good
place to do this), and instead move the whole thing to some nice
synchronous place where we can make sure that we hold the inode semaphore
or something. Like the last close of a shared-writable mmap - since the
only way we can get non-zero after i_size is with a writable mmap.

And no, I can't guarantee this is the bug, but it does seem a bit 
suspicious.

		Linus

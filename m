Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUDDBBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 20:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUDDBBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 20:01:47 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33733
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262079AbUDDBBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 20:01:45 -0500
Date: Sun, 4 Apr 2004 03:01:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: anon-vma (and now filebacked-mappings too) mprotect vma merging [Re:    2.6.5-rc2-aa vma merging]
Message-ID: <20040404010147.GS2307@dualathlon.random>
References: <20040403184639.GN2307@dualathlon.random> <Pine.LNX.4.44.0404031954250.10509-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404031954250.10509-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 08:29:15PM +0100, Hugh Dickins wrote:
> I liked Andrew's vma->page_table_lock suggestion, was imagining we

vma->page_table_lock cannot help you with anonmm, the rbtree is global,
for that you still need a mm-wide lock with anonmm. I serialize
read/write the rbtree only with the mmap_sem, you cannot.

vma->page_table_lock helps _only_ in the pagetable scanning: so only
_after_ nuking the global page_table_lock like I can do thanks to
anon_vma. you cannot drop the mm-wide page_table_lock with anonmm.
vma->page_table_lock is a natural optimization for the anon-vma logic
instead (after fixing the mremap/truncate race ;).

To drop the page_table_lock during vma manipulations in anonmm (and so
to give a real sense to a vma->page_table_lock in anonmm) you could use
a down_read_trylock on the mm->mmap_sem, but that is not going to work
well: the mmap_sem can be taken during extended period of times
involving I/O, and you may never get it. BTW, now that the lookup on the
prio-tree is immediate the i_shared_sem has no reason anymore to be a
semaphore either, it should go back to a spinlock like in 2.4, like the
anon_vma is also protected by a spinlock.

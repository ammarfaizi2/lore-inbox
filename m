Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVHAVHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVHAVHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVHAVE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:04:59 -0400
Received: from gold.veritas.com ([143.127.12.110]:25708 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261253AbVHAVEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:04:39 -0400
Date: Mon, 1 Aug 2005 22:06:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.58.0508011250210.3341@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0508012153570.6323@goblin.wat.veritas.com>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
 <42EDDB82.1040900@yahoo.com.au> <20050801091956.GA3950@elte.hu>
 <42EDEAFE.1090600@yahoo.com.au> <20050801101547.GA5016@elte.hu>
 <42EE0021.3010208@yahoo.com.au> <Pine.LNX.4.61.0508012030050.5373@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508011250210.3341@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Aug 2005 21:04:35.0415 (UTC) FILETIME=[9EFB0670:01C596DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Linus Torvalds wrote:
> On Mon, 1 Aug 2005, Hugh Dickins wrote:
> > 
> > > Aside, that brings up an interesting question - why should readonly
> > > mappings of writeable files (with VM_MAYWRITE set) disallow ptrace
> > > write access while readonly mappings of readonly files not? Or am I
> > > horribly confused?
> > 
> > Either you or I.  You'll have to spell that out to me in more detail,
> > I don't see it that way.
> 
> We have always just done a COW if it's read-only - even if it's shared.
> 
> The point being that if a process mapped did a read-only mapping, and a 
> tracer wants to modify memory, the tracer is always allowed to do so, but 
> it's _not_ going to write anything back to the filesystem.  Writing 
> something back to an executable just because the user happened to mmap it 
> with MAP_SHARED (but read-only) _and_ the user had the right to write to 
> that fd is _not_ ok.

I'll need to think that through, but not right now.  It's a surprise
to me, and it's likely to surprise the current kernel too.  I'd prefer
to say that if the executable was mapped shared from a writable fd,
then the tracer will write back to it; but you're clearly against that.
We may need to split the vma to handle your semantics correctly.

> Using the dirty flag for a "page is _really_ writable" is admittedly kind
> of hacky, but it does have the advantage of working even when the -real-
> write bit isn't set due to "maybe_mkwrite()". If it forces the s390 people 
> to add some more hacks for their strange VM, so be it..

I'll concentrate on this for now.  s390 used to have the same semantics
as everyone else, they made a conscious choice to diverge, and keep dirty
bit in separate array indexed by struct page, and page_test_and_clear_dirty
macro they use instead of clearing pte_dirty.

It works all right, and I don't think it will prevent us communicating
between maybe_mkwrite and get_user_pages by a pte flag that would be
the usual pte_dirty on every other architecture.  Just need to be
careful to handle the right one right.

Hugh

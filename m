Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291248AbSAaTZK>; Thu, 31 Jan 2002 14:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291247AbSAaTYy>; Thu, 31 Jan 2002 14:24:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52488 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291248AbSAaTYb>; Thu, 31 Jan 2002 14:24:31 -0500
Date: Thu, 31 Jan 2002 11:23:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, Momchil Velikov <velco@fadata.bg>,
        John Stoffel <stoffel@casc.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020131201412.L1309@athlon.random>
Message-ID: <Pine.LNX.4.33.0201311115450.1732-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jan 2002, Andrea Arcangeli wrote:
>
> then there must be some collision handling that raise the complexity to
> O(N) like with the hashtable, if the depth is fixed and if 32bits of
> index are enough regardless of how many entries are in the tree.

No collisions. Each mapping has its own private tree. And mappings are
virtually indexed by 32 bits. No hashes, no collisions, no nothing.

Think of the page tables. We can have 64GB of memory, and the page tables
will shrink and grow dynamically to match the needs for virtual memory.
The radix tree is no different, except it ends up being a bit more
aggressive about shrinking by virtue of not always using the maximum depth.

(A fixed depth tree is much simpler, and has equivalent memory use for
not-very-dense mappings. But file mappings are 99% dense).

> of course if we add kmalloc to the pagecache code we can drop such part
> from the page structure with the hashtable too.

But you still need the hashtable.

Right now the hashtable is _roughly_ the size of 4 bytes per physical page
in the machine - and it was done that way explicitly to avoid havin gto
walk the chains. That's a LOT of memory.

For example, on my 2GB machine, I have 2MB worth of hash-tables.

In addition, each "struct page" has 8 bytes in it, so we have a total of
12 bytes per page just for the hash chains.

And yes, you could use kmalloc to allocate the hash chain entries. But
we're _guaranteed_ that 12 bytes, and kmalloc overhead might make it
worse.

In short: the radix tree certainly isn't any worse.

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268675AbUHTWnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268675AbUHTWnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 18:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268676AbUHTWnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 18:43:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23524 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268675AbUHTWne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 18:43:34 -0400
Date: Fri, 20 Aug 2004 18:43:28 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <reiserfs-dev@namesys.com>
Subject: Re: 2.6.8.1-mm2
In-Reply-To: <20040819014204.2d412e9b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0408201753250.4192-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, Andrew Morton wrote:

> - Added the reiser4 filesystem.

Time for a quick scan through the code, comments in order in which
I ran into stuff, not in order of importance.

> reiser4-include-reiser4.patch

Might be an idea to trim some of the excess text from the help
entry and make things a bit more professional.

> reiser4-perthread-pages.patch

If a task exits unexpectedly, it will leak the reserved pages.
This memory leak wants fixing...

Also, why the !in_interrupt() test in perthread_pages_alloc() ?
Surely this function shouldn't be called from interrupts, since
it is a general purpose pool of pages.

> reiser4-radix-tree-tag.patch

Just a nitpick here, could we rename PAGECACHE_TAG_FS_SPECIFIC
to PAGECACHE_TAG_FS_PRIVATE, since we're using the name "private"
in half a number of other places for the exact same purpose ?

> reiser4-radix_tree_lookup_slot.patch

Having reiserfs dig into the radix tree looks like a layering
violation to me.  If there is a real need to replace pagecache
pages with other pages in the radix tree, maybe we should have
a function to do that in the pagecache code, leaving reiserfs
to call things at the right abstraction level ?

I see a potential for race conditions when reiserfs changes a
page which write has just looked up, and what about mmap?
Even if the code is safe now, this is bound to result in a
maintenance nightmare down the road.

> reiser4-truncate_inode_pages_range.patch

This has the same race issue as any of the "hole punch"
patches that have been floating around in the past.  The
truncate path has some (subtle!) race prevention that
depends on the nopage functions not searching past i_size,
but this hole punch code doesn't.

I am not convinced this is SMP safe.

cheers,

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


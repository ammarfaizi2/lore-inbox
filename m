Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUHVVj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUHVVj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUHVVj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:39:29 -0400
Received: from clusterfw.beelinegprs.ru ([217.118.66.232]:7546 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S266316AbUHVVij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:38:39 -0400
Date: Mon, 23 Aug 2004 01:32:00 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: 2.6.8.1-mm2
Message-ID: <20040822213200.GD5154@backtop.namesys.com>
References: <20040819014204.2d412e9b.akpm@osdl.org> <Pine.LNX.4.44.0408201753250.4192-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408201753250.4192-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 06:43:28PM -0400, Rik van Riel wrote:
> On Thu, 19 Aug 2004, Andrew Morton wrote:
> 
> > - Added the reiser4 filesystem.
> 
> Time for a quick scan through the code, comments in order in which
> I ran into stuff, not in order of importance.
> 
> > reiser4-include-reiser4.patch
> 
> Might be an idea to trim some of the excess text from the help
> entry and make things a bit more professional.
> 
> > reiser4-perthread-pages.patch
> 
> If a task exits unexpectedly, it will leak the reserved pages.
> This memory leak wants fixing...

Actually reiser4 does care of releasing all reserved pages before 
leaving kernel context.  

Would it be enough to just add a check/pages_release into do_exit() under
something like CONFIG_PERTHREAD_RESERVED_PAGES_DEBUG? 

> 
> Also, why the !in_interrupt() test in perthread_pages_alloc() ?
> Surely this function shouldn't be called from interrupts, since
> it is a general purpose pool of pages.
> 
> > reiser4-radix-tree-tag.patch
> 
> Just a nitpick here, could we rename PAGECACHE_TAG_FS_SPECIFIC
> to PAGECACHE_TAG_FS_PRIVATE, since we're using the name "private"
> in half a number of other places for the exact same purpose ?
> 
> > reiser4-radix_tree_lookup_slot.patch
> 
> Having reiserfs dig into the radix tree looks like a layering
> violation to me.  If there is a real need to replace pagecache
> pages with other pages in the radix tree, maybe we should have
> a function to do that in the pagecache code, leaving reiserfs
> to call things at the right abstraction level ?

Reiser4 uses common radix tree impl. for indexing own objects (jnodes, readdir
cursors), not pages.
 
> I see a potential for race conditions when reiserfs changes a
> page which write has just looked up, and what about mmap?
> Even if the code is safe now, this is bound to result in a
> maintenance nightmare down the road.
> 
> > reiser4-truncate_inode_pages_range.patch
> 
> This has the same race issue as any of the "hole punch"
> patches that have been floating around in the past.  The
> truncate path has some (subtle!) race prevention that
> depends on the nopage functions not searching past i_size,
> but this hole punch code doesn't.

There is an reiser4 inode r/w semaphore which is taken in both reiser4 ->nopage
(unix_file_filemap_nopage) -- for read and in the code with calls
truncate_inode_pages_range() -- for write.  There should be no races.

> 
> I am not convinced this is SMP safe.
> 
> cheers,
> 
> Rik
> -- 
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
> 
Thanks,
Alex.

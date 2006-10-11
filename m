Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030800AbWJKFNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030800AbWJKFNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 01:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030799AbWJKFNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 01:13:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030801AbWJKFNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 01:13:11 -0400
Date: Tue, 10 Oct 2006 22:13:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
Message-Id: <20061010221304.6bef249f.akpm@osdl.org>
In-Reply-To: <20061010121332.19693.37204.sendpatchset@linux.site>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
	<20061010121332.19693.37204.sendpatchset@linux.site>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 16:21:49 +0200 (CEST)
Nick Piggin <npiggin@suse.de> wrote:

> --- linux-2.6.orig/mm/filemap.c
> +++ linux-2.6/mm/filemap.c
> @@ -1392,9 +1392,10 @@ struct page *filemap_nopage(struct vm_ar
>  	unsigned long size, pgoff;
>  	int did_readaround = 0, majmin = VM_FAULT_MINOR;
>  
> +	BUG_ON(!(area->vm_flags & VM_CAN_INVALIDATE));
> +
>  	pgoff = ((address-area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
>  
> -retry_all:
>  	size = (i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
>  	if (pgoff >= size)
>  		goto outside_data_content;
> @@ -1416,7 +1417,7 @@ retry_all:
>  	 * Do we have something in the page cache already?
>  	 */
>  retry_find:
> -	page = find_get_page(mapping, pgoff);
> +	page = find_lock_page(mapping, pgoff);

Here's a little problem.  Locking the page in the pagefault handler takes
our deadlock while writing from a mmapped copy of the page into the same
page from "extremely hard to hit" to "super-easy to hit".  Try running
write-deadlock-demo.c from
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz

It conveniently deadlocks while holding mmap_sem, so `ps' get stuck too.

So this whole idea of locking the page in the fault handler is off the
table until we fix that deadlock for real.  Coincidentally I started coding
a fix for that a couple of weeks ago, but spend too much time with my nose
in other people's crap to get around to writing my own crap.

The basic idea is

- revert the recent changes to the core write() code (the ones which
  killed writev() performance, especially on NFS overwrites).

- clean some stuff up

- modify the core of write() so that instead of doing copy_from_user(),
  we do inc_preempt_count();copy_from_user_inatomic().  So we never enter
  the pagefault handler while holding the lock on the pagecache page.

  If the fault happens, we run commit_write() on however much stuff we
  managed to copy and then go back and try to fault the target page back in
  again.  Repeat for ten times then give up.

  It gets tricky because it means that we'll need to go back to zeroing
  out the uncopied part of the pagecache page before
  commit_write+unlock_page().  This will resurrect the recently-fixed
  problem where userspace can fleetingly see a bunch of zeroes in pagecache
  where it expected to see either the old data or the new data.

  But I don't think that problem was terribly serious, and we can improve
  the situation quite a lot by not doing that zeroing if the page is
  already up-to-date.

Anyway, if you're feeling up to it I'll document the patches I have and hand
them over - they're not making much progress here.


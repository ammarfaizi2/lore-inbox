Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVKUXwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVKUXwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVKUXwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:52:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750793AbVKUXwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:52:19 -0500
Date: Mon, 21 Nov 2005 15:51:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: sander@humilis.net, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Please help me understand ->writepage. Was Re: segfault mdadm
 --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
Message-Id: <20051121155144.62bedaab.akpm@osdl.org>
In-Reply-To: <17282.21309.229128.930997@cse.unsw.edu.au>
References: <431B9558.1070900@baanhofman.nl>
	<17179.40731.907114.194935@cse.unsw.edu.au>
	<20051116133639.GA18274@favonius>
	<20051116142000.5c63449f.akpm@osdl.org>
	<17275.48113.533555.948181@cse.unsw.edu.au>
	<20051117075041.GA5563@favonius>
	<20051117101251.GA2883@favonius>
	<20051117101511.GB2883@favonius>
	<17282.21309.229128.930997@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> Help ???

Indeed.  tmpfs is crackpottery.

>  What md/bitmap wants to do is effectively memory map the file, make
>  updates to pages occasionally, flush those pages out to storage, and
>  wait for the flush to complete.  It doesn't exactly memory map.  It
>  just reads all the pages and keeps them in an array (holding a
>  reference to each).
> 
>  To write the pages out it effectively does ->prepare_write,
>  ->commit_write, and then ->writepage.
>  I'm not sure that prepare/commit is needed, but they don't seem to be
>  the problem.  writepage is.
> 
>  For tmpfs at least, writepage disconnects the page from the pagecache
>  (via move_to_swap_cache), so the page that we are holding is no longer
>  part of the file and, significantly, page->mapping become NULL.
>  This suggests that the ->writepage usage is broken.
>  However I tried to see what 'msync' does for real memory mapped files,
>  and it eventually calls ->writepage too.  So how does that work??
> 
>  Any advice would be most welcome!

Skip the writepage if !mapping_cap_writeback_dirty(page->mapping), I guess.
Or, if appropriate, just sync the file.  Use filemap_fdatawrite() or even
refactor do_fsync() and use most of that.

Also, write_page() doesn't need to run set_page_dirty(); ->commit_write()
will do that.

Several kmap()s in there which can become kmap_atomic().

bitmap_init_from_disk() might be leaking bitmap->filemap on kmalloc-failed
error path.

bitmap->filemap_attr can be allocated with kzalloc() now.

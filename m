Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUGJF5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUGJF5r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 01:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUGJF5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 01:57:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:23446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266141AbUGJF5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 01:57:44 -0400
Date: Fri, 9 Jul 2004 22:56:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-Id: <20040709225634.2eb0b8b0.akpm@osdl.org>
In-Reply-To: <20040710045920.GY20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random>
	<20040708212923.406135f0.akpm@osdl.org>
	<20040709044205.GF20947@dualathlon.random>
	<20040708215645.16d0f227.akpm@osdl.org>
	<20040710001600.GT20947@dualathlon.random>
	<20040710010738.GX20947@dualathlon.random>
	<20040710045920.GY20947@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> +page_is_mapped:
>  +
>  +	end_index = i_size >> PAGE_CACHE_SHIFT;
>   	if (page->index >= end_index) {
>  -		unsigned offset = i_size_read(inode) & (PAGE_CACHE_SIZE - 1);
>  +		unsigned offset = i_size & (PAGE_CACHE_SIZE - 1);
>   		char *kaddr;
>   
>   		if (page->index > end_index || !offset)
>  @@ -503,8 +506,6 @@ mpage_writepage(struct bio *bio, struct 
>   		kunmap_atomic(kaddr, KM_USER0);
>   	}
>   
>  -page_is_mapped:

What's the thinking behind moving the page_is_mapped label here?

We've established that we have found `first_unmapped' number of uptodate
and dirty buffers at the "front" of the page, and we're about to stick
(first_unmapped<<blkbits) bytes of this page into the BIO for writeout. 
Hence everything which will go into the BIO is known to be uptodate and
dirty.  So I'm wondering why this change was made.


The change is correct, though.  It prevents us from writing non-zero data
between i_size and the end of the final bh to the file. 
block_write_full_page() does it too:

	/*
	 * The page straddles i_size.  It must be zeroed out on each and every
	 * writepage invokation because it may be mmapped.  "A file is mapped
	 * in multiples of the page size.  For a file that is not a multiple of
	 * the  page size, the remaining memory is zeroed when mapped, and
	 * writes to that region are not written out to the file."
	 */

(Note that this is a "best effort" thing - userspace could still write
non-zero data into the mmapped page outside i_size even while I/O is in
flight.  Can't do much about that).

But was this the reason for you making this change?

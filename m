Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965292AbWFATHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbWFATHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWFATHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:07:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965291AbWFATHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:07:54 -0400
Date: Thu, 1 Jun 2006 12:12:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-Id: <20060601121200.457c0335.akpm@osdl.org>
In-Reply-To: <20060601184938.GA31376@suse.de>
References: <20060529214011.GA417@suse.de>
	<20060530182453.GA8701@suse.de>
	<20060601184938.GA31376@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 20:49:38 +0200
Olaf Hering <olh@suse.de> wrote:

> 
> This script will cause cramfs decompression errors, on SMP at least:
> 
> #!/bin/bash                                                                                                                                                          
> while :;do blockdev --flushbufs /dev/loop0;done </dev/null &>/dev/null&
> while :;do ps faxs  </dev/null &>/dev/null&done </dev/null &>/dev/null&
> while :;do dmesg    </dev/null &>/dev/null&done </dev/null &>/dev/null&
> while :;do find /mounts/instsys -type f -print0|xargs -0 cat &>/dev/null;done
> 
> (The used executables come from the symlinked /mounts/instsys directory)
> 
> ...
> Error -3 while decompressing!
> c0000000009592a2(2649)->c0000000edf87000(4096)
> Error -3 while decompressing!
> c000000000959298(2520)->c0000000edbc7000(4096)
> Error -3 while decompressing!
> c000000000959c70(2489)->c0000000f1482000(4096) 
> Error -3 while decompressing!
> c00000000095a629(2355)->c0000000edaff000(4096)
> Error -3 while decompressing!
> ...
> 
> Its a long standing bug, introduced in 2.6.2.
> 
> cramfs_read() clears parts of the src buffer because the page is not uptodate.
> invalidate_bdev() called from block_ioctl(BLKFLSBUF) will set ClearPageUptodate()
> after cramfs_read() got the page from read_cache_page()
> If PageUptodate() fails, read the page again before using it.
> There is still a small window were the page may not be uptodate before copying
> its contents away.
> 
> evms_access does the BLKFLSBUF ioctl (lots of them) on the loop device. This will
> corrupt the SuSE installation image on SMP kernels, leading to random segfaults.
> 

OK, invalidate_inode_pages().

> +
>  	for (i = 0; i < BLKS_PER_BUF; i++) {
> -		struct page *page = pages[i];
> -		if (page) {
> -			memcpy(data, kmap(page), PAGE_CACHE_SIZE);
> -			kunmap(page);
> -			page_cache_release(page);
> -		} else
> -			memset(data, 0, PAGE_CACHE_SIZE);
> +		if (blocknr + i < devsize) {
> +			page = NULL;
> +			for (readagain = 0; readagain < 5; readagain++) {
> +				page = read_cache_page(mapping, blocknr + i,
> +					(filler_t *)mapping->a_ops->readpage,
> +					NULL);
> +				/* synchronous error? */
> +				if (IS_ERR(page)) {
> +					page = NULL;
> +					break;
> +				}
> +				wait_on_page_locked(page);
> +				if (PageUptodate(page))
> +					break;
> +				/* asynchronous error */
> +				/* maybe BLKFLSBUF flushed the page */
> +				page_cache_release(page);
> +				page = NULL;
> +			}
> +			if (page) {
> +				memcpy(data, kmap(page), PAGE_CACHE_SIZE);
> +				kunmap(page);
> +				page_cache_release(page);
> +			} else
> +				memset(data, 0, PAGE_CACHE_SIZE);
> +			if (readagain)
> +				printk(KERN_DEBUG "cramfs_read got %s Uptodate page after %d attempt(s)\n",
> +						page ? "an" : "no", readagain);
> +		}

This code absolutely needs a comment telling the poor reader what it's in
there for.

It's still racy.  Do the memcpy while the page is locked:


retry:
	read_cache_page()
	lock_page()
	if (!PageUptodate()) {
		if (readagain-- != 0)
			goto retry;
		give_up();
	}
	memcpy();
	unlock_page();

Also, let's use kmap_atomic() while we're in there.

Of course, this will all just fail less often than it presently does.  We'd
be better off taking a lock if poss to keep the ioctl away.  I'd have
thought that it'd be appropriate to take i_mutex while running
invalidate_inode_pages().

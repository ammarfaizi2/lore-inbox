Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbUKVKug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUKVKug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUKVKuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:50:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:53228 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262053AbUKVKmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:42:02 -0500
Date: Mon, 22 Nov 2004 02:41:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
Message-Id: <20041122024145.5baaa0b0.akpm@osdl.org>
In-Reply-To: <877joexjk5.fsf@devron.myhome.or.jp>
References: <877joexjk5.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
>  If I do the following operation on fatfs, and my box under heavy load,
> 
>  	open("testfile", O_CREAT | O_TRUNC | O_RDWR, 0664);
>  	lseek(fd, 500*1024*1024 - 1, SEEK_SET);
>  	write(fd, "\0", 1);
> 
>  In cont_prepare_write(), kernel fills the hole by zero cleared page.
> 
>  fs/buffer.c:cont_prepare_write:2210,
>  	while(page->index > (pgpos = *bytes>>PAGE_CACHE_SHIFT)) {
> 
>  		[...]	
> 
>  		status = __block_prepare_write(inode, new_page, zerofrom,
>  						PAGE_CACHE_SIZE, get_block);
>  		if (status)
>  			goto out_unmap;
>  		kaddr = kmap_atomic(new_page, KM_USER0);
>  		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
>  		flush_dcache_page(new_page);
>  		kunmap_atomic(kaddr, KM_USER0);
>  		__block_commit_write(inode, new_page,
>  				zerofrom, PAGE_CACHE_SIZE);
>  		unlock_page(new_page);
>  		page_cache_release(new_page);
>  	}
> 
>  But until ->commit_write(), kernel doesn't update the ->i_size. Then,
>  if kernel writes out that hole page before updates of ->i_size, dirty
>  flag of buffer_head is cleared in __block_write_full_page(). So hole
>  page was not writed to disk.

But the page remains locked across both the ->prepare_write() and
->commit_write() operations.  So writeback cannot get in there to call
->writepage().

The page lock should correctly synchronise the prepare_write/commit_write
and writeback functions.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbUKVKt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUKVKt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUKVKr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:47:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:24450 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262042AbUKVKrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:47:10 -0500
Date: Mon, 22 Nov 2004 02:46:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
Message-Id: <20041122024654.37eb5f3d.akpm@osdl.org>
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

Oh I see.  After the above page is unlocked, it's temporarily outside
i_size.

Perhaps cont_prepare_write() should look to see if the zerofilled page is
outside the current i_size and if so, advance i_size to the end of the
zerofilled page prior to releasing the page lock.

We might need to run mark_inode_dirty() at some stage, or perhaps just rely
on the caller doing that in ->commit_write().

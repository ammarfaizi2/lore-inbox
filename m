Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbWHAGDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWHAGDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 02:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbWHAGDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 02:03:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161086AbWHAGC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 02:02:59 -0400
Date: Mon, 31 Jul 2006 23:02:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]: ufs: ufs_get_locked_patch race fix
Message-Id: <20060731230251.3b149902.akpm@osdl.org>
In-Reply-To: <20060731125702.GA5094@rain>
References: <20060731125702.GA5094@rain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 16:57:02 +0400
Evgeniy Dushistov <dushistov@mail.ru> wrote:

> As discussed earlier:
> http://lkml.org/lkml/2006/6/28/136
> this patch fixes such issue:
> `ufs_get_locked_page' takes page from cache
> after that `vmtruncate' takes page and deletes it from cache
> `ufs_get_locked_page' locks page, and reports about EIO error.
> 
> Also because of find_lock_page always return valid page or NULL,
> we have no need check it if page not NULL.
> 
> Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>
> 
> 
> ---
> 
> 
> Index: linux-2.6.18-rc2-mm1/fs/ufs/util.c
> ===================================================================
> --- linux-2.6.18-rc2-mm1.orig/fs/ufs/util.c
> +++ linux-2.6.18-rc2-mm1/fs/ufs/util.c
> @@ -257,6 +257,7 @@ try_again:
>  		page = read_cache_page(mapping, index,
>  				       (filler_t*)mapping->a_ops->readpage,
>  				       NULL);
> +
>  		if (IS_ERR(page)) {
>  			printk(KERN_ERR "ufs_change_blocknr: "
>  			       "read_cache_page error: ino %lu, index: %lu\n",
> @@ -266,6 +267,13 @@ try_again:
>  
>  		lock_page(page);
>  
> +		if (unlikely(page->mapping != mapping ||
> +			     page->index != index)) {
> +			unlock_page(page);
> +			page_cache_release(page);
> +			goto try_again;
> +		}
> +
>  		if (!PageUptodate(page) || PageError(page)) {
>  			unlock_page(page);
>  			page_cache_release(page);

Looks good to me.

Is there any need to be checking ->index?  Normally we simply use the
sequence:

	lock_page(page);
	if (page->mapping == NULL)
		/* truncate got there first */

to handle this case.

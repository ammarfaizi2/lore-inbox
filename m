Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbWF1Lum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWF1Lum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbWF1Lum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:50:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932784AbWF1Lul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:50:41 -0400
Date: Wed, 28 Jun 2006 04:50:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]: ufs: truncate should allocate block for last byte
Message-Id: <20060628045029.bc10d333.akpm@osdl.org>
In-Reply-To: <20060628093851.GA1719@rain.homenetwork>
References: <20060628093851.GA1719@rain.homenetwork>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 13:38:51 +0400
Evgeniy Dushistov <dushistov@mail.ru> wrote:

> +struct page *ufs_get_locked_page(struct address_space *mapping,
> +				 pgoff_t index)
> +{
> +	struct page *page;
> +
> +try_again:
> +	page = find_lock_page(mapping, index);
> +	if (!page) {
> +		page = read_cache_page(mapping, index,
> +				       (filler_t*)mapping->a_ops->readpage,
> +				       NULL);
> +		if (IS_ERR(page)) {
> +			printk(KERN_ERR "ufs_change_blocknr: "
> +			       "read_cache_page error: ino %lu, index: %lu\n",
> +			       mapping->host->i_ino, index);
> +			goto out;
> +		}
> +
> +		lock_page(page);
> +
> +		if (!PageUptodate(page) || PageError(page)) {
> +			unlock_page(page);
> +			page_cache_release(page);
> +
> +			printk(KERN_ERR "ufs_change_blocknr: "
> +			       "can not read page: ino %lu, index: %lu\n",
> +			       mapping->host->i_ino, index);
> +
> +			page = ERR_PTR(-EIO);
> +			goto out;
> +		}
> +	}
> +
> +	if (unlikely(!page->mapping || !page_has_buffers(page))) {
> +		unlock_page(page);
> +		page_cache_release(page);
> +		goto try_again;/*we really need these buffers*/
> +	}
> +out:
> +	return page;
> +}

I think there's a (preexisting) problem here.  When one thread is executing
ufs_get_locked_page() while a second thread is running truncate().

If truncate got to the page first, truncate_complete_page() will mark the
page !uptodate and will later unlock it.  Now this function gets the page
lock and emits a printk (bad) and assumes -EIO (worse).

That scenario might not be possible because of i_mutex coverage, dunno.

But if it _is_ possible, it can be simply fixed by doing

	lock_page(page);
+	if (page->mapping == NULL) {
+		/* truncate() got there first */
+		page_cache_release(page);
+		goto try_again;
+	}

That's if it is appropriate to re-instantiate the page at a place which is
now outside i_size...


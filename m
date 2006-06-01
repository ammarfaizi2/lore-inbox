Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965310AbWFAVVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965310AbWFAVVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965313AbWFAVVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:21:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:722 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965310AbWFAVVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:21:12 -0400
Date: Thu, 1 Jun 2006 14:24:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-Id: <20060601142400.1352f903.akpm@osdl.org>
In-Reply-To: <20060601201050.GA32221@suse.de>
References: <20060529214011.GA417@suse.de>
	<20060530182453.GA8701@suse.de>
	<20060601184938.GA31376@suse.de>
	<20060601121200.457c0335.akpm@osdl.org>
	<20060601201050.GA32221@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
> 
>  
> +/* return a page in PageUptodate state, BLKFLSBUF may have flushed the page */
> +static struct page *cramfs_read_cache_page(struct address_space *m, unsigned int n)
> +{
> +	struct page *page;
> +	int readagain = 5;
> +retry:
> +	page = read_cache_page(m, n, (filler_t *)m->a_ops->readpage, NULL);
> +	if (IS_ERR(page))
> +		return NULL;
> +	lock_page(page);
> +	if (PageUptodate(page))
> +		return page;
> +	unlock_page(page);
> +	page_cache_release(page);
> +	if (readagain--)
> +		goto retry;
> +	return NULL;
> +}

Better, but it's still awful, isn't it?  The things you were discussing
with Chris look more promising.  PG_Dirty would be a bit of a hack, but at
least it'd be a 100% reliable hack, whereas the above is a
whatever-the-previous-failure-rate-was-to-the-fifth hack.

> +			page = cramfs_read_cache_page(mapping, blocknr + i);
> +			if (page) {
> +				memcpy(data, kmap_atomic(page, KM_USER0), PAGE_CACHE_SIZE);
> +				kunmap(page);

kunmap_atomic, please.

> +				unlock_page(page);
> +				page_cache_release(page);
> +			} else
> +				memset(data, 0, PAGE_CACHE_SIZE);
> +		}
>  		data += PAGE_CACHE_SIZE;
>  	}
>  	return read_buffers[buffer] + offset;

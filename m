Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287184AbRL2LDd>; Sat, 29 Dec 2001 06:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287194AbRL2LDY>; Sat, 29 Dec 2001 06:03:24 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:44807 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287182AbRL2LDG>; Sat, 29 Dec 2001 06:03:06 -0500
Message-ID: <3C2DA1C9.8EB54896@zip.com.au>
Date: Sat, 29 Dec 2001 02:58:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alad@hss.hns.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Mapped pages handling in shrink_cache()
In-Reply-To: <65256B31.0038FC61.00@sandesh.hss.hns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alad@hss.hns.com wrote:
> 
> Hi, In the following code from shrink_cache()
> 
>           if (PageDirty(page) && is_page_cache_freeable(page) && page->mapping)
> {
>                .
>                .
>                .
> 
>                int (*writepage)(struct page *);
> 
>                writepage = page->mapping->a_ops->writepage;
>                if ((gfp_mask & __GFP_FS) && writepage) {
>                     ClearPageDirty(page);
>                     SetPageLaunder(page);
>                     page_cache_get(page);
>                     spin_unlock(&pagemap_lru_lock);
> 
>                     writepage(page);
>                     page_cache_release(page);
> 
>                     spin_lock(&pagemap_lru_lock);
>                     continue;      <<<<<<< shouldn't the page be unlocked before
>  continuing with the next page <<<<<
>                }
> 

The page is unlocked when IO completes, in interrupt context.
See end_buffer_io_async().

Return-Path: <linux-kernel-owner+w=401wt.eu-S1754829AbWL1LzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbWL1LzW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 06:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbWL1LzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 06:55:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40022 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbWL1LzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 06:55:21 -0500
Date: Thu, 28 Dec 2006 11:55:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [FSAIO][PATCH 6/8] Enable asynchronous wait page and lock page
Message-ID: <20061228115510.GA25644@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
	akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20061228084149.GF6971@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228084149.GF6971@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 02:11:49PM +0530, Suparna Bhattacharya wrote:
> -extern void FASTCALL(lock_page_slow(struct page *page));
> +extern int FASTCALL(__lock_page_slow(struct page *page, wait_queue_t *wait));
>  extern void FASTCALL(__lock_page_nosync(struct page *page));
>  extern void FASTCALL(unlock_page(struct page *page));
>  
>  /*
>   * lock_page may only be called if we have the page's inode pinned.
>   */
> -static inline void lock_page(struct page *page)
> +static inline int __lock_page(struct page *page, wait_queue_t *wait)
>  {
>  	might_sleep();
>  	if (TestSetPageLocked(page))
> -		lock_page_slow(page);
> +		return __lock_page_slow(page, wait);
> +	return 0;
>  }
>  
> +#define lock_page(page)		__lock_page(page, &current->__wait.wait)
> +#define lock_page_slow(page)	__lock_page_slow(page, &current->__wait.wait)

Can we please simply kill your lock_page_slow wrapper and rename the
arguments taking __lock_page_slow to lock_page_slow?  All too many
variants of the locking functions aren't all that useful and there's
very few users.

Similarly I don't really think __lock_page is an all that useful name here.
What about lock_page_wq?  or aio_lock_page to denote it has special
meaning in aio contect?  Then again because of these special sematics
we need a bunch of really verbose kerneldoc comments for this function
famility.


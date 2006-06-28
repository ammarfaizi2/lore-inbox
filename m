Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWF1TTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWF1TTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWF1TTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:19:47 -0400
Received: from tzec.mtu.ru ([195.34.34.228]:39435 "EHLO tzec.mtu.ru")
	by vger.kernel.org with ESMTP id S1751029AbWF1TTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:19:46 -0400
Subject: Re: Unkillable process in last git -- Bisected
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       stable@kernel.org
In-Reply-To: <20060628203825.47790a10@localhost>
References: <20060628142918.1b2c25c3@localhost>
	 <20060628145349.53873ccc@localhost> <20060628150943.78e91871@localhost>
	 <20060628151955.0acdb39a@localhost>  <20060628203825.47790a10@localhost>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 23:06:17 +0400
Message-Id: <1151521577.10385.3.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Wed, 2006-06-28 at 20:38 +0200, Paolo Ornati wrote:
> > Running "localedef" triggers an infinite loop in kernel mode (or
> > something) --> localdef becomes unkillable.
> > 

Can you, please, run localedef under strace -e set=open,write on a
kernel having the below patch applied, so that we will see arguments of
write which caused write to fall into endless loop.


> commit 6527c2bdf1f833cc18e8f42bd97973d583e4aa83
> Author: Vladimir V. Saveliev <vs@namesys.com>
> Date:   Tue Jun 27 02:53:57 2006 -0700
> 
>     [PATCH] generic_file_buffered_write(): deadlock on vectored write
>     
>     generic_file_buffered_write() prefaults in user pages in order to avoid
>     deadlock on copying from the same page as write goes to.
>     
>     However, it looks like there is a problem when write is vectored:
>     fault_in_pages_readable brings in current segment or its part (maxlen).
>     OTOH, filemap_copy_from_user_iovec is called to copy number of bytes
>     (bytes) which may exceed current segment, so filemap_copy_from_user_iovec
>     switches to the next segment which is not brought in yet.  Pagefault is
>     generated.  That causes the deadlock if pagefault is for the same page
>     write goes to: page being written is locked and not uptodate, pagefault
>     will deadlock trying to lock locked page.
>     
>     [akpm@osdl.org: somewhat rewritten]
>     Cc: Neil Brown <neilb@suse.de>
>     Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>     Cc: <stable@kernel.org>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 9c7334b..d504d6e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2095,14 +2095,21 @@ generic_file_buffered_write(struct kiocb
>  	do {
>  		unsigned long index;
>  		unsigned long offset;
> -		unsigned long maxlen;
>  		size_t copied;
>  
>  		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
>  		index = pos >> PAGE_CACHE_SHIFT;
>  		bytes = PAGE_CACHE_SIZE - offset;
> -		if (bytes > count)
> -			bytes = count;
> +
> +		/* Limit the size of the copy to the caller's write size */
> +		bytes = min(bytes, count);
> +
> +		/*
> +		 * Limit the size of the copy to that of the current segment,
> +		 * because fault_in_pages_readable() doesn't know how to walk
> +		 * segments.
> +		 */
> +		bytes = min(bytes, cur_iov->iov_len - iov_base);
>  
>  		/*
>  		 * Bring in the user page that we will copy from _first_.
> @@ -2110,10 +2117,7 @@ generic_file_buffered_write(struct kiocb
>  		 * same page as we're writing to, without it being marked
>  		 * up-to-date.
>  		 */
> -		maxlen = cur_iov->iov_len - iov_base;
> -		if (maxlen > bytes)
> -			maxlen = bytes;
> -		fault_in_pages_readable(buf, maxlen);
> +		fault_in_pages_readable(buf, bytes);
>  
>  		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
>  		if (!page) {
> 
> 
> 


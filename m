Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVA3KKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVA3KKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 05:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVA3KKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 05:10:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:5074 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261664AbVA3KKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 05:10:17 -0500
Date: Sun, 30 Jan 2005 02:10:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: Correct way to release get_user_pages()?
Message-Id: <20050130021017.7ef1c764.akpm@osdl.org>
In-Reply-To: <41FA7AE2.10209@ammasso.com>
References: <52pszqw917.fsf@topspin.com>
	<41FA7AE2.10209@ammasso.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> wrote:
>
>  Roland Dreier wrote:
> 
>  > Reading through the tree, I see that some callers of get_user_pages()
>  > release the pages that they got via put_page(), and some callers use
>  > page_cache_release().  Of course <linux/pagemap.h> has
>  > 
>  > 	#define page_cache_release(page)      put_page(page)
>  > 
>  > so this is really not much of a difference, but I'd like to know which
>  > is considered better style.  Any opinions?

I guess we should only use page_cache_release() if the page is known to be
pagecache.  In the case of get_user_pages() the page could of course be
anonymous in which case put_page is probably more appropriate.  It's all a
bit of a mess and if we ever do end up having PAGE_CACHE_SIZE > PAGE_SIZE,
someone will have some work to do.

I suppose put_page() would be better for now.

>  I've defined this function.  I'm not sure if it really works, but it 
>  looks good.
> 
>  #include <linux/pagemap.h>
> 
>  void put_user_pages(int len, struct page **pages)
>  {
>           int i;
> 
>           for (i=0; i<len; i++) {
>                   if (!PageReserved(pages[i])) {
>                           SetPageDirty(pages[i]);
>                   }
>                   page_cache_release(pages[i]);
>           }
>  }

no...  You should only dirty the page if it was modified, and then use
set_page_dirty() or set_page_dirty_lock().

See dio_bio_complete() for an example.

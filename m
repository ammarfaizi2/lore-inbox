Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264737AbUDWKfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbUDWKfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 06:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUDWKfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 06:35:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:5261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264737AbUDWKfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 06:35:42 -0400
Date: Fri, 23 Apr 2004 03:35:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: put_page() tries to handle hugepages but fails
Message-Id: <20040423033522.03ab14fc.akpm@osdl.org>
In-Reply-To: <20040423102824.GF743@holomorphy.com>
References: <20040423081856.GJ9243@zax>
	<20040423013437.1f2b8fc6.akpm@osdl.org>
	<20040423102824.GF743@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> --- wli-2.6.6-rc2-mm1.orig/mm/swap.c	2004-04-21 05:19:58.000000000 -0700
>  +++ wli-2.6.6-rc2-mm1/mm/swap.c	2004-04-23 03:21:22.000000000 -0700
>  @@ -41,15 +41,12 @@
>   	if (unlikely(PageCompound(page))) {
>   		page = (struct page *)page->private;
>   		if (put_page_testzero(page)) {
>  -			if (page[1].mapping) {	/* destructor? */
>  -				(*(void (*)(struct page *))page[1].mapping)(page);
>  -			} else {
>  -				__page_cache_release(page);
>  -			}
>  +			void (*destructor)(struct page *);
>  +			destructor = (void (*)(struct page *))page[1].mapping;
>  +			BUG_ON(!destructor);
>  +			(*destructor)(page);
>   		}
>  -		return;
>  -	}
>  -	if (!PageReserved(page) && put_page_testzero(page))
>  +	} else if (!PageReserved(page) && put_page_testzero(page))
>   		__page_cache_release(page);

Sure.

This of course duplicates huge_page_release(), which can be killed off.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVATObl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVATObl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 09:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVATObl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 09:31:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28938 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262112AbVATObj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 09:31:39 -0500
Date: Thu, 20 Jan 2005 14:31:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: zhan rongkai <zhanrk@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: fix the bug of __free_pages() of mm/page_alloc.c
Message-ID: <20050120143133.A13242@flint.arm.linux.org.uk>
Mail-Followup-To: zhan rongkai <zhanrk@gmail.com>,
	linux-kernel@vger.kernel.org
References: <73e62045050120053463b7e763@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <73e62045050120053463b7e763@mail.gmail.com>; from zhanrk@gmail.com on Thu, Jan 20, 2005 at 09:34:17PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 09:34:17PM +0800, zhan rongkai wrote:
> [PATCH]: fix the bug of __free_pages() of mm/page_alloc.c
> =========================================================
> 
> The buddy allocator's __free_pages() function seems to be buggy.
> 
> The following codes are from kernel 2.6.10:
> 
> fastcall void __free_pages(struct page *page, unsigned int order)
> {
> 	if (!PageReserved(page) && put_page_testzero(page)) {
> 		if (order == 0)
> 			free_hot_page(page);
> 		else
> 			__free_pages_ok(page, order);
> 	}
> }
> 
> As you know, before truely freeing all pages, this function calls
> put_page_testzero(page) to
> drop the refcount of the pages.
> 
> But, in fact the macro put_page_testzero(page) **only** drops **one**
> page's refcount.
> Therefore, if (order > 0), the refcounts of (page+1) ..
> (page+(1<<order)-1) are unchanged!
> This will cause __free_pages_ok() to dump stack, because it finds some
> pages' page_count()
> are not zero!

When you allocate a page with order > 0, the first 0-order page has a
refcount of 1, and the remaining 0-order pages have a refcount of 0.

If you're triggering this check, I suspect you're fiddling about with
the individual pages (using get_page on them individually?) which is
a no-no.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

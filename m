Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVCJG4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVCJG4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 01:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCJG4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 01:56:08 -0500
Received: from fire.osdl.org ([65.172.181.4]:17838 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261861AbVCJGzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 01:55:51 -0500
Date: Wed, 9 Mar 2005 22:55:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: hch@infradead.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
Message-Id: <20050309225516.55195ddc.akpm@osdl.org>
In-Reply-To: <yq0k6oydjjv.fsf@jaguar.mkp.net>
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050222020309.4289504c.akpm@osdl.org>
	<yq0ekf8lksf.fsf@jaguar.mkp.net>
	<20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
	<20050222112513.4162860d.akpm@osdl.org>
	<yq0zmxwgqxr.fsf@jaguar.mkp.net>
	<20050222153456.502c3907.akpm@osdl.org>
	<yq0sm3negtb.fsf@jaguar.mkp.net>
	<20050223223404.GA21383@infradead.org>
	<yq0k6oydjjv.fsf@jaguar.mkp.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@wildopensource.com> wrote:
>
> Convert /dev/mem read/write calls to use arch_translate_mem_ptr if
>  available. Needed on ia64 for pages converted fo uncached mappings to
>  avoid it being accessed in cached mode after the conversion which can
>  lead to memory corruption. Introduces PG_uncached page flag for
>  marking pages uncached.

For some reason this patch still gives me the creeps.  Maybe it's because
we lose a page flag for something so obscure.

Nothing ever clears PG_uncached.  We'll end up with every page in the
machine marked as being uncached.

But then, nothing ever sets PG_uncached, either.  Is there some patch which
you're hiding from me?

If a page is marked uncached then it'll remain marked as uncached even
after it's unmapped.  Or will it?  Would like to see the other patch, please.

We should add PG_uncached checks to the page allocator.  Is this OK?


--- 25/mm/page_alloc.c~ia64-specific-dev-mem-handlers-checks	2005-03-09 22:53:12.000000000 -0800
+++ 25-akpm/mm/page_alloc.c	2005-03-09 22:53:44.000000000 -0800
@@ -108,6 +108,7 @@ static void bad_page(const char *functio
 			1 << PG_active	|
 			1 << PG_dirty	|
 			1 << PG_swapcache |
+			1 << PG_uncached |
 			1 << PG_writeback);
 	set_page_count(page, 0);
 	reset_page_mapcount(page);
@@ -321,6 +322,7 @@ static inline void free_pages_check(cons
 			1 << PG_reclaim	|
 			1 << PG_slab	|
 			1 << PG_swapcache |
+			1 << PG_uncached |
 			1 << PG_writeback )))
 		bad_page(function, page);
 	if (PageDirty(page))
@@ -446,6 +448,7 @@ static void prep_new_page(struct page *p
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_swapcache |
+			1 << PG_uncached |
 			1 << PG_writeback )))
 		bad_page(__FUNCTION__, page);
 
_


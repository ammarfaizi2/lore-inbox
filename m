Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVLHTUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVLHTUg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVLHTUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:20:36 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:39076 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932262AbVLHTUf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:20:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dz1f8p03k+8V9n4OMq/RhIIwlDr81msVswtnb0v1TBLTWnnmyQlGL/GqnpE98ALzMC+M8N2ZOMQ4sfUUhKCsOHNMM8FFKm/Z+h3YbSotKZ6Q3iPMVUs3iY3viU5FuF14u/km0X9vrR88ayoKX0jHeNCpptB6/vLVLOdKiZa1Eqs=
Message-ID: <84144f020512081120u428ebd6eud0566a7d57a7726a@mail.gmail.com>
Date: Thu, 8 Dec 2005 21:20:33 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: allowed pages in the block later, was Re: [Ext2-devel] [PATCH] ext3: avoid sending down non-refcounted pages
Cc: open-iscsi@googlegroups.com, Christoph Hellwig <hch@infradead.org>,
       FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <439879ED.5050706@cs.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051208180900T.fujita.tomonori@lab.ntt.co.jp>
	 <20051208101833.GM14509@schatzie.adilger.int>
	 <20051208134239.GA13376@infradead.org> <439878E4.6060505@cs.wisc.edu>
	 <439879ED.5050706@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/8/05, Mike Christie <michaelc@cs.wisc.edu> wrote:
> Or there is not a way to do kmalloc(GFP_BLK) that gives us the right
> type of memory is there?

The slab allocator uses page->lru for special purposes. See
page_{set|get}_{cache|slab} in mm/slab.c. They are used by kfree(),
ksize() and slab debugging code to lookup the cache and slab an void
pointer belongs to.

But, if you just need put_page and get_page, couldn't you do something
like the following?

                                       Pekka

Index: 2.6/mm/swap.c
===================================================================
--- 2.6.orig/mm/swap.c
+++ 2.6/mm/swap.c
@@ -36,6 +36,9 @@ int page_cluster;

 void put_page(struct page *page)
 {
+	if (unlikely(PageSlab(page)))
+		return;
+
 	if (unlikely(PageCompound(page))) {
 		page = (struct page *)page_private(page);
 		if (put_page_testzero(page)) {
Index: 2.6/include/linux/mm.h
===================================================================
--- 2.6.orig/include/linux/mm.h
+++ 2.6/include/linux/mm.h
@@ -322,6 +322,9 @@ static inline int page_count(struct page

 static inline void get_page(struct page *page)
 {
+	if (unlikely(PageSlab(page)))
+		return;
+
 	if (unlikely(PageCompound(page)))
 		page = (struct page *)page_private(page);
 	atomic_inc(&page->_count);

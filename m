Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVAUDcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVAUDcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 22:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVAUDcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 22:32:21 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:4112 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262246AbVAUDcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 22:32:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SukkT0Ldj/AsP6hjxbewrUfa9noNM0mJZ6583rz5nAOltDQpMWW2h+9yp7VCD/Y1s5b78FMTzBbiZYO9WZAPO8LNY6cNQvGe8BTzmlI1gUOZPPe3ApRSshl6xqrix6ZoQBUwCwi5Mr3Ira/JxkeMdundk/DBW43MRAEo6MfZh6E=
Message-ID: <73e62045050120193214c1abf7@mail.gmail.com>
Date: Fri, 21 Jan 2005 11:32:08 +0800
From: zhan rongkai <zhanrk@gmail.com>
Reply-To: zhan rongkai <zhanrk@gmail.com>
To: zhan rongkai <zhanrk@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: fix the bug of __free_pages() of mm/page_alloc.c
In-Reply-To: <20050120143133.A13242@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <73e62045050120053463b7e763@mail.gmail.com>
	 <20050120143133.A13242@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005 14:31:34 +0000, Russell King
<rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Jan 20, 2005 at 09:34:17PM +0800, zhan rongkai wrote:
> > [PATCH]: fix the bug of __free_pages() of mm/page_alloc.c
> > =========================================================
> >
> > The buddy allocator's __free_pages() function seems to be buggy.
> >
> > The following codes are from kernel 2.6.10:
> >
> > fastcall void __free_pages(struct page *page, unsigned int order)
> > {
> >       if (!PageReserved(page) && put_page_testzero(page)) {
> >               if (order == 0)
> >                       free_hot_page(page);
> >               else
> >                       __free_pages_ok(page, order);
> >       }
> > }
> >
> > As you know, before truely freeing all pages, this function calls
> > put_page_testzero(page) to
> > drop the refcount of the pages.
> >
> > But, in fact the macro put_page_testzero(page) **only** drops **one**
> > page's refcount.
> > Therefore, if (order > 0), the refcounts of (page+1) ..
> > (page+(1<<order)-1) are unchanged!
> > This will cause __free_pages_ok() to dump stack, because it finds some
> > pages' page_count()
> > are not zero!
> 
> When you allocate a page with order > 0, the first 0-order page has a
> refcount of 1, and the remaining 0-order pages have a refcount of 0.

Thank you for telling me this point.

> If you're triggering this check, I suspect you're fiddling about with
> the individual pages (using get_page on them individually?) which is
> a no-no.
> 
> --
> Russell King
> 

Oh, I forget to tell you that my CPU has no MMU, sorry:-)
Let's see the function set_page_refs() which is called by
prep_new_page() function:

static inline void set_page_refs(struct page *page, int order)
{
#ifdef CONFIG_MMU
	set_page_count(page, 1);
#else
	int i;

	/*
	 * We need to reference all the pages for this order, otherwise if
	 * anyone accesses one of the pages with (get/put) it will be freed.
	 */
	for (i = 0; i < (1 << order); i++)
		set_page_count(page+i, 1);
#endif /* CONFIG_MMU */
}

We can see that it sets all pages' refcount to 1 when there is no MMU.

My previous patch is wrong. Here is new one:
--------------------------------------------

--- linux-2.6.10.orig/mm/page_alloc.c	2004-12-25 05:33:51.000000000 +0800
+++ linux-2.6.10/mm/page_alloc.c	2005-01-21 11:34:57.000000000 +0800
@@ -787,8 +787,23 @@
 }
 
 fastcall void __free_pages(struct page *page, unsigned int order)
-{
-	if (!PageReserved(page) && put_page_testzero(page)) {
+{	
+	if (!PageReserved(page)) {
+#ifdef CONFIG_MMU
+		if (!put_page_testzero(page))
+			return;
+#else
+		int i, result = 1;
+
+		/*
+		 * We need to de-reference all the pages for this order -- see
set_page_refs()
+		 */
+		 for (i = 0; i < (1 << order); i++)
+			 result &= put_page_testzero(page);
+		 if (!result)
+			 BUG();
+#endif /* CONFIG_MMU */
+
 		if (order == 0)
 			free_hot_page(page);
 		else

-- 
Rongkai Zhan

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbUKQDjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbUKQDjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbUKQDjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:39:16 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:29528 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262194AbUKQDho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:37:44 -0500
Message-ID: <419AC783.5040909@yahoo.com.au>
Date: Wed, 17 Nov 2004 14:37:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, dhowells@redhat.com, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Making compound pages mandatory
References: <2315.1100630906@redhat.com>	<Pine.LNX.4.58.0411161746110.2222@ppc970.osdl.org> <20041116182841.4ff7f2e5.akpm@osdl.org> <419AC1C6.4050403@yahoo.com.au> <419AC3E7.9010904@yahoo.com.au>
In-Reply-To: <419AC3E7.9010904@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------080507010908080001050808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080507010908080001050808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Nick Piggin wrote:
> 
>>
>> Good idea. BTW, any reason why the following (very)micro optimisation
>> shouldn't go in?
>>
>> It currently only picks up a couple of things under fs/, but might help
>> reduce other ifdefery around the place. For example mm.h: page_count and
>> get_page.
>>
> 
> Like this, perhaps? It does actually introduce a change in the object
> code. Namely hugetlb's put_page will now also be done inline for non
> compound pages - maybe this change is unacceptable though, but it does
> cut down the ifdefs.

Err... attached.

--------------080507010908080001050808
Content-Type: text/x-patch;
 name="mm-less-ifdefs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-less-ifdefs.patch"




---

 linux-2.6-npiggin/include/linux/mm.h |   20 ++++----------------
 linux-2.6-npiggin/mm/swap.c          |   20 +++++++-------------
 2 files changed, 11 insertions(+), 29 deletions(-)

diff -puN include/linux/mm.h~mm-less-ifdefs include/linux/mm.h
--- linux-2.6/include/linux/mm.h~mm-less-ifdefs	2004-11-17 14:14:12.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mm.h	2004-11-17 14:17:24.000000000 +1100
@@ -288,11 +288,9 @@ struct page {
 
 extern void FASTCALL(__page_cache_release(struct page *));
 
-#ifdef CONFIG_HUGETLB_PAGE
-
 static inline int page_count(struct page *p)
 {
-	if (PageCompound(p))
+	if (unlikely(PageCompound(p)))
 		p = (struct page *)p->private;
 	return atomic_read(&(p)->_count) + 1;
 }
@@ -304,25 +302,15 @@ static inline void get_page(struct page 
 	atomic_inc(&page->_count);
 }
 
-void put_page(struct page *page);
-
-#else		/* CONFIG_HUGETLB_PAGE */
-
-#define page_count(p)		(atomic_read(&(p)->_count) + 1)
-
-static inline void get_page(struct page *page)
-{
-	atomic_inc(&page->_count);
-}
-
+void put_compound_page(struct page *page);
 static inline void put_page(struct page *page)
 {
+	if (unlikely(PageCompound(page)))
+		put_compound_page(page);
 	if (!PageReserved(page) && put_page_testzero(page))
 		__page_cache_release(page);
 }
 
-#endif		/* CONFIG_HUGETLB_PAGE */
-
 /*
  * Multiple processes may "see" the same page. E.g. for untouched
  * mappings of /dev/null, all processes see the same page full of
diff -puN mm/swap.c~mm-less-ifdefs mm/swap.c
--- linux-2.6/mm/swap.c~mm-less-ifdefs	2004-11-17 14:15:20.000000000 +1100
+++ linux-2.6-npiggin/mm/swap.c	2004-11-17 14:15:48.000000000 +1100
@@ -35,23 +35,17 @@
 int page_cluster;
 
 #ifdef CONFIG_HUGETLB_PAGE
-
-void put_page(struct page *page)
+void put_compound_page(struct page *page)
 {
-	if (unlikely(PageCompound(page))) {
-		page = (struct page *)page->private;
-		if (put_page_testzero(page)) {
-			void (*dtor)(struct page *page);
+	page = (struct page *)page->private;
+	if (put_page_testzero(page)) {
+		void (*dtor)(struct page *page);
 
-			dtor = (void (*)(struct page *))page[1].mapping;
-			(*dtor)(page);
-		}
-		return;
+		dtor = (void (*)(struct page *))page[1].mapping;
+		(*dtor)(page);
 	}
-	if (!PageReserved(page) && put_page_testzero(page))
-		__page_cache_release(page);
 }
-EXPORT_SYMBOL(put_page);
+EXPORT_SYMBOL(put_compound_page);
 #endif
 
 /*

_

--------------080507010908080001050808--

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315380AbSEGIJJ>; Tue, 7 May 2002 04:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315381AbSEGIJI>; Tue, 7 May 2002 04:09:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14483 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315380AbSEGIJH>;
	Tue, 7 May 2002 04:09:07 -0400
Date: Tue, 7 May 2002 13:04:46 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Suparna <bsuparna@in.ibm.com>, Andrew Morton <akpm@zip.com.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, marcelo@brutus.conectiva.com.br,
        linux-mm@kvack.org
Subject: Re: [PATCH]Fix: Init page count for all pages during higher order allocs
Message-ID: <20020507130446.F982@in.ibm.com>
Reply-To: bharata@in.ibm.com
In-Reply-To: <20020429202446.A2326@in.ibm.com> <m1r8ky1jzu.fsf@frodo.biederman.org> <20020430110108.A1275@in.ibm.com> <3CCEF4CC.C56E31B8@zip.com.au> <20020502142441.A1668@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 02:24:41PM +0530, Suparna Bhattacharya wrote:
> On Tue, Apr 30, 2002 at 12:47:24PM -0700, Andrew Morton wrote:
> 
> > An alternative is to just set PG_inuse against _all_ pages
> > in rmqueue(), and clear PG_inuse against all pages in
> > __free_pages_ok().  Which seems cleaner, and would fix other
> > problems, I suspect.
> 
> This works well for us. If no one minds the extra flag, and it
> is preferable to the option of initializing page count for 
> higher order pages, we'll go ahead and do this.
>  

Here is a patch against 2.4.18 kernel which uses PG_inuse page flag.
As has been discussed in this thread, this flag will be used to track all 
pages (including partial higher order pages) allocated by the kernel.

Per Andi Kleen's suggestion it is preferable to use __set_bit/__clear_bit
in this case. However __clear_bit doesn't seem to be defined for all
architectures in 2.4, and hence we couldn't use it in arch
independent code as yet. A backport from 2.5 can be contemplated, but
even there definitions seem to be missing for some archs (e.g mips).


diff -urN -X dontdiff 2418-pure/include/linux/mm.h linux-2.4.18+flg/include/linux/mm.h
--- 2418-pure/include/linux/mm.h	Fri Dec 21 23:12:03 2001
+++ linux-2.4.18+flg/include/linux/mm.h	Tue May  7 12:46:53 2002
@@ -285,6 +285,9 @@
 #define PG_arch_1		13
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
+#define PG_inuse		16	/* set for all pages(including higher
+					   order partial-pages) allocated 
+					   by the kernel. */
 
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)
@@ -301,6 +304,15 @@
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
 #define PageLaunder(page)	test_bit(PG_launder, &(page)->flags)
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
+
+/* 
+ * Using the non-atomic version __set_bit as per Andi Kleen's suggestion.
+ * Currently __clear_bit is not available on all architectures in 2.4.
+ */
+#define PageInuse(page)		test_bit(PG_inuse, &(page)->flags)
+#define SetPageInuse(page)	__set_bit(PG_inuse, &(page)->flags)
+/* Replace this by __clear_bit in 2.5 */
+#define ClearPageInuse(page)	clear_bit(PG_inuse, &(page)->flags)
 
 extern void FASTCALL(set_page_dirty(struct page *));
 
diff -urN -X dontdiff 2418-pure/mm/page_alloc.c linux-2.4.18+flg/mm/page_alloc.c
--- 2418-pure/mm/page_alloc.c	Tue Feb 26 01:08:14 2002
+++ linux-2.4.18+flg/mm/page_alloc.c	Thu May  2 15:16:05 2002
@@ -69,6 +69,14 @@
 	free_area_t *area;
 	struct page *base;
 	zone_t *zone;
+	unsigned int i;
+
+	i = 1UL << order;
+	page += i;
+	do {
+		page--;
+		ClearPageInuse(page);
+	} while (--i);
 
 	/* Yes, think what happens when other parts of the kernel take 
 	 * a reference to a page in order to pin it for io. -ben
@@ -181,7 +189,7 @@
 static struct page * rmqueue(zone_t *zone, unsigned int order)
 {
 	free_area_t * area = zone->free_area + order;
-	unsigned int curr_order = order;
+	unsigned int i, curr_order = order;
 	struct list_head *head, *curr;
 	unsigned long flags;
 	struct page *page;
@@ -206,6 +214,13 @@
 			page = expand(zone, page, index, order, curr_order, area);
 			spin_unlock_irqrestore(&zone->lock, flags);
 
+			i = 1UL << order;
+			page += i;
+			do {
+				page--;
+				SetPageInuse(page);
+			} while (--i);
+
 			set_page_count(page, 1);
 			if (BAD_RANGE(zone,page))
 				BUG();
@@ -236,6 +251,7 @@
 {
 	struct page * page = NULL;
 	int __freed = 0;
+	unsigned int i;
 
 	if (!(gfp_mask & __GFP_WAIT))
 		goto out;
@@ -264,9 +280,15 @@
 				if (tmp->index == order && memclass(tmp->zone, classzone)) {
 					list_del(entry);
 					current->nr_local_pages--;
-					set_page_count(tmp, 1);
-					page = tmp;
 
+					i = 1UL << order;
+					page = tmp + i;
+					do {
+						page--;
+						SetPageInuse(page);
+					} while (--i);
+
+					set_page_count(page, 1);
 					if (page->buffers)
 						BUG();
 					if (page->mapping)

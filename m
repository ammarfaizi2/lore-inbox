Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSFIWgf>; Sun, 9 Jun 2002 18:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSFIWge>; Sun, 9 Jun 2002 18:36:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22280 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315279AbSFIWga>; Sun, 9 Jun 2002 18:36:30 -0400
Date: Sun, 9 Jun 2002 23:36:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Cc: "'davem@redhat.com'" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: sparc64 pgalloc.h pgd_quicklist question
Message-ID: <20020609233623.G8761@flint.arm.linux.org.uk>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A783A78A3@nocmail101.ma.tmpw.net> <20020607091826.A5413@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2002 at 09:18:26AM +0100, Russell King wrote:
> On Thu, Jun 06, 2002 at 09:10:40PM -0500, Holzrichter, Bruce wrote:
> > I meant to ask this a little bit back, while I was looking through this
> > code.  In the 2.5 iteration you have for small_page.c your using the
> > next_hash and pprev_hash entries, which no longer are available in the
> > struct page, as far as I have looked, unless your struct page is defined
> > elsewhere, other than linux/mm.h?  Just wondering, as I pull apart the mm
> > code in what time I have looking at this.
> 
> It looks like next_hash and pprev_hash migrated to list.  (I've not
> confirmed that it obeys exactly the same rules yet.)  The solution
> is probably to convert small-page.c to use the list stuff instead.
> 
> If you don't get there before me, I'll probably fix it up this weekend.

Here's a patch that should be applied on top of the existing small_page.c
I've not tested it past the "does it compile" stage, so beware.

(Since mach-arc stuff is falling into disrepair, this code will probably
get removed from Linus' tree soon.)

--- orig/arch/arm/mach-arc/small_page.c	Mon May 13 10:48:07 2002
+++ linux/arch/arm/mach-arc/small_page.c	Sun Jun  9 23:32:42 2002
@@ -50,7 +50,7 @@
  */
 
 struct order {
-	struct page *queue;
+	struct list_head queue;
 	unsigned int mask;		/* (1 << shift) - 1		*/
 	unsigned int shift;		/* (1 << shift) size of page	*/
 	unsigned int block_mask;	/* nr_blocks - 1		*/
@@ -60,10 +60,10 @@
 
 static struct order orders[] = {
 #if PAGE_SIZE == 4096
-	{ NULL, 2047, 11,  1, 0x00000003 }
+	{ LIST_HEAD_INIT(orders[0].queue), 2047, 11,  1, 0x00000003 }
 #elif PAGE_SIZE == 32768
-	{ NULL, 2047, 11, 15, 0x0000ffff },
-	{ NULL, 8191, 13,  3, 0x0000000f }
+	{ LIST_HEAD_INIT(orders[0].queue), 2047, 11, 15, 0x0000ffff },
+	{ LIST_HEAD_INIT(orders[1].queue), 8191, 13,  3, 0x0000000f }
 #else
 #error unsupported page size
 #endif
@@ -75,70 +75,49 @@
 
 static spinlock_t small_page_lock = SPIN_LOCK_UNLOCKED;
 
-static void add_page_to_queue(struct page *page, struct page **p)
-{
-#ifdef PEDANTIC
-	if (page->pprev_hash)
-		PAGE_BUG(page);
-#endif
-	page->next_hash = *p;
-	if (*p)
-		(*p)->pprev_hash = &page->next_hash;
-	*p = page;
-	page->pprev_hash = p;
-}
-
-static void remove_page_from_queue(struct page *page)
-{
-	if (page->pprev_hash) {
-		if (page->next_hash)
-			page->next_hash->pprev_hash = page->pprev_hash;
-		*page->pprev_hash = page->next_hash;
-		page->pprev_hash = NULL;
-	}
-}
-
 static unsigned long __get_small_page(int priority, struct order *order)
 {
 	unsigned long flags;
 	struct page *page;
 	int offset;
 
-	if (!order->queue)
-		goto need_new_page;
+	do {
+		spin_lock_irqsave(&small_page_lock, flags);
+
+		if (list_empty(&order->queue))
+			goto need_new_page;
 
-	spin_lock_irqsave(&small_page_lock, flags);
-	page = order->queue;
+		page = list_entry(order->queue.next, struct page, list);
 again:
 #ifdef PEDANTIC
-	if (USED_MAP(page) & ~order->all_used)
-		PAGE_BUG(page);
+		if (USED_MAP(page) & ~order->all_used)
+			PAGE_BUG(page);
 #endif
-	offset = ffz(USED_MAP(page));
-	SET_USED(page, offset);
-	if (USED_MAP(page) == order->all_used)
-		remove_page_from_queue(page);
-	spin_unlock_irqrestore(&small_page_lock, flags);
+		offset = ffz(USED_MAP(page));
+		SET_USED(page, offset);
+		if (USED_MAP(page) == order->all_used)
+			list_del_init(&page->list);
+		spin_unlock_irqrestore(&small_page_lock, flags);
 
-	return (unsigned long) page_address(page) + (offset << order->shift);
+		return (unsigned long) page_address(page) + (offset << order->shift);
 
 need_new_page:
-	page = alloc_page(priority);
+		spin_unlock_irqrestore(&small_page_lock, flags);
+		page = alloc_page(priority);
+		spin_lock_irqsave(&small_page_lock, flags);
+
+		if (list_empty(&order->queue)) {
+			if (!page)
+				goto no_page;
+			SetPageReserved(page);
+			USED_MAP(page) = 0;
+			list_add(&page->list, &order->queue);
+			goto again;
+		}
 
-	spin_lock_irqsave(&small_page_lock, flags);
-	if (!order->queue) {
-		if (!page)
-			goto no_page;
-		SetPageReserved(page);
-		USED_MAP(page) = 0;
-		cli();
-		add_page_to_queue(page, &order->queue);
-	} else {
+		spin_unlock_irqrestore(&small_page_lock, flags);
 		__free_page(page);
-		cli();
-		page = order->queue;
-	}
-	goto again;
+	} while (1);
 
 no_page:
 	spin_unlock_irqrestore(&small_page_lock, flags);
@@ -173,7 +152,7 @@
 		spin_lock_irqsave(&small_page_lock, flags);
 
 		if (USED_MAP(page) == order->all_used)
-			add_page_to_queue(page, &order->queue);
+			list_add(&page->list, &order->queue);
 
 		if (!TEST_AND_CLEAR_USED(page, spage))
 			goto already_free;
@@ -189,7 +168,7 @@
 	/*
 	 * unlink the page from the small page queue and free it
 	 */
-	remove_page_from_queue(page);
+	list_del_init(&page->list);
 	spin_unlock_irqrestore(&small_page_lock, flags);
 	ClearPageReserved(page);
 	__free_page(page);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


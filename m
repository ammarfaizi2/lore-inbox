Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264862AbUD2VOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbUD2VOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264861AbUD2VML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:12:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264862AbUD2VIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:08:45 -0400
Date: Thu, 29 Apr 2004 18:09:51 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Carson Gaspar <carson@taltos.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, akpm@osdl.org, andrea@suse.de, davem@redhat.com
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <20040429210951.GB20453@logos.cnet>
References: <382320000.1082759593@taltos.ny.ficc.gs.com> <16527.4259.174536.629347@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16527.4259.174536.629347@segfault.boston.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 10:02:11PM -0400, Jeff Moyer wrote:
> 
> >FYI, we see the exact same panic with the tg3 driver using 2.4.25 and 
> >distcc with sendfile(). The bcm5700 driver also panics, but I haven't 
> >captured a panic message to be certain it's the same bug.
> 
> >kernel BUG at page_alloc.c:98!
> 
> Andrea fixed this in his tree by deferring the page free to process context
> instead of BUG()ing on PageLRU(page).

Yeap, his fix looks OK.

Can you please people seeing the oops try this, from Andrea (on top of 2.4.26):

--- a/mm/page_alloc.c.orig	2004-04-29 17:38:14.184021976 -0300
+++ b/mm/page_alloc.c	2004-04-29 17:47:27.906843312 -0300
@@ -46,6 +46,34 @@
 
 int vm_gfp_debug = 0;
 
+static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
+
+static spinlock_t free_pages_ok_no_irq_lock = SPIN_LOCK_UNLOCKED;
+struct page * free_pages_ok_no_irq_head;
+
+static void do_free_pages_ok_no_irq(void * arg)
+{
+       struct page * page, * __page;
+
+       spin_lock_irq(&free_pages_ok_no_irq_lock);
+
+       page = free_pages_ok_no_irq_head;
+       free_pages_ok_no_irq_head = NULL;
+
+       spin_unlock_irq(&free_pages_ok_no_irq_lock);
+
+       while (page) {
+               __page = page;
+               page = page->next_hash;
+               __free_pages_ok(__page, __page->index);
+       }
+}
+
+static struct tq_struct free_pages_ok_no_irq_task = {
+       .routine        = do_free_pages_ok_no_irq,
+};
+
+
 /*
  * Temporary debugging check.
  */
@@ -81,7 +109,6 @@
  * -- wli
  */
 
-static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
 static void __free_pages_ok (struct page *page, unsigned int order)
 {
 	unsigned long index, page_idx, mask, flags;
@@ -94,8 +121,20 @@
 	 * a reference to a page in order to pin it for io. -ben
 	 */
 	if (PageLRU(page)) {
-		if (unlikely(in_interrupt()))
-			BUG();
+		if (unlikely(in_interrupt())) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&free_pages_ok_no_irq_lock, flags);
+			page->next_hash = free_pages_ok_no_irq_head;
+			free_pages_ok_no_irq_head = page;
+			page->index = order;
+	
+			spin_unlock_irqrestore(&free_pages_ok_no_irq_lock, flags);
+	
+			schedule_task(&free_pages_ok_no_irq_task);
+			return;
+		}
+		
 		lru_cache_del(page);
 	}
 

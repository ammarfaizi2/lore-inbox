Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422741AbWBINt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbWBINt1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 08:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422758AbWBINt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 08:49:27 -0500
Received: from mail.gmx.de ([213.165.64.21]:48029 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422741AbWBINt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 08:49:26 -0500
X-Authenticated: #14349625
Subject: Re: [k2.6.16-rc1-mm5] kernel BUG at include/linux/mm.h:302!
From: MIke Galbraith <efault@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43EB393F.1070409@yahoo.com.au>
References: <1139473463.8028.13.camel@homer>	<43EAFF6D.1040604@yahoo.com.au>
	 <20060209004712.3998e336.akpm@osdl.org>	<1139478652.7867.9.camel@homer>
	 <20060209021136.410f1128.akpm@osdl.org>  <43EB393F.1070409@yahoo.com.au>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 14:53:07 +0100
Message-Id: <1139493187.7618.4.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 23:44 +1100, Nick Piggin wrote:
> Andrew Morton wrote:

> >> (or Nick, do you have the supposed fix handy?)
> > 
> > 
> > Yeah, I'm still scratching my head over the mystery fix.
> > 
> > 
> 
> The mm/swap.c hunk from git 8519fb30e438f8088b71a94a7d5a660a814d3872
> is the mystery fix (the mm.h hunk is already in there).
> 
> I suppose you'd better verify that -mm works fine with the patch as
> well, when you get time.

Verified.  rc2-mm1 worked fine, and plugging the extracted bit below
into rc1-mm5 fixed it's BUG.

	Thanks,

	-Mike

--- linux-2.6.16-rc1-mm5/mm/swap.c	2006-02-09 05:38:11.000000000 +0100
+++ linux-2.6.16-rc2-mm1/mm/swap.c	2006-02-09 13:04:04.000000000 +0100
@@ -34,19 +34,22 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
-void put_page(struct page *page)
+static void put_compound_page(struct page *page)
 {
-	if (unlikely(PageCompound(page))) {
-		page = (struct page *)page_private(page);
-		if (put_page_testzero(page)) {
-			void (*dtor)(struct page *page);
+	page = (struct page *)page_private(page);
+	if (put_page_testzero(page)) {
+		void (*dtor)(struct page *page);
 
-			dtor = (void (*)(struct page *))page[1].mapping;
-			(*dtor)(page);
-		}
-		return;
+		dtor = (void (*)(struct page *))page[1].mapping;
+		(*dtor)(page);
 	}
-	if (put_page_testzero(page))
+}
+
+void put_page(struct page *page)
+{
+	if (unlikely(PageCompound(page)))
+		put_compound_page(page);
+	else if (put_page_testzero(page))
 		__page_cache_release(page);
 }
 EXPORT_SYMBOL(put_page);
@@ -242,6 +245,15 @@
 	for (i = 0; i < nr; i++) {
 		struct page *page = pages[i];
 
+		if (unlikely(PageCompound(page))) {
+			if (zone) {
+				spin_unlock_irq(&zone->lru_lock);
+				zone = NULL;
+			}
+			put_compound_page(page);
+			continue;
+		}
+
 		if (!put_page_testzero(page))
 			continue;
 
@@ -265,7 +277,7 @@
 			}
 			__pagevec_free(&pages_to_free);
 			pagevec_reinit(&pages_to_free);
-		}
+  		}
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);



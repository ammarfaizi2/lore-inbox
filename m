Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUDPTzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUDPTzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:55:04 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:32266 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263040AbUDPTy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:54:57 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] deinline put_page if CONFIG_HUGETLB_PAGE=y
Date: Fri, 16 Apr 2004 22:54:46 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>
References: <200404162230.40530.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404162230.40530.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GoDgAjxU1Nzisr0"
Message-Id: <200404162254.46533.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_GoDgAjxU1Nzisr0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 16 April 2004 22:30, Denis Vlasenko wrote:
> This is next version of 'inline hunter', a tool designed to find
> inlines which are large. It has bug fixes and improvements suggested
> by readers of lkml. Tarball and results are below sig.
>
> Matt, you may simply replace earlier version with this one.
> --
> vda
>
> Size  Uses Wasted Name and definition
> ===== ==== ====== ================================================
>    56  461  16560 copy_from_user	include/asm/uaccess.h
>   122  119  12036 skb_dequeue	include/linux/skbuff.h
>   164   78  11088 skb_queue_purge	include/linux/skbuff.h
>    97  141  10780 netif_wake_queue	include/linux/netdevice.h
>    43  468  10741 copy_to_user	include/asm/uaccess.h
>    43  461  10580 copy_from_user	include/asm/uaccess.h
>   145   77   9500 put_page	include/linux/mm.h

This patch deinlines put_page if CONFIG_HUGETLB_PAGE=y.
--
vda

--Boundary-00=_GoDgAjxU1Nzisr0
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.6.5.mm_inline1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.5.mm_inline1.patch"

diff -urN linux-2.6.5.orig/include/linux/mm.h linux-2.6.5.mm_inline1/include/linux/mm.h
--- linux-2.6.5.orig/include/linux/mm.h	Sun Apr  4 06:36:15 2004
+++ linux-2.6.5.mm_inline1/include/linux/mm.h	Fri Apr 16 22:49:18 2004
@@ -253,22 +253,7 @@
 	atomic_inc(&page->count);
 }
 
-static inline void put_page(struct page *page)
-{
-	if (PageCompound(page)) {
-		page = (struct page *)page->lru.next;
-		if (put_page_testzero(page)) {
-			if (page->lru.prev) {	/* destructor? */
-				(*(void (*)(struct page *))page->lru.prev)(page);
-			} else {
-				__page_cache_release(page);
-			}
-		}
-		return;
-	}
-	if (!PageReserved(page) && put_page_testzero(page))
-		__page_cache_release(page);
-}
+void put_page(struct page *page);
 
 #else		/* CONFIG_HUGETLB_PAGE */
 
diff -urN linux-2.6.5.orig/mm/page_alloc.c linux-2.6.5.mm_inline1/mm/page_alloc.c
--- linux-2.6.5.orig/mm/page_alloc.c	Sun Apr  4 06:36:17 2004
+++ linux-2.6.5.mm_inline1/mm/page_alloc.c	Fri Apr 16 22:49:51 2004
@@ -109,6 +109,24 @@
  * This is only for debug at present.  This usage means that zero-order pages
  * may not be compound.
  */
+
+void put_page(struct page *page)
+{
+	if (PageCompound(page)) {
+		page = (struct page *)page->lru.next;
+		if (put_page_testzero(page)) {
+			if (page->lru.prev) {	/* destructor? */
+				(*(void (*)(struct page *))page->lru.prev)(page);
+			} else {
+				__page_cache_release(page);
+			}
+		}
+		return;
+	}
+	if (!PageReserved(page) && put_page_testzero(page))
+		__page_cache_release(page);
+}
+
 static void prep_compound_page(struct page *page, unsigned long order)
 {
 	int i;

--Boundary-00=_GoDgAjxU1Nzisr0--


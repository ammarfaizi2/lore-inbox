Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272723AbRIPTwQ>; Sun, 16 Sep 2001 15:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272730AbRIPTwG>; Sun, 16 Sep 2001 15:52:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59663 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272723AbRIPTv5>;
	Sun, 16 Sep 2001 15:51:57 -0400
Date: Sun, 16 Sep 2001 16:52:02 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <200109161919.f8GJJwA25036@smtp-server3.tampabay.rr.com>
Message-ID: <Pine.LNX.4.33L.0109161636310.21279-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Phillip Susi wrote:

> Maybe I'm missing something here, but it seems to me that these
> problems are due to the cache putting pressure on VM, so process pages
> get swapped out.  The obvious solution to this is to limit the size of
> the cache, or implement some sort of algorithm to slow its growth and
> reduce the pressure on VM.

> Am I way off base here?

You're absolutely right and it's only a tiny patch to
implement this thing.  I've attached a completely
untested (I haven't even compiled this thing) patch
which implements this thing. I suspect it'll apply to
any recent -ac kernel, porting it to -linus should be
easy.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)



--- mm/vmscan.c.orig	Sun Sep 16 16:44:14 2001
+++ mm/vmscan.c	Sun Sep 16 16:49:09 2001
@@ -731,6 +731,8 @@
  */
 #define too_many_buffers (atomic_read(&buffermem_pages) > \
 		(num_physpages * buffer_mem.borrow_percent / 100))
+#define too_much_cache (page_cache_size - swapper_space.nrpages) > \
+		(num_physpages * page_cache.borrow_percent / 100))
 int refill_inactive_scan(unsigned int priority)
 {
 	struct list_head * page_lru;
@@ -793,6 +795,18 @@
 		 * be reclaimed there...
 		 */
 		if (page->buffers && !page->mapping && too_many_buffers) {
+			deactivate_page_nolock(page);
+			page_active = 0;
+		}
+
+		/*
+		 * If the page cache is too large, move the page
+		 * to the inactive list. If it is really accessed
+		 * it'll be referenced before it reaches the point
+		 * where we'll reclaim it.
+		 */
+		if (page->mapping && too_much_cache && page_count(page) <=
+					(page->buffers ? 2 : 1)) {
 			deactivate_page_nolock(page);
 			page_active = 0;
 		}
--- mm/swap.c.orig	Sun Sep 16 16:50:43 2001
+++ mm/swap.c	Sun Sep 16 16:50:58 2001
@@ -64,7 +64,7 @@

 buffer_mem_t page_cache = {
 	2,	/* minimum percent page cache */
-	15,	/* borrow percent page cache */
+	60,	/* borrow percent page cache */
 	75	/* maximum */
 };



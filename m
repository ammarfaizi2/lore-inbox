Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272736AbRIPTyg>; Sun, 16 Sep 2001 15:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272732AbRIPTy1>; Sun, 16 Sep 2001 15:54:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:16 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272730AbRIPTyQ>;
	Sun, 16 Sep 2001 15:54:16 -0400
Date: Sun, 16 Sep 2001 16:54:28 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Jeremy Zawodny <Jeremy@Zawodny.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH]  Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010916123309.A15108@peach.zawodny.com>
Message-ID: <Pine.LNX.4.33L.0109161652480.21279-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Jeremy Zawodny wrote:
> On Sun, Sep 16, 2001 at 03:19:29PM +0000, Phillip Susi wrote:
>
> > Maybe I'm missing something here, but it seems to me that these
> > problems are due to the cache putting pressure on VM, so process
> > pages get swapped out.
>
> That's what it felt like in the cases that I ran into it.  It was
> trying to treat all memory equally, when it probably shouldn't have.

Indeed, it should treat all memory equally, except when we
really have far too much cache.  I'll resend the patch with
the subject clearly marked since this trivial thing really
does need testers ;)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/


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



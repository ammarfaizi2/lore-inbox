Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267670AbRHIU5D>; Thu, 9 Aug 2001 16:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266827AbRHIU4y>; Thu, 9 Aug 2001 16:56:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270597AbRHIU4t>; Thu, 9 Aug 2001 16:56:49 -0400
Date: Thu, 9 Aug 2001 17:55:59 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: marc heckmann <heckmann@hbesoftware.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: 2.4.8-pre7: still buffer cache problems
In-Reply-To: <32774.213.7.60.90.997365391.squirrel@webmail.hbesoftware.com>
Message-ID: <Pine.LNX.4.33L.0108091749580.1439-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, marc heckmann wrote:

> While 2.4.8-pre7 definitely fixes the "dd if=/dev/zero
> of=bigfile bs=1000k count=bignumber" case. The "dd if=/dev/hda
> of=/dev/null" is still quite broken for me.

OK, there is no obvious way to do do drop-behind on
buffer cache pages, but I think we can use a quick
hack to make the system behave well under the presence
of large amounts of buffer cache pages.

What we could do is, in refill_inactive_scan(), just
moving buffer cache pages to the inactive list regardless
of page aging when there are too many buffercache pages
around in the system.

Does the patch below help you ?

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


--- linux-2.4.7-ac7/mm/vmscan.c.buffer	Thu Aug  9 17:54:24 2001
+++ linux-2.4.7-ac7/mm/vmscan.c	Thu Aug  9 17:55:09 2001
@@ -708,6 +708,8 @@
  * This function will scan a portion of the active list to find
  * unused pages, those pages will then be moved to the inactive list.
  */
+#define too_many_buffers (atomic_read(&buffermem_pages) > \
+		(num_physpages * buffer_mem.borrow_percent / 100))
 int refill_inactive_scan(zone_t *zone, unsigned int priority, int target)
 {
 	struct list_head * page_lru;
@@ -770,6 +772,18 @@
 				page_active = 1;
 			}
 		}
+
+		/*
+		 * If the amount of buffer cache pages is too
+		 * high we just move every buffer cache page we
+		 * find to the inactive list. Eventually they'll
+		 * be reclaimed there...
+		 */
+		if (page->buffers && !page->mapping && too_many_buffers) {
+			deactivate_page_nolock(page);
+			page_active = 0;
+		}
+
 		/*
 		 * If the page is still on the active list, move it
 		 * to the other end of the list. Otherwise we exit if


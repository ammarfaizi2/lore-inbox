Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272758AbRITF6T>; Thu, 20 Sep 2001 01:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274316AbRITF6J>; Thu, 20 Sep 2001 01:58:09 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:18963 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272758AbRITF5x>; Thu, 20 Sep 2001 01:57:53 -0400
Message-ID: <3BA98577.3F0A3D5A@zip.com.au>
Date: Wed, 19 Sep 2001 22:58:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: 2.4.10pre11 vm rewrite fixes for mainline inclusion and testing
In-Reply-To: <20010918224317.E720@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With this patch against -pre12 the BUG()s in shrink_cache()
go away.

--- linux-2.4.10-pre12/mm/vmscan.c	Wed Sep 19 20:47:21 2001
+++ linux-akpm/mm/vmscan.c	Wed Sep 19 22:49:48 2001
@@ -435,15 +435,20 @@ static int shrink_cache(struct list_head
 
 			if (try_to_free_buffers(page, gfp_mask)) {
 				if (!page->mapping) {
-					UnlockPage(page);
-
 					/*
 					 * Account we successfully freed a page
 					 * of buffer cache.
 					 */
 					atomic_dec(&buffermem_pages);
 
+					/*
+					 * We must not allow an anon page
+					 * with no buffers to be visible on
+					 * the LRU, so we unlock the page after
+					 * taking the lru lock
+					 */
 					spin_lock(&pagemap_lru_lock);
+					UnlockPage(page);
 					__lru_cache_del(page);
 
 					/* effectively free the page here */


With this patch applied I've had three total system lockups with
the usual workload.  No diagnostics, no interrupts, NMI watchdog
doesn't catch it.  Nice.   This is not related to networking; I
wasn't able to do much network stress testing because the
darn APIC bug kept biting me.  Grumble.

I'll try -pre9.

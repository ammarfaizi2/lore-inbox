Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbRACPen>; Wed, 3 Jan 2001 10:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbRACPed>; Wed, 3 Jan 2001 10:34:33 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:19951 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132369AbRACPeX>; Wed, 3 Jan 2001 10:34:23 -0500
Date: Wed, 3 Jan 2001 13:03:27 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] add PF_MEMALLOC to __alloc_pages()
Message-ID: <Pine.LNX.4.21.0101031258070.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Alan, Mike,

the following patch sets PF_MEMALLOC for the current task
in __alloc_pages() to avoid infinite recursion when we try
to free memory from __alloc_pages().

Please apply the patch below, which fixes this (embarrasing)
bug...

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/



--- linux-2.4.0-prerelease/mm/page_alloc.c.orig	Wed Jan  3 12:52:13 2001
+++ linux-2.4.0-prerelease/mm/page_alloc.c	Wed Jan  3 13:01:19 2001
@@ -427,7 +427,9 @@
 		if (order > 0 && (gfp_mask & __GFP_WAIT)) {
 			zone = zonelist->zones;
 			/* First, clean some dirty pages. */
+			current->flags |= PF_MEMALLOC;
 			page_launder(gfp_mask, 1);
+			current->flags &= ~PF_MEMALLOC;
 			for (;;) {
 				zone_t *z = *(zone++);
 				if (!z)
@@ -475,7 +477,9 @@
 		 * free ourselves...
 		 */
 		} else if (gfp_mask & __GFP_WAIT) {
+			current->flags |= PF_MEMALLOC;
 			try_to_free_pages(gfp_mask);
+			current->flags &= ~PF_MEMALLOC;
 			memory_pressure++;
 			if (!order)
 				goto try_again;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

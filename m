Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbRFUEB7>; Thu, 21 Jun 2001 00:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264805AbRFUEBt>; Thu, 21 Jun 2001 00:01:49 -0400
Received: from zeus.kernel.org ([209.10.41.242]:60375 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264739AbRFUEBe>;
	Thu, 21 Jun 2001 00:01:34 -0400
Date: Wed, 20 Jun 2001 23:13:46 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: [PATCH] Avoid !__GFP_IO allocations to eat from memory reservations
Message-ID: <Pine.LNX.4.21.0106202310430.13933-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

I just read pre3<->pre4 diff and it seems you missed this patch... here it
goes again.

In pre3/4, GFP_BUFFER allocations can eat from the "emergency" memory
reservations in case try_to_free_pages() fails for those allocations in
__alloc_pages().


Here goes the (tested) patch to fix that:


--- linux/mm/page_alloc.c.orig	Thu Jun 14 11:00:14 2001
+++ linux/mm/page_alloc.c	Thu Jun 14 11:32:56 2001
@@ -453,6 +453,12 @@
 				int progress = try_to_free_pages(gfp_mask);
 				if (progress || gfp_mask & __GFP_IO)
 					goto try_again;
+				/*
+				 * Fail in case no progress was made and the
+				 * allocation may not be able to block on IO.
+				 */
+				else
+					return NULL;
 			}
 		}
 	}



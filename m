Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263016AbRFNOex>; Thu, 14 Jun 2001 10:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263031AbRFNOen>; Thu, 14 Jun 2001 10:34:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4369 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263016AbRFNOed>; Thu, 14 Jun 2001 10:34:33 -0400
Date: Thu, 14 Jun 2001 09:59:43 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Avoid !__GFP_IO allocations to eat from memory reservations
Message-Id: <20010614143441Z263016-17720+3764@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
Message-ID: <Pine.LNX.4.21.0106140949550.8439-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII


Linus, 

In pre3, GFP_BUFFER allocations can eat from the "emergency" memory
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269889AbRHGAt3>; Mon, 6 Aug 2001 20:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269701AbRHGAtU>; Mon, 6 Aug 2001 20:49:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15625 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269836AbRHGAtI>; Mon, 6 Aug 2001 20:49:08 -0400
Date: Mon, 6 Aug 2001 20:19:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: [PATCH] total_free_shortage() using zone_free_shortage()
Message-ID: <Pine.LNX.4.21.0108062015430.11216-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, 

The following patch changes total_free_shortage() to use
zone_free_shortage() to calculate the sum of perzone free shortages.

This way we isolate the calculation variables in zone_free_shortage(). 

Against 2.4.8-pre4. Please apply. 


diff -Nur linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Mon Aug  6 21:29:11 2001
+++ linux/mm/vmscan.c	Mon Aug  6 21:37:53 2001
@@ -807,12 +807,8 @@
 		int i;
 		for(i = 0; i < MAX_NR_ZONES; i++) {
 			zone_t *zone = pgdat->node_zones+ i;
-			if (zone->size && (zone->inactive_clean_pages +
-					zone->free_pages < zone->pages_min)) {
-				sum += zone->pages_min;
-				sum -= zone->free_pages;
-				sum -= zone->inactive_clean_pages;
-			}
+
+			sum += zone_free_shortage(zone);
 		}
 		pgdat = pgdat->node_next;
 	} while (pgdat);



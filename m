Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277893AbRJRSZb>; Thu, 18 Oct 2001 14:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277905AbRJRSZV>; Thu, 18 Oct 2001 14:25:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:44296 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277893AbRJRSZP>; Thu, 18 Oct 2001 14:25:15 -0400
Date: Thu, 18 Oct 2001 15:04:15 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fork() failing
Message-ID: <Pine.LNX.4.21.0110181503220.12276-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

As you know, we currently allow 1-order allocations to fail easily. 

However, there is one special case of 1-order allocations which cannot
fail: fork.

Here is the tested patch against pre4.

--- linux.orig/mm/page_alloc.c	Thu Oct 18 14:26:28 2001
+++ linux/mm/page_alloc.c	Thu Oct 18 16:23:15 2001
@@ -393,8 +393,13 @@
 		}
 	}
 
-	/* Don't let big-order allocations loop */
-	if (order)
+	/* We have one special 1-order alloc user: fork().
+	 * It obviously cannot fail easily like other 
+	 * high order allocations. This could also be fixed
+	 * by having a __GFP_LOOP flag to indicate that the 
+	 * high order allocation is "critical". 
+	 */
+	if (order > 1)
 		return NULL;
 
 	/* Yield for kswapd, and try again */


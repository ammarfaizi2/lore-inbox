Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262240AbRENDnt>; Sun, 13 May 2001 23:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbRENDnk>; Sun, 13 May 2001 23:43:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54278 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262240AbRENDne>;
	Sun, 13 May 2001 23:43:34 -0400
Date: Mon, 14 May 2001 00:43:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] balance_dirty_state() fix
Message-ID: <Pine.LNX.4.21.0105140039300.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following patch fixes a problem where bdflush eats too
much cpu time without getting work done; the problem is that
calls to page_launder() don't achieve anything in the short
term and may not even achieve anything long-term because we
may just be short on inactive pages.

In both of these cases it's better to just let bdflush stop
eating CPU and have the system do something useful instead.
Please apply.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


--- linux-2.4.4/fs/buffer.c.orig	Mon May 14 00:36:15 2001
+++ linux-2.4.4/fs/buffer.c	Mon May 14 00:36:28 2001
@@ -1034,7 +1034,6 @@
 int balance_dirty_state(kdev_t dev)
 {
 	unsigned long dirty, tot, hard_dirty_limit, soft_dirty_limit;
-	int shortage;
 
 	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
 	tot = nr_free_buffer_pages();
@@ -1049,16 +1048,6 @@
 			return 1;
 		return 0;
 	}
-
-	/*
-	 * If we are about to get low on free pages and
-	 * cleaning the inactive_dirty pages would help
-	 * fix this, wake up bdflush.
-	 */
-	shortage = free_shortage();
-	if (shortage && nr_inactive_dirty_pages > shortage &&
-			nr_inactive_dirty_pages > freepages.high)
-		return 0;
 
 	return -1;
 }


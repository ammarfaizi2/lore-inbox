Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262319AbRENJzJ>; Mon, 14 May 2001 05:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262323AbRENJy7>; Mon, 14 May 2001 05:54:59 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:21776 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262319AbRENJyt>; Mon, 14 May 2001 05:54:49 -0400
Date: Mon, 14 May 2001 11:53:49 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Another VM race? (was: page_launder() bug)
In-Reply-To: <Pine.LNX.4.21.0105132003580.5468-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.3.96.1010514114823.17128A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > CPU 0				CPU 1
> > is executing the code marked	is executing try_to_free_buffers on
> > above with ^^^^^^^:		the same page (it can be, because CPU 0
> > 				did not lock the page)
> > 
> > (page->buffers &&
> > 
> > 				page->buffers = NULL
> > 
> > MAJOR(page->buffers->b_dev) == 
> > 	RAMDISK_MAJOR)) ===> Oops, NULL pointer dereference!
> > 
> > 
> > 
> > Maybe compiler CSE optimization will eliminate the double load of
> > page->buffers, but we must not rely on it. If the compiler doesn't
> > optimize it, it can produce random oopses.
> 
> You're right, this should be fixed. Do you happen to have a
> patch ? ;)

You can apply this one.

Mikulas

--- linux/mm/vmscan.c_	Mon May 14 11:41:42 2001
+++ linux/mm/vmscan.c	Mon May 14 11:44:54 2001
@@ -454,8 +454,7 @@
 
 		/* Page is or was in use?  Move it to the active list. */
 		if (PageTestandClearReferenced(page) || page->age > 0 ||
-				(!page->buffers && page_count(page) > 1) ||
-				page_ramdisk(page)) {
+				(!page->buffers && page_count(page) > 1)) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
 			continue;
@@ -470,6 +469,9 @@
 			list_add(page_lru, &inactive_dirty_list);
 			continue;
 		}
+
+		/* M.P.: We must not call page_ramdisk for unlocked page */
+		if (page_ramdisk(page)) goto page_active;
 
 		/*
 		 * Dirty swap-cache page? Write it out if



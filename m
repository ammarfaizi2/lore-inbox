Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132896AbRANN2z>; Sun, 14 Jan 2001 08:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132857AbRANN2p>; Sun, 14 Jan 2001 08:28:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1692 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132816AbRANN2d>;
	Sun, 14 Jan 2001 08:28:33 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.43345.483744.954137@pizda.ninka.net>
Date: Sun, 14 Jan 2001 05:27:45 -0800 (PST)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: set_page_dirty/page_launder deadlock
In-Reply-To: <Pine.LNX.4.21.0101140108430.11917-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0101140108430.11917-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti writes:
 > 
 > While taking a look at page_launder()...

 ...

 > set_page_dirty() may lock the pagecache_lock which means potential
 > deadlock since we have the pagemap_lru_lock locked.

Indeed, the following should work as a fix:

--- mm/vmscan.c.~1~	Thu Jan 11 02:22:19 2001
+++ mm/vmscan.c	Sun Jan 14 05:26:17 2001
@@ -493,12 +493,15 @@
 			page_cache_release(page);
 
 			/* And re-start the thing.. */
-			spin_lock(&pagemap_lru_lock);
-			if (result != 1)
+			if (result != 1) {
+				spin_lock(&pagemap_lru_lock);
 				continue;
-			/* writepage refused to do anything */
-			set_page_dirty(page);
-			goto page_active;
+			} else {
+				/* writepage refused to do anything */
+				set_page_dirty(page);
+				spin_lock(&pagemap_lru_lock);
+				goto page_active;
+			}
 		}
 
 		/*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRADGRR>; Thu, 4 Jan 2001 01:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRADGRH>; Thu, 4 Jan 2001 01:17:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:43781 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129348AbRADGQy>; Thu, 4 Jan 2001 01:16:54 -0500
Date: Thu, 4 Jan 2001 02:25:19 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: __get_swap_page() minor problem 
Message-ID: <Pine.LNX.4.21.0101040220180.1158-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

If the check for "count >= SWAP_MAP_MAX" in __get_swap_page is true, we
will end up trying to unlock a not-yet-locked spinlock.

Here goes a patch to change this.

--- linux/mm/swapfile.c.orig	Thu Jan  4 04:10:08 2001
+++ linux/mm/swapfile.c	Thu Jan  4 04:10:12 2001
@@ -90,8 +90,12 @@
 	int type, wrapped = 0;
 
 	entry.val = 0;	/* Out of memory */
-	if (count >= SWAP_MAP_MAX)
-		goto bad_count;
+	if (count >= SWAP_MAP_MAX) {
+		printk(KERN_ERR "get_swap_page: bad count %hd from %p\n",
+	       		count, __builtin_return_address(0));
+		return entry;
+	}
+
 	swap_list_lock();
 	type = swap_list.next;
 	if (type < 0)
@@ -130,11 +134,6 @@
 out:
 	swap_list_unlock();
 	return entry;
-
-bad_count:
-	printk(KERN_ERR "get_swap_page: bad count %hd from %p\n",
-	       count, __builtin_return_address(0));
-	goto out;
 }
 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313512AbSEEUv3>; Sun, 5 May 2002 16:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313529AbSEEUv1>; Sun, 5 May 2002 16:51:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39689 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313512AbSEEUvX>;
	Sun, 5 May 2002 16:51:23 -0400
Message-ID: <3CD59BD5.964D8BE4@zip.com.au>
Date: Sun, 05 May 2002 13:53:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/10] radix-tree locking fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



__delete_from_swap_cache modifies the radix tree.  We need to take the
lock for writing.


=====================================

--- 2.5.13/mm/swapfile.c~swap-lock-fix	Sun May  5 13:31:59 2002
+++ 2.5.13-akpm/mm/swapfile.c	Sun May  5 13:31:59 2002
@@ -308,13 +308,13 @@ int remove_exclusive_swap_page(struct pa
 	retval = 0;
 	if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
-		read_lock(&swapper_space.page_lock);
+		write_lock(&swapper_space.page_lock);
 		if (page_count(page) - !!PagePrivate(page) == 2) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
 		}
-		read_unlock(&swapper_space.page_lock);
+		write_unlock(&swapper_space.page_lock);
 	}
 	swap_info_put(p);
 


-

Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155478AbPFWO0W>; Wed, 23 Jun 1999 10:26:22 -0400
Received: by vger.rutgers.edu id <S155098AbPFWO0L>; Wed, 23 Jun 1999 10:26:11 -0400
Received: from lightning.swansea.uk.linux.org ([194.168.151.1]:15460 "EHLO the-village.bc.nu") by vger.rutgers.edu with ESMTP id <S155469AbPFWOXA>; Wed, 23 Jun 1999 10:23:00 -0400
Subject: File Corruption Bug.. continued
To: linux-kernel@vger.rutgers.edu
Date: Wed, 23 Jun 1999 15:21:44 +0100 (BST)
Content-Type: text
Message-Id: <E10wnuM-00000M-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

I've now been through most of the 2.2.7->2.2.9 diff set discarding stuff
that seems not to be a viable candiate.

The remaining suspects are:
	o	Quota - which has big 2.2.7->2.2.9 changes.
	o	The small scsi changes (dubious)
	o	A small mm change

There are other candiates - notably
	TCP changes
	interrupt changes
	IRDA
	NFS

The tcp changes ought to have shown up more than this does. The interrupt
changes dont really seem to explain cross platform stuff. And I doubt most
people running these tests were running irda. NFS is a possibility.

So - are most people seeing the problems running quotas ? And would someone
with their brain firmly wrapped around the page cache/vfs verify this change
that was made is absolutely safe

diff -u --new-file --recursive --exclude-from ../../exclude linux.2.2.7/mm/page_alloc.c linux.2.2.9/mm/page_alloc.c
--- linux.2.2.7/mm/page_alloc.c	Wed Jun 23 17:48:03 1999
+++ linux.2.2.9/mm/page_alloc.c	Wed Jun 23 17:43:53 1999
@@ -419,12 +419,12 @@
 		return;
 	}
 
-	/* The page is unshared, and we want write access.  In this
-	   case, it is safe to tear down the swap cache and give the
-	   page over entirely to this process. */
-
-	if (PageSwapCache(page_map))
-		delete_from_swap_cache(page_map);
+	/*
+	 * The page is unshared and we're going to dirty it - so tear
+	 * down the swap cache and give exclusive access to the page to
+	 * this process.
+	 */
+	delete_from_swap_cache(page_map);
 	set_pte(page_table, pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot))));
   	return;
 }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

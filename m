Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318921AbSG1HaD>; Sun, 28 Jul 2002 03:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318920AbSG1HWe>; Sun, 28 Jul 2002 03:22:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55813 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318921AbSG1HVL>;
	Sun, 28 Jul 2002 03:21:11 -0400
Message-ID: <3D439E29.DF391375@zip.com.au>
Date: Sun, 28 Jul 2002 00:32:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 6/13] optimise struct page layout
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Reorganise the members of struct page.

- Place ->flags at the start so the compiler can generate indirect
  addressing rather than indirect+indexed for this commonly-accessed
  field.  Shrinks the kernel by ~100 bytes.

- Keep ->count with ->flags so they have the best chance of
  being in the same cacheline.




 mm.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- 2.5.29/include/linux/mm.h~page-reorg	Sat Jul 27 23:39:05 2002
+++ 2.5.29-akpm/include/linux/mm.h	Sat Jul 27 23:49:00 2002
@@ -149,12 +149,12 @@ struct pte_chain;
  * TODO: make this structure smaller, it could be as small as 32 bytes.
  */
 struct page {
+	unsigned long flags;		/* atomic flags, some possibly
+					   updated asynchronously */
+	atomic_t count;			/* Usage count, see below. */
 	struct list_head list;		/* ->mapping has some page lists. */
 	struct address_space *mapping;	/* The inode (or ...) we belong to. */
 	unsigned long index;		/* Our offset within mapping. */
-	atomic_t count;			/* Usage count, see below. */
-	unsigned long flags;		/* atomic flags, some possibly
-					   updated asynchronously */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by pagemap_lru_lock !! */
 	union {

.

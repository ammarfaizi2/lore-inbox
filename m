Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317604AbSFIOES>; Sun, 9 Jun 2002 10:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317607AbSFIOES>; Sun, 9 Jun 2002 10:04:18 -0400
Received: from p50887457.dip.t-dialin.net ([80.136.116.87]:64460 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317604AbSFIOER>; Sun, 9 Jun 2002 10:04:17 -0400
Date: Sun, 9 Jun 2002 08:04:05 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Adrian Sun <asun@cobaltnet.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Subject: [PATCH][2.5] introduce new list macros for hfs (5 occ)
Message-ID: <Pine.LNX.4.44.0206090802080.25737-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This uses the list_move* and list_del_init macros for hfs

--- linus-2.5/fs/hfs/catalog.c	Sun Jun  9 04:16:00 2002
+++ thunder-2.5/fs/hfs/catalog.c	Sun Jun  9 06:32:40 2002
@@ -158,8 +158,7 @@
 
 static inline void remove_hash(struct hfs_cat_entry *entry)
 {
-	list_del(&entry->hash);
-	INIT_LIST_HEAD(&entry->hash);
+	list_del_init(&entry->hash);
 }
 
 /*
@@ -210,10 +209,8 @@
 	        entry->state |= HFS_DIRTY;
 
 		/* Only add valid (ie hashed) entries to the dirty list. */
-		if (!list_empty(&entry->hash)) {
-		        list_del(&entry->list);
-			list_add(&entry->list, &mdb->entry_dirty);
-		}
+		if (!list_empty(&entry->hash))
+			list_move(&entry->list, &mdb->entry_dirty);
 	}
 	spin_unlock(&entry_lock);
 }
@@ -223,8 +220,7 @@
 {
         if (!(entry->state & HFS_DELETED)) {
 	        entry->state |= HFS_DELETED;
-		list_del(&entry->hash);
-		INIT_LIST_HEAD(&entry->hash);
+		list_del_init(&entry->hash);
 
 	        if (entry->type == HFS_CDR_FIL) {
 		  /* free all extents */
@@ -882,8 +878,7 @@
 		}
 
 		if (!entry->count) {
-		        list_del(&entry->hash);
-			INIT_LIST_HEAD(&entry->hash);
+		        list_del_init(&entry->hash);
 			list_del(&entry->list);
 			list_add(&entry->list, dispose);
 			continue;
@@ -961,8 +956,7 @@
 			        insert = entry_in_use.prev;
 
 		       /* add to in_use list */
-		       list_del(&entry->list);
-		       list_add(&entry->list, insert);
+		       list_move(&entry->list, insert);
 
 		       /* reset DIRTY, set LOCK */
 		       entry->state ^= HFS_DIRTY | HFS_LOCK;

-- 
Lightweight patch manager using pine. If you have any objections, tell me.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbRABCKO>; Mon, 1 Jan 2001 21:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129597AbRABCKE>; Mon, 1 Jan 2001 21:10:04 -0500
Received: from moot.mb.ca ([64.4.83.10]:39436 "EHLO moot.cdir.mb.ca")
	by vger.kernel.org with ESMTP id <S129477AbRABCJu>;
	Mon, 1 Jan 2001 21:09:50 -0500
Date: Mon, 1 Jan 2001 20:38:26 -0600 (CST)
From: Manmower <manmower@moot.ca>
To: chaffee@cs.berkeley.edu
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fat_cache is not SMP safe (2.4.0-prerelease)
Message-ID: <Pine.LNX.4.10.10101012024250.27472-100000@moot.cdir.mb.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When copying large files to/from my vfat filesystem, I frequently get NULL
pointer dereference oopsen.  I believe this to be a possible solution.
(I have been unable to cause an oops since I did this.)

(against 2.4.0-prerelease)

--- fs/fat/cache.c.orig	Mon Jan  1 14:33:43 2001
+++ fs/fat/cache.c	Mon Jan  1 19:13:29 2001
@@ -24,6 +24,7 @@
 #endif
 
 static struct fat_cache *fat_cache,cache[FAT_CACHE];
+spinlock_t fat_cache_lock = SPIN_LOCK_UNLOCKED;
 
 /* Returns the this'th FAT entry, -1 if it is an end-of-file entry. If
    new_value is != -1, that FAT entry is replaced by it. */
@@ -133,13 +134,16 @@
 	return next;
 }
 
-
 void fat_cache_init(void)
 {
 	static int initialized = 0;
 	int count;
 
-	if (initialized) return;
+	spin_lock(&fat_cache_lock);
+	if (initialized) {
+		spin_unlock(&fat_cache_lock);
+		return;
+		}
 	fat_cache = &cache[0];
 	for (count = 0; count < FAT_CACHE; count++) {
 		cache[count].device = 0;
@@ -147,6 +151,7 @@
 		    &cache[count+1];
 	}
 	initialized = 1;
+	spin_unlock(&fat_cache_lock);
 }
 
 
@@ -157,6 +162,7 @@
 
 	if (!first)
 		return;
+	spin_lock(&fat_cache_lock);
 	for (walk = fat_cache; walk; walk = walk->next)
 		if (inode->i_dev == walk->device
 		    && walk->start_cluster == first
@@ -166,8 +172,12 @@
 #ifdef DEBUG
 printk("cache hit: %d (%d)\n",walk->file_cluster,*d_clu);
 #endif
-			if ((*f_clu = walk->file_cluster) == cluster) return;
+			if ((*f_clu = walk->file_cluster) == cluster) { 
+				spin_unlock(&fat_cache_lock);
+				return;
+			}
 		}
+	spin_unlock(&fat_cache_lock);
 #ifdef DEBUG
 printk("cache miss\n");
 #endif
@@ -197,6 +207,7 @@
 	int first = MSDOS_I(inode)->i_start;
 
 	last = NULL;
+	spin_lock(&fat_cache_lock);
 	for (walk = fat_cache; walk->next; walk = (last = walk)->next)
 		if (inode->i_dev == walk->device
 		    && walk->start_cluster == first
@@ -204,17 +215,22 @@
 			if (walk->disk_cluster != d_clu) {
 				printk("FAT cache corruption inode=%ld\n",
 					inode->i_ino);
+				spin_unlock(&fat_cache_lock);
 				fat_cache_inval_inode(inode);
 				return;
 			}
 			/* update LRU */
-			if (last == NULL) return;
+			if (last == NULL) {
+				spin_unlock(&fat_cache_lock);
+				return;
+			}
 			last->next = walk->next;
 			walk->next = fat_cache;
 			fat_cache = walk;
 #ifdef DEBUG
 list_cache();
 #endif
+			spin_unlock(&fat_cache_lock);
 			return;
 		}
 	walk->device = inode->i_dev;
@@ -224,6 +240,7 @@
 	last->next = NULL;
 	walk->next = fat_cache;
 	fat_cache = walk;
+	spin_unlock(&fat_cache_lock);
 #ifdef DEBUG
 list_cache();
 #endif
@@ -238,10 +255,12 @@
 	struct fat_cache *walk;
 	int first = MSDOS_I(inode)->i_start;
 
+	spin_lock(&fat_cache_lock);
 	for (walk = fat_cache; walk; walk = walk->next)
 		if (walk->device == inode->i_dev
 		    && walk->start_cluster == first)
 			walk->device = 0;
+	spin_unlock(&fat_cache_lock);
 }
 
 
@@ -249,9 +268,11 @@
 {
 	struct fat_cache *walk;
 
+	spin_lock(&fat_cache_lock);
 	for (walk = fat_cache; walk; walk = walk->next)
 		if (walk->device == device)
 			walk->device = 0;
+	spin_unlock(&fat_cache_lock);
 }
 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

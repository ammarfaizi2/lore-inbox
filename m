Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWJYXwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWJYXwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 19:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWJYXwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 19:52:51 -0400
Received: from hu-out-0506.google.com ([72.14.214.227]:27773 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751707AbWJYXwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 19:52:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=lmWEt4H5EaWOke+bGiQmug1BEUCRgOqQ9ebr4cmrBfhLjwsZ9xWlFW0G06fPG2ZtbCJEqgwO7/nXZhot0SWWzKbzgtdYh5lv8CSOLj8MT+ST6MygCc3bdR8wwsQ96qkIZ22jyvf07RdJrv5DRR8iTYyLEj6SgyS0D1+j+qQlLqs=
Message-ID: <f46018bb0610251652y7b29889cr8a41044db6168432@mail.gmail.com>
Date: Wed, 25 Oct 2006 19:52:47 -0400
From: "Holden Karau" <holden@pigscanfly.ca>
To: hirofumi@mail.parknet.co.jp
Subject: [PATCH 1/1] fat: improve sync performance by grouping writes in fat_mirror_bhs
Cc: linux-kernel@vger.kernel.org, holdenk@xandros.com,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       "Holden Karau" <holden@pigscanfly.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: e492536d052bdb84
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com

This is an attempt at improving fat_mirror_bhs in sync mode [namely it
writes all of the data for a backup block, and then blocks untill
finished]. The old behaviour would write & block in smaller chunks, so
this should be slightly faster. It also removes the fixme requesting
that it be fixed to behave this way :-)
Signed-off-by: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com
---
Important note; I do not normally play with filesystems. This MAY eat
your file system, it hasen't eaten mine but that does not mean much at
all [although I don't think it will]. I'd greatly appreciate comments
& suggestions. In case the patch gets mangled I've put it up at
http://www.holdenkarau.com/~holden/projects/fat/001_improve_fat_sync_performance.patch

And now for the actual patch:
--- a/fs/fat/fatent.c	2006-09-19 23:42:06.000000000 -0400
+++ b/fs/fat/fatent.c	2006-10-25 19:14:14.000000000 -0400
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2004, OGAWA Hirofumi
+ * Copyright (C) 2006, Holden Karau [Xandros]
  * Released under GPL v2.
  */

@@ -343,34 +344,46 @@ int fat_ent_read(struct inode *inode, st
 	return ops->ent_get(fatent);
 }

-/* FIXME: We can write the blocks as more big chunk. */
 static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
-			  int nr_bhs)
+			  int nr_bhs ) {
+  return fat_mirror_bhs_optw(sb , bhs , nr_bhs, 0);
+}
+
+static int fat_mirror_bhs_optw(struct super_block *sb, struct
buffer_head **bhs,
+			       int nr_bhs , int wait)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	struct buffer_head *c_bh;
+	struct buffer_head *c_bh[nr_bhs];
 	int err, n, copy;

+	/* Always wait if mounted -o sync */
+	if (sb->s_flags & MS_SYNCHRONOUS ) {
+	  wait = 1;
+	}
+
 	err = 0;
+	err = fat_sync_bhs_optw( bhs  , nr_bhs , wait);
+	if (err)
+	  goto error;
 	for (copy = 1; copy < sbi->fats; copy++) {
 		sector_t backup_fat = sbi->fat_length * copy;
-
 		for (n = 0; n < nr_bhs; n++) {
-			c_bh = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
-			if (!c_bh) {
+	    c_bh[n] = sb_getblk(sb, backup_fat + bhs[n]->b_blocknr);
+	    if (!c_bh[n]) {
 				err = -ENOMEM;
 				goto error;
 			}
-			memcpy(c_bh->b_data, bhs[n]->b_data, sb->s_blocksize);
-			set_buffer_uptodate(c_bh);
-			mark_buffer_dirty(c_bh);
-			if (sb->s_flags & MS_SYNCHRONOUS)
-				err = sync_dirty_buffer(c_bh);
-			brelse(c_bh);
+	    set_buffer_uptodate(c_bh[n]);
+	    mark_buffer_dirty(c_bh[n]);
+	    memcpy(c_bh[n]->b_data, bhs[n]->b_data, sb->s_blocksize);
+	  }
+	  err = fat_sync_bhs_optw( c_bh  , nr_bhs , wait );
+	  for (n = 0; n < nr_bhs; n++ ) {
+	    brelse(c_bh[n]);
+	  }
 			if (err)
 				goto error;
 		}
-	}
 error:
 	return err;
 }
@@ -383,12 +396,7 @@ int fat_ent_write(struct inode *inode, s
 	int err;

 	ops->ent_put(fatent, new);
-	if (wait) {
-		err = fat_sync_bhs(fatent->bhs, fatent->nr_bhs);
-		if (err)
-			return err;
-	}
-	return fat_mirror_bhs(sb, fatent->bhs, fatent->nr_bhs);
+	return fat_mirror_bhs_optw(sb, fatent->bhs, fatent->nr_bhs , wait);
 }

 static inline int fat_ent_next(struct msdos_sb_info *sbi,
@@ -505,9 +513,9 @@ out:
 	fatent_brelse(&fatent);
 	if (!err) {
 		if (inode_needs_sync(inode))
-			err = fat_sync_bhs(bhs, nr_bhs);
-		if (!err)
-			err = fat_mirror_bhs(sb, bhs, nr_bhs);
+		  err = fat_mirror_bhs_optw(sb , bhs, nr_bhs , 1);
+		else
+		  err = fat_mirror_bhs_optw(sb, bhs, nr_bhs , 0 );
 	}
 	for (i = 0; i < nr_bhs; i++)
 		brelse(bhs[i]);
@@ -549,11 +557,6 @@ int fat_free_clusters(struct inode *inod
 		}

 		if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
-			if (sb->s_flags & MS_SYNCHRONOUS) {
-				err = fat_sync_bhs(bhs, nr_bhs);
-				if (err)
-					goto error;
-			}
 			err = fat_mirror_bhs(sb, bhs, nr_bhs);
 			if (err)
 				goto error;
@@ -564,11 +567,6 @@ int fat_free_clusters(struct inode *inod
 		fat_collect_bhs(bhs, &nr_bhs, &fatent);
 	} while (cluster != FAT_ENT_EOF);

-	if (sb->s_flags & MS_SYNCHRONOUS) {
-		err = fat_sync_bhs(bhs, nr_bhs);
-		if (err)
-			goto error;
-	}
 	err = fat_mirror_bhs(sb, bhs, nr_bhs);
 error:
 	fatent_brelse(&fatent);
--- a/fs/fat/misc.c	2006-09-19 23:42:06.000000000 -0400
+++ b/fs/fat/misc.c	2006-10-25 18:54:27.000000000 -0400
@@ -194,11 +194,17 @@ void fat_date_unix2dos(int unix_date, __

 EXPORT_SYMBOL_GPL(fat_date_unix2dos);

-int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
+
+int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs ) {
+  return fat_sync_bhs_optw(bhs , nr_bhs , 1);
+}
+
+int fat_sync_bhs_optw(struct buffer_head **bhs, int nr_bhs ,int wait)
 {
 	int i, err = 0;

 	ll_rw_block(SWRITE, nr_bhs, bhs);
+	if (wait) {
 	for (i = 0; i < nr_bhs; i++) {
 		wait_on_buffer(bhs[i]);
 		if (buffer_eopnotsupp(bhs[i])) {
@@ -207,6 +213,7 @@ int fat_sync_bhs(struct buffer_head **bh
 		} else if (!err && !buffer_uptodate(bhs[i]))
 			err = -EIO;
 	}
+	}
 	return err;
 }

--- a/include/linux/msdos_fs.h	2006-09-19 23:42:06.000000000 -0400
+++ b/include/linux/msdos_fs.h	2006-10-25 18:53:50.000000000 -0400
@@ -419,6 +419,7 @@ extern int fat_chain_add(struct inode *i
 extern int date_dos2unix(unsigned short time, unsigned short date);
 extern void fat_date_unix2dos(int unix_date, __le16 *time, __le16 *date);
 extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
+extern int fat_sync_bhs_optw(struct buffer_head **bhs, int nr_bhs, int wait);

 int fat_cache_init(void);
 void fat_cache_destroy(void);

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSHIQeD>; Fri, 9 Aug 2002 12:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSHIQeD>; Fri, 9 Aug 2002 12:34:03 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:50561 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S314546AbSHIQeA>;
	Fri, 9 Aug 2002 12:34:00 -0400
Date: Fri, 9 Aug 2002 20:36:39 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200208091636.g79Gad6I007887@bitshadow.namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [BK] [PATCH] reiserfs changeset 6 of 7 to include into 2.4 tree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This changeset fixes wrong casts for bit operations (backport from 2.5)
   You can pull it from bk://thebsh.namesys.com/bk/reiser3-linux-2.4

   Diffstat:

 fs/reiserfs/journal.c       |    8 ++++----
 fs/reiserfs/namei.c         |    4 ++--
 include/linux/reiserfs_fs.h |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

Plain text patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.686   -> 1.687  
#	 fs/reiserfs/namei.c	1.22    -> 1.23   
#	fs/reiserfs/journal.c	1.21    -> 1.22   
#	include/linux/reiserfs_fs.h	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/06	green@angband.namesys.com	1.687
# reiserfs_fs.h, namei.c, journal.c:
#   fix wrong casts for bit operations (backported from 2.5)
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Tue Aug  6 10:38:14 2002
+++ b/fs/reiserfs/journal.c	Tue Aug  6 10:38:14 2002
@@ -191,7 +191,7 @@
   if (!jb->bitmaps[bmap_nr]) {
     jb->bitmaps[bmap_nr] = get_bitmap_node(p_s_sb) ;
   }
-  set_bit(bit_nr, jb->bitmaps[bmap_nr]->data) ;
+  set_bit(bit_nr, (unsigned long *)jb->bitmaps[bmap_nr]->data) ;
   return 0 ;
 }
 
@@ -375,7 +375,7 @@
 /* buffer is in current transaction */
 inline int buffer_journaled(const struct buffer_head *bh) {
   if (bh)
-    return test_bit(BH_JDirty, ( struct buffer_head * ) &bh->b_state) ;
+    return test_bit(BH_JDirty, &((struct buffer_head *)bh)->b_state) ;
   else
     return 0 ;
 }
@@ -385,7 +385,7 @@
 */ 
 inline int buffer_journal_new(const struct buffer_head *bh) {
   if (bh) 
-    return test_bit(BH_JNew, ( struct buffer_head * )&bh->b_state) ;
+    return test_bit(BH_JNew, &((struct buffer_head *)bh)->b_state) ;
   else
     return 0 ;
 }
@@ -534,7 +534,7 @@
       PROC_INFO_INC( p_s_sb, journal.in_journal_bitmap );
       jb = SB_JOURNAL(p_s_sb)->j_list_bitmap + i ;
       if (jb->journal_list && jb->bitmaps[bmap_nr] &&
-          test_bit(bit_nr, jb->bitmaps[bmap_nr]->data)) {
+          test_bit(bit_nr, (unsigned long *)jb->bitmaps[bmap_nr]->data)) {
 	tmp_bit = find_next_zero_bit((unsigned long *)
 	                             (jb->bitmaps[bmap_nr]->data),
 	                             p_s_sb->s_blocksize << 3, bit_nr+1) ; 
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Tue Aug  6 10:38:14 2002
+++ b/fs/reiserfs/namei.c	Tue Aug  6 10:38:14 2002
@@ -232,7 +232,7 @@
    
 	/* mark, that this generation number is used */
 	if (de->de_gen_number_bit_string)
-	    set_bit (GET_GENERATION_NUMBER (deh_offset (deh)), de->de_gen_number_bit_string);
+	    set_bit (GET_GENERATION_NUMBER (deh_offset (deh)), (unsigned long *)de->de_gen_number_bit_string);
 
 	// calculate pointer to name and namelen
 	de->de_entry_num = i;
@@ -420,7 +420,7 @@
 	return -EEXIST;
     }
 
-    gen_number = find_first_zero_bit (bit_string, MAX_GENERATION_NUMBER + 1);
+    gen_number = find_first_zero_bit ((unsigned long *)bit_string, MAX_GENERATION_NUMBER + 1);
     if (gen_number > MAX_GENERATION_NUMBER) {
       /* there is no free generation number */
       reiserfs_warning ("reiserfs_add_entry: Congratulations! we have got hash function screwed up\n");
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Tue Aug  6 10:38:14 2002
+++ b/include/linux/reiserfs_fs.h	Tue Aug  6 10:38:14 2002
@@ -1576,7 +1576,7 @@
 
 				/* why is this kerplunked right here? */
 static inline int reiserfs_buffer_prepared(const struct buffer_head *bh) {
-  if (bh && test_bit(BH_JPrepared, ( struct buffer_head * ) &bh->b_state))
+  if (bh && test_bit(BH_JPrepared, &( (struct buffer_head *)bh)->b_state))
     return 1 ;
   else
     return 0 ;
@@ -1585,7 +1585,7 @@
 /* buffer was journaled, waiting to get to disk */
 static inline int buffer_journal_dirty(const struct buffer_head *bh) {
   if (bh)
-    return test_bit(BH_JDirty_wait, ( struct buffer_head * ) &bh->b_state) ;
+    return test_bit(BH_JDirty_wait, &( (struct buffer_head *)bh)->b_state) ;
   else
     return 0 ;
 }

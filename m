Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSHTK44>; Tue, 20 Aug 2002 06:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSHTK44>; Tue, 20 Aug 2002 06:56:56 -0400
Received: from reload.namesys.com ([212.16.7.75]:10368 "EHLO
	reload.namesys.com") by vger.kernel.org with ESMTP
	id <S316845AbSHTK4u>; Tue, 20 Aug 2002 06:56:50 -0400
To: torvalds@transmeta.com, reiser@namesys.com, green@namesys.com,
       linux-kernel@vger.kernel.org
Subject: [BK] [2.5] reiserfs changeset 1 of 3
Message-Id: <20020820110050.9A38FA8C4F@reload.namesys.com>
Date: Tue, 20 Aug 2002 15:00:50 +0400 (MSD)
From: reiser@reload.namesys.com (Hans Reiser)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   This changesets adds displaying of some aditional reiserfs statistics through
   /proc interface. Please apply.
   You can get it from bk://thebsh.namesys.com/bk/reiser3-linux-2.5

Diffstat:
 fs/reiserfs/procfs.c           |   13 +++++++++++++
 fs/reiserfs/stree.c            |   10 +++++++++-
 include/linux/reiserfs_fs_sb.h |    6 ++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

Plain text patch
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.499   -> 1.500  
#	fs/reiserfs/procfs.c	1.12    -> 1.13   
#	include/linux/reiserfs_fs_sb.h	1.17    -> 1.18   
#	 fs/reiserfs/stree.c	1.31    -> 1.32   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/20	green@angband.namesys.com	1.500
# Add displaying of more reiserfs statistical info through /proc interface, by Nikita Danilov
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
--- a/fs/reiserfs/procfs.c	Tue Aug 20 13:58:46 2002
+++ b/fs/reiserfs/procfs.c	Tue Aug 20 13:58:46 2002
@@ -165,6 +165,12 @@
 			"search_by_key_fs_changed: \t%lu\n"
 			"search_by_key_restarted: \t%lu\n"
 			
+			"insert_item_restarted: \t%lu\n"
+			"paste_into_item_restarted: \t%lu\n"
+			"cut_from_item_restarted: \t%lu\n"
+			"delete_solid_item_restarted: \t%lu\n"
+			"delete_item_restarted: \t%lu\n"
+
 			"leaked_oid: \t%lu\n"
 			"leaves_removable: \t%lu\n",
 
@@ -201,6 +207,13 @@
 			SFP( search_by_key ),
 			SFP( search_by_key_fs_changed ),
 			SFP( search_by_key_restarted ),
+
+			SFP( insert_item_restarted ),
+			SFP( paste_into_item_restarted ),
+			SFP( cut_from_item_restarted ),
+			SFP( delete_solid_item_restarted ),
+			SFP( delete_item_restarted ),
+
 			SFP( leaked_oid ),
 			SFP( leaves_removable ) );
 
diff -Nru a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
--- a/fs/reiserfs/stree.c	Tue Aug 20 13:58:46 2002
+++ b/fs/reiserfs/stree.c	Tue Aug 20 13:58:46 2002
@@ -1245,6 +1245,8 @@
 	if ( n_ret_value != REPEAT_SEARCH )
 	    break;
 
+	PROC_INFO_INC( p_s_sb, delete_item_restarted );
+
 	// file system changed, repeat search
 	n_ret_value = search_for_position_by_key(p_s_sb, p_s_item_key, p_s_path);
 	if (n_ret_value == IO_ERROR)
@@ -1355,8 +1357,10 @@
 	}
 
 	retval = fix_nodes (M_DELETE, &tb, NULL, 0);
-	if (retval == REPEAT_SEARCH)
+	if (retval == REPEAT_SEARCH) {
+	    PROC_INFO_INC( th -> t_super, delete_solid_item_restarted );
 	    continue;
+	}
 
 	if (retval == CARRY_ON) {
 	    do_balance (&tb, 0, 0, M_DELETE);
@@ -1543,6 +1547,8 @@
       	if ( n_ret_value != REPEAT_SEARCH )
 	    break;
 	
+	PROC_INFO_INC( p_s_sb, cut_from_item_restarted );
+
 	n_ret_value = search_for_position_by_key(p_s_sb, p_s_item_key, p_s_path);
 	if (n_ret_value == POSITION_FOUND)
 	    continue;
@@ -1810,6 +1816,7 @@
     
     while ( (retval = fix_nodes(M_PASTE, &s_paste_balance, NULL, p_c_body)) == REPEAT_SEARCH ) {
 	/* file system changed while we were in the fix_nodes */
+	PROC_INFO_INC( th -> t_super, paste_into_item_restarted );
 	retval = search_for_position_by_key (th->t_super, p_s_key, p_s_search_path);
 	if (retval == IO_ERROR) {
 	    retval = -EIO ;
@@ -1860,6 +1867,7 @@
 
     while ( (retval = fix_nodes(M_INSERT, &s_ins_balance, p_s_ih, p_c_body)) == REPEAT_SEARCH) {
 	/* file system changed while we were in the fix_nodes */
+	PROC_INFO_INC( th -> t_super, insert_item_restarted );
 	retval = search_item (th->t_super, key, p_s_path);
 	if (retval == IO_ERROR) {
 	    retval = -EIO;
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Tue Aug 20 13:58:46 2002
+++ b/include/linux/reiserfs_fs_sb.h	Tue Aug 20 13:58:46 2002
@@ -270,6 +270,12 @@
   stat_cnt_t search_by_key_fs_changed;
   stat_cnt_t search_by_key_restarted;
 
+  stat_cnt_t insert_item_restarted;
+  stat_cnt_t paste_into_item_restarted;
+  stat_cnt_t cut_from_item_restarted;
+  stat_cnt_t delete_solid_item_restarted;
+  stat_cnt_t delete_item_restarted;
+
   stat_cnt_t leaked_oid;
   stat_cnt_t leaves_removable;
 

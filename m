Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSFJNv5>; Mon, 10 Jun 2002 09:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSFJNvX>; Mon, 10 Jun 2002 09:51:23 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:27264 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315335AbSFJNuV>;
	Mon, 10 Jun 2002 09:50:21 -0400
Date: Mon, 10 Jun 2002 17:42:55 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADgtuW003848@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 3 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 3 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

  This is reiserfs_fill_super cleanup. By Josh MacDonald.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 fs/reiserfs/procfs.c           |    2
 fs/reiserfs/super.c            |  132 +++++++++++++++++++++--------------------
 include/linux/reiserfs_fs_sb.h |    2
 3 files changed, 71 insertions(+), 65 deletions(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.596   -> 1.597  
#	fs/reiserfs/procfs.c	1.9     -> 1.10   
#	 fs/reiserfs/super.c	1.44    -> 1.45   
#	include/linux/reiserfs_fs_sb.h	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.597
# reiserfs_fs_sb.h, super.c, procfs.c:
#   reiserfs_fill_super cleanup. From Josh MacDonald.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
--- a/fs/reiserfs/procfs.c	Thu May 30 18:42:17 2002
+++ b/fs/reiserfs/procfs.c	Thu May 30 18:42:17 2002
@@ -36,7 +36,7 @@
 	/* get super-block by device */
 	result = get_super( dev );
 	if( result != NULL ) {
-		if( !reiserfs_is_super( result ) ) {
+		if( !is_reiserfs_super( result ) ) {
 			printk( KERN_DEBUG "reiserfs: procfs-52: "
 				"non-reiserfs super found\n" );
 			drop_super( result );
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Thu May 30 18:42:17 2002
+++ b/fs/reiserfs/super.c	Thu May 30 18:42:17 2002
@@ -24,6 +24,8 @@
 #define REISERFS_OLD_BLOCKSIZE 4096
 #define REISERFS_SUPER_MAGIC_STRING_OFFSET_NJ 20
 
+static struct file_system_type reiserfs_fs_type;
+
 const char reiserfs_3_5_magic_string[] = REISERFS_SUPER_MAGIC_STRING;
 const char reiserfs_3_6_magic_string[] = REISER2FS_SUPER_MAGIC_STRING;
 const char reiserfs_jr_magic_string[] = REISER2FS_JR_SUPER_MAGIC_STRING;
@@ -55,6 +57,11 @@
 	  is_reiserfs_jr (rs));
 }
 
+int is_reiserfs_super (struct super_block *s)
+{
+	return s -> s_type == & reiserfs_fs_type ;
+}
+
 static int reiserfs_remount (struct super_block * s, int * flags, char * data);
 static int reiserfs_statfs (struct super_block * s, struct statfs * buf);
 
@@ -997,7 +1004,7 @@
 // at the ext2 code and comparing. It's subfunctions contain no code
 // used as a template unless they are so labeled.
 //
-static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
+static int reiserfs_fill_super (struct super_block * s, void * data, int silent)
 {
     struct inode *root_inode;
     int j;
@@ -1009,21 +1016,24 @@
     struct reiserfs_super_block * rs;
     char *jdev_name;
     struct reiserfs_sb_info *sbi;
+    int errval = -EINVAL;
 
     sbi = kmalloc(sizeof(struct reiserfs_sb_info), GFP_KERNEL);
-    if (!sbi)
-	return -ENOMEM;
+    if (!sbi) {
+	errval = -ENOMEM;
+	goto error;
+    }
     s->u.generic_sbp = sbi;
     memset (sbi, 0, sizeof (struct reiserfs_sb_info));
 
     jdev_name = NULL;
     if (parse_options ((char *) data, &(sbi->s_mount_opt), &blocks, &jdev_name) == 0) {
-	return -EINVAL;
+	goto error;
     }
 
     if (blocks) {
-  	printk("reserfs: resize option for remount only\n");
-	return -EINVAL;
+  	printk("jmacd-7: reiserfs_fill_super: resize option for remount only\n");
+	goto error;
     }	
 
     /* try old format (undistributed bitmap, super block in 8-th 1k block of a device) */
@@ -1038,7 +1048,7 @@
     sbi->s_mount_state = REISERFS_VALID_FS ;
 
     if (old_format ? read_old_bitmaps(s) : read_bitmaps(s)) { 
-	printk ("reiserfs_fill_super: unable to read bitmap\n");
+	printk ("jmacd-8: reiserfs_fill_super: unable to read bitmap\n");
 	goto error;
     }
 #ifdef CONFIG_REISERFS_CHECK
@@ -1056,7 +1066,7 @@
 			 */
     }
     if (reread_meta_blocks(s)) {
-	printk("reiserfs_fill_super: unable to reread meta blocks after journal init\n") ;
+	printk("jmacd-9: reiserfs_fill_super: unable to reread meta blocks after journal init\n") ;
 	goto error ;
     }
 
@@ -1071,7 +1081,7 @@
     args.dirid = REISERFS_ROOT_PARENT_OBJECTID ;
     root_inode = iget5_locked (s, REISERFS_ROOT_OBJECTID, reiserfs_find_actor, reiserfs_init_locked_inode, (void *)(&args));
     if (!root_inode) {
-	printk ("reiserfs_fill_super: get root inode failed\n");
+	printk ("jmacd-10: reiserfs_fill_super: get root inode failed\n");
 	goto error;
     }
 
@@ -1155,7 +1165,7 @@
     reiserfs_proc_register( s, "journal", reiserfs_journal_in_proc );
     init_waitqueue_head (&(sbi->s_wait));
 
-    return 0;
+    return (0);
 
  error:
     if (jinit_done) { /* kill the commit thread, free journal ram */
@@ -1172,10 +1182,12 @@
     if (SB_BUFFER_WITH_SB (s))
 	brelse(SB_BUFFER_WITH_SB (s));
 
-    kfree(sbi);
-    s->u.generic_sbp = NULL;
+    if (sbi != NULL) {
+	kfree(sbi);
+    }
 
-    return -EINVAL;
+    s->u.generic_sbp = NULL;
+    return errval;
 }
 
 
@@ -1202,66 +1214,60 @@
   return 0;
 }
 
-static struct super_block *reiserfs_get_sb(struct file_system_type *fs_type,
-	int flags, char *dev_name, void *data)
+static struct super_block*
+get_super_block (struct file_system_type *fs_type,
+		 int                      flags,
+		 char                    *dev_name,
+		 void                    *data)
 {
-	return get_sb_bdev(fs_type, flags, dev_name, data, reiserfs_fill_super);
+	return get_sb_bdev (fs_type, flags, dev_name, data, reiserfs_fill_super);
 }
 
-static struct file_system_type reiserfs_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"reiserfs",
-	get_sb:		reiserfs_get_sb,
-	kill_sb:	kill_block_super,
-	fs_flags:	FS_REQUIRES_DEV,
-};
-
-int reiserfs_is_super(struct super_block *s)
+static int __init
+init_reiserfs_fs ( void )
 {
-	return s->s_type == &reiserfs_fs_type;
-}
+	int ret;
 
-//
-// this is exactly what 2.3.99-pre9's init_ext2_fs is
-//
-static int __init init_reiserfs_fs (void)
-{
-	int err = init_inodecache();
-	if (err)
-		goto out1;
-	reiserfs_proc_info_global_init();
-	reiserfs_proc_register_global( "version", 
-				       reiserfs_global_version_in_proc );
-        err = register_filesystem(&reiserfs_fs_type);
-	if (err)
-		goto out;
-	return 0;
-out:
-	reiserfs_proc_unregister_global( "version" );
-	reiserfs_proc_info_global_done();
-	destroy_inodecache();
-out1:
-	return err;
-}
+	if ((ret = init_inodecache ())) {
+		return ret;
+	}
 
+	reiserfs_proc_info_global_init ();
+	reiserfs_proc_register_global ("version", reiserfs_global_version_in_proc);
 
-MODULE_DESCRIPTION("ReiserFS journaled filesystem");
-MODULE_AUTHOR("Hans Reiser <reiser@namesys.com>");
-MODULE_LICENSE("GPL");
+        ret = register_filesystem (& reiserfs_fs_type);
 
-//
-// this is exactly what 2.3.99-pre9's init_ext2_fs is
-//
-static void __exit exit_reiserfs_fs(void)
-{
-	reiserfs_proc_unregister_global( "version" );
-	reiserfs_proc_info_global_done();
-        unregister_filesystem(&reiserfs_fs_type);
-	destroy_inodecache();
+	if (ret == 0) {
+		return 0;
+	}
+
+	reiserfs_proc_unregister_global ("version");
+	reiserfs_proc_info_global_done ();
+	destroy_inodecache ();
+
+	return ret;
 }
 
-module_init(init_reiserfs_fs) ;
-module_exit(exit_reiserfs_fs) ;
+static void __exit
+exit_reiserfs_fs ( void )
+{
+	reiserfs_proc_unregister_global ("version");
+	reiserfs_proc_info_global_done ();
+        unregister_filesystem (& reiserfs_fs_type);
+	destroy_inodecache ();
+}
 
+static struct file_system_type reiserfs_fs_type = {
+	owner: THIS_MODULE,
+	name: "reiserfs",
+	get_sb: get_super_block,
+	kill_sb: kill_block_super,
+	fs_flags: FS_REQUIRES_DEV,
+};
 
+MODULE_DESCRIPTION ("ReiserFS journaled filesystem");
+MODULE_AUTHOR      ("Hans Reiser <reiser@namesys.com>");
+MODULE_LICENSE     ("GPL");
 
+module_init (init_reiserfs_fs);
+module_exit (exit_reiserfs_fs);
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Thu May 30 18:42:17 2002
+++ b/include/linux/reiserfs_fs_sb.h	Thu May 30 18:42:17 2002
@@ -430,7 +430,7 @@
 
 
 void reiserfs_file_buffer (struct buffer_head * bh, int list);
-int reiserfs_is_super(struct super_block *s)  ;
+int is_reiserfs_super(struct super_block *s)  ;
 int journal_mark_dirty(struct reiserfs_transaction_handle *, struct super_block *, struct buffer_head *bh) ;
 int flush_old_commits(struct super_block *s, int) ;
 int show_reiserfs_locks(void) ;

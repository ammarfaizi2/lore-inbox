Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311273AbSC1BMj>; Wed, 27 Mar 2002 20:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311288AbSC1BMe>; Wed, 27 Mar 2002 20:12:34 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:26318 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S311273AbSC1BMU>; Wed, 27 Mar 2002 20:12:20 -0500
Message-ID: <3CA26DB8.9080305@didntduck.org>
Date: Wed, 27 Mar 2002 20:11:20 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: [PATCH] struct super_block cleanup - reiserfs
Content-Type: multipart/mixed;
 boundary="------------070501030600010704020709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070501030600010704020709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates reiserfs_sb_info from struct super_block.

-- 

						Brian Gerst

--------------070501030600010704020709
Content-Type: text/plain;
 name="sb-reiserfs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-reiserfs-1"

diff -urN linux-2.5.7/fs/reiserfs/do_balan.c linux/fs/reiserfs/do_balan.c
--- linux-2.5.7/fs/reiserfs/do_balan.c	Thu Mar  7 21:18:15 2002
+++ linux/fs/reiserfs/do_balan.c	Wed Mar 27 19:38:22 2002
@@ -1527,7 +1527,7 @@
     ** and then free them now
     */
 
-    tb->tb_sb->u.reiserfs_sb.s_do_balance ++;
+    REISERFS_SB(tb->tb_sb)->s_do_balance ++;
 
 
     /* release all nodes hold to perform the balancing */
diff -urN linux-2.5.7/fs/reiserfs/fix_node.c linux/fs/reiserfs/fix_node.c
--- linux-2.5.7/fs/reiserfs/fix_node.c	Thu Mar  7 21:18:22 2002
+++ linux/fs/reiserfs/fix_node.c	Wed Mar 27 19:38:22 2002
@@ -1988,13 +1988,13 @@
 
     vp = kmalloc (size, flags);
     if (vp) {
-	s->u.reiserfs_sb.s_kmallocs += size;
-	if (s->u.reiserfs_sb.s_kmallocs > malloced + 200000) {
-	    reiserfs_warning ("vs-8301: reiserfs_kmalloc: allocated memory %d\n", s->u.reiserfs_sb.s_kmallocs);
-	    malloced = s->u.reiserfs_sb.s_kmallocs;
+	REISERFS_SB(s)->s_kmallocs += size;
+	if (REISERFS_SB(s)->s_kmallocs > malloced + 200000) {
+	    reiserfs_warning ("vs-8301: reiserfs_kmalloc: allocated memory %d\n", REISERFS_SB(s)->s_kmallocs);
+	    malloced = REISERFS_SB(s)->s_kmallocs;
 	}
     }
-/*printk ("malloc : size %d, allocated %d\n", size, s->u.reiserfs_sb.s_kmallocs);*/
+/*printk ("malloc : size %d, allocated %d\n", size, REISERFS_SB(s)->s_kmallocs);*/
     return vp;
 }
 
@@ -2002,9 +2002,9 @@
 {
     kfree (vp);
   
-    s->u.reiserfs_sb.s_kmallocs -= size;
-    if (s->u.reiserfs_sb.s_kmallocs < 0)
-	reiserfs_warning ("vs-8302: reiserfs_kfree: allocated memory %d\n", s->u.reiserfs_sb.s_kmallocs);
+    REISERFS_SB(s)->s_kmallocs -= size;
+    if (REISERFS_SB(s)->s_kmallocs < 0)
+	reiserfs_warning ("vs-8302: reiserfs_kfree: allocated memory %d\n", REISERFS_SB(s)->s_kmallocs);
 
 }
 #endif
@@ -2062,7 +2062,7 @@
 #ifdef CONFIG_REISERFS_CHECK
 		reiserfs_warning ("vs-8345: get_mem_for_virtual_node: "
 				  "kmalloc failed. reiserfs kmalloced %d bytes\n",
-				  tb->tb_sb->u.reiserfs_sb.s_kmallocs);
+				  REISERFS_SB(tb->tb_sb)->s_kmallocs);
 #endif
 		tb->vn_buf_size = 0;
 	    }
@@ -2290,7 +2290,7 @@
     int windex ;
     struct buffer_head  * p_s_tbS0 = PATH_PLAST_BUFFER(p_s_tb->tb_path);
 
-    ++ p_s_tb -> tb_sb -> u.reiserfs_sb.s_fix_nodes;
+    ++ REISERFS_SB(p_s_tb -> tb_sb) -> s_fix_nodes;
 
     n_pos_in_item = p_s_tb->tb_path->pos_in_item;
 
diff -urN linux-2.5.7/fs/reiserfs/ibalance.c linux/fs/reiserfs/ibalance.c
--- linux-2.5.7/fs/reiserfs/ibalance.c	Thu Mar  7 21:18:54 2002
+++ linux/fs/reiserfs/ibalance.c	Wed Mar 27 19:38:22 2002
@@ -623,10 +623,10 @@
 		new_root = tb->L[h-1];
 	    /* switch super block's tree root block number to the new value */
             PUT_SB_ROOT_BLOCK( tb->tb_sb, new_root->b_blocknr );
-	    //tb->tb_sb->u.reiserfs_sb.s_rs->s_tree_height --;
+	    //REISERFS_SB(tb->tb_sb)->s_rs->s_tree_height --;
             PUT_SB_TREE_HEIGHT( tb->tb_sb, SB_TREE_HEIGHT(tb->tb_sb) - 1 );
 
-	    do_balance_mark_sb_dirty (tb, tb->tb_sb->u.reiserfs_sb.s_sbh, 1);
+	    do_balance_mark_sb_dirty (tb, REISERFS_SB(tb->tb_sb)->s_sbh, 1);
 	    /*&&&&&&&&&&&&&&&&&&&&&&*/
 	    if (h > 1)
 		/* use check_internal if new root is an internal node */
@@ -949,7 +949,7 @@
 	/* Change root in structure super block. */
         PUT_SB_ROOT_BLOCK( tb->tb_sb, tbSh->b_blocknr );
         PUT_SB_TREE_HEIGHT( tb->tb_sb, SB_TREE_HEIGHT(tb->tb_sb) + 1 );
-	do_balance_mark_sb_dirty (tb, tb->tb_sb->u.reiserfs_sb.s_sbh, 1);
+	do_balance_mark_sb_dirty (tb, REISERFS_SB(tb->tb_sb)->s_sbh, 1);
 	tb->tb_sb->s_dirt = 1;
     }
 	
diff -urN linux-2.5.7/fs/reiserfs/inode.c linux/fs/reiserfs/inode.c
--- linux-2.5.7/fs/reiserfs/inode.c	Thu Mar  7 21:18:23 2002
+++ linux/fs/reiserfs/inode.c	Wed Mar 27 19:38:22 2002
@@ -1176,7 +1176,7 @@
        nlink==0: processing of open-unlinked and half-truncated files
        during mount (fs/reiserfs/super.c:finish_unfinished()). */
     if( ( inode -> i_nlink == 0 ) && 
-	! inode -> i_sb -> u.reiserfs_sb.s_is_unlinked_ok ) {
+	! REISERFS_SB(inode -> i_sb) -> s_is_unlinked_ok ) {
 	    reiserfs_warning( "vs-13075: reiserfs_read_inode2: "
 			      "dead inode read from disk %K. "
 			      "This is likely to be race with knfsd. Ignore\n", 
@@ -1515,7 +1515,7 @@
     else
 #if defined( USE_INODE_GENERATION_COUNTER )
       inode->i_generation = 
-	le32_to_cpu( sb -> u.reiserfs_sb.s_rs -> s_inode_generation );
+	le32_to_cpu( REISERFS_SB(sb) -> s_rs -> s_inode_generation );
 #else
       inode->i_generation = ++event;
 #endif
diff -urN linux-2.5.7/fs/reiserfs/namei.c linux/fs/reiserfs/namei.c
--- linux-2.5.7/fs/reiserfs/namei.c	Thu Mar  7 21:18:06 2002
+++ linux/fs/reiserfs/namei.c	Wed Mar 27 19:38:22 2002
@@ -183,7 +183,7 @@
     if (len == 2 && name[0] == '.' && name[1] == '.')
 	return DOT_DOT_OFFSET;
 
-    res = s->u.reiserfs_sb.s_hash_function (name, len);
+    res = REISERFS_SB(s)->s_hash_function (name, len);
 
     // take bits from 7-th to 30-th including both bounds
     res = GET_HASH_VALUE(res);
diff -urN linux-2.5.7/fs/reiserfs/prints.c linux/fs/reiserfs/prints.c
--- linux-2.5.7/fs/reiserfs/prints.c	Thu Mar  7 21:18:07 2002
+++ linux/fs/reiserfs/prints.c	Wed Mar 27 19:38:22 2002
@@ -592,7 +592,7 @@
 	     "MODE=%c, ITEM_POS=%d POS_IN_ITEM=%d\n" 
 	     "=====================================================================\n"
 	     "* h *    S    *    L    *    R    *   F   *   FL  *   FR  *  CFL  *  CFR  *\n",
-	     tb->tb_sb->u.reiserfs_sb.s_do_balance,
+	     REISERFS_SB(tb->tb_sb)->s_do_balance,
 	     tb->tb_mode, PATH_LAST_POSITION (tb->tb_path), tb->tb_path->pos_in_item);
   
     for (h = 0; h < sizeof(tb->insert_size) / sizeof (tb->insert_size[0]); h ++) {
@@ -717,9 +717,9 @@
   /*
   printk ("reiserfs_put_super: session statistics: balances %d, fix_nodes %d, \
 bmap with search %d, without %d, dir2ind %d, ind2dir %d\n",
-	  s->u.reiserfs_sb.s_do_balance, s->u.reiserfs_sb.s_fix_nodes,
-	  s->u.reiserfs_sb.s_bmaps, s->u.reiserfs_sb.s_bmaps_without_search,
-	  s->u.reiserfs_sb.s_direct2indirect, s->u.reiserfs_sb.s_indirect2direct);
+	  REISERFS_SB(s)->s_do_balance, REISERFS_SB(s)->s_fix_nodes,
+	  REISERFS_SB(s)->s_bmaps, REISERFS_SB(s)->s_bmaps_without_search,
+	  REISERFS_SB(s)->s_direct2indirect, REISERFS_SB(s)->s_indirect2direct);
   */
 
 }
diff -urN linux-2.5.7/fs/reiserfs/procfs.c linux/fs/reiserfs/procfs.c
--- linux-2.5.7/fs/reiserfs/procfs.c	Thu Mar  7 21:18:20 2002
+++ linux/fs/reiserfs/procfs.c	Wed Mar 27 19:38:22 2002
@@ -82,9 +82,9 @@
 	sb = procinfo_prologue( to_kdev_t((int)data) );
 	if( sb == NULL )
 		return -ENOENT;
-	if ( sb->u.reiserfs_sb.s_properties & (1 << REISERFS_3_6) ) {
+	if ( REISERFS_SB(sb)->s_properties & (1 << REISERFS_3_6) ) {
 		format = "3.6";
-	} else if ( sb->u.reiserfs_sb.s_properties & (1 << REISERFS_3_5) ) {
+	} else if ( REISERFS_SB(sb)->s_properties & (1 << REISERFS_3_5) ) {
 		format = "3.5";
 	} else {
 		format = "unknown";
@@ -140,7 +140,7 @@
 	sb = procinfo_prologue( to_kdev_t((int)data) );
 	if( sb == NULL )
 		return -ENOENT;
-	r = &sb->u.reiserfs_sb;
+	r = REISERFS_SB(sb);
 	len += sprintf( &buffer[ len ], 
 			"state: \t%s\n"
 			"mount options: \t%s%s%s%s%s%s%s%s%s%s%s%s\n"
@@ -220,7 +220,7 @@
 	sb = procinfo_prologue( to_kdev_t((int)data) );
 	if( sb == NULL )
 		return -ENOENT;
-	r = &sb->u.reiserfs_sb;
+	r = REISERFS_SB(sb);
 
 	len += sprintf( &buffer[ len ],
 			"level\t"
@@ -293,13 +293,13 @@
 			     int count, int *eof, void *data )
 {
 	struct super_block *sb;
-	struct reiserfs_sb_info *r = &sb->u.reiserfs_sb;
+	struct reiserfs_sb_info *r;
 	int len = 0;
     
 	sb = procinfo_prologue( to_kdev_t((int)data) );
 	if( sb == NULL )
 		return -ENOENT;
-	r = &sb->u.reiserfs_sb;
+	r = REISERFS_SB(sb);
 
 	len += sprintf( &buffer[ len ], "free_block: %lu\n"
 			"find_forward:"
@@ -340,7 +340,7 @@
 	sb = procinfo_prologue( to_kdev_t((int)data) );
 	if( sb == NULL )
 		return -ENOENT;
-	sb_info = &sb->u.reiserfs_sb;
+	sb_info = REISERFS_SB(sb);
 	rs = sb_info -> s_rs;
 	hash_code = DFL( s_hash_function_code );
 
@@ -397,7 +397,7 @@
 	sb = procinfo_prologue( to_kdev_t((int)data) );
 	if( sb == NULL )
 		return -ENOENT;
-	sb_info = &sb->u.reiserfs_sb;
+	sb_info = REISERFS_SB(sb);
 	rs = sb_info -> s_rs;
 	mapsize = le16_to_cpu( rs -> s_v1.s_oid_cursize );
 	total_used = 0;
@@ -449,7 +449,7 @@
 	sb = procinfo_prologue( to_kdev_t((int)data) );
 	if( sb == NULL )
 		return -ENOENT;
-	r = &sb->u.reiserfs_sb;
+	r = REISERFS_SB(sb);
 	rs = r -> s_rs;
 	jp = &rs->s_v1.s_journal;
 
@@ -557,9 +557,9 @@
 int reiserfs_proc_info_init( struct super_block *sb )
 {
 	spin_lock_init( & __PINFO( sb ).lock );
-	sb->u.reiserfs_sb.procdir = proc_mkdir(sb->s_id, proc_info_root);
-	if( sb->u.reiserfs_sb.procdir ) {
-		sb->u.reiserfs_sb.procdir -> owner = THIS_MODULE;
+	REISERFS_SB(sb)->procdir = proc_mkdir(sb->s_id, proc_info_root);
+	if( REISERFS_SB(sb)->procdir ) {
+		REISERFS_SB(sb)->procdir -> owner = THIS_MODULE;
 		return 0;
 	}
 	reiserfs_warning( "reiserfs: cannot create /proc/%s/%s\n",
@@ -575,7 +575,7 @@
 	spin_unlock( & __PINFO( sb ).lock );
 	if ( proc_info_root ) {
 		remove_proc_entry( sb->s_id, proc_info_root );
-		sb->u.reiserfs_sb.procdir = NULL;
+		REISERFS_SB(sb)->procdir = NULL;
 	}
 	return 0;
 }
@@ -587,14 +587,14 @@
 struct proc_dir_entry *reiserfs_proc_register( struct super_block *sb, 
 					       char *name, read_proc_t *func )
 {
-	return ( sb->u.reiserfs_sb.procdir ) ? create_proc_read_entry
-		( name, 0, sb->u.reiserfs_sb.procdir, func, 
+	return ( REISERFS_SB(sb)->procdir ) ? create_proc_read_entry
+		( name, 0, REISERFS_SB(sb)->procdir, func, 
 		  ( void * ) kdev_t_to_nr( sb -> s_dev ) ) : NULL;
 }
 
 void reiserfs_proc_unregister( struct super_block *sb, const char *name )
 {
-	remove_proc_entry( name, sb->u.reiserfs_sb.procdir );
+	remove_proc_entry( name, REISERFS_SB(sb)->procdir );
 }
 
 struct proc_dir_entry *reiserfs_proc_register_global( char *name, 
diff -urN linux-2.5.7/fs/reiserfs/stree.c linux/fs/reiserfs/stree.c
--- linux-2.5.7/fs/reiserfs/stree.c	Thu Mar  7 21:18:55 2002
+++ linux/fs/reiserfs/stree.c	Wed Mar 27 19:38:22 2002
@@ -1387,7 +1387,7 @@
        __u32 *inode_generation;
        
        inode_generation = 
-         &th -> t_super -> u.reiserfs_sb.s_rs -> s_inode_generation;
+         &REISERFS_SB(th -> t_super) -> s_rs -> s_inode_generation;
        *inode_generation = cpu_to_le32( le32_to_cpu( *inode_generation ) + 1 );
       }
 /* USE_INODE_GENERATION_COUNTER */
diff -urN linux-2.5.7/fs/reiserfs/super.c linux/fs/reiserfs/super.c
--- linux-2.5.7/fs/reiserfs/super.c	Mon Mar 18 16:14:16 2002
+++ linux/fs/reiserfs/super.c	Wed Mar 27 19:39:33 2002
@@ -153,7 +153,7 @@
     max_cpu_key.key_length = 3;
  
     done = 0;
-    s -> u.reiserfs_sb.s_is_unlinked_ok = 1;
+    REISERFS_SB(s)->s_is_unlinked_ok = 1;
     while (1) {
         retval = search_item (s, &max_cpu_key, &path);
         if (retval != ITEM_NOT_FOUND) {
@@ -239,7 +239,7 @@
         printk ("done\n");
         done ++;
     }
-    s -> u.reiserfs_sb.s_is_unlinked_ok = 0;
+    REISERFS_SB(s)->s_is_unlinked_ok = 0;
      
     pathrelse (&path);
     if (done)
@@ -378,7 +378,7 @@
   if (!(s->s_flags & MS_RDONLY)) {
     journal_begin(&th, s, 10) ;
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
-    set_sb_umount_state( SB_DISK_SUPER_BLOCK(s), s->u.reiserfs_sb.s_mount_state );
+    set_sb_umount_state( SB_DISK_SUPER_BLOCK(s), REISERFS_SB(s)->s_mount_state );
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
   }
 
@@ -396,9 +396,9 @@
 
   print_statistics (s);
 
-  if (s->u.reiserfs_sb.s_kmallocs != 0) {
+  if (REISERFS_SB(s)->s_kmallocs != 0) {
     reiserfs_warning ("vs-2004: reiserfs_put_super: allocated memory left %d\n",
-		      s->u.reiserfs_sb.s_kmallocs);
+		      REISERFS_SB(s)->s_kmallocs);
   }
 
   reiserfs_proc_unregister( s, "journal" );
@@ -409,6 +409,10 @@
   reiserfs_proc_unregister( s, "super" );
   reiserfs_proc_unregister( s, "version" );
   reiserfs_proc_info_done( s );
+
+  kfree(s->u.generic_sbp);
+  s->u.generic_sbp = NULL;
+
   return;
 }
 
@@ -612,30 +616,30 @@
   
   if (*flags & MS_RDONLY) {
     /* try to remount file system with read-only permissions */
-    if (sb_umount_state(rs) == REISERFS_VALID_FS || s->u.reiserfs_sb.s_mount_state != REISERFS_VALID_FS) {
+    if (sb_umount_state(rs) == REISERFS_VALID_FS || REISERFS_SB(s)->s_mount_state != REISERFS_VALID_FS) {
       return 0;
     }
 
     journal_begin(&th, s, 10) ;
     /* Mounting a rw partition read-only. */
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
-    set_sb_umount_state( rs, s->u.reiserfs_sb.s_mount_state );
+    set_sb_umount_state( rs, REISERFS_SB(s)->s_mount_state );
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     s->s_dirt = 0;
   } else {
-    s->u.reiserfs_sb.s_mount_state = sb_umount_state(rs) ;
+    REISERFS_SB(s)->s_mount_state = sb_umount_state(rs) ;
     s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
     journal_begin(&th, s, 10) ;
 
     /* Mount a partition which is read-only, read-write */
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
-    s->u.reiserfs_sb.s_mount_state = sb_umount_state(rs);
+    REISERFS_SB(s)->s_mount_state = sb_umount_state(rs);
     s->s_flags &= ~MS_RDONLY;
     set_sb_umount_state( rs, REISERFS_ERROR_FS );
     /* mark_buffer_dirty (SB_BUFFER_WITH_SB (s), 1); */
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     s->s_dirt = 0;
-    s->u.reiserfs_sb.s_mount_state = REISERFS_VALID_FS ;
+    REISERFS_SB(s)->s_mount_state = REISERFS_VALID_FS ;
   }
   /* this will force a full flush of all journal lists */
   SB_JOURNAL(s)->j_must_wait = 1 ;
@@ -1001,10 +1005,16 @@
     struct reiserfs_iget4_args args ;
     struct reiserfs_super_block * rs;
     char *jdev_name;
+    struct reiserfs_sb_info *sbi;
+
+    sbi = kmalloc(sizeof(struct reiserfs_sb_info), GFP_KERNEL);
+    if (!sbi)
+	return -ENOMEM;
+    s->u.generic_sbp = sbi;
+    memset (sbi, 0, sizeof (struct reiserfs_sb_info));
 
-    memset (&s->u.reiserfs_sb, 0, sizeof (struct reiserfs_sb_info));
     jdev_name = NULL;
-    if (parse_options ((char *) data, &(s->u.reiserfs_sb.s_mount_opt), &blocks, &jdev_name) == 0) {
+    if (parse_options ((char *) data, &(sbi->s_mount_opt), &blocks, &jdev_name) == 0) {
 	return -EINVAL;
     }
 
@@ -1024,8 +1034,8 @@
       printk("sh-2021: reiserfs_fill_super: can not find reiserfs on %s\n", s->s_id);
       goto error;    
     }
-    s->u.reiserfs_sb.s_mount_state = SB_REISERFS_STATE(s);
-    s->u.reiserfs_sb.s_mount_state = REISERFS_VALID_FS ;
+    sbi->s_mount_state = SB_REISERFS_STATE(s);
+    sbi->s_mount_state = REISERFS_VALID_FS ;
 
     if (old_format ? read_old_bitmaps(s) : read_bitmaps(s)) { 
 	printk ("reiserfs_fill_super: unable to read bitmap\n");
@@ -1071,8 +1081,8 @@
     }
 
     // define and initialize hash function
-    s->u.reiserfs_sb.s_hash_function = hash_function (s);
-    if (s->u.reiserfs_sb.s_hash_function == NULL) {
+    sbi->s_hash_function = hash_function (s);
+    if (sbi->s_hash_function == NULL) {
       dput(s->s_root) ;
       s->s_root = NULL ;
       goto error ;
@@ -1080,9 +1090,9 @@
 
     rs = SB_DISK_SUPER_BLOCK (s);
     if (is_reiserfs_3_5 (rs) || (is_reiserfs_jr (rs) && SB_VERSION (s) == REISERFS_VERSION_1))
-	set_bit(REISERFS_3_5, &(s->u.reiserfs_sb.s_properties));
+	set_bit(REISERFS_3_5, &(sbi->s_properties));
     else
-	set_bit(REISERFS_3_6, &(s->u.reiserfs_sb.s_properties));
+	set_bit(REISERFS_3_6, &(sbi->s_properties));
     
     if (!(s->s_flags & MS_RDONLY)) {
 
@@ -1107,8 +1117,8 @@
 	    
 	    set_sb_version(rs,REISERFS_VERSION_2);
 	    reiserfs_convert_objectid_map_v1(s) ;
-	    set_bit(REISERFS_3_6, &(s->u.reiserfs_sb.s_properties));
-	    clear_bit(REISERFS_3_5, &(s->u.reiserfs_sb.s_properties));
+	    set_bit(REISERFS_3_6, &(sbi->s_properties));
+	    clear_bit(REISERFS_3_5, &(sbi->s_properties));
 	  } else {
 	    reiserfs_warning("reiserfs: using 3.5.x disk format\n") ;
 	  }
@@ -1127,7 +1137,7 @@
 	}
     }
     // mark hash in super block: it could be unset. overwrite should be ok
-    set_sb_hash_function_code( rs, function2code(s->u.reiserfs_sb.s_hash_function ) );
+    set_sb_hash_function_code( rs, function2code(sbi->s_hash_function ) );
 
     reiserfs_proc_info_init( s );
     reiserfs_proc_register( s, "version", reiserfs_version_in_proc );
@@ -1137,7 +1147,7 @@
     reiserfs_proc_register( s, "on-disk-super", reiserfs_on_disk_super_in_proc );
     reiserfs_proc_register( s, "oidmap", reiserfs_oidmap_in_proc );
     reiserfs_proc_register( s, "journal", reiserfs_journal_in_proc );
-    init_waitqueue_head (&(s->u.reiserfs_sb.s_wait));
+    init_waitqueue_head (&(sbi->s_wait));
 
     return 0;
 
@@ -1156,6 +1166,9 @@
     if (SB_BUFFER_WITH_SB (s))
 	brelse(SB_BUFFER_WITH_SB (s));
 
+    kfree(sbi);
+    s->u.generic_sbp = NULL;
+
     return -EINVAL;
 }
 
diff -urN linux-2.5.7/fs/reiserfs/tail_conversion.c linux/fs/reiserfs/tail_conversion.c
--- linux-2.5.7/fs/reiserfs/tail_conversion.c	Thu Mar  7 21:18:33 2002
+++ linux/fs/reiserfs/tail_conversion.c	Wed Mar 27 19:38:22 2002
@@ -35,7 +35,7 @@
 				       tree. */
 
 
-    sb->u.reiserfs_sb.s_direct2indirect ++;
+    REISERFS_SB(sb)->s_direct2indirect ++;
 
     n_blk_size = sb->s_blocksize;
 
@@ -202,7 +202,7 @@
     loff_t pos, pos1; /* position of first byte of the tail */
     struct cpu_key key;
 
-    p_s_sb->u.reiserfs_sb.s_indirect2direct ++;
+    REISERFS_SB(p_s_sb)->s_indirect2direct ++;
 
     *p_c_mode = M_SKIP_BALANCING;
 
diff -urN linux-2.5.7/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7/include/linux/fs.h	Wed Mar 27 15:35:49 2002
+++ linux/include/linux/fs.h	Wed Mar 27 19:41:19 2002
@@ -651,7 +651,6 @@
 #include <linux/ufs_fs_sb.h>
 #include <linux/romfs_fs_sb.h>
 #include <linux/adfs_fs_sb.h>
-#include <linux/reiserfs_fs_sb.h>
 #include <linux/bfs_fs_sb.h>
 
 extern struct list_head super_blocks;
@@ -695,7 +694,6 @@
 		struct ufs_sb_info	ufs_sb;
 		struct romfs_sb_info	romfs_sb;
 		struct adfs_sb_info	adfs_sb;
-		struct reiserfs_sb_info	reiserfs_sb;
 		struct bfs_sb_info	bfs_sb;
 		void			*generic_sbp;
 	} u;
diff -urN linux-2.5.7/include/linux/reiserfs_fs.h linux/include/linux/reiserfs_fs.h
--- linux-2.5.7/include/linux/reiserfs_fs.h	Thu Mar  7 21:18:24 2002
+++ linux/include/linux/reiserfs_fs.h	Wed Mar 27 19:43:32 2002
@@ -21,6 +21,7 @@
 #include <linux/bitops.h>
 #include <linux/proc_fs.h>
 #include <linux/reiserfs_fs_i.h>
+#include <linux/reiserfs_fs_sb.h>
 #endif
 
 /*
@@ -96,7 +97,7 @@
 /***************************************************************************/
 
 /*
- * Structure of super block on disk, a version of which in RAM is often accessed as s->u.reiserfs_sb.s_rs
+ * Structure of super block on disk, a version of which in RAM is often accessed as REISERFS_SB(s)->s_rs
  * the version in RAM is part of a larger structure containing fields never written to disk.
  */
 #define UNSET_HASH 0 // read_super will guess about, what hash names
@@ -176,7 +177,7 @@
 
 
 // on-disk super block fields converted to cpu form
-#define SB_DISK_SUPER_BLOCK(s) ((s)->u.reiserfs_sb.s_rs)
+#define SB_DISK_SUPER_BLOCK(s) (REISERFS_SB(s)->s_rs)
 #define SB_V1_DISK_SUPER_BLOCK(s) (&(SB_DISK_SUPER_BLOCK(s)->s_v1))
 #define SB_BLOCKSIZE(s) \
         le32_to_cpu ((SB_V1_DISK_SUPER_BLOCK(s)->s_blocksize))
@@ -287,6 +288,12 @@
 {
 	return list_entry(inode, struct reiserfs_inode_info, vfs_inode);
 }
+
+static inline struct reiserfs_sb_info *REISERFS_SB(const struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
 /** this says about version of key of all items (but stat data) the
     object consists of */
 #define get_inode_item_key_version( inode )                                    \
@@ -1284,7 +1291,7 @@
 #define REISERFS_KERNEL_MEM		0	/* reiserfs kernel memory mode	*/
 #define REISERFS_USER_MEM		1	/* reiserfs user memory mode		*/
 
-#define fs_generation(s) ((s)->u.reiserfs_sb.s_generation_counter)
+#define fs_generation(s) (REISERFS_SB(s)->s_generation_counter)
 #define get_generation(s) atomic_read (&fs_generation(s))
 #define FILESYSTEM_CHANGED_TB(tb)  (get_generation((tb)->tb_sb) != (tb)->fs_gen)
 #define fs_changed(gen,s) (gen != get_generation (s))
@@ -1884,10 +1891,10 @@
 #define PROC_EXP( e )   e
 
 #define MAX( a, b ) ( ( ( a ) > ( b ) ) ? ( a ) : ( b ) )
-#define __PINFO( sb ) ( sb ) -> u.reiserfs_sb.s_proc_info_data
+#define __PINFO( sb ) REISERFS_SB(sb) -> s_proc_info_data
 #define PROC_INFO_MAX( sb, field, value )								\
     __PINFO( sb ).field =												\
-        MAX( ( sb ) -> u.reiserfs_sb.s_proc_info_data.field, value )
+        MAX( REISERFS_SB( sb ) -> s_proc_info_data.field, value )
 #define PROC_INFO_INC( sb, field ) ( ++ ( __PINFO( sb ).field ) )
 #define PROC_INFO_ADD( sb, field, val ) ( __PINFO( sb ).field += ( val ) )
 #define PROC_INFO_BH_STAT( sb, bh, level )							\
diff -urN linux-2.5.7/include/linux/reiserfs_fs_sb.h linux/include/linux/reiserfs_fs_sb.h
--- linux-2.5.7/include/linux/reiserfs_fs_sb.h	Wed Mar 27 15:35:49 2002
+++ linux/include/linux/reiserfs_fs_sb.h	Wed Mar 27 19:43:32 2002
@@ -412,20 +412,20 @@
 #define REISERFS_TEST3 13
 #define REISERFS_TEST4 14 
 
-#define reiserfs_r5_hash(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << FORCE_R5_HASH))
-#define reiserfs_rupasov_hash(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << FORCE_RUPASOV_HASH))
-#define reiserfs_tea_hash(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << FORCE_TEA_HASH))
-#define reiserfs_hash_detect(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << FORCE_HASH_DETECT))
-#define reiserfs_no_border(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NO_BORDER))
-#define reiserfs_no_unhashed_relocation(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NO_UNHASHED_RELOCATION))
-#define reiserfs_hashed_relocation(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_HASHED_RELOCATION))
-#define reiserfs_test4(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_TEST4))
-
-#define dont_have_tails(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << NOTAIL))
-#define replay_only(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REPLAYONLY))
-#define reiserfs_dont_log(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NOLOG))
-#define old_format_only(s) ((s)->u.reiserfs_sb.s_properties & (1 << REISERFS_3_5))
-#define convert_reiserfs(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_CONVERT))
+#define reiserfs_r5_hash(s) (REISERFS_SB(s)->s_mount_opt & (1 << FORCE_R5_HASH))
+#define reiserfs_rupasov_hash(s) (REISERFS_SB(s)->s_mount_opt & (1 << FORCE_RUPASOV_HASH))
+#define reiserfs_tea_hash(s) (REISERFS_SB(s)->s_mount_opt & (1 << FORCE_TEA_HASH))
+#define reiserfs_hash_detect(s) (REISERFS_SB(s)->s_mount_opt & (1 << FORCE_HASH_DETECT))
+#define reiserfs_no_border(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_NO_BORDER))
+#define reiserfs_no_unhashed_relocation(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_NO_UNHASHED_RELOCATION))
+#define reiserfs_hashed_relocation(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_HASHED_RELOCATION))
+#define reiserfs_test4(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_TEST4))
+
+#define dont_have_tails(s) (REISERFS_SB(s)->s_mount_opt & (1 << NOTAIL))
+#define replay_only(s) (REISERFS_SB(s)->s_mount_opt & (1 << REPLAYONLY))
+#define reiserfs_dont_log(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_NOLOG))
+#define old_format_only(s) (REISERFS_SB(s)->s_properties & (1 << REISERFS_3_5))
+#define convert_reiserfs(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_CONVERT))
 
 
 void reiserfs_file_buffer (struct buffer_head * bh, int list);
@@ -439,13 +439,13 @@
 #define SCHEDULE_OCCURRED       1
 
 
-#define SB_BUFFER_WITH_SB(s) ((s)->u.reiserfs_sb.s_sbh)
-#define SB_JOURNAL(s) ((s)->u.reiserfs_sb.s_journal)
+#define SB_BUFFER_WITH_SB(s) (REISERFS_SB(s)->s_sbh)
+#define SB_JOURNAL(s) (REISERFS_SB(s)->s_journal)
 #define SB_JOURNAL_1st_RESERVED_BLOCK(s) (SB_JOURNAL(s)->j_1st_reserved_block)
 #define SB_JOURNAL_LIST(s) (SB_JOURNAL(s)->j_journal_list)
 #define SB_JOURNAL_LIST_INDEX(s) (SB_JOURNAL(s)->j_journal_list_index) 
 #define SB_JOURNAL_LEN_FREE(s) (SB_JOURNAL(s)->j_journal_len_free) 
-#define SB_AP_BITMAP(s) ((s)->u.reiserfs_sb.s_ap_bitmap)
+#define SB_AP_BITMAP(s) (REISERFS_SB(s)->s_ap_bitmap)
 
 #define SB_DISK_JOURNAL_HEAD(s) (SB_JOURNAL(s)->j_header_bh->)
 

--------------070501030600010704020709--


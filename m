Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289372AbSBKODF>; Mon, 11 Feb 2002 09:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289551AbSBKOC6>; Mon, 11 Feb 2002 09:02:58 -0500
Received: from angband.namesys.com ([212.16.7.85]:9344 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289372AbSBKOCo>; Mon, 11 Feb 2002 09:02:44 -0500
Date: Mon, 11 Feb 2002 17:02:37 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.4 reiserfs 64bit and bigendian bugfixes
Message-ID: <20020211170237.A1524@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

   This patch solves known reiserfs 64bit issues. Also erroneous
   le64_to_cpu converted to correct cpu_to_le64.

Bye,
    Oleg

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="64bit_and_bigendian_fixes.diff"

diff -uNr linux-2.4.18-pre9.orig/fs/reiserfs/journal.c linux-2.4.18-pre9/fs/reiserfs/journal.c
--- linux-2.4.18-pre9.orig/fs/reiserfs/journal.c	Mon Feb 11 15:23:32 2002
+++ linux-2.4.18-pre9/fs/reiserfs/journal.c	Mon Feb 11 15:24:38 2002
@@ -793,7 +793,7 @@
   while(cn) {
     if (cn->blocknr != 0) {
       if (debug) {
-        printk("block %lu, bh is %d, state %d\n", cn->blocknr, cn->bh ? 1: 0, 
+        printk("block %lu, bh is %d, state %ld\n", cn->blocknr, cn->bh ? 1: 0, 
 	        cn->state) ;
       }
       fake_bh.b_blocknr = cn->blocknr ;
diff -uNr linux-2.4.18-pre9.orig/fs/reiserfs/procfs.c linux-2.4.18-pre9/fs/reiserfs/procfs.c
--- linux-2.4.18-pre9.orig/fs/reiserfs/procfs.c	Mon Feb 11 15:23:29 2002
+++ linux-2.4.18-pre9/fs/reiserfs/procfs.c	Mon Feb 11 15:24:38 2002
@@ -79,7 +79,7 @@
 	struct super_block *sb;
 	char *format;
     
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t ) ( long ) data );
 	if( sb == NULL )
 		return -ENOENT;
 	if ( sb->u.reiserfs_sb.s_properties & (1 << REISERFS_3_6) ) {
@@ -143,7 +143,7 @@
 	struct reiserfs_sb_info *r;
 	int len = 0;
     
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t ) ( long ) data );
 	if( sb == NULL )
 		return -ENOENT;
 	r = &sb->u.reiserfs_sb;
@@ -223,7 +223,7 @@
 	int len = 0;
 	int level;
 	
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t ) ( long ) data );
 	if( sb == NULL )
 		return -ENOENT;
 	r = &sb->u.reiserfs_sb;
@@ -302,7 +302,7 @@
 	struct reiserfs_sb_info *r = &sb->u.reiserfs_sb;
 	int len = 0;
     
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t ) ( long ) data );
 	if( sb == NULL )
 		return -ENOENT;
 	r = &sb->u.reiserfs_sb;
@@ -343,7 +343,7 @@
 	int hash_code;
 	int len = 0;
     
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t ) ( long ) data );
 	if( sb == NULL )
 		return -ENOENT;
 	sb_info = &sb->u.reiserfs_sb;
@@ -396,7 +396,7 @@
 	int len = 0;
 	int exact;
     
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t ) ( long ) data );
 	if( sb == NULL )
 		return -ENOENT;
 	sb_info = &sb->u.reiserfs_sb;
@@ -447,7 +447,7 @@
 	struct reiserfs_super_block *rs;
 	int len = 0;
     
-	sb = procinfo_prologue( ( kdev_t ) ( int ) data );
+	sb = procinfo_prologue( ( kdev_t ) ( long ) data );
 	if( sb == NULL )
 		return -ENOENT;
 	r = &sb->u.reiserfs_sb;
@@ -464,7 +464,7 @@
 			"s_journal_max_commit_age: \t%i\n"
 			"s_journal_max_trans_age: \t%i\n"
 			/* incore fields */
-			"j_state: \t%i\n"			
+			"j_state: \t%li\n"			
 			"j_trans_id: \t%lu\n"
 			"j_mount_id: \t%lu\n"
 			"j_start: \t%lu\n"
@@ -588,7 +588,7 @@
 {
 	return ( sb->u.reiserfs_sb.procdir ) ? create_proc_read_entry
 		( name, 0, sb->u.reiserfs_sb.procdir, func, 
-		  ( void * ) ( int ) sb -> s_dev ) : NULL;
+		  ( void * ) ( long ) sb -> s_dev ) : NULL;
 }
 
 void reiserfs_proc_unregister( struct super_block *sb, const char *name )
diff -uNr linux-2.4.18-pre9.orig/include/linux/reiserfs_fs.h linux-2.4.18-pre9/include/linux/reiserfs_fs.h
--- linux-2.4.18-pre9.orig/include/linux/reiserfs_fs.h	Mon Feb 11 15:23:29 2002
+++ linux-2.4.18-pre9/include/linux/reiserfs_fs.h	Mon Feb 11 15:53:07 2002
@@ -236,9 +236,9 @@
     __u64 linear;
 } __attribute__ ((__packed__)) offset_v2_esafe_overlay;
 
-static inline __u16 offset_v2_k_type( struct offset_v2 *v2 )
+static inline __u16 offset_v2_k_type( const struct offset_v2 *v2 )
 {
-    offset_v2_esafe_overlay tmp = *(offset_v2_esafe_overlay *)v2;
+    offset_v2_esafe_overlay tmp = *(const offset_v2_esafe_overlay *)v2;
     tmp.linear = le64_to_cpu( tmp.linear );
     return tmp.offset_v2.k_type;
 }
@@ -248,12 +248,12 @@
     offset_v2_esafe_overlay *tmp = (offset_v2_esafe_overlay *)v2;
     tmp->linear = le64_to_cpu(tmp->linear);
     tmp->offset_v2.k_type = type;
-    tmp->linear = le64_to_cpu(tmp->linear);
+    tmp->linear = cpu_to_le64(tmp->linear);
 }
  
-static inline loff_t offset_v2_k_offset( struct offset_v2 *v2 )
+static inline loff_t offset_v2_k_offset( const struct offset_v2 *v2 )
 {
-    offset_v2_esafe_overlay tmp = *(offset_v2_esafe_overlay *)v2;
+    offset_v2_esafe_overlay tmp = *(const offset_v2_esafe_overlay *)v2;
     tmp.linear = le64_to_cpu( tmp.linear );
     return tmp.offset_v2.k_offset;
 }
@@ -262,7 +262,7 @@
     offset_v2_esafe_overlay *tmp = (offset_v2_esafe_overlay *)v2;
     tmp->linear = le64_to_cpu(tmp->linear);
     tmp->offset_v2.k_offset = offset;
-    tmp->linear = le64_to_cpu(tmp->linear);
+    tmp->linear = cpu_to_le64(tmp->linear);
 }
 #else
 # define offset_v2_k_type(v2)           ((v2)->k_type)
diff -uNr linux-2.4.18-pre9.orig/include/linux/reiserfs_fs_sb.h linux-2.4.18-pre9/include/linux/reiserfs_fs_sb.h
--- linux-2.4.18-pre9.orig/include/linux/reiserfs_fs_sb.h	Mon Feb 11 15:23:32 2002
+++ linux-2.4.18-pre9/include/linux/reiserfs_fs_sb.h	Mon Feb 11 15:52:02 2002
@@ -201,7 +201,7 @@
   struct buffer_head *bh ;		 /* real buffer head */
   kdev_t dev ;				 /* dev of real buffer head */
   unsigned long blocknr ;		 /* block number of real buffer head, == 0 when buffer on disk */		 
-  int state ;
+  long state ;
   struct reiserfs_journal_list *jlist ;  /* journal list this cnode lives in */
   struct reiserfs_journal_cnode *next ;  /* next in transaction list */
   struct reiserfs_journal_cnode *prev ;  /* prev in transaction list */
@@ -264,7 +264,7 @@
   struct reiserfs_journal_cnode *j_last ; /* newest journal block */
   struct reiserfs_journal_cnode *j_first ; /*  oldest journal block.  start here for traverse */
 				
-  int j_state ;			
+  long j_state ;			
   unsigned long j_trans_id ;
   unsigned long j_mount_id ;
   unsigned long j_start ;             /* start of current waiting commit (index into j_ap_blocks) */

--4Ckj6UjgE2iN1+kY--

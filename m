Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288972AbSAKPh5>; Fri, 11 Jan 2002 10:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289990AbSAKPhs>; Fri, 11 Jan 2002 10:37:48 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:57865 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288972AbSAKPhm>; Fri, 11 Jan 2002 10:37:42 -0500
Date: Fri, 11 Jan 2002 18:37:41 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 64 bit cleanness for reiserfs for 2.4
Message-ID: <20020111183741.A20729@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    These 2 patches fixes 64 bit cleanness issues in reiserfs code. 
    1st patch is famous bitops on int integer type fix (we got a report there were more bitops on ints
    from "Dale Farnsworth" <Dale.Farnsworth@mvista.com>,
    so I performed an audit and here is the patch. Without this patch bad things should happen on 64 bit arches.

    2nd patch is to fix warnings (and possibly not harmless ones) in fs/reiserfs/procfs.c when compiled on
    64 bit architecture (I tested it on alpha). May be someone can come up with better solution, so I separated
    it as different patch.

    Consider these 2 as a bugfixes and please apply.

Bye,
    Oleg

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="64bit_bitops_fix-1.diff"

--- linux/include/linux/reiserfs_fs_sb.h.orig	Fri Jan 11 11:04:19 2002
+++ linux/include/linux/reiserfs_fs_sb.h	Fri Jan 11 11:07:17 2002
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
--- linux/fs/reiserfs.old/procfs.c	Fri Jan 11 11:04:12 2002
+++ linux/fs/reiserfs/procfs.c	Fri Jan 11 11:04:28 2002
@@ -464,7 +464,7 @@
 			"s_journal_max_commit_age: \t%i\n"
 			"s_journal_max_trans_age: \t%i\n"
 			/* incore fields */
-			"j_state: \t%i\n"			
+			"j_state: \t%li\n"			
 			"j_trans_id: \t%lu\n"
 			"j_mount_id: \t%lu\n"
 			"j_start: \t%lu\n"
--- linux/fs/reiserfs/journal.c.orig	Fri Jan 11 11:13:44 2002
+++ linux/fs/reiserfs/journal.c	Fri Jan 11 11:13:57 2002
@@ -793,7 +793,7 @@
   while(cn) {
     if (cn->blocknr != 0) {
       if (debug) {
-        printk("block %lu, bh is %d, state %d\n", cn->blocknr, cn->bh ? 1: 0, 
+        printk("block %lu, bh is %d, state %ld\n", cn->blocknr, cn->bh ? 1: 0, 
 	        cn->state) ;
       }
       fake_bh.b_blocknr = cn->blocknr ;

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="64bit_kdevt_procfs_fix.diff"

--- linux/fs/reiserfs/procfs.c.orig	Fri Jan 11 13:34:21 2002
+++ linux/fs/reiserfs/procfs.c	Fri Jan 11 13:38:53 2002
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
@@ -588,7 +588,7 @@
 {
 	return ( sb->u.reiserfs_sb.procdir ) ? create_proc_read_entry
 		( name, 0, sb->u.reiserfs_sb.procdir, func, 
-		  ( void * ) ( int ) sb -> s_dev ) : NULL;
+		  ( void * ) ( long ) sb -> s_dev ) : NULL;
 }
 
 void reiserfs_proc_unregister( struct super_block *sb, const char *name )

--envbJBWh7q8WU6mo--

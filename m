Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292941AbSCMKCp>; Wed, 13 Mar 2002 05:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292942AbSCMKCh>; Wed, 13 Mar 2002 05:02:37 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:33034 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S292941AbSCMKC2>; Wed, 13 Mar 2002 05:02:28 -0500
Date: Wed, 13 Mar 2002 13:02:22 +0300
Message-Id: <200203131002.g2DA2Mm19938@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: PROBLEM: Kernel Panic on 2.5.6 and 2.5.7-pre1 boot [PATCH] and discussion of Linux testing procedures
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At Namesys, every change to reiserfs is required to be first tested by
the author, and then tested by at least one additional person.  For
these tests we have a gigantic suite of tests that run for hours.
Beta test users (all 2.5 users) should expect things to break and
be unreliable.  They should also expect that nothing a
regression test can find should ever hit kernel.org.  They should
never have to spend their valuable time finding bugs that a computer
can find for them.

I would encourage requiring that every patch sent to Linus have
two signatures on it, one indicating that the author has tested it
(this requires rebooting the computer with the new kernel in the
case of the patch that prompted this email), and another indicating what
second person has tested it.

For reiserfs I personally try to make sure that one of the
signatures is from someone who knows that sometimes the usual
regression tests won't hit the new code, and has been observed
to understand that he is expected to write whatever
code is required to test it properly in that case.

I realize that I am engaging in a bit of cultural imperialism here,
and that many members of the Linux community find testing before
release an inconvenience.  In fact, the person responsible
for this breakage has been personally responsible
for almost all of the "so bad no one should use it" breakage incidents
that reiserfs has experienced since it was added to the kernel, and
nothing said privately or publicly seems to be enough to get him
to even try copying a file into ReiserFS between making and releasing
his improvements.  In my not at all objective view he is pissing all
over our painstaking efforts at quality control.

Despite this, I would like to encourage that person to continue making
improvements to ReiserFS.

So, let me therefor confine myself to asking that if persons
modify ReiserFS, that the changes be first sent to the maintainer
before being either sent or accepted into the mainstream kernel.
We will indeed ensure that they are tested before release if we
are allowed a chance to do so.

Todd, a patch is attached that will get you working again.

This patch will be sent to Linus a little bit later with
a bunch of other patches.

Hans

In response to:
****************************************************
From:	"Todd E. Johnson" <tejohnson@yahoo.com>
Subject: PROBLEM: Kernel Panic on 2.5.6 and 2.5.7-pre1 boot

Hello,

Information as follows:

[1.] One line summary of the problem:  

Kernel Panic on 2.5.6 and 2.5.7-pre1 boot

[2.] Full description of the problem/report:

After a simple build of 2.5.6, and/or 2.5.7-pre1, when I reboot my
machine, I am greeted by
a kernel panic moments after the IDE controller is recognized.

[most of email deleted...]

***************************************************************************


--- linux-2.5.6.original/fs/reiserfs/journal.c	Tue Mar 12 15:25:27 2002
+++ linux-2.5.6/fs/reiserfs/journal.c	Wed Mar 13 11:01:37 2002
@@ -98,21 +98,6 @@
 static int release_journal_dev( struct super_block *super,
 				struct reiserfs_journal *journal );
 
-static inline struct buffer_head *journ_get_hash_table(struct super_block *s, int block)
-{
-	return __get_hash_table(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize);
-}
- 
-static inline struct buffer_head *journ_getblk(struct super_block *s, int block)
-{
-	return __getblk(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize);
-}
-
-static inline struct buffer_head *journ_bread(struct super_block *s, int block)
-{
-	return __bread(SB_JOURNAL(s)->j_dev_bd, block, s->s_blocksize);
-}
-
 static void init_journal_hash(struct super_block *p_s_sb) {
   memset(SB_JOURNAL(p_s_sb)->j_hash_table, 0, JOURNAL_HASH_SIZE * sizeof(struct reiserfs_journal_cnode *)) ;
 }
@@ -705,7 +690,7 @@
   count = 0 ;
   for (i = 0 ; atomic_read(&(jl->j_commit_left)) > 1 && i < (jl->j_len + 1) ; i++) {  /* everything but commit_bh */
     bn = SB_ONDISK_JOURNAL_1st_BLOCK(s) + (jl->j_start+i) %  SB_ONDISK_JOURNAL_SIZE(s);
-    tbh = journ_get_hash_table(s, bn) ;
+    tbh = get_hash_table(SB_JOURNAL_DEV(s), bn, s->s_blocksize) ;
 
 /* kill this sanity check */
 if (count > (orig_commit_left + 2)) {
@@ -734,7 +719,7 @@
     for (i = 0 ; atomic_read(&(jl->j_commit_left)) > 1 && 
                  i < (jl->j_len + 1) ; i++) {  /* everything but commit_bh */
       bn = SB_ONDISK_JOURNAL_1st_BLOCK(s) + (jl->j_start + i) % SB_ONDISK_JOURNAL_SIZE(s) ;
-      tbh = journ_get_hash_table(s, bn) ;
+      tbh = get_hash_table(SB_JOURNAL_DEV(s), bn, s->s_blocksize) ;
 
       wait_on_buffer(tbh) ;
       if (!buffer_uptodate(tbh)) {
@@ -1425,8 +1410,9 @@
     offset = d_bh->b_blocknr - SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) ;
 
     /* ok, we have a journal description block, lets see if the transaction was valid */
-    c_bh = journ_bread(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +
-		 ((offset + le32_to_cpu(desc->j_len) + 1) % SB_ONDISK_JOURNAL_SIZE(p_s_sb))) ;
+    c_bh = bread(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +
+		 ((offset + le32_to_cpu(desc->j_len) + 1) % SB_ONDISK_JOURNAL_SIZE(p_s_sb)), 
+		 p_s_sb->s_blocksize) ;
     if (!c_bh)
       return 0 ;
     commit = (struct reiserfs_journal_commit *)c_bh->b_data ;
@@ -1480,7 +1466,7 @@
   unsigned long trans_offset ;
   int i;
 
-  d_bh = journ_bread(p_s_sb, cur_dblock) ;
+  d_bh = bread(SB_JOURNAL_DEV(p_s_sb), cur_dblock, p_s_sb->s_blocksize) ;
   if (!d_bh)
     return 1 ;
   desc = (struct reiserfs_journal_desc *)d_bh->b_data ;
@@ -1504,9 +1490,9 @@
     brelse(d_bh) ;
     return 1 ;
   }
-  c_bh = journ_bread(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +
+  c_bh = bread(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) +
 		((trans_offset + le32_to_cpu(desc->j_len) + 1) % 
-		 SB_ONDISK_JOURNAL_SIZE(p_s_sb))) ;
+		 SB_ONDISK_JOURNAL_SIZE(p_s_sb)), p_s_sb->s_blocksize) ;
   if (!c_bh) {
     brelse(d_bh) ;
     return 1 ;
@@ -1535,7 +1521,7 @@
   }
   /* get all the buffer heads */
   for(i = 0 ; i < le32_to_cpu(desc->j_len) ; i++) {
-    log_blocks[i] =  journ_getblk(p_s_sb,  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + (trans_offset + 1 + i) % SB_ONDISK_JOURNAL_SIZE(p_s_sb));
+    log_blocks[i] =  getblk(SB_JOURNAL_DEV(p_s_sb),  SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + (trans_offset + 1 + i) % SB_ONDISK_JOURNAL_SIZE(p_s_sb), p_s_sb->s_blocksize);
     if (i < JOURNAL_TRANS_HALF) {
       real_blocks[i] = sb_getblk(p_s_sb, le32_to_cpu(desc->j_realblock[i])) ;
     } else {
@@ -1675,9 +1661,10 @@
   ** is the first unflushed, and if that transaction is not valid, 
   ** replay is done
   */
-  SB_JOURNAL(p_s_sb)->j_header_bh = journ_bread(p_s_sb,
+  SB_JOURNAL(p_s_sb)->j_header_bh = bread (SB_JOURNAL_DEV(p_s_sb),
 					   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
-					   SB_ONDISK_JOURNAL_SIZE(p_s_sb));
+					   SB_ONDISK_JOURNAL_SIZE(p_s_sb),
+					   p_s_sb->s_blocksize) ;
   if (!SB_JOURNAL(p_s_sb)->j_header_bh) {
     return 1 ;
   }
@@ -1698,7 +1685,7 @@
     ** there is nothing more we can do, and it makes no sense to read 
     ** through the whole log.
     */
-    d_bh = journ_bread(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + le32_to_cpu(jh->j_first_unflushed_offset)) ;
+    d_bh = bread(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + le32_to_cpu(jh->j_first_unflushed_offset), p_s_sb->s_blocksize) ;
     ret = journal_transaction_is_valid(p_s_sb, d_bh, NULL, NULL) ;
     if (!ret) {
       continue_replay = 0 ;
@@ -2049,8 +2036,9 @@
      rs = SB_DISK_SUPER_BLOCK(p_s_sb);
      
      /* read journal header */
-     bhjh = journ_bread(p_s_sb,
-		   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb));
+     bhjh = bread (SB_JOURNAL_DEV(p_s_sb),
+		   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb),
+		   SB_BLOCKSIZE(p_s_sb));
      if (!bhjh) {
 	 printk("sh-459: unable to read  journal header\n") ;
 	 return 1 ;
@@ -2988,7 +2976,7 @@
   
   rs = SB_DISK_SUPER_BLOCK(p_s_sb) ;
   /* setup description block */
-  d_bh = journ_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start) ; 
+  d_bh = getblk(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start, p_s_sb->s_blocksize) ; 
   mark_buffer_uptodate(d_bh, 1) ;
   desc = (struct reiserfs_journal_desc *)(d_bh)->b_data ;
   memset(desc, 0, sizeof(struct reiserfs_journal_desc)) ;
@@ -2996,8 +2984,9 @@
   desc->j_trans_id = cpu_to_le32(SB_JOURNAL(p_s_sb)->j_trans_id) ;
 
   /* setup commit block.  Don't write (keep it clean too) this one until after everyone else is written */
-  c_bh =  journ_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
-		 ((SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL(p_s_sb)->j_len + 1) % SB_ONDISK_JOURNAL_SIZE(p_s_sb))) ;
+  c_bh =  getblk(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
+		 ((SB_JOURNAL(p_s_sb)->j_start + SB_JOURNAL(p_s_sb)->j_len + 1) % SB_ONDISK_JOURNAL_SIZE(p_s_sb)), 
+		 p_s_sb->s_blocksize) ;
   commit = (struct reiserfs_journal_commit *)c_bh->b_data ;
   memset(commit, 0, sizeof(struct reiserfs_journal_commit)) ;
   commit->j_trans_id = cpu_to_le32(SB_JOURNAL(p_s_sb)->j_trans_id) ;
@@ -3087,8 +3076,9 @@
     /* copy all the real blocks into log area.  dirty log blocks */
     if (test_bit(BH_JDirty, &cn->bh->b_state)) {
       struct buffer_head *tmp_bh ;
-      tmp_bh =  journ_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
-		       ((cur_write_start + jindex) % SB_ONDISK_JOURNAL_SIZE(p_s_sb))) ;
+      tmp_bh =  getblk(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
+		       ((cur_write_start + jindex) % SB_ONDISK_JOURNAL_SIZE(p_s_sb)), 
+		       p_s_sb->s_blocksize) ;
       mark_buffer_uptodate(tmp_bh, 1) ;
       memcpy(tmp_bh->b_data, cn->bh->b_data, cn->bh->b_size) ;  
       jindex++ ;



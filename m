Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310693AbSCMPnc>; Wed, 13 Mar 2002 10:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310686AbSCMPnY>; Wed, 13 Mar 2002 10:43:24 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:1709 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S310676AbSCMPnK>; Wed, 13 Mar 2002 10:43:10 -0500
Message-Id: <200203131455.HAA15251@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Sebastian Droege <sebastian.droege@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.7-pre1] Reiserfs mounting oops patch
Date: Wed, 13 Mar 2002 08:40:48 -0700
X-Mailer: KMail [version 1.3.1]
Cc: torvalds@transmeta.com
In-Reply-To: <20020313155056.3918d052.sebastian.droege@gmx.de>
In-Reply-To: <20020313155056.3918d052.sebastian.droege@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 March 2002 07:50 am, Sebastian Droege wrote:
> Hi,
> here is a patch somebody has posted some time ago (Oleg Drokin I think),
> but it isn't included in 2.5.7-pre1 and some people might miss it first
> (like me ;) ) I think the patch is really important, because you can't
> mount a reiserfs partition without it It fixes an oops when mounting a
> reiserfs partition and it works for me
>
[other patch snipped]

Earlier today, Hans posted another patch, which I applied and am testing now.
So far, so good.  It boots anyway, and I can build kernels using 2.5.7-pre1
with ReiserFS and this patch from Hans.  With 2.5.6-vanilla, I got the same
kernel panic as others. Enjoy.

Steven
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


-

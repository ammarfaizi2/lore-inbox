Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313504AbSDET2E>; Fri, 5 Apr 2002 14:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313503AbSDET1z>; Fri, 5 Apr 2002 14:27:55 -0500
Received: from backtop.namesys.com ([212.16.7.71]:26753 "EHLO
	bitshadow.namesys.com") by vger.kernel.org with ESMTP
	id <S313502AbSDET1p>; Fri, 5 Apr 2002 14:27:45 -0500
Date: Sat, 6 Apr 2002 00:25:11 +0400
Message-Id: <200204052025.g35KPB502865@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: ReiserFS Bug Fixes 2 of 6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changeset is to fix reiserfs problems that arose after applying one of
Al Viro's cleanup. This changeset simply removes offending part.

You can use bk receive to get it.

diffstat:
 journal.c |   56 +++++++++++++++++++++++---------------------------------
 1 files changed, 23 insertions(+), 33 deletions(-)

patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.586   -> 1.587  
#	fs/reiserfs/journal.c	1.30    -> 1.31   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/05	green@angband.namesys.com	1.587
# journal.c:
#   Al Viro's cleanup broke reiserfs in 2.5.6-pre3, revert the change.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Fri Apr  5 14:13:49 2002
+++ b/fs/reiserfs/journal.c	Fri Apr  5 14:13:49 2002
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
@@ -2045,8 +2032,9 @@
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
@@ -2984,7 +2972,7 @@
   
   rs = SB_DISK_SUPER_BLOCK(p_s_sb) ;
   /* setup description block */
-  d_bh = journ_getblk(p_s_sb, SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start) ; 
+  d_bh = getblk(SB_JOURNAL_DEV(p_s_sb), SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_JOURNAL(p_s_sb)->j_start, p_s_sb->s_blocksize) ; 
   mark_buffer_uptodate(d_bh, 1) ;
   desc = (struct reiserfs_journal_desc *)(d_bh)->b_data ;
   memset(desc, 0, sizeof(struct reiserfs_journal_desc)) ;
@@ -2992,8 +2980,9 @@
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
@@ -3083,8 +3072,9 @@
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


BK changeset:

This BitKeeper patch contains the following changesets:
1.587
## Wrapped with gzip_uu ##


begin 664 bkpatch2227
M'XL(`#RWK3P``[56:V^;2!3][/D55ZI6=92`9QB>KASEJ=ULHB9*E'[8JD(\
MQ@$;@\4,2;ORC]\9L-DT@MB[<K&M*^!R..?<,R-_@$?.RO'@J60L1Q_@CX*+
M\2#(G\(@C_4\6##^@^M1L9#W[HM"WALEQ8*-ZOY1./=?BG(^*EDJ4:B6I7GU
M73-T"\GVNT!$"3RSDH\'1*?M%?%CR<:#^\O?'V].[Q&:3.`\D2]D#TS`9()$
M43X'6<Q/`I%D1:Z+,LCY@HE`L5BUK2L#8T-^+.)0;-DK8F/3644D)B0P"8NQ
M8;JVB6J>)QUZWB*9V,*>B;&]PH[C>N@"B&ZY#F!CA,T1MH#0L4G&E!QB<XPQ
M]`+#(0$-HS/8KY!S%,&LJ,H\R/1H+$\`3C/XDI;%1PY1QH*\6D)8%G,&S32F
M'-(<Y"QT6UN6C![)ZW(8`D3"(*K?KJ-K<#W/0G?_C@!I__%`"`<8'<-2#;=;
MZY2/-IQ&K897NBU,C16EU/%6D>>X4QNS"$>!$UI&O\_OH3;#),18F2Z5^E3(
M.MM5X'X-<10'SVQVPBO.])B]3Y82S_*PM;()=JPZ>92\#1XQM@?/H*!1^DNB
MMY>L-<.X!:U\J;\R/'?=<_D?*;P@F`"1]CG8!8*NFB*7"8@P@0D\,>$G`4]\
M$809&SZ<^7_>/MY_/KWQ+RZ_#/G!$83Y$7#MF/MA5D1SGO[-#N"3Q*-.C5<7
M@#T@$M-PP4!7LGI`:\S(KR'#D@7Q6Z2ESWT>2CAY_?;SQ=7#=7N;<.&?W=R>
M7V^:X!`-!C`<%M,IE_OI(62,&KXH_&A9#6/&(^UXYF<LEXU`#N"W#LR'J[\N
M-W#RI0JO.>L2XE+ES;H"Q+O(B*K2CVN@HWYD"]>NK^M>#5+@WAI<52EPJPO]
M/*G;0-%-W++B:=WT-?TF*:N<A-F\E_1NK&%8+V*_'2R1OW3[!+NI*^:VTS!O
M:DUC#;!Y5F4ED7ZS\I7YT"=$0;JX@935D+[*`[KT_42P[>OUV%$K6\(V57F\
M4\YV\_7U`IDE2O(T+65?E4^SBB<L7EO^3@CD'EZO9UDWZQG"9+:#93W^=/'<
M[F(#53_W4WH50\^ME].ZM@9NB>;.S#J"PT50BC[/0%'RK-HTS[-KT]8K?#^<
MFEWP'6:]O.7FN)>]D6+75OID=3:A`+%8[EME<PR':E=]*5/!6GVS-(_9]YV%
=-$>/G/;?>Y0P>;5:3#PSM!W;H.@?"U[I6D,,````
`
end

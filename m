Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313299AbSDETbY>; Fri, 5 Apr 2002 14:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313309AbSDETbQ>; Fri, 5 Apr 2002 14:31:16 -0500
Received: from backtop.namesys.com ([212.16.7.71]:27777 "EHLO
	bitshadow.namesys.com") by vger.kernel.org with ESMTP
	id <S313299AbSDETbC>; Fri, 5 Apr 2002 14:31:02 -0500
Date: Sat, 6 Apr 2002 00:28:28 +0400
Message-Id: <200204052028.g35KSS602873@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: ReiserFS Bug Fixes 4 of 6 (Please apply all 6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changeset is to fix reiserfs journal problems during fs mounting.

You can get it by piping this message through bk receive

Diffstat:
 journal.c |   29 +++++++++++++----------------
 1 files changed, 13 insertions(+), 16 deletions(-)

Patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.588   -> 1.589  
#	fs/reiserfs/journal.c	1.31    -> 1.34   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/05	green@angband.namesys.com	1.589
# journal.c:
#   Remove confusing warning about journal replay on readonly FS
#   Fixed journal replay bug where old code would replay transactions with
#   mount_id != mount_id recorded in journal header.
#   (by Chris Mason)
#   Release journal device in case we have encountered some errors reading
#   journal.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Fri Apr  5 14:20:51 2002
+++ b/fs/reiserfs/journal.c	Fri Apr  5 14:20:51 2002
@@ -1637,11 +1637,9 @@
 }
 static int journal_read(struct super_block *p_s_sb) {
   struct reiserfs_journal_desc *desc ;
-  unsigned long last_flush_trans_id = 0 ;
   unsigned long oldest_trans_id = 0;
   unsigned long oldest_invalid_trans_id = 0 ;
   time_t start ;
-  unsigned long last_flush_start = 0;
   unsigned long oldest_start = 0;
   unsigned long cur_dblock = 0 ;
   unsigned long newest_mount_id = 9 ;
@@ -1672,13 +1670,14 @@
   if (le32_to_cpu(jh->j_first_unflushed_offset) >= 0 && 
       le32_to_cpu(jh->j_first_unflushed_offset) < SB_ONDISK_JOURNAL_SIZE(p_s_sb) && 
       le32_to_cpu(jh->j_last_flush_trans_id) > 0) {
-    last_flush_start = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
+    oldest_start = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
                        le32_to_cpu(jh->j_first_unflushed_offset) ;
-    last_flush_trans_id = le32_to_cpu(jh->j_last_flush_trans_id) ;
+    oldest_trans_id = le32_to_cpu(jh->j_last_flush_trans_id) + 1;
+    newest_mount_id = le32_to_cpu(jh->j_mount_id);
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1153: found in "
                    "header: first_unflushed_offset %d, last_flushed_trans_id "
 		   "%lu\n", le32_to_cpu(jh->j_first_unflushed_offset), 
-		   last_flush_trans_id) ;
+		   le32_to_cpu(jh->j_last_flush_trans_id)) ;
     valid_journal_header = 1 ;
 
     /* now, we try to read the first unflushed offset.  If it is not valid, 
@@ -1691,15 +1690,13 @@
       continue_replay = 0 ;
     }
     brelse(d_bh) ;
+    goto start_log_replay;
   }
 
   if (continue_replay && is_read_only(p_s_sb->s_dev)) {
     printk("clm-2076: device is readonly, unable to replay log\n") ;
     return -1 ;
   }
-  if (continue_replay && (p_s_sb->s_flags & MS_RDONLY)) {
-    printk("Warning, log replay starting on readonly filesystem\n") ;    
-  }
 
   /* ok, there are transactions that need to be replayed.  start with the first log block, find
   ** all the valid transactions, and pick out the oldest.
@@ -1733,17 +1730,13 @@
 	              "newest_mount_id to %d\n", le32_to_cpu(desc->j_mount_id));
       }
       cur_dblock += le32_to_cpu(desc->j_len) + 2 ;
-    } 
-    else {
+    } else {
       cur_dblock++ ;
     }
     brelse(d_bh) ;
   }
-  /* step three, starting at the oldest transaction, replay */
-  if (last_flush_start > 0) {
-    oldest_start = last_flush_start ;
-    oldest_trans_id = last_flush_trans_id + 1 ;
-  } 
+
+start_log_replay:
   cur_dblock = oldest_start ;
   if (oldest_trans_id)  {
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1206: Starting replay "
@@ -2037,6 +2030,7 @@
 		   SB_BLOCKSIZE(p_s_sb));
      if (!bhjh) {
 	 printk("sh-459: unable to read  journal header\n") ;
+	 release_journal_dev(p_s_sb, journal);
 	 return 1 ;
      }
      jh = (struct reiserfs_journal_header *)(bhjh->b_data);
@@ -2053,7 +2047,8 @@
 		jh->jh_journal.jp_journal_magic, jname,
 		sb_jp_journal_magic(rs), fname);
 	 brelse (bhjh);
-    return 1 ;
+	 release_journal_dev(p_s_sb, journal);
+	 return 1 ;
   }
      
   SB_JOURNAL_TRANS_MAX(p_s_sb)      = le32_to_cpu (jh->jh_journal.jp_journal_trans_max);
@@ -2153,11 +2148,13 @@
   SB_JOURNAL_LIST(p_s_sb)[0].j_list_bitmap = get_list_bitmap(p_s_sb, SB_JOURNAL_LIST(p_s_sb)) ;
   if (!(SB_JOURNAL_LIST(p_s_sb)[0].j_list_bitmap)) {
     reiserfs_warning("journal-2005, get_list_bitmap failed for journal list 0\n") ;
+    release_journal_dev(p_s_sb, journal);
     return 1 ;
   }
   if (journal_read(p_s_sb) < 0) {
     reiserfs_warning("Replay Failure, unable to mount\n") ;
     free_journal_ram(p_s_sb) ;
+    release_journal_dev(p_s_sb, journal);
     return 1 ;
   }
   SB_JOURNAL_LIST_INDEX(p_s_sb) = 0 ; /* once the read is done, we can set this


BK changeset:

This BitKeeper patch contains the following changesets:
1.589
## Wrapped with gzip_uu ##


begin 664 bkpatch2342
M'XL(``&YK3P``[5647/:.!!^1K]B;_J23`Z0+,LVSM!IDUSO*+DF0R9O-^,1
MMH))C,5(=BAS[G\_21"2YFA+FP#,2+9VOUWM?I_0&[C60L6MB1*B1&_@+ZFK
MN,7+R9B76:?D,Z&7NI/*F5D;26G6NKF<B:ZS[X[ODH54=UTEI@:%MHMI67]N
M>QV&C/DEK](<[H72<8MTZ.9-M9R+N#7ZX\_K\_<CA/I].,U-0'$E*NCW4275
M/2\R_8Y7>2'+3J5XJ6>BXC:+9F/:>!A[YLM(2#$+&A)@/VQ2DA'"?2(R[/E1
MX".7Y[LM^WF.Y&.&>PPSKR&$ACXZ`])A40^PU\5^%S,@-&9^3,(C[,<8PS>!
MX8A`&Z,3>-V-G*(4;F6M2EYTTM@\`(S$3-X+2&5Y4^MI.8$%5Z4=^5C6U8,U
M*#$O^!)D:68\DV6QA`]7#N##]+/(GMN-:P.4"R5`%ID!SP0L9&VFZW6W#9Y6
M4UEJ6$RKW$'-9%U6R32#W_J/<R52J3(38EINHN0F!Z$ZSNE@O#2]5U,-?W,M
MR\/UK@K!M=@X9.)^F@H+D=K7"P$Y-[L696K#F#PST(:1()222KL]FAHXJ(=Z
MH2'8ID;H\I%JJ/V3'X0PQ^@MS"V)M_?T1J^58":;7CWI+\/4:RBE8:])>V%T
M$V"1XI2'8^9]FT_?0UV1EOI10R/F42>FK>966/M)_#L*^U'B/B%>XT>TQYS:
MJ/>UV+S8BWXL-@9M\NIB2U^/A4\X&%#"(G0!;;5P/\.IR^WM^@5R#CQ,>T!0
MR\1VJ2=KM,2D?C!/=*+'OS]D<WB,SDP1`F,_<*.WLY^UJ\P#$#@VSH299B&C
MM1W=C4>`?\KC!01CGA<UJZH[@M'G!&,[$"PR!//VP+!7.WQ_X>C]W\$[!+\7
MAF1?Y#PC@6^[;D=_-8:6-X/U:-E@-BQTE>B**W,/@*N3Y.+3V>!JF'R\N!Y]
M>G^>$+-Z<GYQ.ER3Y!".P"&%:Z30T/@)DJN5K44?"D&]I))).J\/;O/VV]ND
MX,;BIJAUOK&S>.38(91B81$VU=R&\+!HM42"B*R2<&.K93!VBWEH542"'EU7
M82(K":X&22$GR:KM-D)(K4H'9@S7IE]`%.8H^M<N^AXPN^A;HW_0<X#X92IB
M4;.BAU.1_[6*:.SOH"(,;;J7.]&++D%#6/UO[HWVH:D*?;P,I[E([W0]Z[-4
.X(`R@?X#O)#I`8`+````
`
end


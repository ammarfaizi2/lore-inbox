Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292292AbSBPACR>; Fri, 15 Feb 2002 19:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292293AbSBPACM>; Fri, 15 Feb 2002 19:02:12 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:33263 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292292AbSBPAB7>;
	Fri, 15 Feb 2002 19:01:59 -0500
Date: Fri, 15 Feb 2002 17:01:15 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Dave Jones <davej@suse.de>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix ext2/ext3 revision level checks
Message-ID: <20020215170115.N14054@lynx.adilger.int>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
this patch/CSET fixes the revision-level checking for ext2 and ext3.

Without it, we will still try to write the superblock even if we set
the mount read-only, we do not return an error code to mount(8) to
tell the user that the filesystem cannot be remounted read-write,
and we get a false warning when a user tries to mount such a filesystem
read-only.

You should just be able to do "|bk receive [linux-2.5 path]" to import
the CSET at the end directly into BK if you so desire and your email
client can do pipes.

Note that I have compiled this but not run-tested it on 2.5 because I
am unable to get 2.5 to finish a build at this time (haven't tried -dj
yet)...  It is exactly the same patch that I have been using and tested
correct behaviour with under 2.4, so it should be OK.

Cheers, Andreas
==========================================================================
ChangeSet@1.332, 2002-02-14 12:01:31-07:00, adilger@lynx.adilger.int
  Don't try to write the superblock or pretend to let a read-write remount
  succeed if the ext2/ext3 superblock has too high a revision level.

diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Thu Feb 14 12:11:10 2002
+++ b/fs/ext2/super.c	Thu Feb 14 12:11:10 2002
@@ -332,14 +332,16 @@
 			      struct ext2_super_block * es,
 			      int read_only)
 {
-	int res = 0;
+	if (read_only)
+		return 0;
+
 	if (le32_to_cpu(es->s_rev_level) > EXT2_MAX_SUPP_REV) {
-		printk ("EXT2-fs warning: revision level too high, "
-			"forcing read-only mode\n");
-		res = MS_RDONLY;
+		ext2_warning(sb, __FUNCTION__, "revision level too high, "
+			     "forcing read-only mode");
+		sb->s_flags |= MS_RDONLY;
+		return -EROFS;
 	}
-	if (read_only)
-		return res;
+
 	if (!(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
 		printk ("EXT2-fs warning: mounting unchecked fs, "
 			"running e2fsck is recommended\n");
@@ -374,7 +376,7 @@
 		ext2_check_inodes_bitmap (sb);
 	}
 #endif
-	return res;
+	return 0;
 }
 
 static int ext2_check_descriptors (struct super_block * sb)
@@ -788,8 +790,9 @@
 		 * by e2fsck since we originally mounted the partition.)
 		 */
 		sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
-		if (!ext2_setup_super (sb, es, 0))
-			sb->s_flags &= ~MS_RDONLY;
+		if ((ret = ext2_setup_super (sb, es, 0)))
+			return ret;
+		sb->s_flags &= ~MS_RDONLY;
 	}
 	ext2_sync_super(sb, es);
 	return 0;
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Thu Feb 14 12:11:10 2002
+++ b/fs/ext3/super.c	Thu Feb 14 12:11:10 2002
@@ -708,15 +708,14 @@
 			    int read_only)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
-	int res = 0;
 
 	if (le32_to_cpu(es->s_rev_level) > EXT3_MAX_SUPP_REV) {
-		printk (KERN_ERR "EXT3-fs warning: revision level too high, "
-			"forcing read-only mode\n");
-		res = MS_RDONLY;
+		ext3_warning(sb, __FUNCTION__, "revision level too high, "
+			     "forcing read-only mode");
+		sb->s_flags |= MS_RDONLY;
+		return -EROFS;
 	}
-	if (read_only)
-		return res;
+
 	if (!(sbi->s_mount_state & EXT3_VALID_FS))
 		printk (KERN_WARNING "EXT3-fs warning: mounting unchecked fs, "
 			"running e2fsck is recommended\n");
@@ -775,7 +774,7 @@
 	}
 #endif
 	setup_ro_after(sb);
-	return res;
+	return 0;
 }
 
 static int ext3_check_descriptors (struct super_block * sb)
@@ -1711,8 +1710,9 @@
 			 */
 			ext3_clear_journal_err(sb, es);
 			sbi->s_mount_state = le16_to_cpu(es->s_state);
-			if (!ext3_setup_super (sb, es, 0))
-				sb->s_flags &= ~MS_RDONLY;
+			if ((ret = ext3_setup_super (sb, es, 0)))
+				return ret;
+			sb->s_flags &= ~MS_RDONLY;
 		}
 	}
 	setup_ro_after(sb);

================================================================


This BitKeeper patch contains the following changesets:
1.332
## Wrapped with gzip_uu ##


begin 664 bkpatch13015
M'XL(`,X+;#P"`]V6:VO;2!2&/WM^Q2&%W9A&\EQT=7');M)+V#8)3O-AH2#&
MTMC65I;,C.0D(/K;]XR<BY/6*6F[4%82'EMSYN4]9\XC^1F<&Z6'/9GEQ4QI
M\@S>5J8>]HJK\M*]ONGF98T3XZK"B4%C],#H=%#D97/I<-<G.'<JZW0.*Z7-
ML,=<<7NGOEJJ86_\ZLWYNS_&A(Q&<#"7Y4R=J1I&(U)7>B6+S.S+>EY4I5MK
M69J%JJ6;5HOV-K3EE'(\?18*Z@<M"Z@7MBG+&),>4QGE7A1X9)7K:G^!4N[2
M-*[*FB\4F.`,@VDKHIC[Y!#0J^!`^0`OY@'C0\J&@CDT'%(*U_GO/RP&/.?@
M4/(G_%S_!R2%PZK\O89:7Z$V7.B\5E#/%9AFJ?2DJ-)/4&E8:E6K,K,A!192
M@E8R<];16BVJ!O<KQ35IJE0&^;234)<U'^"'V!2;2X,J%<SSV;S36>4FKTJ4
M7:G")7^!1T,O(*=WVT:<)QZ$4$G)RV_4:FH&G<'.FYMN5BP64<LX\UBK6"SQ
M]+VIF,B,>ULW:(L<:L24"8;;S_T(/2UMDSYF2'QAB%/!T1"-0L';2:92-ITR
M1B.>*2:^94AL,\1\%O@='P\"+24_VR7)Y$K]LV\:H]Q,;=.(T5W@^VA-"-:A
M@OD]G908G/B7)`4EKEEY2,I3^%AOW`DX^J*[L-]/'^[A=R!S&#(&S`X>"'(4
ML@`\TNM9U>1"ZC(O9[MFL@=)\OK\^.##T<EQDNS!SGU_M\YQ!A?WP!X[TTJG
MN'Q=B:HLKF!196JG_P)#S,1Y:9)I(6<&VA&\/TO&AR?'[_ZV<UC)1I?@O!J?
MO#Y[8:U%P*VU&(U^Q-]AA%^.UL---,5`9I/`2!Q]3`:-8)UW=[5]!4"7D<'@
M9=)5"[JTE-D#VN_W;?"-%`[6QCV/OXW@\X;).W[X)C__P9/G*^^:+8\<"V/@
MQ:WP`US68>1_!T:,_[\Y6C^1O\H1_Q&.A/!M5]H!6\\VGG6>V+[OWS4UMNE'
M&QM:V(2(;V#COPILPF,6(>'Q-6PB#+NTNF$3MC#N`L.8=ZC=)XT_3MI]T![C
<[.;O73I7Z2?3+$;XLHFGGA>1?P&G4'^,4`H`````
`
end
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


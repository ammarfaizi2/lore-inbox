Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313309AbSDETeo>; Fri, 5 Apr 2002 14:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313511AbSDETeg>; Fri, 5 Apr 2002 14:34:36 -0500
Received: from backtop.namesys.com ([212.16.7.71]:28801 "EHLO
	bitshadow.namesys.com") by vger.kernel.org with ESMTP
	id <S313309AbSDETeU>; Fri, 5 Apr 2002 14:34:20 -0500
Date: Sat, 6 Apr 2002 00:31:43 +0400
Message-Id: <200204052031.g35KVh502903@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: ReiserFS Bug Fixes 6 of 6 (Please apply all 6) [PATCH]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changeset is to convert one of the errors to a warning, so that once
encountered, it would still be possible to continue operations.
Also during this it was found that buffer was still marked as mapped,
even if get_block returned error. This problem was also fixed.

You can get it by piping this message through bk receive.

Diffstat:

 inode.c           |   10 ++++++----
 tail_conversion.c |   10 +++++++---
 2 files changed, 13 insertions(+), 7 deletions(-)

Patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.590   -> 1.591  
#	 fs/reiserfs/inode.c	1.41    -> 1.42   
#	fs/reiserfs/tail_conversion.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/05	green@angband.namesys.com	1.591
# tail_conversion.c, inode.c:
#   Make pap14030 error condition to not crash the box. Also mark buffer as not mapped on get_block failures so that subsequent accesses to it will fail.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Fri Apr  5 14:22:46 2002
+++ b/fs/reiserfs/inode.c	Fri Apr  5 14:22:46 2002
@@ -756,6 +756,11 @@
 		goto research ;
 	    }
 	    retval = direct2indirect (&th, inode, &path, unbh, tail_offset);
+	    if (retval) {
+		reiserfs_unmap_buffer(unbh);
+		reiserfs_free_block (&th, allocated_block_nr);
+		goto failure;
+	    }
 	    /* it is important the mark_buffer_uptodate is done after
 	    ** the direct2indirect.  The buffer might contain valid
 	    ** data newer than the data on disk (read by readpage, changed,
@@ -765,10 +770,7 @@
 	    ** the disk
 	    */
 	    mark_buffer_uptodate (unbh, 1);
-	    if (retval) {
-		reiserfs_free_block (&th, allocated_block_nr);
-		goto failure;
-	    }
+
 	    /* we've converted the tail, so we must 
 	    ** flush unbh before the transaction commits
 	    */
diff -Nru a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
--- a/fs/reiserfs/tail_conversion.c	Fri Apr  5 14:22:46 2002
+++ b/fs/reiserfs/tail_conversion.c	Fri Apr  5 14:22:46 2002
@@ -49,9 +49,13 @@
     make_cpu_key (&end_key, inode, tail_offset, TYPE_INDIRECT, 4);
 
     // FIXME: we could avoid this 
-    if ( search_for_position_by_key (sb, &end_key, path) == POSITION_FOUND )
-	reiserfs_panic (sb, "PAP-14030: direct2indirect: "
-			"pasted or inserted byte exists in the tree");
+    if ( search_for_position_by_key (sb, &end_key, path) == POSITION_FOUND ) {
+	reiserfs_warning ("PAP-14030: direct2indirect: "
+			"pasted or inserted byte exists in the tree %K. "
+			"Use fsck to repair.\n", &end_key);
+	pathrelse(path);
+	return -EIO;
+    }
     
     p_le_ih = PATH_PITEM_HEAD (path);
 

BK changeset:

This BitKeeper patch contains the following changesets:
1.591
## Wrapped with gzip_uu ##


begin 664 bkpatch2387
M'XL(`)&YK3P``^56:V_;-A3];/Z*BQ0K'#26^;0>@8=D3;<9W6HC7;X5$"B)
MMC3;DDM228QI_WV4[";M\E@:K,"`6?Y`D9>7YYY[CJ07<&&4CGH+K52)7L#/
ME;%13Y:+1):95\JU,EOCI=7:K9U7E5L;YM5:#;OX8;*,KRJ]'&I5N"QLL"K*
M^GI`/8%<^$S:-(=+I4W4(QZ[F;';C8IZYV]^NOCE]!RA\1A>Y^Y`]5Y9&(^1
MK?2E7&7F1-I\596>U;(T:V5EBZ*Y"6THQM1=@O@,BU%#1IC[34HR0B0G*L.4
M!R...IPG]]3S]TP<"QP*7^"&<)\'Z`R()T("F`XQ'V(!A$4BC!A[A7F$,3R8
M&%Y1&&#T`_R[A;Q&*5A9K.*T*EM."Y<Q/8*BK#+EI9%;!?A5+A5LY(9PS#`H
MK2L-+CPKK(MV>*"L+*1:&M>$7$%277MPNC(5K*5>0E+/YTJ#-%W86FXV*@.W
M;Z%LG*RJ=`ES=WZME0&WQ>;2@JD3HS[6JK0@TU09X];<,86%JV*UZN(]]!:(
M"$<!FMWV&0V^\H<0EAA][XIS"KJ?T+G9R]`-]JQ\1JW`C#:,BC!HLDRQ,$QY
M%F;IG/#DX58^G'.GED"0AH\894]'=J>%7V)D#2:4APUC.,$!86&6I93R)T)\
M(/DM6!8P&G:6NZ>RUGS?@M]'//@XOYQ3VG#&`]RYD=,OS1A$@ORS&4<PX-_$
MC/]5L^T$.86!ONK^SCRS^]K]#`].?!&`0#WWJ(%B#GVMK"/U$/Y`O=ZG]'%=
MNFKB77W]NDSRP^//E^>N5?L*^R]M?@1RY6ZD5=EN-BYUMV%1N=KV'!SOCOP3
MG?FC`+C#X1,@Z,,=)=\QP%=H^GG.1)F\5+^?F-HH+U-/2QA2PD?"=W:AW.^D
M3<1SI.W#@/VOI+U[?#TB[3N4/T/D9X("0Q/!P4>?A`Y&29WF\;S2\:8R'0]Q
MLHV7:@M]DQS!2U5F[=U1^Q[(#YWL8#9]/_EM,GT7_SB]>'<&G4MN7'`E=5F4
M"^@?S$YG@X[G"+)"J]32HMP-(CAP/N@=;*2Q+8/:O>S=[G:<;*T"=5T8:]QD
MUP3K=`+?O?7VF]Q7G6/&<>UHU&HC"^U]*`]N@;8>:Z%JM3*JWX$^;O'96I<P
A>#.9'J.=Y6X^V])<I4M3K\?<IP)G`4%_`27D<@8\"@``
`
end

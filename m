Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313500AbSDET0y>; Fri, 5 Apr 2002 14:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313502AbSDET0p>; Fri, 5 Apr 2002 14:26:45 -0500
Received: from backtop.namesys.com ([212.16.7.71]:26241 "EHLO
	bitshadow.namesys.com") by vger.kernel.org with ESMTP
	id <S313500AbSDET0b>; Fri, 5 Apr 2002 14:26:31 -0500
Date: Sat, 6 Apr 2002 00:23:57 +0400
Message-Id: <200204052023.g35KNvR02861@bitshadow.namesys.com>
From: Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: ReiserFS Bug Fixes 1 of 6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changeset is to fix reiserfs corruption problems while finishing unlinks
and truncates during mount.
You can just use bk receive to get it.

reiserfs copies a key into the private part of the inode, and uses this
for some operations.  If an iget fails because the object no longer
exists, iput might trigger deletion of whatever object previously lived
in that inode, leading to corruption on disk.  The patch below fixes
that, and a minor thinko in the read_super call.  bk receivable patch
included as well.
Fix itself is from Chris Mason.

Diffstat:

 inode.c |   21 ++++++++++++++++-----
 super.c |    3 +--
 2 files changed, 17 insertions(+), 7 deletions(-)

plain patch:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.537   -> 1.537.5.1
#	 fs/reiserfs/inode.c	1.37    -> 1.38   
#	 fs/reiserfs/super.c	1.31    -> 1.32   
#
# --------------------------------------------
# 02/04/02	mason@suse.com	1.537.5.1
# cleanup fixes:
# 
# reiserfs_read_inode2 needs to clear the private key when it fails to 
# read the inode from disk.
# 
# brelse called too soon while reading the super.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Fri Apr  5 14:08:08 2002
+++ b/fs/reiserfs/inode.c	Fri Apr  5 14:08:08 2002
@@ -1107,8 +1107,19 @@
     return;
 }
 
+/* reiserfs_read_inode2 is called to read the inode off disk, and it
+** does a make_bad_inode when things go wrong.  But, we need to make sure
+** and clear the key in the private portion of the inode, otherwise a
+** corresponding iput might try to delete whatever object the inode last
+** represented.
+*/
+static void reiserfs_make_bad_inode(struct inode *inode) {
+    memset(INODE_PKEY(inode), 0, KEY_SIZE);
+    make_bad_inode(inode);
+}
+
 void reiserfs_read_inode(struct inode *inode) {
-    make_bad_inode(inode) ;
+    reiserfs_make_bad_inode(inode) ;
 }
 
 
@@ -1128,7 +1139,7 @@
     int retval;
 
     if (!p) {
-	make_bad_inode(inode) ;
+	reiserfs_make_bad_inode(inode) ;
 	return;
     }
 
@@ -1148,13 +1159,13 @@
 	reiserfs_warning ("vs-13070: reiserfs_read_inode2: "
                     "i/o failure occurred trying to find stat data of %K\n",
                     &key);
-	make_bad_inode(inode) ;
+	reiserfs_make_bad_inode(inode) ;
 	return;
     }
     if (retval != ITEM_FOUND) {
 	/* a stale NFS handle can trigger this without it being an error */
 	pathrelse (&path_to_sd);
-	make_bad_inode(inode) ;
+	reiserfs_make_bad_inode(inode) ;
 	inode->i_nlink = 0;
 	return;
     }
@@ -1181,7 +1192,7 @@
 			      "dead inode read from disk %K. "
 			      "This is likely to be race with knfsd. Ignore\n", 
 			      &key );
-	    make_bad_inode( inode );
+	    reiserfs_make_bad_inode( inode );
     }
 
     reiserfs_check_path(&path_to_sd) ; /* init inode should be relsing */
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Fri Apr  5 14:08:08 2002
+++ b/fs/reiserfs/super.c	Fri Apr  5 14:08:08 2002
@@ -740,9 +740,8 @@
     //
     // ok, reiserfs signature (old or new) found in at the given offset
     //    
-    brelse (bh);
-    
     sb_set_blocksize (s, sb_blocksize(rs));
+    brelse (bh);
     
     bh = reiserfs_bread (s, offset / s->s_blocksize);
     if (!bh) {

BK changeset:

This BitKeeper patch contains the following changesets:
1.537.5.1
## Wrapped with gzip_uu ##


begin 664 bkpatch2212
M'XL(`/^VK3P``[56VV[C-A!]-K]B@'UQTE@F=;%E!RG2W01ML$4WR'8?6A0P
M9&EDL9%%@Z3L3>O^>X>TG1N<-%DTL@!9TLSAW,ZAWL$7@WK<F6G$AKV#GY2Q
MXT[6S*994P1--D=S8X)<S>G=E5+TKE^I.?:]?7]Z/5DI?=W7*`DEZM6R:;_V
MPB!A9'Z9V;R")6HS[H@@NGUB;Q8X[ER=__CEYQ^N&#LY@0\5+8B?T<+)";-*
M+[.Z,*>9K6K5!%9GC9FCS5P4ZUO3=<AY2+]$#".>#-9BP./A.A>%$%DLL.!A
MG`[B.S07]?-8D4C%*":_=3Q(PR$[`Q$DT3!(`@$\[/.XST,0T3@1XWC0X\F8
M<YAG1C6GIC7H$.&[$'J<O8?_-X</+(>\QJQI%U#*KVC&](#.3=5+,]&8%1/9
MJ`)#:!`+0P%X#PVV0EAHN<PLPC7>P*K"!J2%,I.U-_,X6>$-/024FC(II+D.
M-LM,-=8&(<_J&LE.*3!*-80D:_2^LIEY=],N4`?L(\2#,.7L\JZOK/?*@S&>
M<?8]+-S$[*]B:?J[`O0W*^?WZIGP*%ISP7FR3J:#M(C2)$ZR=,C+Z:.F/0U$
MLR#21$3)F@]"\8IP?!T?AQ.NHS`9I>NBP&@TRN-B5.2EB)\-YP'073A1$D:I
M9\X>8\>AMXB3+:56IW,"#1:F#;!HG\:*>!B*<!3'ZV0X&'%/I2A]S*(H>8)%
M8@"]Y$UH]&$O*61S;_R+5KN!1JV5-O1L/]&`Y'$O`0.`7RMI"!<7!EKCZ408
M!=9H=TQ9:%Q*12_5]$_,K>-A+9>X"22SVTB(9'+16L>H3<<_04^O_$D,N=S7
M_&\@VH40?`1"L/[A?D6A9&ZY_U@K5%EZJ3CR]9"6'1Y"H=!`1DV]QLGTMEY>
M>&Q%%3`P4[#2JIE1K=ZW]@A6Z&7+X3LO$A*-#LEAWLG8O4[MFK=0VDHJDRKO
M8CH"1?_UBC*!S*'D2FLT"]5XH7(5A;F<551U?>.6])UQ`1(B[5:W/;E-LLZ,
M3TPC]<U@8[$(V&&?&9M9F<-2R7NC\##MKK&ZS7<-/?27`_B;`1USG!NTW8M?
M/IV=3RX_GO_6W;P^`GX$=#OY?/'[^<'QQO8AZL;PF/W#_F!G@@X0KH_^ZLR?
MBF:[_K%SBK9._MIYB4>R]4A>[C'<>@Q?ZI'&&P]_[3R7R[:F5(7'0K@5\5<(
MX:OVC_\0P@=8D1`A'8+3%A+%Z48(PY<+(?3"-]%!SV\?:?<`3*7:NH!&V=U>
M[V9_VI8EL6$E;>7OB6:.Z9M=WGT7M(V5-62EI5OZHB"9<-QPC#+3"4WV9%JK
M_-K(O[![0!+FM]!G%&Q;MV]0L+-A'$'(+H9QLIW_;1K=:>7&8_?AF5=(\;3S
2$_JZ2^+A*&+_`H&_&N_^"@``
`
end

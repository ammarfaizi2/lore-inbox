Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317879AbSGKTZ4>; Thu, 11 Jul 2002 15:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317878AbSGKTZz>; Thu, 11 Jul 2002 15:25:55 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:9936 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317879AbSGKTZx>; Thu, 11 Jul 2002 15:25:53 -0400
Subject: [BK-PATCH-2.5] NTFS: 2.0.18 - Fix race condition in reading of compressed files
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 11 Jul 2002 20:28:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SjcG-0002of-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

This fixes a nasty little race condition in reading compressed files. There
was a narrow window between checking a buffer head for being uptodate and
locking it in fs/ntfs/compress.c::ntfs_file_read_compressed_block(). We now
lock the buffer and then check whether it is uptodate or not.

Big thanks go to Andre and Jens for bringing a stable IDE layer to 2.5.25
which actually makes it possible to start finding bugs in other places
other than IDE!

I am running http://www.linuxdiskcert.org/LAD-ide24-2.5.25.patch.bz2 on
top of the current 2.5 BitKeeper tree and it's working great!!! Thanks guys!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    2 ++
 fs/ntfs/ChangeLog                  |    8 ++++++++
 fs/ntfs/Makefile                   |    2 +-
 fs/ntfs/compress.c                 |   17 +++++++++--------
 4 files changed, 20 insertions(+), 9 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/11 1.621)
   NTFS: 2.0.18 - Fix race condition in reading of compressed files.
   - There was a narrow window between checking a buffer head for being
   uptodate and locking it in ntfs_file_read_compressed_block(). We now
   lock the buffer and then check whether it is uptodate or not.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Thu Jul 11 20:19:13 2002
+++ b/Documentation/filesystems/ntfs.txt	Thu Jul 11 20:19:13 2002
@@ -247,6 +247,8 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.18:
+	- Fix race condition in reading of compressed files.
 2.0.17:
 	- Cleanups and optimizations.
 2.0.16:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Thu Jul 11 20:19:13 2002
+++ b/fs/ntfs/ChangeLog	Thu Jul 11 20:19:13 2002
@@ -13,6 +13,14 @@
 	  with initialized_size < data_size. I don't think it can happen but
 	  it requires more careful consideration.
 	- Enable NFS exporting of NTFS.
+	- Apply block resolution optimization from aops.c::ntfs_read_block() to
+	  compress.c::ntfs_file_read_compressed_block() as well.
+
+2.0.18 - Fix race condition in reading of compressed files.
+
+	- There was a narrow window between checking a buffer head for being
+	  uptodate and locking it in ntfs_file_read_compressed_block(). We now
+	  lock the buffer and then check whether it is uptodate or not.
 
 2.0.17 - Cleanups and optimizations - shrinking the ToDo list.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Thu Jul 11 20:19:13 2002
+++ b/fs/ntfs/Makefile	Thu Jul 11 20:19:13 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.17\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.18\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	Thu Jul 11 20:19:13 2002
+++ b/fs/ntfs/compress.c	Thu Jul 11 20:19:13 2002
@@ -157,7 +157,7 @@
 
 	/* Default error code. */
 	int err = -EOVERFLOW;
-	
+
 	ntfs_debug("Entering, cb_size = 0x%x.", cb_size);
 do_next_sb:
 	ntfs_debug("Beginning sub-block at offset = 0x%x in the cb.",
@@ -193,7 +193,7 @@
 	/* Setup offsets for the current sub-block destination. */
 	do_sb_start = *dest_ofs;
 	do_sb_end = do_sb_start + NTFS_SB_SIZE;
-	
+
 	/* Check that we are still within allowed boundaries. */
 	if (*dest_index == dest_max_index && do_sb_end > dest_max_ofs)
 		goto return_overflow;
@@ -572,11 +572,13 @@
 	for (i = 0; i < nr_bhs; i++) {
 		struct buffer_head *tbh = bhs[i];
 
-		if (buffer_uptodate(tbh))
+		if (unlikely(test_set_buffer_locked(tbh)))
 			continue;
-
-		lock_buffer(tbh);
-		get_bh(tbh);
+		if (unlikely(buffer_uptodate(tbh))) {
+			unlock_buffer(tbh);
+			continue;
+		}
+		atomic_inc(&tbh->b_count);
 		tbh->b_end_io = end_buffer_io_sync;
 		submit_bh(READ, tbh);
 	}
@@ -587,9 +589,8 @@
 
 		if (buffer_uptodate(tbh))
 			continue;
-
 		wait_on_buffer(tbh);
-		if (!buffer_uptodate(tbh))
+		if (unlikely(!buffer_uptodate(tbh)))
 			goto read_err;
 	}
 

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch27457
M'XL(`#':+3T``\5776_;-A1]-G_%70L,"0K+)/7MP473..F"9FV0I-L>`AB4
M1,5";-&0Z+K9M/^^2\F)&SG>8C?=;,<$:?+PD.>>>Y67\*F41;\C,L$9>0D_
MJU+W.['(M8BL7&H<.E<*AWKSLNB51=S3^37!T3.AXS%\ED79[S#+OA_1MS/9
M[YP?O?MT>G!.R&``AV.17\L+J6$P(%H5G\4D*=\(/9ZHW-*%R,NIU,**U;2Z
MGUIQ2CF^7>;;U/4JYE''KV*6,"8<)A/*G<!S2,WZS8IM&\!GE-LVY6[%F&?[
M9`C,\C@#RGO4[S$&G/:9W[>=5Y3U*84V'KQRH$O)6WA>VH<DA@^7QQ=]X!:U
M6`!=.,Z^0"%B";'*DTQG*H<LAT**),NO0:4X/IT5LBQE`FDVD:6%&%VX',M"
MPD*4("`71:$6L,CR!)M(ZH64.<1C&=\8#`'1/$UE`6,$A505.`7'$68^TRH1
M6H+($YBH9GJF#8%<I^7([#<R5$8K$J/(3-S;M^`W";E:((P9`#V6=_L8-.PN
M*<!B++%7U,#E:D_DD2MMD?>`$G%*SE;Q0KI;O@BA@I+7\/9]E98]P[WWB[B1
MAG_%0I]2AF^;AFY84>SX52IC%KG,94Y"[6A=_W6895@Q%J+$K+(9]Y<[#E4\
MGTI<:<3KU1K=EEI.&P1+?]&/<*"L\EWJ29^F7'I1$MG1.HDG(+=HL8!Z_L.+
M:&[U5%T_QL*KDM1+0\&0C$QM/W4V7\4*J+6IBQ9S'VYZ%R]6_-BN0>4QAZ6Q
M'P@_\1W!O<V[?H74VM:Q;<>M$\V_WY/)0,\HU7K^>;I4F)AXZ/**\2`,Z\3$
MW;6\Q#;F)?Z]\M)\5MO2)':3A$R>:)*4<6@=5A^A6RSJ#SKN[`FWOH./3[@3
M`B?-SGW2V2E!FIA8B]IE".QHBW7%-]KB7F`W<():8$;#+10._@^%&P^W%%X[
MXBZ",A<"H^/!;#:YA;IZH'JEFLQK+=5,9]/LCSJ(("W4%(2:H=O[_;H$U=5G
M67+P2D@'8)41EG/^J4P!5LB%G$PL<D6^I>9>F2,\0]%%_L]2=1'GV\KNUQZY
M*W(MBVQ50C<;I%U"\<L\DYD2ZC4)T*-;V(-!E_WG]FC*_09[W!UP!W<,`V#D
MQ'P=_7YY?C`Z/#X]>'<!`^@.S7/BZ->C\XN3CQ\&5R\:*E<O'@BWLD)+NFWK
M[V;UUNHO#9B/"MJ5[7BTR6^.OX5^(72#[Z+?]JY^Q-"(LZ6E-_D9D;9Q]$8[
M(\X3GZ.;!Z(-0;K2<9<PQ6LW@=HT5]@/O;I?-]AW?=?TFZ;3R5+8F^>3[$9.
M;O>T+/6HE'K4'&QD#BJ3/1V-]_?WS5(?;+,T!+>]=+GB[JS+-?`GSNO@)`1:
M@M:__&2&47R=Y7-I.G_AG]!JFL6C+(_W?L1)W=<1BC#/-<X>NJ$Y#C:\)E\W
>+08_/$YA]8]PK4TYGPY2P:(@DC[Y&^KUPD=:#P``
`
end

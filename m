Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312918AbSDBUPp>; Tue, 2 Apr 2002 15:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312914AbSDBUP2>; Tue, 2 Apr 2002 15:15:28 -0500
Received: from 216-42-72-142.ppp.netsville.net ([216.42.72.142]:36244 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S312917AbSDBUPM>; Tue, 2 Apr 2002 15:15:12 -0500
Subject: [PATCH] 2.5.7 reiserfs mount fixes
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
Cc: reiserfs-list@namesys.com, green@namesys.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 02 Apr 2002 15:14:43 -0500
Message-Id: <1017778483.26533.19.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

These patches fix reiserfs corruption problems while finishing unlinks
and truncates during mount.  They have been very lightly tested,
reiserfs under 2.5.x should be used with caution until we've hammered on
it a bit more.

2.5.[67] will oops on mount without Oleg's journal.c patch that has been
floating around.  You can grab it at:

ftp.namesys.com/pub/reiserfs-for-2.5/2.5.7.pending/02-jdev_bd_uninitialised_fix.diff

There are a few other patches in that ftp directory, but at least one of
them is still causing corruptions.  The most critical patches are the
02_jdev fix, and the one below.  I would skip all the others right now.

reiserfs copies a key into the private part of the inode, and uses this
for some operations.  If an iget fails because the object no longer
exists, iput might trigger deletion of whatever object previously lived
in that inode, leading to corruption on disk.  The patch below fixes
that, and a minor thinko in the read_super call.  bk receivable patch
included as well.

ChangeSet@1.538, 2002-04-02 13:51:46-05:00, mason@suse.com
  cleanup fixes:
  
  reiserfs_read_inode2 needs to clear the private key when it fails to 
  read the inode from disk.
  
  brelse called too soon while reading the super.

diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Tue Apr  2 14:44:38 2002
+++ b/fs/reiserfs/inode.c	Tue Apr  2 14:44:38 2002
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
--- a/fs/reiserfs/super.c	Tue Apr  2 14:44:38 2002
+++ b/fs/reiserfs/super.c	Tue Apr  2 14:44:38 2002
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

================================================================


This BitKeeper patch contains the following changesets:
1.538
## Wrapped with gzip_uu ##


begin 664 bkpatch2053
M'XL(`"8*JCP``[56VV[C-A!]-K]B@'UQ4E](76S908ITDV`;;-$-LMV'%@4,
M61I%;&31("E[T[K_WB%]R:5.FBP:60`M:N9P.#/G4._@BT$];LU2HVKV#GY4
MQHY;IC'8R]2,)JZ4HHG^]*9?R;KYVIL)1K.7J<U*6*`VXY;HA;L9>SO'<>OJ
M_,.7GWZX8NSX&$[+M+[&SVCA^)A9I1=IE9N3U):5JGM6I[69H4W=8JN=Z2K@
M/*!?+(8ACP<K,>#1<)6)7(@T$ICS($H&T1U:J6;X/%8H$C&*R&\5#9)@R,Y`
M].(P`1[T>=3G`8AP'(MQ-.CR>,PY^'2<;-,`WP70Y>P]_+_QG[(,L@K3NIE#
M(;^B&=,$W1HEU:0P$XUI/I&URC&`&C$W%(#WT&!+A+F6B]0BW.`M+$NL05HH
M4EEY,X^3YM[00T"A:2>Y-#>]]3)3C95!R-*J0K)3"HQ2-2')"KVOK*^]NVGF
MJ'OL(T2#(.'L\JZFK/O*BS&><O8]S%VW[,]B8?K;!/37*V?W\AGS,%QQP7F\
MBJ>#)`^3.(K39,B+Z:.B/0U$?2"26(3QB@\"\8IP?!X?AQ.LPB`>):L\QW`T
MRJ)\E&>%B)X-YP'073AA'(2)9\T>8\>?MXB3+:16)S,"[<U-T\.\>1HKY$$@
M@E$4K>+A8,0]C?[-HC!^@D5B`-WX36ATNI<4LK[7_GFC74.CUDH;FMM/-$CK
M?"\!>P"_E-(0+LX--,;3B3!RK-!NF3+7N)"*7JKI'YA9Q\-*+G`=2&HWD1#)
MY+RQCE'KBG^"KE[ZFQARN:_XWT"T"R'X"(1@_</]BD*;V7'_L5:HHO!2T?'Y
MD)8='D*NT$!*1;W!R727+R\\MJ0,&+A6L-2JOJ9<O6]L!Y;H9<OA.R\2$HT.
MR6'>R=B]2FV+-U?:2DJ3*NYBZH"B_WI).X'4H61*:S1S57NA<AF%F;PN*>OZ
MUBWI*^,")$0ZJ78UV6VR2HW?F$:JF\':8MYCAWUF;&IE!@LE[[7"PVVWC=5-
MMBWHH1\.X"\&=,UP9M"V+W[^='8^N?QX_FM[_;H#O`/T./E\\=OYP=':]B'J
MVO"(_<U^9V>"+A"NCGYTYD]%LUG_R#F%&R<_ME[B$6\\XI=[##<>PY=Z)-':
MPX^MY_:RR2EEX;$0;D3\%4+XJO/C/X3P`58H1$"7X'2$A%&R%L+@Y4((W>!-
M=-#SVT?:/@!3JJ;*H59V>]:[WI\V14%L6$I;^F>BF6/Z^I1WWP5-;64%:6'I
MD;XH2"8<-QRCS'1"G3V95BJ[,?)/;!^0A/DC]!D%V^3M&Q3L;!B%$+"+811O
B^G^SC?:T=.VQ_>C,2J1XFMEQR$44#?*`_0/*&CI(U@H`````
`
end


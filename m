Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319497AbSIGOYv>; Sat, 7 Sep 2002 10:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319498AbSIGOYv>; Sat, 7 Sep 2002 10:24:51 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:63148 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319497AbSIGOYr>; Sat, 7 Sep 2002 10:24:47 -0400
Subject: [BK-PATCH 2/3] Introduce fs/inode.c::ilookup().
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 7 Sep 2002 15:29:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
       viro@math.psu.edu (Alexander Viro)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17ngaV-00025O-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is the second patch changing iget{,5}_locked() to use ilookup{,5}().

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/inode.c |   82 +++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 45 insertions(+), 37 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/09/07 1.623)
   Cleanup: Convert fs/inode.c::iget_locked() and iget5_locked() to use
   ilookup() and ilookup5() respectively.


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Sat Sep  7 14:52:36 2002
+++ b/fs/inode.c	Sat Sep  7 14:52:36 2002
@@ -536,7 +536,7 @@
 	inode->i_state &= ~(I_LOCK|I_NEW);
 	wake_up_inode(inode);
 }
-
+EXPORT_SYMBOL(unlock_new_inode);
 
 /*
  * This is called without the inode lock held.. Be careful.
@@ -764,65 +764,73 @@
 }
 EXPORT_SYMBOL(ilookup);
 
-/*
- * This is iget without the read_inode portion of get_new_inode
- * the filesystem gets back a new locked and hashed inode and gets
- * to fill it in before unlocking it via unlock_new_inode().
+/**
+ * iget5_locked - obtain an inode from a mounted file system
+ * @sb:		super block of file system
+ * @hashval:	hash value (usually inode number)
+ * @test:	callback used for comparisons between inodes
+ * @set:	callback used to initialize a new struct inode
+ * @data:	opaque data pointer to pass to @test and @set
+ *
+ * This is iget() without the read_inode() portion of get_new_inode().
+ *
+ * The inode specified by @hasval and @data is looked up in the inode cache
+ * and if present it is returned with an increased reference count.
+ *
+ * If it is not present, get_new_inode() is used to allocate a new inode and
+ * this is returned locked, hashed, and with the I_NEW flag set. The file
+ * system gets to fill it in before unlocking it via unlock_new_inode().
+ *
+ * Note both @test and @set are called with the inode_lock held, so can't sleep.
  */
-struct inode *iget5_locked(struct super_block *sb, unsigned long hashval, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
+struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *),
+		int (*set)(struct inode *, void *), void *data)
 {
-	struct list_head * head = inode_hashtable + hash(sb, hashval);
-	struct inode * inode;
+	struct list_head *head = inode_hashtable + hash(sb, hashval);
+	struct inode *inode;
 
-	spin_lock(&inode_lock);
-	inode = find_inode(sb, head, test, data);
-	if (inode) {
-		__iget(inode);
-		spin_unlock(&inode_lock);
-		wait_on_inode(inode);
+	inode = ilookup5(sb, hashval, test, data);
+	if (inode)
 		return inode;
-	}
-	spin_unlock(&inode_lock);
-
 	/*
 	 * get_new_inode() will do the right thing, re-trying the search
 	 * in case it had to block at any point.
 	 */
 	return get_new_inode(sb, head, test, set, data);
 }
+EXPORT_SYMBOL(iget5_locked);
 
-/*
- * Because most filesystems are based on 32-bit unique inode numbers some
- * functions are duplicated to keep iget_locked as a fast path. We can avoid
- * unnecessary pointer dereferences and function calls for this specific
- * case. The duplicated functions (find_inode_fast and get_new_inode_fast)
- * have the same pre- and post-conditions as their original counterparts.
+/**
+ * iget_locked - obtain an inode from a mounted file system
+ * @sb:		super block of file system
+ * @ino:	inode number to search for
+ *
+ * This is a fast version of iget5_locked() for file systems where the inode
+ * number is sufficient for unique identification of an inode.
+ *
+ * The inode specified by @ino is looked up in the inode cache and if present
+ * it is returned with an increased reference count.
+ *
+ * If it is not present, get_new_inode_fast() is used to allocate a new inode
+ * and this is returned locked, hashed, and with the I_NEW flag set. The file
+ * system gets to fill it in before unlocking it via unlock_new_inode().
  */
 struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
-	struct list_head * head = inode_hashtable + hash(sb, ino);
-	struct inode * inode;
+	struct list_head *head = inode_hashtable + hash(sb, ino);
+	struct inode *inode;
 
-	spin_lock(&inode_lock);
-	inode = find_inode_fast(sb, head, ino);
-	if (inode) {
-		__iget(inode);
-		spin_unlock(&inode_lock);
-		wait_on_inode(inode);
+	inode = ilookup(sb, ino);
+	if (inode)
 		return inode;
-	}
-	spin_unlock(&inode_lock);
-
 	/*
 	 * get_new_inode_fast() will do the right thing, re-trying the search
 	 * in case it had to block at any point.
 	 */
 	return get_new_inode_fast(sb, head, ino);
 }
-
-EXPORT_SYMBOL(iget5_locked);
 EXPORT_SYMBOL(iget_locked);
-EXPORT_SYMBOL(unlock_new_inode);
 
 /**
  *	__insert_inode_hash - hash an inode

===================================================================

This BitKeeper patch contains the following changesets:
1.623
## Wrapped with gzip_uu ##


begin 664 bkpatch2633
M'XL(`*0$>CT``]U7;6_;-A#^;/V*`_IAMNL74I*ME\%#UZ38@G5MD+;8]LF@
M92HF*HN:2"7+X!^_.TJ.':=%T&(%AB6&*9.\N^>>>^[B/(,/1M9I3RCA<^\9
M_*R-37N9**U834II<>M*:]R:-J:>FCJ;%JIL_AK[D]E8%5I_;"H/[UP*FVW@
M1M8F[?%)<+]C[RJ9]JY>_?3A]8]7GK=8P-E&E-?RG;2P6'A6US>B6)L7PFX*
M74YL+4JSE59,,KW=W5_=^8SY^#OC4<!F\QV?LS#:97S-N0BY7#,_C.>AYW)X
M<<!^ZB!A$?=9S.,="W@4>^?`)W,_`.9/63)E$?`@]><I#YXSGC(&I_[@.8<Q
M\U["OPO[S,O@K)"B;*H4SG2)+%K(S525>BTG69JJ:VF7A<X^RG5_`*)<`^W,
M#EM60V,DNNDJLK_5?IKAQUJ:2F96W<CB;N+]`@&/Y][EH1C>^`M_/(\)YOWP
M!!6'+(ZY2`*L@!_R9+=B/`YBF2=LO5[-`_Z(\D<>7`W].4MVW$_"R$GJ<.=I
M37TIHL>B^B0B%K/9S@^PH*VJDE-1L>2SH@IG,`ZB_X6LVIJ\A7%]ZUZHD\NC
MF%^ALO-9D`#W+MKEU>^7;Z_>+]_]\>O+MZ_[34E0EZ6\7;H`@^^]\V@>0>A=
M1!$#'GO3X="#X8.\8`QZ984J,1=P9I#7>@L"MKHI+5[(52'!W!DKMV3\PJS2
M7L\TE:QA13Y`YX_N;(398.W2'CT`/C42^HUI1%'<=5'*9KN2]<!=M[*=LD6Q
M$N@06<:PN@:L<R5J971I8"7MK90=1M,BD8^LL$:J5%:)0OTM,0DD`XRMF\RV
MALYN+:Q(>[H2?R(L^@"55IAK3>:5,(96!\H5F.*@'9F^WR@#]$(&L=ZWRFYT
M8\%N)-9>K%O>\:#2M56Z)&I(5?<EZ0\F]YYD1P1)1N4*P:_N''-(5QO70<-H
M)#`\;BJT<+%:PTQD&Y>04V$.%<I/EIBH):-:VJ8NT8Q`ML7-$".15,M<UK+,
MT`75>`_I(N],2VWWSD:G^.E\SS0RKS-A]SRWJ!`,.;,=4_<P6KF-@!1!*X%V
MT"BAB^6;5[]!7HAK0+(GCAW2%'EJ944X7%UPNW`X2Y0$BD1"JWM57M/VC1)P
MV@@'UM]H1+O2&/5A>4'4Q&=1R"-0SM:U"6QD@9"-QCOE=Q9,(64UP>Z*?&I&
M6@+O6&8P?#`[NB/7-,NV:89F-4*@1EVWY"#ZKFE&7J^':H3^D"`.^@_]CN!&
MJS4,!X=KB/_SM[H'DM*``(?@$^`9+KW.IE#&+C<H7QBZ]T67.>'!J8R=_=QA
MZQ/D#B3.EMY)PK30Q(DBF&.(V*<0[>'B,"2/?(R`$ARY#B1_*.%^.[C02QPB
MI1=1XC\:<\?,NA&7A"Y@@A,Q/!YQWW3"H:.T=SS)2)M&BAJ_Y:$J3^:%@%R@
MW.@+83<63OZVT+0["F'@=H,M>I`A.>OBH#O3Y+G*%#4[&3:EHDFFUKB!DP1;
ML@NR3_BIH8-[3\V9DR'C./YV<V9)=#T];/;#[[\V;,YC%E"?Q2S\VC[#H\_W
M6,SF)/F8\T_TV+'Y<4O%/,"6.H]]:DQ<9MA9]_^88(6SCZ;9+OPXB7*9S;U_
)`-+'!5X*#0``
`
end

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319496AbSIGO0F>; Sat, 7 Sep 2002 10:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319499AbSIGO0F>; Sat, 7 Sep 2002 10:26:05 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:21677 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319496AbSIGO0C>; Sat, 7 Sep 2002 10:26:02 -0400
Subject: [BK-PATCH 3/3] Introduce fs/inode.c::ilookup().
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 7 Sep 2002 15:30:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
       viro@math.psu.edu (Alexander Viro)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17ngbi-00025d-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

And this is the third patch, moving the inode hash calculation from
iget{,5}_locked() to get_new_inode{_fast}().

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/inode.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/09/07 1.624)
   Cleanup: Move inode hash calculation from fs/inode.c::iget_locked()
   and iget5_locked() into get_new_inode_fast() and get_new_inode(),
   respectively.


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Sat Sep  7 14:52:45 2002
+++ b/fs/inode.c	Sat Sep  7 14:52:45 2002
@@ -538,15 +538,27 @@
 }
 EXPORT_SYMBOL(unlock_new_inode);
 
+static inline unsigned long hash(struct super_block *sb, unsigned long hashval)
+{
+	unsigned long tmp = hashval + ((unsigned long) sb / L1_CACHE_BYTES);
+	tmp = tmp + (tmp >> I_HASHBITS);
+	return tmp & I_HASHMASK;
+}
+
+/* Yeah, I know about quadratic hash. Maybe, later. */
+
 /*
  * This is called without the inode lock held.. Be careful.
  *
  * We no longer cache the sb_flags in i_flags - see fs.h
  *	-- rmk@arm.uk.linux.org
  */
-static struct inode * get_new_inode(struct super_block *sb, struct list_head *head, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
+static inline struct inode *get_new_inode(struct super_block *sb,
+		unsigned long hashval, int (*test)(struct inode *, void *),
+		int (*set)(struct inode *, void *), void *data)
 {
-	struct inode * inode;
+	struct list_head *head = inode_hashtable + hash(sb, hashval);
+	struct inode *inode;
 
 	inode = alloc_inode(sb);
 	if (inode) {
@@ -594,9 +606,11 @@
  * get_new_inode_fast is the fast path version of get_new_inode, see the
  * comment at iget_locked for details.
  */
-static struct inode * get_new_inode_fast(struct super_block *sb, struct list_head *head, unsigned long ino)
+static inline struct inode *get_new_inode_fast(struct super_block *sb,
+		unsigned long ino)
 {
-	struct inode * inode;
+	struct list_head *head = inode_hashtable + hash(sb, ino);
+	struct inode *inode;
 
 	inode = alloc_inode(sb);
 	if (inode) {
@@ -633,15 +647,6 @@
 	return inode;
 }
 
-static inline unsigned long hash(struct super_block *sb, unsigned long hashval)
-{
-	unsigned long tmp = hashval + ((unsigned long) sb / L1_CACHE_BYTES);
-	tmp = tmp + (tmp >> I_HASHBITS);
-	return tmp & I_HASHMASK;
-}
-
-/* Yeah, I know about quadratic hash. Maybe, later. */
-
 /**
  *	iunique - get a unique inode number
  *	@sb: superblock
@@ -787,7 +792,6 @@
 		int (*test)(struct inode *, void *),
 		int (*set)(struct inode *, void *), void *data)
 {
-	struct list_head *head = inode_hashtable + hash(sb, hashval);
 	struct inode *inode;
 
 	inode = ilookup5(sb, hashval, test, data);
@@ -797,7 +801,7 @@
 	 * get_new_inode() will do the right thing, re-trying the search
 	 * in case it had to block at any point.
 	 */
-	return get_new_inode(sb, head, test, set, data);
+	return get_new_inode(sb, hashval, test, set, data);
 }
 EXPORT_SYMBOL(iget5_locked);
 
@@ -818,7 +822,6 @@
  */
 struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
-	struct list_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
 
 	inode = ilookup(sb, ino);
@@ -828,7 +831,7 @@
 	 * get_new_inode_fast() will do the right thing, re-trying the search
 	 * in case it had to block at any point.
 	 */
-	return get_new_inode_fast(sb, head, ino);
+	return get_new_inode_fast(sb, ino);
 }
 EXPORT_SYMBOL(iget_locked);
 

===================================================================

This BitKeeper patch contains the following changesets:
1.624
## Wrapped with gzip_uu ##


begin 664 bkpatch2667
M'XL(`*T$>CT``^5676^C1A1]9G[%E5:J;`?##&"^(D>;.%%C[4:-DMV'E2JA
M`28Q"F9<9G`:E?[W#H-CKYVD^Z&^U;:XUMQ[#_>><[#\#CX+5L<&+:A#T#NX
MY$+&1D8K25.K8E(=W7"NCNQ&U+:H,[LLJN;/L6--QD7)^4.S0JKFFLIL`6M6
MB]@@EKL]D4\K%ALW%[]^_GAZ@]!T"K,%K>[9+9,PG2+)ZS4M<_&>RD7)*TO6
MM!)+)JF5\66[+6T=C!WUGI#`Q1._)3[V@C8C.2'4(RS'CA?Z'M([O-_-?@@0
MX8`XCD_<%KLD]-$Y$,MW/,".C2,;!T#<V"7Q!!]A$F,,AWAP1&",T1G\MV//
M4`:SDM&J6<5PQ=<,BHKG#!94+""C9=:45!:\@KN:+^%.V#IM97%<W#.9E#Q[
M8/E@J%!HE4-W-MD>*BC)H2NKV&.B&Y,[*J3*=,5[B<'05!@U$RN6R6+-RB<+
M?0#%E(NN=[*A\0^^$,(4HY-OD+9;ZVO6(C=L%4LD:E.LY@C9783S//5=\D*<
M%PA:;9=X84M($'K:?+N:;[OO1R=Z:;]7)W)\'+7$B;Q`^R_`A_;SPC?MYV`8
MD^!_9L!>O=]@7#_JCW+4]5=#_(0?YQ,/0X2$5%ME:D#UB\:@J41Q7[$<%)_W
M>O6!D'6321#-BM5)VFT$(Y&:KY0J,8;H+V3L9^1R!=/G/!S!8+"7'X)(P8:/
M))F=SBXODK,OGRYNA\?(Z/NZJ^KIPLD)S)/+T]O+L_DG75$SV=25+OEED[HZ
MO?UPC/Y&OR-[!%\879@PAX>*/P)->2/ACX;FM5ZX&\B"*_J4,A.4LJRV8&2K
MQO.)ITS8T1.`>T#/AHO>&*-]V=[@"1G&JTR9G2=@,)),R.%@']B$-2]R&`V[
M[KY,L'^IVGS)J:3#;OZHGS\"!QF;GK(0,EDPJLKT==JC)-TTZLDJF6*YEUM)
M^RSF\;9]<TL=CM4MHIXB%9SOIZBW_/?RI%JZ9:)^F>BGE^EPWES$=WWU#)P'
M$59W.0]Q%^9]>+;7@<H[>DSHM#-!26."YEX!A@[12"[12#J\BK0A8SO@]L]"
7MF#9@VB64S;QTC",//0/\13<#YX(````
`
end

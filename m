Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270957AbSISJqI>; Thu, 19 Sep 2002 05:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270940AbSISJqI>; Thu, 19 Sep 2002 05:46:08 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:47552 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270939AbSISJp7>; Thu, 19 Sep 2002 05:45:59 -0400
Subject: [BK-PATCH-2.5-2/2] Introduce ilookup() for searching for inodes in icache
To: torvalds@transmeta.com (Linus Torvalds),
       viro@math.psu.edu (Alexander Viro)
Date: Thu, 19 Sep 2002 10:51:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel), linux-fsdevel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17rxxf-0007Kx-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here is the second patch which switches iget_locked() to use the new
helpers and it adds some documentation.

No functionality changed at all.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/inode.c |   87 +++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 50 insertions(+), 37 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/09/18 1.536.1.38)
   Cleanup: Convert fs/inode.c::iget_locked() and iget5_locked() to use
   the new ifind_fast() and ifind() helpers, respectively.


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Thu Sep 19 10:39:43 2002
+++ b/fs/inode.c	Thu Sep 19 10:39:43 2002
@@ -535,7 +535,7 @@
 	inode->i_state &= ~(I_LOCK|I_NEW);
 	wake_up_inode(inode);
 }
-
+EXPORT_SYMBOL(unlock_new_inode);
 
 /*
  * This is called without the inode lock held.. Be careful.
@@ -812,65 +812,78 @@
 }
 EXPORT_SYMBOL(ilookup);
 
-/*
- * This is iget without the read_inode portion of get_new_inode
- * the filesystem gets back a new locked and hashed inode and gets
- * to fill it in before unlocking it via unlock_new_inode().
+/**
+ * iget5_locked - obtain an inode from a mounted file system
+ * @sb:		super block of file system
+ * @hashval:	hash value (usually inode number) to get
+ * @test:	callback used for comparisons between inodes
+ * @set:	callback used to initialize a new struct inode
+ * @data:	opaque data pointer to pass to @test and @set
+ *
+ * This is iget() without the read_inode() portion of get_new_inode().
+ *
+ * iget5_locked() uses ifind() to search for the inode specified by @hashval
+ * and @data in the inode cache and if present it is returned with an increased
+ * reference count. This is a generalized version of iget_locked() for file
+ * systems where the inode number is not sufficient for unique identification
+ * of an inode.
+ *
+ * If the inode is not in cache, get_new_inode() is called to allocate a new
+ * inode and this is returned locked, hashed, and with the I_NEW flag set. The
+ * file system gets to fill it in before unlocking it via unlock_new_inode().
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
+	inode = ifind(sb, head, test, data);
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
+ * @ino:	inode number to get
+ *
+ * This is iget() without the read_inode() portion of get_new_inode_fast().
+ *
+ * iget_locked() uses ifind_fast() to search for the inode specified by @ino in
+ * the inode cache and if present it is returned with an increased reference
+ * count. This is for file systems where the inode number is sufficient for
+ * unique identification of an inode.
+ *
+ * If the inode is not in cache, get_new_inode_fast() is called to allocate a
+ * new inode and this is returned locked, hashed, and with the I_NEW flag set.
+ * The file system gets to fill it in before unlocking it via
+ * unlock_new_inode().
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
+	inode = ifind_fast(sb, head, ino);
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
1.536.1.38
## Wrapped with gzip_uu ##


begin 664 bkpatch16654
M'XL(`%^;B3T``[U7VW+;-A!]%K]B9_)06=&%X$6BV%$GC9UI/4T3CY-,VR<-
M1$(6)A2@$*!==_3QW06IN]U<&]MCTB#VX.S9LTOY";PSHDQ;7/*`>4_@5VUL
MVLJXLGS65\+BTK76N#2H3#DP938HI*K^[@7]N"<+K=]7*P_W7'&;+>!6E"9M
ML7ZX7;'W*Y&VKE_\\N[ES]>>-YG`^8*K&_%&6)A,/*O+6U[DYAFWBT*KOBVY
M,DMA>3_3R_5VZSKP_0"_8S8*_7BX9D,_&JTSEC/&(R9R/XB28>2Y')[MN!\#
MC%G"AF$0!>L@"?S0NP#6C\-A'PDGX`<#?SQ@";`D#5@:CY[Z+/5].`:%IPQZ
MOO<<OBWW<R^#\T)P5:U2.-<*I;0P-P.I="[Z69K*&V&GA<[>B[Q]!ESE0"OQ
M;LEJJ(Q`&+L0H,0=R+E4^73.C=T$T`+>+T2QPDIUH11F)3(K;T5QW_=^`Y2%
M,>]J5R.O]YE?GN=SW_OI(^+L\MI79QPF:U2#C=<SGR5A(N9C/\]GPY"=%.$$
M@4H["E@<K8-AXD?.:;L]'[?:YS(Z]=I#C-!LP7C-`N;'SFPC_\1FT:,VBWWH
MA:/O8[3O8BY7F-?0*^_<#YKE:J]&7V"UBQC[EGF7]>7%GU>OK]].W_SU^_/7
M+]N5(NY3I#IU!YS]Z%TD+(;(NTQ0?9QU@T['@\Y!HM`#/;-<*LP(7!C,2[T$
M#DM=*8L;YK(08.Z-%4L*?F9F::ME*LP89H0!>GZR9\'-`@N8MN@&\*X2T*Y,
MQ8OBOCE%5<N9*)W,2,=%65$/XJ*8<<1%]?%T70+6?,5+:;0R,!/V3HB&JJD)
MB9,H!)5*6LD+^8_`7*A\QI959NM`%Y=SR].67O$/R([^@)66F'))X2MN#%T=
M*5=M.@?C*/3M0AJ@'V2.];^3=J$KZXQ2"I[7\N.#E2ZMU(H4(K=M*],^ZS=(
M1YY#\F9K*SS="%[B*X5$(/!:.?(8[L$T9_=;J0G,L72)8#EW^S.>X7UM6%BA
M1X5"&2PE4`I;E0J1*(7:`1EF@!(27BGFHA0J0PCR0G^;-\=TE"B=NKE[!399
M'C85T29G$%9M#@-W"X3<(U?;@$"5MF"J^5QFD@A2<*4DU4;FN(`99YS4)#0\
M:F/7C9*7\SW4!@YE<,EWC^6G#>28VBIXHQ&[,8HKBT,AR6R3\E:I.KLND.YT
MI4U./3K]<OKJQ1\P+_@-ELX)YI+?:P]BXHR%:X6K@D)/8[("ZOZ5ZH:6;R6'
MXX;>V>:51K8SC:<>^A-X*3:);4FY6%<5FE1(V6C<HWY`N0LA5GV<$H%/0X4N
MH;??)]`Y,&CSR#7_M&[^CIEUD:B1-[4XR+YQ9-=KM;"=H-TABF?M0]PNW&J9
M0^=LMPWY/[ZKN2%WGQ'A``(B'.*EU<04TMCI`OL/.N[WI,F<^.`K!DOPU'%K
M$^6&),[(UE'"=*')&<0PQ"-"GXZH'TZ:WG0`>$07*+6N&QZ$A/W5KD<OQH<!
MBGF91/[)H-[7U`WI*'!'12-@P_TA_;_.:`1*6P=-N!W%WV+&-2_*_4'WT)S;
MO$\_;=CA&JX3WE>.M]UL(["C\;:96Y\PM`X'%F$].+.^<F!M1'ID:A&:^X#R
M;:9677WQA5.KUN!T<%TD,7,]&P=?VK/XZ#_Z-8Y<$\7CDWZMY=LU;8-ST*U#
FAMUZD8RHV_$28M-N_Z/#@F3O3;6<L!E^RL1/R-Z_^.]Z8D,.````
`
end

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbSJAIaE>; Tue, 1 Oct 2002 04:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbSJAIaE>; Tue, 1 Oct 2002 04:30:04 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:46779 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261531AbSJAIaA>; Tue, 1 Oct 2002 04:30:00 -0400
Subject: [RESEND][BK-PATCH-2/2] Introduce ilookup() for searching for inodes in icache
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 1 Oct 2002 09:35:27 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro),
       linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17wIV5-0000ur-00@storm.christs.cam.ac.uk>
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

<aia21@cantab.net> (02/09/18 1.536.35.9)
   Cleanup: Convert fs/inode.c::iget_locked() and iget5_locked() to use
   the new ifind_fast() and ifind() helpers, respectively.


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Tue Oct  1 09:22:43 2002
+++ b/fs/inode.c	Tue Oct  1 09:22:43 2002
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
1.536.35.9
## Wrapped with gzip_uu ##


begin 664 bkpatch12475
M'XL(`%1;F3T``[U7VW+;-A!]%K]B9_)06=&%X$6BV%$GC9UI/4T3CY-,VR<-
M1$(6)A2@$*!==_3QW06IN]U<&UMCTB#VX.S9LTO[";PSHDQ;7/*`>4_@5VUL
MVLJXLGS65\+BTK76N#2H3#DP938HI*K^[@7]N"<+K=]7*P_W7'&;+>!6E"9M
ML7ZX7;'W*Y&VKE_\\N[ES]>>-YG`^8*K&_%&6)A,/*O+6U[DYAFWBT*KOBVY
M,DMA>3_3R_5VZSKP_0"_8S8*_7BX9D,_&JTSEC/&(R9R/XB28>2Y')[MN!\#
MC%G"AF$0!>L@"?S0NP#6C\-A/XS[8_"#@3\>L`18D@8LC4=/?9;Z/AR#PE,&
M/=][#M^6^[F7P7DAN*I6*9QKA5):F)N!5#H7_2Q-Y8VPTT)G[T7>/@.N<J"5
M>+=D-51&((Q="%#B#N1<JGPZY\9N`F@![Q>B6&&ENE`*LQ*9E;>BN.][OP'*
MPIAWM:N1U_O,+\_SN>_]]!%Q=GGMJS,.DS6JP<;KF<^2,!'SL9_GLV'(3HIP
M@D"E'04LCM;!,/$CY[3=GH];[7,9G7KM(49HMF"\9@'S8V>VD7]BL^A1F\4^
M],+1]S':=S&7*\QKZ)5W[H-FN=JKT1=8[2(.44?OLKZ\^//J]?7;Z9N_?G_^
M^F6[4L1]BE2G[H"S'[V+A,40>9<)JH^S;M#I>-`Y2!1ZH&>62X49@0N#>:F7
MP&&I*V5QPUP6`LR]L6))P<_,+&VU3(49PXPP0,]/]BRX66`!TQ;=`-Y5`MJ5
MJ7A1W#>GJ&HY$Z63&>FX*"OJ05P4,XZXJ#Z>KDO`FJ]X*8U6!F;"W@G14#4U
M(7$2A:!222MY(?\1F`N5S]BRRFP=Z.)R;GG:TBO^`=G1+[#2$E,N*7S%C:&K
M(^6J3>=@'(6^74@#]$'F6/\[:1>ZLLXHI>!Y+3\^6.G22JU((7+;MC+MLWZ#
M=.0Y)&^VML+3C>`EOE)(!`*OE2./X1Y,<W:_E9K`'$N7")9SMS_C&=[7AH45
M>E0HE,%2`J6P5:D0B5*H'9!A!B@AX95B+DJA,H0@+_2W>7-,1XG2J9N[5V"3
MY6%3$6UR!F'5YC!PMT#(/7*U#0A4:0NFFL]E)HD@!5=*4FUDC@N8<<9)34+#
MHS9VW2AY.=]#;>!0!I=\]UA^VD".J:V"-QJQ&Z.XLC@4DLPV*6^5JK/K`NE.
M5]KDU*/3+Z>O7OP!\X+?8.F<8"[YO?8@)LY8N%:X*BCT-"8KH.Y?J6YH^59R
M.&[HG6U>:60[TWCJH3^!EV*3V):4BW55H4F%E(W&/>H'E+L08M7'*1'X-%3H
M$GK[?0*=`X,VCUSS3^OF[YA9%XD:>5.+@^P;1W:]5@O;"=H=HGC6/L3MPJV6
M.73.=MN0_^.[FAMR]QD1#B`@PB%>6DU,(8V=+K#_H.-^3IK,B0^^8K`$3QVW
M-E%N2.*,;!TE3!>:G$$,0SPB].F(^N&DZ4T'@$=T@5+KNN%!2-A?[7KT8GP8
MH)B72>2?#.I]3=V0C@)W5#0"-MP?TO_KC$:@M'70A-M1_"UF7/.BW!]T#\VY
MS?OTTX8=KN$ZX7WE>-O--@([&F^;N?4)0^MP8!'6@S/K*P?61J1'IA:AN3]0
MOLW4JJLOOG!JU1J<#JZ+)&:N9^/@2WL6'_U'O\:1:Z)X?-*OM7R[IFUP#KIU
GR+!;+Y(1=3M>0FS:[7]T6)#LO:F6DSB;B>$XS+U_`6"H!=E##@``
`
end

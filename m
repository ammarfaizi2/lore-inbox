Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319495AbSIGOXB>; Sat, 7 Sep 2002 10:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319496AbSIGOXA>; Sat, 7 Sep 2002 10:23:00 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:49046 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319495AbSIGOW6>; Sat, 7 Sep 2002 10:22:58 -0400
Subject: [BK-PATCH 1/3] Introduce fs/inode.c::ilookup().
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 7 Sep 2002 15:27:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
       viro@math.psu.edu (Alexander Viro)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17ngYk-00025C-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This is the first of three patches implementing ilookup(), a function
to search the inode cache for an inode and if not found just return NULL.

All response about ilookup() / ilookup5() was positive and several
file systems would like to have such a function available.

The first patch just adds ilookup() and ilookup5(). This would be
sufficient for NTFS and other FS.

The second patch changes iget_locked() and iget5_locked() to use ilookup()
and ilookup5(). This makes sense as iget{,5}_locked() are just the same
as ilookup{,5}() except they call get_new_inode{,_fast}() instead of
returning NULL.

The third patch moves the inode hash calculation from iget{,5}_locked()
into get_new_inode{,_fast}().

The second and third patch have the small disadvantage to the previous
code in that in the case that ilookup() fails in iget_locked() and
get_new_inode_fast() is called the inode hash is calculated twice.
But that is the slow path so I don't think it is a problem.

If you think that is bad then you can just ignore patches 2 and 3.

But please apply at least the first patch as that is really needed.

All three patches are tested and work fine.

If you want all three patches you can also do a: 

	bk pull http://linux-ntfs.bkbits.net/linux-2.5-ilookup

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/inode.c         |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs.h |    4 +++
 2 files changed, 73 insertions(+), 1 deletion(-)

through these ChangeSets:

<aia21@cantab.net> (02/09/07 1.622)
   Introduce ilookup() and ilookup5() in fs/inode.c.


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Sat Sep  7 14:52:28 2002
+++ b/fs/inode.c	Sat Sep  7 14:52:28 2002
@@ -696,6 +696,74 @@
 	return inode;
 }
 
+/**
+ * ilookup5 - search for an inode in the inode cache
+ * @sb:		super block of file system to search
+ * @hashval:	hash value (usually inode number) to search for
+ * @test:	callback used for comparisons between inodes
+ * @data:	opaque data pointer to pass to @test
+ *
+ * ilookup5() searches for the inode specified by @hasval and @data in the
+ * inode cache.
+ *
+ * If the inode is in the cache, the inode is returned with an incremented
+ * reference count.
+ *
+ * Otherwise NULL is returned.
+ *
+ * Note, @test is called with the inode_lock held, so can't sleep.
+ */
+inline struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *), void *data)
+{
+	struct list_head *head = inode_hashtable + hash(sb, hashval);
+	struct inode *inode;
+
+	spin_lock(&inode_lock);
+	inode = find_inode(sb, head, test, data);
+	if (inode) {
+		__iget(inode);
+		spin_unlock(&inode_lock);
+		wait_on_inode(inode);
+		return inode;
+	}
+	spin_unlock(&inode_lock);
+	return NULL;
+}
+EXPORT_SYMBOL(ilookup5);
+
+/**
+ * ilookup - search for an inode in the inode cache
+ * @sb:		super block of file system to search
+ * @ino:	inode number to search for
+ *
+ * ilookup() searches for the inode @ino in the inode cache. This is a fast
+ * version of ilookup5() for file systems where the inode number is sufficient
+ * for unique identification of an inode.
+ *
+ * If the inode is in the cache, the inode is returned with an incremented
+ * reference count.
+ *
+ * Otherwise NULL is returned.
+ */
+inline struct inode *ilookup(struct super_block *sb, unsigned long ino)
+{
+	struct list_head *head = inode_hashtable + hash(sb, ino);
+	struct inode *inode;
+
+	spin_lock(&inode_lock);
+	inode = find_inode_fast(sb, head, ino);
+	if (inode) {
+		__iget(inode);
+		spin_unlock(&inode_lock);
+		wait_on_inode(inode);
+		return inode;
+	}
+	spin_unlock(&inode_lock);
+	return NULL;
+}
+EXPORT_SYMBOL(ilookup);
+
 /*
  * This is iget without the read_inode portion of get_new_inode
  * the filesystem gets back a new locked and hashed inode and gets
@@ -765,7 +833,7 @@
  *	Add an inode to the inode hash for this superblock. If the inode
  *	has no superblock it is added to a separate anonymous chain.
  */
- 
+
 void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 {
 	struct list_head *head = &anon_hash_chain;
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sat Sep  7 14:52:28 2002
+++ b/include/linux/fs.h	Sat Sep  7 14:52:28 2002
@@ -1204,6 +1204,10 @@
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
 
+extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *), void *data);
+extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
+
 extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 extern struct inode * iget_locked(struct super_block *, unsigned long);
 extern void unlock_new_inode(struct inode *);

===================================================================

This BitKeeper patch contains the following changesets:
1.622
## Wrapped with gzip_uu ##


begin 664 bkpatch2601
M'XL(`)P$>CT``]57^V_;-A#^6?PK"!38;,>62<G6PX&'K`]LP;(F2!M@`PH8
MM$3%1&3*%2F[V=S_?4=:?B3.HPDZ+(N#2*+NOOONXQUS?H4O%"\'#A/,H^@5
M_K50>N`D3&HV=B77L'1>%+#4K5395672S86LOG0\M]\1>5%<53,$-F=,)Q,\
MYZ4:.-3U-ROZ>L8'SOF[7RY.?CY':#C$;R9,7O(/7./A$.FBG+,\54=,3_)"
MNKID4DVY9FY23)<;TZ5'B`>?/@U]T@^6-""]<)G0E%+6HSPE7B\*>FC.9%H6
M<WXT3]QD7FDW^>LV1DP"0FE(XR7I16&`WF+J!IZ'B=<E<9>$F/H#$@UH=$#H
M@!!L93G:RH$//-PAZ#7^OLS?H`0?2UT6:95P7.O::&)(:/W4AT<A<::Z0A8I
M=Q,7_89]&D;H;*LIZCSQ!R'""/KID72V07?SB?UH"?Q!RS&AD1_Q+"9I.@Y\
MNB?;'D),0NJ1B/27G@\2/,I`R"2O4KXJOFZFW,E-)C$HV_?#94!X'$5IF&5I
M,.;!/I'[@+:$?+]'8ENJ6]*/U^I3)4(*D+10.1NK.P%"S_.@1DFP[,<^K2LU
MNEVHI']OH08Q[M`74ZFK;3[%G7)A?Z'TSG9,GE&XQT$<X2!"W58+X=8F..Y@
MQ5D)9T]6E$`+VPB&D)[P^B%AR80;IR,U'CB.JF:\Q..\2*YPD>%,Y!RK:Z7Y
M%,2KT:SUA*D):#EPS`V&NXKC1J4JEN?7-;2LIF->-K>.AH9UUGQULN;YF$&@
M2O'44H1=F+%2J$(J/.9ZP7G-65FWE&DV<(H9^PS!S`.>%4)J(`PA9DPI<[7@
M8+XK!.S"B@%7-LXV?37CB<@$Q!]?VZ0@$[N!-E@ME87:JN76Z,?9#I!0:UVM
M3?OFJY+KJI0092'T9+432<FG',BG!JKD&2^YA#)*BDKJ=813`"D70G'\_N+D
M9!=H;?&^T!#+YFQ>&TG7438$1G8W)SQ/VU@58"-_U%CEG,\,2A<)"2<`2*'+
M*M$UY]9&NGK9%L9H51@M-6[C2BIQ:5*"1KK$=3FTD>/`CN!&RS!J-FYBMO&\
M$"EN-=<W1N,F^ALYM5TNE!Y-.(-7]N^P3L"@0S-#+1[82`U#H`[9/-RXKZF;
MRR'Z!.LS(6WVC1^V2AB'E24<:T*F(_NP@H2@L'-`O6WKRYIFN&$MFAB(.J.1
MN.2Z7H'7JQB5O"N*LV!"CPI91]CZK'81UT2=K^@AE-K85,`A^HK>_7%V>OYQ
M].'/WU^?GC36V]0T^=YL_W^S^\%[X.QV^5Z3[Q"YO_L,SAV$7/QQ8OI)888S
M9KO9SE.BD(;63E<;N!V6"B^@8?@.7LT.H%2592(1T'(&SCA64IB#1*2P!F=`
MPG0=8*W52VGTAUOT&SL4G)[=:L;W^[39R.SG3J_5R/^+)K,]]C:$R8.BX]7E
MDQV.]@>IQX>D9TYQ6]09EY>5^%;8&&`CO]^G2]KW>L2.4#2@3YBA>B]JV+>#
MZ:T1:C_WYXQ2,/H&N(?X%Y@KY'_V3_'P00)/:'E3LYNOH'!>)5>JF@Y3$GDQ
,"S/T#](SI][T#@``
`
end

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSHaRzj>; Sat, 31 Aug 2002 13:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317851AbSHaRzj>; Sat, 31 Aug 2002 13:55:39 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:13237 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317845AbSHaRzh>; Sat, 31 Aug 2002 13:55:37 -0400
Subject: [BK-PATCH-2.5] Introduce new VFS inode cache lookup function
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 31 Aug 2002 19:00:04 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro),
       linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17lCXU-0002zH-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Al,

The below ChangeSet against Linus' current BK tree adds a new function to
the VFS, fs/inode.c::ilookup().

This is needed in NTFS when writing out inode metadata pages via the VM
dirty page code paths as we need to know whether there is an active inode
in icache but we don't want to do an iget() because if the inode is not
active then there is no need to write it... - I can just skip onto the next
one instead... - If there is an active inode then I need to get the struct
inode in order to perform appropriate locking for the write out to happen.

If there is something you don't like about this patch please let me know
what it is, preferably with what you want instead so I can modify it...

Without such icache lookup functionality it is impossible to write inodes
via the VM page dirty code paths AFAICS. - The only alternative I can see
is to duplicate the whole icache private to NTFS so that I can perform the
lookup internally but I think that is silly considering the VFS already
keeps the inode cache...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/inode.c         |   33 +++++++++++++++++++++++++++++++++
 include/linux/fs.h |    3 +++
 2 files changed, 36 insertions(+)

through these ChangeSets:

<aia21@cantab.net> (02/08/31 1.572)
   Implement an inode cache search function fs/inode.c::ilookup() and export it to modules.


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Sat Aug 31 18:49:37 2002
+++ b/fs/inode.c	Sat Aug 31 18:49:37 2002
@@ -696,6 +696,39 @@
 	return inode;
 }
 
+/**
+ * ilookup - search for an inode in the inode cache
+ * @sb:		super block of file system to search
+ * @hashval:	hash value (usually inode number) to search for
+ * @test:	callback used for comparisons between inodes
+ * @data:	opaque data pointer to pass to @test
+ *
+ * ilookup() searches for an inode in the inode cache.
+ *
+ * If the inode is in the cache and is not (in the process of being) cleared,
+ * the reference count of the inode is increased and the inode is returned.
+ *
+ * Otherwise NULL is returned.
+ */
+struct inode *ilookup(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *), void *data)
+{
+	struct list_head *head = inode_hashtable + hash(sb, hashval);
+	struct inode *inode;
+
+	spin_lock(&inode_lock);
+	inode = find_inode(sb, head, test, data);
+	if (inode && !(inode->i_state & (I_FREEING | I_CLEAR))) {
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
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sat Aug 31 18:49:37 2002
+++ b/include/linux/fs.h	Sat Aug 31 18:49:37 2002
@@ -1199,6 +1199,9 @@
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
 
+extern struct inode *ilookup(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *), void *data);
+
 extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 extern struct inode * iget_locked(struct super_block *, unsigned long);
 extern void unlock_new_inode(struct inode *);

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch106439
M'XL(`+$!<3T``\56^V_;-A#^6?PK;B@0V$XLBWI95N`B:9IUQK(F<!=@`P8(
ME$3;0F72(ZD\,/5_'RG)<1YM@P1[^"6*O/ONXW?'D]_`I:0BMDA!7(S>P$]<
MJMC*"%,DM1E5>FK.N9X:55*,I,A&9<&JFZ%K!\.BY/QSM4':YH*H;`575,C8
MPK9W-Z-N-S2VYJ<?+L^.YPA-IW"R(FQ)/U$%TRE27%R1,I='1*U*SFPE")-K
MJHB=\75]9UJ[CN/J=X#'GA.$-0X=?UQG.,>8^)CFCNM'H8_*/#W27YOGTN9B
M^=@_\C`>N]AWZ\#W\`2]!VP'8Q<<=^1$(P\#CF+/CS'>=W#L.-!(<K23`O9=
M&#KH'?RSK$]0!K/UIJ1KRA00!@7C.86,9"L*DA*A95Q4+%,%9["0HV;9SN*X
MD[_7UTXYT)L-%PH*I>G!FN=52:6-?H;`#:((7>QT1\,7OA!RB(/>/K/M';/[
M^YYX4:WWB2=UZN#(B^ABXN1Y&FJU'\O[!*')E^<%DQI[?C!^ED'!LK+*:5N@
MHX6T5P^9:)PP\,9UZ-!)%.7CQ2(/4QH^)?(MH!TAQW<GN"GG'>GGZ_FE$B&I
MD50A2Y+*KP*,7==U_,@)ZV#BX;"IZ#!Z6-!>'$R^6=">]V]5]'&>PUV!FCIL
M<W@.0W'=?'1=7=Q3[Q55.0LG$7@>&@T&"`;;:#"\.S1<[(Y3P4"MZ/VS97R.
M9!I;EJPV5$!:\NPS\`4LBE(?O%NIZ-J<I1:ML5X1N=(ZQ989@!Y5%'J5K$A9
MWG;0K%JG5/1WCH9&XZQHVUG+,B4Z4"5IWE#4"F^(*"1G$E*JKBGM.,O&+2>*
MQ!;?D#]U,',#&UXPI0GK$!LBI;DVX-K\G@ZZ+;0$J'Q.";OSG"WNK11R:]EV
M(M-C]!SC"GK=PD;PC&H"6K.4%FS9AZS4(6E^8-",A:`+*BC+-`BO='?C3R)D
M@A*CA(%_L"2HJ@2C^9;<N5X5UX6D\/'R[.RQQ0A)):I,=?Z#K0C=;)/AI,WP
M0*8'4#%9++4OZ&I?0I?7`V196EKH#8R<_=Y#R`.XXD4.@_YV8)+11W\AJ[,K
M"ZF2%25ZJ?F=MIZ)0=<G3A?5?A.I9PAT(?N'=^Y;YN9RB/[0\YN")89R;Z\%
M,F/CT%KJWE.P/&EN6D@=]``,]8.F4!K3A<F6,=_;@Q_:X?!MD4A%E)Z#WBSY
M<7YZ.OOX`6J8)2=GI\?S?K\/>E=6DA1+JEH?@]42JMC7*%G7I%`)9QV=G4^;
M).AV97U!WT/IC$V"#]$7=/K;Q?G\U^33[[^\.S_K=2GM&VU,YWW:I9_OP*]\
M1*`T$^61XGQ=92M;A^!,<5L7^HJH[^)&+G9=SW=P'41!&#4-&@<OZM#_68-N
M'FF/^O/3?;VF3V/7P>`A>J.[%H/_Z:`V9;/]6ZH;6O995NMIYD78G^0.^AOH
'AE,_"`L`````
`
end

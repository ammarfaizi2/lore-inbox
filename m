Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315817AbSEECU2>; Sat, 4 May 2002 22:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315818AbSEECU1>; Sat, 4 May 2002 22:20:27 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:27726 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315817AbSEECUZ>; Sat, 4 May 2002 22:20:25 -0400
Subject: [RFC][PATCH] Introduce fs/inode.c/init_address_space().
To: akpm@zip.com.au
Date: Sun, 5 May 2002 03:20:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E174BdQ-0005tz-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, the below patch adds a new exported functon init_address_space() and 
two inline helpers to share code between it and inode_init_once() and 
alloc_inode().

This function allows file systems to initialize private address spaces
without the need to know about the address space internals.

Andrew, not sure what you have in mind for the future of ra_pages, so for
now I am just passing in the super block to init_address_space. Is that 
ok?

I am not sure I am happy with the arguments the new function takes so just 
an RFC for now... Especially do we want the gfp_mask to be a tunable?

Comments anyone?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Sun May  5 03:10:53 2002
+++ b/fs/inode.c	Sun May  5 03:10:53 2002
@@ -70,9 +70,59 @@
 
 static kmem_cache_t * inode_cachep;
 
+static inline void address_space_init_once(struct address_space *mapping)
+{
+	INIT_RADIX_TREE(&mapping->page_tree, GFP_ATOMIC);
+	rwlock_init(&mapping->page_lock);
+	INIT_LIST_HEAD(&mapping->clean_pages);
+	INIT_LIST_HEAD(&mapping->dirty_pages);
+	INIT_LIST_HEAD(&mapping->locked_pages);
+	INIT_LIST_HEAD(&mapping->io_pages);
+	INIT_LIST_HEAD(&mapping->i_mmap);
+	INIT_LIST_HEAD(&mapping->i_mmap_shared);
+	spin_lock_init(&mapping->i_shared_lock);
+}
+
+static struct address_space_operations empty_aops;
+
+static inline void __init_address_space(struct address_space *mapping,
+		const struct super_block *sb, struct inode *host,
+		const int gfp_mask)
+{
+	mapping->nrpages = 0;
+	mapping->a_ops = &empty_aops;
+	mapping->host = host;
+	mapping->dirtied_when = 0;
+	mapping->gfp_mask = gfp_mask;
+	mapping->ra_pages = &default_ra_pages;
+	if (sb && sb->s_bdev)
+		mapping->ra_pages = sb->s_bdev->bd_inode->i_mapping->ra_pages;
+}
+
+/**
+ * init_address_space - initialize a new address space
+ * @mapping:	address space to initialize
+ * @sb:		super block to which @mapping belongs (optional)
+ * @host:	inode to which the @mapping belongs
+ * @gfp_mask:	how to allocate pages
+ *
+ * Initialize the address space @mapping with kernel defaults and set @host
+ * and @gfp_mask.
+ *
+ * If @sb is specified, use it to obtain the address of the read ahead
+ * defaults of the parent block device, otherwise use the kernel default
+ * read ahead.
+ */
+void init_address_space(struct address_space *mapping,
+		const struct super_block *sb, struct inode *host,
+		const int gfp_mask)
+{
+	address_space_init_once(mapping);
+	__init_address_space(mapping, sb, host, gfp_mask);
+}
+
 static struct inode *alloc_inode(struct super_block *sb)
 {
-	static struct address_space_operations empty_aops;
 	static struct inode_operations empty_iops;
 	static struct file_operations empty_fops;
 	struct inode *inode;
@@ -100,14 +150,8 @@
 		inode->i_pipe = NULL;
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
-		inode->i_data.a_ops = &empty_aops;
-		inode->i_data.host = inode;
-		inode->i_data.gfp_mask = GFP_HIGHUSER;
-		inode->i_data.dirtied_when = 0;
+		__init_address_space(&inode->i_data, sb, inode, GFP_HIGHUSER);
 		inode->i_mapping = &inode->i_data;
-		inode->i_data.ra_pages = &default_ra_pages;
-		if (sb->s_bdev)
-			inode->i_data.ra_pages = sb->s_bdev->bd_inode->i_mapping->ra_pages;
 		memset(&inode->u, 0, sizeof(inode->u));
 	}
 	return inode;
@@ -134,20 +178,12 @@
 	memset(inode, 0, sizeof(*inode));
 	init_waitqueue_head(&inode->i_wait);
 	INIT_LIST_HEAD(&inode->i_hash);
-	INIT_LIST_HEAD(&inode->i_data.clean_pages);
-	INIT_LIST_HEAD(&inode->i_data.dirty_pages);
-	INIT_LIST_HEAD(&inode->i_data.locked_pages);
-	INIT_LIST_HEAD(&inode->i_data.io_pages);
 	INIT_LIST_HEAD(&inode->i_dentry);
 	INIT_LIST_HEAD(&inode->i_dirty_buffers);
 	INIT_LIST_HEAD(&inode->i_devices);
 	sema_init(&inode->i_sem, 1);
-	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
-	rwlock_init(&inode->i_data.page_lock);
-	spin_lock_init(&inode->i_data.i_shared_lock);
 	spin_lock_init(&inode->i_bufferlist_lock);
-	INIT_LIST_HEAD(&inode->i_data.i_mmap);
-	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
+	address_space_init_once(&inode->i_data);
 }
 
 static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sun May  5 03:10:53 2002
+++ b/include/linux/fs.h	Sun May  5 03:10:53 2002
@@ -1234,6 +1234,10 @@
 #define user_path_walk(name,nd)	 __user_walk(name, LOOKUP_FOLLOW, nd)
 #define user_path_walk_link(name,nd) __user_walk(name, 0, nd)
 
+extern void init_address_space(struct address_space *mapping,
+		const struct super_block *sb, struct inode *host,
+		const int gfp_mask);
+
 extern void inode_init_once(struct inode *);
 extern void iput(struct inode *);
 extern void force_delete(struct inode *);
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Sun May  5 03:10:53 2002
+++ b/kernel/ksyms.c	Sun May  5 03:10:53 2002
@@ -140,6 +140,7 @@
 EXPORT_SYMBOL(iget4);
 EXPORT_SYMBOL(iput);
 EXPORT_SYMBOL(inode_init_once);
+EXPORT_SYMBOL(init_address_space);
 EXPORT_SYMBOL(force_delete);
 EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(follow_down);


===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020505013345|32446
## Wrapped with gzip_uu ##


begin 664 bkpatch2125
M'XL(`*V4U#P``\58;4_;2!#^'/^*D2HAH"3Q^B5V4H&@A9:H[8$"/?6DDZR-
MO<8K'-OR;DAI<__]9M<X[S2`6K4@$L_./C.S\\SLN*^@?]IKR+R\HVDDCJE,
MTCQKR9)F8L0D;87Y:/HNH=D-NV)R:IFFA3\N\6S3[4Q)QW2\:4@B0JA#6&1:
MCM]QC%?P1;"RUZ"<6@2?SG,A>XV09I(.6QF3*!KD.8K:8U&V11FV4YZ-OS6M
MEMN\BX6!ZY=4A@G<L5+T&J1ESR3ROF"]QN#LPY=/)P/#.#R$F7-P>&C\VCAF
M:`7+;L9\"YQKVA8Q'=N=VE;7](Q3("TT`*;5-EW\Q2\]V^XY[FN3]$P3].D<
MST\%7MO0-(VW\&N#>&>$\/?[JQZ<1!&P;T5>2A9!/,Y"F6?`,RX#&D4E$R(0
M!0W9[A[0+`(YR7$1\\(@86F!B4"_$$HDM&00YA&#(9,3QA!#ZAT\0V&@`?-L
MAD/3-`\#O;:[UT*`ZX2+RCQ'^VIY@L\\92#NA60C94>[Q6G*OS,H2GY')8,'
M)T$[*1!HPF62CR7(A$'&,";<=YOE$Z##6KRT!T$E*S.:BI;Q$6S+<3K&Y9P^
M1O.9_PS#I*9QM"5=MVB2I>U;<3\2K7`Q9UV[.\5/TYYZD6?'/@TC-_:MKA>N
M46,CBHL_Q+81Q70MV]_J22S:.@VK7OA39`KI3H<F\6V?Q5TSBH8=FZQ[L8HP
M]\#M$-_:Z@'/PG0<L:K:V[%H):OG03JN[4T[)NOZ?N3%<=09LLZZ(X\!S1VR
M;,_R=7^8.[V]03SWB`QZ6XR.O_-"[6[1\1J`8RL,FUC8$P@Z5/6$U99@=Q]M
M"2[V!.+]EJ:@^L'SRG]S\2/4D\O_(U1,N8!F.=&_6$>7"SEZ017V/0M<8@A)
M)0]KI^]R'L%28`NN"5F.0[F\#/LC6A0\N]DS?AB-_E_]ZV!P<MK_&EP/SLYV
M=QX6FT<%O6&!+!D[@`_O+X.3ZXO/_7=[;XQ&.<%(;[65576UH%0TZJ?^U75P
M?G9RNJ`5IHQF@=(5/]6+>"GOGZ"G#++H"8H\?XI2,,+O3U`)-#\BI2E0'FPZ
M$/Z@5!_*?\:_=>HVI27(D7M4714"V*C`Z&E>B#?S38OY#H(-?/YIL@^,1B-$
M;%D;%V.T%PR5<[`OA@>U7-,3]A.<9.9[\$*!F[@(1E3<:MK,HLQ*?:QP".:;
M!3'%<)1P9S&4^;)"QU7UL2A66>=X8I,$ZVT%L3:/\OKKXG))@]J1G8C%=)S*
MH):A'H]A5PQA9P?$L'DD@F'$[O8PO$W[YQK-HV%4E;1._*INE=/V_KX!^QL:
M##07;W>*5_=D^9Y6VXX?4'&&7+K"ET8#K2B&O49#9PVJK*'*).$X*M88V*JP
M8=X(V,T+122:[NF=B9Y*J\3.-JFI876CUJY/M]=(<,1`?=W9U&"B@T8=I=:?
M1[8^?\QPU>0"U94.#UD1NEL*;/G:+X6E!#.SK=I`K$(&KC!9R&/DQ0&,!5-#
M&#J5#R7EV9+M/-:/):/8$!/\JV!F5A]6"RQ))'-U@IAB'F)_RW&EG'`$5P:4
MVK+/"F@.JSQL&[H._W`5/M;VZP:/Q-_8*6IO0%G4-N:X%:E//1>(<4I,&QRC
M3\P./C4V@^W,"B2BDE:86E3=&^?]#^=?KLX&"(QP/MCX87N(>DH<5S\Y7;#0
MAFLJ&X^%M&P%P=3$LSX=;9]\7CB:&7>\S)'7,FD58MQBT?@GLQE!",]UIX3@
MR>E1B)C=9\Q"SN]Z/5*34,3"E%8W#<1Y.>?P?#!2XTLU5ZZ,+^LAOV2,(9;=
M00*P;^HM!?YT(:DK5I%I^<UC.Y%>\KYC%".681<]9IG@HT=A%(,\R[8)3N-8
M'II!OO,,`I'?2:#JU7J9.VR9//HU;84[RX&^B#>.A2WB[.OEQ>`ZN/KG\]N+
B3[OK'JC>4/\G2IBP\%:,1X=^-^SZ;MPU_@>X0DH4!A(`````
`
end

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318899AbSHMBZa>; Mon, 12 Aug 2002 21:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318900AbSHMBZa>; Mon, 12 Aug 2002 21:25:30 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:37343 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318899AbSHMBZ2>; Mon, 12 Aug 2002 21:25:28 -0400
Subject: [BK-PATCH-2.5] NTFS 2.0.25 - Minor bugfixes and cleanups
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 13 Aug 2002 02:29:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17eQUn-00089u-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks! A very minor bugfix and cleanups. Just to flush all changes
before starting with change sets adding write code...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    2 ++
 fs/ntfs/ChangeLog                  |   10 ++++++++++
 fs/ntfs/Makefile                   |    2 +-
 fs/ntfs/aops.c                     |   19 ++++++++++++++++---
 fs/ntfs/file.c                     |    3 ---
 5 files changed, 29 insertions(+), 7 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/08/13 1.475)
   NTFS: 2.0.25 - Small bug fixes and cleanups.
   - Unlock the page in an out of memory error code path in
     fs/ntfs/aops.c::ntfs_read_block().
   - If fs/ntfs/aops.c::ntfs_read_page() is called on an uptodate page,
     just unlock the page and return. (This can happen due to ->writepage
     clearing PageUptodate() during write out of MstProtected()
     attributes.
   - Remove leaked write code again.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Tue Aug 13 00:55:35 2002
+++ b/Documentation/filesystems/ntfs.txt	Tue Aug 13 00:55:35 2002
@@ -247,6 +247,8 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.25:
+	- Minor bugfixes in error code paths and small cleanups.
 2.0.24:
 	- Small internal cleanups.
 	- Support for sendfile system call. (Christoph Hellwig)
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Tue Aug 13 00:55:35 2002
+++ b/fs/ntfs/ChangeLog	Tue Aug 13 00:55:35 2002
@@ -2,6 +2,16 @@
 	- Find and fix bugs.
 	- Enable NFS exporting of NTFS.
 
+2.0.25 - Small bug fixes and cleanups.
+
+	- Unlock the page in an out of memory error code path in
+	  fs/ntfs/aops.c::ntfs_read_block().
+	- If fs/ntfs/aops.c::ntfs_read_page() is called on an uptodate page,
+	  just unlock the page and return. (This can happen due to ->writepage
+	  clearing PageUptodate() during write out of MstProtected()
+	  attributes.
+	- Remove leaked write code again.
+
 2.0.24 - Cleanups.
 
 	- Treat BUG_ON() as ASSERT() not VERIFY(), i.e. do not use side effects
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Tue Aug 13 00:55:35 2002
+++ b/fs/ntfs/Makefile	Tue Aug 13 00:55:35 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.24\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.25\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Tue Aug 13 00:55:35 2002
+++ b/fs/ntfs/aops.c	Tue Aug 13 00:55:35 2002
@@ -156,6 +156,9 @@
  * applies the mst fixups to the page before finally marking it uptodate and
  * unlocking it.
  *
+ * We only enforce allocated_size limit because i_size is checked for in
+ * generic_file_read().
+ *
  * Return 0 on success and -errno on error.
  *
  * Contains an adapted version of fs/buffer.c::block_read_full_page().
@@ -182,8 +185,10 @@
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
 	bh = head = page_buffers(page);
-	if (unlikely(!bh))
+	if (unlikely(!bh)) {
+		unlock_page(page);
 		return -ENOMEM;
+	}
 
 	iblock = page->index << (PAGE_CACHE_SHIFT - blocksize_bits);
 	lblock = (ni->allocated_size + blocksize - 1) >> blocksize_bits;
@@ -343,8 +348,16 @@
 	u32 attr_len;
 	int err = 0;
 
-	if (unlikely(!PageLocked(page)))
-		PAGE_BUG(page);
+	BUG_ON(!PageLocked(page));
+
+	/*
+	 * This can potentially happen because we clear PageUptodate() during
+	 * ntfs_writepage() of MstProtected() attributes.
+	 */
+	if (PageUptodate(page)) {
+		unlock_page(page);
+		return 0;
+	}
 
 	ni = NTFS_I(page->mapping->host);
 
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	Tue Aug 13 00:55:35 2002
+++ b/fs/ntfs/file.c	Tue Aug 13 00:55:35 2002
@@ -51,9 +51,6 @@
 struct file_operations ntfs_file_ops = {
 	.llseek		= generic_file_llseek,	/* Seek inside file. */
 	.read		= generic_file_read,	/* Read from file. */
-#ifdef NTFS_RW
-	.write		= generic_file_write,	/* Write to a file. */
-#endif
 	.mmap		= generic_file_mmap,	/* Mmap file. */
 	.sendfile	= generic_file_sendfile,/* Zero-copy data send with the
 						   data source being on the

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch14123
M'XL(`/=*6#T``^U86W/31A1^EG[%`5Z<4-M[T4JV&#-<`C1#@$Q"VCYDQK.6
M5K:*+7FD%9!6_>\]J\T%VQ$D)NE3DXPRWNR>VW?.]ZWR"$Y*582.3"6C[B/X
M-2]UZ$0RTW+2RY3&I:,\QZ5^51;]LHCZ.INZN'HH=32#SZHH0X?V^.6*/ENJ
MT#EZ]>;DX/F1ZXY&\'(FLZDZ5AI&(U?GQ6<YC\MG4L_F>=;3A<S*A=*R%^6+
M^G)KS0AA^"UHP(GP:^H3+Z@C&E,J/:IBPKR![UU9F^4+]7U;`TH)]0CG->/>
M<.CN`>UY@0#"^F30IQP("84(*7E,:$@(-`5Y=E4(>"R@2]P7<+<9O'0C>/_Q
M]7$(K$=Z#'W`\4+.YS"III"D7U4),HLAFBN95<NRA]N[<)+-\^@3Z)F"I9PJ
M2#/<!'FE(4]@H19Y<0:J*/("HCPV>_0,]^!1@*3L9QH?,D=C41B:#^-"R7@\
M,38[.];#?O*=G<9G9P?2$B*,5,60-_ZKI<YCJ6U,OS3>_JQ*#=5:M":?0NFJ
MR'K0^3AKS&0PD\NERB"N%%88ND^_%*E69G]CR.1?I-D4FVRJ3LX=80QQU:PV
MFR\*\*[4AT6N5:15W-EICDNMBW12:75>P".LT6<%:/03AF]/-Z624YEF/?<M
M,"Z(<`^OFM?MWO++=8DD[E-X\;:^*.4[=)>D<U7384`(]B/A9"B&-<$/09VH
MB$X$%=2+"9]L=N"FF?/&9MC1C`UK3ID_6/5HMO6BZ_SQ6B4J\0:Q"`:*35C$
MVQV>6UESQZC/N76WET?50N$YG>99L[T\*[5:V/,]_55?$P*A=2"(KP*2,.5/
MX@F?;(9P`\O?A,6YJ`4+UJM@03S(I]=%X==QXB=#23$8E?`@\=H+<67HRJD0
M)*B91SU_U:F=F^L\,K,HO8#16/E<4I&T>SRWLEYZ,O0&#;G^N#Z&=>\0(G=[
MB`B:]WP^K#%UXC4,S-D*`7L\Y**5@-E]$?#)LN&M!`G3LK!A`-M''Z!;?&E^
M<*(/;U#N+7ABGWE#8*YU';I.%]ZE&<:"$F`5`/E]C<ZM*I2-4EQI@VF(C58]
MQW_+6=B$NVT6#+I\*&@M?!K0!EU*_75])4$KO)3\I_C:D5W#=R.Y;>#T@!+W
MAG)^:N#>4L^=&\FY<R=J[MR1F#L_I>7.JI0[/U;RTY6AN%#.M9FXE2ZW3\2:
M+IN!H,+S&UT.FH'P@U6Z8R$;ML\#=.E]CH.YNR.+F5FP-X>66;A(:XM1V!L`
M=??-X]4?'X^>CU^^/GC^YAA&T-TSE][Q;Z^.CO<_O!^=/K3C<OIP!2[;K&M@
MW497V[%:T57B,8XW(E+[5!#[:C!@MT'*ARZ_%ZC^O^O_U%T?6;ZY*;5TMDUW
M&XJG8@#<A5WX'4/)Y@A!ANH28<)S+`#&&X_+]"_DI721:IBH2%8E8F<7315F
M*C*$920)T4)#4Y6I(HW&9M*:TAMX8-?=HP-AALC\8JZ3)M#!(J>?U/RL\V`R
MV]F!OUW'L76W:)G'SA-SPL>#SC_N'O=\/+O/O<`HD_/BY,WXP_O.`U/?@]S$
M8<_@(92C_B[2["Y<@K7$\F8ZQ<3.+H"[R.>+LF!=CU1CINFD2WSQ;QN@K3(Z
M[/9MDBLF;7AMF3J.;3$@3TRZWS*(?7-98Y#;O!2U,\C*2]$EUYM+H^7ZM;O/
M]QF$W!>!W.!-MWF-:YD0F^0VS"\\')#+_PHU_5Y6BQ'C`=:**_=??8-B''D2
"````
`
end

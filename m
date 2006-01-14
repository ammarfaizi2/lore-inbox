Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWANIzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWANIzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 03:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWANIzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 03:55:09 -0500
Received: from mx1.mail.ru ([194.67.23.121]:7479 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1750803AbWANIzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 03:55:06 -0500
Date: Sat, 14 Jan 2006 11:42:06 +0300
From: Evgeniy <dushistov@mail.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2.6.15] ufs cleanup v. 2
Message-ID: <20060114084206.GA23126@rain.homenetwork>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060113005450.GA7971@mipter.zuzino.mipt.ru> <Pine.LNX.4.64.0601121700041.3535@g5.osdl.org> <20060113102136.GA7868@mipter.zuzino.mipt.ru> <Pine.LNX.4.64.0601130739540.3535@g5.osdl.org> <20060113190524.GA31715@rain.homenetwork> <Pine.LNX.4.64.0601131144520.13339@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601131144520.13339@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 11:51:28AM -0800, Linus Torvalds wrote:
> I was thinking of something even more abstracted:
> 
> 	static inline void *get_usb_offset(struct ufs_sb_private_info *uspi,
> 		unsigned int offset)
> 	{
> 		unsigned int index;
> 
> 		index = offset >> uspi->s_fshift;
> 		offset &= ~uspi->s_fmask;
> 		return uspi->s_ubh.bh[index]->b_data + offset;
> 	}
> Hmm?

Yes, this is much better then my suggestion.

Here is update of ufs cleanup patch,
it also includes
* fix compilation warnings which appears if debug mode turn on
* remove unnecessary duplication of code to support UFS2

I tested it on ufs1 and ufs2 file-systems.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/fs/ufs/balloc.c linux-2.6.15/fs/ufs/balloc.c
--- linux-2.6.15-vanilla/fs/ufs/balloc.c	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15/fs/ufs/balloc.c	2006-01-14 09:50:06.768125250 +0300
@@ -48,7 +48,7 @@ void ufs_free_fragments (struct inode * 
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	
 	UFSD(("ENTER, fragment %u, count %u\n", fragment, count))
 	
@@ -80,8 +80,9 @@ void ufs_free_fragments (struct inode * 
 	for (i = bit; i < end_bit; i++) {
 		if (ubh_isclr (UCPI_UBH, ucpi->c_freeoff, i))
 			ubh_setbit (UCPI_UBH, ucpi->c_freeoff, i);
-		else ufs_error (sb, "ufs_free_fragments",
-			"bit already cleared for fragment %u", i);
+		else 
+			ufs_error (sb, "ufs_free_fragments",
+				   "bit already cleared for fragment %u", i);
 	}
 	
 	DQUOT_FREE_BLOCK (inode, count);
@@ -142,7 +143,7 @@ void ufs_free_blocks (struct inode * ino
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 
 	UFSD(("ENTER, fragment %u, count %u\n", fragment, count))
 	
@@ -246,7 +247,7 @@ unsigned ufs_new_fragments (struct inode
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	*err = -ENOSPC;
 
 	lock_super (sb);
@@ -406,7 +407,7 @@ ufs_add_fragments (struct inode * inode,
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first (USPI_UBH);
+	usb1 = ubh_get_usb_first (uspi);
 	count = newcount - oldcount;
 	
 	cgno = ufs_dtog(fragment);
@@ -489,7 +490,7 @@ static unsigned ufs_alloc_fragments (str
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	oldcg = cgno;
 	
 	/*
@@ -605,7 +606,7 @@ static unsigned ufs_alloccg_block (struc
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	ucg = ubh_get_ucg(UCPI_UBH);
 
 	if (goal == 0) {
@@ -662,7 +663,7 @@ static unsigned ufs_bitmap_search (struc
 	UFSD(("ENTER, cg %u, goal %u, count %u\n", ucpi->c_cgx, goal, count))
 
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first (USPI_UBH);
+	usb1 = ubh_get_usb_first (uspi);
 	ucg = ubh_get_ucg(UCPI_UBH);
 
 	if (goal)
diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/fs/ufs/ialloc.c linux-2.6.15/fs/ufs/ialloc.c
--- linux-2.6.15-vanilla/fs/ufs/ialloc.c	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15/fs/ufs/ialloc.c	2006-01-14 09:50:06.924135000 +0300
@@ -72,7 +72,7 @@ void ufs_free_inode (struct inode * inod
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	
 	ino = inode->i_ino;
 
@@ -167,7 +167,7 @@ struct inode * ufs_new_inode(struct inod
 	ufsi = UFS_I(inode);
 	sbi = UFS_SB(sb);
 	uspi = sbi->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 
 	lock_super (sb);
 
diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/fs/ufs/inode.c linux-2.6.15/fs/ufs/inode.c
--- linux-2.6.15-vanilla/fs/ufs/inode.c	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15/fs/ufs/inode.c	2006-01-14 09:50:06.964137500 +0300
@@ -61,7 +61,7 @@ static int ufs_block_to_path(struct inod
 	int n = 0;
 
 
-	UFSD(("ptrs=uspi->s_apb = %d,double_blocks=%d \n",ptrs,double_blocks));
+	UFSD(("ptrs=uspi->s_apb = %d,double_blocks=%ld \n",ptrs,double_blocks));
 	if (i_block < 0) {
 		ufs_warning(inode->i_sb, "ufs_block_to_path", "block < 0");
 	} else if (i_block < direct_blocks) {
@@ -104,7 +104,7 @@ u64  ufs_frag_map(struct inode *inode, s
 	unsigned flags = UFS_SB(sb)->s_flags;
 	u64 temp = 0L;
 
-	UFSD((": frag = %lu  depth = %d\n",frag,depth));
+	UFSD((": frag = %llu  depth = %d\n", (unsigned long long)frag, depth));
 	UFSD((": uspi->s_fpbshift = %d ,uspi->s_apbmask = %x, mask=%llx\n",uspi->s_fpbshift,uspi->s_apbmask,mask));
 
 	if (depth == 0)
@@ -365,9 +365,10 @@ repeat:
 		sync_dirty_buffer(bh);
 	inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
+	UFSD(("result %u\n", tmp + blockoff));
 out:
 	brelse (bh);
-	UFSD(("EXIT, result %u\n", tmp + blockoff))
+	UFSD(("EXIT\n"));
 	return result;
 }
 
@@ -386,7 +387,7 @@ static int ufs_getfrag_block (struct ino
 	
 	if (!create) {
 		phys64 = ufs_frag_map(inode, fragment);
-		UFSD(("phys64 = %lu \n",phys64));
+		UFSD(("phys64 = %llu \n",phys64));
 		if (phys64)
 			map_bh(bh_result, sb, phys64);
 		return 0;
@@ -401,7 +402,7 @@ static int ufs_getfrag_block (struct ino
 
 	lock_kernel();
 
-	UFSD(("ENTER, ino %lu, fragment %u\n", inode->i_ino, fragment))
+	UFSD(("ENTER, ino %lu, fragment %llu\n", inode->i_ino, (unsigned long long)fragment))
 	if (fragment < 0)
 		goto abort_negative;
 	if (fragment >
diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/fs/ufs/super.c linux-2.6.15/fs/ufs/super.c
--- linux-2.6.15-vanilla/fs/ufs/super.c	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15/fs/ufs/super.c	2006-01-14 09:50:07.036142000 +0300
@@ -221,7 +221,7 @@ void ufs_error (struct super_block * sb,
 	va_list args;
 
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	
 	if (!(sb->s_flags & MS_RDONLY)) {
 		usb1->fs_clean = UFS_FSBAD;
@@ -253,7 +253,7 @@ void ufs_panic (struct super_block * sb,
 	va_list args;
 	
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	
 	if (!(sb->s_flags & MS_RDONLY)) {
 		usb1->fs_clean = UFS_FSBAD;
@@ -420,21 +420,18 @@ static int ufs_read_cylinder_structures 
 		if (i + uspi->s_fpb > blks)
 			size = (blks - i) * uspi->s_fsize;
 
-		if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
+		if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) 
 			ubh = ubh_bread(sb,
 				fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_csaddr) + i, size);
-			if (!ubh)
-				goto failed;
-			ubh_ubhcpymem (space, ubh, size);
-			sbi->s_csp[ufs_fragstoblks(i)]=(struct ufs_csum *)space;
-		}
-		else {
+		else 
 			ubh = ubh_bread(sb, uspi->s_csaddr + i, size);
-			if (!ubh)
-				goto failed;
-			ubh_ubhcpymem(space, ubh, size);
-			sbi->s_csp[ufs_fragstoblks(i)]=(struct ufs_csum *)space;
-		}
+		
+		if (!ubh)
+			goto failed;
+
+		ubh_ubhcpymem (space, ubh, size);
+		sbi->s_csp[ufs_fragstoblks(i)]=(struct ufs_csum *)space;
+
 		space += size;
 		ubh_brelse (ubh);
 		ubh = NULL;
@@ -539,6 +536,7 @@ static int ufs_fill_super(struct super_b
 	struct inode *inode;
 	unsigned block_size, super_block_size;
 	unsigned flags;
+	unsigned super_block_offset;
 
 	uspi = NULL;
 	ubh = NULL;
@@ -586,10 +584,11 @@ static int ufs_fill_super(struct super_b
 	if (!uspi)
 		goto failed;
 
+	super_block_offset=UFS_SBLOCK;
+
 	/* Keep 2Gig file limit. Some UFS variants need to override 
 	   this but as I don't know which I'll let those in the know loosen
 	   the rules */
-	   
 	switch (sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) {
 	case UFS_MOUNT_UFSTYPE_44BSD:
 		UFSD(("ufstype=44bsd\n"))
@@ -601,7 +600,8 @@ static int ufs_fill_super(struct super_b
 		flags |= UFS_DE_44BSD | UFS_UID_44BSD | UFS_ST_44BSD | UFS_CG_44BSD;
 		break;
 	case UFS_MOUNT_UFSTYPE_UFS2:
-		UFSD(("ufstype=ufs2\n"))
+		UFSD(("ufstype=ufs2\n"));
+		super_block_offset=SBLOCK_UFS2;
 		uspi->s_fsize = block_size = 512;
 		uspi->s_fmask = ~(512 - 1);
 		uspi->s_fshift = 9;
@@ -725,19 +725,16 @@ again:	
 	/*
 	 * read ufs super block from device
 	 */
-	if ( (flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {
-		ubh = ubh_bread_uspi(uspi, sb, uspi->s_sbbase + SBLOCK_UFS2/block_size, super_block_size);
-	}
-	else {
-		ubh = ubh_bread_uspi(uspi, sb, uspi->s_sbbase + UFS_SBLOCK/block_size, super_block_size);
-	}
+
+	ubh = ubh_bread_uspi(uspi, sb, uspi->s_sbbase + super_block_offset/block_size, super_block_size);
+	
 	if (!ubh) 
             goto failed;
 
 	
-	usb1 = ubh_get_usb_first(USPI_UBH);
-	usb2 = ubh_get_usb_second(USPI_UBH);
-	usb3 = ubh_get_usb_third(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
+	usb2 = ubh_get_usb_second(uspi);
+	usb3 = ubh_get_usb_third(uspi);
 	usb  = (struct ufs_super_block *)
 		((struct ufs_buffer_head *)uspi)->bh[0]->b_data ;
 
@@ -1006,8 +1003,8 @@ static void ufs_write_super (struct supe
 	UFSD(("ENTER\n"))
 	flags = UFS_SB(sb)->s_flags;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
-	usb3 = ubh_get_usb_third(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
+	usb3 = ubh_get_usb_third(uspi);
 
 	if (!(sb->s_flags & MS_RDONLY)) {
 		usb1->fs_time = cpu_to_fs32(sb, get_seconds());
@@ -1049,8 +1046,8 @@ static int ufs_remount (struct super_blo
 	
 	uspi = UFS_SB(sb)->s_uspi;
 	flags = UFS_SB(sb)->s_flags;
-	usb1 = ubh_get_usb_first(USPI_UBH);
-	usb3 = ubh_get_usb_third(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
+	usb3 = ubh_get_usb_third(uspi);
 	
 	/*
 	 * Allow the "check" option to be passed as a remount option.
@@ -1124,7 +1121,7 @@ static int ufs_statfs (struct super_bloc
 	lock_kernel();
 
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first (USPI_UBH);
+	usb1 = ubh_get_usb_first (uspi);
 	usb  = (struct ufs_super_block *)
 		((struct ufs_buffer_head *)uspi)->bh[0]->b_data ;
 	
diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/fs/ufs/util.h linux-2.6.15/fs/ufs/util.h
--- linux-2.6.15-vanilla/fs/ufs/util.h	2006-01-14 09:47:20.429729750 +0300
+++ linux-2.6.15/fs/ufs/util.h	2006-01-14 09:59:08.261966500 +0300
@@ -249,18 +249,28 @@ extern void _ubh_memcpyubh_(struct ufs_s
 
 
 /*
- * macros to get important structures from ufs_buffer_head
+ * macros and inline function to get important structures from ufs_sb_private_info
  */
-#define ubh_get_usb_first(ubh) \
-	((struct ufs_super_block_first *)((ubh)->bh[0]->b_data))
 
-#define ubh_get_usb_second(ubh) \
-	((struct ufs_super_block_second *)((ubh)->\
-					   bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE & ~uspi->s_fmask)))
-
-#define ubh_get_usb_third(ubh) \
-	((struct ufs_super_block_third *)((ubh)-> \
-	bh[UFS_SECTOR_SIZE*2 >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE*2 & ~uspi->s_fmask)))
+static inline void *get_usb_offset(struct ufs_sb_private_info *uspi,
+				   unsigned int offset)
+{
+	unsigned int index;
+	
+	index = offset >> uspi->s_fshift;
+	offset &= ~uspi->s_fmask;
+	return uspi->s_ubh.bh[index]->b_data + offset;
+}
+
+#define ubh_get_usb_first(uspi) \
+	((struct ufs_super_block_first *)get_usb_offset((uspi), 0))
+
+#define ubh_get_usb_second(uspi) \
+	((struct ufs_super_block_second *)get_usb_offset((uspi), UFS_SECTOR_SIZE))
+
+#define ubh_get_usb_third(uspi)	\
+	((struct ufs_super_block_third *)get_usb_offset((uspi), 2*UFS_SECTOR_SIZE))
+
 
 #define ubh_get_ucg(ubh) \
 	((struct ufs_cylinder_group *)((ubh)->bh[0]->b_data))

-- 
/Evgeniy


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262610AbRE3FT5>; Wed, 30 May 2001 01:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbRE3FTr>; Wed, 30 May 2001 01:19:47 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:48635 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262611AbRE3FTj>; Wed, 30 May 2001 01:19:39 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105300517.f4U5HDh1020959@webber.adilger.int>
Subject: Re: [CHECKER] 84 bugs in 2.4.4/2.4.4-ac8 where NULL pointers are deref'd
In-Reply-To: <200105292149.OAA29781@csl.Stanford.EDU> "from Dawson Engler at
 May 29, 2001 02:49:50 pm"
To: Dawson Engler <engler@csl.stanford.edu>
Date: Tue, 29 May 2001 23:17:13 -0600 (MDT)
CC: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, daniel.pirkl@email.cz,
        mikulas@artax.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler writes:
> enclosed are 84 potential errors where code
> 	(1) checks if a pointer is null
> 	(2) dereferences it anyway.
> ---------------------------------------------------------
> [BUG]  seems like it.  it's not guarded.  or is there some weird dependence?
> /u2/engler/mc/oses/linux/2.4.4-ac8/fs/ext2/dir.c:61:ext2_check_dir_entry: ERROR:INTERNAL_NULL:53:61: [type=set] (set at line 53) Dereferencing NULL ptr "dir" illegally!
> ---------------------------------------------------------
> [BUG] [GEM] another blow up because of error printouts
> /u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/dir.c:215:hpfs_lookup: ERROR:INTERNAL_NULL:213:215: [type=set] (set at line 213) Dereferencing NULL ptr "result" illegally!
> ---------------------------------------------------------
> [BUG]  seems to blow up with malformed input.
> /u2/engler/mc/oses/linux/2.4.4-ac8/fs/hpfs/super.c:215:parse_opts: ERROR:INTERNAL_NULL:180:215: [type=null] (set at line 180) WARN: Passing NULL pointer "rhs" as arg 0 to function strcmp
> ---------------------------------------------------------
> [BUG] seems identical to the ext2 one.
> /u2/engler/mc/oses/linux/2.4.4-ac8/fs/ufs/dir.c:178:ufs_check_dir_entry: ERROR:INTERNAL_NULL:170:178: [type=set] (set at line 170) Dereferencing NULL ptr "dir" illegally!
> ---------------------------------------------------------
> [BUG]  looks bad.
> /u2/engler/mc/oses/linux/2.4.4-ac8/fs/ufs/super.c:271:ufs_parse_options: ERROR:INTERNAL_NULL:267:271: [type=null] (set at line 267) WARN: Passing NULL pointer "value" as arg 0 to function strcmp

OK, attached is a patch which fixes the above checker bugs under fs/.

For ufs/dir.c it was overzealous verification (and or copying from ext2) -
dir could not be NULL (the supplied pointer is dereferenced in each of
the calling functions before ufs_check_dir_entry() is called).

For ext2 it is pretty much the same, except ext2_delete_entry() called
ext2_check_dir_entry() with a NULL input (for some reason), but it could
easily supply a valid input value.  All callers to ext2_delete_entry()
dereference the dir parameter before calling ext2_delete_entry().  All
other paths dereference dir before ext2_check_dir_entry() is called.

UFS and HPFS maintainers CC'd in case they want to object, but it is
pretty straight forward stuff.

Cheers, Andreas
===========================================================================
diff -ru linux-2.4.5.orig/fs/ext2/dir.c linux-2.4.5-aed/fs/ext2/dir.c
--- linux-2.4.5.orig/fs/ext2/dir.c	Fri Dec  8 18:35:54 2000
+++ linux-2.4.5-aed/fs/ext2/dir.c	Tue May 29 19:42:02 2001
@@ -40,17 +43,18 @@
 			  unsigned long offset)
 {
 	const char * error_msg = NULL;
+	int rlen = le16_to_cpu(de->rec_len);
 
-	if (le16_to_cpu(de->rec_len) < EXT2_DIR_REC_LEN(1))
+	if (rlen < EXT2_DIR_REC_LEN(1))
 		error_msg = "rec_len is smaller than minimal";
-	else if (le16_to_cpu(de->rec_len) % 4 != 0)
+	else if (rlen % 4 != 0)
 		error_msg = "rec_len % 4 != 0";
-	else if (le16_to_cpu(de->rec_len) < EXT2_DIR_REC_LEN(de->name_len))
+	else if (rlen < EXT2_DIR_REC_LEN(de->name_len))
 		error_msg = "rec_len is too small for name_len";
-	else if (dir && ((char *) de - bh->b_data) + le16_to_cpu(de->rec_len) >
-		 dir->i_sb->s_blocksize)
+	else if (((char *) de - bh->b_data) + rlen > dir->i_sb->s_blocksize)
 		error_msg = "directory entry across blocks";
-	else if (dir && le32_to_cpu(de->inode) > le32_to_cpu(dir->i_sb->u.ext2_sb.s_es->s_inodes_count))
+	else if (le32_to_cpu(de->inode) >
+		 le32_to_cpu(dir->i_sb->u.ext2_sb.s_es->s_inodes_count))
 		error_msg = "inode out of bounds";
 
 	if (error_msg != NULL)
@@ -58,7 +62,7 @@
 			    "offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
 			    dir->i_ino, error_msg, offset,
 			    (unsigned long) le32_to_cpu(de->inode),
-			    le16_to_cpu(de->rec_len), de->name_len);
+			    rlen, de->name_len);
 	return error_msg == NULL ? 1 : 0;
 }
 
diff -ru linux-2.4.5.orig/fs/ext2/namei.c linux-2.4.5-aed/fs/ext2/namei.c
--- linux-2.4.5.orig/fs/ext2/namei.c	Tue Apr 10 16:43:25 2001
+++ linux-2.4.5-aed/fs/ext2/namei.c	Tue May 29 19:40:10 2001
@@ -327,8 +327,7 @@
 	pde = NULL;
 	de = (struct ext2_dir_entry_2 *) bh->b_data;
 	while (i < bh->b_size) {
-		if (!ext2_check_dir_entry ("ext2_delete_entry", NULL, 
-					   de, bh, i))
+		if (!ext2_check_dir_entry("ext2_delete_entry", dir, de, bh, i))
 			return -EIO;
 		if (de == de_del)  {
 			if (pde)
diff -ru linux-2.4.5.orig/fs/hpfs/dir.c linux-2.4.5-aed/fs/hpfs/dir.c
--- linux-2.4.5.orig/fs/hpfs/dir.c	Fri Aug 11 15:29:01 2000
+++ linux-2.4.5-aed/fs/hpfs/dir.c	Tue May 29 19:32:57 2001
@@ -212,7 +212,7 @@
 	hpfs_lock_iget(dir->i_sb, de->directory || (de->ea_size && dir->i_sb->s_hpfs_eas) ? 1 : 2);
 	if (!(result = iget(dir->i_sb, ino))) {
 		hpfs_unlock_iget(dir->i_sb);
-		hpfs_error(result->i_sb, "hpfs_lookup: can't get inode");
+		hpfs_error(dir->i_sb, "hpfs_lookup: can't get inode");
 		goto bail1;
 	}
 	if (!de->directory) result->i_hpfs_parent_dir = dir->i_ino;
diff -ru linux-2.4.5.orig/fs/hpfs/super.c linux-2.4.5-aed/fs/hpfs/super.c
--- linux-2.4.5.orig/fs/hpfs/super.c	Tue May  8 17:17:20 2001
+++ linux-2.4.5-aed/fs/hpfs/super.c	Tue May 29 20:16:22 2001
@@ -212,6 +212,8 @@
 				return 0;
 		}
 		else if (!strcmp(p, "case")) {
+			if (!rhs || !*rhs)
+				return 0;
 			if (!strcmp(rhs, "lower"))
 				*lowercase = 1;
 			else if (!strcmp(rhs, "asis"))
@@ -220,6 +222,8 @@
 				return 0;
 		}
 		else if (!strcmp(p, "conv")) {
+			if (!rhs || !*rhs)
+				return 0;
 			if (!strcmp(rhs, "binary"))
 				*conv = CONV_BINARY;
 			else if (!strcmp(rhs, "text"))
@@ -230,6 +234,8 @@
 				return 0;
 		}
 		else if (!strcmp(p, "check")) {
+			if (!rhs || !*rhs)
+				return 0;
 			if (!strcmp(rhs, "none"))
 				*chk = 0;
 			else if (!strcmp(rhs, "normal"))
@@ -240,6 +246,8 @@
 				return 0;
 		}
 		else if (!strcmp(p, "errors")) {
+			if (!rhs || !*rhs)
+				return 0;
 			if (!strcmp(rhs, "continue"))
 				*errs = 0;
 			else if (!strcmp(rhs, "remount-ro"))
@@ -250,6 +258,8 @@
 				return 0;
 		}
 		else if (!strcmp(p, "eas")) {
+			if (!rhs || !*rhs)
+				return 0;
 			if (!strcmp(rhs, "no"))
 				*eas = 0;
 			else if (!strcmp(rhs, "ro"))
@@ -260,6 +270,8 @@
 				return 0;
 		}
 		else if (!strcmp(p, "chkdsk")) {
+			if (!rhs || !*rhs)
+				return 0;
 			if (!strcmp(rhs, "no"))
 				*chkdsk = 0;
 			else if (!strcmp(rhs, "errors"))
diff -ru linux-2.4.5.orig/fs/ufs/dir.c linux-2.4.5-aed/fs/ufs/dir.c
--- linux-2.4.5.orig/fs/ufs/dir.c	Fri Aug 11 15:29:02 2000
+++ linux-2.4.5-aed/fs/ufs/dir.c	Tue May 29 20:10:35 2001
@@ -152,22 +152,23 @@
 	struct super_block * sb;
 	const char * error_msg;
 	unsigned flags, swab;
-	
+	int rlen = SWAB16(de->d_reclen);
+
 	sb = dir->i_sb;
 	flags = sb->u.ufs_sb.s_flags;
 	swab = sb->u.ufs_sb.s_swab;
 	error_msg = NULL;
-			
-	if (SWAB16(de->d_reclen) < UFS_DIR_REC_LEN(1))
+
+	if (rlen < UFS_DIR_REC_LEN(1))
 		error_msg = "reclen is smaller than minimal";
-	else if (SWAB16(de->d_reclen) % 4 != 0)
+	else if (rlen % 4 != 0)
 		error_msg = "reclen % 4 != 0";
-	else if (SWAB16(de->d_reclen) < UFS_DIR_REC_LEN(ufs_get_de_namlen(de)))
+	else if (rlen < UFS_DIR_REC_LEN(ufs_get_de_namlen(de)))
 		error_msg = "reclen is too small for namlen";
-	else if (dir && ((char *) de - bh->b_data) + SWAB16(de->d_reclen) >
-		 dir->i_sb->s_blocksize)
+	else if (((char *) de - bh->b_data) + rlen > dir->i_sb->s_blocksize)
 		error_msg = "directory entry across blocks";
-	else if (dir && SWAB32(de->d_ino) > (sb->u.ufs_sb.s_uspi->s_ipg * sb->u.ufs_sb.s_uspi->s_ncg))
+	else if (SWAB32(de->d_ino) > (sb->u.ufs_sb.s_uspi->s_ipg *
+				      sb->u.ufs_sb.s_uspi->s_ncg))
 		error_msg = "inode out of bounds";
 
 	if (error_msg != NULL)
@@ -175,8 +176,8 @@
 			    "offset=%lu, inode=%lu, reclen=%d, namlen=%d",
 			    dir->i_ino, dir->i_size, error_msg, offset,
 			    (unsigned long) SWAB32(de->d_ino),
-			    SWAB16(de->d_reclen), ufs_get_de_namlen(de));
-	
+			    rlen, ufs_get_de_namlen(de));
+
 	return (error_msg == NULL ? 1 : 0);
 }
 
diff -ru linux-2.4.5.orig/fs/ufs/super.c linux-2.4.5-aed/fs/ufs/super.c
--- linux-2.4.5.orig/fs/ufs/super.c	Tue May 29 13:13:21 2001
+++ linux-2.4.5-aed/fs/ufs/super.c	Tue May 29 20:14:02 2001
@@ -265,6 +265,10 @@
 			*value++ = 0;
 		if (!strcmp (this_char, "ufstype")) {
 			ufs_clear_opt (*mount_options, UFSTYPE);
+			if (!value || !*value) {
+				printk ("UFS-fs: ufstype option needs value\n");
+				return 0;
+			}
 			if (!strcmp (value, "old"))
 				ufs_set_opt (*mount_options, UFSTYPE_OLD);
 			else if (!strcmp (value, "sun"))
@@ -288,6 +292,10 @@
 		}
 		else if (!strcmp (this_char, "onerror")) {
 			ufs_clear_opt (*mount_options, ONERROR);
+			if (!value || !*value) {
+				printk ("UFS-fs: onerror option needs value\n");
+				return 0;
+			}
 			if (!strcmp (value, "panic"))
 				ufs_set_opt (*mount_options, ONERROR_PANIC);
 			else if (!strcmp (value, "lock"))
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

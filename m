Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbSJ2Qza>; Tue, 29 Oct 2002 11:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbSJ2Qza>; Tue, 29 Oct 2002 11:55:30 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:19470 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S262147AbSJ2QzA>; Tue, 29 Oct 2002 11:55:00 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] small cleanup of fat  (3/3)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 30 Oct 2002 02:01:18 +0900
Message-ID: <877kg1b2n5.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

- cleanup
- remove unneeded mark_inode_dirty() in fat_extend_dir()

Please apply.

 fs/fat/misc.c   |    1 -
 fs/vfat/namei.c |   48 +++++++++++++++---------------------------------
 2 files changed, 15 insertions(+), 34 deletions(-)
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- fat-2.5.44/fs/vfat/namei.c~fat_cleanup	2002-10-24 02:34:26.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/vfat/namei.c	2002-10-26 07:37:40.000000000 +0900
@@ -690,42 +690,39 @@ xlate_to_uni(const char *name, int len, 
 	return 0;
 }
 
-static int
-vfat_fill_slots(struct inode *dir, struct msdos_dir_slot *ds, const char *name,
-		int len, int *slots, int is_dir, int uni_xlate)
+static int vfat_build_slots(struct inode *dir, const char *name, int len,
+			    struct msdos_dir_slot *ds, int *slots, int is_dir)
 {
-	struct nls_table *nls_io, *nls_disk;
-	wchar_t *uname;
+	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
+	struct fat_mount_options *opts = &sbi->options;
 	struct msdos_dir_slot *ps;
 	struct msdos_dir_entry *de;
 	unsigned long page;
 	unsigned char cksum, lcase;
-	char *uniname, msdos_name[MSDOS_NAME];
-	int res, utf8, slot, ulen, unilen, i;
+	char msdos_name[MSDOS_NAME];
+	wchar_t *uname;
+	int res, slot, ulen, usize, i;
 	loff_t offset;
 
 	*slots = 0;
-	utf8 = MSDOS_SB(dir->i_sb)->options.utf8;
-	nls_io = MSDOS_SB(dir->i_sb)->nls_io;
-	nls_disk = MSDOS_SB(dir->i_sb)->nls_disk;
+	res = vfat_valid_longname(name, len, opts->unicode_xlate);
+	if (res < 0)
+		return res;
 
-	if (name[len-1] == '.')
-		len--;
 	if(!(page = __get_free_page(GFP_KERNEL)))
 		return -ENOMEM;
 
-	uniname = (char *) page;
-	res = xlate_to_uni(name, len, uniname, &ulen, &unilen, uni_xlate,
-			   utf8, nls_io);
+	uname = (wchar_t *)page;
+	res = xlate_to_uni(name, len, (char *)uname, &ulen, &usize,
+			   opts->unicode_xlate, opts->utf8, sbi->nls_io);
 	if (res < 0)
 		goto out_free;
 
-	uname = (wchar_t *) page;
 	res = vfat_is_used_badchars(uname, ulen);
 	if (res < 0)
 		goto out_free;
 
-	res = vfat_create_shortname(dir, nls_disk, uname, ulen,
+	res = vfat_create_shortname(dir, sbi->nls_disk, uname, ulen,
 				    msdos_name, &lcase);
 	if (res < 0)
 		goto out_free;
@@ -736,7 +733,7 @@ vfat_fill_slots(struct inode *dir, struc
 	}
 
 	/* build the entry of long file name */
-	*slots = unilen / 13;
+	*slots = usize / 13;
 	for (cksum = i = 0; i < 11; i++) {
 		cksum = (((cksum&1)<<7)|((cksum&0xfe)>>1)) + msdos_name[i];
 	}
@@ -774,21 +771,6 @@ out_free:
 	return res;
 }
 
-/* We can't get "." or ".." here - VFS takes care of those cases */
-
-static int vfat_build_slots(struct inode *dir, const char *name, int len,
-			    struct msdos_dir_slot *ds, int *slots, int is_dir)
-{
-	int res, xlate;
-
-	xlate = MSDOS_SB(dir->i_sb)->options.unicode_xlate;
-	res = vfat_valid_longname(name, len, xlate);
-	if (res < 0)
-		return res;
-
-	return vfat_fill_slots(dir, ds, name, len, slots, is_dir, xlate);
-}
-
 static int vfat_add_entry(struct inode *dir,struct qstr* qname,
 			  int is_dir, struct vfat_slot_info *sinfo_out,
 			  struct buffer_head **bh, struct msdos_dir_entry **de)
--- fat-2.5.44/fs/fat/misc.c~fat_cleanup	2002-10-28 02:25:03.000000000 +0900
+++ fat-2.5.44-hirofumi/fs/fat/misc.c	2002-10-28 02:25:09.000000000 +0900
@@ -208,7 +208,6 @@ struct buffer_head *fat_extend_dir(struc
 	}
 	inode->i_size += 1 << MSDOS_SB(sb)->cluster_bits;
 	MSDOS_I(inode)->mmu_private += 1 << MSDOS_SB(sb)->cluster_bits;
-	mark_inode_dirty(inode);
 
 	return res;
 }

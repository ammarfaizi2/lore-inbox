Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVIDM0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVIDM0p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 08:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVIDM0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 08:26:45 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:27302 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750780AbVIDM0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 08:26:44 -0400
Subject: [PATCH] fat: Remove duplicate directory scanning code
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Date: Sun, 04 Sep 2005 15:26:09 +0300
Message-Id: <1125836769.2185.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch removes duplicate directory scanning code from fs/fat/dir.c. The
two functions that share identical code are fat_readdirx() and
fat_search_long(). This patch also renames fat_readdirx to __fat_readdir().

Tested on User-mode Linux with a small 16 MB vfat partition.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 dir.c |  239 +++++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 113 insertions(+), 126 deletions(-)

Index: 2.6/fs/fat/dir.c
===================================================================
--- 2.6.orig/fs/fat/dir.c
+++ 2.6/fs/fat/dir.c
@@ -197,6 +197,95 @@ fat_shortname2uni(struct nls_table *nls,
 	return len;
 }
 
+enum {
+	DIRENT_END	= 0x01,
+	NOT_EXTENDED	= 0x02,
+	DIR_END		= 0x03
+};
+
+/**
+ * fat_parse_extended - Parse extended directory entry.
+ *
+ * This function returns zero on success, negative value on error, or one of
+ * the following:
+ *
+ * %DIRENT_END - Directory entry ended unexpectedly.
+ * %NOT_EXTENDED - Directory entry does not contain extended attributes.
+ * %DIR_END - Directory has no more entries.
+ */
+static int fat_parse_extended(struct inode *dir,
+			      loff_t *pos,
+			      struct buffer_head **bh,
+			      struct msdos_dir_entry **de,
+			      wchar_t **unicode,
+			      unsigned char *nr_slots)
+{
+	struct msdos_dir_slot *ds;
+	unsigned char id;
+	unsigned char slot;
+	unsigned char slots;
+	unsigned char sum;
+	unsigned char alias_checksum;
+	int i;
+
+	if (!*unicode) {
+		*unicode = (wchar_t *) __get_free_page(GFP_KERNEL);
+		if (!*unicode) {
+			brelse(*bh);
+			return -ENOMEM;
+		}
+	}
+parse_long:
+	slots = 0;
+	ds = (struct msdos_dir_slot *) *de;
+	id = ds->id;
+	if (!(id & 0x40))
+		return DIRENT_END;
+	slots = id & ~0x40;
+	if (slots > 20 || !slots)	/* ceil(256 * 2 / 26) */
+		return DIRENT_END;
+	*nr_slots = slots;
+	alias_checksum = ds->alias_checksum;
+
+	slot = slots;
+	while (1) {
+		int offset;
+
+		slot--;
+		offset = slot * 13;
+		fat16_towchar(*unicode + offset, ds->name0_4, 5);
+		fat16_towchar(*unicode + offset + 5, ds->name5_10, 6);
+		fat16_towchar(*unicode + offset + 11, ds->name11_12, 2);
+
+		if (ds->id & 0x40) {
+			(*unicode)[offset + 13] = 0;
+		}
+		if (fat_get_entry(dir, pos, bh, de) < 0)
+			return DIR_END;
+		if (slot == 0)
+			break;
+		ds = (struct msdos_dir_slot *) *de;
+		if (ds->attr != ATTR_EXT)
+			return NOT_EXTENDED;
+		if ((ds->id & ~0x40) != slot)
+			goto parse_long;
+		if (ds->alias_checksum != alias_checksum)
+			goto parse_long;
+	}
+	if ((*de)->name[0] == DELETED_FLAG)
+		return DIRENT_END;
+	if ((*de)->attr == ATTR_EXT)
+		goto parse_long;
+	if (IS_FREE((*de)->name) || ((*de)->attr & ATTR_VOLUME))
+		return DIRENT_END;
+	for (sum = 0, i = 0; i < 11; i++)
+		sum = (((sum&1)<<7)|((sum&0xfe)>>1)) + (*de)->name[i];
+	if (sum != alias_checksum)
+		*nr_slots = 0;
+
+	return 0;
+}
+
 /*
  * Return values: negative -> error, 0 -> not found, positive -> found,
  * value is the total amount of slots, including the shortname entry.
@@ -234,68 +323,16 @@ parse_record:
 		if (de->attr != ATTR_EXT && IS_FREE(de->name))
 			continue;
 		if (de->attr == ATTR_EXT) {
-			struct msdos_dir_slot *ds;
-			unsigned char id;
-			unsigned char slot;
-			unsigned char slots;
-			unsigned char sum;
-			unsigned char alias_checksum;
-
-			if (!unicode) {
-				unicode = (wchar_t *)
-					__get_free_page(GFP_KERNEL);
-				if (!unicode) {
-					brelse(bh);
-					return -ENOMEM;
-				}
-			}
-parse_long:
-			slots = 0;
-			ds = (struct msdos_dir_slot *) de;
-			id = ds->id;
-			if (!(id & 0x40))
-				continue;
-			slots = id & ~0x40;
-			if (slots > 20 || !slots)	/* ceil(256 * 2 / 26) */
+			int status = fat_parse_extended(inode, &cpos, &bh, &de,
+							&unicode, &nr_slots);
+			if (status < 0)
+				return status;
+			else if (status == DIRENT_END)
 				continue;
-			nr_slots = slots;
-			alias_checksum = ds->alias_checksum;
-
-			slot = slots;
-			while (1) {
-				int offset;
-
-				slot--;
-				offset = slot * 13;
-				fat16_towchar(unicode + offset, ds->name0_4, 5);
-				fat16_towchar(unicode + offset + 5, ds->name5_10, 6);
-				fat16_towchar(unicode + offset + 11, ds->name11_12, 2);
-
-				if (ds->id & 0x40) {
-					unicode[offset + 13] = 0;
-				}
-				if (fat_get_entry(inode, &cpos, &bh, &de) < 0)
-					goto EODir;
-				if (slot == 0)
-					break;
-				ds = (struct msdos_dir_slot *) de;
-				if (ds->attr !=  ATTR_EXT)
-					goto parse_record;
-				if ((ds->id & ~0x40) != slot)
-					goto parse_long;
-				if (ds->alias_checksum != alias_checksum)
-					goto parse_long;
-			}
-			if (de->name[0] == DELETED_FLAG)
-				continue;
-			if (de->attr ==  ATTR_EXT)
-				goto parse_long;
-			if (IS_FREE(de->name) || (de->attr & ATTR_VOLUME))
-				continue;
-			for (sum = 0, i = 0; i < 11; i++)
-				sum = (((sum&1)<<7)|((sum&0xfe)>>1)) + de->name[i];
-			if (sum != alias_checksum)
-				nr_slots = 0;
+			else if (status == NOT_EXTENDED)
+				goto parse_record;
+			else if (status == DIR_END)
+				goto EODir;
 		}
 
 		memcpy(work, de->name, sizeof(de->name));
@@ -383,7 +420,7 @@ struct fat_ioctl_filldir_callback {
 	int short_len;
 };
 
-static int fat_readdirx(struct inode *inode, struct file *filp, void *dirent,
+static int __fat_readdir(struct inode *inode, struct file *filp, void *dirent,
 			filldir_t filldir, int short_only, int both)
 {
 	struct super_block *sb = inode->i_sb;
@@ -450,69 +487,19 @@ GetNew:
 	}
 
 	if (isvfat && de->attr == ATTR_EXT) {
-		struct msdos_dir_slot *ds;
-		unsigned char id;
-		unsigned char slot;
-		unsigned char slots;
-		unsigned char sum;
-		unsigned char alias_checksum;
-
-		if (!unicode) {
-			unicode = (wchar_t *)__get_free_page(GFP_KERNEL);
-			if (!unicode) {
-				filp->f_pos = cpos;
-				brelse(bh);
-				ret = -ENOMEM;
-				goto out;
-			}
-		}
-ParseLong:
-		slots = 0;
-		ds = (struct msdos_dir_slot *) de;
-		id = ds->id;
-		if (!(id & 0x40))
-			goto RecEnd;
-		slots = id & ~0x40;
-		if (slots > 20 || !slots)	/* ceil(256 * 2 / 26) */
-			goto RecEnd;
-		long_slots = slots;
-		alias_checksum = ds->alias_checksum;
-
-		slot = slots;
-		while (1) {
-			int offset;
-
-			slot--;
-			offset = slot * 13;
-			fat16_towchar(unicode + offset, ds->name0_4, 5);
-			fat16_towchar(unicode + offset + 5, ds->name5_10, 6);
-			fat16_towchar(unicode + offset + 11, ds->name11_12, 2);
-
-			if (ds->id & 0x40) {
-				unicode[offset + 13] = 0;
-			}
-			if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
-				goto EODir;
-			if (slot == 0)
-				break;
-			ds = (struct msdos_dir_slot *) de;
-			if (ds->attr !=  ATTR_EXT)
-				goto RecEnd;	/* XXX */
-			if ((ds->id & ~0x40) != slot)
-				goto ParseLong;
-			if (ds->alias_checksum != alias_checksum)
-				goto ParseLong;
+		int status = fat_parse_extended(inode, &cpos, &bh, &de,
+						&unicode, &long_slots);
+		if (status < 0) {
+			filp->f_pos = cpos;
+			ret = status;
+			goto out;
 		}
-		if (de->name[0] == DELETED_FLAG)
+		else if (status == DIRENT_END)
 			goto RecEnd;
-		if (de->attr ==  ATTR_EXT)
-			goto ParseLong;
-		if (IS_FREE(de->name) || (de->attr & ATTR_VOLUME))
-			goto RecEnd;
-		for (sum = 0, i = 0; i < 11; i++)
-			sum = (((sum&1)<<7)|((sum&0xfe)>>1)) + de->name[i];
-		if (sum != alias_checksum)
-			long_slots = 0;
+		else if (status == NOT_EXTENDED)
+			goto RecEnd;	/* XXX: Retry? */
+		else if (status == DIR_END)
+			goto EODir;
 	}
 
 	if (sbi->options.dotsOK) {
@@ -647,7 +634,7 @@ out:
 static int fat_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	return fat_readdirx(inode, filp, dirent, filldir, 0, 0);
+	return __fat_readdir(inode, filp, dirent, filldir, 0, 0);
 }
 
 static int fat_ioctl_filldir(void *__buf, const char *name, int name_len,
@@ -736,8 +723,8 @@ static int fat_dir_ioctl(struct inode * 
 	down(&inode->i_sem);
 	ret = -ENOENT;
 	if (!IS_DEADDIR(inode)) {
-		ret = fat_readdirx(inode, filp, &buf, fat_ioctl_filldir,
-				   short_only, both);
+		ret = __fat_readdir(inode, filp, &buf, fat_ioctl_filldir,
+				    short_only, both);
 	}
 	up(&inode->i_sem);
 	if (ret >= 0)



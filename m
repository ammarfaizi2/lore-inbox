Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVCETty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVCETty (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVCETkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:40:08 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:24837 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261200AbVCETLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 14/29] FAT: vfat_build_slots() cleanup
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
	<87r7iuq6af.fsf_-_@devron.myhome.or.jp>
	<87mztiq69f.fsf_-_@devron.myhome.or.jp>
	<87is46q68d.fsf_-_@devron.myhome.or.jp>
	<87ekeuq672.fsf_-_@devron.myhome.or.jp>
	<87acpiq665.fsf_-_@devron.myhome.or.jp>
	<876506q653.fsf_-_@devron.myhome.or.jp>
	<871xauq63z.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:51:33 +0900
In-Reply-To: <871xauq63z.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:50:56 +0900")
Message-ID: <87wtsmorii.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With this, the vfat_build_slots() builds the completely data including
the timestamp and cluster. (But this is not using "cluster", it's not
complete yet)

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/vfat/namei.c |  110 ++++++++++++++++++++++++++------------------------------
 1 files changed, 52 insertions(+), 58 deletions(-)

diff -puN fs/vfat/namei.c~sync07-fat_dir fs/vfat/namei.c
--- linux-2.6.11/fs/vfat/namei.c~sync07-fat_dir	2005-03-06 02:36:41.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/vfat/namei.c	2005-03-06 02:36:41.000000000 +0900
@@ -575,8 +575,9 @@ xlate_to_uni(const unsigned char *name, 
 }
 
 static int vfat_build_slots(struct inode *dir, const unsigned char *name,
-			    int len, struct msdos_dir_slot *ds,
-			    int *slots, int is_dir)
+			    int len, int is_dir, int cluster,
+			    struct timespec *ts,
+			    struct msdos_dir_slot *slots, int *nr_slots)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
 	struct fat_mount_options *opts = &sbi->options;
@@ -586,83 +587,85 @@ static int vfat_build_slots(struct inode
 	unsigned char cksum, lcase;
 	unsigned char msdos_name[MSDOS_NAME];
 	wchar_t *uname;
-	int res, slot, ulen, usize, i;
+	__le16 time, date;
+	int err, ulen, usize, i;
 	loff_t offset;
 
-	*slots = 0;
-	res = vfat_valid_longname(name, len);
-	if (res)
-		return res;
+	*nr_slots = 0;
+	err = vfat_valid_longname(name, len);
+	if (err)
+		return err;
 
 	page = __get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 
 	uname = (wchar_t *)page;
-	res = xlate_to_uni(name, len, (unsigned char *)uname, &ulen, &usize,
+	err = xlate_to_uni(name, len, (unsigned char *)uname, &ulen, &usize,
 			   opts->unicode_xlate, opts->utf8, sbi->nls_io);
-	if (res < 0)
+	if (err)
 		goto out_free;
 
-	res = vfat_is_used_badchars(uname, ulen);
-	if (res < 0)
+	err = vfat_is_used_badchars(uname, ulen);
+	if (err)
 		goto out_free;
 
-	res = vfat_create_shortname(dir, sbi->nls_disk, uname, ulen,
+	err = vfat_create_shortname(dir, sbi->nls_disk, uname, ulen,
 				    msdos_name, &lcase);
-	if (res < 0)
+	if (err < 0)
 		goto out_free;
-	else if (res == 1) {
-		de = (struct msdos_dir_entry *)ds;
-		res = 0;
+	else if (err == 1) {
+		de = (struct msdos_dir_entry *)slots;
+		err = 0;
 		goto shortname;
 	}
 
 	/* build the entry of long file name */
-	*slots = usize / 13;
 	for (cksum = i = 0; i < 11; i++)
 		cksum = (((cksum&1)<<7)|((cksum&0xfe)>>1)) + msdos_name[i];
 
-	for (ps = ds, slot = *slots; slot > 0; slot--, ps++) {
-		ps->id = slot;
+	*nr_slots = usize / 13;
+	for (ps = slots, i = *nr_slots; i > 0; i--, ps++) {
+		ps->id = i;
 		ps->attr = ATTR_EXT;
 		ps->reserved = 0;
 		ps->alias_checksum = cksum;
 		ps->start = 0;
-		offset = (slot - 1) * 13;
+		offset = (i - 1) * 13;
 		fatwchar_to16(ps->name0_4, uname + offset, 5);
 		fatwchar_to16(ps->name5_10, uname + offset + 5, 6);
 		fatwchar_to16(ps->name11_12, uname + offset + 11, 2);
 	}
-	ds[0].id |= 0x40;
+	slots[0].id |= 0x40;
 	de = (struct msdos_dir_entry *)ps;
 
 shortname:
 	/* build the entry of 8.3 alias name */
-	(*slots)++;
+	(*nr_slots)++;
 	memcpy(de->name, msdos_name, MSDOS_NAME);
 	de->attr = is_dir ? ATTR_DIR : ATTR_ARCH;
 	de->lcase = lcase;
-	de->adate = de->cdate = de->date = 0;
-	de->ctime = de->time = 0;
+	fat_date_unix2dos(ts->tv_sec, &time, &date);
+	de->time = de->ctime = time;
+	de->date = de->cdate = de->adate = date;
 	de->ctime_cs = 0;
-	de->start = 0;
-	de->starthi = 0;
+	de->start = cpu_to_le16(cluster);
+	de->starthi = cpu_to_le16(cluster >> 16);
 	de->size = 0;
-
 out_free:
 	free_page(page);
-	return res;
+	return err;
 }
 
-static int vfat_add_entry(struct inode *dir, struct qstr *qname,
-			  int is_dir, struct fat_slot_info *sinfo)
+static int vfat_add_entry(struct inode *dir, struct qstr *qname, int is_dir,
+			  struct fat_slot_info *sinfo)
 {
 	struct super_block *sb = dir->i_sb;
-	struct msdos_dir_slot *dir_slots;
-	loff_t offset;
-	int res, slots, slot;
+	struct msdos_dir_slot *slots;
+	struct timespec ts;
 	unsigned int len;
+	int err, i, nr_slots;
+	loff_t offset;
 	struct msdos_dir_entry *de, *dummy_de;
 	struct buffer_head *bh, *dummy_bh;
 	loff_t dummy_i_pos;
@@ -671,59 +674,50 @@ static int vfat_add_entry(struct inode *
 	if (len == 0)
 		return -ENOENT;
 
-	dir_slots = kmalloc(sizeof(*dir_slots) * MSDOS_SLOTS, GFP_KERNEL);
-	if (dir_slots == NULL)
+	slots = kmalloc(sizeof(*slots) * MSDOS_SLOTS, GFP_KERNEL);
+	if (slots == NULL)
 		return -ENOMEM;
 
-	res = vfat_build_slots(dir, qname->name, len,
-			       dir_slots, &slots, is_dir);
-	if (res < 0)
+	ts = CURRENT_TIME_SEC;
+	err = vfat_build_slots(dir, qname->name, len, is_dir, 0, &ts,
+			       slots, &nr_slots);
+	if (err)
 		goto cleanup;
 
 	/* build the empty directory entry of number of slots */
 	offset =
-	    fat_add_entries(dir, slots, &dummy_bh, &dummy_de, &dummy_i_pos);
+	    fat_add_entries(dir, nr_slots, &dummy_bh, &dummy_de, &dummy_i_pos);
 	if (offset < 0) {
-		res = offset;
+		err = offset;
 		goto cleanup;
 	}
 	brelse(dummy_bh);
 
 	/* Now create the new entry */
 	bh = NULL;
-	for (slot = 0; slot < slots; slot++) {
+	for (i = 0; i < nr_slots; i++) {
 		if (fat_get_entry(dir, &offset, &bh, &de, &sinfo->i_pos) < 0) {
-			res = -EIO;
+			err = -EIO;
 			goto cleanup;
 		}
-		memcpy(de, dir_slots + slot, sizeof(struct msdos_dir_slot));
+		memcpy(de, slots + i, sizeof(struct msdos_dir_slot));
 		mark_buffer_dirty(bh);
 		if (sb->s_flags & MS_SYNCHRONOUS)
 			sync_dirty_buffer(bh);
 	}
 
-	res = 0;
 	/* update timestamp */
-	dir->i_ctime = dir->i_mtime = dir->i_atime = CURRENT_TIME_SEC;
+	dir->i_ctime = dir->i_mtime = dir->i_atime = ts;
 	mark_inode_dirty(dir);
 
-	fat_date_unix2dos(dir->i_mtime.tv_sec, &de->time, &de->date);
-	dir->i_mtime.tv_nsec = 0;
-	de->ctime = de->time;
-	de->adate = de->cdate = de->date;
-	mark_buffer_dirty(bh);
-	if (sb->s_flags & MS_SYNCHRONOUS)
-		sync_dirty_buffer(bh);
-
 	/* slots can't be less than 1 */
-	sinfo->slot_off = offset - sizeof(struct msdos_dir_slot) * slots;
-	sinfo->nr_slots = slots;
+	sinfo->slot_off = offset - sizeof(struct msdos_dir_slot) * nr_slots;
+	sinfo->nr_slots = nr_slots;
 	sinfo->de = de;
 	sinfo->bh = bh;
-
 cleanup:
-	kfree(dir_slots);
-	return res;
+	kfree(slots);
+	return err;
 }
 
 static int vfat_find(struct inode *dir, struct qstr *qname,
_

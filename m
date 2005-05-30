Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVE3GNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVE3GNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 02:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVE3GNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 02:13:14 -0400
Received: from mxb.rambler.ru ([81.19.66.30]:50695 "EHLO mxb.rambler.ru")
	by vger.kernel.org with ESMTP id S261527AbVE3GHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 02:07:00 -0400
Message-ID: <429B1E35.2040905@rambler.ru>
Date: Mon, 30 May 2005 10:07:49 -0400
From: Pavel Fedin <sonic_amiga@rambler.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Full NLS support for HFS (classic) filesystem
Content-Type: multipart/mixed;
 boundary="------------020005070807030202040109"
X-Auth-User: sonic_amiga, whoson: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020005070807030202040109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

   Hello, all! After a long thnking i implemented full NLS support for
MacHFS filesystem. This is the patch for 2.6.11.1 kernel.
   Add "iocharset" and "hfscodepage" mount options to fstab for it to work.
   "hfscodepage" option is also introduced to iso9660 and udf
filesystems. They ignore it. Both options are also added to hfsplus
filesystem. It also ignores them. This is done in order to enable user
to put one line into fstab like:
/dev/cdrom /mnt/cdrom iso9660,udf,hfsplus,hfs
user,noauto,iocharset=koi8-r,hfscodepage=10007 0 0
   This allows you to have one mount point for all CD formats at last.
   Codepage option is called "hfscodepage", not "codepage" because in
future "codepage" option might be added to iso9660 filesystem in order
to enable translation of 8-bit names and in many countries ISO codepage
differs from HFS codepage.
   cp10007 nls table is also added by this patch. This codepage is used
on russian macintoshes.
   Some technical details on the implementation:
   HFS filesystem by nature requires filenames in Mac encoding to be
supplied to file search algorythm, otherwise it will not work. So two
different algorythms are used depending on used iocharset:
   a) if iocharset=utf8 - all characters are reverse-convertable in this
case. NLS table is loaded for the specified codepage and conversion is
done using it.
   b) if iocharset is not utf8 - not every character can be
reverse-translated in this case. To override this two tables are
composed on the fly from two supplied NLS pages using a tricky
algorythm. A 256 byte table is created and filled with characters taken
from NLS->NLS conversion. Those characters from 256-byte destination set
which were used are marked. After this all remaining entries in the
table (characters which had no equivalent in the destination NLS table)
are filled with characters which remained unused. Then resulting table
is reversed in order to provide a second table for reverse translation.
   This implementation is rather tricky and probably sometimes it can
fail (i hope it won't, at least i tested it with hfscodepage=10007) so i
left a simple possibility to disable conversion by simply removing
iocharset and hfscodepage from hfs mount options.

-- 
   Kind regards, Pavel Fedin


--------------020005070807030202040109
Content-Type: text/x-patch;
 name="hfs-nls-2.6.11.1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hfs-nls-2.6.11.1.diff"

--- linux-2.6.11.1/fs/hfs/catalog.c.orig	2005-03-18 00:34:30.000000000 +0300
+++ linux-2.6.11.1/fs/hfs/catalog.c	2005-03-30 23:55:02.000000000 +0400
@@ -20,12 +20,12 @@
  *
  * Given the ID of the parent and the name build a search key.
  */
-void hfs_cat_build_key(btree_key *key, u32 parent, struct qstr *name)
+void hfs_cat_build_key(btree_key *key, u32 parent, struct qstr *name, struct hfs_sb_info *sbi)
 {
 	key->cat.reserved = 0;
 	key->cat.ParID = cpu_to_be32(parent);
 	if (name) {
-		hfs_triv2mac(&key->cat.CName, name);
+		hfs_triv2mac(&key->cat.CName, name, sbi->unix2mac, sbi->nls);
 		key->key_len = 6 + key->cat.CName.len;
 	} else {
 		memset(&key->cat.CName, 0, sizeof(struct hfs_name));
@@ -63,12 +63,12 @@
 }
 
 static int hfs_cat_build_thread(hfs_cat_rec *rec, int type,
-				u32 parentid, struct qstr *name)
+				u32 parentid, struct qstr *name, struct hfs_sb_info *sbi)
 {
 	rec->type = type;
 	memset(rec->thread.reserved, 0, sizeof(rec->thread.reserved));
 	rec->thread.ParID = cpu_to_be32(parentid);
-	hfs_triv2mac(&rec->thread.CName, name);
+	hfs_triv2mac(&rec->thread.CName, name, sbi->unix2mac, sbi->nls);
 	return sizeof(struct hfs_cat_thread);
 }
 
@@ -93,10 +93,10 @@
 	sb = dir->i_sb;
 	hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
 
-	hfs_cat_build_key(fd.search_key, cnid, NULL);
+	hfs_cat_build_key(fd.search_key, cnid, NULL, HFS_SB(sb));
 	entry_size = hfs_cat_build_thread(&entry, S_ISDIR(inode->i_mode) ?
 			HFS_CDR_THD : HFS_CDR_FTH,
-			dir->i_ino, str);
+			dir->i_ino, str, HFS_SB(sb));
 	err = hfs_brec_find(&fd);
 	if (err != -ENOENT) {
 		if (!err)
@@ -107,7 +107,7 @@
 	if (err)
 		goto err2;
 
-	hfs_cat_build_key(fd.search_key, dir->i_ino, str);
+	hfs_cat_build_key(fd.search_key, dir->i_ino, str, HFS_SB(sb));
 	entry_size = hfs_cat_build_record(&entry, cnid, inode);
 	err = hfs_brec_find(&fd);
 	if (err != -ENOENT) {
@@ -127,7 +127,7 @@
 	return 0;
 
 err1:
-	hfs_cat_build_key(fd.search_key, cnid, NULL);
+	hfs_cat_build_key(fd.search_key, cnid, NULL, HFS_SB(sb));
 	if (!hfs_brec_find(&fd))
 		hfs_brec_remove(&fd);
 err2:
@@ -176,7 +176,7 @@
 	hfs_cat_rec rec;
 	int res, len, type;
 
-	hfs_cat_build_key(fd->search_key, cnid, NULL);
+	hfs_cat_build_key(fd->search_key, cnid, NULL, HFS_SB(sb));
 	res = hfs_brec_read(fd, &rec, sizeof(rec));
 	if (res)
 		return res;
@@ -211,7 +211,7 @@
 	sb = dir->i_sb;
 	hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
 
-	hfs_cat_build_key(fd.search_key, dir->i_ino, str);
+	hfs_cat_build_key(fd.search_key, dir->i_ino, str, HFS_SB(sb));
 	res = hfs_brec_find(&fd);
 	if (res)
 		goto out;
@@ -239,7 +239,7 @@
 	if (res)
 		goto out;
 
-	hfs_cat_build_key(fd.search_key, cnid, NULL);
+	hfs_cat_build_key(fd.search_key, cnid, NULL, HFS_SB(sb));
 	res = hfs_brec_find(&fd);
 	if (!res) {
 		res = hfs_brec_remove(&fd);
@@ -280,7 +280,7 @@
 	dst_fd = src_fd;
 
 	/* find the old dir entry and read the data */
-	hfs_cat_build_key(src_fd.search_key, src_dir->i_ino, src_name);
+	hfs_cat_build_key(src_fd.search_key, src_dir->i_ino, src_name, HFS_SB(sb));
 	err = hfs_brec_find(&src_fd);
 	if (err)
 		goto out;
@@ -289,7 +289,7 @@
 			    src_fd.entrylength);
 
 	/* create new dir entry with the data from the old entry */
-	hfs_cat_build_key(dst_fd.search_key, dst_dir->i_ino, dst_name);
+	hfs_cat_build_key(dst_fd.search_key, dst_dir->i_ino, dst_name, HFS_SB(sb));
 	err = hfs_brec_find(&dst_fd);
 	if (err != -ENOENT) {
 		if (!err)
@@ -305,7 +305,7 @@
 	mark_inode_dirty(dst_dir);
 
 	/* finally remove the old entry */
-	hfs_cat_build_key(src_fd.search_key, src_dir->i_ino, src_name);
+	hfs_cat_build_key(src_fd.search_key, src_dir->i_ino, src_name, HFS_SB(sb));
 	err = hfs_brec_find(&src_fd);
 	if (err)
 		goto out;
@@ -321,7 +321,7 @@
 		goto out;
 
 	/* remove old thread entry */
-	hfs_cat_build_key(src_fd.search_key, cnid, NULL);
+	hfs_cat_build_key(src_fd.search_key, cnid, NULL, HFS_SB(sb));
 	err = hfs_brec_find(&src_fd);
 	if (err)
 		goto out;
@@ -330,9 +330,9 @@
 		goto out;
 
 	/* create new thread entry */
-	hfs_cat_build_key(dst_fd.search_key, cnid, NULL);
+	hfs_cat_build_key(dst_fd.search_key, cnid, NULL, HFS_SB(sb));
 	entry_size = hfs_cat_build_thread(&entry, type == HFS_CDR_FIL ? HFS_CDR_FTH : HFS_CDR_THD,
-					dst_dir->i_ino, dst_name);
+					dst_dir->i_ino, dst_name, HFS_SB(sb));
 	err = hfs_brec_find(&dst_fd);
 	if (err != -ENOENT) {
 		if (!err)
--- linux-2.6.11.1/fs/hfs/dir.c.orig	2005-03-18 00:34:30.000000000 +0300
+++ linux-2.6.11.1/fs/hfs/dir.c	2005-05-28 22:15:01.000000000 +0400
@@ -28,7 +28,7 @@
 	dentry->d_op = &hfs_dentry_operations;
 
 	hfs_find_init(HFS_SB(dir->i_sb)->cat_tree, &fd);
-	hfs_cat_build_key(fd.search_key, dir->i_ino, &dentry->d_name);
+	hfs_cat_build_key(fd.search_key, dir->i_ino, &dentry->d_name, HFS_SB(dir->i_sb));
 	res = hfs_brec_read(&fd, &rec, sizeof(rec));
 	if (res) {
 		hfs_find_exit(&fd);
@@ -56,17 +56,19 @@
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct super_block *sb = inode->i_sb;
 	int len, err;
-	char strbuf[HFS_NAMELEN + 1];
+	char strbuf[129];
 	union hfs_cat_rec entry;
 	struct hfs_find_data fd;
 	struct hfs_readdir_data *rd;
+	unsigned char *mac2unix = HFS_SB(sb)->mac2unix;
+	struct nls_table *nls = HFS_SB(sb)->nls;
 	u16 type;
 
 	if (filp->f_pos >= inode->i_size)
 		return 0;
 
 	hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
-	hfs_cat_build_key(fd.search_key, inode->i_ino, NULL);
+	hfs_cat_build_key(fd.search_key, inode->i_ino, NULL, HFS_SB(sb));
 	err = hfs_brec_find(&fd);
 	if (err)
 		goto out;
@@ -111,7 +113,7 @@
 		}
 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset, fd.entrylength);
 		type = entry.type;
-		len = hfs_mac2triv(strbuf, &fd.key->cat.CName);
+		len = hfs_mac2triv(strbuf, &fd.key->cat.CName, mac2unix, nls);
 		if (type == HFS_CDR_DIR) {
 			if (fd.entrylength < sizeof(struct hfs_cat_dir)) {
 				printk("HFS: small dir entry\n");
@@ -308,7 +310,7 @@
 			   new_dir, &new_dentry->d_name);
 	if (!res)
 		hfs_cat_build_key((btree_key *)&HFS_I(old_dentry->d_inode)->cat_key,
-				  new_dir->i_ino, &new_dentry->d_name);
+				  new_dir->i_ino, &new_dentry->d_name, HFS_SB(new_dentry->d_sb));
 	return res;
 }
 
--- linux-2.6.11.1/fs/hfs/hfs_fs.h.orig	2005-03-18 00:34:30.000000000 +0300
+++ linux-2.6.11.1/fs/hfs/hfs_fs.h	2005-03-30 23:53:27.000000000 +0400
@@ -138,6 +138,8 @@
 						   permissions on all dirs */
 	uid_t s_uid;				/* The uid of all files */
 	gid_t s_gid;				/* The gid of all files */
+	char *iocharset;			/* I/O Character set */
+	int codepage;				/* Disk codepage */
 
 	int session, part;
 
@@ -150,6 +152,9 @@
 	int fs_div;
 
 	struct hlist_head rsrc_inodes;
+	unsigned char *mac2unix;
+	unsigned char *unix2mac;
+	struct nls_table *nls;
 };
 
 #define HFS_FLG_BITMAP_DIRTY	0
@@ -168,7 +173,7 @@
 extern int hfs_cat_delete(u32, struct inode *, struct qstr *);
 extern int hfs_cat_move(u32, struct inode *, struct qstr *,
 			struct inode *, struct qstr *);
-extern void hfs_cat_build_key(btree_key *, u32, struct qstr *);
+extern void hfs_cat_build_key(btree_key *, u32, struct qstr *, struct hfs_sb_info *);
 
 /* dir.c */
 extern struct file_operations hfs_dir_operations;
@@ -232,8 +237,10 @@
 extern int hfs_compare_dentry(struct dentry *, struct qstr *, struct qstr *);
 
 /* trans.c */
-extern void hfs_triv2mac(struct hfs_name *, struct qstr *);
-extern int hfs_mac2triv(char *, const struct hfs_name *);
+extern unsigned char *hfs_load_charset(char *iocharset, int codepage);
+extern unsigned char *hfs_revert_charset(unsigned char *mac2unix);
+extern void hfs_triv2mac(struct hfs_name *, struct qstr *, unsigned char *, struct nls_table *);
+extern int hfs_mac2triv(char *, const struct hfs_name *, unsigned char *, struct nls_table *);
 
 extern struct timezone sys_tz;
 
--- linux-2.6.11.1/fs/hfs/inode.c.orig	2005-03-18 00:34:30.000000000 +0300
+++ linux-2.6.11.1/fs/hfs/inode.c	2005-03-18 00:35:51.000000000 +0300
@@ -163,7 +163,7 @@
 
 	init_MUTEX(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
-	hfs_cat_build_key((btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
+	hfs_cat_build_key((btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name, HFS_SB(sb));
 	inode->i_ino = HFS_SB(sb)->next_id++;
 	inode->i_mode = mode;
 	inode->i_uid = current->fsuid;
--- linux-2.6.11.1/fs/hfs/super.c.orig	2005-03-18 00:34:30.000000000 +0300
+++ linux-2.6.11.1/fs/hfs/super.c	2005-05-28 23:53:31.000000000 +0400
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
+#include <linux/nls.h>
 #include <linux/vfs.h>
 
 #include "hfs_fs.h"
@@ -64,9 +65,30 @@
  */
 static void hfs_put_super(struct super_block *sb)
 {
+	struct hfs_sb_info *hsb = HFS_SB(sb);
 	hfs_mdb_close(sb);
 	/* release the MDB's resources */
 	hfs_mdb_put(sb);
+	if (hsb->nls)
+	{
+		unload_nls(hsb->nls);
+		hsb->nls = NULL;
+	}
+	if (hsb->mac2unix)
+	{
+		kfree(hsb->mac2unix);
+		hsb->mac2unix = NULL;
+	}
+	if (hsb->unix2mac)
+	{
+		kfree(hsb->unix2mac);
+		hsb->unix2mac = NULL;
+	}
+	if (hsb->iocharset)
+	{
+		kfree(hsb->iocharset);
+		hsb->iocharset = NULL;
+	}
 }
 
 /*
@@ -155,6 +177,8 @@
 	hsb->s_quiet = 0;
 	hsb->part = -1;
 	hsb->session = -1;
+	hsb->iocharset = NULL;
+	hsb->codepage = CONFIG_HFS_DEFAULT_CODEPAGE;
 
 	if (!options)
 		return 1;
@@ -210,6 +234,12 @@
 			hsb->session = simple_strtoul(value, &value, 0);
 			if (*value)
 				return 0;
+		} else if (!strcmp(this_char, "hfscodepage")) {
+			if (!value || !*value)
+				return 0;
+			hsb->codepage = simple_strtoul(value, &value, 0);
+			if (*value)
+				return 0;
 	/* String-valued options */
 		} else if (!strcmp(this_char, "type") && value) {
 			if (strlen(value) != 4)
@@ -219,6 +249,13 @@
 			if (strlen(value) != 4)
 				return 0;
 			memcpy(&hsb->s_creator, value, 4);
+		} else if (!strcmp(this_char, "iocharset") && value) {
+                       if (hsb->iocharset)
+                               kfree(hsb->iocharset);
+                       hsb->iocharset = kmalloc(strlen(value)+1, GFP_KERNEL);
+                       if (!hsb->iocharset)
+                               return -ENOMEM;
+                       strcpy(hsb->iocharset, value);
 	/* Boolean-valued options */
 		} else if (!strcmp(this_char, "quiet")) {
 			if (value)
@@ -252,6 +289,7 @@
 	hfs_cat_rec rec;
 	struct inode *root_inode;
 	int res;
+	char buf[256];
 
 	sbi = kmalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
 	if (!sbi)
@@ -279,6 +317,27 @@
 		goto bail2;
 	}
 
+	res = -EINVAL;
+	if (sbi->iocharset)
+	{
+		if (strcmp(sbi->iocharset, "utf8"))
+		{
+			sbi->mac2unix = hfs_load_charset(sbi->iocharset, sbi->codepage);
+			if (!sbi->mac2unix)
+				goto bail1;
+			sbi->unix2mac = hfs_revert_charset(sbi->mac2unix);
+			if (!sbi->unix2mac)
+				goto bail0;
+		}
+		else
+		{
+			sprintf(buf, "cp%d", sbi->codepage);
+			sbi->nls = load_nls(buf);
+			if (!sbi->nls)
+				goto bail1;
+		}
+	}
+
 	/* try to get the root inode */
 	hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
 	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
@@ -306,6 +365,10 @@
 	iput(root_inode);
 bail_no_root:
 	hfs_warn("hfs_fs: get root inode failed.\n");
+	kfree(sbi->unix2mac);
+bail0:
+	kfree(sbi->mac2unix);
+bail1:
 	hfs_mdb_put(sb);
 bail2:
 bail3:
--- linux-2.6.11.1/fs/hfs/trans.c.orig	2005-03-18 00:34:30.000000000 +0300
+++ linux-2.6.11.1/fs/hfs/trans.c	2005-05-28 23:29:12.000000000 +0400
@@ -9,10 +9,116 @@
  * with ':' vs. '/' as the path-element separator.
  */
 
+#include <linux/types.h>
+#include <linux/nls.h>
 #include "hfs_fs.h"
 
+/*
+ * Define this if you want to enable verification that your table does not contain
+ * duplicated characters
+ */
+#undef NLS_SANITY_CHECK
+
 /*================ Global functions ================*/
 
+/* hfs_load_charset()
+ *
+ * Creates table for converting characters from Macintosh character set to Linux character set
+ * from two given NLS modules (I/O and disk character sets). This is necessary because
+ * translation must be 100% reversible otherwise we won't be able to lock a file even if it's
+ * found.
+ */
+unsigned char *hfs_load_charset(char *iocharset, int codepage)
+{
+	struct nls_table *nls_io, *nls_disk;
+	int i, j, clen;
+	char c8;
+	wchar_t c16;
+	unsigned char *mac2unix;
+	char buf[256];
+
+	sprintf(buf,"cp%d",codepage);
+	nls_disk = load_nls(buf);
+	if (!nls_disk) {
+		hfs_warn("hfs_fs: codepage %s not found\n", buf);
+		return NULL;
+	}
+	nls_io = load_nls(iocharset);
+	if (!nls_io) {
+		hfs_warn("hfs_fs: IO charset %s not found\n", iocharset);
+		unload_nls(nls_disk);
+		return NULL;
+	}
+	mac2unix = kmalloc(256, GFP_KERNEL);
+	if (mac2unix) {
+		memset (mac2unix, 0, 256);
+		memset (buf, 0, sizeof(buf));
+		for(i=0; i<256; i++) {
+			c8 = (char)i;
+			clen = nls_disk->char2uni(&c8, 1, &c16);
+			if (clen > 0) {
+				/* FIXME: To enable UTF-8 support you'll need to:
+				   1. Replace the following '1' with NLS_MAX_CHARSET_SIZE;
+				   2. Increase size of the translation table;
+				   3. Rework reverse translation routine (reverse translation table would
+				      be huge for Unicode)
+				*/
+				clen = nls_io->uni2char(c16, &mac2unix[i], 1);
+				if (clen > 0)
+				{
+#ifdef NLS_SANITY_CHECK
+					if (buf[mac2unix[i]]) {
+						hfs_warn ("hfs_fs: duplicating character %02X (translated for second time from %02X) in NLS tables!\n", mac2unix[i], i);
+						kfree (mac2unix);
+						mac2unix = NULL;
+						goto fault;
+					}
+#endif
+					buf[mac2unix[i]] = 1;
+				}
+			}
+		}
+		j = 0;
+		for(i=1; i<256; i++) {
+			if (!mac2unix[i]) {
+				while (buf[j]) {
+					j++;
+#ifdef NLS_SANITY_CHECK
+					if (j > 255) {
+						hfs_warn ("hfs_fs: weird, extra untranslated characters appear! Kernel BUG!\n");
+						kfree (mac2unix);
+						mac2unix = NULL;
+						goto fault;
+					}
+#endif
+				}
+				mac2unix[i] = j++;
+			}
+		}
+	}
+fault:
+	unload_nls(nls_io);
+	unload_nls(nls_disk);
+	return mac2unix;		
+}
+
+/* hfs_revert_charset()
+ *
+ * Initialises reverse translation table from forward translation table.
+ * Optionally can check table's consistency (verify that there are no duplicated values in it)
+ */
+unsigned char *hfs_revert_charset(unsigned char *mac2unix)
+{
+	unsigned char *unix2mac;
+	int i;
+
+	unix2mac = kmalloc(256, GFP_KERNEL);
+	if (unix2mac)
+		for(i=0; i<256; i++)
+			unix2mac[mac2unix[i]] = i;
+	return unix2mac;
+};
+
 /*
  * hfs_mac2triv()
  *
@@ -27,19 +133,50 @@
  * by ':' which never appears in HFS filenames.	 All other characters
  * are passed unchanged from input to output.
  */
-int hfs_mac2triv(char *out, const struct hfs_name *in)
+int hfs_mac2triv(char *out, const struct hfs_name *in, unsigned char *table, struct nls_table *nls)
 {
 	const char *p;
 	char c;
-	int i, len;
+	int i, l, len;
+	wchar_t uni;
+	int dl = 0;
 
 	len = in->len;
 	p = in->name;
-	for (i = 0; i < len; i++) {
-		c = *p++;
-		*out++ = c == '/' ? ':' : c;
+	if (nls) {
+		for (i = 0; i < len;) {
+			l = nls->char2uni(&p[i], len-i, &uni);
+			if (l > 0)
+			{
+				uni = uni == '/' ? ':' : uni;
+				i += l;
+				l = utf8_wctomb(out, uni, NLS_MAX_CHARSET_SIZE);
+				if (l > 0) {
+					out += l;
+					dl += l;
+				}
+			}
+			else
+				i++;
+			if (l < 0)
+			{
+				*out++ = '?';
+				dl++;
+				hfs_warn("hfs_fs/hfs_mac2triv(): weird, non-translatable character appear! KERNEL BUG!\n");
+			}
+		}
+		return dl;
+	} else {
+		for (i = 0; i < len; i++)
+		{
+			c = *p++;
+			c = c == '/' ? ':' : c;
+			if (table)
+				c = table[(unsigned char)c];
+			*out++ = c;
+		}
+		return i;
 	}
-	return i;
 }
 
 /*
@@ -54,18 +191,53 @@
  * This routine is a inverse to hfs_mac2triv().
  * A ':' is replaced by a '/'.
  */
-void hfs_triv2mac(struct hfs_name *out, struct qstr *in)
+void hfs_triv2mac(struct hfs_name *out, struct qstr *in, unsigned char *table, struct nls_table *nls)
 {
 	const char *src;
 	char *dst, c;
-	int i, len;
+	wchar_t uni;
+	int i, l, len;
+	int dl = 0;
+	int limit = HFS_NAMELEN;
 
-	out->len = len = min((unsigned int)HFS_NAMELEN, in->len);
 	src = in->name;
 	dst = out->name;
-	for (i = 0; i < len; i++) {
-		c = *src++;
-		*dst++ = c == ':' ? '/' : c;
+	if (nls) {
+		len = in->len;
+		for (i = 0; i < len && limit > 0;) {
+			l = utf8_mbtowc(&uni, &src[i], len-i);
+			if (l > 0)
+			{
+				uni = uni == ':' ? '/' : uni;
+				i += l;
+				l = nls->uni2char(uni, dst, limit);
+				if (l > 0)
+				{
+					dst += l;
+					dl += l;
+					limit -= l;
+				}
+			}
+			else
+				i++;
+			if (l < 0)
+			{
+				*dst++ = '?';
+				dl++;
+				limit--;
+				hfs_warn("hfs_fs/hfs_triv2mac(): weird, non-translatable character appear! KERNEL BUG!\n");
+			}
+		}
+		out->len = dl;
+	} else {
+		out->len = len = min((unsigned int)HFS_NAMELEN, in->len);
+		for (i = 0; i < len; i++) {
+			c = *src++;
+			c = c == ':' ? '/' : c;
+			if (table)
+				c = table[(unsigned char)c];
+			*dst++ = c;
+		}
 	}
 	for (; i < HFS_NAMELEN; i++)
 		*dst++ = 0;
--- linux-2.6.11.1/fs/hfsplus/options.c.orig	2005-03-18 00:34:30.000000000 +0300
+++ linux-2.6.11.1/fs/hfsplus/options.c	2005-03-18 00:35:51.000000000 +0300
@@ -117,6 +117,8 @@
 				printk("HFS+-fs: session requires an argument\n");
 				return 0;
 			}
+		} else if (!strcmp(curropt, "iocharset")) {
+		} else if (!strcmp(curropt, "hfscodepage")) {
 		} else {
 			printk("HFS+-fs: unknown option %s\n", curropt);
 			return 0;
--- linux-2.6.11.1/fs/isofs/inode.c.orig	2005-03-18 00:34:30.000000000 +0300
+++ linux-2.6.11.1/fs/isofs/inode.c	2005-03-18 00:35:51.000000000 +0300
@@ -364,6 +364,7 @@
 	{Opt_ignore, "conv=auto"},
 	{Opt_ignore, "conv=a"},
 	{Opt_nocompress, "nocompress"},
+	{Opt_ignore, "hfscodepage=%s"},
 	{Opt_err, NULL}
 };
 
--- linux-2.6.11.1/fs/nls/Kconfig.orig	2005-03-18 00:34:30.000000000 +0300
+++ linux-2.6.11.1/fs/nls/Kconfig	2005-03-18 00:35:51.000000000 +0300
@@ -332,6 +332,19 @@
 	  say Y here if you want to include the DOS codepage for Russian and
 	  Bulgarian and Belarusian.
 
+config NLS_CODEPAGE_10007
+	tristate "Macintosh CP10007 (Russian, Ukrainian)"
+	depends on NLS
+	help
+	  The Macintosh HFS file system family can deal with filenames in
+	  native language character sets. These character sets are stored in
+	  so-called codepages. You need to include the appropriate codepage
+	  if you want to be able to read/write these filenames on HFS
+	  partitions correctly. This does apply to the filenames
+	  only, not to the file contents. You can include several codepages;
+	  say Y here if you want to include the Macintosh codepage for Russian
+	  and Ukrainian.
+
 config NLS_ASCII
 	tristate "ASCII (United States)"
 	depends on NLS
--- linux-2.6.11.1/fs/nls/Makefile.orig	2005-03-18 00:34:30.000000000 +0300
+++ linux-2.6.11.1/fs/nls/Makefile	2005-03-18 00:35:51.000000000 +0300
@@ -26,6 +26,7 @@
 obj-$(CONFIG_NLS_CODEPAGE_950)	+= nls_cp950.o
 obj-$(CONFIG_NLS_CODEPAGE_1250) += nls_cp1250.o
 obj-$(CONFIG_NLS_CODEPAGE_1251)	+= nls_cp1251.o
+obj-$(CONFIG_NLS_CODEPAGE_10007) += nls_cp10007.o
 obj-$(CONFIG_NLS_ASCII)		+= nls_ascii.o
 obj-$(CONFIG_NLS_ISO8859_1)	+= nls_iso8859-1.o
 obj-$(CONFIG_NLS_ISO8859_2)	+= nls_iso8859-2.o
--- linux-2.6.11.1/fs/nls/nls_cp10007.c.orig	2005-03-18 00:35:51.000000000 +0300
+++ linux-2.6.11.1/fs/nls/nls_cp10007.c	2005-03-18 00:35:51.000000000 +0300
@@ -0,0 +1,351 @@
+/*
+ * linux/fs/nls_cp10007.c
+ *
+ * Charset cp10007 translation tables.
+ * Written by Pavel Fedin <sonic_amiga@rambler.ru>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/nls.h>
+#include <linux/errno.h>
+
+static wchar_t charset2uni[256] = {
+	/* 0x00*/
+	0x0000, 0x0001, 0x0002, 0x0003, 
+	0x0004, 0x0005, 0x0006, 0x0007, 
+	0x0008, 0x0009, 0x000a, 0x000b, 
+	0x000c, 0x000d, 0x000e, 0x000f, 
+	/* 0x10*/
+	0x0010, 0x0011, 0x0012, 0x0013, 
+	0x0014, 0x0015, 0x0016, 0x0017, 
+	0x0018, 0x0019, 0x001a, 0x001b, 
+	0x001c, 0x001d, 0x001e, 0x001f, 
+	/* 0x20*/
+	0x0020, 0x0021, 0x0022, 0x0023, 
+	0x0024, 0x0025, 0x0026, 0x0027, 
+	0x0028, 0x0029, 0x002a, 0x002b, 
+	0x002c, 0x002d, 0x002e, 0x002f, 
+	/* 0x30*/
+	0x0030, 0x0031, 0x0032, 0x0033, 
+	0x0034, 0x0035, 0x0036, 0x0037, 
+	0x0038, 0x0039, 0x003a, 0x003b, 
+	0x003c, 0x003d, 0x003e, 0x003f, 
+	/* 0x40*/
+	0x0040, 0x0041, 0x0042, 0x0043, 
+	0x0044, 0x0045, 0x0046, 0x0047, 
+	0x0048, 0x0049, 0x004a, 0x004b, 
+	0x004c, 0x004d, 0x004e, 0x004f, 
+	/* 0x50*/
+	0x0050, 0x0051, 0x0052, 0x0053, 
+	0x0054, 0x0055, 0x0056, 0x0057, 
+	0x0058, 0x0059, 0x005a, 0x005b, 
+	0x005c, 0x005d, 0x005e, 0x005f, 
+	/* 0x60*/
+	0x0060, 0x0061, 0x0062, 0x0063, 
+	0x0064, 0x0065, 0x0066, 0x0067, 
+	0x0068, 0x0069, 0x006a, 0x006b, 
+	0x006c, 0x006d, 0x006e, 0x006f, 
+	/* 0x70*/
+	0x0070, 0x0071, 0x0072, 0x0073, 
+	0x0074, 0x0075, 0x0076, 0x0077, 
+	0x0078, 0x0079, 0x007a, 0x007b, 
+	0x007c, 0x007d, 0x007e, 0x007f, 
+	/* 0x80*/
+	0x0410, 0x0411, 0x0412, 0x0413, 
+	0x0414, 0x0415, 0x0416, 0x0417, 
+	0x0418, 0x0419, 0x041a, 0x041b, 
+	0x041c, 0x041d, 0x041e, 0x041f, 
+	/* 0x90*/
+	0x0420, 0x0421, 0x0422, 0x0423, 
+	0x0424, 0x0425, 0x0426, 0x0427, 
+	0x0428, 0x0429, 0x042a, 0x042b, 
+	0x042c, 0x042d, 0x042e, 0x042f, 
+	/* 0xa0*/
+	0x2020, 0x00b0, 0x0490, 0x00a3, 
+	0x00a7, 0x2022, 0x00b6, 0x0406, 
+	0x00ae, 0x00a9, 0x2122, 0x0402, 
+	0x0452, 0x2260, 0x0403, 0x0453, 
+	/* 0xb0*/
+	0x221e, 0x00b1, 0x2264, 0x2265, 
+	0x0456, 0x00b5, 0x0491, 0x0408, 
+	0x0404, 0x0454, 0x0407, 0x0457, 
+	0x0409, 0x0459, 0x040a, 0x045a, 
+	/* 0xc0*/
+	0x0458, 0x0405, 0x00ac, 0x221a, 
+	0x0192, 0x2248, 0x2206, 0x00ab, 
+	0x00bb, 0x2026, 0x00a0, 0x040b, 
+	0x045b, 0x040c, 0x045c, 0x0455, 
+	/* 0xd0*/
+	0x2013, 0x2014, 0x201c, 0x201d, 
+	0x2018, 0x2019, 0x00f7, 0x201e, 
+	0x040e, 0x045e, 0x040f, 0x045f, 
+	0x2116, 0x0401, 0x0451, 0x044f, 
+	/* 0xe0*/
+	0x0430, 0x0431, 0x0432, 0x0433, 
+	0x0434, 0x0435, 0x0436, 0x0437, 
+	0x0438, 0x0439, 0x043a, 0x043b, 
+	0x043c, 0x043d, 0x043e, 0x043f, 
+	/* 0xf0*/
+	0x0440, 0x0441, 0x0442, 0x0443, 
+	0x0444, 0x0445, 0x0446, 0x0447, 
+	0x0448, 0x0449, 0x044a, 0x044b, 
+	0x044c, 0x044d, 0x044e, 0x20ac, 
+};
+
+static unsigned char page00[256] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, /* 0x10-0x17 */
+	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, /* 0x18-0x1f */
+	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, /* 0x20-0x27 */
+	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 0x28-0x2f */
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, /* 0x30-0x37 */
+	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, /* 0x38-0x3f */
+	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x40-0x47 */
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, /* 0x48-0x4f */
+	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x50-0x57 */
+	0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, /* 0x58-0x5f */
+	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, /* 0x60-0x67 */
+	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, /* 0x68-0x6f */
+	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, /* 0x70-0x77 */
+	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, /* 0x78-0x7f */
+
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x80-0x87 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x88-0x8f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x90-0x97 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x98-0x9f */
+	0xca, 0x00, 0x00, 0xa3, 0x00, 0x00, 0x00, 0xa4, /* 0xa0-0xa7 */
+	0x00, 0xa9, 0x00, 0xc7, 0xc2, 0x00, 0xa8, 0x00, /* 0xa8-0xaf */
+	0xa1, 0xb1, 0x00, 0x00, 0x00, 0xb5, 0xa6, 0x00, /* 0xb0-0xb7 */
+	0x00, 0x00, 0x00, 0xc8, 0x00, 0x00, 0x00, 0x00, /* 0xb8-0xbf */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0xc0-0xc7 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0xc8-0xcf */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0xd0-0xd7 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0xd8-0xdf */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0xe0-0xe7 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0xe8-0xef */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xd6, /* 0xf0-0xf7 */
+};
+
+static unsigned char page01[256] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x00-0x07 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x08-0x0f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x10-0x17 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xb0, 0x00, /* 0x18-0x1f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x20-0x27 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x28-0x2f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x30-0x37 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x38-0x3f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x40-0x47 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x48-0x4f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x50-0x57 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x58-0x5f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x60-0x67 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x68-0x6f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x70-0x77 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x78-0x7f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x80-0x87 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x88-0x8f */
+	0x00, 0x00, 0xc4, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x90-0x97 */
+};
+
+static unsigned char page04[256] = {
+	0x00, 0xdd, 0xab, 0xae, 0xb8, 0xc1, 0xa7, 0xba, /* 0x00-0x07 */
+	0xb7, 0xbc, 0xbe, 0xcb, 0xcd, 0x00, 0xd8, 0xda, /* 0x08-0x0f */
+	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, /* 0x10-0x17 */
+	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, /* 0x18-0x1f */
+	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, /* 0x20-0x27 */
+	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f, /* 0x28-0x2f */
+	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, /* 0x30-0x37 */
+	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef, /* 0x38-0x3f */
+	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, /* 0x40-0x47 */
+	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xdf, /* 0x48-0x4f */
+	0x00, 0xde, 0xac, 0xaf, 0xb9, 0xcf, 0xb4, 0xbb, /* 0x50-0x57 */
+	0xc0, 0xbd, 0xbf, 0xcc, 0xce, 0x00, 0xd9, 0xdb, /* 0x58-0x5f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x60-0x67 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x68-0x6f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x70-0x77 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x78-0x7f */
+
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x80-0x87 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x88-0x8f */
+	0xa2, 0xb6, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x90-0x97 */
+};
+
+static unsigned char page20[256] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x00-0x07 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x08-0x0f */
+	0x00, 0x00, 0x00, 0xd0, 0xd1, 0x00, 0x00, 0x00, /* 0x10-0x17 */
+	0xd4, 0xd5, 0x00, 0x00, 0xd2, 0xd3, 0xd7, 0x00, /* 0x18-0x1f */
+	0xa0, 0x00, 0xa5, 0x00, 0x00, 0x00, 0xc9, 0x00, /* 0x20-0x27 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x28-0x2f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x30-0x37 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x38-0x3f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x40-0x47 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x48-0x4f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x50-0x57 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x58-0x5f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x60-0x67 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x68-0x6f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x70-0x77 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x78-0x7f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x80-0x87 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x88-0x8f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x90-0x97 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x98-0x9f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0xa0-0xa7 */
+	0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, /* 0xa8-0xaf */
+};
+
+static unsigned char page21[256] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x00-0x07 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x08-0x0f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xdc, 0x00, /* 0x10-0x17 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x18-0x1f */
+	0x00, 0x00, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x20-0x27 */
+};
+
+static unsigned char page22[256] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc6, 0x00, /* 0x00-0x07 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x08-0x0f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x10-0x17 */
+	0x00, 0x00, 0xc3, 0x00, 0x00, 0x00, 0xb0, 0x00, /* 0x18-0x1f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x20-0x27 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x28-0x2f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x30-0x37 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x38-0x3f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x40-0x47 */
+	0xc5, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x48-0x4f */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x50-0x57 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x58-0x5f */
+	0xad, 0x00, 0x00, 0x00, 0xb2, 0xb3, 0x00, 0x00, /* 0x60-0x67 */
+};
+
+static unsigned char *page_uni2charset[256] = {
+	page00, page01, NULL,   NULL,   page04, NULL,   NULL,   NULL,   
+	NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   
+	NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   
+	NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   
+	page20, page21, page22, NULL,   NULL,   NULL,   NULL,   NULL,   
+};
+
+static unsigned char charset2lower[256] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, /* 0x10-0x17 */
+	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, /* 0x18-0x1f */
+	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, /* 0x20-0x27 */
+	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 0x28-0x2f */
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, /* 0x30-0x37 */
+	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, /* 0x38-0x3f */
+	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x40-0x47 */
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, /* 0x48-0x4f */
+	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x50-0x57 */
+	0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, /* 0x58-0x5f */
+	0x60, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x60-0x67 */
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, /* 0x68-0x6f */
+	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x70-0x77 */
+	0x58, 0x59, 0x5a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, /* 0x78-0x7f */
+	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, /* 0x80-0x87 */
+	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef, /* 0x88-0x8f */
+	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, /* 0x90-0x97 */
+	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xdf, /* 0x98-0x9f */
+	0xa0, 0xa1, 0xb6, 0xa3, 0xa4, 0xa5, 0xa6, 0xb4, /* 0xa0-0xa7 */
+	0xa8, 0xa9, 0xaa, 0xac, 0xac, 0xad, 0xaf, 0xaf, /* 0xa8-0xaf */
+	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xc0, /* 0xb0-0xb7 */
+	0xb9, 0xb9, 0xbb, 0xbb, 0xbd, 0xbd, 0xbf, 0xbf, /* 0xb8-0xbf */
+	0xc0, 0xcf, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, /* 0xc0-0xc7 */
+	0xc8, 0xc9, 0xca, 0xcc, 0xcc, 0xce, 0xce, 0xcf, /* 0xc8-0xcf */
+	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, /* 0xd0-0xd7 */
+	0xd9, 0xd9, 0xdb, 0xdb, 0xdc, 0xde, 0xde, 0xdf, /* 0xd8-0xdf */
+	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, /* 0xe0-0xe7 */
+	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef, /* 0xe8-0xef */
+	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, /* 0xf0-0xf7 */
+	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff, /* 0xf8-0xff */
+};
+
+static unsigned char charset2upper[256] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, /* 0x10-0x17 */
+	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, /* 0x18-0x1f */
+	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, /* 0x20-0x27 */
+	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 0x28-0x2f */
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, /* 0x30-0x37 */
+	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, /* 0x38-0x3f */
+	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x40-0x47 */
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, /* 0x48-0x4f */
+	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x50-0x57 */
+	0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, /* 0x58-0x5f */
+	0x60, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x60-0x67 */
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, /* 0x68-0x6f */
+	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x70-0x77 */
+	0x58, 0x59, 0x5a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, /* 0x78-0x7f */
+	0x80, 0x81, 0x82, 0x81, 0x84, 0x85, 0x86, 0x87, /* 0x80-0x87 */
+	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, /* 0x88-0x8f */
+	0x80, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, /* 0x90-0x97 */
+	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f, /* 0x98-0x9f */
+	0xa0, 0xa1, 0xa1, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, /* 0xa0-0xa7 */
+	0xa8, 0xa9, 0xaa, 0xab, 0xab, 0xad, 0xae, 0xae, /* 0xa8-0xaf */
+	0xb0, 0xb1, 0xb2, 0xb3, 0xa7, 0xb5, 0xa2, 0xb7, /* 0xb0-0xb7 */
+	0xb8, 0xb8, 0xba, 0xba, 0xbc, 0xbc, 0xbe, 0xbe, /* 0xb8-0xbf */
+	0xb7, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, /* 0xc0-0xc7 */
+	0xc8, 0xc9, 0xca, 0xcb, 0xcb, 0xcd, 0xcd, 0xc1, /* 0xc8-0xcf */
+	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7, /* 0xd0-0xd7 */
+	0xd8, 0xd8, 0xda, 0xda, 0xdc, 0xdd, 0xdd, 0x9f, /* 0xd8-0xdf */
+	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, /* 0xe0-0xe7 */
+	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, /* 0xe8-0xef */
+	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, /* 0xf0-0xf7 */
+	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0xff, /* 0xf8-0xff */
+};
+
+static int uni2char(wchar_t uni, unsigned char *out, int boundlen)
+{
+	unsigned char *uni2charset;
+	unsigned char cl = uni & 0x00ff;
+	unsigned char ch = (uni & 0xff00) >> 8;
+
+	if (boundlen <= 0)
+		return -ENAMETOOLONG;
+
+	uni2charset = page_uni2charset[ch];
+	if (uni2charset && uni2charset[cl])
+		out[0] = uni2charset[cl];
+	else
+		return -EINVAL;
+	return 1;
+}
+
+static int char2uni(const unsigned char *rawstring, int boundlen, wchar_t *uni)
+{
+	*uni = charset2uni[*rawstring];
+	if (*uni == 0x0000)
+		return -EINVAL;
+	return 1;
+}
+
+static struct nls_table table = {
+	.charset	= "cp10007",
+	.uni2char	= uni2char,
+	.char2uni	= char2uni,
+	.charset2lower	= charset2lower,
+	.charset2upper	= charset2upper,
+	.owner		= THIS_MODULE,
+};
+
+static int __init init_nls_cp10007(void)
+{
+	return register_nls(&table);
+}
+
+static void __exit exit_nls_cp10007(void)
+{
+	unregister_nls(&table);
+}
+
+module_init(init_nls_cp10007)
+module_exit(exit_nls_cp10007)
+
+MODULE_LICENSE("Dual BSD/GPL");
--- linux-2.6.11.1/fs/nls/nls_cp10007.mod.c.orig	2005-03-18 00:35:51.000000000 +0300
+++ linux-2.6.11.1/fs/nls/nls_cp10007.mod.c	2005-03-18 00:35:51.000000000 +0300
@@ -0,0 +1,21 @@
+#include <linux/module.h>
+#include <linux/vermagic.h>
+#include <linux/compiler.h>
+
+MODULE_INFO(vermagic, VERMAGIC_STRING);
+
+#undef unix
+struct module __this_module
+__attribute__((section(".gnu.linkonce.this_module"))) = {
+ .name = __stringify(KBUILD_MODNAME),
+ .init = init_module,
+#ifdef CONFIG_MODULE_UNLOAD
+ .exit = cleanup_module,
+#endif
+};
+
+static const char __module_depends[]
+__attribute_used__
+__attribute__((section(".modinfo"))) =
+"depends=nls_base";
+
--- linux-2.6.11.1/fs/udf/super.c.orig	2005-03-18 00:34:31.000000000 +0300
+++ linux-2.6.11.1/fs/udf/super.c	2005-03-18 00:35:51.000000000 +0300
@@ -274,7 +274,7 @@
 	Opt_gid, Opt_uid, Opt_umask, Opt_session, Opt_lastblock,
 	Opt_anchor, Opt_volume, Opt_partition, Opt_fileset,
 	Opt_rootdir, Opt_utf8, Opt_iocharset,
-	Opt_err
+	Opt_err, Opt_ignore
 };
 
 static match_table_t tokens = {
@@ -299,6 +299,7 @@
 	{Opt_rootdir, "rootdir=%u"},
 	{Opt_utf8, "utf8"},
 	{Opt_iocharset, "iocharset=%s"},
+	{Opt_ignore, "hfscodepage=%s"},
 	{Opt_err, NULL}
 };
 
@@ -412,6 +413,7 @@
 				break;
 			case Opt_utf8:
 				uopt->flags |= (1 << UDF_FLAG_UTF8);
+			case Opt_ignore:
 				break;
 #ifdef CONFIG_UDF_NLS
 			case Opt_iocharset:
--- linux-2.6.11.1/fs/Kconfig.orig	2005-03-17 21:47:24.000000000 +0300
+++ linux-2.6.11.1/fs/Kconfig	2005-05-28 23:53:13.000000000 +0400
@@ -980,6 +980,14 @@
 	  To compile this file system support as a module, choose M here: the
 	  module will be called hfs.
 
+config HFS_DEFAULT_CODEPAGE
+	string "Default codepage for HFS"
+	depends on HFS_FS
+	default "437"
+	help
+	  This option should be set to the codepage of your HFS filesystems.
+	  It can be overridden with the 'codepage' mount option.
+
 config HFSPLUS_FS
 	tristate "Apple Extended HFS file system support"
 	select NLS
--- linux-2.6.11.1/Documentation/filesystems/hfs.txt.orig	2005-03-04 20:26:37.000000000 +0300
+++ linux-2.6.11.1/Documentation/filesystems/hfs.txt	2005-05-28 23:57:52.000000000 +0400
@@ -41,6 +41,20 @@
   quiet
   	Ignore invalid mount options instead of complaining.
 
+  iocharset=name
+	Character set to use for converting file names. Specifies character
+	set used by your Linux system. Currently only HFS supports character
+	set translation, HFS+ simply ignores this argument.
+	
+	Character set conversion needs excessive testing so it gets enabled
+	only when you specify this argument in mount options. If you have
+	any problems, remove it, this will restore old behavour of the
+	filesystem (no translation is done).
+
+  hfscodepage=###
+	Set the codepage number for converting file names. Specifies
+	character set used by Macintoshes in your country. Also ignored by
+	HFS+.
 
 Writing to HFS Filesystems
 ==========================


--------------020005070807030202040109--

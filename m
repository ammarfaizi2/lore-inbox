Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVHHMyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVHHMyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 08:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVHHMyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 08:54:55 -0400
Received: from NS5.Sony.CO.JP ([137.153.0.45]:57774 "EHLO ns5.sony.co.jp")
	by vger.kernel.org with ESMTP id S1750848AbVHHMyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 08:54:54 -0400
Message-ID: <42F7561F.4010308@sm.sony.co.jp>
Date: Mon, 08 Aug 2005 21:54:55 +0900
From: Hiroyuki Machida <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] Posix file attribute support on VFAT
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ogawa-san and FAT developpers,

Here is a patch to enable posix file attribute mapping to VFAT attributes,
with restrictions.

Main purpose of this patch is to build root file system with VFAT for small
embedded device. FAT is widely used for embedded device to exchange data,
and also small embedded device has resource limitation. So it's very handy
that VFAT has capability to built root fs, even that has restrictions.

Details are described within a patch. I think this feature still needs
improvemnts, however it is very helpful for most embedded developpers.

Thanks,
Hiroyuki Machida

---

* vfat-posix_attr.patch:

 fs/fat/file.c            |   10 +
 fs/fat/inode.c           |   27 +++
 fs/vfat/namei.c          |  291 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/msdos_fs.h |  320 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 646 insertions(+), 2 deletions(-)

Signed-off-by: Hiroyuki Machida <machida@sm.sony.co.jp>

This patch enables "posix_attr" option described as following;


	"posix_attr" mapping support on VFAT.

- Descriptions

The option "posix_attr" enables attribute mapping from POSIX 
special files and permission modes/attributes to VFAT attributes 
and creation time fields.

On memory resident inode storage holds full posix attributes,
however in media side, VFAT can't have enough room to store all
attributes. So attribute mapping taken by this option 
is designed to be minimal.

For newly created and/or modified files/dirs, system can utilize 
full posix attributes, because memory resident inode storage can
hold those. After umount-mount cycle, system may lose some 
attributes to preserve VFAT format.

This mapping method has many restrictions, however it's
very handy to build root file system with FAT for small embedded 
device where inter-operation with PC is needed.

- Features
	
Following attributes/modes are supported with this option
in VFAT media side. However, on memory resident inode storage 
holds full posix attributes.  That means, for newly created and/or 
modified files/dirs, system can utilize full posix attributes. 
After umount-mount cycle, system can just keep following 
attributes/modes.

  - FileType
	File type is held in 3MSB bits in ctime_cs.
	This enables support following special files.
		symbolic link,
		block device node,
		char device node,
		fifo,
		socket
	Regular files also may have POSIX attributes.

  - DeviceFile
	Major and minor number would be held at ctime
	and both values are limited  to 255.

  - Owner's User ID/Group ID:		2nd LSB bit in ctime_cs 
	This can be used to distinguish root and others,
	because this has just one bit width. 
	Value of UID/GID for non-root user will be taken from uid/gid 
	option on mounting. If nothing is specified, system uses -1 as 
	last resort.

  - Permission for Group/Other (rwx):	3rd-5th LSB bit in ctime_cs
	Those modes will be kept in ctime_cs.
	Also permission modes for "others" will be
	same as "group", due to lack of fields.

  - Permission for Owner (rwx)
	These modes will be mapped to FAT attributes.
	Just same as mapping under VFAT.

  - Others
	no sticky, setgid nor setuid bits are not supported.

- Algorithm for attribute mapping decision

  - Regular file/dir
	To distinguish regular files/dirs, look if this fat dir 
	entry doesn't have ATTR_SYS, first. If it doesn't have 
	ATTR_SYS, then check if TYPE field (MSB 3bits) in ctime_cs 
	is equal to 7. If so, this regular file/dir is created and/or 
	modified under VFAT with "poisx_attr". And posix attribute 
	mapping can be take place. Otherwise, conventional VFAT 
	attribute mapping is used.

  - Special file
	To distinguish special files, look if this fat dir entry 
	has ATTR_SYS, first. If it has ATTR_SYS, then check
	1st. LSB bit in ctime_cs, refered as "special file flag".
	If set,  this file is created under VFAT with "posix_attr". 
	Look up TYPE field to decide special file type.
	This spcial file detection mothod has some flaw to make
	potential confusion. E.g. some system file created under
	dos/win may be treated as special file.  However in most case,
	user don't create system file under dos/win.


- FAT DIR entry fields description

  - ctime_cs

	    8bit byte
	7 6 5 4 3 2 1 0
	|===| | | | | |
	TYPE  | | | | +- special file flag (vaild if ATTR_SYS)
	      | | | +--- User/Group ID(owner)
	      | | +----- !group X
	      | +------- !group W
	      +--------- !group R

		

	special file flag
		Indicate this entry has posix attribut mapping.
		This field is vaild for fat dir entry, which 
		have ATTR_SYS.

	special file TYPE
		val	type on VFS(val)	Description
		------------------------------------------------
		0 	(place folder for backword compat)
		1 	DT_LNK (10)		symbolic link
		2	DT_BLK (6)		block dev
		3	DT_CHR (4)		char dev
		4	DT_FIFO (1)		fifo
		5	DT_SOCK	(12)		socket
	
		7	(resevered for DT_REG/DT_DIR) *)

		*)Value 7 is reserved for regular file/dir (DT_REG/DT_DIR).
		Normally ctime_cs would have 0-199 value to stand for 
		up to 2sec. The value for DT_REG/DT_DIR is selected 
		to be over this range to distinguish if file was created
		under POSIX_ATTR or not.

  - attr
	FAT attribute	(val)		mapped attribute
	------------------------------------------------
	ATTR_RO		0x01 		!owner W
	ATTR_HIDDEN	0x02		!owner R
	ATTR_SYS	0x04
	ATTR_VOLUME	0x08
	ATTR_DIR	0x10		DIR
	ATTR_ARCH	0x20		!owner X

  - ctime
		16bit word
	f e d c b a 9 8 7 6 5 4 3 2 1 0
	|=============| |-------------|
	  major		  minor


---
* looking for alp@oak--linux-1/alp-linux--dev-2-6-12--1.7--patch-8 to compare with
* comparing to alp@oak--linux-1/alp-linux--dev-2-6-12--1.7--patch-8
M  fs/fat/file.c
M  fs/vfat/namei.c
M  include/linux/msdos_fs.h
M  fs/fat/inode.c

* modified files

--- orig/fs/fat/file.c
+++ mod/fs/fat/file.c
@@ -179,6 +179,10 @@
 			error = 0;
 		goto out;
 	}
+	if (sbi->options.posix_attr){
+		error = inode_setattr(inode, attr);
+		goto out;
+	}
 	if (((attr->ia_valid & ATTR_UID) &&
 	     (attr->ia_uid != sbi->options.fs_uid)) ||
 	    ((attr->ia_valid & ATTR_GID) &&
@@ -306,3 +310,9 @@
 	.truncate	= fat_truncate,
 	.setattr	= fat_notify_change,
 };
+
+struct inode_operations fat_symlink_inode_operations = {
+       .readlink       = page_readlink,
+       .follow_link    = page_follow_link_light,
+       .setattr        = fat_notify_change,
+};


--- orig/fs/fat/inode.c
+++ mod/fs/fat/inode.c
@@ -274,6 +274,10 @@
 		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
 		inode->i_size = le32_to_cpu(de->size);
 		inode->i_op = &fat_file_inode_operations;
+		if (sbi->options.posix_attr
+			&& is_vfat_posix_symlink(inode, de)){
+				inode->i_op = &fat_symlink_inode_operations;
+		}
 		inode->i_fop = &fat_file_operations;
 		inode->i_mapping->a_ops = &fat_aops;
 		MSDOS_I(inode)->mmu_private = inode->i_size;
@@ -499,8 +503,11 @@
 	fat_date_unix2dos(inode->i_mtime.tv_sec, &raw_entry->time, &raw_entry->date);
 	if (sbi->options.isvfat) {
 		fat_date_unix2dos(inode->i_ctime.tv_sec,&raw_entry->ctime,&raw_entry->cdate);
-		raw_entry->ctime_cs = (inode->i_ctime.tv_sec & 1) * 100 +
-			inode->i_ctime.tv_nsec / 10000000;
+		if (set_vfat_posix_attr(raw_entry, inode) == -1) {
+			raw_entry->ctime_cs 
+				= (inode->i_ctime.tv_sec & 1) * 100 +
+					inode->i_ctime.tv_nsec / 10000000;
+		}
 	}
 	spin_unlock(&sbi->inode_hash_lock);
 	mark_buffer_dirty(bh);
@@ -742,6 +749,8 @@
 			seq_puts(m, ",uni_xlate");
 		if (!opts->numtail)
 			seq_puts(m, ",nonumtail");
+		if (opts->posix_attr)
+			seq_puts(m, ",posix_attr");
 	}
 
 	return 0;
@@ -755,6 +764,7 @@
 	Opt_charset, Opt_shortname_lower, Opt_shortname_win95,
 	Opt_shortname_winnt, Opt_shortname_mixed, Opt_utf8_no, Opt_utf8_yes,
 	Opt_uni_xl_no, Opt_uni_xl_yes, Opt_nonumtail_no, Opt_nonumtail_yes,
+	Opt_posix_attr_no, Opt_posix_attr_yes,
 	Opt_obsolate, Opt_err,
 };
 
@@ -823,6 +833,13 @@
 	{Opt_nonumtail_yes, "nonumtail=yes"},
 	{Opt_nonumtail_yes, "nonumtail=true"},
 	{Opt_nonumtail_yes, "nonumtail"},
+	{Opt_posix_attr_no, "posix_attr=0"},		/* 0 or no or false */
+	{Opt_posix_attr_no, "posix_attr=no"},
+	{Opt_posix_attr_no, "posix_attr=false"},
+	{Opt_posix_attr_yes, "posix_attr=1"},	/* empty or 1 or yes or true */
+	{Opt_posix_attr_yes, "posix_attr=yes"},
+	{Opt_posix_attr_yes, "posix_attr=true"},
+	{Opt_posix_attr_yes, "posix_attr"},
 	{Opt_err, NULL}
 };
 
@@ -980,6 +997,12 @@
 		case Opt_nonumtail_yes:		/* empty or 1 or yes or true */
 			opts->numtail = 0;	/* negated option */
 			break;
+		case Opt_posix_attr_no:		/* 0 or no or false */
+			opts->posix_attr = 0;
+			break;
+		case Opt_posix_attr_yes:	/* empty or 1 or yes or true */
+			opts->posix_attr = 1;
+			break;
 
 		/* obsolete mount options */
 		case Opt_obsolate:


--- orig/fs/vfat/namei.c
+++ mod/fs/vfat/namei.c
@@ -24,6 +24,190 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include <linux/namei.h>
+#include <linux/fs.h>
+
+#define	GET_INODE_FILE_TYPE(x)	(((x)->i_mode & 0xf000) >> 12)
+#define	GET_INODE_OWNER_R(x)	(((x)->i_mode & 0x0100) >> 8)
+#define	GET_INODE_OWNER_W(x)	(((x)->i_mode & 0x0080) >> 7)
+#define	GET_INODE_OWNER_X(x)	(((x)->i_mode & 0x0040) >> 6)
+#define	GET_INODE_GROUP_R(x)	(((x)->i_mode & 0x0020) >> 5)
+#define	GET_INODE_GROUP_W(x)	(((x)->i_mode & 0x0010) >> 4)
+#define	GET_INODE_GROUP_X(x)	(((x)->i_mode & 0x0008) >> 3)
+#define	GET_INODE_USER_ID(x)	((x)->i_uid ? 1 : 0)
+#define	GET_INODE_DRV_MAJOR(x)	((x)->i_rdev >> MINORBITS)
+#define	GET_INODE_DRV_MINOR(x)	((x)->i_rdev & MINORMASK)
+
+static unsigned short  filetype_table[] = {
+	DT_REG, /* place folder for backward compat */
+	DT_LNK,
+	DT_BLK,
+	DT_CHR,
+	DT_FIFO,
+	DT_SOCK,
+	0
+};
+
+/**
+ * is_vfat_posix_symlink - check if posix file type from VFAT dir is symlink
+ *
+ * Returns
+ *	        0 ... is not symlink or don't have posix attributes
+ *	otherwise ... is symlink
+ */
+int is_vfat_posix_symlink(struct inode *inode, struct msdos_dir_entry *dentry)
+{
+	if (get_fat_attr_sys(dentry) && get_posix_attr_spec_file(dentry)) {
+		return (filetype_table[get_posix_attr_file_type(dentry)]
+			== DT_LNK);
+	}
+	return 0;
+}
+
+/*
+ * get_vfat_posix_attr - Retrieve posix attributes from VFAT dir entry
+ */
+static inline
+void get_vfat_posix_attr(struct inode *inode, struct msdos_dir_entry *dentry)
+{
+	int uid;
+	int gid;
+	struct msdos_sb_info *sbi;
+	int ftype;
+
+	if (!(inode && dentry) || IS_ERR(inode)) 
+		goto out;
+	sbi = MSDOS_SB(inode->i_sb);
+	if (!sbi->options.posix_attr) 
+		goto out;
+
+	/* File type : 0xF000 : 12 */
+	ftype = -1;
+	if (!get_fat_attr_sys(dentry)) {
+		if (get_posix_attr_reg_file(dentry))
+			ftype = get_fat_attr_dir(dentry) ? DT_DIR : DT_REG;
+	} else if (get_posix_attr_spec_file(dentry)) {
+		ftype = filetype_table[get_posix_attr_file_type(dentry)]; 
+	}
+	if (ftype == -1)
+		goto out;
+	inode->i_mode = ftype << 12;
+
+	/* Owner : 0x01C0) : 6 */
+	inode->i_mode |= (((get_posix_attr_owner_r(dentry) << 2) 
+		| (get_posix_attr_owner_w(dentry) << 1) 
+		| get_posix_attr_owner_x(dentry)) << 6);
+	/* Group : 0x0038) : 3 */
+	inode->i_mode |= (((get_posix_attr_group_r(dentry) << 2) 
+		| (get_posix_attr_group_w(dentry) << 1) 
+		| get_posix_attr_group_x(dentry)) << 3);
+	/* Other : 0x0007 */
+	inode->i_mode |= ((get_posix_attr_group_r(dentry) << 2) 
+		| (get_posix_attr_group_w(dentry) << 1) 
+		| get_posix_attr_group_x(dentry));
+	/* User & Group ID */
+	uid = sbi->options.fs_uid;
+	gid = sbi->options.fs_gid;
+	if (!uid) uid = -1;
+	if (!gid) gid = -1;
+	inode->i_uid = (int)get_posix_attr_user_id(dentry) ?  uid : 0;
+	inode->i_gid = (int)get_posix_attr_user_id(dentry) ?  gid : 0;
+
+	/* Special file */
+	switch (ftype) {
+	case DT_BLK:
+		inode->i_rdev = 
+			((get_posix_attr_drv_major(dentry) << MINORBITS) 
+			| get_posix_attr_drv_minor(dentry));
+		inode->i_mode &= ~S_IFMT;
+		inode->i_mode |= S_IFBLK;
+		init_special_inode( inode, inode->i_mode, inode->i_rdev );
+		break;
+	case DT_CHR:
+		inode->i_rdev = 
+			((get_posix_attr_drv_major(dentry) << MINORBITS) 
+			| get_posix_attr_drv_minor(dentry));
+		inode->i_mode &= ~S_IFMT;
+		inode->i_mode |= S_IFCHR;
+		init_special_inode( inode, inode->i_mode, inode->i_rdev );
+		break;
+	case DT_FIFO:
+		inode->i_mode &= ~S_IFMT;
+		inode->i_mode |= S_IFIFO;
+		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+		break;
+	case DT_SOCK:
+		inode->i_mode &= ~S_IFMT;
+		inode->i_mode |= S_IFSOCK;
+		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+		break;
+	}
+out:
+	return;
+}
+
+/**
+ * set_vfat_posix_attr - set posix attributes to VFAT dir entry
+ *
+ * Returns
+ *	 0 ... posix_attr are set
+ *	-1 ... posix_attr are not set
+ */
+int set_vfat_posix_attr(struct msdos_dir_entry *dentry, struct inode *inode)
+{
+	int     ftype;
+
+	if (!(inode && dentry) || IS_ERR(inode)) 
+		goto not_set;
+	if (!MSDOS_SB(inode->i_sb)->options.posix_attr) 
+		goto not_set;
+
+	/* File type */
+	switch (GET_INODE_FILE_TYPE(inode)) {
+	case DT_DIR:
+		set_fat_attr_dir(dentry, 1);
+		/* fall through */
+	case DT_REG:
+		set_posix_attr_reg_file(dentry, 1);
+		break;
+	default:
+		for(ftype=0; filetype_table[ftype]; ftype++){
+			if (filetype_table[ftype] ==
+				GET_INODE_FILE_TYPE(inode)){
+					break;
+			}
+		}
+		if (!filetype_table[ftype])
+			goto not_set;
+		/* mark posix attr for special file */
+		set_fat_attr_sys(dentry,1);
+		set_posix_attr_spec_file(dentry, 1);
+		set_posix_attr_file_type(dentry, ftype);
+		break;
+	}
+	/* Permissions for Owner */
+	set_posix_attr_owner_r(dentry, GET_INODE_OWNER_R(inode));
+	set_posix_attr_owner_w(dentry, GET_INODE_OWNER_W(inode));
+	set_posix_attr_owner_x(dentry, GET_INODE_OWNER_X(inode));
+	/* Permissions for Group/Others */
+	set_posix_attr_group_r(dentry, GET_INODE_GROUP_R(inode));
+	set_posix_attr_group_w(dentry, GET_INODE_GROUP_W(inode));
+	set_posix_attr_group_x(dentry, GET_INODE_GROUP_X(inode));
+	/* User ID */
+	set_posix_attr_user_id(dentry, GET_INODE_USER_ID(inode));
+
+	/* Deivce number */
+	switch (GET_INODE_FILE_TYPE(inode)) {
+	case DT_CHR:
+		/* fall through */
+	case DT_BLK:
+		set_posix_attr_drv_major(dentry, GET_INODE_DRV_MAJOR(inode));
+		set_posix_attr_drv_minor(dentry, GET_INODE_DRV_MINOR(inode));
+		break;
+	}
+	return 0;
+not_set:
+	return -1;
+}
 
 static int vfat_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
@@ -721,6 +905,7 @@
 		goto error;
 	}
 	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
+	get_vfat_posix_attr(inode, sinfo.de);
 	brelse(sinfo.bh);
 	if (IS_ERR(inode)) {
 		unlock_kernel();
@@ -774,6 +959,10 @@
 	}
 	inode->i_version++;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
+	if (MSDOS_SB(sb)->options.posix_attr) {
+		inode->i_mode = mode;
+		mark_inode_dirty(inode);
+	}
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
@@ -868,6 +1057,10 @@
 	inode->i_version++;
 	inode->i_nlink = 2;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
+	if (MSDOS_SB(sb)->options.posix_attr) {
+		inode->i_mode = (S_IFDIR | (mode & 0x0fff));
+		mark_inode_dirty(inode);
+	}
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
@@ -1023,6 +1216,102 @@
 	goto out;
 }
 
+static
+int vfat_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+{
+	/* base : vfat_create() */
+	struct super_block *sb = dir->i_sb;
+	struct inode *inode = NULL;
+	struct fat_slot_info sinfo;
+	struct timespec ts;
+	int err;
+	int len;
+
+#define	VFAT_POSIX_ATTR_MAXNAME	255
+
+	if (!MSDOS_SB(sb)->options.posix_attr)
+		return -EOPNOTSUPP;
+
+	len = strlen (symname) + 1;
+	if (len >= VFAT_POSIX_ATTR_MAXNAME) {
+		return -ENAMETOOLONG;
+	}
+
+	lock_kernel();
+
+	ts = CURRENT_TIME_SEC;
+	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &ts, &sinfo);
+	if (err)
+		goto out;
+	dir->i_version++;
+
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
+	brelse(sinfo.bh);
+	if (IS_ERR(inode)){
+		err = PTR_ERR(inode);
+		goto out;
+	}
+	inode->i_version++;
+	inode->i_mode = (S_IFLNK | 0777);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
+	inode->i_op = &fat_symlink_inode_operations;
+	mark_inode_dirty(inode);
+
+	dentry->d_time = dentry->d_parent->d_inode->i_version;
+	d_instantiate(dentry,inode);
+
+	err = page_symlink(dentry->d_inode, symname, len);
+out:
+	unlock_kernel();
+	return err;
+}
+
+static
+int vfat_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
+{
+	/* base : vfat_create() */
+	struct super_block *sb = dir->i_sb;
+	struct inode *inode = NULL;
+	struct fat_slot_info sinfo;
+	struct timespec ts;
+	int err;
+
+	if (!MSDOS_SB(sb)->options.posix_attr)
+		return -EOPNOTSUPP;
+
+	lock_kernel();
+
+	ts = CURRENT_TIME_SEC;
+	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &ts, &sinfo);
+	if (err)
+		goto out;
+	dir->i_version++;
+
+	inode = fat_build_inode(sb, sinfo.de, sinfo.i_pos);
+	brelse(sinfo.bh);
+	if (IS_ERR(inode)){
+		err = PTR_ERR(inode);
+		goto out;
+	}
+	inode->i_version++;
+
+	inode->i_mode = mode;
+	inode->i_rdev = rdev;
+
+	inode->i_mtime = inode->i_atime = inode->i_ctime = ts;
+	init_special_inode(inode, mode, rdev);
+	mark_inode_dirty(inode);
+
+	dentry->d_time = dentry->d_parent->d_inode->i_version;
+	d_instantiate(dentry, inode);
+
+	err = 0;
+
+out:
+	unlock_kernel();
+	return err;
+}
+
 static struct inode_operations vfat_dir_inode_operations = {
 	.create		= vfat_create,
 	.lookup		= vfat_lookup,
@@ -1031,6 +1320,8 @@
 	.rmdir		= vfat_rmdir,
 	.rename		= vfat_rename,
 	.setattr	= fat_notify_change,
+	.symlink	= vfat_symlink,
+	.mknod		= vfat_mknod,
 };
 
 static int vfat_fill_super(struct super_block *sb, void *data, int silent)


--- orig/include/linux/msdos_fs.h
+++ mod/include/linux/msdos_fs.h
@@ -199,6 +199,7 @@
 		 sys_immutable:1, /* set = system files are immutable */
 		 dotsOK:1,        /* set = hidden and system files are named '.filename' */
 		 isvfat:1,        /* 0=no vfat long filename support, 1=vfat support */
+		 posix_attr:1,       /* 1= posix attribute mapping support */
 		 utf8:1,	  /* Use of UTF8 character set (Default) */
 		 unicode_xlate:1, /* create escape sequences for unhandled Unicode */
 		 numtail:1,       /* Does first alias have a numeric '~1' type tail? */
@@ -386,6 +387,7 @@
 			     unsigned int cmd, unsigned long arg);
 extern struct file_operations fat_file_operations;
 extern struct inode_operations fat_file_inode_operations;
+extern struct inode_operations fat_symlink_inode_operations;
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 extern void fat_truncate(struct inode *inode);
 
@@ -407,6 +409,324 @@
 extern void fat_date_unix2dos(int unix_date, __le16 *time, __le16 *date);
 extern int fat_sync_bhs(struct buffer_head **bhs, int nr_bhs);
 
+/*
+ * vfat posix attr option "posix_attr" stuffs
+ *
+ * FEATURES
+ *	
+ * Following attributes/modes are supported in posix attribute mapping
+ * in VFAT media side. That is, for newly created and/or modified files/dirs,
+ * system can utilize full posix attributes. After umount-mount cycle, system
+ * can keep following attributes/modes.
+ *   - FileType
+ * 	This supports following special files and it's attributes;
+ * 		symbolic link,	block device node,
+ * 		char device node, fifo,	socket
+ * 	Regular files/dirs also may have POSIX attributes.
+ *   - DeviceFile
+ * 	Major and minor number would be held at ctime
+ * 	and both values are limited  to 255.
+ *   - Owner's User ID/Group ID 
+ * 	This can be used to distinguish root and others,
+ * 	because this has just one bit width. 
+ * 	Value of UID/GID for non-root user will be taken from uid/gid 
+ * 	option on mounting. If nothing is specified, system uses -1 as 
+ * 	last resort.
+ *   - Permission for Group/Other (rwx)
+ * 	Those modes will be kept in ctime_cs.
+ * 	Also permission modes for "others" will be
+ * 	same as "group", due to lack of fields.
+ *   - Permission for Owner (rwx)
+ * 	These modes will be mapped to FAT attributes.
+ * 	Just same as mapping under VFAT.
+ *   - Others
+ * 	no sticky, setgid nor setuid bits are not supported.
+ * 
+ *ALGORITHM FOR MAPPING DECISION
+ *   - Regular file/dir
+ * 	To distinguish regular files/dirs, look if this fat dir 
+ * 	entry doesn't have ATTR_SYS, first. If it doesn't have 
+ * 	ATTR_SYS, then check if TYPE field (MSB 3bits) in ctime_cs 
+ * 	is equal to 7. If so, this regular file/dir is created and/or 
+ * 	modified under VFAT with "posix_attr". And posix attribute 
+ * 	mapping can be take place. Otherwise, conventional VFAT 
+ * 	attribute mapping is used.
+ *   - Special file
+ * 	To distinguish special files, look if this fat dir entry 
+ * 	has ATTR_SYS, first. If it has ATTR_SYS, then check
+ * 	1st. LSB bit in ctime_cs, referred as "special file flag".
+ * 	If set,  this file is created under VFAT with "posix_attr". 
+ * 	Look up TYPE field to decide special file type.
+ * 	This special file detection method has some flaw to make
+ * 	potential confusion. E.g. some system file created under
+ *	dos/win may be treated as special file.  However in most case,
+ *	user don't create system file under dos/win.
+ *
+ *
+ *FAT DIR ENTRY FIELDS
+ *
+ *   - ctime_cs
+ * 	    8bit byte
+ * 	7 6 5 4 3 2 1 0
+ * 	|===| | | | | |
+ * 	TYPE  | | | | +- special file flag (valid if ATTR_SYS)
+ * 	      | | | +--- User/Group ID(root or others)
+ * 	      | | +----- !group X
+ * 	      | +------- !group W
+ * 	      +--------- !group R
+ * 
+ * 	  special file flag
+ * 		Indicate this entry has posix attribute mapping.
+ * 		This field is valid for fat dir entry, which 
+ * 		have ATTR_SYS.
+ * 
+ * 	  special file TYPE
+ * 		val	type on VFS(val)	Description
+ * 		------------------------------------------------
+ * 		0 	(place folder for backward compat)
+ * 		1 	DT_LNK (10)		symbolic link
+ * 		2	DT_BLK (6)		block dev
+ * 		3	DT_CHR (4)		char dev
+ * 		4	DT_FIFO (1)		fifo
+ * 		5	DT_SOCK	(12)		socket
+ * 	
+ * 		7*)	(reserved for DT_REG/DT_DIR) 
+ * 
+ * 		*)Value 7 is reserved for regular file/dir (DT_REG/DT_DIR).
+ * 		Normally ctime_cs would have 0-199 value to stand for 
+ * 		up to 2sec. The value for DT_REG/DT_DIR is selected 
+ * 		to be over this range to distinguish if file was created
+ * 		under POSIX_ATTR or not.
+ *
+ *   - attr
+ * 	FAT attribute	(val)		mapped attribute
+ * 	------------------------------------------------
+ * 	ATTR_RO		0x01 		!owner W
+ * 	ATTR_HIDDEN	0x02		!owner R
+ * 	ATTR_SYS	0x04
+ * 	ATTR_VOLUME	0x08
+ * 	ATTR_DIR	0x10		DIR
+ * 	ATTR_ARCH	0x20		!owner X
+ *
+ *   - ctime
+ * 		16bit word
+ * 	f e d c b a 9 8 7 6 5 4 3 2 1 0
+ * 	|=============| |-------------|
+ * 	  major		  minor
+ * 
+ */
+
+/* FAT ATTR_SYS */
+static inline 
+int get_fat_attr_sys(struct msdos_dir_entry *de)
+{
+	return ((de->attr & 0x4)>>2);
+}
+
+static inline 
+void set_fat_attr_sys(struct msdos_dir_entry *de, int val)
+{
+	de->attr = (((val << 2) & 0x4) | (de->attr & 0xfb));
+}
+
+/* FAT ATTR_DIR */
+static inline 
+int get_fat_attr_dir(struct msdos_dir_entry *de)
+{
+	return ((de->attr & 0x10)>>4);
+}
+
+static inline 
+void set_fat_attr_dir(struct msdos_dir_entry *de, int val)
+{
+	de->attr = (((val << 4) & 0x10) | (de->attr & 0xef));
+}
+
+/* regular file/dir flag */
+static inline 
+int get_posix_attr_reg_file(struct msdos_dir_entry *de)
+{
+	return ((de->ctime_cs & 0xe0) == 0xe0);
+}
+
+static inline 
+void set_posix_attr_reg_file(struct msdos_dir_entry *de, int val)
+{
+	val = val ? 0xe0 : 0;
+	de->ctime_cs = (val | (de->ctime_cs & 0x1f));
+}
+
+/* special file flag */
+static inline 
+int get_posix_attr_spec_file(struct msdos_dir_entry *de)
+{
+	return (de->ctime_cs & 0x01);
+}
+
+static inline 
+void set_posix_attr_spec_file(struct msdos_dir_entry *de, int val)
+{
+	val = val ? 0x01 : 0x00;
+	de->ctime_cs = (val | (de->ctime_cs & 0xfe));
+}
+
+/* file type */
+static inline 
+int get_posix_attr_file_type(struct msdos_dir_entry *de)
+{
+	return ((de->ctime_cs & 0xe0) >> 5);
+}
+
+static inline 
+void set_posix_attr_file_type(struct msdos_dir_entry *de, int val)
+{
+	val = (val & 0x3) << 5;
+	de->ctime_cs = (val | (de->ctime_cs & 0x1f));
+}
+
+/* owner r */
+static inline 
+int get_posix_attr_owner_r(struct msdos_dir_entry *de)
+{
+	return (((de->attr & 0x02) >> 1) ^ 1);
+}
+
+static inline 
+void set_posix_attr_owner_r(struct msdos_dir_entry *de, int val)
+{
+	val = val ? 0 : 0x02;
+	de->attr = (val | (de->attr & 0xfd));
+}
+
+/* owner w */
+static inline 
+int get_posix_attr_owner_w(struct msdos_dir_entry *de)
+{
+	return ((de->attr & 0x01) ^ 1);
+}
+
+static inline 
+void set_posix_attr_owner_w(struct msdos_dir_entry *de, int val)
+{
+	val = val ? 0 : 0x01;
+	de->attr = (val | (de->attr & 0xfe));
+}
+
+/* owner x */
+static inline 
+int get_posix_attr_owner_x(struct msdos_dir_entry *de)
+{
+	return (((de->attr & 0x20) >> 5) ^ 1);
+}
+
+static inline 
+void set_posix_attr_owner_x(struct msdos_dir_entry *de, int val)
+{
+	val = val ? 0 : 0x20;
+	de->attr = (val | (de->attr & 0xdf));
+}
+
+/* group r */
+static inline 
+int get_posix_attr_group_r(struct msdos_dir_entry *de)
+{
+	return (((de->ctime_cs & 0x10) >> 4) ^ 1);
+}
+
+static inline 
+void set_posix_attr_group_r(struct msdos_dir_entry *de, int val)
+{
+	val = val ? 0 : 0x10;
+	de->ctime_cs = (val | (de->ctime_cs & 0xef));
+}
+
+/* group w */
+static inline 
+int get_posix_attr_group_w(struct msdos_dir_entry *de)
+{
+	return (((de->ctime_cs & 0x08) >> 3) ^ 1);
+}
+
+static inline 
+void set_posix_attr_group_w(struct msdos_dir_entry *de, int val)
+{
+	val = val ? 0 : 0x08;
+	de->ctime_cs = (val | (de->ctime_cs & 0xf7));
+}
+
+/* group x */
+static inline 
+int get_posix_attr_group_x(struct msdos_dir_entry *de)
+{
+	return (((de->ctime_cs & 0x04) >> 2) ^ 1);
+}
+
+static inline 
+void set_posix_attr_group_x(struct msdos_dir_entry *de, int val)
+{
+	val = val ? 0 : 0x04;
+	de->ctime_cs = (val | (de->ctime_cs & 0xfb));
+}
+
+/* user id */
+static inline 
+int get_posix_attr_user_id(struct msdos_dir_entry *de)
+{
+	return ((de->ctime_cs & 0x02) >> 1);
+}
+
+static inline 
+void set_posix_attr_user_id(struct msdos_dir_entry *de, int val)
+{
+	val = val ? 0x02 : 0;
+	de->ctime_cs = (val | (de->ctime_cs & 0xfd));
+}
+
+/* driver major number */
+static inline 
+int get_posix_attr_drv_major(struct msdos_dir_entry *de)
+{
+	return ((de->ctime & 0xff00) >> 8);
+}
+
+static inline 
+void set_posix_attr_drv_major(struct msdos_dir_entry *de, int val)
+{
+	val = (val & 0xff) << 8;
+	de->ctime = (val | (de->ctime & 0x00ff));
+}
+
+/* driver minor number */
+static inline 
+int get_posix_attr_drv_minor(struct msdos_dir_entry *de)
+{
+	return (de->ctime & 0x00ff);
+}
+
+static inline 
+void set_posix_attr_drv_minor(struct msdos_dir_entry *de, int val)
+{
+	de->ctime = ((val & 0x00ff) | (de->ctime & 0xff00));
+}
+
+#ifdef CONFIG_VFAT_FS
+/* fs/vfat/namei.c */
+extern int is_vfat_posix_symlink(struct inode *, struct msdos_dir_entry *);
+extern int set_vfat_posix_attr(struct msdos_dir_entry *, struct inode *);
+#else /* CONFIG_VFAT_FS */
+static inline int 
+is_vfat_posix_symlink(struct inode *inode, struct msdos_dir_entry *de)
+{
+	return -1;
+}
+
+static inline int 
+set_vfat_posix_attr(struct msdos_dir_entry *de, struct inode *inode)
+{
+	return -1;
+}
+#endif /* CONFIG_VFAT_FS */
+
 #endif /* __KERNEL__ */
 
 #endif






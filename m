Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270437AbTGUPzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270189AbTGUPxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:53:52 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:21257 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S270179AbTGUPnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:43:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] signed char cleanup/fixes (10/11)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 22 Jul 2003 00:58:18 +0900
Message-ID: <87k7abvplx.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes char type of filename to unsigned char more.


 fs/fat/dir.c             |   20 +++++++++----------
 fs/fat/inode.c           |    6 ++---
 fs/fat/misc.c            |    5 ++--
 fs/msdos/namei.c         |   46 ++++++++++++++++++++++-----------------------
 fs/vfat/namei.c          |   48 ++++++++++++++++++++++++++---------------------
 include/linux/msdos_fs.h |   15 +++++++-------
 6 files changed, 74 insertions(+), 66 deletions(-)

diff -puN fs/fat/dir.c~fat_char-to-unsigned_char fs/fat/dir.c
--- linux-2.6.0-test1/fs/fat/dir.c~fat_char-to-unsigned_char	2003-07-21 02:48:32.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/dir.c	2003-07-21 02:48:32.000000000 +0900
@@ -152,7 +152,7 @@ fat_strnicmp(struct nls_table *t, const 
 }
 
 static inline int
-fat_shortname2uni(struct nls_table *nls, char *buf, int buf_size,
+fat_shortname2uni(struct nls_table *nls, unsigned char *buf, int buf_size,
 		  wchar_t *uni_buf, unsigned short opt, int lower)
 {
 	int len = 0;
@@ -176,8 +176,8 @@ fat_shortname2uni(struct nls_table *nls,
  * Return values: negative -> error, 0 -> not found, positive -> found,
  * value is the total amount of slots, including the shortname entry.
  */
-int fat_search_long(struct inode *inode, const char *name, int name_len,
-			int anycase, loff_t *spos, loff_t *lpos)
+int fat_search_long(struct inode *inode, const unsigned char *name,
+		    int name_len, int anycase, loff_t *spos, loff_t *lpos)
 {
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh = NULL;
@@ -187,7 +187,7 @@ int fat_search_long(struct inode *inode,
 	wchar_t bufuname[14];
 	unsigned char xlate_len, long_slots;
 	wchar_t *unicode = NULL;
-	char work[8], bufname[260];	/* 256 + 4 */
+	unsigned char work[8], bufname[260];	/* 256 + 4 */
 	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
 	int utf8 = MSDOS_SB(sb)->options.utf8;
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
@@ -199,7 +199,7 @@ int fat_search_long(struct inode *inode,
 			goto EODir;
 parse_record:
 		long_slots = 0;
-		if (de->name[0] == (__s8) DELETED_FLAG)
+		if (de->name[0] == DELETED_FLAG)
 			continue;
 		if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))
 			continue;
@@ -258,7 +258,7 @@ parse_long:
 				if (ds->alias_checksum != alias_checksum)
 					goto parse_long;
 			}
-			if (de->name[0] == (__s8) DELETED_FLAG)
+			if (de->name[0] == DELETED_FLAG)
 				continue;
 			if (de->attr ==  ATTR_EXT)
 				goto parse_long;
@@ -351,7 +351,7 @@ static int fat_readdirx(struct inode *in
 	wchar_t bufuname[14];
 	unsigned char long_slots;
 	wchar_t *unicode = NULL;
-	char c, work[8], bufname[56], *ptname = bufname;
+	unsigned char c, work[8], bufname[56], *ptname = bufname;
 	unsigned long lpos, dummy, *furrfu = &lpos;
 	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
 	int isvfat = MSDOS_SB(sb)->options.isvfat;
@@ -392,7 +392,7 @@ GetNew:
 		goto EODir;
 	/* Check for long filename entry */
 	if (isvfat) {
-		if (de->name[0] == (__s8) DELETED_FLAG)
+		if (de->name[0] == DELETED_FLAG)
 			goto RecEnd;
 		if (de->attr != ATTR_EXT && (de->attr & ATTR_VOLUME))
 			goto RecEnd;
@@ -458,7 +458,7 @@ ParseLong:
 			if (ds->alias_checksum != alias_checksum)
 				goto ParseLong;
 		}
-		if (de->name[0] == (__s8) DELETED_FLAG)
+		if (de->name[0] == DELETED_FLAG)
 			goto RecEnd;
 		if (de->attr ==  ATTR_EXT)
 			goto ParseLong;
@@ -555,7 +555,7 @@ ParseLong:
 			    (de->attr & ATTR_DIR) ? DT_DIR : DT_REG) < 0)
 			goto FillFailed;
 	} else {
-		char longname[275];
+		unsigned char longname[275];
 		int long_len = utf8
 			? utf8_wcstombs(longname, unicode, sizeof(longname))
 			: uni16_to_x8(longname, unicode, uni_xlate,
diff -puN fs/fat/inode.c~fat_char-to-unsigned_char fs/fat/inode.c
--- linux-2.6.0-test1/fs/fat/inode.c~fat_char-to-unsigned_char	2003-07-21 02:48:32.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/inode.c	2003-07-21 02:48:32.000000000 +0900
@@ -734,7 +734,7 @@ int fat_fill_super(struct super_block *s
 	struct msdos_sb_info *sbi;
 	int logical_sector_size, fat_clusters, debug, cp, first;
 	unsigned int total_sectors, rootdir_sectors;
-	unsigned char media;
+	unsigned int media;
 	long error;
 	char buf[50];
 
@@ -1037,9 +1037,9 @@ int fat_statfs(struct super_block *sb, s
 	return 0;
 }
 
-static int is_exec(char *extension)
+static int is_exec(unsigned char *extension)
 {
-	char *exe_extensions = "EXECOMBAT", *walk;
+	unsigned char *exe_extensions = "EXECOMBAT", *walk;
 
 	for (walk = exe_extensions; *walk; walk += 3)
 		if (!strncmp(extension, walk, 3))
diff -puN fs/fat/misc.c~fat_char-to-unsigned_char fs/fat/misc.c
--- linux-2.6.0-test1/fs/fat/misc.c~fat_char-to-unsigned_char	2003-07-21 02:48:32.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/fat/misc.c	2003-07-21 02:48:32.000000000 +0900
@@ -346,8 +346,9 @@ int fat_subdirs(struct inode *dir)
  * Scans a directory for a given file (name points to its formatted name).
  * Returns an error code or zero.
  */
-int fat_scan(struct inode *dir, const char *name, struct buffer_head **bh,
-	     struct msdos_dir_entry **de, loff_t *i_pos)
+int fat_scan(struct inode *dir, const unsigned char *name,
+	     struct buffer_head **bh, struct msdos_dir_entry **de,
+	     loff_t *i_pos)
 {
 	loff_t cpos;
 
diff -puN fs/msdos/namei.c~fat_char-to-unsigned_char fs/msdos/namei.c
--- linux-2.6.0-test1/fs/msdos/namei.c~fat_char-to-unsigned_char	2003-07-21 02:48:32.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/msdos/namei.c	2003-07-21 02:48:32.000000000 +0900
@@ -14,30 +14,30 @@
 
 
 /* MS-DOS "device special files" */
-static const char *reserved_names[] = {
-    "CON     ","PRN     ","NUL     ","AUX     ",
-    "LPT1    ","LPT2    ","LPT3    ","LPT4    ",
-    "COM1    ","COM2    ","COM3    ","COM4    ",
-    NULL
+static const unsigned char *reserved_names[] = {
+	"CON     ","PRN     ","NUL     ","AUX     ",
+	"LPT1    ","LPT2    ","LPT3    ","LPT4    ",
+	"COM1    ","COM2    ","COM3    ","COM4    ",
+	NULL
 };
 
 /* Characters that are undesirable in an MS-DOS file name */
-static char bad_chars[] = "*?<>|\"";
-static char bad_if_strict_pc[] = "+=,; ";
-static char bad_if_strict_atari[] = " "; /* GEMDOS is less restrictive */
+static unsigned char bad_chars[] = "*?<>|\"";
+static unsigned char bad_if_strict_pc[] = "+=,; ";
+static unsigned char bad_if_strict_atari[] = " "; /* GEMDOS is less restrictive */
 #define	bad_if_strict(opts) ((opts)->atari ? bad_if_strict_atari : bad_if_strict_pc)
 
 /***** Formats an MS-DOS file name. Rejects invalid names. */
-static int msdos_format_name(const char *name,int len,
-	char *res,struct fat_mount_options *opts)
+static int msdos_format_name(const unsigned char *name, int len,
+	unsigned char *res, struct fat_mount_options *opts)
 	/* name is the proposed name, len is its length, res is
 	 * the resulting name, opts->name_check is either (r)elaxed,
 	 * (n)ormal or (s)trict, opts->dotsOK allows dots at the
 	 * beginning of name (for hidden files)
 	 */
 {
-	char *walk;
-	const char **reserved;
+	unsigned char *walk;
+	const unsigned char **reserved;
 	unsigned char c;
 	int space;
 
@@ -112,13 +112,13 @@ static int msdos_format_name(const char 
 }
 
 /***** Locates a directory entry.  Uses unformatted name. */
-static int msdos_find(struct inode *dir, const char *name, int len,
+static int msdos_find(struct inode *dir, const unsigned char *name, int len,
 		      struct buffer_head **bh, struct msdos_dir_entry **de,
 		      loff_t *i_pos)
 {
-	int res;
+	unsigned char msdos_name[MSDOS_NAME];
 	char dotsOK;
-	char msdos_name[MSDOS_NAME];
+	int res;
 
 	dotsOK = MSDOS_SB(dir->i_sb)->options.dotsOK;
 	res = msdos_format_name(name,len, msdos_name,&MSDOS_SB(dir->i_sb)->options);
@@ -146,8 +146,8 @@ static int msdos_find(struct inode *dir,
 static int msdos_hash(struct dentry *dentry, struct qstr *qstr)
 {
 	struct fat_mount_options *options = & (MSDOS_SB(dentry->d_sb)->options);
+	unsigned char msdos_name[MSDOS_NAME];
 	int error;
-	char msdos_name[MSDOS_NAME];
 	
 	error = msdos_format_name(qstr->name, qstr->len, msdos_name, options);
 	if (!error)
@@ -162,8 +162,8 @@ static int msdos_hash(struct dentry *den
 static int msdos_cmp(struct dentry *dentry, struct qstr *a, struct qstr *b)
 {
 	struct fat_mount_options *options = & (MSDOS_SB(dentry->d_sb)->options);
+	unsigned char a_msdos_name[MSDOS_NAME], b_msdos_name[MSDOS_NAME];
 	int error;
-	char a_msdos_name[MSDOS_NAME], b_msdos_name[MSDOS_NAME];
 
 	error = msdos_format_name(a->name, a->len, a_msdos_name, options);
 	if (error)
@@ -228,7 +228,7 @@ out:
 }
 
 /***** Creates a directory entry (name is already formatted). */
-static int msdos_add_entry(struct inode *dir, const char *name,
+static int msdos_add_entry(struct inode *dir, const unsigned char *name,
 			   struct buffer_head **bh,
 			   struct msdos_dir_entry **de,
 			   loff_t *i_pos, int is_dir, int is_hid)
@@ -270,7 +270,7 @@ int msdos_create(struct inode *dir,struc
 	struct inode *inode;
 	loff_t i_pos;
 	int res, is_hid;
-	char msdos_name[MSDOS_NAME];
+	unsigned char msdos_name[MSDOS_NAME];
 
 	lock_kernel();
 	res = msdos_format_name(dentry->d_name.name,dentry->d_name.len,
@@ -352,7 +352,7 @@ int msdos_mkdir(struct inode *dir,struct
 	struct msdos_dir_entry *de;
 	struct inode *inode;
 	int res,is_hid;
-	char msdos_name[MSDOS_NAME];
+	unsigned char msdos_name[MSDOS_NAME];
 	loff_t i_pos;
 
 	lock_kernel();
@@ -442,9 +442,9 @@ unlink_done:
 	return res;
 }
 
-static int do_msdos_rename(struct inode *old_dir, char *old_name,
+static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
     struct dentry *old_dentry,
-    struct inode *new_dir,char *new_name, struct dentry *new_dentry,
+    struct inode *new_dir, unsigned char *new_name, struct dentry *new_dentry,
     struct buffer_head *old_bh,
     struct msdos_dir_entry *old_de, loff_t old_i_pos, int is_hid)
 {
@@ -550,7 +550,7 @@ int msdos_rename(struct inode *old_dir,s
 	struct msdos_dir_entry *old_de;
 	loff_t old_i_pos;
 	int error, is_hid, old_hid; /* if new file and old file are hidden */
-	char old_msdos_name[MSDOS_NAME], new_msdos_name[MSDOS_NAME];
+	unsigned char old_msdos_name[MSDOS_NAME], new_msdos_name[MSDOS_NAME];
 
 	lock_kernel();
 	error = msdos_format_name(old_dentry->d_name.name,
diff -puN fs/vfat/namei.c~fat_char-to-unsigned_char fs/vfat/namei.c
--- linux-2.6.0-test1/fs/vfat/namei.c~fat_char-to-unsigned_char	2003-07-21 02:48:32.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/fs/vfat/namei.c	2003-07-21 02:48:32.000000000 +0900
@@ -122,7 +122,7 @@ vfat_strnicmp(struct nls_table *t, const
  */
 static int vfat_hash(struct dentry *dentry, struct qstr *qstr)
 {
-	const char *name;
+	const unsigned char *name;
 	int len;
 
 	len = qstr->len;
@@ -144,7 +144,7 @@ static int vfat_hash(struct dentry *dent
 static int vfat_hashi(struct dentry *dentry, struct qstr *qstr)
 {
 	struct nls_table *t = MSDOS_SB(dentry->d_inode->i_sb)->nls_io;
-	const char *name;
+	const unsigned char *name;
 	int len;
 	unsigned long hash;
 
@@ -206,11 +206,11 @@ static int vfat_cmp(struct dentry *dentr
 
 /* MS-DOS "device special files" */
 
-static const char *reserved3_names[] = {
+static const unsigned char *reserved3_names[] = {
 	"con     ", "prn     ", "nul     ", "aux     ", NULL
 };
 
-static const char *reserved4_names[] = {
+static const unsigned char *reserved4_names[] = {
 	"com1    ", "com2    ", "com3    ", "com4    ", "com5    ",
 	"com6    ", "com7    ", "com8    ", "com9    ",
 	"lpt1    ", "lpt2    ", "lpt3    ", "lpt4    ", "lpt5    ",
@@ -263,16 +263,20 @@ static inline int vfat_is_used_badchars(
 /* Returns negative number on error, 0 for a normal
  * return, and 1 for . or .. */
 
-static int vfat_valid_longname(const char *name, int len, int xlate)
+static int vfat_valid_longname(const unsigned char *name, int len, int xlate)
 {
-	const char **reserved, *walk;
+	const unsigned char **reserved, *walk;
 	int baselen;
 
-	if (len && name[len-1] == ' ') return -EINVAL;
-	if (len >= 256) return -EINVAL;
- 	if (len < 3) return 0;
+	if (len && name[len-1] == ' ')
+		return -EINVAL;
+	if (len >= 256)
+		return -EINVAL;
+	if (len < 3)
+		return 0;
 
-	for (walk = name; *walk != 0 && *walk != '.'; walk++);
+	for (walk = name; *walk != 0 && *walk != '.'; walk++)
+		;
 	baselen = walk - name;
 
 	if (baselen == 3) {
@@ -289,7 +293,7 @@ static int vfat_valid_longname(const cha
 	return 0;
 }
 
-static int vfat_find_form(struct inode *dir,char *name)
+static int vfat_find_form(struct inode *dir, unsigned char *name)
 {
 	struct msdos_dir_entry *de;
 	struct buffer_head *bh = NULL;
@@ -402,7 +406,7 @@ static inline int to_shortname_char(stru
  */
 static int vfat_create_shortname(struct inode *dir, struct nls_table *nls,
 				 wchar_t *uname, int ulen,
-				 char *name_res, unsigned char *lcase)
+				 unsigned char *name_res, unsigned char *lcase)
 {
 	wchar_t *ip, *ext_start, *end, *name_start;
 	unsigned char base[9], ext[4], buf[8], *p;
@@ -582,21 +586,22 @@ static int vfat_create_shortname(struct 
 
 /* Translate a string, including coded sequences into Unicode */
 static int
-xlate_to_uni(const char *name, int len, char *outname, int *longlen, int *outlen,
-	     int escape, int utf8, struct nls_table *nls)
+xlate_to_uni(const unsigned char *name, int len, unsigned char *outname,
+	     int *longlen, int *outlen, int escape, int utf8,
+	     struct nls_table *nls)
 {
 	const unsigned char *ip;
 	unsigned char nc;
-	char *op;
+	unsigned char *op;
 	unsigned int ec;
 	int i, k, fill;
 	int charlen;
 
 	if (utf8) {
-		*outlen = utf8_mbstowcs((__u16 *) outname, name, PAGE_SIZE);
+		*outlen = utf8_mbstowcs((wchar_t *)outname, name, PAGE_SIZE);
 		if (name[len-1] == '.')
 			*outlen-=2;
-		op = &outname[*outlen * sizeof(__u16)];
+		op = &outname[*outlen * sizeof(wchar_t)];
 	} else {
 		if (name[len-1] == '.') 
 			len--;
@@ -667,8 +672,9 @@ xlate_to_uni(const char *name, int len, 
 	return 0;
 }
 
-static int vfat_build_slots(struct inode *dir, const char *name, int len,
-			    struct msdos_dir_slot *ds, int *slots, int is_dir)
+static int vfat_build_slots(struct inode *dir, const unsigned char *name,
+			    int len, struct msdos_dir_slot *ds,
+			    int *slots, int is_dir)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
 	struct fat_mount_options *opts = &sbi->options;
@@ -676,7 +682,7 @@ static int vfat_build_slots(struct inode
 	struct msdos_dir_entry *de;
 	unsigned long page;
 	unsigned char cksum, lcase;
-	char msdos_name[MSDOS_NAME];
+	unsigned char msdos_name[MSDOS_NAME];
 	wchar_t *uname;
 	int res, slot, ulen, usize, i;
 	loff_t offset;
@@ -690,7 +696,7 @@ static int vfat_build_slots(struct inode
 		return -ENOMEM;
 
 	uname = (wchar_t *)page;
-	res = xlate_to_uni(name, len, (char *)uname, &ulen, &usize,
+	res = xlate_to_uni(name, len, (unsigned char *)uname, &ulen, &usize,
 			   opts->unicode_xlate, opts->utf8, sbi->nls_io);
 	if (res < 0)
 		goto out_free;
diff -puN include/linux/msdos_fs.h~fat_char-to-unsigned_char include/linux/msdos_fs.h
--- linux-2.6.0-test1/include/linux/msdos_fs.h~fat_char-to-unsigned_char	2003-07-21 02:48:32.000000000 +0900
+++ linux-2.6.0-test1-hirofumi/include/linux/msdos_fs.h	2003-07-21 02:48:32.000000000 +0900
@@ -44,7 +44,7 @@ struct statfs;
 #define CASE_LOWER_EXT  16	/* extension is lower case */
 
 #define DELETED_FLAG 0xe5 /* marks file as deleted when in name[0] */
-#define IS_FREE(n) (!*(n) || *(const unsigned char *) (n) == DELETED_FLAG)
+#define IS_FREE(n) (!*(n) || *(n) == DELETED_FLAG)
 
 #define MSDOS_VALID_MODE (S_IFREG | S_IFDIR | S_IRWXU | S_IRWXG | S_IRWXO)
 	/* valid file mode bits */
@@ -113,8 +113,8 @@ struct statfs;
 #define CT_LE_L(v) cpu_to_le32(v)
 
 struct fat_boot_sector {
-	__s8	ignored[3];	/* Boot strap short or near jump */
-	__s8	system_id[8];	/* Name - can be used to special case
+	__u8	ignored[3];	/* Boot strap short or near jump */
+	__u8	system_id[8];	/* Name - can be used to special case
 				   partition manager volumes */
 	__u8	sector_size[2];	/* bytes per logical sector */
 	__u8	cluster_size;	/* sectors/cluster */
@@ -149,7 +149,7 @@ struct fat_boot_fsinfo {
 };
 
 struct msdos_dir_entry {
-	__s8	name[8],ext[3];	/* name and extension */
+	__u8	name[8],ext[3];	/* name and extension */
 	__u8	attr;		/* attribute bits */
 	__u8    lcase;		/* Case for base and extension */
 	__u8	ctime_ms;	/* Creation time, milliseconds */
@@ -243,8 +243,9 @@ extern int fat_free(struct inode *inode,
 
 /* fat/dir.c */
 extern struct file_operations fat_dir_operations;
-extern int fat_search_long(struct inode *inode, const char *name, int name_len,
-			   int anycase, loff_t *spos, loff_t *lpos);
+extern int fat_search_long(struct inode *inode, const unsigned char *name,
+			   int name_len, int anycase,
+			   loff_t *spos, loff_t *lpos);
 extern int fat_readdir(struct file *filp, void *dirent, filldir_t filldir);
 extern int fat_dir_ioctl(struct inode * inode, struct file * filp,
 			 unsigned int cmd, unsigned long arg);
@@ -304,7 +305,7 @@ static __inline__ int fat_get_entry(stru
 	return fat__get_entry(dir, pos, bh, de, i_pos);
 }
 extern int fat_subdirs(struct inode *dir);
-extern int fat_scan(struct inode *dir, const char *name,
+extern int fat_scan(struct inode *dir, const unsigned char *name,
 		    struct buffer_head **res_bh,
 		    struct msdos_dir_entry **res_de, loff_t *i_pos);
 

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

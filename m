Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317495AbSFIBzA>; Sat, 8 Jun 2002 21:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317502AbSFIBy7>; Sat, 8 Jun 2002 21:54:59 -0400
Received: from melchi.fuller.edu ([65.118.138.13]:26116 "EHLO
	melchi.fuller.edu") by vger.kernel.org with ESMTP
	id <S317495AbSFIByy>; Sat, 8 Jun 2002 21:54:54 -0400
Date: Sat, 8 Jun 2002 18:53:49 -0700 (PDT)
From: <christoph@lameter.com>
X-X-Sender: <christoph@melchi.fuller.edu>
To: <linux-kernel@vger.rutgers.edu>
cc: <adelton@fi.muni.cz>
Subject: vfat patch for shortcut display as symlinks for 2.4.18
Message-ID: <Pine.LNX.4.33.0206081849010.5464-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried the patch adding symlinks to the vfat fs. It was submitted
back at the end of last year but it does not seem to have made it into the
kernel sources. I was unable to find a discussion on this. Symlink support
in vfat is really useful when you are sharing a vfat volume on a dual
booted system. I tried patching a 2.5.X kernel but the page cache changes
mean that the patch needs reworking.

Do you have any updates to the patch Jan?

Here is the readme and the patch again:

------- readme -------------------------------------------------

Symlink support for VFAT filesystem for Linux 2.4

Jan Pazdziora, adelton@fi.muni.cz

October 31, 2001.

In Windows, there are so called shortcuts that provide ways of
referencing other files. We will use these to support symlinks on VFAT
partitions under Linux. This patch adds the support to fat/vfat
filesystem source.

Shortcuts are normal files with extension .lnk. That means that from
now on, no regular file on VFAT with symlinks support will be allowed
to have this extension.

The .lnk files not only point to other files but can also hold
information about ways of starting the referenced file, with which
program and parameters. Something like .pif was. The format is
rather complex, and is described by Jesse Hager at
http://www.wotsit.org/download.asp?f=shortcut.

There are three plus one fields of interest here:

1) Relative path -- if it is present we will use it to mean relative
   symlink, and when writing relative symlink, we will fill this
   field.
2) Network location, in a form \\hostname\path. We won't try to
   resolve it, except one special case, \\localhost\path, which will
   mean /path, absolute symlink.
3) Local location, in a form C:\path. We won't try to resolve this and
   we will never write this kind of link, because we don't know what
   the driver letters are.
4) Description field -- Cygwin seems to use it to store the absolute
   symlinks, we will write it to contain the symlink path (relative or
   absolute).

This patch makes symlink resolving the default. You can mount the
filesystem with an option -o nosymlinks, that will switch the symlink
support off and you will see the base .lnk files.

This patch was tested on Linux kernel 2.4.13 and on Windows ME.

Questions, requests for comment:

If we had the information about drive letter available, we would be
able to resolve the C:\Windows links correctly as well. Note that
inside one drive (shortcut from D: to some other location on D:), the
relative path seems to always be present, so it only starts to be
needed and interesting with links that go accross the Windows drive
boundary. Perhaps some /etc/windrives.conf file? Or a /proc support?
Suggestions welcome.

Cygwin doesn't seem to support the network and local symlinks under
Windows well. It is unhappy with the Network/local part. I believe
that it is a problem of Cygwin (do they do their own symlink
resolution?) and I might be able to get a patch to make Cygwin work
properly as well.

The patch adds minor tweaks into some common code, and also some
bigger functions for symlink creating and resolving. These could be
moved into separate file, from vfat/namei.c and fat/file.c. But due to
a way the fat/vfat/msdos filesystem sypport is structured, the support
(at least partial) will probably always need to be in the common fat
base.

Comments welcome.


diff -ru linux-2.4.13-orig/fs/fat/dir.c linux-2.4.13/fs/fat/dir.c
--- linux-2.4.13-orig/fs/fat/dir.c	Fri Oct 12 22:48:42 2001
+++ linux-2.4.13/fs/fat/dir.c	Mon Oct 29 22:05:43 2001
@@ -179,6 +179,13 @@
 	return len;
 }

+static int is_symlink(char *extension)
+{
+	if (strncmp(extension, "LNK", 3) == 0)
+		return 1;
+	return 0;
+}
+
 /*
  * Return values: negative -> error, 0 -> not found, positive -> found,
  * value is the total amount of slots, including the shortname entry.
@@ -197,6 +204,7 @@
 	char work[8], bufname[260];	/* 256 + 4 */
 	int uni_xlate = MSDOS_SB(sb)->options.unicode_xlate;
 	int utf8 = MSDOS_SB(sb)->options.utf8;
+	int showsymlinks = MSDOS_SB(sb)->options.symlinks;
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
 	int ino, chl, i, j, last_u, res = 0;
 	loff_t cpos = 0;
@@ -319,6 +327,9 @@
 		xlate_len = utf8
 			?utf8_wcstombs(bufname, bufuname, sizeof(bufname))
 			:uni16_to_x8(bufname, bufuname, uni_xlate, nls_io);
+		if (showsymlinks && (xlate_len == name_len + 4)
+					&& is_symlink(de->ext))
+				xlate_len -= 4;
 		if (xlate_len == name_len)
 			if ((!anycase && !memcmp(name, bufname, xlate_len)) ||
 			    (anycase && !fat_strnicmp(nls_io, name, bufname,
@@ -329,6 +340,9 @@
 			xlate_len = utf8
 				?utf8_wcstombs(bufname, unicode, sizeof(bufname))
 				:uni16_to_x8(bufname, unicode, uni_xlate, nls_io);
+			if (showsymlinks && (xlate_len == name_len + 4)
+						&& is_symlink(de->ext))
+				xlate_len -= 4;
 			if (xlate_len != name_len)
 				continue;
 			if ((!anycase && !memcmp(name, bufname, xlate_len)) ||
@@ -367,6 +381,7 @@
 	int isvfat = MSDOS_SB(sb)->options.isvfat;
 	int utf8 = MSDOS_SB(sb)->options.utf8;
 	int nocase = MSDOS_SB(sb)->options.nocase;
+	int showsymlinks = MSDOS_SB(sb)->options.symlinks;
 	unsigned short opt_shortname = MSDOS_SB(sb)->options.shortname;
 	int ino, inum, chi, chl, i, i2, j, last, last_u, dotoffset = 0;
 	loff_t cpos;
@@ -556,6 +571,8 @@
 	}

 	if (!long_slots||shortnames) {
+		if (showsymlinks && i > 4 && is_symlink(de->ext))
+			i -= 4;
 		if (both)
 			bufname[i] = '\0';
 		if (filldir(dirent, bufname, i, *furrfu, inum,
@@ -567,6 +584,8 @@
 			? utf8_wcstombs(longname, unicode, sizeof(longname))
 			: uni16_to_x8(longname, unicode, uni_xlate,
 				      nls_io);
+		if (showsymlinks && long_len > 4 && is_symlink(de->ext))
+			long_len -= 4;
 		if (both) {
 			memcpy(&longname[long_len+1], bufname, i);
 			long_len += i;
diff -ru linux-2.4.13-orig/fs/fat/file.c linux-2.4.13/fs/fat/file.c
--- linux-2.4.13-orig/fs/fat/file.c	Sun Aug 12 19:56:56 2001
+++ linux-2.4.13/fs/fat/file.c	Wed Oct 31 16:06:48 2001
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/pagemap.h>
 #include <linux/fat_cvf.h>
+#include <linux/slab.h>

 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -36,6 +37,15 @@
 	setattr:	fat_notify_change,
 };

+int fat_readlink(struct dentry *dentry, char *buffer, int buflen);
+int fat_follow_link(struct dentry *dentry, struct nameidata *nd);
+
+struct inode_operations fat_symlink_inode_operations = {
+	readlink:       fat_readlink,
+	follow_link:    fat_follow_link,
+	setattr:	fat_notify_change,
+};
+
 ssize_t fat_file_read(
 	struct file *filp,
 	char *buf,
@@ -134,3 +144,201 @@
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
 }
+
+#define FAT_SYMLINK_SHELL_ITEM_LIST	0x01
+#define FAT_SYMLINK_FILE_LOCATION	0x02
+#define FAT_SYMLINK_RELATIVE		0x08
+#define FAT_SYMLINK_LOCAL		0x01
+#define FAT_SYMLINK_NETWORK		0x02
+#define FAT_SYMLINK_ABSOLUTE		"\\\\localhost\\"
+
+int fat_getlink(struct dentry *dentry, char *buffer, int buflen,
+		char **outbuffer)
+{
+	struct page * page;
+	struct address_space *mapping = dentry->d_inode->i_mapping;
+	char * ptr;
+	int ret = -EIO;
+	int offset = 76;
+	unsigned char flags;
+	*outbuffer = buffer;
+
+	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage,
+		NULL);
+	if (IS_ERR(page))
+		goto sync_fail;
+	wait_on_page(page);
+	if (!Page_Uptodate(page))
+		goto async_fail;
+	ptr = kmap(page);
+
+	if (!(ptr && *ptr == 'L'))	/* FIXME: test cele signatury */
+		goto fail_and_free_page;
+
+	flags = *(ptr + 20);
+
+	if (flags & FAT_SYMLINK_RELATIVE) {
+		int i, len;
+		for (i = 0; i <= 2; i++) {
+			if (flags & (1 << i)) {
+				offset += CF_LE_W(*(__u16 *)(ptr + offset));
+				if (i == 0 || i == 2)
+					offset += 2;
+			}
+		}
+		len = CF_LE_W(*(__u16 *)(ptr + offset));
+		if (!buffer) {
+			*outbuffer = kmalloc(len + 1, GFP_KERNEL);
+			if (!(*outbuffer)) {
+				ret = -ENOMEM;
+				goto fail_and_free_page;
+			}
+			memcpy(*outbuffer, ptr + offset + 2, len);
+		} else {
+			if (len > buflen) {
+				len = buflen;
+			}
+			if (copy_to_user(buffer, ptr + offset + 2, len + 1)) {
+				ret = -EFAULT;
+				goto fail_and_free_page;
+			}
+		}
+		(*outbuffer)[len] = 0;
+		for (i = 0; i < len; i++) {
+			if ((*outbuffer)[i] == '\\')
+				(*outbuffer)[i] = '/';
+		}
+		ret = len;
+	} else if (flags & FAT_SYMLINK_FILE_LOCATION) {
+		unsigned char loc_flags;
+		char * first_part = NULL;
+		char * final_part = NULL;
+		int first_part_len, final_part_len;
+		int insert_slash = 0;
+		int total_len;
+
+		if (flags & FAT_SYMLINK_SHELL_ITEM_LIST) {
+			offset += CF_LE_W(*(__u16 *)(ptr + offset)) + 2;
+		}
+		loc_flags = *(ptr + offset + 8);
+
+		if (loc_flags & FAT_SYMLINK_NETWORK) {
+			int new_offset = offset
+				+ CF_LE_W(*(__u16 *)(ptr + offset + 20));
+			new_offset += CF_LE_W(*(__u16 *)(ptr + new_offset + 8));
+			first_part = ptr + new_offset;
+		} else if (loc_flags & FAT_SYMLINK_LOCAL) {
+			first_part = ptr + offset
+				+ CF_LE_W(*(__u16 *)(ptr + offset + 16));
+		}
+
+		if (!first_part)
+			goto fail_and_free_page;
+
+		first_part_len = strlen(first_part);
+		if (!strnicmp(first_part, FAT_SYMLINK_ABSOLUTE,
+			strlen(FAT_SYMLINK_ABSOLUTE))) {
+			first_part += strlen(FAT_SYMLINK_ABSOLUTE) - 1;
+			first_part_len += 1 - strlen(FAT_SYMLINK_ABSOLUTE);
+		}
+
+		final_part = ptr + offset
+				+ CF_LE_W(*(__u16 *)(ptr + offset + 24));
+		final_part_len = strlen(final_part);
+
+		if (final_part_len && (first_part[first_part_len - 1] != '\\'))
+			insert_slash = 1;
+
+		ret = total_len = first_part_len + insert_slash
+							+ final_part_len;
+		if (!buffer) {
+			int i;
+			*outbuffer = kmalloc(first_part_len + insert_slash
+				+ final_part_len + 1, GFP_KERNEL);
+			if (!(*outbuffer)) {
+				ret = -ENOMEM;
+				goto fail_and_free_page;
+			}
+
+			for (i = 0; i < first_part_len; i++) {
+				if (first_part[i] == '\\')
+					(*outbuffer)[i] = '/';
+				else
+					(*outbuffer)[i] = first_part[i];
+			}
+			if (insert_slash) {
+				(*outbuffer)[i] = '/';
+				i++;
+			}
+			for (i = 0; i < final_part_len; i++) {
+				if (final_part[i] == '\\')
+					(*outbuffer)[first_part_len
+						+ insert_slash + i] = '/';
+				else
+					(*outbuffer)[first_part_len
+					+ insert_slash + i] = final_part[i];
+			}
+			(*outbuffer)[first_part_len + insert_slash + i] = 0;
+		} else {
+			int i;
+			if (total_len > buflen)
+				total_len = buflen;
+			if (copy_to_user(buffer, first_part,
+				min(first_part_len, buflen))) {
+				ret = -EFAULT;
+				goto fail_and_free_page;
+			}
+			if (first_part_len + 1 < buflen) {
+				if (insert_slash
+					&& copy_to_user(buffer
+						+ first_part_len, "/", 1)) {
+					ret = -EFAULT;
+					goto fail_and_free_page;
+				}
+				if (copy_to_user(buffer + first_part_len
+					+ insert_slash, final_part,
+					min(final_part_len, buflen
+						- first_part_len
+						- insert_slash))) {
+					ret = -EFAULT;
+					goto fail_and_free_page;
+				}
+			}
+			for (i = 0; i < min(buflen, first_part_len
+				+ insert_slash + final_part_len); i++) {
+				if (buffer[i] == '\\')
+					buffer[i] = '/';
+			}
+			buffer[total_len] = '\000';
+		}
+	}
+
+fail_and_free_page:
+	kunmap(page);
+async_fail:
+        page_cache_release(page);
+sync_fail:
+        return ret;
+}
+
+int fat_readlink(struct dentry *dentry, char *buffer, int buflen)
+{
+	char * out;
+	if (dentry->d_inode->i_size > PAGE_SIZE)
+		return -ENAMETOOLONG;
+	return fat_getlink(dentry, buffer, buflen, &out);
+}
+
+int fat_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	int res;
+	char * buffer;
+	if (dentry->d_inode->i_size > PAGE_SIZE)
+		return -ENAMETOOLONG;
+	fat_getlink(dentry, NULL, 0, &buffer);
+	res = vfs_follow_link(nd, buffer);
+	if (buffer)
+		kfree(buffer);
+	return res;
+}
+
diff -ru linux-2.4.13-orig/fs/fat/inode.c linux-2.4.13/fs/fat/inode.c
--- linux-2.4.13-orig/fs/fat/inode.c	Fri Oct 12 22:48:42 2001
+++ linux-2.4.13/fs/fat/inode.c	Mon Oct 29 22:18:42 2001
@@ -223,6 +223,7 @@
 	opts->nocase = 0;
 	opts->shortname = 0;
 	opts->utf8 = 0;
+	opts->symlinks = 0;
 	opts->iocharset = NULL;
 	*debug = *fat = 0;

@@ -852,6 +853,13 @@
 	return 0;
 }

+static int is_symlink(char *extension)
+{
+	if (strncmp(extension, "LNK", 3) == 0)
+		return 1;
+	return 0;
+}
+
 static int fat_writepage(struct page *page)
 {
 	return block_write_full_page(page,fat_get_block);
@@ -940,6 +948,12 @@
 		inode->i_size = CF_LE_L(de->size);
 	        inode->i_op = &fat_file_inode_operations;
 	        inode->i_fop = &fat_file_operations;
+		if (MSDOS_SB(sb)->options.symlinks && is_symlink(de->ext)) {
+			inode->i_mode &= ~ S_IFREG;
+			inode->i_mode |= S_IFLNK;
+			inode->i_op = &fat_symlink_inode_operations;
+			inode->i_fop = NULL;
+		}
 		inode->i_mapping->a_ops = &fat_aops;
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 	}
diff -ru linux-2.4.13-orig/fs/vfat/namei.c linux-2.4.13/fs/vfat/namei.c
--- linux-2.4.13-orig/fs/vfat/namei.c	Fri Oct 12 22:48:42 2001
+++ linux-2.4.13/fs/vfat/namei.c	Thu Nov  1 09:14:43 2001
@@ -109,6 +109,7 @@
 	opts->numtail = 1;
 	opts->utf8 = 0;
 	opts->shortname = VFAT_SFN_DISPLAY_LOWER | VFAT_SFN_CREATE_WIN95;
+	opts->symlinks = 1;
 	/* for backward compatible */
 	if (opts->nocase) {
 		opts->nocase = 0;
@@ -155,6 +156,8 @@
 						| VFAT_SFN_CREATE_WIN95;
 			else
 				ret = 0;
+		} else if (!strcmp(this_char,"nosymlinks")) {
+			opts->symlinks = 0;
 		}
 		if (this_char != options)
 			*(this_char-1) = ',';
@@ -213,7 +216,9 @@
 	name = qstr->name;
 	while (len && name[len-1] == '.')
 		len--;
-
+	if (MSDOS_SB(dentry->d_inode->i_sb)->options.symlinks
+		&& len > 4 && strnicmp(name + len - 4, ".lnk", 4) == 0)
+		len -= 4;
 	qstr->hash = full_name_hash(name, len);

 	return 0;
@@ -236,6 +241,9 @@
 	name = qstr->name;
 	while (len && name[len-1] == '.')
 		len--;
+	if (MSDOS_SB(dentry->d_inode->i_sb)->options.symlinks
+		&& len > 4 && strnicmp(name + len - 4, ".lnk", 4) == 0)
+		len -= 4;

 	hash = init_name_hash();
 	while (len--)
@@ -1248,6 +1256,8 @@

 }

+static int vfat_symlink ( struct inode *dir, struct dentry *dentry,
+                 const char *symname);

 /* Public inode operations for the VFAT fs */
 struct inode_operations vfat_dir_inode_operations = {
@@ -1258,6 +1268,7 @@
 	rmdir:		vfat_rmdir,
 	rename:		vfat_rename,
 	setattr:	fat_notify_change,
+	symlink:	vfat_symlink,
 };

 struct super_block *vfat_read_super(struct super_block *sb,void *data,
@@ -1285,3 +1296,139 @@

 	return res;
 }
+
+/*
+ * Function vfat_symlink_fill takes a pointer to target of the
+ * new symlink and a pointer to buffer and creates correct content
+ * of the buffer, to be written as a file specifying the symlink.
+ * If however the buffer pointer is NULL, it doesn't write to it.
+ * In any case it returns the length of the new file, so this function
+ * should be called twice -- first with NULL as buffer and after
+ * allocating the exact memory, with the pointer to that buffer.
+ *
+ * The relative symlink is stored as relative symlink with the description
+ * the same as the symlink, the absolute symlink is stored as \\localhost\
+ * network symlink with description matching the symlink path.
+ */
+
+#define FAT_SYMLINK_FILE_START	"L\000\000\000\001\024\002\000\000\000\000\000\xc0\000\000\000\000\000\000\x46"
+#define FAT_SYMLINK_LOCALHOST	"\\\\localhost\\"
+
+static int vfat_symlink_fill(const char * symname, char * buffer)
+{
+	int res = 0;
+	int symnamelen = strlen(symname);
+
+	if (buffer) {
+		memcpy(buffer, FAT_SYMLINK_FILE_START, 20);
+		memset(buffer + 20, 0, 76 - 20);
+		*(__u32*)(buffer + 60) = CT_LE_L(1);
+	}
+
+	if (*symname == '/') {
+		res = 76 + symnamelen + 12 + 1 + 20 + 28 + 1 + symnamelen + 2;
+		if (buffer) {
+			int i;
+			*(__u32*)(buffer + 20) = CT_LE_L(6);
+			*(__u32*)(buffer + 76) = CT_LE_L(res - 76);
+			*(__u32*)(buffer + 80) = CT_LE_L(28);
+			*(__u32*)(buffer + 84) = CT_LE_L(2);
+			*(__u32*)(buffer + 96) = CT_LE_L(28);
+			*(__u32*)(buffer + 100) = CT_LE_L(28 + 20 + 13);
+			*(__u32*)(buffer + 104) = CT_LE_L(symnamelen + 12 + 1 + 20);
+			*(__u32*)(buffer + 112) = CT_LE_L(20);
+			memcpy(buffer + 124, FAT_SYMLINK_LOCALHOST, 13);
+			for (i = 1; i <= symnamelen; i++) {
+				if (*(symname + i) == '/')
+					*(buffer + 124 + 12 + i) = '\\';
+				else
+					*(buffer + 124 + 12 + i)
+							= *(symname + i);
+			}
+			*(__u32*)(buffer + 124 + 12 + symnamelen + 1)
+							= CT_LE_W(symnamelen);
+			memcpy(buffer + 124 + 12 + symnamelen + 1 + 2,
+				symname, symnamelen);
+		}
+	} else {
+		res = 76 + 2 + symnamelen + 2 + symnamelen + 1;
+		if (buffer) {
+			int i;
+			*(__u32*)(buffer + 20) = CT_LE_L(12);
+			*(__u16*)(buffer + 76) = CT_LE_W(symnamelen);
+			memcpy(buffer + 78, symname, symnamelen);
+
+			*(__u16*)(buffer + 78 + symnamelen)
+							= CT_LE_W(symnamelen);
+			for (i = 0; i < symnamelen; i++) {
+				if (*(symname + i) == '/')
+					*(buffer + 80 + symnamelen + i) = '\\';
+				else
+					*(buffer + 80 + symnamelen + i)
+							= *(symname + i);
+			}
+		}
+	}
+
+	return res;
+}
+
+/*
+ * Function vfat_symlink creates new symlink file on a vfat partition.
+ * First it adds the .lnk extension which on vfat will denote the symlink
+ * type. To do this, since we're making the name longer, we may need
+ * to allocate new d_name.name. Then we allocate buffer for the content
+ * of the symlink file, let vfat_symlink_fill to fill the buffer, create
+ * the file, release the buffer and are done.
+ */
+
+static int vfat_symlink ( struct inode *dir, struct dentry *dentry,
+                 const char *symname)
+{
+	char * buffer;
+        int ret, len;
+
+	int d_name_len = dentry->d_name.len;
+
+	if (d_name_len + 4 + 1 > sizeof(dentry->d_iname)) {
+		char * new_name = kmalloc(d_name_len + 4 + 1, GFP_KERNEL);
+		if (!new_name) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		memcpy(new_name, dentry->d_name.name, d_name_len);
+		if (dentry->d_name.name != dentry->d_iname)
+			kfree(dentry->d_name.name);
+		dentry->d_name.name = new_name;
+	}
+	memcpy((unsigned char *)dentry->d_name.name + d_name_len, ".lnk", 5);
+	dentry->d_name.len += 4;
+
+        ret = vfat_create(dir, dentry, S_IFLNK | 0777);
+        if (ret) {
+                printk(KERN_WARNING "vfat_symlink: create failed (%d)\n", ret);
+                goto out;
+        }
+
+	buffer = kmalloc(vfat_symlink_fill(symname, NULL), GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto out_unlink;
+	}
+
+	len = vfat_symlink_fill(symname, buffer);
+	ret = block_symlink(dentry->d_inode, buffer, len);
+	kfree(buffer);
+
+	if (ret < 0)
+		goto out_unlink;
+out:
+	return ret;
+
+out_unlink:
+	printk(KERN_WARNING "vfat_symlink: write failed, unlinking\n");
+	vfat_unlink (dir, dentry);
+	d_drop(dentry);
+	goto out;
+}
+
diff -ru linux-2.4.13-orig/include/linux/msdos_fs.h linux-2.4.13/include/linux/msdos_fs.h
--- linux-2.4.13-orig/include/linux/msdos_fs.h	Fri Oct 12 22:48:42 2001
+++ linux-2.4.13/include/linux/msdos_fs.h	Tue Oct 30 21:07:07 2001
@@ -56,7 +56,7 @@
 #define DELETED_FLAG 0xe5 /* marks file as deleted when in name[0] */
 #define IS_FREE(n) (!*(n) || *(const unsigned char *) (n) == DELETED_FLAG)

-#define MSDOS_VALID_MODE (S_IFREG | S_IFDIR | S_IRWXU | S_IRWXG | S_IRWXO)
+#define MSDOS_VALID_MODE (S_IFREG | S_IFDIR | S_IRWXU | S_IRWXG | S_IRWXO | S_IFLNK )
 	/* valid file mode bits */

 #define MSDOS_SB(s) (&((s)->u.msdos_sb))
@@ -271,6 +271,7 @@
 /* fat/file.c */
 extern struct file_operations fat_file_operations;
 extern struct inode_operations fat_file_inode_operations;
+extern struct inode_operations fat_symlink_inode_operations;
 extern ssize_t fat_file_read(struct file *filp, char *buf, size_t count,
 			     loff_t *ppos);
 extern int fat_get_block(struct inode *inode, long iblock,
@@ -278,6 +279,11 @@
 extern ssize_t fat_file_write(struct file *filp, const char *buf, size_t count,
 			      loff_t *ppos);
 extern void fat_truncate(struct inode *inode);
+/*
+extern int fat_readlink(struct dentry *dentry, char *buffer, int buflen);
+extern int fat_follow_link(struct dentry *, struct nameidata *);
+*/
+

 /* fat/inode.c */
 extern void fat_hash_init(void);
diff -ru linux-2.4.13-orig/include/linux/msdos_fs_sb.h linux-2.4.13/include/linux/msdos_fs_sb.h
--- linux-2.4.13-orig/include/linux/msdos_fs_sb.h	Fri Oct 12 22:48:42 2001
+++ linux-2.4.13/include/linux/msdos_fs_sb.h	Mon Oct 29 22:06:24 2001
@@ -26,7 +26,8 @@
 		 numtail:1,       /* Does first alias have a numeric '~1' type tail? */
 		 atari:1,         /* Use Atari GEMDOS variation of MS-DOS fs */
 		 fat32:1,	  /* Is this a FAT32 partition? */
-		 nocase:1;	  /* Does this need case conversion? 0=need case conversion*/
+		 nocase:1,	  /* Does this need case conversion? 0=need case conversion*/
+		 symlinks:1;	  /* Do we want to support symlinks? */
 };

 struct msdos_sb_info {



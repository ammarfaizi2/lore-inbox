Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSE2MPi>; Wed, 29 May 2002 08:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSE2MPh>; Wed, 29 May 2002 08:15:37 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:58721 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315198AbSE2MPO>; Wed, 29 May 2002 08:15:14 -0400
Subject: [BK/PATCH] NTFS 2.0.8 update and fixes
To: linux-kernel@vger.kernel.org (Linux Kernel)
Date: Wed, 29 May 2002 13:15:12 +0100 (BST)
Cc: linux-ntfs-dev@lists.sourceforge.net
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17D2MC-0006Ra-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just sent the below NTFS update to Linus for inclusion.

You can also pull it from the NTFS bitkeeper repository:

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

=======================================================

This will update the following files:

 fs/ntfs/attraops.c                 |   47 --
 Documentation/filesystems/ntfs.txt |  100 +++---
 fs/ntfs/ChangeLog                  |   54 ++-
 fs/ntfs/Makefile                   |    2 
 fs/ntfs/attrib.c                   |    1 
 fs/ntfs/dir.c                      |  583 ++++++++++++++++++++++++++++++++++++-
 fs/ntfs/dir.h                      |   47 ++
 fs/ntfs/inode.c                    |   26 -
 fs/ntfs/layout.h                   |    4 
 fs/ntfs/namei.c                    |  218 ++++++++++++-
 fs/ntfs/ntfs.h                     |    7 
 fs/ntfs/super.c                    |   90 +----
 fs/ntfs/unistr.c                   |    4 
 fs/ntfs/volume.h                   |   36 +-
 14 files changed, 971 insertions(+), 248 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/05/11 1.530.3.3)
   NTFS: Remove unused source file.

<aia21@cantab.net> (02/05/26 1.582.2.2)
   NTFS: The beginning of 2.0.8. - Major updates for handling of case sensitivity.
   - Remove unused source file fs/ntfs/attraops.c.
   - Remove show_inodes mount option(s), thus dropping support for
     displaying of short file names.
   - Remove deprecated mount option posix.
   - Restore show_sys_files mount option.
   - Add new mount option case_sensitive, to determine if the driver treats
     file names as case sensitive or not. If case sensitive, create file names
     in the POSIX namespace. Otherwise create file names in the WIN32
     namespace. By default, or when case_sensitive is set to FALSE, files
     remain accessible via their short file name, if it exists.
   - Add additional argument to ntfs_lookup_inode_by_name() in which we
     return information about the matching file name if the case is not
     matching or the match is a short file name. See comments above the
     function definition for details.

<aia21@cantab.net> (02/05/27 1.582.2.3)
   NTFS: Fix really dumb logic bug in boot sector recovery.

<aia21@cantab.net> (02/05/28 1.582.2.4)
   NTFS: Fix potential 1 byte overflow in fs/ntfs/unistr.c::ntfs_ucstonls().
   Also, minor updates/fixes to docs and comments.

<aia21@cantab.net> (02/05/29 1.582.2.5)
   NTFS: 2.0.8 release. Major updates for dcache aliasing issues wrt short/long file names.
   
   In order to handle the case insensitivity issues of NTFS with regards to the
   dcache and the dcache requiring only one dentry per directory, we deal with
   dentry aliases that only differ in case in ->ntfs_lookup() while maintining
   a case sensitive dcache. This means that we get the full benefit of dcache
   speed when the file/directory is looked up with the same case as returned by
   ->ntfs_readdir() but that a lookup for any other case (or for the short file
   name) will not find anything in dcache and will enter ->ntfs_lookup()
   instead, where we search the directory for a fully matching file name
   (including case) and if that is not found, we search for a file name that
   matches with different case and if that has non-POSIX semantics we return
   that. We actually do only one search (case sensitive) and keep tabs on
   whether we have found a case insensitive match in the process.
   
   To simplify matters for us, we do not treat the short vs long filenames as
   two hard links but instead if the lookup matches a short filename, we
   return the dentry for the corresponding long filename instead.
   
   In ->ntfs_lookup() we distinguish three cases:
   
   1) @dent perfectly matches (i.e. including case) a directory entry with a
      file name in the WIN32 or POSIX namespaces. In this case
      ntfs_lookup_inode_by_name() will return with name set to NULL and we
      just d_add() @dent.
   2) @dent matches (not including case) a directory entry with a file name in
      the WIN32 namespace. In this case ntfs_lookup_inode_by_name() will return
      with name set to point to a kmalloc()ed ntfs_name structure containing
      the properly cased little endian Unicode name. We convert the name to the
      current NLS code page, search if a dentry with this name already exists
      and if so return that instead of @dent. The VFS will then destroy the old
      @dent and use the one we returned. If a dentry is not found, we allocate
      a new one, d_add() it, and return it as above.
   3) @dent matches either perfectly or not (i.e. we don't care about case) a
      directory entry with a file name in the DOS namespace. In this case
      ntfs_lookup_inode_by_name() will return with name set to point to a
      kmalloc()ed ntfs_name structure containing the mft reference (cpu endian)
      of the inode. We use the mft reference to read the inode and to find the
      file name in the WIN32 namespace corresponding to the matched short file
      name. We then convert the name to the current NLS code page, and proceed
      searching for a dentry with this name, etc, as in case 2), above.


diff -Nru a/fs/ntfs/attraops.c b/fs/ntfs/attraops.c
--- a/fs/ntfs/attraops.c	Wed May 29 12:23:20 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,47 +0,0 @@
-#include "ntfs.h"
-
-/*
- * We need to define the attribute object structure. FIXME: Move these to
- * ntfs.h.
- */
-typedef struct {
-	ntfs_inode *a_ni;
-	ntfs_volume *a_vol;
-	atomic_t a_count;
-	s64 a_size;
-	struct rw_semaphore a_sem;
-	struct address_space a_mapping;
-	unsigned long a_flags;
-} attr_obj;
-
-/**
- * ntfs_attr_readpage - fill a page @page of an attribute object @aobj with data
- * @aobj:	attribute object to which the page @page belongs
- * @page:	page cache page to fill with data
- *
- */
-//static int ntfs_attr_readpage(attr_obj *aobj, struct page *page)
-static int ntfs_attr_readpage(struct file *aobj, struct page *page)
-{
-	return -EOPNOTSUPP;
-}
-
-/*
- * Address space operations for accessing attributes. Note that these functions
- * do not accept an inode as the first parameter but an attribute object. We
- * use this to implement a generic interface that is not bound to inodes in
- * order to support multiple named streams per file, multiple bitmaps per file
- * and directory, etc. Basically, this gives access to any attribute within an
- * mft record.
- *
- * We make use of a slab cache for attribute object allocations.
- */
-struct address_space_operations ntfs_attr_aops = {
-	writepage:	NULL,			/* Write dirty page to disk. */
-	readpage:	ntfs_attr_readpage,	/* Fill page with data. */
-	sync_page:	block_sync_page,	/* Currently, just unplugs the
-						   disk request queue. */
-	prepare_write:	NULL,			/* . */
-	commit_write:	NULL,			/* . */
-};
-
diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Wed May 29 12:23:21 2002
+++ b/Documentation/filesystems/ntfs.txt	Wed May 29 12:23:21 2002
@@ -73,52 +73,27 @@
 			Otherwise the default behaviour is to abort mount if
 			any unknown options are found.
 
-posix=<bool>		Deprecated option. Still supported but please use
-			show_inodes=posix in the future. See description for
-			show_inodes=opt.
-
-show_sys_files=<bool>	Deprecated option. Still supported but please use
-			show_inodes=system in the future. See description for
-			show_inodes=opt.
-
-show_inodes=opt		Allows choice of which types of inode names readdir()
-			returns, i.e. this affects what "ls" shows. Following
-			values can be used for "opt":
-			   system: show system files
-			   win32:  long file names (includes POSIX) [DEFAULT]
-			   long:   same as win32
-			   dos:    short file names only (excludes POSIX)
-			   short:  same as dos
-			   posix:  same as both win32 and dos
-			   all:    all file names
-			Note that the options are additive, i.e. specifying:
-			   show_inodes=system,show_inodes=win32,show_inodes=dos
-			is the same as specifying:
-			   show_inodes=all
-			Note that the "posix" and "all" options will show all
-			directory names, BUT the link count on each directory
-			inode entry is set to 1, due to Linux not supporting
-			directory hard links. This may well confuse some
-			user space applications, since the directory names will
-			have the same inode numbers. Thus it is NOT advisable
-			to use the "posix" and "all" options. We provide them
-			only for completeness sake.
-			Further, note that the "system" option will not show
-			"$MFT" due to bugs/mis-features in glibc. Even though
-			it does not show, you can specifically "ls" it:
-				ls -l \$MFT
-			And of course you can stat it, too.
-			Further, note that irrespective of what show_inodes
-			option(s) you use, all files are accessible when you
-			specify the correct name, even though they may not be
-			shown in a normal "ls", i.e. you can always access the
-			system files and both the short and long file names of
-			files and directories.
-			Finally, note that win32 and dos file names are not
-			case sensitive and can be accessed using any
-			combination of lower and upper case, while POSIX file
-			names are case sensitive and they can only be accessed
-			given the correct case.
+show_sys_files=<BOOL>	If show_sys_files is specified, show the system files
+			in directory listings. Otherwise the default behaviour
+			is to hide the system files.
+			Note that even when show_sys_files is specified, "$MFT"
+			will not be visible due to bugs/mis-features in glibc.
+			Further, note that irrespective of show_sys_files, all
+			files are accessible by name, i.e. you can always do
+			"ls -l \$UpCase" for example to specifically show the
+			system file containing the Unicode upcase table.
+
+case_sensitive=<BOOL>	If case_sensitive is specified, treat all file names as
+			case sensitive and create file names in the POSIX
+			namespace. Otherwise the default behaviour is to treat
+			file names as case insensitive and to create file names
+			in the WIN32/LONG name space. Note, the Linux NTFS
+			driver will never create short file names and will
+			remove them on rename/delete of the corresponding long
+			file name.
+			Note that by default / when case_sensitive is set to
+			FALSE, files remain accessible via their short file
+			name, if it exists.
 
 errors=opt		What to do when critical file system errors are found.
 			Following values can be used for "opt":
@@ -174,12 +149,22 @@
   (from 9:43 minutes on average down to 7:53). The time spent in user space
   was unchanged but the time spent in the kernel was decreased by a factor of
   2.5 (from 85 CPU seconds down to 33).
+- The driver does not support short file names in general. For backwards
+  compatibility, we implement access to files using their short file names if
+  they exist. The driver will not create short file names however, and a rename
+  will discard any existing short file name.
 
 
 Known bugs and (mis-)features
 =============================
 
-- None
+- The link count on each directory inode entry is set to 1, due to Linux not
+  supporting directory hard links. This may well confuse some user space
+  applications, since the directory names will have the same inode numbers.
+  This also speeds up ntfs_read_inode() immensely. And we haven't found any
+  problems with this approach so far. If you find a problem with this, please
+  let us know.
+
 
 Please send bug reports/comments/feedback/abuse to the Linux-NTFS development
 list at sourceforge: linux-ntfs-dev@lists.sourceforge.net
@@ -262,6 +247,18 @@
 
 Note that a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.8:
+	- Remove now obsolete show_inodes and posix mount option(s).
+	- Restore show_sys_files mount option.
+	- Add new mount option case_sensitive, to determine if the driver
+	  treats file names as case sensitive or not.
+	- Mostly drop support for short file names (for backwards compatibility
+	  we only support accessing files via their short file name if one
+	  exists).
+	- Fix dcache aliasing issues wrt short/long file names.
+	- Cleanups.
+2.0.7:
+	- Just cleanups.
 2.0.6:
 	- Major bugfix to make compatible with other kernel changes. This fixes
 	  the hangs/oopses on umount.
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Wed May 29 12:23:21 2002
+++ b/fs/ntfs/ChangeLog	Wed May 29 12:23:21 2002
@@ -21,8 +21,29 @@
 	  several copies of almost identicall functions and the functions are
 	  quite big. Modularising them a bit, e.g. a-la get_block(), will make
 	  them cleaner and make code reuse easier.
-	- Want to use dummy inodes for address space i/o. We need some VFS
-	  changes first, which are currently under discussion.
+	- Want to use dummy inodes for address space i/o.
+
+2.0.8 - Major updates for handling of case sensitivity and dcache aliasing.
+
+	- Remove unused source file fs/ntfs/attraops.c.
+	- Remove show_inodes mount option(s), thus dropping support for
+	  displaying of short file names.
+	- Remove deprecated mount option posix.
+	- Restore show_sys_files mount option.
+	- Add new mount option case_sensitive, to determine if the driver
+	  treats file names as case sensitive or not. If case sensitive, create
+	  file names in the POSIX namespace. Otherwise create file names in the
+	  LONG/WIN32 name space. By default, or when case_sensitive is set to
+	  FALSE, files remain accessible via their short file name, if it
+	  exists.
+	- Fix dcache aliasing issues wrt short/long file names via changes
+	  to fs/ntfs/dir.c::ntfs_lookup_inode_by_name() and
+	  fs/ntfs/namei.c::ntfs_lookup(). (The latter is still TODO:)
+	- Add additional argument to ntfs_lookup_inode_by_name() in which we
+	  return information about the matching file name if the case is not
+	  matching or the match is a short file name. See comments above the
+	  function definition for details.
+	- TODO: (AIA) Change ntfs_lookup()...
 
 2.0.7 - Minor cleanups and updates for changes in core kernel code.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Wed May 29 12:23:21 2002
+++ b/fs/ntfs/Makefile	Wed May 29 12:23:21 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.7\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.8\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Wed May 29 12:23:21 2002
+++ b/fs/ntfs/attrib.c	Wed May 29 12:23:21 2002
@@ -22,6 +22,7 @@
 
 #include <linux/buffer_head.h>
 #include "ntfs.h"
+#include "dir.h"
 
 /* Temporary helper functions -- might become macros */
 
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Wed May 29 12:23:21 2002
+++ b/fs/ntfs/dir.c	Wed May 29 12:23:21 2002
@@ -22,6 +22,7 @@
 
 #include <linux/smp_lock.h>
 #include "ntfs.h"
+#include "dir.h"
 
 /**
  * The little endian Unicode string $I30 as a global constant.
@@ -35,6 +36,564 @@
  * @dir_ni:	ntfs inode of the directory in which to search for the name
  * @uname:	Unicode name for which to search in the directory
  * @uname_len:	length of the name @uname in Unicode characters
+ * @res:	return the found file name if necessary (see below)
+ *
+ * Look for an inode with name @uname in the directory with inode @dir_ni.
+ * ntfs_lookup_inode_by_name() walks the contents of the directory looking for
+ * the Unicode name. If the name is found in the directory, the corresponding
+ * inode number (>= 0) is returned as a mft reference in cpu format, i.e. it
+ * is a 64-bit number containing the sequence number.
+ *
+ * On error, a negative value is returned corresponding to the error code. In
+ * particular if the inode is not found -ENOENT is returned. Note that you
+ * can't just check the return value for being negative, you have to check the
+ * inode number for being negative which you can extract using MREC(return
+ * value).
+ *
+ * Note, @uname_len does not include the (optional) terminating NULL character.
+ *
+ * Note, we look for a case sensitive match first but we also look for a case
+ * insensitive match at the same time. If we find a case insensitive match, we
+ * save that for the case that we don't find an exact match, where we return
+ * the case insensitive match and setup @res (which we allocate!) with the mft
+ * reference, the file name type, length and with a copy of the little endian
+ * Unicode file name itself. If we match a file name which is in the DOS name
+ * space, we only return the mft reference and file name type in @res.
+ * ntfs_lookup() then uses this to find the long file name in the inode itself.
+ * This is to avoid polluting the dcache with short file names. We want them to
+ * work but we don't care for how quickly one can access them. This also fixes
+ * the dcache aliasing issues.
+ */
+u64 ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const uchar_t *uname,
+		const int uname_len, ntfs_name **res)
+{
+	ntfs_volume *vol = dir_ni->vol;
+	struct super_block *sb = vol->sb;
+	MFT_RECORD *m;
+	INDEX_ROOT *ir;
+	INDEX_ENTRY *ie;
+	INDEX_ALLOCATION *ia;
+	u8 *index_end;
+	u64 mref;
+	attr_search_context *ctx;
+	int err = 0, rc;
+	VCN vcn, old_vcn;
+	struct address_space *ia_mapping;
+	struct page *page;
+	u8 *kaddr;
+	ntfs_name *name = NULL;
+
+	/* Get hold of the mft record for the directory. */
+	m = map_mft_record(READ, dir_ni);
+	if (IS_ERR(m))
+		goto map_err_out;
+
+	ctx = get_attr_search_ctx(dir_ni, m);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto unm_err_out;
+	}
+
+	/* Find the index root attribute in the mft record. */
+	if (!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
+			ctx)) {
+		ntfs_error(sb, "Index root attribute missing in directory "
+				"inode 0x%Lx.",
+				(unsigned long long)dir_ni->mft_no);
+		err = -EIO;
+		goto put_unm_err_out;
+	}
+	/* Get to the index root value (it's been verified in read_inode). */
+	ir = (INDEX_ROOT*)((u8*)ctx->attr +
+			le16_to_cpu(ctx->attr->_ARA(value_offset)));
+	index_end = (u8*)&ir->index + le32_to_cpu(ir->index.index_length);
+	/* The first index entry. */
+	ie = (INDEX_ENTRY*)((u8*)&ir->index +
+			le32_to_cpu(ir->index.entries_offset));
+	/*
+	 * Loop until we exceed valid memory (corruption case) or until we
+	 * reach the last entry.
+	 */
+	for (;; ie = (INDEX_ENTRY*)((u8*)ie + le16_to_cpu(ie->_IEH(length)))) {
+		/* Bounds checks. */
+		if ((u8*)ie < (u8*)ctx->mrec || (u8*)ie +
+				sizeof(INDEX_ENTRY_HEADER) > index_end ||
+				(u8*)ie + le16_to_cpu(ie->_IEH(key_length)) >
+				index_end)
+			goto dir_err_out;
+		/*
+		 * The last entry cannot contain a name. It can however contain
+		 * a pointer to a child node in the B+tree so we just break out.
+		 */
+		if (ie->_IEH(flags) & INDEX_ENTRY_END)
+			break;
+		/*
+		 * We perform a case sensitive comparison and if that matches
+		 * we are done and return the mft reference of the inode (i.e.
+		 * the inode number together with the sequence number for
+		 * consistency checking). We convert it to cpu format before
+		 * returning.
+		 */
+		if (ntfs_are_names_equal(uname, uname_len,
+				(uchar_t*)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length,
+				CASE_SENSITIVE, vol->upcase, vol->upcase_len)) {
+found_it:
+			/*
+			 * We have a perfect match, so we don't need to care
+			 * about having matched imperfectly before, so we can
+			 * free name and set *res to NULL.
+			 * However, if the perfect match is a short file name,
+			 * we need to signal this through *res, so that
+			 * ntfs_lookup() can fix dcache aliasing issues.
+			 * As an optimization we just reuse an existing
+			 * allocation of *res.
+			 */
+			if (ie->key.file_name.file_name_type == FILE_NAME_DOS) {
+				if (!name) {
+					name = kmalloc(sizeof(ntfs_name),
+							GFP_NOFS);
+					if (!name) {
+						err = -ENOMEM;
+						goto put_unm_err_out;
+					}
+				}
+				name->mref = le64_to_cpu(
+						ie->_IIF(indexed_file));
+				name->type = FILE_NAME_DOS;
+				name->len = 0;
+				*res = name;
+			} else {
+				if (name)
+					kfree(name);
+				*res = NULL;
+			}
+			mref = le64_to_cpu(ie->_IIF(indexed_file));
+			put_attr_search_ctx(ctx);
+			unmap_mft_record(READ, dir_ni);
+			return mref;
+		}
+		/*
+		 * For a case insensitive mount, we also perform a case
+		 * insensitive comparison (provided the file name is not in the
+		 * POSIX namespace). If the comparison matches, and the name is
+		 * in the WIN32 namespace, we cache the filename in *res so
+		 * that the caller, ntfs_lookup(), can work on it. If the
+		 * comparison matches, and the name is in the DOS namespace, we
+		 * only cache the mft reference and the file name type (we set
+		 * the name length to zero for simplicity).
+		 */
+		if (!NVolCaseSensitive(vol) &&
+				ie->key.file_name.file_name_type &&
+				ntfs_are_names_equal(uname, uname_len,
+				(uchar_t*)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length,
+				IGNORE_CASE, vol->upcase, vol->upcase_len)) {
+			int name_size = sizeof(ntfs_name);
+			u8 type = ie->key.file_name.file_name_type;
+			u8 len = ie->key.file_name.file_name_length;
+
+			/* Only one case insensitive matching name allowed. */
+			if (name) {
+				ntfs_error(sb, "Found already allocated name "
+						"in phase 1. Please run chkdsk "
+						"and if that doesn't find any "
+						"errors please report you saw "
+						"this message to "
+						"linux-ntfs@lists.sf.net.");
+				goto dir_err_out;
+			}
+
+			if (type != FILE_NAME_DOS)
+				name_size += len * sizeof(uchar_t);
+			name = kmalloc(name_size, GFP_NOFS);
+			if (!name) {
+				err = -ENOMEM;
+				goto put_unm_err_out;
+			}
+			name->mref = le64_to_cpu(ie->_IIF(indexed_file));
+			name->type = type;
+			if (type != FILE_NAME_DOS) {
+				name->len = len;
+				memcpy(name->name, ie->key.file_name.file_name,
+						len * sizeof(uchar_t));
+			} else
+				name->len = 0;
+			*res = name;
+		}
+		/*
+		 * Not a perfect match, need to do full blown collation so we
+		 * know which way in the B+tree we have to go.
+		 */
+		rc = ntfs_collate_names(uname, uname_len,
+				(uchar_t*)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length, 1,
+				IGNORE_CASE, vol->upcase, vol->upcase_len);
+		/*
+		 * If uname collates before the name of the current entry, there
+		 * is definitely no such name in this index but we might need to
+		 * descend into the B+tree so we just break out of the loop.
+		 */
+		if (rc == -1)
+			break;
+		/* The names are not equal, continue the search. */
+		if (rc)
+			continue;
+		/*
+		 * Names match with case insensitive comparison, now try the
+		 * case sensitive comparison, which is required for proper
+		 * collation.
+		 */
+		rc = ntfs_collate_names(uname, uname_len,
+				(uchar_t*)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length, 1,
+				CASE_SENSITIVE, vol->upcase, vol->upcase_len);
+		if (rc == -1)
+			break;
+		if (rc)
+			continue;
+		/*
+		 * Perfect match, this will never happen as the
+		 * ntfs_are_names_equal() call will have gotten a match but we
+		 * still treat it correctly.
+		 */
+		goto found_it;
+	}
+	/*
+	 * We have finished with this index without success. Check for the
+	 * presence of a child node and if not present return -ENOENT, unless
+	 * we have got a matching name cached in name in which case return the
+	 * mft reference associated with it.
+	 */
+	if (!(ie->_IEH(flags) & INDEX_ENTRY_NODE)) {
+		if (name) {
+			put_attr_search_ctx(ctx);
+			unmap_mft_record(READ, dir_ni);
+			return name->mref;
+		}
+		ntfs_debug("Entry not found.");
+		err = -ENOENT;
+		goto put_unm_err_out;
+	} /* Child node present, descend into it. */
+	/* Consistency check: Verify that an index allocation exists. */
+	if (!NInoIndexAllocPresent(dir_ni)) {
+		ntfs_error(sb, "No index allocation attribute but index entry "
+				"requires one. Directory inode 0x%Lx is "
+				"corrupt or driver bug.",
+				(unsigned long long)dir_ni->mft_no);
+		err = -EIO;
+		goto put_unm_err_out;
+	}
+	/* Get the starting vcn of the index_block holding the child node. */
+	vcn = sle64_to_cpup((u8*)ie + le16_to_cpu(ie->_IEH(length)) - 8);
+	ia_mapping = VFS_I(dir_ni)->i_mapping;
+descend_into_child_node:
+	/*
+	 * Convert vcn to index into the index allocation attribute in units
+	 * of PAGE_CACHE_SIZE and map the page cache page, reading it from
+	 * disk if necessary.
+	 */
+	page = ntfs_map_page(ia_mapping, vcn <<
+			dir_ni->_IDM(index_vcn_size_bits) >> PAGE_CACHE_SHIFT);
+	if (IS_ERR(page)) {
+		ntfs_error(sb, "Failed to map directory index page, error %ld.",
+				-PTR_ERR(page));
+		goto put_unm_err_out;
+	}
+	kaddr = (u8*)page_address(page);
+fast_descend_into_child_node:
+	/* Get to the index allocation block. */
+	ia = (INDEX_ALLOCATION*)(kaddr + ((vcn <<
+			dir_ni->_IDM(index_vcn_size_bits)) & ~PAGE_CACHE_MASK));
+	/* Bounds checks. */
+	if ((u8*)ia < kaddr || (u8*)ia > kaddr + PAGE_CACHE_SIZE) {
+		ntfs_error(sb, "Out of bounds check failed. Corrupt directory "
+				"inode 0x%Lx or driver bug.",
+				(unsigned long long)dir_ni->mft_no);
+		err = -EIO;
+		goto unm_unm_err_out;
+	}
+	if (sle64_to_cpu(ia->index_block_vcn) != vcn) {
+		ntfs_error(sb, "Actual VCN (0x%Lx) of index buffer is "
+				"different from expected VCN (0x%Lx). "
+				"Directory inode 0x%Lx is corrupt or driver "
+				"bug.",
+				(long long)sle64_to_cpu(ia->index_block_vcn),
+				(long long)vcn,
+				(unsigned long long)dir_ni->mft_no);
+		err = -EIO;
+		goto unm_unm_err_out;
+	}
+	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
+			dir_ni->_IDM(index_block_size)) {
+		ntfs_error(sb, "Index buffer (VCN 0x%Lx) of directory inode "
+				"0x%Lx has a size (%u) differing from the "
+				"directory specified size (%u). Directory "
+				"inode is corrupt or driver bug.",
+				(long long)vcn,
+				(unsigned long long)dir_ni->mft_no,
+				le32_to_cpu(ia->index.allocated_size) + 0x18,
+				dir_ni->_IDM(index_block_size));
+		err = -EIO;
+		goto unm_unm_err_out;
+	}
+	index_end = (u8*)ia + dir_ni->_IDM(index_block_size);
+	if (index_end > kaddr + PAGE_CACHE_SIZE) {
+		ntfs_error(sb, "Index buffer (VCN 0x%Lx) of directory inode "
+				"0x%Lx crosses page boundary. Impossible! "
+				"Cannot access! This is probably a bug in the "
+				"driver.", (long long)vcn,
+				(unsigned long long)dir_ni->mft_no);
+		err = -EIO;
+		goto unm_unm_err_out;
+	}
+	index_end = (u8*)&ia->index + le32_to_cpu(ia->index.index_length);
+	if (index_end > (u8*)ia + dir_ni->_IDM(index_block_size)) {
+		ntfs_error(sb, "Size of index buffer (VCN 0x%Lx) of directory "
+				"inode 0x%Lx exceeds maximum size.",
+				(long long)vcn,
+				(unsigned long long)dir_ni->mft_no);
+		err = -EIO;
+		goto unm_unm_err_out;
+	}
+	/* The first index entry. */
+	ie = (INDEX_ENTRY*)((u8*)&ia->index +
+			le32_to_cpu(ia->index.entries_offset));
+	/*
+	 * Iterate similar to above big loop but applied to index buffer, thus
+	 * loop until we exceed valid memory (corruption case) or until we
+	 * reach the last entry.
+	 */
+	for (;; ie = (INDEX_ENTRY*)((u8*)ie + le16_to_cpu(ie->_IEH(length)))) {
+		/* Bounds check. */
+		if ((u8*)ie < (u8*)ia || (u8*)ie +
+				sizeof(INDEX_ENTRY_HEADER) > index_end ||
+				(u8*)ie + le16_to_cpu(ie->_IEH(key_length)) >
+				index_end) {
+			ntfs_error(sb, "Index entry out of bounds in "
+					"directory inode 0x%Lx.",
+					(unsigned long long)dir_ni->mft_no);
+			err = -EIO;
+			goto unm_unm_err_out;
+		}
+		/*
+		 * The last entry cannot contain a name. It can however contain
+		 * a pointer to a child node in the B+tree so we just break out.
+		 */
+		if (ie->_IEH(flags) & INDEX_ENTRY_END)
+			break;
+		/*
+		 * We perform a case sensitive comparison and if that matches
+		 * we are done and return the mft reference of the inode (i.e.
+		 * the inode number together with the sequence number for
+		 * consistency checking). We convert it to cpu format before
+		 * returning.
+		 */
+		if (ntfs_are_names_equal(uname, uname_len,
+				(uchar_t*)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length,
+				CASE_SENSITIVE, vol->upcase, vol->upcase_len)) {
+found_it2:
+			/*
+			 * We have a perfect match, so we don't need to care
+			 * about having matched imperfectly before, so we can
+			 * free name and set *res to NULL.
+			 * However, if the perfect match is a short file name,
+			 * we need to signal this through *res, so that
+			 * ntfs_lookup() can fix dcache aliasing issues.
+			 * As an optimization we just reuse an existing
+			 * allocation of *res.
+			 */
+			if (ie->key.file_name.file_name_type == FILE_NAME_DOS) {
+				if (!name) {
+					name = kmalloc(sizeof(ntfs_name),
+							GFP_NOFS);
+					if (!name) {
+						err = -ENOMEM;
+						goto unm_unm_err_out;
+					}
+				}
+				name->mref = le64_to_cpu(
+						ie->_IIF(indexed_file));
+				name->type = FILE_NAME_DOS;
+				name->len = 0;
+				*res = name;
+			} else {
+				if (name)
+					kfree(name);
+				*res = NULL;
+			}
+			mref = le64_to_cpu(ie->_IIF(indexed_file));
+			ntfs_unmap_page(page);
+			put_attr_search_ctx(ctx);
+			unmap_mft_record(READ, dir_ni);
+			return mref;
+		}
+		/*
+		 * For a case insensitive mount, we also perform a case
+		 * insensitive comparison (provided the file name is not in the
+		 * POSIX namespace). If the comparison matches, and the name is
+		 * in the WIN32 namespace, we cache the filename in *res so
+		 * that the caller, ntfs_lookup(), can work on it. If the
+		 * comparison matches, and the name is in the DOS namespace, we
+		 * only cache the mft reference and the file name type (we set
+		 * the name length to zero for simplicity).
+		 */
+		if (!NVolCaseSensitive(vol) &&
+				ie->key.file_name.file_name_type &&
+				ntfs_are_names_equal(uname, uname_len,
+				(uchar_t*)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length,
+				IGNORE_CASE, vol->upcase, vol->upcase_len)) {
+			int name_size = sizeof(ntfs_name);
+			u8 type = ie->key.file_name.file_name_type;
+			u8 len = ie->key.file_name.file_name_length;
+
+			/* Only one case insensitive matching name allowed. */
+			if (name) {
+				ntfs_error(sb, "Found already allocated name "
+						"in phase 2. Please run chkdsk "
+						"and if that doesn't find any "
+						"errors please report you saw "
+						"this message to "
+						"linux-ntfs@lists.sf.net.");
+				ntfs_unmap_page(page);
+				goto dir_err_out;
+			}
+
+			if (type != FILE_NAME_DOS)
+				name_size += len * sizeof(uchar_t);
+			name = kmalloc(name_size, GFP_NOFS);
+			if (!name) {
+				err = -ENOMEM;
+				goto put_unm_err_out;
+			}
+			name->mref = le64_to_cpu(ie->_IIF(indexed_file));
+			name->type = type;
+			if (type != FILE_NAME_DOS) {
+				name->len = len;
+				memcpy(name->name, ie->key.file_name.file_name,
+						len * sizeof(uchar_t));
+			} else
+				name->len = 0;
+			*res = name;
+		}
+		/*
+		 * Not a perfect match, need to do full blown collation so we
+		 * know which way in the B+tree we have to go.
+		 */
+		rc = ntfs_collate_names(uname, uname_len,
+				(uchar_t*)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length, 1,
+				IGNORE_CASE, vol->upcase, vol->upcase_len);
+		/*
+		 * If uname collates before the name of the current entry, there
+		 * is definitely no such name in this index but we might need to
+		 * descend into the B+tree so we just break out of the loop.
+		 */
+		if (rc == -1)
+			break;
+		/* The names are not equal, continue the search. */
+		if (rc)
+			continue;
+		/*
+		 * Names match with case insensitive comparison, now try the
+		 * case sensitive comparison, which is required for proper
+		 * collation.
+		 */
+		rc = ntfs_collate_names(uname, uname_len,
+				(uchar_t*)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length, 1,
+				CASE_SENSITIVE, vol->upcase, vol->upcase_len);
+		if (rc == -1)
+			break;
+		if (rc)
+			continue;
+		/*
+		 * Perfect match, this will never happen as the
+		 * ntfs_are_names_equal() call will have gotten a match but we
+		 * still treat it correctly.
+		 */
+		goto found_it2;
+	}
+	/*
+	 * We have finished with this index buffer without success. Check for
+	 * the presence of a child node.
+	 */
+	if (ie->_IEH(flags) & INDEX_ENTRY_NODE) {
+		if ((ia->index.flags & NODE_MASK) == LEAF_NODE) {
+			ntfs_error(sb, "Index entry with child node found in "
+					"a leaf node in directory inode 0x%Lx.",
+					(unsigned long long)dir_ni->mft_no);
+			err = -EIO;
+			goto unm_unm_err_out;
+		}
+		/* Child node present, descend into it. */
+		old_vcn = vcn;
+		vcn = sle64_to_cpup((u8*)ie +
+				le16_to_cpu(ie->_IEH(length)) - 8);
+		if (vcn >= 0) {
+			/* If vcn is in the same page cache page as old_vcn we
+			 * recycle the mapped page. */
+			if (old_vcn << vol->cluster_size_bits >>
+					PAGE_CACHE_SHIFT == vcn <<
+					vol->cluster_size_bits >>
+					PAGE_CACHE_SHIFT)
+				goto fast_descend_into_child_node;
+			ntfs_unmap_page(page);
+			goto descend_into_child_node;
+		}
+		ntfs_error(sb, "Negative child node vcn in directory inode "
+				"0x%Lx.", (unsigned long long)dir_ni->mft_no);
+		err = -EIO;
+		goto unm_unm_err_out;
+	}
+	/*
+	 * No child node present, return -ENOENT, unless we have got a matching
+	 * name cached in name in which case return the mft reference
+	 * associated with it.
+	 */
+	if (name) {
+		ntfs_unmap_page(page);
+		put_attr_search_ctx(ctx);
+		unmap_mft_record(READ, dir_ni);
+		return name->mref;
+	}
+	ntfs_debug("Entry not found.");
+	err = -ENOENT;
+unm_unm_err_out:
+	ntfs_unmap_page(page);
+put_unm_err_out:
+	put_attr_search_ctx(ctx);
+unm_err_out:
+	unmap_mft_record(READ, dir_ni);
+	if (name) {
+		kfree(name);
+		*res = NULL;
+	}
+	return ERR_MREF(err);
+map_err_out:
+	ntfs_error(sb, "map_mft_record(READ) failed with error code %ld.",
+			-PTR_ERR(m));
+	return ERR_MREF(PTR_ERR(m));
+dir_err_out:
+	ntfs_error(sb, "Corrupt directory. Aborting lookup.");
+	err = -EIO;
+	goto put_unm_err_out;
+}
+
+#if 0
+
+// TODO: (AIA)
+// The algorithm embedded in this code will be required for the time when we
+// want to support adding of entries to directories, where we require correct
+// collation of file names in order not to cause corruption of the file system.
+
+/**
+ * ntfs_lookup_inode_by_name - find an inode in a directory given its name
+ * @dir_ni:	ntfs inode of the directory in which to search for the name
+ * @uname:	Unicode name for which to search in the directory
+ * @uname_len:	length of the name @uname in Unicode characters
  *
  * Look for an inode with name @uname in the directory with inode @dir_ni.
  * ntfs_lookup_inode_by_name() walks the contents of the directory looking for
@@ -414,6 +973,8 @@
 	goto put_unm_err_out;
 }
 
+#endif
+
 typedef union {
 	INDEX_ROOT *ir;
 	INDEX_ALLOCATION *ia;
@@ -447,7 +1008,6 @@
 	int name_len;
 	unsigned dt_type;
 	FILE_NAME_TYPE_FLAGS name_type;
-	READDIR_OPTIONS readdir_opts;
 
 	/* Advance the position even if going to skip the entry. */
 	if (index_type == INDEX_TYPE_ALLOCATION)
@@ -457,25 +1017,17 @@
 				vol->mft_record_size;
 	else /* if (index_type == INDEX_TYPE_ROOT) */
 		filp->f_pos = (u8*)ie - (u8*)iu.ir;
-	readdir_opts = vol->readdir_opts;
 	name_type = ie->key.file_name.file_name_type;
-	if (name_type == FILE_NAME_DOS && RHideDosNames(readdir_opts)) {
+	if (name_type == FILE_NAME_DOS) {
 		ntfs_debug("Skipping DOS name space entry.");
 		return 0;
 	}
-	if (RHideLongNames(readdir_opts)) {
-		if (name_type == FILE_NAME_WIN32 ||
-				name_type == FILE_NAME_POSIX) {
-			ntfs_debug("Skipping WIN32/POSIX name space entry.");
-			return 0;
-		}
-	}
 	if (MREF_LE(ie->_IIF(indexed_file)) == FILE_root) {
 		ntfs_debug("Skipping root directory self reference entry.");
 		return 0;
 	}
 	if (MREF_LE(ie->_IIF(indexed_file)) < FILE_first_user &&
-			RHideSystemFiles(readdir_opts)) {
+			!NVolShowSystemFiles(vol)) {
 		ntfs_debug("Skipping system file.");
 		return 0;
 	}
@@ -496,7 +1048,8 @@
 			(unsigned long long)MREF_LE(ie->_IIF(indexed_file)),
 			dt_type == DT_DIR ? "DIR" : "REG");
 	return filldir(dirent, name, name_len, filp->f_pos,
-			(unsigned long)MREF_LE(ie->_IIF(indexed_file)), dt_type);
+			(unsigned long)MREF_LE(ie->_IIF(indexed_file)),
+			dt_type);
 }
 
 /*
@@ -510,7 +1063,7 @@
  * index root entries and then the index allocation entries that are marked
  * as in use in the index bitmap.
  * While this will return the names in random order this doesn't matter for
- * readdir but OTOH results in faster readdir.
+ * readdir but OTOH results in a faster readdir.
  */
 static int ntfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
diff -Nru a/fs/ntfs/dir.h b/fs/ntfs/dir.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/fs/ntfs/dir.h	Wed May 29 12:23:21 2002
@@ -0,0 +1,47 @@
+/*
+ * dir.h - Defines for directory handling in NTFS Linux kernel driver. Part of
+ *	   the Linux-NTFS project.
+ *
+ * Copyright (c) 2002 Anton Altaparmakov.
+ *
+ * This program/include file is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program/include file is distributed in the hope that it will be 
+ * useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program (in the main directory of the Linux-NTFS 
+ * distribution in the file COPYING); if not, write to the Free Software
+ * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _LINUX_NTFS_DIR_H
+#define _LINUX_NTFS_DIR_H
+
+#include "layout.h"
+
+/*
+ * ntfs_name is used to return the file name to the caller of
+ * ntfs_lookup_inode_by_name() in order for the caller (namei.c::ntfs_lookup())
+ * to be able to deal with dcache aliasing issues.
+ */
+typedef struct {
+	MFT_REF mref;
+	FILE_NAME_TYPE_FLAGS type;
+	u8 len;
+	uchar_t name[0];
+} __attribute__ ((__packed__)) ntfs_name;
+
+/* The little endian Unicode string $I30 as a global constant. */
+extern const uchar_t I30[5];
+
+extern u64 ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const uchar_t *uname,
+		const int uname_len, ntfs_name **res);
+
+#endif /* _LINUX_NTFS_FS_DIR_H */
+
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Wed May 29 12:23:21 2002
+++ b/fs/ntfs/inode.c	Wed May 29 12:23:21 2002
@@ -23,6 +23,7 @@
 #include <linux/buffer_head.h>
 
 #include "ntfs.h"
+#include "dir.h"
 
 struct inode *ntfs_alloc_big_inode(struct super_block *sb)
 {
@@ -1337,13 +1338,6 @@
 	return;
 }
 
-static const option_t si_readdir_opts_arr[] = {
-	{ SHOW_SYSTEM,	"system" },
-	{ SHOW_WIN32,	"win32" },
-	{ SHOW_DOS,	"dos" },
-	{ 0,		NULL }
-};
-
 /**
  * ntfs_show_options - show mount options in /proc/mounts
  * @sf:		seq_file in which to write our mount options
@@ -1368,20 +1362,10 @@
 		seq_printf(sf, ",dmask=0%o", vol->dmask);
 	}
 	seq_printf(sf, ",nls=%s", vol->nls_map->charset);
-	switch (vol->readdir_opts) {
-	case SHOW_ALL:
-		seq_printf(sf, ",show_inodes=all");
-		break;
-	case SHOW_POSIX:
-		seq_printf(sf, ",show_inodes=posix");
-		break;
-	default:
-		for (i = 0; si_readdir_opts_arr[i].val; i++) {
-			if (si_readdir_opts_arr[i].val & vol->readdir_opts)
-				seq_printf(sf, ",show_inodes=%s",
-						si_readdir_opts_arr[i].str);
-		}
-	}
+	if (NVolCaseSensitive(vol))
+		seq_printf(sf, ",case_sensitive");
+	if (NVolShowSystemFiles(vol))
+		seq_printf(sf, ",show_sys_files");
 	for (i = 0; on_errors_arr[i].val; i++) {
 		if (on_errors_arr[i].val & vol->on_errors)
 			seq_printf(sf, ",errors=%s", on_errors_arr[i].str);
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	Wed May 29 12:23:21 2002
+++ b/fs/ntfs/layout.h	Wed May 29 12:23:21 2002
@@ -29,7 +29,7 @@
 #include <linux/list.h>
 #include <asm/byteorder.h>
 
-#include "volume.h"
+#include "types.h"
 
 /*
  * Constant endianness conversion defines.
@@ -679,7 +679,7 @@
  */
 typedef enum {
 	/*
-	 * These flags are only presnt in the STANDARD_INFORMATION attribute
+	 * These flags are only present in the STANDARD_INFORMATION attribute
 	 * (in the field file_attributes).
 	 */
 	FILE_ATTR_READONLY		= const_cpu_to_le32(0x00000001),
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	Wed May 29 12:23:21 2002
+++ b/fs/ntfs/namei.c	Wed May 29 12:23:21 2002
@@ -21,6 +21,7 @@
  */
 
 #include "ntfs.h"
+#include "dir.h"
 
 /**
  * ntfs_lookup - find the inode represented by a dentry in a directory inode
@@ -43,6 +44,48 @@
  * dentry @dent. The dentry is then termed a negative dentry.
  *
  * Only if an actual error occurs, do we return an error via ERR_PTR().
+ *
+ * TODO: Implement the below! (AIA)
+ *
+ * In order to handle the case insensitivity issues of NTFS with regards to the
+ * dcache and the dcache requiring only one dentry per directory, we deal with
+ * dentry aliases that only differ in case in ->ntfs_lookup() while maintining
+ * a case sensitive dcache. This means that we get the full benefit of dcache
+ * speed when the file/directory is looked up with the same case as returned by
+ * ->ntfs_readdir() but that a lookup for any other case (or for the short file
+ * name) will not find anything in dcache and will enter ->ntfs_lookup()
+ * instead, where we search the directory for a fully matching file name
+ * (including case) and if that is not found, we search for a file name that
+ * matches with different case and if that has non-POSIX semantics we return
+ * that. We actually do only one search (case sensitive) and keep tabs on
+ * whether we have found a case insensitive match in the process.
+ *
+ * To simplify matters for us, we do not treat the short vs long filenames as
+ * two hard links but instead if the lookup matches a short filename, we
+ * return the dentry for the corresponding long filename instead.
+ *
+ * There are three cases we need to distinguish here:
+ *
+ * 1) @dent perfectly matches (i.e. including case) a directory entry with a
+ *    file name in the WIN32 or POSIX namespaces. In this case
+ *    ntfs_lookup_inode_by_name() will return with name set to NULL and we
+ *    just d_add() @dent.
+ * 2) @dent matches (not including case) a directory entry with a file name in
+ *    the WIN32 or POSIX namespaces. In this case ntfs_lookup_inode_by_name()
+ *    will return with name set to point to a kmalloc()ed ntfs_name structure
+ *    containing the properly cased little endian Unicode name. We convert the
+ *    name to the current NLS code page, search if a dentry with this name
+ *    already exists and if so return that instead of @dent. The VFS will then
+ *    destroy the old @dent and use the one we returned. If a dentry is not
+ *    found, we allocate a new one, d_add() it, and return it as above.
+ * 3) @dent matches either perfectly or not (i.e. we don't care about case) a
+ *    directory entry with a file name in the DOS namespace. In this case
+ *    ntfs_lookup_inode_by_name() will return with name set to point to a
+ *    kmalloc()ed ntfs_name structure containing the mft reference (cpu endian)
+ *    of the inode. We use the mft reference to read the inode and to find the
+ *    file name in the WIN32 namespace corresponding to the matched short file
+ *    name. We then convert the name to the current NLS code page, and proceed
+ *    searching for a dentry with this name, etc, as in case 2), above.
  */
 static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent)
 {
@@ -52,6 +95,7 @@
 	unsigned long dent_ino;
 	uchar_t *uname;
 	int uname_len;
+	ntfs_name *name = NULL;
 
 	ntfs_debug("Looking up %s in directory inode 0x%lx.",
 			dent->d_name.name, dir_ino->i_ino);
@@ -62,8 +106,12 @@
 		ntfs_error(vol->sb, "Failed to convert name to Unicode.");
 		return ERR_PTR(uname_len);
 	}
-	mref = ntfs_lookup_inode_by_name(NTFS_I(dir_ino), uname, uname_len);
+	mref = ntfs_lookup_inode_by_name(NTFS_I(dir_ino), uname, uname_len,
+			&name);
 	kmem_cache_free(ntfs_name_cache, uname);
+	// TODO: Handle name. (AIA)
+	if (name)
+		kfree(name);
 	if (!IS_ERR_MREF(mref)) {
 		dent_ino = (unsigned long)MREF(mref);
 		ntfs_debug("Found inode 0x%lx. Calling iget.", dent_ino);
@@ -102,7 +150,10 @@
 	return ERR_PTR(MREF_ERR(mref));
 }
 
+/*
+ * Inode operations for directories.
+ */
 struct inode_operations ntfs_dir_inode_ops = {
-	lookup:		ntfs_lookup,	/* lookup directory. */
+	lookup:		ntfs_lookup,	/* VFS: Lookup directory. */
 };
 
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	Wed May 29 12:23:21 2002
+++ b/fs/ntfs/ntfs.h	Wed May 29 12:23:21 2002
@@ -96,9 +96,6 @@
 extern kmem_cache_t *ntfs_big_inode_cache;
 extern kmem_cache_t *ntfs_attr_ctx_cache;
 
-/* The little endian Unicode string $I30 as a global constant. */
-extern const uchar_t I30[5];
-
 /* The various operations structs defined throughout the driver files. */
 extern struct super_operations ntfs_mount_sops;
 extern struct super_operations ntfs_sops;
@@ -222,10 +219,6 @@
 extern inline s64 utc2ntfs(const time_t time);
 extern inline s64 get_current_ntfs_time(void);
 extern inline time_t ntfs2utc(const s64 time);
-
-/* From fs/ntfs/dir.c */
-extern u64 ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const uchar_t *uname,
-		const int uname_len);
 
 /* From fs/ntfs/unistr.c */
 extern BOOL ntfs_are_names_equal(const uchar_t *s1, size_t s1_len,
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Wed May 29 12:23:21 2002
+++ b/fs/ntfs/super.c	Wed May 29 12:23:21 2002
@@ -52,17 +52,6 @@
 	{ 0,			NULL }
 };
 
-static const option_t readdir_opts_arr[] = {
-	{ SHOW_SYSTEM,	"system" },
-	{ SHOW_WIN32,	"win32" },
-	{ SHOW_WIN32,	"long" },
-	{ SHOW_DOS,	"dos" },
-	{ SHOW_DOS,	"short" },
-	{ SHOW_POSIX,	"posix" },
-	{ SHOW_ALL,	"all" },
-	{ 0,		NULL }
-};
-
 /**
  * simple_getbool -
  *
@@ -98,7 +87,8 @@
 	uid_t uid = (uid_t)-1;
 	gid_t gid = (gid_t)-1;
 	mode_t fmask = (mode_t)-1, dmask = (mode_t)-1;
-	int mft_zone_multiplier = -1, on_errors = -1, readdir_opts = -1;
+	int mft_zone_multiplier = -1, on_errors = -1;
+	int show_sys_files = -1, case_sensitive = -1;
 	struct nls_table *nls_map = NULL, *old_nls;
 
 	/* I am lazy... (-8 */
@@ -120,6 +110,13 @@
 		if (*v)							\
 			goto needs_val;					\
 	} 
+#define NTFS_GETOPT_BOOL(option, variable)				\
+	if (!strcmp(p, option)) {					\
+		BOOL val;						\
+		if (!simple_getbool(v, &val))				\
+			goto needs_bool;				\
+		variable = val;						\
+	} 
 #define NTFS_GETOPT_OPTIONS_ARRAY(option, variable, opt_array)		\
 	if (!strcmp(p, option)) {					\
 		int _i;							\
@@ -146,47 +143,16 @@
 		else NTFS_GETOPT("umask", fmask = dmask)
 		else NTFS_GETOPT("fmask", fmask)
 		else NTFS_GETOPT("dmask", dmask)
-		else NTFS_GETOPT_WITH_DEFAULT("sloppy", sloppy, TRUE)
 		else NTFS_GETOPT("mft_zone_multiplier", mft_zone_multiplier)
+		else NTFS_GETOPT_WITH_DEFAULT("sloppy", sloppy, TRUE)
+		else NTFS_GETOPT_BOOL("show_sys_files", show_sys_files)
+		else NTFS_GETOPT_BOOL("case_sensitive", case_sensitive)
 		else NTFS_GETOPT_OPTIONS_ARRAY("errors", on_errors,
 				on_errors_arr)
-		else NTFS_GETOPT_OPTIONS_ARRAY("show_inodes", readdir_opts,
-				readdir_opts_arr)
-		else if (!strcmp(p, "show_sys_files")) {
-			BOOL val = FALSE;
-			ntfs_warning(vol->sb, "Option show_sys_files is "
-				   "deprecated. Please use option "
-				   "show_inodes=system in the future.");
-			if (!v || !*v)
-				val = TRUE;
-			else if (!simple_getbool(v, &val))
-				goto needs_bool;
-			if (val) {
-				if (readdir_opts == -1)
-					readdir_opts = 0;
-				readdir_opts |= SHOW_SYSTEM;
-			}
-		} else if (!strcmp(p, "posix")) {
-			BOOL val = FALSE;
-			ntfs_warning(vol->sb, "Option posix is deprecated. "
-				   "Please use option show_inodes=posix "
-				   "instead. Be aware that some userspace "
-				   "applications may be confused by this, "
-				   "since the short and long names of "
-				   "directory inodes will have the same inode "
-				   "numbers, yet each will only have a link "
-				   "count of 1 due to Linux not supporting "
-				   "directory hard links.");
-			if (!v || !*v)
-				goto needs_arg;
-			else if (!simple_getbool(v, &val))
-				goto needs_bool;
-			if (val) {
-				if (readdir_opts == -1)
-					readdir_opts = 0;
-				readdir_opts |= SHOW_POSIX;
-			}
-		} else if (!strcmp(p, "nls") || !strcmp(p, "iocharset")) {
+		else if (!strcmp(p, "posix") || !strcmp(p, "show_inodes"))
+			ntfs_warning(vol->sb, "Ignoring obsolete option %s.",
+					p);
+		else if (!strcmp(p, "nls") || !strcmp(p, "iocharset")) {
 			if (!strcmp(p, "iocharset"))
 				ntfs_warning(vol->sb, "Option iocharset is "
 						"deprecated. Please use "
@@ -232,6 +198,7 @@
 				errors++;
 		}
 #undef NTFS_GETOPT_OPTIONS_ARRAY
+#undef NTFS_GETOPT_BOOL
 #undef NTFS_GETOPT
 #undef NTFS_GETOPT_WITH_DEFAULT
 	}
@@ -297,8 +264,18 @@
 		vol->fmask = fmask;
 	if (dmask != (mode_t)-1)
 		vol->dmask = dmask;
-	if (readdir_opts != -1)
-		vol->readdir_opts = readdir_opts;
+	if (show_sys_files != -1) {
+		if (show_sys_files)
+			NVolSetShowSystemFiles(vol);
+		else
+			NVolClearShowSystemFiles(vol);
+	}
+	if (case_sensitive != -1) {
+		if (case_sensitive)
+			NVolSetCaseSensitive(vol);
+		else
+			NVolClearCaseSensitive(vol);
+	}
 	return TRUE;
 needs_arg:
 	ntfs_error(vol->sb, "The %s option requires an argument.", p);
@@ -1492,6 +1469,7 @@
 	vol->root_ino = NULL;
 	vol->secure_ino = NULL;
 	vol->uid = vol->gid = 0;
+	vol->flags = 0;
 	vol->on_errors = 0;
 	vol->mft_zone_multiplier = 0;
 	vol->nls_map = NULL;
@@ -1530,12 +1508,6 @@
 	 */
 	vol->fmask = 0177;
 	vol->dmask = 0077;
-
-	/*
-	 * Default is to show long file names (including POSIX file names), and
-	 * not to show system files and short file names.
-	 */
-	vol->readdir_opts = SHOW_WIN32;
 
 	/* Important to get the mount options dealt with now. */
 	if (!parse_options(vol, (char*)opt))
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	Wed May 29 12:23:21 2002
+++ b/fs/ntfs/volume.h	Wed May 29 12:23:21 2002
@@ -26,18 +26,30 @@
 
 #include "types.h"
 
-/* These are used to determine which inode names are returned by readdir(). */
+/*
+ * Defined bits for the flags field in the ntfs_volume structure.
+ */
 typedef enum {
-	SHOW_SYSTEM	= 1,
-	SHOW_WIN32	= 2,
-	SHOW_DOS	= 4,
-	SHOW_POSIX	= SHOW_WIN32 | SHOW_DOS,
-	SHOW_ALL	= SHOW_SYSTEM | SHOW_POSIX,
-} READDIR_OPTIONS;
+	NV_ShowSystemFiles,	/* 1: Return system files in ntfs_readdir(). */
+	NV_CaseSensitive,	/* 1: Treat file names as case sensitive and
+				      create filenames in the POSIX namespace.
+				      Otherwise be case insensitive and create
+				      file names in WIN32 namespace. */
+} ntfs_volume_flags;
+
+#define NVolShowSystemFiles(n_vol)	test_bit(NV_ShowSystemFiles,	\
+							&(n_vol)->flags)
+#define NVolSetShowSystemFiles(n_vol)	set_bit(NV_ShowSystemFiles,	\
+							&(n_vol)->flags)
+#define NVolClearShowSystemFiles(n_vol)	clear_bit(NV_ShowSystemFiles,	\
+							&(n_vol)->flags)
 
-#define RHideSystemFiles(x)	(!((x) & SHOW_SYSTEM))
-#define RHideLongNames(x)	(!((x) & SHOW_WIN32))
-#define RHideDosNames(x)	(!((x) & SHOW_DOS))
+#define NVolCaseSensitive(n_vol)	test_bit(NV_CaseSensitive,	\
+							&(n_vol)->flags)
+#define NVolSetCaseSensitive(n_vol)	set_bit(NV_CaseSensitive,	\
+							&(n_vol)->flags)
+#define NVolClearCaseSensitive(n_vol)	clear_bit(NV_CaseSensitive,	\
+							&(n_vol)->flags)
 
 /*
  * The NTFS in memory super block structure.
@@ -57,13 +69,13 @@
 	LCN nr_blocks;			/* Number of NTFS_BLOCK_SIZE bytes
 					   sized blocks on the device. */
 	/* Configuration provided by user at mount time. */
+	unsigned long flags;		/* Miscellaneous flags, see above. */
 	uid_t uid;			/* uid that files will be mounted as. */
 	gid_t gid;			/* gid that files will be mounted as. */
 	mode_t fmask;			/* The mask for file permissions. */
 	mode_t dmask;			/* The mask for directory
 					   permissions. */
-	READDIR_OPTIONS readdir_opts;	/* Namespace of inode names to show. */
-	u8 mft_zone_multiplier;	/* Initial mft zone multiplier. */
+	u8 mft_zone_multiplier;		/* Initial mft zone multiplier. */
 	u8 on_errors;			/* What to do on file system errors. */
 	/* NTFS bootsector provided information. */
 	u16 sector_size;		/* in bytes */
diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Wed May 29 12:23:22 2002
+++ b/Documentation/filesystems/ntfs.txt	Wed May 29 12:23:22 2002
@@ -245,7 +245,7 @@
 ChangeLog
 =========
 
-Note that a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
+Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
 2.0.8:
 	- Remove now obsolete show_inodes and posix mount option(s).
@@ -256,7 +256,7 @@
 	  we only support accessing files via their short file name if one
 	  exists).
 	- Fix dcache aliasing issues wrt short/long file names.
-	- Cleanups.
+	- Cleanups and minor fixes.
 2.0.7:
 	- Just cleanups.
 2.0.6:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Wed May 29 12:23:22 2002
+++ b/fs/ntfs/ChangeLog	Wed May 29 12:23:22 2002
@@ -33,9 +33,10 @@
 	- Add new mount option case_sensitive, to determine if the driver
 	  treats file names as case sensitive or not. If case sensitive, create
 	  file names in the POSIX namespace. Otherwise create file names in the
-	  LONG/WIN32 name space. By default, or when case_sensitive is set to
+	  LONG/WIN32 namespace. By default, or when case_sensitive is set to
 	  FALSE, files remain accessible via their short file name, if it
 	  exists.
+	- Remove really dumb logic bug in boot sector recovery code.
 	- Fix dcache aliasing issues wrt short/long file names via changes
 	  to fs/ntfs/dir.c::ntfs_lookup_inode_by_name() and
 	  fs/ntfs/namei.c::ntfs_lookup(). (The latter is still TODO:)
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Wed May 29 12:23:22 2002
+++ b/fs/ntfs/super.c	Wed May 29 12:23:22 2002
@@ -441,7 +441,7 @@
 			ntfs_error(sb, "Primary boot sector is invalid.");
 	} else if (!silent)
 		ntfs_error(sb, read_err_str, "primary");
-	if (NTFS_SB(sb)->on_errors & ~ON_ERRORS_RECOVER) {
+	if (!(NTFS_SB(sb)->on_errors & ON_ERRORS_RECOVER)) {
 		if (bh_primary)
 			brelse(bh_primary);
 		if (!silent)
diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Wed May 29 12:23:23 2002
+++ b/Documentation/filesystems/ntfs.txt	Wed May 29 12:23:23 2002
@@ -91,9 +91,9 @@
 			driver will never create short file names and will
 			remove them on rename/delete of the corresponding long
 			file name.
-			Note that by default / when case_sensitive is set to
-			FALSE, files remain accessible via their short file
-			name, if it exists.
+			Note that files remain accessible via their short file
+			name, if it exists. If case_sensitive, you will need to
+			provide the correct case of the short file name.
 
 errors=opt		What to do when critical file system errors are found.
 			Following values can be used for "opt":
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Wed May 29 12:23:23 2002
+++ b/fs/ntfs/ChangeLog	Wed May 29 12:23:23 2002
@@ -33,9 +33,8 @@
 	- Add new mount option case_sensitive, to determine if the driver
 	  treats file names as case sensitive or not. If case sensitive, create
 	  file names in the POSIX namespace. Otherwise create file names in the
-	  LONG/WIN32 namespace. By default, or when case_sensitive is set to
-	  FALSE, files remain accessible via their short file name, if it
-	  exists.
+	  LONG/WIN32 namespace. Note, files remain accessible via their short
+	  file name, if it exists.
 	- Remove really dumb logic bug in boot sector recovery code.
 	- Fix dcache aliasing issues wrt short/long file names via changes
 	  to fs/ntfs/dir.c::ntfs_lookup_inode_by_name() and
@@ -44,6 +43,7 @@
 	  return information about the matching file name if the case is not
 	  matching or the match is a short file name. See comments above the
 	  function definition for details.
+	- Fix potential 1 byte overflow in fs/ntfs/unistr.c::ntfs_ucstonls().
 	- TODO: (AIA) Change ntfs_lookup()...
 
 2.0.7 - Minor cleanups and updates for changes in core kernel code.
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Wed May 29 12:23:23 2002
+++ b/fs/ntfs/dir.c	Wed May 29 12:23:23 2002
@@ -200,7 +200,7 @@
 						"and if that doesn't find any "
 						"errors please report you saw "
 						"this message to "
-						"linux-ntfs@lists.sf.net.");
+						"linux-ntfs-dev@lists.sf.net.");
 				goto dir_err_out;
 			}
 
@@ -456,7 +456,7 @@
 						"and if that doesn't find any "
 						"errors please report you saw "
 						"this message to "
-						"linux-ntfs@lists.sf.net.");
+						"linux-ntfs-dev@lists.sf.net.");
 				ntfs_unmap_page(page);
 				goto dir_err_out;
 			}
diff -Nru a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
--- a/fs/ntfs/unistr.c	Wed May 29 12:23:23 2002
+++ b/fs/ntfs/unistr.c	Wed May 29 12:23:23 2002
@@ -333,7 +333,7 @@
 		}
 		if (!ns) {
 			ns_len = ins_len * NLS_MAX_CHARSET_SIZE;
-			ns = (unsigned char*)kmalloc(ns_len, GFP_NOFS);
+			ns = (unsigned char*)kmalloc(ns_len + 1, GFP_NOFS);
 			if (!ns)
 				goto mem_err_out;
 		}
@@ -352,7 +352,7 @@
 						~63, GFP_NOFS);
 				if (tc) {
 					memcpy(tc, ns, ns_len);
-					ns_len = (ns_len + 64) & ~63;
+					ns_len = ((ns_len + 64) & ~63) - 1;
 					kfree(ns);
 					ns = tc;
 					goto retry;
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Wed May 29 12:23:25 2002
+++ b/fs/ntfs/ChangeLog	Wed May 29 12:23:25 2002
@@ -25,6 +25,9 @@
 
 2.0.8 - Major updates for handling of case sensitivity and dcache aliasing.
 
+	Big thanks go to Al Viro and other inhabitants of #kernel for investing
+	their time to discuss the case sensitivity and dcache aliasing issues.
+
 	- Remove unused source file fs/ntfs/attraops.c.
 	- Remove show_inodes mount option(s), thus dropping support for
 	  displaying of short file names.
@@ -38,13 +41,18 @@
 	- Remove really dumb logic bug in boot sector recovery code.
 	- Fix dcache aliasing issues wrt short/long file names via changes
 	  to fs/ntfs/dir.c::ntfs_lookup_inode_by_name() and
-	  fs/ntfs/namei.c::ntfs_lookup(). (The latter is still TODO:)
-	- Add additional argument to ntfs_lookup_inode_by_name() in which we
-	  return information about the matching file name if the case is not
-	  matching or the match is a short file name. See comments above the
-	  function definition for details.
+	  fs/ntfs/namei.c::ntfs_lookup():
+	  - Add additional argument to ntfs_lookup_inode_by_name() in which we
+	    return information about the matching file name if the case is not
+	    matching or the match is a short file name. See comments above the
+	    function definition for details.
+	  - Change ntfs_lookup() to only create dcache entries for the correctly
+	    cased file name and only for the WIN32 namespace counterpart of DOS
+	    namespace file names. This ensures we have only one dentry per
+	    directory and also removes all dcache aliasing issues between short
+	    and long file names once we add write support. See comments above
+	    function for details.
 	- Fix potential 1 byte overflow in fs/ntfs/unistr.c::ntfs_ucstonls().
-	- TODO: (AIA) Change ntfs_lookup()...
 
 2.0.7 - Minor cleanups and updates for changes in core kernel code.
 
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	Wed May 29 12:23:25 2002
+++ b/fs/ntfs/namei.c	Wed May 29 12:23:25 2002
@@ -20,6 +20,8 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/dcache.h>
+
 #include "ntfs.h"
 #include "dir.h"
 
@@ -45,8 +47,6 @@
  *
  * Only if an actual error occurs, do we return an error via ERR_PTR().
  *
- * TODO: Implement the below! (AIA)
- *
  * In order to handle the case insensitivity issues of NTFS with regards to the
  * dcache and the dcache requiring only one dentry per directory, we deal with
  * dentry aliases that only differ in case in ->ntfs_lookup() while maintining
@@ -71,13 +71,13 @@
  *    ntfs_lookup_inode_by_name() will return with name set to NULL and we
  *    just d_add() @dent.
  * 2) @dent matches (not including case) a directory entry with a file name in
- *    the WIN32 or POSIX namespaces. In this case ntfs_lookup_inode_by_name()
- *    will return with name set to point to a kmalloc()ed ntfs_name structure
- *    containing the properly cased little endian Unicode name. We convert the
- *    name to the current NLS code page, search if a dentry with this name
- *    already exists and if so return that instead of @dent. The VFS will then
- *    destroy the old @dent and use the one we returned. If a dentry is not
- *    found, we allocate a new one, d_add() it, and return it as above.
+ *    the WIN32 namespace. In this case ntfs_lookup_inode_by_name() will return
+ *    with name set to point to a kmalloc()ed ntfs_name structure containing
+ *    the properly cased little endian Unicode name. We convert the name to the
+ *    current NLS code page, search if a dentry with this name already exists
+ *    and if so return that instead of @dent. The VFS will then destroy the old
+ *    @dent and use the one we returned. If a dentry is not found, we allocate
+ *    a new one, d_add() it, and return it as above.
  * 3) @dent matches either perfectly or not (i.e. we don't care about case) a
  *    directory entry with a file name in the DOS namespace. In this case
  *    ntfs_lookup_inode_by_name() will return with name set to point to a
@@ -91,11 +91,11 @@
 {
 	ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
 	struct inode *dent_inode;
+	uchar_t *uname;
+	ntfs_name *name = NULL;
 	u64 mref;
 	unsigned long dent_ino;
-	uchar_t *uname;
 	int uname_len;
-	ntfs_name *name = NULL;
 
 	ntfs_debug("Looking up %s in directory inode 0x%lx.",
 			dent->d_name.name, dir_ino->i_ino);
@@ -109,9 +109,6 @@
 	mref = ntfs_lookup_inode_by_name(NTFS_I(dir_ino), uname, uname_len,
 			&name);
 	kmem_cache_free(ntfs_name_cache, uname);
-	// TODO: Handle name. (AIA)
-	if (name)
-		kfree(name);
 	if (!IS_ERR_MREF(mref)) {
 		dent_ino = (unsigned long)MREF(mref);
 		ntfs_debug("Found inode 0x%lx. Calling iget.", dent_ino);
@@ -120,9 +117,17 @@
 			/* Consistency check. */
 			if (MSEQNO(mref) == NTFS_I(dent_inode)->seq_no ||
 					dent_ino == FILE_MFT) {
-				d_add(dent, dent_inode);
-				ntfs_debug("Done.");
-				return NULL;
+				/* Perfect WIN32/POSIX match. -- Case 1. */
+				if (!name) {
+					d_add(dent, dent_inode);
+					ntfs_debug("Done.");
+					return NULL;
+				}
+				/*
+				 * We are too indented. Handle imperfect
+				 * matches and short file names further below.
+				 */
+				goto handle_name;
 			}
 			ntfs_error(vol->sb, "Found stale reference to inode "
 					"0x%Lx (reference sequence number = "
@@ -136,8 +141,11 @@
 			ntfs_error(vol->sb, "iget(0x%Lx) failed, returning "
 					"-EACCES.",
 					(unsigned long long)MREF(mref));
+		if (name)
+			kfree(name);
 		return ERR_PTR(-EACCES);
 	}
+	/* It is guaranteed that name is no longer allocated at this point. */
 	if (MREF_ERR(mref) == -ENOENT) {
 		ntfs_debug("Entry was not found, adding negative dentry.");
 		/* The dcache will handle negative entries. */
@@ -148,6 +156,127 @@
 	ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error "
 			"code %i.", -MREF_ERR(mref));
 	return ERR_PTR(MREF_ERR(mref));
+
+	// TODO: Consider moving this lot to a separate function! (AIA)
+handle_name:
+   {
+	struct dentry *real_dent;
+	attr_search_context *ctx;
+	ntfs_inode *ni = NTFS_I(dent_inode);
+	int err;
+	struct qstr nls_name;
+
+	nls_name.name = NULL;
+	if (name->type != FILE_NAME_DOS) {			/* Case 2. */
+		nls_name.len = (unsigned)ntfs_ucstonls(vol,
+				(uchar_t*)&name->name, name->len,
+				(unsigned char**)&nls_name.name,
+				name->len * 3 + 1);
+		kfree(name);
+	} else /* if (name->type == FILE_NAME_DOS) */ {		/* Case 3. */
+		MFT_RECORD *m;
+		FILE_NAME_ATTR *fn;
+
+		kfree(name);
+
+		/* Find the WIN32 name corresponding to the matched DOS name. */
+		ni = NTFS_I(dent_inode);
+		m = map_mft_record(READ, ni);
+		if (IS_ERR(m)) {
+			err = PTR_ERR(m);
+			goto name_err_out;
+		}
+		ctx = get_attr_search_ctx(ni, m);
+		if (!ctx) {
+			err = -ENOMEM;
+			goto unm_err_out;
+		}
+		do {
+			ATTR_RECORD *a;
+			u32 val_len;
+
+			if (!lookup_attr(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0,
+					ctx)) {
+				ntfs_error(vol->sb, "Inode corrupt: No WIN32 "
+						"namespace counterpart to DOS "
+						"file name. Run chkdsk.");
+				err = -EIO;
+				goto put_unm_err_out;
+			}
+			/* Consistency checks. */
+			a = ctx->attr;
+			if (a->non_resident || a->flags)
+				goto eio_put_unm_err_out;
+			val_len = le32_to_cpu(a->_ARA(value_length));
+			if (le16_to_cpu(a->_ARA(value_offset)) + val_len >
+					le32_to_cpu(a->length))
+				goto eio_put_unm_err_out;
+			fn = (FILE_NAME_ATTR*)((u8*)ctx->attr + le16_to_cpu(
+					ctx->attr->_ARA(value_offset)));
+			if ((u32)(fn->file_name_length * sizeof(uchar_t) +
+					sizeof(FILE_NAME_ATTR)) > val_len)
+				goto eio_put_unm_err_out;
+		} while (fn->file_name_type != FILE_NAME_WIN32);
+
+		/* Convert the found WIN32 name to current NLS code page. */
+		nls_name.len = (unsigned)ntfs_ucstonls(vol,
+				(uchar_t*)&fn->file_name, fn->file_name_length,
+				(unsigned char**)&nls_name.name,
+				fn->file_name_length * 3 + 1);
+
+		put_attr_search_ctx(ctx);
+		unmap_mft_record(READ, ni);
+	}
+
+	/* Check if a conversion error occured. */
+	if ((signed)nls_name.len < 0) {
+		err = (signed)nls_name.len;
+		goto name_err_out;
+	}
+	nls_name.hash = full_name_hash(nls_name.name, nls_name.len);
+
+	// FIXME: Do we need dcache_lock or dparent_lock here or is the
+	// fact that i_sem is held on the parent inode sufficient? (AIA)
+
+	/* Does a dentry matching the nls_name exist already? */
+	real_dent = d_lookup(dent->d_parent, &nls_name);
+	/* If not, create it now. */
+	if (!real_dent) {
+		real_dent = d_alloc(dent->d_parent, &nls_name);
+		kfree(nls_name.name);
+		if (!real_dent) {
+			err = -ENOMEM;
+			goto name_err_out;
+		}
+		d_add(real_dent, dent_inode);
+		return real_dent;
+	}
+	kfree(nls_name.name);
+	/* Matching dentry exists, check if it is negative. */
+	if (real_dent->d_inode) {
+		BUG_ON(real_dent->d_inode != dent_inode);
+		/*
+		 * Already have the inode and the dentry attached, decrement
+		 * the reference count to balance the iget() we did earlier on.
+		 */
+		iput(dent_inode);
+		return real_dent;
+	}
+	/* Negative dentry: instantiate it. */
+	d_instantiate(real_dent, dent_inode);
+	return real_dent;
+
+eio_put_unm_err_out:
+	ntfs_error(vol->sb, "Illegal file name attribute. Run chkdsk.");
+	err = -EIO;
+put_unm_err_out:
+	put_attr_search_ctx(ctx);
+unm_err_out:
+	unmap_mft_record(READ, ni);
+name_err_out:
+	iput(dent_inode);
+	return ERR_PTR(err);
+   }
 }
 
 /*

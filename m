Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUENPSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUENPSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 11:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUENPSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 11:18:08 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:14230 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261605AbUENPOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 11:14:17 -0400
Date: Fri, 14 May 2004 16:14:14 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6.6-BK] NTFS 2.1.11 Really final cleanups.
Message-ID: <Pine.SOL.4.58.0405141613001.918@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.6

Thanks!  Another cleanup which I missed last time as well as renaming uchar_t
throughout the NTFS code to ntfschar since uchar_t is already defined by POSIX
to be an unsigned 1-byte character and it is confusing to have uchar_t in NTFS
mean something different (unsigned 2-byte Unicode character).  Having a unique
name (ntfschar turns up nothing in Google) makes things more obvious...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    2 +
 fs/ntfs/ChangeLog                  |   23 +++++++++++---
 fs/ntfs/Makefile                   |    8 +++--
 fs/ntfs/attrib.c                   |   59 ++++++++++++++++++-------------------
 fs/ntfs/attrib.h                   |    9 +++--
 fs/ntfs/dir.c                      |   44 +++++++++++++--------------
 fs/ntfs/dir.h                      |    6 +--
 fs/ntfs/inode.c                    |    8 ++---
 fs/ntfs/inode.h                    |    6 +--
 fs/ntfs/layout.h                   |    8 ++---
 fs/ntfs/logfile.c                  |    7 +++-
 fs/ntfs/logfile.h                  |    2 -
 fs/ntfs/namei.c                    |    8 ++---
 fs/ntfs/ntfs.h                     |   32 ++++++++++----------
 fs/ntfs/super.c                    |   12 +++----
 fs/ntfs/types.h                    |    2 -
 fs/ntfs/unistr.c                   |   46 ++++++++++++++--------------
 fs/ntfs/upcase.c                   |    8 ++---
 fs/ntfs/volume.h                   |    2 -
 19 files changed, 159 insertions(+), 133 deletions(-)

===================================================================

The diff patch for non-BK users:

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Fri May 14 16:03:21 2004
+++ b/Documentation/filesystems/ntfs.txt	Fri May 14 16:03:21 2004
@@ -273,6 +273,8 @@

 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.

+2.1.11:
+	- Driver internal cleanups.
 2.1.10:
 	- Force read-only (re)mounting of volumes with unsupported volume
 	  flags and various cleanups.
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/ChangeLog	Fri May 14 16:03:21 2004
@@ -1,10 +1,16 @@
 ToDo:
 	- Find and fix bugs.
+	- Either invalidate quotas or update the quota charges on NTFS 3.x
+	  volumes with quota tracking enabled ($Quota).
+	- Checkpoint or disable the user space journal ($UsnJrnl).
 	- Implement aops->set_page_dirty() in order to take control of buffer
 	  dirtying. Not having it means if page_has_buffers(), all buffers
 	  will be dirtied with the page. And if not they won't be. That is
 	  fine for the moment but will break once we enable metadata updates.
-	- Implement sops->dirty_inode() to implement {a,m,c} time updates and
+	  For now just always using __set_page_dirty_nobuffers() for metadata
+	  pages as nothing can dirty a page other than ourselves. Should this
+	  change, we will really need to roll our own ->set_page_dirty().
+	- Implement sops->dirty_inode() to implement {a,m,c}time updates and
 	  such things.
 	- Implement sops->write_inode().
 	- In between ntfs_prepare/commit_write, need exclusion between
@@ -19,6 +25,15 @@
 	  sufficient for synchronisation here. We then just need to make sure
 	  ntfs_readpage/writepage/truncate interoperate properly with us.

+2.1.11 - Driver internal cleanups.
+
+	- Only build logfile.o if building the driver with read-write support.
+	- Really final white space cleanups.
+	- Use generic_ffs() instead of ffs() in logfile.c which allows the
+	  log_page_size variable to be optimized by gcc into a constant.
+	- Rename uchar_t to ntfschar everywhere as uchar_t is unsigned 1-byte
+	  char as defined by POSIX and as found on some systems.
+
 2.1.10 - Force read-only (re)mounting of volumes with unsupported volume flags.

 	- Finish off the white space cleanups (remove trailing spaces, etc).
@@ -600,12 +615,12 @@
 	  types of inode names readdir() returns and modify ntfs_filldir()
 	  accordingly. There are several parameters to show_inodes:
 		system:	system files
-	  	win32:	long file names (including POSIX file names) [DEFAULT]
+		win32:	long file names (including POSIX file names) [DEFAULT]
 		long:	same as win32
-	  	dos:	short file names only (excluding POSIX file names)
+		dos:	short file names only (excluding POSIX file names)
 		short:	same as dos
 		posix:	same as both win32 and dos
-	  	all:	all file names
+		all:	all file names
 	  Note that the options are additive, i.e. specifying:
 		-o show_inodes=system,show_inodes=win32,show_inodes=dos
 	  is the same as specifying:
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/Makefile	Fri May 14 16:03:21 2004
@@ -2,10 +2,10 @@

 obj-$(CONFIG_NTFS_FS) += ntfs.o

-ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o logfile.o \
-	     mft.o mst.o namei.o super.o sysctl.o unistr.o upcase.o
+ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
+	     mst.o namei.o super.o sysctl.o unistr.o upcase.o

-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.10\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.11\"

 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
@@ -13,4 +13,6 @@

 ifeq ($(CONFIG_NTFS_RW),y)
 EXTRA_CFLAGS += -DNTFS_RW
+
+ntfs-objs += logfile.o
 endif
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/attrib.c	Fri May 14 16:03:21 2004
@@ -105,7 +105,7 @@
  * It is up to the caller to serialize access to the run lists @dst and @src.
  *
  * Return: TRUE   Success, the run lists can be merged.
- *         FALSE  Failure, the run lists cannot be merged.
+ *	   FALSE  Failure, the run lists cannot be merged.
  */
 static inline BOOL ntfs_are_rl_mergeable(run_list_element *dst,
 		run_list_element *src)
@@ -151,7 +151,7 @@
  * It is up to the caller to serialize access to the run lists @dst and @src.
  *
  * Return: TRUE   Success, the run lists have been merged.
- *         FALSE  Failure, the run lists cannot be merged and have not been
+ *	   FALSE  Failure, the run lists cannot be merged and have not been
  *		  modified.
  */
 static inline BOOL ntfs_rl_merge(run_list_element *dst, run_list_element *src)
@@ -264,9 +264,9 @@
 	BUG_ON(!src);

 	/* disc => Discontinuity between the end of @dst and the start of @src.
-	 *         This means we might need to insert a hole.
+	 *	   This means we might need to insert a hole.
 	 * hole => @dst ends with a hole or an unmapped region which we can
-	 *         extend to match the discontinuity. */
+	 *	   extend to match the discontinuity. */
 	if (loc == 0)
 		disc = (src[0].vcn > 0);
 	else {
@@ -444,7 +444,7 @@
 	ntfs_rl_mc(dst, loc + 1, src, 0, ssize);

 	/* Adjust the size of the holes either size of @src. */
-	dst[loc].length         = dst[loc+1].vcn       - dst[loc].vcn;
+	dst[loc].length		= dst[loc+1].vcn       - dst[loc].vcn;
 	dst[loc+ssize+1].vcn    = dst[loc+ssize].vcn   + dst[loc+ssize].length;
 	dst[loc+ssize+1].length = dst[loc+ssize+2].vcn - dst[loc+ssize+1].vcn;

@@ -504,7 +504,7 @@
 	ntfs_debug_dump_runlist(srl);
 #endif

- 	/* Check for silly calling... */
+	/* Check for silly calling... */
 	if (unlikely(!srl))
 		return drl;
 	if (unlikely(IS_ERR(srl) || IS_ERR(drl)))
@@ -706,9 +706,9 @@
  *
  * The following error codes are defined:
  *	-ENOMEM	- Not enough memory to allocate run list array.
- * 	-EIO	- Corrupt run list.
- * 	-EINVAL	- Invalid parameters were passed in.
- * 	-ERANGE	- The two run lists overlap.
+ *	-EIO	- Corrupt run list.
+ *	-EINVAL	- Invalid parameters were passed in.
+ *	-ERANGE	- The two run lists overlap.
  *
  * FIXME: For now we take the conceptionally simplest approach of creating the
  * new run list disregarding the already existing one and then splicing the
@@ -719,7 +719,7 @@
 		const ATTR_RECORD *attr, run_list_element *old_rl)
 {
 	VCN vcn;		/* Current vcn. */
-	LCN lcn; 		/* Current lcn. */
+	LCN lcn;		/* Current lcn. */
 	s64 deltaxcn;		/* Change in [vl]cn. */
 	run_list_element *rl;	/* The output run list. */
 	u8 *buf;		/* Current position in mapping pairs array. */
@@ -769,7 +769,7 @@
 		 */
 		if (((rlpos + 3) * sizeof(*old_rl)) > rlsize) {
 			run_list_element *rl2;
-
+
 			rl2 = ntfs_malloc_nofs(rlsize + (int)PAGE_SIZE);
 			if (unlikely(!rl2)) {
 				ntfs_free(rl);
@@ -946,7 +946,7 @@
 	attr_search_context *ctx;
 	MFT_RECORD *mrec;
 	int err = 0;
-
+
 	ntfs_debug("Mapping run list part containing vcn 0x%llx.",
 			(unsigned long long)vcn);

@@ -983,7 +983,7 @@
 			ni->run_list.rl = rl;
 	}
 	up_write(&ni->run_list.lock);
-
+
 	put_attr_search_ctx(ctx);
 err_out:
 	unmap_mft_record(base_ni);
@@ -1096,13 +1096,13 @@
  * Warning: Never use @val when looking for attribute types which can be
  *	    non-resident as this most likely will result in a crash!
  */
-BOOL find_attr(const ATTR_TYPES type, const uchar_t *name, const u32 name_len,
+BOOL find_attr(const ATTR_TYPES type, const ntfschar *name, const u32 name_len,
 		const IGNORE_CASE_BOOL ic, const u8 *val, const u32 val_len,
 		attr_search_context *ctx)
 {
 	ATTR_RECORD *a;
 	ntfs_volume *vol;
-	uchar_t *upcase;
+	ntfschar *upcase;
 	u32 upcase_len;

 	if (ic == IGNORE_CASE) {
@@ -1145,12 +1145,12 @@
 			if (a->name_length)
 				return FALSE;
 		} else if (!ntfs_are_names_equal(name, name_len,
-			    (uchar_t*)((u8*)a + le16_to_cpu(a->name_offset)),
+			    (ntfschar*)((u8*)a + le16_to_cpu(a->name_offset)),
 			    a->name_length, ic, upcase, upcase_len)) {
 			register int rc;
-
+
 			rc = ntfs_collate_names(name, name_len,
-					(uchar_t*)((u8*)a +
+					(ntfschar*)((u8*)a +
 						le16_to_cpu(a->name_offset)),
 					a->name_length, 1, IGNORE_CASE,
 					upcase, upcase_len);
@@ -1162,9 +1162,9 @@
 				return FALSE;
 			/* If the strings are not equal, continue search. */
 			if (rc)
-	 			continue;
+				continue;
 			rc = ntfs_collate_names(name, name_len,
-					(uchar_t*)((u8*)a +
+					(ntfschar*)((u8*)a +
 						le16_to_cpu(a->name_offset)),
 					a->name_length, 1, CASE_SENSITIVE,
 					upcase, upcase_len);
@@ -1354,7 +1354,7 @@
  * and if there is not enough space, the attribute should be placed in an
  * extent mft record.
  */
-static BOOL find_external_attr(const ATTR_TYPES type, const uchar_t *name,
+static BOOL find_external_attr(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const VCN lowest_vcn, const u8 *val, const u32 val_len,
 		attr_search_context *ctx)
@@ -1364,7 +1364,7 @@
 	ATTR_LIST_ENTRY *al_entry, *next_al_entry;
 	u8 *al_start, *al_end;
 	ATTR_RECORD *a;
-	uchar_t *al_name;
+	ntfschar *al_name;
 	u32 al_name_len;

 	ni = ctx->ntfs_ino;
@@ -1417,7 +1417,7 @@
 		 * missing, assume we want an unnamed attribute.
 		 */
 		al_name_len = al_entry->name_length;
-		al_name = (uchar_t*)((u8*)al_entry + al_entry->name_offset);
+		al_name = (ntfschar*)((u8*)al_entry + al_entry->name_offset);
 		if (!name) {
 			if (al_name_len)
 				goto not_found;
@@ -1461,12 +1461,12 @@
 		if (lowest_vcn && (u8*)next_al_entry >= al_start	    &&
 				(u8*)next_al_entry + 6 < al_end		    &&
 				(u8*)next_al_entry + le16_to_cpu(
-					next_al_entry->length) <= al_end    &&
+					next_al_entry->length) <= al_end    &&
 				sle64_to_cpu(next_al_entry->lowest_vcn) <=
 					sle64_to_cpu(lowest_vcn)	    &&
 				next_al_entry->type == al_entry->type	    &&
 				next_al_entry->name_length == al_name_len   &&
-				ntfs_are_names_equal((uchar_t*)((u8*)
+				ntfs_are_names_equal((ntfschar*)((u8*)
 					next_al_entry +
 					next_al_entry->name_offset),
 					next_al_entry->name_length,
@@ -1539,7 +1539,7 @@
 		if (name) {
 			if (a->name_length != al_name_len)
 				continue;
-			if (!ntfs_are_names_equal((uchar_t*)((u8*)a +
+			if (!ntfs_are_names_equal((ntfschar*)((u8*)a +
 					le16_to_cpu(a->name_offset)),
 					a->name_length, al_name, al_name_len,
 					CASE_SENSITIVE, vol->upcase,
@@ -1623,9 +1623,10 @@
  * being searched for, i.e. if one wants to add the attribute to the mft
  * record this is the correct place to insert it into.
  */
-BOOL lookup_attr(const ATTR_TYPES type, const uchar_t *name, const u32 name_len,
-		const IGNORE_CASE_BOOL ic, const VCN lowest_vcn, const u8 *val,
-		const u32 val_len, attr_search_context *ctx)
+BOOL lookup_attr(const ATTR_TYPES type, const ntfschar *name,
+		const u32 name_len, const IGNORE_CASE_BOOL ic,
+		const VCN lowest_vcn, const u8 *val, const u32 val_len,
+		attr_search_context *ctx)
 {
 	ntfs_inode *base_ni;

diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/attrib.h	Fri May 14 16:03:21 2004
@@ -79,13 +79,14 @@

 extern LCN vcn_to_lcn(const run_list_element *rl, const VCN vcn);

-extern BOOL find_attr(const ATTR_TYPES type, const uchar_t *name,
+extern BOOL find_attr(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic, const u8 *val,
 		const u32 val_len, attr_search_context *ctx);

-BOOL lookup_attr(const ATTR_TYPES type, const uchar_t *name, const u32 name_len,
-		const IGNORE_CASE_BOOL ic, const VCN lowest_vcn, const u8 *val,
-		const u32 val_len, attr_search_context *ctx);
+BOOL lookup_attr(const ATTR_TYPES type, const ntfschar *name,
+		const u32 name_len, const IGNORE_CASE_BOOL ic,
+		const VCN lowest_vcn, const u8 *val, const u32 val_len,
+		attr_search_context *ctx);

 extern int load_attribute_list(ntfs_volume *vol, run_list *rl, u8 *al_start,
 		const s64 size, const s64 initialized_size);
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/dir.c	Fri May 14 16:03:21 2004
@@ -27,7 +27,7 @@
 /**
  * The little endian Unicode string $I30 as a global constant.
  */
-uchar_t I30[5] = { const_cpu_to_le16('$'), const_cpu_to_le16('I'),
+ntfschar I30[5] = { const_cpu_to_le16('$'), const_cpu_to_le16('I'),
 		const_cpu_to_le16('3'),	const_cpu_to_le16('0'),
 		const_cpu_to_le16(0) };

@@ -64,7 +64,7 @@
  * work but we don't care for how quickly one can access them. This also fixes
  * the dcache aliasing issues.
  */
-MFT_REF ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const uchar_t *uname,
+MFT_REF ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const ntfschar *uname,
 		const int uname_len, ntfs_name **res)
 {
 	ntfs_volume *vol = dir_ni->vol;
@@ -135,7 +135,7 @@
 		 * returning.
 		 */
 		if (ntfs_are_names_equal(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length,
 				CASE_SENSITIVE, vol->upcase, vol->upcase_len)) {
 found_it:
@@ -186,7 +186,7 @@
 		if (!NVolCaseSensitive(vol) &&
 				ie->key.file_name.file_name_type &&
 				ntfs_are_names_equal(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length,
 				IGNORE_CASE, vol->upcase, vol->upcase_len)) {
 			int name_size = sizeof(ntfs_name);
@@ -206,7 +206,7 @@
 			}

 			if (type != FILE_NAME_DOS)
-				name_size += len * sizeof(uchar_t);
+				name_size += len * sizeof(ntfschar);
 			name = kmalloc(name_size, GFP_NOFS);
 			if (!name) {
 				err = -ENOMEM;
@@ -217,7 +217,7 @@
 			if (type != FILE_NAME_DOS) {
 				name->len = len;
 				memcpy(name->name, ie->key.file_name.file_name,
-						len * sizeof(uchar_t));
+						len * sizeof(ntfschar));
 			} else
 				name->len = 0;
 			*res = name;
@@ -227,7 +227,7 @@
 		 * know which way in the B+tree we have to go.
 		 */
 		rc = ntfs_collate_names(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length, 1,
 				IGNORE_CASE, vol->upcase, vol->upcase_len);
 		/*
@@ -246,7 +246,7 @@
 		 * collation.
 		 */
 		rc = ntfs_collate_names(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length, 1,
 				CASE_SENSITIVE, vol->upcase, vol->upcase_len);
 		if (rc == -1)
@@ -395,7 +395,7 @@
 		 * returning.
 		 */
 		if (ntfs_are_names_equal(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length,
 				CASE_SENSITIVE, vol->upcase, vol->upcase_len)) {
 found_it2:
@@ -445,7 +445,7 @@
 		if (!NVolCaseSensitive(vol) &&
 				ie->key.file_name.file_name_type &&
 				ntfs_are_names_equal(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length,
 				IGNORE_CASE, vol->upcase, vol->upcase_len)) {
 			int name_size = sizeof(ntfs_name);
@@ -466,7 +466,7 @@
 			}

 			if (type != FILE_NAME_DOS)
-				name_size += len * sizeof(uchar_t);
+				name_size += len * sizeof(ntfschar);
 			name = kmalloc(name_size, GFP_NOFS);
 			if (!name) {
 				err = -ENOMEM;
@@ -477,7 +477,7 @@
 			if (type != FILE_NAME_DOS) {
 				name->len = len;
 				memcpy(name->name, ie->key.file_name.file_name,
-						len * sizeof(uchar_t));
+						len * sizeof(ntfschar));
 			} else
 				name->len = 0;
 			*res = name;
@@ -487,7 +487,7 @@
 		 * know which way in the B+tree we have to go.
 		 */
 		rc = ntfs_collate_names(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length, 1,
 				IGNORE_CASE, vol->upcase, vol->upcase_len);
 		/*
@@ -506,7 +506,7 @@
 		 * collation.
 		 */
 		rc = ntfs_collate_names(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length, 1,
 				CASE_SENSITIVE, vol->upcase, vol->upcase_len);
 		if (rc == -1)
@@ -607,7 +607,7 @@
  *
  * Note, @uname_len does not include the (optional) terminating NULL character.
  */
-u64 ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const uchar_t *uname,
+u64 ntfs_lookup_inode_by_name(ntfs_inode *dir_ni, const ntfschar *uname,
 		const int uname_len)
 {
 	ntfs_volume *vol = dir_ni->vol;
@@ -689,7 +689,7 @@
 		 * convert it to cpu format before returning.
 		 */
 		if (ntfs_are_names_equal(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length, ic,
 				vol->upcase, vol->upcase_len)) {
 found_it:
@@ -703,7 +703,7 @@
 		 * know which way in the B+tree we have to go.
 		 */
 		rc = ntfs_collate_names(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length, 1,
 				IGNORE_CASE, vol->upcase, vol->upcase_len);
 		/*
@@ -722,7 +722,7 @@
 		 * collation.
 		 */
 		rc = ntfs_collate_names(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length, 1,
 				CASE_SENSITIVE, vol->upcase, vol->upcase_len);
 		if (rc == -1)
@@ -875,7 +875,7 @@
 		 * convert it to cpu format before returning.
 		 */
 		if (ntfs_are_names_equal(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length, ic,
 				vol->upcase, vol->upcase_len)) {
 found_it2:
@@ -888,7 +888,7 @@
 		 * know which way in the B+tree we have to go.
 		 */
 		rc = ntfs_collate_names(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length, 1,
 				IGNORE_CASE, vol->upcase, vol->upcase_len);
 		/*
@@ -907,7 +907,7 @@
 		 * collation.
 		 */
 		rc = ntfs_collate_names(uname, uname_len,
-				(uchar_t*)&ie->key.file_name.file_name,
+				(ntfschar*)&ie->key.file_name.file_name,
 				ie->key.file_name.file_name_length, 1,
 				CASE_SENSITIVE, vol->upcase, vol->upcase_len);
 		if (rc == -1)
@@ -1027,7 +1027,7 @@
 		ntfs_debug("Skipping system file.");
 		return 0;
 	}
-	name_len = ntfs_ucstonls(vol, (uchar_t*)&ie->key.file_name.file_name,
+	name_len = ntfs_ucstonls(vol, (ntfschar*)&ie->key.file_name.file_name,
 			ie->key.file_name.file_name_length, &name,
 			NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1);
 	if (name_len <= 0) {
diff -Nru a/fs/ntfs/dir.h b/fs/ntfs/dir.h
--- a/fs/ntfs/dir.h	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/dir.h	Fri May 14 16:03:21 2004
@@ -34,13 +34,13 @@
 	MFT_REF mref;
 	FILE_NAME_TYPE_FLAGS type;
 	u8 len;
-	uchar_t name[0];
+	ntfschar name[0];
 } __attribute__ ((__packed__)) ntfs_name;

 /* The little endian Unicode string $I30 as a global constant. */
-extern uchar_t I30[5];
+extern ntfschar I30[5];

 extern MFT_REF ntfs_lookup_inode_by_name(ntfs_inode *dir_ni,
-		const uchar_t *uname, const int uname_len, ntfs_name **res);
+		const ntfschar *uname, const int uname_len, ntfs_name **res);

 #endif /* _LINUX_NTFS_FS_DIR_H */
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/inode.c	Fri May 14 16:03:21 2004
@@ -66,7 +66,7 @@
 		if (ni->name_len != na->name_len)
 			return 0;
 		if (na->name_len && memcmp(ni->name, na->name,
-				na->name_len * sizeof(uchar_t)))
+				na->name_len * sizeof(ntfschar)))
 			return 0;
 	}
 	/* Match! */
@@ -121,8 +121,8 @@
 	if (na->name && na->name_len && na->name != I30) {
 		unsigned int i;

-		i = na->name_len * sizeof(uchar_t);
-		ni->name = (uchar_t*)kmalloc(i + sizeof(uchar_t), GFP_ATOMIC);
+		i = na->name_len * sizeof(ntfschar);
+		ni->name = (ntfschar*)kmalloc(i + sizeof(ntfschar), GFP_ATOMIC);
 		if (!ni->name)
 			return -ENOMEM;
 		memcpy(ni->name, na->name, i);
@@ -206,7 +206,7 @@
  * obtained from PTR_ERR().
  */
 struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPES type,
-		uchar_t *name, u32 name_len)
+		ntfschar *name, u32 name_len)
 {
 	struct inode *vi;
 	ntfs_attr na;
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/inode.h	Fri May 14 16:03:21 2004
@@ -54,7 +54,7 @@
 	 * name_len = 4 for directories.
 	 */
 	ATTR_TYPES type;	/* Attribute type of this fake inode. */
-	uchar_t *name;		/* Attribute name of this fake inode. */
+	ntfschar *name;		/* Attribute name of this fake inode. */
 	u32 name_len;		/* Attribute name length of this fake inode. */
 	run_list run_list;	/* If state has the NI_NonResident bit set,
 				   the run list of the unnamed data attribute
@@ -248,7 +248,7 @@
  */
 typedef struct {
 	unsigned long mft_no;
-	uchar_t *name;
+	ntfschar *name;
 	u32 name_len;
 	ATTR_TYPES type;
 } ntfs_attr;
@@ -259,7 +259,7 @@

 extern struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no);
 extern struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPES type,
-		uchar_t *name, u32 name_len);
+		ntfschar *name, u32 name_len);

 extern struct inode *ntfs_alloc_big_inode(struct super_block *sb);
 extern void ntfs_destroy_big_inode(struct inode *inode);
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/layout.h	Fri May 14 16:03:21 2004
@@ -504,7 +504,7 @@
  */
 typedef struct {
 /*hex ofs*/
-/*  0*/	uchar_t name[0x40];		/* Unicode name of the attribute. Zero
+/*  0*/	ntfschar name[0x40];		/* Unicode name of the attribute. Zero
 					   terminated. */
 /* 80*/	ATTR_TYPES type;		/* Type of the attribute. */
 /* 84*/	u32 display_rule;		/* Default display rule.
@@ -910,7 +910,7 @@
 				   attribute value. */
 /* 24*/	u16 instance;		/* If lowest_vcn = 0, the instance of the
 				   attribute being referenced; otherwise 0. */
-/* 26*/	uchar_t name[0];	/* Use when creating only. When reading use
+/* 26*/	ntfschar name[0];	/* Use when creating only. When reading use
 				   name_offset to determine the location of the
 				   name. */
 /* sizeof() = 26 + (attribute_name_length * 2) bytes */
@@ -994,7 +994,7 @@
 /* 40*/	u8 file_name_length;			/* Length of file name in
 						   (Unicode) characters. */
 /* 41*/	FILE_NAME_TYPE_FLAGS file_name_type;	/* Namespace of the file name.*/
-/* 42*/	uchar_t file_name[0];			/* File name in Unicode. */
+/* 42*/	ntfschar file_name[0];			/* File name in Unicode. */
 } __attribute__ ((__packed__)) FILE_NAME_ATTR;

 /*
@@ -1775,7 +1775,7 @@
  * NOTE: Present only in FILE_Volume.
  */
 typedef struct {
-	uchar_t name[0];		/* The name of the volume in Unicode. */
+	ntfschar name[0];	/* The name of the volume in Unicode. */
 } __attribute__ ((__packed__)) VOLUME_NAME;

 /*
diff -Nru a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
--- a/fs/ntfs/logfile.c	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/logfile.c	Fri May 14 16:03:21 2004
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/buffer_head.h>
+#include <linux/bitops.h>

 #include "logfile.h"
 #include "volume.h"
@@ -455,7 +456,11 @@
 	else
 		log_page_size = PAGE_CACHE_SIZE;
 	log_page_mask = log_page_size - 1;
-	log_page_bits = ffs(log_page_size) - 1;
+	/*
+	 * Use generic_ffs() instead of ffs() to enable the compiler to
+	 * optimize log_page_size and log_page_bits into constants.
+	 */
+	log_page_bits = generic_ffs(log_page_size) - 1;
 	size &= ~(log_page_size - 1);
 	/*
 	 * Ensure the log file is big enough to store at least the two restart
diff -Nru a/fs/ntfs/logfile.h b/fs/ntfs/logfile.h
--- a/fs/ntfs/logfile.h	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/logfile.h	Fri May 14 16:03:21 2004
@@ -288,7 +288,7 @@
 /* 22*/	u8 reserved[6];		/* Reserved/alignment. */
 /* 28*/	u32 client_name_length; /* Length of client name in bytes.  Should
 				   always be 8. */
-/* 32*/	uchar_t client_name[64];/* Name of the client in Unicode.  Should
+/* 32*/	ntfschar client_name[64];/* Name of the client in Unicode.  Should
 				   always be "NTFS" with the remaining bytes
 				   set to 0. */
 /* sizeof() = 160 (0xa0) bytes */
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/namei.c	Fri May 14 16:03:21 2004
@@ -98,7 +98,7 @@
 {
 	ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
 	struct inode *dent_inode;
-	uchar_t *uname;
+	ntfschar *uname;
 	ntfs_name *name = NULL;
 	MFT_REF mref;
 	unsigned long dent_ino;
@@ -177,7 +177,7 @@
 	nls_name.name = NULL;
 	if (name->type != FILE_NAME_DOS) {			/* Case 2. */
 		nls_name.len = (unsigned)ntfs_ucstonls(vol,
-				(uchar_t*)&name->name, name->len,
+				(ntfschar*)&name->name, name->len,
 				(unsigned char**)&nls_name.name, 0);
 		kfree(name);
 	} else /* if (name->type == FILE_NAME_DOS) */ {		/* Case 3. */
@@ -221,14 +221,14 @@
 				goto eio_err_out;
 			fn = (FILE_NAME_ATTR*)((u8*)ctx->attr + le16_to_cpu(
 					ctx->attr->data.resident.value_offset));
-			if ((u32)(fn->file_name_length * sizeof(uchar_t) +
+			if ((u32)(fn->file_name_length * sizeof(ntfschar) +
 					sizeof(FILE_NAME_ATTR)) > val_len)
 				goto eio_err_out;
 		} while (fn->file_name_type != FILE_NAME_WIN32);

 		/* Convert the found WIN32 name to current NLS code page. */
 		nls_name.len = (unsigned)ntfs_ucstonls(vol,
-				(uchar_t*)&fn->file_name, fn->file_name_length,
+				(ntfschar*)&fn->file_name, fn->file_name_length,
 				(unsigned char**)&nls_name.name, 0);

 		put_attr_search_ctx(ctx);
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/ntfs.h	Fri May 14 16:03:21 2004
@@ -174,31 +174,31 @@
 extern void post_write_mst_fixup(NTFS_RECORD *b);

 /* From fs/ntfs/unistr.c */
-extern BOOL ntfs_are_names_equal(const uchar_t *s1, size_t s1_len,
-		const uchar_t *s2, size_t s2_len,
+extern BOOL ntfs_are_names_equal(const ntfschar *s1, size_t s1_len,
+		const ntfschar *s2, size_t s2_len,
 		const IGNORE_CASE_BOOL ic,
-		const uchar_t *upcase, const u32 upcase_size);
-extern int ntfs_collate_names(const uchar_t *name1, const u32 name1_len,
-		const uchar_t *name2, const u32 name2_len,
+		const ntfschar *upcase, const u32 upcase_size);
+extern int ntfs_collate_names(const ntfschar *name1, const u32 name1_len,
+		const ntfschar *name2, const u32 name2_len,
 		const int err_val, const IGNORE_CASE_BOOL ic,
-		const uchar_t *upcase, const u32 upcase_len);
-extern int ntfs_ucsncmp(const uchar_t *s1, const uchar_t *s2, size_t n);
-extern int ntfs_ucsncasecmp(const uchar_t *s1, const uchar_t *s2, size_t n,
-		const uchar_t *upcase, const u32 upcase_size);
-extern void ntfs_upcase_name(uchar_t *name, u32 name_len,
-		const uchar_t *upcase, const u32 upcase_len);
+		const ntfschar *upcase, const u32 upcase_len);
+extern int ntfs_ucsncmp(const ntfschar *s1, const ntfschar *s2, size_t n);
+extern int ntfs_ucsncasecmp(const ntfschar *s1, const ntfschar *s2, size_t n,
+		const ntfschar *upcase, const u32 upcase_size);
+extern void ntfs_upcase_name(ntfschar *name, u32 name_len,
+		const ntfschar *upcase, const u32 upcase_len);
 extern void ntfs_file_upcase_value(FILE_NAME_ATTR *file_name_attr,
-		const uchar_t *upcase, const u32 upcase_len);
+		const ntfschar *upcase, const u32 upcase_len);
 extern int ntfs_file_compare_values(FILE_NAME_ATTR *file_name_attr1,
 		FILE_NAME_ATTR *file_name_attr2,
 		const int err_val, const IGNORE_CASE_BOOL ic,
-		const uchar_t *upcase, const u32 upcase_len);
+		const ntfschar *upcase, const u32 upcase_len);
 extern int ntfs_nlstoucs(const ntfs_volume *vol, const char *ins,
-		const int ins_len, uchar_t **outs);
-extern int ntfs_ucstonls(const ntfs_volume *vol, const uchar_t *ins,
+		const int ins_len, ntfschar **outs);
+extern int ntfs_ucstonls(const ntfs_volume *vol, const ntfschar *ins,
 		const int ins_len, unsigned char **outs, int outs_len);

 /* From fs/ntfs/upcase.c */
-extern uchar_t *generate_default_upcase(void);
+extern ntfschar *generate_default_upcase(void);

 #endif /* _LINUX_NTFS_H */
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/super.c	Fri May 14 16:03:21 2004
@@ -944,12 +944,12 @@
 	}
 	/*
 	 * The upcase size must not be above 64k Unicode characters, must not
-	 * be zero and must be a multiple of sizeof(uchar_t).
+	 * be zero and must be a multiple of sizeof(ntfschar).
 	 */
-	if (!ino->i_size || ino->i_size & (sizeof(uchar_t) - 1) ||
-			ino->i_size > 64ULL * 1024 * sizeof(uchar_t))
+	if (!ino->i_size || ino->i_size & (sizeof(ntfschar) - 1) ||
+			ino->i_size > 64ULL * 1024 * sizeof(ntfschar))
 		goto iput_upcase_failed;
-	vol->upcase = (uchar_t*)ntfs_malloc_nofs(ino->i_size);
+	vol->upcase = (ntfschar*)ntfs_malloc_nofs(ino->i_size);
 	if (!vol->upcase)
 		goto iput_upcase_failed;
 	index = 0;
@@ -972,7 +972,7 @@
 	}
 	vol->upcase_len = ino->i_size >> UCHAR_T_SIZE_BITS;
 	ntfs_debug("Read %llu bytes from $UpCase (expected %u bytes).",
-			ino->i_size, 64 * 1024 * sizeof(uchar_t));
+			ino->i_size, 64 * 1024 * sizeof(ntfschar));
 	iput(ino);
 	down(&ntfs_lock);
 	if (!default_upcase) {
@@ -2059,7 +2059,7 @@
 	}

 	ntfs_name_cache = kmem_cache_create(ntfs_name_cache_name,
-			(NTFS_MAX_NAME_LEN+1) * sizeof(uchar_t), 0,
+			(NTFS_MAX_NAME_LEN+1) * sizeof(ntfschar), 0,
 			SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!ntfs_name_cache) {
 		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
diff -Nru a/fs/ntfs/types.h b/fs/ntfs/types.h
--- a/fs/ntfs/types.h	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/types.h	Fri May 14 16:03:21 2004
@@ -24,7 +24,7 @@
 #define _LINUX_NTFS_TYPES_H

 /* 2-byte Unicode character type. */
-typedef u16 uchar_t;
+typedef u16 ntfschar;
 #define UCHAR_T_SIZE_BITS 1

 /*
diff -Nru a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
--- a/fs/ntfs/unistr.c	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/unistr.c	Fri May 14 16:03:21 2004
@@ -61,9 +61,9 @@
  * identical, or FALSE (0) if they are not identical. If @ic is IGNORE_CASE,
  * the @upcase table is used to performa a case insensitive comparison.
  */
-BOOL ntfs_are_names_equal(const uchar_t *s1, size_t s1_len,
-		const uchar_t *s2, size_t s2_len, const IGNORE_CASE_BOOL ic,
-		const uchar_t *upcase, const u32 upcase_size)
+BOOL ntfs_are_names_equal(const ntfschar *s1, size_t s1_len,
+		const ntfschar *s2, size_t s2_len, const IGNORE_CASE_BOOL ic,
+		const ntfschar *upcase, const u32 upcase_size)
 {
 	if (s1_len != s2_len)
 		return FALSE;
@@ -90,13 +90,13 @@
  *
  * The following characters are considered invalid: '"', '*', '<', '>' and '?'.
  */
-int ntfs_collate_names(const uchar_t *name1, const u32 name1_len,
-		const uchar_t *name2, const u32 name2_len,
+int ntfs_collate_names(const ntfschar *name1, const u32 name1_len,
+		const ntfschar *name2, const u32 name2_len,
 		const int err_val, const IGNORE_CASE_BOOL ic,
-		const uchar_t *upcase, const u32 upcase_len)
+		const ntfschar *upcase, const u32 upcase_len)
 {
 	u32 cnt, min_len;
-	uchar_t c1, c2;
+	ntfschar c1, c2;

 	min_len = name1_len;
 	if (name1_len > name2_len)
@@ -142,9 +142,9 @@
  * if @s1 (or the first @n Unicode characters thereof) is found, respectively,
  * to be less than, to match, or be greater than @s2.
  */
-int ntfs_ucsncmp(const uchar_t *s1, const uchar_t *s2, size_t n)
+int ntfs_ucsncmp(const ntfschar *s1, const ntfschar *s2, size_t n)
 {
-	uchar_t c1, c2;
+	ntfschar c1, c2;
 	size_t i;

 	for (i = 0; i < n; ++i) {
@@ -178,10 +178,10 @@
  * if @s1 (or the first @n Unicode characters thereof) is found, respectively,
  * to be less than, to match, or be greater than @s2.
  */
-int ntfs_ucsncasecmp(const uchar_t *s1, const uchar_t *s2, size_t n,
-		const uchar_t *upcase, const u32 upcase_size)
+int ntfs_ucsncasecmp(const ntfschar *s1, const ntfschar *s2, size_t n,
+		const ntfschar *upcase, const u32 upcase_size)
 {
-	uchar_t c1, c2;
+	ntfschar c1, c2;
 	size_t i;

 	for (i = 0; i < n; ++i) {
@@ -199,11 +199,11 @@
 	return 0;
 }

-void ntfs_upcase_name(uchar_t *name, u32 name_len, const uchar_t *upcase,
+void ntfs_upcase_name(ntfschar *name, u32 name_len, const ntfschar *upcase,
 		const u32 upcase_len)
 {
 	u32 i;
-	uchar_t u;
+	ntfschar u;

 	for (i = 0; i < name_len; i++)
 		if ((u = le16_to_cpu(name[i])) < upcase_len)
@@ -211,20 +211,20 @@
 }

 void ntfs_file_upcase_value(FILE_NAME_ATTR *file_name_attr,
-		const uchar_t *upcase, const u32 upcase_len)
+		const ntfschar *upcase, const u32 upcase_len)
 {
-	ntfs_upcase_name((uchar_t*)&file_name_attr->file_name,
+	ntfs_upcase_name((ntfschar*)&file_name_attr->file_name,
 			file_name_attr->file_name_length, upcase, upcase_len);
 }

 int ntfs_file_compare_values(FILE_NAME_ATTR *file_name_attr1,
 		FILE_NAME_ATTR *file_name_attr2,
 		const int err_val, const IGNORE_CASE_BOOL ic,
-		const uchar_t *upcase, const u32 upcase_len)
+		const ntfschar *upcase, const u32 upcase_len)
 {
-	return ntfs_collate_names((uchar_t*)&file_name_attr1->file_name,
+	return ntfs_collate_names((ntfschar*)&file_name_attr1->file_name,
 			file_name_attr1->file_name_length,
-			(uchar_t*)&file_name_attr2->file_name,
+			(ntfschar*)&file_name_attr2->file_name,
 			file_name_attr2->file_name_length,
 			err_val, ic, upcase, upcase_len);
 }
@@ -253,16 +253,16 @@
  * This might look a bit odd due to fast path optimization...
  */
 int ntfs_nlstoucs(const ntfs_volume *vol, const char *ins,
-		const int ins_len, uchar_t **outs)
+		const int ins_len, ntfschar **outs)
 {
 	struct nls_table *nls = vol->nls_map;
-	uchar_t *ucs;
+	ntfschar *ucs;
 	wchar_t wc;
 	int i, o, wc_len;

 	/* We don't trust outside sources. */
 	if (ins) {
-		ucs = (uchar_t*)kmem_cache_alloc(ntfs_name_cache, SLAB_NOFS);
+		ucs = (ntfschar*)kmem_cache_alloc(ntfs_name_cache, SLAB_NOFS);
 		if (ucs) {
 			for (i = o = 0; i < ins_len; i += wc_len) {
 				wc_len = nls->char2uni(ins + i, ins_len - i,
@@ -318,7 +318,7 @@
  *
  * This might look a bit odd due to fast path optimization...
  */
-int ntfs_ucstonls(const ntfs_volume *vol, const uchar_t *ins,
+int ntfs_ucstonls(const ntfs_volume *vol, const ntfschar *ins,
 		const int ins_len, unsigned char **outs, int outs_len)
 {
 	struct nls_table *nls = vol->nls_map;
diff -Nru a/fs/ntfs/upcase.c b/fs/ntfs/upcase.c
--- a/fs/ntfs/upcase.c	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/upcase.c	Fri May 14 16:03:21 2004
@@ -26,7 +26,7 @@

 #include "ntfs.h"

-uchar_t *generate_default_upcase(void)
+ntfschar *generate_default_upcase(void)
 {
 	static const int uc_run_table[][3] = { /* Start, End, Add */
 	{0x0061, 0x007B,  -32}, {0x0451, 0x045D, -80}, {0x1F70, 0x1F72,  74},
@@ -68,12 +68,12 @@
 	};

 	int i, r;
-	uchar_t *uc;
+	ntfschar *uc;

-	uc = ntfs_malloc_nofs(default_upcase_len * sizeof(uchar_t));
+	uc = ntfs_malloc_nofs(default_upcase_len * sizeof(ntfschar));
 	if (!uc)
 		return uc;
-	memset(uc, 0, default_upcase_len * sizeof(uchar_t));
+	memset(uc, 0, default_upcase_len * sizeof(ntfschar));
 	for (i = 0; i < default_upcase_len; i++)
 		uc[i] = cpu_to_le16(i);
 	for (r = 0; uc_run_table[r][0]; r++)
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	Fri May 14 16:03:21 2004
+++ b/fs/ntfs/volume.h	Fri May 14 16:03:21 2004
@@ -72,7 +72,7 @@
 	u64 serial_no;			/* The volume serial number. */
 	/* Mount specific NTFS information. */
 	u32 upcase_len;			/* Number of entries in upcase[]. */
-	uchar_t *upcase;		/* The upcase table. */
+	ntfschar *upcase;		/* The upcase table. */
 	LCN mft_zone_start;		/* First cluster of the mft zone. */
 	LCN mft_zone_end;		/* First cluster beyond the mft zone. */
 	struct inode *mft_ino;		/* The VFS inode of $MFT. */


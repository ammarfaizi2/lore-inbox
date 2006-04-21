Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWDUQFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWDUQFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWDUQFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:05:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19365 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932378AbWDUQFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:05:40 -0400
Subject: [PATCH 05/16] GFS2: File and inode operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 21 Apr 2006 17:13:50 +0100
Message-Id: <1145636030.3856.102.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 05/16] GFS2: File and inode operations

File operations, superblock operations and inode operations
code for GFS2.

This also includes a new header file, iflags.h which is designed to
abstract the (originally ext2 only, but now used by many different fs)
get/set flags ioctl by having one central place in which to register
filesystem flags. Given favourable reviews, I'll submit some patches to
update the other fileststems to define their flags in terms of those
in iflags.h. Note that this doesn't change the interface of the other
filesystems since the values of the flags are identical to those
previously defined.

To the best of my knowledge, GFS2 is the only filesystem which requires
the addition of flags above and beyond those defined by ext2/3 so if
there are others and we've clashed with them, please let me know.



Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>


 fs/gfs2/ops_file.c     |  999 ++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/ops_file.h     |   20 
 fs/gfs2/ops_fstype.c   |  904 +++++++++++++++++++++++++++++++++++++
 fs/gfs2/ops_fstype.h   |   16 
 fs/gfs2/ops_inode.c    | 1196 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/ops_inode.h    |   18 
 include/linux/iflags.h |  104 ++++
 7 files changed, 3257 insertions(+)

--- /dev/null
+++ b/fs/gfs2/ops_file.c
@@ -0,0 +1,999 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/pagemap.h>
+#include <linux/uio.h>
+#include <linux/blkdev.h>
+#include <linux/mm.h>
+#include <linux/smp_lock.h>
+#include <linux/fs.h>
+#include <linux/gfs2_ondisk.h>
+#include <linux/ext2_fs.h>
+#include <linux/crc32.h>
+#include <linux/iflags.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "bmap.h"
+#include "dir.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "lm.h"
+#include "log.h"
+#include "meta_io.h"
+#include "ops_file.h"
+#include "ops_vm.h"
+#include "quota.h"
+#include "rgrp.h"
+#include "trans.h"
+#include "util.h"
+#include "eaops.h"
+
+/* "bad" is for NFS support */
+struct filldir_bad_entry {
+	char *fbe_name;
+	unsigned int fbe_length;
+	uint64_t fbe_offset;
+	struct gfs2_inum fbe_inum;
+	unsigned int fbe_type;
+};
+
+struct filldir_bad {
+	struct gfs2_sbd *fdb_sbd;
+
+	struct filldir_bad_entry *fdb_entry;
+	unsigned int fdb_entry_num;
+	unsigned int fdb_entry_off;
+
+	char *fdb_name;
+	unsigned int fdb_name_size;
+	unsigned int fdb_name_off;
+};
+
+/* For regular, non-NFS */
+struct filldir_reg {
+	struct gfs2_sbd *fdr_sbd;
+	int fdr_prefetch;
+
+	filldir_t fdr_filldir;
+	void *fdr_opaque;
+};
+
+/*
+ * Most fields left uninitialised to catch anybody who tries to
+ * use them. f_flags set to prevent file_accessed() from touching
+ * any other part of this. Its use is purely as a flag so that we
+ * know (in readpage()) whether or not do to locking.
+ */
+struct file gfs2_internal_file_sentinal = {
+	.f_flags = O_NOATIME|O_RDONLY,
+};
+
+static int gfs2_read_actor(read_descriptor_t *desc, struct page *page,
+			   unsigned long offset, unsigned long size)
+{
+	char *kaddr;
+	unsigned long count = desc->count;
+
+	if (size > count)
+		size = count;
+
+	kaddr = kmap(page);
+	memcpy(desc->arg.buf, kaddr + offset, size);
+        kunmap(page);
+
+        desc->count = count - size;
+        desc->written += size;
+        desc->arg.buf += size;
+        return size;
+}
+
+int gfs2_internal_read(struct gfs2_inode *ip, struct file_ra_state *ra_state,
+		       char *buf, loff_t *pos, unsigned size)
+{
+	struct inode *inode = ip->i_vnode;
+	read_descriptor_t desc;
+	desc.written = 0;
+	desc.arg.buf = buf;
+	desc.count = size;
+	desc.error = 0;
+	do_generic_mapping_read(inode->i_mapping, ra_state,
+				&gfs2_internal_file_sentinal, pos, &desc,
+				gfs2_read_actor);
+	return desc.written ? desc.written : desc.error;
+}
+
+/**
+ * gfs2_llseek - seek to a location in a file
+ * @file: the file
+ * @offset: the offset
+ * @origin: Where to seek from (SEEK_SET, SEEK_CUR, or SEEK_END)
+ *
+ * SEEK_END requires the glock for the file because it references the
+ * file's size.
+ *
+ * Returns: The new offset, or errno
+ */
+
+static loff_t gfs2_llseek(struct file *file, loff_t offset, int origin)
+{
+	struct gfs2_inode *ip = file->f_mapping->host->u.generic_ip;
+	struct gfs2_holder i_gh;
+	loff_t error;
+
+	if (origin == 2) {
+		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY,
+					   &i_gh);
+		if (!error) {
+			error = remote_llseek(file, offset, origin);
+			gfs2_glock_dq_uninit(&i_gh);
+		}
+	} else
+		error = remote_llseek(file, offset, origin);
+
+	return error;
+}
+
+
+static ssize_t gfs2_direct_IO_read(struct kiocb *iocb, const struct iovec *iov,
+				   loff_t offset, unsigned long nr_segs)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	ssize_t retval;
+
+	retval = filemap_write_and_wait(mapping);
+	if (retval == 0) {
+		retval = mapping->a_ops->direct_IO(READ, iocb, iov, offset,
+						   nr_segs);
+	}
+	return retval;
+}
+
+/**
+ * __gfs2_file_aio_read - The main GFS2 read function
+ * 
+ * N.B. This is almost, but not quite the same as __generic_file_aio_read()
+ * the important subtle different being that inode->i_size isn't valid
+ * unless we are holding a lock, and we do this _only_ on the O_DIRECT
+ * path since otherwise locking is done entirely at the page cache
+ * layer.
+ */
+static ssize_t __gfs2_file_aio_read(struct kiocb *iocb,
+				    const struct iovec *iov,
+				    unsigned long nr_segs, loff_t *ppos)
+{
+	struct file *filp = iocb->ki_filp;
+	struct gfs2_inode *ip = filp->f_mapping->host->u.generic_ip;
+	struct gfs2_holder gh;
+	ssize_t retval;
+	unsigned long seg;
+	size_t count;
+
+	count = 0;
+	for (seg = 0; seg < nr_segs; seg++) {
+		const struct iovec *iv = &iov[seg];
+
+		/*
+		 * If any segment has a negative length, or the cumulative
+		 * length ever wraps negative then return -EINVAL.
+		 */
+		count += iv->iov_len;
+		if (unlikely((ssize_t)(count|iv->iov_len) < 0))
+			return -EINVAL;
+		if (access_ok(VERIFY_WRITE, iv->iov_base, iv->iov_len))
+			continue;
+		if (seg == 0)
+			return -EFAULT;
+		nr_segs = seg;
+		count -= iv->iov_len;   /* This segment is no good */
+		break;
+	}
+
+	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
+	if (filp->f_flags & O_DIRECT) {
+		loff_t pos = *ppos, size;
+		struct address_space *mapping;
+		struct inode *inode;
+
+		mapping = filp->f_mapping;
+		inode = mapping->host;
+		retval = 0;
+		if (!count)
+			goto out; /* skip atime */
+
+		gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &gh);
+		retval = gfs2_glock_nq_m_atime(1, &gh);
+		if (retval)
+			goto out;
+		if (gfs2_is_stuffed(ip)) {
+			gfs2_glock_dq_m(1, &gh);
+			gfs2_holder_uninit(&gh);
+			goto fallback_to_normal;
+		}
+		size = i_size_read(inode);
+		if (pos < size) {
+			retval = gfs2_direct_IO_read(iocb, iov, pos, nr_segs);
+			if (retval > 0 && !is_sync_kiocb(iocb))
+				retval = -EIOCBQUEUED;
+			if (retval > 0)
+				*ppos = pos + retval;
+		}
+		file_accessed(filp);
+		gfs2_glock_dq_m(1, &gh);
+		gfs2_holder_uninit(&gh);
+		goto out;
+	}
+
+fallback_to_normal:
+	retval = 0;
+	if (count) {
+		for (seg = 0; seg < nr_segs; seg++) {
+			read_descriptor_t desc;
+
+			desc.written = 0;
+			desc.arg.buf = iov[seg].iov_base;
+			desc.count = iov[seg].iov_len;
+			if (desc.count == 0)
+				continue;
+			desc.error = 0;
+			do_generic_file_read(filp,ppos,&desc,file_read_actor);
+			retval += desc.written;
+			if (desc.error) {
+				retval = retval ?: desc.error;
+				 break;
+			}
+		}
+	}
+out:
+	return retval;
+}
+
+/**
+ * gfs2_read - Read bytes from a file
+ * @file: The file to read from
+ * @buf: The buffer to copy into
+ * @size: The amount of data requested
+ * @offset: The current file offset
+ *
+ * Outputs: Offset - updated according to number of bytes read
+ *
+ * Returns: The number of bytes read, errno on failure
+ */
+
+static ssize_t gfs2_read(struct file *filp, char __user *buf, size_t size,
+			 loff_t *offset)
+{
+	struct iovec local_iov = { .iov_base = buf, .iov_len = size };
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, filp);
+	ret = __gfs2_file_aio_read(&kiocb, &local_iov, 1, offset);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	return ret;
+}
+
+static ssize_t gfs2_file_readv(struct file *filp, const struct iovec *iov,
+			       unsigned long nr_segs, loff_t *ppos)
+{
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	init_sync_kiocb(&kiocb, filp);
+	ret = __gfs2_file_aio_read(&kiocb, iov, nr_segs, ppos);
+	if (-EIOCBQUEUED == ret)
+		ret = wait_on_sync_kiocb(&kiocb);
+	return ret;
+}
+
+static ssize_t gfs2_file_aio_read(struct kiocb *iocb, char __user *buf,
+				  size_t count, loff_t pos)
+{
+        struct iovec local_iov = { .iov_base = buf, .iov_len = count };
+
+        BUG_ON(iocb->ki_pos != pos);
+        return __gfs2_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
+}
+
+
+/**
+ * filldir_reg_func - Report a directory entry to the caller of gfs2_dir_read()
+ * @opaque: opaque data used by the function
+ * @name: the name of the directory entry
+ * @length: the length of the name
+ * @offset: the entry's offset in the directory
+ * @inum: the inode number the entry points to
+ * @type: the type of inode the entry points to
+ *
+ * Returns: 0 on success, 1 if buffer full
+ */
+
+static int filldir_reg_func(void *opaque, const char *name, unsigned int length,
+			    uint64_t offset, struct gfs2_inum *inum,
+			    unsigned int type)
+{
+	struct filldir_reg *fdr = (struct filldir_reg *)opaque;
+	struct gfs2_sbd *sdp = fdr->fdr_sbd;
+	int error;
+
+	error = fdr->fdr_filldir(fdr->fdr_opaque, name, length, offset,
+				 inum->no_formal_ino, type);
+	if (error)
+		return 1;
+
+	if (fdr->fdr_prefetch && !(length == 1 && *name == '.')) {
+		gfs2_glock_prefetch_num(sdp,
+				       inum->no_addr, &gfs2_inode_glops,
+				       LM_ST_SHARED, LM_FLAG_TRY | LM_FLAG_ANY);
+		gfs2_glock_prefetch_num(sdp,
+				       inum->no_addr, &gfs2_iopen_glops,
+				       LM_ST_SHARED, LM_FLAG_TRY);
+	}
+
+	return 0;
+}
+
+/**
+ * readdir_reg - Read directory entries from a directory
+ * @file: The directory to read from
+ * @dirent: Buffer for dirents
+ * @filldir: Function used to do the copying
+ *
+ * Returns: errno
+ */
+
+static int readdir_reg(struct file *file, void *dirent, filldir_t filldir)
+{
+	struct inode *dir = file->f_mapping->host;
+	struct gfs2_inode *dip = dir->u.generic_ip;
+	struct filldir_reg fdr;
+	struct gfs2_holder d_gh;
+	uint64_t offset = file->f_pos;
+	int error;
+
+	fdr.fdr_sbd = dip->i_sbd;
+	fdr.fdr_prefetch = 1;
+	fdr.fdr_filldir = filldir;
+	fdr.fdr_opaque = dirent;
+
+	gfs2_holder_init(dip->i_gl, LM_ST_SHARED, GL_ATIME, &d_gh);
+	error = gfs2_glock_nq_atime(&d_gh);
+	if (error) {
+		gfs2_holder_uninit(&d_gh);
+		return error;
+	}
+
+	error = gfs2_dir_read(dir, &offset, &fdr, filldir_reg_func);
+
+	gfs2_glock_dq_uninit(&d_gh);
+
+	file->f_pos = offset;
+
+	return error;
+}
+
+/**
+ * filldir_bad_func - Report a directory entry to the caller of gfs2_dir_read()
+ * @opaque: opaque data used by the function
+ * @name: the name of the directory entry
+ * @length: the length of the name
+ * @offset: the entry's offset in the directory
+ * @inum: the inode number the entry points to
+ * @type: the type of inode the entry points to
+ *
+ * For supporting NFS.
+ *
+ * Returns: 0 on success, 1 if buffer full
+ */
+
+static int filldir_bad_func(void *opaque, const char *name, unsigned int length,
+			    uint64_t offset, struct gfs2_inum *inum,
+			    unsigned int type)
+{
+	struct filldir_bad *fdb = (struct filldir_bad *)opaque;
+	struct gfs2_sbd *sdp = fdb->fdb_sbd;
+	struct filldir_bad_entry *fbe;
+
+	if (fdb->fdb_entry_off == fdb->fdb_entry_num ||
+	    fdb->fdb_name_off + length > fdb->fdb_name_size)
+		return 1;
+
+	fbe = &fdb->fdb_entry[fdb->fdb_entry_off];
+	fbe->fbe_name = fdb->fdb_name + fdb->fdb_name_off;
+	memcpy(fbe->fbe_name, name, length);
+	fbe->fbe_length = length;
+	fbe->fbe_offset = offset;
+	fbe->fbe_inum = *inum;
+	fbe->fbe_type = type;
+
+	fdb->fdb_entry_off++;
+	fdb->fdb_name_off += length;
+
+	if (!(length == 1 && *name == '.')) {
+		gfs2_glock_prefetch_num(sdp,
+				       inum->no_addr, &gfs2_inode_glops,
+				       LM_ST_SHARED, LM_FLAG_TRY | LM_FLAG_ANY);
+		gfs2_glock_prefetch_num(sdp,
+				       inum->no_addr, &gfs2_iopen_glops,
+				       LM_ST_SHARED, LM_FLAG_TRY);
+	}
+
+	return 0;
+}
+
+/**
+ * readdir_bad - Read directory entries from a directory
+ * @file: The directory to read from
+ * @dirent: Buffer for dirents
+ * @filldir: Function used to do the copying
+ *
+ * For supporting NFS.
+ *
+ * Returns: errno
+ */
+
+static int readdir_bad(struct file *file, void *dirent, filldir_t filldir)
+{
+	struct inode *dir = file->f_mapping->host;
+	struct gfs2_inode *dip = dir->u.generic_ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct filldir_reg fdr;
+	unsigned int entries, size;
+	struct filldir_bad *fdb;
+	struct gfs2_holder d_gh;
+	uint64_t offset = file->f_pos;
+	unsigned int x;
+	struct filldir_bad_entry *fbe;
+	int error;
+
+	entries = gfs2_tune_get(sdp, gt_entries_per_readdir);
+	size = sizeof(struct filldir_bad) +
+	    entries * (sizeof(struct filldir_bad_entry) + GFS2_FAST_NAME_SIZE);
+
+	fdb = kzalloc(size, GFP_KERNEL);
+	if (!fdb)
+		return -ENOMEM;
+
+	fdb->fdb_sbd = sdp;
+	fdb->fdb_entry = (struct filldir_bad_entry *)(fdb + 1);
+	fdb->fdb_entry_num = entries;
+	fdb->fdb_name = ((char *)fdb) + sizeof(struct filldir_bad) +
+		entries * sizeof(struct filldir_bad_entry);
+	fdb->fdb_name_size = entries * GFS2_FAST_NAME_SIZE;
+
+	gfs2_holder_init(dip->i_gl, LM_ST_SHARED, GL_ATIME, &d_gh);
+	error = gfs2_glock_nq_atime(&d_gh);
+	if (error) {
+		gfs2_holder_uninit(&d_gh);
+		goto out;
+	}
+
+	error = gfs2_dir_read(dir, &offset, fdb, filldir_bad_func);
+
+	gfs2_glock_dq_uninit(&d_gh);
+
+	fdr.fdr_sbd = sdp;
+	fdr.fdr_prefetch = 0;
+	fdr.fdr_filldir = filldir;
+	fdr.fdr_opaque = dirent;
+
+	for (x = 0; x < fdb->fdb_entry_off; x++) {
+		fbe = &fdb->fdb_entry[x];
+
+		error = filldir_reg_func(&fdr,
+					 fbe->fbe_name, fbe->fbe_length,
+					 fbe->fbe_offset,
+					 &fbe->fbe_inum, fbe->fbe_type);
+		if (error) {
+			file->f_pos = fbe->fbe_offset;
+			error = 0;
+			goto out;
+		}
+	}
+
+	file->f_pos = offset;
+
+ out:
+	kfree(fdb);
+
+	return error;
+}
+
+/**
+ * gfs2_readdir - Read directory entries from a directory
+ * @file: The directory to read from
+ * @dirent: Buffer for dirents
+ * @filldir: Function used to do the copying
+ *
+ * Returns: errno
+ */
+
+static int gfs2_readdir(struct file *file, void *dirent, filldir_t filldir)
+{
+	int error;
+
+	if (strcmp(current->comm, "nfsd") != 0)
+		error = readdir_reg(file, dirent, filldir);
+	else
+		error = readdir_bad(file, dirent, filldir);
+
+	return error;
+}
+
+static const u32 iflags_to_gfs2[32] = {
+	[iflag_Sync] = GFS2_DIF_SYNC,
+	[iflag_Immutable] = GFS2_DIF_IMMUTABLE,
+	[iflag_Append] = GFS2_DIF_APPENDONLY,
+	[iflag_NoAtime] = GFS2_DIF_NOATIME,
+	[iflag_Index] = GFS2_DIF_EXHASH,
+	[iflag_JournalData] = GFS2_DIF_JDATA,
+	[iflag_DirectIO] = GFS2_DIF_DIRECTIO,
+	[iflag_InheritDirectIO] = GFS2_DIF_INHERIT_DIRECTIO,
+	[iflag_InheritJdata] = GFS2_DIF_INHERIT_JDATA,
+};
+
+static const u32 gfs2_to_iflags[32] = {
+	[gfs2fl_Sync] = IFLAG_SYNC,
+	[gfs2fl_Immutable] = IFLAG_IMMUTABLE,
+	[gfs2fl_AppendOnly] = IFLAG_APPEND,
+	[gfs2fl_NoAtime] = IFLAG_NOATIME,
+	[gfs2fl_ExHash] = IFLAG_INDEX,
+	[gfs2fl_Jdata] = IFLAG_JOURNAL_DATA,
+	[gfs2fl_Directio] = IFLAG_DIRECTIO,
+	[gfs2fl_InheritDirectio] = IFLAG_INHERITDIRECTIO,
+	[gfs2fl_InheritJdata] = IFLAG_INHERITJDATA,
+};
+
+static int gfs2_get_flags(struct file *filp, u32 __user *ptr)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_holder gh;
+	int error;
+	u32 iflags;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &gh);
+	error = gfs2_glock_nq_m_atime(1, &gh);
+	if (error)
+		return error;
+	
+	iflags = iflags_cvt(gfs2_to_iflags, ip->i_di.di_flags);
+	if (put_user(iflags, ptr))
+		error = -EFAULT;
+
+	gfs2_glock_dq_m(1, &gh);
+	gfs2_holder_uninit(&gh);
+	return error;
+}
+
+/* Flags that can be set by user space */
+#define GFS2_FLAGS_USER_SET (GFS2_DIF_JDATA|			\
+			     GFS2_DIF_DIRECTIO|			\
+			     GFS2_DIF_IMMUTABLE|		\
+			     GFS2_DIF_APPENDONLY|		\
+			     GFS2_DIF_NOATIME|			\
+			     GFS2_DIF_SYNC|			\
+			     GFS2_DIF_SYSTEM|			\
+			     GFS2_DIF_INHERIT_DIRECTIO|		\
+			     GFS2_DIF_INHERIT_JDATA)
+
+/**
+ * gfs2_set_flags - set flags on an inode
+ * @inode: The inode
+ * @flags: The flags to set
+ * @mask: Indicates which flags are valid
+ *
+ */
+static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct buffer_head *bh;
+	struct gfs2_holder gh;
+	int error;
+	u32 new_flags, flags;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
+	if (error)
+		return error;
+
+	flags = ip->i_di.di_flags;
+	new_flags = (flags & ~mask) | (reqflags & mask);
+	if ((new_flags ^ flags) == 0)
+		goto out;
+
+	error = -EINVAL;
+	if ((new_flags ^ flags) & ~GFS2_FLAGS_USER_SET)
+		goto out;
+
+	if (S_ISDIR(inode->i_mode)) {
+		if ((new_flags ^ flags) & (GFS2_DIF_JDATA | GFS2_DIF_DIRECTIO))
+			goto out;
+	} else if (S_ISREG(inode->i_mode)) {
+		if ((new_flags ^ flags) & (GFS2_DIF_INHERIT_DIRECTIO|
+					   GFS2_DIF_INHERIT_JDATA))
+			goto out;
+	} else
+		goto out;
+
+	error = -EPERM;
+	if (IS_IMMUTABLE(inode) && (new_flags & GFS2_DIF_IMMUTABLE))
+		goto out;
+	if (IS_APPEND(inode) && (new_flags & GFS2_DIF_APPENDONLY))
+		goto out;
+	error = gfs2_repermission(inode, MAY_WRITE, NULL);
+	if (error)
+		goto out;
+
+	error = gfs2_trans_begin(sdp, RES_DINODE, 0);
+	if (error)
+		goto out;
+	error = gfs2_meta_inode_buffer(ip, &bh);
+	if (error)
+		goto out_trans_end;
+	gfs2_trans_add_bh(ip->i_gl, bh, 1);
+	ip->i_di.di_flags = new_flags;
+	gfs2_dinode_out(&ip->i_di, bh->b_data);
+	brelse(bh);
+out_trans_end:
+	gfs2_trans_end(sdp);
+out:
+	gfs2_glock_dq_uninit(&gh);
+	return error;
+}
+
+static int gfs2_set_flags(struct file *filp, u32 __user *ptr)
+{
+	u32 iflags, gfsflags;
+	if (get_user(iflags, ptr))
+		return -EFAULT;
+	gfsflags = iflags_cvt(iflags_to_gfs2, iflags);
+	return do_gfs2_set_flags(filp, gfsflags, ~0);
+}
+
+static long gfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch(cmd) {
+	case IFLAGS_GET_IOC:
+		return gfs2_get_flags(filp, (u32 __user *)arg);
+	case IFLAGS_SET_IOC:
+		return gfs2_set_flags(filp, (u32 __user *)arg);
+	}
+	return -ENOTTY;
+}
+
+
+/**
+ * gfs2_mmap -
+ * @file: The file to map
+ * @vma: The VMA which described the mapping
+ *
+ * Returns: 0 or error code
+ */
+
+static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct gfs2_inode *ip = file->f_mapping->host->u.generic_ip;
+	struct gfs2_holder i_gh;
+	int error;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &i_gh);
+	error = gfs2_glock_nq_atime(&i_gh);
+	if (error) {
+		gfs2_holder_uninit(&i_gh);
+		return error;
+	}
+
+	/* This is VM_MAYWRITE instead of VM_WRITE because a call
+	   to mprotect() can turn on VM_WRITE later. */
+
+	if ((vma->vm_flags & (VM_MAYSHARE | VM_MAYWRITE)) ==
+	    (VM_MAYSHARE | VM_MAYWRITE))
+		vma->vm_ops = &gfs2_vm_ops_sharewrite;
+	else
+		vma->vm_ops = &gfs2_vm_ops_private;
+
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return error;
+}
+
+/**
+ * gfs2_open - open a file
+ * @inode: the inode to open
+ * @file: the struct file for this opening
+ *
+ * Returns: errno
+ */
+
+static int gfs2_open(struct inode *inode, struct file *file)
+{
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_holder i_gh;
+	struct gfs2_file *fp;
+	int error;
+
+	fp = kzalloc(sizeof(struct gfs2_file), GFP_KERNEL);
+	if (!fp)
+		return -ENOMEM;
+
+	mutex_init(&fp->f_fl_mutex);
+
+	gfs2_assert_warn(ip->i_sbd, !file->private_data);
+	file->private_data = fp;
+
+	if (S_ISREG(ip->i_di.di_mode)) {
+		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY,
+					   &i_gh);
+		if (error)
+			goto fail;
+
+		if (!(file->f_flags & O_LARGEFILE) &&
+		    ip->i_di.di_size > MAX_NON_LFS) {
+			error = -EFBIG;
+			goto fail_gunlock;
+		}
+
+		/* Listen to the Direct I/O flag */
+
+		if (ip->i_di.di_flags & GFS2_DIF_DIRECTIO)
+			file->f_flags |= O_DIRECT;
+
+		gfs2_glock_dq_uninit(&i_gh);
+	}
+
+	return 0;
+
+ fail_gunlock:
+	gfs2_glock_dq_uninit(&i_gh);
+
+ fail:
+	file->private_data = NULL;
+	kfree(fp);
+
+	return error;
+}
+
+/**
+ * gfs2_close - called to close a struct file
+ * @inode: the inode the struct file belongs to
+ * @file: the struct file being closed
+ *
+ * Returns: errno
+ */
+
+static int gfs2_close(struct inode *inode, struct file *file)
+{
+	struct gfs2_sbd *sdp = inode->i_sb->s_fs_info;
+	struct gfs2_file *fp;
+
+	fp = file->private_data;
+	file->private_data = NULL;
+
+	if (gfs2_assert_warn(sdp, fp))
+		return -EIO;
+
+	kfree(fp);
+
+	return 0;
+}
+
+/**
+ * gfs2_fsync - sync the dirty data for a file (across the cluster)
+ * @file: the file that points to the dentry (we ignore this)
+ * @dentry: the dentry that points to the inode to sync
+ *
+ * Returns: errno
+ */
+
+static int gfs2_fsync(struct file *file, struct dentry *dentry, int datasync)
+{
+	struct gfs2_inode *ip = dentry->d_inode->u.generic_ip;
+
+	gfs2_log_flush(ip->i_gl->gl_sbd, ip->i_gl);
+
+	return 0;
+}
+
+/**
+ * gfs2_lock - acquire/release a posix lock on a file
+ * @file: the file pointer
+ * @cmd: either modify or retrieve lock state, possibly wait
+ * @fl: type and range of lock
+ *
+ * Returns: errno
+ */
+
+static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct gfs2_inode *ip = file->f_mapping->host->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct lm_lockname name =
+		{ .ln_number = ip->i_num.no_addr,
+		  .ln_type = LM_TYPE_PLOCK };
+
+	if (!(fl->fl_flags & FL_POSIX))
+		return -ENOLCK;
+	if ((ip->i_di.di_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
+		return -ENOLCK;
+
+	if (sdp->sd_args.ar_localflocks) {
+		if (IS_GETLK(cmd)) {
+			struct file_lock tmp;
+			int ret;
+			ret = posix_test_lock(file, fl, &tmp);
+			fl->fl_type = F_UNLCK;
+			if (ret)
+				memcpy(fl, &tmp, sizeof(struct file_lock));
+			return 0;
+		} else {
+			return posix_lock_file_wait(file, fl);
+		}
+	}
+
+	if (IS_GETLK(cmd))
+		return gfs2_lm_plock_get(sdp, &name, file, fl);
+	else if (fl->fl_type == F_UNLCK)
+		return gfs2_lm_punlock(sdp, &name, file, fl);
+	else
+		return gfs2_lm_plock(sdp, &name, file, cmd, fl);
+}
+
+/**
+ * gfs2_sendfile - Send bytes to a file or socket
+ * @in_file: The file to read from
+ * @out_file: The file to write to
+ * @count: The amount of data
+ * @offset: The beginning file offset
+ *
+ * Outputs: offset - updated according to number of bytes read
+ *
+ * Returns: The number of bytes sent, errno on failure
+ */
+
+static ssize_t gfs2_sendfile(struct file *in_file, loff_t *offset, size_t count,
+			     read_actor_t actor, void *target)
+{
+	return generic_file_sendfile(in_file, offset, count, actor, target);
+}
+
+static int do_flock(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct gfs2_file *fp = file->private_data;
+	struct gfs2_holder *fl_gh = &fp->f_fl_gh;
+	struct gfs2_inode *ip = file->f_dentry->d_inode->u.generic_ip;
+	struct gfs2_glock *gl;
+	unsigned int state;
+	int flags;
+	int error = 0;
+
+	state = (fl->fl_type == F_WRLCK) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
+	flags = ((IS_SETLKW(cmd)) ? 0 : LM_FLAG_TRY) | GL_EXACT | GL_NOCACHE;
+
+	mutex_lock(&fp->f_fl_mutex);
+
+	gl = fl_gh->gh_gl;
+	if (gl) {
+		if (fl_gh->gh_state == state)
+			goto out;
+		gfs2_glock_hold(gl);
+		flock_lock_file_wait(file,
+				     &(struct file_lock){.fl_type = F_UNLCK});		
+		gfs2_glock_dq_uninit(fl_gh);
+	} else {
+		error = gfs2_glock_get(ip->i_sbd,
+				      ip->i_num.no_addr, &gfs2_flock_glops,
+				      CREATE, &gl);
+		if (error)
+			goto out;
+	}
+
+	gfs2_holder_init(gl, state, flags, fl_gh);
+	gfs2_glock_put(gl);
+
+	error = gfs2_glock_nq(fl_gh);
+	if (error) {
+		gfs2_holder_uninit(fl_gh);
+		if (error == GLR_TRYFAILED)
+			error = -EAGAIN;
+	} else {
+		error = flock_lock_file_wait(file, fl);
+		gfs2_assert_warn(ip->i_sbd, !error);
+	}
+
+ out:
+	mutex_unlock(&fp->f_fl_mutex);
+
+	return error;
+}
+
+static void do_unflock(struct file *file, struct file_lock *fl)
+{
+	struct gfs2_file *fp = file->private_data;
+	struct gfs2_holder *fl_gh = &fp->f_fl_gh;
+
+	mutex_lock(&fp->f_fl_mutex);
+	flock_lock_file_wait(file, fl);
+	if (fl_gh->gh_gl)
+		gfs2_glock_dq_uninit(fl_gh);
+	mutex_unlock(&fp->f_fl_mutex);
+}
+
+/**
+ * gfs2_flock - acquire/release a flock lock on a file
+ * @file: the file pointer
+ * @cmd: either modify or retrieve lock state, possibly wait
+ * @fl: type and range of lock
+ *
+ * Returns: errno
+ */
+
+static int gfs2_flock(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct gfs2_inode *ip = file->f_mapping->host->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+
+	if (!(fl->fl_flags & FL_FLOCK))
+		return -ENOLCK;
+	if ((ip->i_di.di_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
+		return -ENOLCK;
+
+	if (sdp->sd_args.ar_localflocks)
+		return flock_lock_file_wait(file, fl);
+
+	if (fl->fl_type == F_UNLCK) {
+		do_unflock(file, fl);
+		return 0;
+	} else
+		return do_flock(file, cmd, fl);
+}
+
+struct file_operations gfs2_file_fops = {
+	.llseek = gfs2_llseek,
+	.read = gfs2_read,
+	.readv = gfs2_file_readv,
+	.aio_read = gfs2_file_aio_read,
+	.write = generic_file_write,
+	.writev = generic_file_writev,
+	.aio_write = generic_file_aio_write,
+	.unlocked_ioctl = gfs2_ioctl,
+	.mmap = gfs2_mmap,
+	.open = gfs2_open,
+	.release = gfs2_close,
+	.fsync = gfs2_fsync,
+	.lock = gfs2_lock,
+	.sendfile = gfs2_sendfile,
+	.flock = gfs2_flock,
+	.splice_read = generic_file_splice_read,
+	.splice_write = generic_file_splice_write,
+};
+
+struct file_operations gfs2_dir_fops = {
+	.readdir = gfs2_readdir,
+	.unlocked_ioctl = gfs2_ioctl,
+	.open = gfs2_open,
+	.release = gfs2_close,
+	.fsync = gfs2_fsync,
+	.lock = gfs2_lock,
+	.flock = gfs2_flock,
+};
+
--- /dev/null
+++ b/include/linux/iflags.h
@@ -0,0 +1,104 @@
+#ifndef _LINUX_IFLAGS_H
+#define _LINUX_IFLAGS_H
+
+/*
+ * A universal set of inode flags.
+ *
+ * Originally taken from ext2/3 with additions for other filesystems.
+ * Filesystems supporting this interface should interoperate with
+ * the lsattr and chattr command line tools.
+ *
+ * This interface is supported in whole or in part by:
+ * ext2
+ * ext3
+ * xfs
+ * jfs
+ * gfs2
+ *
+ */
+
+#define IFLAGS_GET_IOC		_IOR('f', 1, long)
+#define IFLAGS_SET_IOC		_IOW('f', 2, long)
+
+/*
+ * These values are provided for use as indices of an array
+ * for use with the iflags_cvt function below
+ */
+enum {
+	iflag_SecureRm		= 0,	/* Secure deletion */
+	iflag_Unrm		= 1,	/* Undelete */
+	iflag_Compress		= 2,	/* Compress file */
+	iflag_Sync		= 3,	/* Synchronous updates */
+	iflag_Immutable	= 4,	/* Immutable */
+	iflag_Append		= 5,	/* Append */
+	iflag_NoDump		= 6,	/* Don't dump file */
+	iflag_NoAtime		= 7,	/* No atime updates */
+	/* Reserved for compression usage */
+	iflag_Dirty		= 8,
+	iflag_ComprBlk		= 9,	/* One or more compressed clusters */
+	iflag_NoComp		= 10,	/* Don't compress */
+	iflag_Ecompr		= 11,	/* Compression error */
+	/* End of compression flags */
+	iflag_Btree		= 12,	/* btree format dir */
+	iflag_Index		= 12,	/* hash-indexed directory */
+	iflag_Imagic		= 13,	/* AFS directory */
+	iflag_JournalData	= 14,	/* file data should be journaled */
+	iflag_NoTail		= 15,	/* file tail should not be merged */
+	iflag_DirSync		= 16,	/* dirsync behaviour */
+	iflag_TopDir		= 17,	/* Top of directory hierarchies */
+	iflag_DirectIO		= 18,	/* Always use direct I/O on this file */
+	iflag_InheritDirectIO	= 19,	/* Set DirectIO on new files in dir */
+	iflag_InheritJdata	= 20,	/* Set JournalData on create in dir */
+	iflag_Reserved		= 31	/* reserved for ext2/3 lib */
+};
+
+#define __IFL(x) (1<<(iflag_##x))
+#define IFLAG_SECRM		__IFL(SecureRm)		/* 0x00000001 */
+#define IFLAG_UNRM		__IFL(Unrm)		/* 0x00000002 */
+#define IFLAG_COMPR		__IFL(Compr)		/* 0x00000004 */
+#define IFLAG_SYNC		__IFL(Sync)		/* 0x00000008 */
+#define IFLAG_IMMUTABLE		__IFL(Immutable)	/* 0x00000010 */
+#define IFLAG_APPEND		__IFL(Append)		/* 0x00000020 */
+#define IFLAG_NODUMP		__IFL(NoDump)		/* 0x00000040 */
+#define IFLAG_NOATIME		__IFL(NoAtime)		/* 0x00000080 */
+#define IFLAG_DIRTY		__IFL(Dirty)		/* 0x00000100 */
+#define IFLAG_COMPRBLK		__IFL(ComprBlk)		/* 0x00000200 */
+#define IFLAG_NOCOMP		__IFL(NoComp)		/* 0x00000400 */
+#define IFLAG_ECOMPR		__IFL(Ecompr)		/* 0x00000800 */
+#define IFLAG_BTREE		__IFL(Btree)		/* 0x00001000 */
+#define IFLAG_INDEX		__IFL(Index)		/* 0x00001000 */
+#define IFLAG_IMAGIC		__IFL(Imagic)		/* 0x00002000 */
+#define IFLAG_JOURNAL_DATA	__IFL(JournalData)	/* 0x00004000 */
+#define IFLAG_NOTAIL		__IFL(NoTail)		/* 0x00008000 */
+#define IFLAG_DIRSYNC		__IFL(DirSync)		/* 0x00010000 */
+#define IFLAG_TOPDIR		__IFL(TopDir)		/* 0x00020000 */
+#define IFLAG_DIRECTIO		__IFL(DirectIO)		/* 0x00040000 */
+#define IFLAG_INHERITDIRECTIO	__IFL(InheritDirectIO)	/* 0x00080000 */
+#define IFLAG_INHERITJDATA	__IFL(InheritJdata)	/* 0x00100000 */
+#define IFLAG_RESERVED		__IFL(Reserved)		/* 0x80000000 */
+
+#ifdef __KERNEL__
+/**
+ * iflags_cvt
+ * @table: A table of 32 u32 flags
+ * @val: a 32 bit value to convert
+ *
+ * This function can be used to convert between IFLAGS values and
+ * the filesystem's own flags values.
+ *
+ * Returns: the converted flags
+ */
+static inline u32 iflags_cvt(const u32 *table, u32 val)
+{
+	u32 res = 0;
+	while(val) {
+		if (val & 1)
+			res |= *table;
+		table++;
+		val >>= 1;
+	}
+	return res;
+}
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_IFLAGS_H */
--- /dev/null
+++ b/fs/gfs2/ops_file.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_FILE_DOT_H__
+#define __OPS_FILE_DOT_H__
+extern struct file gfs2_internal_file_sentinal;
+extern int gfs2_internal_read(struct gfs2_inode *ip,
+			      struct file_ra_state *ra_state,
+			      char *buf, loff_t *pos, unsigned size);
+
+extern struct file_operations gfs2_file_fops;
+extern struct file_operations gfs2_dir_fops;
+
+#endif /* __OPS_FILE_DOT_H__ */
--- /dev/null
+++ b/fs/gfs2/ops_fstype.c
@@ -0,0 +1,904 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/vmalloc.h>
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/gfs2_ondisk.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "daemon.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "lm.h"
+#include "mount.h"
+#include "ops_export.h"
+#include "ops_fstype.h"
+#include "ops_super.h"
+#include "recovery.h"
+#include "rgrp.h"
+#include "super.h"
+#include "unlinked.h"
+#include "sys.h"
+#include "util.h"
+
+#define DO 0
+#define UNDO 1
+
+static struct gfs2_sbd *init_sbd(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp;
+	unsigned int x;
+
+	sdp = vmalloc(sizeof(struct gfs2_sbd));
+	if (!sdp)
+		return NULL;
+
+	memset(sdp, 0, sizeof(struct gfs2_sbd));
+
+	sb->s_fs_info = sdp;
+	sdp->sd_vfs = sb;
+
+	gfs2_tune_init(&sdp->sd_tune);
+
+	for (x = 0; x < GFS2_GL_HASH_SIZE; x++) {
+		sdp->sd_gl_hash[x].hb_lock = RW_LOCK_UNLOCKED;
+		INIT_LIST_HEAD(&sdp->sd_gl_hash[x].hb_list);
+	}
+	INIT_LIST_HEAD(&sdp->sd_reclaim_list);
+	spin_lock_init(&sdp->sd_reclaim_lock);
+	init_waitqueue_head(&sdp->sd_reclaim_wq);
+	mutex_init(&sdp->sd_invalidate_inodes_mutex);
+
+	mutex_init(&sdp->sd_inum_mutex);
+	spin_lock_init(&sdp->sd_statfs_spin);
+	mutex_init(&sdp->sd_statfs_mutex);
+
+	spin_lock_init(&sdp->sd_rindex_spin);
+	mutex_init(&sdp->sd_rindex_mutex);
+	INIT_LIST_HEAD(&sdp->sd_rindex_list);
+	INIT_LIST_HEAD(&sdp->sd_rindex_mru_list);
+	INIT_LIST_HEAD(&sdp->sd_rindex_recent_list);
+
+	INIT_LIST_HEAD(&sdp->sd_jindex_list);
+	spin_lock_init(&sdp->sd_jindex_spin);
+	mutex_init(&sdp->sd_jindex_mutex);
+
+	INIT_LIST_HEAD(&sdp->sd_unlinked_list);
+	spin_lock_init(&sdp->sd_unlinked_spin);
+	mutex_init(&sdp->sd_unlinked_mutex);
+
+	INIT_LIST_HEAD(&sdp->sd_quota_list);
+	spin_lock_init(&sdp->sd_quota_spin);
+	mutex_init(&sdp->sd_quota_mutex);
+
+	spin_lock_init(&sdp->sd_log_lock);
+
+	INIT_LIST_HEAD(&sdp->sd_log_le_gl);
+	INIT_LIST_HEAD(&sdp->sd_log_le_buf);
+	INIT_LIST_HEAD(&sdp->sd_log_le_revoke);
+	INIT_LIST_HEAD(&sdp->sd_log_le_rg);
+	INIT_LIST_HEAD(&sdp->sd_log_le_databuf);
+
+	mutex_init(&sdp->sd_log_reserve_mutex);
+	INIT_LIST_HEAD(&sdp->sd_ail1_list);
+	INIT_LIST_HEAD(&sdp->sd_ail2_list);
+
+	init_rwsem(&sdp->sd_log_flush_lock);
+	INIT_LIST_HEAD(&sdp->sd_log_flush_list);
+
+	INIT_LIST_HEAD(&sdp->sd_revoke_list);
+
+	mutex_init(&sdp->sd_freeze_lock);
+
+	return sdp;
+}
+
+static void init_vfs(struct super_block *sb, unsigned noatime)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+
+	sb->s_magic = GFS2_MAGIC;
+	sb->s_op = &gfs2_super_ops;
+	sb->s_export_op = &gfs2_export_ops;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+
+	if (sb->s_flags & (MS_NOATIME | MS_NODIRATIME))
+		set_bit(noatime, &sdp->sd_flags);
+
+	/* Don't let the VFS update atimes.  GFS2 handles this itself. */
+	sb->s_flags |= MS_NOATIME | MS_NODIRATIME;
+}
+
+static int init_names(struct gfs2_sbd *sdp, int silent)
+{
+	struct gfs2_sb *sb = NULL;
+	char *proto, *table;
+	int error = 0;
+
+	proto = sdp->sd_args.ar_lockproto;
+	table = sdp->sd_args.ar_locktable;
+
+	/*  Try to autodetect  */
+
+	if (!proto[0] || !table[0]) {
+		struct buffer_head *bh;
+		bh = sb_getblk(sdp->sd_vfs,
+			       GFS2_SB_ADDR >> sdp->sd_fsb2bb_shift);
+		lock_buffer(bh);
+		clear_buffer_uptodate(bh);
+		clear_buffer_dirty(bh);
+		unlock_buffer(bh);
+		ll_rw_block(READ, 1, &bh);
+		wait_on_buffer(bh);
+
+		if (!buffer_uptodate(bh)) {
+			brelse(bh);
+			return -EIO;
+		}
+
+		sb = kmalloc(sizeof(struct gfs2_sb), GFP_KERNEL);
+		if (!sb) {
+			brelse(bh);
+			return -ENOMEM;
+		}
+		gfs2_sb_in(sb, bh->b_data); 
+		brelse(bh);
+
+		error = gfs2_check_sb(sdp, sb, silent);
+		if (error)
+			goto out;
+
+		if (!proto[0])
+			proto = sb->sb_lockproto;
+		if (!table[0])
+			table = sb->sb_locktable;
+	}
+
+	if (!table[0])
+		table = sdp->sd_vfs->s_id;
+
+	snprintf(sdp->sd_proto_name, GFS2_FSNAME_LEN, "%s", proto);
+	snprintf(sdp->sd_table_name, GFS2_FSNAME_LEN, "%s", table);
+
+ out:
+	kfree(sb);
+
+	return error;
+}
+
+static int init_locking(struct gfs2_sbd *sdp, struct gfs2_holder *mount_gh,
+			int undo)
+{
+	struct task_struct *p;
+	int error = 0;
+
+	if (undo)
+		goto fail_trans;
+
+	p = kthread_run(gfs2_scand, sdp, "gfs2_scand");
+	error = IS_ERR(p);
+	if (error) {
+		fs_err(sdp, "can't start scand thread: %d\n", error);
+		return error;
+	}
+	sdp->sd_scand_process = p;
+
+	for (sdp->sd_glockd_num = 0;
+	     sdp->sd_glockd_num < sdp->sd_args.ar_num_glockd;
+	     sdp->sd_glockd_num++) {
+		p = kthread_run(gfs2_glockd, sdp, "gfs2_glockd");
+		error = IS_ERR(p);
+		if (error) {
+			fs_err(sdp, "can't start glockd thread: %d\n", error);
+			goto fail;
+		}
+		sdp->sd_glockd_process[sdp->sd_glockd_num] = p;
+	}
+
+	error = gfs2_glock_nq_num(sdp,
+				  GFS2_MOUNT_LOCK, &gfs2_nondisk_glops,
+				  LM_ST_EXCLUSIVE, LM_FLAG_NOEXP | GL_NOCACHE,
+				  mount_gh);
+	if (error) {
+		fs_err(sdp, "can't acquire mount glock: %d\n", error);
+		goto fail;
+	}
+
+	error = gfs2_glock_nq_num(sdp,
+				  GFS2_LIVE_LOCK, &gfs2_nondisk_glops,
+				  LM_ST_SHARED,
+				  LM_FLAG_NOEXP | GL_EXACT | GL_NEVER_RECURSE,
+				  &sdp->sd_live_gh);
+	if (error) {
+		fs_err(sdp, "can't acquire live glock: %d\n", error);
+		goto fail_mount;
+	}
+
+	error = gfs2_glock_get(sdp, GFS2_RENAME_LOCK, &gfs2_nondisk_glops,
+			       CREATE, &sdp->sd_rename_gl);
+	if (error) {
+		fs_err(sdp, "can't create rename glock: %d\n", error);
+		goto fail_live;
+	}
+
+	error = gfs2_glock_get(sdp, GFS2_TRANS_LOCK, &gfs2_trans_glops,
+			       CREATE, &sdp->sd_trans_gl);
+	if (error) {
+		fs_err(sdp, "can't create transaction glock: %d\n", error);
+		goto fail_rename;
+	}
+	set_bit(GLF_STICKY, &sdp->sd_trans_gl->gl_flags);
+
+	return 0;
+
+ fail_trans:
+	gfs2_glock_put(sdp->sd_trans_gl);
+
+ fail_rename:
+	gfs2_glock_put(sdp->sd_rename_gl);
+
+ fail_live:
+	gfs2_glock_dq_uninit(&sdp->sd_live_gh);
+
+ fail_mount:
+	gfs2_glock_dq_uninit(mount_gh);
+
+ fail:
+	while (sdp->sd_glockd_num--)
+		kthread_stop(sdp->sd_glockd_process[sdp->sd_glockd_num]);
+
+	kthread_stop(sdp->sd_scand_process);
+
+	return error;
+}
+
+static struct inode *gfs2_lookup_root(struct gfs2_sbd *sdp,
+				      const struct gfs2_inum *inum)
+{
+        int error;
+	struct gfs2_glock *gl;
+	struct gfs2_inode *ip;
+	struct inode *inode;
+
+	error = gfs2_glock_get(sdp, inum->no_addr, &gfs2_inode_glops,
+			       CREATE, &gl);
+        if (!error) {
+               	error = gfs2_inode_get(gl, inum, CREATE, &ip);
+		if (!error) {
+			gfs2_inode_min_init(ip, DT_DIR);
+			inode = gfs2_ip2v(ip);
+			gfs2_inode_put(ip);
+			gfs2_glock_put(gl);
+			return inode;
+		}
+                gfs2_glock_put(gl);
+        }
+        return ERR_PTR(error);
+}
+
+static int init_sb(struct gfs2_sbd *sdp, int silent, int undo)
+{
+	struct super_block *sb = sdp->sd_vfs;
+	struct gfs2_holder sb_gh;
+	struct gfs2_inum *inum;
+	struct inode *inode;
+	int error = 0;
+
+	if (undo) {
+		return 0;
+	}
+	
+	error = gfs2_glock_nq_num(sdp,
+				 GFS2_SB_LOCK, &gfs2_meta_glops,
+				 LM_ST_SHARED, 0, &sb_gh);
+	if (error) {
+		fs_err(sdp, "can't acquire superblock glock: %d\n", error);
+		return error;
+	}
+
+	error = gfs2_read_sb(sdp, sb_gh.gh_gl, silent);
+	if (error) {
+		fs_err(sdp, "can't read superblock: %d\n", error);
+		goto out;
+	}
+
+	/* Set up the buffer cache and SB for real */
+	if (sdp->sd_sb.sb_bsize < bdev_hardsect_size(sb->s_bdev)) {
+		error = -EINVAL;
+		fs_err(sdp, "FS block size (%u) is too small for device "
+		       "block size (%u)\n",
+		       sdp->sd_sb.sb_bsize, bdev_hardsect_size(sb->s_bdev));
+		goto out;
+	}
+	if (sdp->sd_sb.sb_bsize > PAGE_SIZE) {
+		error = -EINVAL;
+		fs_err(sdp, "FS block size (%u) is too big for machine "
+		       "page size (%u)\n",
+		       sdp->sd_sb.sb_bsize, (unsigned int)PAGE_SIZE);
+		goto out;
+	}
+
+	/* Get rid of buffers from the original block size */
+	sb_gh.gh_gl->gl_ops->go_inval(sb_gh.gh_gl, DIO_METADATA | DIO_DATA);
+	sb_gh.gh_gl->gl_aspace->i_blkbits = sdp->sd_sb.sb_bsize_shift;
+
+	sb_set_blocksize(sb, sdp->sd_sb.sb_bsize);
+
+	/* Get the root inode */
+	inum = &sdp->sd_sb.sb_root_dir;
+	if (sb->s_type == &gfs2meta_fs_type)
+		inum = &sdp->sd_sb.sb_master_dir;
+	inode = gfs2_lookup_root(sdp, inum);
+	if (IS_ERR(inode)) {
+		error = PTR_ERR(inode);
+		fs_err(sdp, "can't read in root inode: %d\n", error);
+		goto out;
+	}
+
+	sb->s_root = d_alloc_root(inode);
+	if (!sb->s_root) {
+		fs_err(sdp, "can't get root dentry\n");
+		error = -ENOMEM;
+		iput(inode);
+	}
+out:
+	gfs2_glock_dq_uninit(&sb_gh);
+	return error;
+}
+
+static int init_journal(struct gfs2_sbd *sdp, int undo)
+{
+	struct gfs2_holder ji_gh;
+	struct task_struct *p;
+	struct gfs2_inode *ip;
+	int jindex = 1;
+	int error = 0;
+
+	if (undo) {
+		jindex = 0;
+		goto fail_recoverd;
+	}
+
+	sdp->sd_jindex = gfs2_lookup_simple(sdp->sd_master_dir, "jindex");
+	if (IS_ERR(sdp->sd_jindex)) {
+		fs_err(sdp, "can't lookup journal index: %d\n", error);
+		return PTR_ERR(sdp->sd_jindex);
+	}
+	ip = sdp->sd_jindex->u.generic_ip;
+	set_bit(GLF_STICKY, &ip->i_gl->gl_flags);
+
+	/* Load in the journal index special file */
+
+	error = gfs2_jindex_hold(sdp, &ji_gh);
+	if (error) {
+		fs_err(sdp, "can't read journal index: %d\n", error);
+		goto fail;
+	}
+
+	error = -EINVAL;
+	if (!gfs2_jindex_size(sdp)) {
+		fs_err(sdp, "no journals!\n");
+		goto fail_jindex;		
+	}
+
+	if (sdp->sd_args.ar_spectator) {
+		sdp->sd_jdesc = gfs2_jdesc_find(sdp, 0);
+		sdp->sd_log_blks_free = sdp->sd_jdesc->jd_blocks;
+	} else {
+		if (sdp->sd_lockstruct.ls_jid >= gfs2_jindex_size(sdp)) {
+			fs_err(sdp, "can't mount journal #%u\n",
+			       sdp->sd_lockstruct.ls_jid);
+			fs_err(sdp, "there are only %u journals (0 - %u)\n",
+			       gfs2_jindex_size(sdp),
+			       gfs2_jindex_size(sdp) - 1);
+			goto fail_jindex;
+		}
+		sdp->sd_jdesc = gfs2_jdesc_find(sdp, sdp->sd_lockstruct.ls_jid);
+
+		error = gfs2_glock_nq_num(sdp,
+					  sdp->sd_lockstruct.ls_jid,
+					  &gfs2_journal_glops,
+					  LM_ST_EXCLUSIVE, LM_FLAG_NOEXP,
+					  &sdp->sd_journal_gh);
+		if (error) {
+			fs_err(sdp, "can't acquire journal glock: %d\n", error);
+			goto fail_jindex;
+		}
+
+		ip = sdp->sd_jdesc->jd_inode->u.generic_ip;
+		error = gfs2_glock_nq_init(ip->i_gl,
+					   LM_ST_SHARED,
+					   LM_FLAG_NOEXP | GL_EXACT,
+					   &sdp->sd_jinode_gh);
+		if (error) {
+			fs_err(sdp, "can't acquire journal inode glock: %d\n",
+			       error);
+			goto fail_journal_gh;
+		}
+
+		error = gfs2_jdesc_check(sdp->sd_jdesc);
+		if (error) {
+			fs_err(sdp, "my journal (%u) is bad: %d\n",
+			       sdp->sd_jdesc->jd_jid, error);
+			goto fail_jinode_gh;
+		}
+		sdp->sd_log_blks_free = sdp->sd_jdesc->jd_blocks;
+	}
+
+	if (sdp->sd_lockstruct.ls_first) {
+		unsigned int x;
+		for (x = 0; x < sdp->sd_journals; x++) {
+			error = gfs2_recover_journal(gfs2_jdesc_find(sdp, x));
+			if (error) {
+				fs_err(sdp, "error recovering journal %u: %d\n",
+				       x, error);
+				goto fail_jinode_gh;
+			}
+		}
+
+		gfs2_lm_others_may_mount(sdp);
+	} else if (!sdp->sd_args.ar_spectator) {
+		error = gfs2_recover_journal(sdp->sd_jdesc);
+		if (error) {
+			fs_err(sdp, "error recovering my journal: %d\n", error);
+			goto fail_jinode_gh;
+		}
+	}
+
+	set_bit(SDF_JOURNAL_CHECKED, &sdp->sd_flags);
+	gfs2_glock_dq_uninit(&ji_gh);
+	jindex = 0;
+
+	/* Disown my Journal glock */
+
+	sdp->sd_journal_gh.gh_owner = NULL;
+	sdp->sd_jinode_gh.gh_owner = NULL;
+
+	p = kthread_run(gfs2_recoverd, sdp, "gfs2_recoverd");
+	error = IS_ERR(p);
+	if (error) {
+		fs_err(sdp, "can't start recoverd thread: %d\n", error);
+		goto fail_jinode_gh;
+	}
+	sdp->sd_recoverd_process = p;
+
+	return 0;
+
+ fail_recoverd:
+	kthread_stop(sdp->sd_recoverd_process);
+
+ fail_jinode_gh:
+	if (!sdp->sd_args.ar_spectator)
+		gfs2_glock_dq_uninit(&sdp->sd_jinode_gh);
+
+ fail_journal_gh:
+	if (!sdp->sd_args.ar_spectator)
+		gfs2_glock_dq_uninit(&sdp->sd_journal_gh);
+
+ fail_jindex:
+	gfs2_jindex_free(sdp);
+	if (jindex)
+		gfs2_glock_dq_uninit(&ji_gh);
+
+ fail:
+	iput(sdp->sd_jindex);
+
+	return error;
+}
+
+
+static int init_inodes(struct gfs2_sbd *sdp, int undo)
+{
+	int error = 0;
+	struct gfs2_inode *ip;
+	struct inode *inode;
+
+	if (undo)
+		goto fail_qinode;
+
+	inode = gfs2_lookup_root(sdp, &sdp->sd_sb.sb_master_dir);
+	if (IS_ERR(inode)) {
+		error = PTR_ERR(inode);
+		fs_err(sdp, "can't read in master directory: %d\n", error);
+		goto fail;
+	}
+	sdp->sd_master_dir = inode;
+
+	error = init_journal(sdp, undo);
+	if (error)
+		goto fail_master;
+
+	/* Read in the master inode number inode */
+	sdp->sd_inum_inode = gfs2_lookup_simple(sdp->sd_master_dir, "inum");
+	if (IS_ERR(sdp->sd_inum_inode)) {
+		error = PTR_ERR(sdp->sd_inum_inode);
+		fs_err(sdp, "can't read in inum inode: %d\n", error);
+		goto fail_journal;
+	}
+
+
+	/* Read in the master statfs inode */
+	sdp->sd_statfs_inode = gfs2_lookup_simple(sdp->sd_master_dir, "statfs");
+	if (IS_ERR(sdp->sd_statfs_inode)) {
+		error = PTR_ERR(sdp->sd_statfs_inode);
+		fs_err(sdp, "can't read in statfs inode: %d\n", error);
+		goto fail_inum;
+	}
+
+	/* Read in the resource index inode */
+	sdp->sd_rindex = gfs2_lookup_simple(sdp->sd_master_dir, "rindex");
+	if (IS_ERR(sdp->sd_rindex)) {
+		error = PTR_ERR(sdp->sd_rindex);
+		fs_err(sdp, "can't get resource index inode: %d\n", error);
+		goto fail_statfs;
+	}
+	ip = sdp->sd_rindex->u.generic_ip;
+	set_bit(GLF_STICKY, &ip->i_gl->gl_flags);
+	sdp->sd_rindex_vn = ip->i_gl->gl_vn - 1;
+
+	/* Read in the quota inode */
+	sdp->sd_quota_inode = gfs2_lookup_simple(sdp->sd_master_dir, "quota");
+	if (IS_ERR(sdp->sd_quota_inode)) {
+		error = PTR_ERR(sdp->sd_quota_inode);
+		fs_err(sdp, "can't get quota file inode: %d\n", error);
+		goto fail_rindex;
+	}
+	return 0;
+
+fail_qinode:
+	iput(sdp->sd_quota_inode);
+
+fail_rindex:
+	gfs2_clear_rgrpd(sdp);
+	iput(sdp->sd_rindex);
+
+fail_statfs:
+	iput(sdp->sd_statfs_inode);
+
+fail_inum:
+	iput(sdp->sd_inum_inode);
+fail_journal:
+	init_journal(sdp, UNDO);
+fail_master:
+	iput(sdp->sd_master_dir);
+fail:
+	return error;
+}
+
+static int init_per_node(struct gfs2_sbd *sdp, int undo)
+{
+	struct inode *pn = NULL;
+	char buf[30];
+	int error = 0;
+	struct gfs2_inode *ip;
+
+	if (sdp->sd_args.ar_spectator)
+		return 0;
+
+	if (undo)
+		goto fail_qc_gh;
+
+	pn = gfs2_lookup_simple(sdp->sd_master_dir, "per_node");
+	if (IS_ERR(pn)) {
+		error = PTR_ERR(pn);
+		fs_err(sdp, "can't find per_node directory: %d\n", error);
+		return error;
+	}
+
+	sprintf(buf, "inum_range%u", sdp->sd_jdesc->jd_jid);
+	sdp->sd_ir_inode = gfs2_lookup_simple(pn, buf);
+	if (IS_ERR(sdp->sd_ir_inode)) {
+		error = PTR_ERR(sdp->sd_ir_inode);
+		fs_err(sdp, "can't find local \"ir\" file: %d\n", error);
+		goto fail;
+	}
+
+	sprintf(buf, "statfs_change%u", sdp->sd_jdesc->jd_jid);
+	sdp->sd_sc_inode = gfs2_lookup_simple(pn, buf);
+	if (IS_ERR(sdp->sd_sc_inode)) {
+		error = PTR_ERR(sdp->sd_sc_inode);
+		fs_err(sdp, "can't find local \"sc\" file: %d\n", error);
+		goto fail_ir_i;
+	}
+
+	sprintf(buf, "unlinked_tag%u", sdp->sd_jdesc->jd_jid);
+	sdp->sd_ut_inode = gfs2_lookup_simple(pn, buf);
+	if (IS_ERR(sdp->sd_ut_inode)) {
+		error = PTR_ERR(sdp->sd_ut_inode);
+		fs_err(sdp, "can't find local \"ut\" file: %d\n", error);
+		goto fail_sc_i;
+	}
+
+	sprintf(buf, "quota_change%u", sdp->sd_jdesc->jd_jid);
+	sdp->sd_qc_inode = gfs2_lookup_simple(pn, buf);
+	if (IS_ERR(sdp->sd_qc_inode)) {
+		error = PTR_ERR(sdp->sd_qc_inode);
+		fs_err(sdp, "can't find local \"qc\" file: %d\n", error);
+		goto fail_ut_i;
+	}
+
+	iput(pn);
+	pn = NULL;
+
+	ip = sdp->sd_ir_inode->u.generic_ip;
+	error = gfs2_glock_nq_init(ip->i_gl,
+				   LM_ST_EXCLUSIVE, GL_NEVER_RECURSE,
+				   &sdp->sd_ir_gh);
+	if (error) {
+		fs_err(sdp, "can't lock local \"ir\" file: %d\n", error);
+		goto fail_qc_i;
+	}
+
+	ip = sdp->sd_sc_inode->u.generic_ip;
+	error = gfs2_glock_nq_init(ip->i_gl,
+				   LM_ST_EXCLUSIVE, GL_NEVER_RECURSE,
+				   &sdp->sd_sc_gh);
+	if (error) {
+		fs_err(sdp, "can't lock local \"sc\" file: %d\n", error);
+		goto fail_ir_gh;
+	}
+
+	ip = sdp->sd_ut_inode->u.generic_ip;
+	error = gfs2_glock_nq_init(ip->i_gl,
+				   LM_ST_EXCLUSIVE, GL_NEVER_RECURSE,
+				   &sdp->sd_ut_gh);
+	if (error) {
+		fs_err(sdp, "can't lock local \"ut\" file: %d\n", error);
+		goto fail_sc_gh;
+	}
+
+	ip = sdp->sd_qc_inode->u.generic_ip;
+	error = gfs2_glock_nq_init(ip->i_gl,
+				   LM_ST_EXCLUSIVE, GL_NEVER_RECURSE,
+				   &sdp->sd_qc_gh);
+	if (error) {
+		fs_err(sdp, "can't lock local \"qc\" file: %d\n", error);
+		goto fail_ut_gh;
+	}
+
+	return 0;
+
+ fail_qc_gh:
+	gfs2_glock_dq_uninit(&sdp->sd_qc_gh);
+
+ fail_ut_gh:
+	gfs2_glock_dq_uninit(&sdp->sd_ut_gh);
+
+ fail_sc_gh:
+	gfs2_glock_dq_uninit(&sdp->sd_sc_gh);
+
+ fail_ir_gh:
+	gfs2_glock_dq_uninit(&sdp->sd_ir_gh);
+
+ fail_qc_i:
+	iput(sdp->sd_qc_inode);
+
+ fail_ut_i:
+	iput(sdp->sd_ut_inode);
+
+ fail_sc_i:
+	iput(sdp->sd_sc_inode);
+
+ fail_ir_i:
+	iput(sdp->sd_ir_inode);
+
+ fail:
+	if (pn)
+		iput(pn);
+	return error;
+}
+
+static int init_threads(struct gfs2_sbd *sdp, int undo)
+{
+	struct task_struct *p;
+	int error = 0;
+
+	if (undo)
+		goto fail_inoded;
+
+	sdp->sd_log_flush_time = jiffies;
+	sdp->sd_jindex_refresh_time = jiffies;
+
+	p = kthread_run(gfs2_logd, sdp, "gfs2_logd");
+	error = IS_ERR(p);
+	if (error) {
+		fs_err(sdp, "can't start logd thread: %d\n", error);
+		return error;
+	}
+	sdp->sd_logd_process = p;
+
+	sdp->sd_statfs_sync_time = jiffies;
+	sdp->sd_quota_sync_time = jiffies;
+
+	p = kthread_run(gfs2_quotad, sdp, "gfs2_quotad");
+	error = IS_ERR(p);
+	if (error) {
+		fs_err(sdp, "can't start quotad thread: %d\n", error);
+		goto fail;
+	}
+	sdp->sd_quotad_process = p;
+
+	p = kthread_run(gfs2_inoded, sdp, "gfs2_inoded");
+	error = IS_ERR(p);
+	if (error) {
+		fs_err(sdp, "can't start inoded thread: %d\n", error);
+		goto fail_quotad;
+	}
+	sdp->sd_inoded_process = p;
+
+	return 0;
+
+ fail_inoded:
+	kthread_stop(sdp->sd_inoded_process);
+
+ fail_quotad:
+	kthread_stop(sdp->sd_quotad_process);
+
+ fail:
+	kthread_stop(sdp->sd_logd_process);
+	
+	return error;
+}
+
+/**
+ * fill_super - Read in superblock
+ * @sb: The VFS superblock
+ * @data: Mount options
+ * @silent: Don't complain if it's not a GFS2 filesystem
+ *
+ * Returns: errno
+ */
+
+static int fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct gfs2_sbd *sdp;
+	struct gfs2_holder mount_gh;
+	int error;
+
+	sdp = init_sbd(sb);
+	if (!sdp) {
+		printk(KERN_WARNING "GFS2: can't alloc struct gfs2_sbd\n");
+		return -ENOMEM;
+	}
+
+	error = gfs2_mount_args(sdp, (char *)data, 0);
+	if (error) {
+		printk(KERN_WARNING "GFS2: can't parse mount arguments\n");
+		goto fail;
+	}
+
+	init_vfs(sb, SDF_NOATIME);
+
+	/* Set up the buffer cache and fill in some fake block size values
+	   to allow us to read-in the on-disk superblock. */
+	sdp->sd_sb.sb_bsize = sb_min_blocksize(sb, GFS2_BASIC_BLOCK);
+	sdp->sd_sb.sb_bsize_shift = sb->s_blocksize_bits;
+	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift -
+                               GFS2_BASIC_BLOCK_SHIFT;
+	sdp->sd_fsb2bb = 1 << sdp->sd_fsb2bb_shift;
+
+	error = init_names(sdp, silent);
+	if (error)
+		goto fail;
+
+	error = gfs2_sys_fs_add(sdp);
+	if (error)
+		goto fail;
+
+	error = gfs2_lm_mount(sdp, silent);
+	if (error)
+		goto fail_sys;
+
+	error = init_locking(sdp, &mount_gh, DO);
+	if (error)
+		goto fail_lm;
+
+	error = init_sb(sdp, silent, DO);
+	if (error)
+		goto fail_locking;
+
+	error = init_inodes(sdp, DO);
+	if (error)
+		goto fail_sb;
+
+	error = init_per_node(sdp, DO);
+	if (error)
+		goto fail_inodes;
+
+	error = gfs2_statfs_init(sdp);
+	if (error) {
+		fs_err(sdp, "can't initialize statfs subsystem: %d\n", error);
+		goto fail_per_node;
+	}
+
+	error = init_threads(sdp, DO);
+	if (error)
+		goto fail_per_node;
+
+	if (!(sb->s_flags & MS_RDONLY)) {
+		error = gfs2_make_fs_rw(sdp);
+		if (error) {
+			fs_err(sdp, "can't make FS RW: %d\n", error);
+			goto fail_threads;
+		}
+	}
+
+	gfs2_glock_dq_uninit(&mount_gh);
+
+	return 0;
+
+ fail_threads:
+	init_threads(sdp, UNDO);
+
+ fail_per_node:
+	init_per_node(sdp, UNDO);
+
+ fail_inodes:
+	init_inodes(sdp, UNDO);
+
+ fail_sb:
+	init_sb(sdp, 0, UNDO);
+
+ fail_locking:
+	init_locking(sdp, &mount_gh, UNDO);
+
+ fail_lm:
+	gfs2_gl_hash_clear(sdp, WAIT);
+	gfs2_lm_unmount(sdp);
+	while (invalidate_inodes(sb))
+		yield();
+
+ fail_sys:
+	gfs2_sys_fs_del(sdp);
+
+ fail:
+	vfree(sdp);
+	sb->s_fs_info = NULL;
+
+	return error;
+}
+
+static struct super_block *gfs2_get_sb(struct file_system_type *fs_type,
+				       int flags, const char *dev_name,
+				       void *data)
+{
+	return get_sb_bdev(fs_type, flags, dev_name, data, fill_super);
+}
+
+static void gfs2_kill_sb(struct super_block *sb)
+{
+	kill_block_super(sb);
+}
+
+struct file_system_type gfs2_fs_type = {
+	.name = "gfs2",
+	.fs_flags = FS_REQUIRES_DEV,
+	.get_sb = gfs2_get_sb,
+	.kill_sb = gfs2_kill_sb,
+	.owner = THIS_MODULE,
+};
+
+struct file_system_type gfs2meta_fs_type = {
+	.name = "gfs2meta",
+	.fs_flags = FS_REQUIRES_DEV,
+	.get_sb = gfs2_get_sb,
+	.kill_sb = gfs2_kill_sb,
+	.owner = THIS_MODULE,
+};
+
--- /dev/null
+++ b/fs/gfs2/ops_fstype.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_FSTYPE_DOT_H__
+#define __OPS_FSTYPE_DOT_H__
+
+extern struct file_system_type gfs2_fs_type;
+extern struct file_system_type gfs2meta_fs_type;
+
+#endif /* __OPS_FSTYPE_DOT_H__ */
--- /dev/null
+++ b/fs/gfs2/ops_inode.c
@@ -0,0 +1,1196 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/namei.h>
+#include <linux/utsname.h>
+#include <linux/mm.h>
+#include <linux/xattr.h>
+#include <linux/posix_acl.h>
+#include <linux/gfs2_ondisk.h>
+#include <linux/crc32.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "acl.h"
+#include "bmap.h"
+#include "dir.h"
+#include "eaops.h"
+#include "eattr.h"
+#include "glock.h"
+#include "inode.h"
+#include "meta_io.h"
+#include "ops_dentry.h"
+#include "ops_inode.h"
+#include "page.h"
+#include "quota.h"
+#include "rgrp.h"
+#include "trans.h"
+#include "unlinked.h"
+#include "util.h"
+
+/**
+ * gfs2_create - Create a file
+ * @dir: The directory in which to create the file
+ * @dentry: The dentry of the new file
+ * @mode: The mode of the new file
+ *
+ * Returns: errno
+ */
+
+static int gfs2_create(struct inode *dir, struct dentry *dentry,
+		       int mode, struct nameidata *nd)
+{
+	struct gfs2_inode *dip = dir->u.generic_ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_holder ghs[2];
+	struct inode *inode;
+	int new = 1;
+
+	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
+
+	for (;;) {
+		inode = gfs2_createi(ghs, &dentry->d_name, S_IFREG | mode);
+		if (!IS_ERR(inode)) {
+			gfs2_trans_end(sdp);
+			if (dip->i_alloc.al_rgd)
+				gfs2_inplace_release(dip);
+			gfs2_quota_unlock(dip);
+			gfs2_alloc_put(dip);
+			gfs2_glock_dq_uninit_m(2, ghs);
+			break;
+		} else if (PTR_ERR(inode) != -EEXIST ||
+			   (nd->intent.open.flags & O_EXCL)) {
+			gfs2_holder_uninit(ghs);
+			return PTR_ERR(inode);
+		}
+
+		inode = gfs2_lookupi(dir, &dentry->d_name, 0, nd);
+		if (inode) {
+			if (!IS_ERR(inode)) {
+				new = 0;
+				gfs2_holder_uninit(ghs);
+				break;
+			} else {
+				gfs2_holder_uninit(ghs);
+				return PTR_ERR(inode);
+			}
+		}
+	}
+
+	d_instantiate(dentry, inode);
+	if (new)
+		mark_inode_dirty(inode);
+
+	return 0;
+}
+
+/**
+ * gfs2_lookup - Look up a filename in a directory and return its inode
+ * @dir: The directory inode
+ * @dentry: The dentry of the new inode
+ * @nd: passed from Linux VFS, ignored by us
+ *
+ * Called by the VFS layer. Lock dir and call gfs2_lookupi()
+ *
+ * Returns: errno
+ */
+
+static struct dentry *gfs2_lookup(struct inode *dir, struct dentry *dentry,
+				  struct nameidata *nd)
+{
+	struct inode *inode = NULL;
+
+	dentry->d_op = &gfs2_dops;
+
+	inode = gfs2_lookupi(dir, &dentry->d_name, 0, nd);
+	if (inode && IS_ERR(inode))
+		return ERR_PTR(PTR_ERR(inode));
+
+	if (inode)
+		return d_splice_alias(inode, dentry);
+	d_add(dentry, inode);
+
+	return NULL;
+}
+
+/**
+ * gfs2_link - Link to a file
+ * @old_dentry: The inode to link
+ * @dir: Add link to this directory
+ * @dentry: The name of the link
+ *
+ * Link the inode in "old_dentry" into the directory "dir" with the
+ * name in "dentry".
+ *
+ * Returns: errno
+ */
+
+static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
+		     struct dentry *dentry)
+{
+	struct gfs2_inode *dip = dir->u.generic_ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct inode *inode = old_dentry->d_inode;
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_holder ghs[2];
+	int alloc_required;
+	int error;
+
+	if (S_ISDIR(ip->i_di.di_mode))
+		return -EPERM;
+
+	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, ghs);
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 1);
+
+	error = gfs2_glock_nq_m(2, ghs);
+	if (error)
+		goto out;
+
+	error = gfs2_repermission(dir, MAY_WRITE | MAY_EXEC, NULL);
+	if (error)
+		goto out_gunlock;
+
+	error = gfs2_dir_search(dir, &dentry->d_name, NULL, NULL);
+	switch (error) {
+	case -ENOENT:
+		break;
+	case 0:
+		error = -EEXIST;
+	default:
+		goto out_gunlock;
+	}
+
+	error = -EINVAL;
+	if (!dip->i_di.di_nlink)
+		goto out_gunlock;
+	error = -EFBIG;
+	if (dip->i_di.di_entries == (uint32_t)-1)
+		goto out_gunlock;
+	error = -EPERM;
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		goto out_gunlock;
+	error = -EINVAL;
+	if (!ip->i_di.di_nlink)
+		goto out_gunlock;
+	error = -EMLINK;
+	if (ip->i_di.di_nlink == (uint32_t)-1)
+		goto out_gunlock;
+
+	alloc_required = error = gfs2_diradd_alloc_required(dir, &dentry->d_name);
+	if (error < 0)
+		goto out_gunlock;
+	error = 0;
+
+	if (alloc_required) {
+		struct gfs2_alloc *al = gfs2_alloc_get(dip);
+
+		error = gfs2_quota_lock(dip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+		if (error)
+			goto out_alloc;
+
+		error = gfs2_quota_check(dip, dip->i_di.di_uid,
+					 dip->i_di.di_gid);
+		if (error)
+			goto out_gunlock_q;
+
+		al->al_requested = sdp->sd_max_dirres;
+
+		error = gfs2_inplace_reserve(dip);
+		if (error)
+			goto out_gunlock_q;
+
+		error = gfs2_trans_begin(sdp,
+					 sdp->sd_max_dirres +
+					 al->al_rgd->rd_ri.ri_length +
+					 2 * RES_DINODE + RES_STATFS +
+					 RES_QUOTA, 0);
+		if (error)
+			goto out_ipres;
+	} else {
+		error = gfs2_trans_begin(sdp, 2 * RES_DINODE + RES_LEAF, 0);
+		if (error)
+			goto out_ipres;
+	}
+
+	error = gfs2_dir_add(dir, &dentry->d_name, &ip->i_num,
+			     IF2DT(ip->i_di.di_mode));
+	if (error)
+		goto out_end_trans;
+
+	error = gfs2_change_nlink(ip, +1);
+
+ out_end_trans:
+	gfs2_trans_end(sdp);
+
+ out_ipres:
+	if (alloc_required)
+		gfs2_inplace_release(dip);
+
+ out_gunlock_q:
+	if (alloc_required)
+		gfs2_quota_unlock(dip);
+
+ out_alloc:
+	if (alloc_required)
+		gfs2_alloc_put(dip);
+
+ out_gunlock:
+	gfs2_glock_dq_m(2, ghs);
+
+ out:
+	gfs2_holder_uninit(ghs);
+	gfs2_holder_uninit(ghs + 1);
+
+	if (!error) {
+		atomic_inc(&inode->i_count);
+		d_instantiate(dentry, inode);
+		mark_inode_dirty(inode);
+	}
+
+	return error;
+}
+
+/**
+ * gfs2_unlink - Unlink a file
+ * @dir: The inode of the directory containing the file to unlink
+ * @dentry: The file itself
+ *
+ * Unlink a file.  Call gfs2_unlinki()
+ *
+ * Returns: errno
+ */
+
+static int gfs2_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct gfs2_inode *dip = dir->u.generic_ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_inode *ip = dentry->d_inode->u.generic_ip;
+	struct gfs2_unlinked *ul;
+	struct gfs2_holder ghs[2];
+	int error;
+
+	error = gfs2_unlinked_get(sdp, &ul);
+	if (error)
+		return error;
+
+	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, ghs);
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 1);
+
+	error = gfs2_glock_nq_m(2, ghs);
+	if (error)
+		goto out;
+
+	error = gfs2_unlink_ok(dip, &dentry->d_name, ip);
+	if (error)
+		goto out_gunlock;
+
+	error = gfs2_trans_begin(sdp, 2 * RES_DINODE + RES_LEAF +
+				RES_UNLINKED, 0);
+	if (error)
+		goto out_gunlock;
+
+	error = gfs2_unlinki(dip, &dentry->d_name, ip,ul);
+
+	gfs2_trans_end(sdp);
+
+ out_gunlock:
+	gfs2_glock_dq_m(2, ghs);
+
+ out:
+	gfs2_holder_uninit(ghs);
+	gfs2_holder_uninit(ghs + 1);
+
+	gfs2_unlinked_put(sdp, ul);
+
+	return error;
+}
+
+/**
+ * gfs2_symlink - Create a symlink
+ * @dir: The directory to create the symlink in
+ * @dentry: The dentry to put the symlink in
+ * @symname: The thing which the link points to
+ *
+ * Returns: errno
+ */
+
+static int gfs2_symlink(struct inode *dir, struct dentry *dentry,
+			const char *symname)
+{
+	struct gfs2_inode *dip = dir->u.generic_ip, *ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_holder ghs[2];
+	struct inode *inode;
+	struct buffer_head *dibh;
+	int size;
+	int error;
+
+	/* Must be stuffed with a null terminator for gfs2_follow_link() */
+	size = strlen(symname);
+	if (size > sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode) - 1)
+		return -ENAMETOOLONG;
+
+	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
+
+	inode = gfs2_createi(ghs, &dentry->d_name, S_IFLNK | S_IRWXUGO);
+	if (IS_ERR(inode)) {
+		gfs2_holder_uninit(ghs);
+		return PTR_ERR(inode);
+	}
+
+	ip = ghs[1].gh_gl->gl_object;
+
+	ip->i_di.di_size = size;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+
+	if (!gfs2_assert_withdraw(sdp, !error)) {
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		memcpy(dibh->b_data + sizeof(struct gfs2_dinode), symname,
+		       size);
+		brelse(dibh);
+	}
+
+	gfs2_trans_end(sdp);
+	if (dip->i_alloc.al_rgd)
+		gfs2_inplace_release(dip);
+	gfs2_quota_unlock(dip);
+	gfs2_alloc_put(dip);
+
+	gfs2_glock_dq_uninit_m(2, ghs);
+
+	d_instantiate(dentry, inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
+/**
+ * gfs2_mkdir - Make a directory
+ * @dir: The parent directory of the new one
+ * @dentry: The dentry of the new directory
+ * @mode: The mode of the new directory
+ *
+ * Returns: errno
+ */
+
+static int gfs2_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	struct gfs2_inode *dip = dir->u.generic_ip, *ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_holder ghs[2];
+	struct inode *inode;
+	struct buffer_head *dibh;
+	int error;
+
+	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
+
+	inode = gfs2_createi(ghs, &dentry->d_name, S_IFDIR | mode);
+	if (IS_ERR(inode)) {
+		gfs2_holder_uninit(ghs);
+		return PTR_ERR(inode);
+	}
+
+	ip = ghs[1].gh_gl->gl_object;
+
+	ip->i_di.di_nlink = 2;
+	ip->i_di.di_size = sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode);
+	ip->i_di.di_flags |= GFS2_DIF_JDATA;
+	ip->i_di.di_payload_format = GFS2_FORMAT_DE;
+	ip->i_di.di_entries = 2;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+
+	if (!gfs2_assert_withdraw(sdp, !error)) {
+		struct gfs2_dinode *di = (struct gfs2_dinode *)dibh->b_data;
+		struct gfs2_dirent *dent = (struct gfs2_dirent *)(di+1);
+		struct qstr str;
+
+		gfs2_str2qstr(&str, ".");
+		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
+		gfs2_qstr2dirent(&str, GFS2_DIRENT_SIZE(str.len), dent);
+		dent->de_inum = di->di_num; /* already GFS2 endian */
+		dent->de_type = DT_DIR;
+		di->di_entries = cpu_to_be32(1);
+
+		gfs2_str2qstr(&str, "..");
+		dent = (struct gfs2_dirent *)((char*)dent + GFS2_DIRENT_SIZE(1));
+		gfs2_qstr2dirent(&str, dibh->b_size - GFS2_DIRENT_SIZE(1) - sizeof(struct gfs2_dinode), dent);
+
+		gfs2_inum_out(&dip->i_num, (char *) &dent->de_inum);
+		dent->de_type = DT_DIR;
+
+		gfs2_dinode_out(&ip->i_di, (char *)di);
+
+		brelse(dibh);
+	}
+
+	error = gfs2_change_nlink(dip, +1);
+	gfs2_assert_withdraw(sdp, !error); /* dip already pinned */
+
+	gfs2_trans_end(sdp);
+	if (dip->i_alloc.al_rgd)
+		gfs2_inplace_release(dip);
+	gfs2_quota_unlock(dip);
+	gfs2_alloc_put(dip);
+
+	gfs2_glock_dq_uninit_m(2, ghs);
+
+	d_instantiate(dentry, inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
+/**
+ * gfs2_rmdir - Remove a directory
+ * @dir: The parent directory of the directory to be removed
+ * @dentry: The dentry of the directory to remove
+ *
+ * Remove a directory. Call gfs2_rmdiri()
+ *
+ * Returns: errno
+ */
+
+static int gfs2_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct gfs2_inode *dip = dir->u.generic_ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_inode *ip = dentry->d_inode->u.generic_ip;
+	struct gfs2_unlinked *ul;
+	struct gfs2_holder ghs[2];
+	int error;
+
+	error = gfs2_unlinked_get(sdp, &ul);
+	if (error)
+		return error;
+
+	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, ghs);
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 1);
+
+	error = gfs2_glock_nq_m(2, ghs);
+	if (error)
+		goto out;
+
+	error = gfs2_unlink_ok(dip, &dentry->d_name, ip);
+	if (error)
+		goto out_gunlock;
+
+	if (ip->i_di.di_entries < 2) {
+		if (gfs2_consist_inode(ip))
+			gfs2_dinode_print(&ip->i_di);
+		error = -EIO;
+		goto out_gunlock;
+	}
+	if (ip->i_di.di_entries > 2) {
+		error = -ENOTEMPTY;
+		goto out_gunlock;
+	}
+
+	error = gfs2_trans_begin(sdp, 2 * RES_DINODE + 3 * RES_LEAF +
+				RES_UNLINKED, 0);
+	if (error)
+		goto out_gunlock;
+
+	error = gfs2_rmdiri(dip, &dentry->d_name, ip, ul);
+
+	gfs2_trans_end(sdp);
+
+ out_gunlock:
+	gfs2_glock_dq_m(2, ghs);
+
+ out:
+	gfs2_holder_uninit(ghs);
+	gfs2_holder_uninit(ghs + 1);
+
+	gfs2_unlinked_put(sdp, ul);
+
+	return error;
+}
+
+/**
+ * gfs2_mknod - Make a special file
+ * @dir: The directory in which the special file will reside
+ * @dentry: The dentry of the special file
+ * @mode: The mode of the special file
+ * @rdev: The device specification of the special file
+ *
+ */
+
+static int gfs2_mknod(struct inode *dir, struct dentry *dentry, int mode,
+		      dev_t dev)
+{
+	struct gfs2_inode *dip = dir->u.generic_ip, *ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_holder ghs[2];
+	struct inode *inode;
+	struct buffer_head *dibh;
+	uint32_t major = 0, minor = 0;
+	int error;
+
+	switch (mode & S_IFMT) {
+	case S_IFBLK:
+	case S_IFCHR:
+		major = MAJOR(dev);
+		minor = MINOR(dev);
+		break;
+	case S_IFIFO:
+	case S_IFSOCK:
+		break;
+	default:
+		return -EOPNOTSUPP;		
+	};
+
+	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
+
+	inode = gfs2_createi(ghs, &dentry->d_name, mode);
+	if (IS_ERR(inode)) {
+		gfs2_holder_uninit(ghs);
+		return PTR_ERR(inode);
+	}
+
+	ip = ghs[1].gh_gl->gl_object;
+
+	ip->i_di.di_major = major;
+	ip->i_di.di_minor = minor;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+
+	if (!gfs2_assert_withdraw(sdp, !error)) {
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		brelse(dibh);
+	}
+
+	gfs2_trans_end(sdp);
+	if (dip->i_alloc.al_rgd)
+		gfs2_inplace_release(dip);
+	gfs2_quota_unlock(dip);
+	gfs2_alloc_put(dip);
+
+	gfs2_glock_dq_uninit_m(2, ghs);
+
+	d_instantiate(dentry, inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
+/**
+ * gfs2_rename - Rename a file
+ * @odir: Parent directory of old file name
+ * @odentry: The old dentry of the file
+ * @ndir: Parent directory of new file name
+ * @ndentry: The new dentry of the file
+ *
+ * Returns: errno
+ */
+
+static int gfs2_rename(struct inode *odir, struct dentry *odentry,
+		       struct inode *ndir, struct dentry *ndentry)
+{
+	struct gfs2_inode *odip = odir->u.generic_ip;
+	struct gfs2_inode *ndip = ndir->u.generic_ip;
+	struct gfs2_inode *ip = odentry->d_inode->u.generic_ip;
+	struct gfs2_inode *nip = NULL;
+	struct gfs2_sbd *sdp = odip->i_sbd;
+	struct gfs2_unlinked *ul;
+	struct gfs2_holder ghs[4], r_gh;
+	unsigned int num_gh;
+	int dir_rename = 0;
+	int alloc_required;
+	unsigned int x;
+	int error;
+
+	if (ndentry->d_inode) {
+		nip = ndentry->d_inode->u.generic_ip;
+		if (ip == nip)
+			return 0;
+	}
+
+	error = gfs2_unlinked_get(sdp, &ul);
+	if (error)
+		return error;
+
+	/* Make sure we aren't trying to move a dirctory into it's subdir */
+
+	if (S_ISDIR(ip->i_di.di_mode) && odip != ndip) {
+		dir_rename = 1;
+
+		error = gfs2_glock_nq_init(sdp->sd_rename_gl,
+					   LM_ST_EXCLUSIVE, 0,
+					   &r_gh);
+		if (error)
+			goto out;
+
+		error = gfs2_ok_to_move(ip, ndip);
+		if (error)
+			goto out_gunlock_r;
+	}
+
+	gfs2_holder_init(odip->i_gl, LM_ST_EXCLUSIVE, 0, ghs);
+	gfs2_holder_init(ndip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 1);
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 2);
+	num_gh = 3;
+
+	if (nip)
+		gfs2_holder_init(nip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + num_gh++);
+
+	error = gfs2_glock_nq_m(num_gh, ghs);
+	if (error)
+		goto out_uninit;
+
+	/* Check out the old directory */
+
+	error = gfs2_unlink_ok(odip, &odentry->d_name, ip);
+	if (error)
+		goto out_gunlock;
+
+	/* Check out the new directory */
+
+	if (nip) {
+		error = gfs2_unlink_ok(ndip, &ndentry->d_name, nip);
+		if (error)
+			goto out_gunlock;
+
+		if (S_ISDIR(nip->i_di.di_mode)) {
+			if (nip->i_di.di_entries < 2) {
+				if (gfs2_consist_inode(nip))
+					gfs2_dinode_print(&nip->i_di);
+				error = -EIO;
+				goto out_gunlock;
+			}
+			if (nip->i_di.di_entries > 2) {
+				error = -ENOTEMPTY;
+				goto out_gunlock;
+			}
+		}
+	} else {
+		error = gfs2_repermission(ndir, MAY_WRITE | MAY_EXEC, NULL);
+		if (error)
+			goto out_gunlock;
+
+		error = gfs2_dir_search(ndir, &ndentry->d_name, NULL, NULL);
+		switch (error) {
+		case -ENOENT:
+			error = 0;
+			break;
+		case 0:
+			error = -EEXIST;
+		default:
+			goto out_gunlock;
+		};
+
+		if (odip != ndip) {
+			if (!ndip->i_di.di_nlink) {
+				error = -EINVAL;
+				goto out_gunlock;
+			}
+			if (ndip->i_di.di_entries == (uint32_t)-1) {
+				error = -EFBIG;
+				goto out_gunlock;
+			}
+			if (S_ISDIR(ip->i_di.di_mode) &&
+			    ndip->i_di.di_nlink == (uint32_t)-1) {
+				error = -EMLINK;
+				goto out_gunlock;
+			}
+		}
+	}
+
+	/* Check out the dir to be renamed */
+
+	if (dir_rename) {
+		error = gfs2_repermission(odentry->d_inode, MAY_WRITE, NULL);
+		if (error)
+			goto out_gunlock;
+	}
+
+	alloc_required = error = gfs2_diradd_alloc_required(ndir, &ndentry->d_name);
+	if (error < 0)
+		goto out_gunlock;
+	error = 0;
+
+	if (alloc_required) {
+		struct gfs2_alloc *al = gfs2_alloc_get(ndip);
+
+		error = gfs2_quota_lock(ndip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+		if (error)
+			goto out_alloc;
+
+		error = gfs2_quota_check(ndip, ndip->i_di.di_uid,
+					 ndip->i_di.di_gid);
+		if (error)
+			goto out_gunlock_q;
+
+		al->al_requested = sdp->sd_max_dirres;
+
+		error = gfs2_inplace_reserve(ndip);
+		if (error)
+			goto out_gunlock_q;
+
+		error = gfs2_trans_begin(sdp, sdp->sd_max_dirres +
+					 al->al_rgd->rd_ri.ri_length +
+					 4 * RES_DINODE + 4 * RES_LEAF +
+					 RES_UNLINKED + RES_STATFS +
+					 RES_QUOTA, 0);
+		if (error)
+			goto out_ipreserv;
+	} else {
+		error = gfs2_trans_begin(sdp, 4 * RES_DINODE +
+					 5 * RES_LEAF +
+					 RES_UNLINKED, 0);
+		if (error)
+			goto out_gunlock;
+	}
+
+	/* Remove the target file, if it exists */
+
+	if (nip) {
+		if (S_ISDIR(nip->i_di.di_mode))
+			error = gfs2_rmdiri(ndip, &ndentry->d_name, nip, ul);
+		else
+			error = gfs2_unlinki(ndip, &ndentry->d_name, nip, ul);
+		if (error)
+			goto out_end_trans;
+	}
+
+	if (dir_rename) {
+		struct qstr name;
+		gfs2_str2qstr(&name, "..");
+
+		error = gfs2_change_nlink(ndip, +1);
+		if (error)
+			goto out_end_trans;
+		error = gfs2_change_nlink(odip, -1);
+		if (error)
+			goto out_end_trans;
+
+		error = gfs2_dir_mvino(ip, &name, &ndip->i_num, DT_DIR);
+		if (error)
+			goto out_end_trans;
+	} else {
+		struct buffer_head *dibh;
+		error = gfs2_meta_inode_buffer(ip, &dibh);
+		if (error)
+			goto out_end_trans;
+		ip->i_di.di_ctime = get_seconds();
+		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		brelse(dibh);
+	}
+
+	error = gfs2_dir_del(odip, &odentry->d_name);
+	if (error)
+		goto out_end_trans;
+
+	error = gfs2_dir_add(ndir, &ndentry->d_name, &ip->i_num,
+			     IF2DT(ip->i_di.di_mode));
+	if (error)
+		goto out_end_trans;
+
+ out_end_trans:
+	gfs2_trans_end(sdp);
+
+ out_ipreserv:
+	if (alloc_required)
+		gfs2_inplace_release(ndip);
+
+ out_gunlock_q:
+	if (alloc_required)
+		gfs2_quota_unlock(ndip);
+
+ out_alloc:
+	if (alloc_required)
+		gfs2_alloc_put(ndip);
+
+ out_gunlock:
+	gfs2_glock_dq_m(num_gh, ghs);
+
+ out_uninit:
+	for (x = 0; x < num_gh; x++)
+		gfs2_holder_uninit(ghs + x);
+
+ out_gunlock_r:
+	if (dir_rename)
+		gfs2_glock_dq_uninit(&r_gh);
+
+ out:
+	gfs2_unlinked_put(sdp, ul);
+
+	return error;
+}
+
+/**
+ * gfs2_readlink - Read the value of a symlink
+ * @dentry: the symlink
+ * @buf: the buffer to read the symlink data into
+ * @size: the size of the buffer
+ *
+ * Returns: errno
+ */
+
+static int gfs2_readlink(struct dentry *dentry, char __user *user_buf,
+			 int user_size)
+{
+	struct gfs2_inode *ip = dentry->d_inode->u.generic_ip;
+	char array[GFS2_FAST_NAME_SIZE], *buf = array;
+	unsigned int len = GFS2_FAST_NAME_SIZE;
+	int error;
+
+	error = gfs2_readlinki(ip, &buf, &len);
+	if (error)
+		return error;
+
+	if (user_size > len - 1)
+		user_size = len - 1;
+
+	if (copy_to_user(user_buf, buf, user_size))
+		error = -EFAULT;
+	else
+		error = user_size;
+
+	if (buf != array)
+		kfree(buf);
+
+	return error;
+}
+
+/**
+ * gfs2_follow_link - Follow a symbolic link
+ * @dentry: The dentry of the link
+ * @nd: Data that we pass to vfs_follow_link()
+ *
+ * This can handle symlinks of any size. It is optimised for symlinks
+ * under GFS2_FAST_NAME_SIZE.
+ *
+ * Returns: 0 on success or error code
+ */
+
+static void *gfs2_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	struct gfs2_inode *ip = dentry->d_inode->u.generic_ip;
+	char array[GFS2_FAST_NAME_SIZE], *buf = array;
+	unsigned int len = GFS2_FAST_NAME_SIZE;
+	int error;
+
+	error = gfs2_readlinki(ip, &buf, &len);
+	if (!error) {
+		error = vfs_follow_link(nd, buf);
+		if (buf != array)
+			kfree(buf);
+	}
+
+	return ERR_PTR(error);
+}
+
+/**
+ * gfs2_permission -
+ * @inode:
+ * @mask:
+ * @nd: passed from Linux VFS, ignored by us
+ *
+ * Returns: errno
+ */
+
+static int gfs2_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_holder i_gh;
+	int error;
+
+	if (ip->i_vn == ip->i_gl->gl_vn)
+		return generic_permission(inode, mask, gfs2_check_acl);
+
+	error = gfs2_glock_nq_init(ip->i_gl,
+				   LM_ST_SHARED, LM_FLAG_ANY,
+				   &i_gh);
+	if (!error) {
+		error = generic_permission(inode, mask, gfs2_check_acl_locked);
+		gfs2_glock_dq_uninit(&i_gh);
+	}
+
+	return error;
+}
+
+static int setattr_size(struct inode *inode, struct iattr *attr)
+{
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	int error;
+
+	if (attr->ia_size != ip->i_di.di_size) {
+		error = vmtruncate(inode, attr->ia_size);
+		if (error)
+			return error;
+	}
+
+	error = gfs2_truncatei(ip, attr->ia_size);
+	if (error)
+		return error;
+
+	return error;
+}
+
+static int setattr_chown(struct inode *inode, struct iattr *attr)
+{
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct buffer_head *dibh;
+	uint32_t ouid, ogid, nuid, ngid;
+	int error;
+
+	ouid = ip->i_di.di_uid;
+	ogid = ip->i_di.di_gid;
+	nuid = attr->ia_uid;
+	ngid = attr->ia_gid;
+
+	if (!(attr->ia_valid & ATTR_UID) || ouid == nuid)
+		ouid = nuid = NO_QUOTA_CHANGE;
+	if (!(attr->ia_valid & ATTR_GID) || ogid == ngid)
+		ogid = ngid = NO_QUOTA_CHANGE;
+
+	gfs2_alloc_get(ip);
+
+	error = gfs2_quota_lock(ip, nuid, ngid);
+	if (error)
+		goto out_alloc;
+
+	if (ouid != NO_QUOTA_CHANGE || ogid != NO_QUOTA_CHANGE) {
+		error = gfs2_quota_check(ip, nuid, ngid);
+		if (error)
+			goto out_gunlock_q;
+	}
+
+	error = gfs2_trans_begin(sdp, RES_DINODE + 2 * RES_QUOTA, 0);
+	if (error)
+		goto out_gunlock_q;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto out_end_trans;
+
+	error = inode_setattr(inode, attr);
+	gfs2_assert_warn(sdp, !error);
+	gfs2_inode_attr_out(ip);
+
+	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	brelse(dibh);
+
+	if (ouid != NO_QUOTA_CHANGE || ogid != NO_QUOTA_CHANGE) {
+		gfs2_quota_change(ip, -ip->i_di.di_blocks,
+				 ouid, ogid);
+		gfs2_quota_change(ip, ip->i_di.di_blocks,
+				 nuid, ngid);
+	}
+
+ out_end_trans:
+	gfs2_trans_end(sdp);
+
+ out_gunlock_q:
+	gfs2_quota_unlock(ip);
+
+ out_alloc:
+	gfs2_alloc_put(ip);
+
+	return error;
+}
+
+/**
+ * gfs2_setattr - Change attributes on an inode
+ * @dentry: The dentry which is changing
+ * @attr: The structure describing the change
+ *
+ * The VFS layer wants to change one or more of an inodes attributes.  Write
+ * that change out to disk.
+ *
+ * Returns: errno
+ */
+
+static int gfs2_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = dentry->d_inode;
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_holder i_gh;
+	int error;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	if (error)
+		return error;
+
+	error = -EPERM;
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		goto out;
+
+	error = inode_change_ok(inode, attr);
+	if (error)
+		goto out;
+
+	if (attr->ia_valid & ATTR_SIZE)
+		error = setattr_size(inode, attr);
+	else if (attr->ia_valid & (ATTR_UID | ATTR_GID))
+		error = setattr_chown(inode, attr);
+	else if ((attr->ia_valid & ATTR_MODE) && IS_POSIXACL(inode))
+		error = gfs2_acl_chmod(ip, attr);
+	else
+		error = gfs2_setattr_simple(ip, attr);
+
+ out:
+	gfs2_glock_dq_uninit(&i_gh);
+
+	if (!error)
+		mark_inode_dirty(inode);
+
+	return error;
+}
+
+/**
+ * gfs2_getattr - Read out an inode's attributes
+ * @mnt: ?
+ * @dentry: The dentry to stat
+ * @stat: The inode's stats
+ *
+ * Returns: errno
+ */
+
+static int gfs2_getattr(struct vfsmount *mnt, struct dentry *dentry,
+			struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	struct gfs2_inode *ip = inode->u.generic_ip;
+	struct gfs2_holder gh;
+	int error;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
+	if (!error) {
+		generic_fillattr(inode, stat);
+		gfs2_glock_dq_uninit(&gh);
+	}
+
+	return error;
+}
+
+static int gfs2_setxattr(struct dentry *dentry, const char *name,
+			 const void *data, size_t size, int flags)
+{
+	struct gfs2_inode *ip = dentry->d_inode->u.generic_ip;
+	struct gfs2_ea_request er;
+
+	memset(&er, 0, sizeof(struct gfs2_ea_request));
+	er.er_type = gfs2_ea_name2type(name, &er.er_name);
+	if (er.er_type == GFS2_EATYPE_UNUSED)
+		return -EOPNOTSUPP;
+	er.er_data = (char *)data;
+	er.er_name_len = strlen(er.er_name);
+	er.er_data_len = size;
+	er.er_flags = flags;
+
+	gfs2_assert_warn(ip->i_sbd, !(er.er_flags & GFS2_ERF_MODE));
+
+	return gfs2_ea_set(ip, &er);
+}
+
+static ssize_t gfs2_getxattr(struct dentry *dentry, const char *name,
+			     void *data, size_t size)
+{
+	struct gfs2_ea_request er;
+
+	memset(&er, 0, sizeof(struct gfs2_ea_request));
+	er.er_type = gfs2_ea_name2type(name, &er.er_name);
+	if (er.er_type == GFS2_EATYPE_UNUSED)
+		return -EOPNOTSUPP;
+	er.er_data = data;
+	er.er_name_len = strlen(er.er_name);
+	er.er_data_len = size;
+
+	return gfs2_ea_get(dentry->d_inode->u.generic_ip, &er);
+}
+
+static ssize_t gfs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	struct gfs2_ea_request er;
+
+	memset(&er, 0, sizeof(struct gfs2_ea_request));
+	er.er_data = (size) ? buffer : NULL;
+	er.er_data_len = size;
+
+	return gfs2_ea_list(dentry->d_inode->u.generic_ip, &er);
+}
+
+static int gfs2_removexattr(struct dentry *dentry, const char *name)
+{
+	struct gfs2_ea_request er;
+
+	memset(&er, 0, sizeof(struct gfs2_ea_request));
+	er.er_type = gfs2_ea_name2type(name, &er.er_name);
+	if (er.er_type == GFS2_EATYPE_UNUSED)
+		return -EOPNOTSUPP;
+	er.er_name_len = strlen(er.er_name);
+
+	return gfs2_ea_remove(dentry->d_inode->u.generic_ip, &er);
+}
+
+struct inode_operations gfs2_file_iops = {
+	.permission = gfs2_permission,
+	.setattr = gfs2_setattr,
+	.getattr = gfs2_getattr,
+	.setxattr = gfs2_setxattr,
+	.getxattr = gfs2_getxattr,
+	.listxattr = gfs2_listxattr,
+	.removexattr = gfs2_removexattr,
+};
+
+struct inode_operations gfs2_dev_iops = {
+	.permission = gfs2_permission,
+	.setattr = gfs2_setattr,
+	.getattr = gfs2_getattr,
+	.setxattr = gfs2_setxattr,
+	.getxattr = gfs2_getxattr,
+	.listxattr = gfs2_listxattr,
+	.removexattr = gfs2_removexattr,
+};
+
+struct inode_operations gfs2_dir_iops = {
+	.create = gfs2_create,
+	.lookup = gfs2_lookup,
+	.link = gfs2_link,
+	.unlink = gfs2_unlink,
+	.symlink = gfs2_symlink,
+	.mkdir = gfs2_mkdir,
+	.rmdir = gfs2_rmdir,
+	.mknod = gfs2_mknod,
+	.rename = gfs2_rename,
+	.permission = gfs2_permission,
+	.setattr = gfs2_setattr,
+	.getattr = gfs2_getattr,
+	.setxattr = gfs2_setxattr,
+	.getxattr = gfs2_getxattr,
+	.listxattr = gfs2_listxattr,
+	.removexattr = gfs2_removexattr,
+};
+
+struct inode_operations gfs2_symlink_iops = {
+	.readlink = gfs2_readlink,
+	.follow_link = gfs2_follow_link,
+	.permission = gfs2_permission,
+	.setattr = gfs2_setattr,
+	.getattr = gfs2_getattr,
+	.setxattr = gfs2_setxattr,
+	.getxattr = gfs2_getxattr,
+	.listxattr = gfs2_listxattr,
+	.removexattr = gfs2_removexattr,
+};
+
--- /dev/null
+++ b/fs/gfs2/ops_inode.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_INODE_DOT_H__
+#define __OPS_INODE_DOT_H__
+
+extern struct inode_operations gfs2_file_iops;
+extern struct inode_operations gfs2_dir_iops;
+extern struct inode_operations gfs2_symlink_iops;
+extern struct inode_operations gfs2_dev_iops;
+
+#endif /* __OPS_INODE_DOT_H__ */



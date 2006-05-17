Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWEQPQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWEQPQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWEQPQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:16:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751002AbWEQPQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:16:47 -0400
Message-ID: <446B3E5D.1030301@redhat.com>
Date: Wed, 17 May 2006 11:16:45 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] memory mapped files not updating timestamps
Content-Type: multipart/mixed;
 boundary="------------080706030104030105030506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080706030104030105030506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Attached are some changes to address the problem that modifications to
the contents of a file, made via an mmap'd region, do not cause the
modification time on the file to be updated.  This lack can cause corruption
by allowing backup software to not detect files which should be backed up.
This also represents a potential security hole because it allows a file 
to be
modified with no corresponding change in the file modification or change
time fields.

The changes add support to detect when the modification time needs to be
updated by placing a hook in __set_pages_dirty_buffers and
__set_pages_dirty_nobuffers.  One of these two routines will be invoked
when the dirty bit is detected in the pte.  The hook sets a new bit in the
address_space mapping struct indicating that the file which is associated
with that part of the address space needs to have its modification and
change time attributes updated.

The new bit described above is used in various system calls to cause the
modification and change times to be updated.  These are msync, munmap, 
fsync,
and exit system calls.  Additionally, these two timestamps will be updated
if a sync or other inode flushing operation occurs as part of normal system
operations.

These changes were tested in two ways.  One was to simply create a file,
write(2) to it, close it, and then test to ensure that the file modification
time does not change after the file is closed.  Another was a program which
creates a file, mmap's it, modifies the mapped pages, and then either 
msync's
the region, fsync's the file, sync's the system, abruptly exits, or simply
munmap's the files.  This program shows the file mtime and ctime fields at
various times and these times were used to ensure that they did change and
did change in expected ways.

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------080706030104030105030506
Content-Type: text/plain;
 name="mctime.devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mctime.devel"

--- linux-2.6.16.i686/fs/inode.c.org
+++ linux-2.6.16.i686/fs/inode.c
@@ -1211,8 +1211,8 @@ void touch_atime(struct vfsmount *mnt, s
 EXPORT_SYMBOL(touch_atime);
 
 /**
- *	file_update_time	-	update mtime and ctime time
- *	@file: file accessed
+ *	inode_update_time	-	update mtime and ctime time
+ *	@inode: file accessed
  *
  *	Update the mtime and ctime members of an inode and mark the inode
  *	for writeback.  Note that this function is meant exclusively for
@@ -1222,9 +1222,8 @@ EXPORT_SYMBOL(touch_atime);
  *	timestamps are handled by the server.
  */
 
-void file_update_time(struct file *file)
+void inode_update_time(struct inode *inode)
 {
-	struct inode *inode = file->f_dentry->d_inode;
 	struct timespec now;
 	int sync_it = 0;
 
@@ -1246,7 +1245,7 @@ void file_update_time(struct file *file)
 		mark_inode_dirty_sync(inode);
 }
 
-EXPORT_SYMBOL(file_update_time);
+EXPORT_SYMBOL(inode_update_time);
 
 int inode_needs_sync(struct inode *inode)
 {
--- linux-2.6.16.i686/fs/fs-writeback.c.org
+++ linux-2.6.16.i686/fs/fs-writeback.c
@@ -168,6 +168,9 @@ __sync_single_inode(struct inode *inode,
 
 	spin_unlock(&inode_lock);
 
+	if (test_and_clear_bit(AS_MCTIME, &mapping->flags))
+		inode_update_time(inode);
+
 	ret = do_writepages(mapping, wbc);
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
--- linux-2.6.16.i686/fs/buffer.c.org
+++ linux-2.6.16.i686/fs/buffer.c
@@ -347,6 +347,10 @@ long do_fsync(struct file *file, int dat
 	if (!ret)
 		ret = err;
 	current->flags &= ~PF_SYNCWRITE;
+
+	if (test_and_clear_bit(AS_MCTIME, &mapping->flags))
+		inode_update_time(mapping->host);
+
 out:
 	return ret;
 }
@@ -837,6 +841,7 @@ EXPORT_SYMBOL(mark_buffer_dirty_inode);
 int __set_page_dirty_buffers(struct page *page)
 {
 	struct address_space * const mapping = page->mapping;
+	int ret = 0;
 
 	spin_lock(&mapping->private_lock);
 	if (page_has_buffers(page)) {
@@ -861,9 +866,13 @@ int __set_page_dirty_buffers(struct page
 		}
 		write_unlock_irq(&mapping->tree_lock);
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
-		return 1;
+		ret = 1;
 	}
-	return 0;
+
+	if (page_mapped(page))
+		set_bit(AS_MCTIME, &mapping->flags);
+
+	return ret;
 }
 EXPORT_SYMBOL(__set_page_dirty_buffers);
 
--- linux-2.6.16.i686/include/linux/fs.h.org
+++ linux-2.6.16.i686/include/linux/fs.h
@@ -1777,7 +1777,12 @@ extern int buffer_migrate_page(struct pa
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int __must_check inode_setattr(struct inode *, struct iattr *);
 
-extern void file_update_time(struct file *file);
+extern void inode_update_time(struct inode *);
+
+static inline void file_update_time(struct file *file)
+{
+	inode_update_time(file->f_dentry->d_inode);
+}
 
 static inline ino_t parent_ino(struct dentry *dentry)
 {
--- linux-2.6.16.i686/include/linux/pagemap.h.org
+++ linux-2.6.16.i686/include/linux/pagemap.h
@@ -16,8 +16,9 @@
  * Bits in mapping->flags.  The lower __GFP_BITS_SHIFT bits are the page
  * allocation mode flags.
  */
-#define	AS_EIO		(__GFP_BITS_SHIFT + 0)	/* IO error on async write */
+#define AS_EIO		(__GFP_BITS_SHIFT + 0)	/* IO error on async write */
 #define AS_ENOSPC	(__GFP_BITS_SHIFT + 1)	/* ENOSPC on async write */
+#define AS_MCTIME	(__GFP_BITS_SHIFT + 2)	/* need m/ctime change */
 
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
--- linux-2.6.16.i686/mm/page-writeback.c.org
+++ linux-2.6.16.i686/mm/page-writeback.c
@@ -627,8 +627,10 @@ EXPORT_SYMBOL(write_one_page);
  */
 int __set_page_dirty_nobuffers(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
+	int ret = 0;
+
 	if (!TestSetPageDirty(page)) {
-		struct address_space *mapping = page_mapping(page);
 		struct address_space *mapping2;
 
 		if (mapping) {
@@ -648,9 +650,11 @@ int __set_page_dirty_nobuffers(struct pa
 							I_DIRTY_PAGES);
 			}
 		}
-		return 1;
+		ret = 1;
 	}
-	return 0;
+	if (page_mapped(page))
+		set_bit(AS_MCTIME, &mapping->flags);
+	return ret;
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
 
--- linux-2.6.16.i686/mm/msync.c.org
+++ linux-2.6.16.i686/mm/msync.c
@@ -206,12 +206,16 @@ asmlinkage long sys_msync(unsigned long 
 		file = vma->vm_file;
 		start = vma->vm_end;
 		if ((flags & MS_ASYNC) && file && nr_pages_dirtied) {
+			struct address_space *mapping = file->f_mapping;
+
 			get_file(file);
 			up_read(&current->mm->mmap_sem);
-			balance_dirty_pages_ratelimited_nr(file->f_mapping,
+			balance_dirty_pages_ratelimited_nr(mapping,
 							nr_pages_dirtied);
 			fput(file);
 			down_read(&current->mm->mmap_sem);
+			if (test_and_clear_bit(AS_MCTIME, &mapping->flags))
+				inode_update_time(mapping->host);
 			vma = find_vma(current->mm, start);
 		} else if ((flags & MS_SYNC) && file &&
 				(vma->vm_flags & VM_SHARED)) {
--- linux-2.6.16.i686/mm/mmap.c.org
+++ linux-2.6.16.i686/mm/mmap.c
@@ -203,6 +203,8 @@ void unlink_file_vma(struct vm_area_stru
 		spin_lock(&mapping->i_mmap_lock);
 		__remove_shared_vm_struct(vma, file, mapping);
 		spin_unlock(&mapping->i_mmap_lock);
+		if (test_and_clear_bit(AS_MCTIME, &mapping->flags))
+			inode_update_time(mapping->host);
 	}
 }
 

--------------080706030104030105030506--

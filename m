Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbUKPOYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbUKPOYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbUKPOYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:24:22 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:23230 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261734AbUKPOOz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:14:55 -0500
Date: Tue, 16 Nov 2004 19:41:25 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [patch 4/4] Cleanup file_count usage: Avoid file_count usage for hugetlb nattach reporting
Message-ID: <20041116141125.GE23257@impedimenta.in.ibm.com>
References: <20041116135200.GA23257@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116135200.GA23257@impedimenta.in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file_count macro usage to get the number of attaches to a hugetlb
sysv style shared memory segment, seems to work although it looks bogus
on the first look.  But we want to get rid of file_count macros and 
reads to struct file.f_count.  This patch cleans up the file_count usage
for shm hugetlb attaches.  The nattch counter is maintained on the same 
lines as in regular sysv shared memory segments. The file_operations for the 
struct file of the shared memory hugetlb segment now is different from the
hugetlbfs specific f_ops. 

Patch has been tested with some userspace testcases

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>
---

 fs/hugetlbfs/inode.c    |   21 ++++++++++++++++++++-
 include/linux/hugetlb.h |    5 ++++-
 include/linux/shm.h     |   19 +++++++++++++++++++
 ipc/shm.c               |   19 ++++++-------------
 mm/hugetlb.c            |    7 +++++++
 5 files changed, 56 insertions(+), 15 deletions(-)

diff -ruN -X dontdiff2 linux-2.6.9/fs/hugetlbfs/inode.c f_count-2.6.9/fs/hugetlbfs/inode.c
--- linux-2.6.9/fs/hugetlbfs/inode.c	2004-10-19 03:25:07.000000000 +0530
+++ f_count-2.6.9/fs/hugetlbfs/inode.c	2004-11-15 15:12:17.000000000 +0530
@@ -35,6 +35,7 @@
 static struct super_operations hugetlbfs_ops;
 static struct address_space_operations hugetlbfs_aops;
 struct file_operations hugetlbfs_file_operations;
+struct file_operations hugetlbfs_shm_file_operations;
 static struct inode_operations hugetlbfs_dir_inode_operations;
 static struct inode_operations hugetlbfs_inode_operations;
 
@@ -91,6 +92,16 @@
 	return ret;
 }
 
+static int 
+hugetlbfs_shm_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int ret;
+	ret = hugetlbfs_file_mmap(file, vma);
+	vma->vm_ops = &hugetlb_shm_vm_ops;
+	shm_inc(file->f_dentry->d_inode->i_ino);
+	return ret;
+}
+
 /*
  * Called under down_write(mmap_sem), page_table_lock is not held
  */
@@ -552,6 +563,11 @@
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
 };
 
+struct file_operations hugetlbfs_shm_file_operations = {
+	.mmap			= hugetlbfs_shm_file_mmap,
+	.get_unmapped_area	= hugetlb_get_unmapped_area,
+};
+
 static struct inode_operations hugetlbfs_dir_inode_operations = {
 	.create		= hugetlbfs_create,
 	.lookup		= simple_lookup,
@@ -737,6 +753,9 @@
 			can_do_mlock());
 }
 
+/*
+ * Setup a hugetlb file on hugetlbfs for a new shm segment
+ */
 struct file *hugetlb_zero_setup(size_t size)
 {
 	int error = -ENOMEM;
@@ -781,7 +800,7 @@
 	file->f_vfsmnt = mntget(hugetlbfs_vfsmount);
 	file->f_dentry = dentry;
 	file->f_mapping = inode->i_mapping;
-	file->f_op = &hugetlbfs_file_operations;
+	file->f_op = &hugetlbfs_shm_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
 	return file;
 
diff -ruN -X dontdiff2 linux-2.6.9/include/linux/hugetlb.h f_count-2.6.9/include/linux/hugetlb.h
--- linux-2.6.9/include/linux/hugetlb.h	2004-10-19 03:24:08.000000000 +0530
+++ f_count-2.6.9/include/linux/hugetlb.h	2004-11-15 15:12:17.000000000 +0530
@@ -117,14 +117,17 @@
 }
 
 extern struct file_operations hugetlbfs_file_operations;
+extern struct file_operations hugetlbfs_shm_file_operations;
 extern struct vm_operations_struct hugetlb_vm_ops;
+extern struct vm_operations_struct hugetlb_shm_vm_ops;
 struct file *hugetlb_zero_setup(size_t);
 int hugetlb_get_quota(struct address_space *mapping);
 void hugetlb_put_quota(struct address_space *mapping);
 
 static inline int is_file_hugepages(struct file *file)
 {
-	return file->f_op == &hugetlbfs_file_operations;
+	return file->f_op == &hugetlbfs_shm_file_operations 
+		|| file->f_op == &hugetlbfs_file_operations;
 }
 
 static inline void set_file_hugepages(struct file *file)
diff -ruN -X dontdiff2 linux-2.6.9/include/linux/shm.h f_count-2.6.9/include/linux/shm.h
--- linux-2.6.9/include/linux/shm.h	2004-10-19 03:24:40.000000000 +0530
+++ f_count-2.6.9/include/linux/shm.h	2004-11-15 15:12:17.000000000 +0530
@@ -95,12 +95,31 @@
 
 #ifdef CONFIG_SYSVIPC
 long do_shmat(int shmid, char __user *shmaddr, int shmflg, unsigned long *addr);
+void shm_open(struct vm_area_struct *shmd);
+void shm_close(struct vm_area_struct *shmd);
+void shm_inc(int id);
 #else
 static inline long do_shmat(int shmid, char __user *shmaddr,
 				int shmflg, unsigned long *addr)
 {
 	return -ENOSYS;
 }
+
+static inline void shm_open(struct vm_area_struct *shmd)
+{
+	BUG();
+}
+
+static inline void shm_close(struct vm_area_struct *shmd)
+{
+	BUG();
+}
+
+static inline void shm_inc(int id)
+{
+	BUG();
+}
+
 #endif
 
 #endif /* __KERNEL__ */
diff -ruN -X dontdiff2 linux-2.6.9/ipc/shm.c f_count-2.6.9/ipc/shm.c
--- linux-2.6.9/ipc/shm.c	2004-10-19 03:24:08.000000000 +0530
+++ f_count-2.6.9/ipc/shm.c	2004-11-15 15:12:17.000000000 +0530
@@ -44,8 +44,6 @@
 	ipc_buildid(&shm_ids, id, seq)
 
 static int newseg (key_t key, int shmflg, size_t size);
-static void shm_open (struct vm_area_struct *shmd);
-static void shm_close (struct vm_area_struct *shmd);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_shm_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data);
 #endif
@@ -83,7 +81,7 @@
 
 
 
-static inline void shm_inc (int id) {
+void shm_inc(int id) {
 	struct shmid_kernel *shp;
 
 	if(!(shp = shm_lock(id)))
@@ -95,7 +93,7 @@
 }
 
 /* This is called by fork, once for every shm attach. */
-static void shm_open (struct vm_area_struct *shmd)
+void shm_open(struct vm_area_struct *shmd)
 {
 	shm_inc (shmd->vm_file->f_dentry->d_inode->i_ino);
 }
@@ -129,7 +127,7 @@
  * The descriptor has already been removed from the current->mm->mmap list
  * and will later be kfree()d.
  */
-static void shm_close (struct vm_area_struct *shmd)
+void shm_close(struct vm_area_struct *shmd)
 {
 	struct file * file = shmd->vm_file;
 	int id = file->f_dentry->d_inode->i_ino;
@@ -228,9 +226,7 @@
 	shp->id = shm_buildid(id,shp->shm_perm.seq);
 	shp->shm_file = file;
 	file->f_dentry->d_inode->i_ino = shp->id;
-	if (shmflg & SHM_HUGETLB)
-		set_file_hugepages(file);
-	else
+	if (!(shmflg & SHM_HUGETLB))
 		file->f_op = &shm_file_operations;
 	shm_tot += numpages;
 	shm_unlock(shp);
@@ -496,10 +492,7 @@
 		tbuf.shm_ctime	= shp->shm_ctim;
 		tbuf.shm_cpid	= shp->shm_cprid;
 		tbuf.shm_lpid	= shp->shm_lprid;
-		if (!is_file_hugepages(shp->shm_file))
-			tbuf.shm_nattch	= shp->shm_nattch;
-		else
-			tbuf.shm_nattch = file_count(shp->shm_file) - 1;
+		tbuf.shm_nattch	= shp->shm_nattch;
 		shm_unlock(shp);
 		if(copy_shmid_to_user (buf, &tbuf, version))
 			err = -EFAULT;
@@ -875,7 +868,7 @@
 				shp->shm_segsz,
 				shp->shm_cprid,
 				shp->shm_lprid,
-				is_file_hugepages(shp->shm_file) ? (file_count(shp->shm_file) - 1) : shp->shm_nattch,
+				shp->shm_nattch,
 				shp->shm_perm.uid,
 				shp->shm_perm.gid,
 				shp->shm_perm.cuid,
diff -ruN -X dontdiff2 linux-2.6.9/mm/hugetlb.c f_count-2.6.9/mm/hugetlb.c
--- linux-2.6.9/mm/hugetlb.c	2004-10-19 03:24:37.000000000 +0530
+++ f_count-2.6.9/mm/hugetlb.c	2004-11-15 15:12:17.000000000 +0530
@@ -10,6 +10,7 @@
 #include <linux/hugetlb.h>
 #include <linux/sysctl.h>
 #include <linux/highmem.h>
+#include <linux/shm.h>
 
 const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
 static unsigned long nr_huge_pages, free_huge_pages;
@@ -248,6 +249,12 @@
 	.nopage = hugetlb_nopage,
 };
 
+struct vm_operations_struct hugetlb_shm_vm_ops = {
+	.open 	= shm_open,
+	.close	= shm_close,
+	.nopage = hugetlb_nopage,
+};
+
 void zap_hugepage_range(struct vm_area_struct *vma,
 			unsigned long start, unsigned long length)
 {

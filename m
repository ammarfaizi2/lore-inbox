Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbULIPKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbULIPKO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbULIPKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:10:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15817 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261520AbULIPJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:09:26 -0500
Date: Thu, 9 Dec 2004 15:08:58 GMT
Message-Id: <200412091508.iB9F8woc027575@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: akpm@osdl.org, davidm@snapgear.com, gerg@snapgear.com, wli@holomorphy.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 5/5] NOMMU: Futher nommu shared memory support
In-Reply-To: <3e47b0ba-49f4-11d9-9df1-0002b3163499@redhat.com> 
References: <3e47b0ba-49f4-11d9-9df1-0002b3163499@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch furthers shared memory support under !MMU conditions:

 (1) tiny-shmem.c farms get_unmapped_area() and mmap() requests off to ramfs in
     addition to the inode creation requests, thus supporting SYSV SHM

 (2) tiny-shmem.c no longer expands the inode it allocates by writing directly
     into i_size.

 (3) SYSV IPC is then available on nommu.

     (a) SYSV SHM requires shmem_mmap() to be provided by the backing
         filesystem (tmpfs in shmem.c or tiny-shmem.c).

     (b) SYSV SHM requires shmem_get_unmapped_area() to be provided by the
         backing fs if under !MMU conditions.

Signed-Off-By: dhowells@redhat.com
---
diffstat nommu-shmem-2610rc2mm3-3.diff
 include/linux/mm.h |   11 +++++++++++
 init/Kconfig       |    1 -
 ipc/shm.c          |   16 +++++++++++-----
 mm/shmem.c         |    2 +-
 mm/tiny-shmem.c    |   26 +++++++++++++++++++++++++-
 5 files changed, 48 insertions(+), 8 deletions(-)

diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/init/Kconfig linux-2.6.10-rc2-mm3-shmem/init/Kconfig
--- linux-2.6.10-rc2-mm3-mmcleanup/init/Kconfig	2004-11-22 10:54:17.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/init/Kconfig	2004-12-01 17:07:36.000000000 +0000
@@ -81,7 +81,6 @@ config SWAP
 
 config SYSVIPC
 	bool "System V IPC"
-	depends on MMU
 	---help---
 	  Inter Process Communication is a suite of library functions and
 	  system calls which let processes (running programs) synchronize and
diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/include/linux/mm.h linux-2.6.10-rc2-mm3-shmem/include/linux/mm.h
--- linux-2.6.10-rc2-mm3-mmcleanup/include/linux/mm.h	2004-11-22 10:54:16.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/include/linux/mm.h	2004-12-08 16:52:24.000000000 +0000
@@ -566,9 +603,20 @@ int shmem_lock(struct file *file, int lo
 #define shmem_get_policy(a, b)	(NULL)
 #endif
 struct file *shmem_file_setup(char *name, loff_t size, unsigned long flags);
+extern int shmem_mmap(struct file *file, struct vm_area_struct *vma);
 
 int shmem_zero_setup(struct vm_area_struct *);
 
+#ifdef CONFIG_MMU
+#define shmem_get_unmapped_area(f,a,l,p,fl) 0
+#else
+extern unsigned long shmem_get_unmapped_area(struct file *file,
+					     unsigned long addr,
+					     unsigned long len,
+					     unsigned long pgoff,
+					     unsigned long flags);
+#endif
+
 static inline int can_do_mlock(void)
 {
 	if (capable(CAP_IPC_LOCK))
diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/ipc/shm.c linux-2.6.10-rc2-mm3-shmem/ipc/shm.c
--- linux-2.6.10-rc2-mm3-mmcleanup/ipc/shm.c	2004-11-22 10:54:17.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/ipc/shm.c	2004-12-02 15:20:36.000000000 +0000
@@ -157,14 +157,20 @@ static void shm_close (struct vm_area_st
 
 static int shm_mmap(struct file * file, struct vm_area_struct * vma)
 {
-	file_accessed(file);
-	vma->vm_ops = &shm_vm_ops;
-	shm_inc(file->f_dentry->d_inode->i_ino);
-	return 0;
+	int ret;
+
+	ret = shmem_mmap(file, vma);
+	if (ret == 0) {
+		vma->vm_ops = &shm_vm_ops;
+		shm_inc(file->f_dentry->d_inode->i_ino);
+	}
+
+	return ret;
 }
 
 static struct file_operations shm_file_operations = {
-	.mmap	= shm_mmap
+	.mmap	= shm_mmap,
+	.get_unmapped_area = shmem_get_unmapped_area,
 };
 
 static struct vm_operations_struct shm_vm_ops = {
diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/mm/shmem.c linux-2.6.10-rc2-mm3-shmem/mm/shmem.c
--- linux-2.6.10-rc2-mm3-mmcleanup/mm/shmem.c	2004-11-22 10:54:18.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/mm/shmem.c	2004-12-02 15:16:23.000000000 +0000
@@ -1246,7 +1246,7 @@ out_nomem:
 	return retval;
 }
 
-static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
+int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/mm/tiny-shmem.c linux-2.6.10-rc2-mm3-shmem/mm/tiny-shmem.c
--- linux-2.6.10-rc2-mm3-mmcleanup/mm/tiny-shmem.c	2004-11-15 13:34:39.000000000 +0000
+++ linux-2.6.10-rc2-mm3-shmem/mm/tiny-shmem.c	2004-12-02 16:20:55.000000000 +0000
@@ -78,8 +78,13 @@ struct file *shmem_file_setup(char *name
 		goto close_file;
 
 	d_instantiate(dentry, inode);
-	inode->i_size = size;
 	inode->i_nlink = 0;	/* It is unlinked */
+
+	/* notify everyone as to the change of file size */
+	error = do_truncate(dentry, size);
+	if (error < 0)
+		goto close_file;
+
 	file->f_vfsmnt = mntget(shm_mnt);
 	file->f_dentry = dentry;
 	file->f_mapping = inode->i_mapping;
@@ -120,3 +125,22 @@ int shmem_unuse(swp_entry_t entry, struc
 {
 	return 0;
 }
+
+int shmem_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	file_accessed(file);
+#ifndef CONFIG_MMU
+	return ramfs_nommu_mmap(file, vma);
+#else
+	return 0;
+#endif
+}
+
+unsigned long shmem_get_unmapped_area(struct file *file,
+				      unsigned long addr,
+				      unsigned long len,
+				      unsigned long pgoff,
+				      unsigned long flags)
+{
+	return ramfs_nommu_get_unmapped_area(file, addr, len, pgoff, flags);
+}

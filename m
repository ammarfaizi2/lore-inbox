Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVKWTAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVKWTAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVKWTAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:00:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57808 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932195AbVKWTAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:00:11 -0500
Date: Wed, 23 Nov 2005 18:59:48 GMT
Message-Id: <200511231859.jANIxmgQ032276@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, dalomar@serrasold.com
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Fcc: outgoing
Subject: [PATCH 2/3] NOMMU: Make SYSV IPC SHM use ramfs facilities on NOMMU
In-Reply-To: <dhowells1132772387@warthog.cambridge.redhat.com>
References: <dhowells1132772387@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes the SYSV IPC shared memory facilities use the new
ramfs facilities on a no-MMU kernel.

The following changes are made:

 (1) There are now shmem_mmap() and shmem_get_unmapped_area() functions to
     allow the IPC SHM facilities to commune with the tiny-shmem and shmem
     code.

 (2) ramfs files now need resizing using do_truncate() rather than by modifying
     the inode size directly (see shmem_file_setup()). This causes ramfs to
     attempt to bind a block of pages of sufficient size to the inode.

 (3) CONFIG_SYSVIPC is no longer contingent on CONFIG_MMU.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 shmem-nommu-2615rc2.diff
 include/linux/mm.h |    9 +++++++++
 init/Kconfig       |    1 -
 ipc/shm.c          |   18 +++++++++++++-----
 mm/nommu.c         |    6 ++++++
 mm/shmem.c         |    2 +-
 mm/tiny-shmem.c    |   29 ++++++++++++++++++++++++++++-
 6 files changed, 57 insertions(+), 8 deletions(-)

diff -uNrp linux-2.6.15-rc2-frv/include/linux/mm.h linux-2.6.15-rc2-frv-shmem/include/linux/mm.h
--- linux-2.6.15-rc2-frv/include/linux/mm.h	2005-11-23 13:29:08.000000000 +0000
+++ linux-2.6.15-rc2-frv-shmem/include/linux/mm.h	2005-11-23 16:46:59.000000000 +0000
@@ -656,9 +656,18 @@ int shmem_lock(struct file *file, int lo
 #define shmem_get_policy(a, b)	(NULL)
 #endif
 struct file *shmem_file_setup(char *name, loff_t size, unsigned long flags);
+extern int shmem_mmap(struct file *file, struct vm_area_struct *vma);
 
 int shmem_zero_setup(struct vm_area_struct *);
 
+#ifndef CONFIG_MMU
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
diff -uNrp linux-2.6.15-rc2-frv/init/Kconfig linux-2.6.15-rc2-frv-shmem/init/Kconfig
--- linux-2.6.15-rc2-frv/init/Kconfig	2005-11-23 12:09:23.000000000 +0000
+++ linux-2.6.15-rc2-frv-shmem/init/Kconfig	2005-11-23 16:00:57.000000000 +0000
@@ -105,7 +105,6 @@ config SWAP
 
 config SYSVIPC
 	bool "System V IPC"
-	depends on MMU
 	---help---
 	  Inter Process Communication is a suite of library functions and
 	  system calls which let processes (running programs) synchronize and
diff -uNrp linux-2.6.15-rc2-frv/ipc/shm.c linux-2.6.15-rc2-frv-shmem/ipc/shm.c
--- linux-2.6.15-rc2-frv/ipc/shm.c	2005-11-23 12:09:23.000000000 +0000
+++ linux-2.6.15-rc2-frv-shmem/ipc/shm.c	2005-11-23 16:45:44.000000000 +0000
@@ -157,14 +157,22 @@ static void shm_close (struct vm_area_st
 
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
+#ifndef CONFIG_MMU
+	.get_unmapped_area = shmem_get_unmapped_area,
+#endif
 };
 
 static struct vm_operations_struct shm_vm_ops = {
diff -uNrp linux-2.6.15-rc2-frv/mm/nommu.c linux-2.6.15-rc2-frv-shmem/mm/nommu.c
--- linux-2.6.15-rc2-frv/mm/nommu.c	2005-11-23 12:09:24.000000000 +0000
+++ linux-2.6.15-rc2-frv-shmem/mm/nommu.c	2005-11-23 16:00:57.000000000 +0000
@@ -1177,3 +1177,9 @@ int in_gate_area_no_task(unsigned long a
 {
 	return 0;
 }
+
+struct page * filemap_nopage(struct vm_area_struct * area, unsigned long address, int *type)
+{
+	BUG();
+	return NULL;
+}
diff -uNrp linux-2.6.15-rc2-frv/mm/shmem.c linux-2.6.15-rc2-frv-shmem/mm/shmem.c
--- linux-2.6.15-rc2-frv/mm/shmem.c	2005-11-23 12:09:24.000000000 +0000
+++ linux-2.6.15-rc2-frv-shmem/mm/shmem.c	2005-11-23 16:00:57.000000000 +0000
@@ -1255,7 +1255,7 @@ out_nomem:
 	return retval;
 }
 
-static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
+int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
diff -uNrp linux-2.6.15-rc2-frv/mm/tiny-shmem.c linux-2.6.15-rc2-frv-shmem/mm/tiny-shmem.c
--- linux-2.6.15-rc2-frv/mm/tiny-shmem.c	2005-11-23 12:09:24.000000000 +0000
+++ linux-2.6.15-rc2-frv-shmem/mm/tiny-shmem.c	2005-11-23 16:46:15.000000000 +0000
@@ -81,13 +81,19 @@ struct file *shmem_file_setup(char *name
 		goto close_file;
 
 	d_instantiate(dentry, inode);
-	inode->i_size = size;
 	inode->i_nlink = 0;	/* It is unlinked */
+
 	file->f_vfsmnt = mntget(shm_mnt);
 	file->f_dentry = dentry;
 	file->f_mapping = inode->i_mapping;
 	file->f_op = &ramfs_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
+
+	/* notify everyone as to the change of file size */
+	error = do_truncate(dentry, size, file);
+	if (error < 0)
+		goto close_file;
+
 	return file;
 
 close_file:
@@ -123,3 +129,24 @@ int shmem_unuse(swp_entry_t entry, struc
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
+#ifndef CONFIG_MMU
+unsigned long shmem_get_unmapped_area(struct file *file,
+				      unsigned long addr,
+				      unsigned long len,
+				      unsigned long pgoff,
+				      unsigned long flags)
+{
+	return ramfs_nommu_get_unmapped_area(file, addr, len, pgoff, flags);
+}
+#endif

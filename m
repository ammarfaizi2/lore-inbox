Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWH3K51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWH3K51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 06:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWH3K51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 06:57:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39081 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750850AbWH3K50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 06:57:26 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] NOMMU: Set BDI capabilities for /dev/mem and /dev/kmem [try #2]
Date: Wed, 30 Aug 2006 11:57:13 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060830105713.28601.43444.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Set the backing device info capabilities for /dev/mem and /dev/kmem to permit
direct sharing under no-MMU conditions and full mapping capabilities under MMU
conditions.  Make the BDI used by these available to all directly mappable
character devices.

Also comment the capabilities for /dev/zero.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/char/mem.c   |   33 +++++++++++++++++++++++++++++++++
 fs/char_dev.c        |   20 ++++++++++++++++++++
 include/linux/cdev.h |    2 ++
 3 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 917b204..48bdf6b 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -238,6 +238,19 @@ #endif
 }
 #endif
 
+#ifndef CONFIG_MMU
+static unsigned long get_unmapped_area_mem(struct file *file,
+					   unsigned long addr,
+					   unsigned long len,
+					   unsigned long pgoff,
+					   unsigned long flags)
+{
+	if (!valid_mmap_phys_addr_range(pgoff, len))
+		return (unsigned long) -EINVAL;
+	return pgoff;
+}
+#endif
+
 static int mmap_mem(struct file * file, struct vm_area_struct * vma)
 {
 	size_t size = vma->vm_end - vma->vm_start;
@@ -245,6 +258,12 @@ static int mmap_mem(struct file * file, 
 	if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
 		return -EINVAL;
 
+#ifndef CONFIG_MMU
+	/* can't do an in-place private mapping if there's no MMU */
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return -ENOSYS;
+#endif
+
 	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
 						 size,
 						 vma->vm_page_prot);
@@ -782,6 +801,9 @@ static const struct file_operations mem_
 	.write		= write_mem,
 	.mmap		= mmap_mem,
 	.open		= open_mem,
+#ifndef CONFIG_MMU
+	.get_unmapped_area = get_unmapped_area_mem,
+#endif
 };
 
 static const struct file_operations kmem_fops = {
@@ -790,6 +812,9 @@ static const struct file_operations kmem
 	.write		= write_kmem,
 	.mmap		= mmap_kmem,
 	.open		= open_kmem,
+#ifndef CONFIG_MMU
+	.get_unmapped_area = get_unmapped_area_mem,
+#endif
 };
 
 static const struct file_operations null_fops = {
@@ -815,6 +840,10 @@ static const struct file_operations zero
 	.mmap		= mmap_zero,
 };
 
+/*
+ * capabilities for /dev/zero
+ * - permits private mappings, "copies" are taken of the source of zeros
+ */
 static struct backing_dev_info zero_bdi = {
 	.capabilities	= BDI_CAP_MAP_COPY,
 };
@@ -862,9 +891,13 @@ static int memory_open(struct inode * in
 	switch (iminor(inode)) {
 		case 1:
 			filp->f_op = &mem_fops;
+			filp->f_mapping->backing_dev_info =
+				&directly_mappable_cdev_bdi;
 			break;
 		case 2:
 			filp->f_op = &kmem_fops;
+			filp->f_mapping->backing_dev_info =
+				&directly_mappable_cdev_bdi;
 			break;
 		case 3:
 			filp->f_op = &null_fops;
diff --git a/fs/char_dev.c b/fs/char_dev.c
index 3483d3c..0009346 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -19,11 +19,30 @@ #include <linux/kobject.h>
 #include <linux/kobj_map.h>
 #include <linux/cdev.h>
 #include <linux/mutex.h>
+#include <linux/backing-dev.h>
 
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
 
+/*
+ * capabilities for /dev/mem, /dev/kmem and similar directly mappable character
+ * devices
+ * - permits shared-mmap for read, write and/or exec
+ * - does not permit private mmap in NOMMU mode (can't do COW)
+ * - no readahead or I/O queue unplugging required
+ */
+struct backing_dev_info directly_mappable_cdev_bdi = {
+	.capabilities	= (
+#ifdef CONFIG_MMU
+		/* permit private copies of the data to be taken */
+		BDI_CAP_MAP_COPY |
+#endif
+		/* permit direct mmap, for read, write or exec */
+		BDI_CAP_MAP_DIRECT |
+		BDI_CAP_READ_MAP | BDI_CAP_WRITE_MAP | BDI_CAP_EXEC_MAP),
+};
+
 static struct kobj_map *cdev_map;
 
 static DEFINE_MUTEX(chrdevs_lock);
@@ -461,3 +480,4 @@ EXPORT_SYMBOL(cdev_del);
 EXPORT_SYMBOL(cdev_add);
 EXPORT_SYMBOL(register_chrdev);
 EXPORT_SYMBOL(unregister_chrdev);
+EXPORT_SYMBOL(directly_mappable_cdev_bdi);
diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index 2216638..ee5f53f 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -23,5 +23,7 @@ void cdev_del(struct cdev *);
 
 void cd_forget(struct inode *);
 
+extern struct backing_dev_info directly_mappable_cdev_bdi;
+
 #endif
 #endif

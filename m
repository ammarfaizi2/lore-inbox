Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbWH2SBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbWH2SBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWH2SBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:01:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13280 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965197AbWH2SBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:01:03 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/2] NOMMU: Set BDI capabilities for /dev/mem and /dev/kmem
Date: Tue, 29 Aug 2006 18:59:49 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060829175949.32281.21374.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Set the backing device info capabilities for /dev/mem and /dev/kmem to permit
direct sharing under no-MMU conditions.

Also comment the capabilities for /dev/zero.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/char/mem.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 917b204..4c29619 100644
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
@@ -815,10 +840,25 @@ static const struct file_operations zero
 	.mmap		= mmap_zero,
 };
 
+/*
+ * capabilities for /dev/zero
+ * - permits private mappings, "copies" are taken of the source of zeros
+ */
 static struct backing_dev_info zero_bdi = {
 	.capabilities	= BDI_CAP_MAP_COPY,
 };
 
+/*
+ * capabilities for /dev/mem and /dev/kmem
+ * - permits shared mmap for read, write and/or exec
+ * - does not permit private mmap (add BDI_CAP_MAP_COPY to permit this)
+ */
+static struct backing_dev_info mem_bdi = {
+	.capabilities	= (BDI_CAP_MAP_DIRECT |
+			   BDI_CAP_READ_MAP | BDI_CAP_WRITE_MAP |
+			   BDI_CAP_EXEC_MAP),
+};
+
 static const struct file_operations full_fops = {
 	.llseek		= full_lseek,
 	.read		= read_full,
@@ -861,9 +901,11 @@ static int memory_open(struct inode * in
 {
 	switch (iminor(inode)) {
 		case 1:
+			filp->f_mapping->backing_dev_info = &mem_bdi;
 			filp->f_op = &mem_fops;
 			break;
 		case 2:
+			filp->f_mapping->backing_dev_info = &mem_bdi;
 			filp->f_op = &kmem_fops;
 			break;
 		case 3:

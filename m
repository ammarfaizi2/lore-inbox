Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbULHHjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbULHHjC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbULHHho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:37:44 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:50570 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262056AbULHHai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:30:38 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org,
       Ian.Pratt@cl.cam.ac.uk
Subject: [4/6] Xen VMM #4: HAS_ARCH_DEV_MEM
In-reply-to: Your message of "Wed, 08 Dec 2004 07:28:16 GMT."
             <E1CbwFE-0006PZ-00@mta1.cl.cam.ac.uk> 
Date: Wed, 08 Dec 2004 07:30:31 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CbwHQ-0006Zf-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds ARCH_HAS_DEV_MEM, enabling per-architecture
implementations of /dev/mem and thus avoids a number of messy
#ifdef's. Although the mmap case can be solved easily be simply using
io_remap_page_range instead of remap_pfn_range on all architecutres,
we need to support read/write of /dev/mem in order for dmidecode etc
to work. These changes are more messy, and we believe warrant making
/dev/mem arch specific, which also cleans up uncached_access too.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---


diff -Nurp pristine-linux-2.6.10-rc3/drivers/char/mem.c tmp-linux-2.6.10-rc3-xen.patch/drivers/char/mem.c
--- pristine-linux-2.6.10-rc3/drivers/char/mem.c	2004-12-03 21:53:47.000000000 +0000
+++ tmp-linux-2.6.10-rc3-xen.patch/drivers/char/mem.c	2004-12-08 00:52:40.000000000 +0000
@@ -143,7 +143,7 @@ static ssize_t do_write_mem(void *p, uns
 	return written;
 }
 
-
+#ifndef ARCH_HAS_DEV_MEM
 /*
  * This funcion reads the *physical* memory. The f_pos points directly to the 
  * memory location. 
@@ -189,8 +189,9 @@ static ssize_t write_mem(struct file * f
 		return -EFAULT;
 	return do_write_mem(__va(p), p, buf, count, ppos);
 }
+#endif
 
-static int mmap_mem(struct file * file, struct vm_area_struct * vma)
+static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
 {
 #ifdef pgprot_noncached
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
@@ -567,7 +568,7 @@ static int open_port(struct inode * inod
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-#define mmap_kmem	mmap_mem
+#define mmap_mem	mmap_kmem
 #define zero_lseek	null_lseek
 #define full_lseek      null_lseek
 #define write_zero	write_null
@@ -575,6 +576,7 @@ static int open_port(struct inode * inod
 #define open_mem	open_port
 #define open_kmem	open_mem
 
+#ifndef ARCH_HAS_DEV_MEM
 static struct file_operations mem_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_mem,
@@ -582,6 +584,9 @@ static struct file_operations mem_fops =
 	.mmap		= mmap_mem,
 	.open		= open_mem,
 };
+#else
+extern struct file_operations mem_fops;
+#endif
 
 static struct file_operations kmem_fops = {
 	.llseek		= memory_lseek,


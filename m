Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbUK3CPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbUK3CPI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUK3CMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:12:52 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:47832 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261941AbUK3CMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:12:18 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org,
       Ian.Pratt@cl.cam.ac.uk
Subject: [4/7] Xen VMM #3: ARCH_HAS_DEV_MEM
In-reply-to: Your message of "Tue, 30 Nov 2004 02:03:45 GMT."
             <E1CYxMo-0005GB-00@mta1.cl.cam.ac.uk> 
Date: Tue, 30 Nov 2004 02:12:09 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CYxUv-0005Ll-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds ARCH_HAS_DEV_MEM, enabling per-architecture
implementations of /dev/mem and thus avoids a number of messy
#ifdef's. In arch xen we need to use different functions for mapping
bus vs physical addresses. This allows the X server and dmidecode etc
to work as per normal.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---


diff -Nurp pristine-linux-2.6.10-rc2/drivers/char/mem.c tmp-linux-2.6.10-rc2-xen.patch/drivers/char/mem.c
--- pristine-linux-2.6.10-rc2/drivers/char/mem.c	2004-11-30 01:19:43.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/drivers/char/mem.c	2004-11-30 01:42:12.000000000 +0000
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
@@ -208,6 +209,7 @@ static int mmap_mem(struct file * file, 
 			    vma->vm_end-vma->vm_start,
 			    vma->vm_page_prot))
 		return -EAGAIN;
+
 	return 0;
 }
 
@@ -567,7 +569,7 @@ static int open_port(struct inode * inod
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-#define mmap_kmem	mmap_mem
+#define mmap_mem	mmap_kmem
 #define zero_lseek	null_lseek
 #define full_lseek      null_lseek
 #define write_zero	write_null
@@ -575,6 +577,7 @@ static int open_port(struct inode * inod
 #define open_mem	open_port
 #define open_kmem	open_mem
 
+#ifndef ARCH_HAS_DEV_MEM
 static struct file_operations mem_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_mem,
@@ -582,6 +585,9 @@ static struct file_operations mem_fops =
 	.mmap		= mmap_mem,
 	.open		= open_mem,
 };
+#else
+extern struct file_operations mem_fops;
+#endif
 
 static struct file_operations kmem_fops = {
 	.llseek		= memory_lseek,

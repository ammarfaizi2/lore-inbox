Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUFVQu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUFVQu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUFVP0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:26:37 -0400
Received: from holomorphy.com ([207.189.100.168]:45443 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264920AbUFVPSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:18:11 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [23/23] add mmap() support for /proc/profile
Message-ID: <0406220818.3aWaYa1aKb3aHbWaYaMbJb3aLbIbXa3aWa1aLbMbKb1a0aLb1a3aZaLbHb2a3a2a15250@holomorphy.com>
In-Reply-To: <0406220817.IbZaYa0a2aZaKb5aIbJbYaXa4aIbIbZaZaWa3aZa5a2a2aHbIbMbZa0aMbHbHbKb15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:18:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow mmap() on /proc/profile.

Index: prof-2.6.7/kernel/profile.c
===================================================================
--- prof-2.6.7.orig/kernel/profile.c	2004-06-22 07:26:01.925749024 -0700
+++ prof-2.6.7/kernel/profile.c	2004-06-22 07:26:02.811614352 -0700
@@ -8,10 +8,11 @@
 #include <linux/bootmem.h>
 #include <linux/notifier.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <asm/sections.h>
 
 static atomic_t *prof_buffer;
-static unsigned long prof_len, prof_shift;
+static unsigned long prof_len, prof_shift, prof_pages;
 static int prof_on;
 
 int __init profile_setup(char * str)
@@ -33,7 +34,8 @@
  
 	/* only text is profiled */
 	prof_len = ((unsigned long)(_etext - _stext) + 1) >> prof_shift;
-	prof_buffer = alloc_bootmem(sizeof(atomic_t)*prof_len);
+	prof_buffer = alloc_bootmem_pages(sizeof(atomic_t)*prof_len);
+	prof_pages = PAGE_ALIGN(prof_len*sizeof(atomic_t))/PAGE_SIZE;
 	atomic_set(prof_buffer, 1 << prof_shift);
 }
 
@@ -167,6 +169,7 @@
 EXPORT_SYMBOL_GPL(profile_event_unregister);
 
 #ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
 /*
  * This function accesses profiling information. The returned data is
  * binary: the sampling step and the actual contents of the profile
@@ -214,9 +217,37 @@
 	return count;
 }
 
+static struct page *profile_nopage(struct vm_area_struct *vma,
+						unsigned long vaddr, int *type)
+{
+	void *kvaddr;
+
+	if (linear_page_index(vma, vaddr) > prof_pages) {
+		*type = VM_FAULT_SIGBUS;
+		return NOPAGE_SIGBUS;
+	}
+	kvaddr = (void *)(PAGE_SIZE*vma->vm_pgoff + vaddr - vma->vm_start);
+	*type = VM_FAULT_MINOR;
+	return virt_to_page(kvaddr);
+}
+
+static struct vm_operations_struct profile_vm_ops = {
+	.nopage = profile_nopage,
+};
+
+static int mmap_profile(struct file *file, struct vm_area_struct *vma)
+{
+	if (vma->vm_pgoff + vma_pages(vma) > prof_pages)
+		return -ENODEV;
+	vma->vm_flags |= VM_RESERVED|VM_IO;
+	vma->vm_ops = &profile_vm_ops;
+	return 0;
+}
+
 static struct file_operations proc_profile_operations = {
 	.read		= read_profile,
 	.write		= write_profile,
+	.mmap		= mmap_profile,
 };
 
 void create_proc_profile(void)

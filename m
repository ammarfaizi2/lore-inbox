Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264422AbUFVRNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbUFVRNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbUFVRMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:12:24 -0400
Received: from holomorphy.com ([207.189.100.168]:13444 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264422AbUFVRDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:03:43 -0400
Date: Tue, 22 Jun 2004 10:03:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: rddunlap@osdl.org
Subject: Re: [profile]: [23/23] add mmap() support for /proc/profile
Message-ID: <20040622170340.GC2135@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, rddunlap@osdl.org
References: <0406220817.IbZaYa0a2aZaKb5aIbJbYaXa4aIbIbZaZaWa3aZa5a2a2aHbIbMbZa0aMbHbHbKb15250@holomorphy.com> <0406220818.3aWaYa1aKb3aHbWaYaMbJb3aLbIbXa3aWa1aLbMbKb1a0aLb1a3aZaLbHb2a3a2a15250@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0406220818.3aWaYa1aKb3aHbWaYaMbJb3aLbIbXa3aWa1aLbMbKb1a0aLb1a3aZaLbHb2a3a2a15250@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 08:18:10AM -0700, William Lee Irwin III wrote:
> Allow mmap() on /proc/profile.

Stale code. =(

The working version is:

Index: prof-2.6.7/kernel/profile.c
===================================================================
--- prof-2.6.7.orig/kernel/profile.c	2004-06-22 08:28:12.237655416 -0700
+++ prof-2.6.7/kernel/profile.c	2004-06-22 08:28:13.102523936 -0700
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
@@ -180,7 +183,7 @@
 
 	if (p >= sizeof(atomic_t)*prof_len)
 		return 0;
-	count = min(prof_len*sizeof(atomic_t) - p, count);
+	count = min_t(size_t, prof_len*sizeof(atomic_t) - p, count);
 	if (copy_to_user(buf, (char *)prof_buffer + p, count))
 		return -EFAULT;
 	*ppos += count;
@@ -210,13 +213,44 @@
 	}
 #endif
 
-	memset(prof_buffer, 0, prof_len*sizeof(atomic_t));
+	memset(&prof_buffer[1], 0, (prof_len - 1)*sizeof(atomic_t));
 	return count;
 }
 
+static int mmap_profile(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long pfn, vaddr, base_pfn = __pa(prof_buffer)/PAGE_SIZE;
+	if (vma->vm_pgoff + vma_pages(vma) > prof_pages)
+		return -ENODEV;
+	vma->vm_flags |= VM_RESERVED|VM_IO;
+	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
+		pgd_t *pgd = pgd_offset(vma->vm_mm, vaddr);
+		pmd_t *pmd;
+		pte_t *pte, pte_val;
+		spin_lock(&vma->vm_mm->page_table_lock);
+		pmd = pmd_alloc(vma->vm_mm, pgd, vaddr);
+		if (!pmd)
+			goto enomem;
+		pte = pte_alloc_map(vma->vm_mm, pmd, vaddr);
+		if (!pte)
+			goto enomem;
+		pfn = base_pfn + linear_page_index(vma, vaddr);
+		pte_val = pfn_pte(pfn, vma->vm_page_prot);
+		set_pte(pte, pte_val);
+		update_mmu_cache(vma, vaddr, pte_val);
+		pte_unmap(pte);
+		spin_unlock(&vma->vm_mm->page_table_lock);
+	}
+	return 0;
+enomem:
+	spin_unlock(&vma->vm_mm->page_table_lock);
+	return -ENOMEM;
+}
+
 static struct file_operations proc_profile_operations = {
 	.read		= read_profile,
 	.write		= write_profile,
+	.mmap		= mmap_profile,
 };
 
 void create_proc_profile(void)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267129AbTAPR71>; Thu, 16 Jan 2003 12:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbTAPR70>; Thu, 16 Jan 2003 12:59:26 -0500
Received: from [65.193.106.66] ([65.193.106.66]:18976 "EHLO
	xchangeserver2.storigen.com") by vger.kernel.org with ESMTP
	id <S267129AbTAPR7X> convert rfc822-to-8bit; Thu, 16 Jan 2003 12:59:23 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: [PATCH] drivers/char/mem.c, kernel 2.4.20: fix mmap /dev/kmem and vmalloc'd addresses
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 16 Jan 2003 13:08:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <7BFCE5F1EF28D64198522688F5449D5AE4CC07@xchangeserver2.storigen.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] drivers/char/mem.c, kernel 2.4.20: fix mmap /dev/kmem and vmalloc'd addresses
Thread-Index: AcK9ij2FAGZeJVy0Qe2VRoAh77XnNw==
From: "Tony Dziedzic" <Tony.Dziedzic@storigen.com>
To: <linux-kernel@vger.kernel.org>
Cc: <marcelo@conectiva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mmap'ing kernel virtual addresses above high_memory using /dev/kmem returns different results than reads of /dev/kmem.  The problem occurs because the call to remap_page_range in mmap_mem assumes a physically-contiguous region of memory that is allocated below high_memory; this isn't the case for (e.g.) vmalloc'd memory.

The attached patch creates a unique mmap routine for /dev/kmem that uses the "nopage" vm_operations_struct function to construct a correct mapping to kernel memory when a page is accessed via the user virtual address.  A simple test program verifies that the patch corrects the different values returned when reading /dev/kmem as compared to mmap'ing /dev/kmem.

Joseph "Tony" Dziedzic
Storigen Systems, Inc.

--- linux-2.4.20/drivers/char/mem.c	Fri Aug  2 20:39:43 2002
+++ linux-2.4.20-patch/drivers/char/mem.c	Thu Jan 16 11:26:36 2003
@@ -520,7 +520,91 @@
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-#define mmap_kmem	mmap_mem
+struct page *kmem_vm_nopage(struct vm_area_struct *vma, unsigned long address, int write)
+{
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long kaddr;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *ptep, pte;
+	struct page *page = NULL;
+
+	/* address is user VA; convert to kernel VA of desired page */
+	kaddr = (address - vma->vm_start) + offset;
+	kaddr = VMALLOC_VMADDR(kaddr);
+
+	spin_lock(&init_mm.page_table_lock);
+
+	/* Lookup page structure for kernel VA */
+	pgd = pgd_offset(&init_mm, kaddr);
+	if (pgd_none(*pgd) || pgd_bad(*pgd))
+		goto out;
+	pmd = pmd_offset(pgd, kaddr);
+	if (pmd_none(*pmd) || pmd_bad(*pmd))
+		goto out;
+	ptep = pte_offset(pmd, kaddr);
+	if (!ptep)
+		goto out;
+	pte = *ptep;
+	if (!pte_present(pte))
+		goto out;
+	if (write && !pte_write(pte))
+		goto out;
+	page = pte_page(pte);
+	if (!VALID_PAGE(page)) {
+		page = NULL;
+		goto out;
+	}
+
+	/* Increment reference count on page */
+	get_page(page);
+
+out:
+	spin_unlock(&init_mm.page_table_lock);
+
+	return page;
+}
+
+struct vm_operations_struct kmem_vm_ops = {
+	nopage:		kmem_vm_nopage,
+};
+
+static int mmap_kmem(struct file * file, struct vm_area_struct * vma)
+{
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long size = vma->vm_end - vma->vm_start;
+
+	/*
+	 * If the user is not attempting to mmap a high memory address then
+	 * the standard mmap_mem mechanism will work.  High memory addresses
+	 * need special handling, as remap_page_range expects a physically-
+	 * contiguous range of kernel addresses (such as obtained in kmalloc).
+	 */
+	if ((offset + size) < (unsigned long) high_memory)
+		return mmap_mem(file, vma);
+
+	/*
+	 * Accessing memory above the top the kernel knows about or
+	 * through a file pointer that was marked O_SYNC will be
+	 * done non-cached.
+	 */
+	if (noncached_address(offset) || (file->f_flags & O_SYNC))
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	/* Don't do anything here; "nopage" will fill the holes */
+	vma->vm_ops = &kmem_vm_ops;
+
+	/* Don't try to swap out physical pages.. */
+	vma->vm_flags |= VM_RESERVED;
+
+	/*
+	 * Don't dump addresses that are not real memory to a core file.
+	 */
+	vma->vm_flags |= VM_IO;
+
+	return 0;
+}
+
 #define zero_lseek	null_lseek
 #define full_lseek      null_lseek
 #define write_zero	write_null

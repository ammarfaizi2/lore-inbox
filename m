Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265802AbSKAWua>; Fri, 1 Nov 2002 17:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265804AbSKAWua>; Fri, 1 Nov 2002 17:50:30 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:55508 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S265808AbSKAWu1>; Fri, 1 Nov 2002 17:50:27 -0500
Date: Fri, 1 Nov 2002 23:56:20 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: Huge TLB pages always physically continious?
Message-ID: <20021101235620.A5263@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Spam-Score: -5.2 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *187kik-0000lX-00*/AN1uY.td6w*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there,

are huge TLB pages always physically continous in memory?

What does follow_hugetlb_page do exactly? I simply don't
understand what the code does.

I would like to build up a simplified get_user_pages_sgl() to
build a scatter gather list from user space adresses.

If I want to coalesce physically continous pages (if they are
also virtually continious) anyway, can I write up a simplified
follow_hugetlb_page_sgl() function which handles the huge page
really as only one page?

Motivation:

Currently doing scatter gather DMA of user pages requires THREE
runs over the pages and I would like to save at least the second
one and possibly shorten the third one.

The three steps required:

   1) get_user_pages() to obtain the pages and lock them in page_cache
   2) translate the vector of pointers to struct page to a vector
      of struct scatterlist
   3) pci_map_sg() a decent amount[1], DMA it, wait for completion 
      or abortion, pci_unmap_sg() it and start again with the remainder

Step 2) could be eliminated completely and also the allocation of
the temporary vector of struct page.

Step 3) could be shortend, if I coalesce physically continous
ranges into a single scatterlist entry with just a ->length
bigger than PAGE_SIZE. I know that this is only worth it on
architectures, where physical address == bus address.

As each step is a for() loop and should be considered running on
more than 1MB worth of memory, I see significant improvements.

Without supporting huge TLB pages, I only add 700 bytes to the
kernel while simply copying get_user_pages() into a function,
which takes an vector of struct scatterlist instead of struct
page.

This sounds a promising tradeoff for a first time implementation.

Patch attached. No users yet, but they will follow. First
candidate is the v4l DMA stuff.

Regards

Ingo Oeser

[1] How much can I safely map on the strange architectures, where
   this is a limited? AFAIK there is no value or function telling
   me how far I can go.
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="get_user_pages_sgl.patch"

diff -Naur linux-2.5.44/kernel/ksyms.c linux-2.5.44-ioe/kernel/ksyms.c
--- linux-2.5.44/kernel/ksyms.c	Sat Oct 19 06:01:08 2002
+++ linux-2.5.44-ioe/kernel/ksyms.c	Fri Nov  1 23:12:48 2002
@@ -136,6 +136,7 @@
 EXPORT_SYMBOL(page_address);
 #endif
 EXPORT_SYMBOL(get_user_pages);
+EXPORT_SYMBOL(get_user_pages_sgl);
 
 /* filesystem internal functions */
 EXPORT_SYMBOL(def_blk_fops);
diff -Naur linux-2.5.44/mm/memory.c linux-2.5.44-ioe/mm/memory.c
--- linux-2.5.44/mm/memory.c	Sat Oct 19 06:01:52 2002
+++ linux-2.5.44-ioe/mm/memory.c	Fri Nov  1 23:48:42 2002
@@ -49,6 +49,7 @@
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
+#include <asm/scatterlist.h>
 
 #include <linux/swapops.h>
 
@@ -514,6 +515,85 @@
 }
 
 
+int get_user_pages_sgl(struct task_struct *tsk, struct mm_struct *mm,
+		unsigned long start, int len, int write,
+		struct scatterlist **sgl)
+{
+	int i;
+	unsigned int flags;
+
+	/* Without this structure, it makes no sense to call this */
+	BUG_ON(!sgl);
+
+	/* 
+	 * Require read or write permissions.
+	 */
+	flags = write ? VM_WRITE : VM_READ;
+	i = 0;
+
+	do {
+		struct vm_area_struct *	vma;
+
+		vma = find_extend_vma(mm, start);
+
+		if (!vma || (vma->vm_flags & VM_IO)
+				|| !(flags & vma->vm_flags))
+			return i ? : -EFAULT;
+
+		/* Doesn't work with huge pages! */
+		BUG_ON(is_vm_hugetlb_page(vma));
+		
+		spin_lock(&mm->page_table_lock);
+		do {
+			struct page *map;
+			while (!(map = follow_page(mm, start, write))) {
+				spin_unlock(&mm->page_table_lock);
+				switch (handle_mm_fault(mm,vma,start,write)) {
+				case VM_FAULT_MINOR:
+					tsk->min_flt++;
+					break;
+				case VM_FAULT_MAJOR:
+					tsk->maj_flt++;
+					break;
+				case VM_FAULT_SIGBUS:
+					return i ? i : -EFAULT;
+				case VM_FAULT_OOM:
+					return i ? i : -ENOMEM;
+				default:
+					BUG();
+				}
+				spin_lock(&mm->page_table_lock);
+			}
+			sgl[i]->page = get_page_map(map);
+			if (!sgl[i]->page) {
+				spin_unlock(&mm->page_table_lock);
+				while (i--)
+					page_cache_release(sgl[i]->page);
+				i = -EFAULT;
+				goto out;
+			}
+			if (!PageReserved(sgl[i]->page))
+				page_cache_get(sgl[i]->page);
+			
+			/* TODO: Do coalescing of physically continious pages
+			 * here
+			 */
+			sgl[i]->offset=0;
+			sgl[i]->length=PAGE_SIZE;
+
+			i++;
+			start += PAGE_SIZE;
+			len--;
+		} while(len && start < vma->vm_end);
+		spin_unlock(&mm->page_table_lock);
+	} while(len);
+	
+	/* This might be pointless, if start is always aligned to pages */
+	sgl[0]->offset=start & ~PAGE_MASK;
+	sgl[0]->length=PAGE_SIZE - (start & ~PAGE_MASK);
+out:
+	return i;
+}
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)

--6TrnltStXW4iwmi0--

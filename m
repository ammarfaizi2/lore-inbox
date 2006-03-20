Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWCTNgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWCTNgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWCTNgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:36:38 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:42647 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751124AbWCTNgh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:36:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PRP25BARt+5/cRaHSwH+ud1kpzdKWbwT4r371RKX1lbK6g5fVAsk/V8NYojgBArwvwK1FI96qRjInJqbPanBzPgv+/RnG0sRALtTGdB8S5A9u3RyKc3tPOgyJgaPErRS986ZrB6YGLoORj9crhcvynBflhUXXxCFsAMHsoCQuzU=
Message-ID: <bc56f2f0603200536scb87a8ck@mail.gmail.com>
Date: Mon, 20 Mar 2006 08:36:35 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: akpm@osdl.org
Subject: PATCH][1/8] 2.6.15 mlock: make_pages_wired/unwired
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add make_pages_unwired routine.
2. Replace make_pages_present with make_pages_wired, support rollback.
3. Pass 1 more param ("wire") to get_user_pages.

Signed-off-by: Shaoping Wang <pwstone@gmail.com>


--
 include/linux/mm.h |    8 ++++--
 mm/memory.c        |   65 +++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 11 deletions(-)

diff -urN  linux-2.6.15.orig/include/linux/mm.h linux-2.6.15/include/linux/mm.h
--- linux-2.6.15.orig/include/linux/mm.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/include/linux/mm.h	2006-03-07 01:49:12.000000000 -0500
@@ -59,6 +59,9 @@
 	unsigned long vm_start;		/* Our start address within vm_mm. */
 	unsigned long vm_end;		/* The first byte after our end address
 					   within vm_mm. */
+	int vm_wire_change;			/* VM_LOCKED bit of vm_flags was just changed.
+								 * For rollback support of sys_mlock series system calls.
+								 */

 	/* linked list of VM areas per task, sorted by address */
 	struct vm_area_struct *vm_next;
@@ -699,12 +706,13 @@
 	return __handle_mm_fault(mm, vma, address, write_access) & (~VM_FAULT_WRITE);
 }

-extern int make_pages_present(unsigned long addr, unsigned long end);
+extern int make_pages_wired(unsigned long addr, unsigned long end);
+void make_pages_unwired(struct mm_struct *mm, unsigned long addr,
unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long
addr, void *buf, int len, int write);
 void install_arg_page(struct vm_area_struct *, struct page *, unsigned long);

 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
unsigned long start,
-		int len, int write, int force, struct page **pages, struct
vm_area_struct **vmas);
+		int len, int write, int force, int wire, struct page **pages,
struct vm_area_struct **vmas);
 void print_bad_pte(struct vm_area_struct *, pte_t, unsigned long);

 int __set_page_dirty_buffers(struct page *page);
diff -urN  linux-2.6.15.orig/mm/memory.c linux-2.6.15/mm/memory.c
--- linux-2.6.15.orig/mm/memory.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/memory.c	2006-03-07 11:14:59.000000000 -0500
@@ -950,8 +950,30 @@
 	return page;
 }

+void make_pages_unwired(struct mm_struct *mm,
+					unsigned long start,unsigned long end)
+{
+	struct vm_area_struct *vma;
+	struct page *page;
+	unsigned int foll_flags;
+
+	foll_flags =0;
+
+	vma=find_vma(mm,start);
+	if(!vma)
+		BUG();
+	if(is_vm_hugetlb_page(vma))
+		return;
+	
+	for(; start<end ; start+=PAGE_SIZE) {
+		page=follow_page(vma,start,foll_flags);
+		if(page)
+			unwire_page(page);
+	}
+}
+
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long start, int len, int write, int force,
+		unsigned long start, int len, int write,int force, int wire,
 		struct page **pages, struct vm_area_struct **vmas)
 {
 	int i;
@@ -973,6 +995,7 @@
 		if (!vma && in_gate_area(tsk, start)) {
 			unsigned long pg = start & PAGE_MASK;
 			struct vm_area_struct *gate_vma = get_gate_vma(tsk);
+			struct page *page;	
 			pgd_t *pgd;
 			pud_t *pud;
 			pmd_t *pmd;
@@ -994,6 +1017,7 @@
 				pte_unmap(pte);
 				return i ? : -EFAULT;
 			}
+			page = vm_normal_page(gate_vma, start, *pte);
 			if (pages) {
 				struct page *page = vm_normal_page(gate_vma, start, *pte);
 				pages[i] = page;
@@ -1003,9 +1027,12 @@
 			pte_unmap(pte);
 			if (vmas)
 				vmas[i] = gate_vma;
+			if(wire)
+				wire_page(page);
 			i++;
 			start += PAGE_SIZE;
 			len--;
+
 			continue;
 		}

@@ -1013,6 +1040,7 @@
 				|| !(vm_flags & vma->vm_flags))
 			return i ? : -EFAULT;

+		/* We dont account wired HugeTLB pages */
 		if (is_vm_hugetlb_page(vma)) {
 			i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &len, i);
@@ -1067,17 +1095,20 @@
 			}
 			if (vmas)
 				vmas[i] = vma;
+			if(wire)
+				wire_page(page);
 			i++;
 			start += PAGE_SIZE;
 			len--;
 		} while (len && start < vma->vm_end);
 	} while (len);
+
 	return i;
 }
 EXPORT_SYMBOL(get_user_pages);

-static int zeromap_pte_range(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, unsigned long end, pgprot_t prot)
+static int zeromap_pte_range(struct mm_struct *mm, struct vm_area_struct *vma,
+			pmd_t *pmd, unsigned long addr, unsigned long end, pgprot_t prot)
 {
 	pte_t *pte;
 	spinlock_t *ptl;

@@ -2306,10 +2338,13 @@
 }
 #endif /* __PAGETABLE_PMD_FOLDED */

-int make_pages_present(unsigned long addr, unsigned long end)
+int make_pages_wired(unsigned long addr, unsigned long end)
 {
 	int ret, len, write;
+	struct page *page;
 	struct vm_area_struct * vma;
+	struct mm_struct *mm=current->mm;
+	int wire_change;

 	vma = find_vma(current->mm, addr);
 	if (!vma)
@@ -2320,13 +2355,26 @@
 	if (end > vma->vm_end)
 		BUG();
 	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
-	ret = get_user_pages(current, current->mm, addr,
-			len, write, 0, NULL, NULL);
-	if (ret < 0)
-		return ret;
-	return ret == len ? 0 : -1;
+	wire_change = vma->vm_wire_change;
+	vma->vm_wire_change = 1;
+	ret = get_user_pages(current, mm, addr,
+			len, write, 1, 1, NULL, NULL); /* write,set_wire */
+	vma->vm_wire_change = wire_change;
+	if(ret < len) {
+	    for(; addr< end ; addr += PAGE_SIZE) {
+        	page=follow_page(vma,addr,0);
+            if(page)
+				unwire_page(page);
+			else
+				BUG();
+   		}
+		return -1;
+	}
+	else
+		return 0;
 }

+
 /*
  * Map a vmalloc()-space virtual address to the physical page.
  */

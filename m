Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbREQVAn>; Thu, 17 May 2001 17:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbREQVAe>; Thu, 17 May 2001 17:00:34 -0400
Received: from [216.156.138.34] ([216.156.138.34]:11016 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S262128AbREQVAU>;
	Thu, 17 May 2001 17:00:20 -0400
Message-ID: <3B043BBF.6F8E7B7C@colorfullife.com>
Date: Thu, 17 May 2001 22:59:43 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new version of singlecopy pipe
In-Reply-To: <3AFC36BA.B71FC470@colorfullife.com>
				<20010512020742.A1054@werewolf.able.es>
				<15100.33537.982370.753962@pizda.ninka.net>
				<20010512095057.A2539@werewolf.able.es> <15100.62190.251880.613889@pizda.ninka.net>
Content-Type: multipart/mixed;
 boundary="------------E55B0C43118DD5CE878A9037"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E55B0C43118DD5CE878A9037
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"David S. Miller" wrote:
> 
> J . A . Magallon writes:
>  > > What platform?
> 
>  > Any more info ?
> 
> No, I thought it might be some cache flushing issue
> on a non-x86 machine.
> 
I found the problem: 
I sent out the old patch :-(

Attached is the correct version of patch-copy_user_user.

--
	Manfred
--------------E55B0C43118DD5CE878A9037
Content-Type: text/plain; charset=us-ascii;
 name="patch-copy_user_user"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-copy_user_user"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 4
//  EXTRAVERSION = -ac8
--- 2.4/kernel/ptrace.c	Sat Mar 31 21:49:29 2001
+++ build-2.4/kernel/ptrace.c	Thu May 17 19:43:09 2001
@@ -19,13 +19,14 @@
 /*
  * Access another process' address space, one page at a time.
  */
-static int access_one_page(struct mm_struct * mm, struct vm_area_struct * vma, unsigned long addr, void *buf, int len, int write)
+static int access_one_page(struct mm_struct * mm, struct vm_area_struct * vma, unsigned long addr, void *buf, size_t len, int write)
 {
 	pgd_t * pgdir;
 	pmd_t * pgmiddle;
 	pte_t * pgtable;
 	char *maddr; 
 	struct page *page;
+	int i;
 
 repeat:
 	spin_lock(&mm->page_table_lock);
@@ -50,7 +51,7 @@
 	if (page != ZERO_PAGE(addr) || write) {
 		if ((!VALID_PAGE(page)) || PageReserved(page)) {
 			spin_unlock(&mm->page_table_lock);
-			return 0;
+			return OTHER_EFAULT;
 		}
 	}
 	get_page(page);
@@ -59,38 +60,40 @@
 
 	if (write) {
 		maddr = kmap(page);
-		memcpy(maddr + (addr & ~PAGE_MASK), buf, len);
+		i = copy_from_user(maddr + (addr & ~PAGE_MASK), buf, len);
 		flush_page_to_ram(page);
 		flush_icache_page(vma, page);
 		kunmap(page);
 	} else {
 		maddr = kmap(page);
-		memcpy(buf, maddr + (addr & ~PAGE_MASK), len);
+		i = copy_to_user(buf, maddr + (addr & ~PAGE_MASK), len);
 		flush_page_to_ram(page);
 		kunmap(page);
 	}
 	put_page(page);
-	return len;
+	return i ? CUR_EFAULT : 0;
 
 fault_in_page:
 	spin_unlock(&mm->page_table_lock);
 	/* -1: out of memory. 0 - unmapped page */
-	if (handle_mm_fault(mm, vma, addr, write) > 0)
+	i = handle_mm_fault(mm, vma, addr, write);
+	if (i > 0)
 		goto repeat;
-	return 0;
-
+	if (i < 0)
+		return OTHER_ENOMEM;
+	return OTHER_EFAULT;
 bad_pgd:
 	spin_unlock(&mm->page_table_lock);
 	pgd_ERROR(*pgdir);
-	return 0;
+	return OTHER_EFAULT;
 
 bad_pmd:
 	spin_unlock(&mm->page_table_lock);
 	pmd_ERROR(*pgmiddle);
-	return 0;
+	return OTHER_EFAULT;
 }
 
-static int access_mm(struct mm_struct *mm, struct vm_area_struct * vma, unsigned long addr, void *buf, int len, int write)
+static int access_mm(struct mm_struct *mm, struct vm_area_struct * vma, unsigned long addr, void *buf, size_t len, int write, int *pcopied)
 {
 	int copied = 0;
 
@@ -102,30 +105,36 @@
 		if (this_len > len)
 			this_len = len;
 		retval = access_one_page(mm, vma, addr, buf, this_len, write);
-		copied += retval;
-		if (retval != this_len)
-			break;
+		if (retval) {
+			if (pcopied)
+				*pcopied = copied;
+			return retval;
+		}
+		copied += this_len;
 
-		len -= retval;
+		len -= this_len;
 		if (!len)
 			break;
 
-		addr += retval;
-		buf += retval;
+		addr += this_len;
+		buf += this_len;
 
 		if (addr < vma->vm_end)
 			continue;	
-		if (!vma->vm_next)
-			break;
-		if (vma->vm_next->vm_start != vma->vm_end)
-			break;
+		if (!vma->vm_next || vma->vm_next->vm_start != vma->vm_end) {
+			if (pcopied)
+				*pcopied = copied;
+			return OTHER_EFAULT;
+		}
 	
 		vma = vma->vm_next;
 	}
-	return copied;
+	if (pcopied)
+		*pcopied = copied;
+	return 0;
 }
 
-int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
+int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, size_t len, int write)
 {
 	int copied;
 	struct mm_struct *mm;
@@ -143,12 +152,44 @@
 	down_read(&mm->mmap_sem);
 	vma = find_extend_vma(mm, addr);
 	copied = 0;
-	if (vma)
-		copied = access_mm(mm, vma, addr, buf, len, write);
+	if (vma) {
+		mm_segment_t old;
+		old = get_fs();
+		set_fs(KERNEL_DS);
+		/* silently ignore failues, perhaps the caller
+		 * is interested in partial transfers
+		 */
+		access_mm(mm, vma, addr, buf, len, write, &copied);
+		set_fs(old);
+	}
 
 	up_read(&mm->mmap_sem);
 	mmput(mm);
 	return copied;
+}
+
+/* 
+ * transfers 'len' bytes from/to from 'mm:oaddr' to/from
+ * 'current->mm:cbuf'.
+ * The caller must guarantee that mm won't go away.
+ * if do_write is true, then the data is written into 'mm:oaddr' 
+ * Return 0 on success.
+ */
+
+
+int copy_user_to_user(char *cbuf, struct mm_struct *mm, unsigned long oaddr, size_t len, int do_write)
+{
+	struct vm_area_struct * vma;
+	int retval;
+	down_read(&mm->mmap_sem);
+	vma = find_extend_vma(mm, oaddr);
+	if (vma)
+		retval = access_mm(mm, vma, oaddr, cbuf, len, do_write, NULL);
+	else
+		retval = OTHER_EFAULT;
+
+	up_read(&mm->mmap_sem);
+	return retval;
 }
 
 int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len)
--- 2.4/include/linux/mm.h	Sat May 12 10:03:59 2001
+++ build-2.4/include/linux/mm.h	Thu May 17 19:42:38 2001
@@ -440,9 +440,15 @@
 extern pte_t *FASTCALL(pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
-extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
+extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, size_t len, int write);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char *dst, int len);
 extern int ptrace_writedata(struct task_struct *tsk, char * src, unsigned long dst, int len);
+
+#define OTHER_EFAULT	1
+#define OTHER_ENOMEM	2
+#define CUR_EFAULT	3
+extern int copy_user_to_user(char *cbuf, struct mm_struct *mm, unsigned long oaddr, size_t len, int do_write);
+
 
 /*
  * On a two-level page table, this ends up being trivial. Thus the



--------------E55B0C43118DD5CE878A9037--



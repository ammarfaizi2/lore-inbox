Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUBBH3b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 02:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbUBBH3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 02:29:31 -0500
Received: from mail4.speakeasy.net ([216.254.0.204]:5568 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S265649AbUBBH3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 02:29:23 -0500
Date: Sun, 1 Feb 2004 23:29:20 -0800
Message-Id: <200402020729.i127TKG8011009@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] restore protections after forced fault in get_user_pages
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

get_user_pages can force a fault to succeed despite the vma's protections.
This is used in access_process_vm, so that ptrace can write an unwritable
page, or read an unreadable but present page.  The problem is that the page
table entry is then left with the escalated permissions, so a benign ptrace
call can cause a normal user access that should fault not to.  A simple
test case is to run this program under gdb:

	main()
	{
	  puts ("hi there");
	  *(volatile int *) &main = 0;
	  puts ("should be dead now");
	  return 22;
	}

do:

	$ gdb ./foo
	(gdb) break main
	(gdb) run
	(gdb) cont

With existing Linux kernels, the program will print:

	hi there
	should be dead now

and exit normally.  However, the second line of main obviously should
fault.  The following patch makes it do so.  

There are real-world scenarios where this has bitten people.  For example,
some garbage collectors use mprotect to ensure that they get known SIGSEGV
faults for accessing certain pages during collection.  When dealing with
such a program (e.g. a JVM), just examining the data at certain addresses
in the debugger can completely break the normal behavior of the program.
No fun for the poor bastard trying to debug such a garbage collector.

As the comment says, this is not airtight, i.e. atomic for racing accesses.
But it is perfectly adequate for the reasonable debugger scenario where
everything else that might use that user page is stopped while
access_process_vm gets called.  Previously there was a window where the
protections behaved wrong, from after the first ptrace-induced fault until
perhaps forever (page out).  Now there is a window from after the fault
until a tiny bit later.  I think that's a satisfactory improvement.


Thanks,
Roland


Index: linux-2.6/mm/memory.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/mm/memory.c,v
retrieving revision 1.141
diff -u -b -p -r1.141 memory.c
--- linux-2.6/mm/memory.c 20 Jan 2004 05:12:38 -0000 1.141
+++ linux-2.6/mm/memory.c 2 Feb 2004 06:03:29 -0000
@@ -685,6 +685,27 @@ static inline struct page *get_page_map(
 	return page;
 }
 
+/*
+ * Reset the page table entry for the given address after faulting in a page.
+ * We restore the protections indicated by its vma.
+ */
+static void
+restore_page_prot(struct mm_struct *mm, struct vm_area_struct *vma,
+		  unsigned long address)
+{
+	pgd_t *pgd = pgd_offset(mm, address);
+	pmd_t *pmd = pmd_alloc(mm, pgd, address);
+	pte_t *pte;
+	if (!pmd)
+		return;
+	pte = pte_alloc_map(mm, pmd, address);
+	if (!pte)
+		return;
+	flush_cache_page(vma, address);
+	ptep_establish(vma, address, pte, pte_modify(*pte, vma->vm_page_prot));
+	update_mmu_cache(vma, address, entry);
+	pte_unmap(pte);
+}
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
@@ -764,6 +785,22 @@ int get_user_pages(struct task_struct *t
 				}
 				spin_lock(&mm->page_table_lock);
 			}
+			if (force &&
+			    !(vma->vm_flags & (write ? VM_WRITE : VM_READ)))
+				/*
+				 * We forced a fault for protections the
+				 * page does not ordinarily allow.  Restore
+				 * the proper protections so that improper
+				 * user accesses are not allowed just
+				 * because we accessed it from the side.
+				 * Note that there is a window here where
+				 * user access could exploit the temporary
+				 * page proections.  Tough beans.  You just
+				 * have prevent user code from running while
+				 * you are accessing memory via ptrace if you
+				 * want it to get the proper faults.
+				 */
+			      restore_page_prot(mm, vma, start);
 			if (pages) {
 				pages[i] = get_page_map(map);
 				if (!pages[i]) {

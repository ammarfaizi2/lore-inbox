Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132511AbREHVdb>; Tue, 8 May 2001 17:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135363AbREHVdW>; Tue, 8 May 2001 17:33:22 -0400
Received: from quasar.osc.edu ([192.148.249.15]:6060 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S132511AbREHVdP>;
	Tue, 8 May 2001 17:33:15 -0400
Date: Tue, 8 May 2001 17:32:57 -0400
From: "'Pete Wyckoff'" <pw@osc.edu>
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ken Nicholson <knicholson@corp.iready.com>,
        pollard@tomcat.admin.navo.hpc.mil, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Direct Sockets Support??
Message-ID: <20010508173257.C15867@quasar.osc.edu>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9DEE0@ATL_MS1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i-nntp2
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402B9DEE0@ATL_MS1>; from Venkateshr@ami.com on Tue, May 08, 2001 at 04:18:01PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkateshr@ami.com said:
> 	> But in the case of an application which fits in main memory, and
> 	> has been running for a while (so all pages are present and
> 	> dirty), all you'd really have to do is verify the page tables are
> 	> in the proper state and skip the TLB flush, right?
> 
> 	We really cannot assume this. There are two cases 
> 		a. when a user app wants to receive some data, it allocates
> memory(using malloc) and waits for the hw to do zero-copy read. The kernel
> does not allocate physical page frames for the entire memory region
> allocated. We need to lock the memory (and locking is expensive due to
> costly TLB flushes) to do this
> 
> 		b. when a user app wants to send data, he fills the buffer
> and waits for the hw to transmit data, but under heavy physical memory
> pressure, the swapper might swap the pages we want to transmit. So we need
> to lock the memory to be 100% sure.

You're right, of course.  But I suspect that the fast path of
re-locking memory which is happily in core will go much faster
by removing the multi-processor TLB purge.  And it can't hurt,
unless I'm missing something.

		-- Pete

--- linux-2.4.4-stock/mm/mlock.c	Tue May  8 17:26:34 2001
+++ linux/mm/mlock.c	Tue May  8 17:24:13 2001
@@ -114,6 +114,10 @@
 	return 0;
 }
 
+/* implemented in mm/memory.c */
+extern int mlock_make_pages_present(struct vm_area_struct *vma,
+	unsigned long addr, unsigned long end);
+
 static int mlock_fixup(struct vm_area_struct * vma, 
 	unsigned long start, unsigned long end, unsigned int newflags)
 {
@@ -138,7 +142,7 @@
 		pages = (end - start) >> PAGE_SHIFT;
 		if (newflags & VM_LOCKED) {
 			pages = -pages;
-			make_pages_present(start, end);
+			mlock_make_pages_present(vma, start, end);
 		}
 		vma->vm_mm->locked_vm -= pages;
 	}

--- linux-2.4.4-stock/mm/memory.c	Tue May  8 17:25:36 2001
+++ linux/mm/memory.c	Tue May  8 17:24:40 2001
@@ -1438,3 +1438,80 @@
 	} while (addr < end);
 	return 0;
 }
+
+/*
+ * Specialized version of make_pages_present which does not require
+ * a multi-processor TLB purge for every page if nothing about the PTE
+ * was modified.
+ */
+int mlock_make_pages_present(struct vm_area_struct *vma,
+	unsigned long addr, unsigned long end)
+{
+	int ret, write;
+	struct mm_struct *mm = current->mm;
+
+	write = (vma->vm_flags & VM_WRITE) != 0;
+
+	/*
+	 * We need the page table lock to synchronize with kswapd
+	 * and the SMP-safe atomic PTE updates.
+	 */
+	spin_lock(&mm->page_table_lock);
+
+	ret = 0;
+	for (ret=0; !ret && addr < end; addr += PAGE_SIZE) {
+		pgd_t *pgd;
+		pmd_t *pmd;
+		pte_t *pte, entry;
+		int modified;
+
+		current->state = TASK_RUNNING;
+		pgd = pgd_offset(mm, addr);
+		pmd = pmd_alloc(mm, pgd, addr);
+		if (!pmd) {
+			ret = -1;
+			break;
+		}
+		pte = pte_alloc(mm, pmd, addr);
+		if (!pte) {
+			ret = -1;
+			break;
+		}
+		entry = *pte;
+		if (!pte_present(entry)) {
+			/*
+			 * If it truly wasn't present, we know that kswapd
+			 * and the PTE updates will not touch it later. So
+			 * drop the lock.
+			 */
+			if (pte_none(entry)) {
+				ret = do_no_page(mm, vma, addr, write, pte);
+				continue;
+			}
+			ret = do_swap_page(mm, vma, addr, pte,
+				pte_to_swp_entry(entry), write);
+			continue;
+		}
+
+		modified = 0;
+		if (write) {
+			if (!pte_write(entry)) {
+				ret = do_wp_page(mm, vma, addr, pte, entry);
+				continue;
+			}
+			if (!pte_dirty(entry)) {
+			    entry = pte_mkdirty(entry);
+			    modified = 1;
+			}
+		}
+		if (!pte_young(entry)) {
+			entry = pte_mkyoung(entry);
+			modified = 1;
+		}
+		if (modified)
+		    establish_pte(vma, addr, pte, entry);
+	}
+
+	spin_unlock(&mm->page_table_lock);
+	return ret;
+}

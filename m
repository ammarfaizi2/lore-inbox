Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317369AbSFGXx2>; Fri, 7 Jun 2002 19:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317370AbSFGXx1>; Fri, 7 Jun 2002 19:53:27 -0400
Received: from holomorphy.com ([66.224.33.161]:11409 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317369AbSFGXxG>;
	Fri, 7 Jun 2002 19:53:06 -0400
Date: Fri, 7 Jun 2002 16:52:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: remove magic numbers for fault return codes
Message-ID: <20020607235259.GP6777@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return codes from fault handling functions are open-coded in
memory.c and arch/i386/mm/fault.c.

This patch removes them in favor of defining integer constants with
mnemonic names and using them as the return codes and in dispatches
on the return values from handle_mm_fault(), and also removing some of
the associated comments explaining what the magic numbers mean at
various points where they were formerly used. In addition two redundant
variables were removed, a comment was added to the bad_wp_page: label
to explain to onlookers more of what the printk() there means, and
failure to match the return code with a value in the various switch()
statements on the return code was flagged as a BUG() at various points.

>From what I saw in page_alloc.c last time, since these hit the same
lines, they might as well all go out in one batch. I am, of course,
willing to adjust/separate various bits as desired.


Cheers,
Bill


===== include/linux/mm.h 1.55 vs edited =====
--- 1.55/include/linux/mm.h	Sat May 25 16:25:47 2002
+++ edited/include/linux/mm.h	Fri Jun  7 15:59:07 2002
@@ -305,6 +305,16 @@
 #define NOPAGE_SIGBUS	(NULL)
 #define NOPAGE_OOM	((struct page *) (-1))
 
+/*
+ * Different kinds of faults, as returned by handle_mm_fault().
+ * Used to decide whether a process gets delivered SIGBUS or
+ * just gets major/minor fault counters bumped up.
+ */
+#define VM_FAULT_OOM	(-1)
+#define VM_FAULT_SIGBUS	0
+#define VM_FAULT_MINOR	1
+#define VM_FAULT_MAJOR	2
+
 /* The array of struct pages */
 extern struct page *mem_map;
 
===== mm/memory.c 1.70 vs edited =====
--- 1.70/mm/memory.c	Fri May 31 18:18:07 2002
+++ edited/mm/memory.c	Fri Jun  7 15:19:49 2002
@@ -514,18 +514,18 @@
 			while (!(map = follow_page(mm, start, write))) {
 				spin_unlock(&mm->page_table_lock);
 				switch (handle_mm_fault(mm, vma, start, write)) {
-				case 1:
+				case VM_FAULT_MINOR:
 					tsk->min_flt++;
 					break;
-				case 2:
+				case VM_FAULT_MAJOR:
 					tsk->maj_flt++;
 					break;
-				case 0:
-					if (i) return i;
-					return -EFAULT;
+				case VM_FAULT_SIGBUS:
+					return i ? i : -EFAULT;
+				case VM_FAULT_OOM:
+					return i ? i : -ENOMEM;
 				default:
-					if (i) return i;
-					return -ENOMEM;
+					BUG();
 				}
 				spin_lock(&mm->page_table_lock);
 			}
@@ -982,7 +982,7 @@
 			establish_pte(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
-			return 1;	/* Minor fault */
+			return VM_FAULT_MINOR;
 		}
 	}
 	pte_unmap(page_table);
@@ -1016,16 +1016,21 @@
 	spin_unlock(&mm->page_table_lock);
 	page_cache_release(new_page);
 	page_cache_release(old_page);
-	return 1;	/* Minor fault */
+	return VM_FAULT_MINOR;
 
 bad_wp_page:
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
 	printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n", address);
-	return -1;
+	/*
+	 * This should really halt the system so it can be debugged or
+	 * at least the kernel stops what it's doing before it corrupts
+	 * data, but for the moment just pretend this is OOM.
+	 */
+	return VM_FAULT_OOM;
 no_mem:
 	page_cache_release(old_page);
-	return -1;
+	return VM_FAULT_OOM;
 }
 
 static void vmtruncate_list(list_t *head, unsigned long pgoff)
@@ -1149,7 +1154,7 @@
 	struct page *page;
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 	pte_t pte;
-	int ret = 1;
+	int ret = VM_FAULT_MINOR;
 
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
@@ -1162,17 +1167,19 @@
 			 * Back out if somebody else faulted in this pte while
 			 * we released the page table lock.
 			 */
-			int retval;
 			spin_lock(&mm->page_table_lock);
 			page_table = pte_offset_map(pmd, address);
-			retval = pte_same(*page_table, orig_pte) ? -1 : 1;
+			if (pte_same(*page_table, orig_pte))
+				ret = VM_FAULT_OOM;
+			else
+				ret = VM_FAULT_MINOR;
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
-			return retval;
+			return ret;
 		}
 
 		/* Had to read the page from swap area: Major fault */
-		ret = 2;
+		ret = VM_FAULT_MAJOR;
 	}
 
 	lock_page(page);
@@ -1188,7 +1195,7 @@
 		spin_unlock(&mm->page_table_lock);
 		unlock_page(page);
 		page_cache_release(page);
-		return 1;
+		return VM_FAULT_MINOR;
 	}
 
 	/* The page isn't present yet, go ahead with the fault. */
@@ -1246,7 +1253,7 @@
 			pte_unmap(page_table);
 			page_cache_release(page);
 			spin_unlock(&mm->page_table_lock);
-			return 1;
+			return VM_FAULT_MINOR;
 		}
 		mm->rss++;
 		flush_page_to_ram(page);
@@ -1260,10 +1267,10 @@
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, addr, entry);
 	spin_unlock(&mm->page_table_lock);
-	return 1;	/* Minor fault */
+	return VM_FAULT_MINOR;
 
 no_mem:
-	return -1;
+	return VM_FAULT_OOM;
 }
 
 /*
@@ -1291,10 +1298,11 @@
 
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, 0);
 
-	if (new_page == NULL)	/* no page was available -- SIGBUS */
-		return 0;
+	/* no page was available -- either SIGBUS or OOM */
+	if (new_page == NOPAGE_SIGBUS)
+		return VM_FAULT_SIGBUS;
 	if (new_page == NOPAGE_OOM)
-		return -1;
+		return VM_FAULT_OOM;
 
 	/*
 	 * Should we do an early C-O-W break?
@@ -1303,7 +1311,7 @@
 		struct page * page = alloc_page(GFP_HIGHUSER);
 		if (!page) {
 			page_cache_release(new_page);
-			return -1;
+			return VM_FAULT_OOM;
 		}
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
@@ -1339,13 +1347,13 @@
 		pte_unmap(page_table);
 		page_cache_release(new_page);
 		spin_unlock(&mm->page_table_lock);
-		return 1;
+		return VM_FAULT_MINOR;
 	}
 
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
 	spin_unlock(&mm->page_table_lock);
-	return 2;	/* Major fault */
+	return VM_FAULT_MAJOR;
 }
 
 /*
@@ -1397,7 +1405,7 @@
 	establish_pte(vma, address, pte, entry);
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
-	return 1;
+	return VM_FAULT_MINOR;
 }
 
 /*
@@ -1425,7 +1433,7 @@
 			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 	}
 	spin_unlock(&mm->page_table_lock);
-	return -1;
+	return VM_FAULT_OOM;
 }
 
 /*
===== arch/i386/mm/fault.c 1.13 vs edited =====
--- 1.13/arch/i386/mm/fault.c	Tue Feb 26 17:13:20 2002
+++ edited/arch/i386/mm/fault.c	Fri Jun  7 15:26:47 2002
@@ -56,12 +56,16 @@
 
 	for (;;) {
 	survive:
-		{
-			int fault = handle_mm_fault(current->mm, vma, start, 1);
-			if (!fault)
+		switch (handle_mm_fault(current->mm, vma, start, 1)) {
+			case VM_FAULT_SIGBUS:
 				goto bad_area;
-			if (fault < 0)
+			case VM_FAULT_OOM:
 				goto out_of_memory;
+			case VM_FAULT_MINOR:
+			case VM_FAULT_MAJOR:
+				break;
+			default:
+				BUG();
 		}
 		if (!size)
 			break;
@@ -239,16 +243,18 @@
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-	case 1:
-		tsk->min_flt++;
-		break;
-	case 2:
-		tsk->maj_flt++;
-		break;
-	case 0:
-		goto do_sigbus;
-	default:
-		goto out_of_memory;
+		case VM_FAULT_MINOR:
+			tsk->min_flt++;
+			break;
+		case VM_FAULT_MAJOR:
+			tsk->maj_flt++;
+			break;
+		case VM_FAULT_SIGBUS:
+			goto do_sigbus;
+		case VM_FAULT_OOM:
+			goto out_of_memory;
+		default:
+			BUG();
 	}
 
 	/*

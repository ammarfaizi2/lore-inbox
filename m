Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSGDXu3>; Thu, 4 Jul 2002 19:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSGDXsk>; Thu, 4 Jul 2002 19:48:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49165 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315257AbSGDXrI>;
	Thu, 4 Jul 2002 19:47:08 -0400
Message-ID: <3D24E071.23753273@zip.com.au>
Date: Thu, 04 Jul 2002 16:55:29 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 27/27] Use names, not numbers for pagefault types
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is Bill Irwin's cleanup patch which gives symbolic names to the
fault types:

	#define VM_FAULT_OOM	(-1)
	#define VM_FAULT_SIGBUS	0
	#define VM_FAULT_MINOR	1
	#define VM_FAULT_MAJOR	2

Only arch/i386 has been updated - other architectures can do this too.




 arch/i386/mm/fault.c |   34 +++++++++++++++------------
 include/linux/mm.h   |   10 +++++++
 mm/memory.c          |   64 ++++++++++++++++++++++++++++-----------------------
 3 files changed, 66 insertions(+), 42 deletions(-)

--- 2.5.24/include/linux/mm.h~fault-type-cleanup	Thu Jul  4 16:17:35 2002
+++ 2.5.24-akpm/include/linux/mm.h	Thu Jul  4 16:17:35 2002
@@ -305,6 +305,16 @@ static inline void set_page_zone(struct 
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
 
--- 2.5.24/mm/memory.c~fault-type-cleanup	Thu Jul  4 16:17:35 2002
+++ 2.5.24-akpm/mm/memory.c	Thu Jul  4 16:17:35 2002
@@ -503,18 +503,18 @@ int get_user_pages(struct task_struct *t
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
@@ -968,7 +968,7 @@ static int do_wp_page(struct mm_struct *
 			establish_pte(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
-			return 1;	/* Minor fault */
+			return VM_FAULT_MINOR;
 		}
 	}
 	pte_unmap(page_table);
@@ -1002,16 +1002,21 @@ static int do_wp_page(struct mm_struct *
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
@@ -1135,7 +1140,7 @@ static int do_swap_page(struct mm_struct
 	struct page *page;
 	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 	pte_t pte;
-	int ret = 1;
+	int ret = VM_FAULT_MINOR;
 
 	pte_unmap(page_table);
 	spin_unlock(&mm->page_table_lock);
@@ -1148,17 +1153,19 @@ static int do_swap_page(struct mm_struct
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
@@ -1174,7 +1181,7 @@ static int do_swap_page(struct mm_struct
 		spin_unlock(&mm->page_table_lock);
 		unlock_page(page);
 		page_cache_release(page);
-		return 1;
+		return VM_FAULT_MINOR;
 	}
 
 	/* The page isn't present yet, go ahead with the fault. */
@@ -1232,7 +1239,7 @@ static int do_anonymous_page(struct mm_s
 			pte_unmap(page_table);
 			page_cache_release(page);
 			spin_unlock(&mm->page_table_lock);
-			return 1;
+			return VM_FAULT_MINOR;
 		}
 		mm->rss++;
 		flush_page_to_ram(page);
@@ -1246,10 +1253,10 @@ static int do_anonymous_page(struct mm_s
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
@@ -1277,10 +1284,11 @@ static int do_no_page(struct mm_struct *
 
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
@@ -1289,7 +1297,7 @@ static int do_no_page(struct mm_struct *
 		struct page * page = alloc_page(GFP_HIGHUSER);
 		if (!page) {
 			page_cache_release(new_page);
-			return -1;
+			return VM_FAULT_OOM;
 		}
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
@@ -1325,13 +1333,13 @@ static int do_no_page(struct mm_struct *
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
@@ -1383,7 +1391,7 @@ static inline int handle_pte_fault(struc
 	establish_pte(vma, address, pte, entry);
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
-	return 1;
+	return VM_FAULT_MINOR;
 }
 
 /*
@@ -1411,7 +1419,7 @@ int handle_mm_fault(struct mm_struct *mm
 			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
 	}
 	spin_unlock(&mm->page_table_lock);
-	return -1;
+	return VM_FAULT_OOM;
 }
 
 /*
--- 2.5.24/arch/i386/mm/fault.c~fault-type-cleanup	Thu Jul  4 16:17:35 2002
+++ 2.5.24-akpm/arch/i386/mm/fault.c	Thu Jul  4 16:17:35 2002
@@ -56,12 +56,16 @@ good_area:
 
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
@@ -239,16 +243,18 @@ good_area:
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

-

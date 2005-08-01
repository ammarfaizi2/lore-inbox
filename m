Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVHAIVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVHAIVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVHAIVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:21:42 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:55435 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262090AbVHAIVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:21:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=LbYFrKq4oL9QHH6vHKK+7MH7vQ67kIA6v1DDVlOlHh9V0xu2iWujULG6kKDeovBAL8YMAoYNBhRxWWu6uAKh7GcBgAFl4XXd+jNQbK3tuzvepgFqbQq0v8sv3F6skaNxfyRO5Xm+ZoNhAh6PzdndNLE9YC78X0OwP3e1Av5Dd+c=  ;
Message-ID: <42EDDB82.1040900@yahoo.com.au>
Date: Mon, 01 Aug 2005 18:21:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
CC: Roland McGrath <roland@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.13-rc4] fix get_user_pages bug
References: <20050801032258.A465C180EC0@magilla.sf.frob.com>
In-Reply-To: <20050801032258.A465C180EC0@magilla.sf.frob.com>
Content-Type: multipart/mixed;
 boundary="------------050805090606090001010502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050805090606090001010502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Not sure if this should be fixed for 2.6.13. It can result in
pagecache corruption: so I guess that answers my own question.

This was tested by Robin and appears to solve the problem. Roland
had a quick look and thought the basic idea was sound. I'd like to
get a couple more acks before going forward, and in particular
Robin was contemplating possible efficiency improvements (although
efficiency can wait on correctness).

Feedback please, anyone.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


--------------050805090606090001010502
Content-Type: text/plain;
 name="mm-gup-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-gup-fix.patch"

When get_user_pages for write access races with another process in the page
fault handler that has established the pte for read access, handle_mm_fault
in get_user_pages will return VM_FAULT_MINOR even if it hasn't made the page
correctly writeable (for example, broken COW).

Thus the assumption that get_user_pages has a writeable page at the mapping
after handle_mm_fault returns is incorrect. Fix this by reporting a raced
(uncompleted) fault and retrying the lookup and fault in get_user_pages before
making the assumption that we have a writeable page.

Great work by Robin Holt <holt@sgi.com> to debug the problem.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/i386/mm/fault.c
+++ linux-2.6/arch/i386/mm/fault.c
@@ -351,6 +351,8 @@ good_area:
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_RACE:
+			break;
 		default:
 			BUG();
 	}
Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -625,6 +625,7 @@ static inline int page_mapped(struct pag
  * Used to decide whether a process gets delivered SIGBUS or
  * just gets major/minor fault counters bumped up.
  */
+#define VM_FAULT_RACE	(-2)
 #define VM_FAULT_OOM	(-1)
 #define VM_FAULT_SIGBUS	0
 #define VM_FAULT_MINOR	1
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -969,6 +969,16 @@ int get_user_pages(struct task_struct *t
 					return i ? i : -EFAULT;
 				case VM_FAULT_OOM:
 					return i ? i : -ENOMEM;
+				case VM_FAULT_RACE:
+					/*
+					 * Someone else got there first.
+					 * Must retry before we can assume
+					 * that we have actually performed
+					 * the write fault (below).
+					 */
+					if (write)
+						continue;
+					break;
 				default:
 					BUG();
 				}
@@ -1229,6 +1239,7 @@ static int do_wp_page(struct mm_struct *
 	struct page *old_page, *new_page;
 	unsigned long pfn = pte_pfn(pte);
 	pte_t entry;
+	int ret;
 
 	if (unlikely(!pfn_valid(pfn))) {
 		/*
@@ -1285,7 +1296,9 @@ static int do_wp_page(struct mm_struct *
 	 */
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
+	ret = VM_FAULT_RACE;
 	if (likely(pte_same(*page_table, pte))) {
+		ret = VM_FAULT_MINOR;
 		if (PageAnon(old_page))
 			dec_mm_counter(mm, anon_rss);
 		if (PageReserved(old_page))
@@ -1304,7 +1317,7 @@ static int do_wp_page(struct mm_struct *
 	page_cache_release(new_page);
 	page_cache_release(old_page);
 	spin_unlock(&mm->page_table_lock);
-	return VM_FAULT_MINOR;
+	return ret;
 
 no_new_page:
 	page_cache_release(old_page);
@@ -1659,7 +1672,7 @@ static int do_swap_page(struct mm_struct
 			if (likely(pte_same(*page_table, orig_pte)))
 				ret = VM_FAULT_OOM;
 			else
-				ret = VM_FAULT_MINOR;
+				ret = VM_FAULT_RACE;
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
 			goto out;
@@ -1681,7 +1694,7 @@ static int do_swap_page(struct mm_struct
 	spin_lock(&mm->page_table_lock);
 	page_table = pte_offset_map(pmd, address);
 	if (unlikely(!pte_same(*page_table, orig_pte))) {
-		ret = VM_FAULT_MINOR;
+		ret = VM_FAULT_RACE;
 		goto out_nomap;
 	}
 
@@ -1742,6 +1755,7 @@ do_anonymous_page(struct mm_struct *mm, 
 {
 	pte_t entry;
 	struct page * page = ZERO_PAGE(addr);
+	int ret = VM_FAULT_MINOR;
 
 	/* Read-only mapping of ZERO_PAGE. */
 	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));
@@ -1765,6 +1779,7 @@ do_anonymous_page(struct mm_struct *mm, 
 			pte_unmap(page_table);
 			page_cache_release(page);
 			spin_unlock(&mm->page_table_lock);
+			ret = VM_FAULT_RACE;
 			goto out;
 		}
 		inc_mm_counter(mm, rss);
@@ -1784,7 +1799,7 @@ do_anonymous_page(struct mm_struct *mm, 
 	lazy_mmu_prot_update(entry);
 	spin_unlock(&mm->page_table_lock);
 out:
-	return VM_FAULT_MINOR;
+	return ret;
 no_mem:
 	return VM_FAULT_OOM;
 }
@@ -1902,6 +1917,7 @@ retry:
 		pte_unmap(page_table);
 		page_cache_release(new_page);
 		spin_unlock(&mm->page_table_lock);
+		ret = VM_FAULT_RACE;
 		goto out;
 	}
 
Index: linux-2.6/arch/alpha/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/alpha/mm/fault.c
+++ linux-2.6/arch/alpha/mm/fault.c
@@ -162,6 +162,8 @@ do_page_fault(unsigned long address, uns
 		goto do_sigbus;
 	      case VM_FAULT_OOM:
 		goto out_of_memory;
+	      case VM_FAULT_RACE:
+		break;
 	      default:
 		BUG();
 	}
Index: linux-2.6/arch/arm/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/arm/mm/fault.c
+++ linux-2.6/arch/arm/mm/fault.c
@@ -195,6 +195,7 @@ survive:
 	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 	case VM_FAULT_SIGBUS:
+	case VM_FAULT_RACE:
 		return fault;
 	}
 
Index: linux-2.6/arch/ia64/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/ia64/mm/fault.c
+++ linux-2.6/arch/ia64/mm/fault.c
@@ -164,6 +164,8 @@ ia64_do_page_fault (unsigned long addres
 		goto bad_area;
 	      case VM_FAULT_OOM:
 		goto out_of_memory;
+	      case VM_FAULT_RACE:
+		break;
 	      default:
 		BUG();
 	}
Index: linux-2.6/arch/m32r/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/m32r/mm/fault.c
+++ linux-2.6/arch/m32r/mm/fault.c
@@ -234,6 +234,8 @@ survive:
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_RACE:
+			break;
 		default:
 			BUG();
 	}
Index: linux-2.6/arch/mips/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/mips/mm/fault.c
+++ linux-2.6/arch/mips/mm/fault.c
@@ -109,6 +109,8 @@ survive:
 		goto do_sigbus;
 	case VM_FAULT_OOM:
 		goto out_of_memory;
+	case VM_FAULT_RACE:
+		break;
 	default:
 		BUG();
 	}
Index: linux-2.6/arch/ppc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/ppc/mm/fault.c
+++ linux-2.6/arch/ppc/mm/fault.c
@@ -259,6 +259,8 @@ good_area:
                 goto do_sigbus;
         case VM_FAULT_OOM:
                 goto out_of_memory;
+	case VM_FAULT_RACE:
+		break;
 	default:
 		BUG();
 	}
Index: linux-2.6/arch/ppc64/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/ppc64/mm/fault.c
+++ linux-2.6/arch/ppc64/mm/fault.c
@@ -234,6 +234,8 @@ good_area:
 		goto do_sigbus;
 	case VM_FAULT_OOM:
 		goto out_of_memory;
+	case VM_FAULT_RACE:
+		break;
 	default:
 		BUG();
 	}
Index: linux-2.6/arch/s390/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/s390/mm/fault.c
+++ linux-2.6/arch/s390/mm/fault.c
@@ -260,6 +260,8 @@ survive:
 		goto do_sigbus;
 	case VM_FAULT_OOM:
 		goto out_of_memory;
+	case VM_FAULT_RACE:
+		break;
 	default:
 		BUG();
 	}
Index: linux-2.6/arch/sh/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/sh/mm/fault.c
+++ linux-2.6/arch/sh/mm/fault.c
@@ -101,6 +101,8 @@ survive:
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_RACE:
+			break;
 		default:
 			BUG();
 	}
Index: linux-2.6/arch/sparc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/sparc/mm/fault.c
+++ linux-2.6/arch/sparc/mm/fault.c
@@ -302,8 +302,8 @@ good_area:
 		current->maj_flt++;
 		break;
 	case VM_FAULT_MINOR:
-	default:
 		current->min_flt++;
+	case VM_FAULT_RACE:
 		break;
 	}
 	up_read(&mm->mmap_sem);
Index: linux-2.6/arch/sparc64/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/sparc64/mm/fault.c
+++ linux-2.6/arch/sparc64/mm/fault.c
@@ -454,6 +454,8 @@ good_area:
 		goto do_sigbus;
 	case VM_FAULT_OOM:
 		goto out_of_memory;
+	case VM_FAULT_RACE:
+		break;
 	default:
 		BUG();
 	}
Index: linux-2.6/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/trap_kern.c
+++ linux-2.6/arch/um/kernel/trap_kern.c
@@ -76,6 +76,8 @@ int handle_page_fault(unsigned long addr
 		case VM_FAULT_OOM:
 			err = -ENOMEM;
 			goto out_of_memory;
+		case VM_FAULT_RACE:
+			break;
 		default:
 			BUG();
 		}
Index: linux-2.6/arch/xtensa/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/xtensa/mm/fault.c
+++ linux-2.6/arch/xtensa/mm/fault.c
@@ -113,6 +113,8 @@ survive:
 		goto do_sigbus;
 	case VM_FAULT_OOM:
 		goto out_of_memory;
+	case VM_FAULT_RACE:
+		break;
 	default:
 		BUG();
 	}

--------------050805090606090001010502--
Send instant messages to your online friends http://au.messenger.yahoo.com 

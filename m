Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbUCZJVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 04:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbUCZJVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 04:21:38 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:42409 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263979AbUCZJRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 04:17:45 -0500
Message-ID: <4063F581.ACC5C511@nospam.org>
Date: Fri, 26 Mar 2004 10:18:57 +0100
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Migrate pages from a ccNUMA node to another - patch
Content-Type: multipart/mixed;
 boundary="------------C3649D9FC7EAC1DC128DB793"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C3649D9FC7EAC1DC128DB793
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 
--------------C3649D9FC7EAC1DC128DB793
Content-Type: text/plain; charset=us-ascii;
 name="mig-2.6.4-bk4-2004-march-25"
Content-Disposition: inline;
 filename="mig-2.6.4-bk4-2004-march-25"
Content-Transfer-Encoding: 7bit

diff -Nru 2.6.4.ref/arch/ia64/kernel/acpi.c 2.6.4.mig4/arch/ia64/kernel/acpi.c
--- 2.6.4.ref/arch/ia64/kernel/acpi.c	Tue Mar 16 10:18:04 2004
+++ 2.6.4.mig4/arch/ia64/kernel/acpi.c	Thu Mar 25 08:58:09 2004
@@ -457,6 +457,7 @@
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (pxm_bit_test(i)) {
 			pxm_to_nid_map[i] = numnodes;
+			node_set_online(numnodes);
 			nid_to_pxm_map[numnodes++] = i;
 		}
 	}
diff -Nru 2.6.4.ref/arch/ia64/kernel/entry.S 2.6.4.mig4/arch/ia64/kernel/entry.S
--- 2.6.4.ref/arch/ia64/kernel/entry.S	Tue Mar 16 10:18:04 2004
+++ 2.6.4.mig4/arch/ia64/kernel/entry.S	Thu Mar 25 08:58:09 2004
@@ -1518,7 +1518,11 @@
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall			// 1275
+#if defined(CONFIG_NUMA)
+	data8 sys_page_migrate			// 1276: Migrate pages to another NUMA node
+#else
 	data8 sys_ni_syscall
+#endif
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
diff -Nru 2.6.4.ref/arch/ia64/mm/Makefile 2.6.4.mig4/arch/ia64/mm/Makefile
--- 2.6.4.ref/arch/ia64/mm/Makefile	Tue Mar 16 10:18:04 2004
+++ 2.6.4.mig4/arch/ia64/mm/Makefile	Thu Mar 25 08:58:15 2004
@@ -5,7 +5,7 @@
 obj-y := init.o fault.o tlb.o extable.o
 
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
-obj-$(CONFIG_NUMA)	   += numa.o
+obj-$(CONFIG_NUMA)	   += numa.o migrate.o
 obj-$(CONFIG_DISCONTIGMEM) += discontig.o
 ifndef CONFIG_DISCONTIGMEM
 obj-y += contig.o
diff -Nru 2.6.4.ref/arch/ia64/mm/migrate.c 2.6.4.mig4/arch/ia64/mm/migrate.c
--- 2.6.4.ref/arch/ia64/mm/migrate.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig4/arch/ia64/mm/migrate.c	Thu Mar 25 08:58:15 2004
@@ -0,0 +1,1274 @@
+/*
+ * Migrate pages from a ccNUMA node to another.
+ * ============================================
+ *
+ * Version 0.1, 31st of March 2004
+ * By Zoltan Menyhart, Bull S.A. <Zoltan.Menyhart_AT_bull.net@no.spam.org>
+ * The usual GPL applies.
+ *
+ * This is Linux, and explanatory comments / error messages are seen
+ * as a sign of weakness :-)))
+ *
+ * O.K. check out "migrate.txt" and "page_migrate.h".
+ */
+
+
+#include <linux/mm.h>
+#include <linux/smp_lock.h>
+#include <linux/pagemap.h>
+#include <linux/rmap-locking.h>
+#include <linux/swap.h>
+#include <linux/vmalloc.h>
+#include <asm/rmap.h>
+#include <asm/tlbflush.h>
+#include <asm/page_migrate.h>
+#if defined(_TEST_)
+#include <linux/delay.h>		// For "ia64_get_itc()"
+#endif
+
+#if !defined(CONFIG_DISCONTIGMEM) || !defined(CONFIG_NUMA)
+#error	"That's a NUMA stuff"
+#endif
+
+
+/*
+ * Type of a virtual address.
+ */
+typedef	unsigned long	vaddr_t;	// Pointers converted to this type
+
+
+#if defined(_TEST_)
+
+// Set the bits - as defined below - for some kernel messages.
+unsigned int _pr_flag_;
+
+#define	PRINT_page	1		// Dump "struct page"-s
+#define	PRINT_mm	2		// Dump "struct mm_struct"-s
+#define	PRINT_vma	4		// Dump "struct vm_area_struct"-s
+#define	PRINT_pte	8		// Show PTE-s, r-maps
+#define	PRINT_errors	0x10
+#define	PRINT_etc	0x20
+#define	PRINT_pgd	0x40		// Show PGD scan
+
+#define PRINT(args...)	do { if (_pr_flag_) printk(args); } while (0)
+#define PRINT_ERR(args...)								\
+			do { if (_pr_flag_ & PRINT_errors) printk(args); } while (0)
+#define PRINT_ETC(args...)								\
+			do { if (_pr_flag_ & PRINT_etc) printk(args); } while (0)
+#define PRINT_PGD(args...)								\
+			do { if (_pr_flag_ & PRINT_pgd) printk(args); } while (0)
+
+static const char	dest_not_online[] =	"Destination node not online\n";
+static const char	no_vma[] =		"Cannot find VMA for address 0x%lx\n";
+static const char	illegal_pid[] =		"Illegal PID\n";
+static const char	inv_n_addresses[] = 	"Invalid number of addresses";
+static const char	ill_va_alias[] =	"v-addr alias in range: 0x%p...0x%p\n";
+static const char	no_momory[] =		"No more memory\n";
+static const char	ill_user_buff[] =	"Illegal user buffer address\n";
+
+void		dump_mm(const struct mm_struct * const);
+void		dump_vma(const struct vm_area_struct * const);
+void		dump_page(const char * const, const struct page * const);
+void		dump_pte_stuff(const pte_t * const);
+phaddr_t	gimme_an_address(const caddr_t);
+
+#define	STATIC
+#define	INLINE
+
+#else	// #if defined(_TEST_)
+
+#define PRINT(args...)		do { } while (0)
+#define PRINT_ERR(args...)	do { } while (0)
+#define PRINT_ETC(args...)	do { } while (0)
+#define PRINT_PGD(args...)	do { } while (0)
+
+#define	dump_mm(vma)		do { } while (0)
+#define	dump_vma(vma)		do { } while (0)
+#define	dump_page(text, page)	do { } while (0)
+#define	dump_pte_stuff(ptep)	do { } while (0)
+
+#define	STATIC			static
+#define	INLINE			inline
+
+#endif	// #if defined(_TEST_)
+
+
+STATIC INLINE long long
+migr_virt_addr_range(const caddr_t, const size_t, const int, const pid_t);
+
+STATIC INLINE long long
+migr_vaddr_range_2(vaddr_t, const vaddr_t, const int, struct mm_struct * const);
+
+STATIC INLINE int
+migr_1_page_by_pte(pte_t * const, const int, struct mm_struct * const);
+
+STATIC INLINE long long
+batch_migrate(const caddr_t, size_t, const int, const pid_t);
+
+STATIC struct mm_struct	*
+look_up_mm(const pid_t);
+
+int
+check_migr_1_page_part_2(struct page * const, struct page * const,
+						struct mm_struct * const, pte_t * const);
+
+int
+get_pages_if_valid(phaddr_t * const, unsigned int);
+
+STATIC INLINE int
+check_pages_if_in_pgd(phaddr_t * const, const size_t, const struct mm_struct * const);
+
+STATIC INLINE int
+check_migrate_1_page(const phaddr_t, const int, struct mm_struct * const);
+
+
+// These are the flags which are copied for the new page:
+#define	FLAG_MASK	(PG_referenced | PG_uptodate | PG_dirty | PG_active |		\
+				PG_highmem | PG_arch_1 | PG_private | PG_writeback |	\
+				PG_nosave | PG_mappedtodisk | PG_reclaim | PG_compound)
+
+
+#if defined(_NEED_STATISTICS_)
+
+/*
+ * Statistics are accessed in a non atomic way. Who cares? Just some statistics :-)
+ */
+STATIC struct _statistics_	_statistics;
+STATIC struct _statistics_size_	_statistics_sizes = {sizeof _statistics, MAX_NUMNODES};
+
+#define	DECLARE_ITC_VAR(var)		unsigned long var
+#define	SAVE_ITC(var)			var = ia64_get_itc()
+#define	STORE_DELAY(var, destination)	_statistics.t.destination += ia64_get_itc() - var
+#define	COUNT(what)			_statistics.c.what++
+#define	ERROR_CNT(what)			_statistics.e.what++
+#define	ERROR_CNT_ADD(var, delta)	_statistics.e.var += delta
+
+STATIC INLINE int	page_migrate_statistics(const caddr_t, const int);
+
+#else
+
+#define	DECLARE_ITC_VAR(var)
+#define	SAVE_ITC(var)			do { } while (0)
+#define	STORE_DELAY(var, destination)	do { } while (0)
+#define	COUNT(what)			do { } while (0)
+#define	ERROR_CNT(what)			do { } while (0)
+#define	ERROR_CNT_ADD(var, delta)	do { } while (0)
+
+#endif	// #if defined(_NEED_STATISTICS_)
+
+
+/*
+ * Migrate pages from a NUMA node to another (and some other minor services).
+ * (See "migrate.txt" and "page_migrate.h".)
+ *
+ * As usual, "-Exxx" returned on errors.
+ */
+asmlinkage long long
+sys_page_migrate(const int cmd, const caddr_t address, const size_t length,
+							const int node, const pid_t pid)
+{
+	long long	rc;
+	DECLARE_ITC_VAR(time);			// Total time for "sys_page_migrate()"
+
+	SAVE_ITC(/* out */ time);
+	PRINT("\nsys_page_migrate(%d, 0x%p, 0x%lx, %d, %d): pid = %d\n",
+					cmd, address, length, node, pid, current->pid);
+	switch (cmd){
+	//
+	// Migrate some pages from a NUMA node to another.
+	//
+	case _PHADDR_BATCH_MIGRATE_:
+		if (!node_online(node)){
+			PRINT_ERR(dest_not_online);
+			ERROR_CNT(bad_request);
+			rc = -ENODEV;
+			break;
+		}
+		if (length > PAGE_SIZE / sizeof(phaddr_t)){
+			PRINT_ERR(inv_n_addresses);
+			ERROR_CNT(bad_request);
+			rc = -EINVAL;
+			break;
+		}
+		rc = batch_migrate(/* user buffer */ address, /* buffer */ length,
+									node, pid);
+		break;
+	//
+	// Migrate virtual address range.
+	//
+	case _VA_RANGE_MIGRATE_:
+		if (!node_online(node)){
+			PRINT_ERR(dest_not_online);
+			ERROR_CNT(bad_request);
+			rc = -ENODEV;
+			break;
+		}
+		//
+		// Some architectures do not decode all the MSB-s of virtual addresses
+		// for the PGD, PMD and PTE indices, i.e. they have got holes or aliases
+		// in the virtual address space. Make sure that "length" does not span
+		// over virtual address holes nor it creates illegal alias to an
+		// otherwise valid address.
+		//
+		if (__IS_VA_ALIAS((vaddr_t) address, length)){
+			PRINT_ERR(ill_va_alias, address, address + length);
+			ERROR_CNT(non_existent_addr);
+			rc = -EFAULT;
+			break;
+		}
+		rc = migr_virt_addr_range(/* user virtual */ address,
+						/* address range */ length, node, pid);
+		break;
+
+#if defined(_NEED_STATISTICS_)
+	case _STATISTICS_:
+		rc = page_migrate_statistics(/* user buffer */ address,
+						/* ? clear statistics ? */ length != 0);
+		break;
+	case _SIZEOF_STATISTICS_:
+		rc =  *(long long *) &_statistics_sizes;	// Yeh, I know...
+		break;
+#endif
+#if defined(_TEST_)
+	case _GIMME_AN_ADDRESS_:
+		rc = (long long) gimme_an_address(/* user vistual */ address);
+		break;
+#endif
+	default:
+		ERROR_CNT(bad_request);
+		rc = -EINVAL;
+		break;
+	}
+	STORE_DELAY(/* in */ time, /* out */ total);
+	return rc;
+}
+
+
+/*
+ * Migrate virtual address range of a process.
+ *
+ * Arguments:	address:	Starting virtual address in a process'es address space
+ *		length:		Length of the address range to be migrated
+ *		node:		Destination NUMA node
+ *		pid:		ID of the victim process, "0" means myself
+ *
+ * Returns:	On (partial) success, the number of the pages actually migrated is
+ *		returned (in form of "struct _un_success_count_").
+ *		As usual, "-Exxx" returned on errors.
+ */
+STATIC INLINE long long
+migr_virt_addr_range(const caddr_t address, const size_t length, const int node,
+									const pid_t pid)
+{
+	const vaddr_t		ulimit = (vaddr_t) address + length;
+	struct mm_struct	*mm;
+	long long		rc;
+	struct vm_area_struct	*beg_vma;
+	DECLARE_ITC_VAR(vma_time);		// Time for "find_vma()"
+	DECLARE_ITC_VAR(mmap_sem);		// Time for "down_read(&mm->mmap_sem)"
+	DECLARE_ITC_VAR(pgd_lock);		// "spin_lock(&mm->page_table_lock)"
+	DECLARE_ITC_VAR(pgd_unlock);		// "spin_unlock(&mm->page_table_lock)"
+
+	if (pid != 0 && pid != current->pid){
+		//
+		//  Look up the "mm_struct" belonging to the process ID.
+		//
+		if ((mm = look_up_mm(pid)) == NULL){
+			PRINT_ERR(illegal_pid);
+			ERROR_CNT(bad_request);
+			return -ESRCH;
+		}
+		//
+		// On success, "mm->mm_users" got incremented to make sure that
+		// "mm_struct" does not go away.
+		//
+	} else {
+		mm = current->mm;
+		//
+		// Actually, there is no need to grab "mm" because it is ours, wont go
+		// away in the mean time. As we do not want to ask questions when
+		// releasing it...
+		// It is safe just to increment the counter: it is ours.
+		//
+		atomic_inc(&mm->mm_users);
+	}
+	SAVE_ITC(/* out */ mmap_sem);
+	down_read(&mm->mmap_sem);			// Protect the VMA list
+	STORE_DELAY(/* in */ mmap_sem, /* out */ mmap_sem);
+	dump_mm(mm);
+	//
+	// Check if the starting virtual "address" is valid.
+	//
+	SAVE_ITC(/* out */ vma_time);
+	beg_vma = find_vma(mm, (vaddr_t) address);	// Look up the first VMA for
+							// which "address < ->vm_end"
+	STORE_DELAY(/* in */ vma_time, /* out */ find_vma);
+	if (beg_vma == NULL || beg_vma->vm_start > (vaddr_t) address){
+		if (beg_vma != NULL)
+			dump_vma(beg_vma);
+		up_read(&mm->mmap_sem);
+		mmput(mm);
+		PRINT_ERR(no_vma, (vaddr_t) address);
+		ERROR_CNT(non_existent_addr);
+		return -EFAULT;
+	}
+	//
+	// It is safe to start walking the PGD, the PMD and the PTE at "address".
+	//
+	dump_vma(beg_vma);
+	//
+	// We need the page table lock to synchronize with "kswapd"
+	// and the SMP-safe atomic PTE updates.
+	//
+	SAVE_ITC(/* out */ pgd_lock);
+	spin_lock(&mm->page_table_lock);
+	STORE_DELAY(/* in */ pgd_lock, /* out */ pgd_lock);
+	//
+	// Look up pages in the PGD and migrate them one by one.
+	//
+	rc = migr_vaddr_range_2((vaddr_t) address & PAGE_MASK,
+					/* round up */ PAGE_ALIGN(ulimit), node, mm);
+	//
+	// Let the others complete the page fault handler code. They will find the
+	// condition "someone has already installed the PTE" to be TRUE.
+	//
+	SAVE_ITC(/* out */ pgd_unlock);
+	spin_unlock(&mm->page_table_lock);
+	STORE_DELAY(/* in */ pgd_unlock, /* out */ pgd_unlock);
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+	return rc;
+}
+
+
+/*
+ * Migrate virtual address range belonging to a PGD.
+ *
+ * Arguments:	address:	Starting virtual address in a process'es address space
+ *		ulimit:		The address range is below this upper limit
+ *		node:		Destination NUMA node
+ *		mm:		-> victim "mm_struct"
+ *
+ * Returns:	On (partial) success, the number of the pages actually migrated is
+ *		returned in "struct _un_success_count_".
+ *		As usual, "-Exxx" returned on errors.
+ *
+ * Notes:	- We've already checked that "[address...ulimit)" is inside the allowed
+ *		  user virtual address range.
+ *		- Caller has to hold "mm->mmap_sem" for read and "mm->page_table_lock".
+ */
+STATIC INLINE long long
+migr_vaddr_range_2(vaddr_t address, const vaddr_t ulimit, const int node,
+							struct mm_struct * const mm)
+{
+	unsigned long			g, m, e;	// PGD, MPD and PTE indices
+	const pgd_t			*pgd;
+	const pmd_t			*pmd;
+	pte_t				*pte, *pte0;
+	int				rc;
+	struct _un_success_count_	count = {0, 0};
+	DECLARE_ITC_VAR(pgd_scan_t);			// PGD scan time
+
+	//
+	// We've already cheked that it is safe to start walking the PGD, the PMD and the
+	// PTE at "address". We've also checked that "[address...ulimit)" does not span
+	// over virtual address holes nor it creates illegal alias to an otherwise
+	// valid address.
+	//
+	g = pgd_index(address);			// PGD scan starts here
+	m = pmd_index(address);			// The 1st PMD scan starts here
+	e = pte_index(address);			// The 1st PTE scan starts here
+	//
+	// Check the user pages only, starting at the PTE corresponding to "address".
+	// Note: "mm->pgd" is an identity mapped virtual address.
+	//
+	SAVE_ITC(/* out */ pgd_scan_t);
+	for (pgd = mm->pgd + g; address < ulimit && g < USER_PTRS_PER_PGD;
+					// Other than the 1st PMD scans start at 0 index
+								m = 0, g++, pgd++){
+		PRINT_PGD("address: 0x%016lx pgd: 0x%p ", address, pgd);
+		PRINT_PGD("g: 0x%lx m: 0x%lx e: 0x%lx\n", g, m, e);
+		PRINT_PGD("__VA():\t 0x%016lx\n", __VA(g, m, e));
+		//
+		// "pgd" contains an identity mapped virtual address.
+		// Migration tolarates holes in the virtual address space.
+		//
+		if (pgd_none(*pgd) || pgd_bad(*pgd)){
+			address &= ~(PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - 1);
+			address += PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE;
+			continue;
+		}
+		//
+		// "*pgd" is a physical address.
+		//
+		for (pmd = pmd_offset(pgd, 0) + m; m < PTRS_PER_PMD && address < ulimit;
+					// Other than the 1st PTE scans start at 0 index
+								e = 0, m++, pmd++){
+			//
+			// "pmd" contains an identity mapped virtual address.
+			// Migration tolarates holes in the virtual address space.
+			//
+			if (pmd_none(*pmd) || pmd_bad(*pmd)){
+				address &= ~(PTRS_PER_PTE * PAGE_SIZE - 1);
+				address += PTRS_PER_PTE * PAGE_SIZE;
+				continue;
+			}
+			//
+			// "*pmd" is a physical address.
+			//
+			pte0 = pte_offset_map(pmd, 0);
+			//
+			// "pte0" contains some kind of virtual address of the
+			// beginning of a PTE page.
+			//
+			for (pte = pte0 + e; e < PTRS_PER_PTE && address < ulimit;
+						address += PAGE_SIZE, e++, pte++){
+				if (!pte_present(*pte))
+					continue;
+				//
+				// We've found a page... Let's move it.
+				//
+				PRINT("\nVirtual addr:\t0x%016lx\n", __VA(g, m, e));
+				STORE_DELAY(/* in */ pgd_scan_t, /* out */ pgd_scan);
+				if ((rc = migr_1_page_by_pte(pte, node, mm)) < 0){
+					pte_unmap(pte0);
+					return rc;
+				}
+				SAVE_ITC(/* out */ pgd_scan_t);
+				if (rc > 0)
+					count.successful++;
+				else
+					count.failed++;
+			}
+			pte_unmap(pte0);
+		}
+	}
+	STORE_DELAY(/* in */ pgd_scan_t, /* out */ pgd_scan);
+	return *(long long *) &count;		// Yeh, I know...
+}
+
+
+/*
+ * Common part of checking & migrating the pages one by one.
+ *
+ * Arguments:	src_node:	Source NUMA node
+ *		old_p:		-> old page structure
+ *		node:		Destination NUMA node
+ *		mm:		-> victim "mm_struct"
+ *		pte:		-> PTE of the page to be moved
+ *
+ * Returns:	1:		Migration O. K.
+ *		0:		Minor error, no actual migration has been done
+ *		-Exxx:		Catastrophic error
+ *
+ * Notes:	- "mm->page_table_lock" and "mm->mmap_sem" have to be held.
+ *		- The old page is "get_page()"-ed on entry to meke sure it does not go
+ *		  away in the mean time - on return it gets "put_page()"-ed.
+ */
+STATIC int
+common_check_migrate_1_page(const int src_node, struct page * const old_p,
+			const int node, struct mm_struct * const mm, pte_t * const pte)
+{
+	struct page	*new_p;
+	int		rc;
+	DECLARE_ITC_VAR(alloc_time);	// Time for "vmalloc()"
+	DECLARE_ITC_VAR(lock_time);	// Time for "lock_page()"
+	DECLARE_ITC_VAR(unlock_time);	// Time for "unlock_page()"
+	DECLARE_ITC_VAR(free_time);	// "__free_pages()", "page_cache_release()"
+
+	//
+	// Allocate the new page in advance. It is less dangerous
+	// - to have a page "floating around" and then take locks
+	// than
+	// - to acquire some locks (e.g. to be able to check the conditions)
+	//   and then allocate the page
+	//
+	// Do not insist on allocating the page...
+	//
+	SAVE_ITC(/* out */ alloc_time);
+	new_p = alloc_pages_node(node, GFP_HIGHUSER | __GFP_NORETRY, 0);
+	STORE_DELAY(/* in */ alloc_time, /* out */ page_alloc);
+	if (new_p == NULL){
+		put_page(old_p);
+		PRINT_ERR("No more memory on node %d\n", node);
+		ERROR_CNT(no_memory);
+		return -ENOMEM;
+	}
+	SAVE_ITC(/* out */ lock_time);
+	lock_page(old_p);
+	STORE_DELAY(/* in */ lock_time, /* out */ page_lock);
+
+	//
+	// Would be too long to do everything here.
+	//
+	rc = check_migr_1_page_part_2(old_p, new_p, mm, pte);
+
+	SAVE_ITC(/* out */ unlock_time);
+	unlock_page(old_p);
+	STORE_DELAY(/* in */ unlock_time, /* out */ page_unlock);
+	PRINT("check_migr_1_page_part_2() returned: %d\n", rc);
+	if (rc == 0){
+		//
+		// The old page was "lru_cache_add_active()"-ed e.g. in
+		// "do_anonymous_page()". As on entry the old page was again
+		// "get_page()"-ed, its reference counter is at least 2 right now.
+		//
+		page_cache_release(old_p);
+		_statistics.count[src_node][node]++;
+	} else{
+		SAVE_ITC(/* out */ free_time);
+		__free_pages(new_p, 0);
+		STORE_DELAY(/* in */ free_time, /* out */ page_free);
+	}
+	//
+	// On success, "put_page()" sets free the old page
+	// (unless someone else got hold of it in the mean time).
+	//
+	SAVE_ITC(/* out */ free_time);
+	put_page(old_p);
+	STORE_DELAY(/* in */ free_time, /* out */ page_free);
+	return rc == 0 ? 1 : 0;
+}
+
+
+/*
+ * Migrate a page identified by its PTE.
+ *
+ * Arguments:	pte:		-> PTE of the page to be moved
+ *		node:		Destination NUMA node
+ *		mm:		-> victim "mm_struct"
+ *
+ * Returns:	1:		Success
+ *		0:		We cannot cope with this page (it is valid, though)
+ *		-Exxx:		Fatal errors
+ *
+ * Note:	"mm->page_table_lock" and "mm->mmap_sem" have to be held.
+ */
+STATIC INLINE int
+migr_1_page_by_pte(pte_t * const pte, const int node, struct mm_struct * const mm)
+{
+	const phaddr_t	old_addr = pte_val(*pte) & _PFN_MASK;
+	const int	src_node = paddr_to_nid(old_addr);
+	struct page	* const old_p = pfn_to_page(old_addr >> PAGE_SHIFT);
+
+	dump_page("\nOld", old_p);
+	if (node == src_node){
+		PRINT_ETC("Old ph adr:\t0x%016llx old node: %d new node: %d\n",
+							old_addr, src_node, node);
+		return 1;			// Done :-)
+	}
+	//
+	// Actually, there is no need to grab the old page because it is sure that it
+	// has been "get_page()"-ed before and we still keep "->page_table_lock".
+	// We are going to invoke "common_check_migrate_1_page()" that is used by the
+	// physical address driven migration, too. This latter - not knowing in advance
+	// whom a page belongs to and what "->page_table_lock" is to take - needs to
+	// grab the old page.
+	// Invoking the common service requires us to do the same.
+	//
+	get_page(old_p);			// Should we call "page_cache_get()" ?
+	//
+	// The old page will be "put_page()"-ed.
+	//
+	return common_check_migrate_1_page(src_node, old_p, node, mm, pte);
+}
+
+
+/*
+ * Migrate some pages identified by their physical address from a NUMA node to another.
+ *
+ * Arguments:	table:		-> the user buffer containing the physical addresses of
+ *				the pages to be migrated.
+ *				Max. "PAGE_SIZE / sizeof(phaddr_t *)" of them can be
+ *				mifgrated at once.
+ *		n:		Number of the physical page addresses
+ *		node:		Destination NUMA node
+ *		pid:		Pages are assumed to belong to this process
+ *
+ * Returns:	On (partial) success, the number of the pages actually migrated is
+ *		returned (in form of "struct _un_success_count_").
+ *		As usual, "-Exxx" returned on errors.
+ */
+STATIC INLINE long long
+batch_migrate(const caddr_t table, size_t n, const int node, const pid_t pid)
+{
+	int				rc;
+	phaddr_t			*p, *bp;
+	struct mm_struct		*mm;
+	struct _un_success_count_	count = { 0, 0};
+	DECLARE_ITC_VAR(alloc_time);		// Time for "vmalloc()"
+	DECLARE_ITC_VAR(mmap_sem);		// Time for "down_read(&mm->mmap_sem)"
+	DECLARE_ITC_VAR(pgd_lock);		// "spin_lock(&mm->page_table_lock)"
+	DECLARE_ITC_VAR(pgd_unlock);		// "spin_unlock(&mm->page_table_lock)"
+	DECLARE_ITC_VAR(pgd_scan_t);		// PGD scan time
+
+	if (pid != 0 && pid != current->pid){
+		//
+		//  Look up the "mm_struct" belonging to the process ID.
+		//
+		if ((mm = look_up_mm(pid)) == NULL){
+			PRINT_ERR(illegal_pid);
+			ERROR_CNT(bad_request);
+			return -ESRCH;
+		}
+		//
+		// On success, "mm->mm_users" got incremented to make sure that
+		// "mm_struct" does not go away.
+		//
+	} else {
+		mm = current->mm;
+		//
+		// Actually, there is no need to grab "mm" because it is ours, wont go
+		// away in the mean time. As we do not want to ask questions when
+		// releasing it...
+		// It is safe just to increment the counter: it is ours.
+		//
+		atomic_inc(&mm->mm_users);
+	}
+	//
+	// Fetch the table of the addresses.
+	//
+	SAVE_ITC(/* out */ alloc_time);
+	bp = vmalloc(PAGE_SIZE);
+	STORE_DELAY(/* in */ alloc_time, /* out */ page_alloc);
+	if (bp == NULL){
+		mmput(mm);
+		PRINT_ERR(no_momory);
+		ERROR_CNT(no_memory);
+		return -ENOMEM;
+	}
+	if (copy_from_user(bp, table, n * sizeof(phaddr_t)) != 0){
+		vfree(bp);
+		mmput(mm);
+		PRINT_ERR(ill_user_buff);
+		ERROR_CNT(bad_request);
+		return -EFAULT;
+	}
+	SAVE_ITC(/* out */ mmap_sem);
+	down_read(&mm->mmap_sem);		// Protect the VMA list
+	STORE_DELAY(/* in */ mmap_sem, /* out */ mmap_sem);
+	dump_mm(mm);
+	//
+	// We need the page table lock to synchronize with "kswapd"
+	// and the SMP-safe atomic PTE updates.
+	//
+	SAVE_ITC(/* out */ pgd_lock);
+	spin_lock(&mm->page_table_lock);
+	STORE_DELAY(/* in */ pgd_lock, /* out */ pgd_lock);
+	//
+	// Check to see if the pages are mapped by "mm->pgd" as user pages.
+	// For those which are, call "get_page()" to make sure they do not go away.
+	// "1" will be OR-ed to invalid addresses.
+	//
+	SAVE_ITC(/* out */ pgd_scan_t);
+	rc = check_pages_if_in_pgd(bp, n, mm);
+	STORE_DELAY(/* in */ pgd_scan_t, /* out */ pgd_scan);
+	if (rc >= 0){
+		//
+		// The number of the valid addresses is equal to "rc".
+		//
+		ERROR_CNT_ADD(non_existent_addr, n - rc);
+		for (n = rc, p = bp; n > 0; p++){
+#if defined(_TEST_)
+			if (p - bp >= PAGE_SIZE / sizeof(phaddr_t))
+				panic("\nAddress table overflow\n");
+#endif
+			if (*p & 1)		// Address has not been validated
+				continue;
+			//
+			// Check & migrate the next page.
+			// The old page gets "put_page()"-ed.
+			//
+			if ((rc = check_migrate_1_page(*p, node, mm)) < 0)
+				break;
+			else if (rc > 0){
+				count.successful++;
+				n--;		// Decrement for a good address only
+			} else
+				count.failed++;
+		}
+		if (rc >= 0)
+			rc = *(long long *) &count;	// Yeh, I know...
+	}
+	//
+	// Let the others complete the page fault handler code. They will find the
+	// condition "someone has already installed the PTE" to be TRUE.
+	//
+	SAVE_ITC(/* out */ pgd_unlock);
+	spin_unlock(&mm->page_table_lock);
+	STORE_DELAY(/* in */ pgd_unlock, /* out */ pgd_unlock);
+	up_read(&mm->mmap_sem);
+	vfree(bp);
+	mmput(mm);				// Decrement "mm->mm_users" and free
+						//	"*mm" if the counter becomes zero
+	return rc;
+}
+
+
+/*
+ * Check & migrate the pages one by one.
+ *
+ * Arguments:	address:	Physical addresses of the page to be migrated
+ *		node:		Destination NUMA node
+ *		mm:		-> victim "mm_struct"
+ *
+ * Returns:	1:		Migration O. K.
+ *		0:		Minor error, no actual migration has been done
+ *		-Exxx:		Catastrophic error
+ *
+ * Notes:	- "mm->page_table_lock" and "mm->mmap_sem" have to be held.
+ *		- The old page is "get_page()"-ed on entry to meke sure it does not go
+ *		  away in the mean time - on return it gets "put_page()"-ed.
+ */
+STATIC INLINE int
+check_migrate_1_page(const phaddr_t address, const int node, struct mm_struct * const mm)
+{
+	const int		src_node = paddr_to_nid(address);
+	const unsigned long	old_pfn = address >> PAGE_SHIFT;
+	struct page		*old_p;
+
+	//
+	// Should be revised for the node hot plug :-)
+	//
+#if defined(_TEST_)
+	if (src_node == -1)
+		panic("\nCannot map source address to node\n");
+	if (!node_online(src_node))
+		panic("\nSource node not online\n");
+	if (!pfn_valid(old_pfn))
+		panic("\nNot a valid source pfn\n");
+#endif
+	old_p = pfn_to_page(old_pfn);
+	if (node == src_node){
+		PRINT_ETC("Old ph adr:\t0x%016llx old node: %d new node: %d\n",
+								address, src_node, node);
+		put_page(old_p);
+		return 1;			// Done :-)
+	}
+	return common_check_migrate_1_page(src_node, old_p, node, mm, NULL);
+}
+
+
+/*
+ * The real page migration is done here.
+ *
+ * Arguments:	old:		-> old page structure
+ *		new:		-> new page structure
+ *		node:		Destination NUMA node
+ *		pte:		-> PTE of the page to be moved
+ *
+ * Returns:	Negative values (like -Exxx) indicate errors
+ *
+ * Notes:	- The old page has to be "get_page()"-ed and locked.
+ *		- Its "pte_chain" has to locked.
+ *		- The new page and its "pte_chain" has to locked.
+ *		- "mm->page_table_lock" and "mm->mmap_sem" have to be held.
+ */
+STATIC INLINE int
+page_migrate_2(struct page * const old, struct page * const new,
+					struct mm_struct * const mm, pte_t *pte_p)
+{
+	const struct page	*pte_page;
+	struct vm_area_struct	*vma;
+	pte_t			pte;
+	vaddr_t			vaddress;
+	DECLARE_ITC_VAR(vma_time);		// Time for "find_vma()"
+	DECLARE_ITC_VAR(flush_tlb_time);	// Time for "flush_tlb_page()"
+	DECLARE_ITC_VAR(add_lru_time);		// Time for "lru_cache_add_active()"
+	DECLARE_ITC_VAR(copy_time);		// Time for "copy_user_highpage()"
+	DECLARE_ITC_VAR(upd_mmu_cache);		// Time for "update_mmu_cache()"
+
+	if (!PageDirect(old)){
+		PRINT_ERR("Direct mapped pages only\n");
+		ERROR_CNT(page_type_not_supp);
+		return -EFAULT;
+	}
+	if (pte_p == NULL)			// Architecture independent code :-)
+		pte_p = rmap_ptep_map(old->pte.direct);
+	//
+	// "struct page" of the page that hotst the PTE.
+	//
+	pte_page = kmap_atomic_to_page(pte_p);	// Architecture independent code :-)
+	//
+	// "pte_page->mapping" points at the victim process'es "mm_struct"
+	//
+#if defined(_TEST_)
+	if (mm != (struct mm_struct *) pte_page->mapping)
+		panic("\nBroken r-map ???\n");
+	dump_mm(mm);
+#endif
+	//
+	// "page->index" has the high bits of the address; the lower bits of the address
+	// are calculated from the offset of the PTE within the page table page.
+	//
+	vaddress = pte_page->index + ((unsigned long) pte_p & ~PAGE_MASK) * PTRS_PER_PTE;
+	PRINT("Virtual addr:\t0x%lx\n", vaddress);
+	//
+	// Double check if the virtual address is still valid.
+	//
+	SAVE_ITC(/* out */ vma_time);
+	vma = find_vma(mm, vaddress);		// "vma" cache should help much
+	STORE_DELAY(/* in */ vma_time, /* out */ find_vma);
+	if (vma == NULL || vma->vm_start > vaddress){
+		PRINT_ERR("During mremap() ?\n");
+		ERROR_CNT(page_gone_away);
+		rmap_ptep_unmap(pte_p);
+		return -EFAULT;
+	}
+	dump_vma(vma);
+	//
+	// Nuke the page table entry.
+	//
+	flush_cache_page(vma, vaddress);	// Architecture independent code :-)
+	pte = ptep_get_and_clear(pte_p);
+	SAVE_ITC(/* out */ flush_tlb_time);
+	flush_tlb_page(vma, vaddress);		// Architecture independent code :-)
+	STORE_DELAY(/* in */ flush_tlb_time, /* out */ flush_tlb);
+	//
+	// From now on, the other CPUs cannot touch the content of the page. Should they
+	// try to, they would observe page faults. They pass easily "mmap_sem" beacause
+	// they take it for read, too. As we hold "page_table_lock", they queue up in the
+	// page fault handler.
+	//
+	PRINT("Old ph addr:\t0x%016lx\n", page_to_phys(old));
+	PRINT("Old PTE:\t0x%016lx\n", pte_val(pte));
+	PRINT("_PFN_MASK:\t0x%016lx\n", _PFN_MASK);
+	//
+	// Copy some of the page structure.
+	//
+	dump_page("Source", old);
+	new->flags = (new->flags & ~FLAG_MASK) | (old->flags & FLAG_MASK);
+	new->pte.direct = old->pte.direct;
+	SetPageDirect(new);			// Direct mapped pages only
+	old->pte.direct = NULL;
+	ClearPageDirect(old);
+	if (PagePrivate(new))
+		new->private = old->private;
+	SAVE_ITC(/* out */ add_lru_time);
+	lru_cache_add_active(new);
+	STORE_DELAY(/* in */ add_lru_time, /* out */ add_lru);
+	dump_page("New", new);
+	//
+	// Here is where the data is copied.
+	//
+	SAVE_ITC(/* out */ copy_time);
+	copy_user_highpage(new, old, vaddress);	// Architecture independent code :-)
+	STORE_DELAY(/* in */ copy_time, /* out */ copy);
+	//
+	// The new PTE keeps everything but the PFN.
+	//
+	pte = mk_pte(new, __pgprot((pte_val(pte) & ~_PFN_MASK)));
+	PRINT("New ph addr:\t0x%016lx\nNew PTE:\t0x%016lx\n\n",
+							page_to_phys(new), pte_val(pte));
+	set_pte(pte_p, pte);
+	SAVE_ITC(/* out */ upd_mmu_cache);
+	update_mmu_cache(vma, vaddress, pte);	// Architecture independent code :-)
+	STORE_DELAY(/* in */ upd_mmu_cache, /* out */ update_mmu_cache);
+	rmap_ptep_unmap(pte_p);
+	return 0;
+}
+
+
+/*
+ * Some more tests and go on with the page migration.
+ *
+ * Arguments:	old:		-> old page structure
+ *		new:		-> new page structure
+ *		node:		Destination NUMA node
+ *		pte:		-> PTE of the page to be moved
+ *
+ * Returns:	Negative values indicate errors
+ *
+ * Notes:	- The old page has to be "get_page()"-ed and locked.
+ *		- "mm->page_table_lock" and "mm->mmap_sem" have to be held.
+ */
+STATIC INLINE int
+check_migr_1_page_part_2(struct page * const old, struct page * const new,
+					struct mm_struct * const mm, pte_t * const pte)
+{
+	int rc;
+	DECLARE_ITC_VAR(pte_chain_lock_time);	// Time for "pte_chain_lock()"
+	DECLARE_ITC_VAR(unlock_time);		// Time for "unlock_page()"
+
+	if (PageReserved(old)){
+		PRINT_ERR("What shall I do with a reserved page ?\n");
+		ERROR_CNT(page_type_not_supp);
+		return -ENXIO;
+	}
+	if (PageError(old)){
+		PRINT_ERR("Page has got error(s)\n");
+		ERROR_CNT(errors);
+		return -EIO;
+	}
+	if (!PageUptodate(old)){
+		PRINT_ERR("Page has no valid data ???\n");
+//		return -EIO;
+	}
+	if (PageCompound(old)){
+		PRINT_ERR("What shall I do with a compound page ?\n");
+		ERROR_CNT(page_type_not_supp);
+		return -ENXIO;
+	}
+	if (old->mapping != NULL){
+		PRINT_ERR("Anonymous pages only\n");
+		ERROR_CNT(page_type_not_supp);
+		return -ENXIO;
+	}
+	if (PageSwapCache(old)){
+		PRINT_ERR("What shall I do with a page in swap cache ?\n");
+		ERROR_CNT(page_type_not_supp);
+		return -ENXIO;
+	}
+	if (PageHighMem(page)){
+		PRINT_ERR("What shall I do with a HIGHMEM page ?\n");
+		ERROR_CNT(page_type_not_supp);
+		return -ENXIO;
+	}
+	SAVE_ITC(/* out */ pte_chain_lock_time);
+	pte_chain_lock(old);
+	STORE_DELAY(/* in */ pte_chain_lock_time, /* out */ pte_chain_lock);
+	if (!page_mapped(old)){			// Actually means "r-mapped"
+		PRINT_ERR("Page not in r-map\n");
+		pte_chain_unlock(old);
+		ERROR_CNT(page_type_not_supp);
+		return -EFAULT;
+	}
+	//
+	// As nobody else should know about this new page, taking these locks should not
+	// be in conflict with anything.
+	//
+	if (TestSetPageLocked(new))
+		panic("\nSomeone is stealing my new page\n");
+	if (!pte_chain_trylock(new))
+		panic("\nSomeone is stealing my new pte chain\n");
+
+	//
+	// The real page migration.
+	//
+	rc = page_migrate_2(old, new, mm, pte);
+
+	pte_chain_unlock(new);
+	SAVE_ITC(/* out */ unlock_time);
+	unlock_page(new);
+	STORE_DELAY(/* in */ unlock_time, /* out */ new_page_unlock);
+	pte_chain_unlock(old);
+	return rc;
+}
+
+
+/*
+ * Check to see if the pages are mapped by "mm->pgd" as user pages.
+ * For those which are, call "get_page()" to make sure they do not go away.
+ *
+ * Arguments:	phaddresses:	-> the user buffer containing the physical addresses of
+ *				the pages to be migrated
+ *		n:		Number of the physical page addresses
+ *		mm:		-> victim "mm_struct"
+ *
+ * Returns:	The number of the addresses validated
+ *
+ * Note:	Caller has to hold "mm->mmap_sem" for read and "mm->page_table_lock".
+ */
+STATIC INLINE int
+check_pages_if_in_pgd(phaddr_t * const phaddresses, const size_t n,
+						const struct mm_struct * const mm)
+{
+	const pgd_t	*pgd;
+	const pmd_t	*pmd;
+	const pte_t	*pte, *pte0;
+	unsigned long	g, m, e;
+	unsigned int	i, found = 0;
+	phaddr_t	*p;
+
+	//
+	// Mark the addresses as not already validated.
+	//
+	for (i = 0, p = phaddresses; i < n; i++, p++)
+		*p |= 1;			// "(1 & _PFN_MASK) == 0"
+	//
+	// Check the user pages only.
+	// Note: "mm->pgd" is an identity mapped virtual address.
+	//
+	for (g = FIRST_USER_PGD_NR, pgd = mm->pgd + g; g < USER_PTRS_PER_PGD;
+									g++, pgd++){
+		if (pgd_none(*pgd) || pgd_bad(*pgd))
+			continue;
+		//
+		// "*pgd" is a physical address.
+		//
+		for (m = 0, pmd = pmd_offset(pgd, 0); m < PTRS_PER_PMD; m++, pmd++){
+			//
+			// "pmd" contains an identity mapped virtual address.
+			//
+			if (pmd_none(*pmd) || pmd_bad(*pmd))
+				continue;
+			//
+			// "*pmd" is a physical address.
+			//
+			pte0 = pte_offset_map(pmd, 0);
+			//
+			// "pte0" contains some kind of virtual address of the
+			// beginning of a PTE page.
+			//
+			for (e = 0, pte = pte0; e < PTRS_PER_PTE; e++, pte++){
+				if (!pte_present(*pte))
+					continue;
+				//
+				// Check this PTE against the list of the addresses.
+				//
+				for (i = 0, p = phaddresses; i < n; i++, p++){
+					if ((pte_val(*pte) & _PFN_MASK) !=
+									(*p & _PFN_MASK))
+						continue;
+					*p &= _PFN_MASK;	// Validate the address
+					PRINT("Virtual addr:\t0x%016lx\n",
+									__VA(g, m, e));
+					//
+					// Make sure the page does not go away.
+					// Should we call "page_cache_get()" instead ?
+					//
+					get_page(pfn_to_page(*p >> PAGE_SHIFT));
+					if (++found == n){
+						pte_unmap(pte0);
+						return found;
+					}
+					//
+					// There should be no more than one address on
+					// the list that matches this PTE.
+					//
+					break;
+				}
+			}
+			pte_unmap(pte0);
+		}
+	}
+	return found;
+}
+
+
+/*
+ * Look up an "mm_struct" belonging to a process ID.
+ *
+ * "NULL" is returned on failure.
+ *
+ * Notes:	- On success, "->mm_users" gets incremented to make sure that "mm_struct"
+ *		  does not go away.
+ *		- "->mm" of a kernel thread is "NULL"; anyway, we don't dare to touch a
+ *		  kernel thread
+ */
+STATIC struct mm_struct *
+look_up_mm(const pid_t pid)
+{
+	struct task_struct	*p;
+	struct mm_struct	*mm;
+	DECLARE_ITC_VAR(time);			// "mm" look up time
+
+	SAVE_ITC(/* out */ time);
+	read_lock(&tasklist_lock);
+	if ((p = find_task_by_pid(pid)) == NULL){
+		read_unlock(&tasklist_lock);
+		STORE_DELAY(/* in */ time, /* out */ mm_lookup);
+		return NULL;
+	}
+	//
+	// "get_task_mm()" includes "task_lock()" that "nests both inside and outside of
+	// read_lock(&tasklist_lock)" - as a note in "sched.h" states.
+	//
+	mm = get_task_mm(p);			// Can be "NULL" for a kernel thread
+	//
+	// On success, "mm->mm_users" got incremented to make sure that "mm_struct" does
+	// not go away.
+	//
+	read_unlock(&tasklist_lock);
+	STORE_DELAY(/* in */ time, /* out */ mm_lookup);
+	return mm;
+}
+
+
+#if defined(_NEED_STATISTICS_)
+
+
+/*
+ * Fetch and clear the statistics.
+ *
+ * Accessed in a non atomic way. Who cares? Just some statistics :-)
+ */
+STATIC INLINE int
+page_migrate_statistics(const caddr_t vaddress, const int flag)
+{
+	//
+	// Assuming all the CPU-s are clocked at the same frequency.
+	//
+	_statistics.t.cyc_per_usec = local_cpu_data->cyc_per_usec;
+	if (copy_to_user(vaddress, &_statistics, sizeof _statistics) != 0)
+		return -EFAULT;
+	if (flag)
+		memset(&_statistics, 0,sizeof _statistics);
+	return 0;
+}
+
+
+#endif	// #if defined(_NEED_STATISTICS_)
+
+
+#if defined(_TEST_)
+
+
+void
+dump_mm(const struct mm_struct * const mm)
+{
+	if (_pr_flag_ & PRINT_mm){
+		PRINT("mm: 0x%p\n", mm);
+		PRINT("mmap: 0x%p mm_rb.rb_node: 0x%p\n", mm->mmap, mm->mm_rb.rb_node);
+		PRINT("mmap_cache: 0x%p free_area_cache: 0x%lx\n", mm->mmap_cache,
+								mm->free_area_cache);
+		PRINT("pgd: 0x%p mm_users: %d mm_count: %d map_count: %d\n",
+					mm->pgd, atomic_read(&mm->mm_users),
+					atomic_read(&mm->mm_count), mm->map_count);
+		PRINT("mmap_sem.count: %d mmap_sem.wait_lock: %d\n", mm->mmap_sem.count,
+							mm->mmap_sem.wait_lock.lock);
+		PRINT("&mmap_sem.wait_list: 0x%p next: 0x%p prev: 0x%p\n",
+				&mm->mmap_sem.wait_list, mm->mmap_sem.wait_list.next,
+							mm->mmap_sem.wait_list.prev);
+		PRINT("page_table_lock: %u\n", mm->page_table_lock.lock);
+		PRINT("&mmlist: 0x%p next: 0x%p prev: 0x%p\n", &mm->mmlist,
+						mm->mmlist.next, mm->mmlist.prev);
+		PRINT("start_code: 0x%lx end_code: 0x%lx\n", mm->start_code,
+									mm->end_code);
+		PRINT("start_data: 0x%lx end_data: 0x%lx\n", mm->start_data,
+									mm->end_data);
+		PRINT("start_brk: 0x%lx brk: 0x%lx start_stack: 0x%lx\n", mm->start_brk,
+							mm->brk, mm->start_stack);
+		PRINT("arg_start: 0x%lx arg_end: 0x%lx\n", mm->arg_start, mm->arg_end);
+		PRINT("env_start: 0x%lx env_end: 0x%lx\n", mm->env_start, mm->env_end);
+		PRINT("rss: 0x%lx total_vm: 0x%lx locked_vm: 0x%lx\n", mm->rss,
+							mm->total_vm, mm->locked_vm);
+		PRINT("def_flags: 0x%lu cpu_vm_mask: 0x%lx\n", mm->def_flags,
+								mm->cpu_vm_mask);
+//	unsigned long saved_auxv[40];
+		PRINT("dumpable: %u ", mm->dumpable);
+#ifdef CONFIG_HUGETLB_PAGE
+		PRINT("used_hugetlb: 0x%d ", mm->used_hugetlb);
+#endif
+		PRINT("context: 0x%lu core_waiters: %d\n", mm->context,
+								mm->core_waiters);
+		PRINT("core_startup_done: 0x%p\n", mm->core_startup_done);
+		PRINT("core_done.done: %d ", mm->core_done.done);
+		PRINT("core_done.wait.lock: %u\n", mm->core_done.wait.lock.lock);
+		PRINT("&core_done.wait.task_list: 0x%p next: 0x%p prev: 0x%p\n",
+		&mm->core_done.wait.task_list, mm->core_done.wait.task_list.next,
+						mm->core_done.wait.task_list.prev);
+		PRINT("ioctx_list_lock.read_counter: %d ",
+						mm->ioctx_list_lock.read_counter);
+		PRINT("ioctx_list_lock.write_lock: %d\n",
+						mm->ioctx_list_lock.write_lock);
+		PRINT("ioctx_list: 0x%p &default_kioctx: 0x%p\n\n", mm->ioctx_list,
+								&mm->default_kioctx);
+	}
+}
+
+
+void
+dump_vma(const struct vm_area_struct * const vma)
+{
+	if (_pr_flag_ & PRINT_vma){
+		PRINT("vm_area: 0x%p\n", vma);
+		PRINT("mm: 0x%p\n", vma->vm_mm);
+		PRINT("start: 0x%lx end: 0x%lx\n", vma->vm_start, vma->vm_end);
+		PRINT("next: 0x%p &rb: 0x%p\n", vma->vm_next, &vma->vm_rb);
+		PRINT("prot: 0x%lx flags: 0x%lx\n", pgprot_val(vma->vm_page_prot),
+									vma->vm_flags);
+		PRINT("&shared: 0x%p next: 0x%p prev: 0x%p\n", &vma->shared,
+						vma->shared.next, vma->shared.prev);
+		PRINT("ops: 0x%p private: 0x%p\n", vma->vm_ops, vma->vm_private_data);
+		PRINT("file: 0x%p pgoff: 0x%lx\n\n", vma->vm_file, vma->vm_pgoff);
+	}
+}
+
+
+void
+dump_page(const char * const text, const struct page * const p)
+{
+	if (_pr_flag_ & PRINT_page){
+		PRINT("%s page struct: 0x%p\n", text, p);
+		PRINT("flags: 0x%lx count: 0x%x\n", p->flags, atomic_read(&p->count));
+		PRINT("&list: 0x%p next: 0x%p prev: 0x%p\n", &p->list,
+							p->list.next, p->list.prev);
+		PRINT("mapping: 0x%p index: 0x%lx\n", p->mapping, p->index);
+		PRINT("&lru: 0x%p next: 0x%p prev: 0x%p\n", &p->lru,
+							p->lru.next, p->lru.prev);
+		if (PageDirect(p))
+			PRINT("pte.direct: 0x%p", p->pte.direct);
+		else
+			PRINT("pte.chain: 0x%p", p->pte.chain);
+		PRINT(" private: 0x%lx\n", p->private);
+#if defined(WANT_PAGE_VIRTUAL)
+		PRINT("virtual: 0x%p\n", p->virtual);
+#endif
+		PRINT("\n");
+	}
+}
+
+
+void
+dump_pte_stuff(const pte_t * const pte_addr)
+{
+	if (_pr_flag_ & PRINT_pte){
+		// "struct page" of the page that hosts the PTE.
+		const struct page * const pte_page = kmap_atomic_to_page(pte_addr);
+
+		PRINT("pte_paddr: 0x%p pte: 0x%016lx\n", pte_addr, pte_val(*pte_addr));
+		dump_page("\npte", pte_page);
+	}
+}
+
+
+#define	_DATA_		0x6000000000000000UL	// User data segment
+
+
+/*
+ * Give me a valid physical address (if "vaddress == -1"),
+ * otherwise translate a user mode virtual address to a physical one.
+ */
+phaddr_t
+gimme_an_address(caddr_t vaddress)
+{
+	const struct vm_area_struct	*vma;
+	const pgd_t			*pgd;
+	const pmd_t			*pmd;
+	const pte_t			*pte;
+	phaddr_t			phaddress = -EFAULT;
+
+	if (vaddress == (caddr_t) -1)
+		vaddress = (caddr_t) _DATA_;
+	PRINT("Virtual addr:\t0x%016lx\n", (vaddr_t) vaddress);
+	down_read(&current->mm->mmap_sem);
+	vma = find_vma(current->mm, (vaddr_t) vaddress);
+	if (vma == NULL || vma->vm_start > (vaddr_t) vaddress){
+		up_read(&current->mm->mmap_sem);
+		return -EFAULT;
+	}
+	spin_lock(&current->mm->page_table_lock);
+	do {
+		pgd = pgd_offset(current->mm, (vaddr_t) vaddress);
+		if (pgd_none(*pgd) || pgd_bad(*pgd))
+			break;
+		pmd = pmd_offset(pgd, (vaddr_t) vaddress);
+		if (pmd_none(*pmd) || pmd_bad(*pmd))
+			break;
+		pte = pte_offset_map(pmd, (vaddr_t) vaddress);
+		if (!pte_present(*pte)){
+			pte_unmap(pte);
+			break;
+		}
+		phaddress = pte_pfn(*pte) << PAGE_SHIFT;
+		pte_unmap(pte);
+	} while (0);
+	spin_unlock(&current->mm->page_table_lock);
+	up_read(&current->mm->mmap_sem);
+	PRINT("Physical addr:\t0x%016llx\n", (long long) phaddress);
+	return phaddress;
+}
+
+
+#endif // #if defined(_TEST_)
diff -Nru 2.6.4.ref/include/asm-generic/rmap.h 2.6.4.mig4/include/asm-generic/rmap.h
--- 2.6.4.ref/include/asm-generic/rmap.h	Tue Mar 16 10:18:15 2004
+++ 2.6.4.mig4/include/asm-generic/rmap.h	Thu Mar 25 08:59:42 2004
@@ -87,4 +87,45 @@
 }
 #endif
 
+/*
+ * Shared pages have a chain of pte_chain structures, used to locate
+ * all the mappings to this page. We only need a pointer to the pte
+ * here, the page struct for the page table page contains the process
+ * it belongs to and the offset within that process.
+ *
+ * We use an array of pte pointers in this structure to minimise cache misses
+ * while traversing reverse maps.
+ */
+#define NRPTE ((L1_CACHE_BYTES - sizeof(unsigned long))/sizeof(pte_addr_t))
+
+/*
+ * next_and_idx encodes both the address of the next pte_chain and the
+ * offset of the highest-index used pte in ptes[].
+ */
+struct pte_chain {
+	unsigned long next_and_idx;
+	pte_addr_t ptes[NRPTE];
+} ____cacheline_aligned;
+
+static inline struct pte_chain *pte_chain_next(struct pte_chain *pte_chain)
+{
+	return (struct pte_chain *)(pte_chain->next_and_idx & ~NRPTE);
+}
+
+static inline struct pte_chain *pte_chain_ptr(unsigned long pte_chain_addr)
+{
+	return (struct pte_chain *)(pte_chain_addr & ~NRPTE);
+}
+
+static inline int pte_chain_idx(struct pte_chain *pte_chain)
+{
+	return pte_chain->next_and_idx & NRPTE;
+}
+
+static inline unsigned long
+pte_chain_encode(struct pte_chain *pte_chain, int idx)
+{
+	return (unsigned long)pte_chain | idx;
+}
+
 #endif /* _GENERIC_RMAP_H */
diff -Nru 2.6.4.ref/include/asm-ia64/page_migrate.h 2.6.4.mig4/include/asm-ia64/page_migrate.h
--- 2.6.4.ref/include/asm-ia64/page_migrate.h	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig4/include/asm-ia64/page_migrate.h	Thu Mar 25 08:59:42 2004
@@ -0,0 +1,245 @@
+#define	_TEST_
+#define	_NEED_STATISTICS_
+
+
+/*
+ * Migrate pages from a NUMA node to another.
+ * ==========================================
+ *
+ * Version 0.1, 23th of March 2004
+ * By Zoltan Menyhart, Bull S.A. <Zoltan.Menyhart_AT_bull.net@no.spam.org>
+ * The usual GPL applies.
+ *
+ * (See "migrate.txt".)
+ *
+ * Sytem call syntax:
+ *
+ *	long long sys_page_migrate(int command, caddr_t address, size_t length,
+ *								int node, pid_t pid);
+ *
+ * On error "-1" is returned and "errno" holds the error code.
+ *
+ * The following commands are available:
+ */
+enum {
+/*
+ * - Return a physical address.
+ *   (testing only, the kernel has to be compiled with "#define	_TEST_")
+ */
+	_GIMME_AN_ADDRESS_,
+/*
+ *   On entry, if "address" is a valid virtual address in the address space of the
+ *   current task with an existing backing page, then its physical address is returned;
+ *   if it is equal to "-1L", then the system finds a valid physical address on its own.
+ *   The other arguments are don't care.
+ *
+ * - Fetch and clear the statistics.
+ */
+	_STATISTICS_,
+/*
+ *   "address" is a pointer to the user's buffer. If "length != 0" then having bben
+ *   fetched, the statistics get cleared. The other arguments are don't care.
+ *
+ * - Obtain the size of the statistics structure (see "struct _statistics_size_"):
+ */
+	_SIZEOF_STATISTICS_,
+/*
+ *   The arguments are don't care.
+ *
+ * - Batch migrate pages from a NUMA node to another.
+ */
+	_PHADDR_BATCH_MIGRATE_,
+/*
+ *   "address" points at the user table containing the physical address of the pages to
+ *   be migrated. "length" is the number of the physical addresses in the buffer. Max.
+ *   "PAGE_SIZE / sizeof(phaddr_t)" of them can be mifgrated at once.
+ *   "node" is the destination NUMA node.
+ *   Addresses are assumed to belong to the process indicated by "pid".
+ *   The number of the pages actually migrated is returned
+ *   (see "struct _un_success_count_).
+ *
+ * - Migrate virtual address range of a process:
+ */
+	_VA_RANGE_MIGRATE_,
+/*
+ *   "sddress" is the starting virtual address in a process'es address space.
+ *   "length" is the length of the address range to be migrated
+ *   Addresses are assumed to belong to the process indicated by "pid".
+ *   The number of the pages actually migrated is returned
+ *   (see "struct _un_success_count_).
+ */
+};
+
+
+/*
+ * Type of a physical address -- hopefully enough for all architectures.
+ * (We allow negative values, too, for indicating some errors.)
+ */
+typedef	long long	phaddr_t;
+
+
+struct _un_success_count_ {
+	unsigned int	successful;		// Pages successfully migrated
+	unsigned int	failed;			// Minor failures
+};
+
+
+struct _statistics_size_ {
+	unsigned int	sizeof_statistics;	// sizeof(struct _statistics_)
+	unsigned int	max_nodes;		// MAX_NUMNODES
+};
+
+
+/*
+ * Statistics are accessed in a non atomic way. Who cares? Just some statistics :-)
+ */
+struct _statistics_ {
+	struct {					// Error counters
+		unsigned long	non_existent_addr;
+		unsigned long	page_gone_away;
+		unsigned long	busy;
+		unsigned long	bad_request;
+		unsigned long	no_memory;		// On the target node
+		unsigned long	page_type_not_supp;
+		unsigned long	errors;			// "PageError(page)" is set
+	} e;
+	struct {					// Clock ticks
+		unsigned long	total;
+		unsigned long	page_alloc;
+		unsigned long	page_free;
+		unsigned long	page_lock;
+		unsigned long	new_page_unlock;
+		unsigned long	page_unlock;
+		unsigned long	validation;
+		unsigned long	pgd_scan;
+		unsigned long	pgd_lock;
+		unsigned long	pgd_unlock;
+		unsigned long	mm_list_lock;
+		unsigned long	mmap_sem;
+		unsigned long	pte_chain_lock;
+		unsigned long	find_vma;
+		unsigned long	flush_tlb;
+		unsigned long	add_lru;
+		unsigned long	copy;
+		unsigned long	update_mmu_cache;
+		unsigned long	mm_lookup;
+		unsigned long	cyc_per_usec;
+		unsigned long	perfbullctl;
+		unsigned long	pci_cfg_rd;
+		unsigned long	pci_cfg_wr;
+	} t;
+	struct {					// Event counters
+		unsigned long	mm_hit;
+		unsigned long	pgd_scan;
+		unsigned long	perfbullctl;
+		unsigned long	pci_cfg_rd;
+		unsigned long	pci_cfg_wr;
+	} c;
+#if defined(__KERNEL__)
+	unsigned long	count[MAX_NUMNODES][MAX_NUMNODES];
+#else
+	unsigned long	count[0][0];
+#endif
+};
+
+
+#if !defined(__KERNEL__)
+
+
+#include <unistd.h>
+#include <sys/types.h>
+
+#if !defined(__NR_page_migrate)
+#define __NR_page_migrate	1276
+#endif
+
+
+/*
+ * Migrate some pages of the process of PID.
+ */
+static inline int
+migrate_ph_pages(const phaddr_t * const table, const size_t length, const int node,
+				struct _un_success_count_ * const p, const pid_t pid)
+{
+	union {
+		long long			ll;
+		struct _un_success_count_	s;
+	} u;
+
+	u.ll = syscall(__NR_page_migrate, _PHADDR_BATCH_MIGRATE_,
+							table, length, node, pid);
+	if (u.ll == -1)
+		return -1;
+	if (p != NULL){
+		p->successful = u.s.successful;
+		p->failed = u.s.failed;
+	}
+	return 0; 
+}
+
+
+/*
+ * Migrate virtual address range of the process of PID.
+ */
+static inline int
+migrate_virt_addr_range(const caddr_t address, const size_t length, const int node,
+				struct _un_success_count_ * const p, const pid_t pid)
+{
+	union {
+		long long			ll;
+		struct _un_success_count_	s;
+	} u;
+
+	u.ll = syscall(__NR_page_migrate, _VA_RANGE_MIGRATE_,
+							address, length, node, pid);
+	if (u.ll == -1)
+		return -1;
+	if (p != NULL){
+		p->successful = u.s.successful;
+		p->failed = u.s.failed;
+	}
+	return 0; 
+}
+
+
+/*
+ * Obtain the size of the statistics structure.
+ */
+static inline int
+get_stat_sizes(struct _statistics_size_ * const p)
+{
+	union {
+		long long			ll;
+		struct _statistics_size_	s;
+	} u;
+
+	u.ll = syscall(__NR_page_migrate, _SIZEOF_STATISTICS_, 0, 0, 0, 0);
+	if (u.ll == -1)
+		return -1;
+	if (p != NULL)
+		*p = u.s;
+	return 0; 
+}
+
+
+/*
+ * Fetch and clear the statistics.
+ */
+static inline int
+get_staistics(struct _statistics_ * const p, const long slear_flag)
+{
+	return syscall(__NR_page_migrate, _STATISTICS_, p, slear_flag, 0, 0);
+}
+
+
+/*
+ * Return a physical address.
+ */
+static inline phaddr_t
+gimme_a_ph_address(const caddr_t p)
+{
+	return syscall(__NR_page_migrate, _GIMME_AN_ADDRESS_, p, 0, 0, 0);
+}
+
+
+#endif
diff -Nru 2.6.4.ref/include/asm-ia64/pgtable.h 2.6.4.mig4/include/asm-ia64/pgtable.h
--- 2.6.4.ref/include/asm-ia64/pgtable.h	Tue Mar 16 10:18:15 2004
+++ 2.6.4.mig4/include/asm-ia64/pgtable.h	Thu Mar 25 08:59:42 2004
@@ -112,6 +112,28 @@
 #define PTRS_PER_PTE	(__IA64_UL(1) << (PAGE_SHIFT-3))
 
 /*
+ * The IA64 architecture does not decode all the MSB-s of virtual addresses for PGD, PMD
+ * and PTE indices, i.e. IA64 has got holes or aliases in the virtual address space.
+ * These def's are provided to check to see if an "address" -- "length" pair spans over
+ * virtual address holes or it creates illegal alias to an otherwise valid address.
+ * (User mode only.)
+ */
+#define	__VA_BITS_PER_REGION	(PAGE_SHIFT - 3 - 3 +	/* PGD low index */		\
+				2 * (PAGE_SHIFT - 3) +	/* PMD and PTE indices */	\
+				PAGE_SHIFT)		/* The page itself */
+#define	__VA_ALIAS_MASK		((1UL << __VA_BITS_PER_REGION) - 1)
+#define	__IS_VA_ALIAS(address, length)							\
+				((~__VA_ALIAS_MASK & (address)) !=			\
+					(~__VA_ALIAS_MASK & ((address) + (length) - 1)))
+
+/*
+ * Virtual address composed by use of PGD, PMD and PTE indices:
+ */
+#define	__VA(pgdi, pmdi, ptei)	(((pgdi) >> (PAGE_SHIFT - 6)) << 61 |			\
+				((pgdi) & ((PTRS_PER_PGD >> 3) - 1)) << PGDIR_SHIFT |	\
+				(pmdi) << PMD_SHIFT | (ptei) << PAGE_SHIFT)
+
+/*
  * All the normal masks have the "page accessed" bits on, as any time
  * they are used, the page is accessed. They are cleared only by the
  * page-out routines.
@@ -325,8 +347,10 @@
 	(init_mm.pgd + (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)))
 
 /* Find an entry in the second-level page table.. */
-#define pmd_offset(dir,addr) \
-	((pmd_t *) pgd_page(*(dir)) + (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1)))
+#define pmd_index(addr) \
+	(((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+#define pmd_offset(dir, addr) \
+	((pmd_t *) pgd_page(*(dir)) + pmd_index(addr))
 
 /*
  * Find an entry in the third-level page table.  This looks more complicated than it
diff -Nru 2.6.4.ref/include/asm-ia64/rmap-locking.h 2.6.4.mig4/include/asm-ia64/rmap-locking.h
--- 2.6.4.ref/include/asm-ia64/rmap-locking.h	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig4/include/asm-ia64/rmap-locking.h	Thu Mar 25 08:59:42 2004
@@ -0,0 +1,25 @@
+/*
+ * include/linux/rmap-locking.h
+ *
+ * Locking primitives for exclusive access to a page's reverse-mapping
+ * pte chain.
+ */
+
+#include <linux/slab.h>
+
+struct pte_chain;
+extern kmem_cache_t *pte_chain_cache;
+
+#define pte_chain_lock(page)	bit_spin_lock(PG_chainlock, &page->flags)
+#define pte_chain_trylock(page)	bit_spin_trylock(PG_chainlock, &page->flags)
+#define pte_chain_unlock(page)	bit_spin_unlock(PG_chainlock, &page->flags)
+
+struct pte_chain *pte_chain_alloc(int gfp_flags);
+void __pte_chain_free(struct pte_chain *pte_chain);
+
+static inline void pte_chain_free(struct pte_chain *pte_chain)
+{
+	if (pte_chain)
+		__pte_chain_free(pte_chain);
+}
+
diff -Nru 2.6.4.ref/include/linux/rmap-locking.h 2.6.4.mig4/include/linux/rmap-locking.h
--- 2.6.4.ref/include/linux/rmap-locking.h	Tue Mar 16 10:18:15 2004
+++ 2.6.4.mig4/include/linux/rmap-locking.h	Thu Mar 25 08:59:42 2004
@@ -11,6 +11,7 @@
 extern kmem_cache_t *pte_chain_cache;
 
 #define pte_chain_lock(page)	bit_spin_lock(PG_chainlock, &page->flags)
+#define pte_chain_trylock(page)	bit_spin_trylock(PG_chainlock, &page->flags)
 #define pte_chain_unlock(page)	bit_spin_unlock(PG_chainlock, &page->flags)
 
 struct pte_chain *pte_chain_alloc(int gfp_flags);
diff -Nru 2.6.4.ref/mm/rmap.c 2.6.4.mig4/mm/rmap.c
--- 2.6.4.ref/mm/rmap.c	Tue Mar 16 10:18:17 2004
+++ 2.6.4.mig4/mm/rmap.c	Thu Mar 25 09:00:13 2004
@@ -46,40 +46,9 @@
  * We use an array of pte pointers in this structure to minimise cache misses
  * while traversing reverse maps.
  */
-#define NRPTE ((L1_CACHE_BYTES - sizeof(unsigned long))/sizeof(pte_addr_t))
-
-/*
- * next_and_idx encodes both the address of the next pte_chain and the
- * offset of the highest-index used pte in ptes[].
- */
-struct pte_chain {
-	unsigned long next_and_idx;
-	pte_addr_t ptes[NRPTE];
-} ____cacheline_aligned;
 
 kmem_cache_t	*pte_chain_cache;
 
-static inline struct pte_chain *pte_chain_next(struct pte_chain *pte_chain)
-{
-	return (struct pte_chain *)(pte_chain->next_and_idx & ~NRPTE);
-}
-
-static inline struct pte_chain *pte_chain_ptr(unsigned long pte_chain_addr)
-{
-	return (struct pte_chain *)(pte_chain_addr & ~NRPTE);
-}
-
-static inline int pte_chain_idx(struct pte_chain *pte_chain)
-{
-	return pte_chain->next_and_idx & NRPTE;
-}
-
-static inline unsigned long
-pte_chain_encode(struct pte_chain *pte_chain, int idx)
-{
-	return (unsigned long)pte_chain | idx;
-}
-
 /*
  * pte_chain list management policy:
  *
diff -Nru 2.6.4.ref/test/migstat.c 2.6.4.mig4/test/migstat.c
--- 2.6.4.ref/test/migstat.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig4/test/migstat.c	Thu Mar 25 09:02:00 2004
@@ -0,0 +1,130 @@
+/*
+ * Display and reset page migration statistics.
+ *
+ * Usage: migstat [-c]
+ */
+
+
+#include <stdio.h>
+#include <errno.h>
+#include <malloc.h>
+#include "page_migrate.h"
+
+#define	CONV(x)		x, (x * mult + div / 2) / div, (x * mult + div / 2) / div / 1000
+
+extern int		errno;
+
+struct _statistics_		*sp;
+struct _statistics_size_	ss;
+
+main(const int argc, const char * const argv[])
+{
+	int		from, to;
+	unsigned long	*p;
+	unsigned long	ok = 0;
+	unsigned long	mult = 1, div = 1;
+	unsigned long	time;
+	int		clear_flag = 0;
+
+	if (argc == 2 && strcmp(argv[1], "-c") == 0)
+		clear_flag = 1;
+	else if (argc != 1){
+		fprintf(stderr, "Usage: %s [-c]\n", argv[0]);
+		return 1;
+	}
+	if (get_stat_sizes(&ss) < 0){
+		perror("get_stat_sizes()");
+		return 1;
+	}
+	if ((sp = malloc(ss.sizeof_statistics)) == NULL){
+		fprintf(stderr, "malloc(%d) failed\n", ss.sizeof_statistics);
+		return 1;
+	}
+	if (get_staistics(sp, clear_flag) < 0){
+		perror("get_staistics()");
+		return 1;
+	}
+	printf("\nError counters:\n");
+	if (sp->e.non_existent_addr != 0)
+		printf("non_existent_addr:  %ld\n", sp->e.non_existent_addr);
+	if (sp->e.page_gone_away != 0)
+		printf("page_gone_away:     %ld\n", sp->e.page_gone_away);
+	if (sp->e.busy != 0)
+		printf("busy:               %ld\n", sp->e.busy);
+	if (sp->e.bad_request != 0)
+		printf("bad_request:        %ld\n", sp->e.bad_request);
+	if (sp->e.no_memory != 0)
+		printf("no_memory:          %ld\n", sp->e.no_memory);
+	if (sp->e.page_type_not_supp != 0)
+		printf("page_type_not_supp: %ld\n", sp->e.page_type_not_supp);
+	if (sp->e.errors != 0)
+		printf("page errors:        %ld\n", sp->e.errors);
+	printf("Total:              %ld\n", sp->e.non_existent_addr +
+			sp->e.page_gone_away + sp->e.busy + sp->e.bad_request +
+			sp->e.no_memory + sp->e.page_type_not_supp + sp->e.errors);
+
+	printf("\n\tMigrated to:\n");
+	printf("From:\t");
+	for (to = 0; to < ss.max_nodes; to++)
+		printf("%d:%c", to, to < ss.max_nodes - 1 ? '\t' : '\n');
+	p = &sp->count[0][0];
+	for (from = 0; from < ss.max_nodes; from++){
+		printf("%d:\t", from);
+		for (to = 0; to < ss.max_nodes; p++, to++){
+			ok += *p;
+			if (from == to && *p == 0)
+				printf("-");
+			else
+				printf("%lu", *p);
+			printf("%c", to < ss.max_nodes - 1 ? '\t' : '\n');
+		}
+	}
+	printf("Total: %ld\n\n", ok);
+
+	div = sp->t.cyc_per_usec;
+	printf("                 Clock ticks:   Microsec:  Millisec:\n");
+	printf("total:          %12ld  %10ld   %8ld\n", CONV(sp->t.total));
+	printf("page_alloc:     %12ld  %10ld   %8ld\n", CONV(sp->t.page_alloc));
+	printf("page_free:      %12ld  %10ld   %8ld\n", CONV(sp->t.page_free));
+	printf("page_lock:      %12ld  %10ld   %8ld\n", CONV(sp->t.page_lock));
+	printf("page_unlock:    %12ld  %10ld   %8ld\n", CONV(sp->t.page_unlock));
+	printf("new_pg_unlock:  %12ld  %10ld   %8ld\n", CONV(sp->t.new_page_unlock));
+	printf("validation:     %12ld  %10ld   %8ld\n", CONV(sp->t.validation));
+	printf("pgd_scan:       %12ld  %10ld   %8ld\n", CONV(sp->t.pgd_scan));
+	printf("pgd_lock:       %12ld  %10ld   %8ld\n", CONV(sp->t.pgd_lock));
+	printf("pgd_unlock:     %12ld  %10ld   %8ld\n", CONV(sp->t.pgd_unlock));
+	printf("mm_list_lock:   %12ld  %10ld   %8ld\n", CONV(sp->t.mm_list_lock));
+	printf("mmap_sem:       %12ld  %10ld   %8ld\n", CONV(sp->t.mmap_sem));
+	printf("pte_chain_lock: %12ld  %10ld   %8ld\n", CONV(sp->t.pte_chain_lock));
+	printf("find_vma:       %12ld  %10ld   %8ld\n", CONV(sp->t.find_vma));
+	printf("flush_tlb:      %12ld  %10ld   %8ld\n", CONV(sp->t.flush_tlb));
+	printf("add_lru:        %12ld  %10ld   %8ld\n", CONV(sp->t.add_lru));
+	printf("copy:           %12ld  %10ld   %8ld\n", CONV(sp->t.copy));
+	printf("upd_mmu_cache:  %12ld  %10ld   %8ld\n", CONV(sp->t.update_mmu_cache));
+	time = sp->t.total - sp->t.page_alloc - sp->t.page_free -
+		sp->t.page_lock - sp->t.page_unlock - sp->t.new_page_unlock -
+		sp->t.validation - // sp->t.pgd_unlock - sp->t.mmap_sem -
+		// sp->t.pgd_scan - sp->t.pgd_lock - sp->t.mmlist_lock -
+		sp->t.pte_chain_lock - sp->t.find_vma - sp->t.flush_tlb -
+		sp->t.add_lru - sp->t.copy - sp->t.update_mmu_cache;
+	printf("Where is        %12ld  %10ld   %8ld ?\n", CONV(time));
+
+	printf("cyc_per_usec:    %11ld\n", sp->t.cyc_per_usec);
+
+	if (sp->c.pgd_scan != 0){
+		printf("\npgd_scan:\t\t%11ld\n", sp->c.pgd_scan);
+		printf("mm_hit:\t\t\t%11ld\nmiss:\t\t\t%11ld\n", sp->c.mm_hit,
+					sp->e.non_existent_addr + ok - sp->c.mm_hit);
+	}
+
+	if (sp->c.perfbullctl != 0){
+		printf("\npci_cfg_rd:\t%11ld\t   %10ld\n", CONV(sp->t.pci_cfg_rd));
+		printf("pci_cfg_rd count:\t%11ld\n", sp->c.pci_cfg_rd);
+		printf("pci_cfg_wr:\t%11ld\t   %10ld\n", CONV(sp->t.pci_cfg_wr));
+		printf("pci_cfg_wr count:\t%11ld\n", sp->c.pci_cfg_wr);
+		printf("perfbullctl:\t%11ld\t   %10ld\n", CONV(sp->t.perfbullctl));
+		printf("perfbullctl count:\t%11ld\n", sp->c.perfbullctl);
+	}
+	return 0;
+}
+
diff -Nru 2.6.4.ref/test/ph.c 2.6.4.mig4/test/ph.c
--- 2.6.4.ref/test/ph.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig4/test/ph.c	Thu Mar 25 09:02:00 2004
@@ -0,0 +1,94 @@
+/*
+ * Demo: migrate some of our pages identified by their physical addresses.
+ */
+
+
+#include <stdio.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include "page_migrate.h"
+
+#if !defined(PAGE_SIZE)
+#define	PAGE_SIZE	(16 * 1024)
+#endif
+
+#define	MMAPSIZE		(1024 * 1024 * 256)
+
+phaddr_t			address;
+extern int			errno;
+phaddr_t			table[PAGE_SIZE / sizeof(phaddr_t)];
+struct _un_success_count_	u_s;
+
+
+size_t
+fill(volatile void *p)
+{
+	size_t		count = 123;
+	size_t		i;
+
+	for (i = 0; i < count; i++, p += PAGE_SIZE){
+		* (unsigned long *) p = 0xdeadbeefL;
+		if ((address = gimme_a_ph_address((void *) p)) < 0)
+			break;
+		table[i] = address;
+	}
+	printf("# addresses: %d\n", i);
+	return i;
+}
+
+
+mig(volatile void *p, int node)
+{
+	int		rc;
+	size_t		count;
+
+	count = fill(p);
+	rc = migrate_ph_pages(table, count, node, &u_s, 0);
+	printf("\nmig(..., %d): rc = %ld errno = %d *p: 0x%lx\n", node, rc, errno,
+								* (unsigned long *) p);
+	printf("successful: %d failed: %d\n", u_s.successful, u_s.failed);
+	if (rc < 0){
+		perror("migrate_virt_addr_range()");
+		exit(-1);
+	}
+	address = gimme_a_ph_address((void *) p);
+	printf("\nmig(..., %d): ph address = 0x%016llx\n", node, address);
+	if (address < 0){
+		perror("gimme_a_ph_address()");
+		exit(-1);
+	}
+}
+
+
+main()
+{
+	volatile void	*p;
+
+	p = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
+					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED){
+		perror("\nmmap()");
+		return 1;
+	}
+	/*
+	 * No backing page => should fail.
+	 */
+	printf("\nmain(): ph address = 0x%llx\n", address);
+	* (unsigned long *) p = 0xdeadbeef03L;
+	/*
+	 * Now there should be a backing page.
+	 */
+	address = gimme_a_ph_address((void *) p);
+	printf("\nmain(): ph address = 0x%016llx\n", address);
+	if (address < 0){
+		perror("gimme_a_ph_address()");
+		return 1;
+	}
+	mig(p, 0);
+	mig(p, 1);
+	mig(p, 2);
+	mig(p, 3);
+	return 0;
+}
+
diff -Nru 2.6.4.ref/test/v.c 2.6.4.mig4/test/v.c
--- 2.6.4.ref/test/v.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig4/test/v.c	Thu Mar 25 09:02:00 2004
@@ -0,0 +1,78 @@
+/*
+ * Demo: migrate some of its own virtual address range.
+ */
+
+
+#include <stdio.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include "page_migrate.h"
+
+#define	MMAPSIZE	(1024 * 1024 * 256)
+
+phaddr_t	address;
+extern int	errno;
+
+struct _un_success_count_ u_s;
+
+
+mig(volatile void *p, int node)
+{
+	int	rc;
+
+	rc = migrate_virt_addr_range((caddr_t) p, MMAPSIZE, node, &u_s, 0);
+	printf("\nmig(..., %d): rc = %ld errno = %d *p: 0x%lx\n", node, rc, errno,
+								* (unsigned long *) p);
+	printf("successful: %d failed: %d\n", u_s.successful, u_s.failed);
+	if (rc < 0){
+		perror("migrate_virt_addr_range()");
+		exit(-1);
+	}
+	address = gimme_a_ph_address((void *) p);
+	printf("\nmig(..., %d): ph address = 0x%016llx\n", node, address);
+	if (address < 0){
+		perror("gimme_a_ph_address()");
+		exit(-1);
+	}
+}
+
+
+main()
+{
+	volatile void	*p0, *p;
+
+	p0 = p = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
+					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED){
+		perror("\nmmap()");
+		return 1;
+	}
+	/*
+	 * Make sure 2 pages are exist.
+	 */
+	* (unsigned long *) p = 0xdeadbeef01L;
+	p += 1024 * 16;
+	* (unsigned long *) p = 0xdeadbeef02L;
+	address = gimme_a_ph_address((void *) p);
+	/*
+	 * No backing page => should fail.
+	 */
+	p += 1024 * 64;
+	printf("\nmain(): ph address = 0x%llx\n", address);
+	* (unsigned long *) p = 0xdeadbeef03L;
+	/*
+	 * Now there should be a backing page.
+	 */
+	address = gimme_a_ph_address((void *) p);
+	printf("\nmain(): ph address = 0x%016llx\n", address);
+	if (address < 0){
+		perror("gimme_a_ph_address()");
+		return 1;
+	}
+	mig(p0, 0);
+	mig(p0, 1);
+	mig(p0, 2);
+	mig(p0, 3);
+	return 0;
+}
diff -Nru 2.6.4.ref/test/victim.c 2.6.4.mig4/test/victim.c
--- 2.6.4.ref/test/victim.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig4/test/victim.c	Thu Mar 25 09:02:00 2004
@@ -0,0 +1,36 @@
+/*
+ * Victim process for "vmig".
+ */
+
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+
+#define	MMAPSIZE	(1024 * 1024 * 1024L)
+#define	N		MMAPSIZE / sizeof(long)
+
+
+main()
+{
+	int		i;
+	volatile long	*p0, *p;
+	long		sum0, sum;
+
+	printf("victim: pid = %d\n", getpid());
+	p0 = p = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
+					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED){
+		perror("\nmmap()");
+		return 1;
+	}
+	printf("address: %p, size: 0x%lx\n", p, MMAPSIZE);
+	for (i = 0, sum0 = 0; i < N; i++)
+		sum0 += *p++ = random();
+	do {
+		for (i = 0, sum = 0, p = p0; i < N; i++)
+			sum += *p++;
+		printf("\nvictim: pid = %d, sum: %ld\n", getpid(), sum);
+	} while (sum0 == sum);
+}
diff -Nru 2.6.4.ref/test/vmig.c 2.6.4.mig4/test/vmig.c
--- 2.6.4.ref/test/vmig.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig4/test/vmig.c	Thu Mar 25 09:02:00 2004
@@ -0,0 +1,36 @@
+/*
+ * Migrate the victim process by hand.
+ */
+
+
+#include <stdio.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include "page_migrate.h"
+
+// Who cares for the SH library ?
+#define	SH_ADDRESS	(2UL << 60)
+#define	SH_SIZE		(16UL * 1024 * 1024 * 1024 * 1024)
+
+struct _un_success_count_ u_s;
+
+main(const int argc, const char * const argv[])
+{
+	int	node;
+	pid_t	pid;
+	int	rc;
+
+	if (argc != 3){
+		fprintf(stderr, "usage: vmig <pid> <node>\n");
+		return 1;
+	}
+	pid = atoi(argv[1]);
+	node = atoi(argv[2]);
+	rc = migrate_virt_addr_range((caddr_t) SH_ADDRESS, SH_SIZE, node, &u_s, pid);
+	if (rc < 0)
+		perror("migrate_virt_addr_range()");
+	else
+		printf("successful: %d failed: %d\n", u_s.successful, u_s.failed);
+	return 0;
+}


--------------C3649D9FC7EAC1DC128DB793--


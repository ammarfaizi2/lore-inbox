Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbUDBOei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 09:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbUDBOeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 09:34:37 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:9920 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264060AbUDBOby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 09:31:54 -0500
Message-ID: <406D6EA5.AA1F018B@nospam.org>
Date: Fri, 02 Apr 2004 15:46:13 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Migrate pages - v0.2
Content-Type: multipart/mixed;
 boundary="------------9666F83589B875839215849A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9666F83589B875839215849A
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Here is my next try.

Version 0.2, 2nd of April 2004:
- Efforts made to make it less architecture dependent
- Two big loops of PGD-PMD-PTE scans merged at the expense of
  some "if-then-else"-es and some additional function parameters
- Permission check added
- Excessive DEBUG stuff removed
- Some cosmetics

You can find a description in "Documentation/migrate.txt".

I keep on using a single system call in order not too pollute much...
Until I have an official system call number I just picked up:

	__NR_page_migrate 1276

I was thinking about reading out statistics via "/proc". Well I do not like
converting numbers to strings and making the user program convert them back...
In addition we may have up to 256 nodes, up to 256 * 256 migration counters -
the result is not much readable.

Notes about the data security:
- The process controlling the migration cannot read nor modify the data of the
  victim process.
- The data of the victim process cannot be broken. Should the migration fail,
  a data page will be found intact, in a single example, either on the source
  or the destination NUMA node.
- He who can kill you is allowed to migrate your pages.

The patch is against:        patch-2.6.4.-bk4

TODO: check to see if pulling in pages in to a node is better than pushing them out

Your remarks will be appreciated.

Zoltán Menyhárt


P.S: is the list linux-mm@kvack.org alive ?
--------------9666F83589B875839215849A
Content-Type: text/plain; charset=us-ascii;
 name="mig-2.6.4-bk4-2004-apr-2"
Content-Disposition: inline;
 filename="mig-2.6.4-bk4-2004-apr-2"
Content-Transfer-Encoding: 7bit

diff -Nur 2.6.4.ref/Documentation/migrate.txt 2.6.4.mig2-tmp/Documentation/migrate.txt
--- 2.6.4.ref/Documentation/migrate.txt	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig2-tmp/Documentation/migrate.txt	Fri Apr  2 14:32:00 2004
@@ -0,0 +1,352 @@
+Migrate pages from a ccNUMA node to another.
+============================================
+
+Version 0.2, 2nd of April 2004
+By Zoltan Menyhart, Bull S.A. <Zoltan.Menyhart@bull.net>
+The usual GPL applies.
+
+What is it all about ?
+----------------------
+
+The old golden days of the Symmetrical Multi-Processor systems are over.
+Gone forever.
+We are left with (cache coherent) Non Uniform Memory Architectures.
+I can see the future.
+I can see systems with hundreds, thousands of processors, with less and less
+uniform memory architectures.
+The "closeness" of a processor to its working set of memory will have the most
+important effect on the performance.
+
+You can make use of the forthcoming NUMA APIs to set up your NUMA environment:
+to bind processes to (groups of ) processors, to define the memory placement
+policy, etc.
+
+Yes, the initial placement is very much important. It affects tremendously the
+performance you obtain.
+
+Yet, what if
+- the application changes its behavior over time ?
+ (which processor uses which part of the memory)
+- you have not got the source of the application ?
+- you cannot add the NUMA services to it ?
+- you are not authorized to touch it ? (e.g. it is a reference benchmark)
+
+Page migration tries to help you out in these situations.
+
+What can this service do ?
+--------------------------
+
+- Migrate pages identified by their physical addresses to another NUMA node
+- Migrate pages of a virtual user address range to another NUMA node
+
+How can it be used ?
+--------------------
+
+1. Hardware assisted migration
+..............................
+
+As you can guess, it is very much platform dependent.
+I can only give you an example:
+
+We've got an Intel IA64 based machine for development / testing.
+It consists of 4 "Tiger boxes" connected together by a pair of Scalability Port
+Switches. A "Tiger box" is built around a Scalable Node Controller (SNC), and
+includes 4 Itanium-2 processors and some Gbytes of memory.
+The NUMA factor is 1 : 2.25.
+The SNC contains 2048 counters which allow us to count how many times these 2048
+zones of memory are touched from each node in a given observation period.
+An "artificial intelligence" can make predictions from these usage statistics
+and decide what pages are to be migrated and where.
+
+(Unfortunately, the SNCs are buggy - even the version C.1 is - we've got to use
+a couple of work-arounds, much of the work has to be done in software.
+This wastes about 10 seconds of CPU time while executing a benchmark of
+2 minutes. I hope, one day...)
+
+2. Application driven migration
+...............................
+
+An application can exploit the forthcoming NUMA APIs to specify its initial
+memory placement policy.
+Yet what if the application wants to change its behavior ?
+
+Allocating room on the destination node, copying the data by the application
+itself, and finally freeing the original room of the data is not very efficient.
+
+An application can ask the migration service to move a range of its virtual
+address space to the destination node.
+
+Example:
+A process of an application prepares a huge amount of data and hands it over to
+Its fellow processes (which happen to be bound to another NUMA node) for their
+(almost) exclusive usage.
+Migrating a page costs 128 remote accesses (assuming a page size of 16 Kbytes
+and a bus transaction size of 128 bytes) + some administration.
+Assuming the consumers of the data will frequently touch the page (cache misses)
+a considerable number of times, say more that 1000 times, then the migration
+becomes largely profitable.
+
+3. NUMA aware scheduler
+.......................
+
+A NUMA aware scheduler tries to keep processes on their "home" node where they
+have allocated (most of) their memory. What if the processors in this node are
+overloaded while several processors in the other nodes are largely in idle ?
+
+Should the scheduler select some other processors in the other nodes to execute
+these processes, at the expense of considerable number of extra node
+transactions ?
+Or should the scheduler leave the processors in the other nodes doing nothing ?
+Or should it move some processes with their memory working set to another node ?
+Let's leave this dilemma for the NUMA aware scheduler for the moment.
+
+Once the scheduler has made up its mind, the migration service can move the
+working set of memory of the selected processes to their new "home" node.
+
+User mode interface
+-------------------
+
+This prototype of the page migration service is implemented as a system call,
+the different forms of which are wrapped by use of some small,
+static, inline functions.
+
+NAME
+        migrate_ph_pages        - migrate pages to another NUMA node
+        migrate_virt_addr_range - migrate virtual address range to another node
+
+SYNOPSIS
+
+        #include <sys/types.h>
+        #include "page_migrate.h"
+
+        int migrate_ph_pages(
+                const phaddr_t * const table,
+                const size_t length,
+                const int node,
+                struct _un_success_count_ * const p,
+                const pid_t pid);
+
+        int migrate_virt_addr_range(
+                const caddr_t address,
+                const size_t length,
+                const int node,
+                struct _un_success_count_ * const p,
+                const pid_t pid);
+
+DESCRIPTION
+
+        The "migrate_ph_pages()" system call is used to migrate pages - their
+        physical addresses of "phaddr_t" type are given in "table" - to "node".
+        "length" indicates the number of the physical addresses in "table" and
+        should not be greater than "PAGE_SIZE / sizeof(phaddr_t)".
+        Only the pages belonging to the process indicated by "pid" and its
+        child processes cloned via "clone2(CLONEVM)" are treated, the other
+        processes' pages are silently ignored.
+
+        The "migrate_virt_addr_range()" system call is used to migrate pages of
+        a virtual address range of "length" starting at "address" to "node".
+        The virtual address range belongs to the process indicated by "pid" and
+        to its cloned children. If "pid" is zero then the current
+        process's virtual address range is moved.
+
+        Some statistics are returned via "p":
+
+        struct _un_success_count_ {
+                unsigned int    successful;     // Pages successfully migrated
+                unsigned int    failed;         // Minor failures
+        };
+
+RETURN VALUE
+
+        "migrate_ph_pages()" and "migrate_virt_addr_range()" return 0 on
+        success, or -1 if a major error occurred (in which case, "errno" is set
+        appropriately). Minor errors are silently ignored (migration continues
+        with the rest of the pages).
+
+ERRORS
+
+        ENODEV:         illegal destination node
+        ESRCH:          no process of "pid" can be found
+        EPERM:          no permission
+        EINVAL:         invalid system call parameters
+        EFAULT:         illegal virtual user address
+        ENOMEM:         cannot allocate memory
+
+RESTRICTIONS
+
+        We can migrate a page if it belongs to a single "mm_struct" / PGD,
+        i.e. it is private to a process or shared with its child processes
+        cloned via "clone2(CLONEVM)".
+
+Notes:
+
+- A "major error" prevents us from carrying on the migration, but it is not a
+  real error for the "victim" application that can continue (it is guaranteed
+  not to be broken). The pages already migrated are left in their new node.
+
+- Migrating a page shared among other than child processes cloned via
+  "clone2(CLONEVM)" would require locking all the page owners' PGDs.
+  I've got serious concerns about locking more than one PGDs:
+  + It is not foreseen in the design of the virtual memory management.
+  + Obviously, the PGDs have to be "trylock()"-ed in order to avoid dead locks.
+    However, "trylock()"-ing lots of PGDs, possibly thousands of them, would
+    lead to starvation problems. A performance enhancement tool consuming so
+    much in the event of not concluding...
+
+Some figures
+------------
+
+One of our customers has an OpenMP benchmark which was used to measure the
+machine described above. It uses 1 Gbytes of memory and runs on 16 processors,
+on 4 NUMA nodes.
+
+If the benchmark is adapted to our NUMA architecture, then it takes 86 seconds
+to complete.
+
+As results are not accepted if obtained by modifying the benchmark in any
+way, the best we can do is to use a random or round robin memory allocation
+policy. We end up with a locality rate of 25 % and the benchmark executes in 121
+seconds.
+
+If we had a zero-overhead migration tool, then - I estimate - it would complete
+In 92 seconds (the benchmark starts in a "pessimized" environment, and it takes
+time for the locality ramp up from 25 % to almost 100 %).
+
+Actually it takes 2 to 3 seconds to move 750 Mbytes of memory (on a heavily
+loaded machine), reading out the counters of the SNCs and making some quick
+decisions take 1 to 2 seconds, and we lose about 10 seconds due to the buggy
+SNCs. We end up with 106 seconds.
+
+Some if's
+---------
+
+- if the benchmark used more memory, then it would be more expensive to migrate
+  all of it's pages
+- if the benchmark ran for longer without changing its memory usage
+  pattern, then it could spend a greater percentage of its lifetime in a well
+  localized environment
+- if you had a NUMA factor higher than ours, then obviously, you would gain
+  more in performance by use of the migration service
+- if we used Madison processors with 6 Mbytes of cache (twice as much we have
+  right now), then the NUMA factor would be masked more efficiently
+- if the clock frequency of the processors increases, then you run out of cached
+  data more quickly and the NUMA factor becomes a higher performance cut factor
+
+Notes about the data security
+-----------------------------
+
+- The process controlling the migration cannot read nor modify the data of the
+  victim process.
+- The data of the victim process cannot be broken. Should the migration fail,
+  a data page will be found intact, in a single example, either on the source
+  or the destination NUMA node.
+- He who can kill you is allowed to migrate your pages.
+
+Porting guide
+-------------
+
+include/asm-.../page_migrate.h:
+...............................
+
+	Copy "include/asm-ia64/page_migrate.h" into the directory
+	"include/asm-<your architecture>
+
+Define "return_t":
+
+	Type of the return value for the system call. Should be able to hold
+	negative values, that of "phaddr_t" and we will cast the structures
+	"_un_success_count_" and "_statistics_size_" to this type.
+
+Define "phaddr_t":
+
+	Type of a physical address.
+
+Define "struct _un_success_count_":
+
+	Number of the pages successfully migrated / minor failures.
+
+Define "_statistics_size_":
+
+	Holds sizes of "struct _statistics_" are.
+
+Define "struct _statistics_":
+
+	The counters should not overflow.
+
+include/asm-.../delay.h:
+........................
+
+Define "GET_TIMER()":
+
+	This macro / function should return the current clock ticks.
+	It can simply return zero => no timing info will be available.
+
+include/linux/pagemap.h:
+........................
+
+Define "__IS_VADDR_ALIAS(address, length)":
+
+	Some architectures do not decode all the MSB-s of virtual
+	addresses for the PGD, PMD and PTE indices, i.e. they have
+	got holes or aliases in the virtual user address space.
+	This macro / function should return TRUE if "length" spans over
+	virtual address holes or it creates an illegal alias to an
+	otherwise valid address.
+
+	IA64 example (assuming a page size of 16 Kbytes):
+	There are 5 user regions, starting at addresses "i << 61" (where "i"
+	goes from 0 to 4). Only the first 16 Tbytes of each region is valid.
+	We count as:
+
+	0, 1, 2, ... 0x000fffffffffffff,
+	0x2000000000000, 0x2000000000001, ... 0x200fffffffffffff,
+	0x4000000000000, etc.
+
+Define "__VA(pgd_i, pmd_i, pte_i)":
+
+	This macro / function converts PGD, PMD and PTE indices into a
+	virtual address. Beware of the illegal virtual address aliases.
+	Not absolutely necessary if not testing. However, as it is the
+	counterpart of "pgd_index()", "pmd_index()" and "pte_index()"...
+
+include/asm-.../unistd.h:
+.........................
+
+	Add "#define __NR_page_migrate 1276"
+
+arch/.../Kconfig:
+.................
+
+Add:
+
+config PAGE_MIGRATE
+	bool "Support for migrating pages from a NUMA node to another"
+	depends on DISCONTIGMEM && NUMA
+	default n
+	help
+	  Say Y to compile the kernel to support migrating either pages
+	  identified by their physical addresses or a user mode virtual
+	  address range from a NUMA node to another.
+	  This option is for optimizing memory allocation pattern for
+	  high-end NUMA server systems.
+	  If in doubt, say N.
+
+To activate page migration, select:
+	Processor type and features
+	  NUMA support
+	    Support for migrating pages from a NUMA node to another
+
+Revision history:
+-----------------
+
+Version 0.1, 25th of March 2004:
+	- Initial version
+
+Version 0.2, 2nd of April 2004:
+	- Efforts made to make it less architecture dependent
+	- Two big loops of PGD-PMD-PTE scans merged at the expense of
+	  some "if-then-else"-es and some additional function parameters
+	- Permission check added
+	- Excessive DEBUG stuff removed
+	- Some cosmetics :-)
+
diff -Nur 2.6.4.ref/arch/ia64/Kconfig 2.6.4.mig2-tmp/arch/ia64/Kconfig
--- 2.6.4.ref/arch/ia64/Kconfig	Tue Mar 16 13:36:30 2004
+++ 2.6.4.mig2-tmp/arch/ia64/Kconfig	Fri Apr  2 11:28:21 2004
@@ -218,6 +218,18 @@
 	  Access).  This option is for configuring high-end multiprocessor
 	  server systems.  If in doubt, say N.
 
+config PAGE_MIGRATE
+	bool "Support for migrating pages from a NUMA node to another"
+	depends on DISCONTIGMEM && NUMA
+	default n
+	help
+	  Say Y to compile the kernel to support migrating either pages
+	  identified by their physical addresses or a user mode virtual
+	  address range from a NUMA node to another.
+	  This option is for optimizing memory allocation pattern for
+	  high-end NUMA server systems.
+	  If in doubt, say N.
+
 config VIRTUAL_MEM_MAP
 	bool "Virtual mem map"
 	default y if !IA64_HP_SIM
diff -Nur 2.6.4.ref/arch/ia64/kernel/acpi.c 2.6.4.mig2-tmp/arch/ia64/kernel/acpi.c
--- 2.6.4.ref/arch/ia64/kernel/acpi.c	Tue Mar 16 10:18:04 2004
+++ 2.6.4.mig2-tmp/arch/ia64/kernel/acpi.c	Fri Apr  2 11:28:17 2004
@@ -457,6 +457,7 @@
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (pxm_bit_test(i)) {
 			pxm_to_nid_map[i] = numnodes;
+			node_set_online(numnodes);
 			nid_to_pxm_map[numnodes++] = i;
 		}
 	}
diff -Nur 2.6.4.ref/arch/ia64/kernel/entry.S 2.6.4.mig2-tmp/arch/ia64/kernel/entry.S
--- 2.6.4.ref/arch/ia64/kernel/entry.S	Tue Mar 16 10:18:04 2004
+++ 2.6.4.mig2-tmp/arch/ia64/kernel/entry.S	Fri Apr  2 11:28:17 2004
@@ -1518,7 +1518,7 @@
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall			// 1275
-	data8 sys_ni_syscall
+	data8 sys_page_migrate
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
diff -Nur 2.6.4.ref/include/asm-ia64/delay.h 2.6.4.mig2-tmp/include/asm-ia64/delay.h
--- 2.6.4.ref/include/asm-ia64/delay.h	Tue Mar 16 10:18:15 2004
+++ 2.6.4.mig2-tmp/include/asm-ia64/delay.h	Fri Apr  2 11:30:14 2004
@@ -20,6 +20,11 @@
 #include <asm/intrinsics.h>
 #include <asm/processor.h>
 
+/*
+ * Architecture independent macro name for reading the timer.
+ */
+#define	GET_TIMER()	ia64_get_itc()
+
 static __inline__ void
 ia64_set_itm (unsigned long val)
 {
diff -Nur 2.6.4.ref/include/asm-ia64/page_migrate.h 2.6.4.mig2-tmp/include/asm-ia64/page_migrate.h
--- 2.6.4.ref/include/asm-ia64/page_migrate.h	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig2-tmp/include/asm-ia64/page_migrate.h	Fri Apr  2 11:30:14 2004
@@ -0,0 +1,218 @@
+/*
+ * Migrate pages from a NUMA node to another.
+ * ==========================================
+ *
+ * Version 0.2, 2nd of April 2004
+ * By Zoltan Menyhart, Bull S.A. <Zoltan.Menyhart@bull.net>
+ * The usual GPL applies.
+ *
+ * (See "Documentation/migrate.txt".)
+ */
+
+
+/*
+ * Type of the return value for the system call. Should be able to hold
+ * negative values, that of "phaddr_t" and we will cast the structures
+ * "_un_success_count_" and "_statistics_size_" to this type.
+ */
+typedef	long long	return_t;
+
+/*
+ * Type of a physical address -- hopefully enough for all architectures.
+ */
+typedef	long long	phaddr_t;
+
+
+struct _un_success_count_ {
+	unsigned int	successful;		/* Pages successfully migrated */
+	unsigned int	failed;			/* Minor failures */
+};
+
+
+struct _statistics_size_ {
+	unsigned int	sizeof_statistics;	/* sizeof(struct _statistics_) */
+	unsigned int	max_nodes;		/* MAX_NUMNODES */
+};
+
+
+/*
+ * Statistics are accessed in a non atomic way.
+ * Who cares? Just some statistics :-)
+ */
+struct _statistics_ {
+	struct {					/* Error counters */
+		unsigned long	non_existent_addr;
+		unsigned long	page_gone_away;
+		unsigned long	busy;
+		unsigned long	bad_request;
+		unsigned long	no_memory;		/* On the target node */
+		unsigned long	page_type_not_supp;
+		unsigned long	errors;			/* "PageError()" is set */
+	} e;
+	struct {					/* Clock ticks */
+		unsigned long	total;
+		unsigned long	page_alloc;
+		unsigned long	page_free;
+		unsigned long	page_lock;
+		unsigned long	new_page_unlock;
+		unsigned long	page_unlock;
+		unsigned long	pgd_scan;
+		unsigned long	pgd_lock;
+		unsigned long	pgd_unlock;
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
+	struct {					/* Event counters */
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
+ *
+ * Arguments:	table:	-> physical addresses of the pages
+ *		length:	Indicates the number of the physical addresses
+ *		node:	Destination NUMA node
+ *		p:	-> status returned
+ *		pid:	Only pages belonging to this process and its
+ *			"clone2(CLONEVM)"-ed children are move
+ *
+ * Returns:	-1 if a major error occurred (in which case, "errno" is set
+ *		appropriately). Minor errors are silently ignored (migration
+ *		continues with the rest of the pages).
+ */
+static inline int
+migrate_ph_pages(const phaddr_t				* const table,
+			const size_t			length,
+			const int			node,
+			struct _un_success_count_	* const p,
+			const pid_t			pid)
+{
+	union {
+		return_t			ll;
+		struct _un_success_count_	s;
+	} u;
+
+	u.ll = syscall(__NR_page_migrate, _PHADDR_BATCH_MIGRATE_,
+						table, length, node, pid);
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
+ *
+ * Arguments:	addr:	Starting address of the virtual address range
+ *		length:	Length of the virtual address range
+ *		node:	Destination NUMA node
+ *		p:	-> status returned
+ *		pid:	Only pages belonging to this process and its
+ *			"clone2(CLONEVM)"-ed children are move
+ *
+ * Returns:	-1 if a major error occurred (in which case, "errno" is set
+ *		appropriately). Minor errors are silently ignored (migration
+ *		continues with the rest of the pages).
+ */
+static inline int
+migrate_virt_addr_range(const caddr_t			addr,
+			const size_t			length,
+			const int			node,
+			struct _un_success_count_	* const p,
+			const pid_t			pid)
+{
+	union {
+		return_t			ll;
+		struct _un_success_count_	s;
+	} u;
+
+	u.ll = syscall(__NR_page_migrate, _VA_RANGE_MIGRATE_,
+						addr, length, node, pid);
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
+		return_t			ll;
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
+get_staistics(struct _statistics_ * const p, const long clear_flag)
+{
+	return syscall(__NR_page_migrate, _STATISTICS_, p, clear_flag, 0, 0);
+}
+
+
+/*
+ * Return a physical address.
+ */
+static inline phaddr_t
+gimme_a_ph_address(const caddr_t vaddr)
+{
+	return syscall(__NR_page_migrate, _GIMME_AN_ADDRESS_, vaddr, 0, 0, 0);
+}
+
+
+#endif	/* #if !defined(__KERNEL__) */
+
diff -Nur 2.6.4.ref/include/asm-ia64/pgtable.h 2.6.4.mig2-tmp/include/asm-ia64/pgtable.h
--- 2.6.4.ref/include/asm-ia64/pgtable.h	Tue Mar 16 10:18:15 2004
+++ 2.6.4.mig2-tmp/include/asm-ia64/pgtable.h	Fri Apr  2 11:30:14 2004
@@ -112,6 +112,30 @@
 #define PTRS_PER_PTE	(__IA64_UL(1) << (PAGE_SHIFT-3))
 
 /*
+ * The IA64 architecture does not decode all the MSB-s of virtual addresses for
+ * PGD, PMD and PTE indices, i.e. IA64 has got holes or aliases in the virtual
+ * address space.
+ * These def's are provided to check to see if an "address" -- "length" pair
+ * spans over virtual address holes or it creates illegal alias to an otherwise
+ * valid address. (User mode virtual addresses only.)
+ */
+#define	__VADDR_BITS_PER_REGION	(PAGE_SHIFT - 3 - 3 +	/* PGD low index */	\
+				2 * (PAGE_SHIFT - 3) +	/* PMD & PTE indices */	\
+				PAGE_SHIFT)		/* The page itself */
+#define	__VADDR_ALIAS_MASK		((1UL << __VADDR_BITS_PER_REGION) - 1)
+#define	__IS_VADDR_ALIAS(address, length)					\
+			((~__VADDR_ALIAS_MASK & (address)) !=			\
+			(~__VADDR_ALIAS_MASK & ((address) + (length) - 1)))
+
+/*
+ * Virtual address composed by use of PGD, PMD and PTE indices:
+ */
+#define	__VA(pgdi, pmdi, ptei)							\
+			(((pgdi) >> (PAGE_SHIFT - 6)) << 61 |			\
+			((pgdi) & ((PTRS_PER_PGD >> 3) - 1)) << PGDIR_SHIFT |	\
+			(pmdi) << PMD_SHIFT | (ptei) << PAGE_SHIFT)
+
+/*
  * All the normal masks have the "page accessed" bits on, as any time
  * they are used, the page is accessed. They are cleared only by the
  * page-out routines.
@@ -325,8 +349,10 @@
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
diff -Nur 2.6.4.ref/include/asm-ia64/unistd.h 2.6.4.mig2-tmp/include/asm-ia64/unistd.h
--- 2.6.4.ref/include/asm-ia64/unistd.h	Tue Mar 16 10:18:15 2004
+++ 2.6.4.mig2-tmp/include/asm-ia64/unistd.h	Fri Apr  2 11:30:14 2004
@@ -251,6 +251,7 @@
 #define __NR_reserved1			1259	/* reserved for NUMA interface */
 #define __NR_reserved2			1260	/* reserved for NUMA interface */
 #define __NR_reserved3			1261	/* reserved for NUMA interface */
+#define __NR_page_migrate		1276
 
 #ifdef __KERNEL__
 
diff -Nur 2.6.4.ref/include/linux/page_migrate.h 2.6.4.mig2-tmp/include/linux/page_migrate.h
--- 2.6.4.ref/include/linux/page_migrate.h	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig2-tmp/include/linux/page_migrate.h	Fri Apr  2 11:30:16 2004
@@ -0,0 +1,81 @@
+#define	_TEST_
+#define	_NEED_STATISTICS_
+
+#if	!defined(_PAGE_MIGRATE_)
+#define	_PAGE_MIGRATE_
+
+
+/*
+ * Migrate pages from a NUMA node to another.
+ * ==========================================
+ *
+ * Version 0.2, 2nd of April 2004
+ * By Zoltan Menyhart, Bull S.A. <Zoltan.Menyhart@bull.net>
+ * The usual GPL applies.
+ *
+ * (See "Documentation/migrate.txt".)
+ *
+ * System call syntax:
+ * -------------------
+ *
+ *	return_t sys_page_migrate(int command, caddr_t address, size_t length,
+ *							int node, pid_t pid);
+ *
+ * On error "-1" is returned and "errno" holds the error code.
+ *
+ * The following commands are available:
+ */
+enum {
+/*
+ * - Return a physical address:
+ */
+	_GIMME_AN_ADDRESS_,
+/*
+ *   On entry, if "address" is a valid virtual address in the address space of
+ *   the current task with an existing backing page, then its physical address
+ *   is returned.
+ *   (Testing only, the kernel has to be compiled with "#define	_TEST_".)
+ *
+ * - Fetch and clear the statistics:
+ */
+	_STATISTICS_,
+/*
+ *   "address" is a pointer to the user's buffer. If "length != 0" then having
+ *   been fetched, the statistics get cleared.
+ *   The other arguments are don't care.
+ *
+ * - Obtain the size of the statistics structure in "struct _statistics_size_":
+ */
+	_SIZEOF_STATISTICS_,
+/*
+ *   The arguments are don't care.
+ *
+ * - Batch migrate pages from a NUMA node to another.
+ */
+	_PHADDR_BATCH_MIGRATE_,
+/*
+ *   "address" points at the user table containing the physical address of the
+ *   pages to be migrated.
+ *   "length" is the number of the physical addresses in the buffer.
+ *   Max. "PAGE_SIZE / sizeof(phaddr_t)" of them can be migrated at once.
+ *   "node" is the destination NUMA node.
+ *   Addresses are assumed to belong to the process indicated by "pid".
+ *   The number of the pages actually migrated is returned,
+ *   see "struct _un_success_count_.
+ *
+ * - Migrate virtual address range of a process:
+ */
+	_VA_RANGE_MIGRATE_,
+/*
+ *   "address" is the starting virtual address in a process'es address space.
+ *   "length" is the length of the address range to be migrated
+ *   Addresses are assumed to belong to the process indicated by "pid".
+ *   The number of the pages actually migrated is returned,
+ *   see "struct _un_success_count_.
+ */
+};
+
+#include <asm/page_migrate.h>
+
+#endif	/* #if !defined(_PAGE_MIGRATE_) */
+
diff -Nur 2.6.4.ref/kernel/sys.c 2.6.4.mig2-tmp/kernel/sys.c
--- 2.6.4.ref/kernel/sys.c	Tue Mar 16 10:18:17 2004
+++ 2.6.4.mig2-tmp/kernel/sys.c	Fri Apr  2 11:30:46 2004
@@ -260,6 +260,7 @@
 cond_syscall(sys_shmget)
 cond_syscall(sys_shmdt)
 cond_syscall(sys_shmctl)
+cond_syscall(sys_page_migrate)
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read)
diff -Nur 2.6.4.ref/mm/Makefile 2.6.4.mig2-tmp/mm/Makefile
--- 2.6.4.ref/mm/Makefile	Tue Mar 16 10:18:17 2004
+++ 2.6.4.mig2-tmp/mm/Makefile	Fri Apr  2 11:30:51 2004
@@ -11,4 +11,6 @@
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
 			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
 
+obj-$(CONFIG_PAGE_MIGRATE) += migrate.o
+
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
diff -Nur 2.6.4.ref/mm/migrate.c 2.6.4.mig2-tmp/mm/migrate.c
--- 2.6.4.ref/mm/migrate.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig2-tmp/mm/migrate.c	Fri Apr  2 14:51:42 2004
@@ -0,0 +1,888 @@
+/*
+ * Migrate pages from a ccNUMA node to another.
+ * ============================================
+ *
+ * Version 0.2, 2nd of April 2004
+ * By Zoltan Menyhart, Bull S.A. <Zoltan.Menyhart@bull.net>
+ * The usual GPL applies.
+ *
+ * See also "Documentation/migrate.txt" and "page_migrate.h".
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
+#include <linux/page_migrate.h>
+#include <linux/delay.h>		/* For "GET_TIMER()" */
+
+
+/*
+ * Type of virtual addresses. Pointers converted to this type to be able to
+ * do some atithmetics.
+ */
+typedef	unsigned long	vaddr_t;
+
+
+#if defined(_TEST_)
+
+/*
+ * Set the bits - as defined below - for some kernel messages.
+ */
+unsigned int _pr_flag_;
+
+#define	PRINT_errors	1
+#define	PRINT_etc	2
+#define	PRINT_pgd	4		/* Show PGD scan */
+
+#define PRINT(args...)		do {						\
+					if (_pr_flag_)				\
+						printk(args);			\
+				} while (0)
+#define PRINT_ERR(args...)	do {						\
+					if (_pr_flag_ & PRINT_errors)		\
+						printk(args);			\
+				} while (0)
+#define PRINT_ETC(args...)	do {						\
+					if (_pr_flag_ & PRINT_etc)		\
+						printk(args);			\
+				} while (0)
+#define PRINT_PGD(args...)	do {						\
+					if (_pr_flag_ & PRINT_pgd)		\
+						printk(args);			\
+				} while (0)
+
+static const char dest_not_online[] =	"Destination node not online\n";
+static const char no_vma[] =		"Cannot find VMA for address 0x%lx\n";
+static const char illegal_pid[] =	"Illegal PID\n";
+static const char inv_n_addresses[] = 	"Invalid number of addresses";
+static const char ill_va_alias[] =	"v-addr alias in range: 0x%p...0x%p\n";
+static const char no_momory[] =		"No more memory\n";
+static const char ill_user_buff[] =	"Illegal user buffer address\n";
+
+phaddr_t	gimme_an_address(const caddr_t);
+
+#define	STATIC
+#define	INLINE
+
+#else	/* #if defined(_TEST_) */
+
+#define PRINT(args...)		do { } while (0)
+#define PRINT_ERR(args...)	do { } while (0)
+#define PRINT_ETC(args...)	do { } while (0)
+#define PRINT_PGD(args...)	do { } while (0)
+
+#define	STATIC			static
+#define	INLINE			inline
+
+#endif	/* #if defined(_TEST_) */
+
+
+STATIC return_t
+common_page_migrate(const int, const caddr_t, const size_t, const int,
+								const pid_t);
+
+STATIC INLINE return_t
+validate_migrate_pages(const int, const vaddr_t, const vaddr_t, const int,
+						struct mm_struct * const);
+
+STATIC INLINE int
+migr_1_page_by_pte(const int, const phaddr_t * const, const size_t, const int,
+				struct mm_struct * const, pte_t * const);
+
+STATIC INLINE return_t
+batch_migrate(const caddr_t, size_t, const int, const pid_t);
+
+int
+check_migr_1_page(struct page * const, struct page * const,
+					struct mm_struct * const, pte_t * const);
+
+
+/*
+ * These are the flags which are copied for the new page:
+ */
+#define	FLAG_MASK	(PG_referenced | PG_uptodate | PG_dirty | PG_active |	\
+			 PG_highmem | PG_arch_1 | PG_private | PG_writeback |	\
+			 PG_nosave | PG_mappedtodisk | PG_reclaim | PG_compound)
+
+
+/*
+ * Migration type for "common_page_migrate()":
+ */
+enum {	_VADDR_MIG,			/* Virtual address range */
+	_PHADDR_MIG,			/* List of physical addresses */
+};
+
+
+#if defined(_NEED_STATISTICS_)
+
+/*
+ * Statistics are accessed in a non atomic way. Who cares? Just some statistics...
+ */
+STATIC struct _statistics_	_statistics;
+STATIC struct _statistics_size_	_statistics_sizes =
+					{sizeof _statistics, MAX_NUMNODES};
+
+#define	DECLARE_ITC_VAR(var)		unsigned long var
+#define	SAVE_ITC(var)			var = GET_TIMER()
+#define	STORE_DELAY(var, dest)		_statistics.t.dest += GET_TIMER() - var
+#define	COUNT(what)			_statistics.c.what++
+#define	ERROR_CNT(what)			_statistics.e.what++
+#define	ERROR_CNT_ADD(var, delta)	_statistics.e.var += delta
+#define	MOVED(from, to)			_statistics.count[from][to]++
+
+STATIC INLINE int	page_migrate_statistics(const caddr_t, const int);
+
+#else
+
+#define	DECLARE_ITC_VAR(var)
+#define	SAVE_ITC(var)			do { } while (0)
+#define	STORE_DELAY(var, dest)		do { } while (0)
+#define	COUNT(what)			do { } while (0)
+#define	ERROR_CNT(what)			do { } while (0)
+#define	ERROR_CNT_ADD(var, delta)	do { } while (0)
+#define	MOVED(from, to)			do { } while (0)
+
+#endif	/* #if defined(_NEED_STATISTICS_) */
+
+
+/*
+ * Migrate pages from a NUMA node to another (and some other minor services).
+ * (See "Documentation/migrate.txt" and "page_migrate.h".)
+ *
+ * As usual, "-Exxx" returned on errors.
+ */
+asmlinkage return_t
+sys_page_migrate(const int cmd, const caddr_t address, const size_t length,
+						const int node, const pid_t pid)
+{
+	return_t	rc;
+	DECLARE_ITC_VAR(time);		/* Total time for "sys_page_migrate()" */
+
+	SAVE_ITC(/* out */ time);
+	PRINT("\nsys_page_migrate(%d, 0x%p, 0x%lx, %d, %d): pid = %d\n",
+				cmd, address, length, node, pid, current->pid);
+	switch (cmd){
+	/*
+	 * Migrate some pages from a NUMA node to another.
+	 */
+	case _PHADDR_BATCH_MIGRATE_:
+		if (length > PAGE_SIZE / sizeof(phaddr_t)){
+			PRINT_ERR(inv_n_addresses);
+			ERROR_CNT(bad_request);
+			rc = -EINVAL;
+			break;
+		}
+		rc = batch_migrate(address, length, node, pid);
+		break;
+	/*
+	 * Migrate virtual address range.
+	 */
+	case _VA_RANGE_MIGRATE_:
+		/*
+		 * Some architectures do not decode all the MSB-s of virtual
+		 * addresses for the PGD, PMD and PTE indices, i.e. they have
+		 * got holes or aliases in the virtual address space. Make sure
+		 * that "length" does not span over virtual address holes nor
+		 * it creates illegal alias to an otherwise valid address.
+		 */
+		if (__IS_VADDR_ALIAS((vaddr_t) address, length)){
+			PRINT_ERR(ill_va_alias, address, address + length);
+			ERROR_CNT(non_existent_addr);
+			rc = -EFAULT;
+			break;
+		}
+		rc = common_page_migrate(_VADDR_MIG, address, length, node, pid);
+		break;
+
+#if defined(_NEED_STATISTICS_)
+	case _STATISTICS_:
+		rc = page_migrate_statistics(address, length != 0);
+		break;
+	case _SIZEOF_STATISTICS_:
+		rc =  *(return_t *) &_statistics_sizes; /* Yeh, I know... */
+		break;
+#endif
+#if defined(_TEST_)
+	case _GIMME_AN_ADDRESS_:
+		rc = (return_t) gimme_an_address(address);
+		break;
+#endif
+	default:
+		ERROR_CNT(bad_request);
+		rc = -EINVAL;
+		break;
+	}
+	STORE_DELAY(time, /* out */ total);
+	return rc;
+}
+
+
+/*
+ * Migrate some pages identified by their physical address from a NUMA node to
+ * another.
+ *
+ * Arguments:	table:	-> the user buffer containing the physical addresses of
+ *			the pages to be migrated.
+ *			Max. "PAGE_SIZE / sizeof(phaddr_t *)" of them can be
+ *			migrated at once.
+ *		n:	Number of the physical page addresses
+ *		node:	Destination NUMA node
+ *		pid:	Pages are assumed to belong to this process
+ *
+ * Returns:	On (partial) success, some statics are returned.
+ *		As usual, "-Exxx" returned on errors.
+ */
+STATIC INLINE return_t
+batch_migrate(const caddr_t table, const size_t n, const int node,
+								const pid_t pid)
+{
+	return_t	rc;
+	phaddr_t	*bp;
+	DECLARE_ITC_VAR(alloc_time);		/* Time for "vmalloc()" */
+
+	/*
+	 * Fetch the table of the addresses.
+	 */
+	SAVE_ITC(/* out */ alloc_time);
+	bp = vmalloc(PAGE_SIZE);
+	STORE_DELAY(alloc_time, /* out */ page_alloc);
+	if (bp == NULL){
+		PRINT_ERR(no_momory);
+		ERROR_CNT(no_memory);
+		return -ENOMEM;
+	}
+	if (copy_from_user(bp, table, n * sizeof(phaddr_t)) != 0){
+		vfree(bp);
+		PRINT_ERR(ill_user_buff);
+		ERROR_CNT(bad_request);
+		return -EFAULT;
+	}
+	rc = common_page_migrate(_PHADDR_MIG, (caddr_t) bp, n, node, pid);
+	vfree(bp);
+	return rc;
+}
+
+
+/*
+ * Look up an "mm_struct" belonging to a process ID.
+ * We require to migrate the memory pages of someone similar rights which are
+ * necessary to kill her/him.
+ *
+ * Arguments:	pid:	ID of the victim process, "0" means myself
+ *		rcp:	-> detailed error code
+ *
+ * Returns:	On success, a pointer to the victim "mm_struct" is returned.
+ *		"NULL" is returned on failure and the "-Exxx" in "*rcp".
+ *
+ * Notes:	- On success, "->mm_users" gets incremented to make sure that
+ *		  "mm_struct" does not go away
+ *		- "->mm" of a kernel thread is "NULL"; anyway, we don't dare to
+ *		  touch a kernel thread
+ */
+STATIC INLINE struct mm_struct *
+look_up_mm(const pid_t pid, return_t * const rcp)
+{
+	struct task_struct	*p;
+	struct mm_struct	*mm;
+	DECLARE_ITC_VAR(time);			/* "mm" look up time */
+
+	SAVE_ITC(/* out */ time);
+	read_lock(&tasklist_lock);
+	if ((p = find_task_by_pid(pid)) == NULL){
+		read_unlock(&tasklist_lock);
+		STORE_DELAY(time, /* out */ mm_lookup);
+		*rcp = -ESRCH;
+		return NULL;
+	}
+	if (current->session != p->session && current->euid != p->suid &&
+			current->euid != p->uid && current->uid != p->suid &&
+				current->uid != p->uid && !capable(CAP_KILL)){
+		read_unlock(&tasklist_lock);
+		STORE_DELAY(time, /* out */ mm_lookup);
+		*rcp = -EPERM;
+		return NULL;
+	}
+	/*
+	 * "get_task_mm()" includes "task_lock()" that "nests both inside and
+	 * outside of read_lock(&tasklist_lock)" - as a note in "sched.h" states.
+	 */
+	if ((mm = get_task_mm(p)) == NULL)	/* If kernel thread... */
+		*rcp = -EPERM;
+	read_unlock(&tasklist_lock);
+	STORE_DELAY(time, /* out */ mm_lookup);
+	return mm;
+}
+
+
+/*
+ * Common page migration routine.
+ *
+ * Arguments:	type:	If _VADDR_MIG (Virtual address range):
+ *
+ *			addr:	Starting virtual address in a process'es address
+ *				space
+ *			ln:	Length of the address range to be migrated
+ *
+ *			Else _PHADDR_MIG (List of physical addresses):
+ *
+ *			addr:	-> the page aldligned buffer containing the
+ *				physical addresses of the pages to be migrated
+ *			ln:	Number of the physical page addresses
+ *
+ *		node:	Destination NUMA node
+ *		pid:	ID of the victim process, "0" means myself
+ *
+ * Returns:	On (partial) success, some statics are returned.
+ *		As usual, "-Exxx" returned on errors.
+ */
+STATIC return_t
+common_page_migrate(const int type, const caddr_t addr, const size_t ln,
+						const int node, const pid_t pid)
+{
+	struct mm_struct	*mm;
+	return_t		rc;
+	struct vm_area_struct	*beg_vma;
+	DECLARE_ITC_VAR(vma_time);	/* Time for "find_vma()" */
+	DECLARE_ITC_VAR(mmap_sem);	/* Time for "down_read(&mm->mmap_sem)" */
+	DECLARE_ITC_VAR(pgd_lock);	/* "spin_lock(&mm->page_table_lock)" */
+	DECLARE_ITC_VAR(pgd_unlock);	/* "spin_unlock(&mm->page_table_lock)" */
+
+	if (!node_online(node)){
+		PRINT_ERR(dest_not_online);
+		ERROR_CNT(bad_request);
+		return -ENODEV;
+	}
+	if (pid != 0 && pid != current->pid){
+		if ((mm = look_up_mm(pid, &rc)) == NULL){
+			PRINT_ERR(illegal_pid);
+			ERROR_CNT(bad_request);
+			return rc;
+		}
+	} else {
+		mm = current->mm;
+		/*
+		 * Actually, there is no need to grab "mm" because it is ours.
+		 * As we do not want to ask questions when releasing it...
+		 * It is safe just to increment the counter.
+		 */
+		atomic_inc(&mm->mm_users);
+	}
+	SAVE_ITC(/* out */ mmap_sem);
+	down_read(&mm->mmap_sem);		/* Protect the VMA list */
+	STORE_DELAY(mmap_sem, /* out */ mmap_sem);
+	if (type == _VADDR_MIG){
+		/*
+		 * Check if the starting virtual "addr" is valid.
+		 * Some architectures do not decode all the MSB-s of virtual
+		 * addresses for the PGD, PMD and PTE indices, i.e. they have
+		 * got holes or aliases in the virtual address space.
+		 * Make sure that illegal aliases (to valid virtual addresses)
+		 * are rejected.
+		 */
+		SAVE_ITC(/* out */ vma_time);
+		beg_vma = find_vma(mm, (vaddr_t) addr);
+		STORE_DELAY(vma_time, /* out */ find_vma);
+		if (beg_vma == NULL || beg_vma->vm_start > (vaddr_t) addr){
+			up_read(&mm->mmap_sem);
+			mmput(mm);
+			PRINT_ERR(no_vma, (vaddr_t) addr);
+			ERROR_CNT(non_existent_addr);
+			return -EFAULT;
+		}
+	}
+	/*
+	 * We need the page table lock to synchronize with "kswapd"
+	 * and the SMP-safe atomic PTE updates.
+	 */
+	SAVE_ITC(/* out */ pgd_lock);
+	spin_lock(&mm->page_table_lock);
+	STORE_DELAY(pgd_lock, /* out */ pgd_lock);
+	/*
+	 * Look up the pages in the PGD and migrate them one by one.
+	 * (No harm if page-masking the address of the buffer holding the
+	 *  physical addresses of the pages.)
+	 */
+	rc = validate_migrate_pages(type, (vaddr_t) addr & PAGE_MASK,
+								ln, node, mm);
+	/*
+	 * Let the others complete the page fault handler code. They will find
+	 * the condition "someone has already installed the PTE" to be TRUE.
+	 */
+	SAVE_ITC(/* out */ pgd_unlock);
+	spin_unlock(&mm->page_table_lock);
+	STORE_DELAY(pgd_unlock, /* out */ pgd_unlock);
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+	return rc;
+}
+
+
+/*
+ * Validate and migrate pages belonging to a PGD. We check the user pages only.
+ *
+ * Arguments:	type:	If _VADDR_MIG (Virtual address range):
+ *
+ *			addr:	Starting virtual address in a process'es address
+ *				space
+ *			ln:	Length of the address range to be migrated
+ *
+ *			Else _PHADDR_MIG (List of physical addresses):
+ *
+ *			addr:	-> the page aligned buffer containing the
+ *				physical addresses of the pages to be migrated
+ *			ln:	Number of the physical page addresses
+ *
+ *		node:	Destination NUMA node
+ *		mm:	-> victim "mm_struct"
+ *
+ * Returns:	On (partial) success, the number of the pages actually migrated
+ *		is returned (in form of "struct _un_success_count_").
+ *		As usual, "-Exxx" returned on errors
+ *
+ * Notes:	- Caller has to hold "mm->mmap_sem" for read and
+ *		  "mm->page_table_lock".
+ *		- For migrtating a range of virtual addresses, we've already
+ *		  checked that it is safe to start walking the PGD, the PMD and
+ *		  the PTE at "addr". We've also checked that "[addr...ulimit)"
+ *		  does not span over virtual address range holes nor it creates
+ *		  an illegal alias to an otherwise valid address.
+ */
+STATIC INLINE return_t
+validate_migrate_pages(const int type, const vaddr_t addr, const vaddr_t ln,
+				const int node, struct mm_struct * const mm)
+{
+	vaddr_t			vaddr;
+	vaddr_t			ulimit; 
+	unsigned long		g, m, e;	/* PGD, MPD and PTE indices */
+	const pgd_t		*pgd;
+	const pmd_t		*pmd;
+	pte_t			*pte, *pte0;
+	int			rc;
+	struct _un_success_count_	count = {0, 0};
+	DECLARE_ITC_VAR(pgd_scan_t);		/* PGD scan time */
+
+	if (type == _PHADDR_MIG){
+		vaddr = 0;
+		ulimit = TASK_SIZE;		/* No limit */
+	} else {
+		vaddr = addr;
+		ulimit = PAGE_ALIGN((vaddr_t) addr + ln);	/* Round up */
+	}
+	g = pgd_index(vaddr);		/* PGD scan starts here */
+	m = pmd_index(vaddr);		/* The 1st PMD scan starts here */
+	e = pte_index(vaddr);		/* The 1st PTE scan starts here */
+	SAVE_ITC(/* out */ pgd_scan_t);
+	for (pgd = mm->pgd + g; vaddr < ulimit && g < USER_PTRS_PER_PGD;
+					/* Next PMD scan starts at index 0 */
+							m = 0, g++, pgd++){
+		PRINT_PGD("address: 0x%016lx pgd: 0x%p ", vaddr, pgd);
+		PRINT_PGD("g: 0x%lx m: 0x%lx e: 0x%lx\n", g, m, e);
+		PRINT_PGD("__VA():\t 0x%016lx\n", __VA(g, m, e));
+		/*
+		 * Migration tolarates holes in the virtual address space.
+		 */
+		if (pgd_none(*pgd) || pgd_bad(*pgd)){
+			vaddr &= ~(PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - 1);
+			vaddr += PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE;
+			continue;
+		}
+		for (pmd = pmd_offset(pgd, 0) + m;
+					m < PTRS_PER_PMD && vaddr < ulimit;
+					/* Next PTE scan starts at index 0 */
+							e = 0, m++, pmd++){
+			if (pmd_none(*pmd) || pmd_bad(*pmd)){
+				vaddr &= ~(PTRS_PER_PTE * PAGE_SIZE - 1);
+				vaddr += PTRS_PER_PTE * PAGE_SIZE;
+				continue;
+			}
+			pte0 = pte_offset_map(pmd, 0);
+			for (pte = pte0 + e; e < PTRS_PER_PTE && vaddr < ulimit;
+						vaddr += PAGE_SIZE, e++, pte++){
+				if (!pte_present(*pte))
+					continue;
+				PRINT("\nVirtual addr:\t0x%016lx\n",
+								__VA(g, m, e));
+				STORE_DELAY(pgd_scan_t, /* out */ pgd_scan);
+				rc = migr_1_page_by_pte(type, (phaddr_t *) addr,
+							ln, node, mm, pte);
+				if (rc < 0){
+					pte_unmap(pte0);
+					return rc;
+				}
+				SAVE_ITC(/* out */ pgd_scan_t);
+				switch (rc){
+				case 2:	/* "*pte" does not match against the */
+					/* table of the physical addresses */
+					continue;
+				case 1:
+					count.successful++;
+					break;
+				default:
+					count.failed++;
+				}
+			}
+			pte_unmap(pte0);
+		}
+	}
+	STORE_DELAY(pgd_scan_t, /* out */ pgd_scan);
+	return *(return_t *) &count;		/* Yeh, I know... */
+}
+
+
+/*
+ * Check a PTE against the list of the physical addresses.
+ *
+ * Arguments:	addr:	-> the page aligned buffer containing the
+ *			physical addresses of the pages to be migrated
+ *		ln:	Number of the physical page addresses
+ *		pte:	PTE of the page to be moved
+ *
+ * Returns:	1:	PTE does not match
+ *		0:	A physical address corresponds to the PTE
+ *
+ * Note:	"mm->page_table_lock" and "mm->mmap_sem" have to be held.
+ */
+STATIC INLINE int
+check_phys_address(const phaddr_t *addr, size_t ln, const pte_t pte)
+{
+	for (; ln > 0; ln--, addr++)
+		if ((pte_val(pte) & _PFN_MASK) == (*addr & _PFN_MASK))
+			return 0;
+	return 1;
+}
+
+
+/*
+ * Migrate a page identified by its PTE.
+ *
+ * Arguments:	type:	If _VADDR_MIG (Virtual address range):
+ *
+ *			addr:	*do not care*
+ *			ln:	*do not care*
+ *
+ *			Else _PHADDR_MIG (List of physical addresses):
+ *
+ *			addr:	-> the page aligned buffer containing the
+ *				physical addresses of the pages to be migrated
+ *			ln:	Number of the physical page addresses
+ *
+ *		node:	Destination NUMA node
+ *		mm:	-> victim "mm_struct"
+ *		pte:	-> PTE of the page to be moved
+ *
+ * Returns:	1:	Success
+ *		2:	PTE does not match against the table of the
+ *			physical addresses
+ *		0:	We cannot cope with this page (it is valid, though)
+ *		-Exxx:	Fatal errors
+ *
+ * Note:	"mm->page_table_lock" and "mm->mmap_sem" have to be held.
+ */
+STATIC INLINE int
+migr_1_page_by_pte(const int type, const phaddr_t * const addr, const size_t ln,
+		const int node, struct mm_struct * const mm, pte_t * const pte)
+{
+	const phaddr_t	old_addr = pte_val(*pte) & _PFN_MASK;
+	const int	src_node = paddr_to_nid(old_addr);
+	struct page	* const old_p = pfn_to_page(old_addr >> PAGE_SHIFT);
+	struct page	*new_p;
+	int		rc;
+	DECLARE_ITC_VAR(alloc_time);	/* Time for "vmalloc()" */
+	DECLARE_ITC_VAR(lock_time);	/* Time for "lock_page()" */
+	DECLARE_ITC_VAR(unlock_time);	/* Time for "unlock_page()" */
+	DECLARE_ITC_VAR(free_time);	/* Time for "__free_pages()" and */
+					/* "page_cache_release()" */
+
+	if (type == _PHADDR_MIG && check_phys_address(addr, ln, *pte))
+		return 2;
+	if (node == src_node){
+		PRINT_ETC("Old ph addr:\t0x%016llx old node: %d new node: %d\n",
+						old_addr, src_node, node);
+		return 1;
+	}
+	SAVE_ITC(/* out */ alloc_time);
+	new_p = alloc_pages_node(node, GFP_HIGHUSER | __GFP_NORETRY, 0);
+	STORE_DELAY(alloc_time, /* out */ page_alloc);
+	if (new_p == NULL){
+		PRINT_ERR("No more memory on node %d\n", node);
+		ERROR_CNT(no_memory);
+		return -ENOMEM;
+	}
+	/*
+	 * Make sure the old page is not set free while we hold its lock.
+	 */
+	get_page(old_p);
+	/*
+	 * TODO: should "lock_page()" take too much time, try-lock instead.
+	 */
+	SAVE_ITC(/* out */ lock_time);
+	lock_page(old_p);
+	STORE_DELAY(lock_time, /* out */ page_lock);
+
+	rc = check_migr_1_page(old_p, new_p, mm, pte);
+
+	SAVE_ITC(/* out */ unlock_time);
+	unlock_page(old_p);
+	STORE_DELAY(unlock_time, /* out */ page_unlock);
+	PRINT("check_migr_1_page() returned: %d\n", rc);
+	if (rc == 0)
+		MOVED(src_node, node);
+	else{
+		SAVE_ITC(/* out */ free_time);
+		__free_pages(new_p, 0);
+		STORE_DELAY(free_time, /* out */ page_free);
+	}
+	SAVE_ITC(/* out */ free_time);
+	put_page(old_p);
+	STORE_DELAY(free_time, /* out */ page_free);
+	return rc == 0 ? 1 : 0;
+}
+
+
+/*
+ * The real page migration is done here.
+ *
+ * Arguments:	old:	-> old page structure
+ *		new:	-> new page structure
+ *		node:	Destination NUMA node
+ *		pte:	-> PTE of the page to be moved
+ *
+ * Returns:	Negative values (like -Exxx) indicate errors
+ *
+ * Notes:	- Both the old and the new pages and their "pte_chain"-s have
+ *		  to be locked
+ *		- "mm->page_table_lock" and "mm->mmap_sem" have to be held
+ */
+STATIC INLINE int
+page_migrate(struct page * const old, struct page * const new,
+				struct mm_struct * const mm, pte_t * const pte_p)
+{
+	struct vm_area_struct	*vma;
+	pte_t			pte;
+	vaddr_t			vaddress;
+	DECLARE_ITC_VAR(vma_time);	/* Time for "find_vma()" */
+	DECLARE_ITC_VAR(flush_tlb_t);	/* Time for "flush_tlb_page()" */
+	DECLARE_ITC_VAR(add_lru_time);	/* Time for "lru_cache_add_active()" */
+	DECLARE_ITC_VAR(copy_time);	/* Time for "copy_user_highpage()" */
+	DECLARE_ITC_VAR(upd_mmu_cache);	/* Time for "update_mmu_cache()" */
+
+	if (!PageDirect(old)){
+		PRINT_ERR("Direct mapped pages only\n");
+		ERROR_CNT(page_type_not_supp);
+		return -EFAULT;
+	}
+	vaddress = ptep_to_address(pte_p);
+	PRINT("Virtual addr:\t0x%lx\n", vaddress);
+	SAVE_ITC(/* out */ vma_time);
+	vma = find_vma(mm, vaddress);
+	STORE_DELAY(vma_time, /* out */ find_vma);
+	if (vma == NULL || vma->vm_start > vaddress)
+		panic("\nVMA lost ???\n");
+	/*
+	 * Nuke the page table entry.
+	 */
+	flush_cache_page(vma, vaddress);
+	pte = ptep_get_and_clear(pte_p);
+	SAVE_ITC(/* out */ flush_tlb_t);
+	flush_tlb_page(vma, vaddress);
+	STORE_DELAY(flush_tlb_t, /* out */ flush_tlb);
+	/*
+	 * From now on, the other CPUs cannot touch the content of the page.
+	 * Should they try to, they would observe page faults.
+	 * They pass easily "->mmap_sem" beacause they take it for read, too.
+	 * They queue up in the page fault handler to take "->page_table_lock".
+	 */
+	PRINT("Old ph addr:\t0x%016lx\n", page_to_phys(old));
+	PRINT("Old PTE:\t0x%016lx\n", pte_val(pte));
+	PRINT("_PFN_MASK:\t0x%016lx\n", _PFN_MASK);
+	/*
+	 * Copy some of the page structure.
+	 */
+	new->flags = (new->flags & ~FLAG_MASK) | (old->flags & FLAG_MASK);
+	new->pte.direct = old->pte.direct;
+	SetPageDirect(new);			/* Direct mapped pages only */
+	old->pte.direct = NULL;
+	ClearPageDirect(old);
+	if (PagePrivate(new))
+		new->private = old->private;
+	SAVE_ITC(/* out */ add_lru_time);
+	lru_cache_add_active(new);
+	STORE_DELAY(add_lru_time, /* out */ add_lru);
+	/*
+	 * Here is where the data is copied.
+	 */
+	SAVE_ITC(/* out */ copy_time);
+	copy_user_highpage(new, old, vaddress);
+	STORE_DELAY(copy_time, /* out */ copy);
+	/*
+	 * The new PTE keeps everything but the PFN.
+	 */
+	pte = mk_pte(new, __pgprot((pte_val(pte) & ~_PFN_MASK)));
+	PRINT("New ph addr:\t0x%016lx\nNew PTE:\t0x%016lx\n\n",
+						page_to_phys(new), pte_val(pte));
+	set_pte(pte_p, pte);
+	SAVE_ITC(/* out */ upd_mmu_cache);
+	update_mmu_cache(vma, vaddress, pte);
+	STORE_DELAY(upd_mmu_cache, /* out */ update_mmu_cache);
+	/*
+	 * The old page was "lru_cache_add_active()"-ed e.g. in
+	 * "do_anonymous_page()".
+	 */
+	page_cache_release(old);
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
+ * Notes:	- The old page has to be locked
+ *		- "mm->page_table_lock" and "mm->mmap_sem" have to be held
+ */
+STATIC INLINE int
+check_migr_1_page(struct page * const old, struct page * const new,
+				struct mm_struct * const mm, pte_t * const pte)
+{
+	int rc;
+	DECLARE_ITC_VAR(pte_chain_lock_time);	/* Time for "pte_chain_lock()" */
+	DECLARE_ITC_VAR(unlock_time);		/* Time for "unlock_page()" */
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
+/*		return -EIO;
+ */
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
+	STORE_DELAY(pte_chain_lock_time, /* out */ pte_chain_lock);
+	if (!page_mapped(old)){			/* Actually means "r-mapped" */
+		PRINT_ERR("Page not in r-map\n");
+		pte_chain_unlock(old);
+		ERROR_CNT(page_type_not_supp);
+		return -EFAULT;
+	}
+	lock_page(new);
+	pte_chain_lock(new);
+
+	rc = page_migrate(old, new, mm, pte);
+
+	pte_chain_unlock(new);
+	SAVE_ITC(/* out */ unlock_time);
+	unlock_page(new);
+	STORE_DELAY(unlock_time, /* out */ new_page_unlock);
+	pte_chain_unlock(old);
+	return rc;
+}
+
+
+#if defined(_NEED_STATISTICS_)
+
+/*
+ * Fetch and clear the statistics.
+ * Accessed in a non atomic way. Who cares? Just some statistics :-)
+ */
+STATIC INLINE int
+page_migrate_statistics(const caddr_t vaddress, const int flag)
+{
+	/*
+	 * Assuming all the CPU-s are clocked at the same frequency.
+	 */
+	_statistics.t.cyc_per_usec = local_cpu_data->cyc_per_usec;
+	if (copy_to_user(vaddress, &_statistics, sizeof _statistics) != 0)
+		return -EFAULT;
+	if (flag)
+		memset(&_statistics, 0,sizeof _statistics);
+	return 0;
+}
+
+#endif	/* #if defined(_NEED_STATISTICS_) */
+
+
+#if defined(_TEST_)
+
+/*
+ * Translate a user mode virtual address to a physical one.
+ */
+phaddr_t
+gimme_an_address(const caddr_t vaddress)
+{
+	const struct vm_area_struct	*vma;
+	const pgd_t			*pgd;
+	const pmd_t			*pmd;
+	const pte_t			*pte;
+	phaddr_t			phaddress = -EFAULT;
+
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
+#endif /* #if defined(_TEST_) */
+

--------------9666F83589B875839215849A--


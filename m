Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUCYRJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUCYRHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:07:23 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:58633 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263435AbUCYQ7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:59:49 -0500
Date: Thu, 25 Mar 2004 17:03:33 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
cc: Andi Kleen <ak@suse.de>, raybry@sgi.com, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [PATCH] [6/6] HUGETLB memory commitment
Message-ID: <18970668.1080234213@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[080-mem_acctdom_hugetlb_sysctl]

---
 include/linux/mman.h     |    4 ++--
 include/linux/sysctl.h   |    2 ++
 kernel/sysctl.c          |   28 ++++++++++++++++++++++------
 mm/mmap.c                |   11 +++++++----
 mm/nommu.c               |    8 ++++++--
 security/commoncap.c     |   19 ++++++++++---------
 security/dummy.c         |   19 ++++++++++---------
 security/selinux/hooks.c |   19 ++++++++++---------
 8 files changed, 69 insertions(+), 41 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/mman.h current/include/linux/mman.h
--- reference/include/linux/mman.h	2004-03-25 15:03:32.000000000 +0000
+++ current/include/linux/mman.h	2004-03-25 16:43:46.000000000 +0000
@@ -10,8 +10,8 @@
 #define MREMAP_MAYMOVE	1
 #define MREMAP_FIXED	2
 
-extern int sysctl_overcommit_memory;
-extern int sysctl_overcommit_ratio;
+extern int sysctl_overcommit_memory[];
+extern int sysctl_overcommit_ratio[];
 extern atomic_t vm_committed_space[];
 
 #ifdef CONFIG_SMP
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/sysctl.h current/include/linux/sysctl.h
--- reference/include/linux/sysctl.h	2004-03-11 20:47:28.000000000 +0000
+++ current/include/linux/sysctl.h	2004-03-25 16:45:06.000000000 +0000
@@ -158,6 +158,8 @@ enum
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
+	VM_OVERCOMMIT_MEMORY_HUGEPAGES=22,	/* Turn off the virtual memory safety limit */
+	VM_OVERCOMMIT_RATIO_HUGEPAGES=23,	/* percent of RAM to allow overcommit in */
 };
 
 
diff -X /home/apw/lib/vdiff.excl -rupN reference/kernel/sysctl.c current/kernel/sysctl.c
--- reference/kernel/sysctl.c	2004-03-25 15:03:28.000000000 +0000
+++ current/kernel/sysctl.c	2004-03-25 16:44:46.000000000 +0000
@@ -50,8 +50,8 @@
 /* External variables not in a header file. */
 extern int panic_timeout;
 extern int C_A_D;
-extern int sysctl_overcommit_memory;
-extern int sysctl_overcommit_ratio;
+extern int sysctl_overcommit_memory[];
+extern int sysctl_overcommit_ratio[];
 extern int max_threads;
 extern atomic_t nr_queued_signals;
 extern int max_queued_signals;
@@ -628,16 +628,16 @@ static ctl_table vm_table[] = {
 	{
 		.ctl_name	= VM_OVERCOMMIT_MEMORY,
 		.procname	= "overcommit_memory",
-		.data		= &sysctl_overcommit_memory,
-		.maxlen		= sizeof(sysctl_overcommit_memory),
+		.data		= &sysctl_overcommit_memory[VM_AD_DEFAULT],
+		.maxlen		= sizeof(sysctl_overcommit_memory[VM_AD_DEFAULT]),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
 	{
 		.ctl_name	= VM_OVERCOMMIT_RATIO,
 		.procname	= "overcommit_ratio",
-		.data		= &sysctl_overcommit_ratio,
-		.maxlen		= sizeof(sysctl_overcommit_ratio),
+		.data		= &sysctl_overcommit_ratio[VM_AD_DEFAULT],
+		.maxlen		= sizeof(sysctl_overcommit_ratio[VM_AD_DEFAULT]),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
@@ -715,6 +715,22 @@ static ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &hugetlb_sysctl_handler,
 	 },
+	 {
+		.ctl_name	= VM_OVERCOMMIT_MEMORY_HUGEPAGES,
+		.procname	= "overcommit_memory_hugepages",
+		.data		= &sysctl_overcommit_memory[VM_AD_HUGETLB],
+		.maxlen		= sizeof(sysctl_overcommit_memory[VM_AD_HUGETLB]),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= VM_OVERCOMMIT_RATIO_HUGEPAGES,
+		.procname	= "overcommit_ratio_hugepages",
+		.data		= &sysctl_overcommit_ratio[VM_AD_HUGETLB],
+		.maxlen		= sizeof(sysctl_overcommit_ratio[VM_AD_HUGETLB]),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #endif
 	{
 		.ctl_name	= VM_LOWER_ZONE_PROTECTION,
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/mmap.c current/mm/mmap.c
--- reference/mm/mmap.c	2004-03-25 15:03:32.000000000 +0000
+++ current/mm/mmap.c	2004-03-25 17:23:45.000000000 +0000
@@ -52,8 +52,12 @@ pgprot_t protection_map[16] = {
 	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
 };
 
-int sysctl_overcommit_memory = 0;	/* default is heuristic overcommit */
-int sysctl_overcommit_ratio = 50;	/* default is 50% */
+/* Defaults are:
+ *  VM_AD_DEFAULT       heuristic overcommit, ratio 50%
+ *  VM_AD_HUGETLB       strict commit, ratio 100%
+ */
+int sysctl_overcommit_memory[VM_ACCTDOM_NR] = {  0,    0 };
+int sysctl_overcommit_ratio[VM_ACCTDOM_NR]  = { 50,  100 };
 atomic_t vm_committed_space[VM_ACCTDOM_NR] = 
      { [ 0 ... VM_ACCTDOM_NR-1 ] = ATOMIC_INIT(0) };
 
@@ -612,8 +616,7 @@ munmap_back:
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
-	if (!(flags & MAP_NORESERVE) || 
-	    (acctdom == VM_AD_DEFAULT && sysctl_overcommit_memory > 1)) {
+	if (!(flags & MAP_NORESERVE) || sysctl_overcommit_memory[acctdom] > 1) {
 		if (vm_flags & VM_SHARED) {
 			/* Check memory availability in shmem_file_setup? */
 			vm_flags |= VM_ACCOUNT;
diff -X /home/apw/lib/vdiff.excl -rupN reference/mm/nommu.c current/mm/nommu.c
--- reference/mm/nommu.c	2004-03-25 15:03:32.000000000 +0000
+++ current/mm/nommu.c	2004-03-25 17:23:22.000000000 +0000
@@ -31,8 +31,12 @@ unsigned long num_physpages;
 unsigned long askedalloc, realalloc;
 atomic_t vm_committed_space[VM_ACCTDOM_NR] = 
      { [ 0 ... VM_ACCTDOM_NR-1 ] = ATOMIC_INIT(0) };
-int sysctl_overcommit_memory; /* default is heuristic overcommit */
-int sysctl_overcommit_ratio = 50; /* default is 50% */
+/* Defaults are:
+ *  VM_AD_DEFAULT       heuristic overcommit, ratio 50%
+ *  VM_AD_HUGETLB       strict commit, ratio 100%
+ */ 
+int sysctl_overcommit_memory[VM_ACCTDOM_NR] = {  0,    0 };
+int sysctl_overcommit_ratio[VM_ACCTDOM_NR]  = { 50,  100 };
 
 /*
  * Handle all mappings that got truncated by a "truncate()"
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/commoncap.c current/security/commoncap.c
--- reference/security/commoncap.c	2004-03-25 15:03:33.000000000 +0000
+++ current/security/commoncap.c	2004-03-25 17:15:17.000000000 +0000
@@ -315,9 +315,16 @@ int cap_vm_enough_memory(int domain, lon
 
 	vm_acct_memory(domain, pages);
 
+        /*
+	 * Sometimes we want to use more memory than we have
+	 */
+	if (sysctl_overcommit_memory[domain] == 1)
+		return 0;
+
 	/* Check against the full compliment of hugepages, no reserve. */
 	if (domain == VM_AD_HUGETLB) {
-		allowed = hugetlb_total_pages();
+		allowed = hugetlb_total_pages() *
+			sysctl_overcommit_ratio[domain] / 100;
 
 		goto check;
 	}
@@ -328,13 +335,7 @@ int cap_vm_enough_memory(int domain, lon
 	if (domain != VM_AD_DEFAULT)
 		return 0;
 
-        /*
-	 * Sometimes we want to use more memory than we have
-	 */
-	if (sysctl_overcommit_memory == 1)
-		return 0;
-
-	if (sysctl_overcommit_memory == 0) {
+	if (sysctl_overcommit_memory[domain] == 0) {
 		unsigned long n;
 
 		free = get_page_cache_size();
@@ -372,7 +373,7 @@ int cap_vm_enough_memory(int domain, lon
 		return -ENOMEM;
 	}
 
-	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
+	allowed = totalram_pages * sysctl_overcommit_ratio[domain] / 100;
 	allowed += total_swap_pages;
 
 check:
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/dummy.c current/security/dummy.c
--- reference/security/dummy.c	2004-03-25 15:03:33.000000000 +0000
+++ current/security/dummy.c	2004-03-25 17:16:21.000000000 +0000
@@ -116,9 +116,16 @@ static int dummy_vm_enough_memory(int do
 
 	vm_acct_memory(domain, pages);
 
+        /*
+	 * Sometimes we want to use more memory than we have
+	 */
+	if (sysctl_overcommit_memory[domain] == 1)
+		return 0;
+
 	/* Check against the full compliment of hugepages, no reserve. */
 	if (domain == VM_AD_HUGETLB) {
-		allowed = hugetlb_total_pages();
+		allowed = hugetlb_total_pages() *
+			sysctl_overcommit_ratio[domain] / 100;
 
 		goto check;
 	}
@@ -129,13 +136,7 @@ static int dummy_vm_enough_memory(int do
 	if (domain != VM_AD_DEFAULT)
 		return 0;
 
-        /*
-	 * Sometimes we want to use more memory than we have
-	 */
-	if (sysctl_overcommit_memory == 1)
-		return 0;
-
-	if (sysctl_overcommit_memory == 0) {
+	if (sysctl_overcommit_memory[domain] == 0) {
 		free = get_page_cache_size();
 		free += nr_free_pages();
 		free += nr_swap_pages;
@@ -160,7 +161,7 @@ static int dummy_vm_enough_memory(int do
 		return -ENOMEM;
 	}
 
-	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
+	allowed = totalram_pages * sysctl_overcommit_ratio[domain] / 100;
 	allowed += total_swap_pages;
 
 check:
diff -X /home/apw/lib/vdiff.excl -rupN reference/security/selinux/hooks.c current/security/selinux/hooks.c
--- reference/security/selinux/hooks.c	2004-03-25 15:03:33.000000000 +0000
+++ current/security/selinux/hooks.c	2004-03-25 17:16:44.000000000 +0000
@@ -1505,9 +1505,16 @@ static int selinux_vm_enough_memory(int 
 
 	vm_acct_memory(domain, pages);
 
+        /*
+	 * Sometimes we want to use more memory than we have
+	 */
+	if (sysctl_overcommit_memory[domain] == 1)
+		return 0;
+
 	/* Check against the full compliment of hugepages, no reserve. */
 	if (domain == VM_AD_HUGETLB) {
-		allowed = hugetlb_total_pages();
+		allowed = hugetlb_total_pages() *
+			sysctl_overcommit_ratio[domain] / 100;
 
 		goto check;
 	}
@@ -1518,13 +1525,7 @@ static int selinux_vm_enough_memory(int 
 	if (domain != VM_AD_DEFAULT)
 		return 0;
 
-        /*
-	 * Sometimes we want to use more memory than we have
-	 */
-	if (sysctl_overcommit_memory == 1)
-		return 0;
-
-	if (sysctl_overcommit_memory == 0) {
+	if (sysctl_overcommit_memory[domain] == 0) {
 		free = get_page_cache_size();
 		free += nr_free_pages();
 		free += nr_swap_pages;
@@ -1558,7 +1559,7 @@ static int selinux_vm_enough_memory(int 
 		return -ENOMEM;
 	}
 
-	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
+	allowed = totalram_pages * sysctl_overcommit_ratio[domain] / 100;
 	allowed += total_swap_pages;
 
 check:


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbUDBOkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 09:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbUDBOkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 09:40:21 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:46272 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264067AbUDBOjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 09:39:36 -0500
Message-ID: <406D6F98.7A2A2B2D@nospam.org>
Date: Fri, 02 Apr 2004 15:50:16 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@BULL.NET
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Migrate pages - v0.2 - some demos
Content-Type: multipart/mixed;
 boundary="------------159DE7B42C413B347F4A75BC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------159DE7B42C413B347F4A75BC
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I include some demo programs:

test/ph.c:      migrates some of its pages by use of their physical addresses
test/v.c:       migrates a part of its virtual address range
test/vmig.c:    migrates a part of the virtual address range of "test/victim.c"
test/migstat.c: displays some internal counters if the kernel has been compiled
                with "_NEED_STATISTICS_" defined

They are not too much portable, many hard coded numbers,...

Zoltán Menyhárt
--------------159DE7B42C413B347F4A75BC
Content-Type: text/plain; charset=us-ascii;
 name="mig-demo-2004-apr-2"
Content-Disposition: inline;
 filename="mig-demo-2004-apr-2"
Content-Transfer-Encoding: 7bit

diff -Nur 2.4.6.ref/test/makefile 2.6.4.mig/test/makefile
--- 2.4.6.ref/test/makefile	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig/test/makefile	Fri Apr  2 13:36:00 2004
@@ -0,0 +1,3 @@
+CFLAGS+=-I../include/linux -I- -I../include
+
+all:	v ph migstat victim vmig
diff -Nur 2.4.6.ref/test/migstat.c 2.6.4.mig/test/migstat.c
--- 2.4.6.ref/test/migstat.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig/test/migstat.c	Fri Apr  2 13:37:19 2004
@@ -0,0 +1,128 @@
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
+	printf("pgd_scan:       %12ld  %10ld   %8ld\n", CONV(sp->t.pgd_scan));
+	printf("pgd_lock:       %12ld  %10ld   %8ld\n", CONV(sp->t.pgd_lock));
+	printf("pgd_unlock:     %12ld  %10ld   %8ld\n", CONV(sp->t.pgd_unlock));
+	printf("mmap_sem:       %12ld  %10ld   %8ld\n", CONV(sp->t.mmap_sem));
+	printf("pte_chain_lock: %12ld  %10ld   %8ld\n", CONV(sp->t.pte_chain_lock));
+	printf("find_vma:       %12ld  %10ld   %8ld\n", CONV(sp->t.find_vma));
+	printf("flush_tlb:      %12ld  %10ld   %8ld\n", CONV(sp->t.flush_tlb));
+	printf("add_lru:        %12ld  %10ld   %8ld\n", CONV(sp->t.add_lru));
+	printf("copy:           %12ld  %10ld   %8ld\n", CONV(sp->t.copy));
+	printf("upd_mmu_cache:  %12ld  %10ld   %8ld\n", CONV(sp->t.update_mmu_cache));
+	time = sp->t.total - sp->t.page_alloc - sp->t.page_free -
+		sp->t.page_lock - sp->t.page_unlock - sp->t.new_page_unlock -
+		sp->t.pgd_unlock - sp->t.mmap_sem -
+		sp->t.pgd_scan - sp->t.pgd_lock -
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
diff -Nur 2.4.6.ref/test/ph.c 2.6.4.mig/test/ph.c
--- 2.4.6.ref/test/ph.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig/test/ph.c	Fri Apr  2 13:37:27 2004
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
diff -Nur 2.4.6.ref/test/v.c 2.6.4.mig/test/v.c
--- 2.4.6.ref/test/v.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig/test/v.c	Fri Apr  2 13:37:38 2004
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
diff -Nur 2.4.6.ref/test/victim.c 2.6.4.mig/test/victim.c
--- 2.4.6.ref/test/victim.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig/test/victim.c	Wed Mar 24 17:19:37 2004
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
diff -Nur 2.4.6.ref/test/vmig.c 2.6.4.mig/test/vmig.c
--- 2.4.6.ref/test/vmig.c	Thu Jan  1 01:00:00 1970
+++ 2.6.4.mig/test/vmig.c	Fri Apr  2 13:37:56 2004
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

--------------159DE7B42C413B347F4A75BC--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTJCVpc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 17:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbTJCVpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 17:45:32 -0400
Received: from users.ccur.com ([208.248.32.211]:25173 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S261309AbTJCVp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 17:45:28 -0400
Date: Fri, 3 Oct 2003 17:44:12 -0400
From: Joe Korty <joe.korty@ccur.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, andrea@suse.de
Subject: mlockall and mmap of IO devices don't mix
Message-ID: <20031003214411.GA25802@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test6: the use of mlockall(2) in a process that has mmap(2)ed
the registers of an IO device will hang that process uninterruptibly.
The task runs in an infinite loop in get_user_pages(), invoking
follow_page() forever.

Using binary search I discovered that the problem was introduced
in 2.5.14, specifically in ChangeSetKey

    zippel@linux-m68k.org|ChangeSet|20020503210330|37095

The following patch backs out those lines of the above changeset
which are causing the problem:

--- a/mm/memory.c	2003-10-02 15:32:51.000000000 -0400
+++ b/mm/memory.c	2003-10-02 17:02:48.000000000 -0400
@@ -485,9 +485,7 @@
 	if (pte_present(pte)) {
 		if (!write ||
 		    (pte_write(pte) && pte_dirty(pte))) {
-			pfn = pte_pfn(pte);
-			if (pfn_valid(pfn))
-				return pfn_to_page(pfn);
+			return pte_page(pte);
 		}
 	}
 
The equivalent backout patch for 2.6.0-test6 is:

--- linux-2.6.0-test6/mm/memory.c.orig	2003-09-27 20:50:19.000000000 -0400
+++ linux-2.6.0-test6/mm/memory.c	2003-10-03 16:17:25.000000000 -0400
@@ -618,7 +618,6 @@
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *ptep, pte;
-	unsigned long pfn;
 	struct vm_area_struct *vma;
 
 	vma = hugepage_vma(mm, address);
@@ -645,13 +644,11 @@
 	pte_unmap(ptep);
 	if (pte_present(pte)) {
 		if (!write || (pte_write(pte) && pte_dirty(pte))) {
-			pfn = pte_pfn(pte);
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-
+			struct page *page = pte_page(pte);
+			if (pfn_valid(pte_pfn(pte))) {
 				mark_page_accessed(page);
-				return page;
 			}
+			return page;
 		}
 	}
 
I do not believe that the above constitutes a correct fix.  The
problem is that follow_pages() is fundamentally not able to handle a
mapping which does not have a 'struct page' backing it up, and a
mapping to IO memory by definition has no 'struct page' structure to
back it up.

IMO the original 2.5.14 patch which 'broke' the kernel is correct.
It made follow_page() return zero for a 'struct page' address, which
is entirely reasonable when a mapping has no 'struct page'.  Prior to
2.5.14 follow_page() would return some meaningless nonzero value
which, nevertheless, allowed its caller to continue and establish an
apparently correct mapping.

Joe

PS: my test program.  Nice and short.

/* test mlockall() in conjunction with mmap(2) of an IO device.
 * success -- program exits.
 * failure -- program hangs up, unkillable.
 */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>

int main(int argc, char **argv)
{
	int stat, fd;
	unsigned char *p;
	unsigned long off;

	if (argc > 1) {
		off = strtoul(argv[1], NULL, 16);
	} else {
		fprintf(stderr, "arg is video card addr in /dev/mem");
		exit(1);
	}

	stat = mlockall(MCL_CURRENT | MCL_FUTURE);
	if (stat == -1) {
		perror("mlockall");
		exit(1);
	}

	fd = open ("/dev/mem", O_RDWR, 0666);
	if (fd == -1) {
		perror("open");
		exit(1);
	}

	p = (unsigned char *)mmap(NULL, 0x4096,
		PROT_READ | PROT_WRITE, MAP_SHARED, fd, (off_t)off);
	if (!p) {
		perror("mmap");
		exit(1);
	}
	printf("[%08lx] %02x%02x%02x%02x\n",
		off, p[0], p[1], p[2], p[3]);
	return 0;
}

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVBWEdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVBWEdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 23:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVBWEdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 23:33:37 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:57058
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261154AbVBWEcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 23:32:22 -0500
Date: Tue, 22 Feb 2005 20:31:15 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: nickpiggin@yahoo.com.au, ak@suse.de, benh@kernel.crashing.org,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
Message-Id: <20050222203115.49f79f42.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>
References: <4214A1EC.4070102@yahoo.com.au>
	<4214A437.8050900@yahoo.com.au>
	<20050217194336.GA8314@wotan.suse.de>
	<1108680578.5665.14.camel@gaston>
	<20050217230342.GA3115@wotan.suse.de>
	<20050217153031.011f873f.davem@davemloft.net>
	<20050217235719.GB31591@wotan.suse.de>
	<4218840D.6030203@yahoo.com.au>
	<Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
	<421B0163.3050802@yahoo.com.au>
	<Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005 02:06:28 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> I've not seen Dave's bitmap walking functions (for clearing?),
> would they fit in better with my way?

This is what Nick is referring to:

--------------------

I hacked up something slightly different today.  I only
have it being used by clear_page_range() but it is extremely
effective.

Things like fork+exit latencies on my 750Mhz sparc64 box went
from ~490 microseconds to ~367 microseconds.  fork+execve
latency went down from ~1595 microseconds to ~1351 microseconds.

Two issues:

1) I'm not terribly satisfied with the interface.  I think
   with some improvements it can be applies to the two other
   routines this thing really makes sense for, namely copy_page_range
   and unmap_page_range

2) I don't think it will collapse well for 2-level page tables,
   someone take a look?

It's easy to toy with the sparc64 optimization on other platforms,
just add the necessary hacks to pmd_set and pgd_set, allocation
of pmd and pgd tables, use "PAGE_SHIFT - 5" instead of "PAGE_SHIFT - 6"
on 32-bit platforms, and then copy the asm-sparc64/pgwalk.h bits over
into your platforms asm-${ARCH}/pgwalk.h

I just got also reminded that we walk these damn pagetables completely
twice every exit, once to unmap the VMAs pte mappings, once again to
zap the page tables.  It might be fruitful to explore combining
those two steps, perhaps not.

Anyways, comments and improvment suggestions welcome.  Particularly
interesting would be if this thing helps a lot on other platforms
too, such as x86_64, ia64, alpha and ppc64.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/10 23:44:24-07:00 davem@nuts.davemloft.net 
#   [MM]: Add arch-overridable page table walking machinery.
#   
#   Currently very rudimentary but is used fully for
#   clear_page_range().  An optimized implementation
#   is there for sparc64 and it is extremely effective
#   particularly for 64-bit processes.
#   
#   For things like lat_fork and friends clear_page_tables()
#   use to be 2nd or 3rd in the kernel profile, now it has
#   dropped to the 20th or so entry.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# mm/memory.c
#   2004/08/10 23:42:42-07:00 davem@nuts.davemloft.net +10 -26
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-sparc64/pgtable.h
#   2004/08/10 23:42:42-07:00 davem@nuts.davemloft.net +28 -4
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-sparc64/pgalloc.h
#   2004/08/10 23:42:42-07:00 davem@nuts.davemloft.net +10 -2
#   [MM]: Add arch-overridable page table walking machinery.
# 
# arch/sparc64/mm/init.c
#   2004/08/10 23:42:42-07:00 davem@nuts.davemloft.net +2 -2
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-x86_64/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-v850/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-um/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-sparc64/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +114 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-sparc/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-sh64/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-sh/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-s390/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-ppc64/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-ppc/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-parisc/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-mips/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-m68knommu/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-m68k/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-ia64/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-i386/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-h8300/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-generic/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +96 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-cris/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-arm26/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-arm/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-x86_64/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-x86_64/pgwalk.h
# 
# include/asm-v850/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-v850/pgwalk.h
# 
# include/asm-um/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-um/pgwalk.h
# 
# include/asm-sparc64/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-sparc64/pgwalk.h
# 
# include/asm-sparc/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-sparc/pgwalk.h
# 
# include/asm-sh64/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-sh64/pgwalk.h
# 
# include/asm-sh/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-sh/pgwalk.h
# 
# include/asm-s390/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-s390/pgwalk.h
# 
# include/asm-ppc64/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-ppc64/pgwalk.h
# 
# include/asm-ppc/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-ppc/pgwalk.h
# 
# include/asm-parisc/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-parisc/pgwalk.h
# 
# include/asm-mips/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-mips/pgwalk.h
# 
# include/asm-m68knommu/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-m68knommu/pgwalk.h
# 
# include/asm-m68k/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-m68k/pgwalk.h
# 
# include/asm-ia64/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-ia64/pgwalk.h
# 
# include/asm-i386/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-i386/pgwalk.h
# 
# include/asm-h8300/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-h8300/pgwalk.h
# 
# include/asm-generic/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-generic/pgwalk.h
# 
# include/asm-cris/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-cris/pgwalk.h
# 
# include/asm-arm26/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-arm26/pgwalk.h
# 
# include/asm-arm/pgwalk.h
#   2004/08/10 23:42:14-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-arm/pgwalk.h
# 
# include/asm-alpha/pgwalk.h
#   2004/08/10 23:42:13-07:00 davem@nuts.davemloft.net +6 -0
#   [MM]: Add arch-overridable page table walking machinery.
# 
# include/asm-alpha/pgwalk.h
#   2004/08/10 23:42:13-07:00 davem@nuts.davemloft.net +0 -0
#   BitKeeper file /disk1/BK/sparc-2.6/include/asm-alpha/pgwalk.h
# 
diff -Nru a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
--- a/arch/sparc64/mm/init.c	2004-08-10 23:44:47 -07:00
+++ b/arch/sparc64/mm/init.c	2004-08-10 23:44:47 -07:00
@@ -419,7 +419,7 @@
 					if (ptep == NULL)
 						early_pgtable_allocfail("pte");
 					memset(ptep, 0, BASE_PAGE_SIZE);
-					pmd_set(pmdp, ptep);
+					pmd_set_k(pmdp, ptep);
 				}
 				ptep = (pte_t *)__pmd_page(*pmdp) +
 						((vaddr >> 13) & 0x3ff);
@@ -1455,7 +1455,7 @@
 	memset(swapper_pmd_dir, 0, sizeof(swapper_pmd_dir));
 
 	/* Now can init the kernel/bad page tables. */
-	pgd_set(&swapper_pg_dir[0], swapper_pmd_dir + (shift / sizeof(pgd_t)));
+	pgd_set_k(&swapper_pg_dir[0], swapper_pmd_dir + (shift / sizeof(pgd_t)));
 	
 	sparc64_vpte_patchme1[0] |=
 		(((unsigned long)pgd_val(init_mm.pgd[0])) >> 10);
diff -Nru a/include/asm-alpha/pgwalk.h b/include/asm-alpha/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-alpha/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _ALPHA_PGWALK_H
+#define _ALPHA_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _ALPHA_PGWALK_H */
diff -Nru a/include/asm-arm/pgwalk.h b/include/asm-arm/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-arm/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _ARM_PGWALK_H
+#define _ARM_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _ARM_PGWALK_H */
diff -Nru a/include/asm-arm26/pgwalk.h b/include/asm-arm26/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-arm26/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _ARM26_PGWALK_H
+#define _ARM26_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _ARM26_PGWALK_H */
diff -Nru a/include/asm-cris/pgwalk.h b/include/asm-cris/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-cris/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _CRIS_PGWALK_H
+#define _CRIS_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _CRIS_PGWALK_H */
diff -Nru a/include/asm-generic/pgwalk.h b/include/asm-generic/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-generic/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,96 @@
+#ifndef _GENERIC_PGWALK_H
+#define _GENERIC_PGWALK_H
+
+#include <linux/mm.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+struct pte_walk_state;
+typedef void (*pgd_work_func_t)(struct pte_walk_state *, pgd_t *);
+typedef void (*pmd_work_func_t)(struct pte_walk_state *, pmd_t *);
+typedef void (*pte_work_func_t)(struct pte_walk_state *, pte_t *);
+
+struct pte_walk_state {
+	void *_client_state;
+	void *first;
+	void *last;
+};
+
+static inline void *pte_walk_client_state(struct pte_walk_state *walk)
+{
+	return walk->_client_state;
+}
+
+static inline void pte_walk_init(struct pte_walk_state *walk, pte_t *first, pte_t *last)
+{
+	walk->first = first;
+	walk->last = last;
+}
+
+static inline void pte_walk(struct pte_walk_state *walk, pte_work_func_t pte_work)
+{
+	pte_t *ptep = walk->first;
+	pte_t *last = walk->last;
+
+	do {
+		if (pte_none(*ptep))
+			goto next;
+		pte_work(walk, ptep);
+	next:
+		ptep++;
+	} while (ptep < last);
+}
+
+static inline void pmd_walk_init(struct pte_walk_state *walk, pmd_t *first, pmd_t *last)
+{
+	walk->first = first;
+	walk->last = last;
+}
+
+static inline void pmd_walk(struct pte_walk_state *walk, pmd_work_func_t pmd_work)
+{
+	pmd_t *page_dir = walk->first;
+	pmd_t *last = walk->last;
+
+	do {
+		if (pmd_none(*page_dir))
+			goto next;
+		if (unlikely(pmd_bad(*page_dir))) {
+			pmd_ERROR(*page_dir);
+			pmd_clear(page_dir);
+			goto next;
+		}
+		pmd_work(walk, page_dir);
+	next:
+		page_dir++;
+	} while (page_dir < last);
+}
+
+static inline void pgd_walk_init(struct pte_walk_state *walk, void *client_state, pgd_t *first, pgd_t *last)
+{
+	walk->_client_state = client_state;
+	walk->first = first;
+	walk->last = last;
+}
+
+static inline void pgd_walk(struct pte_walk_state *walk, pgd_work_func_t pgd_work)
+{
+	pgd_t *page_dir = walk->first;
+	pgd_t *last = walk->last;
+
+	do {
+		if (pgd_none(*page_dir))
+			goto next;
+		if (unlikely(pgd_bad(*page_dir))) {
+			pgd_ERROR(page_dir);
+			pgd_clear(page_dir);
+			goto next;
+		}
+		pgd_work(walk, page_dir);
+	next:
+		page_dir++;
+	} while (page_dir < last);
+}
+
+#endif /* _GENERIC_PGWALK_H */
diff -Nru a/include/asm-h8300/pgwalk.h b/include/asm-h8300/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-h8300/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _H8300_PGWALK_H
+#define _H8300_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _H8300_PGWALK_H */
diff -Nru a/include/asm-i386/pgwalk.h b/include/asm-i386/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-i386/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _I386_PGWALK_H
+#define _I386_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _I386_PGWALK_H */
diff -Nru a/include/asm-ia64/pgwalk.h b/include/asm-ia64/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ia64/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _IA64_PGWALK_H
+#define _IA64_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _IA64_PGWALK_H */
diff -Nru a/include/asm-m68k/pgwalk.h b/include/asm-m68k/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-m68k/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _M68K_PGWALK_H
+#define _M68K_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _M68K_PGWALK_H */
diff -Nru a/include/asm-m68knommu/pgwalk.h b/include/asm-m68knommu/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-m68knommu/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _M68KNOMMU_PGWALK_H
+#define _M68KNOMMU_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _M68KNOMMU_PGWALK_H */
diff -Nru a/include/asm-mips/pgwalk.h b/include/asm-mips/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-mips/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _ALPHA_PGWALK_H
+#define _ALPHA_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _ALPHA_PGWALK_H */
diff -Nru a/include/asm-parisc/pgwalk.h b/include/asm-parisc/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-parisc/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _PARISC_PGWALK_H
+#define _PARISC_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _PARISC_PGWALK_H */
diff -Nru a/include/asm-ppc/pgwalk.h b/include/asm-ppc/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ppc/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _PPC_PGWALK_H
+#define _PPC_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _PPC_PGWALK_H */
diff -Nru a/include/asm-ppc64/pgwalk.h b/include/asm-ppc64/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ppc64/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _PPC64_PGWALK_H
+#define _PPC64_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _PPC64_PGWALK_H */
diff -Nru a/include/asm-s390/pgwalk.h b/include/asm-s390/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-s390/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _S390_PGWALK_H
+#define _S390_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _S390_PGWALK_H */
diff -Nru a/include/asm-sh/pgwalk.h b/include/asm-sh/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-sh/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _SH_PGWALK_H
+#define _SH_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _SH_PGWALK_H */
diff -Nru a/include/asm-sh64/pgwalk.h b/include/asm-sh64/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-sh64/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _SH64_PGWALK_H
+#define _SH64_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _SH64_PGWALK_H */
diff -Nru a/include/asm-sparc/pgwalk.h b/include/asm-sparc/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-sparc/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _SPARC_PGWALK_H
+#define _SPARC_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _SPARC_PGWALK_H */
diff -Nru a/include/asm-sparc64/pgalloc.h b/include/asm-sparc64/pgalloc.h
--- a/include/asm-sparc64/pgalloc.h	2004-08-10 23:44:47 -07:00
+++ b/include/asm-sparc64/pgalloc.h	2004-08-10 23:44:47 -07:00
@@ -93,6 +93,8 @@
 
 static __inline__ void free_pgd_fast(pgd_t *pgd)
 {
+	virt_to_page(pgd)->index = 0UL;
+
 	preempt_disable();
 	*(unsigned long *)pgd = (unsigned long) pgd_quicklist;
 	pgd_quicklist = (unsigned long *) pgd;
@@ -113,8 +115,10 @@
 	} else {
 		preempt_enable();
 		ret = (unsigned long *) __get_free_page(GFP_KERNEL|__GFP_REPEAT);
-		if(ret)
+		if (ret) {
 			memset(ret, 0, PAGE_SIZE);
+			virt_to_page(ret)->index = 0UL;
+		}
 	}
 	return (pgd_t *)ret;
 }
@@ -162,8 +166,10 @@
 	pmd = pmd_alloc_one_fast(mm, address);
 	if (!pmd) {
 		pmd = (pmd_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-		if (pmd)
+		if (pmd) {
 			memset(pmd, 0, PAGE_SIZE);
+			virt_to_page(pmd)->index = 0UL;
+		}
 	}
 	return pmd;
 }
@@ -171,6 +177,8 @@
 static __inline__ void free_pmd_fast(pmd_t *pmd)
 {
 	unsigned long color = DCACHE_COLOR((unsigned long)pmd);
+
+	virt_to_page(pmd)->index = 0UL;
 
 	preempt_disable();
 	*(unsigned long *)pmd = (unsigned long) pte_quicklist[color];
diff -Nru a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
--- a/include/asm-sparc64/pgtable.h	2004-08-10 23:44:47 -07:00
+++ b/include/asm-sparc64/pgtable.h	2004-08-10 23:44:47 -07:00
@@ -259,10 +259,34 @@
 
 	return __pte;
 }
-#define pmd_set(pmdp, ptep)	\
-	(pmd_val(*(pmdp)) = (__pa((unsigned long) (ptep)) >> 11UL))
-#define pgd_set(pgdp, pmdp)	\
-	(pgd_val(*(pgdp)) = (__pa((unsigned long) (pmdp)) >> 11UL))
+
+#define PGTABLE_BIT_SHIFT	(PAGE_SHIFT - 6)
+#define PGTABLE_BIT_MASK	((1UL << PGTABLE_BIT_SHIFT) - 1)
+#define PGTABLE_BIT_REGION	(1UL << PGTABLE_BIT_SHIFT)
+#define PGTABLE_BIT(ptr) \
+	(1UL << (((unsigned long)(ptr) & ~PAGE_MASK) >> PGTABLE_BIT_SHIFT))
+#define __PGTABLE_REGION_NEXT(ptr,type) \
+	((type *)(((unsigned long)(ptr) + PGTABLE_BIT_REGION) & \
+		  ~PGTABLE_BIT_MASK))
+#define PMD_REGION_NEXT(pmdp) __PGTABLE_REGION_NEXT(pmdp,pmd_t)
+#define PGD_REGION_NEXT(pgdp) __PGTABLE_REGION_NEXT(pgdp,pgd_t)
+
+#define pmd_set(pmdp, ptep) \
+do { \
+	virt_to_page(pmdp)->index |= PGTABLE_BIT(pmdp); \
+	pmd_val(*pmdp) = __pa((unsigned long) (ptep)) >> 11UL; \
+} while (0)
+#define pmd_set_k(pmdp, ptep) \
+	(pmd_val(*pmdp) = __pa((unsigned long) (ptep)) >> 11UL)
+
+#define pgd_set(pgdp, pmdp) \
+do { \
+	virt_to_page(pgdp)->index |= PGTABLE_BIT(pgdp); \
+	pgd_val(*pgdp) = __pa((unsigned long) (pmdp)) >> 11UL; \
+} while (0)
+#define pgd_set_k(pgdp, pmdp) \
+	(pgd_val(*pgdp) = __pa((unsigned long) (pmdp)) >> 11UL)
+
 #define __pmd_page(pmd)		\
 	((unsigned long) __va((((unsigned long)pmd_val(pmd))<<11UL)))
 #define pmd_page(pmd) 			virt_to_page((void *)__pmd_page(pmd))
diff -Nru a/include/asm-sparc64/pgwalk.h b/include/asm-sparc64/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-sparc64/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,114 @@
+/* pgwalk.h: UltraSPARC fast page table traversal.
+ *
+ * Copyright 2004 David S. Miller <davem@redhat.com>
+ */
+
+#ifndef _SPARC64_PGWALK_H
+#define _SPARC64_PGWALK_H
+
+#include <linux/mm.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+struct pte_walk_state;
+typedef void (*pgd_work_func_t)(struct pte_walk_state *, pgd_t *);
+typedef void (*pmd_work_func_t)(struct pte_walk_state *, pmd_t *);
+typedef void (*pte_work_func_t)(struct pte_walk_state *, pte_t *);
+
+struct pte_walk_state {
+	void *_client_state;
+	void *first;
+	void *last;
+};
+
+static inline void *pte_walk_client_state(struct pte_walk_state *walk)
+{
+	return walk->_client_state;
+}
+
+static inline void pte_walk_init(struct pte_walk_state *walk, pte_t *first, pte_t *last)
+{
+	walk->first = first;
+	walk->last = last;
+}
+
+static inline void pte_walk(struct pte_walk_state *walk, pte_work_func_t pte_work)
+{
+	pte_t *ptep = walk->first;
+	pte_t *last = walk->last;
+
+	do {
+		if (pte_none(*ptep))
+			goto next;
+		pte_work(walk, ptep);
+	next:
+		ptep++;
+	} while (ptep < last);
+}
+
+static inline void pmd_walk_init(struct pte_walk_state *walk, pmd_t *first, pmd_t *last)
+{
+	walk->first = first;
+	walk->last = last;
+}
+
+static inline void pmd_walk(struct pte_walk_state *walk, pmd_work_func_t pmd_work)
+{
+	pmd_t *page_dir = walk->first;
+	pmd_t *last = walk->last;
+	unsigned long mask;
+
+	mask = virt_to_page(page_dir)->index;
+
+	do {
+		if (likely(!(PGTABLE_BIT(page_dir) & mask))) {
+			page_dir = PMD_REGION_NEXT(page_dir);
+			continue;
+		}
+		if (pmd_none(*page_dir))
+			goto next;
+		if (unlikely(pmd_bad(*page_dir))) {
+			pmd_ERROR(*page_dir);
+			pmd_clear(page_dir);
+			goto next;
+		}
+		pmd_work(walk, page_dir);
+	next:
+		page_dir++;
+	} while (page_dir < last);
+}
+
+static inline void pgd_walk_init(struct pte_walk_state *walk, void *client_state, pgd_t *first, pgd_t *last)
+{
+	walk->_client_state = client_state;
+	walk->first = first;
+	walk->last = last;
+}
+
+static inline void pgd_walk(struct pte_walk_state *walk, pgd_work_func_t pgd_work)
+{
+	pgd_t *page_dir = walk->first;
+	pgd_t *last = walk->last;
+	unsigned long mask;
+
+	mask = virt_to_page(page_dir)->index;
+
+	do {
+		if (likely(!(PGTABLE_BIT(page_dir) & mask))) {
+			page_dir = PGD_REGION_NEXT(page_dir);
+			continue;
+		}
+		if (pgd_none(*page_dir))
+			goto next;
+		if (unlikely(pgd_bad(*page_dir))) {
+			pgd_ERROR(page_dir);
+			pgd_clear(page_dir);
+			goto next;
+		}
+		pgd_work(walk, page_dir);
+	next:
+		page_dir++;
+	} while (page_dir < last);
+}
+#endif /* _SPARC64_PGWALK_H */
diff -Nru a/include/asm-um/pgwalk.h b/include/asm-um/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-um/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _UM_PGWALK_H
+#define _UM_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _UM_PGWALK_H */
diff -Nru a/include/asm-v850/pgwalk.h b/include/asm-v850/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-v850/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _V850_PGWALK_H
+#define _V850_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _V850_PGWALK_H */
diff -Nru a/include/asm-x86_64/pgwalk.h b/include/asm-x86_64/pgwalk.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-x86_64/pgwalk.h	2004-08-10 23:44:47 -07:00
@@ -0,0 +1,6 @@
+#ifndef _X86_64_PGWALK_H
+#define _X86_64_PGWALK_H
+
+#include <asm-generic/pgwalk.h>
+
+#endif /* _X86_64_PGWALK_H */
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	2004-08-10 23:44:47 -07:00
+++ b/mm/memory.c	2004-08-10 23:44:47 -07:00
@@ -52,6 +52,7 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
+#include <asm/pgwalk.h>
 
 #include <linux/swapops.h>
 #include <linux/elf.h>
@@ -100,40 +101,25 @@
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static inline void free_one_pmd(struct mmu_gather *tlb, pmd_t * dir)
+static void free_one_pmd(struct pte_walk_state *walk, pmd_t *dir)
 {
 	struct page *page;
 
-	if (pmd_none(*dir))
-		return;
-	if (unlikely(pmd_bad(*dir))) {
-		pmd_ERROR(*dir);
-		pmd_clear(dir);
-		return;
-	}
 	page = pmd_page(*dir);
 	pmd_clear(dir);
 	dec_page_state(nr_page_table_pages);
-	pte_free_tlb(tlb, page);
+	pte_free_tlb(pte_walk_client_state(walk), page);
 }
 
-static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * dir)
+static void free_one_pgd(struct pte_walk_state *walk, pgd_t *dir)
 {
-	int j;
 	pmd_t * pmd;
 
-	if (pgd_none(*dir))
-		return;
-	if (unlikely(pgd_bad(*dir))) {
-		pgd_ERROR(*dir);
-		pgd_clear(dir);
-		return;
-	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++)
-		free_one_pmd(tlb, pmd+j);
-	pmd_free_tlb(tlb, pmd);
+	pmd_walk_init(walk, pmd, pmd + PTRS_PER_PMD);
+	pmd_walk(walk, free_one_pmd);
+	pmd_free_tlb(pte_walk_client_state(tlb), pmd);
 }
 
 /*
@@ -144,13 +130,11 @@
  */
 void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr)
 {
+	struct pte_walk_state walk;
 	pgd_t * page_dir = tlb->mm->pgd;
 
-	page_dir += first;
-	do {
-		free_one_pgd(tlb, page_dir);
-		page_dir++;
-	} while (--nr);
+	pgd_walk_init(&walk, tlb, page_dir, page_dir + nr);
+	pgd_walk(&walk, free_one_pgd);
 }
 
 pte_t fastcall * pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address)

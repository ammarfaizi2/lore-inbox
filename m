Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUHONvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUHONvq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 09:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUHONvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 09:51:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:48772 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265354AbUHONu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 09:50:58 -0400
Date: Sun, 15 Aug 2004 06:50:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: linux-ia64@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: page fault fastpath: Increasing SMP scalability by introducing pte
 locks?
Message-ID: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well this is more an idea than a real patch yet. The page_table_lock
becomes a bottleneck if more than 4 CPUs are rapidly allocating and using
memory. "pft" is a program that measures the performance of page faults on
SMP system. It allocates memory simultaneously in multiple threads thereby
causing lots of page faults for anonymous pages.

Results for a standard 2.6.8.1 kernel. Allocating 2G of RAM in an 8
processor SMP system:

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  2   3    1    0.094s      4.500s   4.059s 85561.646  85568.398
  2   3    2    0.092s      6.390s   3.043s 60649.650 114521.474
  2   3    4    0.081s      6.500s   1.093s 59740.813 203552.963
  2   3    8    0.101s     12.001s   2.035s 32487.736 167082.560

Scalablity problems set in over 4 CPUs.

With pte locks and the fastpath:

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  2   3    1    0.071s      4.535s   4.061s 85362.102  85288.646
  2   3    2    0.073s      4.793s   2.013s 80789.137 184196.199
  2   3    4    0.087s      5.119s   1.057s 75516.326 249716.547
  2   3    8    0.096s      7.089s   1.019s 54715.728 328540.988

The performance in SMP situation is significantly enhanced with this
patch.

Note that the patch does not address various race conditions that may
result from using a pte lock only in handle_mm_fault. Some rules
need to be develop how to coordinate pte locks and the page_table_lock in
order to avoid these.

pte locks are realized by finding a spare bit in the ptes (TLB structures
on IA64 and i386) and settings the bit atomically via bitops for locking.
The fastpath does not allocate the page_table_lock but instead immediately
locks the pte. Thus the logic to release and later reacquire the
page_table_lock is avoided. Multiple page faults can run concurrently
using pte locks avoiding the page_table_lock. Essentially pte locks would
allow a finer granularity of locking.

I would like to get some feedback if people feel that this is the right
way to solve the issue. Most of this is based on work of Ray
Bryant and others at SGI.

Attached are:
1. pte lock patch for i386 and ia64
2. page_fault fastpath
3. page fault test program
4. test script

=========== PTE LOCK PATCH

Index: linux-2.6.8-rc4/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.8-rc4.orig/include/asm-generic/pgtable.h	2004-08-09 19:22:39.000000000 -0700
+++ linux-2.6.8-rc4/include/asm-generic/pgtable.h	2004-08-13 10:05:36.000000000 -0700
@@ -126,4 +126,11 @@
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif

+#ifndef __HAVE_ARCH_PTE_LOCK
+/* need to fall back to the mm spinlock if PTE locks are not supported */
+#define ptep_lock(ptep)		!spin_trylock(&mm->page_table_lock)
+#define ptep_unlock(ptep)	spin_unlock(&mm->page_table_lock)
+#define pte_locked(pte)		spin_is_locked(&mm->page_table_lock)
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
Index: linux-2.6.8-rc4/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.8-rc4.orig/include/asm-ia64/pgtable.h	2004-08-09 19:22:39.000000000 -0700
+++ linux-2.6.8-rc4/include/asm-ia64/pgtable.h	2004-08-13 10:19:15.000000000 -0700
@@ -30,6 +30,8 @@
 #define _PAGE_P_BIT		0
 #define _PAGE_A_BIT		5
 #define _PAGE_D_BIT		6
+#define _PAGE_IG_BITS		53
+#define _PAGE_LOCK_BIT		(_PAGE_IG_BITS+3)	/* bit 56. Aligned to 8 bits */

 #define _PAGE_P			(1 << _PAGE_P_BIT)	/* page present bit */
 #define _PAGE_MA_WB		(0x0 <<  2)	/* write back memory attribute */
@@ -58,6 +60,7 @@
 #define _PAGE_PPN_MASK		(((__IA64_UL(1) << IA64_MAX_PHYS_BITS) - 1) & ~0xfffUL)
 #define _PAGE_ED		(__IA64_UL(1) << 52)	/* exception deferral */
 #define _PAGE_PROTNONE		(__IA64_UL(1) << 63)
+#define _PAGE_LOCK		(__IA64_UL(1) << _PAGE_LOCK_BIT)

 /* Valid only for a PTE with the present bit cleared: */
 #define _PAGE_FILE		(1 << 1)		/* see swap & file pte remarks below */
@@ -282,6 +285,13 @@
 #define pte_mkclean(pte)	(__pte(pte_val(pte) & ~_PAGE_D))
 #define pte_mkdirty(pte)	(__pte(pte_val(pte) | _PAGE_D))

+/*
+ * Lock functions for pte's
+*/
+#define ptep_lock(ptep)		test_and_set_bit(_PAGE_LOCK_BIT,ptep)
+#define ptep_unlock(ptep)	{ clear_bit(_PAGE_LOCK_BIT,ptep);smp_mb__after_clear_bit(); }
+#define pte_locked(pte)		((pte_val(pte) & _PAGE_LOCK)!=0)
+
 /*
  * Macro to a page protection value as "uncacheable".  Note that "protection" is really a
  * misnomer here as the protection value contains the memory attribute bits, dirty bits,
@@ -558,6 +568,7 @@
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
 #define __HAVE_ARCH_PGD_OFFSET_GATE
+#define __HAVE_ARCH_PTE_LOCK
 #include <asm-generic/pgtable.h>

 #endif /* _ASM_IA64_PGTABLE_H */
Index: linux-2.6.8-rc4/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.8-rc4.orig/include/asm-i386/pgtable.h	2004-08-09 19:23:35.000000000 -0700
+++ linux-2.6.8-rc4/include/asm-i386/pgtable.h	2004-08-13 10:04:19.000000000 -0700
@@ -101,7 +101,7 @@
 #define _PAGE_BIT_DIRTY		6
 #define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_BIT_GLOBAL	8	/* Global TLB entry PPro+ */
-#define _PAGE_BIT_UNUSED1	9	/* available for programmer */
+#define _PAGE_BIT_LOCK		9	/* available for programmer */
 #define _PAGE_BIT_UNUSED2	10
 #define _PAGE_BIT_UNUSED3	11
 #define _PAGE_BIT_NX		63
@@ -115,7 +115,7 @@
 #define _PAGE_DIRTY	0x040
 #define _PAGE_PSE	0x080	/* 4 MB (or 2MB) page, Pentium+, if present.. */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry PPro+ */
-#define _PAGE_UNUSED1	0x200	/* available for programmer */
+#define _PAGE_LOCK	0x200	/* available for programmer */
 #define _PAGE_UNUSED2	0x400
 #define _PAGE_UNUSED3	0x800

@@ -260,6 +260,10 @@
 static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, &ptep->pte_low); }
 static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }

+#define ptep_lock(ptep) test_and_set_bit(_PAGE_BIT_LOCK,&ptep->pte_low)
+#define ptep_unlock(ptep) clear_bit(_PAGE_BIT_LOCK,&ptep->pte_low)
+#define pte_locked(pte) ((ptep->pte_low & _PAGE_LOCK) !=0)
+
 /*
  * Macro to mark a page protection value as "uncacheable".  On processors which do not support
  * it, this is a no-op.
@@ -419,6 +423,7 @@
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTEP_MKDIRTY
 #define __HAVE_ARCH_PTE_SAME
+#define __HAVE_ARCH_PTE_LOCK
 #include <asm-generic/pgtable.h>

 #endif /* _I386_PGTABLE_H */

======= PAGEFAULT FASTPATH
Index: linux-2.6.8-rc4/mm/memory.c
===================================================================
--- linux-2.6.8-rc4.orig/mm/memory.c	2004-08-09 19:23:02.000000000 -0700
+++ linux-2.6.8-rc4/mm/memory.c	2004-08-13 10:19:21.000000000 -0700
@@ -1680,6 +1680,10 @@
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
+#ifdef __HAVE_ARCH_PTE_LOCK
+	pte_t *pte;
+	pte_t entry;
+#endif

 	__set_current_state(TASK_RUNNING);
 	pgd = pgd_offset(mm, address);
@@ -1688,7 +1692,64 @@

 	if (is_vm_hugetlb_page(vma))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+#ifdef __HAVE_ARCH_PTE_LOCK
+	/*
+	 * Fast path for anonymous pages, not found faults bypassing
+	 * the necessity to acquire the page_table_lock
+	 */
+
+	if ((vma->vm_ops && vma->vm_ops->nopage) || pgd_none(*pgd)) goto use_page_table_lock;
+	pmd = pmd_offset(pgd,address);
+	if (pmd_none(*pmd)) goto use_page_table_lock;
+	pte = pte_offset_kernel(pmd,address);
+	if (pte_locked(*pte)) return VM_FAULT_MINOR;
+	if (!pte_none(*pte)) goto use_page_table_lock;
+
+	/*
+	 * Page not present, so kswapd and PTE updates will not touch the pte
+	 * so we are able to just use a pte lock.
+	 */
+
+	if (ptep_lock(pte)) return VM_FAULT_MINOR;
+		/*
+		 * PTE already locked so this code is already running on another processor. Wait
+		 * until that processor does our work and then return. If something went
+		 * wrong in the handling of the other processor then we will get another page fault
+		 * that may then handle the error condition
+		 */
+
+	/* Read-only mapping of ZERO_PAGE. */
+	entry = pte_wrprotect(mk_pte(ZERO_PAGE(address), vma->vm_page_prot));
+
+	if (write_access) {
+		struct page *page;
+
+		if (unlikely(anon_vma_prepare(vma))) goto no_mem;
+
+		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+		if (!page)  goto no_mem;
+		clear_user_highpage(page, address);
+
+		mm->rss++;
+		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,vma->vm_page_prot)),vma);
+		lru_cache_add_active(page);
+		mark_page_accessed(page);
+		page_add_anon_rmap(page, vma, address);
+	}
+	/* Setting the pte clears the pte lock so there is no need for unlocking */
+	set_pte(pte, entry);
+	pte_unmap(pte);
+
+	/* No need to invalidate - it was non-present before */
+	update_mmu_cache(vma, address, entry);
+	return VM_FAULT_MINOR;		/* Minor fault */

+no_mem:
+	ptep_unlock(pte);
+	return VM_FAULT_OOM;
+
+use_page_table_lock:
+#endif
 	/*
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.

======= PFT.C test program
#include <pthread.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <sys/mman.h>
#include <time.h>
#include <errno.h>
#include <sys/resource.h>

extern int      optind, opterr;
extern char     *optarg;

long     bytes=16384;
long     sleepsec=0;
long     verbose=0;
long     forkcnt=1;
long     repeatcount=1;
long     do_bzero=0;
long     mypid;
int 	title=0;

volatile int    go, state[128];

struct timespec wall;
struct rusage ruse;
long faults;
long pages;
long gbyte;
double faults_per_sec;
double faults_per_sec_per_cpu;

#define perrorx(s)      (perror(s), exit(1))
#define NBPP            16384

void* test(void*);
void  launch(void);


main (int argc, char *argv[])
{
        int                     i, j, c, stat, er=0;
        static  char            optstr[] = "b:f:g:r:s:vzHt";


        opterr=1;
        while ((c = getopt(argc, argv, optstr)) != EOF)
                switch (c) {
                case 'g':
                        bytes = atol(optarg)*1024*1024*1024;
                        break;
                case 'b':
                        bytes = atol(optarg);
                        break;
                case 'f':
                        forkcnt = atol(optarg);
                        break;
                case 'r':
                        repeatcount = atol(optarg);
                        break;
                case 's':
                        sleepsec = atol(optarg);
                        break;
                case 'v':
                        verbose++;
                        break;
                case 'z':
                        do_bzero++;
                        break;
                case 'H':
                        er++;
                        break;
		case 't' :
			title++;
			break;
                case '?':
                        er = 1;
                        break;
                }

        if (er) {
                printf("usage: %s %s\n", argv[0], optstr);
                exit(1);
        }

	pages = bytes*repeatcount/getpagesize();
	gbyte = bytes/(1024*1024*1024);
	bytes = bytes/forkcnt;

	if (verbose) printf("Calculated pages=%ld pagesize=%ld.\n",pages,getpagesize());

        mypid = getpid();
        setpgid(0, mypid);

        for (i=0; i<repeatcount; i++) {
                if (fork() == 0)
                        launch();
                while (wait(&stat) > 0);
        }

	getrusage(RUSAGE_CHILDREN,&ruse);
	clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&wall);
	if (verbose) printf("Calculated faults=%ld. Real minor faults=%ld, major faults=%ld\n",pages,ruse.ru_minflt+ruse.ru_majflt);
	faults_per_sec=(double) pages / ((double) wall.tv_sec + (double) wall.tv_nsec / 1000000000.0);
	faults_per_sec_per_cpu=(double) pages /  (
		(double) (ruse.ru_utime.tv_sec + ruse.ru_stime.tv_sec) + ((double) (ruse.ru_utime.tv_usec + ruse.ru_stime.tv_usec) / 1000000.0));
	if (title) printf(" Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec\n");
	printf("%3ld %3ld %4ld %4ld.%03lds%7ld.%03lds%4ld.%03lds%10.3f %10.3f\n",
		gbyte,repeatcount,forkcnt,
		ruse.ru_utime.tv_sec,ruse.ru_utime.tv_usec/1000,
		ruse.ru_stime.tv_sec,ruse.ru_stime.tv_usec/1000,
		wall.tv_sec,wall.tv_nsec/10000000,
		faults_per_sec_per_cpu,faults_per_sec);
        exit(0);
}

char *
do_shm(long shmlen) {
        char    *p;
        int     shmid;

        printf ("Try to allocate TOTAL shm segment of %ld bytes\n", shmlen);

        if ((shmid = shmget(IPC_PRIVATE, shmlen, SHM_R|SHM_W))  == -1)
                perrorx("shmget faiiled");

        p=(char*)shmat(shmid, (void*)0, SHM_R|SHM_W);
	printf("  created, adr: 0x%lx\n", (long)p);
	printf("  attached\n");
        bzero(p, shmlen);
	printf("  zeroed\n");

        // if (shmctl(shmid,IPC_RMID,0) == -1)
        //        perrorx("shmctl failed");
	// printf("  deleted\n");

	return p;


}

void
launch()
{
        pthread_t                       ptid[128];
        int     i, j;

        for (j=0; j<forkcnt; j++)
                if (pthread_create(&ptid[j], NULL, test, (void*) (long)j) < 0)
                        perrorx("pthread create");

        if(0) for (j=0; j<forkcnt; j++)
                while(state[j] == 0);
        go = 1;
        if(0) for (j=0; j<forkcnt; j++)
                while(state[j] == 1);
        for (j=0; j<forkcnt; j++)
                pthread_join(ptid[j], NULL);
        exit(0);
}

void*
test(void *arg)
{
        char    *p, *pe;
        long    id;

        id = (long) arg;
        state[id] = 1;
        while(!go);
        p = malloc(bytes);
        // p = do_shm(bytes);
	if (p == 0) {
	    printf("malloc of %Ld bytes failed.\n",bytes);
	    exit;
	} else
	    if (verbose) printf("malloc of %Ld bytes succeeded\n",bytes);
        if (do_bzero)
                bzero(p, bytes);
        else {
                for(pe=p+bytes; p<pe; p+=16384)
                        *p = 'r';
        }
        sleep(sleepsec);
        state[id] = 2;
        pthread_exit(0);
}

===== Test script

./pft -t -g2 -r3 -f1
./pft -g2 -r3 -f2
./pft -g2 -r3 -f4
./pft -g2 -r3 -f8


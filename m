Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVCVVd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVCVVd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVCVVd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:33:29 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:11907
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262004AbVCVV36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:29:58 -0500
Date: Tue, 22 Mar 2005 13:28:18 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322132818.4bf6c8a6.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050322034053.311b10e6.akpm@osdl.org>
	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
	<20050322110144.3a3002d9.davem@davemloft.net>
	<20050322112125.0330c4ee.davem@davemloft.net>
	<20050322112329.70bde057.davem@davemloft.net>
	<Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__22_Mar_2005_13_28_18_-0800_GmTpW9wxXbmzOtmE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__22_Mar_2005_13_28_18_-0800_GmTpW9wxXbmzOtmE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hugh, I got tired of rebooting just to get address walking
traces :-)  So I wrote a little simulator.

Basically, it's free_pgtables() with the page table pointer
stuff ripped out.

You run it like this:

./simulator vma_file

Where vma_file is a text file composed of lines of the form:

START END

in hex.  The ordered list of VMA's is built from this text file.
I enclose a sample file I took from  that trace I built earlier
today.

If you want to get fancy, it's probably very easy to make it so
that parse_file() can read in live /proc/${pid}/maps files too :)

It is easy to stick in support for platforms other than SPARC64,
the machinery is all there, just pop the definitions out from
the platforms include/asm-*/*.h and relevant include/asm-generic/*.h
header files.

Enjoy. :-)

--Multipart=_Tue__22_Mar_2005_13_28_18_-0800_GmTpW9wxXbmzOtmE
Content-Type: text/x-csrc;
 name="simulator.c"
Content-Disposition: attachment;
 filename="simulator.c"
Content-Transfer-Encoding: 7bit

#include <stddef.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <malloc.h>

#define ARCH_SPARC64	1
#define ARCH_IA64	2
#define ARCH_PPC64	3

#define ARCH	ARCH_SPARC64

#if (ARCH == ARCH_SPARC64)
#define PAGE_SHIFT	13
#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-3))
#define PMD_SIZE	(1UL << PMD_SHIFT)
#define PMD_MASK	(~(PMD_SIZE-1))
#define PMD_BITS	11
#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT-3) + PMD_BITS)
#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
#define PGDIR_MASK	(~(PGDIR_SIZE-1))
#define PUD_SHIFT	PGDIR_SHIFT
#define PTRS_PER_PUD	1
#define PUD_SIZE  	(1UL << PUD_SHIFT)
#define PUD_MASK  	(~(PUD_SIZE-1))
#define pgd_addr_end(addr, end)						\
({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
})
#define pud_addr_end(addr, end)			(end)
#define pmd_addr_end(addr, end)						\
({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
})
#else
#error please add definitions for your architecture
#endif

/*
 * Note: this doesn't free the actual pages themselves. That
 * has been handled earlier when unmapping all the memory regions.
 */
static inline void free_pte_range(unsigned long addr)
{
}

static inline void free_pmd_range(unsigned long addr, unsigned long end,
				  unsigned long floor, unsigned long ceiling)
{
	unsigned long next;
	unsigned long start;

	start = addr;
	do {
		next = pmd_addr_end(addr, end);
#if 1
		printf("free_pgtables: free_pte_range() addr(%lx) next(%lx) end(%lx)\n",
		       addr, next, end);
#endif
		free_pte_range(addr);
	} while (addr = next, addr != end);

	start &= PUD_MASK;
	ceiling &= PUD_MASK;
#if 1
	printf("free_pmd_range: start(%lx) ceiling(%lx) ", start, ceiling);
#endif
	if ((start < floor) ||
	    (end - 1 > ceiling - 1)) {
#if 1
		printf("SKIP pud_clear()\n");
#endif
		return;
	}
#if 1
	printf("DO pud_clear()\n");
#endif
}

static inline void free_pud_range(unsigned long addr, unsigned long end,
				  unsigned long floor, unsigned long ceiling)
{
	unsigned long next;
	unsigned long start;

	start = addr;
	do {
		next = pud_addr_end(addr, end);
#if 1
		printf("free_pud_range: free_pmd_range(%lx,%lx,%lx,%lx)\n",
		       addr, next, floor, ceiling);
#endif
		free_pmd_range(addr, next, floor, ceiling);
	} while (addr = next, addr != end);

	start &= PGDIR_MASK;
	ceiling &= PGDIR_MASK;
#if 1
	printf("free_pud_range: start(%lx) ceiling(%lx) ",
	       start, ceiling);
#endif
	if ((start < floor) ||
	    (end - 1 > ceiling - 1)) {
#if 1
		printf("SKIP pgd_clear()\n");
#endif
		return;
	}
#if 1
	printf("DO pgd_clear()\n");
#endif
}

/*
 * This function frees user-level page tables of a process.
 * Unlike other pagetable walks, some memory layouts might give end 0.
 * Must be called with pagetable lock held.
 */
static inline void free_pgd_range(unsigned long addr, unsigned long end,
				  unsigned long floor, unsigned long ceiling)
{
	unsigned long next;
	unsigned long start;

	addr &= PMD_MASK;
	if (addr < floor) {
		addr += PMD_SIZE;
		if (!addr)
			return;
	}
	ceiling &= PMD_MASK;
	if (end - 1 > ceiling - 1)
		end -= PMD_SIZE;
	if (addr > end - 1)
		return;

	start = addr;
	do {
		next = pgd_addr_end(addr, end);
#if 1
		printf("free_pgd_range: free_pud_range(%lx,%lx,%lx,%lx)\n",
		       addr, next, floor, ceiling);
#endif
		free_pud_range(addr, next, floor, ceiling);
	} while (addr = next, addr != end);

	if (1 /*!tlb_is_full_mm(tlb)*/) {
#if 1
		printf("free_pgd_range: Doing flush_tlb_pgtables(%lx,%lx)\n",
		       start, end);
#endif
		/*flush_tlb_pgtables(tlb->mm, start, end);*/
	}
}

struct vm_area_struct {
	struct vm_area_struct *vm_next;
	unsigned long vm_start, vm_end;
};

void free_pgtables(struct vm_area_struct *vma,
		   unsigned long floor, unsigned long ceiling)
{
#if 1
	struct vm_area_struct *tmp = vma;

	printf("VMA DUMP: ");
	while (tmp) {
		printf("[%lx:%lx] ", tmp->vm_start, tmp->vm_end);
		tmp = tmp->vm_next;
	}
	printf("\n");
#endif
	while (vma) {
		struct vm_area_struct *next = vma->vm_next;
		unsigned long addr = vma->vm_start;

		/* Optimization: gather nearby vmas into a single call down */
		while (next && next->vm_start <= vma->vm_end + 2*PMD_SIZE) {
			vma = next;
			next = vma->vm_next;
		}
#if 1
		printf("free_pgtables: free_pgd_range(%lx,%lx,%lx,%lx)\n",
		       addr, vma->vm_end, floor,
		       next ? next->vm_start : ceiling);
#endif
		free_pgd_range(addr, vma->vm_end,
			       floor, next? next->vm_start: ceiling);
		vma = next;
	}
}

/* Note that we have to build the list in ascending order.  */
static struct vm_area_struct *parse_file(FILE *fp)
{
	struct vm_area_struct **pprev = NULL;
	struct vm_area_struct *mpnt, *head;
	unsigned long start, end;

	for (;;) {
		int ret = fscanf(fp, "%lx %lx", &start, &end);

		if (ret < 2 || ret == EOF)
			break;

		mpnt = malloc(sizeof(*mpnt));
		if (mpnt == NULL)
			goto fail;

#if 1
		printf("parse_file: Building VMA %lx --> %lx\n",
		       start, end);
#endif
		mpnt->vm_next = NULL;
		mpnt->vm_start = start;
		mpnt->vm_end = end;
		if (pprev)
			*pprev = mpnt;
		else
			head = mpnt;
		pprev = &mpnt->vm_next;
	}

	return head;

fail:
	while (head) {
		struct vm_area_struct *next = head->vm_next;

		free(head);
		head = next;
	}
	return NULL;
}

int main(int argc, char **argv, char **envp)
{
	FILE *fp;
	struct vm_area_struct *vma;

	if (argc <= 1)
		return 1;

	fp = fopen(argv[1], "r");
	if (fp == NULL) {
		perror("fopen()");
		return 1;
	}
	if ((vma = parse_file(fp)) == NULL)
		return 1;

	free_pgtables(vma, 0, 0);

	return 0;
}

--Multipart=_Tue__22_Mar_2005_13_28_18_-0800_GmTpW9wxXbmzOtmE
Content-Type: text/plain;
 name="vma_list.txt"
Content-Disposition: attachment;
 filename="vma_list.txt"
Content-Transfer-Encoding: 7bit

0x00010000 0x000a4000
0x000b2000 0x000b8000
0x000b8000 0x000de000
0x70000000 0x7001a000
0x70028000 0x7002a000
0x7002c000 0x7006a000
0x7006a000 0x7006c000
0x7006c000 0x70084000
0x70084000 0x70088000
0x70088000 0x70094000
0x70094000 0x70098000
0x70098000 0x701da000
0x701da000 0x701e8000
0x701e8000 0x701f2000
0x701f2000 0x701f4000
0x701f4000 0x701fc000
0x701fc000 0x70204000
0x70204000 0x7020c000
0x7020c000 0x7021e000
0x7021e000 0x7022c000
0x7022c000 0x70230000
0x70230000 0x70232000
0x70234000 0x7023e000
0x7023e000 0x70244000
0x70244000 0x7024e000
0x70250000 0x7025a000
0x7025a000 0x70260000
0x70260000 0x7026c000
0xefbfe000 0xefc28000

--Multipart=_Tue__22_Mar_2005_13_28_18_-0800_GmTpW9wxXbmzOtmE--

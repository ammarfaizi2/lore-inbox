Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTETMNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 08:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTETMNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 08:13:17 -0400
Received: from color.sics.se ([193.10.66.199]:18573 "EHLO color.sics.se")
	by vger.kernel.org with ESMTP id S263752AbTETMNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 08:13:10 -0400
Date: Tue, 20 May 2003 14:26:02 +0200
Message-Id: <200305201226.h4KCQ2T05460@r2d2.sics.se>
From: Per Mildner <Per.Mildner@sics.se>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: mmap address hint ignored if that address is already mapped.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The address hint to mmap(MAP_ANONYMOUS) is ignored unless it lies in
an unmapped region. It used to (2.4.9) return an address "close" to
the supplied hint.

When calling mmap with a non-zero "hint" address and without MAP_FIXED
the address will be ignored unless it lies within an unmapped region
of memory. It used to be (in 2.4.9) that the returned memory was close
to the hint address.

Example, calling the following twice
mmap((void*)getpagesize(),
     0xa00000,
     PROT_NONE,
     (MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE),
     -1, 0);

will return a block at getpagesize() the first time but the second
call will return a block beyond address 0x40000000.

I think the problem lies in mm/mmap.c in arch_get_unmapped_area(). In
2.4.18 it looks like:

static inline unsigned long arch_get_unmapped_area(
       struct file *filp, unsigned long addr,
       unsigned long len, unsigned long pgoff, unsigned long flags)
{
	struct vm_area_struct *vma;

	if (len > TASK_SIZE)
		return -ENOMEM;

	if (addr) { // [PM] *** new special case code
		addr = PAGE_ALIGN(addr);
		vma = find_vma(current->mm, addr);
		if (TASK_SIZE - len >= addr &&
		    (!vma || addr + len <= vma->vm_start))
			return addr;
	}
	addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);

	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
		/* At this point:  (!vma || addr < vma->vm_end). */
		if (TASK_SIZE - len < addr)
			return -ENOMEM;
		if (!vma || addr + len <= vma->vm_start)
			return addr;
		addr = vma->vm_end;
	}
}

In 2.4.9 it looks like:

static inline unsigned long arch_get_unmapped_area(
       struct file *filp, unsigned long addr,
       unsigned long len, unsigned long pgoff, unsigned long flags)
{
	struct vm_area_struct *vma;

	if (len > TASK_SIZE)
		return -ENOMEM;
	if (!addr)
		addr = TASK_UNMAPPED_BASE;
	addr = PAGE_ALIGN(addr);

	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
		/* At this point:  (!vma || addr < vma->vm_end). */
		if (TASK_SIZE - len < addr)
			return -ENOMEM;
		if (!vma || addr + len <= vma->vm_start)
			return addr;
		addr = vma->vm_end;
	}
}
     
What I think happens is that the first call to find_vma() in both
versions will find the block mapped by the first call to mmap (call
this block A). (find_vma always returns the lowest address block that
ends after addr).

In the 2.4.9 code the for loop will then return an address located
right above block A. The semantics of mmap will thus be that the
address returned is the first (in increasing address order) large
enough area that starts at or after the hint address "addr".

In the 2.4.18 code the special case for addr != 0 will kick in and
since the block A returned will not satisfy condition addr + len <=
vma->vm_start the if-then-else will fall through to addr =
PAGE_ALIGN(TASK_UNMAPPED_BASE), in effect ignoring the supplied hint
address addr.

Obviously the current behavior is not in itself wrong since mmap is free to
ignore the address completely unless MAP_FIXED is used. However, if an
explicit hint address is used it seems reasonable to assume that the
caller have a fairly strong desire to get a block close to that
address.

Note that SUSv3 says "A non-zero value of addr is taken to be a
suggestion of a process address NEAR which the mapping should be
placed." (my emphasis) whereas my Linux man page says "... preferably AT
address start." (my emph.), i.e., does not claim anything if the
address cannot be used as is.

The new code is a change in behavior, slightly against the spirit of
SUSv3 and breaks our application. The version in 2.5.69 is different
but also appears to discard the hint address if falls in a mapped
memory region.

The problem happens on a RedHat 7.3:
Linux bliss.sics.se 2.4.18-3 #1 Thu Apr 18 07:37:53 EDT 2002 i686 unknown

The problem does not happen on RedHat 7.2:
Linux r2d2 2.4.9-31smp #1 SMP Tue Feb 26 06:55:00 EST 2002 i686 unknown

A possible work-around would be to change

	addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);

into

        else
          addr = TASK_UNMAPPED_BASE;
	addr = PAGE_ALIGN(addr);


The below test program run on 2.4.9 prints:
mmap(0x00001000, 0xa00000, PROT_NONE, (MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE), -1, 0).....== [0x00001000,0x00a01000] 
mmap(0x00001000, 0xa00000, PROT_NONE, (MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE), -1, 0).....== [0x00a01000,0x01401000] 
mmap(0x00001000, 0xa00000, PROT_NONE, (MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE), -1, 0).....== [0x01401000,0x01e01000] 
... always address closest to 0x00001000 until the lower 128MB is full

The below test program run on 2.4.18 prints:
mmap(0x00001000, 0xa00000, PROT_NONE, (MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE), -1, 0).....== [0x00001000,0x00a01000] 
mmap(0x00001000, 0xa00000, PROT_NONE, (MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE), -1, 0).....== [0x40033000,0x40a33000] 
mmap(0x00001000, 0xa00000, PROT_NONE, (MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE), -1, 0).....== [0x40a33000,0x41433000] 
... The second and subsequent call to mmap will ignore the hint
... address 0x00001000.

Example program, run with gcc -Wall test.c && ./a.out

#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdio.h>

static char *sp_mmap(void *addr, size_t size)
{
  char *p;

  fprintf(stderr, "mmap(0x%08lx, 0x%lx, PROT_NONE, (MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE), -1, 0)...",
          (unsigned long)addr, (unsigned long)size
          );fflush(stderr);

  p = (char*)mmap(addr, size,
                  PROT_NONE,
                  (MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE),
                  -1, 0);

  fprintf(stderr, 
          "..== [0x%08lx,0x%08lx] %s\n",
          (unsigned long)p,
          (unsigned long)(p == MAP_FAILED ? p : ((char*)p)+size),
          (p == MAP_FAILED ? " (MAP_FAILED)" : "")); fflush(stderr);

  return p;
}

int main ()
{
  size_t pgsize = getpagesize();
  void *start;

  start = (void*) pgsize;
  while (1)
    {
      size_t const sz = 0xa00000;
      char *tmp;

      tmp = (char*)sp_mmap(start, sz);

      if (tmp == MAP_FAILED) break;

#if EXACT_HINT                  /* if true then x86 Linux 2.4.18-3 works */
      start = tmp + sz;
#endif
    }
  exit(EXIT_SUCCESS);
}



-- 
Per Mildner                                     Per.Mildner@sics.se
Swedish Institute of Computer Science

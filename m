Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbTLZKym (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 05:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbTLZKym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 05:54:42 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:63175 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S265170AbTLZKyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 05:54:35 -0500
Date: Fri, 26 Dec 2003 10:54:33 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Rohit Seth <rohit.seth@intel.com>
Subject: 2.6.0 Huge pages not working as expected
Message-ID: <20031226105433.GA25970@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying out the huge page support using 2.6.0.  I compiled
with :-

CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y

And all looks good in /proc/meminfo

HugePages_Total:     8
HugePages_Free:      8
Hugepagesize:     4096 kB

I mounted a hugetlbfs on /mnt/hugetlb.

I wrote a little test program to show the benefits of huge pages by
reducing TLB thrashing - it fills up 16 MB with sequential numbers
then adds them with different strides - very much the sort of thing
FFTs do.  However huge pages show a performance decrease not increase
for large strides!  For smaller ones there is a small speedup.

I've been testing on

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 551.405
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1089.53

Whats happening? Is there something broken in my program, the kernel,
or my understanding?  I know this isn't a particularly good
demonstration of reducing TLB thrashing as it should only read in
cacheline multiples, but I wasn't expecting it to slow down!

I've also been trying huge pages with mprime (which does lots of FFTs)
which does show some improvement (just 2% or so because it is already
very TLB aware).

Here are the results :-

------------------------------------------------------------
Memory from malloc()
Testing memory at 0x4015e008
span =        1, time =     71.212 ms, total = -2097152
span =        2, time =     71.744 ms, total = -2097152
span =        4, time =     88.352 ms, total = -2097152
span =        8, time =    176.207 ms, total = -2097152
span =       16, time =    176.166 ms, total = -2097152
span =       32, time =    176.385 ms, total = -2097152
span =       64, time =    179.042 ms, total = -2097152
span =      128, time =    184.059 ms, total = -2097152
span =      256, time =    195.014 ms, total = -2097152
span =      512, time =    217.084 ms, total = -2097152
span =     1024, time =    260.899 ms, total = -2097152
span =     2048, time =    259.714 ms, total = -2097152
span =     4096, time =    261.059 ms, total = -2097152

Memory from hugetlbfs
Testing memory at 0x41400000
span =        1, time =     70.815 ms, total = -2097152
span =        2, time =     71.261 ms, total = -2097152
span =        4, time =     88.178 ms, total = -2097152
span =        8, time =    175.512 ms, total = -2097152
span =       16, time =    174.996 ms, total = -2097152
span =       32, time =    175.689 ms, total = -2097152
span =       64, time =    177.301 ms, total = -2097152
span =      128, time =    181.705 ms, total = -2097152
span =      256, time =    191.232 ms, total = -2097152
span =      512, time =    209.886 ms, total = -2097152
span =     1024, time =    247.646 ms, total = -2097152
span =     2048, time =    279.525 ms, total = -2097152
span =     4096, time =    344.605 ms, total = -2097152

Memory from /dev/zero
Testing memory at 0x42400000
span =        1, time =     70.916 ms, total = -2097152
span =        2, time =     71.405 ms, total = -2097152
span =        4, time =     89.584 ms, total = -2097152
span =        8, time =    176.190 ms, total = -2097152
span =       16, time =    175.730 ms, total = -2097152
span =       32, time =    176.377 ms, total = -2097152
span =       64, time =    178.675 ms, total = -2097152
span =      128, time =    183.429 ms, total = -2097152
span =      256, time =    194.153 ms, total = -2097152
span =      512, time =    215.089 ms, total = -2097152
span =     1024, time =    256.428 ms, total = -2097152
span =     2048, time =    268.468 ms, total = -2097152
span =     4096, time =    268.702 ms, total = -2097152
------------------------------------------------------------

And here is the program...

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/mman.h>

#define MEMORY_FILE_NAME "/mnt/hugetlb/z"
#define MEMORY_SIZE (4*1024*1024)

/****************************************************************************
Returns the time in floating point seconds since the epoch - useful for more
accurate timing that time() allows for
****************************************************************************/

static double timef(void)
{
    struct timeval tv = {0, 0};
    gettimeofday(&tv, 0);
    return (double)tv.tv_sec + ((double)tv.tv_usec)/1E6;
}

/****************************************************************************
Test the memory with different spans - should show TLB thrashing nicely
****************************************************************************/

static void test(int *p)
{
    int i;
    int span;

    printf("Testing memory at %p\n", p);

    /* fill it */
    for (i = 0; i < MEMORY_SIZE; i++)
	p[i] = i;

    /* test it with different spans */
    for (span = 1; span <= 4096; span *= 2)
    {
	double start = timef();
	int j;
	int total = 0;

	for (j = 0; j < span; j++)
	{
	    for (i = j; i < MEMORY_SIZE; i+= span)
		total += p[i];
	}
	start = timef() - start;
	printf("span = %8d, time = %10.3f ms, total = %d\n", span, 1000*start, total);
    }
    printf("\n");
}

/****************************************************************************
Thrash the hugetlb
****************************************************************************/

int main(void)
{
    int *malloc_memory;
    int *hugepage_memory;
    int *devzero_memory;
    int fd;

    /* get some malloc memory */
    malloc_memory = calloc(MEMORY_SIZE, sizeof(int));
    if (malloc_memory == 0)
    {
	fprintf(stderr, "Couldn't allocate memory\n");
	exit(EXIT_FAILURE);
    }

    /* get some hugepage memory */
    fd = open(MEMORY_FILE_NAME, O_CREAT|O_RDWR, 0600);
    if (fd < 0)
    {
	fprintf(stderr, "Failed to open huge page memory file '%s': %s\n", MEMORY_FILE_NAME, strerror(errno));
	exit(EXIT_FAILURE);
    }
    hugepage_memory = mmap(0, MEMORY_SIZE * sizeof(int), PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
    if (hugepage_memory == MAP_FAILED)
    {
	fprintf(stderr, "Huge page mmap() failed: %s\n", strerror(errno));
	exit(EXIT_FAILURE);
    }

    /* get some /dev/zero memory */
    fd = open("/dev/zero", O_CREAT|O_RDWR, 0600);
    if (fd < 0)
    {
	fprintf(stderr, "Failed to open /dev/zero memory file: %s\n", strerror(errno));
	exit(EXIT_FAILURE);
    }
    devzero_memory = mmap(0, MEMORY_SIZE * sizeof(int), PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
    if (devzero_memory == MAP_FAILED)
    {
	fprintf(stderr, "Huge page mmap() failed: %s\n", strerror(errno));
	exit(EXIT_FAILURE);
    }

    printf("Memory from malloc()\n");
    test(malloc_memory);

    printf("Memory from hugetlbfs\n");
    test(hugepage_memory);

    printf("Memory from /dev/zero\n");
    test(devzero_memory);

    unlink(MEMORY_FILE_NAME);

    return EXIT_SUCCESS;
}


-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVAOToO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVAOToO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 14:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVAOToO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 14:44:14 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:48047 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262310AbVAOTnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 14:43:52 -0500
Date: Sat, 15 Jan 2005 19:43:51 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linux Memory Management List <linux-mm@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 0/0 Reducing fragmentation through better allocation
Message-ID: <Pine.LNX.4.58.0501151942020.17278@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Two patches will be posted with this thread. They both aim to address the
problem of external fragmentation in the buddy allocator preventing high-order
allocations. The first patch is a modified buddy allocator which I believe to
be very stable. The second patch is a proof-of-concept patch that linearly
scans memory and frees pages to satisfy a high-order allocation. The second
patch is very experimental and could break some architectures.

I ran a series of stress tests against the standard 2.6.11-rc1 kernel,
2.6.11-rc1+modifiedallocator and 2.6.11-rc1+modifiedallocator+linearscanner.
The shell script I used is displayed below but broadly speaking the script;

1. Start updatedb running in the background
2. Load kernel modules that are allocate high-order blocks
3. Clean a kernel tree
4. Make 6 copies of the tree. As each copy finishes, a compile starts at -j4
5. Start compiling the primary tree
6. Sleep 3 minutes
7. Use the kernel module to attempt 160 times to allocate a 2^10 block of pages
    - note, it only attempts 160 times, no matter how often it succeeds
    - An allocation is attempted every 1/10th of a second

The results are;

Vanilla 2.6.11-rc1
Attempted allocations: 160
Success allocs:        3
Failed allocs:         157
% Success:            1

2.6.11-rc1 with modified allocator
Attempted allocations: 160
Success allocs:        81
Failed allocs:         79
% Success:            50

2.6.11-rc1 with modified allocator and linear scanner
Attempted allocations: 160
Success allocs:        122
Failed allocs:         38
% Success:            76

With the scanner, 9 of those allocations were directly serviced by the linear
scanner. However, I know that it would have freed up a lot more pages than
necessary while scanning.

Test script is as follows;
#!/bin/bash

updatedb &

RESULTS=/root/results-`uname -r`.txt
START=`date +%s`
echo Start date: `date`
echo Start date: `date` > $RESULTS
uname -a >> $RESULTS

insmod /usr/src/vmregress/src/core/vmregress_core.ko
insmod /usr/src/vmregress/src/test/highalloc.ko
if [ ! -e /proc/vmregress/test_highalloc ]; then
  echo High alloc proc test does not exist
  exit
fi

cd /usr/src/linux-2.6.9-mbuddy
make clean

for i in `seq 1 6`; do
  echo Copying and making copy-$i
  cd ..
  rm -rf linux-2.6.9-copy-$i
  cp -r linux-2.6.9-mbuddy linux-2.6.9-copy-$i
  cd linux-2.6.9-copy-$i
  make clean > /dev/null 2> /dev/null
  make -j4 bzImage > /dev/null 2> ../error-$i.txt &
done

echo Making primary
cd ../linux-2.6.9-mbuddy
make -j4 bzImage > /dev/null 2> ../error-primary.txt &
cd ..

sleep 180
echo Trying high alloc
echo Buddyinfo at start of test >> $RESULTS
cat /proc/buddyinfo >> $RESULTS

STARTALLOC=`date +%s`
echo 10 160 > /proc/vmregress/test_highalloc
ENDALLOC=`date +%s`
cat /proc/vmregress/test_highalloc >> $RESULTS
echo Duration alloctest: $(($ENDALLOC-$STARTALLOC)) >> $RESULTS

cat /proc/vmregress/test_highalloc
echo Buddyinfo at end of test >> $RESULTS
cat /proc/buddyinfo >> $RESULTS


echo Waiting in `pwd`
echo Waiting till bzImages in each place
while [ ! -e linux-2.6.9-mbuddy/arch/i386/boot/bzImage ]; do sleep 1; done
echo Finished: Primary

for i in `seq 1 6`; do
  echo Waiting for linux-2.6.9-copy-$i/arch/i386/boot/bzImage
  while [ ! -e linux-2.6.9-copy-$i/arch/i386/boot/bzImage ]; do sleep 1; done
  echo Finished: Copy $i
done

echo Recording buddyinfo stats
cat /proc/buddyinfo > before-delete
rm linux-2.6.9-copy* -rf
cat /proc/buddyinfo > after-delete

echo End date: `date`
END=`date +%s`
echo Duration: $(($END-$START))



The module that performs the allocation works by creating a proc entry and echoing
parameters to it. This is where the test is started

echo 10 160 > /proc/vmregress/test_highalloc

and says "Attempt 160 allocations of 2^10 blocks of pages". The results are read
afterwards by catting the same proc entry. The module is part of VMRegress and
not released yet due to lack-of-documentation. However, the source is here so
you get an idea of how it works exactly. The code you cannot see is mainly support
code like initialising the proc entry and functions like printp for writing to
a proc entry (I know, I should be using seq_printf, but this code was written
before seq_printf existing and I have not updated to match).


/*
 * highalloc - Test the allocation of high-order pages
 *
 * Mel Gorman 2005
 */

#include <linux/version.h>
#include <linux/config.h>
#include <linux/fs.h>
#include <linux/types.h>
#include <linux/proc_fs.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <asm/uaccess.h>

/* Module specific */
#include <vmregress_core.h>
#include <procprint.h>
#include <linux/mmzone.h>
#include <linux/mm.h>
#include <linux/vmalloc.h>
#include <linux/spinlock.h>
#include <linux/highmem.h>
#include <asm/rmap.h>		/* Included only if available */
#include <vmr_mmzone.h>

#define MODULENAME "test_highalloc"
#define NUM_PROC_ENTRIES 1

/* Tests */
#define TEST_FAST 0
#define TEST_LOW  1
#define TEST_MIN  2
#define TEST_ZERO 3

static vmr_desc_t testinfo[] = {
	VMR_DESC_INIT(TEST_FAST, MODULENAME , vmr_read_proc, vmr_write_proc),
};

MODULE_AUTHOR("Mel Gorman <mel@csn.ul.ie>");
MODULE_DESCRIPTION("Test high order allocations");
MODULE_LICENSE("GPL");

/* Boolean to indicate whether to use gfp_highuser or not */
static int gfp_highuser;
MODULE_PARM(gfp_highuser, "i");
MODULE_PARM_DESC(gfp_highuser, "Set to 1 if gfp_highuser is to be used with alloc_pages");

/* GFP flags to use with __alloc_pages. defaults to GFP_USER */
unsigned int gfp_flags=GFP_USER;

/**
 * test_alloc_help - Print help message to proc buffer
 * @procentry: Which proc buffer to write to
 */
void test_alloc_help(int procentry) {
	vmrproc_openbuffer(&testinfo[procentry]);

	printp("%s%s\n\n", MODULENAME, testinfo[procentry].name);
	printp("To run test, run \n");
	printp("echo order number > /proc/vmregress/%s\n\n", MODULENAME);

	/* Set gfp_flags based on the module parameter */
	if (gfp_highuser) gfp_flags = GFP_HIGHUSER;

	vmrproc_closebuffer(&testinfo[procentry]);
}

/**
 *
 * test_alloc_runtest - Allocate and free a number of pages from a ZONE_NORMAL
 * @params: Parameters read from the proc entry
 * @argc:   Number of parameters actually entered
 * @procentry: Proc buffer to write to
 *
 * If pages is set to 0, pages will be allocated until the pages_high watermark
 * is hit
 * Returns
 * 0  on success
 * -1 on failure
 *
 */
int test_alloc_runtest(int *params, int argc, int procentry) {
	unsigned long order;		/* Order of pages */
	unsigned long numpages;		/* Number of pages to allocate */
	struct page **pages;		/* Pages that were allocated */
	unsigned long attempts=0;
	unsigned long alloced=0;
	unsigned long nextjiffies = jiffies;
	unsigned long lastjiffies = jiffies;
	unsigned long success=0;
	unsigned long fail=0;
	unsigned long resched_count=0;

	/* Get the parameters */
	order = params[0];
	numpages = params[1];

	/* Make sure a buffer is available */
	if (vmrproc_checkbuffer(testinfo[procentry])) BUG();
	vmrproc_openbuffer(&testinfo[procentry]);

	if (order < 0 || order > MAX_ORDER) {
		vmr_printk("Order request makes no sense\n");
		return -1;
	}

	if (numpages < 0) {
		vmr_printk("Number of pages makes no sense\n");
		return -1;
	}

	/*
	 * Allocate memory to store pointers to pages.
	 */
	pages = vmalloc((numpages+1) * sizeof(struct page **));

	/*
	 * Attempt to allocate the requested number of pages
	 */
	while (attempts++ != numpages) {
		struct page *page;
		if (lastjiffies > jiffies) nextjiffies = jiffies;
		while (jiffies < nextjiffies) check_resched(resched_count);
		nextjiffies = jiffies + (HZ / 10);

		/* Print message if this is taking a long time */
		if (jiffies - lastjiffies > HZ) {
			printk("High order alloc test attempts: %lu\n",
					attempts);
		}
		lastjiffies = jiffies;

		page = alloc_pages(gfp_flags, order);
		if (page) {
			success++;
			pages[alloced++] = page;
		} else {
			fail++;
		}
	}

	/*
	 * Free up the pages
	 */
	alloced--;
	do {
		__free_pages(pages[alloced], order);
		alloced--;
	} while (alloced != 0);

	/* Print header */
	printp("Order:                 %lu\n", order);
	printp("Attempted allocations: %lu\n", numpages);
	printp("Success allocs:        %lu\n", success);
	printp("Failed allocs:         %lu\n", fail);
	printp("%% Success:            %lu\n", (success * 100) / (unsigned long)numpages);

	vfree(pages);

	printp("Test completed successfully\n");

	vmrproc_closebuffer(&testinfo[procentry]);
	return 0;
}

#define NUMBER_PROC_WRITE_PARAMETERS 2
#define VMR_WRITE_CALLBACK test_alloc_runtest
#include "../init/proc.c"

#define VMR_HELP_PROVIDED test_alloc_help
#include "../init/init.c"



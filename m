Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275671AbRIZWlc>; Wed, 26 Sep 2001 18:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275672AbRIZWlY>; Wed, 26 Sep 2001 18:41:24 -0400
Received: from green.csi.cam.ac.uk ([131.111.8.57]:43690 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S275671AbRIZWlP>; Wed, 26 Sep 2001 18:41:15 -0400
Message-Id: <5.1.0.14.2.20010926212916.022c3e00@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 26 Sep 2001 23:42:49 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] invalidate buffers on blkdev_put
Cc: Alexander Viro <viro@math.psu.edu>, Chris Mason <mason@suse.com>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.33.0109252037160.7697-100000@penguin.transmeta.
 com>
In-Reply-To: <5.1.0.14.2.20010925231124.0309ac70@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:39 26/09/01, Linus Torvalds wrote:
>On Tue, 25 Sep 2001, Anton Altaparmakov wrote:
> > Looking at the patch, you introduce a static inline blksize_bits. Wouldn't
> > it be a lot more efficient to change the function to say:
>
>More efficient? Probably not. We know that the result of blksize_bits is
>in the range of 9-12 on x86, and if you look at the thing it uses that
>knowledge.

Of course. I saw that. However the do/while approach is a O(N) algorithm 
while the ffs() using algorithm can be O(1) if the CPU allows it.

I wrote a quick benchmark program + script (appended at bottom of this 
mail) and did 50 million iterations of either the do/while function or the 
ffs() equivalent (including the BUG() check for power of 2) and it turns 
out that on all CPUs tested (Pentium 133S, Pentium III 800, Alpha EV56 
533(or so), Athlon 1.33GHz 266FSB) the do/while loop is marginally faster 
for sizes of 256 and 512 (except P3/800 where the ffs is faster even for 
these smaller sizes) but is increasingly slower for increasing sizes. For 
large sizes the do/while loop becomes significantly slower than the ffs() 
approach, which of course is irrelevant at the moment with the block size 
limitation...

The values in below tables are in seconds (user field from time output) 
needed to complete 50 million cycles.

For those who prefer graphs rather than tables, I have created line charts 
comparing the two methods for each CPU which you can view at URL (note the 
charts contain data points for higher sizes, too, not shown in below tables 
and also note that each point shown is from a single benchmark run simply 
because I couldn't be bothered to do the stats on more than one go, but the 
values shown are representative of several runs, if you don't believe me, 
the program and script are at the bottom of this mail...):
         http://www-stu.christs.cam.ac.uk/~aia21/ffs_test.gif

do/while based function
=======================

                 | Size
CPU             | 256   512     1024    2048    4096    8192    16384
---------------+----------------------------------------------------
P1/133          | 2.26  2.38    4.62    5.29    6.04    6.78    7.56
P3/800          | 0.30  0.30    0.42    0.56    0.70    1.40    1.65
Alpha/533       | 0.48  0.48    1.93    2.22    2.52    2.31    2.61
Athlon/1333     | 0.13  0.14    0.27    0.34    0.41    0.49    0.57


ffs based function
==================

                 | Size
CPU             | 256   512     1024    2048    4096    8192    16384
---------------+----------------------------------------------------
P1/133          | 3.73  3.73    3.78    3.77    3.77    3.78    3.84
P3/800          | 0.27  0.26    0.25    0.26    0.26    0.25    0.27
Alpha/533       | 0.58  0.58    0.58    0.58    0.58    0.58    0.58
Athlon/1333     | 0.15  0.15    0.15    0.15    0.15    0.15    0.15

And just for fun the comparison for the completely irrelevant and insane 
size of 2^30 (1073741824), again 50 million iterations:

CPU             | do/while | ffs
---------------+----------+--------
P1/133          | 19.62    | 3.76
P3/800          |  3.70    | 0.25
Alpha/533       |  7.25    | 0.58
Athlon/1333     |  2.18    | 0.15

Yeah, I know, benchmarks are to be taken with a pinch of salt, are 
meaningless most of the time, etc, but it was fun doing this just to see 
how different CPUs perform (on this specific piece of code). And it was a 
good way to relax my brain after 11 hours of work at the lab today... (-:

>More importantly, I think the whole code will go away, because the bits
>(and the size) should be in the bdev structure in the first place (or,
>even better, the inode, at which point all the special-case functions go
>away and just become calls to the generic ones)

Yes, that would be a very good thing indeed and yes it renders the 
discussion pointless. But a lot of code in the kernel does the same 
calculation all the time, in particular in file systems and block devices 
(which will probably go away once we have the value in the inode) and 
almost none I have seen use ffs() but use variations of unoptimized 
for/while/do loops and I think the above benchmark results show that using 
ffs() would benefit all those cases unless they expect the normal case to 
be a size of less or equal 512.

Best regards,

         Anton

--- test_ffs.sh ---
#!/bin/bash
iters=50000000
if [ ! -f ./test_ffs ]; then
         gcc -O2 -m486 -o test_ffs test_ffs.c
fi
echo
echo Performing $iters iterations with each blocksize.
for l in 256 512 1024 2048 4096 8192 16384 32768 65536 131072 1073741824; do
         time ./test_ffs 1 $iters $l
         time ./test_ffs 2 $iters $l
done
exit 0
--- test_ffs.c ---
static inline unsigned int blksize_bits(unsigned int size)
{
         unsigned int bits = 8;
         do {
                 bits++;
                 size >>= 1;
         } while (size > 256);
         return bits;
}

/*
  * Replace this with ffs() from linux/include/asm/bitops.h
  * for your arch on non ia32.
  */
static __inline__ int kernel_ia32_ffs(int x)
{
         int r;
         __asm__("bsfl %1,%0\n\t"
                 "jnz 1f\n\t"
                 "movl $-1,%0\n"
                 "1:" : "=r" (r) : "g" (x));
         return r+1;
}

static inline unsigned int blksize_bits_ffs(unsigned int size)
{
         if (!(size & size - 1))
                 return kernel_ia32_ffs(size) - 1;
         puts("size not power of 2!");
         exit(1);
}

int main(int argc, char *argv[])
{
         long i, j, iters, testval;
         char test;
         if (argc != 4) {
parm_err:
                 printf("Syntax: test_ffs test iterations testvalue\n"
                                 "test = 1 -> use do/while blksize_bits\n"
                                 "test = 2 -> use ffs blksize_bits\n"
                                 "iterations = number of iterations of "
                                 "blksize_bits call\n"
                                 "testvalue = value to pass to 
blksize_bits\n");
                 exit(1);
         }
         test = *argv[1];
         if (test != '1' && test != '2')
                 goto parm_err;
         iters = atol(argv[2]);
         testval = atol(argv[3]);
         if (iters <= 0 || testval <= 0)
                 goto parm_err;
         printf("\n\nPerforming %li million iterations of %s test with test "
                         "value %li.\n", iters/1000000, test == '1' ?
                         "do/while" : "ffs", testval);
         switch (test) {
         case '1':
                 for (i = 0; i < iters; i++)
                         j = blksize_bits(testval);
                 break;
         case '2':
                 for (i = 0; i < iters; i++)
                         j = blksize_bits_ffs(testval);
                 break;
         }
         return 0;
}



-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


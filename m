Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278275AbRKHUvQ>; Thu, 8 Nov 2001 15:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278269AbRKHUvH>; Thu, 8 Nov 2001 15:51:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:48900 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278275AbRKHUu4>; Thu, 8 Nov 2001 15:50:56 -0500
Message-ID: <3BEAEEE5.5F5BA8C0@zip.com.au>
Date: Thu, 08 Nov 2001 12:45:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>, ext2-devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
In-Reply-To: <20011107123430.D5922@lynx.no> <Pine.GSO.4.21.0111071446020.4283-100000@weyl.math.psu.edu> <3BE9E8B6.235E16A8@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, some more columns of numbers.

The 10-month simulated workload generates a total of 328 megs
of data.  This workload was applied seventeen times in succession
to sequentially numbered directories at the top of an empty
8 gigabyte ext2 fs.  Each top-level directory ends up containing
62 directories and 8757 files.  After the seventeen directories
were created, the disk was 75% full.

To assess the fragmentation we see how long it takes to read
all the files in each top-level directory, cache-cold, using

	find . -type f | xargs cat > /dev/null

We can find the "ideal" time for running the above command by copying
the 328 megs of files onto a pristine partition using an ext2 which
has the the `if (0 &&' patch and then timing how long that takes to
read.  It's 13 seconds, which is pretty darn good.  Reading an
equivalently-sized single file take 12.6, so we're maxing out the disk.

      Tree    Stock    Stock/         Patched  Patched/
              (secs)   ideal           (secs)  Stock
	0	37	2.9		74	2.0
	1	41	3.2		89	2.2
	2	41	3.2		97	2.4
	3	38	3.0		97	2.6
	4	55	4.3		102	1.9
	5	51	4.0		98	1.9
	6	72	5.7		94	1.3
	7	56	4.4		96	1.7
	8	64	5.1		102	1.6
	9	63	5		100	1.6
	10	57	4.5		95	1.7
	11	83	6.6		102	1.2
	12	54	4.3		101	1.9
	13	82	6.5		104	1.3
	14	89	7.1		103	1.2
	15	88	7.0		95	1.1
	16	106	8.4		99	0.9

Mean:          63.35	4.9		96.4	1.7

So.

- Even after a single iteration of the Smith test, ext2 fragmentation
  has reduced efficiency by a factor of three.   And the disk was
  never more than 5% full during the creation of these files.

- By the time the disk is 75% full, read efficiency is down by a factor
  of over eight.  Given that the most-recently created files are also
  the most-frequently accessed, this hurts.

- The `if (0 &&' patch makes things 1.7x worse, but it never got worse
  than the stock ext2's worst case.

Directory and inode fragmentation is not significant.  The time
to run `du -s' against tree number 8 is two seconds.

Seems to be fertile ground for improvement, however it looks
as though even a single pass of the Smith test has fragged the
disk to death and this is perhaps not a case we want to optimise
for.

The total amount of data which a single pass of the Smith workload
passes into write() is approx 52 gigabytes.  Thankfully, very little
of that actually hits disk because it's deleted before it gets written
back; but that's fine for this exercise.

So after writing 52 gigs of data and removing 51.7 gigs, an 8 gig
ext2 filesystem is badly fragmented.  Does this mean that the tale
about ext2 being resistant to fragmentation is a myth?

Or is this workload simply asking too much?   If the answer is
yes, then one solution is to change ext2 block allocation to
favour the fast-growth case and develop an online defrag tool.

Seems we have looked at both ends of the spectrum: the ultimate
case of fast growth and the ultimate case of slow growth.  In
both cases, ext2 block allocation is running at 3x to 5x less
than ideal.  Where is its sweet spot?


-

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTLEVAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 16:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTLEVAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 16:00:24 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:21077 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264471AbTLEVAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 16:00:09 -0500
Date: Fri, 5 Dec 2003 15:00:08 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Subject: sparse file performance (was Re: Is there a "make hole" (truncate in middle) syscall?)
Message-ID: <20031205150008.B14054@hexapodia.org>
References: <200312041432.23907.rob@landley.net> <20031204172348.A14054@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031204172348.A14054@hexapodia.org>; from adi@hexapodia.org on Thu, Dec 04, 2003 at 05:23:48PM -0600
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 05:23:48PM -0600, Andy Isaacson wrote:
> On Thu, Dec 04, 2003 at 02:32:23PM -0600, Rob Landley wrote:
> > What are the downsides of holes?  (How big do they have to be to
> > actually save space, is there a performance penalty to having a file
> > with 1000 4k holes in it, etc...)
> 
> It's filesystem-dependent; some filesystems don't implement sparse
> files.  The lower bound is one block; on extents-based filesystems like
> XFS it might be bigger.  (If you've got 1GB of data, then a 1MB block of
> zeros, then another GB of data, you're probably better off allocating a
> single 2GB extent rather than two smaller extents with a hole.)
> 
> There's no inherent downside to holey files; in fact they can be a
> straight-up performance win -- that's a block that doesn't need to be
> read from disk, just hand the user a COW pointer to your zero page.  And
> if you're lucky and the preceding and following blocks are allocated
> adjacent on disk, you can do it all as a single streaming IO.

I got curious enough to run some tests, and was suprised at the results.
My machine (Athlon XP 2400+, 2030 MHz, 512 MB, KT400, 2.4.22) can read
out of buffer cache at 234 MB/s, and off of its IDE disk at 40 MB/s.
I'd assumed that read(2)ing a holey file would go faster than reading
out of buffer cache; in theory you could do it completely in L1 cache
(with a 4KB buffer, it's just a ton of syscalls, some page table
manipulation, and a bunch of memcpy() out of a single zero page).  But
it turns out that reading a hole is *slower* than reading data from
buffer cache, just 195 MB/s.

200 MB file       234 MB/s  (with warm caches)
1 GB file          40 MB/s  (exceeds physical memory)
1 GB sparse file  195 MB/s

the 1GB sparse file was created with "dd if=file of=1gsparse bs=1M
count=1 seek=1023"; the filesystem is ext3.

Here's 'vmstat 5' while reading the 200MB file in a loop:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa

 1  0  50968   4468   4872 410424    0    0     0     9  102    46 62 38  0  0
 1  0  50968   4448   4892 410424    0    0     0     6  101    41 62 38  0  0
 1  0  50968   4428   4912 410424    0    0     0     6  101    40 62 38  0  0
 1  0  50968   4404   4936 410424    0    0     0     6  101    37 61 39  0  0
 1  0  50968   4384   4956 410424    0    0     0     8  105   117 60 40  0  0
 1  0  50968   4484   4984 410296    0    0     0     9  103    81 62 38  0  0

here's 'vmstat 5' while reading the 1GB sparse file in a loop:

 1  0  55448   4460   2464 417320    0    0   217     6  144  3117 45 49  6  0
 1  0  55448   4444   2480 417304    0    0   219     6  204  3237 50 44  6  0
 1  0  55448   4444   2488 417288    0    0   218     9  181  3200 49 45  6  0
 1  0  55460   4456   2468 417140   30    0   249     6  182  3193 46 48  6  0
 1  0  55460   4396   2484 417300    0    2   220    12  140  3084 46 48  6  0
 1  0  55460   4356   2464 417360    0    0   216     2  145  3101 47 48  6  0

The code is simply doing

        while((n = read(fd, buf, sizeof(buf))) > 0) {
                c += n;
                for(i=0; i < n; i++) {
                        hist[buf[i]]++;
                }
        }

compiled with gcc 3.3.2 -O2.

Code appended.

-andy

#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>

#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/time.h>
#include <fcntl.h>
#include <ctype.h>

static void
die(char *fmt, ...)
{
	va_list a;
	va_start(a, fmt);
	vfprintf(stderr, fmt, a);
	va_end(a);
	exit(1);
}

double tod(void)
{
	static struct timeval tv1;
	struct timeval tv2;
	double r;

	if(tv1.tv_sec == 0) {
		gettimeofday(&tv1, 0);
		return 0;
	}
	gettimeofday(&tv2, 0);
	r = (tv2.tv_sec - tv1.tv_sec) + (tv2.tv_usec - tv1.tv_usec) / 1e6;
	memcpy(&tv1, &tv2, sizeof(tv1));
	return r;
}

int main(int argc, char **argv)
{
	char buf[4096];
	int fd, i, n, m;
	long long c = 0;
	double t1, t2;
	int hist[256] = { 0 };
	unsigned char *p = buf;

	if(argc != 2) die("usage: %s file\n", argv[0]);

	if((fd = open(argv[1], O_RDONLY)) == -1)
		die("%s: %s\n", argv[1], strerror(errno));

	t1 = tod();
	while((n = read(fd, buf, sizeof(buf))) > 0) {
		c += n;
		for(i=0; i < n; i++) {
			hist[p[i]]++;
		}
	}
	t2 = tod();
	if(n == -1) die("read: %s\n", strerror(errno));

	m = 0;
	for(i=1; i<256; i++)
		if(hist[i] > hist[m]) m = i;
	printf("%lld characters read, mode at %d '%c' with %d\n",
			c, m, isprint(m) ? m : '?', hist[m]);
	printf("%f seconds, %f MB/sec\n", t2-t1, c / (t2-t1) / 1e6);
	return 0;
}

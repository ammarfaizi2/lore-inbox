Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUFYGRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUFYGRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 02:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUFYGRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 02:17:18 -0400
Received: from holomorphy.com ([207.189.100.168]:45455 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266227AbUFYGRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 02:17:02 -0400
Date: Thu, 24 Jun 2004 23:16:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, andrea@suse.de, nickpiggin@yahoo.com.au,
       tiwai@suse.de, ak@suse.de, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040625061627.GW21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, andrea@suse.de,
	nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de, ak@muc.de,
	tripperda@nvidia.com, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
References: <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624220823.GO21066@holomorphy.com> <20040624224529.GA30687@dualathlon.random> <20040624225121.GS21066@holomorphy.com> <20040624160945.69185c46.akpm@osdl.org> <20040624231549.GT21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624231549.GT21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/*
On Thu, Jun 24, 2004 at 04:09:45PM -0700, Andrew Morton wrote:
>> A testcase would be, on a 2G box:
>> a) free up as much memory as you can
>> b) write a 1.2G file to fill highmem with pagecache
>> c) malloc(800M), bzero(), sleep
>> d) swapoff -a
>> You now have a box which has almost all of lowmem pinned in anonymous
>> memory.  It'll limp along and go oom fairly easily.
>> Another testcase would be:
>> a) free up as much memory as you can
>> b) write a 1.2G file to fill highmem with pagecache
>> c) malloc(800M), mlock it
>> You now have most of lowmem mlocked.

On Thu, Jun 24, 2004 at 04:15:49PM -0700, William Lee Irwin III wrote:
> These are approximately identical to the testcases I had in mind, except
> neither of these is truly specific to 2GB and can have the various magic
> numbers calculated from sysconf() and/or meminfo.

It seems that glibc is fucking with sysinfo or something; hackish
workaround was to call sysconf(_SC_PAGESIZE) by hand for where mem_unit
would otherwise be needed and to treat the screwed-with sysinfo fields
as being in opaque units. Blame Uli.

At any rate, the result of running this with no swap online appears to
be that this just results in OOM kills whenever enough lowmem is needed.
This is expected, as the anonymous allocations aren't mlocked, so with
swap online, they would merely be swapped out, and with swap offline,
the nr_swap_pages deadlock is no longer possible (the nr_swap_pages fix
wasn't in place for this testing). Something more sophisticated may
have worse effects.

However, there were apparent oddities with premature failures of vma
allocations and piss poor vma merging observed. For instance, the
sbrk()/mmap() changeover logic to fall back on a per-iteration basis is
largely because sticking to mmap() and then changing over to sbrk()
when it fails switches over prematurely, and so failed to sufficiently
utilize lowmem. The failures to find the free areas for the vmas went
away after alternating between sbrk() and mmap(). Also, the 64KB
mmap()'s of the file aren't merged at all, despite being very very
blatantly sequential. I'll look into this.

The strategy of mmap()'ing locked pagecache is useless for PAE boxen in
general and so things should be taught to, say, mount ramfs, allocate
ramfs pagecache to fill highmem, and then go on to mmap() instead of
fiddling around mmap()'ing and mlock()'ing pagecache. I can implement
this if it's deemed necessary to have the testcase extensible to PAE.

The results are mixed. It's not clear that this behavior is
pathological, at least not in the manner Andrea described. It is,
however, easy to trigger workload failure as opposed to kernel deadlock.
It may help to clarify the general position on that kind of issue so I
know how and whether that should be addressed.

$ cat /proc/meminfo 
MemTotal:      1032988 kB
MemFree:        106684 kB
Buffers:          3804 kB
Cached:          16256 kB
SwapCached:          0 kB
Active:         897104 kB
Inactive:         2708 kB
HighTotal:      130816 kB
HighFree:       101388 kB
LowTotal:       902172 kB
LowFree:          5296 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             108 kB
Writeback:           0 kB
Mapped:         881912 kB
Slab:            18276 kB
Committed_AS:   911496 kB
PageTables:       1896 kB
VmallocTotal:   114680 kB
VmallocUsed:      2160 kB
VmallocChunk:   105244 kB
$ cat /proc/buddyinfo 
Node 0, zone      DMA      0      0      1      1      1      0      1      1      1      0      0 
Node 0, zone   Normal     56     14     59      2      3      0      1      1      1      0      0 
Node 0, zone  HighMem    777    315    349    360    505    236     61      1      0      0      0 
*/

#define _GNU_SOURCE
#define _FILE_OFFSET_BITS 64

#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <sys/sysinfo.h>

#define LENGTH_STEP		((off64_t)pagesize << 4)
#define MAX_RETRIES		64
#ifdef DEBUG
#define dprintf(fmt, arg...)	printf(fmt,##arg)
#else
#define dprintf(fmt, arg...)	do { } while (0)
#endif

#define die()								\
	do {								\
		fprintf(stderr, "failure %s (%d) at %s:%d\n",		\
			strerror(errno),  errno, __FILE__, __LINE__);	\
		fflush(stderr);						\
		sleep(60);						\
		exit(EXIT_FAILURE);					\
	} while (0)

int main(void)
{
	struct sysinfo info;
	char namebuf[64] = "/tmp/zoneDoS_XXXXXX";
	int i, fd, retries;
	off64_t len = 0;
	unsigned long *first, *last, *p, *first_buf, *last_buf, *q;
	unsigned long freehigh, freelow;
	long pagesize;

	first = last = NULL;
	first_buf = last_buf = NULL;
	if ((pagesize = sysconf(_SC_PAGESIZE)) < 0)
		die();
	if ((fd = mkstemp(namebuf)) < 0)
		die();
	if (unlink(namebuf))
		die();

	if (sysinfo(&info))
		die();
	retries = freehigh = 0;
	while (info.freehigh && retries < MAX_RETRIES) {
		if (ftruncate64(fd, len + LENGTH_STEP))
			die();
		p = mmap(NULL, LENGTH_STEP, PROT_READ|PROT_WRITE, MAP_SHARED, fd, len);
		if (p == MAP_FAILED)
			die();
		len += LENGTH_STEP;
		if (mlock(p, LENGTH_STEP))
			die();
		*p = 0;
		if (last)
			*last = (unsigned long)p;
		last = p;
		if (!first)
			first = p;
		freehigh = info.freehigh;
		if (sysinfo(&info))
			die();
		if (info.freehigh >= freehigh)
			retries++;
		else
			retries = 0;
		dprintf("allocated %lu kB, freehigh = %lu kB\n",
			(unsigned long)(len >> 10),
			(unsigned long)(info.freehigh >> 10));
	}

	if (sysinfo(&info))
		die();
	retries = freelow = 0;
	while (info.freeram - info.freehigh && retries < MAX_RETRIES) {
		q = mmap(NULL, LENGTH_STEP, PROT_READ|PROT_WRITE, MAP_ANONYMOUS, 0, 0);
		if (q == MAP_FAILED)
			q = sbrk(LENGTH_STEP);
		if (q == MAP_FAILED) {
			sleep(1);
			++retries;
			continue;
		}
		for (i = 0; i < LENGTH_STEP/sizeof(*q); i += pagesize/sizeof(*q))
			q[i + 1] = 1;
		*q = 0;
		if (last_buf)
			*last_buf = (unsigned long)q;
		last_buf = q;
		if (!first_buf)
			first_buf = q;
		freelow = info.freeram - info.freehigh;
		if (sysinfo(&info))
			die();
		if (info.freeram - info.freehigh >= freelow)
			++retries;
		else
			retries = 0;
		dprintf("freelow = %lu kB\n", (info.freeram - info.freehigh) >> 10);
	}

	dprintf("done allocating anonymous memory, freeing pagecache\n");
	while (first) {
		p = first;
		first = (unsigned long *)(*first);
		if (munmap(p, LENGTH_STEP))
			die();
	}
	close(fd);
	pause();
	return EXIT_SUCCESS;
}

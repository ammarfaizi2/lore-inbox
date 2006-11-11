Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946874AbWKKBsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946874AbWKKBsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 20:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946876AbWKKBsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 20:48:09 -0500
Received: from deepthought.armory.com ([192.122.209.42]:23048 "HELO armory.com")
	by vger.kernel.org with SMTP id S1946874AbWKKBsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 20:48:08 -0500
From: Bela Lubkin <filbo@armory.com>
Date: Fri, 10 Nov 2006 17:48:00 -0800
References: <FE74AC4E0A23124DA52B99F17F441597DA118C@PA-EXCH03.vmware.com> <p734pt7k8s0.fsf@bingen.suse.de> <FE74AC4E0A23124DA52B99F17F44159701DBBFE7@PA-EXCH03.vmware.com> <200611110123.38309.ak@suse.de>
X-Mailer: Mail User's Shell (7.2.6 beta(5) 1998-10-07 + patches)
To: Andi Kleen <ak@suse.de>
Subject: Re: touch_cache() only touches two thirds
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Message-ID: <200611101748.aa17359@deepthought.armory.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

Bela>> The corrected code in
Bela>> <http://bugzilla.kernel.org/show_bug.cgi?id=7476#c4> covers the
Bela>> full cache range.  Granted that modern CPUs may be able to track
Bela>> multiple simultaneous cache access streams: how many such streams
Bela>> are they likely to be able to follow at once?  It seems like
Bela>> going from 1 to 2 would be a big win, 2 to 3 a small win, beyond
Bela>> that it wouldn't likely make much incremental difference.  So
Bela>> what do the actual implementations in the field support?

Andi> I remember reading at some point that a POWER4 could track at
Andi> least 5+ parallel streams.  I don't know how many K8 handles, but
Andi> it is multiple too at least (forward and backwards)

Andi> I don't have more data, but at least the newer Intel CPUs seem to
Andi> be also very good at prefetching and when you look at a die photo
Andi> the L/S unit in general is quite big. More than 6 streams handled
Andi> is certainly a possibility.

Andi> I guess it could be figured out with some clever benchmarking.

Bela>> The code (original and corrected) uses 6 simultaneous streams.

Andi> My gut feeling is that this is not enough.

Bela>> I have a modified version that takes a `ways' parameter to
Bela>> use an arbitrary number of streams.  I'll post that onto
Bela>> bugzilla.kernel.org.

Andi> Post it to the list please.

Ok, will do.  I'm not real sure about list etiquette here.  A discussion
is underway on <http://bugzilla.kernel.org/show_bug.cgi?id=7476>.  Here
is the code I've posted there.  (Slightly newer versions here.)

First is a C program -- a test harness that embeds the new touch_cache()
routine (needs memory management work to go into kernel).  Then a shell
script I've been using to torture it.

The torture script tests it with cache lines up to 66-longs, and with up
to 656-way streaming (artifacts of the shell's $RANDOM ;-)

Moved this to my home account so I have some control over the mailer...

>Bela<

=============================================================================
/*
 * Test program to demonstrate touch_cache() algorithms
 *
 * Bela Lubkin 2006-11-10
 */

#include <stdio.h>
#include <stdlib.h>

/* Elements Per Displayline -- display parameter for self-check code */
#define EPD 64

/*
 * The following definitions describe the cache line size of the machine
 * architecture:
 *
 *   cache_t, here defined as `long', is a single cache element
 *   LPC, Longs Per Cacheline, is the number of elements per cache line
 *
 * For consistency, cache_t should probably be int32_t, and only LPC
 * should be varied to match various architectures.
 */

#define LPC 8
int	lpc = LPC;
typedef long cache_t;

bar()
{
	int i;

	printf("+");
	for (i = 0; i < EPD + (EPD / lpc) - 1; i++)
		printf("=");
	printf("+\n");
}

clear(cache_t *cache, int size)
{
	int i;

	for (i = -EPD; i < size + EPD; i++)
		cache[i] = 0;
}

/*
 * show() dumps the resulting touched cache and checks it for
 * correctness.
 *
 * The `misplaced' test isn't strictly necessary, as the actual goal is
 * merely to touch each cache line (anywhere within the line).  I found
 * the additional restriction useful to promote overall correctness
 * during the process of refining the touch_cache() algorithm.
 */
show(cache_t *cache, int size)
{
	int i;
	int missed = 0, underrun = 0, misplaced = 0, overrun = 0;

	for (i = -EPD; i < size + EPD; i++) {
		if ((i + EPD) % EPD == 0)
			printf("|");
		printf("%c", cache[i] ? '0' + cache[i] : (i < 0 || i >= size) ? '-' : '.');
		if ((i + EPD) % EPD == EPD - 1)
			printf("\n");
		else if ((i + EPD) % lpc == lpc - 1)
			printf(":");
		if (i >= 0 && i < size && (i % lpc) == 0 && cache[i] == 0)
			missed++;
		if (cache[i]) {
			if (i < 0)
				underrun += cache[i];
			if (i >= size)
				overrun += cache[i];
			if (i % lpc != 0)
				misplaced += cache[i];
		}
	}
	if ((i + EPD) % EPD != 0)
		printf("\n");
	if (missed)
		printf("ERROR: %d cache lines were missed!\n", missed);
	if (underrun)
		printf("ERROR: %d writes before beginning of buffer!\n", underrun);
	if (overrun)
		printf("ERROR: %d writes after end of buffer!\n", overrun);
	if (misplaced)
		printf("ERROR: %d writes at unexpected alignments within a cache line!\n", misplaced);
	if (missed || underrun || misplaced || overrun)
		exit(1);
}

static int *waystart;

/*
 * When putting into kernel, use vmalloc()/vfree();
 * change error handling.
 */

prep_ways(int ways, int size)
{
	int way, waysize = size / ways;

	/* one extra `way' is used when `ways' is odd */
	/* (actually, only the even elements of this array are used) */
	waystart = (int *)malloc((ways + 1) * sizeof(*waystart));

	if (!waystart) {
		fprintf(stderr, "malloc failed\n");
		exit(1);
	}

	for (way = 0; way < ways + 1; way++) {
		if ((way & 1) == 0)
			/* even `waystart' points to 1st line in its `way' */
			waystart[way] = way * waysize;
		else
			/* odd `waystart' points to last line in its `way' */
			waystart[way] = (way + 1) * waysize - lpc;
		/* align to next cache line */
		waystart[way] = lpc * ((waystart[way] + lpc - 1) / lpc);
	}
}

free_ways()
{
	free(waystart);
}

touch_cache(cache_t *cache, int ways, int size)
{
	int way, i;

	/*
	 * We access the buffer via `ways' independent 'streams' of
	 * read/write access which are interleaved; every other one
	 * is written backwards.  This is supposed to keep the cache
	 * from recognizing any linear access pattern.
	 *
	 * [--->     <---|--->     <---|--->     <---]
	 *
	 * We touch every cacheline in the buffer (32 bytes on 32-bit
	 * systems, 64 bytes on 64-bit systems; actually now `lpc *
	 * sizeof(cache_t)', could be determined at runtime).
	 */
	for (i = 0; i < size / ways; i += lpc) {
		for (way = 0; way < ways; way++) {
			if ((way & 1) == 0)
				cache[waystart[way] + i]++;
			else
				cache[waystart[way] - i]++;
		}
	}
}

main(int argc, char *argv[])
{
	int i;
	int size, ways;
	cache_t *cache;

	size = atoi(argv[1]);
	ways = atoi(argv[2]);
	if (argc > 3)
		lpc = atoi(argv[3]);
	if (argc < 3 || ways <= 0 || size < ways) {
		fprintf(stderr, "usage: touch_cache cache_size ways [longs-per-cacheline]\n");
		fprintf(stderr, "       cache_size >= ways\n");
		exit(1);
	}

	/*
	 * This is a bit of a shuck, papering over the fact that it's
	 * hard to get perfect 1:1 cache line coverage in an odd-sized
	 * buffer...
	 */
	if (size % (ways * lpc)) {
		printf("cache_size should be a multiple of %d * ways\n", lpc);
		printf("Raising cache_size...\n");
		size = (lpc * ways) * (1 + size / lpc / ways);
	}

	printf("size: %d, ways: %d, longs-per-cacheline: %d\n", size, ways, lpc);

	/* allocate an extra 2*EPD cache elements, two display lines,
	   to demonstrate not running off the ends of the buffer */
	cache = (cache_t *)malloc((EPD * 2 + size) * sizeof(*cache));
	cache += EPD;

	if (!cache) {
		fprintf(stderr, "malloc failed\n");
		exit(1);
	}

	clear(cache, size);
	prep_ways(ways, size);

	touch_cache(cache, ways, size);

	free_ways();

	bar();
	show(cache, size);
	bar();

	exit(0);
}
=============================================================================
#!/bin/bash

# Torture the touch_cache() algorithm.
#
# This produces about 24MB of output.  Any "ERROR" messages indicate a
# problem; the rest should be rather boring.  Run as:
#
#   ./touch_cache.test.sh > touch_cache.test.out
#   grep -i error touch_cache.test.out

exec 2>&1

i=0
err=0
while [ $i -lt 1000 ]; do
  let i=i+1
  let size=$RANDOM+1
  let ways=$RANDOM/50+1
  case $RANDOM in
    1[01234]???) lpc=4;;
    1[56789]???) lpc=8;;
    2[01234]???) lpc=16;;
    2[56789]???) lpc=32;;
          3????) lpc=64;;
          *) let lpc=$RANDOM/500+1;;
  esac
  if [ $ways -gt $size ]; then
    x=$ways
    ways=$size
    size=$x
  fi
  ./touch_cache $size $ways $lpc || let err=err+1
done
if [ $err -gt 0 ]; then
  echo ERROR: errors above, check output
else
  echo Test completed with no errors.
fi

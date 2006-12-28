Return-Path: <linux-kernel-owner+w=401wt.eu-S964834AbWL1DFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWL1DFr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 22:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWL1DFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 22:05:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53368 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964834AbWL1DFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 22:05:46 -0500
Date: Wed, 27 Dec 2006 19:04:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: ranma@tdiedrich.de, gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <20061227.165246.112622837.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net>
 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Dec 2006, David Miller wrote:
> > 
> > I still don't see _why_, though. But maybe smarter people than me can see 
> > it..
> 
> FWIW this program definitely triggers the bug for me.

Ok, now that I have something simple to do repeatable stuff with, I can 
say what the pattern is.. It's not all that surprising, but it's still 
worth just stating for the record.

What happens is that when I do the "packetized writes" in random order, 
the _last_ write to a page occasionally just goes missing. It's not always 
at the end of a page, as shown by for example:

 - A whole chunk got dropped:

	Chunk 2094 corrupted (0-1459)  (1624-3083)
	Expected 46, got 0
	Written as (30912)55414(10000)

   That "Written as (x)y(z)" line means that the corrupted chunk was 
   written as chunk #y, and the preceding and following chunks (that were 
   _not_ corrupt) on the page was written as #x and #z respectively.

   In other words, the missing chunk (which is still zero) was written 
   much later than the ones that were ok, and never hit the disk. It's a 
   contiguous chunk in the middle of the page (chunks are 1460 bytes in 
   size)

   The first line means that all bytes of the chunk (0-1459) were 
   corrupted, and the values in parenthesis are the offsets within a page. 
   In other words, this was a chunk in the _middle_ of a page.

 - The missing data can also be at the beginning or ends of pages:

   Beginning of the chunk missing, it was at the end of a page (page 
   offsets 3288-4095) and the _next_ page got written out fine:

	Chunk 2126 corrupted (0-807)  (3288-4095)
	Expected 78, got 0
	Written as (32713)55573(14301)

   End of a chunk missing, it was the beginning of a page (and the 
   _previous_ page that contained the beginning of the chunk was written 
   out fine)

	Chunk 2179 corrupted (1252-1459)  (0-207)
	Expected 131, got 0
	Written as (45189)55489(15515)

Now, the reason I say this isn't surprising is that this is entirely 
consistent with the dirty bit being dropped on the floor somewhere, and 
likely through some interaction with the previous changes being in the 
process of being written out.

Something (incorrectly) ends up deciding that it doesn't need to write the 
page, since it's already written, or alternatively clears the dirty bit 
too late (clears it because an _earlier_ write finished, never mind that 
the new dirty data didn't make it).

I also figured out that it's not the low-memory situation that does it, it 
really must be the "page_mkclean()" triggering. Becuase I can do

	echo 5 > /proc/sys/vm/dirty_ratio
	echo 3 > /proc/sys/vm/dirty_background_ratio

to make it clean the pages much more aggressively than the default, and I 
can see corruption on my 256MB machine with just a 40MB shared file, and 
70MB of memory consistently free.

So this thing is definitely giving some answers. It's NOT about low 
memory, and it very much seems to be about the whole "balance_dirty_ratio" 
thing. I don't think I triggered the actual low-memory stuff once in that 
situation..

So I have some more data on the behaviour, but I _still_ don't see the 
reason behind it. It's probably something really obvious once it's pointed 
out..

[ Modified test-program that tells you where the corruption happens (and 
  when the missing parts were supposed to be written out) appended, in 
  case people care. ]

			Linus

---
#include <sys/mman.h>
#include <sys/fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>

#define TARGETSIZE (100 << 20)
#define CHUNKSIZE (1460)
#define NRCHUNKS (TARGETSIZE / CHUNKSIZE)
#define SIZE (NRCHUNKS * CHUNKSIZE)

static void fillmem(void *start, int nr)
{
	memset(start, nr, CHUNKSIZE);
}

#define page_offset(buf, off) (0xfff & ((unsigned)(unsigned long)(buf)+(off)))

static int chunkorder[NRCHUNKS];

static int order(int nr)
{
	int i;
	if (nr < 0 || nr >= NRCHUNKS)
		return -1;
	for (i = 0; i < NRCHUNKS; i++)
		if (chunkorder[i] == nr)
			return i;
	return -2;
}

static void checkmem(void *buf, int nr)
{
	unsigned int start = ~0u, end = 0;
	unsigned char c = nr, *p = buf, differs = 0;
	int i;
	for (i = 0; i < CHUNKSIZE; i++) {
		unsigned char got = *p++;
		if (got != c) {
			if (i < start)
				start = i;
			if (i > end)
				end = i;
			differs = got;
		}
	}
	if (start < end) {
		printf("Chunk %d corrupted (%u-%u)  (%u-%u)            \n", nr, start, end,
			page_offset(buf, start), page_offset(buf, end));
		printf("Expected %u, got %u\n", c, differs);
		printf("Written as (%d)%d(%d)\n", order(nr-1), order(nr), order(nr+1));
	}
}

static char *remap(int fd, char *mapping)
{
	if (mapping) {
		munmap(mapping, SIZE);
		posix_fadvise(fd, 0, SIZE, POSIX_FADV_DONTNEED);
	}
	return mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
}

int main(int argc, char **argv)
{
	char *mapping;
	int fd, i;

	/*
	 * Make some random ordering of writing the chunks to the
	 * memory map..
	 *
	 * Start with fully ordered..
	 */
	for (i = 0; i < NRCHUNKS; i++)
		chunkorder[i] = i;

	/* ..and then mix it up randomly */
	srandom(time(NULL));
	for (i = 0; i < NRCHUNKS; i++) {
		int index = (unsigned int) random() % NRCHUNKS;
		int nr = chunkorder[index];
		chunkorder[index] = chunkorder[i];
		chunkorder[i] = nr;
	}

	fd = open("mapfile", O_RDWR | O_TRUNC | O_CREAT, 0666);
	if (fd < 0)
		return -1;
	if (ftruncate(fd, SIZE) < 0)
		return -1;
	mapping = remap(fd, NULL);
	if (-1 == (int)(long)mapping)
		return -1;

	for (i = 0; i < NRCHUNKS; i++) {
		int chunk = chunkorder[i];
		printf("Writing chunk %d/%d (%d%%)     \r", i, NRCHUNKS, 100*i/NRCHUNKS);
		fillmem(mapping + chunk * CHUNKSIZE, chunk);
	}
	printf("\n");

	/* Unmap, drop, and remap.. */
	mapping = remap(fd, mapping);

	/* .. and check */
	for (i = 0; i < NRCHUNKS; i++) {
		int chunk = i;
		printf("Checking chunk %d/%d (%d%%)     \r", i, NRCHUNKS, 100*i/NRCHUNKS);
		checkmem(mapping + chunk * CHUNKSIZE, chunk);
	}
	printf("\n");
	
	return 0;
}

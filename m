Return-Path: <linux-kernel-owner+w=401wt.eu-S964829AbWL1AkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWL1AkN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWL1AkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:40:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46577 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964829AbWL1AkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:40:11 -0500
Date: Wed, 27 Dec 2006 16:39:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: ranma@tdiedrich.de, gordonfarquharson@gmail.com, tbm@cyrius.com,
       a.p.zijlstra@chello.nl, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
References: <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org> <20061226161700.GA14128@yamamaya.is-a-geek.org>
 <20061226.205518.63739038.davem@davemloft.net> <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Dec 2006, Linus Torvalds wrote:
> 
> I think the test-case could probably be improved by having a munmap() and 
> page-cache flush in between the writing and the checking, to see whether 
> that shows the corruption easier (and possibly without having to start 
> paging in order to throw the pages out, which would simplify testing a 
> lot).

I think the page-writeout is implicated, because I do seem to need it, but 
the page-cache flush does seem to make corruption _easier_ to see. I now 
seem about to trigger it with a 100MB file on a 256MB machine in a minute 
or so, with this slight modification.

I still don't see _why_, though. But maybe smarter people than me can see 
it..

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

static void checkmem(void *start, int nr)
{
	unsigned char c = nr, *p = start;
	int i;
	for (i = 0; i < CHUNKSIZE; i++) {
		if (*p++ != c) {
			printf("Chunk %d corrupted           \n", nr);
			return;
		}
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
	static int chunkorder[NRCHUNKS];

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

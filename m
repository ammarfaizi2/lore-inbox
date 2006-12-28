Return-Path: <linux-kernel-owner+w=401wt.eu-S964839AbWL1AQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWL1AQj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWL1AQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:16:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45009 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964842AbWL1AQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:16:38 -0500
Date: Wed, 27 Dec 2006 16:16:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: ranma@tdiedrich.de, gordonfarquharson@gmail.com, tbm@cyrius.com,
       a.p.zijlstra@chello.nl, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <20061226.205518.63739038.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
References: <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org> <20061226161700.GA14128@yamamaya.is-a-geek.org>
 <20061226.205518.63739038.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Dec 2006, David Miller wrote:
> 
> I've seen it on sparc64, UP kernel, no preempt.

Ok, I still don't have a clue, but I think I at least have a new 
test-case.

It can probably be improved upon, but this would _seem_ to trigger the 
problem. Can people check?

You'd want to make sure you get page-put activity, by making TARGETSIZE be 
big enough to cause memory pressure (and rather than making it bigger, you 
might want to make your memory smaller instead, to make it run more 
quickly. Either using "mem=128M" or big compiles or something...).

If it finds corruption, you'll see something like

	Writing chunk 183858/183859 (99%)
	Chunk ..
	Chunk 120887 corrupted
	Chunk 122372 corrupted
	Chunk ...
	Checking chunk 183858/183859 (99%)

otherwise it will just say

	Writing chunk 183858/183859 (99%)
	Checking chunk 183858/183859 (99%)

and exit.

I didn't spend a lot of time verifying this, but I _was_ able to cause 
those "Chunk xxx corrupted" messages with this. There's probably a more 
efficient better way to do it, but this is better than trying to use 
rtorrent, and also makes any worries about what rtorrent does go away.

Of course, maybe it's this test-program that is buggy now, although it 
looks trivial enough that I don't think it is.

I think my earlier stress-tester may not have triggered this, because it 
just did all its writing in a linear order, so any LRU logic will happen 
to write back old pages that we are no longer touching. The randomization 
(and using a chunksize that isn't a multiple of a page-size) makes sure 
that we're actually going to have lots of rewriting going on.

I think the test-case could probably be improved by having a munmap() and 
page-cache flush in between the writing and the checking, to see whether 
that shows the corruption easier (and possibly without having to start 
paging in order to throw the pages out, which would simplify testing a 
lot). But I haven't tested. I decided to post this asap, now that I've 
recreated the corruption with something else, and something that is 
possibly easier to analyze..

		Linus

----
#include <sys/mman.h>
#include <sys/fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>

#define TARGETSIZE (256 << 20)
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
			printf("Chunk %d corrupted               \n", nr);
			return;
		}
	}
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
	mapping = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (-1 == (int)(long)mapping)
		return -1;

	for (i = 0; i < NRCHUNKS; i++) {
		int chunk = chunkorder[i];
		printf("Writing chunk %d/%d (%d%%)     \r", i, NRCHUNKS, 100*i/NRCHUNKS);
		fillmem(mapping + chunk * CHUNKSIZE, chunk);
	}
	printf("\n");
	for (i = 0; i < NRCHUNKS; i++) {
		int chunk = i;
		printf("Checking chunk %d/%d (%d%%)     \r", i, NRCHUNKS, 100*i/NRCHUNKS);
		checkmem(mapping + chunk * CHUNKSIZE, chunk);
	}
	printf("\n");
	
	return 0;
}

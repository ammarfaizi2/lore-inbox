Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVGVO3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVGVO3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVGVO3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:29:07 -0400
Received: from science.horizon.com ([192.35.100.1]:59213 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262100AbVGVO1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:27:53 -0400
Date: 22 Jul 2005 10:38:57 -0000
Message-ID: <20050722103857.17907.qmail@science.horizon.com>
From: linux@horizon.com
To: naber@inl.nl
Subject: Re: a 15 GB file on tmpfs
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a 15 GB file which I want to place in memory via tmpfs. I want to do 
> this because I need to have this data accessible with a very low seek time.

It should work fine.  tmpfs has the same limits as any other file system,
2 TB or more, and more than that with CONFIG_LBD.

NOTE, however, that tmpfs does NOT guarantee the data will be in RAM!  It
uses the page cache just like any other file system, and pages out unused
data just like any other file system.  If you just want average-case fast,
it'll work fine.  If you want guaranteed fast, you'll have to work harder.

> I want to know if this is possible before spending 10,000 euros on a machine 
> that has 16 GB of memory. 

So create a 15 GB file on an existing machine.  Make it sparse, so you
don't need so much RAM, but test to verify that the kernel doesn't
wrap at 4 GB, and can keep the data at offsets 0, 4 GB, 8 GB, and 12 GB
separate.

Works for me (test code below).

> The machine we plan to buy is a HP Proliant Xeon machine and I want to run a 
> 32 bit linux kernel on it (the xeon we want doesn't have the 64-bit stuff 
> yet)

If you're working with > 4GB data sets, I would recommend you think VERY hard
before deciding not to get a 64-bit machine.  If you could just put all 15 GB
into your application's address space:
- The application would be much simpler and faster.
- The kernel wouldn't be slowed by HIGHMEM workarounds.  It's not that bad,
  but it's definitely noticeable.
- Your expensive new machine won't be obsolete quite as fast.

I'd also like to mention that AMD's large L2 TLB is enormously helpful when
working with large data sets.  It's not discussed much on the web sites that
benchmark with games, but it really helps crunch a lot of data.



#define _GNU_SOURCE
#define _FILE_OFFSET_BITS 64
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>

#define STRIDE (1<<20)

int
main(int argc, char **argv)
{
	int fd;
	off_t off;

	if (argc != 2) {
		fprintf(stderr, "Wrong number of arguments: %u\n", argc);
		return 1;
	}
	fd = open(argv[1], O_RDWR|O_CREAT|O_LARGEFILE, 0666);
	if (fd < 0) {
		perror(argv[1]);
		return 1;
	}

	for (off = 0; off < 0x400000000LL; off += STRIDE) {
		char buf[40];
		off_t res;
		ssize_t ss1, ss2;;

		ss1 = sprintf(buf, "%llu", off);

		res = lseek(fd, off, SEEK_SET);
		if (res == (off_t)-1) {
			perror("lseek");
			return 1;
		}
		ss2 = write(fd, buf, ++ss1);
		if (ss2 != ss1) {
			perror("write");
			return 1;
		}
	}

	for (off = 0; off < 0x400000000LL; off += STRIDE) {
		char buf[40], buf2[40];
		off_t res;
		ssize_t ss1, ss2;;

		ss1 = sprintf(buf, "%lld", off);

		res = lseek(fd, off, SEEK_SET);
		if (res == (off_t)-1) {
			perror("lseek");
			return 1;
		}

		ss2 = read(fd, buf2, ++ss1);
		if (ss2 != ss1 || memcmp(buf, buf2, ss1) != 0) {
			fprintf(stderr, "Mismatch at %llu: %.*s vs. %s\n", off, (int)ss2, buf2, buf);
			return 1;
		}
	}
	printf("All tests succeeded.\n");
	return 0;
}


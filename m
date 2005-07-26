Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVGZWKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVGZWKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVGZWKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:10:13 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:57777 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262166AbVGZWJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:09:57 -0400
Subject: Re: Memory pressure handling with iSCSI
From: Adam Litke <agl@us.ibm.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: "Badari Pulavarty [imap]" <pbadari@us.ibm.com>,
       Rik van Riel <riel@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <148380000.1122413605@flay>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	 <Pine.LNX.4.61.0507261659250.1786@chimarrao.boston.redhat.com>
	 <1122411949.6433.50.camel@dyn9047017102.beaverton.ibm.com>
	 <148380000.1122413605@flay>
Content-Type: text/plain
Organization: IBM
Message-Id: <1122415509.3274.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 26 Jul 2005 17:05:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 16:33, Martin J. Bligh wrote:
> >> > After KS & OLS discussions about memory pressure, I wanted to re-do
> >> > iSCSI testing with "dd"s to see if we are throttling writes.  
> >> 
> >> Could you also try with shared writable mmap, to see if that
> >> works ok or triggers a deadlock ?
> > 
> > 
> > I can, but lets finish addressing one issue at a time. Last time,
> > I changed too many things at the same time and got no where :(
> 
> Adam is working that one, but not over iSCSI.

I wrote a simple/ugly C program to demonstrate the MAP_SHARED,PROT_WRITE
case.  I was able to saturate the system with 75% of all memory in dirty
pages before I got bored.

To reproduce:
- Create a 3GB file with dd
- ./map-shared-dirty bigfile <number of chunks>

I break up the mmap & dirty operation into chunks in case the system is
tight on memory.  Choose a large enough number of chunks so the
individual mmaps will be small enough for your system to accomodate.

-- 

MemTotal:      4092492 kB
MemFree:        786988 kB
Buffers:          6372 kB
Cached:        3211388 kB
SwapCached:          0 kB
Active:        3197428 kB
Inactive:        36696 kB
HighTotal:     3211264 kB
HighFree:         1024 kB
LowTotal:       881228 kB
LowFree:        785964 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:         3117300 kB
Writeback:        3568 kB
Mapped:          24780 kB
Slab:            59316 kB
Committed_AS:    49760 kB
PageTables:        780 kB
VmallocTotal:   114680 kB
VmallocUsed:        32 kB
VmallocChunk:   114648 kB

/*
 * map-shared-dirty.c - Demonstrate a loophole in dirty-ratio when 
 * heavily dirtying MAP_SHARED memory.
 *
 * Usage: (I know it's ugly)
 * ./map-shared-dirty <large file> <number of chunks>
 */

#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdio.h>

size_t page_size;

void dirty_file(int fd, unsigned long bytes, size_t map_offset) {
	char *addr;
	
	addr = mmap(NULL, bytes, PROT_READ|PROT_WRITE, MAP_SHARED, fd, map_offset);
	if (addr == MAP_FAILED) {
		fprintf(stderr, "Failed to map file\n");
		fprintf(stderr, "bytes: %i offset: %i\n", bytes,map_offset);
		exit(1);
	}
	
	/* Dirty the pages */
	memset(addr, map_offset%255, bytes);

	munmap(addr, bytes);
}

int main(int argc, char **argv)
{
	char *filename = argv[1];
	int chunks = atoi(argv[2]);
	int fd;
	unsigned long i, chunk_size, bytes;
	struct stat file_info;

	fd = open(filename, O_RDWR|0100000); /* O_LARGEFILE */
	if (fd <= 0) {
		fprintf(stderr, "Failed to open file\n");
		exit(1);
	}
	fstat(fd, &file_info);
	bytes = file_info.st_size;
	
	page_size = getpagesize();
	chunk_size = (bytes / chunks) & ~(page_size - 1);
	printf("Chunk size = %i\n", chunk_size);
	for (i = 0; i < bytes; i+=chunk_size)
		dirty_file(fd, chunk_size, i);
	
	exit(0);
}


-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center


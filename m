Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbSLKCZM>; Tue, 10 Dec 2002 21:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbSLKCZM>; Tue, 10 Dec 2002 21:25:12 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27897 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id <S266969AbSLKCZJ>;
	Tue, 10 Dec 2002 21:25:09 -0500
Date: Tue, 10 Dec 2002 18:32:54 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: possible cache aliasing problem with O_DIRECT?
Message-ID: <20021210183254.Y8642@mvista.com>
References: <20021210182051.X8642@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021210182051.X8642@mvista.com>; from jsun@mvista.com on Tue, Dec 10, 2002 at 06:20:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


... forgot the attachment, possibly due to the same memory 
corruption problem. :-)

Also, the problem is discovered in 2.4.18.  I checked with 2.4.19
and it appears it should be there as well.

Jun

On Tue, Dec 10, 2002 at 06:20:51PM -0800, Jun Sun wrote:
> 
> I am chasing a problem which might be a cache aliasing problem
> when a disk file is opened with O_DIRECT flag.
> 
> I attached the source code of two programs.  One generates a binary file
> and the other opens the file with O_DIRECT and reads it.  It checks
> the content of the file while reading it.
> 
> I tested this on a MIPS board with NEC vr5432 CPU, which has a
> virtually indexed, two-way set associative d-cache, and can easily 
> re-produce the data corruption problem.
> 
> I attached a patch which apparently solves the problem.
> 
> I am not an expert in fs and mm, but my guess is:
> 
> 1) user process allocates a big buffer
> 2) the user buffer is mapped into kernel virtual space for doing direct IO 
>    through map_user_kiobuf()
> 3) since the virtual address for buffer area is different in user space
>    from that in kernel virtual, kernel should do a flush cache for those
>    pages after doing the IO.  That is why my attached patch makes it work.
> 
> Does this make sense?
> 
> However, I still have some puzzles.  For it to work completely, another
> cache flushing needs to be done for the address range of the buffer in user
> space.  I thought this should be done some where inside map_user_kiobuf()
> but could not find it anywhere.  Did I miss it?  Or it just happens to work
> even without it?
> 
> Another puzzling part is that I also tested the program on another couple
> of MIPS boards which *should* suffer from this problem, but failed to 
> re-produce it.
> 
> Any thoughts?
> 
> Jun
> 

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gen-file.c"


/*
 * generate a binary file with 33554432/4 32-bit integers.  The
 * integers range from 0 to 33554432/4-1.
 *
 * This file is used by my-diotest.c.
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define		TOTAL_SIZE		33554432

main()
{
	int intsize=TOTAL_SIZE/4;
	int f;
	int i;
	int ret;
	assert(sizeof(i) == 4);
	f=open("srcdata-ordered", O_RDWR | O_CREAT);
	assert(f > 0);
	for (i=0; i< intsize; i++) {
		ret=write(f, &i, sizeof(i));
		assert(ret == sizeof(i));
	}
	close(f);
}

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="my-diotest.c"


/*
 * test program to demonstrate possible cache aliasing problem with O_DRECT
 * option on IDE files.
 *
 * Problem exists on NEC rochopper boards with vr5432/vr5500 CPUs.  However
 * it did not show up with vr4131 cpu and toshiba CPUs, which is unexpected.
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define IOSIZE  32768

void *aligned_alloc(int size, int align)
{
	void *p = malloc(size + align);
	return (void*) (((unsigned)p + align-1) / align * align);
}

void check_buffer(char *p, int round)
{
	int *q= (int*)p;
	int intsize = IOSIZE / 4;
	int i;
	int base=round*intsize;
	for (i=0; i< intsize; i++, q++)	
		if (*q != base+i) 
			printf("error at (%d, %d): got %d, expect %d\n",
				round, i, *q, base+i);
}

void dcp(int sfd)
{
	int zfd;
	int r, w;
	char *p;
	int round=0;

#if 0
	zfd = open("/dev/zero", O_RDWR);
	p = mmap(NULL, IOSIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE, zfd, 0);
	close(zfd);
#endif
	p = aligned_alloc(IOSIZE, 4096);
	printf("buffer alloced/mapped to memory area: %x\n", p);

	while (1) {
		memset(p, 0, IOSIZE);
		r = read(sfd, p, IOSIZE);
		if (r <= 0) break;
		check_buffer(p, round);
		round++;
	}
}

int
main(int argc, char *argv[])
{
	int sfd;
	int ret;

	sfd = open(argv[1], O_RDONLY | O_DIRECT);
	printf ("sfd ret = %d\n", sfd);
	dcp(sfd);
	return 0;
}

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="o_direct-cache-flush.patch"

diff -Nru mm/filemap.c.orig mm/filemap.c
--- mm/filemap.c.orig	Mon Dec  9 18:27:41 2002
+++ mm/filemap.c	Tue Dec 10 17:13:41 2002
@@ -1550,9 +1550,13 @@
 
 		retval = mapping->a_ops->direct_IO(rw, inode, iobuf, (offset+progress) >> blocksize_bits, blocksize);
 
-		if (rw == READ && retval > 0)
+		if (rw == READ && retval > 0) {
+			int i;
+			for (i=0; i< iobuf->nr_pages; i++)
+				flush_page_to_ram(iobuf->maplist[i]);
 			mark_dirty_kiobuf(iobuf, retval);
-		
+		}
+
 		if (retval >= 0) {
 			count -= retval;
 			buf += retval;

--Yylu36WmvOXNoKYn--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131976AbRDFQrw>; Fri, 6 Apr 2001 12:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbRDFQrn>; Fri, 6 Apr 2001 12:47:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17004 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131976AbRDFQr2>; Fri, 6 Apr 2001 12:47:28 -0400
Date: Fri, 6 Apr 2001 19:07:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2 times faster rawio and several fixes (2.4.3aa3)
Message-ID: <20010406190701.H28118@athlon.random>
In-Reply-To: <20010406183440.B28118@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010406183440.B28118@athlon.random>; from andrea@suse.de on Fri, Apr 06, 2001 at 06:34:40PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 06:34:40PM +0200, Andrea Arcangeli wrote:
> 2.4.3aa3 with rawio-1:
> 
> root@alpha:/home/andrea > time ./rawio-bench 
> Opening /dev/raw1
> Allocating 50MB of memory
> Reading from /dev/raw1
> Writing data to /dev/raw1
> 
> real    0m5.208s
> user    0m0.001s
> sys     0m1.162s
> root@alpha:/home/andrea > time ./rawio-bench 
> Opening /dev/raw1
> Allocating 50MB of memory
> Reading from /dev/raw1
> Writing data to /dev/raw1
> 
> real    0m5.233s
> user    0m0.002s
> sys     0m1.184s
> root@alpha:/home/andrea > time ./rawio-bench 
> Opening /dev/raw1
> Allocating 50MB of memory
> Reading from /dev/raw1
> Writing data to /dev/raw1
> 
> real    0m5.378s
> user    0m0.002s
> sys     0m1.213s
> root@alpha:/home/andrea > time ./rawio-bench 
> Opening /dev/raw1
> Allocating 50MB of memory
> Reading from /dev/raw1
> Writing data to /dev/raw1
> 
> real    0m5.258s
> user    0m0.001s
> sys     0m1.183s
> root@alpha:/home/andrea > 

with this patch:

--- 2.4.3aa/include/linux/iobuf.h	Fri Apr  6 16:33:12 2001
+++ /misc/andrea-alpha/2.4.3aa/include/linux/iobuf.h	Fri Apr  6 18:31:23 2001
@@ -24,7 +24,7 @@
  * entire iovec.
  */
 
-#define KIO_MAX_ATOMIC_IO	512 /* in kb */
+#define KIO_MAX_ATOMIC_IO	1024 /* in kb */
 #define KIO_STATIC_PAGES	(KIO_MAX_ATOMIC_IO / (PAGE_SIZE >> 10) + 1)
 #define KIO_MAX_SECTORS		(KIO_MAX_ATOMIC_IO * 2)
 

applied on top of 2.4.3aa3 I get even better results:

alpha:/home/andrea # time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m4.898s
user    0m0.003s
sys     0m1.138s
alpha:/home/andrea # time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m4.935s
user    0m0.002s
sys     0m1.159s
alpha:/home/andrea # time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m4.925s
user    0m0.003s
sys     0m1.162s
alpha:/home/andrea # time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m4.941s
user    0m0.004s
sys     0m1.166s
alpha:/home/andrea # 

this is most probably beacuse I'm striping on two scsi disks and this way we can send
512k requests to each disk.

NOTE: also userspace reads and writes have to be >=512kbytes in granularity or
you'll generate small requests because rawio in always synchronous. And using
decent sized write/reads is good idea anyways to reduce the enter/exit kernel
overhead.

However we can probably stay with the 512k atomic I/O otherwise the iobuf
structure will grow again of an order of 2. With 512k of atomic I/O the kiovec
structure is just 8756 in size (infact probably I should allocate some of the
structures dynamically instead of statics inside the kiobuf.. as it is now
with my patch it's not very reliable as it needs an allocation of order 2).

BTW, some more description on the testcase: it first read 50mbytes physically
contigous and then it lseek to zero and writes 50mbytes. Disk throughput in
mean is 100mbyte/5sec = 20mbyte/sec.

It uses anonymous memory as in-core backend. It looks perfect testcase to me
and they're the faster disks I have here around.

Here the proggy:

/* 2001 Andrea Arcangeli <andrea@suse.de> */

#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <asm/page.h>

#define MB (1024*1024)
#define BUFSIZE (50*MB)

main()
{
	int fd, size, ret;
	int filemap;
	char * buf, * end, * tmp;

	printf("Opening /dev/raw1\n");
	fd = open("/dev/raw1", O_RDWR);
	if (fd < 0)
		perror("open /dev/raw1"), exit(1);

#if 1
	printf("Allocating %dMB of memory\n", BUFSIZE/MB);
	buf = (char *) malloc(BUFSIZE);
	if (buf < 0)
		perror("malloc"), exit(1);
	end = (char *) ((unsigned long) (buf + BUFSIZE) & PAGE_MASK);
	buf = (char *) ((unsigned long)(buf + ~PAGE_MASK) & PAGE_MASK);
#else
	printf("Mapping %dMB of memory\n", BUFSIZE/MB);
	filemap = open("deleteme", O_RDWR|O_TRUNC|O_CREAT, 0644);
	if (filemap < 0)
		perror("open"), exit(1);
	{
		int i;
		char buf[4096];
		for (i = 0; i < BUFSIZE; i += 4096)
			write(filemap, &buf, 4096);
	}
	ftruncate(filemap, BUFSIZE);
	buf = mmap(0, BUFSIZE, PROT_READ|PROT_WRITE, MAP_SHARED, filemap, 0);
	if ((long) buf < 0)
		perror("mmap"), exit(1);
	if ((unsigned long) buf & ~PAGE_MASK)
		perror("mmap misaligned"), exit(1);
	end = buf + BUFSIZE;
#endif
	size = end - buf;

	printf("Reading from /dev/raw1\n");
	ret = read(fd, buf, size);
	if (ret < 0)
		perror("read /dev/raw1"), exit(1);
	if (ret != size)
		fprintf(stderr, "read only %d of %d bytes\n", ret, size);
	printf("Writing data to /dev/raw1\n");
	if (lseek(fd, 0, SEEK_SET) < 0)
		perror("lseek"), exit(1);
	ret = write(fd, buf, size);
	if (ret < 0)
		perror("read /dev/raw1"), exit(1);
	if (ret != size)
		fprintf(stderr, "write only %d of %d bytes\n", ret, size);
}

Andrea

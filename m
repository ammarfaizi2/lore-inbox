Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVGIVl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVGIVl5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 17:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVGIVl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 17:41:56 -0400
Received: from [212.76.81.126] ([212.76.81.126]:1796 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261746AbVGIVls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 17:41:48 -0400
Message-Id: <200507092139.AAA03256@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Jens Axboe'" <axboe@suse.de>, "'Steven Pratt'" <slpratt@austin.ibm.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <torvalds@osdl.org>,
       <grant_lkml@dodo.com.au>, <linux@rainbow-software.org>,
       <andre@tomt.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [git patches] IDE update
Date: Sun, 10 Jul 2005 00:39:17 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0034_01C584E7.CDB1F1B0"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20050709054053.GX7050@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcWESBCL0b1oEOAZR+2q4ji8XM2yIgAhllcA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0034_01C584E7.CDB1F1B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Jens Axboe <axboe@suse.de> wrote:{
> >>   
> >>>Some more investigation - it appears to be broken read-ahead, actually.
> >>>
> >>>--- mm/readahead.c~	2005-07-08 11:16:14.000000000 +0200
> >>>+++ mm/readahead.c	2005-07-08 11:17:49.000000000 +0200
> >>>@@ -351,7 +351,9 @@
> >>> 		ra->cache_hit += nr_to_read;
> >>> 		if (ra->cache_hit >= VM_MAX_CACHE_HIT) {
> >>> 			ra_off(ra);
> >>>+#if 0
> >>> 			ra->flags |= RA_FLAG_INCACHE;
> >>>+#endif
> >>> 			return 0;
> >>> 		}
> >>> 	} else {
> >>
> >> >Just use the test app I posted, it shows the problem just fine. If I 
> >use a regular file, behaviour is identical as expected (ie equally 
> >broken :-).
}

Modified test app shows comparison w/ and w/o O_DIRECT.

Your comments please!

2.4.31# (hdparm -f /dev/hda;free;time /tmp/readisk /dev/hda 1 )

/dev/hda:
             total       used       free     shared    buffers     cached
Mem:        256388      23728     232660          0       1944       4324
-/+ buffers/cache:      17460     238928
Swap:            0          0          0
Mem Throughput: 107 MiB/sec - 8388608-16 bs-blks
Mem Throughput: 121 MiB/sec - 4194304-32 bs-blks
Mem Throughput: 122 MiB/sec - 2097152-64 bs-blks
Mem Throughput: 122 MiB/sec - 1048576-128 bs-blks
Mem Throughput: 120 MiB/sec - 524288-256 bs-blks
Mem Throughput: 120 MiB/sec - 262144-512 bs-blks
Mem Throughput: 131 MiB/sec - 131072-1024 bs-blks
Mem Throughput: 336 MiB/sec - 65536-2048 bs-blks
Mem Throughput: 476 MiB/sec - 32768-4096 bs-blks
Mem Throughput: 432 MiB/sec - 16384-8192 bs-blks
Mem Throughput: 824 MiB/sec - 8192-16384 bs-blks	<--- 20% faster
Mem Throughput: 799 MiB/sec - 4096-32768 bs-blks
Mem Throughput: 494 MiB/sec - 2048-65536 bs-blks
Mem Throughput: 270 MiB/sec - 1024-131072 bs-blks
Mem Throughput: 146 MiB/sec - 512-262144 bs-blks
Mem Throughput: 76 MiB/sec - 256-524288 bs-blks
Disk Throughput: 39 MiB/sec
1.13user 12.35system 0:15.65elapsed 86%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (87major+2061minor)pagefaults 0swaps
=====================================================================

2.4.31# (hdparm -f /dev/hda;free;time /tmp/readisk /dev/hda 1 1 )
O_DIRECT

/dev/hda:
             total       used       free     shared    buffers     cached
Mem:        256388      23824     232564          0       2024       4324
-/+ buffers/cache:      17476     238912
Swap:            0          0          0
Mem Throughput: 36 MiB/sec - 8388608-16 bs-blks
Mem Throughput: 34 MiB/sec - 4194304-32 bs-blks
Mem Throughput: 34 MiB/sec - 2097152-64 bs-blks
Mem Throughput: 37 MiB/sec - 1048576-128 bs-blks
Mem Throughput: 29 MiB/sec - 524288-256 bs-blks		<--- small dip
Mem Throughput: 15 MiB/sec - 262144-512 bs-blks		<--- 333% slower
Mem Throughput: 42 MiB/sec - 131072-1024 bs-blks
Mem Throughput: 45 MiB/sec - 65536-2048 bs-blks
Mem Throughput: 40 MiB/sec - 32768-4096 bs-blks
Mem Throughput: 36 MiB/sec - 16384-8192 bs-blks
Mem Throughput: 33 MiB/sec - 8192-16384 bs-blks
Mem Throughput: 25 MiB/sec - 4096-32768 bs-blks
Mem Throughput: 16 MiB/sec - 2048-65536 bs-blks
Mem Throughput: 10 MiB/sec - 1024-131072 bs-blks
read infile: Invalid argument 512-262144 bs-blks	<--- too small?
read infile: Invalid argument 256-524288 bs-blks
Disk Throughput: 38 MiB/sec
0.27user 10.88system 1:12.95elapsed 15%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (99major+2062minor)pagefaults 0swaps
=====================================================================

2.6.12# (hdparm -f /dev/hda;free;time /tmp/readisk /dev/hda 1 )

/dev/hda:
             total       used       free     shared    buffers     cached
Mem:        255228      15668     239560          0       5060       4252
-/+ buffers/cache:       6356     248872
Swap:            0          0          0
Mem Throughput: 97 MiB/sec - 8388608-16 bs-blks
Mem Throughput: 120 MiB/sec - 4194304-32 bs-blks
Mem Throughput: 120 MiB/sec - 2097152-64 bs-blks
Mem Throughput: 120 MiB/sec - 1048576-128 bs-blks
Mem Throughput: 121 MiB/sec - 524288-256 bs-blks
Mem Throughput: 120 MiB/sec - 262144-512 bs-blks
Mem Throughput: 129 MiB/sec - 131072-1024 bs-blks
Mem Throughput: 237 MiB/sec - 65536-2048 bs-blks
Mem Throughput: 451 MiB/sec - 32768-4096 bs-blks
Mem Throughput: 418 MiB/sec - 16384-8192 bs-blks
Mem Throughput: 636 MiB/sec - 8192-16384 bs-blks
Mem Throughput: 672 MiB/sec - 4096-32768 bs-blks	<--- 20% slower
Mem Throughput: 399 MiB/sec - 2048-65536 bs-blks
Mem Throughput: 217 MiB/sec - 1024-131072 bs-blks
Mem Throughput: 115 MiB/sec - 512-262144 bs-blks
Mem Throughput: 59 MiB/sec - 256-524288 bs-blks
Disk Throughput: 26 MiB/sec
0.93user 13.79system 0:18.59elapsed 79%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+2150minor)pagefaults 0swaps
=====================================================================

2.6.12# (hdparm -f /dev/hda;free;time /tmp/readisk /dev/hda 1 1)
O_DIRECT

/dev/hda:
             total       used       free     shared    buffers     cached
Mem:        255228      15668     239560          0       5060       4252
-/+ buffers/cache:       6356     248872
Swap:            0          0          0
Mem Throughput: 33 MiB/sec - 8388608-16 bs-blks
Mem Throughput: 30 MiB/sec - 4194304-32 bs-blks
Mem Throughput: 34 MiB/sec - 2097152-64 bs-blks
Mem Throughput: 39 MiB/sec - 1048576-128 bs-blks
Mem Throughput: 30 MiB/sec - 524288-256 bs-blks		<--- small dip
Mem Throughput: 49 MiB/sec - 262144-512 bs-blks		<--- 333% faster
Mem Throughput: 49 MiB/sec - 131072-1024 bs-blks
Mem Throughput: 44 MiB/sec - 65536-2048 bs-blks
Mem Throughput: 42 MiB/sec - 32768-4096 bs-blks
Mem Throughput: 40 MiB/sec - 16384-8192 bs-blks
Mem Throughput: 29 MiB/sec - 8192-16384 bs-blks
Mem Throughput: 22 MiB/sec - 4096-32768 bs-blks
Mem Throughput: 14 MiB/sec - 2048-65536 bs-blks
Mem Throughput: 8 MiB/sec - 1024-131072 bs-blks
Mem Throughput: 4 MiB/sec - 512-262144 bs-blks
read infile: Invalid argument 256-524288 bs-blks	<--- too small?
Disk Throughput: 34 MiB/sec
0.69user 32.09system 1:39.15elapsed 33%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+2164minor)pagefaults 0swaps
=====================================================================

------=_NextPart_000_0034_01C584E7.CDB1F1B0
Content-Type: application/octet-stream;
	name="rd128.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rd128.c"

//#include <stdio.h>
#include <unistd.h>
#define __USE_GNU
#include <fcntl.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <linux/fs.h>

#define BS		(8192*1024)
#define BLOCKS		(128*1024/8192)
#define ALIGN(buf)	(char *) (((unsigned long) (buf) + 4095) & ~(4095))

void print_time(struct timeval *s, int memory)
{
	unsigned long ms, mb;
	struct timeval e;
	mb =3D BS * BLOCKS / 1024;
	gettimeofday(&e, NULL);
	ms =3D (e.tv_sec - s->tv_sec) * 1000 + (e.tv_usec - s->tv_usec) / 1000;

	if (memory)
		printf("Mem Throughput: %lu MiB/sec - %lu-%lu bs-blks\n", mb / ms, =
BS/memory, BLOCKS*memory);
	else
		printf("Disk Throughput: %lu MiB/sec\n", mb / ms);
}
=0A=
void read_stuff(int fd, char *buffer, int memory)
{
	struct timeval s;
	int i, ret;
=0A=
	int j=3D1; if (memory)=0D j=3Dmemory;=0A=
=0A=
	gettimeofday(&s, NULL);
=0A=
	for (i =3D 0; i < (BLOCKS*j); i++) {
		if (memory)
			lseek(fd, 0, SEEK_SET);
		ret =3D read(fd, buffer, BS/j);

		if (!ret)=0A=
			break;
		else if (ret < 0) {
			perror("read infile");
//			break;
			return;
		}
	}
	print_time(&s, memory);
}
=0A=
int main(int argc, char *argv[])
{
	char *buffer;
	int i, fd, seek;
	if (argc < 2) {
		printf("%s: <device>\n", argv[0]);
		return 1;
	}
=0A=
	if (argc > 2)
		seek =3D 1;
	else
		seek =3D 0;
=0A=
	if (argc > 3)
		fd =3D open(argv[1], O_RDONLY | O_DIRECT);
	else
		fd =3D open(argv[1], O_RDONLY );
=0A=
	if (argc > 4)
		seek =3D 0;
=0A=
	if (fd =3D=3D -1) {
		perror("open");
		return 2;
	}
	ioctl(fd, BLKFLSBUF, 0);

	buffer =3D ALIGN(malloc(BS + 4095));

	if (seek) {
	    for (i =3D 0; i < 16 ; i++) {
		read_stuff(fd, buffer, (2<<i)/2);
	}}
	read_stuff(fd, buffer, 0);
	return 0;
}=0A=

------=_NextPart_000_0034_01C584E7.CDB1F1B0--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbTFUKgn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 06:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTFUKgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 06:36:42 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55046 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S265128AbTFUKgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 06:36:39 -0400
Date: Sat, 21 Jun 2003 12:50:19 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, marcelo@conectiva.com.br,
       kpfleming@cox.net, stoffel@lucent.com, gibbs@scsiguy.com,
       linux-kernel@vger.kernel.org, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <20030621105019.GA834@pcw.home.local>
References: <20030509150207.3ff9cd64.skraw@ithnet.com> <41560000.1055306361@caspian.scsiguy.com> <20030611222346.0a26729e.skraw@ithnet.com> <16103.39056.810025.975744@gargle.gargle.HOWL> <20030613114531.2b7235e7.skraw@ithnet.com> <20030620220331.GA1100@alpha.home.local> <20030621014828.0420b74f.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030621014828.0420b74f.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 01:48:28AM +0200, Stephan von Krawczynski wrote:
 
> Well, in fact I am a bit lost in the case, because of the shere data volume, I
> have space for several sets on disk, but it takes a damn long time to produce
> one cycle write/verify. Anyway I will do if that helps. The big problem with
> tar is that I have (to my knowledge) no chance to let it somewhere save the
> verify-failing data parts. I guess this could help a lot, because we could then
> see what the corruption looks like, how long (in bytes) it is and so on.
> If anybody has an idea how to achieve this goal let me know.

I wanted to implement a compare-and-capture feature in my check tool, but
realized that it would certainly be of no help if you get duplicated blocks or
so, because you'll have no way to tell *where* the captured block should have
been. That's why I suggested the checksum instead : if you get a pattern such
as :
   check1  check2
0: 1234    1234
1: 4567    4567
3: 789a    4567
4: bcde    789a
5: f012    bcde

... it will mean than block 1 was duplicated in check2. If you see :

   check1  check2
0: 1234    1234
1: 4567    4567
3: 789a    4567
4: bcde    bcde
5: f012    f012

... it will mean than block 1 was repeated instead of block 2 in check2.

If you see 0000, it probably means that you got a block full of zeros, since
the algorithm is only additive.

The resulting files will be 1/512 of the input, I think you'll find some space
on your disk for such a file.

It may be interesting to do regular checks during the second read, so that you
can abort after the first error, and not have to get a second full read.

> Ok, weekend is here, I see what can be done.

Here is my proposed program. I tried it on my local hard disk, it took 5 min
to check the full 8 GB (30 MB/s), and I reached 123 MB/s on a 4 disks software
raid5 array with an AHA29160. It outputs the current offset every 64 MB.
Here it is running on a DDS3 :

[root@alpha /root]# ~willy/c/chkblk.alpha /dev/nst0 > nst0.chk
At offset 603979776...

I hope it can help.

Cheers,
Willy


/*
 * chkblk - computes block checksums - 2003/06/21 - Willy Tarreau <w@w.ods.org>
 *
 * This program is free, do what you want with it, I will not be responsible if
 * it trashes all your data.
 *
 * Reads a file and outputs a binary 16 bit checksum for each 1KB block.
 * Useful to check for data corruption. Eg :
 *
 *  # chkblk /dev/tape > test1.chk
 *  # chkblk /dev/tape > test2.chk
 *  # cmp -l test[12].chk
 *
 * or :
 *  # chkblk /dev/sda2 |od -tx2 -Ax > test1.txt
 *  # chkblk /dev/sda2 |od -tx2 -Ax > test2.txt
 *  # diff -u test[12].txt
 *
 * To be able to read files bigger than 2GB, you should compile it
 * with "-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64".
 *
 *
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>

#define BLOCKSIZE 1024

#if _FILE_OFFSET_BITS == 64
#define OFF_T_FMT "%ll"
#else
#define OFF_T_FMT "%l"
#endif

void usage() {
    fprintf(stderr,
	    "Usage: chkblk input > output\n"
	    "   - input is a file, device, ...\n"
	    "   - output will be a binary file 1/512th the size of input\n"
	    );
    exit(1);
}


main(int argc, char **argv) {
    int fd;
    int len;
    off_t inp_off;
    unsigned long *buffer;

    if (argc != 2)
	usage();

    buffer = (void *)malloc(BLOCKSIZE);
    if (buffer == NULL) {
	fprintf(stderr,"Out of memory\n");
	exit(2);
    }

    fd = open(argv[1], O_RDONLY);
    if (fd < 0) {
	perror("open");
	exit(3);
    }

    inp_off = 0;
    while ((len = read(fd, buffer, BLOCKSIZE)) > 0) {
	unsigned long sum = 0;
	int off;
	inp_off += len;

	/* displays the offset every 64 MB */
	if ((inp_off & 0x3ffffff) == 0)
	    fprintf(stderr,"At offset " OFF_T_FMT "u...\r", inp_off);

	for (off = 0; off < len/sizeof(*buffer); off++)
	    sum += buffer[off];
	while (sum >= (1<<16)) {
	    sum = (sum & 0xffff) + (sum >> 16);
	}
	putchar(sum);
	putchar(sum >> 8);
    }
    fprintf(stderr,"At offset " OFF_T_FMT "u", inp_off);
    if (len < 0) {
	fprintf(stderr, ", read returned : \n");
	perror("");
	close(fd);
	exit(4);
    }
    else {
	fprintf(stderr, ", check completed without error\n");
    }
	
    close(fd);
    exit(0);
}

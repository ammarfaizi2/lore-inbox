Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262740AbSJHCzG>; Mon, 7 Oct 2002 22:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbSJHCzG>; Mon, 7 Oct 2002 22:55:06 -0400
Received: from packet.digeo.com ([12.110.80.53]:28611 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262740AbSJHCy7>;
	Mon, 7 Oct 2002 22:54:59 -0400
Message-ID: <3DA24A4E.87BEBD2C@digeo.com>
Date: Mon, 07 Oct 2002 20:00:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Kirby <sim@netnation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 
 -  (NUMA))
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <E17ybuZ-0003tz-00@starship> <3DA1D30E.B3255E7D@digeo.com> <3DA1D969.8050005@nortelnetworks.com> <3DA1E250.1C5F7220@digeo.com> <20021008023654.GA29076@netnation.com> <3DA247F3.B1150369@digeo.com> <20021008025457.GA26788@netnation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 03:00:31.0348 (UTC) FILETIME=[DD0B0B40:01C26E76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby wrote:
> 
> On Mon, Oct 07, 2002 at 07:50:27PM -0700, Andrew Morton wrote:
> 
> > Oh tell me about it.
> >
> > Appended is the offset->block mapping for my "linux-kernel" mailbox.
> > Read it and weep...
> 
> Eep. :)  Just out of interest, how did you get these mappings?
> 

/*
 * Show file blocks
 */

#include <unistd.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>

#include <linux/fs.h>

static const char *myname;

int main(int argc, char **argv)
{
	int i, err = 0;
	int fd;
	long blksize;
	off_t filesz;
	long fileblks, blk;
	long start = -1, end = -1;
	long first_logical = -1;

	myname = argv[0];

	while((i = getopt(argc, argv, "")) != EOF) {
		switch(i) {
		default:
			err++;
			break;
		}
	}

	if (err || optind != argc-1) {
		fprintf(stderr, "Usage: %s file\n",
			myname);
		exit(1);
	}

	fd = open(argv[optind], O_RDONLY);
	if (fd == -1) {
		perror(argv[optind]);
		exit(1);
	}

	if (ioctl(fd, FIGETBSZ, &blksize) == -1) {
		perror("FIGETBSZ");
		fprintf(stderr, "assuming 4096\n");
		blksize = 4096;
	}

	filesz = lseek(fd, 0, SEEK_END);
	lseek(fd, 0, SEEK_SET);
	fileblks = (filesz + blksize-1) / blksize;

	err = 0;
	for(blk = 0; blk < fileblks; blk++) {
		long devblk = blk;

		if (ioctl(fd, FIBMAP, &devblk) == -1) {
			if (errno == -EPERM) {
				fprintf(stderr, "got root?\n");
				exit(1);
			}
			printf("%ld: %d (%s)\n",
				blk, errno, strerror(errno));
			err++;
		} else {
			if (start == -1) {
				start = devblk;
				end = devblk;
				first_logical = blk;
			} else {
				if (devblk == end + 1) {
					end++;
				} else {
					printf("%ld-%ld: %ld-%ld (%ld)\n",
						first_logical,
						first_logical+(end-start),
						start, end,
						end - start + 1);
					start = devblk;
					end = devblk;
					first_logical = blk;
				}
			}
		}
	}

	if (start != -1)
		printf("%ld-%ld: %ld-%ld (%ld)\n",
			first_logical,
			first_logical+(end-start),
			start, end,
			end - start + 1);

	exit(err ? 1 : 0);
}

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129640AbRBQSad>; Sat, 17 Feb 2001 13:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130218AbRBQSaY>; Sat, 17 Feb 2001 13:30:24 -0500
Received: from gear.torque.net ([204.138.244.1]:9230 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S129640AbRBQSaJ>;
	Sat, 17 Feb 2001 13:30:09 -0500
Message-ID: <3A8EC1E6.6CC89D15@torque.net>
Date: Sat, 17 Feb 2001 13:24:38 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Flushing buffer and page cache
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

> > Is it possible to flush all entries in the buffer cache corresponding
> > to a single block device (i.e. simply drop them if they aren't dirty,
> > or write them to disk and drop them after this if they are dirty)?
> 
> Yes, just send the BLKFLSBUF ioctl to the device this syncs the device then 
> removes all the buffers from the cache.  We use it as a tool to move a SAN 
> device around a cluster, which is similar to what you want to do.

Last time this question was raised, someone mentioned
a little utility called flushb . Here is its source:

/*
 * flushb.c --- This routine flushes the disk buffers for a disk
 */

/*
 * modified August 2000 by Juri Haberland
 * juri.haberland@innominate.de
 */

#include <stdio.h>
#include <fcntl.h>
#include <linux/fs.h>

#define NOARGS void

const char *progname;

static void usage(NOARGS)
{
        fprintf(stderr, "Usage: %s disk\n", progname);
        exit(1);
}      

int main(int argc, char **argv)
{
        int     fd;

        progname = argv[0];
        if (argc != 2)
                usage();

        fd = open(argv[1], O_RDONLY, 0);
        if (fd < 0) {
                perror("open");
                exit(1);
        }
        /*
         * Note: to reread the partition table, use the ioctl
         * BLKRRPART instead of BLKFSLBUF.
         */
        if (ioctl(fd, BLKFLSBUF, 0) < 0) {
                perror("ioctl BLKFLSBUF");
                exit(1);
        }
        return 0;
}

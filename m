Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRBFTPo>; Tue, 6 Feb 2001 14:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbRBFTPY>; Tue, 6 Feb 2001 14:15:24 -0500
Received: from gear.torque.net ([204.138.244.1]:26118 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S129744AbRBFTOu>;
	Tue, 6 Feb 2001 14:14:50 -0500
Message-ID: <3A804C02.B09071@torque.net>
Date: Tue, 06 Feb 2001 14:09:54 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: rawio usage
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: multipart/mixed;
 boundary="------------D4869FCB9AEAF2CC69FB9DEF"

This is a multi-part message in MIME format.
--------------D4869FCB9AEAF2CC69FB9DEF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Mayank Vasa" <mvasa@confluencenetworks.com> wrote:
> I am quite new to rawio and am experimenting with with its usage. My test
> environment is Redhat 7.0, kernel version 2.2.16-22 having an external fibre
> channel drive having 2 disks (/dev/sda1 and /dev/sdb1)
> 
> All I am trying to do is to write and read to & from the disk using a raw
> device. Externally I did a "raw /dev/raw/raw1 /dev/sdb1" and then I wrote a
> small program to do the read/write.

[snip]

Raw devices need to meet the alignment requirements of the
device they are bound to; in the case of most disk this
will be 512 bytes. You need to take this into account for:
  - the buffer you give to the read() and write() calls
  - the 'size' given to read() and write() should be a
    multiple of 512
  - the SEEK_SET 'offset' given to lseek() should be a
    multiple of 512. Note you have a 2 G limit here.
    You can use _llseek() to get around this.

A small program that just reads from a raw device (or the
corresponding block device which should give the same
result) attached.

If you were binding a raw device to a cdrom device then
the BLKSIZE would need to be 2048 bytes (in most cases).

Doug Gilbert
--------------D4869FCB9AEAF2CC69FB9DEF
Content-Type: text/plain; charset=us-ascii;
 name="my_rawio_ex.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="my_rawio_ex.c"

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

#define BLKSIZE 512
#define BLKS2READ 1

int main(int argc, char *argv[])
{
    int fd, k;
    unsigned char buff[BLKSIZE * (BLKS2READ + 1)]; // allow extra for alignment
    unsigned char * arbp;			   // aligned read buffer ptr
    long block_addr = 0;

    arbp = (char *)(((unsigned long)buff + (BLKSIZE - 1)) & (~(BLKSIZE - 1)));

    fd = open(argv[1], O_RDONLY);
    if (fd < 0) {
        perror("open");
        exit (1);
    }
    if ((lseek(fd, block_addr * BLKSIZE, SEEK_SET)) < 0){
        perror("lseek");	// problem if 2nd arg > 2G
        exit (1);
    }
    if ((read(fd, arbp, BLKSIZE * BLKS2READ)) < 0) {
        perror("read");
        exit(1);
    }

    printf("First 16 bytes of the readbuf (in hex) are:\n   ");
    for (k = 0; k < 16; ++k)
	printf("%x ", (int)arbp[k]);
    printf("\n");
    close(fd);
    return 0;
}

--------------D4869FCB9AEAF2CC69FB9DEF--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

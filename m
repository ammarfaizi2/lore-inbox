Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbRBFOxA>; Tue, 6 Feb 2001 09:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129105AbRBFOwu>; Tue, 6 Feb 2001 09:52:50 -0500
Received: from md.aacisd.com ([64.23.207.34]:47117 "HELO md.aacisd.com")
	by vger.kernel.org with SMTP id <S129423AbRBFOwg>;
	Tue, 6 Feb 2001 09:52:36 -0500
Message-ID: <8FED3D71D1D2D411992A009027711D671890@md>
From: Nathan Black <NBlack@md.aacisd.com>
To: "'Mayank Vasa'" <mvasa@confluencenetworks.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: rawio usage
Date: Tue, 6 Feb 2001 09:48:00 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

need 512 byte alignment

i.e. 

change 
    char writeBuf[512];
to:
    char writeBuf[1023];
	writeBuf = (char *)(((int )&writeBuf[0] +  511) &~511);

This will typecast the writeBuffer address to an int  and add 511 to the
address. When you and that with ~511( invert 511). That will result int
something in a multiple of 512 for the address.
Then just typecast it back.
That is how to align it. Jens Was kind enough to tell me how to do this.
Nathan


-----Original Message-----
From: Mayank Vasa [mailto:mvasa@confluencenetworks.com]
Sent: Tuesday, February 06, 2001 1:37 AM
To: Linux-Kernel
Subject: rawio usage


Hi,

I am quite new to rawio and am experimenting with with its usage. My test
environment is Redhat 7.0, kernel version 2.2.16-22 having an external fibre
channel drive having 2 disks (/dev/sda1 and /dev/sdb1)

All I am trying to do is to write and read to & from the disk using a raw
device. Externally I did a "raw /dev/raw/raw1 /dev/sdb1" and then I wrote a
small program to do the read/write. The program is:

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    int fd;
    char writeBuf[512];
    char readBuf[100];

    memset(readBuf, '\0', 100);
    memset(writeBuf, '\0', 100);

    memcpy(writeBuf, "This is a test", 14);
    printf("writeBuf = %s\n", writeBuf);

    fd = open(argv[1], O_RDWR);
    if (fd < 0) {
        perror("open");
        exit (1);
    }

    if ((lseek(fd, 0L, 0)) < 0){
        perror("lseek");
        exit (1);
    }

    if ((write(fd, writeBuf, 512)) < 0) {
        printf ("errno = %d\n", errno);
        perror("write");
        exit(1);
    }

    lseek(fd, 0L, 0);
    if ((read(fd, readBuf, 512)) < 0) {
        perror("read");
        exit(1);
    }

    printf("The readbuf is %s\n", readBuf);
    return 0;
}

When I run this program as root, I get the error "write: Invalid argument".
It is basically returning errno = 22 which is EINVAL and as per the write
manpage means that fd is attached to an object which is unsuitable for
writing.

Could someone guide me on where I am going wrong & how to use raw devices?

--
Mayank Vasa
Confluence Networks.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

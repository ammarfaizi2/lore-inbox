Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbRBFGh3>; Tue, 6 Feb 2001 01:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130596AbRBFGhT>; Tue, 6 Feb 2001 01:37:19 -0500
Received: from mail07a.vwh1.net ([209.238.9.57]:6700 "HELO mail07a.vwh1.net")
	by vger.kernel.org with SMTP id <S129480AbRBFGhE>;
	Tue, 6 Feb 2001 01:37:04 -0500
From: "Mayank Vasa" <mvasa@confluencenetworks.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: rawio usage
Date: Mon, 5 Feb 2001 22:36:32 -0800
Message-ID: <OGEIIBECLDEKAJGFBOGCMEFNCAAA.mvasa@confluencenetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Return-Path: mvasa@confluencenetworks.com
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

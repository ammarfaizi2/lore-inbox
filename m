Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbTH2QOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTH2QOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:14:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261385AbTH2QNs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:13:48 -0400
Date: Fri, 29 Aug 2003 12:13:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Some read-errors on floppys not reported on 2.4.22
Message-ID: <Pine.LNX.4.53.0308291207430.25423@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the following program:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
int main()
{
    int fd;
    char buf[0x1000];
    if((fd = open("/dev/fd0", O_RDONLY)) < 0)
    {
        perror("open");
        exit(EXIT_FAILURE);
    }
    while(read(fd, buf, sizeof(buf)) > 0)
        ;
    perror("read");
    close(fd);
    return 0;
}

This program will return:

Script started on Fri Aug 29 12:05:32 2003
# ./xxx
read: Success
# exit
exit

Script done on Fri Aug 29 12:05:51 2003

Success, even where there are lots of CRC errors that
prematurely terminate the read:

end_request: I/O error, dev 02:00 (floppy), sector 101
floppy0: data CRC error: track 2, head 1, sector 12, size 2
floppy0: data CRC error: track 2, head 1, sector 12, size 2
end_request: I/O error, dev 02:00 (floppy), sector 101
floppy0: data CRC error: track 3, head 1, sector 3, size 2
floppy0: data CRC error: track 3, head 1, sector 3, size 2
end_request: I/O error, dev 02:00 (floppy), sector 128
floppy0: data CRC error: track 2, head 1, sector 12, size 2
floppy0: data CRC error: track 2, head 1, sector 12, size 2
end_request: I/O error, dev 02:00 (floppy), sector 101


This is NotGood(tm); A program may think it got all the
data, from a floppy when, in fact it wasn't able to read
more than a few sectors.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.



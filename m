Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTKGXHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTKGWYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:24:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:28289 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264487AbTKGRHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 12:07:44 -0500
Date: Fri, 7 Nov 2003 12:09:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Floppy-Disk blocked signal problem.
Message-ID: <Pine.LNX.4.53.0311071208590.17866@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

Linux 2.4.22 has a major problem when reading the floppy disk.
Signal delivery is so delayed that many are lost. This program
will show that one can't count upon getting even one signal per
second reliably delivered when a floppy is being read!

This was first discovered when trying to ise ITIMER_REAL with
100 ticks/second. Lucky if we got one. Then I found that even
trying to get one tick/second was a problem:


#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <malloc.h>
#include <fcntl.h>
#include <signal.h>

#define BUF_LEN 0x10000
int main(void);

void handler(int unused)
{
    alarm(1);
    fprintf(stderr, "%08x\n", time(NULL));
}
int main()
{
    int fd;
    char *buf;
    if((fd = open("/dev/fd0", O_RDONLY)) == -1)
    {
        perror("open");
        exit(EXIT_FAILURE);
    }
    if((buf = malloc(BUF_LEN * sizeof(char))) == NULL)
    {
        fprintf(stderr, "No memory\n");
        exit(EXIT_FAILURE);
    }
    signal(SIGALRM, handler);
    alarm(1);
    while(read(fd, buf, BUF_LEN) == BUF_LEN)
          ;
    close(fd);
    free(buf);
    return 0;
}


Script started on Fri Nov  7 12:07:02 2003
$ ./xxx
3fabd13d
3fabd13f
3fabd141
3fabd144
3fabd145
3fabd148
3fabd14a
3fabd14c
3fabd14e
3fabd150
3fabd153
3fabd154
3fabd157
3fabd159
3fabd15b
3fabd15d
3fabd15f
3fabd161
3fabd163
3fabd166
3fabd168
3fabd16a
# exit
exit
Script done on Fri Nov  7 12:07:59 2003

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



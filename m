Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbTCTPmC>; Thu, 20 Mar 2003 10:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbTCTPmC>; Thu, 20 Mar 2003 10:42:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:39560 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261501AbTCTPl6>; Thu, 20 Mar 2003 10:41:58 -0500
Date: Thu, 20 Mar 2003 10:54:55 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Srihari Vijayaraghavan <harisri@bigpond.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bottleneck on /dev/null
In-Reply-To: <200303210157.10494.harisri@bigpond.com>
Message-ID: <Pine.LNX.4.53.0303201047500.4008@chaos>
References: <200303210157.10494.harisri@bigpond.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003, Srihari Vijayaraghavan wrote:

> Linux-2.4.latest
> PACKET_MMAP
> PCAP_FRAMES=max for tcpdump-3.8/libpcap-0.8 (from http://public.lanl.gov/cpw/)
> e1000 driver
>
> 2 * Xeon 2800 MHz, 512 KB L2
> 1 GB RAM
> 70 GB HW RAID-0 on SmartArray 5i
> 2 * 2 port Intel GigE cards (only using 1 per card for the testing purposes)
>
> Capturing all packets and writting to /dev/null causes more packet drops than
> writting to hard drives (approx 40,000 packets/sec of 70 bytes for couple of
> minutes). I will have a comparision between those figures in a day or two,
> but /dev/null was well over SCSI hard drives. I thought writting (even
> multiple of them simultaneously) to /dev/null should be faster than fastest
> SCSI drives out there :) Interesting.
>
> (And yes I see plenty of "errors", "dropped", and "overruns" in ifconfig stats
> on those interfaces. %system is over 80%, and tcpdump goes to "D" state many
> times. Simon Kirby suggested to use irq-smp_affinity to see if that helps for
> reducing %system time. A well optimised e1000 would definitely help as tg3
> does it very well.)
>
> I mean to test this /dev/null behavior on 2 tg3 driver configuration perhaps
> in couple of days time. (But the 2 tg3 cards with out-of-the-box NAPI support
> on 2.4.latest is able to not to loose a single packet even while writting to
> hard drives, then I didn't care to test it on /dev/null)
>
> BTW I found 2.5.51 backport of e1000 NAPI support at
> http://havoc.gtf.org/lunz/linux/net/
> Anyone knows of a recent backport or improved one for 2.4.latest (including
> 2.4.21-pre5 or -pre6). Patches for testing or URL is welcome.
>
> Thanks
> --
> Hari
> harisri@bigpond.com

You are correct and here's a little program to show the problem
and demonstrate when it gets corrected.




#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>
#define BUF_LEN 0x10000
unsigned long amount = 0L;
void timer(int unused) {
    fprintf(stdout, "Kilobytes / sec = %lu\n", amount >> 10);
    fflush(stdout);
    amount = 0L;
    alarm(1);
}
main() {
    int fd, len;
    char *buf;
    if((fd = open("/dev/null", O_RDWR)) < 0)
        exit(EXIT_FAILURE);
    if((buf = malloc(BUF_LEN)) == NULL)
        exit(EXIT_FAILURE);
    (void)signal(SIGALRM, timer);
    alarm(1);
    while((len = write(fd, buf, BUF_LEN)) > 0)
        amount += (unsigned long) len;
    free(buf);
    return 0;
}

On my SMP system, using kernel version 2.4.20, I get:

Kilobytes / sec = 3987136
Kilobytes / sec = 4101760
Kilobytes / sec = 1984
Kilobytes / sec = 4138304
Kilobytes / sec = 33664
Kilobytes / sec = 4189888
Kilobytes / sec = 432
Kilobytes / sec = 4122880

There is an awful big variation and I'm the only one on
this system!! If I disconnect the network line so I
truly get the entire attention of both CPUs, I get:

Kilobytes / sec = 3717402
Kilobytes / sec = 320250
Kilobytes / sec = 239501
Kilobytes / sec = 1893527
Kilobytes / sec = 23
Kilobytes / sec = 6783920
Kilobytes / sec = 1296789
Kilobytes / sec = 5109001


How, what the :F: makes the thing stumble down to 23 kilobytes
per second?a `taint right.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbTCTQsP>; Thu, 20 Mar 2003 11:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTCTQsO>; Thu, 20 Mar 2003 11:48:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:44680 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261415AbTCTQsM>; Thu, 20 Mar 2003 11:48:12 -0500
Date: Thu, 20 Mar 2003 12:01:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bernd Petrovitsch <bernd@gams.at>
cc: Srihari Vijayaraghavan <harisri@bigpond.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bottleneck on /dev/null 
In-Reply-To: <28588.1048178012@frodo.gams.co.at>
Message-ID: <Pine.LNX.4.53.0303201150140.4241@chaos>
References: <Pine.LNX.4.33.0303201720170.8831-100000@gans.physik3.uni-rostock.de>
  <28588.1048178012@frodo.gams.co.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003, Bernd Petrovitsch wrote:

> Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> >On Thu, 20 Mar 2003, Richard B. Johnson wrote:
> >
> >> unsigned long amount = 0L;
> >
> >try 'volatile' to get the deviation down...
>
> .. and try "long long" to avoid an overrun.
>
> 	Bernd
> --

Yes. That's better. It may have been a diagnostic error
in the code of the first person reporting this --also.

The data-rate is so high that I might have wrapped several
times! I didn't think it would be that high, only 2 to 3
gigibyte/second, not over 4 Gb/s (with 130MHz RAM no less)


#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>

#define BUF_LEN 0x10000
volatile unsigned long long amount = 0L;

void timer(int unused) {
    fprintf(stdout, "Kilobytes / sec = %llu\n", amount >> 10);
    fflush(stdout);
    amount = 0LL;
    alarm(1);
}

int main() {
    int fd, len;
    char *buf;
    if((fd = open("/dev/null", O_RDWR)) < 0)
        exit(EXIT_FAILURE);
    if((buf = malloc(BUF_LEN)) == NULL)
        exit(EXIT_FAILURE);
    (void)signal(SIGALRM, timer);
    alarm(1);
    while((len = write(fd, buf, BUF_LEN)) > 0)
        amount += (unsigned long long) len;
    free(buf);
    return 0;
}


With network:

Kilobytes / sec = 46170080
Kilobytes / sec = 46171576
Kilobytes / sec = 46172944
Kilobytes / sec = 46172192
Kilobytes / sec = 46171840
Kilobytes / sec = 46171576

Without network:

Kilobytes / sec = 46128168
Kilobytes / sec = 46128200
Kilobytes / sec = 46128152
Kilobytes / sec = 46128142
Kilobytes / sec = 46128208
Kilobytes / sec = 46128198
Kilobytes / sec = 46128202


Its interesting that the data-rate is higher with the network
plugged in and getting all those M$ broadcast messages. But, as
expected, its more stable without.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


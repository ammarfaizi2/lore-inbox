Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262895AbTCYQ45>; Tue, 25 Mar 2003 11:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262933AbTCYQ45>; Tue, 25 Mar 2003 11:56:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17038 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262895AbTCYQ4z>; Tue, 25 Mar 2003 11:56:55 -0500
Date: Tue, 25 Mar 2003 12:07:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Fionn Behrens <fionn@unix-ag.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: System time warping around real time problem - please help
In-Reply-To: <1048609931.1601.49.camel@rtfm>
Message-ID: <Pine.LNX.4.53.0303251152080.29361@chaos>
References: <1048609931.1601.49.camel@rtfm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, Fionn Behrens wrote:

>
> Hello all,
>
>
> I have got an increasingly annoying problem with our fairly new (fall
> '02) Dual Athlon2k+ Gigabyte 7dpxdw linux system running 2.4.20.
> The only kernel patch applied is Alan Cox's ptrace patch.
>

I am using the exact same kernel (a lot of folks are). There
is no such jumping on my system.
Try this program:

#include <stdio.h>
#include <time.h>
int main() {
   time_t x,y;
   (void)time(&x);
   (void)time(&y);
   for(;;) {
       (void)time(&x);
       if(x < y)
           printf("Prev %ld New %ld\n", y, x);
       y = x;
   }
   return 0;
}
If this shows time jumping around you have one of either:

(1)	Bad timer channel 0 chip (PIT).
(2)	Some daemon trying to sync time with another system.
(3)	You are traveling too close to the speed of light.

Now, your script shows time in fractional seconds.

> 1048608745.61 > 1048608745.60

You can modify the program to do this:


#include <stdio.h>
#include <sys/time.h>
int main() {
   struct timeval tv;
   double x, y;
   (void)gettimeofday(&tv, NULL);
   x = (double) tv.tv_sec * 1e6;
   x += (double) tv.tv_usec;
   y = x;
   for(;;) {
       (void)gettimeofday(&tv, NULL);
       x = (double) tv.tv_sec * 1e6;
       x += (double) tv.tv_usec;
       if(x < y)
           printf("Prev %f New %f\n", y, x);
       y = x;
   }
   return 0;
}

There should be no jumping around -- and there isn't on
any system I've tested this on.

> Software crashes are regularly - naturally. No programmer expects system
> timers going back in time.
>

Hmmm, software should never crash. Even if the timers jump backwards
as you say, they should eventually time-out. If you have crashes, this
may point to other hardware problems as well.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


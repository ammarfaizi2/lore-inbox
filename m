Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVFWPJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVFWPJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 11:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVFWPJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 11:09:39 -0400
Received: from alog0351.analogic.com ([208.224.222.127]:5536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262445AbVFWPJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 11:09:28 -0400
Date: Thu, 23 Jun 2005 11:09:13 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Andreas Schwab <schwab@suse.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible spin-problem in nanosleep()
In-Reply-To: <Pine.LNX.4.61.0506230841390.15910@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0506231058560.16531@chaos.analogic.com>
References: <Pine.LNX.4.61.0506230812160.15775@chaos.analogic.com>
 <jell516ymn.fsf@sykes.suse.de> <Pine.LNX.4.61.0506230841390.15910@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-1189735978-1119539353=:16531"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-1189735978-1119539353=:16531
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Andreas,

Additional input: It seems that it's not the usleep(), but
some kind of scheduling phenomena makes the difference.
The following code will show different amounts of CPU time
after a few hours of running on an otherwise unused
system (not even a network card), a real "quiet" system.

The first task forked() seems to get about 5 times the CPU
time of the second. Since the first task used nanosecond()
it was blamed on nanosecond(), but instead it seems to have
something to do with the order in which children are created.


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

int main(int argx, char *argv[])
{
     volatile int i;
     struct timespec ts;
     switch(fork())
     {
     case 0:=09// Child
         strcpy(argv[0], "Using nanosleep()");
         for(;;)
         {
             ts.tv_sec =3D 0;
             ts.tv_nsec =3D 1000000;=09=09// 1 milisecond
             (void)nanosleep(&ts, NULL);
             for(i=3D0; i< 0x00010000; i++)=09// Do work
                 ;
         }
         break;
     case -1:=09// Failure
         abort();
         break;
     default:
         break;
     }
     switch(fork())
     {
     case 0:=09// Child
         strcpy(argv[0], "Using usleep()");
         for(;;)
         {
             (void)usleep(1000);=09=09=09// 1 millisecond
             for(i=3D0; i< 0x00010000; i++)=09// Do work
                 ;
         }
         break;
     case -1:=09// Failure
         abort();
         break;
     default:
         break;
     }
     pause();
     return 0;
}


On Thu, 23 Jun 2005, Richard B. Johnson wrote:

> On Thu, 23 Jun 2005, Andreas Schwab wrote:
>
>> "Richard B. Johnson" <linux-os@analogic.com> writes:
>>=20
>>> nanosleep() appears to have a problem. It may be just an
>>> 'accounting' problem, but it isn't pretty. Code that used
>>> to use usleep() to spend most of it's time sleeping, used
>>> little or no CPU time as shown by `top`. The same code,
>>> converted to nanosleep() appears to spend a lot of CPU
>>> cycles spinning. The result is that `top` or similar
>>> programs show lots of wasted CPU time.
>>=20
>> usleep() is just a wrapper around nanosleep().  Are you sure you got the
>> units right?
>>=20
>> Andreas.
>>=20
>
> Yeah nano is -9 micro is -6, three more zeros when using nano.
> I note that the actual syscall is __NR_nanosleep =3D 162. I don't
> understand the discrepancy either.
>
>> --=20
>> Andreas Schwab, SuSE Labs, schwab@suse.de
>> SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
>> Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
>> "And now for something completely different."
>>=20
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
> Notice : All mail here is now cached for review by Dictator Bush.
>                 98.36% of all statistics are fiction.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-1189735978-1119539353=:16531--

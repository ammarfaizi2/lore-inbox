Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311009AbSCHSy6>; Fri, 8 Mar 2002 13:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310968AbSCHSym>; Fri, 8 Mar 2002 13:54:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310950AbSCHSy3>; Fri, 8 Mar 2002 13:54:29 -0500
Date: Fri, 8 Mar 2002 13:54:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Terje Eggestad <terje.eggestad@scali.com>,
        Ben Greear <greearb@candelatech.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        george anzinger <george@mvista.com>
Subject: Re: gettimeofday() system call timing curiosity
In-Reply-To: <20020308183049.A18247@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.3.95.1020308134552.6627A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Jamie Lokier wrote:

> Jamie Lokier wrote:
> > It takes the median of 1000 samples of the TSC time taken to do a
> > rdtsc/gettimeofday/rdtsc measurement, then uses that as the threshold
> > for deciding which of the subsequent 1000000 measurements are accepted.
> > Then linear regression through the accepted points.
> > 
> > I see a couple of results there which suggests a probable fault in the
> > filtering algorithm.  Perhaps it should simply use the smallest TSC time
> > taken as the threshold.
> 
> I've looked more closely.  Of all the machines I have access to, only my
> laptop shows the anomolous measurements.
> 
> It turns out that the median of "time in TSC cycles to do a
> rdtsc+gettimeofday+rdtsc measurement" varies from run to run.  It only
> varies between two values, though.
> 
[SNIPPED...]

The following program clearly shows that Linux will not return the
same gettimeofday values twice in succession. Since it provably takes
less than 1 microsecond to make a system call on a modern machine,
Linux must be waiting within the gettimeofday procedure long enough
to make certain that the time has changed. This may be screwing up
any performance measurments made with gettimeofday().


#include <stdio.h>
#include <sys/time.h>

int main(void);
int main()
{
   struct timeval tv, pv;
   tv.tv_sec  = tv.tv_usec = pv.tv_sec = pv.tv_usec = 0;
   for(;;)
   {
        (void)gettimeofday(&tv, NULL);
        if((tv.tv_sec != pv.tv_sec) || (tv.tv_usec != pv.tv_usec))
            printf("sec = %ld usec = %ld\n", tv.tv_sec, tv.tv_usec);
         else
            puts("The same!");
         pv = tv;
   }
   return 0;
}


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

	Bill Gates? Who?


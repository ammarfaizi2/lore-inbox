Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269771AbUJMSIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269771AbUJMSIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 14:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269773AbUJMSIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 14:08:31 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:14790 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S269771AbUJMSI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 14:08:26 -0400
Subject: Re: Periodic posix timer support broke between 2.6.9-rc1 and
	2.6.9-rc1-bk17
From: Alexander Nyberg <alexn@dsv.su.se>
To: Christoph Lameter <clameter@sgi.com>
Cc: George Anzinger <george@mvista.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, roland@redhat.com,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0410121315170.5785@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
	 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
	 <4154F349.1090408@redhat.com>
	 <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
	 <41550B77.1070604@redhat.com>
	 <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
	 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
	 <4159B920.3040802@redhat.com>
	 <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
	 <415AF4C3.1040808@mvista.com>
	 <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
	 <Pine.LNX.4.58.0410062150310.18565@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0410121315170.5785@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1097690892.615.32.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 20:08:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I ran some test programs and discovered that the periodic timer support
> is broken. The timer is triggered once and then never again. Single shot
> timers work fine. 2.6.9-rc1 is fine. The first kernel that I tested where
> I noticed the breakage was 2.6.9-rc1-bk17. 2.6.9-rc2 and following all
> cannot do periodic timer signals.
> 
> I looked through the changelog but I cannot see anything that would cause
> the problem. Roland's patch surely could not have done this.
> 
> Will try to track this down further, time permitting...

I took a bit of a look at this, and it looks like some things changed
with the introduction of the flexible mmap in 2.6.9-rc1-bk1.

If you run the program below it will work, doing as expected. Now
comment out the the line "memset(&sa, 0, sizeof(struct sigaction));"
and program won't run as expected.

Now do "echo -n 1 > /proc/sys/vm/legacy_va_layout" and run the same
program again (the one with memset commented out).

Turning on signal debugging tells us that with legacy_va_layout=0
"SIG deliver (a.out:415): sp=bffff6c0 pc=08048434 ra=00000000"
where ra is the 8-byte instruction that's supposed to get us back to
sys_sigreturn().

Me thinks someone somewhere is using some of the bits that we
"accidently" pass via sa.sa_flags by not setting it to 0, the regular
flags don't seem to show this behaviour, and I couldn't see any real
checking of the passed value of sa.sa_flags.

---------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/time.h>

void sighandler(int signal)
{
	printf("hihi\n");
}

int main()
{
	struct itimerval timeval;
	struct sigaction sa;
	
	memset(&timeval, 0, sizeof(struct timeval));
	memset(&sa, 0, sizeof(struct sigaction));
	
	sa.sa_handler = &sighandler;
	sigfillset(&sa.sa_mask);
	
	sigaction(SIGALRM, &sa, NULL);
	
	timeval.it_interval.tv_sec = 2;
	timeval.it_interval.tv_usec = 0;
	
	timeval.it_value.tv_sec = 2;
	timeval.it_value.tv_usec = 0;
	
	if (setitimer(ITIMER_REAL, &timeval, NULL))
		printf("Nooo!\n");

	for(;;)
		;

	return 0;
}


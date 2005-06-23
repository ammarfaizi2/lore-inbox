Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVFWMSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVFWMSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 08:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVFWMSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 08:18:24 -0400
Received: from alog0308.analogic.com ([208.224.222.84]:58019 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262308AbVFWMSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 08:18:18 -0400
Date: Thu, 23 Jun 2005 08:18:05 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Possible spin-problem in nanosleep()
Message-ID: <Pine.LNX.4.61.0506230812160.15775@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The man pages say usleep() is obsolete and one should
use nanosleep().

nanosleep() appears to have a problem. It may be just an
'accounting' problem, but it isn't pretty. Code that used
to use usleep() to spend most of it's time sleeping, used
little or no CPU time as shown by `top`. The same code,
converted to nanosleep() appears to spend a lot of CPU
cycles spinning. The result is that `top` or similar
programs show lots of wasted CPU time.

In the following 'daemon' was converted to nanosleep(). It
sleeps for 100 milliseconds. Process 'xray' was not converted
and it sleeps for 100 milliseconds also. They used to both
accumulate roughly the same amount of time. They simply sleep,
wake up to sample some status, then go back to sleep. This
is an embedded system that was running for about 10 hours.

PID   NAME            STA CPU     MEM   EXE   Command line
1     (init)          S   0.00    368   8     /sbin/init auto 
2     (keventd)       S   0.00    368   8 
3     (ksoftirqd_CPU0)S   0.00    368   8 
4     (kswapd)        S   0.00    368   8 
5     (bdflush)       S   0.00    368   8 
6     (kupdated)      S   0.00    368   8 
10    (syslog)        S   0.00    268   4     /sbin/syslog 
12    (daemon)        S   5.93    260   4     /sbin/daemon 
14    (xray)          S   0.71    264   8     /bin/xray control


Is this a known problem? Is it going to be fixed? In a possibly
related note, the following:

main()
{
     for(;;)
         sched_yield();
}

.... is shown to be spinning, by 'top' not sleeping. This, even though
it is giving up its quantum continuously.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

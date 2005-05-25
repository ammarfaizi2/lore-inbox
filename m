Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVEYRWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVEYRWt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVEYRWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:22:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17658 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261501AbVEYRW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:22:26 -0400
Message-ID: <4294B42D.2020008@mvista.com>
Date: Wed, 25 May 2005 10:21:49 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bhavesh@avaya.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
References: <1116975555.2050.10.camel@cof110earth.dr.avaya.com>
In-Reply-To: <1116975555.2050.10.camel@cof110earth.dr.avaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bhavesh P. Davda wrote:
> setitimer for 20ms was firing at 21ms, so I wrote a simple debug module
> for 2.6.11.10 kernel on i386 to do something like this:
> 
> struct timeval tv;
> unsigned long jif;
> 
> tv.tv_usec = 20000;
> tv.tv_sec = 0;
> 
> jif = timeval_to_jiffies(&tv);
> printk("%lu usec = %lu jiffies\n", tv.tv_usec, jif);
> 
> This yields:
> 
> 20000 usec = 21 jiffies
> 
> Egad!
> 
> I looked at the timeval_to_jiffies() inline function in
> include/linux/jiffies.h, and after pulling my hair for a few minutes
> (okay almost an hour), I decided to ask much smarter people than myself
> on why it is behaving this way, and what it would take to fix it so that
> "20000 usec = 20 jiffies".
> 
> I got as far as this in figuring it out for i386:
> 
> HZ=1000
> SEC_CONVERSION=4194941632
> USEC_CONVERSION=2199357558
> USEC_ROUND=2199023255551
> USEC_JIFFIE_SC=41
> SEC_JIFFIE_SC=22
> 
> Thanks in advance for saving me from going bald!

Well, I am already bald  :)

What you are missing is that the PIT can not generate a 1ms tick.  The best it 
can do is 999849 nanoseconds.  Given this we need to convert 20000 usec to not 
less than 2000usec worth of jiffies (time MUST always be rounded up).  20 
jiffies is 19.996980 usec so we need to use 21 (which is 20.996829 usec).

Note that TICK_NSEC and tick_nsec will both be 999849 nanoseconds.

If we do NOT account for this PIT issue, the result is a time drift that is 
outside of what ntp can handle...


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

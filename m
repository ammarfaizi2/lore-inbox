Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbULCIoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbULCIoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 03:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbULCIoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 03:44:12 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1271 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261409AbULCIoE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 03:44:04 -0500
Message-ID: <41B02749.70900@mvista.com>
Date: Fri, 03 Dec 2004 00:43:53 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Herbert Poetzl <herbert@13thfloor.at>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: do_posix_clock_monotonic_gettime() returns negative nsec
References: <20041203020357.GA28468@mail.13thfloor.at> <1102042850.13294.43.camel@cog.beaverton.ibm.com>
In-Reply-To: <1102042850.13294.43.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Thu, 2004-12-02 at 18:03, Herbert Poetzl wrote:
> 
>>recent kernels (tested 2.6.10-rc2 and 2.6.10-rc2-bk15)
>>produce funny output in /proc/uptime like this:
>>
>>	# cat /proc/uptime
>>	  12.4294967218 9.05
>>	# cat /proc/uptime
>>	  13.4294967251 10.33
>>	# cat /proc/uptime
>>	  14.4294967295 11.73
>>
>>a short investigation of the issue, ended at
>>do_posix_clock_monotonic_gettime() which can (and 
>>often does) return negative nsec values (within
>>one second), so while the actual 'time' returned
>>is correct, some parts of the kernel assume that
>>those part is within the range (0 - NSEC_PER_SEC)
>>
>>        len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
>>                        (unsigned long) uptime.tv_sec,
>>                        (uptime.tv_nsec / (NSEC_PER_SEC / 100)),
>>
>>as the function itself corrects overflows, it would
>>make sense to me to correct underflows too, for 
>>example with the following patch:
>>
>>--- ./kernel/posix-timers.c.orig	2004-11-19 21:11:05.000000000 +0100
>>+++ ./kernel/posix-timers.c	2004-12-03 02:23:56.000000000 +0100
>>@@ -1208,7 +1208,10 @@ int do_posix_clock_monotonic_gettime(str
>> 	tp->tv_sec += wall_to_mono.tv_sec;
>> 	tp->tv_nsec += wall_to_mono.tv_nsec;
>> 
>>-	if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
>>+	if (tp->tv_nsec < 0) {
>>+		tp->tv_nsec += NSEC_PER_SEC;
>>+		tp->tv_sec--;
>>+	} else if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
>> 		tp->tv_nsec -= NSEC_PER_SEC;
>> 		tp->tv_sec++;
>> 	}
> 
> 
> Sounds like its a good fix to me. 
> 
> George: You have any comment?

Two, in fact.  First, the result here is the sum of wall_to_monotonic and 
getnstimeofday().  If nsec < 0, one or more of these must be also.  Both of 
these values are SUPPOSED to be normalized.

Second, I would rather see:
	set_normalized_timespec(tp, tp->tv_sec + wall_to_mono.tv_sec, 		
				tp->tv_nsec + wall_to_mono.tv_nsec);

Still, doing this paves over the first issue....

> 
> thanks
> -john
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/


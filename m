Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269619AbTHETHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbTHETHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:07:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10223 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S270516AbTHETH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:07:27 -0400
Message-ID: <3F300044.9000306@mvista.com>
Date: Tue, 05 Aug 2003 12:06:44 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Larson <plars@linuxtestproject.org>
CC: Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com,
       Ulrich Drepper <drepper@redhat.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ltp nanosleep02 test
References: <20030803225004.7bcddd33.akpm@osdl.org>	<3F2EE7DE.3040206@mvista.com>  <20030804162223.18ce7698.akpm@osdl.org> <1060095904.28044.105.camel@plars>
In-Reply-To: <1060095904.28044.105.camel@plars>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> On Mon, 2003-08-04 at 18:22, Andrew Morton wrote:
> 
>>OK, thanks.
>>
>>Paul, if nanosleep2 is really dead then you should bury it and stop
>>scaring people ;)
> 
> Actually this test will pass just fine if you increase USEC_PRECISION to
> something more reasonable than 100.  However it looks like whoever wrote
> this test made it intentionally low.  This is the comment right before
> the #define USEC_PRECISION 100:
> /*
>  * Define here the "rem" precision in microseconds,
>  * Various implementations will provide different
>  * precisions. The -aa tree provides up to usec precision.
>  * NOTE: all the trees that don't provide a precision of
>  * the order of the microseconds are subject to an userspace
>  * live lock condition with glibc under a flood of signals,
>  * the "rem" field would never change without the increased
>  * usec precision in the -aa tree.
>  */
> So does anyone know if this patch from the -aa tree is reasonable or has
> a chance of making it into the mainline kernel?  Does this livelock
> situation still exist or was it solved by other means?  If this is no
> longer a potential problem then I will gladly remove the test.

I haven't seen the patch :(  There is a little misdirection in that 
comment, however.  The kernel rounds up the time to the nearest 
resolution and then adds that resolution (resolution is 1/HZ, by the 
way).  The round up is required by the standard as is the add.  The 
add is to make sure the expiry time is AFTER and never before the 
requested time.

What is passed back as the remaining time is the true remaining time 
after this calculation.

The live lock would occur if the caller then used that time to sleep 
again (i.e. to complete the sleep) as the kernel would again add the 
1/HZ to the given value.  So each signal, the time would be extended 
by a jiffie.

The best way to solve this is to use the absolute time version of 
clock_nanosleep, but, sigh, that means a change in glibc.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


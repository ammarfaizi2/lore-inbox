Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270526AbUJTXxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270526AbUJTXxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbUJTXxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:53:42 -0400
Received: from 2-227.coreds.net ([207.55.227.2]:33006 "EHLO data.mvista.com")
	by vger.kernel.org with ESMTP id S270615AbUJTXw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:52:29 -0400
Message-ID: <4176FA29.2030208@mvista.com>
Date: Wed, 20 Oct 2004 16:52:09 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Jerome Borsboom <j.borsboom@erasmusmc.nl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: process start time set wrongly at boot for kernel 2.6.9
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>	 <1098216701.20778.78.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.53.0410200233280.9510@gockel.physik3.uni-rostock.de>	 <1098233967.20778.93.camel@cog.beaverton.ibm.com>	 <41767B60.4050409@mvista.com> <1098294178.20778.117.camel@cog.beaverton.ibm.com>
In-Reply-To: <1098294178.20778.117.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2004-10-20 at 07:51, George Anzinger wrote:
> 
>>john stultz wrote:
>>
>>>I've begun to agree with you about this issue. It seems that until we
>>>can catch every use of jiffies for time, doing one by one is going to
>>>cause consistency problems.  So I'd support the full backout of the
>>>do_posix_clock_monotonic_gettime changes to the proc interface. 
>>>
>>>George, would you protest this?
>>
>>It seems to me that if we do that we will stop making any changes at all.  I.e. 
>>we will not see the rest of the "jiffies for time" code, as it will not "hurt" 
>>any more.
> 
> 
> Sorry, not sure I followed that. Could you explain further?

If we rip out the code folks will stop sending in bug reports on it.  Simple as 
that.
> 
> 
>>Also, the orgional change was made for a reason...
> 
> 
> Right, but I thought it was you who made the original change, and I
> don't recall you answering what that reason was? I wouldn't want the
> code ripped out if it was fixing an actual problem, so that's why I'm
> asking.

As I recall the problem was that uptime was not matching the elapsed wall clock. 
  This was because it was jiffies based and the 1/HZ assumption was made about 
what a jiffie is.  When jiffies became ~1/HZ instead of =1/HZ we started all the 
"good times".  And, this was done because 1/HZ could not be obtained with the 
PIT interrupt source with enought accuracy to satisfy ntp code.
> 
> At the moment, I'd like the idea I think Tim is suggesting. Where we fix
> time so we have a stable base, then we decouple xtime and jiffies from
> the timer interrupt and instead emulate them from the time code. 

The can of worms here is decoupling jiffies from the timer interrupt.  Jiffies 
is (like it or not) the unit of measure used for timers and these _require_ and 
interrupt AND it should be consistantly within a few 10s of usec of when the 
jiffie changes.
> 
> So rather then every tick incrementing jiffies, instead jiffies is set
> equal to (monotonic_clock()*HZ)/NSEC_PER_SEC. 

As mention by me (a long time ago), this assumes you have a better source for 
the clock than the interrupt.  I would argue that on the x86 (which I admit is 
really deficient) the best long term clock is, in fact, the PIT interrupt.  The 
_best_ clock on the x86, IMHO, is one that used the PIT interrupt as the gold 
standard.  Then one smooths this to eliminate interrupt latency issues and lost 
ticks using the TSC.   The pm_timer is as good as the PIT but suffers from 
access time issues.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/


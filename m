Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbULJTnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbULJTnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 14:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbULJTnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 14:43:06 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:10994 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261802AbULJTnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 14:43:02 -0500
Message-ID: <41B9FC3F.50601@mvista.com>
Date: Fri, 10 Dec 2004 11:42:55 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: ganzinger@mvista.com, Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: RCU question
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>
In-Reply-To: <20041210043102.GC4161@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> On Thu, Dec 09, 2004 at 03:59:45PM -0800, George Anzinger wrote:
> 
>>I am working on VST code.  This code is called from the idle loop to check 
>>for future timers.  It then sets up a timer to interrupt in time to handle 
>>the nearest timer and turns off the time base interrupt source.  As part of 
>>qualifying the entry to this state I want to make sure there is no pending 
>>work so, from the idle task I have this:
>>
>>	if (local_softirq_pending())
>>		do_softirq();
>>
>>	BUG_ON(local_softirq_pending());
>>
>>I did not really expect to find any pending softirqs, but, not only are 
>>there some, they don't go away and the system BUGs.  The offender is the 
>>RCU task. The question is: is this normal or is there something wrong?
> 
> 
> Why do you think there would not be any softirq pending after do_softirq() ?
> What if the cpu gets a network interrupt which raises a softirq ?

Yes, but it is serviced on interrupt exit and the task level code would never 
see it.

> And yes, RCU processing in softirq context can re-raise the softirq.
> AFAICS, it is perfectly normal.

My assumption was that, this being the idle task, RCU would be more than happy 
to finish all its pending tasks.

It may be necessary for me to rethink the conditions required to go into the VST 
state.  I had assumed that it required NO softirq pending as a pre condition. 
 From this point on we would have the interrupt system off until the hardware 
sleep instruction (hlt in the x86 case).

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/


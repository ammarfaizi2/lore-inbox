Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVH2TVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVH2TVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 15:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVH2TVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 15:21:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4604 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751404AbVH2TVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 15:21:23 -0400
Message-ID: <43134BBE.8040605@mvista.com>
Date: Mon, 29 Aug 2005 10:54:06 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: "Sat." <walking.to.remember@gmail.com>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: when or where can the case occur in "linux kernel development
 " about "kernel preemption"?
References: <6b5347dc05082609206ff7a305@mail.gmail.com> <430F45F8.8020505@nortel.com> <6b5347dc050827085727df49c8@mail.gmail.com> <Pine.LNX.4.61.0508290742540.27714@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0508290742540.27714@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Sat, 27 Aug 2005, Sat. wrote:
> 
> 
>>2005/8/27, Christopher Friesen <cfriesen@nortel.com>:
>>
>>>Sat. wrote:
>>>
>>>>the case about kernel preemption as follow :
>>>>
>>>>the book said "when a process that has a higher priority than the
>>>>currenty running process is awakened ".
>>>>
>>>>but I can think about when such case can occur , could you give me an example ?
>>>
>>>There may be others, but one common case is when a hardware interrupt
>>>causes the higher priority process to become runnable.  Some examples of
>>>this would be a network packet arriving, or the expiry of a hardware timer.
>>>
>>>Chris
>>>
>>
>>unfortunately, I cannot agree with you , normally ,when the kernel
>>runs in interrupt context , the schedule() should not be invoked
>>------my views .
>>
>>then,could anyone  give me a definite example about network like above
>>or anything else to eluminate  this , ok?
>>
>>thanks !
>>
>>--
> 
> 
>>Sat.
> 
> 
> Schedule is never executed from an interrupt, BUT, there may be
> kernel threads or even user tasks that are sleeping, waiting
> to be awakened when some preliminary interrupt processing has
> occurred. The interrupt code may execute one of the wake-up calls
> which will cause the target to be put into the run queue as soon
> as possible.
> 
Actually, this is not completly true.  The kernel sets a flag while 
handling interrupts that says it is within an interrupt.  This flag is 
cleared on the way out of the interrupt but prior to the return from 
interrupt (rfi) instruction.  Between this flag clearing and the rfi, 
there is a check made to see if the kernel is preemptable and, if so, if 
it is desired (i.e. something more important should run NOW).  If both 
of these are true, schedule is called to do the context switch.  So, 
schedule IS called from within the interrupt, but NOT within the area 
the kernel flags as being in an interrupt which is a subset of the 
actual interrupt.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

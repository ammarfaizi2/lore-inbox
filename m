Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVAUIyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVAUIyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVAUIys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:54:48 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32494 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261487AbVAUIy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:54:28 -0500
Message-ID: <41F0C33D.60908@mvista.com>
Date: Fri, 21 Jan 2005 00:54:21 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] to fix xtime lock for in the RT kernel patch
References: <41F04573.7070508@mvista.com> <20050121063519.GA19954@elte.hu> <41F0BA56.9000605@mvista.com> <20050121082125.GA28267@elte.hu> <41F0BFA4.5030107@mvista.com> <20050121084557.GA29550@elte.hu>
In-Reply-To: <20050121084557.GA29550@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * George Anzinger <george@mvista.com> wrote:
> 
> 
>>>so ->mark_offset and do_timer() go together, and happen under
>>>xtime_lock. What problem is there if we do this?
>>
>>We are trying to get an accurate picture of when, exactly in time,
>>jiffies changes. [...]
> 
> 
> but that's the point of allowing the threading of the timer interrupt. 
> If you _have_ an interrupt source (and task) that _is_ more important
> than the timer interrupt then so be it. Yes, the accuracy of timekeeping
> may suffer.
> 
> so everything is relative, and the user decides which functionality
> should have the better latency. do_offset() can take up to 10 usecs so
> it's a latency source i'd like to keep out of the direct IRQ path, as
> much as possible.

What I am suggesting is spliting the mark code so that it would only grap the 
offset (current TSC in most systems) during interrupt processing.  Applying this 
would be done later in the thread.  Since it is not applying the offset, the 
xtime_lock would not need to be taken.
> 
> 
>>We can handle (do today) some variability in this area, but, at least
>>for RT systems, we would like to get this down to a small a window as
>>possible. 
> 
> 
> by default the timer interrupt has the highest priority, and you can
> still change it to prio 99 to avoid any potential impact from RT tasks
> or other interrupt threads.
> 
> 	Ingo
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWEDDwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWEDDwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 23:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWEDDwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 23:52:17 -0400
Received: from mailserver.apbb.net ([207.55.227.4]:33288 "EHLO apbb.net")
	by vger.kernel.org with ESMTP id S1750952AbWEDDwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 23:52:16 -0400
Message-ID: <44597A19.7050107@wildturkeyranch.net>
Date: Wed, 03 May 2006 20:50:49 -0700
From: George Anzinger <george@wildturkeyranch.net>
Reply-To: george@wildturkeyranch.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de> <20060502165009.GA4223@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605021300140.28543@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0605021300140.28543@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Server: High Performance Mail Server - http://surgemail.com r=100
X-Authenticated-User: george@applegatebroadband.net 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre wrote:
> On Tue, 2 May 2006, Russell King wrote:
> 
> 
>>On Tue, May 02, 2006 at 06:43:45PM +0200, Andi Kleen wrote:
>>
>>>Russell King <rmk+lkml@arm.linux.org.uk> writes:
>>>
>>>>However, this is not the case.  On x86 with TSC, it returns a 54 bit
>>>>number.  This means that when t1 < t0, time_passed_ns becomes a very
>>>>large number which no longer represents the amount of time.
>>>
>>>Good point. For a 1Ghz system this would happen every ~0.57 years.
>>>
>>>The problem is there is AFAIK no non destructive[1] way to find out how
>>>many bits the TSC has
>>>
>>>Destructive would be to overwrite it with -1 and see how many stick.
>>>
>>>
>>>>All uses in kernel/sched.c seem to be aflicted by this problem.
>>>>
>>>>There are several solutions to this - the most obvious being that we
>>>>need a function which returns the nanosecond difference between two
>>>>sched_clock() return values, and this function needs to know how to
>>>>handle the case where sched_clock() has wrapped.
>>>
>>>Ok it can be done with a simple test.
> 
> 
> Better yet the sched_clock() implementation just needs to return a value 
> shifted left so the wrap around always happens on 64 bits and the 
> difference between two consecutive samples is always right.
> 
> 
>>>>IOW:
>>>>
>>>>	t0 = sched_clock();
>>>>	/* do something */
>>>>	t1 = sched_clock();
>>>>
>>>>	time_passed = sched_clock_diff(t1, t0);
>>>>
>>>>Comments?
>>>
>>>Agreed it's a problem, but probably a small one. At worst you'll get
>>>a small scheduling hickup every half year, which should be hardly 
>>>that big an issue.
> 
> 
> ... on x86 that is.
> 
> 
>>>Might chose to just ignore it with a big fat comment?
>>
>>You're right assuming you have a 64-bit TSC, but ARM has at best a
>>32-bit cycle counter which rolls over about every 179 seconds - with
>>gives a range of values from sched_clock from 0 to 178956970625 or
>>0x29AAAAAA81.
>>
>>That's rather more of a problem than having it happen every 208 days.
> 
> 
> Yet that counter isn't necessarily nanosecond based.  So rescaling the 
> returned value to nanosecs requires expensive divisions which could be 
> done only once within sched_clock_diff() instead of twice as often in 
> each sched_clock() calls.

Oh phooey!!  Scaling can be done with a mpy and a shift.  See the new clock 
code where the TSC (or what ever) is scaled to ns.


-- 
George Anzinger   george@wildturkeyranch.net
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

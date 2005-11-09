Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbVKIDel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbVKIDel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 22:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVKIDel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 22:34:41 -0500
Received: from 65-117-135-105.dia.cust.qwest.net ([65.117.135.105]:30960 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1030431AbVKIDek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 22:34:40 -0500
Message-ID: <43715F4B.5010604@timesys.com>
Date: Tue, 08 Nov 2005 21:30:35 -0500
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       john cooper <john.cooper@timesys.com>
Subject: Re: MIPS PREEMPT_RT update..
References: <436B85E1.1050103@timesys.com> <20051108205348.GA15964@elte.hu>
In-Reply-To: <20051108205348.GA15964@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2005 02:33:02.0875 (UTC) FILETIME=[E87006B0:01C5E4D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * john cooper <john.cooper@timesys.com> wrote:
> 
> 
>>Ingo,
>>    Attached is a patch relative to 2.6.14-rc5-rt5
>>which brings arch/mips up to date for PREEMPT_RT.
>>This was derived from a similar patch I had for
>>2.6.13 but I'd assumed it was rather dated to apply
>>to current work.  As it turned out both versions
>>were quite close.
> 
> 
> thanks - merged your patches, they will be in the next
> -rt release.

I neglected to mention the latency instrumentation
is a major TBD due to limitations of the MIPS ABI
which spill over into gcc.  Namely the gcc extension
__builtin_return_address(n) is not usable for 0 < n
(though I seem to recall it being broken for 0 as
well in gcc 3.4.1).

For ARM I was able to trivially walk the stack as
a substitute for __builtin_return_address().  Given
the involved and nondeterministic method of walking
the stack called out by the MIPS ABI I don't see
this as an option.  This limitation also appears to
have influenced arch/mips/kernel/traps.c: dump_stack(),
show_trace() as the ABI suggested method was abandoned.
Instead show_trace() simply scans through the entirety
of the stack, printing out anything and everything
which appears to be a valid kernel text address.  Your
stack trace is in there somewhere scattered amongst
a healthy assortment of unrelated data found in the
stack.

A potential solution may be some method of
maintaining a small circular buffer available per
thread of execution and overloading the mcount()
FUNCTION_PROLOGUE to log the entry address of the
function in which it is embedded.  However I don't
know if this is possible and even if so it doesn't
generalize well to asynchronous execution (interrupts,
exceptions) as there is no easy way to associate the
buffer context to the execution path.

Anyway this is on the back burner as I have a few
other issues to address beforehand.

-john

-- 
john.cooper@timesys.com

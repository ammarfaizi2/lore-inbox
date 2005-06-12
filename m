Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVFLPby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVFLPby (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVFLPbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:31:53 -0400
Received: from soufre.accelance.net ([213.162.48.15]:16605 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S262626AbVFLPbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:31:19 -0400
Message-ID: <42AC5542.5020307@xenomai.org>
Date: Sun, 12 Jun 2005 17:31:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
CC: linux-kernel@vger.kernel.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu>	 <42AA9651.4050404@yahoo.com.au> <1118482075.9519.52.camel@sdietrich-xp.vilm.net>
In-Reply-To: <1118482075.9519.52.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven-Thorsten Dietrich wrote:
> On Sat, 2005-06-11 at 17:44 +1000, Nick Piggin wrote:
> 
>>Ingo Molnar wrote:
>>
>>>could you send me the .config you used for the PREEMPT_RT tests? Also, 
>>>you used -47-08, which was well prior the current round of performance 
>>>improvements, so you might want to re-run with something like -48-06 or 
>>>better.
>>>
>>
>>The other thing that would be really interesting is to test latencies
>>of various other kernel functionalities in the RT kernel (eg. message
>>passing, maybe pipe or localhost read/write, signals, fork/clone/exit,
>>mmap/munmap, faulting in shared memory, or whatever else is important
>>to the RT crowd).
>>
> 
> 
> I have recently seen an analysis of this. It was internal to a customer,
> but I will ask whether they object to publishing it.
> 
> Notably, there are naturally discrepancies between user space and kernel
> tasks. An example of this is thread-spawn benchmarks. That is relevant
> to folks who have RT code with IP to protect that must run in user
> space.
> 

This said, running RT tasks in user-space is not uncommon with
nanokernel-based solutions: RTAI does this since 1999, so the "IP" 
protection argument does not stand here.

There is a crucial difference between being able to run your RT stuff
under MMU protection with stringent RT guarantees, and being able to
additionally call the native Linux services with the same set of 
guarantees. For this reason, keeping the regular programming model in 
user-space does not depend on being able to use the kernel services in a 
fully deterministic fashion.

IOW, if your RT extension is able to recycle the MMU context of any
Linux task for scheduling it in user-space without stepping on the 
kernel toes, you can actually provide for both determinism and 
protection (be it MMU or IP), even if you can't make the vanilla kernel 
services more deterministic than they are if you happen to call them. If 
you don't and always use the highly deterministic services your RT 
extension provides, then the RT guarantees are always kept.

Allowing seamless and consistent dynamic transitions between the always 
deterministic nanokernel context and the mostly deterministic Linux 
context is one way to extend the options available to the RT application 
designer. In any case, one would have to carefully select the system 
calls which could be used in the application, depending on the expected 
level of predictability and time accuracy; using a "pure" Linux 
infrastructure or going for a mixed Linux/nanokernel environment never 
breaks this invariant.

-- 

Philippe.


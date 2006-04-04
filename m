Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWDDP7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWDDP7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWDDP7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:59:39 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:64184 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750726AbWDDP7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:59:38 -0400
Date: Tue, 4 Apr 2006 17:59:27 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Ingo Molnar <mingo@elte.hu>
Cc: Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10
In-Reply-To: <20060404120003.GA15847@elte.hu>
Message-ID: <Pine.LNX.4.61.0604041726490.15050@openx3.frec.bull.fr>
References: <Pine.LNX.4.44L0.0603262214060.8060-100000@lifa03.phys.au.dk>
 <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk>
 <20060326233530.GA22496@elte.hu> <Pine.LNX.4.58.0603281142410.17504@apollon>
 <20060328204944.GA1217@elte.hu> <Pine.LNX.4.61.0604041344000.15050@openx3.frec.bull.fr>
 <20060404120003.GA15847@elte.hu>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/04/2006 18:01:49,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/04/2006 18:01:50,
	Serialize complete at 04/04/2006 18:01:50
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2006, Ingo Molnar wrote:

> 
> * Simon Derr <Simon.Derr@bull.net> wrote:
> 
> > On Tue, 28 Mar 2006, Ingo Molnar wrote:
> > 
> > First issue: 'BUG: udev:45 task might have lost a preemption check!'
> > 
> > When looking at the code in preempt_enable_no_resched(), why is the 
> > value of preempt_count() checked to be non-zero _after_ calling 
> > dec_preempt_count() ?
> > 
> > I saw several posts on this list claiming that this message is 
> > harmless, but I'd like to figure what's going on.
> 
> the warning means that doing a preempt_enable_no_resched() while being 
> in a preemptible section is most likely a bug, and that you could lose a 
> need_resched() check. (and introduce a scheduling latency) What's the 
> backtrace? This could be the sign of a not fully/correctly converted 
> arch/*/kernel/process.c (but i'm only guessing here).

Wow, thanks for the fast reply !

The backtrace is:

[<a00000010007fc50>] preempt_enable_no_resched+0xb0/0xe0
[<a000000100037510>] disabled_fph_fault+0x110/0x140
[<a0000001000378e0>] ia64_fault+0x240/0x11c0
[<a00000010000be40>] ia64_leave_kernel+0x0/0x290

But I must be severely misunderstanding something.

What I understood is that in preemptible sections preempt_count() is 
zero, and in non preemptible sections it is >0.

If preempt_count() is 1, then preempt_enable_no_resched() will decrement 
it and issue a warning. This is what happens in disabled_fph_fault().

Where am I wrong ?


> you should first check the PREEMPT_NONE kernel with PREEMPT_SOFTIRQS and 
> PREEMPT_HARDIRQS enabled. I.e. first check whether IRQ threading works.  
> Then enable all the other PREEMPT options one by one: PREEMPT_DESKTOP, 
> PREEMPT_RCU, PREEMPT_BKL. Only when all these work switch to PREEMPT_RT.
> 
Thanks, I'll try that.


	Simon.


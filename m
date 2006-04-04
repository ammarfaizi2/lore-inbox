Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWDDT1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWDDT1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWDDT1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:27:37 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:22479 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750826AbWDDT1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:27:36 -0400
Date: Tue, 4 Apr 2006 15:27:25 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Simon Derr <Simon.Derr@bull.net>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10
In-Reply-To: <Pine.LNX.4.61.0604041726490.15050@openx3.frec.bull.fr>
Message-ID: <Pine.LNX.4.58.0604041519550.16335@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.0603262214060.8060-100000@lifa03.phys.au.dk>
 <Pine.LNX.4.44L0.0603262255150.8060-100000@lifa03.phys.au.dk>
 <20060326233530.GA22496@elte.hu> <Pine.LNX.4.58.0603281142410.17504@apollon>
 <20060328204944.GA1217@elte.hu> <Pine.LNX.4.61.0604041344000.15050@openx3.frec.bull.fr>
 <20060404120003.GA15847@elte.hu> <Pine.LNX.4.61.0604041726490.15050@openx3.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Apr 2006, Simon Derr wrote:

>
> But I must be severely misunderstanding something.
>
> What I understood is that in preemptible sections preempt_count() is
> zero, and in non preemptible sections it is >0.
>
> If preempt_count() is 1, then preempt_enable_no_resched() will decrement
> it and issue a warning. This is what happens in disabled_fph_fault().
>
> Where am I wrong ?

You're not.

There's nothing unstable about it.  The problem is that you didn't
schedule when you could have.  With Linux, this really isn't an issue,
but with the -rt kernel we concentrate on low latency, and by not
calling schedule when preempt count goes to zero and the need_resched
flag may be set, you may be delaying a high priority process
unnecessarily, for longer than needed.  This in the -rt kernel _is_ a
bug.

So for a stability point of view, that missed schedule wont crash the
kernel, but it might cause an xrun in JACK.

Now, sometimes a call to preempt_enable_no_resched is called just before
schedule is called, this is done so you don't have a double schedule.
For this, it is ok to call *_no_resched, but you need to flag that this
is ok by calling __preempt_enable_no_resched directly.

-- Steve

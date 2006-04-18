Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWDRNcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWDRNcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWDRNcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:32:00 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:38375 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750943AbWDRNb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:31:59 -0400
Subject: Re: RT question : softirq and minimal user RT priority
From: Steven Rostedt <rostedt@goodmis.org>
To: dmarkh@cfl.rr.com
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       markh@compro.net, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <44449EE2.8070907@cfl.rr.com>
References: <200601131527.00828.Serge.Noiraud@bull.net>
	 <1137167600.7241.22.camel@localhost.localdomain>
	 <4443966B.8020802@compro.net> <1145286325.16138.26.camel@mindpipe>
	 <44449EE2.8070907@cfl.rr.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 09:31:51 -0400
Message-Id: <1145367111.17085.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 04:10 -0400, Mark Hounschell wrote:
> Lee Revell wrote:
> > Please don't trim CC lists
> > 
> 
> Sorry.

No prob ;)

> 
> > On Mon, 2006-04-17 at 09:21 -0400, Mark Hounschell wrote:
> >> Steven Rostedt wrote:
> >>>> Is the smallest usable real-time priority greater than the highest real-time softirq ?
> >>> Nope, you can use any rt priority you want.  It's up to you whether you
> >>> want to preempt the softirqs or not. Be careful, timers may be preempted
> >>> from delivering signals to high priority processes.  I have a patch to
> >>> fix this, but I'm waiting on input from either Thomas Gleixner or Ingo.
> >>>
> >>> -- Steve
> >> I know this is an old thread but I seem to be having a problem similar
> >> to this and I didn't find any real resolution in the archives.
> >>
> >> I'm using the rt16 patch on 2.6.16.5 with complete preemption. I have a
> >> high priority rt compute bound task that isn't getting signals from a
> >> pci cards interrupt handler. Only when I insure the rt priority of the
> >> task is lower than the rt priority of the irq thread ([IRQ 193]) will my
> >> task receive signals.
> >>
> >> Is this a bug? Is the bug in my interrupt handler? Or is this expected
> >> and acceptable?
> > 
> > It's expected if your high priority RT task never gives up the CPU - if
> > this is the case the IRQ thread should have higher priority.
> > 
> > Lee
> 
> The default IRQ threads seem to be at RT priorities 25-49. So a user
> should never have a RT compute bound task at a RT priority higher than
> 25? Doesn't seem quite right. In any case, I have other less compute
> bound lower priority RT tasks also running on the same CPU so my high
> priority RT task must be giving up the CPU somewhere along the line. Why
> is it not able to receive signals? Something is not quite right here.

Those are just defaults, If a user is going to run a higher priority
task and needs the use to those IRQS then they need to adjust the
priorities of the interrupts themselves.

But remember that the softirqs which handle the bottom halve of
interrupts are also threads, and they run at even a lower priority.  So
if the interrupt uses its bottom half to send a signal to the process,
then if you have a RT task lower in priority than the IRQ but higher
than the softirq, it can still prevent the signal being sent.

Could you send a sample program that shows us the problem?  This would
help us out in figuring out what is wrong.  I still suspect that it's a
configuration problem, but who knows, maybe you found an indiscernible
bug.

Also, I've been ask to write a section in an O'Reilly book about how to
use the -rt patch.  Knowing problems that users may have (such as the
one you are experiencing) would help greatly in explaining to others the
proper way to configure their setup.

Thanks,

-- Steve



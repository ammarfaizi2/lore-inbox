Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWCRW2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWCRW2X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 17:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWCRW2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 17:28:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751102AbWCRW2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 17:28:22 -0500
Date: Sat, 18 Mar 2006 14:25:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, trini@kernel.crashing.org
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Message-Id: <20060318142520.2dcbb46c.akpm@osdl.org>
In-Reply-To: <1142719518.10017.17.camel@localhost.localdomain>
References: <20060318142827.419018000@localhost.localdomain>
	<20060318142830.607556000@localhost.localdomain>
	<20060318120728.63cbad54.akpm@osdl.org>
	<1142712975.17279.131.camel@localhost.localdomain>
	<20060318123102.7d8c048a.akpm@osdl.org>
	<1142714332.17279.148.camel@localhost.localdomain>
	<20060318130925.616d11c5.akpm@osdl.org>
	<1142719518.10017.17.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 2006-03-18 at 13:09 -0800, Andrew Morton wrote:
> > > Of course I can convert it that way, if we want to keep this "help
> > > sloppy programmers aid" alive.
> > > 
> > 
> > It would be strange to set an alarm for 0xffffffff seconds in the future
> > but yeah, unless we can point at a reason why nobody could have ever been
> > doing that, we should turn this into permanent, documented behaviour of
> > Linux 2.6 and earlier, I'm afraid.
> 
> We have to take two things into account:
> 
> 1. sys_alarm()
> 
> The alarm value 0xFFFFFFFF is valid as the argument to alarm() is an
> unsigned int. So we have to convert this to 0x7FFFFFFF (for 32bit
> machines) because timeval.tv_sec is a signed long. This is done by the
> alarm patch, which is necessary whether we check the sanity of the
> timeval in do_setitimer or not. The current -rc6 kernel sends the alarm
> with the next timer tick, which will break an application which set it
> to something > INT_MAX. 
> 
> Of course we could do this by the silent conversion of negative values
> in setitimer too. But thats insane as we rely on some broken feature.

So you're saying that sys_alarm(0xffffffff) needs to behave as
sys_alarm(0x7ffffffff)?

I guess if we have to do it that way, the risk of breaking anything is very
small.

What's the 2.4/2.6.13 behaviour of sys_alarm(0xffffffff)?

> 2. setitimer()
> 
> An application would have to set value.it_value.tv_sec to a negative
> value to trigger this. Also uninitialized usage of struct timevals can
> cause such behaviour.
> 
> I'm not sure, if it is sane to ingore this.

What does 2.4/2.6.13 do?   Let's do that.

If you're proposing that we depart from previous behaviour by converting
setitimer(0xffffffff) into setitimer(0x7fffffff) then I guess we could live
with that.

> I can change the itimer
> validate patch for now to do
> 
> if (unlikely(!timeval_valid(v))
> 	fixup_timeval(v);
> 
> and print an appropriate warning in fixup_timeval() for the time being.
> 

No, we cannot warn - it'll enable unprivileged users to spam the logs.

One could generate a once-per-reboot warning, I guess.  The message should
include the PID and current->comm.


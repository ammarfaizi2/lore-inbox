Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSGFTny>; Sat, 6 Jul 2002 15:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSGFTnx>; Sat, 6 Jul 2002 15:43:53 -0400
Received: from [24.114.147.133] ([24.114.147.133]:25995 "EHLO starship")
	by vger.kernel.org with ESMTP id <S315806AbSGFTnw>;
	Sat, 6 Jul 2002 15:43:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Stephen Tweedie <sct@redhat.com>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Date: Sat, 6 Jul 2002 21:40:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Pavel Machek <pavel@ucw.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "Stephen C. Tweedie" <sct@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020702123718.A4711@redhat.com> <20020703234750Z16173-11563+874@humbolt.nl.linux.org> <20020705104049.H27198@redhat.com>
In-Reply-To: <20020705104049.H27198@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17QvQ4-0001TZ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 July 2002 11:40, Stephen Tweedie wrote:
> Hi,
> 
> On Thu, Jul 04, 2002 at 01:48:59AM +0200, Daniel Phillips
> <phillips@arcor.de> wrote:
> 
> > Is it just the mod_dec_use_count; return/unload race we're worried about? 

> > I'm not clear on why this is hard.  I'd think it would be sufficient just 
> > to walk all runnable processes to ensure none has an execution address 
> > inside the module.
> 
> That fails if:
> 
> the module function has called somewhere else in the kernel (and
> with -fomit-frame-pointer, you can't reliably walk back up the stack
> to find out if there is a stack frame higher up the stack which is in
> the module);

Hi Stephen,

I'm assuming for the sake of argument that we're requiring the use count to 
be incremented for any call outside the module, a rule we might want anyway, 
since it is less fragile than the no-sleeping rule.

> the module has taken an interrupt into an unrelated driver;

With Ben's new separate interrupt stacks the current IP would be available at 
a known place at the base of the interrupt stack.

> we have computed a call into the module but haven't actually executed
> the call yet;

This one is problematic, and yes, I now agree the problem is hard. This is 
where Keith's handwaving comes in: we are supposed to have deregistered the 
module's services and ensured all processes are out of the module at this 
point.  I don't know how that helps, really.  I just want to note that this 
seems to be the only really hard problem.  It's not insoluable though: going 
to extremes we could record each region of code from which module calls 
originate and check for execution addresses in that region, along with 
execution addresses in the module.  Picking up the call address would have to 
be an atomic read.  You don't have to tell me this is ugly and slow, but it 
would work.

> etc. 

You enumerated all the areas of concern that I'd identified, so I'm curious 
what the etc stands for.

> > For smp, an ipi would pick up the current process on each cpu.
> 
> Without freezing the other CPUs, that still leaves the race wide open.

With per-cpu runqueues, we take an ipi onto each processor and take the 
task's runqueue lock.   We can now check each runnable task, and the task the 
ipi interrupted.  Repeating for each processor, the only door we have to 
close is inter-processor task migration, which is not a fast path.  So this 
part, at least, seems doable.

Anyway, I'm beginning to see what all the fuss is about.

-- 
Daniel

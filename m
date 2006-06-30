Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933000AbWF3SvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000AbWF3SvI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933024AbWF3SvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:51:08 -0400
Received: from palrel10.hp.com ([156.153.255.245]:56764 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S933000AbWF3SvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:51:06 -0400
Date: Fri, 30 Jun 2006 11:43:03 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060630184303.GA22835@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606301435_MC3-1-C3DD-5B3E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606301435_MC3-1-C3DD-5B3E@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Fri, Jun 30, 2006 at 02:33:49PM -0400, Chuck Ebbert wrote:
> In-Reply-To: <200606301541.22928.ak@suse.de>
> 
> On Fri, 30 Jun 2006 15:41:22 +0200, Andi Kleen wrote:
> 
> > > So why do we need care about context switch in cpu-wide mode?
> > > It is because we support a mode where the idle thread is excluded
> > > from cpu-wide monitoring. This is very useful to distinguish 
> > > 'useful kernel work' from 'idle'. 
> > 
> > I don't quite see the point because on x86 the PMU doesn't run
> > during C states anyways. So you get idle excluded automatically.
> 
> Looks like it does run:
> 
> $ pfmon -ecpu_clk_unhalted,interrupts_masked_cycles -k --system-wide -t 10
> <session to end in 10 seconds>
> CPU0     60351837 CPU_CLK_UNHALTED
> CPU0    346548229 INTERRUPTS_MASKED_CYCLES
> 
> The CPU spent ~60 million clocks unhalted and ~350 million with interrupts
> disabled.  (This is an idle 1.6GHz Turion64 machine.)
> 
I think it stops counting only CERTAIN events. That's where it becomes difficult
to interpret. There was a defect like this on Itanium 2.

> Now let's see what happens when we exclude the idle thread:
> 
> $ pfmon -ecpu_clk_unhalted,interrupts_masked_cycles -k --system-wide -t 10 --excl-idle
> <session to end in 10 seconds>
> CPU0    449250 CPU_CLK_UNHALTED
> CPU0    161577 INTERRUPTS_MASKED_CYCLES
> 
> Looks like excluding the idle thread means interrupts that happen while idle
> don't get counted either.  We took 5000 clock interrupts and I know they take
> longer than that to process.
> 

Yes, the way it is implemented today means that nothing happening while the idle
threads runs/sleeps is counted. Monitoring is disabled at context switch boundaries
for task->pid==0.

I would rather have something that would stop counting *EVERYTHING* ONLY when
going low-power OR when busy looping. That's why the idle notififers that Andi mentioned
are interesting. But this would not cover interrupts received while in idle and yet we
want to measure those as they represent useful kernel work. This is unless interrupts while
idle qualifies for an exit_idle() notification.

-- 
-Stephane

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWGDPhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWGDPhN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWGDPhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:37:13 -0400
Received: from palrel13.hp.com ([156.153.255.238]:3201 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S932259AbWGDPhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:37:11 -0400
Date: Tue, 4 Jul 2006 08:28:57 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060704152857.GA6999@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200607011123_MC3-1-C3EB-BFF1@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607011123_MC3-1-C3EB-BFF1@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Sat, Jul 01, 2006 at 11:21:22AM -0400, Chuck Ebbert wrote:
> In-Reply-To: <20060630204032.GB22835@frankl.hpl.hp.com>
> 
> On Fri, 30 Jun 2006 13:40:32 -0700, Stephane Eranian wrote:
> 
> > As Andi is suggesting, I think this may depends on how the BIOS implements
> > the low-power state. I have tried the same command on my dual Opteron 250
> > 2.4GHz and I get:
> > $ pfmon --us-c -ecpu_clk_unhalted,interrupts_masked_cycles -k --system-wide -t 10
> > <session to end in 10 seconds>
> > CPU0                     9,520,303 CPU_CLK_UNHALTED
> > CPU0                     3,726,315 INTERRUPTS_MASKED_CYCLES
> > CPU1                    21,268,151 CPU_CLK_UNHALTED
> > CPU1                    14,515,389 INTERRUPTS_MASKED_CYCLES
> 
> That is similar to what I get with idle=halt. Are you not using ACPI
> for idle?
> 
> Try this:
> 
> $ pfmon -ecpu_clk_unhalted,interrupts_masked_cycles_with_interrupt_pending,interrupts_masked_cycles,cycles_no_fpu_ops_retired -k --system-wide -t 10
> <session to end in 10 seconds>
> CPU0     95016828 CPU_CLK_UNHALTED
> CPU0     36472783 INTERRUPTS_MASKED_CYCLES_WITH_INTERRUPT_PENDING
> CPU0     67484408 INTERRUPTS_MASKED_CYCLES
> CPU0    445326968 CYCLES_NO_FPU_OPS_RETIRED
> 
> That's what I get with idle=halt.  Since the kernel doesn't do FP
> the last line should equal clock cycles.  If it were running at full
> speed it would be 16 billion...

Here is what I get on my dual 2.4GHz Opteron 250:

booted with idle=halt
$ pfmon --us-c -ecpu_clk_unhalted,interrupts_masked_cycles_with_interrupt_pending,interrupts_masked_cycles,cycles_no_fpu_ops_retired -k --system-wide -t 10
<session to end in 10 seconds>
CPU0                    11,356,210 CPU_CLK_UNHALTED                               
CPU0                             0 INTERRUPTS_MASKED_CYCLES_WITH_INTERRUPT_PENDING
CPU0                     3,836,107 INTERRUPTS_MASKED_CYCLES                       
CPU0                23,910,784,532 CYCLES_NO_FPU_OPS_RETIRED                      
CPU1                    19,303,632 CPU_CLK_UNHALTED                               
CPU1                             0 INTERRUPTS_MASKED_CYCLES_WITH_INTERRUPT_PENDING
CPU1                    13,942,265 INTERRUPTS_MASKED_CYCLES                       
CPU1                23,911,872,654 CYCLES_NO_FPU_OPS_RETIRED                      

As you can see, CYCLES_NO_FPU_OPS_RETIRED on each CPU is as expected  for 10s.

booted with idle=poll
$ pfmon --us-c -ecpu_clk_unhalted,interrupts_masked_cycles_with_interrupt_pending,interrupts_masked_cycles,cycles_no_fpu_ops_retired -k --system-wide -t 10
<session to end in 10 seconds>
CPU0                23,906,091,982 CPU_CLK_UNHALTED                               
CPU0                             0 INTERRUPTS_MASKED_CYCLES_WITH_INTERRUPT_PENDING
CPU0                     3,771,569 INTERRUPTS_MASKED_CYCLES                       
CPU0                23,906,090,750 CYCLES_NO_FPU_OPS_RETIRED                      
CPU1                23,906,629,241 CPU_CLK_UNHALTED                               
CPU1                             0 INTERRUPTS_MASKED_CYCLES_WITH_INTERRUPT_PENDING
CPU1                    14,805,078 INTERRUPTS_MASKED_CYCLES                       
CPU1                23,906,194,343 CYCLES_NO_FPU_OPS_RETIRED                      

CYCLES_NO_FPU_OPS_RETIRED is as expected and, in this case, it is equal to CPU_CLK_UNHALTED
because we are busy looping.

If I don't specify anything, I get like idle=halt which is expected.

-- 
-Stephane

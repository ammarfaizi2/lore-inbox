Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWF3Sgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWF3Sgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933001AbWF3Sgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:36:54 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:59349 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932468AbWF3Sgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:36:53 -0400
Date: Fri, 30 Jun 2006 14:33:49 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU
  context switch
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephane Eranian <eranian@hpl.hp.com>
Message-ID: <200606301435_MC3-1-C3DD-5B3E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606301541.22928.ak@suse.de>

On Fri, 30 Jun 2006 15:41:22 +0200, Andi Kleen wrote:

> > So why do we need care about context switch in cpu-wide mode?
> > It is because we support a mode where the idle thread is excluded
> > from cpu-wide monitoring. This is very useful to distinguish 
> > 'useful kernel work' from 'idle'. 
> 
> I don't quite see the point because on x86 the PMU doesn't run
> during C states anyways. So you get idle excluded automatically.

Looks like it does run:

$ pfmon -ecpu_clk_unhalted,interrupts_masked_cycles -k --system-wide -t 10
<session to end in 10 seconds>
CPU0     60351837 CPU_CLK_UNHALTED
CPU0    346548229 INTERRUPTS_MASKED_CYCLES

The CPU spent ~60 million clocks unhalted and ~350 million with interrupts
disabled.  (This is an idle 1.6GHz Turion64 machine.)

Now let's see what happens when we exclude the idle thread:

$ pfmon -ecpu_clk_unhalted,interrupts_masked_cycles -k --system-wide -t 10 --excl-idle
<session to end in 10 seconds>
CPU0    449250 CPU_CLK_UNHALTED
CPU0    161577 INTERRUPTS_MASKED_CYCLES

Looks like excluding the idle thread means interrupts that happen while idle
don't get counted either.  We took 5000 clock interrupts and I know they take
longer than that to process.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush

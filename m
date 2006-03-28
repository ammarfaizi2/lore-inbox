Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWC1Dhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWC1Dhs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 22:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWC1Dhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 22:37:48 -0500
Received: from mga06.intel.com ([134.134.136.21]:33627 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751230AbWC1Dhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 22:37:47 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,136,1141632000"; 
   d="scan'208"; a="15888947:sNHT5761007903"
Date: Mon, 27 Mar 2006 19:15:19 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: prevent high load weight tasks suppressing balancing
Message-ID: <20060327191519.C12364@unix-os.sc.intel.com>
References: <4427873A.4010601@bigpond.net.au> <20060327135204.B12364@unix-os.sc.intel.com> <44287382.4050108@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <44287382.4050108@bigpond.net.au>; from pwil3058@bigpond.net.au on Tue, Mar 28, 2006 at 10:21:38AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 10:21:38AM +1100, Peter Williams wrote:
> Siddha, Suresh B wrote:
> > This breaks HT and MC optimizations.. Consider a DP system with each
> > physical processor having two HT logical threads.. if there are two 
> > runnable processes running on package-0, with this patch scheduler 
> > will never move one of those processes to package-1..
> 
> Is this an active_load_balance() issue?

No. find_busiest_group() doesn't find an imbalance in this case..

> If it is then I suggest that the solution is to fix the 
> active_load_balance() and associated code so that it works with this 
> patch in place.
> 
> It would be possible to modify find_busiest_group() and 
> find_busiest_queue() so that they just PREFER the busiest group to have 
> at least one CPU with more than one running task and the busiest queue 
> to have more than one task.  However, this would make the code 

Please don't do that... Its not for the complexity I say NO but we 
are kind of patching the code instead of addressing the root issue..

> considerably more complex and I'm reluctant to impose that on all 
> architectures just to satisfy HT and MC requirements.  Are there 
> configuration macros or other means that I can use to exclude this 
> (proposed) code on systems where it isn't needed i.e. non HT and MC 
> systems or HT and MC systems with only one package.

There is no config option to disable that portion of the code. Interaction
of this code with mainstream code is very small. Look at the
active_load_balance() and how this comes into play with the help of
migration thread(which gets activated through load_balance)

> Personally, I think that the optimal performance of the load balancing 
> code has already been considerably compromised by its unconditionally 
> accommodating the requirements of active_load_balance() (which you have 
> said is now only required by HT and MC systems) and that it might be 
> better if active load balancing was separated out into a separate 
> mechanism that could be excluded from the build on architectures that 
> don't need it.  I can't help thinking that this would result in a more 
> efficient active load balancing mechanism as well because the current 
> one is very inefficient.

No. Upto now, this has been encapsulated very generically using cpu_power
and thats the reason why adding a sched domain for multi-core was simple.

> Peter
> PS I don't think that this issue is sufficiently important to prevent 
> the adoption of the smpnice patches while it's being resolved.

Scheduler is a very critical piece in the kernel. We need to understand and fix
all the cases..

thanks,
suresh

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTEVBvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 21:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTEVBvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 21:51:52 -0400
Received: from holomorphy.com ([66.224.33.161]:32905 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262451AbTEVBvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 21:51:48 -0400
Date: Wed, 21 May 2003 19:04:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
       haveblue@us.ibm.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mannthey@us.ibm.com
Subject: Re: userspace irq balancer
Message-ID: <20030522020443.GN2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gerrit Huizenga <gh@us.ibm.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
	haveblue@us.ibm.com, pbadari@us.ibm.com,
	linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
	mannthey@us.ibm.com
References: <3014AAAC8E0930438FD38EBF6DCEB5640204334F@fmsmsx407.fm.intel.com> <E19Idxq-0001LD-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19Idxq-0001LD-00@w-gerrit2>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 05:29:45PM -0700, Gerrit Huizenga wrote:
> Yeah, I suppose this userland policy change means we should pull
> the scheduler policy decisions out of the kernel and write user level
> HT, NUMA, SMP and UP schedulers.  Also, the IO schedulers should
> probably be pulled out - I'm sure AS and CFQ and linus_scheduler
> could be user land policies, as well as the elevator.  Memory
> placement and swapping policies, too.
> Oh, wait, some people actually do this - they call it, what,
> Workload Management or some such thing.  But I don't know any
> style of workload management that leaves *no* default, semi-sane
> policy in the kernel.

This is not the case. Interrupt arbitration for sane things generally
balances interrupt load automatically in-hardware. AIUI the TPR was
intended to enable the hardware to do such a thing for xAPIC. Linux
doesn't use the TPR now, which results in decisions made by the
hardware on xAPIC -based SMP systems that are highly detrimental to
performance.

Allowing userspace to exploit more specific knowledge and perform
either static or userspace-controlled dynamic interrupt affinity
is not equivalent to having an insane default policy in-kernel.

The task scheduler, the io scheduler, and memory entitlement policies
are very different issues. They deal entirely with managing software
constructs and resource allocation. Memory placement policies sit at
least two or three levels above anything hardware memory management
can do and it is safe to say it's infeasible to implement NUMA memory
placement policies in hardware.

Interrupt load balancing is very much doable in hardware and prior to
xAPIC it was done so in all cases; for xAPIC the hardware mechanism
became strictly bound to the TPR and had less optimal tiebreak
resolution decisions (something on the order of defaulting to the
lowest APIC ID in the event of a tie, which always occurs if the TPR
isn't frobbed). This naturally creates a problem, which these userspace
and kernel mechanisms are meant to address.

The difficulty with the in-kernel policy is that its decisions are not
optimal for all cases, and it has implementation issues that prevent it
from being fully generally used, i.e. it does not handle the physical
DESTMOD case for pre-xAPIC systems with multiple APIC buses, which
amounts to a very simple incompleteness of what to all outward
appearances is an already large and feature-rich implementation; the
kernel code merely refrains from calling it in that case as a brute-
force workaround. Furthermore the complexity of the decisions to be
made is inappropriate for the kernel. It needs unusual (and slow)
manipulation of hardware to be done in code requiring fast response
times in various cases and that is called at an uncontrollable rate. It
has heuristics which may be inaccurate or wrong for various cases. 

IMHO Linux on Pentium IV should use the TPR in conjunction with _very_
simplistic interrupt load accounting by default and all more
sophisticated logic should be punted straight to userspace as an
administrative API.

To quote chapter and verse:

IA-32 Intel Architecture Software Developer's Manual
Volume 3: System Programming Guide
Section 8.6.2.4 "Lowest Priority Delivery Mode"

"In operating systems that use the lowest-priority delivery mode but do
not update the TPR, the TPR information saved in the chipset will
potentially cause the interrupt to always be delivered to the same
processor from the logical set. This behavior is functionally backward
compatible with the P6 family processor but may result in unexpected
performance implications."

i.e. frob the fscking TPR as recommended by the APIC docs every once in
a while by default, punt anything (and everything) fancier up to
userspace, and get the code that doesn't even understand what the fsck
DESTMOD means the Hell out of the kernel and the Hell away from my
IO-APIC RTE's.


-- wli

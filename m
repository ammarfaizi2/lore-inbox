Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTE0CQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTE0CQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:16:32 -0400
Received: from holomorphy.com ([66.224.33.161]:43208 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262464AbTE0CQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:16:29 -0400
Date: Mon, 26 May 2003 19:26:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, akpm@digeo.com, davidsen@tmr.com,
       haveblue@us.ibm.com, habanero@us.ibm.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527022617.GE8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"David S. Miller" <davem@redhat.com>, akpm@digeo.com,
	davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
	mbligh@aracnet.com, linux-kernel@vger.kernel.org
References: <20030527000639.GA3767@dualathlon.random> <20030526.171527.35691510.davem@redhat.com> <20030527004115.GD3767@dualathlon.random> <20030526.174841.116378513.davem@redhat.com> <20030527015307.GC8978@holomorphy.com> <20030527021407.GM3767@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527021407.GM3767@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 06:53:07PM -0700, William Lee Irwin III wrote:
>> I should also point out that the cost of reprogramming the interrupt
>> controllers isn't taken into account by the kernel irq balancer. In

On Tue, May 27, 2003 at 04:14:07AM +0200, Andrea Arcangeli wrote:
> do you want to take that into account in userspace? if there's a place to
> take that into account that place is the kernel. You can even benchmark
> it at boot.

Userspace is preemptable and schedulable, so it's inherently rate
limited.


On Mon, May 26, 2003 at 06:53:07PM -0700, William Lee Irwin III wrote:
>> the userspace implementation the reprogramming is done infrequently
>> enough to make even significant cost negligible; in-kernel the cost
>> is entirely uncontrolled and the rate of reprogramming unlimited.

On Tue, May 27, 2003 at 04:14:07AM +0200, Andrea Arcangeli wrote:
> depends on the kernel algorithm.
> I feel like the in kernel algorithm is considered to be the one floating
> around that reprograms the apic even when it makes zero changes to the
> routing, like if nothing else was possible to do in kernel.
> start like this: put the userspace algorithm in kernel, then add a
> few bytes of info to keep an average of the idle cpus every second, then
> after 30 seconds a cpu is idle start to route the irqs to such idle cpu,
> slowly, after 60 seconds more aggressively. etc... For such an algorithm
> you don't care less about the reprogramming speed, just like with the
> current "userspace" algorithm, but thanks to the kernel info it will be
> able to do smarter decisions that would never be possible in userspace
> (w/o tlb flushing waste, and w/o kernel->user microkernel protocol
> implementation waste).

No, I'm not assuming that level of naivete. My primary interest is that
the amount of work be properly rate limited, and running at fixed
intervals isn't quite enough; it needs to be bounded amounts of work at
fixed intervals. I failed to point this out, but something more
incremental than a NR_IRQS sweep across all IRQ's every 60s is needed
for proper rate limiting.


On Mon, May 26, 2003 at 06:53:07PM -0700, William Lee Irwin III wrote:
>> The story of APIC code tripping over itself is an even unfunnier comedy
>> of errors, as the lack of TPR adjustment means that within any APIC
[...]

On Tue, May 27, 2003 at 04:14:07AM +0200, Andrea Arcangeli wrote:
> again, reading this I feel like there's the idea that the only possible
> kernel algorithm is the one that bounces stuff and reprograms stuff as
> quickly as it can like the hardware one did.

This is actually a more general concern about correctness. Any
in-kernel algorithm must rely on the in-kernel IO-APIC RTE formation
code, which is highly problematic at best, as partially described by
all of the confusions and incorrect declarations mentioned above. Even
the "Wal-Mart" SMP subarch, used for the most common of i386 machines,
incorrectly declares its physical broadcast destination to be non-xAPIC
physical broadcast despite being used for Pentium IV and prior cpus.


-- wli

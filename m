Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTE0Bn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTE0Bn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:43:29 -0400
Received: from holomorphy.com ([66.224.33.161]:27335 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262426AbTE0Bn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:43:27 -0400
Date: Mon, 26 May 2003 18:53:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: andrea@suse.de, akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com,
       habanero@us.ibm.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527015307.GC8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, andrea@suse.de,
	akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com,
	habanero@us.ibm.com, mbligh@aracnet.com,
	linux-kernel@vger.kernel.org
References: <20030527000639.GA3767@dualathlon.random> <20030526.171527.35691510.davem@redhat.com> <20030527004115.GD3767@dualathlon.random> <20030526.174841.116378513.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526.174841.116378513.davem@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 05:48:41PM -0700, David S. Miller wrote:
> Andrea, whether ksoftirqd processes the softirq work or not has
> nothing to do with what I'm talking about.
> It is all about what does a hardware IRQ mean in terms of work
> processed.  And it can mean anything from 1 to 1000 packets worth
> of work.
> Therefore, any usage of hardware IRQ activity to determine "load" in
> any sense is totally inaccurate.
> So I'm asking you, again, how are you going to measure softirq load in
> making hardware IRQ load balancing decisions?  Watching the scheduling
> and running of ksoftirqd is not an answer.  Networking hardware
> interrupts, with a simplistic and mindless algorithm like the one we
> have currently in the 2.5.x IRQ balancing code, appear to be
> contributing very little to "load" and that is wrong.

I should also point out that the cost of reprogramming the interrupt
controllers isn't taken into account by the kernel irq balancer. In
the userspace implementation the reprogramming is done infrequently
enough to make even significant cost negligible; in-kernel the cost
is entirely uncontrolled and the rate of reprogramming unlimited.

Also, Linux' i386 IO-APIC programming model is quite fragile and does
not properly distinguish between physical and logical destinations or
SAPIC vs. xAPIC (which differ in the physical destination format) to
keep it coherent with i386 IO-APIC's DESTMOD. I would very much like to
see that confusion corrected before any significant amount of online
i386 IO-APIC RTE reprogramming is considered "stable". For instance, I
know of one subarch that claims to use logical DESTMOD with clustered
hierarchical DFR, but is using what appears to be SAPIC physical
broadcast for the RTE's, and a couple of other confusions where the
types of APIC ID's are ambiguous depending on subarch and broken by
dynamic reprogramming. It furthermore assumes flat logical DFR by
virtue of attempting to form APIC destinations representing arbitrary
sets of cpus in addition to assuming at least logical with
cpumask_to_logical_apicid() and is one of the major reasons irqbalance
is either disabled or unusable in various subarches.

The story of APIC code tripping over itself is an even unfunnier comedy
of errors, as the lack of TPR adjustment means that within any APIC
destination at which IO-APIC RTE's are targeted on Pentium IV systems
there will always be just a single cpu at which all interrupts are
concentrated. In order to work around this, all of the buggy code
choking on the fact arbitrary sets of cpus aren't representable as APIC
destinations is actually unused except as a buggy translation layer
from cpu ID's to APIC destinations, and the irqbalancing code works
around this by forming singleton cpumasks, which have historically been
frequently confused with APIC destinations of all 4 different formats.

Basically, the kernel has yet to handle IO-APIC RTE programming
properly, and until there is a remote semblance of action moving it
toward the correct formation of IO-APIC RTE's, in-kernel irqbalancing
is a house of cards built on rapidly shifting sands. There is no point
in anything but a userspace driver where the complexity the kernel has
failed to handle thus far can be punted, or reliance on hardware
mechanisms like the TPR that insulate the kernel from its prior and
current embarrassments in handling this complexity, until something is
done to correct IO-APIC RTE formation.


-- wli

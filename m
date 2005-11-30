Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVK3QDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVK3QDH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVK3QDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:03:07 -0500
Received: from palrel12.hp.com ([156.153.255.237]:25220 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1751423AbVK3QDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:03:06 -0500
Date: Wed, 30 Nov 2005 08:01:59 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Nicholas Miell <nmiell@comcast.net>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [discuss] Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051130160159.GB8511@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <20051129221915.GA6953@frankl.hpl.hp.com> <20051129225155.GT19515@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129225155.GT19515@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Tue, Nov 29, 2005 at 11:51:55PM +0100, Andi Kleen wrote:
> On Tue, Nov 29, 2005 at 02:19:15PM -0800, Stephane Eranian wrote:
> > 
> > On AMD you only have 4 counters. That's not a lot for some measurements.
> 
> Disabling the NMI watchdog for that is out of question. It's a important
> debugging device and without it kernel bug reports are much worse.
> It increased the quality of x86-64 bug reports over the years
> considerably and I'm unwilling to give that up.
> 

So if I understand correctly, the kernel would program a counter
to count elapsed cycles while executing a ring 0 and ring 3. The watchdog
works by polling on the counter and after a certain delta is reached it
triggers an NMI interrupt which, in turn, causes a kernel crash and the
(bug) report. Is that the correct behavior?

> > but it does only implement 47bits. At a high clock rate, this can wrap
> > around fairly rapidly. It all depends on what is the intended usage model.
> 
> TSC also doesn't count cycles in many circumstances (different frequency 
> depending on P states or not synchronized over CPUs, even running
> at completely different frequencies etc.) 
> 

Well the big difference here is that once the counter reaches 2^{47}, it goes
back to zero, i.e., it wraps around silently by default. If you are polling
it, you will suddenly see a huge delta and think that a long perriod of time
has elapsed when in fact it is just one cycle. The TSC may not count all cycles
but the user sees the counter has continuously increasing.

Also are you sure that the PERFCTR0/PERFSEL0 are not affected when going
into lower power state? I know by experience that one IA-64, for instance,
the counters are seriously affected.

> Good debugging infrastructure has priority imho - and NMI watchdog
> is important. You will need to live with three counters.
> 

As Ray mentioned, it all depends on what the user/sysdamin is after.
Some people maybe okay with disbaling NMI in favor of more counters.
Obviously others people are not.

> This means there is one alternative - some of the newer chipsets
> have external watchdogs that could be also used (using the ACPI WDOG
> table).  If someone writes a nice NMI driver for these then on system
> with working WDOG it could replace the perfctr based timeout and free
> the perfctr. That would need some code to allocate and deallocate
> perfctrs though.
> 
I discussed the idea of an abitration layer to access performance
counters with David Gibson a coule of months ago. I do believe this is
an important mechanism to have and I would like to restart the discussion
on this topic. You are providing us another reason why this could
be useful.

-- 
-Stephane

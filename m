Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWJIGLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWJIGLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 02:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWJIGLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 02:11:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18367 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932249AbWJIGLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 02:11:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>, Roland Dreier <rdreier@cisco.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<20061006155021.GE14186@rhun.haifa.ibm.com>
	<m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	<20061006202324.GJ14186@rhun.haifa.ibm.com>
	<m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
	<20061007080315.GM14186@rhun.haifa.ibm.com>
	<m14pugxe47.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610071154510.3952@g5.osdl.org>
	<1160249585.3000.159.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0610071255480.3952@g5.osdl.org>
Date: Mon, 09 Oct 2006 00:06:47 -0600
In-Reply-To: <Pine.LNX.4.64.0610071255480.3952@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 7 Oct 2006 12:57:50 -0700 (PDT)")
Message-ID: <m1hcyerpjc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 7 Oct 2006, Arjan van de Ven wrote:
>> 
>> it seems the right mix at this time is to have the software select the
>> package, and the hardware pick the core within the package. 
>
> I think that sounds like a fairly good approach.
>
> Software obviously can make the "rough" selections, it's the fine-grained 
> ones that are harder (and might need to be done at a frequency that just 
> makes it impractical).
>
> So yes, having software say "We want to steer this particular interrupt to 
> this L3 cache domain" sounds eminently sane.
>
> Having software specify which L1 cache domain it wants to pollute is 
> likely just crazy micro-management.

The current interrupt delivery abstraction in the kernel is a
set of cpus an interrupt can be delivered to.  Which seem sufficient
to the cause of aiming at a cache domain.  Frequently the lower
levels of interrupt delivery map this to a single cpu because of
hardware limitations but in certain cases we can honor a multiple cpu
request.

I believe the scheduler has knowledge about different locality domains
for NUMA and everything else.  So what is wanting on our side is some
architecture? work to do the broad steering by default.

Our current policies on x86_64 are much less enlightened by default.
If we have < 8 cpus and CONFIG_CPU_HOTPLUG is not defined we let
the hardware pick the cpu.  Otherwise we send the interrupt to the
first cpu in the set.  Which means the first cpu.  Beyond that
everything is left up to the user space irqbalanced.

My patches were about keeping us from artificially merging multiple
irq sources into the same linux irq when we ran short of vectors
so we have a chance to aim and observe all irq sources as individuals.

Now it is possible to do all of this fine policy work that has been
discussed in this thread.  But since I don't see that problem yet I'm
probably not the man for that job.

The truly challenging corollary to my work and this discussion is
handling the up coming network adapters that can start demuxing large
network pipes with a different irq for each cache domain in the
system, but the details of how distinct irq sources you need from the
hardware are left up to the software to decide at run time.

Eric

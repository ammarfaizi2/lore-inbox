Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751540AbWJFQD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbWJFQD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWJFQD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:03:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751539AbWJFQD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:03:27 -0400
Date: Fri, 6 Oct 2006 09:02:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot
 handle IRQ -1"
In-Reply-To: <m11wpl328i.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0610060855220.3952@g5.osdl.org>
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
 <m11wpl328i.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Eric W. Biederman wrote:
> 
> The change the patch introduced was that we are now always
> pointing irqs towards individual cpus, and not accepting an irq
> if it comes into the wrong cpu.  

I think we should just revert that thing. I don't think there is any real 
reason to force irq's to specific cpu's: the vectors haven't been _that_ 
problematic a resource, and being limited to just 200+ possible vectors 
globally really hasn't been a real problem once we started giving out the 
vectors more sanely.

And the new code clearly causes problems, and it seems to limit our use of 
irq's in fairly arbitrary ways. It also would seem to depend on the irq 
routing being both sane and reliable, something I'm not sure we should 
rely on.

Also, I suspect the whole notion of only accepting an irq on one 
particular CPU is fundamentally fragile. The irq delivery tends to be a 
multi-phase process that we can't even _control_ from software (ie the irq 
may be pending inside an APIC or a bridge chip or other system logic, so 
things may be happening _while_ we possibly try to change the cpu 
delivery).

So how about just reverting that change?

		Linus

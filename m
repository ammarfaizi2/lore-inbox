Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWD3XSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWD3XSv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 19:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWD3XSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 19:18:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52408 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751168AbWD3XSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 19:18:50 -0400
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Andi Kleen" <ak@suse.de>,
       <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BA3@USRV-EXCH4.na.uis.unisys.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 30 Apr 2006 17:17:56 -0600
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BA3@USRV-EXCH4.na.uis.unisys.com> (Natalie
 Protasevich's message of "Thu, 27 Apr 2006 15:36:50 -0500")
Message-ID: <m1odyibql7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com> writes:

>> >But I guess using GSI/vector internally only would be fine.
>> 
>> The last time I tried to name a variable "gsi" instead of "irq",
>> Linus launched into a tirade that "GSI" doesn't mean anything to him,
>> or anybody else that googles it.  On the other hand "IRQ" means
>> something
>> to everybody, and if you google it you find all kinds of interesting
>> interrupt-related things.
>> 
>> My point was that "IRQ" means so many "interrupt related" things to
>> different people in different contexts, that it is effectively
>> meaningless.
>> 
>> But Linus was not swayed.
>> 
>
> Oh Len, let's call this thing IRQ why not ;) I kind of agree that this
> is more popular and well-known term, like an old trade mark. I just see
> all those layers of code right now to map those to GSIs, pins, whatever
> it is, that can be replaced with... well, much smaller layers of code :)
> and maybe less "assumpti-ous" too.

The original IRQ (on x86) was simply the enumeration of the input
pins on the pair of i8259 interrupt controllers.

The ACPI global system interrrupts is the enumeration of the input
pins on the ioapics in the system.

Therefore the GSI number is the IRQ number, by definition.

However GSI is not a complete enumeration because it does not list
MSI interrupt sources, and in general can not list MSI interrupt
sources.  Further the term GSI is ACPI specific so it really
doesn't make sense outside of that context while irq does.

So the question is how do we solve the big system problem.

Problem 1.
  We have more GSIs than interrupt vectors on a cpu, so a simple
  1-1 mapping will not work.
  However as Natalie's patch showed many of the GSIs are not even
  connected so if we only allocate vectors to GSIs that are use we should
  not have a problem.

Problem 2.
  Some systems have more than 224 GSIs that are actually connected to devices.
  There are three possible ways to handle this case. 
  - Fail after we run out of vectors.
  - Share a vector.
  - Allow vectors of different cpus to handle different irqs.
    The is the most elegant and scalable, and Natalie's suggestion.

So what would be a path to get there from here?
- Fix the irq set_affinity code so that it makes the changes to
  irqs when the interrupt is actually disabled.
  Calling desc->handler->disable, desc->handler->enable
  does not work immediately so the current code is racy.
  Which shows up very badly if you attempt to change the irq vector,
  and may cause rare problems today

- Modify the MSI code to allocate irqs and not vectors.
  So we don't have two paths through the code, for no good reason.

- Modify do_IRQ to get passed an interrupt vector# from the
  interrupt vector instead of an irq number, and then lookup
  the irq number in vector_irq.  This means we don't need
  a code stub per irq, and allows us to handle more irqs
  by simply increasing NR_IRQS.

- Remove the current irq compression.

- Move irq vector allocation/deallocation into request_irq, and free_irq.

- Make vector_irq per_cpu.

- Modify assign_irq to allocate different vectors on different cpus,
  to fail if we cannot find a free irq vector somewhere in the
  irqs cpu set, and call assign_irq from set_affinity so when we change
  cpus we can allocate a different irq.

I have proof of concept level patches for everything thing except making
MSI actually allocate irqs, but that should be straight forward.

Does anyone know if we record the maximum GSI number? That looks like
my sticking point for being able to write a simple irq allocator.

If I have a couple more free minutes I will see if I can post some
preliminary patches.  This is issue play for me so I have limited time
to work on it.

Eric

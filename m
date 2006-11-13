Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755291AbWKMRN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbWKMRN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbWKMRN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:13:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12675 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1755292AbWKMRN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:13:58 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Komuro <komurojun-mbn@nifty.com>, tglx@linutronix.de,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com
Subject: Re: 2.6.19-rc5: known regressions :SMP kernel can not generate ISA irq
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
	<1162985578.8335.12.camel@localhost.localdomain>
	<Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
	<7813413.118221162987983254.komurojun-mbn@nifty.com>
	<11940937.327381163162570124.komurojun-mbn@nifty.com>
	<Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>
Date: Mon, 13 Nov 2006 10:11:24 -0700
In-Reply-To: <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 13 Nov 2006 08:02:28 -0800 (PST)")
Message-ID: <m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 10 Nov 2006, Komuro wrote:
>> 
>> I tried the 2.6.19-rc5,  the problem still happens.
>
> Ok, that's good data, and especially:
>
>> But,
>> I remove the disable_irq_nosync() , enable_irq()
>> from the linux/drivers/net/pcmcia/axnet_cs.c
>> the interrupt is generated properly.
>
> All RIGHT. That's a very good clue. The major difference between PCI and 
> ISA irq's is that they have different trigger types (they also have 
> different polarity, but that tends to be just a small detail). In 
> particular, ISA IRQ's are edge-triggered, and PCI IRQ's are level- 
> triggered.
>
> Now, edge-triggered interrupts are a _lot_ harder to mask, because the 
> Intel APIC is an unbelievable piece of sh*t, and has the edge-detect logic 
> _before_ the mask logic, so if a edge happens _while_ the device is 
> masked, you'll never ever see the edge ever again (unmasking will not 
> cause a new edge, so you simply lost the interrupt).
>
> So when you "mask" an edge-triggered IRQ, you can't really mask it at all, 
> because if you did that, you'd lose it forever if the IRQ comes in while 
> you masked it. Instead, we're supposed to leave it active, and set a flag, 
> and IF the IRQ comes in, we just remember it, and mask it at that point 
> instead, and then on unmasking, we have to replay it by sending a 
> self-IPI.
>
> Maybe that part got broken by some of the IRQ changes by Eric. 

Hmm.  The other possibility is that this is a genirq migration issue.

Yep.  That looks like it.   In the genirq migration the edge and
level triggered cases got merged and previously disable_edge_ioapic
was a noop.  Ouch.

Darn I missed this one in my review of Ingos changes.

I'm not at all certain what the correct fix here is.
- Do we make the make the generic code aware of this messed up
  case?  I believe it is aware of part of the don't disable edge
  triggered interrupt logic already.
- Do we modify the disable logic so it doesn't actually disable the
  irq?
- Do we do as Linus suggests and make the enable logic pass through a
  level triggered state?
- Do we split the edge and level triggered cases apart on again on
  i386 and x86_64?

And how do we make it drop dead clear what we are doing so that
someone doesn't break this in the future by accident.  That I
suspect was the real problem.  That stupid vector == irq case had
introduced so many levels of abstraction it was nearly impossible
to read the code.

Can we get this abstraction right so that we can make obviously
correct code here and still handle all of the weird code bugs?

> Eric, can you please double-check this all? I suspect you disable 
> edge-triggered interrupts when moving them, or something, and maybe you 
> didn't realize that if you disable them on the IO-APIC level, they can be 
> gone forever.

Sure.  So the hypothesis is that it is somewhere near commit
e7b946e98a456077dd6897f726f3d6197bd7e3b9 causing the problem. 

Anything I have changed in this area should affect both i386 and 
x86_64.

> [ Note: this is true EVEN IF we are in the interrupt handler right then - 
>   if we get another edge while in the interrupt handler, the interrupt 
>   will normally be _delayed_ until we've ACK'ed it, but if we have 
>   _masked_ it, it will simply be lost entirely. So a simple "mask" 
>   operation is always incorrect for edge-triggered interrupts.
>
>   One option might be to do a simple mask, and on unmask, turn the edge 
>   trigger into a level trigger at the same time. Then, the first time you 
>   get the interrupt, you turn it back into an edge trigger _before_ you 
>   call the interrupt handlers. That might actually be simpler than doing 
>   the "irq replay" dance with self-IPI, because we can't actually just 
>   fake the IRQ handling - when enable_irq() is called, irq's are normally 
>   disabled on the CPU, so we can't just call the irq handler at that 
>   point: we really do need to "replay" the dang thing.
>
>   Did I mention that the Intel APIC's are a piece of cr*p already? ]

Ok. After a quick skim it appears that there is a disable/enable pair
in the irq migration path for edge triggered interrupts.  But we
do that work while the irq is pending and it doesn't look like I
changed that part of the code.  Just the level triggered irq
migration.

>> So I think enable_irq does not enable the irq.
>
> It probably does enable it (that's the easy part), but see above: if any 
> of the support structure for the APIC crapola is subtly broken, we'll have 
> lost the IRQ anyway.
>
> (Many other IRQ controllers get this right: the "old and broken" Intel 
> i8259 interrupt controller was a much better IRQ controller than the APIC 
> in this regard, because it simply had the edge-detect logic after the 
> masking logic, so if you unmasked an active interrupt that had been 
> masked, you would always see it as an edge, and the i8259 controller needs 
> none of the subtle code at _all_. It just works.)
>
> Anyway, if you _can_ bisect the exact point where this started happening, 
> that would be good. But I would not be surprised in the least if this is 
> all introduced by Eric Biedermans dynamic IRQ handling.

I will share the credit because I missed this in code review but this
is really Ingo's generic irq code. 

Eric

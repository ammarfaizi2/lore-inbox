Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWEBHkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWEBHkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEBHkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:40:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14283 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932419AbWEBHkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:40:08 -0400
To: Andi Kleen <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       sergio@sergiomb.no-ip.org, "Kimball Murray" <kimball.murray@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com,
       linux-acpi@vger.kernel.org
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
References: <CFF307C98FEABE47A452B27C06B85BB652DDDD@hdsmsx411.amr.corp.intel.com>
	<200605020814.49144.ak@suse.de>
	<m1d5ewap6w.fsf@ebiederm.dsl.xmission.com>
	<200605020911.41592.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 02 May 2006 01:39:23 -0600
In-Reply-To: <200605020911.41592.ak@suse.de> (Andi Kleen's message of "Tue,
 2 May 2006 09:11:41 +0200")
Message-ID: <m1u08898pg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tuesday 02 May 2006 08:57, Eric W. Biederman wrote:
>> Andi Kleen <ak@suse.de> writes:
>> 
>> No.  At best there is a fixed offset.  They can't be
>> identical because the first 32 vectors are reserved,
>> for processor exceptions.  
>> 
>> Beyond that the kernel would not need the vector_irq and irq_vector
>> arrays if they were always identical, or even if they were one to one.
>
>
> Yes I should have said it's a fixed offset. Sorry for the confusion.
> Just no mapping table needed.

As far as I can see no mapping table is needed simply because
we place a stub with the irq number of the irq we want to service
at the idt entry of the vector we want to service.

For the old ISA irqs it is certainly a fixed offset.

>> If you look at assign_irq_vector you will see that by default we
>> allocate every 8th vector.  Looking at the comment in
>> init_IO_APIC_traps() this seems to be because we want to avoid
>> apic bugs with multiple interrupts of the same priority.
>> Although why we skip 8 instead of 16 is beyond me.
>
> Hmm - i guess that's old APIC bugs. Might be worth revisiting
> on 64bit.

Certainly worth a look.  I just know that is what the code currently
does. 

>> Although now that I think about it, using some assembler macros
>> instead of cpp macros could probably solve the problem more easily
>> than generating the stubs at runtime.  I think the worst case is
>> 256 cpus * 32 irqs per cpu 
>
> 32 irqs? It's (255-32) 

If you look at NR_IRQ_VECTORS.  32 is currently our estimate on the number
of IRQs sources per cpu.  I think a sane formula for NR_IRQS once
the static limits are removed is something like:
#define NR_IRQS (NR_VECTORS + (NR_CPUS*32))

Which starts out a little high to account for systems that are over endowed
with I/O and sticks with our current fairly high estimate of 32 IRQs per cpu.

Although that 32 may actually come from our the skip 8 logic.

>> * 10 bytes per stub = 80K. 
>
> My calculations gave >200k which is definitely too much.

With a per cpu lookup table we get 4 bytes per entry and 256 entries
per cpu = 1K per cpu.  Which ultimately uses 256K, on a 256 cpu
system.  Which is nothing for a machine with 256GB or so of RAM.
And that could really be be 2 bytes per entry.

I really don't care how we generate the stubs, or if we generate
stubs so long as all I need to do is change NR_IRQS recompile and
it works.

Eric

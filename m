Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWEBG6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWEBG6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWEBG6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:58:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41930 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932416AbWEBG6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:58:44 -0400
To: Andi Kleen <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       sergio@sergiomb.no-ip.org, "Kimball Murray" <kimball.murray@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com,
       linux-acpi@vger.kernel.org
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
References: <CFF307C98FEABE47A452B27C06B85BB652DDDD@hdsmsx411.amr.corp.intel.com>
	<200605020814.49144.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 02 May 2006 00:57:59 -0600
In-Reply-To: <200605020814.49144.ak@suse.de> (Andi Kleen's message of "Tue,
 2 May 2006 08:14:48 +0200")
Message-ID: <m1d5ewap6w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> >- Modify do_IRQ to get passed an interrupt vector# from the
>> >  interrupt vector instead of an irq number, and then lookup
>> >  the irq number in vector_irq.  This means we don't need
>> >  a code stub per irq, and allows us to handle more irqs
>> >  by simply increasing NR_IRQS.
>> 
>> isn't the vector number already on the stack from
>> ENTRY(interrupt)
>> 	pushl $vector-256
>
> Yes - and interrupts/vectors are currently always identical. 

No.  At best there is a fixed offset.  They can't be
identical because the first 32 vectors are reserved,
for processor exceptions.  

Beyond that the kernel would not need the vector_irq and irq_vector
arrays if they were always identical, or even if they were one to one.

If you look at assign_irq_vector you will see that by default we
allocate every 8th vector.  Looking at the comment in
init_IO_APIC_traps() this seems to be because we want to avoid
apic bugs with multiple interrupts of the same priority.
Although why we skip 8 instead of 16 is beyond me.

> If we go
> to per CPU IDTs I suspect the stubs will just need to be generated
> at runtime and start passing interrupts.

If we can generate the stubs at run time that will remove my
biggest problem with them, that we can't easily make the number
of stubs track NR_IRQS.  Not needing an extra table lookup is
certainly desirable, and probably worth the extra 4-8 bytes that a stub
is larger that a per cpu table entry.

Although now that I think about it, using some assembler macros
instead of cpp macros could probably solve the problem more easily
than generating the stubs at runtime.  I think the worst case is
256 cpus * 32 irqs per cpu * 10 bytes per stub = 80K.

At 8 cpus we are about where we are now.

Eric

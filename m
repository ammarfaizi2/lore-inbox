Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWEBHL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWEBHL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWEBHL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:11:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:49605 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932426AbWEBHLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:11:55 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Tue, 2 May 2006 09:11:41 +0200
User-Agent: KMail/1.9.1
Cc: "Brown, Len" <len.brown@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       sergio@sergiomb.no-ip.org, "Kimball Murray" <kimball.murray@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com,
       linux-acpi@vger.kernel.org
References: <CFF307C98FEABE47A452B27C06B85BB652DDDD@hdsmsx411.amr.corp.intel.com> <200605020814.49144.ak@suse.de> <m1d5ewap6w.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1d5ewap6w.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605020911.41592.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 08:57, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> >> >- Modify do_IRQ to get passed an interrupt vector# from the
> >> >  interrupt vector instead of an irq number, and then lookup
> >> >  the irq number in vector_irq.  This means we don't need
> >> >  a code stub per irq, and allows us to handle more irqs
> >> >  by simply increasing NR_IRQS.
> >> 
> >> isn't the vector number already on the stack from
> >> ENTRY(interrupt)
> >> 	pushl $vector-256
> >
> > Yes - and interrupts/vectors are currently always identical. 
> 
> No.  At best there is a fixed offset.  They can't be
> identical because the first 32 vectors are reserved,
> for processor exceptions.  
> 
> Beyond that the kernel would not need the vector_irq and irq_vector
> arrays if they were always identical, or even if they were one to one.


Yes I should have said it's a fixed offset. Sorry for the confusion.
Just no mapping table needed.

> 
> If you look at assign_irq_vector you will see that by default we
> allocate every 8th vector.  Looking at the comment in
> init_IO_APIC_traps() this seems to be because we want to avoid
> apic bugs with multiple interrupts of the same priority.
> Although why we skip 8 instead of 16 is beyond me.

Hmm - i guess that's old APIC bugs. Might be worth revisiting
on 64bit.


> 
> Although now that I think about it, using some assembler macros
> instead of cpp macros could probably solve the problem more easily
> than generating the stubs at runtime.  I think the worst case is
> 256 cpus * 32 irqs per cpu 

32 irqs? It's (255-32) 

> * 10 bytes per stub = 80K. 

My calculations gave >200k which is definitely too much.

-Andi


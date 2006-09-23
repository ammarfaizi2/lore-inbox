Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWIWEb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWIWEb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 00:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWIWEb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 00:31:27 -0400
Received: from ozlabs.org ([203.10.76.45]:43659 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750811AbWIWEb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 00:31:26 -0400
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
In-Reply-To: <4514663E.5050707@goop.org>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
	 <4514663E.5050707@goop.org>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 14:31:22 +1000
Message-Id: <1158985882.26261.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 15:39 -0700, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > +
> > +	/* Set up GDT entry for 16bit stack */
> > +	stk16_off = (u32)&per_cpu(cpu_16bit_stack, cpu);
> > +	gdt = per_cpu(cpu_gdt_table, cpu);
> > +	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
> > +		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
> > +		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
> > +		(CPU_16BIT_STACK_SIZE - 1);
> >   
> 
> This should use pack_descriptor().  I'd never got around to changing it, 
> but it really should.

Yep, agreed.

> > +	/* Complete percpu area setup early, before calling printk(),
> > +	   since it may end up using it indirectly. */
> > +	setup_percpu_for_this_cpu(cpu);
> > +
> >   
> 
> I managed to get all this done in head.S before going into C code; is 
> that not still possible?  Or is there a later patch to do this.

It's possible; it would simplify the C code a little, but I'll have to
see what the asm looks like.

> > +static __cpuinit void setup_percpu_descriptor(struct desc_struct *gdt,
> > +					      unsigned long per_cpu_off)
> > +{
> > +	unsigned limit, flags;
> > +
> > +	limit = (1 << 20);
> > +	flags = 0x8;		/* 4k granularity */
> >   
> 
> Why not set the limit to the percpu section size?  It would avoid having 
> it clipped under Xen.

Sure... there was a couple of other things Xen needs, too, so I thought
I'd do a separate patch (whole page for GDT and the xen page, which
means generic per-cpu setup should use boot_alloc_pages()).

> > +/* Be careful not to use %gs references until this is setup: needs to
> > + * be done on this CPU. */
> > +void __init setup_percpu_for_this_cpu(unsigned int cpu)
> > +{
> > +	struct desc_struct *gdt = per_cpu(cpu_gdt_table, cpu);
> > +	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
> > +
> > +	per_cpu(this_cpu_off, cpu) = __per_cpu_offset[cpu];
> > +	setup_percpu_descriptor(&gdt[GDT_ENTRY_PERCPU],	__per_cpu_offset[cpu]);
> > +	cpu_gdt_descr->address = (unsigned long)gdt;
> > +	cpu_gdt_descr->size = GDT_SIZE - 1;
> > +	load_gdt(cpu_gdt_descr);
> > +	set_kernel_gs();
> > +}
> >   
> 
> Everything except the load_gdt and set_kernel_gs could be done in advance.

Yes.   Which particularly makes sense if this is done in asm, as you
suggested above.

> > +#define percpu_to_op(op,var,val)				\
> > +	do {							\
> > +		typedef typeof(var) T__;			\
> > +		if (0) { T__ tmp__; tmp__ = (val); }		\
> > +		switch (sizeof(var)) {				\
> > +		case 1:						\
> > +			asm(op "b %1,"__percpu_seg"%0"		\
> >   
> 
> So are symbols referencing the .data.percpu section 0-based?  Wouldn't 
> you need to subtract __per_cpu_start from the symbols to get a 0-based 
> segment offset?

I don't think I understand the question.

The .data.percpu section is the "template" per-cpu section, freed along
with other initdata: after setup_percpu_areas() is called, it is not
supposed to be used.  Around that time, the gs segment is set up based
at __per_cpu_offset[cpu], so "%gs:<varname>" accesses the local version.

> Or is the only percpu benefit you're getting from %gs is a slightly 
> quicker way of getting the percpu_offset?  Does that help much?

In generic code, that's true (the arch-specific accessors can do it in 1
insn, not two).  But it's still a help.  This is __raw_get_cpu_var(x)
before:

   3:   89 e0                   mov    %esp,%eax
   5:   25 00 e0 ff ff          and    $0xffffe000,%eax
   a:   8b 40 08                mov    0x8(%eax),%eax
   d:   8b 04 85 00 00 00 00    mov    0x0(,%eax,4),%eax
                        10: R_386_32    __per_cpu_offset
  14:   8b 80 00 00 00 00       mov    0x0(%eax),%eax
                        16: R_386_32    per_cpu__x

And this is after:

  1f:   65 a1 00 00 00 00       mov    %gs:0x0,%eax
                        21: R_386_32    per_cpu__this_cpu_off
  25:   8b 80 00 00 00 00       mov    0x0(%eax),%eax
                        27: R_386_32    per_cpu__x

So we go from 5 instructions, 23 bytes, 3 memory references, to 2
instructions, 12 bytes, 2 memory references (although the extra mem ref
will almost certainly have been in cache).

> > +#define x86_read_percpu(var) percpu_from_op("mov", per_cpu__##var)
> > +#define x86_write_percpu(var,val) percpu_to_op("mov", per_cpu__##var, val)
> > +#define x86_add_percpu(var,val) percpu_to_op("add", per_cpu__##var, val)
> > +#define x86_sub_percpu(var,val) percpu_to_op("sub", per_cpu__##var, val)
> > +#define x86_or_percpu(var,val) percpu_to_op("or", per_cpu__##var, val)  
> 
> Why x86_?  If some other arch implemented a similar mechanism, wouldn't 
> they want to use the same macro names?

Possibly, but for the moment they are very arch specific: we really
don't want them in generic code.  It *might* be worth creating a generic
"read_per_cpu()" which returns a rvalue, but IMHO adding a new thread
model which is all-positive-offset is probably a better long-term plan.

Cheers,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law


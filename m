Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758706AbWK2BlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706AbWK2BlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758724AbWK2BlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:41:11 -0500
Received: from junsun.net ([66.29.16.26]:46858 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1758707AbWK2BlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:41:10 -0500
Date: Tue, 28 Nov 2006 17:40:56 -0800
From: Jun Sun <jsun@junsun.net>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: failed 'ljmp' in linear addressing mode
Message-ID: <20061129014056.GA31798@srv.junsun.net>
References: <20061122234111.GA8499@srv.junsun.net> <Pine.LNX.4.61.0611270843500.4092@chaos.analogic.com> <20061127231646.GA21627@srv.junsun.net> <Pine.LNX.4.61.0611280806280.7116@chaos.analogic.com> <20061128194530.GB28891@srv.junsun.net> <Pine.LNX.4.61.0611281815520.8163@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0611281815520.8163@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 06:49:17PM -0500, linux-os (Dick Johnson) wrote:
> 
> On Tue, 28 Nov 2006, Jun Sun wrote:
> 
> > On Tue, Nov 28, 2006 at 08:46:44AM -0500, linux-os (Dick Johnson) wrote:
> >>
> >> On Mon, 27 Nov 2006, Jun Sun wrote:
> >>
> >>>
> >>> On Mon, Nov 27, 2006 at 08:58:57AM -0500, linux-os (Dick Johnson) wrote:
> >>>>
> >>>> I think it probably resets the instant that you turn off paging. To
> >>>> turn off paging, you need to copy some code (properly linked) to an
> >>>> area where there is a 1:1 mapping between virtual and physical addresses.
> >>>> A safe place is somewhere below 1 megabyte. Then you need to set up a
> >>>> call descriptor so you can call that code (you can ljump if you never
> >>>> plan to get back). You then need to clear interrupts on all CPUs (use a
> >>>> spin-lock). Once you are executing from the new area, you reset your
> >>>> segments to the new area. The call descriptor would have already set
> >>>> CS, as would have the long-jump. At this time you can turn off paging
> >>>> and flush the TLB. You are now in linear-address protected mode.
> >>>>
> >>>
> >>> Thanks for the reply.  But I am pretty much sure I did above correctly.
> >>> I use single-instruction infinite loop in the call path to verify
> >>> that control does reach last 'ljmp' but not the jump destination.
> >>>
> >>> Below is the hack I made to machine_kexec.c file.  As you can see, I
> >>> managed to make the identical mapping between virtual and physical addresses.
> >>>
> >>> Note I did not copy the code into the first 1M.  In fact the code
> >>> is located at 0xc0477000 (0x00477000 in physical).  I thought that should be
> >>> OK as I did not really go all the way back to real-address mode.
> >>>
> >>> That last suspect I have now is the wrong value in CS descriptor.  Does kernel
> >>> have a suitable CS descriptor for the last ljmep to 0x10000000 in linear
> >>> addressing mode?  The CS descriptor seems to be a pretty dark magic to me ...
> >>>
> >>> Cheers.
> >>>
> >>> Jun
> >>>
> >>> -----------------
> >>> diff -Nru linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c.orig linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c
> >>> --- linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c.orig   2006-10-13 11:55:04.000000000 -0700
> >>> +++ linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c        2006-11-22 15:01:45.000000000 -0800
> >>> @@ -212,3 +212,19 @@
> >>>        rnk = (relocate_new_kernel_t) reboot_code_buffer;
> >>>        (*rnk)(page_list, reboot_code_buffer, image->start, cpu_has_pae);
> >>> }
> >>> +
> >>> +extern void do_os_switching(void);
> >>> +void os_switch(void)
> >>> +{
> >>> +       void (*foo)(void);
> >>> +
> >>> +       /* absolutely no irq */
> >>> +       local_irq_disable();
> >>> +
> >>> +       /* create identity mapping */
> >>> +       foo=virt_to_phys(do_os_switching);
> >>> +       identity_map_page((unsigned long)foo);
> >>> +
> >>> +       /* jump to the real address */
> >>> +       foo();
> >>> +}
> >>>
> >> Get a copy of the Intel 486 Microprocessor Reference Manual or read it on-
> >> line. There is no way that you can make a call like that.
> >
> > By "a call like that", you mean "foo()"?  Are you sure about that?
> >
> > The machine_kexec() function in the same file is basically doing the
> > same way (i.e., use "call *$eax" instead of "ljmp").  That is where I got
> > my idea from.
> >
> > In addition, if I put "1: jmp 1b" instruction anywhere *inside*
> > do_os_switching() I would get infinite hanging instead of reboot,
> > which seems to suggest I *did* jump into do_os_switching() successfully.
> >
> > According to Intel Architecture Software Developer's Manual (1997), Vol 3,
> > page 8-14:
> >
> > "2.  If paging is enabled perform the following operations:
> >
> >  - Transfer program control to linear addresses that are identity mapped to
> >    physical addresses (that is, linear addresses equal physical addresses)
> >  ...
> > "
> >
> > it does not indicate one has to use "ljmp" to do this control transfer.
> 
> Assume you are accessing memory at 0xc000-0000. This address, when
> page translation is occurring (page 5-17), consists of three parts.
> 
> (1) A 12-bit offset 0:11
> (2) A 10-bit index  11:21
> (3) A 10-bit index  21:31
> 
> So 0xc00 is an index into the page directory. If you wish to turn off
> translation, you can't just turn off those bits. The next instruction
> will be fetched from memory with the page-cache upper bits reset, i.e,
> using offset 0 of the page directory. You somehow need to turn off those
> bits at the same time the next instruction is fetched. Normally you
> use a call gate. However, you can do a long jump which reloads the
> segment register. When the instruction book says "transfer control"
> it doesn't mean just jump to some offset. When the instruction address is
> 0xC000-0000, it is not the same as 0x0000-0000.  These two addresses are 
> different (to the CPU) until after those page translation bits are reset, not 
> before.

Hmm, if I understand it correctly, identity_map_page() will take 
a physical address (aligned along page boundary) and map it into
the same virtual address.  So in my case the page starting at 0x00477000
in phys space will be mapped at the virtual address 0x00477000.  Is this
understanding correct?

Assuming this understanding is correct, I don't anything wrong with
"call *%eax" where %eax=0x00477000 when paging is still enabled.

If this understanding is wrong, are you suggesting there is a bug
in machine_kexec()?  Here is the gist of machine_kexec() code:

NORET_TYPE void machine_kexec(struct kimage *image)
{
	...
        reboot_code_buffer = page_to_pfn(image->control_code_page)
                                                                << PAGE_SHIFT;
	...
        identity_map_page(reboot_code_buffer);
        memcpy((void *)reboot_code_buffer, relocate_new_kernel,
                                                relocate_new_kernel_size);
	...
        rnk = (relocate_new_kernel_t) reboot_code_buffer;
        (*rnk)(page_list, reboot_code_buffer, image->start, cpu_has_pae);
}

The last statment generates the same "call *%eax" as in my code.

> >
> >> You would need to
> >> call through a task-gate or otherwise set the code-segment and the instruction
> >> pointer at the same instant. First, look at the startup code for a GDT entry
> >> that maps the linear address-space you are using, PLUS allows execution. If
> >> there isn't such an entry, modify an existing one to allow execution. Remember
> >> that CS value, 'segment' in this example. It is probably 0x08, but I don't have
> >> the kernel source on this machine. Do a far jump through something
> >> created as:
> >>  		.byte	0xea			; Jmp instruction
> >>  		.short	$segment		; Your segment selector
> >>  		.word	$where & ~0xc0000000	; Your physical offset
> >>  	where:	invd				; Invalidate cache
> >>  		movl	$segment, %eax		; Get your segment
> >>  		movl	%eax, %ds		; Set a couple segments
> >>  		movl	%eax, %es
> >>
> >> This must be IN your code path! Now, you are executing at the same
> >> 1:1 physical:virtual address. You can remove paging as:
> >>
> >>  		movl	%cr0,	%eax		; Get value
> >>  		andl	~$0x80000000, %eax	; Turn off high bit
> >>  		movl	%eax, %cr0		; Write back
> >>
> >> You are still in protected mode, you now have paging disabled.
> >>
> >
> > I tried this also.  There is no difference in behavior, i.e., it would
> > hang with "1: jmp 1b" inside and it would reboot without that debugging
> > line.
> >
> 
> I think you didn't bother to try it.

I did.  Here is the new code of trying your idea:

extern void do_os_switching(void);
void os_switch(void)
{
        void (*foo)(void);

        /* absolutely no irq */
        local_irq_disable();

        /* create identity mapping */
        foo=virt_to_phys(do_os_switching);
        identity_map_page((unsigned long)foo);

        /* jump to the real address */
        /*
        load_segments();
        set_gdt(phys_to_virt(0),0);
        set_idt(phys_to_virt(0),0);
        foo();
        */
#define __STR(X) #X
#define STR(X) __STR(X)
        __asm__ __volatile__ (
                "\tljmp $"STR(__KERNEL_CS)",$0x00477000\n");
#undef STR
#undef __STR
}

Again, like I said, using this or not does not seem to make a difference
from doing "call *%eax".

> 
> > As you can see, I am pretty convinced that the last instruction,
> > "ljmp $(__KERNEL_CS), $0x10000000", is where the problem is.  (BTW,
> > I also have "1: jmp 1b" instruction at 0x10000000).
> >
> 
> Well now you are even trying to jump to something at 0x1000-0000 and
> that will certainly kill the machine.
>

Can you elaborate more why this last ljmp will fail?  I thought at this point
the paging is turned off, and 0x1000-0000 would simply mean a physical
address - which is a valid physical address in RAM, btw.

Here is the re-post of whole function that contains the ljmp:

ENTRY(do_os_switching)
	/* turn off paging and etc */
        movl    %cr0, %eax
        andl    $~((1<<31)|(1<<18)|(1<<16)|(1<<3)|(1<<2)), %eax
        orl     $(1<<0), %eax
        movl    %eax, %cr0

        /* clear cr4 */
        movl    $0, %eax
        movl    %eax, %cr4

        /* clear cr3, flush TLB */
        movl    $0, %eax
        movl    %eax, %cr3

        ljmp    $(__KERNEL_CS), $0x10000000

Thanks again.  And cheers.

Jun 

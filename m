Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933758AbWK1Nqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933758AbWK1Nqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 08:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758681AbWK1Nqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 08:46:52 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:43789 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1758679AbWK1Nqv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 08:46:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 28 Nov 2006 13:46:48.0936 (UTC) FILETIME=[A6DF6680:01C712F3]
Content-class: urn:content-classes:message
Subject: Re: failed 'ljmp' in linear addressing mode
Date: Tue, 28 Nov 2006 08:46:44 -0500
Message-ID: <Pine.LNX.4.61.0611280806280.7116@chaos.analogic.com>
In-Reply-To: <20061127231646.GA21627@srv.junsun.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: failed 'ljmp' in linear addressing mode
thread-index: AccS86bpiG8RCkJ/TpSW/rynGsR5qA==
References: <20061122234111.GA8499@srv.junsun.net> <Pine.LNX.4.61.0611270843500.4092@chaos.analogic.com> <20061127231646.GA21627@srv.junsun.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jun Sun" <jsun@junsun.net>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Nov 2006, Jun Sun wrote:

>
> On Mon, Nov 27, 2006 at 08:58:57AM -0500, linux-os (Dick Johnson) wrote:
>>
>> I think it probably resets the instant that you turn off paging. To
>> turn off paging, you need to copy some code (properly linked) to an
>> area where there is a 1:1 mapping between virtual and physical addresses.
>> A safe place is somewhere below 1 megabyte. Then you need to set up a
>> call descriptor so you can call that code (you can ljump if you never
>> plan to get back). You then need to clear interrupts on all CPUs (use a
>> spin-lock). Once you are executing from the new area, you reset your
>> segments to the new area. The call descriptor would have already set
>> CS, as would have the long-jump. At this time you can turn off paging
>> and flush the TLB. You are now in linear-address protected mode.
>>
>
> Thanks for the reply.  But I am pretty much sure I did above correctly.
> I use single-instruction infinite loop in the call path to verify
> that control does reach last 'ljmp' but not the jump destination.
>
> Below is the hack I made to machine_kexec.c file.  As you can see, I
> managed to make the identical mapping between virtual and physical addresses.
>
> Note I did not copy the code into the first 1M.  In fact the code
> is located at 0xc0477000 (0x00477000 in physical).  I thought that should be
> OK as I did not really go all the way back to real-address mode.
>
> That last suspect I have now is the wrong value in CS descriptor.  Does kernel
> have a suitable CS descriptor for the last ljmep to 0x10000000 in linear
> addressing mode?  The CS descriptor seems to be a pretty dark magic to me ...
>
> Cheers.
>
> Jun
>
> -----------------
> diff -Nru linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c.orig linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c
> --- linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c.orig   2006-10-13 11:55:04.000000000 -0700
> +++ linux-2.6.17.14-1st/arch/i386/kernel/machine_kexec.c        2006-11-22 15:01:45.000000000 -0800
> @@ -212,3 +212,19 @@
>        rnk = (relocate_new_kernel_t) reboot_code_buffer;
>        (*rnk)(page_list, reboot_code_buffer, image->start, cpu_has_pae);
> }
> +
> +extern void do_os_switching(void);
> +void os_switch(void)
> +{
> +       void (*foo)(void);
> +
> +       /* absolutely no irq */
> +       local_irq_disable();
> +
> +       /* create identity mapping */
> +       foo=virt_to_phys(do_os_switching);
> +       identity_map_page((unsigned long)foo);
> +
> +       /* jump to the real address */
> +       foo();
> +}
>
Get a copy of the Intel 486 Microprocessor Reference Manual or read it on-
line. There is no way that you can make a call like that. You would need to
call through a task-gate or otherwise set the code-segment and the instruction 
pointer at the same instant. First, look at the startup code for a GDT entry 
that maps the linear address-space you are using, PLUS allows execution. If 
there isn't such an entry, modify an existing one to allow execution. Remember 
that CS value, 'segment' in this example. It is probably 0x08, but I don't have 
the kernel source on this machine. Do a far jump through something 
created as:
 		.byte	0xea			; Jmp instruction
 		.short	$segment		; Your segment selector
 		.word	$where & ~0xc0000000	; Your physical offset
 	where:	invd				; Invalidate cache
 		movl	$segment, %eax		; Get your segment
 		movl	%eax, %ds		; Set a couple segments
 		movl	%eax, %es

This must be IN your code path! Now, you are executing at the same
1:1 physical:virtual address. You can remove paging as:

 		movl	%cr0,	%eax		; Get value
 		andl	~$0x80000000, %eax	; Turn off high bit
 		movl	%eax, %cr0		; Write back

You are still in protected mode, you now have paging disabled.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

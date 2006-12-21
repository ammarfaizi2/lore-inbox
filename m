Return-Path: <linux-kernel-owner+w=401wt.eu-S1161091AbWLUM4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWLUM4K (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 07:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWLUM4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 07:56:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:39996 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161091AbWLUM4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 07:56:08 -0500
Date: Thu, 21 Dec 2006 07:56:01 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-ID: <20061221022601.GB30299@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061220141808.e4b8c0ea.khali@linux-fr.org> <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221102232.5a10bece.khali@linux-fr.org> <m164c5pmim.fsf@ebiederm.dsl.xmission.com> <20061221010814.GA30299@in.ibm.com> <m1vek5o2dj.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vek5o2dj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 05:32:56AM -0700, Eric W. Biederman wrote:
> 
> Take a look at the diff for commit 968de4f02621db35b8ae5239c8cfc6664fb872d8
> of setup.S there are very few candidate instructions.
> 
> I suspect with a few minutes of review we should be able to see what the
> assembler is doing wrong and decide if we want to blacklist that assembler
> or work around it's bug.
> 
> diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
> index 3aec453..9aa8b05 100644
> --- a/arch/i386/boot/setup.S
> +++ b/arch/i386/boot/setup.S
> @@ -588,11 +588,6 @@ rmodeswtch_normal:
>         call    default_switch
> 
>  rmodeswtch_end:
> -# we get the code32 start address and modify the below 'jmpi'
> -# (loader may have changed it)
> -       movl    %cs:code32_start, %eax
> -       movl    %eax, %cs:code32
> -
>  # Now we move the system to its rightful place ... but we check if we have a
>  # big-kernel. In that case we *must* not move it ...
>         testb   $LOADED_HIGH, %cs:loadflags
> @@ -788,11 +783,12 @@ a20_err_msg:
>  a20_done:
> 
>  #endif /* CONFIG_X86_VOYAGER */
> -# set up gdt and idt
> +# set up gdt and idt and 32bit start address
>         lidt    idt_48                          # load idt with 0,0
>         xorl    %eax, %eax                      # Compute gdt_base
>         movw    %ds, %ax                        # (Convert %ds:gdt to a linear ptr)
>         shll    $4, %eax
> +       addl    %eax, code32
>         addl    $gdt, %eax
>         movl    %eax, (gdt_48+2)
>         lgdt    gdt_48                          # load gdt with whatever is
> @@ -851,9 +847,26 @@ flush_instr:
>  #      Manual, Mixing 16-bit and 32-bit code, page 16-6)
> 
>         .byte 0x66, 0xea                        # prefix + jmpi-opcode
> -code32:        .long   0x1000                          # will be set to 0x100000
> -                                               # for big kernels
> +code32:        .long   startup_32                      # will be set to %cs+startup_32
>         .word   __BOOT_CS
> +.code32
> +startup_32:
> +       movl $(__BOOT_DS), %eax
> +       movl %eax, %ds
> +       movl %eax, %es
> +       movl %eax, %fs
> +       movl %eax, %gs
> +       movl %eax, %ss
> +
> +       xorl %eax, %eax
> +1:     incl %eax                               # check that A20 really IS enabled
> +       movl %eax, 0x00000000                   # loop forever if it isn't
> +       cmpl %eax, 0x00100000
> +       je 1b
> +
> +       # Jump to the 32bit entry point
> +       jmpl *(code32_start - start + (DELTA_INITSEG << 4))(%esi)

Hi Eric,

I got a basic query. Why have we introduced this additional jump to 
startup_32 in the same file? Won't it work if we stick to old method of
enabling protected mode and then directly taking a jmp to startup_32 in
arch/i386/kernel/head.S. Am I missing something obivious? 

Thanks
Vivek

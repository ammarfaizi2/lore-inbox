Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282769AbRLKTlB>; Tue, 11 Dec 2001 14:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282655AbRLKTkw>; Tue, 11 Dec 2001 14:40:52 -0500
Received: from quark.didntduck.org ([216.43.55.190]:37380 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S282792AbRLKTki>; Tue, 11 Dec 2001 14:40:38 -0500
Message-ID: <3C16612E.CEE55592@didntduck.org>
Date: Tue, 11 Dec 2001 14:40:30 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: stas.orel@mailcity.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.2.20, 100% reproduceable and fully tracked
In-Reply-To: <01121121200600.00906@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev wrote:
> 
> Hello.
> 
> When I am trying to start one weird program under dosemu, I always get an Oops.
> I have tracked this Oops down to a line of a source code in the kernel, see
> below.
> 
> At first, the Oops itself:
> ---
> ksymoops 2.4.3 on i686 2.2.20.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.2.20/ (default)
>      -m /boot/System.map (specified)
> 
> Dec  2 21:04:05 localhost kernel: Unable to handle kernel paging request at virtual address 000078c3
> Dec  2 21:04:05 localhost kernel: current->tss.cr3 = 0ad2f000, %cr3 = 0ad2f000
> Dec  2 21:04:05 localhost kernel: *pde = 0b802067
> Dec  2 21:04:05 localhost kernel: Oops: 0003
> Dec  2 21:04:05 localhost kernel: CPU:    0
> Dec  2 21:04:05 localhost kernel: EIP:    0010:[handle_vm86_fault+1149/2212]
> Dec  2 21:04:05 localhost kernel: EFLAGS: 00010206
> Dec  2 21:04:05 localhost kernel: eax: 00000009   ebx: 00003013   ecx: 00000020   edx: 00000021
> Dec  2 21:04:05 localhost kernel: esi: 000000f3   edi: 000077d0   ebp: 000c39e0   esp: cad31ea8
> Dec  2 21:04:05 localhost kernel: ds: 0018   es: 0018   ss: 0018
> Dec  2 21:04:05 localhost kernel: Process xdos (pid: 872, process nr: 57, stackpage=cad31000)
> Dec  2 21:04:05 localhost kernel: Stack: 000077d0 000000f4 00003013 000c39e0 00002827 cad31f00 00000000 c010a8cc
> Dec  2 21:04:05 localhost kernel:        00009fff 00000000 00000000 cad30000 cad30000 00002827 c010a90f cad31f00
> Dec  2 21:04:05 localhost kernel:        00000000 cad30000 00000000 c010a05d cad31f00 00000000 00000001 00000005
> Dec  2 21:04:05 localhost kernel: Call Trace: [do_general_protection+0/116] [do_general_protection+67/116] [error_code+53/64] [system_call+52/56]
> Dec  2 21:04:06 localhost kernel: Code: 88 7c 37 00 66 4e 88 5c 37 00 68 9d eb 1b c0 e8 3f 8b 00 00
> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   88 7c 37 00               mov    %bh,0x0(%edi,%esi,1)
> Code;  00000004 Before first symbol
>    4:   66 4e                     dec    %si
> Code;  00000006 Before first symbol
>    6:   88 5c 37 00               mov    %bl,0x0(%edi,%esi,1)
> Code;  0000000a Before first symbol
>    a:   68 9d eb 1b c0            push   $0xc01beb9d
> Code;  0000000e Before first symbol
>    f:   e8 3f 8b 00 00            call   8b53 <_EIP+0x8b53> 00008b52 Before first symbol
> ---
> 
> The faulting code is here:
> arch/i386/kernel/vm86.c:341:
> ---
> #define pushw(base, ptr, val) \
> __asm__ __volatile__( \
>         "decw %w0\n\t" \
>         "movb %h2,0(%1,%0)\n\t" \  <-- fault is HERE!
>         "decw %w0\n\t" \
>         "movb %b2,0(%1,%0)" \
>         : "=r" (ptr) \
>         : "r" (base), "q" (val), "0" (ptr))
> ---
> 
> It is executed here, when it GPFs:
> vm86.c:509:
> ---
>         case 0x9c:
>                 SP(regs) -= 2;
>                 IP(regs)++;
>                 pushw(ssp, sp, get_vflags(regs)); <--handle_vm86_fault+1149/2212
>                 VM86_FAULT_RETURN;
> ---
> 
> The registers:
> ebx contains 0x3013. This is the value returned by get_vflags(regs).
> edi=0x77d0 and esi=0xf3 contains dosemu's ss and sp.
> So virtual flags are going to be moved to ss:sp to simulate pushf.
> This all seems OK to me and I don't understand why the code
> mov    %bh,0x0(%edi,%esi,1)
> can raise GPF with such values in regs.
> 
> So, I have collected all the info I ever could from this Oops, but I still
> don't see a bug. I hope someone can help me.
> Any ideas such as how this code (atleast theoretically) can raise GPF?
> Any suggestions such as how can I collect more info on this subject?
> 
> I am pretty shure I can reproduce this Oops at any kernel, atleast at any 2.2.x,
> but currently I am using 2.2.20.

Your virtual stack pointer went into a page that's not mapped.  The bug
is that we're touching user space without a fault handler, causing an
oops instead of a seg fault.  I'll look into cleaning that mess up to
use proper get/put_user macros.

--

				Brian Gerst

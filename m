Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWGWQfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWGWQfH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 12:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWGWQfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 12:35:07 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:37645 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750799AbWGWQfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 12:35:06 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Debugging APM - cat /proc/apm produces oops
Date: Sun, 23 Jul 2006 18:35:01 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607231630.53968.linux@rainbow-software.org> <20060724010658.687e78be.sfr@canb.auug.org.au>
In-Reply-To: <20060724010658.687e78be.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607231835.01953.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 July 2006 17:06, you wrote:
> On Sun, 23 Jul 2006 16:30:53 +0200 Ondrej Zary <linux@rainbow-software.org> 
wrote:
> > cat /proc/apm produces oops on my DTK notebook. Using "apm=broken-psr"
> > kernel parameter fixes that but I lose the battery info. I'd like to have
> > the battery info (and it works fine in Windows) so I want to debug it and
> > (hopefully) fix.
>
> Is there some reason you can't (or don't want to) use ACPI on this machine?

The machine is old (1997) and even the latest BIOS (1999) does not support 
ACPI (although the i430TX chipset itself is ACPI-compatible).

>
> > The oops:
> > # cat /proc/apm
> > <1>BUG: unable to handle kernel paging request at virtual address
> > 00005e88
>
>                                                                        
> ^^^^ Looks like it tried to access through the stack pointer while
> executeing 16 bit code.

Thanks for explanation.

>
> >  printing eip:
> > 00002f9d
> > *pre = 00000000
> > Oops: 0002 [#4]
> > Modules linked in:
> > CPU:    0
> > EIP:    00c0:[<00002f9d>]    Not tainted VLI
>
>           ^^^^
> This is the APM BIOS 16 bit code segment.
>
> > EFLAGS: 00010017   (2.6.17-5-dtk #23)
> > EIP is at 0x2f94
> > eax: 00000033   ebx: 00000001   ecx: 00000000   edx: 00000000
> > esi: c10a1000   edi: 00000014   ebp: c4755e8a   esp: c4755e88
>
>                                                            ^^^^
> Accessing the stack while executing 16 bit code is never going to work.
>
> > ds: 00c8   es: 0000   ss: 0068
> > Process cat (pid: 1928, threadinfo=c4754000 task=c11240b0)
> > Stack: 5e948001 5fc75e55 00005e94 000000c8 10000033 5ea800c0 00000001
> > 530a0000 00000016 00b86017 00000000 0000530a c010830f 00000060 0000530a
> > 00000033 0000007b 0000007b c0337368 00000000 c10a1000 00000000 00000000
> > 00000282 Call Trace:
> >  <c010830f> apm_bios_call+0x68/0xba  <c0108728>
> > apm_get_power_status+0x44/0x90 <c01091a0> apm_get_info+0x34/0xdc 
> > <c01617dc> proc_file_read+0xda/0x22d <c013b5a2> vfs_read+0x82/0x10e 
> > <c013b873> sys_read+0x3c/0x62
> >  <c0102397> syscall_call+0x7/0xb
> > Code:  Bad EIP value.
> > EIP: [<00002f9d>] 0x2f9d SS:ESP 0068:c4755e88
> >
> > So it looks like it dies somewhere in the APM BIOS code. But how to find
> > exactly where and/or why? Maybe use GDB somehow (I've used it only for
> > really simple debugging yet).
> > I've tried calling the APM 0x530A function from DOS (real mode, int 15h)
> > and single-stepping the BIOS APM code (using good old user-friendly Turbo
> > Debugger). Noticed some OUTs to 0xB1 (or something like that), then some
> > PCI accesses (0xCF8 and 0xCFC) and then IP ended in area of all zeros.
> > When I step over the int 15h call, it works fine - returns correct info.
>
> APM BIOS's are often only tested in real mode as that will suffice for
> older Windows systems.  If you machine is less than 6 years old, Windows
> is almost certainly using ACPI and not APM.
>
> If you really want this fixedm you will have to talk to your machine
> menufacturer (or the BIOS manufacturer).

This is not going to work as it's not supported anymore :(
Too bad that the BIOS is Phoenix, as I'm able to modify Award BIOSes only.
So I'll try to find out what the APM BIOS does, rewrite it in C and put in my 
kernel.

-- 
Ondrej Zary

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWAMIQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWAMIQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWAMIQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:16:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030289AbWAMIQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:16:56 -0500
Date: Fri, 13 Jan 2006 00:16:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miroslaw Mieszczak <mirek@mieszczak.com.pl>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: [2.6] Problem with PDC20265 on system with I865 chipset and PIV
 HT
Message-Id: <20060113001618.66821fcb.akpm@osdl.org>
In-Reply-To: <43C6DA9D.4060300@mieszczak.com.pl>
References: <43C6DA9D.4060300@mieszczak.com.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miroslaw Mieszczak <mirek@mieszczak.com.pl> wrote:
>
> I have a problem with PDC20265 controller.
>  On 2.6 kernel I can use it only if set kernel parameters ide2=serialize 
>  ide3=serialize.
>  In other case simultaneous R/W operation from both channels lead into 
>  data corruption and system crash.
> 

hm, I see poor old Bart is plugging away with bug 4309.  Good luck with
that ;)

>  Today I tried 2.6.15 kernel, and few times saved Oops data:
> 
> 
>  Oops: 0002 [#1]
>  SMP
>  Modules linked in: netconsole yenta_socket rsrc_nonstatic pcmcia_core
>  CPU:    1
>  EIP:    0060:[<c0110471>]    Not tainted VLI
>  EFLAGS: 00010003   (2.6.15)
>  EIP is at smp_invalidate_interrupt+0x2d/0x6f
>  eax: 00579000   ebx: f7c22000   ecx: f7302300   edx: 00000001
>  esi: c0575380   edi: c0575300   ebp: f7c22000   esp: f7c23f70
>  ds: 007b   es: 007b   ss: 0068
>  Process swapper (pid: 0, threadinfo=f7c22000 task=f7c1c530)
>  Stack: c010386c f7c22000 c170e2e0 f7c22000 c0575380 c0575300 f7c22000 
>  00000000
>         0000007b 0000007b fffffffd c0100d7c 00000060 00000246 c0100e19 
>  01020809
>         00000000 00000000 00000000 00000000 00000000 00000000 00000000 
>  00000000
>  Call Trace:
>   [<c010386c>] invalidate_interrupt+0x1c/0x24
>   [<c0100d7c>] default_idle+0x2e/0x52
>   [<c0100e19>] cpu_idle+0x65/0x73
>  Code: e0 ff ff 21 e0 8b 50 10 0f a3 15 38 d6 57 c0 19 c0 85 c0 74 28 b8 
>  00 59 57 c0 03 04 95 04 b0 57 c0 8b 08 3b 0d 3c d6 57 c0 74 13 <c7> 05 
>  b0 d0 ff ff 00 00 00 00 f0 0f b3 15 38 d6 57 c0 c3 83 78

That's unrelated.  smp_invalidate_interrupt() died here:


Code;  c0110459 No symbols available
  13:   74 28                     je     3d <_EIP+0x3d>
Code;  c011045b No symbols available
  15:   b8 00 59 57 c0            mov    $0xc0575900,%eax
Code;  c0110460 No symbols available
  1a:   03 04 95 04 b0 57 c0      add    0xc057b004(,%edx,4),%eax
Code;  c0110467 No symbols available
  21:   8b 08                     mov    (%eax),%ecx
Code;  c0110469 No symbols available
  23:   3b 0d 3c d6 57 c0         cmp    0xc057d63c,%ecx
Code;  c011046f No symbols available
  29:   74 13                     je     3e <_EIP+0x3e>

This decode from eip onwards should be reliable

Code;  c0110471 No symbols available
00000000 <_EIP>:
Code;  c0110471 No symbols available   <=====
   0:   c7 05 b0 d0 ff ff 00      movl   $0x0,0xffffd0b0   <=====
Code;  c0110478 No symbols available
   7:   00 00 00 
Code;  c011047b No symbols available
   a:   f0 0f b3 15 38 d6 57      lock btr %edx,0xc057d638
Code;  c0110482 No symbols available
  11:   c0 
Code;  c0110483 No symbols available
  12:   c3                        ret    
Code;  c0110484 No symbols available
  13:   83                        .byte 0x83
Code;  c0110485 No symbols available
  14:   78                        .byte 0x78


That's oopsing when trying to write to the APIC:

	apic_write_around(APIC_EOI, 0);

<cc's x86 people>

Is there any sane way in which APIC accesses can fault, or does this
indicate bad hardware?


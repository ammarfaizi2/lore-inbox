Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBGRCn>; Wed, 7 Feb 2001 12:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBGRCe>; Wed, 7 Feb 2001 12:02:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37648 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129047AbRBGRC2>; Wed, 7 Feb 2001 12:02:28 -0500
Message-ID: <3A817F68.1A5C4EC1@transmeta.com>
Date: Wed, 07 Feb 2001 09:01:28 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: mingo@redhat.com, linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: UP APIC reenabling vs. cpu type detection ordering
In-Reply-To: <20010207135824.A24476@vana.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> Hi,
>   Mikael Pettersson pointed to me that current kernel code should not
> reenable local APIC on AMD K7, as it tests boot_cpu_data.x86_vendor.
> But boot_cpu_data.x86_vendor is uninitialized (or contains wrong
> value) when detect_init_APIC is invoked.
> 
>   As side effect I can confirm that APIC reenabling code works also on
> my AMD K7.
>                                                 Best regards,
>                                                         Petr Vandrovec
>                                                         vandrove@vc.cvut.cz
> 
> P.S.: I'm getting 'spurious 8259A interrupt: IRQ7' few seconds after boot.
> It does not cause any harm AFAIS.
> 
> int detect_init_APIC (void)
> {
>         u32 h, l, dummy, features;
> 
>         if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
>                 printk("No APIC support for non-Intel processors.\n");
>                 return -1;
>         }
> 
>         ...
> 
>                 rdmsr(MSR_IA32_APICBASE, l, h);
>                 if (!(l & MSR_IA32_APICBASE_ENABLE)) {
>                         printk("Local APIC disabled by BIOS -- reenabling.\n");
>                         l &= ~MSR_IA32_APICBASE_BASE;
>                         l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
>                         wrmsr(MSR_IA32_APICBASE, l, h);
>                 }
>         }
> 

Why is the test there in the first place?  If the machine has an APIC, it
should be able to use it.  Presumably no other CPU uses the same MSR
address (am I wrong?) for anything else -- if so, it should be able to
poke it as long as the kernel intercepts the #GP(0) that may come if it
is not enabled.  The Linux kernel has pretty sophisticated support for
trapping faults.

In other words, I'd like to see a reason for making any vendor-specific
determinations, and if so, they should ideally be centralized to the CPU
feature-determination code.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

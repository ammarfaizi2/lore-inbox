Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277380AbRJERmu>; Fri, 5 Oct 2001 13:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277424AbRJERml>; Fri, 5 Oct 2001 13:42:41 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:15518 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277380AbRJERmf>; Fri, 5 Oct 2001 13:42:35 -0400
Date: Fri, 05 Oct 2001 10:39:44 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Olaf Zaplinski <o.zaplinski@mediascape.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FIX] Compiler error on linux-2.4.11-pre4/arch/i386/kernel/mpparse.c
Message-ID: <1551004281.1002278384@mbligh.des.sequent.com>
In-Reply-To: <3BBDDB58.850F966@mediascape.de>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My fault. I'd tested this on SMP and Uniproc, but not uniproc with
IO apic support. Try hacking out the if CONFIG_SMP from this bit

#if CONFIG_SMP
# ifdef CONFIG_MULTIQUAD
#  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
#  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
# else
#  define TARGET_CPUS cpu_online_map
#  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
# endif
#else
# define TARGET_CPUS 0x01
#endif

in smp.h. But you might run into something else. Now I understand which
combination breaks it, I'll do some testing and get you a patch ASAP.

M.

--On Friday, October 05, 2001 6:10 PM +0200 Olaf Zaplinski <o.zaplinski@mediascape.de> wrote:

> Philipp Matthias Hahn wrote:
>> 
>> Hello LKML!
>> 
>> patch-2.4.11-pre4 adds the following lines to include/acm-i386/smp.h:90
>> +#ifndef clustered_apic_mode
>> + #ifdef CONFIG_MULTIQUAD
>> +  #define clustered_apic_mode (1)
>> +  #define esr_disable (1)
>> + #else /* !CONFIG_MULTIQUAD */
>> +  #define clustered_apic_mode (0)
>> +  #define esr_disable (0)
>> + #endif /* CONFIG_MULTIQUAD */
>> +#endif
>> 
>> which don't get included when compiling for non-SMP. Move those lines up
>> before
>> line 37 with "#ifdef CONFIG_SMP" and compiling should work again.
> 
> No, this does not help... :-(
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.11-pre4/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686    -c -o io_apic.o io_apic.c
> io_apic.c: In function `setup_IO_APIC_irqs':
> io_apic.c:601: `INT_DELIVERY_MODE' undeclared (first use in this function)
> io_apic.c:601: (Each undeclared identifier is reported only once
> io_apic.c:601: for each function it appears in.)
> io_apic.c: In function `setup_ExtINT_IRQ0_pin':
> io_apic.c:675: `INT_DELIVERY_MODE' undeclared (first use in this function)
> make[1]: *** [io_apic.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.11-pre4/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2
> 
> 
> Olaf
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



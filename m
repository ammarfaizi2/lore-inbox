Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWCAD2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWCAD2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWCAD2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:28:25 -0500
Received: from thorn.pobox.com ([208.210.124.75]:11671 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1750755AbWCAD2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:28:24 -0500
Date: Tue, 28 Feb 2006 21:28:19 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 cpu hotplug bug - instant reboot when onlining secondary
Message-ID: <20060301032819.GC2856@localhost.localdomain>
References: <20060219235826.GF3293@localhost.localdomain> <Pine.LNX.4.64.0602210800290.1579@montezuma.fsmlabs.com> <20060227075033.GK3293@localhost.localdomain> <Pine.LNX.4.64.0602270748240.1579@montezuma.fsmlabs.com> <20060228213412.GB2856@localhost.localdomain> <Pine.LNX.4.64.0602281412450.28074@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602281412450.28074@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Tue, 28 Feb 2006, Nathan Lynch wrote:
> 
> > Zwane Mwaikambo wrote:
> > > On Mon, 27 Feb 2006, Nathan Lynch wrote:
> > > 
> > > > Zwane Mwaikambo wrote:
> > > > > On Sun, 19 Feb 2006, Nathan Lynch wrote:
> > > > > 
> > > > > > On a dual P3 Xeon machine, offlining and then onlining a cpu makes the
> > > > > > box instantly reboot.  I've been seeing this throughout the 2.6.16-rc
> > > > > > series, but wasn't able to collect more information until now.  Not
> > > > > > sure when this last worked, unfortunately.
> > > > > > 
> > > > > > With the debugging patch below, I get this on serial console:
> > > > > 
> > > > > Does 2.6.14 work? Also i wonder if it gets out of the trampoline...
> > > > 
> > > > 2.6.14 works (albeit with an APIC error reported).  When retesting
> > > > 2.6.16-rc4 with your patch on top of my debugging patch, I don't see the
> > > > "startup_secondary" line:
> > > 
> > > Hi Nathan,
> > > 
> > > Can you try the following patch? We can start moving the WARM_BOOT_HLT 
> > > down until it triple faults (i'm assuming it at least gets this far).
> > 
> > Here's what I got with this one on top of a day-old -git (all
> > debugging patches still applied):
> 
> Looks good, how about the following

I now get:

[17179687.244000] CPU 1 is now offline
[17179693.164000] Booting processor 1/1 eip 3000
[17179693.216000] CPU 1 irqstacks, hard=7837f000 soft=78377000
[17179693.284000] Setting warm reset code and vector.
[17179693.340000] 1.
[17179693.364000] 2.
[17179693.388000] 3.
[17179693.408000] Asserting INIT.
[17179693.448000] Waiting for send to finish...
[17179693.496000] +<7>Deasserting INIT.
[17179693.552000] Waiting for send to finish...
[17179693.600000] +<7>#startup loops: 2.
[17179693.644000] Sending STARTUP #1.
[17179693.688000] After apic_write.
[17179693.724000] Doing apic_write_around for target chip...
[17179693.788000] Doing apic_write_around to kick the second...


> Index: linux-2.6.16-rc2-mm1/arch/i386/kernel/head.S
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.16-rc2-mm1/arch/i386/kernel/head.S,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 head.S
> --- linux-2.6.16-rc2-mm1/arch/i386/kernel/head.S	11 Feb 2006 16:55:14 -0000	1.1.1.1
> +++ linux-2.6.16-rc2-mm1/arch/i386/kernel/head.S	28 Feb 2006 22:12:25 -0000
> @@ -146,6 +146,12 @@ page_pde_offset = (__PAGE_OFFSET >> 20);
>   * we know the trampoline has already loaded the boot_gdt_table GDT
>   * for us.
>   */
> +#define warm_boot	tsc_sync_disabled-__PAGE_OFFSET
> +#define WARM_BOOT_HLT		\
> +	cmpl	$0, warm_boot;	\
> +10:				\
> +	jne	10b
> +
>  ENTRY(startup_32_smp)
>  	cld
>  	movl $(__BOOT_DS),%eax
> @@ -324,6 +330,7 @@ is386:	movl $2,%ecx		# set MP
>  	cmpb $0,%cl
>  	je 1f			# the first CPU calls start_kernel
>  				# all other CPUs call initialize_secondary
> +	WARM_BOOT_HLT
>  	call initialize_secondary
>  	jmp L6
>  1:
> Index: linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 smpboot.c
> --- linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c	11 Feb 2006 16:55:14 -0000	1.1.1.1
> +++ linux-2.6.16-rc2-mm1/arch/i386/kernel/smpboot.c	28 Feb 2006 15:34:42 -0000
> @@ -102,7 +102,7 @@ static cpumask_t smp_commenced_mask;
>   * is no way to resync one AP against BP. TBD: for prescott and above, we
>   * should use IA64's algorithm
>   */
> -static int __devinitdata tsc_sync_disabled;
> +int __devinitdata tsc_sync_disabled;
>  
>  /* Per CPU bogomips and other parameters */
>  struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;

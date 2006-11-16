Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162165AbWKPXIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162165AbWKPXIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbWKPXIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:08:18 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:1941 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1754897AbWKPXIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:08:18 -0500
Date: Thu, 16 Nov 2006 15:10:41 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Message-ID: <20061116231041.GI1397@sequoia.sous-sol.org>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061116145313.d7b2240b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116145313.d7b2240b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Andi seems to have merged this patch but from somewhere I picked up a
> different version, below.

That was from me.  The earlier one had fallen through the cracks, so
I picked it up and reworked it (so that it uses no_timer_check) as per
Andi's suggestion.

> I think the version I have is better.

Agreed ;-)

> Because the patch Andi has merged is
> cast in terms of "irq testing", which is broad.  But that's not what the
> patch does - the patch handles only timers.
> 
> IOW, this:
> 
> > +
> > +	noirqtest	[IA-32,APIC] Disables the code which tests for broken
> > +			timer IRQ sources.
> 
> is misleadingly named.  This:
> 
> +       no_timer_check  [IA-32,X86_64,APIC] Disables the code which tests for
> +                       broken timer IRQ sources.
> +
> 
> is better, no?

Clearer, and also same as x86_64.

> But right now, I'll settle for anything which usually compiles.

I believe the current round has fixed all the know compilation issues.
There's one outstanding runtime issue from Andi, which I believe is due
to an old glibc which requires COMPAT_VDSO (and which CONFIG_PARAVIRT
must disable).  So current set is clean from the reports I have (and
assuming above vdso analysis is correct).

thanks,
-chris
--
> From: Zachary Amsden <zach@vmware.com>
> 
> Add a way to disable the timer IRQ routing check via a boot option.  The
> VMI timer code uses this to avoid triggering the pester Mingo code, which
> probes for some very unusual and broken motherboard routings.  It fires
> 100% of the time when using a paravirtual delay mechanism instead of using
> a realtime delay, since there is no elapsed real time, and the 4 timer IRQs
> have not yet been delivered.
> 
> In addition, it is entirely possible, though improbable, that this bug
> could surface on real hardware which picks a particularly bad time to enter
> SMM mode, causing a long latency during one of the timer IRQs.
> 
> While here, make check_timer be __init.
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> [chrisw: use no_timer_check to bring inline with x86_64 as per Andi's request]
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Cc: Andi Kleen <ak@suse.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  Documentation/kernel-parameters.txt |    7 +++++--
>  arch/i386/kernel/io_apic.c          |   16 ++++++++++++++--
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff -puN arch/i386/kernel/io_apic.c~i386-add-a-way-to-disable-the-timer-irq-routing-check-via-a-boot-option arch/i386/kernel/io_apic.c
> --- a/arch/i386/kernel/io_apic.c~i386-add-a-way-to-disable-the-timer-irq-routing-check-via-a-boot-option
> +++ a/arch/i386/kernel/io_apic.c
> @@ -1930,6 +1930,15 @@ static void __init setup_ioapic_ids_from
>  static void __init setup_ioapic_ids_from_mpc(void) { }
>  #endif
>  
> +static int no_timer_check __initdata;
> +
> +static int __init notimercheck(char *s)
> +{
> +	no_timer_check = 1;
> +	return 1;
> +}
> +__setup("no_timer_check", notimercheck);
> +
>  /*
>   * There is a nasty bug in some older SMP boards, their mptable lies
>   * about the timer IRQ. We do the following to work around the situation:
> @@ -1938,10 +1947,13 @@ static void __init setup_ioapic_ids_from
>   *	- if this function detects that timer IRQs are defunct, then we fall
>   *	  back to ISA timer IRQs
>   */
> -static int __init timer_irq_works(void)
> +int __init timer_irq_works(void)
>  {
>  	unsigned long t1 = jiffies;
>  
> +	if (no_timer_check)
> +		return 1;
> +
>  	local_irq_enable();
>  	/* Let ten ticks pass... */
>  	mdelay((10 * 1000) / HZ);
> @@ -2212,7 +2224,7 @@ int timer_uses_ioapic_pin_0;
>   * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
>   * fanatically on his truly buggy board.
>   */
> -static inline void check_timer(void)
> +static inline void __init check_timer(void)
>  {
>  	int apic1, pin1, apic2, pin2;
>  	int vector;
> diff -puN Documentation/kernel-parameters.txt~i386-add-a-way-to-disable-the-timer-irq-routing-check-via-a-boot-option Documentation/kernel-parameters.txt
> --- a/Documentation/kernel-parameters.txt~i386-add-a-way-to-disable-the-timer-irq-routing-check-via-a-boot-option
> +++ a/Documentation/kernel-parameters.txt
> @@ -599,8 +599,6 @@ and is between 256 and 4096 characters. 
>  
>  	hugepages=	[HW,IA-32,IA-64] Maximal number of HugeTLB pages.
>  
> -	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
> -
>  	i8042.direct	[HW] Put keyboard port into non-translated mode
>  	i8042.dumbkbd	[HW] Pretend that controller can only read data from
>  			     keyboard and cannot control its state
> @@ -1056,9 +1054,14 @@ and is between 256 and 4096 characters. 
>  			in certain environments such as networked servers or
>  			real-time systems.
>  
> +	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
> +
>  	noirqdebug	[IA-32] Disables the code which attempts to detect and
>  			disable unhandled interrupt sources.
>  
> +	no_timer_check	[IA-32,X86_64,APIC] Disables the code which tests for
> +			broken timer IRQ sources.
> +
>  	noisapnp	[ISAPNP] Disables ISA PnP code.
>  
>  	noinitrd	[RAM] Tells the kernel not to load any configured
> _

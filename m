Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310695AbSCSXbF>; Tue, 19 Mar 2002 18:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310740AbSCSXat>; Tue, 19 Mar 2002 18:30:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:5507 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S310695AbSCSXaT>;
	Tue, 19 Mar 2002 18:30:19 -0500
Date: Wed, 20 Mar 2002 00:28:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
Message-ID: <20020319232836.GB1758@elf.ucw.cz>
In-Reply-To: <Pine.GSO.3.96.1020319145208.12399I-100000@delta.ds2.pg.gda.pl> <Pine.LNX.4.33.0203191711070.9609-100000@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- ./arch/i386/kernel/time.c.ORIG	Fri Mar 15 14:57:00 2002
> +++ ./arch/i386/kernel/time.c	Tue Mar 19 17:27:12 2002
> @@ -384,7 +384,9 @@
>  /* last time the cmos clock got updated */
>  static long last_rtc_update;
> 
> +#ifndef CONFIG_X86_TSC
>  int timer_ack;
> +#endif
> 
>  /*
>   * timer_interrupt() needs to keep up the real-time clock,
> @@ -392,7 +394,7 @@
>   */
>  static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
>  {
> -#ifdef CONFIG_X86_IO_APIC
> +#if defined (CONFIG_X86_IO_APIC) && ! defined (CONFIG_X86_TSC)
>  	if (timer_ack) {
>  		/*
>  		 * Subtle, when I/O APICs are used we have to ack timer IRQ
> --- ./arch/i386/kernel/io_apic.c.ORIG	Tue Mar 19 17:31:25 2002
> +++ ./arch/i386/kernel/io_apic.c	Tue Mar 19 17:30:02 2002
> @@ -1478,7 +1478,9 @@
>   */
>  static inline void check_timer(void)
>  {
> +#ifndef CONFIG_X86_TSC
>  	extern int timer_ack;
> +#endif
>  	int pin1, pin2;
>  	int vector;
> 
> @@ -1498,7 +1500,7 @@
>  	 */
>  	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
>  	init_8259A(1);
> -	timer_ack = 1;
> +	timer_ack = !(cpu_has_tsc);
>  	enable_8259A_irq(0);
> 
>  	pin1 = find_isa_irq_pin(0, mp_INT);
> 
> 
> This would get us rid of our problem (although the BIOS hack may
> suffice). However, more than that, it also spares ~2 us on each timer
> interrupt for CPUs which do not need do_slow_gettimeoffset.
> 
> What do you think?

Well, you should get your bios fixed.

Then... Those ifdefs are not neccessary, right? You only need ...

> @@ -1498,7 +1500,7 @@
>  	 */
>  	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
>  	init_8259A(1);
> -	timer_ack = 1;
> +	timer_ack = !(cpu_has_tsc);
>  	enable_8259A_irq(0);
> 
>  	pin1 = find_isa_irq_pin(0, mp_INT);

... these lines.
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

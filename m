Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268026AbTBRV5l>; Tue, 18 Feb 2003 16:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268039AbTBRV5l>; Tue, 18 Feb 2003 16:57:41 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21262 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268026AbTBRV5k>; Tue, 18 Feb 2003 16:57:40 -0500
Date: Tue, 18 Feb 2003 23:07:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: Fixes to suspend-to-RAM
Message-ID: <20030218220740.GD21974@atrey.karlin.mff.cuni.cz>
References: <20030218214343.GB21974@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0302181535520.1035-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302181535520.1035-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >  void __init acpi_reserve_bootmem(void)
> > > >  {
> > > >  	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
> > > > +	if (!acpi_wakeup_address)
> > > > +		printk(KERN_ERR "ACPI: Cannot allocate lowmem. S3 disabled.\n");
> > > >  	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
> > > >  		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
> > > > -	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
> > > 
> > > If you say you're disabling S3, then please really do so and flip the bit 
> > > in the sleep_states[] array.
> > 
> > Check the code, there's a conditional former in the file and S3 will
> > correctly fail. I don't feel like flipping bits from here
> > (arch-dep-code) in generic code.
> 
> Fine. But, how about a call that the drivers/acpi/sleep/main.c::sleep_init()
> can call to arch/i386/kernel/acpi/ to validate that it can do S3 from the 
> beginning. That way, we're more certain of whether or not we're going to 
> succeed or not. 

Bootmem needs to be reserved pretty soon in the boot process, that
might be a problem.

> Doing this can also get rid of this crap, too:
> 
> int acpi_save_state_mem (void)
> {
> #if CONFIG_X86_PAE
>         panic("S3 and PAE do not like each other for now.");
>         return 1;
> #endif
> 
> > Good idea. So acpi_system_save_state can no longer be called with S5,
> > right? That allows quite a lot of cleanup.
> 
> Correct.
> 
> > Hmm, how do you propose error handling when SUSPEND_DISABLE fails?
> > Call SUSPEND_ENABLE or not? Once that is decided  panic can go. But I
> > still think that just should not happen.
> 
> I propose that we don't even call SUSPEND_DISABLE. Based on recent
> conversations, it appears that we can and should do the entire device
> suspend sequence in two passes - SUSPEND_SAVE_STATE with interrupts
> enabled, and SUSPEND_POWER_DOWN with interrupts disabled.

Yes, that crossed my mind, too. That's probably best.

Based on recent talk... Will you act as S3 maintainer so that I can
submit patches to you and you'll take care of forwarding to Linus?

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.

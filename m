Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268024AbTBRVdo>; Tue, 18 Feb 2003 16:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268025AbTBRVdo>; Tue, 18 Feb 2003 16:33:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15881 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268024AbTBRVdm>; Tue, 18 Feb 2003 16:33:42 -0500
Date: Tue, 18 Feb 2003 22:43:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: Fixes to suspend-to-RAM
Message-ID: <20030218214343.GB21974@atrey.karlin.mff.cuni.cz>
References: <20030218211741.GA1039@elf.ucw.cz> <Pine.LNX.4.33.0302181509070.1035-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302181509070.1035-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  void __init acpi_reserve_bootmem(void)
> >  {
> >  	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
> > +	if (!acpi_wakeup_address)
> > +		printk(KERN_ERR "ACPI: Cannot allocate lowmem. S3 disabled.\n");
> >  	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
> >  		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
> > -	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
> 
> If you say you're disabling S3, then please really do so and flip the bit 
> in the sleep_states[] array.

Check the code, there's a conditional former in the file and S3 will
correctly fail. I don't feel like flipping bits from here
(arch-dep-code) in generic code.

> > --- clean/drivers/acpi/sleep/main.c	2003-02-15 18:51:17.000000000 +0100
> > +++ linux/drivers/acpi/sleep/main.c	2003-02-15 18:57:27.000000000 +0100
> > @@ -103,6 +103,10 @@
> >  			return error;
> >  		}
> >  
> > +		error = device_suspend(state, SUSPEND_DISABLE);
> > +		if (error)
> > +			panic("Sorry, devices really should know how to disable\n");
> > +
> 
> Why is every error condition a panic()? That certainly does not add 
> robustness to the code..
> 
> Also, you say that the APIC needs this state. I wonder if that should be
> done in the SUSPEND_POWER_DOWN stage with interrupts disabled?

Good idea. So acpi_system_save_state can no longer be called with S5,
right? That allows quite a lot of cleanup.

Hmm, how do you propose error handling when SUSPEND_DISABLE fails?
Call SUSPEND_ENABLE or not? Once that is decided  panic can go. But I
still think that just should not happen.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.

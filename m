Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbTBRVR4>; Tue, 18 Feb 2003 16:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268022AbTBRVR4>; Tue, 18 Feb 2003 16:17:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58818 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268017AbTBRVRz>;
	Tue, 18 Feb 2003 16:17:55 -0500
Date: Tue, 18 Feb 2003 15:14:03 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: <torvalds@transmeta.com>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: Fixes to suspend-to-RAM
In-Reply-To: <20030218211741.GA1039@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0302181509070.1035-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  void __init acpi_reserve_bootmem(void)
>  {
>  	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
> +	if (!acpi_wakeup_address)
> +		printk(KERN_ERR "ACPI: Cannot allocate lowmem. S3 disabled.\n");
>  	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
>  		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
> -	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);

If you say you're disabling S3, then please really do so and flip the bit 
in the sleep_states[] array.

> --- clean/drivers/acpi/sleep/main.c	2003-02-15 18:51:17.000000000 +0100
> +++ linux/drivers/acpi/sleep/main.c	2003-02-15 18:57:27.000000000 +0100
> @@ -103,6 +103,10 @@
>  			return error;
>  		}
>  
> +		error = device_suspend(state, SUSPEND_DISABLE);
> +		if (error)
> +			panic("Sorry, devices really should know how to disable\n");
> +

Why is every error condition a panic()? That certainly does not add 
robustness to the code..

Also, you say that the APIC needs this state. I wonder if that should be
done in the SUSPEND_POWER_DOWN stage with interrupts disabled?

	-pat


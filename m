Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268977AbUIQUec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268977AbUIQUec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUIQUec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:34:32 -0400
Received: from zork.zork.net ([64.81.246.102]:43713 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S268977AbUIQUeO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:34:14 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8-rc1-mm4: allow-i8042-register-location-override-2.patch
References: <6uy8jg4hp9.fsf@zork.zork.net>
	<200409111727.56934.dtor_core@ameritech.net>
	<200409130851.21743.bjorn.helgaas@hp.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Dmitry Torokhov
	<dtor_core@ameritech.net>, linux-kernel@vger.kernel.org, Dmitry
	Torokhov <dtor@mail.ru>, Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Sep 2004 21:33:54 +0100
In-Reply-To: <200409130851.21743.bjorn.helgaas@hp.com> (Bjorn Helgaas's
	message of "Mon, 13 Sep 2004 08:51:21 -0600")
Message-ID: <6uacvovdn1.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <bjorn.helgaas@hp.com> writes:

> On Saturday 11 September 2004 4:27 pm, Dmitry Torokhov wrote:
>> On Saturday 11 September 2004 04:30 pm, Sean Neakums wrote:
>> > > Input: Add ACPI-based i8042 keyboard and aux controller enumeration;
>> > > can be disabled by passing i8042.noacpi as a boot parameter.
>> > 
>> > On a whim I decided to turn on ACPI, only to discover that my keyboard
>> > no longer worked.  Passing i8042.noacpi=1 makes it work again.
>> > Attached please find boot messages with and without the boot
>> > parameter.  Inlined below is a diff of the two.
>> 
>> Bjorn has a patch that would use defaults if ports/IRQ are not specified
>> in the DSDT table, which should help in your case I think.
>
> Thanks much for testing this, Sean.  Can you try the attached patch,
> please?

With this patch applied and no extra boot parameters, my keyboard works.

> --- 2.6.9-rc1-mm4-bh1/drivers/input/serio/i8042-x86ia64io.h.orig	2004-09-07 14:41:42.000000000 -0600
> +++ 2.6.9-rc1-mm4-bh1/drivers/input/serio/i8042-x86ia64io.h	2004-09-07 14:51:06.000000000 -0600
> @@ -155,9 +155,23 @@
>  		acpi_device_name(device), acpi_device_bid(device),
>  		kbd_res.port1, kbd_res.port2, kbd_res.irq);
>  
> -	i8042_data_reg = kbd_res.port1;
> -	i8042_command_reg = kbd_res.port2;
> -	i8042_kbd_irq = kbd_res.irq;
> +	if (kbd_res.port1)
> +		i8042_data_reg = kbd_res.port1;
> +	else
> +		printk(KERN_WARNING "i8042: bogus data port address in %s _CRS, defaulting to 0x%x\n",
> +			acpi_device_bid(device), i8042_data_reg);
> +
> +	if (kbd_res.port2)
> +		i8042_command_reg = kbd_res.port2;
> +	else
> +		printk(KERN_WARNING "i8042: bogus command port address in %s _CRS, defaulting to 0x%x\n",
> +			acpi_device_bid(device), i8042_command_reg);
> +
> +	if (kbd_res.irq)
> +		i8042_kbd_irq = kbd_res.irq;
> +	else
> +		printk(KERN_WARNING "i8042: bogus IRQ in %s _CRS, defaulting to %d\n",
> +			acpi_device_bid(device), i8042_kbd_irq);
>  
>  	return 0;
>  }
> @@ -176,7 +190,11 @@
>  	printk("i8042: ACPI %s [%s] at irq %d\n",
>  		acpi_device_name(device), acpi_device_bid(device), aux_res.irq);
>  
> -	i8042_aux_irq = aux_res.irq;
> +	if (aux_res.irq)
> +		i8042_aux_irq = aux_res.irq;
> +	else
> +		printk(KERN_WARNING "i8042: bogus IRQ in %s _CRS, defaulting to %d\n",
> +			acpi_device_bid(device), i8042_aux_irq);
>  
>  	return 0;
>  }
> @@ -201,7 +219,7 @@
>  {
>  	int result;
>  
> -	if (i8042_noacpi) {
> +	if (acpi_disabled || i8042_noacpi) {
>  		printk("i8042: ACPI detection disabled\n");
>  		return 0;
>  	}

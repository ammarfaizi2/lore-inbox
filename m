Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268683AbUIGVVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268683AbUIGVVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268679AbUIGVTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:19:01 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:51783 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268672AbUIGVRs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:17:48 -0400
Subject: Re: [PATCH] ACPI-based i8042 keyboard/aux controller enumeration
From: Paul Fulghum <paulkf@microgate.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200409071504.54173.bjorn.helgaas@hp.com>
References: <1094585860.2506.15.camel@deimos.microgate.com>
	 <200409071403.58198.bjorn.helgaas@hp.com>
	 <1094590748.2531.2.camel@deimos.microgate.com>
	 <200409071504.54173.bjorn.helgaas@hp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1094591865.2532.1.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Sep 2004 16:17:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 16:04, Bjorn Helgaas wrote:
> On Tuesday 07 September 2004 2:59 pm, Paul Fulghum wrote:
> > On Tue, 2004-09-07 at 15:03, Bjorn Helgaas wrote:
> > > Can you apply the following patch on top of 2.6.9-rc1-mm4, boot
> > > with "i8042.lsacpi", and post the resulting dmesg?
> > 
> > Nothing is output with i8042.lsacpi=1.
> > I tried it with both i8042.noacpi=1 and 0.
> > 
> > I did notice the following:
> > 
> > Sep  7 15:53:57 deimos kernel: ACPI: Unable to locate RSDP
> > <snip>...
> > Sep  7 15:53:58 deimos kernel: ACPI: Subsystem revision 20040816
> > Sep  7 15:53:58 deimos kernel: ACPI: Interpreter disabled.
> 
> Ah, that explains it.  Can you try this patch, please?  It falls back
> to the original scheme if ACPI is disabled.
> 
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

That worked:
Sep  7 16:12:53 deimos kernel: i8042: ACPI detection disabled
Sep  7 16:12:53 deimos kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep  7 16:12:53 deimos kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

Thanks,
Paul

 
--
Paul Fulghum
paulkf@microgate.com



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUIFMWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUIFMWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267872AbUIFMWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:22:43 -0400
Received: from [195.135.223.162] ([195.135.223.162]:3456 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S267850AbUIFMWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:22:21 -0400
Date: Mon, 6 Sep 2004 14:22:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] allow i8042 register location override
Message-ID: <20040906122237.GA316@ucw.cz>
References: <20040902175647.97709.qmail@web81309.mail.yahoo.com> <200409021529.19575.bjorn.helgaas@hp.com> <200409030157.17604.dtor_core@ameritech.net> <200409030941.24557.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409030941.24557.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 09:41:24AM -0600, Bjorn Helgaas wrote:
> On Friday 03 September 2004 12:57 am, Dmitry Torokhov wrote:
> > What do you think about the patch below? I renamed some function/variable
> > names to be more in line with the rest of i8042 code, other than that
> > its pretty much your code.
> 
> That looks great to me, and it works fine on my DL360.
> 
> My only comment is that in an ideal world, we would not have to
> change any drivers if a new architecture started supporting ACPI.
> With the current patch, we'd have to twiddle some of the i8042-XXX.h
> files a bit.  But I don't think it's worth the trouble of restructuring
> them to fix that.
> 
> Thanks for all your help!

One bug that I could spot immediately is that the patch sets i8042_reset
on i386. This doesn't seem intentional, and is quite wrong, too, since
on some older machines it confuses the BIOS.

I'll look deeper for more problems (like what the patch will do on
amd64, where we should use ACPI as well), but the patch looks fairly OK
otherwise.

> ===================================================================
> 
> 
> ChangeSet@1.1913, 2004-09-03 01:52:52-05:00, dtor_core@ameritech.net
>   Input: Add ACPI-based i8042 keyboard and aux controller enumeration;
>          can be disabled by passing i8042.noacpi as a boot parameter.
>   
>          Original code by Bjorn Helgaas <bjorn.helgaas@hp.com>
>   
>   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> 
>  Documentation/kernel-parameters.txt   |    2 
>  drivers/input/serio/i8042-io.h        |   51 ------
>  drivers/input/serio/i8042-x86ia64io.h |  272 ++++++++++++++++++++++++++++++++++
>  drivers/input/serio/i8042.c           |    6 
>  drivers/input/serio/i8042.h           |    2 
>  5 files changed, 289 insertions(+), 44 deletions(-)
> 
> 
> ===================================================================
> 
> diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> --- a/Documentation/kernel-parameters.txt	2004-09-03 01:54:25 -05:00
> +++ b/Documentation/kernel-parameters.txt	2004-09-03 01:54:25 -05:00
> @@ -464,6 +464,8 @@
>  	i8042.dumbkbd	[HW] Pretend that controlled can only read data from
>  			     keyboard and can not control its state
>  			     (Don't attempt to blink the leds)
> +	i8042.noacpi	[HW] Don't use ACPI to discover KBD/AUX controller
> +			     settings
>  	i8042.noaux	[HW] Don't check for auxiliary (== mouse) port
>  	i8042.nomux	[HW] Don't check presence of an active multiplexing
>  			     controller
> diff -Nru a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
> --- a/drivers/input/serio/i8042-io.h	2004-09-03 01:54:25 -05:00
> +++ b/drivers/input/serio/i8042-io.h	2004-09-03 01:54:25 -05:00
> @@ -3,7 +3,7 @@
>  
>  /*
>   * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by 
> + * under the terms of the GNU General Public License version 2 as published by
>   * the Free Software Foundation.
>   */
>  
> @@ -22,9 +22,6 @@
>  #ifdef __alpha__
>  # define I8042_KBD_IRQ	1
>  # define I8042_AUX_IRQ	(RTC_PORT(0) == 0x170 ? 9 : 12)	/* Jensen is special */
> -#elif defined(__ia64__)
> -# define I8042_KBD_IRQ isa_irq_to_vector(1)
> -# define I8042_AUX_IRQ isa_irq_to_vector(12)
>  #elif defined(__arm__)
>  /* defined in include/asm-arm/arch-xxx/irqs.h */
>  #include <asm/irq.h>
> @@ -39,8 +36,8 @@
>   * Register numbers.
>   */
>  
> -#define I8042_COMMAND_REG	0x64	
> -#define I8042_STATUS_REG	0x64	
> +#define I8042_COMMAND_REG	0x64
> +#define I8042_STATUS_REG	0x64
>  #define I8042_DATA_REG		0x60
>  
>  static inline int i8042_read_data(void)
> @@ -56,66 +53,32 @@
>  static inline void i8042_write_data(int val)
>  {
>  	outb(val, I8042_DATA_REG);
> -	return;
>  }
>  
>  static inline void i8042_write_command(int val)
>  {
>  	outb(val, I8042_COMMAND_REG);
> -	return;
>  }
>  
> -#if defined(__i386__)
> -
> -#include <linux/dmi.h>
> -
> -static struct dmi_system_id __initdata i8042_dmi_table[] = {
> -	{
> -		.ident = "Compaq Proliant 8500",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
> -			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
> -		},
> -	},
> -	{
> -		.ident = "Compaq Proliant DL760",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
> -			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
> -		},
> -	},
> -	{ }
> -};
> -#endif
> -
>  static inline int i8042_platform_init(void)
>  {
>  /*
> - * On ix86 platforms touching the i8042 data register region can do really
> - * bad things. Because of this the region is always reserved on ix86 boxes.
> + * On some platforms touching the i8042 data register region can do really
> + * bad things. Because of this the region is always reserved on such boxes.
>   */
> -#if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__) && !defined(__x86_64__) && !defined(__mips__)
> +#if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__)
>  	if (!request_region(I8042_DATA_REG, 16, "i8042"))
>  		return -1;
>  #endif
>  
> -#if !defined(__i386__) && !defined(__x86_64__)
>          i8042_reset = 1;
> -#endif
> -
> -#if defined(__i386__)
> -	if (dmi_check_system(i8042_dmi_table))
> -		i8042_noloop = 1;
> -#endif
>  
>  	return 0;
>  }
>  
>  static inline void i8042_platform_exit(void)
>  {
> -#if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__) && !defined(__x86_64__)
> +#if !defined(__sh__) && !defined(__alpha__)
>  	release_region(I8042_DATA_REG, 16);
>  #endif
>  }
> diff -Nru a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/drivers/input/serio/i8042-x86ia64io.h	2004-09-03 01:54:25 -05:00
> @@ -0,0 +1,272 @@
> +#ifndef _I8042_X86IA64IO_H
> +#define _I8042_X86IA64IO_H
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +/*
> + * Names.
> + */
> +
> +#define I8042_KBD_PHYS_DESC "isa0060/serio0"
> +#define I8042_AUX_PHYS_DESC "isa0060/serio1"
> +#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
> +
> +/*
> + * IRQs.
> + */
> +
> +#if defined(__ia64__)
> +# define I8042_MAP_IRQ(x)	isa_irq_to_vector((x))
> +#else
> +# define I8042_MAP_IRQ(x)	(x)
> +#endif
> +
> +#define I8042_KBD_IRQ	i8042_kbd_irq
> +#define I8042_AUX_IRQ	i8042_aux_irq
> +
> +static int i8042_kbd_irq = I8042_MAP_IRQ(1);
> +static int i8042_aux_irq = I8042_MAP_IRQ(12);
> +
> +/*
> + * Register numbers.
> + */
> +
> +#define I8042_COMMAND_REG	i8042_command_reg
> +#define I8042_STATUS_REG	i8042_command_reg
> +#define I8042_DATA_REG		i8042_data_reg
> +
> +static int i8042_command_reg = 0x64;
> +static int i8042_data_reg = 0x60;
> +
> +
> +static inline int i8042_read_data(void)
> +{
> +	return inb(I8042_DATA_REG);
> +}
> +
> +static inline int i8042_read_status(void)
> +{
> +	return inb(I8042_STATUS_REG);
> +}
> +
> +static inline void i8042_write_data(int val)
> +{
> +	outb(val, I8042_DATA_REG);
> +}
> +
> +static inline void i8042_write_command(int val)
> +{
> +	outb(val, I8042_COMMAND_REG);
> +}
> +
> +#if defined(__i386__)
> +
> +#include <linux/dmi.h>
> +
> +static struct dmi_system_id __initdata i8042_dmi_table[] = {
> +	{
> +		.ident = "Compaq Proliant 8500",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
> +			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
> +		},
> +	},
> +	{
> +		.ident = "Compaq Proliant DL760",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
> +			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
> +		},
> +	},
> +	{ }
> +};
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +#include <acpi/acpi_bus.h>
> +
> +struct i8042_acpi_resources {
> +	unsigned int port1;
> +	unsigned int port2;
> +	unsigned int irq;
> +};
> +
> +static int i8042_acpi_kbd_registered;
> +static int i8042_acpi_aux_registered;
> +
> +static acpi_status i8042_acpi_parse_resource(struct acpi_resource *res, void *data)
> +{
> +	struct i8042_acpi_resources *i8042_res = data;
> +	struct acpi_resource_io *io;
> +	struct acpi_resource_irq *irq;
> +	struct acpi_resource_ext_irq *ext_irq;
> +
> +	switch (res->id) {
> +		case ACPI_RSTYPE_IO:
> +			io = &res->data.io;
> +			if (io->range_length) {
> +				if (!i8042_res->port1)
> +					i8042_res->port1 = io->min_base_address;
> +				else
> +					i8042_res->port2 = io->min_base_address;
> +			}
> +			break;
> +
> +		case ACPI_RSTYPE_IRQ:
> +			irq = &res->data.irq;
> +			if (irq->number_of_interrupts > 0)
> +				i8042_res->irq =
> +					acpi_register_gsi(irq->interrupts[0],
> +							  irq->edge_level,
> +							  irq->active_high_low);
> +			break;
> +
> +		case ACPI_RSTYPE_EXT_IRQ:
> +			ext_irq = &res->data.extended_irq;
> +			if (ext_irq->number_of_interrupts > 0)
> +				i8042_res->irq =
> +					acpi_register_gsi(ext_irq->interrupts[0],
> +							  ext_irq->edge_level,
> +							  ext_irq->active_high_low);
> +			break;
> +	}
> +	return AE_OK;
> +}
> +
> +static int i8042_acpi_kbd_add(struct acpi_device *device)
> +{
> +	struct i8042_acpi_resources kbd_res;
> +	acpi_status status;
> +
> +	memset(&kbd_res, 0, sizeof(kbd_res));
> +	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +				     i8042_acpi_parse_resource, &kbd_res);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	printk("i8042: ACPI %s [%s] at I/O 0x%x, 0x%x, irq %d\n",
> +		acpi_device_name(device), acpi_device_bid(device),
> +		kbd_res.port1, kbd_res.port2, kbd_res.irq);
> +
> +	i8042_data_reg = kbd_res.port1;
> +	i8042_command_reg = kbd_res.port2;
> +	i8042_kbd_irq = kbd_res.irq;
> +
> +	return 0;
> +}
> +
> +static int i8042_acpi_aux_add(struct acpi_device *device)
> +{
> +	struct i8042_acpi_resources aux_res;
> +	acpi_status status;
> +
> +	memset(&aux_res, 0, sizeof(aux_res));
> +	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +				     i8042_acpi_parse_resource, &aux_res);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	printk("i8042: ACPI %s [%s] at irq %d\n",
> +		acpi_device_name(device), acpi_device_bid(device), aux_res.irq);
> +
> +	i8042_aux_irq = aux_res.irq;
> +
> +	return 0;
> +}
> +
> +static struct acpi_driver i8042_acpi_kbd_driver = {
> +	.name		= "i8042",
> +	.ids		= "PNP0303",
> +	.ops		= {
> +		.add		= i8042_acpi_kbd_add,
> +	},
> +};
> +
> +static struct acpi_driver i8042_acpi_aux_driver = {
> +	.name		= "i8042",
> +	.ids		= "PNP0F13",
> +	.ops		= {
> +		.add		= i8042_acpi_aux_add,
> +	},
> +};
> +
> +static int i8042_acpi_init(void)
> +{
> +	int result;
> +
> +	if (i8042_noacpi) {
> +		printk("i8042: ACPI detection disabled\n");
> +		return 0;
> +	}
> +
> +	result = acpi_bus_register_driver(&i8042_acpi_kbd_driver);
> +	if (result < 0)
> +		return result;
> +
> +	if (result == 0) {
> +		acpi_bus_unregister_driver(&i8042_acpi_kbd_driver);
> +		return -ENODEV;
> +	}
> +	i8042_acpi_kbd_registered = 1;
> +
> +	result = acpi_bus_register_driver(&i8042_acpi_aux_driver);
> +	if (result >= 0)
> +		i8042_acpi_aux_registered = 1;
> +	if (result == 0)
> +		i8042_noaux = 1;
> +
> +	return 0;
> +}
> +
> +static void i8042_acpi_exit(void)
> +{
> +	if (i8042_acpi_kbd_registered)
> +		acpi_bus_unregister_driver(&i8042_acpi_kbd_driver);
> +
> +	if (i8042_acpi_aux_registered)
> +		acpi_bus_unregister_driver(&i8042_acpi_aux_driver);
> +}
> +#endif
> +
> +static inline int i8042_platform_init(void)
> +{
> +/*
> + * On ix86 platforms touching the i8042 data register region can do really
> + * bad things. Because of this the region is always reserved on ix86 boxes.
> + *
> + *	if (!request_region(I8042_DATA_REG, 16, "i8042"))
> + *		return -1;
> + */
> +
> +#ifdef CONFIG_ACPI
> +	if (i8042_acpi_init())
> +		return -1;
> +#endif
> +
> +#if defined(__ia64__)
> +        i8042_reset = 1;
> +#endif
> +
> +#if defined(__i386__)
> +	if (dmi_check_system(i8042_dmi_table))
> +		i8042_noloop = 1;
> +#endif
> +
> +	return 0;
> +}
> +
> +static inline void i8042_platform_exit(void)
> +{
> +#ifdef CONFIG_ACPI
> +	i8042_acpi_exit();
> +#endif
> +}
> +
> +#endif /* _I8042_X86IA64IO_H */
> diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> --- a/drivers/input/serio/i8042.c	2004-09-03 01:54:25 -05:00
> +++ b/drivers/input/serio/i8042.c	2004-09-03 01:54:25 -05:00
> @@ -57,6 +57,12 @@
>  module_param_named(noloop, i8042_noloop, bool, 0);
>  MODULE_PARM_DESC(dumbkbd, "Disable the AUX Loopback command while probing for the AUX port");
>  
> +#ifdef CONFIG_ACPI
> +static int i8042_noacpi;
> +module_param_named(noacpi, i8042_noacpi, bool, 0);
> +MODULE_PARM_DESC(noacpi, "Do not use ACPI to detect controller settings");
> +#endif
> +
>  __obsolete_setup("i8042_noaux");
>  __obsolete_setup("i8042_nomux");
>  __obsolete_setup("i8042_unlock");
> diff -Nru a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
> --- a/drivers/input/serio/i8042.h	2004-09-03 01:54:25 -05:00
> +++ b/drivers/input/serio/i8042.h	2004-09-03 01:54:25 -05:00
> @@ -23,6 +23,8 @@
>  #include "i8042-ppcio.h"
>  #elif defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
>  #include "i8042-sparcio.h"
> +#elif defined(CONFIG_X86) || defined(CONFIG_IA64)
> +#include "i8042-x86ia64io.h"
>  #else
>  #include "i8042-io.h"
>  #endif
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

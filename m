Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271594AbTGQWXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271578AbTGQWXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:23:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:646 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271594AbTGQWVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:21:55 -0400
Date: Thu, 17 Jul 2003 15:35:34 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: <torvalds@transmeta.com>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make CONFIG_ACPI_SLEEP independend on CONFIG_SOFTWARE_SUSPEND
In-Reply-To: <20030717211258.GA10221@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0307171529330.876-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This separates CONFIG_ACPI_SLEEP and CONFIG_SOFTWARE_SUSPEND. That
> should end the user confusion. It also updates obsolete docs, and
> makes code less noisy. Please apply,

Could you please split these patches, as you also appear to change 
behavior in at least part of them. 

More comments below. 

> --- clean/arch/i386/kernel/Makefile	2003-07-06 20:06:50.000000000 +0200
> +++ linux/arch/i386/kernel/Makefile	2003-07-15 17:25:32.000000000 +0200
> @@ -24,7 +24,8 @@
>  obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
>  obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
>  obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
> -obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
> +obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
> +obj-$(CONFIG_PM)		+= suspend_asm.o

Is this backwards? Or perhaps you need both files for CONFIG_PM (since 
{save,restore}_processor_state() is defined in suspend.o)

> --- clean/arch/i386/kernel/suspend_asm.S	2003-05-27 13:42:29.000000000 +0200
> +++ linux/arch/i386/kernel/suspend_asm.S	2003-07-15 17:25:55.000000000 +0200
> @@ -32,6 +32,7 @@
>  saved_context_eflags:
>  	.long	0
>  
> +#ifdef CONFIG_SOFTWARE_SUSPEND
>  	.text
>  
>  ENTRY(do_magic)
> @@ -117,4 +118,4 @@
>  loop2:
>         .quad 0
>         .previous
> -	
> \ No newline at end of file
> +#endif
> \ No newline at end of file

Mind adding a newline here? :) 

> --- clean/drivers/pcmcia/yenta_socket.c	2003-07-14 22:12:19.000000000 +0200
> +++ linux/drivers/pcmcia/yenta_socket.c	2003-07-14 22:18:32.000000000 +0200
> @@ -899,7 +899,10 @@
>  
>  static int yenta_dev_suspend (struct pci_dev *dev, u32 state)
>  {
> -	return pcmcia_socket_dev_suspend(&dev->dev, state, 0);
> +	/* FIXME: We should really let devices to act on *all* levels :-(.
> +	   If you put something else than SUSPEND_SAVE_STATE,
> +	   pcmcia_socket_dev_suspend() will simply do nothing due to its check. */
> +	return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
>  }

This should go to the maintainer (Russell?) 

> --- clean/include/linux/suspend.h	2003-03-06 23:26:14.000000000 +0100
> +++ linux/include/linux/suspend.h	2003-07-15 17:18:03.000000000 +0200
> @@ -55,10 +55,6 @@
>  
>  extern int register_suspend_notifier(struct notifier_block *);
>  extern int unregister_suspend_notifier(struct notifier_block *);
> -extern void refrigerator(unsigned long);
> -
> -extern int freeze_processes(void);
> -extern void thaw_processes(void);
>  
>  extern unsigned int nr_copy_pages __nosavedata;
>  extern suspend_pagedir_t *pagedir_nosave __nosavedata;
> @@ -75,16 +71,26 @@
>  extern void do_suspend_lowlevel(int resume);
>  extern void do_suspend_lowlevel_s4bios(int resume);
>  
> +#ifndef CONFIG_PM
> +#error Bad config
> +#endif

Perhaps you could be a little more helpful with this error message..

> +#ifdef CONFIG_PM
> +extern void refrigerator(unsigned long);
> +extern int freeze_processes(void);
> +extern void thaw_processes(void);
> +#else

Do these even need to be exported? 

> --- clean/kernel/suspend.c	2003-07-11 21:38:49.000000000 +0200
> +++ linux/kernel/suspend.c	2003-07-16 12:36:17.000000000 +0200

> -#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
> +#define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */

This is a behavioral change. 

>  	read_unlock(&tasklist_lock);
> +	schedule();
>  	printk( " done\n" );
>  	MDELAY(500);
>  }

So is this. 

>  EXPORT_SYMBOL(software_suspend);
>  EXPORT_SYMBOL(software_suspend_enabled);
> +#endif
>  EXPORT_SYMBOL(refrigerator);

These probably don't need to be exported to modules, but that's another 
patch. :) 


	-pat


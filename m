Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbSJVKX7>; Tue, 22 Oct 2002 06:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262379AbSJVKX7>; Tue, 22 Oct 2002 06:23:59 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:48610 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262370AbSJVKXz>;
	Tue, 22 Oct 2002 06:23:55 -0400
Date: Tue, 22 Oct 2002 12:29:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][RFC] add support for PC-9800 architecture (11/26) input
Message-ID: <20021022122953.A21346@ucw.cz>
References: <20021017204002.A1211@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021017204002.A1211@precia.cinet.co.jp>; from tomita@cinet.co.jp on Thu, Oct 17, 2002 at 08:40:02PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 08:40:02PM +0900, Osamu Tomita wrote:
> This is part 11/26 of patchset for add support NEC PC-9800 architecture,
> against 2.5.43.
> 
> Summary:
>  input modules
>   - add new driver for PC-9800 standard keyboard and mouse.

Before I'll think of merging this, it has to be seriously cleaned up.
Comments below.

(Summary: use your own SERIO_TYPE for the PC-98 keyboard, remove dead
code and definitions, fix naming, make as little #ifdefs as possible,
and maybe you can put the PC-98 keyboard code into xtkbd.c (in which
case you may get away with SERIO_XT).

>  input.h changes are temporally hack.
>  I'll remove this hack using propery keycode.
>  To do this, I need "kbd" utility that can make keymap even if keycode > 127.

Fix the 'kbd' package first, then. No way I'm going to merge the patches
to input.h.

> +static unsigned char atkbd_set2_keycode[512] = {
> +	  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 43, 14, 15,
> +	 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32,
> +	 33, 34, 35, 36, 37, 38, 39, 40, 84, 44, 45, 46, 47, 48, 49, 50,
> +	 51, 52, 53,181, 57,184,109,104,110,111,103,105,106,108,102,107,
> +	 74, 98, 71, 72, 73, 55, 75, 76, 77, 78, 79, 80, 81,117, 82,124,
> +	 83,185, 87, 88, 85, 89, 90,  0,  0,  0,  0,  0,  0,  0,102,  0,
> +	 99,133, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68,  0,  0,  0,  0,
> +	 42, 58,190, 56, 29

This either is AT keyboard set2 keycode table or it is not. And looking
at the numbers, it obviously is not. It might be something like set1 ...?
So, call it the right name then!

Same applies for all the other identifiers - if it is not AT keyboard,
don't call it ATKBD.

You may as well be able to extend xtkbd.c instead for your use - it's
much more similar to the PC-98 keyboard than atkbd.c.

> +#define ATKBD_KEY_UNKNOWN	  0
> +#define ATKBD_KEY_BAT		251
> +#define ATKBD_KEY_EMUL0		252
> +#define ATKBD_KEY_EMUL1		253
> +#define ATKBD_KEY_RELEASE	254
> +#define ATKBD_KEY_NULL		255

Where are you using these?

> +/*
> + * atkbd_cleanup() restores the keyboard state so that BIOS is happy after a
> + * reboot.
> + */
> +
> +static void atkbd_cleanup(struct serio *serio)
> +{
> +}

Why do you define the function at all?

> +/*
> + * atkbd_connect() is called when the serio module finds and interface
> + * that isn't handled yet by an appropriate device driver. We check if
> + * there is an AT keyboard out there and if yes, we register ourselves
> + * to the input module.
> + */
> +
> +static void atkbd_connect(struct serio *serio, struct serio_dev *dev)
> +{
> +	struct atkbd *atkbd;
> +	int i;
> +
> +	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
> +		(((serio->type & SERIO_TYPE) != SERIO_RS232) || (serio->type & SERIO_PROTO) != SERIO_PS2SER))
> +		        return;

Gee, this just doesn't make sense at all here!

> diff -urN linux/drivers/input/mouse/logibm.c linux98/drivers/input/mouse/logibm.c
> --- linux/drivers/input/mouse/logibm.c	Sat Oct 12 13:22:08 2002
> +++ linux98/drivers/input/mouse/logibm.c	Sat Oct 12 17:40:15 2002
> @@ -38,6 +38,7 @@
>  #include <asm/io.h>
>  #include <asm/irq.h>
>  
> +#include <linux/config.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/ioport.h>
> @@ -48,6 +49,7 @@
>  MODULE_DESCRIPTION("Logitech busmouse driver");
>  MODULE_LICENSE("GPL");
>  
> +#ifndef CONFIG_LOGIBUSMOUSE_PC9800
>  #define	LOGIBM_BASE		0x23c
>  #define	LOGIBM_EXTENT		4
>  
> @@ -55,6 +57,15 @@
>  #define	LOGIBM_SIGNATURE_PORT	LOGIBM_BASE + 1
>  #define	LOGIBM_CONTROL_PORT	LOGIBM_BASE + 2
>  #define	LOGIBM_CONFIG_PORT	LOGIBM_BASE + 3
> +#else /* CONFIG_LOGIBUSMOUSE_PC9800 */
> +#define	LOGIBM_BASE		0x7fd9
> +#define	LOGIBM_DATA_PORT	LOGIBM_BASE + 0
> +/*	LOGIBM_SIGNATURE_PORT	does not exist */
> +#define	LOGIBM_CONTROL_PORT	LOGIBM_BASE + 4
> +/*	LOGIBM_INTERRUPT_PORT	does not exist */
> +#define	LOGIBM_CONFIG_PORT	LOGIBM_BASE + 6
> +#define	LOGIBM_EXTENT		(-7)
> +#endif /* !CONFIG_LOGIBUSMOUSE_PC9800 */

Same comments as Russell had for the serial driver.

> diff -urN linux/drivers/input/serio/i8042-98.c linux98/drivers/input/serio/i8042-98.c
> --- linux/drivers/input/serio/i8042-98.c	Thu Jan  1 09:00:00 1970
> +++ linux98/drivers/input/serio/i8042-98.c	Thu Oct 17 16:54:05 2002
> @@ -0,0 +1,346 @@
> +/*
> + *  NEC PC-9801 keyboard controller driver for Linux
> + *
> + *  Copyright (c) 1999-2002 Vojtech Pavlik
> + *  Modify for NEC PC-9801 by Osamu Tomita <tomita@cinet.co.jp>
> + */
> +
> +struct i8042_values {
> +	int irq;
> +	unsigned char disable;
> +	unsigned char irqen;
> +	unsigned char exists;
> +	signed char mux;
> +	unsigned char *name;
> +	unsigned char *phys;
> +};

Don't call it i8042, when it ain't no i8042 ... again. 

> +static int i8042_wait_write(void)
> +{
> +	outb_p(0x00, 0x5f);
> +	outb_p(0x00, 0x5f);
> +	outb_p(0x00, 0x5f);
> +	outb_p(0x00, 0x5f);
> +	outb_p(0x00, 0x5f);
> +	outb_p(0x00, 0x5f);
> +	outb_p(0x00, 0x5f);
> +	return 0;
> +}

This doesn't look very good, either.

> +static int __init i8042_controller_init(void)
> +{
> +
> +/*
> + * Test the i8042. We need to know if it thinks it's working correctly
> + * before doing anything else.
> + */
> +
> +	i8042_flush();
> +
> +	i8042_initial_ctr = i8042_ctr;

This is completely useless.

> +
> +/*
> + * Disable the keyboard interface and interrupt. 
> + */
> +
> +	i8042_ctr |= I8042_CTR_KBDDIS;
> +	i8042_ctr &= ~I8042_CTR_KBDINT;
> +
> +/*
> + * Set nontranslated mode for the kbd interface if requested by an option.
> + * After this the kbd interface becomes a simple serial in/out, like the aux
> + * interface is. We don't do this by default, since it can confuse notebook
> + * BIOSes.
> + */
> +
> +	i8042_ctr &= ~I8042_CTR_XLATE;	/* i8042_direct = 1; */

As is all this, when you don't ever set the CTR ... ?
I assume the chip doesn't have a CTR at all?

> + * Here we try to reset everything back to a state in which the BIOS will be
> + * able to talk to the hardware when rebooting.
> + */
> +
> +void i8042_controller_cleanup(void)
> +{
> +	i8042_flush();
> +
> +/*
> + * Reset anything that is connected to the ports.
> + */
> +
> +	if (i8042_kbd_values.exists)
> +		serio_cleanup(&i8042_kbd_port);

Why?

> +/*
> + * Restore the original control register setting.
> + */
> +
> +	i8042_ctr = i8042_initial_ctr;
> +
> +}

Oh, my.

> +static int i8042_notify_sys(struct notifier_block *this, unsigned long code,
> +        		    void *unused)
> +{
> +        if (code==SYS_DOWN || code==SYS_HALT) 
> +        	i8042_controller_cleanup();
> +        return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block i8042_notifier=
> +{
> +        i8042_notify_sys,
> +        NULL,
> +        0
> +};

Again, completely unnecessary.


> +	if (i8042_platform_init())
> +		return -EBUSY;

platform_init ... ?!?!? You expect this to run on something else than a pc-98?

> diff -urN linux/drivers/input/serio/i8042-98io.h linux98/drivers/input/serio/i8042-98io.h
> --- linux/drivers/input/serio/i8042-98io.h	Thu Jan  1 09:00:00 1970
> +++ linux98/drivers/input/serio/i8042-98io.h	Sun Oct 13 13:21:58 2002
> @@ -0,0 +1,74 @@
> +#ifndef _I8042_IO_H
> +#define _I8042_IO_H
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
> +#define I8042_KBD_PHYS_DESC "isa0041/serio0"
> +#define I8042_AUX_PHYS_DESC "isa0041/serio1"
> +#define I8042_MUX_PHYS_DESC "isa0041/serio%d"

You're not using these. Why are you defining them. Ahh, cut'n'paste ...

> +
> +/*
> + * IRQs.
> + */
> +
> +#define I8042_KBD_IRQ	1
> +#define I8042_AUX_IRQ	0	/* nothing */

Cool. We don't have an AUX port, but we keep the definitions.

> diff -urN linux/drivers/input/serio/i8042.h linux98/drivers/input/serio/i8042.h
> --- linux/drivers/input/serio/i8042.h	Sat Oct 12 13:22:17 2002
> +++ linux98/drivers/input/serio/i8042.h	Sun Oct 13 13:30:09 2002
> @@ -17,6 +17,8 @@
>  #include "i8042-ppcio.h"
>  #elif defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
>  #include "i8042-sparcio.h"
> +#elif defined(CONFIG_PC9800)
> +#include "i8042-98io.h"
>  #else
>  #include "i8042-io.h"
>  #endif

Why are you changing i8042.h, when you don't need it at all?

> diff -urN linux/include/linux/input.h linux98/include/linux/input.h
> --- linux/include/linux/input.h	Sat Oct 12 13:22:06 2002
> +++ linux98/include/linux/input.h	Sat Oct 12 14:18:54 2002
> @@ -9,6 +9,7 @@
>   * the Free Software Foundation.
>   */
>  
> +#include <linux/config.h>
>  #ifdef __KERNEL__
>  #include <linux/time.h>
>  #include <linux/list.h>
> @@ -134,7 +135,11 @@
>  #define KEY_LEFTBRACE		26
>  #define KEY_RIGHTBRACE		27
>  #define KEY_ENTER		28
> +#ifndef CONFIG_PC9800
>  #define KEY_LEFTCTRL		29
> +#else
> +#define KEY_LEFTCTRL		116
> +#endif

No way are these ever going to change depending on the architecture.
They are defined to be constant. I don't like variable constants.

-- 
Vojtech Pavlik
SuSE Labs

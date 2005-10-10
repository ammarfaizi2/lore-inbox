Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVJJFK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVJJFK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 01:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVJJFK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 01:10:26 -0400
Received: from relay.rost.ru ([80.254.111.11]:22743 "EHLO smtp.rost.ru")
	by vger.kernel.org with ESMTP id S932347AbVJJFKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 01:10:25 -0400
Date: Mon, 10 Oct 2005 09:10:16 +0400
To: Stefan Lucke <stefan@lucke.in-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: touchkit PS/2 touchscreen driver
Message-ID: <20051010051016.GI32628@pazke>
Mail-Followup-To: Stefan Lucke <stefan@lucke.in-berlin.de>,
	linux-kernel@vger.kernel.org
References: <200510090926.24426.stefan@lucke.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510090926.24426.stefan@lucke.in-berlin.de>
X-Uname: Linux 2.6.9-1.667 i686
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 282, 10 09, 2005 at 09:26:24AM +0200, Stefan Lucke wrote:
> Hi,
> 
> based on the touchkit USB and livebook PS/2 touchscreen driver,
> I made a driver for the touchkit PS/2 version. The work is based upon
> kernel 2.6.13.2 .
> 
> The egalax touchsreen controller (PS/2 or USB version) is used
> in this 7" device:
> http://www.cartft.com/catalog/il/449
> 
> Currently I'm using the PS/2 version in a DirectFB enviroment.
> http://www.directfb.org/
> http://mail.directfb.org/pipermail/directfb-dev/2005-September/000705.html
> http://mail.directfb.org/pipermail/directfb-dev/2005-September/000706.html
> 
> 
> Could you please have a look at it and tell my your comments on
> what would be additional required to get it included into kernel tree.

Hi Stefan,

first if you want people to review your code please don't send such small
patches in compressed form. In general patch looks good, but see comments
below.

> diff -uprN linux-2.6.13.2.vanilla/drivers/input/mouse/Makefile linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/Makefile
> --- linux-2.6.13.2.vanilla/drivers/input/mouse/Makefile	2005-09-17 03:02:12.000000000 +0200
> +++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/Makefile	2005-09-23 18:09:08.000000000 +0200
> @@ -15,4 +15,4 @@ obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
>  obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
>  obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
>  
> -psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o
> +psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o touchkit_ps2.o
> diff -uprN linux-2.6.13.2.vanilla/drivers/input/mouse/psmouse-base.c linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/psmouse-base.c
> --- linux-2.6.13.2.vanilla/drivers/input/mouse/psmouse-base.c	2005-09-17 03:02:12.000000000 +0200
> +++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/psmouse-base.c	2005-09-23 19:10:42.000000000 +0200
> @@ -25,6 +25,7 @@
>  #include "logips2pp.h"
>  #include "alps.h"
>  #include "lifebook.h"
> +#include "touchkit_ps2.h"
>  
>  #define DRIVER_DESC	"PS/2 mouse driver"
>  
> @@ -456,6 +457,13 @@ static int psmouse_extensions(struct psm
>  		}
>  	}
>  
> +	if (touchkit_ps2_detect(psmouse, set_properties) == 0) {
> +		if (max_proto > PSMOUSE_IMEX) {
> +			if (!set_properties || touchkit_ps2_init(psmouse) == 0)
> +				return PSMOUSE_TOUCHKIT_PS2;
> +		}
> +	}
> +
>  /*
>   * Try Kensington ThinkingMouse (we try first, because synaptics probe
>   * upsets the thinkingmouse).
> @@ -518,6 +526,10 @@ static int psmouse_extensions(struct psm
>  
>  	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse, set_properties) == 0)
>  		return PSMOUSE_IMPS;
> +#if 0
> +	if (max_proto >= PSMOUSE_TOUCHKIT_PS2 && touchkit_ps2_detect(psmouse, set_properties) == 0)
> +		return PSMOUSE_TOUCHKIT_PS2;
> +#endif                

Hmm, is this part really needed ?

>  
>  /*
>   * Okay, all failed, we have a standard mouse here. The number of the buttons
> @@ -600,6 +612,13 @@ static struct psmouse_protocol psmouse_p
>  		.init		= lifebook_init,
>  	},
>  	{
> +		.type		= PSMOUSE_TOUCHKIT_PS2,
> +		.name		= "touchkitPS/2",
> +		.alias		= "touchkit",
> +		.detect		= touchkit_ps2_detect,
> +		.init		= touchkit_ps2_init,
> +	},
> +	{
>  		.type		= PSMOUSE_AUTO,
>  		.name		= "auto",
>  		.alias		= "any",
> diff -uprN linux-2.6.13.2.vanilla/drivers/input/mouse/psmouse.h linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/psmouse.h
> --- linux-2.6.13.2.vanilla/drivers/input/mouse/psmouse.h	2005-09-17 03:02:12.000000000 +0200
> +++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/psmouse.h	2005-09-23 17:46:38.000000000 +0200
> @@ -78,6 +78,7 @@ enum psmouse_type {
>  	PSMOUSE_SYNAPTICS,
>  	PSMOUSE_ALPS,
>  	PSMOUSE_LIFEBOOK,
> +	PSMOUSE_TOUCHKIT_PS2,
>  	PSMOUSE_AUTO		/* This one should always be last */
>  };
>  
> diff -uprN linux-2.6.13.2.vanilla/drivers/input/mouse/touchkit_ps2.c linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/touchkit_ps2.c
> --- linux-2.6.13.2.vanilla/drivers/input/mouse/touchkit_ps2.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/touchkit_ps2.c	2005-09-25 12:23:58.000000000 +0200
> @@ -0,0 +1,180 @@
> +/* ----------------------------------------------------------------------------
> + * touchkit_ps2.c  --  Driver for eGalax TouchKit PS/2 Touchscreens
> + *
> + * Copyright (C) 2005 by Stefan Lucke
> + * Copyright (C) 2004 by Daniel Ritz
> + * Copyright (C) by Todd E. Johnson (mtouchusb.c)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * Based upon touchkitusb.c
> + *
> + * Vendor documentation is available in support section of:
> + * http://www.egalax.com.tw/
> + *
> + */
> +
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include <linux/input.h>
> +#include <linux/serio.h>
> +#include <linux/libps2.h>
> +#include <linux/dmi.h>
> +
> +#include "psmouse.h"
> +#include "touchkit_ps2.h"
> +
> +
> +#if !defined(DEBUG) && defined(CONFIG_USB_DEBUG)
> +#define DEBUG
> +#endif

Unused ?

> +
> +#define TOUCHKIT_MIN_XC			0x0
> +#define TOUCHKIT_MAX_XC			0x07ff
> +#define TOUCHKIT_XC_FUZZ		0x0
> +#define TOUCHKIT_XC_FLAT		0x0
> +#define TOUCHKIT_MIN_YC			0x0
> +#define TOUCHKIT_MAX_YC			0x07ff
> +#define TOUCHKIT_YC_FUZZ		0x0
> +#define TOUCHKIT_YC_FLAT		0x0
> +#define TOUCHKIT_REPORT_DATA_SIZE	8
> +
> +#define TOUCHKIT_DOWN			0x01
> +#define TOUCHKIT_POINT_TOUCH		0x81
> +#define TOUCHKIT_POINT_NOTOUCH		0x80
> +
> +#define TOUCHKIT_GET_TOUCHED(dat)	((((dat)[0]) & TOUCHKIT_DOWN) ? 1 : 0)
> +#define TOUCHKIT_GET_X(dat)		(((dat)[1] << 7) | (dat)[2])
> +#define TOUCHKIT_GET_Y(dat)		(((dat)[3] << 7) | (dat)[4])
> +
> +#define DRIVER_VERSION			"v0.1"
> +#define DRIVER_AUTHOR			"Stefan Lucke <stefan@lucke.in-berlin.de>"
> +#define DRIVER_DESC			"eGalax TouchKit PS/2 Touchscreen Driver"
> +
> +static int xyswap = 0;
> +module_param(xyswap, bool, 0644);
> +MODULE_PARM_DESC(xyswap, "If set X and Y axes are swapped.");
> +
> +static int  xinvert = 0;
> +module_param(xinvert, bool, 0644);
> +MODULE_PARM_DESC(xinvert, "Invert direction of x axis.");
> +
> +static int  yinvert = 0;
> +module_param(yinvert, bool, 0644);
> +MODULE_PARM_DESC(yinvert, "Invert direction of y axis.");
> +
> +static int  xfuzz = 0;
> +module_param(xfuzz, uint, 0644);
> +MODULE_PARM_DESC(xinvert, "Fuzz value for x axis.");
> +
> +static int  yfuzz = 0;
> +module_param(yfuzz, uint, 0644);
> +MODULE_PARM_DESC(yfuzz, "Fuzz value for y axis.");
> +
> +static int  smartpad = 0;
> +module_param(smartpad, bool, 0644);
> +MODULE_PARM_DESC(smartpad, "Act as a smartpad device.");
> +
> +static int  mouse = 0;
> +module_param(mouse, bool, 0644);
> +MODULE_PARM_DESC(mouse, "Report mouse button");
> +
> +static psmouse_ret_t touchkit_ps2_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
> +{
> +		unsigned char 		*packet = psmouse->packet;
> +		struct input_dev 	*dev = &psmouse->dev;
> +		int 			x,y;

Strange formating, why two tabs ?

> +
> +	if (psmouse->pktcnt != 5)
> +		return PSMOUSE_GOOD_DATA;
> +
> +	input_regs(dev, regs);
> +
> +	if (xyswap) {
> +		y = TOUCHKIT_GET_X(packet);
> +		x = TOUCHKIT_GET_Y(packet);
> +	} else {
> +		x = TOUCHKIT_GET_X(packet);
> +		y = TOUCHKIT_GET_Y(packet);
> +	}
> +
> +	y = (yinvert) ? TOUCHKIT_MAX_YC - y : y;
> +	x = (xinvert) ? TOUCHKIT_MAX_XC - x : x;
> +
> +	input_report_key(dev,
> +			 (mouse) ? BTN_MOUSE : BTN_TOUCH,
> +			 TOUCHKIT_GET_TOUCHED(packet));
> +
> +	if (smartpad)
> +		input_report_key(dev, BTN_TOOL_FINGER, 1);
> +
> +	input_report_abs(dev, ABS_X, x);
> +	input_report_abs(dev, ABS_Y, y);
> +
> +	input_sync(dev);
> +
> +	return PSMOUSE_FULL_PACKET;
> +}
> +
> +int touchkit_ps2_detect(struct psmouse *psmouse, int set_properties)
> +{
> +		unsigned char	param[3];

Two tabs again.

> +
> +	if (set_properties) {
> +		psmouse->vendor = "eGalax";
> +		psmouse->name = "Touchscreen";
> +	}

AFAIK this should be done after device is really detected.

> +
> +	param[0] = 1;
> +	param[1] = 'A';
> +
> +	if (ps2_command(&psmouse->ps2dev, param, (2<<12)|(3<<8)|0x0A) == 0 &&

Can you add descriptive #define for (2<<12)|(3<<8)|0x0A) ? Bare magic
numbers are ugly.

> +	    param[0] == 0x0A && param[1] == 0x01 && param[2] == 'A'){
> +		printk(KERN_INFO "touchkit_ps2: device detected\n");
> +		return 0;
> +	}
> +        return -1;

Use single tab not spaces.

> +}
> +
> +int touchkit_ps2_init(struct psmouse *psmouse)
> +{
> +	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
> +
> +	set_bit((mouse) ? BTN_MOUSE : BTN_TOUCH,psmouse->dev.keybit);
> +	if (smartpad)
> +		set_bit(BTN_TOOL_FINGER,psmouse->dev.keybit);
> +
> +	psmouse->dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
> +
> +        /* Used to Scale Compensated Data */

Same here.

> +	psmouse->dev.absmin[ABS_X] = TOUCHKIT_MIN_XC;
> +	psmouse->dev.absmax[ABS_X] = TOUCHKIT_MAX_XC;
> +	psmouse->dev.absfuzz[ABS_X] = xfuzz;
> +	psmouse->dev.absflat[ABS_X] = TOUCHKIT_XC_FLAT;
> +	psmouse->dev.absmin[ABS_Y] = TOUCHKIT_MIN_YC;
> +	psmouse->dev.absmax[ABS_Y] = TOUCHKIT_MAX_YC;
> +	psmouse->dev.absfuzz[ABS_Y] = yfuzz;
> +	psmouse->dev.absflat[ABS_Y] = TOUCHKIT_YC_FLAT;
> +
> +	input_set_abs_params(&psmouse->dev, ABS_X, 0, 0x07ff, xfuzz, 0);
> +	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 0x07ff, yfuzz, 0);
> +
> +	psmouse->protocol_handler = touchkit_ps2_process_byte;
> +	psmouse->pktsize = 5;
> +
> +	return 0;
> +}
> diff -uprN linux-2.6.13.2.vanilla/drivers/input/mouse/touchkit_ps2.h linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/touchkit_ps2.h
> --- linux-2.6.13.2.vanilla/drivers/input/mouse/touchkit_ps2.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/touchkit_ps2.h	2005-09-24 12:34:23.000000000 +0200
> @@ -0,0 +1,18 @@
> +/* ----------------------------------------------------------------------------
> + * touchkit_ps2.h  --  Driver for eGalax TouchKit PS/2 Touchscreens
> + *
> + * Copyright (C) 2005 by Stefan Lucke
> + * Copyright (c) 2005 Vojtech Pavlik
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#ifndef _TOUCHKIT_PS2_H
> +#define _TOUCHKIT_PS2_H
> +
> +int touchkit_ps2_detect(struct psmouse *psmouse, int set_properties);
> +int touchkit_ps2_init(struct psmouse *psmouse);
> +
> +#endif

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVBONmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVBONmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVBONmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:42:49 -0500
Received: from styx.suse.cz ([82.119.242.94]:65161 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261721AbVBONm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:42:27 -0500
Date: Tue, 15 Feb 2005 14:43:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050215134308.GE7250@ucw.cz>
References: <20050211201013.GA6937@ucw.cz> <1108457880.2843.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108457880.2843.5.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 09:57:59AM +0100, Kenan Esau wrote:
> Am Freitag, den 11.02.2005, 21:10 +0100 schrieb Vojtech Pavlik:

> Here are my changes. I have tested everything on my lifebook B2175 and
> it works fine for me. I have used DMI for probing. Does anyone have an
> Idea what devices we have to add to the DMI-probing?
> 
> Please comment on the code.

> diff -Naur -X dontdiff linux-2.6.11-rc3-vanilla/drivers/input/mouse/lifebook.c linux-2.6.11-rc3-kenan/drivers/input/mouse/lifebook.c
> --- linux-2.6.11-rc3-vanilla/drivers/input/mouse/lifebook.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.11-rc3-kenan/drivers/input/mouse/lifebook.c	2005-02-14 19:09:37.000000000 +0100
> @@ -0,0 +1,150 @@
> +/*
> + * Fujitsu B-series Lifebook PS/2 TouchScreen driver
> + *
> + * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
> + *
> + * Copyright (c) 2005 Kenan Esau <kenan.esau@conan.de>
> + *
> + * TouchScreen detection, absolute mode setting and packet layout is taken from
> + * Harald Hoyer's description of the device.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/serio.h>
> +#include <linux/libps2.h>
> +#include <linux/dmi.h>
> +
> +#include "psmouse.h"
> +#include "lifebook.h"
> +
> +#define LBTOUCH_TOUCHED 0x04
> +#define LBTOUCH_X_HIGH  0x30
> +#define LBTOUCH_Y_HIGH  0xC0
> +#define LBTOUCH_LB      0x01
> +#define LBTOUCH_RB      0x02
> +
> +static int max_y = 937;

This doesn't look correct. I think the correct value here is 1024,
because that's what is the maximum possible value transfered in the
packet. With 937 you can get negative values in your code.

> +static struct dmi_system_id lifebook_dmi_table[] = {
> +	{
> +		.ident = "Fujitsu Siemens Lifebook B-Sereis",
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK B Series"),
> +		},
> +	},
> +	{ }
> +};

This might be a bit too much generic. Are you sure there are no B Series
lifebooks without a touchscreen?

> +static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
> +{
> +	unsigned char *packet = psmouse->packet;
> +	struct input_dev *dev = &psmouse->dev;
> +
> +        unsigned long x = 0;
> +        unsigned long y = 0;
> +        static uint8_t pkt_lst_touch = 0;
> +	static uint8_t pkt_cur_touch = 0;
> +	uint8_t pkt_lb = packet[0] & LBTOUCH_LB;
> +	uint8_t pkt_rb = packet[0] & LBTOUCH_RB;

Tab/space damage here. Do we really need constants for everything? They
don't carry any information value, because we already know what the mask
means from the left side of the assignment. 

Another use for constants is where the value would possibly change,
which again isn't the case with masks.

Also, input_regs() is missing here.

> +        pkt_cur_touch = packet[0] & LBTOUCH_TOUCHED;
> +
> +        if ( psmouse->pktcnt != 3 )
> +                return PSMOUSE_GOOD_DATA;
> +
> +	/* calculate X and Y */
> +	if (pkt_cur_touch) {
> +		x = (packet[1] | ((packet[0] & LBTOUCH_X_HIGH) << 4 ));
> +		y = max_y - 
> +                    (packet[2] | ((packet[0] & LBTOUCH_Y_HIGH) << 2 ));
> +	} else {
> +		x = ((packet[0] & 0x10) ? packet[1]-256 : packet[1]);
> +		y = - ((packet[0] & 0x20) ? packet[2]-256 : packet[2]);
> +	}

This doesn't make sense. As far as I know, there is bit 3 in byte 0
which signifies a relative packet. We don't need to take the decision
how to interpret the axis values based on the touch bit!

> +        input_report_key(dev, BTN_LEFT, pkt_lb);
> +        input_report_key(dev, BTN_RIGHT, pkt_rb);
> +        input_report_key(dev, BTN_TOUCH, pkt_cur_touch);
> +
> +	/* currently touched */
> +	if (pkt_cur_touch) {
> +                input_report_abs(dev, ABS_X, x);
> +                input_report_abs(dev, ABS_Y, y);
> +        }
> +
> +	/* quickpoint move */
> +	if ( !pkt_cur_touch && !pkt_lst_touch  &&  (x || y ) ) {
> +                input_report_rel(dev, REL_X, x);
> +                input_report_rel(dev, REL_Y, y);
> +        }

You don't need to check for x and y being nonzero here.

This looks like a stupid workaround for not using the relative/absolute
bit I refer to above properly.

Also, you can simply merge the reporting and computing of the x/y
values, making the use of the two variables completely unnecessary.

> +	input_sync(dev);
> +
> +        /* save the state for the currently received packet */
> +	pkt_lst_touch = pkt_cur_touch;
> +
> +        return PSMOUSE_FULL_PACKET;
> +}
> +
> +static int lifebook_initialize(struct psmouse *psmouse)
> +{
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> +        unsigned char param;
> +
> +        if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE))
> +		return -1;
> +
> +        if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_BAT))
> +		return -1;

Do we need two resets here? I'd expect RESET_BAT to override completely
everything.

> +
> +        /* 
> +           Enable absolute output -- ps2_command fails always but if
> +           you leave this call out the touchsreen will never send
> +           absolute coordinates
> +        */ 
> +        param = 0x07;
> +        ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);

Have you checked whether really the touchscreen sends a 0xfe error back,
or some other value, or timeout? i8042.debug=1 is your friend here.

> +        psmouse->set_rate(psmouse, psmouse->rate);
> +        psmouse->set_resolution(psmouse, psmouse->resolution);
> +        
> +        if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE))
> +		return -1;
> +
> +        return 0;
> +}
> +
> +static void lifebook_disconnect(struct psmouse *psmouse)
> +{
> +	psmouse_reset(psmouse);
> +}
> +
> +int lifebook_detect(struct psmouse *psmouse, int set_properties)
> +{
> +	if (!dmi_check_system(lifebook_dmi_table))
> +                return -1;
> +
> +	if (set_properties) {
> +		psmouse->vendor = "Fujitsu Lifebook";
> +		psmouse->name = "TouchScreen";
> +                psmouse->dev.evbit[0] = BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
> +                psmouse->dev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
> +                psmouse->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
> +                psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
> +                input_set_abs_params(&psmouse->dev, ABS_X, 130, 885, 0, 0);
> +                input_set_abs_params(&psmouse->dev, ABS_Y, 272, 830, 0, 0);
> +
> +                psmouse->protocol_handler = lifebook_process_byte;
> +                psmouse->disconnect = lifebook_disconnect;
> +                psmouse->reconnect  = lifebook_initialize;
> +                psmouse->initialize = lifebook_initialize;
> +                psmouse->pktsize = 3;
> +	}
> +
> +	return 0;
> +}

The change to the psmouse interface I'm leaving to Dmitry to comment on.

> diff -Naur -X dontdiff linux-2.6.11-rc3-vanilla/drivers/input/mouse/lifebook.h linux-2.6.11-rc3-kenan/drivers/input/mouse/lifebook.h
> --- linux-2.6.11-rc3-vanilla/drivers/input/mouse/lifebook.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.11-rc3-kenan/drivers/input/mouse/lifebook.h	2005-02-14 13:40:19.000000000 +0100
> @@ -0,0 +1,16 @@
> +/*
> + * Fujitsu B-series Lifebook PS/2 TouchScreen driver
> + *
> + * Copyright (c) 2005 Vojtech Pavlik
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#ifndef _LIFEBOOK_H
> +#define _LIFEBOOK_H
> +
> +int lifebook_detect(struct psmouse *psmouse, int set_properties);
> +
> +#endif
> diff -Naur -X dontdiff linux-2.6.11-rc3-vanilla/drivers/input/mouse/Makefile linux-2.6.11-rc3-kenan/drivers/input/mouse/Makefile
> --- linux-2.6.11-rc3-vanilla/drivers/input/mouse/Makefile	2005-02-15 09:33:36.000000000 +0100
> +++ linux-2.6.11-rc3-kenan/drivers/input/mouse/Makefile	2005-02-13 10:46:45.000000000 +0100
> @@ -14,4 +14,4 @@
>  obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
>  obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
>  
> -psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o
> +psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o
> diff -Naur -X dontdiff linux-2.6.11-rc3-vanilla/drivers/input/mouse/psmouse-base.c linux-2.6.11-rc3-kenan/drivers/input/mouse/psmouse-base.c
> --- linux-2.6.11-rc3-vanilla/drivers/input/mouse/psmouse-base.c	2005-02-15 09:33:36.000000000 +0100
> +++ linux-2.6.11-rc3-kenan/drivers/input/mouse/psmouse-base.c	2005-02-15 08:54:45.000000000 +0100
> @@ -24,6 +24,7 @@
>  #include "synaptics.h"
>  #include "logips2pp.h"
>  #include "alps.h"
> +#include "lifebook.h"
>  
>  #define DRIVER_DESC	"PS/2 mouse driver"
>  
> @@ -62,7 +63,7 @@
>  __obsolete_setup("psmouse_resetafter=");
>  __obsolete_setup("psmouse_rate=");
>  
> -static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2" };
> +static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2", "LBPS/2" };
>  
>  /*
>   * psmouse_process_byte() analyzes the PS/2 data stream and reports
> @@ -463,6 +464,9 @@
>  		}
>  	}
>  
> +	if (max_proto > PSMOUSE_IMEX && lifebook_detect(psmouse, set_properties) == 0)
> +		return PSMOUSE_LIFEBOOK;
> +
>  	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
>  		return PSMOUSE_GENPS;
>  
> @@ -565,13 +569,13 @@
>   * psmouse_initialize() initializes the mouse to a sane state.
>   */
>  
> -static void psmouse_initialize(struct psmouse *psmouse)
> +static int psmouse_initialize(struct psmouse *psmouse)
>  {
>  /*
>   * We set the mouse into streaming mode.
>   */
> -
> -	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSTREAM);
> +	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSTREAM))
> +                return -1;
>  
>  /*
>   * We set the mouse report rate, resolution and scaling.
> @@ -580,8 +584,11 @@
>  	if (psmouse_max_proto != PSMOUSE_PS2) {
>  		psmouse->set_rate(psmouse, psmouse->rate);
>  		psmouse->set_resolution(psmouse, psmouse->resolution);
> -		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
> +                if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11))
> +                        return -1;
>  	}
> +
> +        return 0;
>  }
>  
>  /*
> @@ -719,6 +726,7 @@
>  	}
>  
>  	psmouse->rate = psmouse_rate;
> +        psmouse->initialize = psmouse_initialize;
>  	psmouse->resolution = psmouse_resolution;
>  	psmouse->resetafter = psmouse_resetafter;
>  	psmouse->smartscroll = psmouse_smartscroll;
> @@ -747,7 +755,8 @@
>  
>  	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
>  
> -	psmouse_initialize(psmouse);
> +        if (psmouse->initialize(psmouse))
> +                printk(KERN_ERR"input: %s initialization failed\n", psmouse->devname);
>  
>  	if (parent && parent->pt_activate)
>  		parent->pt_activate(parent);
> @@ -804,7 +813,8 @@
>  	 */
>  	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
>  
> -	psmouse_initialize(psmouse);
> +        if (psmouse->initialize(psmouse))
> +                printk(KERN_ERR"input: %s initialization failed\n", psmouse->devname);
>  
>  	if (parent && parent->pt_activate)
>  		parent->pt_activate(parent);
> diff -Naur -X dontdiff linux-2.6.11-rc3-vanilla/drivers/input/mouse/psmouse.h linux-2.6.11-rc3-kenan/drivers/input/mouse/psmouse.h
> --- linux-2.6.11-rc3-vanilla/drivers/input/mouse/psmouse.h	2005-02-15 09:33:36.000000000 +0100
> +++ linux-2.6.11-rc3-kenan/drivers/input/mouse/psmouse.h	2005-02-14 11:44:10.000000000 +0100
> @@ -60,6 +60,7 @@
>  	void (*set_rate)(struct psmouse *psmouse, unsigned int rate);
>  	void (*set_resolution)(struct psmouse *psmouse, unsigned int resolution);
>  
> +        int (*initialize)(struct psmouse *psmouse);
>  	int (*reconnect)(struct psmouse *psmouse);
>  	void (*disconnect)(struct psmouse *psmouse);
>  
> @@ -77,6 +78,7 @@
>  	PSMOUSE_IMEX,
>  	PSMOUSE_SYNAPTICS,
>  	PSMOUSE_ALPS,
> +	PSMOUSE_LIFEBOOK,
>  };
>  
>  int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

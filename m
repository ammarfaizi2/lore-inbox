Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVBORXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVBORXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVBORVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:21:18 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:1767 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261796AbVBORQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:16:28 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050215134308.GE7250@ucw.cz>
References: <20050211201013.GA6937@ucw.cz>
	 <1108457880.2843.5.camel@localhost>  <20050215134308.GE7250@ucw.cz>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 18:15:33 +0100
Message-Id: <1108487733.2843.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 15.02.2005, 14:43 +0100 schrieb Vojtech Pavlik:
> On Tue, Feb 15, 2005 at 09:57:59AM +0100, Kenan Esau wrote:
> > Am Freitag, den 11.02.2005, 21:10 +0100 schrieb Vojtech Pavlik:
> 
> > Here are my changes. I have tested everything on my lifebook B2175 and
> > it works fine for me. I have used DMI for probing. Does anyone have an
> > Idea what devices we have to add to the DMI-probing?
> > 
> > Please comment on the code.
> 
> > diff -Naur -X dontdiff linux-2.6.11-rc3-vanilla/drivers/input/mouse/lifebook.c linux-2.6.11-rc3-kenan/drivers/input/mouse/lifebook.c
> > --- linux-2.6.11-rc3-vanilla/drivers/input/mouse/lifebook.c	1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.11-rc3-kenan/drivers/input/mouse/lifebook.c	2005-02-14 19:09:37.000000000 +0100
> > @@ -0,0 +1,150 @@
> > +/*
> > + * Fujitsu B-series Lifebook PS/2 TouchScreen driver
> > + *
> > + * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
> > + *
> > + * Copyright (c) 2005 Kenan Esau <kenan.esau@conan.de>
> > + *
> > + * TouchScreen detection, absolute mode setting and packet layout is taken from
> > + * Harald Hoyer's description of the device.
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published by
> > + * the Free Software Foundation.
> > + */
> > +
> > +#include <linux/input.h>
> > +#include <linux/serio.h>
> > +#include <linux/libps2.h>
> > +#include <linux/dmi.h>
> > +
> > +#include "psmouse.h"
> > +#include "lifebook.h"
> > +
> > +#define LBTOUCH_TOUCHED 0x04
> > +#define LBTOUCH_X_HIGH  0x30
> > +#define LBTOUCH_Y_HIGH  0xC0
> > +#define LBTOUCH_LB      0x01
> > +#define LBTOUCH_RB      0x02
> > +
> > +static int max_y = 937;
> 
> This doesn't look correct. I think the correct value here is 1024,
> because that's what is the maximum possible value transfered in the
> packet. With 937 you can get negative values in your code.

Since the input_event-structure takes signed values that does not really
matter. But you are right it looks a little bit strange and I will
change it to 1024. It's 937 at the moment since this is the "ideal"
value for my touchscreen where y_max=937. ;-)

> > +static struct dmi_system_id lifebook_dmi_table[] = {
> > +	{
> > +		.ident = "Fujitsu Siemens Lifebook B-Sereis",
> > +		.matches = {
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK B Series"),
> > +		},
> > +	},
> > +	{ }
> > +};
> 
> This might be a bit too much generic. Are you sure there are no B Series
> lifebooks without a touchscreen?
> 
> > +static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
> > +{
> > +	unsigned char *packet = psmouse->packet;
> > +	struct input_dev *dev = &psmouse->dev;
> > +
> > +        unsigned long x = 0;
> > +        unsigned long y = 0;
> > +        static uint8_t pkt_lst_touch = 0;
> > +	static uint8_t pkt_cur_touch = 0;
> > +	uint8_t pkt_lb = packet[0] & LBTOUCH_LB;
> > +	uint8_t pkt_rb = packet[0] & LBTOUCH_RB;
> 
> Tab/space damage here. Do we really need constants for everything? They
> don't carry any information value, because we already know what the mask
> means from the left side of the assignment. 
> 
> Another use for constants is where the value would possibly change,
> which again isn't the case with masks.

I put the constants there since I think it is more readable but if you
don't like them I'll throw em out.

> Also, input_regs() is missing here.
> 
> > +        pkt_cur_touch = packet[0] & LBTOUCH_TOUCHED;
> > +
> > +        if ( psmouse->pktcnt != 3 )
> > +                return PSMOUSE_GOOD_DATA;
> > +
> > +	/* calculate X and Y */
> > +	if (pkt_cur_touch) {
> > +		x = (packet[1] | ((packet[0] & LBTOUCH_X_HIGH) << 4 ));
> > +		y = max_y - 
> > +                    (packet[2] | ((packet[0] & LBTOUCH_Y_HIGH) << 2 ));
> > +	} else {
> > +		x = ((packet[0] & 0x10) ? packet[1]-256 : packet[1]);
> > +		y = - ((packet[0] & 0x20) ? packet[2]-256 : packet[2]);
> > +	}
> 
> This doesn't make sense. As far as I know, there is bit 3 in byte 0
> which signifies a relative packet. We don't need to take the decision
> how to interpret the axis values based on the touch bit!

I will check this.

> 
> > +        input_report_key(dev, BTN_LEFT, pkt_lb);
> > +        input_report_key(dev, BTN_RIGHT, pkt_rb);
> > +        input_report_key(dev, BTN_TOUCH, pkt_cur_touch);
> > +
> > +	/* currently touched */
> > +	if (pkt_cur_touch) {
> > +                input_report_abs(dev, ABS_X, x);
> > +                input_report_abs(dev, ABS_Y, y);
> > +        }
> > +
> > +	/* quickpoint move */
> > +	if ( !pkt_cur_touch && !pkt_lst_touch  &&  (x || y ) ) {
> > +                input_report_rel(dev, REL_X, x);
> > +                input_report_rel(dev, REL_Y, y);
> > +        }
> 
> You don't need to check for x and y being nonzero here.
> 
> This looks like a stupid workaround for not using the relative/absolute
> bit I refer to above properly.
> 
> Also, you can simply merge the reporting and computing of the x/y
> values, making the use of the two variables completely unnecessary.

OK

> 
> > +	input_sync(dev);
> > +
> > +        /* save the state for the currently received packet */
> > +	pkt_lst_touch = pkt_cur_touch;
> > +
> > +        return PSMOUSE_FULL_PACKET;
> > +}
> > +
> > +static int lifebook_initialize(struct psmouse *psmouse)
> > +{
> > +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> > +        unsigned char param;
> > +
> > +        if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE))
> > +		return -1;
> > +
> > +        if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_BAT))
> > +		return -1;
> 
> Do we need two resets here? I'd expect RESET_BAT to override completely
> everything.

It's quite a while ago when I developed the init-sequence of the
touchscreen. But if I remember correctly it needed the DISABLE and the
RESET_BAT.

> 
> > +
> > +        /* 
> > +           Enable absolute output -- ps2_command fails always but if
> > +           you leave this call out the touchsreen will never send
> > +           absolute coordinates
> > +        */ 
> > +        param = 0x07;
> > +        ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
> 
> Have you checked whether really the touchscreen sends a 0xfe error back,
> or some other value, or timeout? i8042.debug=1 is your friend here.

OK -- that's a good hint

[...]


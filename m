Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265280AbSJRRhW>; Fri, 18 Oct 2002 13:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSJRRgg>; Fri, 18 Oct 2002 13:36:36 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:45047 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id <S265225AbSJRRfg>; Fri, 18 Oct 2002 13:35:36 -0400
From: "Christopher Hoover" <ch@murgatroid.com>
To: "'Vojtech Pavlik'" <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.43: Fix for Logitech Wheel Mouse
Date: Fri, 18 Oct 2002 10:41:25 -0700
Organization: Murgatroid.Com
Message-ID: <004401c276cd$95d3bc90$8100000a@bergamot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20021018110625.A26788@ucw.cz>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, it unfortunately is not a proper fix. I'll have to analyze the
> problem some more.

Would you say more?  I looked at XFree86 sources and it seemed that the
ImPS/2 protocol best matched what my mouse was sending.

What about a module param/setup arg to force the mouse protocol?


> Can you send me the output of /proc/bus/input/devices on your system
> (without your fix, preferably)?

With*out* the patch:

I: Bus=0011 Vendor=0002 Product=0002 Version=0035
N: Name="PS2++ Logitech Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event0 
B: EV=7 
B: KEY=70000 0 0 0 0 0 0 0 0 
B: REL=3 

I: Bus=0011 Vendor=0001 Product=0002 Version=ab02
N: Name="AT Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event1 
B: EV=120003 
B: KEY=4 2000000 8061f9 fbc9d621 efdfffdf ffefffff ffffffff fffffffe 
B: LED=7 


With the patch:

I: Bus=0011 Vendor=0002 Product=0005 Version=0035
N: Name="ImPS/2 Logitech Wheel Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event0 
B: EV=7 
B: KEY=70000 0 0 0 0 0 0 0 0 
B: REL=103 

I: Bus=0011 Vendor=0001 Product=0002 Version=ab02
N: Name="AT Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event1 
B: EV=120003 
B: KEY=4 2000000 8061f9 fbc9d621 efdfffdf ffefffff ffffffff fffffffe 
B: LED=7 




-----Original Message-----
From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
Sent: Friday, October 18, 2002 2:06 AM
To: Christopher Hoover
Cc: linux-kernel@vger.kernel.org; vojtech@suse.cz
Subject: Re: [PATCH] 2.5.43: Fix for Logitech Wheel Mouse


On Thu, Oct 17, 2002 at 11:20:14PM -0700, Christopher Hoover wrote:
> The wheel on my Logitech mouse doesn't work under the input layer.
> The mouse was originally recognized as:
> 
>   input: PS2++ Logitech Mouse on isa0060/serio1
> 
> In this mode, the driver also emits (just once?):
> 
>   psmouse.c: Received PS2++ packet #0, but don't know how to handle.
> 
> 
> The following patch simply swaps the order of detection of Logitech PS
> 2++ and Intellimouse protocols.  Now my mouse is recognized as:
> 
>   input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
> 
> And the wheel works properly in this mode.

Can you send me the output of /proc/bus/input/devices on your system
(without your fix, preferably)?

I'd like to know whether the driver thinks the mouse has a wheel or not.

> -ch
> ch@murgatroid.com
> ch@hpl.hp.com
> 
> 
> PATCH FOLLOWS
> --- linux-2.5.43/drivers/input/mouse/psmouse.c.orig	Tue Oct 15
20:27:22 2002
> +++ linux-2.5.43/drivers/input/mouse/psmouse.c	Thu Oct 17
22:45:05 2002
> @@ -378,40 +378,6 @@
>  				}
>  
>  /*
> - * Do Logitech PS2++ / PS2T++ magic init.
> - */
> -
> -			if (psmouse->model == 97) { /* TouchPad 3 */
> -
> -				set_bit(REL_WHEEL, psmouse->dev.relbit);
> -				set_bit(REL_HWHEEL,
psmouse->dev.relbit);
> -
> -				param[0] = 0x11; param[1] = 0x04;
param[2] = 0x68; /* Unprotect RAM */
> -				psmouse_command(psmouse, param, 0x30d1);
> -				param[0] = 0x11; param[1] = 0x05;
param[2] = 0x0b; /* Enable features */
> -				psmouse_command(psmouse, param, 0x30d1);
> -				param[0] = 0x11; param[1] = 0x09;
param[2] = 0xc3; /* Enable PS2++ */
> -				psmouse_command(psmouse, param, 0x30d1);
> -
> -				param[0] = 0;
> -				if (!psmouse_command(psmouse, param,
0x13d1) &&
> -					param[0] == 0x06 && param[1] ==
0x00 && param[2] == 0x14)
> -					return PSMOUSE_PS2TPP;
> -
> -			} else {
> -				param[0] = param[1] = param[2] = 0;
> -
> -				psmouse_ps2pp_cmd(psmouse, param, 0x39);
/* Magic knock */
> -				psmouse_ps2pp_cmd(psmouse, param, 0xDB);
> -
> -				if ((param[0] & 0x78) == 0x48 &&
(param[1] & 0xf3) == 0xc2 &&
> -					(param[2] & 3) == ((param[1] >>
2) & 3))
> -						return PSMOUSE_PS2PP;
> -			}
> -		}
> -	}
> -
> -/*
>   * Try IntelliMouse magic init.
>   */
>  
> @@ -450,6 +416,40 @@
>  
>  		psmouse->name = "Wheel Mouse";
>  		return PSMOUSE_IMPS;
> +	}
> +
> +/*
> + * Do Logitech PS2++ / PS2T++ magic init.
> + */
> +
> +			if (psmouse->model == 97) { /* TouchPad 3 */
> +
> +				set_bit(REL_WHEEL, psmouse->dev.relbit);
> +				set_bit(REL_HWHEEL,
psmouse->dev.relbit);
> +
> +				param[0] = 0x11; param[1] = 0x04;
param[2] = 0x68; /* Unprotect RAM */
> +				psmouse_command(psmouse, param, 0x30d1);
> +				param[0] = 0x11; param[1] = 0x05;
param[2] = 0x0b; /* Enable features */
> +				psmouse_command(psmouse, param, 0x30d1);
> +				param[0] = 0x11; param[1] = 0x09;
param[2] = 0xc3; /* Enable PS2++ */
> +				psmouse_command(psmouse, param, 0x30d1);
> +
> +				param[0] = 0;
> +				if (!psmouse_command(psmouse, param,
0x13d1) &&
> +					param[0] == 0x06 && param[1] ==
0x00 && param[2] == 0x14)
> +					return PSMOUSE_PS2TPP;
> +
> +			} else {
> +				param[0] = param[1] = param[2] = 0;
> +
> +				psmouse_ps2pp_cmd(psmouse, param, 0x39);
/* Magic knock */
> +				psmouse_ps2pp_cmd(psmouse, param, 0xDB);
> +
> +				if ((param[0] & 0x78) == 0x48 &&
(param[1] & 0xf3) == 0xc2 &&
> +					(param[2] & 3) == ((param[1] >>
2) & 3))
> +						return PSMOUSE_PS2PP;
> +			}
> +		}
>  	}
>  
>  /*

-- 
Vojtech Pavlik
SuSE Labs


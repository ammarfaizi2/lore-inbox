Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264146AbSJRJAe>; Fri, 18 Oct 2002 05:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSJRJAe>; Fri, 18 Oct 2002 05:00:34 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:11914 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264146AbSJRJAa>;
	Fri, 18 Oct 2002 05:00:30 -0400
Date: Fri, 18 Oct 2002 11:06:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Christopher Hoover <ch@murgatroid.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH] 2.5.43: Fix for Logitech Wheel Mouse
Message-ID: <20021018110625.A26788@ucw.cz>
References: <20021017231953.A17985@heavens.murgatroid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021017231953.A17985@heavens.murgatroid.com>; from ch@murgatroid.com on Thu, Oct 17, 2002 at 11:20:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
> --- linux-2.5.43/drivers/input/mouse/psmouse.c.orig	Tue Oct 15 20:27:22 2002
> +++ linux-2.5.43/drivers/input/mouse/psmouse.c	Thu Oct 17 22:45:05 2002
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
> -				set_bit(REL_HWHEEL, psmouse->dev.relbit);
> -
> -				param[0] = 0x11; param[1] = 0x04; param[2] = 0x68; /* Unprotect RAM */
> -				psmouse_command(psmouse, param, 0x30d1);
> -				param[0] = 0x11; param[1] = 0x05; param[2] = 0x0b; /* Enable features */
> -				psmouse_command(psmouse, param, 0x30d1);
> -				param[0] = 0x11; param[1] = 0x09; param[2] = 0xc3; /* Enable PS2++ */
> -				psmouse_command(psmouse, param, 0x30d1);
> -
> -				param[0] = 0;
> -				if (!psmouse_command(psmouse, param, 0x13d1) &&
> -					param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14)
> -					return PSMOUSE_PS2TPP;
> -
> -			} else {
> -				param[0] = param[1] = param[2] = 0;
> -
> -				psmouse_ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
> -				psmouse_ps2pp_cmd(psmouse, param, 0xDB);
> -
> -				if ((param[0] & 0x78) == 0x48 && (param[1] & 0xf3) == 0xc2 &&
> -					(param[2] & 3) == ((param[1] >> 2) & 3))
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
> +				set_bit(REL_HWHEEL, psmouse->dev.relbit);
> +
> +				param[0] = 0x11; param[1] = 0x04; param[2] = 0x68; /* Unprotect RAM */
> +				psmouse_command(psmouse, param, 0x30d1);
> +				param[0] = 0x11; param[1] = 0x05; param[2] = 0x0b; /* Enable features */
> +				psmouse_command(psmouse, param, 0x30d1);
> +				param[0] = 0x11; param[1] = 0x09; param[2] = 0xc3; /* Enable PS2++ */
> +				psmouse_command(psmouse, param, 0x30d1);
> +
> +				param[0] = 0;
> +				if (!psmouse_command(psmouse, param, 0x13d1) &&
> +					param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14)
> +					return PSMOUSE_PS2TPP;
> +
> +			} else {
> +				param[0] = param[1] = param[2] = 0;
> +
> +				psmouse_ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
> +				psmouse_ps2pp_cmd(psmouse, param, 0xDB);
> +
> +				if ((param[0] & 0x78) == 0x48 && (param[1] & 0xf3) == 0xc2 &&
> +					(param[2] & 3) == ((param[1] >> 2) & 3))
> +						return PSMOUSE_PS2PP;
> +			}
> +		}
>  	}
>  
>  /*

-- 
Vojtech Pavlik
SuSE Labs

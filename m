Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265733AbTFNVEt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 17:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbTFNVEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 17:04:49 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7917 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265733AbTFNVER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 17:04:17 -0400
Date: Sat, 14 Jun 2003 23:18:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Eric Wong <eric@yhbt.net>
Cc: linux-kernel@vger.kernel.org, linus@transmeta.com, vojtech@suse.cz
Subject: Re: [PATCH] Logitech PS/2++ updates
Message-ID: <20030614231802.A26327@ucw.cz>
References: <20030326025538.GB12549@BL4ST>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030326025538.GB12549@BL4ST>; from eric@yhbt.net on Tue, Mar 25, 2003 at 06:55:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 06:55:38PM -0800, Eric Wong wrote:

> Updates to the PS/2++ mouse protocol used by Logitech, as well as
> SMS/Smart Scroll/Cruise Control and 800 cpi resolution control for those
> who want it.  Up to 10 buttons are supported now, although only 8 are
> used at the moment  on the MX500 and MX700.

Going to merge this, but what are the H118 and H119 keys? Also what
exactly "SMS" means?

> diff -bruN a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
> --- a/drivers/input/mouse/psmouse.c	2003-03-17 13:43:47.000000000 -0800
> +++ b/drivers/input/mouse/psmouse.c	2003-03-24 20:06:26.000000000 -0800
> @@ -21,9 +21,17 @@
>  MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
>  MODULE_DESCRIPTION("PS/2 mouse driver");
>  MODULE_PARM(psmouse_noext, "1i");
> +MODULE_PARM(psmouse_res, "i");
> +MODULE_PARM_DESC(psmouse_res, "resolution, not all mice support all values");
> +MODULE_PARM(psmouse_sms, "i");
> +MODULE_PARM_DESC(psmouse_sms, "autorepeat, 1 = enabled (default) | 0 = disabled");
>  MODULE_LICENSE("GPL");
>  
> +#define PSMOUSE_LOGITECH_SMS	1
> +
>  static int psmouse_noext;
> +static int psmouse_res;
> +static int psmouse_sms = PSMOUSE_LOGITECH_SMS;
>  
>  #define PSMOUSE_CMD_SETSCALE11	0x00e6
>  #define PSMOUSE_CMD_SETRES	0x10e8
> @@ -83,8 +91,47 @@
>  /*
>   * The PS2++ protocol is a little bit complex
>   */
> +	if (psmouse->type == PSMOUSE_PS2PP) { 
> +
> +		if ((packet[0] & 0x48) == 0x48 && (packet[1] & 0x02) == 0x02 ) {
>  
> -	if (psmouse->type == PSMOUSE_PS2PP || psmouse->type == PSMOUSE_PS2TPP) {
> +			switch (((packet[1] >> 4) & 0x0f) | (packet[0] & 0x30)) {
> +
> +			case 0x0d: /* Mouse extra info */
> +
> +				input_report_rel(dev, packet[2] & 0x80 ? REL_HWHEEL : REL_WHEEL,
> +					(int) (packet[2] & 8) - (int) (packet[2] & 7));
> +				input_report_key(dev, BTN_SIDE, (packet[2] >> 4) & 1);
> +				input_report_key(dev, BTN_EXTRA, (packet[2] >> 5) & 1);
> +
> +				break;
> +			case 0x0e: /* buttons 4, 5, 6, 7, 8, 9, 10 info */
> +
> +				input_report_key(dev, BTN_SIDE, (packet[2]) & 1);
> +				input_report_key(dev, BTN_EXTRA, (packet[2] >> 1) & 1);
> +				input_report_key(dev, BTN_TASK, (packet[2] >> 2) & 1);
> +				input_report_key(dev, BTN_SMSUP, (packet[2] >> 3) & 1);
> +				input_report_key(dev, BTN_SMSDOWN, (packet[2] >> 4) & 1);
> +				input_report_key(dev, BTN_H118, (packet[2] >> 5) & 1);
> +				input_report_key(dev, BTN_H119, (packet[2] >> 6) & 1);
> +
> +				break;
> +#ifdef DEBUG
> +			default:
> +				printk(KERN_WARNING "psmouse.c: Received PS2++ packet #%x, but don't know how to handle.\n",
> +					((packet[1] >> 4) & 0x03) | ((packet[0] >> 2) & 0x0c));
> +#endif
> +
> +			}
> +
> +		packet[0] &= 0x0f;
> +		packet[1] = 0;
> +		packet[2] = 0;
> +
> +		}
> +	}
> +	
> +	if (psmouse->type == PSMOUSE_PS2TPP) {
>  
>  		if ((packet[0] & 0x40) == 0x40 && abs((int)packet[1] - (((int)packet[0] & 0x10) << 4)) > 191 ) {
>  
> @@ -112,7 +159,6 @@
>  				printk(KERN_WARNING "psmouse.c: Received PS2++ packet #%x, but don't know how to handle.\n",
>  					((packet[1] >> 4) & 0x03) | ((packet[0] >> 2) & 0x0c));
>  #endif
> -
>  			}
>  
>  		packet[0] &= 0x0f;
> @@ -385,9 +431,11 @@
>  
>  		int i;
>  		static int logitech_4btn[] = { 12, 40, 41, 42, 43, 52, 73, 80, -1 };
> -		static int logitech_wheel[] = { 52, 53, 75, 76, 80, 81, 83, 88, -1 };
> +		static int logitech_wheel[] = { 52, 53, 75, 76, 80, 81, 83, 88, 112, -1 };
>  		static int logitech_ps2pp[] = { 12, 13, 40, 41, 42, 43, 50, 51, 52, 53, 73, 75,
> -							76, 80, 81, 83, 88, 96, 97, -1 };
> +							76, 80, 81, 83, 88, 96, 97, 112, -1 };
> +		static int logitech_P2[] = { 112, -1 };
> +
>  		psmouse->vendor = "Logitech";
>  		psmouse->model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
>  
> @@ -414,6 +462,17 @@
>  					psmouse->name = "Wheel Mouse";
>  				}
>  
> +			for (i = 0; logitech_P2[i] != -1; i++)
> +				if (logitech_P2[i]  == psmouse->model) {
> +					set_bit(BTN_SIDE, psmouse->dev.keybit);
> +					set_bit(BTN_EXTRA, psmouse->dev.keybit);
> +					set_bit(BTN_TASK, psmouse->dev.keybit);
> +					set_bit(BTN_SMSUP, psmouse->dev.keybit);
> +					set_bit(BTN_SMSDOWN, psmouse->dev.keybit);
> +					set_bit(BTN_H118, psmouse->dev.keybit);
> +					set_bit(BTN_H119, psmouse->dev.keybit);
> +				}
> +
>  /*
>   * Do Logitech PS2++ / PS2T++ magic init.
>   */
> @@ -534,6 +593,60 @@
>  }
>  
>  /*
> + * SMS/Smart Scroll/Cruise Control for some newer Logitech mice 
> + * Defaults to enabled if we do nothing to it. Of course I put this in because
> + * I want it disabled :P
> + * 1 - enabled (if previously disabled, also default)
> + * 0/2 - disabled 
> + */
> +static void psmouse_logitech_sms(struct psmouse *psmouse, unsigned char *param)
> +{
> +	psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11);
> +	param[0] = 0;
> +	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +	param[0] = 3;
> +	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +	param[0] = 0;
> +	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +	param[0] = 2;
> +	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +	param[0] = 0;
> +	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +	if (psmouse_sms == 1) 
> +		param[0] = 1;
> +	else if	(psmouse_sms > 2)
> +		return;
> +	/* else leave param[0] == 0 to disable */
> +	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +}
> +
> +/*
> + * Support 800 cpi resolution _only_ if the user wants it (there are good reasons
> + * to not use it even if the mouse supports it, and of course there are also good
> + * reasons to use it, let the user decide)
> + */
> +static void psmouse_set_resolution(struct psmouse *psmouse, unsigned char *param)
> +{
> +	param[0] = 3;
> +	if (psmouse_res >= 800) {
> +	/* setting 400 cpi after doing the follwing enables 800 cpi */
> +		psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11);
> +		psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11);
> +		psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11);
> +	} else if (psmouse_res && psmouse_res < 200) {
> +		if (psmouse_res >= 100) 
> +			param[0] = 2;
> +		else if (psmouse_res >= 50)
> +			param[0] = 1;
> +		else if (psmouse_res)
> +			param[0] = 0;
> +	}
> +	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +}
> +
> +/*
>   * psmouse_initialize() initializes the mouse to a sane state.
>   */
>  
> @@ -541,11 +654,12 @@
>  {
>  	unsigned char param[2];
>  
> +	psmouse_logitech_sms(psmouse, param);
> +	
>  /*
>   * We set the mouse report rate to a highest possible value.
>   * We try 100 first in case mouse fails to set 200.
>   */
> -
>  	param[0] = 100;
>  	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
>  
> @@ -555,9 +669,7 @@
>  /*
>   * We also set the resolution and scaling.
>   */
> -
> -	param[0] = 3;
> -	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +	psmouse_set_resolution(psmouse, param);
>  	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
>  
>  /*
> @@ -668,7 +780,23 @@
>  	psmouse_noext = 1;
>  	return 1;
>  }
> +
> +static int __init psmouse_res_setup(char *str)
> +{
> +	get_option(&str,&psmouse_res);
> +	return 1;
> +}
> +
> +static int __init psmouse_sms_setup(char *str)
> +{
> +	get_option(&str,&psmouse_sms);
> +	return 1;
> +}
> +
>  __setup("psmouse_noext", psmouse_setup);
> +__setup("psmouse_res=", psmouse_res_setup);
> +__setup("psmouse_sms=", psmouse_sms_setup);
> +
>  #endif
>  
>  int __init psmouse_init(void)
> --- a/include/linux/input.h	2003-03-17 13:44:04.000000000 -0800
> +++ b/include/linux/input.h	2003-03-24 20:06:26.000000000 -0800
> @@ -355,7 +355,12 @@
>  #define BTN_SIDE		0x113
>  #define BTN_EXTRA		0x114
>  #define BTN_FORWARD		0x115
> +#define BTN_TASK		0x115
>  #define BTN_BACK		0x116
> +#define BTN_SMSUP		0x116
> +#define BTN_SMSDOWN		0x117
> +#define BTN_H118		0x118
> +#define BTN_H119		0x119
>  
>  #define BTN_JOYSTICK		0x120
>  #define BTN_TRIGGER		0x120
>  
> -- 
> Eric Wong

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

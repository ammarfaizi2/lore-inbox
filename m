Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUKHIhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUKHIhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 03:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUKHIhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 03:37:18 -0500
Received: from postman4.arcor-online.net ([151.189.20.158]:60574 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261779AbUKHIfr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 03:35:47 -0500
Date: Mon, 8 Nov 2004 09:35:31 +0100
From: Juergen Quade <quade@hsnr.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFT/PATCH] Toshiba Satellite, Synaptics & keyboard problems
Message-ID: <20041108083531.GA17236@hsnr.de>
References: <200411080154.54279.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200411080154.54279.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 01:54:52AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> If anyone experiencing keyboard getting "stuck" when you use Synaptics
> touchpad in native mode on Toshiba Satellite type notebooks it seems that
> lowering rate to 40 pps (which is roughly the same as standard PS/2 rate
> bytewise) helps.
> 
> Please try the patch below (should apply to -mm tree) and see if it helps
> any. If not using -mm tree just use "psmouse.rate=40" or "modprobe psmouse
> rate=40" to check if fix is working for you and let me know.

I have problems with "no keyboard" since Kernel 2.6.9.
I am not using a -mm tree and booting with "psmouse.rate=40" does
_not_ fix the problem :-(   (tested with 2.6.9 and 2.6.10-rc1).

As soon as X is started I have no keyboard.
My box is a Acer Travelmate 290 notebook with synaptics/alps
touchpad.

          Juergen.
> 
> Thanks!
> 
> -- 
> Dmitry
> 
> 
> ===================================================================
> 
> 
> ChangeSet@1.1960, 2004-11-08 01:51:37-05:00, dtor_core@ameritech.net
>   Input: synaptics - use DMI to detect Toshiba Satellite notebooks
>          and automatically reduce touchpad reporting rate to 40 pps
>          as they have trouble handling high rate (80 pps).
>   
>   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> 
>  synaptics.c |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+)
> 
> 
> ===================================================================
> 
> 
> 
> diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> --- a/drivers/input/mouse/synaptics.c	2004-11-08 01:52:54 -05:00
> +++ b/drivers/input/mouse/synaptics.c	2004-11-08 01:52:54 -05:00
> @@ -604,6 +604,20 @@
>  	return 0;
>  }
>  
> +#if defined(__i386__)
> +#include <linux/dmi.h>
> +static struct dmi_system_id synaptics_dmi_table[] = {
> +	{
> +		.ident = "Toshiba Satellite",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME , "Satellite"),
> +		},
> +	},
> +	{ }
> +};
> +#endif
> +
>  int synaptics_init(struct psmouse *psmouse)
>  {
>  	struct synaptics_data *priv;
> @@ -636,6 +650,18 @@
>  	psmouse->disconnect = synaptics_disconnect;
>  	psmouse->reconnect = synaptics_reconnect;
>  	psmouse->pktsize = 6;
> +
> +#if defined(__i386__)
> +	/*
> +	 * Toshiba's KBC seems to have trouble handling data from
> +	 * Synaptics as full rate, switch to lower rate which is roughly
> +	 * thye same as rate of standard PS/2 mouse.
> +	 */
> +	if (dmi_check_system(synaptics_dmi_table)) {
> +		printk(KERN_INFO "synaptics: Toshiba Satellite detected, limiting rate to 40pps.\n");
> +		psmouse->rate = 40;
> +	}
> +#endif
>  
>  	return 0;
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

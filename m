Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUACKDn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 05:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbUACKDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 05:03:43 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:48256 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S263015AbUACKDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 05:03:41 -0500
Date: Sat, 3 Jan 2004 11:03:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] i8042 suspend
Message-ID: <20040103100347.GA499@ucw.cz>
References: <200401030350.43437.dtor_core@ameritech.net> <200401030356.48071.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401030356.48071.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 03:56:45AM -0500, Dmitry Torokhov wrote:
> diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> --- a/drivers/input/serio/i8042.c	Sat Jan  3 03:07:29 2004
> +++ b/drivers/input/serio/i8042.c	Sat Jan  3 03:07:29 2004
> @@ -746,6 +746,29 @@
>  
>  
>  /*
> + * Reset the controller.
> + */
> +void i8042_controller_reset(void)
> +{
> +	if (i8042_reset) {
> +		unsigned char param;
> +
> +		if (i8042_command(&param, I8042_CMD_CTL_TEST))
> +			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
> +	}

We should be checking the return value from the TEST command as well,
if we want to use this to initialize the controller on non-x86 platforms
(where i8042.reset is 0).

>  
> -/*
> - * Reset the controller.
> - */
> -
> -	if (i8042_reset) {
> -		unsigned char param;
> +	i8042_controller_reset();
> +}
>  
> -		if (i8042_command(&param, I8042_CMD_CTL_TEST))
> -			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
> -	}


This actually introduces a bug, because we don't want to restore the CTR
setting before we save it, which the new code does.

> @@ -809,7 +826,7 @@
>  	if (i8042_mux_present)
>  		if (i8042_enable_mux_mode(&i8042_aux_values, NULL) ||
>  		    i8042_enable_mux_ports(&i8042_aux_values)) {
> -			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't wotk.\n");
> +			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't work.\n");

Ahh, a typo. :)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUI2NXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUI2NXR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUI2NXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:23:16 -0400
Received: from styx.suse.cz ([82.119.242.94]:39299 "EHLO shadow.suse.cz")
	by vger.kernel.org with ESMTP id S268406AbUI2NVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:21:04 -0400
Date: Wed, 29 Sep 2004 15:21:34 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Readd panic blinking in 2.6
Message-ID: <20040929132134.GA3770@ucw.cz>
References: <m3llet4456.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3llet4456.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 03:05:09PM +0200, Andi Kleen wrote:

> diff -u linux-2.6.9rc2-bk11/drivers/input/serio/i8042.c-PANIC linux-2.6.9rc2-bk11/drivers/input/serio/i8042.c
> --- linux-2.6.9rc2-bk11/drivers/input/serio/i8042.c-PANIC	2004-09-25 16:03:19.000000000 +0200
> +++ linux-2.6.9rc2-bk11/drivers/input/serio/i8042.c	2004-09-27 01:22:23.000000000 +0200
> @@ -887,6 +887,40 @@
>          0
>  };
>  
> +static int blink_frequency = 500;
> +module_param_named(panicblink, blink_frequency, int, 0600);
> +
> +#define DELAY mdelay(1), delay++
> +
> +/* Tell the user who may be running in X and not see the console that we have 
> +   panic'ed. This is to distingush panics from "real" lockups.  */
> +static long i8042_panic_blink(long count)
> +{ 
> +	long delay = 0;
> +	static long last_blink;
> +	static char led;
> +	/* Roughly 1/2s frequency. KDB uses about 1s. Make sure it is 
> +	   different. */
> +	if (!blink_frequency) 
> +		return 0;
> +	if (count - last_blink < blink_frequency)
> +		return 0;
> +	led ^= 0x01 | 0x04;
> +	while (i8042_read_status() & I8042_STR_IBF)
> +		DELAY;

This here relies on interrupts working, since to clear IBF you need to
read from the input port, which is only done in the interrupt routine.
What you should do here is to disable the interrupts on the i8042 by
setting the CTR to an appropriate value and then flush the input port
after a response from the keyboard has arrived.

> +	i8042_write_data(0xed); /* set leds */
> +	DELAY;
> +	while (i8042_read_status() & I8042_STR_IBF)
> +		DELAY;
> +	DELAY;
> +	i8042_write_data(led);
> +	DELAY;
> +	last_blink = count;
> +	return delay;
> +}  

Also, you shouldn't need the DELAY macro, as i8042.c already has the
primitives to do all the waiting.

Something like

	spin_lock_irqsave(&i8042_lock, flags);
	i8042_flush();
	i8042_ctr &= ~I8042_CTR_KBDINT & ~I8042_CTR_AUXINT;
	i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR);
	i8042_wait_write();
	i8042_write_data(0xed);
	i8042_wait_read();
	i8042_flush();
	i8042_wait_write();
	i8042_write_data(led);
	i8042_wait_read();
	i8042_flush();
	spin_unlock_irqrestore(&i8042_lock, flags);

would be safer and more correct.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVAZPnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVAZPnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 10:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVAZPnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 10:43:08 -0500
Received: from ns.suse.de ([195.135.220.2]:38596 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262333AbVAZPnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 10:43:01 -0500
Date: Wed, 26 Jan 2005 16:43:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
Message-ID: <20050126154307.GB4422@ucw.cz>
References: <200501250241.14695.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501250241.14695.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:41:14AM -0500, Dmitry Torokhov wrote:

> Recently there was a patch from Alan regarding access timing violations
> in i8042. It made me curious as we only wait between accesses to status
> register but not data register. I peeked into FreeBSD code and they use
> delays to access both registers and I wonder if that's the piece that
> makes i8042 mysteriously fail on some boards.
> 
> Anyway, regardless of whether access to data register should be done with
> delay as well there seem to be another timing access violation - in
> i8042_command we do i8042_wait_read which reads STR and then immediately
> do i8042_read_status to check AUXDATA bit.
> 
> Does the patch below makes any sense?
> 
> +	do {
> +		str = i8042_read_status();
> +		if (~str & I8042_STR_OBF)
> +			break;
> +		udelay(I8042_DATA_DELAY);
>  		data = i8042_read_data();

In my opinion, there is no requirement to wait after status read
returned success and the actual reading of data. This way we'd have to
have the delay in the interrupt routine as well.

> -		dbg("%02x <- i8042 (flush, %s)", data,
> -			i8042_read_status() & I8042_STR_AUXDATA ? "aux" : "kbd");
> -	}
> +		dbg("%02x <- i8042 (flush, %s)", data, str & I8042_STR_AUXDATA ? "aux" : "kbd");
> +		udelay(I8042_STR_DELAY);
> +	} while (i++ < I8042_BUFFER_SIZE);

So the only problem in the flush routine is the debugging print. 

>  	spin_unlock_irqrestore(&i8042_lock, flags);
>  
> @@ -190,6 +193,7 @@
>  static int i8042_command(unsigned char *param, int command)
>  {
>  	unsigned long flags;
> +	unsigned char str;
>  	int retval = 0, i = 0;
>  
>  	if (i8042_noloop && command == I8042_CMD_AUX_LOOP)
> @@ -213,7 +217,10 @@
>  	if (!retval)
>  		for (i = 0; i < ((command >> 8) & 0xf); i++) {
>  			if ((retval = i8042_wait_read())) break;
> -			if (i8042_read_status() & I8042_STR_AUXDATA)
> +			udelay(I8042_STR_DELAY);
> +			str = i8042_read_status();
[]
> +			udelay(I8042_DATA_DELAY);
> +			if (str & I8042_STR_AUXDATA)
>  				param[i] = ~i8042_read_data();
>  			else
>  				param[i] = i8042_read_data();

We may as well drop the negation. It's a bad way to signal the data came
from the AUX port. Then we don't need the extra status read and can just
proceed to read the data, since IMO we don't need to wait inbetween,
even according to the IBM spec.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

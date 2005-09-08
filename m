Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVIHMeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVIHMeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVIHMeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:34:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2574 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751319AbVIHMeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:34:14 -0400
Date: Thu, 8 Sep 2005 13:34:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [-mm patch 2/5] SharpSL: Add cxx00 support to the Corgi LCD driver
Message-ID: <20050908133408.F31595@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <1126007628.8338.127.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126007628.8338.127.camel@localhost.localdomain>; from rpurdie@rpsys.net on Tue, Sep 06, 2005 at 12:53:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 12:53:48PM +0100, Richard Purdie wrote:
> +/*
> + * Corgi/Spitz Touchscreen to LCD interface
> + */
> +unsigned long inline corgi_get_hsync_len(void) 
> +{
> +	if (machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) {
> +#ifdef CONFIG_PXA_SHARP_C7xx
> +		return w100fb_get_hsynclen(&corgifb_device.dev);
> +#endif
> +	} else if (machine_is_spitz() || machine_is_akita() || machine_is_borzoi()) {
> +#ifdef CONFIG_PXA_SHARP_Cxx00
> +		return pxafb_get_hsync_time(&pxafb_device.dev);
> +#endif

This means you have to force these drivers to be built (since this file
will always be built for sharp stuff.)  This doesn't seem like a good
solution.

> +#define SyncHS(x)   while((GPLR(x) & GPIO_bit(x)) == 0); while((GPLR(x) & GPIO_bit(x)) != 0);

That's particularly gruesome - firstly, two statements inside a macro.
Secondly, no barrier() or cpu_relax() in there (as the kernel janitors
like to see.)  It won't make any difference to the generated code, but
makes other folk happier.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

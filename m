Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVIHMar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVIHMar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVIHMar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:30:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51979 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751148AbVIHMar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:30:47 -0400
Date: Thu, 8 Sep 2005 13:30:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [-mm patch 4/5] SharpSL: Abstract model specifics from Corgi Backlight driver
Message-ID: <20050908133039.E31595@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <1126007631.8338.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126007631.8338.129.camel@localhost.localdomain>; from rpurdie@rpsys.net on Tue, Sep 06, 2005 at 12:53:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 12:53:51PM +0100, Richard Purdie wrote:
> +/*
> + * Corgi/Spitz Backlight Power
> + */
> +int corgi_bl_max(void)
> +{
> +	if (machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) 
> +		return 0x2e;
> +	return 0x3e;

Couldn't this be passed in cleanly via the device's platform data?

> +}
> +
> +void corgi_bl_set(int intensity)
> +{

Along with a function pointer for whatever's needed here for each
machine?

> +	if ((machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) 
> +			&& (intensity > 0x10))
> +		intensity+=0x10;
> +
> +	/* Skip 0x20 as it will blank the display */
> +	if (intensity >= 0x20)
> +		intensity++;
> +
> +	/* Bits 0-4 are accessed via the SSP interface */
> +	corgi_ssp_blduty_set(intensity & 0x1f);
> +
> +	if (machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) {
> +#ifdef CONFIG_PXA_SHARP_C7xx
> +		/* Bit 5 is via SCOOP */
> +		if (intensity & 0x0020)
> +			set_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_BACKLIGHT_CONT);
> +		else
> +			reset_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_BACKLIGHT_CONT);
> +#endif
> +	} else if (machine_is_spitz() || machine_is_borzoi()) {
> +#if defined(CONFIG_MACH_SPITZ) || defined(CONFIG_MACH_BORZOI)
> +		/* Bit 5 is via SCOOP */
> +		if (intensity & 0x0020)
> +			reset_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_CONT);
> +		else
> +			set_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_CONT);
> +
> +		if (intensity) 
> +			set_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_ON);
> +		else
> +			reset_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_ON);
> +#endif
> +	} else if (machine_is_akita()) {
> +#ifdef CONFIG_MACH_AKITA
> +		/* Bit 5 is via IO-Expander */
> +		if (intensity & 0x0020)
> +			akita_reset_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_CONT);
> +		else
> +			akita_set_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_CONT);
> +
> +		if (intensity) 
> +			akita_set_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_ON);
> +		else
> +			akita_reset_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_ON);
> +#endif
> +	}
> +}

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWA3D24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWA3D24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 22:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWA3D24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 22:28:56 -0500
Received: from smtp1.ensim.com ([65.164.64.254]:1547 "EHLO
	exchange-svr2.exch.ensim.com") by vger.kernel.org with ESMTP
	id S1750717AbWA3D2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 22:28:55 -0500
From: Borislav Deianov <borislav@users.sourceforge.net>
Date: Sun, 29 Jan 2006 19:28:44 -0800
To: David Zeuthen <david@fubar.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibm-acpi brightness fix
Message-ID: <20060130032844.GF2271@aero.ensim.com>
References: <1138558472.9858.23.camel@daxter.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138558472.9858.23.camel@daxter.boston.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 30 Jan 2006 03:28:45.0129 (UTC) FILETIME=[46730390:01C6254D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sun, Jan 29, 2006 at 01:14:31PM -0500, David Zeuthen wrote:
> 
> The ibm-acpi driver allows user space to set the brightness of the
> display but the way it currently works is by fading from one of the
> eight levels to the other. While this effect is visually pleasing it's
> probably best taken care of by user space itself (and users of
> gnome-power-manager will notice that this is exactly what it does).

Thanks for the patch. Unfortunately, the fading is required on my X40 -
setting a random brightness value just doesn't work without it. The
EC probably expects it to happen that way since you can only go one
step up or down with the hot keys.

Wishes,
Boris



> 
> This patch removes the fading. Patch is against ibm-acpi 0.11 but it
> also applies to the drivers/acpi/ibm_acpi.c file in Linus' tree. I've
> tested this on a IBM Thinkpad T41. Please apply.
> 
> (Please keep me in the Cc - I'm not subscribed to the LKML)
> 
>     David
> 
> Signed-Off-By: David Zeuthen <david@fubar.dk>
> 
> --- ibm-acpi-0.11.orig/ibm_acpi.c	2005-03-17 05:06:16.000000000 -0500
> +++ ibm-acpi-0.11/ibm_acpi.c	2006-01-29 12:55:53.000000000 -0500
> @@ -1351,7 +1351,7 @@ static int brightness_read(char *p)
>  
>  static int brightness_write(char *buf)
>  {
> -	int cmos_cmd, inc, i;
> +	int cmos_cmd;
>  	u8 level;
>  	int new_level;
>  	char *cmd;
> @@ -1372,13 +1372,11 @@ static int brightness_write(char *buf)
>  			return -EINVAL;
>  
>  		cmos_cmd = new_level > level ? BRIGHTNESS_UP : BRIGHTNESS_DOWN;
> -		inc = new_level > level ? 1 : -1;
> -		for (i = level; i != new_level; i += inc) {
> -			if (!cmos_eval(cmos_cmd))
> -				return -EIO;
> -			if (!acpi_ec_write(brightness_offset, i + inc))
> -				return -EIO;
> -		}
> +
> +		if (!cmos_eval(cmos_cmd))
> +			return -EIO;
> +		if (!acpi_ec_write(brightness_offset, new_level))
> +			return -EIO;
>  	}
>  
>  	return 0;

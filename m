Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVATVJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVATVJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVATVJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:09:17 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:64780 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261944AbVATVJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:09:13 -0500
Date: Thu, 20 Jan 2005 16:07:41 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, tv@lio96.de, herbert@gondor.apana.org.au,
       jgarzik@pobox.com, marcelo.tosatti@cyclades.com
Subject: Re: [patch 2.4.29] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050120210739.GC7687@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, tv@lio96.de,
	herbert@gondor.apana.org.au, jgarzik@pobox.com,
	marcelo.tosatti@cyclades.com
References: <20050120202258.GA7687@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120202258.GA7687@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch...it was made assuming that a previous patch
had been applied -- that seems not to have been the case...

I will reform and repost...

John

On Thu, Jan 20, 2005 at 03:22:59PM -0500, John W. Linville wrote:
> Offset LVI past CIV when starting DAC/ADC in order to prevent
> stalled start.
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> Acked-by: Thomas Voegtle <tv@lio96.de>
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> This fixes a "no sound" problem with Wolfenstein Enemy Territory and
> (apparently) other games using the Quake3 engine.  It probably affects
> some other OSS applications as well.
> 
> This recreates some code that had been removed from the i810_audio
> driver around 5/2004.
> 
>  drivers/sound/i810_audio.c |   10 ++++++++++
>  1 files changed, 10 insertions(+)
> 
> --- i810_audio-2.4/drivers/sound/i810_audio.c.orig	2005-01-20 14:41:43.914734688 -0500
> +++ i810_audio-2.4/drivers/sound/i810_audio.c	2005-01-20 14:41:43.916734414 -0500
> @@ -1062,10 +1062,20 @@
>  	if (count < fragsize)
>  		return;
>  
> +	/* if we are currently stopped, then our CIV is actually set to our
> +	 * *last* sg segment and we are ready to wrap to the next.  However,
> +	 * if we set our LVI to the last sg segment, then it won't wrap to
> +	 * the next sg segment, it won't even get a start.  So, instead, when
> +	 * we are stopped, we set both the LVI value and also we increment
> +	 * the CIV value to the next sg segment to be played so that when
> +	 * we call start, things will operate properly
> +	 */
>  	if (!dmabuf->enable && dmabuf->ready) {
>  		if (!(dmabuf->trigger & trigger))
>  			return;
>  
> +		CIV_TO_LVI(state->card, port, 1);
> +
>  		start(state);
>  		while (!(inb(port + OFF_CR) & ((1<<4) | (1<<2))))
>  			;
> -- 
> John W. Linville
> linville@tuxdriver.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
John W. Linville
linville@tuxdriver.com

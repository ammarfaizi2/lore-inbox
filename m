Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSLAASJ>; Sat, 30 Nov 2002 19:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSLAASJ>; Sat, 30 Nov 2002 19:18:09 -0500
Received: from r2q57.mistral.cz ([62.245.80.57]:23936 "EHLO ppc.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S261346AbSLAASI>;
	Sat, 30 Nov 2002 19:18:08 -0500
Date: Sun, 1 Dec 2002 01:25:33 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Matt Reppert <arashi@arashi.yi.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.co.au
Subject: Re: [PATCH] Unsafe MODULE_ usage in crc32.c
Message-ID: <20021201002533.GA2869@ppc.vc.cvut.cz>
References: <20021130181224.4b4cddad.arashi@arashi.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021130181224.4b4cddad.arashi@arashi.yi.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2002 at 06:12:24PM -0600, Matt Reppert wrote:
> Hi,
> 
> Okay, I know, it's just a library module, doesn't need to ever be unloaded
> anyway. But error noise in dmesg annoys me, hence this patch.
 
Better asking Rusty, why module cannot call MOD_INC_USE_COUNT on itself
during its own init... I'm pretty sure that crc32 module knows that nobody
can unload it at this point: it is executing its own code, isn't it?
					Petr Vandrovec
					vandrove@vc.cvut.cz

> Matt
> 
>   Convert CRC32 to try_module_get; fixes an unsafe usage that
>   prevents unloading.
> 
> 
>  lib/crc32.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> --- linux-2.5.50/lib/crc32.c~crc32-unsafe	2002-11-30 05:31:19.000000000 -0600
> +++ linux-2.5.50-arashi/lib/crc32.c	2002-11-30 05:36:17.000000000 -0600
> @@ -551,7 +551,10 @@ static int __init init_crc32(void)
>  	rc1 = crc32init_le();
>  	rc2 = crc32init_be();
>  	rc = rc1 || rc2;
> -	if (!rc) MOD_INC_USE_COUNT;
> +	if (!rc) {
> +		if (!try_module_get(THIS_MODULE))
> +			rc = -1;
> +	}
>  	return rc;
>  }
>  
> 
> [patch ends]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423486AbWJaPYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423486AbWJaPYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423487AbWJaPYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:24:21 -0500
Received: from rubidium.solidboot.com ([81.22.244.175]:34011 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S1423486AbWJaPYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:24:21 -0500
Message-ID: <45476AA3.6070505@solidboot.com>
Date: Tue, 31 Oct 2006 17:24:19 +0200
From: Juha Yrjola <juha.yrjola@solidboot.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>,
       Timo Teras <timo.teras@solidboot.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: Select only one voltage bit in OCR response
References: <20061009150044.GB1637@mail.solidboot.com> <20061009165317.GA6431@flint.arm.linux.org.uk> <20061009172350.GC1637@mail.solidboot.com> <453327EC.1000402@drzeus.cx> <20061031100503.GB19812@flint.arm.linux.org.uk>
In-Reply-To: <20061031100503.GB19812@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>>> Maybe something like "ocr &= 3 << bit;" would be more approriate?
>>>   
>> Russell? Comments? Do you still have the offending card?
> 
> It wasn't my cards, but was reported by several other folk.  I don't think
> we can revert on this without breakage.
> 
> However, we should probably ensure that we don't end up setting voltage
> bits which the cards don't support.  So maybe masking the resulting OCR
> value with the received combined OCR would be a good idea?  Such as:

Isn't this exactly what Timo is proposing above?

Cheers,
Juha

> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index ee8863c..45e0598 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -467,23 +467,24 @@ static inline void mmc_delay(unsigned in
>   */
>  static u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>  {
> +	u32 selected_ocr;
>  	int bit;
>  
> -	ocr &= host->ocr_avail;
> +	selected_ocr = ocr & host->ocr_avail;
>  
> -	bit = ffs(ocr);
> +	bit = ffs(selected_ocr);
>  	if (bit) {
>  		bit -= 1;
>  
> -		ocr = 3 << bit;
> +		selected_ocr = 3 << bit;
>  
>  		host->ios.vdd = bit;
>  		mmc_set_ios(host);
>  	} else {
> -		ocr = 0;
> +		selected_ocr = 0;
>  	}
>  
> -	return ocr;
> +	return selected_ocr & ocr;
>  }

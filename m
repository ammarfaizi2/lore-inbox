Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWHAXAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWHAXAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWHAXAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:00:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:61679 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750711AbWHAXAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:00:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=PzYkI41/NNBt30bx5cRxPi0NFnr3Kw5RWQEbgwU8QonM3zRjYlHY2BOQkTvgPWFDXfDCrEgLmTT5Hx25Xuz/TGZqoV4dUMFvndrmQ31HVCk8EoEoD0525KuzJ5h/tagIKbpK4+V1hpvGY6rLf63TPTENvlvVQI+Yd0wA0YIGDf4=
Date: Wed, 2 Aug 2006 03:00:03 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
Message-ID: <20060801230003.GB14863@martell.zuzino.mipt.ru>
References: <20060801184451.GP22240@redhat.com> <1154470467.15540.88.camel@localhost.localdomain> <20060801223011.GF22240@redhat.com> <20060801223622.GG22240@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801223622.GG22240@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 06:36:22PM -0400, Dave Jones wrote:
> 000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1638,10 +1638,29 @@ static void poison_obj(struct kmem_cache
>  static void dump_line(char *data, int offset, int limit)
>  {
>  	int i;
> +	unsigned char total=0, bad_count=0;

	" = 0"

>  	printk(KERN_ERR "%03x:", offset);
> -	for (i = 0; i < limit; i++)
> +	for (i = 0; i < limit; i++) {
> +		if (data[offset+i] != POISON_FREE) {

				" + i"

> +			total += data[offset+i];

ditto

> +			++bad_count;

How about post increment?

> +		}
>  		printk(" %02x", (unsigned char)data[offset + i]);
> +	}
>  	printk("\n");
> +
> +	if (bad_count == 1) {
> +		errors = total ^ POISON_FREE;

undeclared "errors"

> +		if ((errors && !(errors & (errors-1))) {

		   ^^^

Turn on CONFIG_DEBUG_SLAB before compiling. ;-)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbTLYKKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 05:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbTLYKKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 05:10:21 -0500
Received: from mail.contactel.cz ([212.65.193.3]:35291 "EHLO mail.contactel.cz")
	by vger.kernel.org with ESMTP id S264261AbTLYKKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 05:10:18 -0500
Date: Thu, 25 Dec 2003 11:08:50 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make ppp_async callable from hard interrupt
Message-ID: <20031225100850.GA6629@penguin.localdomain>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <16356.60597.133074.809551@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16356.60597.133074.809551@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.4i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 11:43:33AM +1100, Paul Mackerras wrote:
>  /* called when a flag is seen - do end-of-packet processing */
> -static inline void
> +static void
>  process_input_packet(struct asyncppp *ap)
>  {
>  	struct sk_buff *skb;
>  	unsigned char *p;
>  	unsigned int len, fcs, proto;
> -	int code = 0;
> +
> +	if (ap->state & (SC_TOSS | SC_ESCAPE))
> +		goto err;
If this is true, skb will be used uninitialized.

>  
>  	skb = ap->rpkt;
> -	ap->rpkt = 0;
> -	if ((ap->state & (SC_TOSS | SC_ESCAPE)) || skb == 0) {
> -		ap->state &= ~(SC_TOSS | SC_ESCAPE);
> -		if (skb != 0)
> -			kfree_skb(skb);
> -		return;
> -	}
> +	if (skb == NULL)
> +		return;		/* 0-length packet */


-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E


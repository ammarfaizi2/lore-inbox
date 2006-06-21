Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWFURXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWFURXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWFURXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:23:18 -0400
Received: from main.gmane.org ([80.91.229.2]:9194 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750823AbWFURXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:23:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: Memory corruption in 8390.c ?
Date: Wed, 21 Jun 2006 10:23:09 -0700
Message-ID: <87mzc65soy.fsf@benpfaff.org>
References: <1150907317.8320.0.camel@alice>
	<1150909982.15275.100.camel@localhost.localdomain>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-7-50-23.hsd1.ca.comcast.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:U55Pf3DTzYtOymp5sJ1n5UQ6psU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> --- drivers/net/8390.c~	2006-06-21 17:41:12.006145536 +0100
> +++ drivers/net/8390.c	2006-06-21 17:41:12.007145384 +0100
> @@ -275,12 +275,14 @@
>  	struct ei_device *ei_local = (struct ei_device *) netdev_priv(dev);
>  	int send_length = skb->len, output_page;
>  	unsigned long flags;
> +	char buf[64];
> +	char *data = skb->data;
>  
>  	if (skb->len < ETH_ZLEN) {
> -		skb = skb_padto(skb, ETH_ZLEN);
> -		if (skb == NULL)
> -			return 0;
> +		memset(buf, 0, ETH_ZLEN);	/* more efficient than doing just the needed bits */
> +		memcpy(buf, data, ETH_ZLEN);

Is this really correct?  It zeros out ETH_ZLEN bytes only to
immediately copy over all of them again.

>  		send_length = ETH_ZLEN;
> +		data = buf;
>  	}
>  
>  	/* Mask interrupts from the ethercard. 
> @@ -347,7 +349,7 @@
>  	 * trigger the send later, upon receiving a Tx done interrupt.
>  	 */
>  	 
> -	ei_block_output(dev, send_length, skb->data, output_page);
> +	ei_block_output(dev, send_length, data, output_page);
>  		
>  	if (! ei_local->txing) 
>  	{


-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org


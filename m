Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWDEAUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWDEAUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWDEAUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:20:25 -0400
Received: from xenotime.net ([66.160.160.81]:37275 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751024AbWDEAUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:20:24 -0400
Date: Tue, 4 Apr 2006 17:22:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, davej@redhat.com,
       chuckw@quantumlinux.com, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, eugene.teo@eugeneteo.net, davem@davemloft.net,
       gregkh@suse.de
Subject: Re: [patch 02/26] USB: Fix irda-usb use after use
Message-Id: <20060404172237.d08cdc43.rdunlap@xenotime.net>
In-Reply-To: <20060404235943.GC27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
	<20060404235943.GC27049@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2006 16:59:43 -0700 gregkh@suse.de wrote:

> Don't read from free'd memory after calling netif_rx().  docopy is used as
> a boolean (0 and 1) so unsigned int is sufficient.
> 
> Coverity bug #928
> 
> Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
> Cc: "David Miller" <davem@davemloft.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
> 
>  drivers/net/irda/irda-usb.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.16.1.orig/drivers/net/irda/irda-usb.c
> +++ linux-2.6.16.1/drivers/net/irda/irda-usb.c
> @@ -740,7 +740,7 @@ static void irda_usb_receive(struct urb 
>  	struct sk_buff *newskb;
>  	struct sk_buff *dataskb;
>  	struct urb *next_urb;
> -	int		docopy;
> +	unsigned int len, docopy;
>  

Is the <docopy> part of the patch just a convenience so that the patch
doesn't have to be split?  I don't see this part as critical.

>  	IRDA_DEBUG(2, "%s(), len=%d\n", __FUNCTION__, urb->actual_length);
>  	
> @@ -851,10 +851,11 @@ static void irda_usb_receive(struct urb 
>  	dataskb->dev = self->netdev;
>  	dataskb->mac.raw  = dataskb->data;
>  	dataskb->protocol = htons(ETH_P_IRDA);
> +	len = dataskb->len;
>  	netif_rx(dataskb);
>  
>  	/* Keep stats up to date */
> -	self->stats.rx_bytes += dataskb->len;
> +	self->stats.rx_bytes += len;
>  	self->stats.rx_packets++;
>  	self->netdev->last_rx = jiffies;
>  
> 

---
~Randy

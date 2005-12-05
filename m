Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVLETW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVLETW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVLETW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:22:58 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:2706 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932519AbVLETW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:22:56 -0500
Date: Mon, 5 Dec 2005 20:22:39 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Message-ID: <20051205192239.GA4150@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@vger.kernel.org
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org> <20051204234320.GA7478@linuxtv.org> <20051205110040.47adf428@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205110040.47adf428@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.190.129.65
Subject: Re: [PATCH linux-2.6.15-rc5] sk98lin: rx checksum offset not set
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005, Stephen Hemminger wrote:
> The checksum offsets for receive offload were not being set correctly.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

I can confirm that this patch fixes the problem for me.

Thanks,
Johannes

> Index: linux-2.6/drivers/net/sk98lin/skge.c
> ===================================================================
> --- linux-2.6.orig/drivers/net/sk98lin/skge.c
> +++ linux-2.6/drivers/net/sk98lin/skge.c
> @@ -818,7 +818,7 @@ uintptr_t VNextDescr;	/* the virtual bus
>  		/* set the pointers right */
>  		pDescr->VNextRxd = VNextDescr & 0xffffffffULL;
>  		pDescr->pNextRxd = pNextDescr;
> -		pDescr->TcpSumStarts = 0;
> +		if (!IsTx) pDescr->TcpSumStarts = ETH_HLEN << 16 | ETH_HLEN;
>  
>  		/* advance one step */
>  		pPrevDescr = pDescr;
> @@ -2169,7 +2169,7 @@ rx_start:	
>  		} /* frame > SK_COPY_TRESHOLD */
>  
>  #ifdef USE_SK_RX_CHECKSUM
> -		pMsg->csum = pRxd->TcpSums;
> +		pMsg->csum = pRxd->TcpSums & 0xffff;
>  		pMsg->ip_summed = CHECKSUM_HW;
>  #else
>  		pMsg->ip_summed = CHECKSUM_NONE;
> 

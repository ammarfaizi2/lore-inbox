Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270535AbUJUAia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270535AbUJUAia (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270545AbUJUAi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:38:28 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:62727 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S270439AbUJUAff
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:35:35 -0400
Date: Thu, 21 Oct 2004 10:35:03 +1000
To: "David S. Miller" <davem@davemloft.net>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, rlrevell@joe-job.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-kernel@gondor.apana.org.au, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net, netdev@oss.sgi.com,
       alain@parkautomat.net
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
Message-ID: <20041021003503.GA10391@gondor.apana.org.au>
References: <1098230132.23628.28.camel@krustophenia.net> <200410202256.56636.vda@port.imtp.ilyichevsk.odessa.ua> <1098303951.2268.8.camel@krustophenia.net> <200410202332.33583.vda@port.imtp.ilyichevsk.odessa.ua> <20041020171508.0e947d08.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020171508.0e947d08.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 05:15:08PM -0700, David S. Miller wrote:
>  
> +int netif_rx_ni(struct sk_buff *skb)
> +{
> +       int err = netif_rx(skb);
> +
> +       preempt_disable();
> +       if (softirq_pending(smp_processor_id()))
> +               do_softirq();

You need to move the netif_rx call inside the disable as otherwise
you might be checking the pending flag on the wrong CPU.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270918AbUJVJ5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270918AbUJVJ5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270930AbUJVJ5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:57:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:28077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270918AbUJVJyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:54:03 -0400
Date: Fri, 22 Oct 2004 02:51:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: xhejtman@mail.muni.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 - e1000 - page allocation failed
Message-Id: <20041022025158.7737182c.akpm@osdl.org>
In-Reply-To: <20041021225825.GA10844@electric-eye.fr.zoreil.com>
References: <20041021221622.GA11607@mail.muni.cz>
	<20041021225825.GA10844@electric-eye.fr.zoreil.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> wrote:
>
> Lukas Hejtmanek <xhejtman@mail.muni.cz> :
> [page allocation failure with e1000]
> 
> If you are using TSO, try patch below by Herbert Xu (available
> from http://marc.theaimsgroup.com/?l=linux-netdev&m=109799935603132&w=3)
> 
> --- 1.67/net/ipv4/tcp_output.c	2004-10-01 13:56:45 +10:00
> +++ edited/net/ipv4/tcp_output.c	2004-10-17 18:58:47 +10:00
> @@ -455,8 +455,12 @@
>  {
>  	struct tcp_opt *tp = tcp_sk(sk);
>  	struct sk_buff *buff;
> -	int nsize = skb->len - len;
> +	int nsize;
>  	u16 flags;
> +
> +	nsize = skb_headlen(skb) - len;
> +	if (nsize < 0)
> +		nsize = 0;
>  
>  	if (skb_cloned(skb) &&
>  	    skb_is_nonlinear(skb) &&

I'd be interested in knowing if this fixes it - I don't expect it will,
because that's a zero-order allocation failure.  He's really out of memory.

The e1000 driver has a default rx ring size of 256 which seems a bit nutty:
a back-to-back GFP_ATOMIC allocation of 256 skbs could easily exhaust the
page allocator pools.

Probably this machine needs to increase /proc/sys/vm/min_free_kbytes.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWEBNyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWEBNyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWEBNyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:54:22 -0400
Received: from stinky.trash.net ([213.144.137.162]:40087 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S964826AbWEBNyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:54:21 -0400
Message-ID: <4457648C.6020100@trash.net>
Date: Tue, 02 May 2006 15:54:20 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [netfilter-core] Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup
 in	sctp_new(), do_basic_checks()
References: <20060502113454.GA28601@elte.hu> <20060502134053.GA30917@elte.hu>
In-Reply-To: <20060502134053.GA30917@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> thinking about it, what prevents the SCTP chunk's len field from being 
> zero, and thus causing an infinite loop in for_each_sctp_chunk()? The 
> patch below should fix that.
> 
> 	Ingo
> 
> ----
> From: Ingo Molnar <mingo@elte.hu>
> 
> fix infinite loop in the SCTP-netfilter code: check SCTP chunk size to 
> guarantee progress of for_each_sctp_chunk(). (all other uses of 
> for_each_sctp_chunk() are preceded by do_basic_checks(), so this fix 
> should be complete.)
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> Index: linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
> ===================================================================
> --- linux.orig/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
> +++ linux/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
> @@ -227,6 +227,15 @@ static int do_basic_checks(struct ip_con
>  	flag = 0;
>  
>  	for_each_sctp_chunk (skb, sch, _sch, offset, count) {
> +		unsigned int len = (htons(sch->length) + 3) & ~3;
> +
> +		/*
> +		 * Dont get into a loop with zero-sized or negative
> +		 * length values:
> +		 */
> +		if (!len || len >= skb->len)
> +			goto fail;
> +

I just came up with a similar fix :) I think I'm going to take
my own patch though because its IMO slightly nicer. Thanks anyway.


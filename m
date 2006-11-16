Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031166AbWKPLaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031166AbWKPLaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 06:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031163AbWKPLaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 06:30:08 -0500
Received: from stinky.trash.net ([213.144.137.162]:18821 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1031162AbWKPLaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 06:30:07 -0500
Message-ID: <455C4BBA.2010800@trash.net>
Date: Thu, 16 Nov 2006 12:30:02 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Faidon Liambotis <paravoid@debian.org>
CC: coreteam@netfilter.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [netfilter-core] [PATCH 2.6.19-rc6] netfilter: fix panic on	ip_conntrack_h323
 with CONFIG_IP_NF_CT_ACCT
References: <20061116104419.GA8807@mail.cube.gr>
In-Reply-To: <20061116104419.GA8807@mail.cube.gr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Faidon Liambotis wrote:
> H.323 connection tracking code calls ip_ct_refresh_acct() when
> processing RCFs and URQs but passes NULL as the skb.
> When CONFIG_IP_NF_CT_ACCT is enabled, the connection tracking core tries
> to derefence the skb, which results in an obvious panic.
> A similar fix was applied on the SIP connection tracking code some time
> ago.

Good catch, but the fix is wrong and will lead to double accounting
of the skb. The correct fix is to use ip_ct_refresh() instead,
which only updates the timeout. Can you send a new patch please?

> Signed-off-by: Faidon Liambotis <paravoid@debian.org>
> 
> --- a/net/ipv4/netfilter/ip_conntrack_helper_h323.c	2006-11-15 19:07:50.000000000 +0200
> +++ b/net/ipv4/netfilter/ip_conntrack_helper_h323.c	2006-11-16 11:09:46.000000000 +0200
> @@ -1417,7 +1417,7 @@ static int process_rcf(struct sk_buff **
>  		DEBUGP
>  		    ("ip_ct_ras: set RAS connection timeout to %u seconds\n",
>  		     info->timeout);
> -		ip_ct_refresh_acct(ct, ctinfo, NULL, info->timeout * HZ);
> +		ip_ct_refresh_acct(ct, ctinfo, *pskb, info->timeout * HZ);
>  
>  		/* Set expect timeout */
>  		read_lock_bh(&ip_conntrack_lock);
> @@ -1465,7 +1465,7 @@ static int process_urq(struct sk_buff **
>  	info->sig_port[!dir] = 0;
>  
>  	/* Give it 30 seconds for UCF or URJ */
> -	ip_ct_refresh_acct(ct, ctinfo, NULL, 30 * HZ);
> +	ip_ct_refresh_acct(ct, ctinfo, *pskb, 30 * HZ);
>  
>  	return 0;
>  }
> 


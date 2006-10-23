Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWJWLR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWJWLR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 07:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWJWLR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 07:17:58 -0400
Received: from stinky.trash.net ([213.144.137.162]:40837 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751911AbWJWLR5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 07:17:57 -0400
Message-ID: <453CA4E2.4080704@trash.net>
Date: Mon, 23 Oct 2006 13:17:54 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Amit Choudhary <amit2030@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc2] [REVISED] net/ipv4/multipath_wrandom.c: check
 kmalloc() return value.
References: <20061022235958.b31d7529.amit2030@gmail.com>
In-Reply-To: <20061022235958.b31d7529.amit2030@gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------050006010508040401060609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050006010508040401060609
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Amit Choudhary wrote:
> Description: Check the return value of kmalloc() in function wrandom_set_nhinfo(), in file net/ipv4/multipath_wrandom.c.
> 
> Signed-off-by: Amit Choudhary <amit2030@gmail.com>
> 
> diff --git a/net/ipv4/multipath_wrandom.c b/net/ipv4/multipath_wrandom.c
> index 92b0482..bcdb1f1 100644
> --- a/net/ipv4/multipath_wrandom.c
> +++ b/net/ipv4/multipath_wrandom.c
> @@ -242,6 +242,9 @@ static void wrandom_set_nhinfo(__be32 ne
>  		target_route = (struct multipath_route *)
>  			kmalloc(size_rt, GFP_ATOMIC);
>  
> +		if (!target_route)
> +			goto error;
> +
>  		target_route->gw = nh->nh_gw;
>  		target_route->oif = nh->nh_oif;
>  		memset(&target_route->rcu, 0, sizeof(struct rcu_head));
> @@ -263,6 +266,9 @@ static void wrandom_set_nhinfo(__be32 ne
>  		target_dest = (struct multipath_dest*)
>  			kmalloc(size_dst, GFP_ATOMIC);
>  
> +		if (!target_dest)
> +			goto error;
> +
>
>  		target_dest->nh_info = nh;
>  		target_dest->network = network;
>  		target_dest->netmask = netmask;
> @@ -275,6 +281,7 @@ static void wrandom_set_nhinfo(__be32 ne
>  	 * we are finished
>  	 */
>  
> + error:
>  	spin_unlock_bh(&state[state_idx].lock);
>  }


Thats slightly better than before, but since no errors are propagated
back to the routing code I think it would still crash later on.
A better idea would be to mark this crap BROKEN until it is really
fixed, so people won't accidentally enable it (which is enough
to cause problems).

Signed-off-by: Patrick McHardy <kaber@trash.net>


--------------050006010508040401060609
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 5572071..9ff5616 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -124,8 +124,8 @@ config IP_ROUTE_MULTIPATH
 	  if a matching packet arrives.
 
 config IP_ROUTE_MULTIPATH_CACHED
-	bool "IP: equal cost multipath with caching support (EXPERIMENTAL)"
-	depends on IP_ROUTE_MULTIPATH
+	bool "IP: equal cost multipath with caching support (BROKEN)"
+	depends on IP_ROUTE_MULTIPATH && BROKEN
 	help
 	  Normally, equal cost multipath routing is not supported by the
 	  routing cache. If you say Y here, alternative routes are cached

--------------050006010508040401060609--

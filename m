Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbULOBF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbULOBF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbULOBEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:04:46 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:50192 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261836AbULOBBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:01:43 -0500
Message-ID: <41BF7F55.4090906@conectiva.com.br>
Date: Tue, 14 Dec 2004 22:03:33 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-net@vger.kernel.or, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipx/: make some code static
References: <20041215005925.GC11972@stusta.de>
In-Reply-To: <20041215005925.GC11972@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACKed, this was because a long time ago I planned to ressurect the SPX code.

- Arnaldo

Adrian Bunk wrote:
> The patch below makes some needlessly global code static.
> 
> 
> diffstat output:
>  include/net/ipx.h  |    8 --------
>  net/ipx/af_ipx.c   |   10 ++++++++--
>  net/ipx/ipx_proc.c |    6 +++---
>  3 files changed, 11 insertions(+), 13 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc3-mm1-full/include/net/ipx.h.old	2004-12-14 14:55:42.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/include/net/ipx.h	2004-12-14 14:57:03.000000000 +0100
> @@ -139,14 +139,6 @@
>  		ipxitf_down(intrfc);
>  }
>  
> -extern void __ipxitf_down(struct ipx_interface *intrfc);
> -
> -static __inline__ void __ipxitf_put(struct ipx_interface *intrfc)
> -{
> -	if (atomic_dec_and_test(&intrfc->refcnt))
> -		__ipxitf_down(intrfc);
> -}
> -
>  static __inline__ void ipxrtr_hold(struct ipx_route *rt)
>  {
>  	        atomic_inc(&rt->refcnt);
> --- linux-2.6.10-rc3-mm1-full/net/ipx/af_ipx.c.old	2004-12-14 14:56:12.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/net/ipx/af_ipx.c	2004-12-14 14:57:28.000000000 +0100
> @@ -291,7 +291,7 @@
>  }
>  #endif
>  
> -void __ipxitf_down(struct ipx_interface *intrfc)
> +static void __ipxitf_down(struct ipx_interface *intrfc)
>  {
>  	struct sock *s;
>  	struct hlist_node *node, *t;
> @@ -335,6 +335,12 @@
>  	spin_unlock_bh(&ipx_interfaces_lock);
>  }
>  
> +static __inline__ void __ipxitf_put(struct ipx_interface *intrfc)
> +{
> +	if (atomic_dec_and_test(&intrfc->refcnt))
> +		__ipxitf_down(intrfc);
> +}
> +
>  static int ipxitf_device_event(struct notifier_block *notifier,
>  				unsigned long event, void *ptr)
>  {
> @@ -1629,7 +1635,7 @@
>  	return rc;
>  }
>  
> -int ipx_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt)
> +static int ipx_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt)
>  {
>  	/* NULL here for pt means the packet was looped back */
>  	struct ipx_interface *intrfc;
> --- linux-2.6.10-rc3-mm1-full/net/ipx/ipx_proc.c.old	2004-12-14 14:57:40.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/net/ipx/ipx_proc.c	2004-12-14 14:57:56.000000000 +0100
> @@ -287,21 +287,21 @@
>  	return 0;
>  }
>  
> -struct seq_operations ipx_seq_interface_ops = {
> +static struct seq_operations ipx_seq_interface_ops = {
>  	.start  = ipx_seq_interface_start,
>  	.next   = ipx_seq_interface_next,
>  	.stop   = ipx_seq_interface_stop,
>  	.show   = ipx_seq_interface_show,
>  };
>  
> -struct seq_operations ipx_seq_route_ops = {
> +static struct seq_operations ipx_seq_route_ops = {
>  	.start  = ipx_seq_route_start,
>  	.next   = ipx_seq_route_next,
>  	.stop   = ipx_seq_route_stop,
>  	.show   = ipx_seq_route_show,
>  };
>  
> -struct seq_operations ipx_seq_socket_ops = {
> +static struct seq_operations ipx_seq_socket_ops = {
>  	.start  = ipx_seq_socket_start,
>  	.next   = ipx_seq_socket_next,
>  	.stop   = ipx_seq_interface_stop,
> 
> 

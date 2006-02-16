Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWBPOpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWBPOpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWBPOpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:45:05 -0500
Received: from shamrock.dyndns.org ([213.146.117.139]:29459 "EHLO
	shamrock.taprogge.wh") by vger.kernel.org with ESMTP
	id S932292AbWBPOpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:45:03 -0500
Date: Thu, 16 Feb 2006 15:44:57 +0100
From: Jens Taprogge <jlt_lk@shamrock.dyndns.org>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netfilter@lists.netfilter.org
Subject: Re: 2.6.16-rc3 panic related to IP Forwarding and/or Netfilter
Message-ID: <20060216144457.GA1576@ranger.taprogge.wh>
Mail-Followup-To: Jens Taprogge <jlt_lk@shamrock.dyndns.org>,
	Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, netfilter@lists.netfilter.org
References: <20060216001056.GA7446@ranger.taprogge.wh> <43F3C547.8050901@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F3C547.8050901@trash.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The two patches fix the panic.  However routing still does not quite
work. 

My setup consits of two masquerading gateways with local adresses
192.168.1.128 (2.6.15.1) and 192.168.3.11 (2.6.16-rc3 + patches).  They
connect the two local networks through an IPSEC tunnel.  With the exact
same setup that previously (192.168.3.11 running 2.6.13) worked I can
now only reach from 192.168.1.0/24 to 192.168.3.0/24 and not the other
way around:

Pinging from 192.168.1.128 I am getting:
	$ ping 192.168.3.15
	PING 192.168.3.15 (192.168.3.15): 56 data bytes
	64 bytes from 192.168.3.15: icmp_seq=0 ttl=63 time=127.9 ms

On the other hand pinging from 192.168.3.11 I am getting timeouts.

This is even the case if I set the nat POSTROUTING rule to: 
	$ iptables -t mangle -I PREROUTING -p esp -j MARK --set-mark 111
	$ iptables -t nat -F POSTROUTING
	$ iptables -t nat -A POSTROUTING -o ppp0 -s 192.168.3.0/24 \
		-m mark ! --mark 111 -j MASQUERADE

on both sides of the tunnel which should disable masquerading for IPSEC
packages.

However the tunnel works as soon as I completly disable masquerading.

If you need more information/testing please let me know.

Best Regards
Jens Taprogge


On Thu, Feb 16, 2006 at 01:20:23AM +0100, Patrick McHardy wrote:
> Jens Taprogge wrote:
> > Hello.
> > 
> > After upgrading from 2.6.13 an IP Masquerading router panics as soon as
> > soon as packages are forwarder (or rather should be).  As long as IP
> > Masquerading is disabled (and thus no forwarding occurs) the box runs
> > stable.
> 
> I just sent these two fixes for this and a related problem to Dave.

> [NETFILTER]: Fix xfrm lookup after SNAT
> 
> To find out if a packet needs to be handled by IPsec after SNAT, packets
> are currently rerouted in POST_ROUTING and a new xfrm lookup is done. This
> breaks SNAT of non-unicast packets to non-local addresses because the
> packet is routed as incoming packet and no neighbour entry is bound to the
> dst_entry. In general, it seems to be a bad idea to replace the dst_entry
> after the packet was already sent to the output routine because its state
> might not match what's expected.
> 
> This patch changes the xfrm lookup in POST_ROUTING to re-use the original
> dst_entry without routing the packet again. This means no policy routing
> can be used for transport mode transforms (which keep the original route)
> when packets are SNATed to match the policy, but it looks like the best
> we can do for now.
> 
> Signed-off-by: Patrick McHardy <kaber@trash.net>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> ---
> commit ee68cea2c26b7a8222f9020f54d22c6067011e8b
> tree e99b13be0392532d17a133fe6b9e7edb0a7a4de9
> parent 10ee39fe3ff618d274e1cd0f6abbc2917b736bfd
> author Patrick McHardy <kaber@trash.net> Wed, 15 Feb 2006 01:34:23 -0800
> committer David S. Miller <davem@davemloft.net> Wed, 15 Feb 2006 01:34:23 -0800
> 
>  include/linux/netfilter_ipv4.h         |    2 +-
>  net/ipv4/netfilter.c                   |   41 ++++++++++++++++++++++++++++++++
>  net/ipv4/netfilter/ip_nat_standalone.c |    6 ++---
>  3 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/netfilter_ipv4.h b/include/linux/netfilter_ipv4.h
> index fdc4a95..43c09d7 100644
> --- a/include/linux/netfilter_ipv4.h
> +++ b/include/linux/netfilter_ipv4.h
> @@ -79,7 +79,7 @@ enum nf_ip_hook_priorities {
>  
>  #ifdef __KERNEL__
>  extern int ip_route_me_harder(struct sk_buff **pskb);
> -
> +extern int ip_xfrm_me_harder(struct sk_buff **pskb);
>  #endif /*__KERNEL__*/
>  
>  #endif /*__LINUX_IP_NETFILTER_H*/
> diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
> index 52a3d7c..ed42cdc 100644
> --- a/net/ipv4/netfilter.c
> +++ b/net/ipv4/netfilter.c
> @@ -78,6 +78,47 @@ int ip_route_me_harder(struct sk_buff **
>  }
>  EXPORT_SYMBOL(ip_route_me_harder);
>  
> +#ifdef CONFIG_XFRM
> +int ip_xfrm_me_harder(struct sk_buff **pskb)
> +{
> +	struct flowi fl;
> +	unsigned int hh_len;
> +	struct dst_entry *dst;
> +
> +	if (IPCB(*pskb)->flags & IPSKB_XFRM_TRANSFORMED)
> +		return 0;
> +	if (xfrm_decode_session(*pskb, &fl, AF_INET) < 0)
> +		return -1;
> +
> +	dst = (*pskb)->dst;
> +	if (dst->xfrm)
> +		dst = ((struct xfrm_dst *)dst)->route;
> +	dst_hold(dst);
> +
> +	if (xfrm_lookup(&dst, &fl, (*pskb)->sk, 0) < 0)
> +		return -1;
> +
> +	dst_release((*pskb)->dst);
> +	(*pskb)->dst = dst;
> +
> +	/* Change in oif may mean change in hh_len. */
> +	hh_len = (*pskb)->dst->dev->hard_header_len;
> +	if (skb_headroom(*pskb) < hh_len) {
> +		struct sk_buff *nskb;
> +
> +		nskb = skb_realloc_headroom(*pskb, hh_len);
> +		if (!nskb)
> +			return -1;
> +		if ((*pskb)->sk)
> +			skb_set_owner_w(nskb, (*pskb)->sk);
> +		kfree_skb(*pskb);
> +		*pskb = nskb;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(ip_xfrm_me_harder);
> +#endif
> +
>  void (*ip_nat_decode_session)(struct sk_buff *, struct flowi *);
>  EXPORT_SYMBOL(ip_nat_decode_session);
>  
> diff --git a/net/ipv4/netfilter/ip_nat_standalone.c b/net/ipv4/netfilter/ip_nat_standalone.c
> index 92c5499..7c3f7d3 100644
> --- a/net/ipv4/netfilter/ip_nat_standalone.c
> +++ b/net/ipv4/netfilter/ip_nat_standalone.c
> @@ -235,19 +235,19 @@ ip_nat_out(unsigned int hooknum,
>  		return NF_ACCEPT;
>  
>  	ret = ip_nat_fn(hooknum, pskb, in, out, okfn);
> +#ifdef CONFIG_XFRM
>  	if (ret != NF_DROP && ret != NF_STOLEN
>  	    && (ct = ip_conntrack_get(*pskb, &ctinfo)) != NULL) {
>  		enum ip_conntrack_dir dir = CTINFO2DIR(ctinfo);
>  
>  		if (ct->tuplehash[dir].tuple.src.ip !=
>  		    ct->tuplehash[!dir].tuple.dst.ip
> -#ifdef CONFIG_XFRM
>  		    || ct->tuplehash[dir].tuple.src.u.all !=
>  		       ct->tuplehash[!dir].tuple.dst.u.all
> -#endif
>  		    )
> -			return ip_route_me_harder(pskb) == 0 ? ret : NF_DROP;
> +			return ip_xfrm_me_harder(pskb) == 0 ? ret : NF_DROP;
>  	}
> +#endif
>  	return ret;
>  }
>  

> [XFRM]: Fix SNAT-related crash in xfrm4_output_finish
> 
> When a packet matching an IPsec policy is SNATed so it doesn't match any
> policy anymore it looses its xfrm bundle, which makes xfrm4_output_finish
> crash because of a NULL pointer dereference.
> 
> This patch directs these packets to the regular output path instead. To
> avoid replicating the device/protocol assignments and statistics from
> ip_output and ip_mc_output, the packet just starts at the begining of
> the output path again and skips the next invocation of the POST_ROUTING
> hook.
> 
> Signed-off-by: Patrick McHardy <kaber@trash.net>
> 
> ---
> commit a31ab06c99e45232b742803677e88363cda2fb85
> tree 020e91264409d418d615599a5880df68ca640432
> parent ede836cd3164896d741dff1a8d7c1dc0b9b1fdf6
> author Patrick McHardy <kaber@trash.net> Wed, 15 Feb 2006 17:30:44 +0100
> committer Patrick McHardy <kaber@trash.net> Wed, 15 Feb 2006 17:30:44 +0100
> 
>  include/linux/netfilter.h |   19 +++++++++++++++----
>  include/net/ip.h          |    1 +
>  include/net/xfrm.h        |    1 -
>  net/ipv4/ip_gre.c         |    3 ++-
>  net/ipv4/ip_output.c      |   16 ++++++++++------
>  net/ipv4/ipip.c           |    3 ++-
>  net/ipv4/xfrm4_output.c   |   13 ++++++++++---
>  7 files changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
> index 4cf6088..5deacda 100644
> --- a/include/linux/netfilter.h
> +++ b/include/linux/netfilter.h
> @@ -184,8 +184,11 @@ static inline int nf_hook_thresh(int pf,
>  				 struct sk_buff **pskb,
>  				 struct net_device *indev,
>  				 struct net_device *outdev,
> -				 int (*okfn)(struct sk_buff *), int thresh)
> +				 int (*okfn)(struct sk_buff *), int thresh,
> +				 int cond)
>  {
> +	if (!cond)
> +		return 1;
>  #ifndef CONFIG_NETFILTER_DEBUG
>  	if (list_empty(&nf_hooks[pf][hook]))
>  		return 1;
> @@ -197,7 +200,7 @@ static inline int nf_hook(int pf, unsign
>  			  struct net_device *indev, struct net_device *outdev,
>  			  int (*okfn)(struct sk_buff *))
>  {
> -	return nf_hook_thresh(pf, hook, pskb, indev, outdev, okfn, INT_MIN);
> +	return nf_hook_thresh(pf, hook, pskb, indev, outdev, okfn, INT_MIN, 1);
>  }
>                     
>  /* Activate hook; either okfn or kfree_skb called, unless a hook
> @@ -224,7 +227,13 @@ static inline int nf_hook(int pf, unsign
>  
>  #define NF_HOOK_THRESH(pf, hook, skb, indev, outdev, okfn, thresh)	       \
>  ({int __ret;								       \
> -if ((__ret=nf_hook_thresh(pf, hook, &(skb), indev, outdev, okfn, thresh)) == 1)\
> +if ((__ret=nf_hook_thresh(pf, hook, &(skb), indev, outdev, okfn, thresh, 1)) == 1)\
> +	__ret = (okfn)(skb);						       \
> +__ret;})
> +
> +#define NF_HOOK_COND(pf, hook, skb, indev, outdev, okfn, cond)		       \
> +({int __ret;								       \
> +if ((__ret=nf_hook_thresh(pf, hook, &(skb), indev, outdev, okfn, INT_MIN, cond)) == 1)\
>  	__ret = (okfn)(skb);						       \
>  __ret;})
>  
> @@ -295,11 +304,13 @@ extern struct proc_dir_entry *proc_net_n
>  
>  #else /* !CONFIG_NETFILTER */
>  #define NF_HOOK(pf, hook, skb, indev, outdev, okfn) (okfn)(skb)
> +#define NF_HOOK_COND(pf, hook, skb, indev, outdev, okfn, cond) (okfn)(skb)
>  static inline int nf_hook_thresh(int pf, unsigned int hook,
>  				 struct sk_buff **pskb,
>  				 struct net_device *indev,
>  				 struct net_device *outdev,
> -				 int (*okfn)(struct sk_buff *), int thresh)
> +				 int (*okfn)(struct sk_buff *), int thresh,
> +				 int cont)
>  {
>  	return okfn(*pskb);
>  }
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 8de0697..fab3d5b 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -41,6 +41,7 @@ struct inet_skb_parm
>  #define IPSKB_XFRM_TUNNEL_SIZE	2
>  #define IPSKB_XFRM_TRANSFORMED	4
>  #define IPSKB_FRAG_COMPLETE	8
> +#define IPSKB_REROUTED		16
>  };
>  
>  struct ipcm_cookie
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index d09ca0e..d6111a2 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -866,7 +866,6 @@ extern int xfrm_state_mtu(struct xfrm_st
>  extern int xfrm_init_state(struct xfrm_state *x);
>  extern int xfrm4_rcv(struct sk_buff *skb);
>  extern int xfrm4_output(struct sk_buff *skb);
> -extern int xfrm4_output_finish(struct sk_buff *skb);
>  extern int xfrm4_tunnel_register(struct xfrm_tunnel *handler);
>  extern int xfrm4_tunnel_deregister(struct xfrm_tunnel *handler);
>  extern int xfrm6_rcv_spi(struct sk_buff **pskb, u32 spi);
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index abe2392..9981dcd 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -830,7 +830,8 @@ static int ipgre_tunnel_xmit(struct sk_b
>  	skb->h.raw = skb->nh.raw;
>  	skb->nh.raw = skb_push(skb, gre_hlen);
>  	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
> -	IPCB(skb)->flags &= ~(IPSKB_XFRM_TUNNEL_SIZE|IPSKB_XFRM_TRANSFORMED);
> +	IPCB(skb)->flags &= ~(IPSKB_XFRM_TUNNEL_SIZE | IPSKB_XFRM_TRANSFORMED |
> +			      IPSKB_REROUTED);
>  	dst_release(skb->dst);
>  	skb->dst = &rt->u.dst;
>  
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 3324fbf..57d290d 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -207,8 +207,10 @@ static inline int ip_finish_output(struc
>  {
>  #if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
>  	/* Policy lookup after SNAT yielded a new policy */
> -	if (skb->dst->xfrm != NULL)
> -		return xfrm4_output_finish(skb);
> +	if (skb->dst->xfrm != NULL) {
> +		IPCB(skb)->flags |= IPSKB_REROUTED;
> +		return dst_output(skb);
> +	}
>  #endif
>  	if (skb->len > dst_mtu(skb->dst) &&
>  	    !(skb_shinfo(skb)->ufo_size || skb_shinfo(skb)->tso_size))
> @@ -271,8 +273,9 @@ int ip_mc_output(struct sk_buff *skb)
>  				newskb->dev, ip_dev_loopback_xmit);
>  	}
>  
> -	return NF_HOOK(PF_INET, NF_IP_POST_ROUTING, skb, NULL, skb->dev,
> -		       ip_finish_output);
> +	return NF_HOOK_COND(PF_INET, NF_IP_POST_ROUTING, skb, NULL, skb->dev,
> +			    ip_finish_output,
> +			    !(IPCB(skb)->flags & IPSKB_REROUTED));
>  }
>  
>  int ip_output(struct sk_buff *skb)
> @@ -284,8 +287,9 @@ int ip_output(struct sk_buff *skb)
>  	skb->dev = dev;
>  	skb->protocol = htons(ETH_P_IP);
>  
> -	return NF_HOOK(PF_INET, NF_IP_POST_ROUTING, skb, NULL, dev,
> -		       ip_finish_output);
> +	return NF_HOOK_COND(PF_INET, NF_IP_POST_ROUTING, skb, NULL, dev,
> +		            ip_finish_output,
> +			    !(IPCB(skb)->flags & IPSKB_REROUTED));
>  }
>  
>  int ip_queue_xmit(struct sk_buff *skb, int ipfragok)
> diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> index e5cbe72..03d1374 100644
> --- a/net/ipv4/ipip.c
> +++ b/net/ipv4/ipip.c
> @@ -622,7 +622,8 @@ static int ipip_tunnel_xmit(struct sk_bu
>  	skb->h.raw = skb->nh.raw;
>  	skb->nh.raw = skb_push(skb, sizeof(struct iphdr));
>  	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
> -	IPCB(skb)->flags &= ~(IPSKB_XFRM_TUNNEL_SIZE|IPSKB_XFRM_TRANSFORMED);
> +	IPCB(skb)->flags &= ~(IPSKB_XFRM_TUNNEL_SIZE | IPSKB_XFRM_TRANSFORMED |
> +			      IPSKB_REROUTED);
>  	dst_release(skb->dst);
>  	skb->dst = &rt->u.dst;
>  
> diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
> index d4df0dd..32ad229 100644
> --- a/net/ipv4/xfrm4_output.c
> +++ b/net/ipv4/xfrm4_output.c
> @@ -152,10 +152,16 @@ error_nolock:
>  	goto out_exit;
>  }
>  
> -int xfrm4_output_finish(struct sk_buff *skb)
> +static int xfrm4_output_finish(struct sk_buff *skb)
>  {
>  	int err;
>  
> +#ifdef CONFIG_NETFILTER
> +	if (!skb->dst->xfrm) {
> +		IPCB(skb)->flags |= IPSKB_REROUTED;
> +		return dst_output(skb);
> +	}
> +#endif
>  	while (likely((err = xfrm4_output_one(skb)) == 0)) {
>  		nf_reset(skb);
>  
> @@ -178,6 +184,7 @@ int xfrm4_output_finish(struct sk_buff *
>  
>  int xfrm4_output(struct sk_buff *skb)
>  {
> -	return NF_HOOK(PF_INET, NF_IP_POST_ROUTING, skb, NULL, skb->dst->dev,
> -		       xfrm4_output_finish);
> +	return NF_HOOK_COND(PF_INET, NF_IP_POST_ROUTING, skb, NULL, skb->dst->dev,
> +			    xfrm4_output_finish,
> +			    !(IPCB(skb)->flags & IPSKB_REROUTED));
>  }


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbSJDFE1>; Fri, 4 Oct 2002 01:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbSJDFE1>; Fri, 4 Oct 2002 01:04:27 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:5899 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261478AbSJDFEZ>; Fri, 4 Oct 2002 01:04:25 -0400
Date: Fri, 4 Oct 2002 02:09:23 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Miscellaneous clean-ups
Message-ID: <20021004050923.GA2728@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, davem@redhat.com,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	netfilter-devel@lists.netfilter.org, usagi@linux-ipv6.org
References: <20021004.011315.05129566.yoshfuji@linux-ipv6.org> <20021003.103617.04446177.davem@redhat.com> <20021004.073642.125593159.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004.073642.125593159.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 04, 2002 at 07:36:42AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ escreveu:
> In article <20021003.103617.04446177.davem@redhat.com> (at Thu, 03 Oct 2002 10:36:17 -0700 (PDT)), "David S. Miller" <davem@redhat.com> says:
> 
> >    -	addr.s6_addr[15] = 1;
> >    +	addr.s6_addr32[3] = __constant_htonl(0x00000001);
> >     
> > Do not use __constant_htonl() in runtime code, use htonl().
> > Arnaldo de Melo told you this the other day for another one
> > of your patches, so you must fix this kind of stuff up before
> > I'll apply any of your patches which have this problem.
> 
> I saw many __constant_{hton,ntoh}{s,l}()s, so fixed.
> 
>       1. use s6_addrXX instead of in6_u.s6_addrXX.
>       2. avoid using magic number.
>       3. use 32bit constants.
>  -->  4. avoid __constant_{hton,ntoh}{l,s}() in runtime code.

Thank you, some still were left, but that is not a problem, we can go on fixing
it, as long as we don't introduce new instances, its OK.
 
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/addrconf.c,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 addrconf.c
> --- net/ipv6/addrconf.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv6/addrconf.c	2002/10/03 22:16:13
> @@ -172,7 +172,7 @@
>  
>  	if ((addr->s6_addr32[0] | addr->s6_addr32[1]) == 0) {
>  		if (addr->s6_addr32[2] == 0) {
> -			if (addr->in6_u.u6_addr32[3] == 0)
> +			if (addr->s6_addr32[3] == 0)
>  				return IPV6_ADDR_ANY;
>  
>  			if (addr->s6_addr32[3] == __constant_htonl(0x00000001))
                                                  ^^^^^^^^^^^
                                                  ^^^^^^^^^^^
not needed as well.

> Index: net/ipv6/icmp.c
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/icmp.c,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.12.1
> diff -u -r1.1.1.1 -r1.1.1.1.12.1
> --- net/ipv6/icmp.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv6/icmp.c	2002/09/12 09:41:58	1.1.1.1.12.1
> @@ -198,7 +198,7 @@
>  		u8 type;
>  		if (skb_copy_bits(skb, ptr+offsetof(struct icmp6hdr, icmp6_type),
>  				  &type, 1)
> -		    || !(type & 0x80))
> +		    || !(type & ICMPV6_INFOMSG_MASK))

nice, no magic numbers.

> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/netfilter/ip6_queue.c,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.12.2
> diff -u -r1.1.1.1 -r1.1.1.1.12.2
> --- net/ipv6/netfilter/ip6_queue.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv6/netfilter/ip6_queue.c	2002/09/19 03:57:51	1.1.1.1.12.2
> @@ -306,14 +306,8 @@
>  	 */
>  	if (e->info->hook == NF_IP_LOCAL_OUT) {
>  		struct ipv6hdr *iph = e->skb->nh.ipv6h;
> -		if (!(   iph->daddr.in6_u.u6_addr32[0] == e->rt_info.daddr.in6_u.u6_addr32[0]
> -                      && iph->daddr.in6_u.u6_addr32[1] == e->rt_info.daddr.in6_u.u6_addr32[1]
> -                      && iph->daddr.in6_u.u6_addr32[2] == e->rt_info.daddr.in6_u.u6_addr32[2]
> -                      && iph->daddr.in6_u.u6_addr32[3] == e->rt_info.daddr.in6_u.u6_addr32[3]
> -		      && iph->saddr.in6_u.u6_addr32[0] == e->rt_info.saddr.in6_u.u6_addr32[0]
> -		      && iph->saddr.in6_u.u6_addr32[1] == e->rt_info.saddr.in6_u.u6_addr32[1]
> -		      && iph->saddr.in6_u.u6_addr32[2] == e->rt_info.saddr.in6_u.u6_addr32[2]
> -		      && iph->saddr.in6_u.u6_addr32[3] == e->rt_info.saddr.in6_u.u6_addr32[3]))
> +		if (ipv6_addr_cmp(&iph->daddr, &e->rt_info.daddr) ||
> +		    ipv6_addr_cmp(&iph->saddr, &e->rt_info.saddr))

Cool, thank you.

- Arnaldo

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262897AbSJRGCe>; Fri, 18 Oct 2002 02:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSJRGCe>; Fri, 18 Oct 2002 02:02:34 -0400
Received: from netcore.fi ([193.94.160.1]:20238 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S262897AbSJRGCa>;
	Fri, 18 Oct 2002 02:02:30 -0400
Date: Fri, 18 Oct 2002 09:08:25 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>, <usagi@linux-ipv6.org>
Subject: Re: [PATCH] IPv6: Sevaral MLD Fixes
In-Reply-To: <20021018.125223.130322644.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.44.0210180858080.32725-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both patches appear to be fine from spec point of view at least, this is 
what should be done.

draft-ietf-magma-mld-source-02.txt in the next patch is in the working 
group last call at the moment, so it should be quite stable now.  I only 
expect some clarifications on situations where there are 
non-upgraded/upgraded MLD nodes on the link, but there shouldn't be 
anything major as far as I can see.

On Fri, 18 Oct 2002, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:

> Hi,
> 
> This patch fixes three points.
>  1. Check address in MLD Query if it is acceptable
>      - unspecified address for General Query
>      - multicast address for Multicast-Address-Specific Queries
>     Otherwise, ignore it.
>  2. send MLD for link-local addresses (except for link-local scope
>     all nodes address).
>  3. Don't send MLD for 0(reserved) scope addresses.
> 
> Patch is against linux-2.4.20-pre11.
> 
> Thanks is advance.
> 
> -------------------------------------------------------------------
> Patch-Name: Several MLD Fixes
> Patch-Id: FIX_2_4_20_pre11_MLD-20021018
> Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
> Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
> Reference: RFC2710
> -------------------------------------------------------------------
> Index: include/net/addrconf.h
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/include/net/addrconf.h,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 addrconf.h
> --- include/net/addrconf.h	2002/08/20 09:46:45	1.1.1.1
> +++ include/net/addrconf.h	2002/10/17 17:55:52
> @@ -191,5 +191,21 @@
>  	return (addr->s6_addr32[0] & __constant_htonl(0xFF000000)) == __constant_htonl(0xFF000000);
>  }
>  
> +static inline int ipv6_addr_is_ll_all_nodes(const struct in6_addr *addr)
> +{
> +	return (addr->s6_addr32[0] == htonl(0xff020000) &&
> +		addr->s6_addr32[1] == 0 &&
> +		addr->s6_addr32[2] == 0 &&
> +		addr->s6_addr32[3] == htonl(0x00000001));
> +}
> +
> +static inline int ipv6_addr_is_ll_all_routers(const struct in6_addr *addr)
> +{
> +	return (addr->s6_addr32[0] == htonl(0xff020000) &&
> +		addr->s6_addr32[1] == 0 &&
> +		addr->s6_addr32[2] == 0 &&
> +		addr->s6_addr32[3] == htonl(0x00000002));
> +}
> +
>  #endif
>  #endif
> Index: include/net/ipv6.h
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/include/net/ipv6.h,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 ipv6.h
> --- include/net/ipv6.h	2002/08/20 09:46:45	1.1.1.1
> +++ include/net/ipv6.h	2002/10/17 17:55:52
> @@ -74,6 +74,20 @@
>  #define IPV6_ADDR_RESERVED	0x2000U	/* reserved address space */
>  
>  /*
> + *	Addr scopes
> + */
> +#ifdef __KERNEL__
> +#define IPV6_ADDR_MC_SCOPE(a)	\
> +	((a)->s6_addr[1] & 0x0f)	/* nonstandard */
> +#define __IPV6_ADDR_SCOPE_INVALID	-1
> +#endif
> +#define IPV6_ADDR_SCOPE_NODELOCAL	0x01
> +#define IPV6_ADDR_SCOPE_LINKLOCAL	0x02
> +#define IPV6_ADDR_SCOPE_SITELOCAL	0x05
> +#define IPV6_ADDR_SCOPE_ORGLOCAL	0x08
> +#define IPV6_ADDR_SCOPE_GLOBAL		0x0e
> +
> +/*
>   *	fragmentation header
>   */
>  
> Index: net/ipv6/mcast.c
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/mcast.c,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.32.3
> diff -u -r1.1.1.1 -r1.1.1.1.32.3
> --- net/ipv6/mcast.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv6/mcast.c	2002/10/17 17:53:59	1.1.1.1.32.3
> @@ -18,6 +18,9 @@
>  /* Changes:
>   *
>   *	yoshfuji	: fix format of router-alert option
> + *	YOSHIFUJI Hideaki @USAGI:
> + *		- Ignore Queries for invalid addresses.
> + *		- MLD for link-local addresses.
>   */
>  
>  #define __NO_VERSION__
> @@ -405,6 +408,7 @@
>  	unsigned long resptime;
>  	struct inet6_dev *idev;
>  	struct icmp6hdr *hdr;
> +	int addr_type;
>  
>  	if (!pskb_may_pull(skb, sizeof(struct in6_addr)))
>  		return -EINVAL;
> @@ -420,6 +424,11 @@
>  	resptime = (resptime<<10)/(1024000/HZ);
>  
>  	addrp = (struct in6_addr *) (hdr + 1);
> +	addr_type = ipv6_addr_type(addrp);
> +
> +	if (addr_type != IPV6_ADDR_ANY &&
> +	    !(addr_type&IPV6_ADDR_MULTICAST))
> +		return -EINVAL;
>  
>  	idev = in6_dev_get(skb->dev);
>  
> @@ -427,7 +436,7 @@
>  		return 0;
>  
>  	read_lock(&idev->lock);
> -	if (ipv6_addr_any(addrp)) {
> +	if (addr_type == IPV6_ADDR_ANY) {
>  		for (ma = idev->mc_list; ma; ma=ma->next)
>  			igmp6_group_queried(ma, resptime);
>  	} else {
> @@ -566,11 +575,9 @@
>  static void igmp6_join_group(struct ifmcaddr6 *ma)
>  {
>  	unsigned long delay;
> -	int addr_type;
> -
> -	addr_type = ipv6_addr_type(&ma->mca_addr);
>  
> -	if ((addr_type & (IPV6_ADDR_LINKLOCAL|IPV6_ADDR_LOOPBACK)))
> +	if (IPV6_ADDR_MC_SCOPE(&ma->mca_addr) < IPV6_ADDR_SCOPE_LINKLOCAL ||
> +	    ipv6_addr_is_ll_all_nodes(&ma->mca_addr))
>  		return;
>  
>  	igmp6_send(&ma->mca_addr, ma->idev->dev, ICMPV6_MGM_REPORT);
> @@ -592,10 +599,9 @@
>  static void igmp6_leave_group(struct ifmcaddr6 *ma)
>  {
>  	int addr_type;
> -
> -	addr_type = ipv6_addr_type(&ma->mca_addr);
>  
> -	if ((addr_type & IPV6_ADDR_LINKLOCAL))
> +	if (IPV6_ADDR_MC_SCOPE(&ma->mca_addr) < IPV6_ADDR_SCOPE_LINKLOCAL ||
> +	    ipv6_addr_is_ll_all_nodes(&ma->mca_addr))
>  		return;
>  
>  	if (ma->mca_flags & MAF_LAST_REPORTER)
> 
> 

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords




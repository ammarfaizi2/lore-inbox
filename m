Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262758AbSJCGzN>; Thu, 3 Oct 2002 02:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbSJCGzM>; Thu, 3 Oct 2002 02:55:12 -0400
Received: from netcore.fi ([193.94.160.1]:38154 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S262758AbSJCGyi>;
	Thu, 3 Oct 2002 02:54:38 -0400
Date: Thu, 3 Oct 2002 10:00:00 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>, <usagi@linux-ipv6.org>
Subject: Re: [PATCH] IPv6: Allow Both IPv6 and IPv4 Sockets on the Same Port
 Number (IPV6_V6ONLY Support)
In-Reply-To: <20021003.121350.119660876.yoshfuji@linux-ipv6.org>
Message-ID: <Pine.LNX.4.44.0210030958270.4695-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please add a short description of 'bindv6only' in 
Documentation/networking/ip-sysctl.txt.

This toggle seems usable only in interface "all" context.

Didn't really look at the rest of the patch.

On Thu, 3 Oct 2002, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> Hello!
> 
> Linux IPv6 stack provides the ability for IPv6 applications to
> interoperate with IPv4 applications.  Port space for TCP (or UDP) is
> shared by IPv6 and IPv4.  This conforms to RFC2553.
> However, some kind of applications may want to restrict their use of
> an IPv6 socket to IPv6 communication only.  IPV6_V6ONLY socket option is
> defined for such applications in RFC2553bis, which is successor of RFC2553.  
> This patch allows to bind both IPv6 and IPv4 sockets with the single
> port number at the same time if IPV6_V6ONLY socket options is set to
> the IPv6 socket.
> 
> We also prohibit a completely duplicate set of (local-addr, local-port,
> remote-addr, remote-port) set even if SO_REUSEADDR is set unless
> the local address is a multicast address; it is ambiguous and it may 
> steal packets from others; i.e. a kind of DoS.
> 
> Packet delivery strategy is similar to one before, but we prefer
> IPv4 a bit.
> 
> Following patch is against linux-2.4.19.
> 
> Thank you in advance.
> 
> -------------------------------------------------------------------
> Patch-Name: Allow Both IPv6 and IPv4 Sockets on the Same Port Number (IPV6_V6ONLY Support)
> Patch-Id: FIX_2_4_19_DOUBLEBIND-20020909
> Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
> Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
> Reference: RFC2553bis
> -------------------------------------------------------------------
> Index: include/linux/in6.h
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/include/linux/in6.h,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- include/linux/in6.h	2002/08/20 09:46:34	1.1.1.1
> +++ include/linux/in6.h	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -156,6 +156,7 @@
>  #define IPV6_MTU_DISCOVER	23
>  #define IPV6_MTU		24
>  #define IPV6_RECVERR		25
> +#define IPV6_V6ONLY		26
>  
>  /* IPV6_MTU_DISCOVER values */
>  #define IPV6_PMTUDISC_DONT		0
> @@ -167,4 +168,19 @@
>  #define IPV6_FLOWINFO_SEND	33
>  
>  
> +#ifdef __KERNEL__
> +#ifndef IN6_IS_ADDR_UNSPECIFIED
> +#define IN6_IS_ADDR_UNSPECIFIED(a)			\
> +	((((a)->s6_addr32[0]) == 0) &&			\
> +	 (((a)->s6_addr32[1]) == 0) &&			\
> +	 (((a)->s6_addr32[2]) == 0) &&			\
> +	 (((a)->s6_addr32[3]) == 0))
> +#endif
> +#ifndef IN6_IS_ADDR_V4MAPPED
> +#define IN6_IS_ADDR_V4MAPPED(a)				\
> +	((((a)->s6_addr32[0]) == 0) &&			\
> +	 (((a)->s6_addr32[1]) == 0) &&			\
> +	 (((a)->s6_addr32[2]) == __constant_htonl(0x0000ffff)))
> +#endif
> +#endif
>  #endif
> Index: include/linux/sysctl.h
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/include/linux/sysctl.h,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- include/linux/sysctl.h	2002/08/20 09:46:34	1.1.1.1
> +++ include/linux/sysctl.h	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -369,7 +369,8 @@
>  	NET_IPV6_DAD_TRANSMITS=7,
>  	NET_IPV6_RTR_SOLICITS=8,
>  	NET_IPV6_RTR_SOLICIT_INTERVAL=9,
> -	NET_IPV6_RTR_SOLICIT_DELAY=10
> +	NET_IPV6_RTR_SOLICIT_DELAY=10,
> +	NET_IPV6_BINDV6ONLY=11
>  };
>  
>  /* /proc/sys/net/<protocol>/neigh/<dev> */
> Index: include/net/if_inet6.h
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/include/net/if_inet6.h,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- include/net/if_inet6.h	2002/08/20 09:46:45	1.1.1.1
> +++ include/net/if_inet6.h	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -86,6 +86,7 @@
>  	int		rtr_solicits;
>  	int		rtr_solicit_interval;
>  	int		rtr_solicit_delay;
> +	int		bindv6only;
>  
>  	void		*sysctl;
>  };
> Index: include/net/sock.h
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/include/net/sock.h,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- include/net/sock.h	2002/08/20 09:46:45	1.1.1.1
> +++ include/net/sock.h	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -171,7 +171,8 @@
>  	__u8			mc_loop:1,
>  	                        recverr:1,
>  	                        sndflow:1,
> -	                        pmtudisc:2;
> +	                        pmtudisc:2,
> +				ipv6only:1;
>  
>  	struct ipv6_mc_socklist	*ipv6_mc_list;
>  	struct ipv6_fl_socklist *ipv6_fl_list;
> Index: net/ipv4/tcp_ipv4.c
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/tcp_ipv4.c,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- net/ipv4/tcp_ipv4.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv4/tcp_ipv4.c	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -45,6 +45,14 @@
>   *	Vitaly E. Lavrov	:	Transparent proxy revived after year coma.
>   *	Andi Kleen		:	Fix new listen.
>   *	Andi Kleen		:	Fix accept error reporting.
> + *	YOSHIFUJI Hideaki @USAGI:	Reworked bind(2) behavior including:
> + *					- Allow ipv6 and ipv4 bind(2) to the
> + *					  same port if IPV6_V6ONLY socket option
> + *					  is set.
> + *					- Don't allow binding to the same
> + *					  address unless it is one of multi-
> + *					  cast address even if SO_REUSEADDR 
> + *					  is set.
>   */
>  
>  #include <linux/config.h>
> @@ -177,23 +185,92 @@
>  static inline int tcp_bind_conflict(struct sock *sk, struct tcp_bind_bucket *tb)
>  {
>  	struct sock *sk2 = tb->owners;
> -	int sk_reuse = sk->reuse;
> +	int sk_reuse, sk2_reuse;
> +	int addr_type2;
> +	int ret;
> +
> +	sk_reuse = 0;
> +	if (sk->reuse)
> +		sk_reuse |= 1;
>  	
>  	for( ; sk2 != NULL; sk2 = sk2->bind_next) {
> -		if (sk != sk2 &&
> -		    sk2->reuse <= 1 &&
> -		    sk->bound_dev_if == sk2->bound_dev_if) {
> -			if (!sk_reuse	||
> -			    !sk2->reuse	||
> -			    sk2->state == TCP_LISTEN) {
> -				if (!sk2->rcv_saddr	||
> -				    !sk->rcv_saddr	||
> -				    (sk2->rcv_saddr == sk->rcv_saddr))
> -					break;
> +		int both_specified = 0;
> +
> +		if (sk2 == sk ||
> +		    (sk2->bound_dev_if && sk->bound_dev_if &&
> +		     sk2->bound_dev_if != sk->bound_dev_if))
> +			continue;
> +
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +		if (sk2->family == AF_INET6) {
> +			struct in6_addr *sk2_rcv_saddr6 = sk2->state != TCP_TIME_WAIT ?
> +				&sk2->net_pinfo.af_inet6.rcv_saddr :
> +				&((struct tcp_tw_bucket*)sk2)->v6_rcv_saddr;
> +			if (IN6_IS_ADDR_UNSPECIFIED(sk2_rcv_saddr6))
> +				addr_type2 = IPV6_ADDR_ANY;
> +			else if (IN6_IS_ADDR_V4MAPPED(sk2_rcv_saddr6))
> +				addr_type2 = IPV6_ADDR_MAPPED;
> +			else
> +				addr_type2 = IPV6_ADDR_UNICAST;	/*XXX*/
> +		} else
> +			addr_type2 = IPV6_ADDR_MAPPED;
> +#else
> +		addr_type2 = IPV6_ADDR_MAPPED;
> +#endif
> +		if ((addr_type2 != IPV6_ADDR_MAPPED ? addr_type2 != IPV6_ADDR_ANY : sk2->rcv_saddr) &&
> +		    sk->rcv_saddr) {
> +			if (sk2->rcv_saddr != sk->rcv_saddr)
> +				continue;
> +			both_specified = 1;
> +		}
> +
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +		if (addr_type2 != IPV6_ADDR_MAPPED && sk2->net_pinfo.af_inet6.ipv6only) {
> +			continue;
> +		}
> +#endif
> +
> +		sk2_reuse = 0;
> +		if (sk2->reuse)
> +			sk2_reuse |= 1;
> +
> +		if (sk2_reuse & sk_reuse & 3) {	/* NOT && */
> +			ret = 1;
> +			if (both_specified) {
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +				struct in6_addr *sk2_daddr6 = sk2->state != TCP_TIME_WAIT ?
> +								&sk2->net_pinfo.af_inet6.daddr :
> +								&((struct tcp_tw_bucket*)sk2)->v6_daddr;
> +#endif
> +				int addr_type2d;
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +				if (sk2->family == AF_INET6) {
> +					if (IN6_IS_ADDR_UNSPECIFIED(sk2_daddr6))
> +						addr_type2d = IPV6_ADDR_ANY;
> +					else if (IN6_IS_ADDR_V4MAPPED(sk2_daddr6))
> +						addr_type2d = IPV6_ADDR_MAPPED;
> +					else
> +						addr_type2d = IPV6_ADDR_UNICAST; /*XXX*/
> +				} else
> +					addr_type2d = IPV6_ADDR_MAPPED;
> +#else
> +				addr_type2d = IPV6_ADDR_MAPPED;
> +#endif
> +				if (addr_type2d != IPV6_ADDR_MAPPED ? addr_type2d != IPV6_ADDR_ANY : sk2->daddr)
> +					continue;
> +			} else {
> +				if ((addr_type2 != IPV6_ADDR_MAPPED ? addr_type2 != IPV6_ADDR_ANY : sk2->rcv_saddr) ||
> +				     sk->rcv_saddr)
> +					continue;
>  			}
>  		}
> +		ret = 1;
> +		goto failed;
>  	}
> -	return sk2 != NULL;
> +	/* If we found a conflict, fail. */
> +	ret = sk2 != NULL;
> +failed:
> +	return ret;
>  }
>  
>  /* Obtain a reference to a local port for the given sock,
> @@ -247,10 +324,11 @@
>  				break;
>  	}
>  	if (tb != NULL && tb->owners != NULL) {
> -		if (sk->reuse > 1)
> +		ret = 1; 
> +		if (tb->fastreuse > 0 && 
> +		    sk->reuse != 0 &&
> +		    sk->state != TCP_LISTEN) {
>  			goto success;
> -		if (tb->fastreuse > 0 && sk->reuse != 0 && sk->state != TCP_LISTEN) {
> -			goto success;
>  		} else {
>  			ret = 1;
>  			if (tcp_bind_conflict(sk, tb))
> @@ -418,23 +496,31 @@
>  	struct sock *result = NULL;
>  	int score, hiscore;
>  
> -	hiscore=0;
> +	hiscore = -1;
>  	for(; sk; sk = sk->next) {
>  		if(sk->num == hnum) {
>  			__u32 rcv_saddr = sk->rcv_saddr;
>  
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +			score = 0;
> +			if (sk->family == PF_INET)
> +				score++;
> +			else if (sk->net_pinfo.af_inet6.ipv6only)
> +				continue;
> +#else
>  			score = 1;
> +#endif
>  			if(rcv_saddr) {
>  				if (rcv_saddr != daddr)
>  					continue;
> -				score++;
> +				score+=2;
>  			}
>  			if (sk->bound_dev_if) {
>  				if (sk->bound_dev_if != dif)
>  					continue;
> -				score++;
> +				score+=2;
>  			}
> -			if (score == 3)
> +			if (score == 5)
>  				return sk;
>  			if (score > hiscore) {
>  				hiscore = score;
> @@ -456,6 +542,10 @@
>  		if (sk->num == hnum &&
>  		    sk->next == NULL &&
>  		    (!sk->rcv_saddr || sk->rcv_saddr == daddr) &&
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +		    (sk->family == PF_INET ||
> +		     (sk->family == PF_INET6 && !sk->net_pinfo.af_inet6.ipv6only)) &&
> +#endif
>  		    !sk->bound_dev_if)
>  			goto sherry_cache;
>  		sk = __tcp_v4_lookup_listener(sk, daddr, hnum, dif);
> Index: net/ipv4/udp.c
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv4/udp.c,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- net/ipv4/udp.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv4/udp.c	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -61,6 +61,14 @@
>   *					return ENOTCONN for unconnected sockets (POSIX)
>   *		Janos Farkas	:	don't deliver multi/broadcasts to a different
>   *					bound-to-device socket
> + *	YOSHIFUJI Hideaki @USAGI:	Reworked bind(2) behavior, including:
> + *					- Allow ipv6 and ipv4 bind(2) to the
> + *					  same port if IPV6_V6ONLY socket opttion is
> + *					  is set.
> + *					- Don't allow binding to the same
> + *					  address unless it is one of multi-
> + *					  cast address even if SO_REUSEADDR 
> + *					  is set.
>   *
>   *
>   *		This program is free software; you can redistribute it and/or
> @@ -85,6 +93,7 @@
>  #include <linux/netdevice.h>
>  #include <net/snmp.h>
>  #include <net/ip.h>
> +#include <net/ipv6.h>
>  #include <net/protocol.h>
>  #include <linux/skbuff.h>
>  #include <net/sock.h>
> @@ -153,18 +162,88 @@
>  		udp_port_rover = snum = result;
>  	} else {
>  		struct sock *sk2;
> +		int sk_reuse, sk2_reuse;
> +		int addr_type2;
>  
> +		sk_reuse = 0;
> +		if (sk->reuse)
> +			sk_reuse |= 1;
> +		if (sk_reuse &&
> +		    MULTICAST(sk->rcv_saddr))
> +			sk_reuse |= 4;
> +
>  		for (sk2 = udp_hash[snum & (UDP_HTABLE_SIZE - 1)];
>  		     sk2 != NULL;
>  		     sk2 = sk2->next) {
> -			if (sk2->num == snum &&
> -			    sk2 != sk &&
> -			    sk2->bound_dev_if == sk->bound_dev_if &&
> -			    (!sk2->rcv_saddr ||
> -			     !sk->rcv_saddr ||
> -			     sk2->rcv_saddr == sk->rcv_saddr) &&
> -			    (!sk2->reuse || !sk->reuse))
> -				goto fail;
> +			int both_specified = 0;
> +
> +			if (sk2->num != snum ||
> +			    sk2 == sk ||
> +			    (sk2->bound_dev_if && sk->bound_dev_if &&
> +			     sk2->bound_dev_if != sk->bound_dev_if))
> +				continue;
> +
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +			if (sk2->family == AF_INET6) {
> +				if (IN6_IS_ADDR_UNSPECIFIED(&sk2->net_pinfo.af_inet6.rcv_saddr))
> +					addr_type2 = IPV6_ADDR_ANY;
> +				else if (IN6_IS_ADDR_V4MAPPED(&sk2->net_pinfo.af_inet6.rcv_saddr))
> +					addr_type2 = IPV6_ADDR_MAPPED;
> +				else
> +					addr_type2 = IPV6_ADDR_UNICAST;	/*XXX*/
> +			} else
> +				addr_type2 = IPV6_ADDR_MAPPED;
> +#else
> +			addr_type2 = IPV6_ADDR_MAPPED;
> +#endif
> +
> +			if ((addr_type2 != IPV6_ADDR_MAPPED ? addr_type2 != IPV6_ADDR_ANY : sk2->rcv_saddr) &&
> +			    sk->rcv_saddr) {
> +				if (sk2->rcv_saddr != sk->rcv_saddr)
> +					continue;
> +				both_specified = 1;
> +			}
> +
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +			if (addr_type2 != IPV6_ADDR_MAPPED && sk2->net_pinfo.af_inet6.ipv6only) {
> +				continue;
> +			}
> +#endif
> +
> +			sk2_reuse = 0;
> +			if (sk2->reuse)
> +				sk2_reuse |= 1;
> +			if (sk2_reuse &&
> +			    (addr_type2 != IPV6_ADDR_MAPPED ? (addr_type2 & IPV6_ADDR_MULTICAST) : MULTICAST(sk2->rcv_saddr)))
> +				sk2_reuse |= 4;
> +
> +			if (sk2_reuse & sk_reuse & 3) {	/* NOT && */
> +				if (sk2_reuse & sk_reuse & 4)
> +					continue;
> +				if (both_specified) {
> +					int addr_type2d;
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +					if (sk2->family == AF_INET6) {
> +						if (IN6_IS_ADDR_UNSPECIFIED(&sk2->net_pinfo.af_inet6.daddr))
> +							addr_type2d = IPV6_ADDR_ANY;
> +						else if (IN6_IS_ADDR_V4MAPPED(&sk2->net_pinfo.af_inet6.daddr))
> +							addr_type2d = IPV6_ADDR_MAPPED;
> +						else
> +							addr_type2d = IPV6_ADDR_UNICAST; /*XXX*/
> +					} else
> +						addr_type2d = IPV6_ADDR_MAPPED;
> +#else
> +					addr_type2d = IPV6_ADDR_MAPPED;
> +#endif
> +					if (addr_type2d != IPV6_ADDR_MAPPED ? addr_type2d != IPV6_ADDR_ANY : sk2->daddr)
> +						continue;
> +				} else {
> +					if ((addr_type2 != IPV6_ADDR_MAPPED ? addr_type2 != IPV6_ADDR_ANY : sk2->rcv_saddr) ||
> +					    sk->rcv_saddr)
> +						continue;
> +				}
> +			}
> +			goto fail;
>  		}
>  	}
>  	sk->num = snum;
> @@ -216,28 +295,37 @@
>  
>  	for(sk = udp_hash[hnum & (UDP_HTABLE_SIZE - 1)]; sk != NULL; sk = sk->next) {
>  		if(sk->num == hnum) {
> -			int score = 0;
> +			int score;
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +			score = 0;
> +			if(sk->family == PF_INET)
> +				score++;
> +			else if (sk->net_pinfo.af_inet6.ipv6only)
> +				continue;
> +#else
> +			score = 1;
> +#endif
>  			if(sk->rcv_saddr) {
>  				if(sk->rcv_saddr != daddr)
>  					continue;
> -				score++;
> +				score+=2;
>  			}
>  			if(sk->daddr) {
>  				if(sk->daddr != saddr)
>  					continue;
> -				score++;
> +				score+=2;
>  			}
>  			if(sk->dport) {
>  				if(sk->dport != sport)
>  					continue;
> -				score++;
> +				score+=2;
>  			}
>  			if(sk->bound_dev_if) {
>  				if(sk->bound_dev_if != dif)
>  					continue;
> -				score++;
> +				score+=2;
>  			}
> -			if(score == 4) {
> +			if(score == 9) {
>  				result = sk;
>  				break;
>  			} else if(score > badness) {
> @@ -273,6 +361,9 @@
>  		    (s->daddr && s->daddr!=rmt_addr)			||
>  		    (s->dport != rmt_port && s->dport != 0)			||
>  		    (s->rcv_saddr  && s->rcv_saddr != loc_addr)		||
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +		    (s->family != PF_INET && s->net_pinfo.af_inet6.ipv6only)	||
> +#endif
>  		    (s->bound_dev_if && s->bound_dev_if != dif))
>  			continue;
>  		break;
> Index: net/ipv6/addrconf.c
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/addrconf.c,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- net/ipv6/addrconf.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv6/addrconf.c	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -116,6 +116,7 @@
>  	MAX_RTR_SOLICITATIONS,		/* router solicits	*/
>  	RTR_SOLICITATION_INTERVAL,	/* rtr solicit interval	*/
>  	MAX_RTR_SOLICITATION_DELAY,	/* rtr solicit delay	*/
> +	bindv6only:		0,
>  };
>  
>  static struct ipv6_devconf ipv6_devconf_dflt =
> @@ -130,6 +131,7 @@
>  	MAX_RTR_SOLICITATIONS,		/* router solicits	*/
>  	RTR_SOLICITATION_INTERVAL,	/* rtr solicit interval	*/
>  	MAX_RTR_SOLICITATION_DELAY,	/* rtr solicit delay	*/
> +	bindv6only:		0,
>  };
>  
>  int ipv6_addr_type(struct in6_addr *addr)
> @@ -1879,7 +1881,7 @@
>  static struct addrconf_sysctl_table
>  {
>  	struct ctl_table_header *sysctl_header;
> -	ctl_table addrconf_vars[11];
> +	ctl_table addrconf_vars[12];
>  	ctl_table addrconf_dev[2];
>  	ctl_table addrconf_conf_dir[2];
>  	ctl_table addrconf_proto_dir[2];
> @@ -1925,6 +1927,10 @@
>  	{NET_IPV6_RTR_SOLICIT_DELAY, "router_solicitation_delay",
>           &ipv6_devconf.rtr_solicit_delay, sizeof(int), 0644, NULL,
>           &proc_dointvec_jiffies},
> +
> +	{NET_IPV6_BINDV6ONLY, "bindv6only",
> +	 &ipv6_devconf.bindv6only, sizeof(int), 0644, NULL,
> +	 &proc_dointvec},
>  
>  	{0}},
>  
> Index: net/ipv6/af_inet6.c
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/af_inet6.c,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- net/ipv6/af_inet6.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv6/af_inet6.c	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -173,6 +173,8 @@
>  	sk->net_pinfo.af_inet6.mc_loop	  = 1;
>  	sk->net_pinfo.af_inet6.pmtudisc	  = IPV6_PMTUDISC_WANT;
>  
> +	sk->net_pinfo.af_inet6.ipv6only   = ipv6_devconf.bindv6only;
> +
>  	/* Init the ipv4 part of the socket since we can have sockets
>  	 * using v6 API for ipv4.
>  	 */
> @@ -248,6 +250,8 @@
>  
>  	/* Check if the address belongs to the host. */
>  	if (addr_type == IPV6_ADDR_MAPPED) {
> +		if (sk->net_pinfo.af_inet6.ipv6only)
> +			return -EADDRNOTAVAIL;
>  		v4addr = addr->sin6_addr.s6_addr32[3];
>  		if (inet_addr_type(v4addr) != RTN_LOCAL)
>  			return -EADDRNOTAVAIL;
> Index: net/ipv6/ipv6_sockglue.c
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/ipv6_sockglue.c,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- net/ipv6/ipv6_sockglue.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv6/ipv6_sockglue.c	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -380,6 +380,15 @@
>  		retv = ipv6_flowlabel_opt(sk, optval, optlen);
>  		break;
>  
> +	case IPV6_V6ONLY:
> +		if (optlen != sizeof(int))
> +			goto e_inval;
> +		if (sk->userlocks&SOCK_BINDADDR_LOCK)
> +			goto e_inval;
> +		np->ipv6only = valbool;
> +		retv = 0;
> +		break;
> +
>  #ifdef CONFIG_NETFILTER
>  	default:
>  		retv = nf_setsockopt(sk, PF_INET6, optname, optval, 
> @@ -520,6 +529,10 @@
>  
>  	case IPV6_FLOWINFO_SEND:
>  		val = np->sndflow;
> +		break;
> +
> +	case IPV6_V6ONLY:
> +		val = np->ipv6only;
>  		break;
>  
>  	default:
> Index: net/ipv6/tcp_ipv6.c
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/tcp_ipv6.c,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- net/ipv6/tcp_ipv6.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv6/tcp_ipv6.c	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -14,6 +14,14 @@
>   *
>   *	Fixes:
>   *	Hideaki YOSHIFUJI	:	sin6_scope_id support
> + *	YOSHIFUJI Hideaki @USAGI:	Reworked bind(2) behavior, including:
> + *					- Allow ipv6 and ipv4 bind(2) to the
> + *					  same port if IPV6_V6ONLY socket
> + *					  option is set.
> + *					- Don't allow binding to the same
> + *					  address unless it is one of multi-
> + *					  cast address even if SO_REUSEADDR 
> + *					  is set.
>   *
>   *	This program is free software; you can redistribute it and/or
>   *      modify it under the terms of the GNU General Public License
> @@ -137,28 +145,70 @@
>  			goto success;
>  		} else {
>  			struct sock *sk2 = tb->owners;
> -			int sk_reuse = sk->reuse;
> -			int addr_type = ipv6_addr_type(&sk->net_pinfo.af_inet6.rcv_saddr);
> +			int sk_reuse, sk2_reuse;
> +			struct in6_addr *sk_rcv_saddr6 = sk->state != TCP_TIME_WAIT ? 
> +								&sk->net_pinfo.af_inet6.rcv_saddr:
> +								&((struct tcp_tw_bucket*)sk)->v6_rcv_saddr;
> +			int addr_type = ipv6_addr_type(sk_rcv_saddr6),
> +			    addr_type2;
> +
> +			sk_reuse = 0;
> +			if (sk->reuse)
> +				sk_reuse |= 1;
>  
>  			/* We must walk the whole port owner list in this case. -DaveM */
>  			for( ; sk2 != NULL; sk2 = sk2->bind_next) {
> -				if (sk != sk2 &&
> -				    sk->bound_dev_if == sk2->bound_dev_if) {
> -					if (!sk_reuse	||
> -					    !sk2->reuse	||
> -					    sk2->state == TCP_LISTEN) {
> -						/* NOTE: IPv6 tw bucket have different format */
> -						if (!sk2->rcv_saddr	||
> -						    addr_type == IPV6_ADDR_ANY ||
> -						    !ipv6_addr_cmp(&sk->net_pinfo.af_inet6.rcv_saddr,
> -								   sk2->state != TCP_TIME_WAIT ?
> -								   &sk2->net_pinfo.af_inet6.rcv_saddr :
> -								   &((struct tcp_tw_bucket*)sk)->v6_rcv_saddr) ||
> -						    (addr_type==IPV6_ADDR_MAPPED && sk2->family==AF_INET &&
> -						     sk->rcv_saddr==sk2->rcv_saddr))
> -							break;
> +				int both_specified = 0;
> +				struct in6_addr *sk2_rcv_saddr6;
> +				if (sk2 == sk ||
> +				    (sk2->bound_dev_if && sk->bound_dev_if &&
> +				     sk2->bound_dev_if != sk->bound_dev_if))
> +					continue;
> +				sk2_rcv_saddr6 = sk2->state != TCP_TIME_WAIT ?
> +							&sk2->net_pinfo.af_inet6.rcv_saddr :
> +							&((struct tcp_tw_bucket*)sk2)->v6_rcv_saddr;
> +
> +				if ((addr_type2 != IPV6_ADDR_MAPPED ? addr_type2 != IPV6_ADDR_ANY : sk2->rcv_saddr) &&
> +				    (addr_type != IPV6_ADDR_MAPPED ? addr_type != IPV6_ADDR_ANY : sk->rcv_saddr)) {
> +					if (addr_type2 == IPV6_ADDR_MAPPED || addr_type == IPV6_ADDR_MAPPED) {
> +						if (addr_type2 != addr_type ||
> +						    sk2->rcv_saddr != sk->rcv_saddr)
> +							continue;
> +					} else {
> +						if (ipv6_addr_cmp(sk2_rcv_saddr6, sk_rcv_saddr6))
> +							continue;
>  					}
> +					both_specified = 1;
>  				}
> +
> +				if ((addr_type2 == IPV6_ADDR_MAPPED &&
> +				     addr_type != IPV6_ADDR_MAPPED && sk->net_pinfo.af_inet6.ipv6only) ||
> +				    (addr_type == IPV6_ADDR_MAPPED &&
> +				     addr_type2 != IPV6_ADDR_MAPPED && sk2->net_pinfo.af_inet6.ipv6only)) {
> +					continue;
> +				}
> +
> +				sk2_reuse = 0;
> +				if (sk2->reuse)
> +					sk2_reuse |= 1;
> +
> +				if (sk2_reuse & sk_reuse & 3) { /* NOT && */
> +					ret = 1;
> +					if (both_specified) {
> +						struct in6_addr *sk2_daddr6 = sk2->state != TCP_TIME_WAIT ?
> +										&sk2->net_pinfo.af_inet6.daddr :
> +										&((struct tcp_tw_bucket*)sk2)->v6_daddr;
> +						int addr_type2d = sk2->family == AF_INET6 ? ipv6_addr_type(sk2_daddr6) : IPV6_ADDR_MAPPED;
> +						if (addr_type2d != IPV6_ADDR_MAPPED ? addr_type2d != IPV6_ADDR_ANY : sk2->daddr)
> +							continue;
> +					} else {
> +						if ((addr_type2 != IPV6_ADDR_MAPPED ? addr_type2 != IPV6_ADDR_ANY : sk2->rcv_saddr) || 
> +						    (addr_type != IPV6_ADDR_MAPPED ? addr_type != IPV6_ADDR_ANY : sk->rcv_saddr))
> +							continue;
> +					}
> +				}
> +				ret = 1;
> +				goto fail_unlock;
>  			}
>  			/* If we found a conflict, fail. */
>  			ret = 1;
> @@ -601,6 +651,9 @@
>  		struct sockaddr_in sin;
>  
>  		SOCK_DEBUG(sk, "connect: ipv4 mapped\n");
> +
> +		if (sk->net_pinfo.af_inet6.ipv6only)
> +			return -ENETUNREACH;
>  
>  		sin.sin_family = AF_INET;
>  		sin.sin_port = usin->sin6_port;
> Index: net/ipv6/udp.c
> ===================================================================
> RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/udp.c,v
> retrieving revision 1.1.1.1
> retrieving revision 1.1.1.1.8.1
> diff -u -r1.1.1.1 -r1.1.1.1.8.1
> --- net/ipv6/udp.c	2002/08/20 09:47:02	1.1.1.1
> +++ net/ipv6/udp.c	2002/09/11 03:30:27	1.1.1.1.8.1
> @@ -11,7 +11,16 @@
>   *
>   *	Fixes:
>   *	Hideaki YOSHIFUJI	:	sin6_scope_id support
> + *	YOSHIFUJI Hideaki @USAGI:	Reworked bind(2) behavior, including:
> + *					- Allow ipv6 and ipv4 bind(2) to the
> + *					  same port if IPV6_V6ONLY socket
> + *					  option is set.
> + *					- Don't allow binding to the same
> + *					  address unless it is one of multi-
> + *					  cast address even if SO_REUSEADDR 
> + *					  is set.
>   *
> + *
>   *	This program is free software; you can redistribute it and/or
>   *      modify it under the terms of the GNU General Public License
>   *      as published by the Free Software Foundation; either version
> @@ -98,23 +107,72 @@
>  		udp_port_rover = snum = result;
>  	} else {
>  		struct sock *sk2;
> -		int addr_type = ipv6_addr_type(&sk->net_pinfo.af_inet6.rcv_saddr);
> +		int sk_reuse, sk2_reuse;
> +		int addr_type = ipv6_addr_type(&sk->net_pinfo.af_inet6.rcv_saddr),
> +		    addr_type2;
> +
> +		sk_reuse = 0;
> +		if (sk->reuse)
> +			sk_reuse |= 1;
> +		if (sk_reuse &&
> +		    (addr_type != IPV6_ADDR_MAPPED ? (addr_type & IPV6_ADDR_MULTICAST) : MULTICAST(sk->rcv_saddr)))
> +			sk_reuse |= 4;
>  
>  		for (sk2 = udp_hash[snum & (UDP_HTABLE_SIZE - 1)];
>  		     sk2 != NULL;
>  		     sk2 = sk2->next) {
> -			if (sk2->num == snum &&
> -			    sk2 != sk &&
> -			    sk2->bound_dev_if == sk->bound_dev_if &&
> -			    (!sk2->rcv_saddr ||
> -			     addr_type == IPV6_ADDR_ANY ||
> -			     !ipv6_addr_cmp(&sk->net_pinfo.af_inet6.rcv_saddr,
> -					    &sk2->net_pinfo.af_inet6.rcv_saddr) ||
> -			     (addr_type == IPV6_ADDR_MAPPED &&
> -			      sk2->family == AF_INET &&
> -			      sk->rcv_saddr == sk2->rcv_saddr)) &&
> -			    (!sk2->reuse || !sk->reuse))
> -				goto fail;
> +			int both_specified = 0;
> +
> +			if (sk2->num != snum ||
> +			    sk2 == sk ||
> +			    (sk2->bound_dev_if && sk->bound_dev_if &&
> +			     sk2->bound_dev_if != sk->bound_dev_if))
> +				continue;
> +
> +			addr_type2 = sk2->family == AF_INET6 ? ipv6_addr_type(&sk2->net_pinfo.af_inet6.rcv_saddr) : IPV6_ADDR_MAPPED;
> +
> +			if ((addr_type2 != IPV6_ADDR_MAPPED ? addr_type2 != IPV6_ADDR_ANY : sk2->rcv_saddr) &&
> +			    (addr_type != IPV6_ADDR_MAPPED ? addr_type != IPV6_ADDR_ANY : sk->rcv_saddr)) {
> +				if (addr_type2 == IPV6_ADDR_MAPPED || addr_type == IPV6_ADDR_MAPPED) {
> +					if (addr_type2 != addr_type ||
> +					    sk2->rcv_saddr != sk->rcv_saddr)
> +						continue;
> +				} else {
> +					if (ipv6_addr_cmp(&sk2->net_pinfo.af_inet6.rcv_saddr,
> +							  &sk->net_pinfo.af_inet6.rcv_saddr))
> +						continue;
> +				}
> +				both_specified = 1;
> +			}
> +
> +			if ((addr_type2 == IPV6_ADDR_MAPPED && 
> +			     addr_type != IPV6_ADDR_MAPPED && sk->net_pinfo.af_inet6.ipv6only) ||
> +			    (addr_type == IPV6_ADDR_MAPPED &&
> +			     addr_type2 != IPV6_ADDR_MAPPED && sk2->net_pinfo.af_inet6.ipv6only)) {
> +				continue;
> +			}
> +
> +			sk2_reuse = 0;
> +			if (sk2->reuse)
> +				sk2_reuse |= 1;
> +			if (sk2_reuse &&
> +			    (addr_type2 != IPV6_ADDR_MAPPED ? (addr_type2 & IPV6_ADDR_MULTICAST) : MULTICAST(sk2->rcv_saddr)))
> +				sk2_reuse |= 4;
> +
> +			if (sk2_reuse & sk_reuse & 3) {	/* NOT && */
> +				if (sk2_reuse & sk_reuse & 4)
> +					continue;
> +				if (both_specified) {
> +					int addr_type2d = sk2->family == AF_INET6 ? ipv6_addr_type(&sk2->net_pinfo.af_inet6.daddr) : IPV6_ADDR_MAPPED;
> +					if (addr_type2d != IPV6_ADDR_MAPPED ? addr_type2d != IPV6_ADDR_ANY : sk2->daddr)
> +						continue;
> +				} else {
> +					if ((addr_type2 != IPV6_ADDR_MAPPED ? addr_type2 != IPV6_ADDR_ANY : sk2->rcv_saddr) || 
> +					    (addr_type != IPV6_ADDR_MAPPED ? addr_type != IPV6_ADDR_ANY : sk->rcv_saddr))
> +						continue;
> +				}
> +			}
> +			goto fail;
>  		}
>  	}
>  
> @@ -221,6 +279,8 @@
>  	int			err;
>  
>  	if (usin->sin6_family == AF_INET) {
> +		if (sk->net_pinfo.af_inet6.ipv6only)
> +			return -EAFNOSUPPORT;
>  		err = udp_connect(sk, uaddr, addr_len);
>  		goto ipv4_connected;
>  	}
> @@ -256,6 +316,9 @@
>  	if (addr_type == IPV6_ADDR_MAPPED) {
>  		struct sockaddr_in sin;
>  
> +		if (sk->net_pinfo.af_inet6.ipv6only)
> +			return -ENETUNREACH;
> +
>  		sin.sin_family = AF_INET;
>  		sin.sin_addr.s_addr = daddr->s6_addr32[3];
>  		sin.sin_port = usin->sin6_port;
> @@ -783,8 +846,11 @@
>  	fl.oif = 0;
>  
>  	if (sin6) {
> -		if (sin6->sin6_family == AF_INET)
> +		if (sin6->sin6_family == AF_INET) {
> +			if (sk->net_pinfo.af_inet6.ipv6only)
> +				return -EAFNOSUPPORT;
>  			return udp_sendmsg(sk, msg, ulen);
> +		}
>  
>  		if (addr_len < SIN6_LEN_RFC2133)
>  			return -EINVAL;
> @@ -830,6 +896,9 @@
>  
>  	if (addr_type == IPV6_ADDR_MAPPED) {
>  		struct sockaddr_in sin;
> +
> +		if (sk->net_pinfo.af_inet6.ipv6only)
> +			return -ENETUNREACH;
>  
>  		sin.sin_family = AF_INET;
>  		sin.sin_addr.s_addr = daddr->s6_addr32[3];
> 
> 

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbREEGdR>; Sat, 5 May 2001 02:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132352AbREEGdG>; Sat, 5 May 2001 02:33:06 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:55658 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S131191AbREEGcu>; Sat, 5 May 2001 02:32:50 -0400
Date: Sat, 5 May 2001 08:32:39 +0200
From: Cliff Albert <cliff@oisec.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (was Re: 2.4.4 & IPv6 oopses)
Message-ID: <20010505083239.A28963@oisec.net>
In-Reply-To: <Pine.LNX.4.21.0105041357150.17065-100000@kepler.agaran.6bone.pl> <Pine.LNX.4.33.0105041709450.31252-100000@netcore.fi> <15091.23396.515412.928664@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <15091.23396.515412.928664@pizda.ninka.net>; from davem@redhat.com on Fri, May 04, 2001 at 06:46:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 06:46:12PM -0700, David S. Miller wrote:

> Pekka Savola writes:
>  > struct in6_addr *saddr = NULL;
>  > [...]
>  >         if (skb && ipv6_chk_addr(&skb->nh.ipv6h->saddr, dev))
>  >                 saddr = &skb->nh.ipv6h->saddr;
>  > [...]
>  > 	ndisc_send_ns(dev, neigh, target, target, saddr);
>  > [...]
>  > This check apparently fails? and saddr is left null.
> 
> Yes, it can fail, and this is normal.  The problem is in
> ndisc_send_ns().
> 
>  > in ndisc_send_ns, NULL saddr is checked:
>  > 
>  > send_llinfo = dev->addr_len && ipv6_addr_type(saddr) != IPV6_ADDR_ANY;
>  > 
>  > which make a null ptr dereference.  send_llinfo check was added recently
>  > to fix RFC incompliancy a week or so ago.
> 
> A few lines later we setup saddr properly if it is NULL, what we need
> to do is either:
> 
> 1) Move that "if (saddr == NULL)" code block up above the send_llinfo
>    check.
> 
>    I think this would break the thing the send_llinfo check
>    was meant to fix, but I can't be sure.
> 
> 2) Just check for NULL saddr in the send_llinfo check and if NULL
>    then send_llinfo is set to zero.
> 
> For now, I've put solution #2 into my tree, patch attached below.
> 
> --- linux/net/ipv6/ndisc.c.~1~	Thu May  3 00:01:10 2001
> +++ linux/net/ipv6/ndisc.c	Fri May  4 18:44:54 2001
> @@ -382,7 +382,7 @@
>  	int send_llinfo;
>  
>  	len = sizeof(struct icmp6hdr) + sizeof(struct in6_addr);
> -	send_llinfo = dev->addr_len && ipv6_addr_type(saddr) != IPV6_ADDR_ANY;
> +	send_llinfo = dev->addr_len && saddr && ipv6_addr_type(saddr) != IPV6_ADDR_ANY;
>  	if (send_llinfo)
>  		len += NDISC_OPT_SPACE(dev->addr_len);
>  

This patch fixed ALL my ICMPv6 related problems. Thanks!

-- 
Cliff Albert		| IRCNet:    #linux.nl, #ne2000, #linux, #freebsd.nl
cliff@oisec.net		| 	     #openbsd, #ipv6, #cu2.nl
-[ICQ: 18461740]--------| 6BONE:     CA2-6BONE       RIPE:     CA3348-RIPE

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVCBJ2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVCBJ2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVCBJ1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:27:25 -0500
Received: from [62.206.217.67] ([62.206.217.67]:9380 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262238AbVCBJ0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:26:45 -0500
Message-ID: <422586D1.5000609@trash.net>
Date: Wed, 02 Mar 2005 10:26:41 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: mukesh agrawal <mukesh@cs.cmu.edu>
CC: coreteam@netfilter.org, netfilter-devel@lists.netfilter.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] [PATCH 2.6.10 1/1] netfilter: fix crash on	nat+icmp
 packets
References: <Pine.LNX.4.61.0503011830590.31296@slash.mukesh.agrawals.org>
In-Reply-To: <Pine.LNX.4.61.0503011830590.31296@slash.mukesh.agrawals.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mukesh agrawal wrote:

> The cause of the crash is that udp_manip_pkt reads *pskb into iph before 
> calling skb_ip_make_writable, and fails to update iph after the call. 
> Since skb_ip_make_writable may delete the original skb when it makes a 
> copy, a page fault may occur when udp_manip_pkt later dereferences iph.

This bug has already been fixed in 2.6.11-rc.

Regards
Patrick

> 
> diff -uprN linux-2.6.10.orig/net/ipv4/netfilter/ip_nat_proto_udp.c 
> linux-2.6.10.fixed/net/ipv4/netfilter/ip_nat_proto_udp.c
> --- linux-2.6.10.orig/net/ipv4/netfilter/ip_nat_proto_udp.c    
> 2004-12-24 16:34:01.000000000 -0500
> +++ linux-2.6.10.fixed/net/ipv4/netfilter/ip_nat_proto_udp.c    
> 2005-03-01 19:32:21.000000000 -0500
> @@ -95,6 +95,9 @@ udp_manip_pkt(struct sk_buff **pskb,
> 
>      if (!skb_ip_make_writable(pskb, hdroff + sizeof(hdr)))
>          return 0;
> +    /* skb_ip_make_writable may have copied the skb, and deleted
> +       the original */
> +    iph = (struct iphdr *)((*pskb)->data + iphdroff);
> 
>      hdr = (void *)(*pskb)->data + hdroff;
>      if (maniptype == IP_NAT_MANIP_SRC) {
> 


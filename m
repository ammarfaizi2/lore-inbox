Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbREMNdd>; Sun, 13 May 2001 09:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbREMNdO>; Sun, 13 May 2001 09:33:14 -0400
Received: from quechua.inka.de ([212.227.14.2]:5186 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S261342AbREMNdK>;
	Sun, 13 May 2001 09:33:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Question about ipip implementation
In-Reply-To: <20010511173940.A418@Hews1193nrc>
Organization: private Linux site, southern Germany
Date: Sun, 13 May 2001 15:16:28 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14yvjd-0002Rw-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I read net/ipv4/ipip.c. It seems to me that ipip_rcv() function after
> "unwrapping" tunelled IP packet creates "virtual Ethernet header" and submit

Does it? ipip_rcv() does this:

	iph = skb->nh.iph;
	skb->mac.raw = skb->nh.raw;

i.e. the "MAC header" pointer of the packet is the same as the IP
header, iow. no MAC header available

	skb->nh.raw = skb->data;

Although I don't exactly understand this :-) it does not add a header

	memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));

this must be cleared before processing the packet

	skb->protocol = __constant_htons(ETH_P_IP);
	skb->pkt_type = PACKET_HOST;

mark it as an IP packet

	read_lock(&ipip_lock);
	if ((tunnel = ipip_tunnel_lookup(iph->saddr, iph->daddr)) != NULL) {
		tunnel->stat.rx_packets++;
		tunnel->stat.rx_bytes += skb->len;
		skb->dev = tunnel->dev;

mark the incoming device

		dst_release(skb->dst);
		skb->dst = NULL;
#ifdef CONFIG_NETFILTER
		nf_conntrack_put(skb->nfct);
		skb->nfct = NULL;
#ifdef CONFIG_NETFILTER_DEBUG
		skb->nf_debug = 0;
#endif
#endif

more clearing of fields / release of resources associated with the packet

		ipip_ecn_decapsulate(iph, skb);

handle ECN flags

		netif_rx(skb);

The packet as submitted starts with the IP header and the skb pointers
are set up so that the MAC header has zero size.

Olaf

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWG1FaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWG1FaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWG1FaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:30:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15847
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751285AbWG1FaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:30:11 -0400
Date: Thu, 27 Jul 2006 22:30:10 -0700 (PDT)
Message-Id: <20060727.223010.63131639.davem@davemloft.net>
To: gerrit@erg.abdn.ac.uk
Cc: akpm@osdl.org, yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru,
       jmorris@namei.org, kaber@coreworks.de, pekkas@netcore.fi,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2.6.18-rc1-mm2 1/3] net: UDP-Lite generic support
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607141719.02766@strip-the-willow>
References: <200607141719.02766@strip-the-willow>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Date: Fri, 14 Jul 2006 17:19:02 +0100

> Generic support (header files, configuration, and documentation) for
> the UDP-Lite protocol (RFC 3828).

Gerrit, I tried to bring myself over the edge to accept this
work and push it into my net-2.6.19 tree,  but I simply can't
The amount of code duplication is absolutely enormous and
totally unnecessary.

With proper abstractions, you can easily add UDP-lite support to the
existing UDP code.  And I would really like it to be in that format
before we put it into the tree.

Then all you need to do is something like add:

	__u16             pcslen;
	__u16             pcrlen;
/* checksum coverage set indicators used by pcflag */
#define UDPLITE_SEND_CC   0x1
#define UDPLITE_RECV_CC   0x2
	__u8              pcflag;

to struct udp_sock.

Add the seperate udp_port_rover and udlite_hash[] table to udp.c, make
the latter sized by UDP_HTABLE_SIZE, with suitable exports, and share
the udp_hash_lock for mutual exclusion.  Finally, parameterize all the
UDP hash table routines to take a hash table base and a port rover
pointer so that they can operate on both UDP and UDP-Lite sockets
transparently.

Next make 2 top-level routines for things like udp_err() etc.
So that you can go:

/* Common code */
static void __udp_err(struct sock *sk, struct sk_buff *skb, int type, int code, u32 info)
{
	struct inet_sock *inet;
	int type = skb->h.icmph->type;
	int code = skb->h.icmph->code;
	int harderr, err;

	if (sk == NULL) {
		ICMP_INC_STATS_BH(ICMP_MIB_INERRORS);
    	  	return;	/* No socket for error */
	}

	err = 0;
	harderr = 0;
	inet = inet_sk(sk);

	switch (type) {
 ...
	}

	/*
	 *      RFC1122: OK.  Passes ICMP errors back to application, as per 
	 *	4.1.3.3.
	 */
	if (!inet->recverr) {
		if (!harderr || sk->sk_state != TCP_ESTABLISHED)
			goto out;
	} else {
		ip_icmp_error(sk, skb, err, uh->dest, info, (u8*)(uh+1));
	}
	sk->sk_err = err;
	sk->sk_error_report(sk);
out:
	sock_put(sk);
}

void udp_err(struct sk_buff *skb, u32 info)
{
	struct iphdr *iph = (struct iphdr*)skb->data;
	struct udphdr *uh = (struct udphdr*)(skb->data+(iph->ihl<<2));
	int type = skb->h.icmph->type;
	int code = skb->h.icmph->code;
	struct sock *sk;

	sk = udp_v4_lookup(udp_hash,
			   iph->daddr, uh->dest, iph->saddr,
			   uh->source, skb->dev->ifindex);
	__udp_err(sk, skb, type, code, info);
}

void udplite_err(struct sk_buff *skb, u32 info)
{
	struct iphdr *iph = (struct iphdr*)skb->data;
	struct udphdr *uh = (struct udphdr*)(skb->data+(iph->ihl<<2));
	int type = skb->h.icmph->type;
	int code = skb->h.icmph->code;
	struct sock *sk;

	sk = udp_v4_lookup(udplite_hash,
			   iph->daddr, uh->dest, iph->saddr,
			   uh->source, skb->dev->ifindex);
	__udp_err(sk, skb, type, code, info);
}

Make similar abstractions for the send and recive path processing,
substituting in the specific UDP vs. UDP-Lite header and
checksum semantic handling along the way.

It's mostly clerical work, but it will mean that we will have one
copy of all this code and as a result we won't even need a config
option for UDP-Lite.

Thanks.


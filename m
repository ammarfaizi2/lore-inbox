Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263239AbREaV0W>; Thu, 31 May 2001 17:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbREaV0N>; Thu, 31 May 2001 17:26:13 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:34294 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263239AbREaVZ7>; Thu, 31 May 2001 17:25:59 -0400
Message-ID: <3B16A7E0.2070008@earthlink.net>
Date: Thu, 31 May 2001 16:21:52 -0400
From: Brad Chapman <kakadu@earthlink.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i586; en-US; C-UPD: MaxLinux0301) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Defragging/refragging IPv6 packets
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   My name is Brad Chapman and I am currently attempting to port the
iptables ip_conntrack component of Netfilter to the IPv6 protocol. My
port is almost feature-complete, but I cannot figure out how to properly
defragment/refragment IPv6 packets. Also, I have written an IPv6 header
parsing function to grab headers from the IPv6 header chain. I would
appreciate some feedback on that as well. Below are some code examples.


DEFRAGGING PACKETS:

/* Returns defragged sk_buff, or NULL */
/* FIXME: is this the "right" way to do it? -- BC */
struct sk_buff *ip6_ct_gather_frags(struct sk_buff *skb)
{
#ifdef CONFIG_NETFILTER_DEBUG
	unsigned int old_debug = skb->nf_debug;
#endif
	struct frag_hdr *fhdr = (struct frag_hdr *)
				ipv6_get_header(skb->nh.ipv6h,
						NEXTHDR_FRAGMENT,
						NULL);
	local_bh_disable();
	if (!ipv6_reassembly(skb, (u8 *)fhdr))
		return NULL;
	local_bh_enable();

	skb->nfcache |= NFC_ALTERED;
#ifdef CONFIG_NETFILTER_DEBUG
	skb->nf_debug = old_debug;
#endif
	return skb;
}

REFRAGGING PACKETS:

/* This gets the fragmentable part - I think -- BC */
static int ip6_refrag_getfrag(const void *data, struct in6_addr *addr,
			      char *buff, unsigned int offset, unsigned int len)
{
	return 0;
}

static unsigned int ip6_refrag(unsigned int hooknum,
			      struct sk_buff **pskb,
			      const struct net_device *in,
			      const struct net_device *out,
			      int (*okfn)(struct sk_buff *))
{
	struct frag_hdr *fhdr = (struct frag_hdr *)
				ipv6_get_header((*pskb)->nh.ipv6h,
						NEXTHDR_FRAGMENT,
						NULL);
	struct flowi *flow;
	int ret;
	__u8 protonum;

	/* Verify the protocol */
	if (!ipv6_get_header((*pskb)->nh.ipv6h, NEXTHDR_PROTOANY, &protonum))
		return NF_DROP;

	/* We've seen it coming out the other side: confirm */
	ip6_confirm(hooknum, pskb, in, out, okfn);

	/* Local packets are never produced too large for their
	   interface.  We degfragment them at LOCAL_OUT, however,
	   so we have to refragment them here. */
	if ((fhdr) && !(fhdr->frag_off & htons(IP6_NON_FRAG_OFFSET))) {

		/* Build the flowlabel */
                flow.proto = (int)protonum;
		ipv6_addr_copy(flow.fl6_src, (*pskb)->nh.ipv6h->saddr);
		ipv6_addr_copy(flow.fl6_dst, (*pskb)->nh.ipv6h->daddr);
		flow.fl6_flowlabel = 0;
		
		if (protonum == NEXTHDR_TCP) {
			flow.uli_u.ports.sport = (*pskb)->nh.tcph->sport;
			flow.uli_u.ports.dport = (*pskb)->nh.tcph->dport;
		}
		else if (protonum == NEXTHDR_UDP) {
			flow.uli_u.ports.sport = (*pskb)->nh.udph->sport;
			flow.uli_u.ports.dport = (*pskb)->nh.udph->dport;
		}
		else if (protonum == NEXTHDR_ICMP) {
                        struct icmp6hdr *icmph;
			icmph = (struct icmp6hdr *)ipv6_get_header((*pskb)->nh.ipv6h,
								   NEXTHDR_ICMP,
								   NULL);
			if (!icmph)
				return NF_DROP;
			
			flow.uli_u.icmpt.type = icmph->icmp6_type;
			flow.uli_u.icmpt.code = icmph->icmp6_code;
		}
		else
			return NF_DROP;
		
		ret = ip6_build_xmit((*pskb)->sk,
				     ip6_refrag_getfrag,
				     (*pskb)->data,
				     flow,
				     (*pskb)->nh.ipv6h->payload_len,
				     NULL, 0, 0);		

		if (ret < 0)
			return NF_DROP;
		return NF_STOLEN;
	}                       	
	return NF_ACCEPT;
}

PARSING IPV6 HEADERS

/* Find a particular header in the IPv6 header chains */
struct ipv6_opt_hdr *
ipv6_get_header(const struct ipv6hdr *ipv6h,
		__u8 header,
		__u8 *result)
{
	struct ipv6_opt_hdr *newhdr = NULL;
	__u8 *hdrptr = (__u8 *)&ipv6h->nexthdr;
	int hdrlen, length;

	IP_NF_ASSERT(header != NEXTHDR_NONE);
	IP_NF_ASSERT(*hdrptr != NEXTHDR_NONE);

	/* Start bouncing */
	length = sizeof(struct ipv6hdr);
	hdrlen = 0;
	while (*hdrptr != NEXTHDR_NONE)
	{
		if (header == NEXTHDR_PROTOANY &&
		    (*hdrptr == NEXTHDR_TCP ||
		     *hdrptr == NEXTHDR_UDP ||
		     *hdrptr == NEXTHDR_ICMP) &&
		    result != NULL)
		{
			*result = *hdrptr;
			newhdr = (struct ipv6_opt_hdr *)hdrptr;
			break;
		} else if (*hdrptr == header) {
			newhdr = (struct ipv6_opt_hdr *)hdrptr;
			break;
		} else if (hdrlen > length) {
			break;
		}
		hdrlen = sizeof((__u8 *)hdrptr);
		hdrptr = (__u8 *)(hdrptr + hdrlen);
		length -= hdrlen;
	}
	return newhdr;
}




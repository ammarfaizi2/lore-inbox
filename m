Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWDQM2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWDQM2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 08:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWDQM2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 08:28:32 -0400
Received: from icarai.midiacom.uff.br ([200.20.10.66]:50869 "EHLO
	MIDIACOM.UFF.BR") by vger.kernel.org with ESMTP id S1750805AbWDQM2b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 08:28:31 -0400
Subject: Packet Transmit Amateur progammer!!
From: Felipe Maya <fmay@midiacom.uff.br>
To: linux mailing-list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 09:31:59 -0400
Message-Id: <1145280720.6657.18.camel@fmay.midiacom.uff.br>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am trying to send one packet in one Congestion Agent.  I am
Amateur kernel programmer, I want to know what is wrong in this
source?? 

Thanks for Help.

int packet_probe(struct sock *sk){
	const struct inet_connection_sock *icsk = inet_csk(sk);
	struct inet_sock *inet = inet_sk(sk);
	struct tcp_sock *tp = tcp_sk(sk);
	struct sk_buff *skb;
	struct tcphdr *tcph;
	struct iphdr *iph;
	size_t tcp_header_size, tlen;
	
	unsigned char data[700];
	
	switch(sk->sk_state){
		case TCP_LISTEN:
		case TCP_ESTABLISHED:
		break;
		default:	
			goto out;
		break;
	}
	tcp_header_size = MAX_TCP_HEADER + sizeof(data);
	//skb = alloc_skb(sizeof(*pack), sk->sk_allocation);
	skb = alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC);
	if (skb == NULL){
		return -1;
	}
	// Reserve space for headers and prepare control bits
	skb_reserve(skb, MAX_TCP_HEADER);
	skb->csum = 0;
	TCP_SKB_CB(skb)->flags =  TCPCB_FLAG_PSH;//(TCPCB_FLAG_ACK | TCPCB_FLAG_RST);
	TCP_SKB_CB(skb)->sacked = 0;
	skb_shinfo(skb)->tso_segs = 1;
	skb_shinfo(skb)->tso_size = 0;

	//Acceptable Sequence
	if (!before(tp->snd_una+tp->snd_wnd, tp->snd_nxt)){
		TCP_SKB_CB(skb)->seq = tp->snd_nxt;
	}
	else{
		TCP_SKB_CB(skb)->seq = tp->snd_una+tp->snd_wnd;
	}
	
	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
	TCP_SKB_CB(skb)->when = tcp_time_stamp;

	tp->retrans_stamp = TCP_SKB_CB(skb)->when;
	skb_header_release(skb);
	__skb_queue_tail(&sk->sk_write_queue, skb);
	sk_charge_skb(sk, skb);
	//Number of segments in one skb (No. packs)
	tp->packets_out += skb_shinfo(skb)->tso_segs;
	//++++++Send packet//////////////////
	if (icsk->icsk_ca_ops->rtt_sample){
		__net_timestamp(skb);
	}
	//Clone skb if is necesary make retranmit 
	//if (unlikely(skb_cloned(skb))) skb = pskb_copy(skb, GFP_ATOMIC);
	//else skb = skb_clone(skb, GFP_ATOMIC);
	//if (unlikely(!skb)) return -ENOBUFS;
	
	// Build TCP header and checksum it
	tcph = (struct tcphdr *) skb_push(skb, MAX_TCP_HEADER);
	skb->h.th = tcph;
	skb_set_owner_w(skb, sk);

	tcph->source = inet->sport;
	tcph->dest = inet->dport;
	tcph->seq = htonl(TCP_SKB_CB(skb)->seq);
	tcph->ack_seq = htonl(tp->rcv_nxt);
	//*(((__u16 *)tcph) + 6)	= htons(((MAX_TCP_HEADER >> 2) << 12) | tcb->flags);

	tcph->check = 0;
	tcph->urg_ptr = 0;
	tcph->urg = 0;
	
	//IP header
	tlen = sizeof(struct iphdr);
	iph = (struct iphdr *) __skb_put(skb, tlen);
	iph->version = 4;
	iph->ihl = 5;
	iph->tos = inet->tos;
	iph->frag_off = 0;
	//iph->ttl = inet->ttl;
	iph->daddr = inet->daddr;
	iph->saddr = inet->saddr;
	iph->protocol = sk->sk_protocol;
	iph->tot_len = htons(tlen);
	skb->nh.iph = iph;

	TCP_ECN_send(sk, tp, skb, tcp_header_size);
	
	/////////////////////////////////////
	TCP_INC_STATS(TCP_MIB_ACTIVEOPENS);

	// Timer for repeating the packet probe until an answer
	//inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
	//			  inet_csk(sk)->icsk_rto, TCP_RTO_MAX);

	return 1;
out:
	return 0;
}


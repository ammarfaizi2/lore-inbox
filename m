Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRCPVRP>; Fri, 16 Mar 2001 16:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131352AbRCPVRF>; Fri, 16 Mar 2001 16:17:05 -0500
Received: from imr1.ericy.com ([208.237.135.240]:26847 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id <S131346AbRCPVQx>;
	Fri, 16 Mar 2001 16:16:53 -0500
Message-ID: <7E67DE81C0B6D311B30500805FFEBAAE03078E3E@lmc35.lmc.ericsson.se>
From: "Mathieu Giguere (LMC)" <lmcmgig@lmc.ericsson.se>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Mathieu Giguere (LMC)" <lmcmgig@lmc.ericsson.se>,
        "Claude LeFrancois (LMC)" <lmcclef@lmc.ericsson.se>
Subject: UDP stop transmitting packets!!!
Date: Fri, 16 Mar 2001 16:16:08 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I will try to explain your the situation of test:

kernel 2.2.17 (yeah an old one but the goal of this comments is for future
kernel to remove this littel bug)
You need to stress your network (4 pings in fload mode with packet size of
125 bytes should do the thing)
And you pass some traffic on a UDP socket port something.

What append if you look in /proc/net/udp
you will see the rx_queue column going up (no problem with that)
but when you reach the maximum queue size, all packet to be drop.

you can see why in the 2 function here:

net/ipv4/udp.c

static int udp_queue_rcv_skb(struct sock * sk, struct sk_buff *skb)
{
	/*
	 *	Charge it to the socket, dropping if the queue is full.
	 */

#if defined(CONFIG_FILTER) && defined(CONFIG_UDP_DELAY_CSUM)
	if (sk->filter && skb->ip_summed != CHECKSUM_UNNECESSARY) {
		if ((unsigned short)csum_fold(csum_partial(skb->h.raw,
skb->len, skb->csum))) {
			udp_statistics.UdpInErrors++;
			ip_statistics.IpInDiscards++;
			ip_statistics.IpInDelivers--;
			kfree_skb(skb);
			return -1;
		}
		skb->ip_summed = CHECKSUM_UNNECESSARY;
	}
#endif

//	When you try to queue the message it will faild because the queue is
full
	if (sock_queue_rcv_skb(sk,skb)<0) {
		udp_statistics.UdpInErrors++;
		ip_statistics.IpInDiscards++;
		ip_statistics.IpInDelivers--;
		kfree_skb(skb);
		return -1;
	}
	udp_statistics.UdpInDatagrams++;
	return 0;
}


include/net/sock.h

extern __inline__ int sock_queue_rcv_skb(struct sock *sk, struct sk_buff
*skb)
{
#ifdef CONFIG_FILTER
	struct sk_filter *filter;
#endif
	/* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
	   number of warnings when compiling with -W --ANK
	 */

//you try to check if you have enough space and if not you discard the
packet (ok fine)
	if (atomic_read(&sk->rmem_alloc) + skb->truesize >=
(unsigned)sk->rcvbuf)
		return -ENOMEM;

#ifdef CONFIG_FILTER
	if ((filter = sk->filter) != NULL && sk_filter(skb, filter))
		return -EPERM;	/* Toss packet */
#endif /* CONFIG_FILTER */

	skb_set_owner_r(skb, sk);
	skb_queue_tail(&sk->receive_queue, skb);
	if (!sk->dead)
		sk->data_ready(sk,skb->len);
	return 0;
}


The problem with the previous code, when the queue become full (for any
reason) you don't try to de-queue packet form it.
So no packet can be process and all are reject by udp
(udp_statistics.UdpInErrors++;)

A possible solution can be something like that:
try to de-queue packets when the queue is full! (a little protection here)

	if (atomic_read(&sk->rmem_alloc) + skb->truesize >=
(unsigned)sk->rcvbuf) {
	     	if (!sk->dead) sk->data_ready(sk,0);
		return -ENOMEM;
	}




/mathieu


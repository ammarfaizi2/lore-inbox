Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279303AbRKAQrW>; Thu, 1 Nov 2001 11:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279305AbRKAQrN>; Thu, 1 Nov 2001 11:47:13 -0500
Received: from ns.suse.de ([213.95.15.193]:3087 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279303AbRKAQrB>;
	Thu, 1 Nov 2001 11:47:01 -0500
Date: Thu, 1 Nov 2001 17:46:56 +0100
From: Andi Kleen <ak@suse.de>
To: Joris van Rantwijk <joris@deadlock.et.tudelft.nl>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        "A.N.Kuznetsov" <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
Message-ID: <20011101174656.A8627@wotan.suse.de>
In-Reply-To: <p733d3yr2b1.fsf@amdsim2.suse.de> <Pine.LNX.4.21.0111011603040.25072-100000@deadlock.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.21.0111011603040.25072-100000@deadlock.et.tudelft.nl>; from joris@deadlock.et.tudelft.nl on Thu, Nov 01, 2001 at 04:18:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 04:18:27PM +0100, Joris van Rantwijk wrote:
> Ah, right. I suspected there was a good reason not to do it, or it
> would have been done ages ago.
> But it's still a bit weird isn't it ?
> You sure won't find this in man packet(7).
>
I would more consider it a bug. I didn't know about it while writing 
packet(7)

Here is a patch.

-Andi

--- linux-2.4.13-work/net/packet/af_packet.c-PACKET	Tue Aug  7 17:30:50 2001
+++ linux-2.4.13-work/net/packet/af_packet.c	Thu Nov  1 17:38:12 2001
@@ -250,6 +250,9 @@
 	if (skb->pkt_type == PACKET_LOOPBACK)
 		goto out;
 
+	if (sk->num != htons(ETH_P_ALL) && skb->protocol != sk->num) 
+		goto out; 
+
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL)
 		goto oom;
 
@@ -413,6 +416,10 @@
 		goto drop;
 
 	sk = (struct sock *) pt->data;
+
+	if (sk->num != htons(ETH_P_ALL) && skb->protocol != sk->num) 
+		goto drop; 
+
 	po = sk->protinfo.af_packet;
 
 	skb->dev = dev;
@@ -824,7 +831,8 @@
 	}
 
 	sk->num = protocol;
-	sk->protinfo.af_packet->prot_hook.type = protocol;
+	/* XXX Always bind to ETH_P_ALL to catch outgoing packets. */ 
+	sk->protinfo.af_packet->prot_hook.type = htons(ETH_P_ALL);
 	sk->protinfo.af_packet->prot_hook.dev = dev;
 
 	sk->protinfo.af_packet->ifindex = dev ? dev->ifindex : 0;
@@ -973,7 +981,7 @@
 	sk->protinfo.af_packet->prot_hook.data = (void *)sk;
 
 	if (protocol) {
-		sk->protinfo.af_packet->prot_hook.type = protocol;
+		sk->protinfo.af_packet->prot_hook.type = htons(ETH_P_ALL);
 		dev_add_pack(&sk->protinfo.af_packet->prot_hook);
 		sock_hold(sk);
 		sk->protinfo.af_packet->running = 1;

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSF1C5T>; Thu, 27 Jun 2002 22:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317037AbSF1C5S>; Thu, 27 Jun 2002 22:57:18 -0400
Received: from ns.suse.de ([213.95.15.193]:33806 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317036AbSF1C5R>;
	Thu, 27 Jun 2002 22:57:17 -0400
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: hurwitz@lanl.gov, linux-kernel@vger.kernel.org
Subject: Re: zero-copy networking & a performance drop
References: <Pine.LNX.4.44.0206271545220.17078-100000@alvie-mail.lanl.gov.suse.lists.linux.kernel> <Pine.LNX.4.33.0206271513320.13651-100000@w-nivedita2.des.beaverton.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Jun 2002 04:59:36 +0200
In-Reply-To: Nivedita Singhvi's message of "28 Jun 2002 00:35:31 +0200"
Message-ID: <p73n0tgm7l3.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nivedita Singhvi <niv@us.ibm.com> writes:
> 	
> there are possibly many different scenario's here, and
> I'm probably missing the most obvious causes...

There is one problem with the TCP csum-copy to user RX implementation. When the
fast path misses (process not scheduling in time for some reason) the 
remaining packet is taken care of by the delack timer. This adds considerable
latency to the ACK generation (worst case 1/50s), because the stack does not
generate send the ack earlier when 2*rcvmss data is received  and can be 
visible as latency to user space in protocols that send lots of small messages.

csum-copy-to-user makes only sense when the NIC doesn't support hardware
checksumming, otherwise it is better to just queue and do a normal copy
and avoid these latencies.

I'm using this patch (should apply to any 2.4.4+ and 2.5). It essentially
disables most of the RX user context TCP for NICs with hardware checksums
(except for the usual processing as part of socket lock). IMHO the user 
context code (prequeue etc.) is not too useful because of the latencies it 
adds and it would be best to drop it. Most NICs should have hardware 
checksumming these days and those that don't are likely slow enough (old 
Realtek) to not need any special hacks.

With that patch it also makes even more sense to go for a SSE optimized
copy-to-user to get more speed out of networking.

Regarding the RX slowdown: I think there was some slowdown in chatroom
when the zero-copy TX stack was introduced. chatroom is horrible 
benchmark in itself, but the stack work should not have slowed it down.
It's possible that it is fixed by this patch too; i haven't checked.

-Andi

diff -urN linux-2.4.18.tmp/net/ipv4/tcp_ipv4.c linux-2.4.18.SuSE/net/ipv4/tcp_ipv4.c
--- linux-2.4.18.tmp/net/ipv4/tcp_ipv4.c	Mon Apr 15 14:43:40 2002
+++ linux-2.4.18.SuSE/net/ipv4/tcp_ipv4.c	Mon Apr 15 16:19:52 2002
@@ -1767,7 +1775,7 @@
 	bh_lock_sock(sk);
 	ret = 0;
 	if (!sk->lock.users) {
-		if (!tcp_prequeue(sk, skb))
+		if (skb->ip_summed != CHECKSUM_NONE || !tcp_prequeue(sk, skb))
 			ret = tcp_v4_do_rcv(sk, skb);
 	} else
 		sk_add_backlog(sk, skb);


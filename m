Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267472AbUHWHkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267472AbUHWHkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 03:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUHWHkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 03:40:41 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:51137 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S267472AbUHWHk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 03:40:26 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'David Meybohm'" <dmeybohm@bellsouth.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Mon, 23 Aug 2004 10:40:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040823033805.GA4103@localhost>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSIwzyaJQhy42HzT5mLDzYMuoJq1AAIuOrg
Message-Id: <S267472AbUHWHk0/20040823074026Z+654@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So to summarize the AC issue;

There is an AC whose "real" failure is a simple programming error. Normally
it had to have two different IP adresses, one for 192.168.77.0 subnet, the
other for 192.168.1.0 subnet. Indeed it has two addresses but the address at
192.168.1.1 is wrongly bound to TCP/IP socket.

If everything were correct, when I would ping 192.168.1.1, it would return a
ping from 192.168.1.1. But now when I ping 192.168.1.1, it just discards the
packet. That lies in the source of this trouble.

I am extremely glad to have got a solution for this issue in less than three
days by fanatical assistance from the linux-kernel mailing list. Everything
has been put on place and two networks are bound together perfectly.
Technically, this event shows what an open-source O/S can do in case of
network anomalies.

However; for now I wish to get deeper into the kernel networking code to
continue my started work even I resolved this issue. This way, I think I
will be able to handle possible future troubles much easier.

Today, I have discovered that NAT does not handle packets correctly if the
return address is different from the intended destination. That is, in a
complex network network, if a node is sending a packet through another
address (even if this packet is fully correct in checksums, unlike this
exceptional trouble, which is now a patched issue), NAT will not be able to
correctly translate packets. I thought it could have been resolved by
disabling rp_filter in /proc/../conf/*, but it was not correct.

So for now, I wish to implement another patch to be able to transparently
surpass this exceptional failure in the AC just to learn some more about the
kernel and packet mangling.

1. The system must think that it is sending the packet to 192.168.1.1 even
if it will be mangled by the kernel to be sent to 192.168.77.1. All three
checksums should be correct (IP, TCP and UDP) so that the remote node will
receive packets correctly.

2. The system must think that it is receiving packets from 192.168.77.1,
indeed before the kernel patch was applied, the packets had a source address
of 192.168.1.1, but they had incorrect checksums in the underlying protocols
(TCP and UDP) so that our system would drop all that was received. Now I
will have to update the CRC's in these corrupted packets with the correct
ones.

In order to establish the first;

- Ip_output.c should be patched so that, when the condition matches, the
system will mangle the destination address of the outgoing packet and append
correct checksums to the IP header.

- After that it should be ensured that the underlying protocols also compute
the correct checksum using the mangled destination address in their
psuedo-headers. [ Perhaps this is already done automatically by a call to a
function ]

In order to establish the second;

- Ip_input.c should be unpatched for now, since our aim is much different.
It will receive a packet from the 192.168.1.1, and leave the address and
checksum in it, unchanged.

- tcp_input.c and udp.c now would be in action to decode and put the data in
the socket buffer. They would naturally construct the psuedo-headers using
the destination address of 192.168.1.1, and as in the beginning, the
checksums will be voided.

- These two codes should be patched in such a way that they re-compute the
checksums whilst they are copying them in to the datagram buffer using the
function int skb_copy_and_csum_datagram_iovec(). This is not a normal
behaviour of operation, but simply ignoring checksums would cause other
clients to fail, even if the linux machine just ignores the wrong CRC's and
copies the data to the socket buffer. 

This issue is not critical now because the "critical" part is gone, it is
just an experimentation with the code, but I would be glad to receive any
contribution from the mailing-list. 

Best Regards...


-----Original Message-----
From: David Meybohm [mailto:dmeybohm@bellsouth.net] 
Sent: Monday, August 23, 2004 5:38 AM
To: Josan Kadett
Cc: 'Brad Campbell'; linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

The attached patch might work. It changes the IP source address from
192.168.1.1 to 192.168.77.1 and then recalculates the IP header
checksum. (I haven't tested it, though).

Do I understand you correctly that the IP checksum is calculated
correctly, but for the address 192.168.1.1, and the UDP and TCP
checksums are computed as if the address was 192.168.77.1?  If so, I
think this should work...

Now, can you please oblige us with the name of the manufacturers of the
broken router (as someone else also previously requested), so they can
be properly publicly ridiculed?  :-)


Hope it helps,

Dave


---


diff -puN net/ipv4/ip_input.c~ip-ignore-csum net/ipv4/ip_input.c
--- v2.6.8/net/ipv4/ip_input.c~ip-ignore-csum	2004-08-22
22:56:34.000000000 -0400
+++ v2.6.8-dym/net/ipv4/ip_input.c	2004-08-22 23:07:26.000000000 -0400
@@ -355,6 +355,27 @@ drop:
         return NET_RX_DROP;
 }
 
+static inline void mangle_addr_and_csum(struct iphdr *iph)
+{
+#define MANGLE_SADDR_IN   htonl(0xc0a80101)
+#define MANGLE_SADDR_OUT  htonl(0xc0a84d01)
+
+	if (iph->saddr != MANGLE_SADDR_IN)
+		return;
+
+	/* Change the source address from 192.168.1.1 to 192.168.77.1 and
+	 * correct the checksum. */
+	iph->saddr = MANGLE_SADDR_OUT;
+	iph->check = 0;
+	iph->check = ip_fast_csum((u8 *)iph, iph->ihl);
+
+	/* Make sure the checksum is correct now. */
+	if (ip_fast_csum((u8 *)iph, iph->ihl) != 0) {
+		printk(KERN_ERR "checksum %08x -> %08x failed! (%04x)\n",
+		       MANGLE_SADDR_IN, iph->saddr, iph->check);
+	}
+}
+
 /*
  * 	Main IP Receive routine.
  */ 
@@ -399,6 +420,9 @@ int ip_rcv(struct sk_buff *skb, struct n
 
 	iph = skb->nh.iph;
 
+	/* Take care of broken router. */
+	mangle_addr_and_csum(iph);
+
 	if (ip_fast_csum((u8 *)iph, iph->ihl) != 0)
 		goto inhdr_error; 
 

_




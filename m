Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUHWE0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUHWE0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 00:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267383AbUHWE0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 00:26:24 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:13699 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S267395AbUHWE0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 00:26:06 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'David Meybohm'" <dmeybohm@bellsouth.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Mon, 23 Aug 2004 07:26:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040823033805.GA4103@localhost>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSIwzyaJQhy42HzT5mLDzYMuoJq1AACWXgg
Message-Id: <S267395AbUHWE0G/20040823042606Z+490@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The device is a Cisco AS3640-T1 but it is not the fault of the device but
our enforcing an unusual configuration in order to connect two networks to
each other. This way we thought it would cut some extra work out, I
investigated the configuration and I believed in the fact that Linux can
handle this anomaly.

Indeed, we do try to connect two networks without the necessary equipment,
and it is at edge of a successful completion.

I tried another patch that is so similar to the code you submitted, indeed
now the linux machine can communicate with the device without any problem.
But there is only one thing left, I'd be extremely glad if you assist in
this last issue so that I will have completed what I started;

Now the system receives the packets from the correct source which is
192.168.77.1. But now, I am trying to establish a "destination nat" scheme,
which will enable this linux machine to act as a gateway to this device.
However; this gateway should have the exact IP number as the device itself
so that the link is not broken for hosts whose subnets are not in the subnet
to which the AC would respond. If we change these subnets with the correct
one, whole IP configuration would be screwed up. 

So now the issue would seem simple;

We would just assign the exact IP number (192.168.77.1) to one of the
interfaces of the linux machine that has the uplink, and build a NAT table
using Iptables so that any request,

To 192.168.77.1 [IF 1] would be redirected to 192.168.77.1 [IF 2]**

Now the problem lies here, I cannot tell the linux machine not to route NAT
to its own loopback adapter. The machine is naturally thinking that this IP
address is its own and nothing works out this way.

I have come up with a solution that should do exactly what we wish;

Similar to the patch of ip_input.c, we could tell the machine that it should
send all IP data to 192.168.1.1 [dumb port of the AC - the source of all
problems]. Just before the system sends that packet, now its destination IP
address should be mangled with the correct one [192.168.77.1]. This way NAT
should work because the system will still think that it is sending a request
to 192.168.1.1, but it will be sent to 77.1 and data will be received from
77.1.

So the code I presume should be as follows;

1. Check if the outgoing packet is going to 192.168.1.1
2. If it is going there mangle it with 192.168.77.1 and checksum
3. TCP and UDP layer should also create their psuedo-headers with
192.168.77.1 because otherwise this time AC won't receive it
4. Receive data back from 192.168.77.1 and translate

** But if the NAT still would insist that it should get packets from the
address it intended to communicate [Hopefully not]; in that case;

5. The ip_input.c patch this time would not be used anyway
6. But now the TCP and UDP checksums would be voided as usual
7. Correct TCP and UDP checksums of the input packet
8. Put them on the socket

So this means we require a similar patch for ip_output.c. Regardless of
those seeminlgy impossible problems, I will persist on the fact that there
are always alternative ways to handle an issue...

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




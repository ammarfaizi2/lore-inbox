Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUHWDmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUHWDmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 23:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267395AbUHWDmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 23:42:38 -0400
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:60872 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S266753AbUHWDme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 23:42:34 -0400
Date: Sun, 22 Aug 2004 23:38:05 -0400
From: David Meybohm <dmeybohm@bellsouth.net>
To: Josan Kadett <corporate@superonline.com>
Cc: "'Brad Campbell'" <brad@wasp.net.au>, linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
Message-ID: <20040823033805.GA4103@localhost>
Mail-Followup-To: Josan Kadett <corporate@superonline.com>,
	'Brad Campbell' <brad@wasp.net.au>, linux-kernel@vger.kernel.org
References: <41289C0B.7010805@wasp.net.au> <S268076AbUHVT2N/20040822192813Z+185@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S268076AbUHVT2N/20040822192813Z+185@vger.kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 10:28:10PM +0200, Josan Kadett wrote:
> I have found the exact reason why NAT does not work;
> 
> - The patched linux box ignores IP checksum errors
> - Since now the source address is mofidified without checksumming, NAT also
> carries that wrong checksum
> - Other boxes does not ignore the checksum and drop packets
> 
> I think the solution is here, I have done many different modifications to
> get the system redirect packets with wrong checksum. Now all to be done, is
> to correct this checksum by changing some code in ip_input.c so that it
> recalculates the checksum when the packets seem to arrive from 192.168.1.1. 
> 
> Where in the code then?

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
--- v2.6.8/net/ipv4/ip_input.c~ip-ignore-csum	2004-08-22 22:56:34.000000000 -0400
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

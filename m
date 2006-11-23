Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757214AbWKWABr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214AbWKWABr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 19:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757213AbWKWABr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 19:01:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:8408 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1757208AbWKWABq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 19:01:46 -0500
Date: Thu, 23 Nov 2006 01:01:44 +0100
From: Olaf Kirch <okir@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make udp_encap_rcv use pskb_may_pull
Message-ID: <20061123000144.GB7452@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make udp_encap_rcv use pskb_may_pull

IPsec with NAT-T breaks on some notebooks using the latest e1000 chipset,
when header split is enabled. When receiving sufficiently large packets, the
driver puts everything up to and including the UDP header into the header
portion of the skb, and the rest goes into the paged part. udp_encap_rcv
forgets to use pskb_may_pull, and fails to decapsulate it. Instead, it
passes it up it to the IKE daemon.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Jean Delvare <jdelvare@suse.de>

 net/ipv4/udp.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

Index: linux-2.6.19-rc6/net/ipv4/udp.c
===================================================================
--- linux-2.6.19-rc6.orig/net/ipv4/udp.c
+++ linux-2.6.19-rc6/net/ipv4/udp.c
@@ -928,24 +928,33 @@ static int udp_encap_rcv(struct sock * s
 	return 1; 
 #else
 	struct udp_sock *up = udp_sk(sk);
-  	struct udphdr *uh = skb->h.uh;
+  	struct udphdr *uh;
 	struct iphdr *iph;
 	int iphlen, len;
   
-	__u8 *udpdata = (__u8 *)uh + sizeof(struct udphdr);
-	__be32 *udpdata32 = (__be32 *)udpdata;
+	__u8 *udpdata;
+	__be32 *udpdata32;
 	__u16 encap_type = up->encap_type;
 
 	/* if we're overly short, let UDP handle it */
-	if (udpdata > skb->tail)
+	len = skb->len - sizeof(struct udphdr);
+	if (len <= 0)
 		return 1;
 
 	/* if this is not encapsulated socket, then just return now */
 	if (!encap_type)
 		return 1;
 
-	len = skb->tail - udpdata;
+	/* If this is a paged skb, make sure we pull up
+	 * whatever data we need to look at. */
+	if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)))
+		return 1;
 
+	/* Now we can get the pointers */
+	uh = skb->h.uh;
+	udpdata = (__u8 *)uh + sizeof(struct udphdr);
+	udpdata32 = (__be32 *)udpdata;
+  
 	switch (encap_type) {
 	default:
 	case UDP_ENCAP_ESPINUDP:

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758344AbWK2WIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758344AbWK2WIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758847AbWK2WHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:07:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22741 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758270AbWK2WHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:07:21 -0500
Message-Id: <20061129220706.398976000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:34 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Olaf Kirch <okir@suse.de>,
       Jean Delvare <jdelvare@suse.de>
Subject: [patch 23/23] UDP: Make udp_encap_rcv use pskb_may_pull
Content-Disposition: inline; filename=udp-make-udp_encap_rcv-use-pskb_may_pull.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Olaf Kirch <okir@suse.de>

IPsec with NAT-T breaks on some notebooks using the latest e1000 chipset,
when header split is enabled. When receiving sufficiently large packets, the
driver puts everything up to and including the UDP header into the header
portion of the skb, and the rest goes into the paged part. udp_encap_rcv
forgets to use pskb_may_pull, and fails to decapsulate it. Instead, it
passes it up it to the IKE daemon.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ipv4/udp.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- linux-2.6.18.4.orig/net/ipv4/udp.c
+++ linux-2.6.18.4/net/ipv4/udp.c
@@ -892,23 +892,32 @@ static int udp_encap_rcv(struct sock * s
 	return 1; 
 #else
 	struct udp_sock *up = udp_sk(sk);
-  	struct udphdr *uh = skb->h.uh;
+  	struct udphdr *uh;
 	struct iphdr *iph;
 	int iphlen, len;
   
-	__u8 *udpdata = (__u8 *)uh + sizeof(struct udphdr);
-	__u32 *udpdata32 = (__u32 *)udpdata;
+	__u8 *udpdata;
+	__u32 *udpdata32;
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
+
+	/* Now we can get the pointers */
+	uh = skb->h.uh;
+	udpdata = (__u8 *)uh + sizeof(struct udphdr);
+	udpdata32 = (__u32 *)udpdata;
 
 	switch (encap_type) {
 	default:

--

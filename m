Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286712AbSAUOo3>; Mon, 21 Jan 2002 09:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287003AbSAUOoU>; Mon, 21 Jan 2002 09:44:20 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:517 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S286712AbSAUOoN>; Mon, 21 Jan 2002 09:44:13 -0500
Date: Mon, 21 Jan 2002 14:44:04 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: davej@suse.de, martin.macok@underground.cz, linux-kernel@vger.kernel.org,
        ak@muc.de
Subject: Re: [andrewg@tasmail.com: remote memory reading through tcp/icmp]
Message-ID: <20020121144404.B11489@flint.arm.linux.org.uk>
In-Reply-To: <20020121015209.A26413@sarah.kolej.mff.cuni.cz> <20020120.175204.18636524.davem@redhat.com> <20020121031211.B29830@suse.de> <20020120.184318.13746427.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020120.184318.13746427.davem@redhat.com>; from davem@redhat.com on Sun, Jan 20, 2002 at 06:43:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 06:43:18PM -0800, David S. Miller wrote:
> Andi?

Ok, final message - I found I was getting a fair number of

  ICMP redirect: packet too short

messages in the log while running IPv6.  It appears that I had icmp
redirects bouncing between two IPv6 routers (and the routers were updating
their routing tables, which is against RFC2461, but I'm not concerned
about that at the moment).

It appears that net/ipv6/ndisc.c forgets to convert the payload_len header
field to host byteorder before comparing it.

The following patch corrects this.

--- ref/net/ipv6/ndisc.c	Thu Dec 20 11:03:56 2001
+++ linux/net/ipv6/ndisc.c	Mon Jan 21 14:06:17 2002
@@ -957,6 +957,7 @@
 	struct nd_msg *msg = (struct nd_msg *) skb->h.raw;
 	struct neighbour *neigh;
 	struct inet6_ifaddr *ifp;
+	unsigned int payload_len;
 
 	__skb_push(skb, skb->data-skb->h.raw);
 
@@ -979,10 +980,11 @@
 	 *	(Some checking in ndisc_find_option)
 	 */
 
+	payload_len = ntohs(skb->nh.ipv6h->payload_len);
 	switch (msg->icmph.icmp6_type) {
 	case NDISC_NEIGHBOUR_SOLICITATION:
 		/* XXX: import nd_neighbor_solicit from glibc netinet/icmp6.h */
-		if (skb->nh.ipv6h->payload_len < 8+16) {
+		if (payload_len < 8+16) {
 			if (net_ratelimit())
 				printk(KERN_WARNING "ICMP NS: packet too short\n");
 			return 0;
@@ -1112,7 +1114,7 @@
 
 	case NDISC_NEIGHBOUR_ADVERTISEMENT:
 		/* XXX: import nd_neighbor_advert from glibc netinet/icmp6.h */
-		if (skb->nh.ipv6h->payload_len < 16+8 ) {
+		if (payload_len < 16+8 ) {
 			if (net_ratelimit())
 				printk(KERN_WARNING "ICMP NA: packet too short\n");
 			return 0;
@@ -1174,7 +1176,7 @@
 
 	case NDISC_ROUTER_ADVERTISEMENT:
 		/* XXX: import nd_router_advert from glibc netinet/icmp6.h */
-		if (skb->nh.ipv6h->payload_len < 8+4+4) {
+		if (payload_len < 8+4+4) {
 			if (net_ratelimit())
 				printk(KERN_WARNING "ICMP RA: packet too short\n");
 			return 0;
@@ -1184,7 +1186,7 @@
 
 	case NDISC_REDIRECT:
 		/* XXX: import nd_redirect from glibc netinet/icmp6.h */
-		if (skb->nh.ipv6h->payload_len < 8+16+16) {
+		if (payload_len < 8+16+16) {
 			if (net_ratelimit())
 				printk(KERN_WARNING "ICMP redirect: packet too short\n");
 			return 0;
@@ -1196,7 +1198,7 @@
 		/* No RS support in the kernel, but we do some required checks */
 
 		/* XXX: import nd_router_solicit from glibc netinet/icmp6.h */
-		if (skb->nh.ipv6h->payload_len < 8) {
+		if (payload_len < 8) {
 			if (net_ratelimit())
 				printk(KERN_WARNING "ICMP RS: packet too short\n");
 			return 0;

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


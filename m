Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbVLWWyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbVLWWyF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbVLWWyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:54:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:53455 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161103AbVLWWt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:27 -0500
Date: Fri, 23 Dec 2005 14:48:30 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, bdschuym@pandora.be
Subject: [patch 12/19] [BRIDGE-NF]: Fix bridge-nf ipv6 length check
Message-ID: <20051223224830.GL19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-bridge-nf-ipv6-length-check.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Bart De Schuymer <bdschuym@pandora.be>

A typo caused some bridged IPv6 packets to get dropped randomly,
as reported by Sebastien Chaumontet. The patch below fixes this
(using skb->nh.raw instead of raw) and also makes the jumbo packet
length checking up-to-date with the code in
net/ipv6/exthdrs.c::ipv6_hop_jumbo.

Signed-off-by: Bart De Schuymer <bdschuym@pandora.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/bridge/br_netfilter.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- linux-2.6.14.4.orig/net/bridge/br_netfilter.c
+++ linux-2.6.14.4/net/bridge/br_netfilter.c
@@ -295,7 +295,7 @@ static int check_hbh_len(struct sk_buff 
 	len -= 2;
 
 	while (len > 0) {
-		int optlen = raw[off+1]+2;
+		int optlen = skb->nh.raw[off+1]+2;
 
 		switch (skb->nh.raw[off]) {
 		case IPV6_TLV_PAD0:
@@ -308,18 +308,15 @@ static int check_hbh_len(struct sk_buff 
 		case IPV6_TLV_JUMBO:
 			if (skb->nh.raw[off+1] != 4 || (off&3) != 2)
 				goto bad;
-
 			pkt_len = ntohl(*(u32*)(skb->nh.raw+off+2));
-
+			if (pkt_len <= IPV6_MAXPLEN ||
+			    skb->nh.ipv6h->payload_len)
+				goto bad;
 			if (pkt_len > skb->len - sizeof(struct ipv6hdr))
 				goto bad;
-			if (pkt_len + sizeof(struct ipv6hdr) < skb->len) {
-				if (__pskb_trim(skb,
-				    pkt_len + sizeof(struct ipv6hdr)))
-					goto bad;
-				if (skb->ip_summed == CHECKSUM_HW)
-					skb->ip_summed = CHECKSUM_NONE;
-			}
+			if (pskb_trim_rcsum(skb,
+			    pkt_len+sizeof(struct ipv6hdr)))
+				goto bad;
 			break;
 		default:
 			if (optlen > len)

--

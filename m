Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163246AbWLGTqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163246AbWLGTqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163245AbWLGTqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:46:39 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:3984 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163242AbWLGTqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:46:38 -0500
Date: Thu, 7 Dec 2006 14:45:53 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linux-net@vger.kernel.org
Cc: mpm@selenic.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       clalance@redhat.com
Subject: [PATCH] netpoll: make arp replies through netpoll use mac address of sender
Message-ID: <20061207194553.GB29313@hmsreliant.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in 2.4 arp requests that were recevied by netpoll were processed in
netconsole_receive_skb, where they were responded to using the src mac of the
request sender.  In the 2.6 kernel arp_reply is responsible for this function,
but instead of using the src mac address of the incomming request, the stored
mac address that was registered for the netconsole application is used.  While
this is usually ok, it can lead to failures in netpoll in some situations
(specifically situations where a network may have two gateways, as arp requests
from one may be responded to using the mac address of the other).  This patch
reverts the behavior to what we had in 2.4, in which all arp requests are sent
back using the src address of the request sender.

Thanks & Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 netpoll.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)


diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 3c58846..5833b21 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -331,6 +331,7 @@ static void arp_reply(struct sk_buff *sk
 	unsigned char *arp_ptr;
 	int size, type = ARPOP_REPLY, ptype = ETH_P_ARP;
 	__be32 sip, tip;
+	unsigned char *sha;
 	struct sk_buff *send_skb;
 	struct netpoll *np = NULL;
 
@@ -357,9 +358,14 @@ static void arp_reply(struct sk_buff *sk
 	    arp->ar_op != htons(ARPOP_REQUEST))
 		return;
 
-	arp_ptr = (unsigned char *)(arp+1) + skb->dev->addr_len;
+	arp_ptr = (unsigned char *)(arp+1);
+	/* save the location of the src hw addr */
+	sha = arp_ptr;
+	arp_ptr += skb->dev->addr_len;
 	memcpy(&sip, arp_ptr, 4);
-	arp_ptr += 4 + skb->dev->addr_len;
+	arp_ptr += 4;
+	/* if we actually cared about dst hw addr, it would get copied here */
+	arp_ptr += skb->dev->addr_len;
 	memcpy(&tip, arp_ptr, 4);
 
 	/* Should we ignore arp? */
@@ -382,7 +388,7 @@ static void arp_reply(struct sk_buff *sk
 
 	if (np->dev->hard_header &&
 	    np->dev->hard_header(send_skb, skb->dev, ptype,
-				 np->remote_mac, np->local_mac,
+				 sha, np->local_mac,
 				 send_skb->len) < 0) {
 		kfree_skb(send_skb);
 		return;
@@ -406,7 +412,7 @@ static void arp_reply(struct sk_buff *sk
 	arp_ptr += np->dev->addr_len;
 	memcpy(arp_ptr, &tip, 4);
 	arp_ptr += 4;
-	memcpy(arp_ptr, np->remote_mac, np->dev->addr_len);
+	memcpy(arp_ptr, sha, np->dev->addr_len);
 	arp_ptr += np->dev->addr_len;
 	memcpy(arp_ptr, &sip, 4);
 
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/

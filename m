Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbVLHWfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbVLHWfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbVLHWfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:35:48 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:20082 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932673AbVLHWfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:35:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=QxEU/i03yABJqIoqzE0TUO0diLm8So1AChk2YVv6qXydVP7VQ+QFiaewtuNO1qEVTJATec/yehuOPOwUvs4yfT7LsAVUejQ+BcQGqFktmrlWiEZw7QUN0OztdkHm/YnDcHqTSVhCVrIwI84XFUUPrnw83qK7iNfnOpTaIChE5d8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Decrease number of pointer derefs in nfnetlink_queue.c
Date: Thu, 8 Dec 2005 23:36:01 +0100
User-Agent: KMail/1.9
Cc: Netfilter Core Team <coreteam@netfilter.org>,
       James Morris <jmorris@intercode.com.au>,
       Harald Welte <laforge@netfilter.org>, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512082336.01678.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a small patch to decrease the number of pointer derefs in
net/netfilter/nfnetlink_queue.c

Benefits of the patch:
 - Fewer pointer dereferences should make the code slightly faster.
 - Size of generated code is smaller
 - improved readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 net/netfilter/nfnetlink_queue.c |   79 ++++++++++++++++++++++------------------
 1 files changed, 44 insertions(+), 35 deletions(-)

orig:
   text    data     bss     dec     hex filename
   5357     244      64    5665    1621 net/netfilter/nfnetlink_queue.o

patched:
   text    data     bss     dec     hex filename
   5335     244      64    5643    160b net/netfilter/nfnetlink_queue.o

--- linux-2.6.15-rc5-git1-orig/net/netfilter/nfnetlink_queue.c	2005-12-04 18:48:58.000000000 +0100
+++ linux-2.6.15-rc5-git1/net/netfilter/nfnetlink_queue.c	2005-12-08 19:47:22.000000000 +0100
@@ -345,6 +345,10 @@ nfqnl_build_packet_message(struct nfqnl_
 	struct nfqnl_msg_packet_hdr pmsg;
 	struct nlmsghdr *nlh;
 	struct nfgenmsg *nfmsg;
+	struct nf_info *entinf = entry->info;
+	struct sk_buff *entskb = entry->skb;
+	struct net_device *indev;
+	struct net_device *outdev;
 	unsigned int tmp_uint;
 
 	QDEBUG("entered\n");
@@ -361,6 +365,8 @@ nfqnl_build_packet_message(struct nfqnl_
 		+ NLMSG_SPACE(sizeof(struct nfqnl_msg_packet_hw))
 		+ NLMSG_SPACE(sizeof(struct nfqnl_msg_packet_timestamp));
 
+	outdev = entinf->outdev;
+
 	spin_lock_bh(&queue->lock);
 	
 	switch (queue->copy_mode) {
@@ -370,15 +376,15 @@ nfqnl_build_packet_message(struct nfqnl_
 		break;
 	
 	case NFQNL_COPY_PACKET:
-		if (entry->skb->ip_summed == CHECKSUM_HW &&
-		    (*errp = skb_checksum_help(entry->skb,
-		                               entry->info->outdev == NULL))) {
+		if (entskb->ip_summed == CHECKSUM_HW &&
+		    (*errp = skb_checksum_help(entskb,
+		                               outdev == NULL))) {
 			spin_unlock_bh(&queue->lock);
 			return NULL;
 		}
 		if (queue->copy_range == 0 
-		    || queue->copy_range > entry->skb->len)
-			data_len = entry->skb->len;
+		    || queue->copy_range > entskb->len)
+			data_len = entskb->len;
 		else
 			data_len = queue->copy_range;
 		
@@ -402,29 +408,30 @@ nfqnl_build_packet_message(struct nfqnl_
 			NFNL_SUBSYS_QUEUE << 8 | NFQNL_MSG_PACKET,
 			sizeof(struct nfgenmsg));
 	nfmsg = NLMSG_DATA(nlh);
-	nfmsg->nfgen_family = entry->info->pf;
+	nfmsg->nfgen_family = entinf->pf;
 	nfmsg->version = NFNETLINK_V0;
 	nfmsg->res_id = htons(queue->queue_num);
 
 	pmsg.packet_id 		= htonl(entry->id);
-	pmsg.hw_protocol	= htons(entry->skb->protocol);
-	pmsg.hook		= entry->info->hook;
+	pmsg.hw_protocol	= htons(entskb->protocol);
+	pmsg.hook		= entinf->hook;
 
 	NFA_PUT(skb, NFQA_PACKET_HDR, sizeof(pmsg), &pmsg);
 
-	if (entry->info->indev) {
-		tmp_uint = htonl(entry->info->indev->ifindex);
+	indev = entinf->indev;
+	if (indev) {
+		tmp_uint = htonl(indev->ifindex);
 #ifndef CONFIG_BRIDGE_NETFILTER
 		NFA_PUT(skb, NFQA_IFINDEX_INDEV, sizeof(tmp_uint), &tmp_uint);
 #else
-		if (entry->info->pf == PF_BRIDGE) {
+		if (entinf->pf == PF_BRIDGE) {
 			/* Case 1: indev is physical input device, we need to
 			 * look for bridge group (when called from 
 			 * netfilter_bridge) */
 			NFA_PUT(skb, NFQA_IFINDEX_PHYSINDEV, sizeof(tmp_uint), 
 				&tmp_uint);
 			/* this is the bridge group "brX" */
-			tmp_uint = htonl(entry->info->indev->br_port->br->dev->ifindex);
+			tmp_uint = htonl(indev->br_port->br->dev->ifindex);
 			NFA_PUT(skb, NFQA_IFINDEX_INDEV, sizeof(tmp_uint),
 				&tmp_uint);
 		} else {
@@ -432,9 +439,9 @@ nfqnl_build_packet_message(struct nfqnl_
 			 * physical device (when called from ipv4) */
 			NFA_PUT(skb, NFQA_IFINDEX_INDEV, sizeof(tmp_uint),
 				&tmp_uint);
-			if (entry->skb->nf_bridge
-			    && entry->skb->nf_bridge->physindev) {
-				tmp_uint = htonl(entry->skb->nf_bridge->physindev->ifindex);
+			if (entskb->nf_bridge
+			    && entskb->nf_bridge->physindev) {
+				tmp_uint = htonl(entskb->nf_bridge->physindev->ifindex);
 				NFA_PUT(skb, NFQA_IFINDEX_PHYSINDEV,
 					sizeof(tmp_uint), &tmp_uint);
 			}
@@ -442,19 +449,19 @@ nfqnl_build_packet_message(struct nfqnl_
 #endif
 	}
 
-	if (entry->info->outdev) {
-		tmp_uint = htonl(entry->info->outdev->ifindex);
+	if (outdev) {
+		tmp_uint = htonl(outdev->ifindex);
 #ifndef CONFIG_BRIDGE_NETFILTER
 		NFA_PUT(skb, NFQA_IFINDEX_OUTDEV, sizeof(tmp_uint), &tmp_uint);
 #else
-		if (entry->info->pf == PF_BRIDGE) {
+		if (entinf->pf == PF_BRIDGE) {
 			/* Case 1: outdev is physical output device, we need to
 			 * look for bridge group (when called from 
 			 * netfilter_bridge) */
 			NFA_PUT(skb, NFQA_IFINDEX_PHYSOUTDEV, sizeof(tmp_uint),
 				&tmp_uint);
 			/* this is the bridge group "brX" */
-			tmp_uint = htonl(entry->info->outdev->br_port->br->dev->ifindex);
+			tmp_uint = htonl(outdev->br_port->br->dev->ifindex);
 			NFA_PUT(skb, NFQA_IFINDEX_OUTDEV, sizeof(tmp_uint),
 				&tmp_uint);
 		} else {
@@ -462,9 +469,9 @@ nfqnl_build_packet_message(struct nfqnl_
 			 * physical output device (when called from ipv4) */
 			NFA_PUT(skb, NFQA_IFINDEX_OUTDEV, sizeof(tmp_uint),
 				&tmp_uint);
-			if (entry->skb->nf_bridge
-			    && entry->skb->nf_bridge->physoutdev) {
-				tmp_uint = htonl(entry->skb->nf_bridge->physoutdev->ifindex);
+			if (entskb->nf_bridge
+			    && entskb->nf_bridge->physoutdev) {
+				tmp_uint = htonl(entskb->nf_bridge->physoutdev->ifindex);
 				NFA_PUT(skb, NFQA_IFINDEX_PHYSOUTDEV,
 					sizeof(tmp_uint), &tmp_uint);
 			}
@@ -472,27 +479,27 @@ nfqnl_build_packet_message(struct nfqnl_
 #endif
 	}
 
-	if (entry->skb->nfmark) {
-		tmp_uint = htonl(entry->skb->nfmark);
+	if (entskb->nfmark) {
+		tmp_uint = htonl(entskb->nfmark);
 		NFA_PUT(skb, NFQA_MARK, sizeof(u_int32_t), &tmp_uint);
 	}
 
-	if (entry->info->indev && entry->skb->dev
-	    && entry->skb->dev->hard_header_parse) {
+	if (indev && entskb->dev
+	    && entskb->dev->hard_header_parse) {
 		struct nfqnl_msg_packet_hw phw;
 
 		phw.hw_addrlen =
-			entry->skb->dev->hard_header_parse(entry->skb,
+			entskb->dev->hard_header_parse(entskb,
 			                                   phw.hw_addr);
 		phw.hw_addrlen = htons(phw.hw_addrlen);
 		NFA_PUT(skb, NFQA_HWADDR, sizeof(phw), &phw);
 	}
 
-	if (entry->skb->tstamp.off_sec) {
+	if (entskb->tstamp.off_sec) {
 		struct nfqnl_msg_packet_timestamp ts;
 
-		ts.sec = cpu_to_be64(entry->skb->tstamp.off_sec);
-		ts.usec = cpu_to_be64(entry->skb->tstamp.off_usec);
+		ts.sec = cpu_to_be64(entskb->tstamp.off_sec);
+		ts.usec = cpu_to_be64(entskb->tstamp.off_usec);
 
 		NFA_PUT(skb, NFQA_TIMESTAMP, sizeof(ts), &ts);
 	}
@@ -510,7 +517,7 @@ nfqnl_build_packet_message(struct nfqnl_
 		nfa->nfa_type = NFQA_PAYLOAD;
 		nfa->nfa_len = size;
 
-		if (skb_copy_bits(entry->skb, 0, NFA_DATA(nfa), data_len))
+		if (skb_copy_bits(entskb, 0, NFA_DATA(nfa), data_len))
 			BUG();
 	}
 		
@@ -667,12 +674,14 @@ nfqnl_set_mode(struct nfqnl_instance *qu
 static int
 dev_cmp(struct nfqnl_queue_entry *entry, unsigned long ifindex)
 {
-	if (entry->info->indev)
-		if (entry->info->indev->ifindex == ifindex)
+	struct nf_info *entinf = entry->info;
+	
+	if (entinf->indev)
+		if (entinf->indev->ifindex == ifindex)
 			return 1;
 			
-	if (entry->info->outdev)
-		if (entry->info->outdev->ifindex == ifindex)
+	if (entinf->outdev)
+		if (entinf->outdev->ifindex == ifindex)
 			return 1;
 
 	return 0;



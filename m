Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVH3VBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVH3VBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 17:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbVH3VBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 17:01:14 -0400
Received: from gtfw2.enterasys.com ([12.25.1.128]:55268 "EHLO
	gtfw2.enterasys.com") by vger.kernel.org with ESMTP id S932436AbVH3VBN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 17:01:13 -0400
Subject: ip_queue.c and TCP resets
From: Michael Rash <mrash@enterasys.com>
Reply-To: mrash@enterasys.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-NxDBWPnspaHSIX2jSO/x"
Date: Tue, 30 Aug 2005 17:01:43 -0400
Message-Id: <1125435703.7024.24.camel@isengard.cipherdyne.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-OriginalArrivalTime: 30 Aug 2005 21:01:01.0833 (UTC) FILETIME=[EDA7BF90:01C5ADA5]
X-pstn-version: pmps:sps_win32_1_1_0c1 pase:2.8
X-pstn-levels: (C:84.0661 M:99.4056 P:95.9108 R:95.9108 S:69.6061 )
X-pstn-settings: 4 (0.2500:0.7500) p:13 m:13 C:14 r:13
X-pstn-addresses: from <mrash@enterasys.com> forward (org good) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NxDBWPnspaHSIX2jSO/x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Attached is a patch against
linux-2.6.11.12/net/ipv4/netfilter/ip_queue.c to put Ethernet MAC
addresses directly into the indev_name and outdev_name portions of the
ipq_packet_msg struct.  This is a total kludge and I doubt anyone else
will find this useful, but for libipq IPS applications it allows TCP
resets and other response traffic to be sent out of the appropriate
physical ports when running as an Ethernet bridge.  I'm sure there are
better ways to do this, but it seems to work.

-- 
Michael Rash
Security Research Engineer
Enterasys Networks, Inc.

--=-NxDBWPnspaHSIX2jSO/x
Content-Disposition: attachment; filename=ip_queue.c.patch
Content-Type: text/x-patch; name=ip_queue.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- net/ipv4/netfilter/ip_queue.c	2005-05-27 01:06:46.000000000 -0400
+++ net/ipv4/netfilter/ip_queue.c.new	2005-06-13 12:19:17.495865712 -0400
@@ -33,7 +33,7 @@
 #include <net/sock.h>
 #include <net/route.h>
 
-#define IPQ_QMAX_DEFAULT 1024
+#define IPQ_QMAX_DEFAULT 2048
 #define IPQ_PROC_FS_NAME "ip_queue"
 #define NET_IPQ_QMAX 2088
 #define NET_IPQ_QMAX_NAME "ip_queue_maxlen"
@@ -195,6 +195,8 @@
 	struct sk_buff *skb;
 	struct ipq_packet_msg *pmsg;
 	struct nlmsghdr *nlh;
+	struct ethhdr *eth;
+	unsigned short int eth_ctr, eth_dev_offset, intf_ctr, intf_dev_offset;
 
 	read_lock_bh(&queue_lock);
 	
@@ -238,7 +240,7 @@
 	pmsg->mark            = entry->skb->nfmark;
 	pmsg->hook            = entry->info->hook;
 	pmsg->hw_protocol     = entry->skb->protocol;
-	
+#if 0
 	if (entry->info->indev)
 		strcpy(pmsg->indev_name, entry->info->indev->name);
 	else
@@ -248,15 +250,105 @@
 		strcpy(pmsg->outdev_name, entry->info->outdev->name);
 	else
 		pmsg->outdev_name[0] = '\0';
+#endif
 	
 	if (entry->info->indev && entry->skb->dev) {
 		pmsg->hw_type = entry->skb->dev->type;
+#if 0
 		if (entry->skb->dev->hard_header_parse)
 			pmsg->hw_addrlen =
 				entry->skb->dev->hard_header_parse(entry->skb,
 				                                   pmsg->hw_addr);
+#endif
 	}
-	
+
+	/* get the ethernet header */
+	eth = eth_hdr(entry->skb);
+
+	eth_dev_offset = 0;
+
+	/* NOTE: we copy the source and destination MAC addresses into the
+	 * indev_name portion of the ipq message struct, and we copy the
+	 * physical interface names in the outdev_name portion of the same
+	 * struct.  Yes, this is a major kludge! */
+
+	/* copy the source MAC address into indev_name (starting
+	 * at indev_name[0]) */
+	for (eth_ctr=0; eth_ctr < ETH_ALEN; eth_ctr++) {
+		/* deal with signed vs. unsigned char definition of indev_name
+		 * vs. h_source */
+		if (eth->h_source[eth_ctr] > 128)
+			pmsg->indev_name[eth_dev_offset] = eth->h_source[eth_ctr] - 255;
+		else
+			pmsg->indev_name[eth_dev_offset] = eth->h_source[eth_ctr];
+		eth_dev_offset++;
+	}
+
+	/* copy the destination MAC address into indev_name (starting
+	 * at indev_name[6]) */
+	for (eth_ctr=0; eth_ctr < ETH_ALEN; eth_ctr++) {
+		/* deal with signed vs. unsigned char definition of indev_name
+		 * vs. h_dest */
+		if (eth->h_dest[eth_ctr] > 128)
+			pmsg->indev_name[eth_dev_offset] = eth->h_dest[eth_ctr] - 255;
+		else
+			pmsg->indev_name[eth_dev_offset] = eth->h_dest[eth_ctr];
+		eth_dev_offset++;
+	}
+
+	/* copy the physical input device */
+	intf_dev_offset = 0;
+	for (intf_ctr=0; intf_ctr < IFNAMSIZ/2; intf_ctr++) {
+		pmsg->outdev_name[intf_dev_offset] =
+			entry->skb->nf_bridge->physindev->name[intf_ctr];
+		intf_dev_offset++;
+	}
+
+	/* copy the physical output device */
+	for (intf_ctr=0; intf_ctr < IFNAMSIZ/2; intf_ctr++) {
+		pmsg->outdev_name[intf_dev_offset] =
+			entry->skb->nf_bridge->physoutdev->name[intf_ctr];
+		intf_dev_offset++;
+	}
+
+	/*
+	 *
+	printk(KERN_INFO "source MAC: %x%x%x%x%x%x\n",
+			eth->h_source[0],
+			eth->h_source[1],
+			eth->h_source[2],
+			eth->h_source[3],
+			eth->h_source[4],
+			eth->h_source[5]);
+
+	printk(KERN_INFO "dest MAC: %x%x%x%x%x%x\n",
+			eth->h_dest[0],
+			eth->h_dest[1],
+			eth->h_dest[2],
+			eth->h_dest[3],
+			eth->h_dest[4],
+			eth->h_dest[5]);
+	*/
+
+	/*
+			entry->skb->mac.ethernet.h_dest[3],
+			entry->skb->mac.ethernet.h_dest[4],
+			entry->skb->mac.ethernet.h_dest[5]);
+	*/
+
+	/*
+	printk(KERN_INFO "physindev: %c%c%c%c\n",
+			entry->skb->nf_bridge->physindev->name[0],
+			entry->skb->nf_bridge->physindev->name[1],
+			entry->skb->nf_bridge->physindev->name[2],
+			entry->skb->nf_bridge->physindev->name[3]);
+	printk(KERN_INFO "physoutdev: %c%c%c%c\n",
+			entry->skb->nf_bridge->physoutdev->name[0],
+			entry->skb->nf_bridge->physoutdev->name[1],
+			entry->skb->nf_bridge->physoutdev->name[2],
+			entry->skb->nf_bridge->physoutdev->name[3]);
+	*/
+
 	if (data_len)
 		if (skb_copy_bits(entry->skb, 0, pmsg->payload, data_len))
 			BUG();

--=-NxDBWPnspaHSIX2jSO/x--


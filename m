Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTKNFQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 00:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTKNFQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 00:16:30 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:8953 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264537AbTKNFPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 00:15:47 -0500
Date: Fri, 14 Nov 2003 10:52:04 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: lkcd-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, suparna@in.ibm.com,
       prasanna@in.ibm.com
Subject: Re: LKCD Network dump over netpoll patch (2.6.0-test9)
Message-ID: <20031114052204.GC18584@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20031110140742.GJ1409@in.ibm.com> <20031111005233.GV13246@waste.org> <20031114045714.GB18584@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114045714.GB18584@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is the lkcd-netdump.patch. This patch includes changes as suggested by 
Matt Mackall to define a new routine netdump_send_packet().


diff -urNp linux.orig/drivers/dump/dump_netdev.c linux+np/drivers/dump/dump_netdev.c
--- linux.orig/drivers/dump/dump_netdev.c	2003-11-13 05:56:01.000000000 +0530
+++ linux+np/drivers/dump/dump_netdev.c	2003-11-14 13:47:39.147245304 +0530
@@ -11,6 +11,8 @@
  * Nov 2002 - Bharata B. Rao <bharata@in.ibm.com>
  * 	Innumerable code cleanups, simplification and some fixes.
  *	Netdump configuration done by ioctl instead of using module parameters.
+ * Oct 2003 - Prasanna S Panchamukhi <prasanna@in.ibm.com>
+ *	Netdump code modified to use Netpoll API's.
  *
  * Copyright (C) 2001  Ingo Molnar <mingo@redhat.com>
  * Copyright (C) 2002 International Business Machines Corp. 
@@ -26,23 +28,13 @@
 #include <linux/module.h>
 #include <linux/dump.h>
 #include <linux/dump_netdev.h>
-#include <linux/percpu.h>
 
 #include <asm/unaligned.h>
 
 static int startup_handshake;
 static int page_counter;
-static struct net_device *dump_ndev;
-static struct in_device *dump_in_dev;
-static u16 source_port, target_port;
-static u32 source_ip, target_ip;
-static unsigned char daddr[6] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff} ;
-static spinlock_t dump_skb_lock = SPIN_LOCK_UNLOCKED;
-static int dump_nr_skbs;
-static struct sk_buff *dump_skb;
 static unsigned long flags_global;
 static int netdump_in_progress;
-static char device_name[IFNAMSIZ];
 
 /*
  * security depends on the trusted path between the netconsole
@@ -52,311 +44,27 @@ static char device_name[IFNAMSIZ];
  */
 static u64 dump_magic;
 
-#define MAX_UDP_CHUNK 1460
-#define MAX_PRINT_CHUNK (MAX_UDP_CHUNK-HEADER_LEN)
-
 /*
  * We maintain a small pool of fully-sized skbs,
  * to make sure the message gets out even in
  * extreme OOM situations.
  */
-#define DUMP_MAX_SKBS 32
-
-#define MAX_SKB_SIZE \
-		(MAX_UDP_CHUNK + sizeof(struct udphdr) + \
-				sizeof(struct iphdr) + sizeof(struct ethhdr))
-
-static void
-dump_refill_skbs(void)
-{
-	struct sk_buff *skb;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dump_skb_lock, flags);
-	while (dump_nr_skbs < DUMP_MAX_SKBS) {
-		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
-		if (!skb)
-			break;
-		if (dump_skb)
-			skb->next = dump_skb;
-		else
-			skb->next = NULL;
-		dump_skb = skb;
-		dump_nr_skbs++;
-	}
-	spin_unlock_irqrestore(&dump_skb_lock, flags);
-}
-
-static struct
-sk_buff * dump_get_skb(void)
-{
-	struct sk_buff *skb;
-	unsigned long flags;
-
-	spin_lock_irqsave(&dump_skb_lock, flags);
-	skb = dump_skb;
-	if (skb) {
-		dump_skb = skb->next;
-		skb->next = NULL;
-		dump_nr_skbs--;
-	}
-	spin_unlock_irqrestore(&dump_skb_lock, flags);
-        
-	return skb;
-}
-
-/*
- * Zap completed output skbs.
- */
-static void
-zap_completion_queue(void)
-{
-	int count;
-	unsigned long flags;
-	struct softnet_data *sd;
-
-        count=0;
-	sd = &__get_cpu_var(softnet_data);
-	if (sd->completion_queue) {
-		struct sk_buff *clist;
-	
-		local_irq_save(flags);
-		clist = sd->completion_queue;
-		sd->completion_queue = NULL;
-		local_irq_restore(flags);
-
-		while (clist != NULL) {
-			struct sk_buff *skb = clist;
-			clist = clist->next;
-			__kfree_skb(skb);
-			count++;
-			if (count > 10000)
-				printk("Error in sk list\n");
-		}
-	}
-}
-
-static void
-dump_send_skb(struct net_device *dev, const char *msg, unsigned int msg_len,
-		reply_t *reply)
-{
-	int once = 1;
-	int total_len, eth_len, ip_len, udp_len, count = 0;
-	struct sk_buff *skb;
-	struct udphdr *udph;
-	struct iphdr *iph;
-	struct ethhdr *eth; 
-
-	udp_len = msg_len + HEADER_LEN + sizeof(*udph);
-	ip_len = eth_len = udp_len + sizeof(*iph);
-	total_len = eth_len + ETH_HLEN;
-
-repeat_loop:
-	zap_completion_queue();
-	if (dump_nr_skbs < DUMP_MAX_SKBS)
-		dump_refill_skbs();
-
-	skb = alloc_skb(total_len, GFP_ATOMIC);
-	if (!skb) {
-		skb = dump_get_skb();
-		if (!skb) {
-			count++;
-			if (once && (count == 1000000)) {
-				printk("possibly FATAL: out of netconsole "
-					"skbs!!! will keep retrying.\n");
-				once = 0;
-			}
-			dev->poll_controller(dev);
-			goto repeat_loop;
-		}
-	}
-
-	atomic_set(&skb->users, 1);
-	skb_reserve(skb, total_len - msg_len - HEADER_LEN);
-	skb->data[0] = NETCONSOLE_VERSION;
-
-	put_unaligned(htonl(reply->nr), (u32 *) (skb->data + 1));
-	put_unaligned(htonl(reply->code), (u32 *) (skb->data + 5));
-	put_unaligned(htonl(reply->info), (u32 *) (skb->data + 9));
-
-	memcpy(skb->data + HEADER_LEN, msg, msg_len);
-	skb->len += msg_len + HEADER_LEN;
-
-	udph = (struct udphdr *) skb_push(skb, sizeof(*udph));
-	udph->source = source_port;
-	udph->dest = target_port;
-	udph->len = htons(udp_len);
-	udph->check = 0;
-
-	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
-
-	iph->version  = 4;
-	iph->ihl      = 5;
-	iph->tos      = 0;
-	iph->tot_len  = htons(ip_len);
-	iph->id       = 0;
-	iph->frag_off = 0;
-	iph->ttl      = 64;
-	iph->protocol = IPPROTO_UDP;
-	iph->check    = 0;
-	iph->saddr    = source_ip;
-	iph->daddr    = target_ip;
-	iph->check    = ip_fast_csum((unsigned char *)iph, iph->ihl);
-
-	eth = (struct ethhdr *) skb_push(skb, ETH_HLEN);
-
-	eth->h_proto = htons(ETH_P_IP);
-	memcpy(eth->h_source, dev->dev_addr, dev->addr_len);
-	memcpy(eth->h_dest, daddr, dev->addr_len);
-
-	count=0;
-repeat_poll:
-	spin_lock(&dev->xmit_lock);
-	dev->xmit_lock_owner = smp_processor_id();
-
-	count++;
-
-
-	if (netif_queue_stopped(dev)) {
-		dev->xmit_lock_owner = -1;
-		spin_unlock(&dev->xmit_lock);
-
-		dev->poll_controller(dev);
-		zap_completion_queue();
-
-
-		goto repeat_poll;
-	}
-
-	dev->hard_start_xmit(skb, dev);
-
-	dev->xmit_lock_owner = -1;
-	spin_unlock(&dev->xmit_lock);
-}
-
-static unsigned short
-udp_check(struct udphdr *uh, int len, unsigned long saddr, unsigned long daddr,
-	       	unsigned long base)
-{
-	return csum_tcpudp_magic(saddr, daddr, len, IPPROTO_UDP, base);
-}
-
-static int
-udp_checksum_init(struct sk_buff *skb, struct udphdr *uh,
-			     unsigned short ulen, u32 saddr, u32 daddr)
-{
-	if (uh->check == 0) {
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-	} else if (skb->ip_summed == CHECKSUM_HW) {
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		if (!udp_check(uh, ulen, saddr, daddr, skb->csum))
-			return 0;
-		skb->ip_summed = CHECKSUM_NONE;
-	}
-	if (skb->ip_summed != CHECKSUM_UNNECESSARY)
-		skb->csum = csum_tcpudp_nofold(saddr, daddr, ulen,
-				IPPROTO_UDP, 0);
-	/* Probably, we should checksum udp header (it should be in cache
-	 * in any case) and data in tiny packets (< rx copybreak).
-	 */
-	return 0;
-}
-
-static __inline__ int
-__udp_checksum_complete(struct sk_buff *skb)
-{
-	return (unsigned short)csum_fold(skb_checksum(skb, 0, skb->len,
-				skb->csum));
-}
-
-static __inline__
-int udp_checksum_complete(struct sk_buff *skb)
-{
-	return skb->ip_summed != CHECKSUM_UNNECESSARY &&
-		__udp_checksum_complete(skb);
-}
 
+static void rx_hook(struct netpoll *np, int port, char *msg, int size);
 int new_req = 0;
 static req_t req;
 
-static int
-dump_rx_hook(struct sk_buff *skb)
+static void rx_hook(struct netpoll *np, int port, char *msg, int size)
 {
-	int proto;
-	struct iphdr *iph;
-	struct udphdr *uh;
-	__u32 len, saddr, daddr, ulen;
-	req_t *__req;
-
+	req_t * __req = (req_t *) msg;
 	/* 
 	 * First check if were are dumping or doing startup handshake, if
 	 * not quickly return.
 	 */
-	if (!netdump_in_progress)
-		return NET_RX_SUCCESS;
-
-	if (skb->dev->type != ARPHRD_ETHER)
-		goto out;
-
-	proto = ntohs(skb->mac.ethernet->h_proto);
-	if (proto != ETH_P_IP)
-		goto out;
-
-	if (skb->pkt_type == PACKET_OTHERHOST)
-		goto out;
-
-	if (skb_shared(skb))
-		goto out;
-
-	 /* IP header correctness testing: */
-	iph = (struct iphdr *)skb->data;
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		goto out;
-
-	if (iph->ihl < 5 || iph->version != 4)
-		goto out;
-
-	if (!pskb_may_pull(skb, iph->ihl*4))
-		goto out;
-
-	if (ip_fast_csum((u8 *)iph, iph->ihl) != 0)
-		goto out;
-
-	len = ntohs(iph->tot_len);
-	if (skb->len < len || len < iph->ihl*4)
-		goto out;
-
-	saddr = iph->saddr;
-	daddr = iph->daddr;
-	if (iph->protocol != IPPROTO_UDP)
-		goto out;
-
-	if (source_ip != daddr)
-		goto out;
-
-	if (target_ip != saddr)
-		goto out;
 
-	len -= iph->ihl*4;
-	uh = (struct udphdr *)(((char *)iph) + iph->ihl*4);
-	ulen = ntohs(uh->len);
-
-	if (ulen != len || ulen < (sizeof(*uh) + sizeof(*__req)))
-		goto out;
-
-	if (udp_checksum_init(skb, uh, ulen, saddr, daddr) < 0)
-		goto out;
-
-	if (udp_checksum_complete(skb))
-		goto out;
-
-	if (source_port != uh->dest)
-		goto out;
-
-	if (target_port != uh->source)
-		goto out;
+	if (!netdump_in_progress)
+		return ;
 
-	__req = (req_t *)(uh + 1);
 	if ((ntohl(__req->command) != COMM_GET_MAGIC) &&
 	    (ntohl(__req->command) != COMM_HELLO) &&
 	    (ntohl(__req->command) != COMM_START_WRITE_NETDUMP_ACK) &&
@@ -371,27 +79,43 @@ dump_rx_hook(struct sk_buff *skb)
 	req.nr = ntohl(__req->nr);
 	new_req = 1;
 out:
-	return NET_RX_DROP;
+	return ;
+}
+static char netdump_membuf[1024 + HEADER_LEN + 1];
+/*
+ * Fill the netdump_membuf with the header information from reply_t structure 
+ * and send it down to netpoll_send_udp() routine.
+ */
+static void 
+netdump_send_packet(struct netpoll *np, reply_t *reply, size_t data_len) {
+	char *b;
+
+	b = &netdump_membuf[1];
+	netdump_membuf[0] = NETCONSOLE_VERSION;
+	put_unaligned(htonl(reply->nr), (u32 *) b);
+	put_unaligned(htonl(reply->code), (u32 *) (b + sizeof(reply->code)));
+	put_unaligned(htonl(reply->info), (u32 *) (b + sizeof(reply->code) + 
+		sizeof(reply->info)));
+	netpoll_send_udp(np, netdump_membuf, data_len + HEADER_LEN);
 }
 
 static void
-dump_send_mem(struct net_device *dev, req_t *req, const char* buff, size_t len)
+dump_send_mem(struct netpoll *np, req_t *req, const char* buff, size_t len)
 {
 	int i;
 
 	int nr_chunks = len/1024;
 	reply_t reply;
-	
-	reply.nr = req->nr;
-	reply.info = 0;
 
+	reply.nr = req->nr;
+	reply.code = REPLY_MEM;
         if ( nr_chunks <= 0)
 		 nr_chunks = 1;
 	for (i = 0; i < nr_chunks; i++) {
 		unsigned int offset = i*1024;
-		reply.code = REPLY_MEM;
 		reply.info = offset;
-                dump_send_skb(dev, buff + offset, 1024, &reply);
+		memcpy((netdump_membuf + HEADER_LEN), (buff + offset), 1024);
+		netdump_send_packet(np, &reply, 1024);
 	}
 }
 
@@ -407,31 +131,33 @@ dump_send_mem(struct net_device *dev, re
 static int
 dump_handshake(struct dump_dev *net_dev)
 {
-	char tmp[200];
 	reply_t reply;
 	int i, j;
+	size_t str_len;
 
 	if (startup_handshake) {
-		sprintf(tmp, "NETDUMP start, waiting for start-ACK.\n");
+		sprintf((netdump_membuf + HEADER_LEN), 
+			"NETDUMP start, waiting for start-ACK.\n");
 		reply.code = REPLY_START_NETDUMP;
 		reply.nr = 0;
 		reply.info = 0;
 	} else {
-		sprintf(tmp, "NETDUMP start, waiting for start-ACK.\n");
+		sprintf((netdump_membuf + HEADER_LEN), 
+			"NETDUMP start, waiting for start-ACK.\n");
 		reply.code = REPLY_START_WRITE_NETDUMP;
 		reply.nr = net_dev->curr_offset;
 		reply.info = net_dev->curr_offset;
 	}
+	str_len = strlen(netdump_membuf + HEADER_LEN);
 	
 	/* send 300 handshake packets before declaring failure */
 	for (i = 0; i < 300; i++) {
-		dump_send_skb(dump_ndev, tmp, strlen(tmp), &reply);
+		netdump_send_packet(&net_dev->np, &reply, str_len);
 
 		/* wait 1 sec */
 		for (j = 0; j < 10000; j++) {
 			udelay(100);
-			dump_ndev->poll_controller(dump_ndev);
-			zap_completion_queue();
+			netpoll_poll(&net_dev->np);
 			if (new_req)
 				break;
 		}
@@ -472,9 +198,9 @@ static ssize_t
 do_netdump(struct dump_dev *net_dev, const char* buff, size_t len)
 {
 	reply_t reply;
-	char tmp[200];
 	ssize_t  ret = 0;
 	int repeatCounter, counter, total_loop;
+	size_t str_len;
 	
 	netdump_in_progress = 1;
 
@@ -497,8 +223,7 @@ do_netdump(struct dump_dev *net_dev, con
 	total_loop = 0;
 	while (1) {
                 if (!new_req) {
-			dump_ndev->poll_controller(dump_ndev);
-			zap_completion_queue();
+			netpoll_poll(&net_dev->np);
 		}
 		if (!new_req) {
 			repeatCounter++;
@@ -530,7 +255,7 @@ do_netdump(struct dump_dev *net_dev, con
 			break;
 
 		case COMM_SEND_MEM:
-			dump_send_mem(dump_ndev, &req, buff, len);
+			dump_send_mem(&net_dev->np, &req, buff, len);
 			break;
 
 		case COMM_EXIT:
@@ -539,46 +264,55 @@ do_netdump(struct dump_dev *net_dev, con
 			goto out;
 
 		case COMM_HELLO:
-			sprintf(tmp, "Hello, this is netdump version "
-					"0.%02d\n", NETCONSOLE_VERSION);
+			sprintf((netdump_membuf + HEADER_LEN), 
+				"Hello, this is netdump version " "0.%02d\n",
+				 NETCONSOLE_VERSION);
+			str_len = strlen(netdump_membuf + HEADER_LEN);
 			reply.code = REPLY_HELLO;
 			reply.nr = req.nr;
                         reply.info = net_dev->curr_offset;
-			dump_send_skb(dump_ndev, tmp, strlen(tmp), &reply);
+			netdump_send_packet(&net_dev->np, &reply, str_len);
 			break;
 
 		case COMM_GET_PAGE_SIZE:
-			sprintf(tmp, "PAGE_SIZE: %ld\n", PAGE_SIZE);
+			sprintf((netdump_membuf + HEADER_LEN), 
+				"PAGE_SIZE: %ld\n", PAGE_SIZE);
+			str_len = strlen(netdump_membuf + HEADER_LEN);
 			reply.code = REPLY_PAGE_SIZE;
 			reply.nr = req.nr;
 			reply.info = PAGE_SIZE;
-			dump_send_skb(dump_ndev, tmp, strlen(tmp), &reply);
+			netdump_send_packet(&net_dev->np, &reply, str_len);
 			break;
 
 		case COMM_GET_NR_PAGES:
 			reply.code = REPLY_NR_PAGES;
 			reply.nr = req.nr;
 			reply.info = num_physpages;
-                        reply.info = page_counter;
-			sprintf(tmp, "Number of pages: %ld\n", num_physpages);
-			dump_send_skb(dump_ndev, tmp, strlen(tmp), &reply);
+			reply.info = page_counter;
+			sprintf((netdump_membuf + HEADER_LEN), 
+				"Number of pages: %ld\n", num_physpages);
+			str_len = strlen(netdump_membuf + HEADER_LEN);
+			netdump_send_packet(&net_dev->np, &reply, str_len);
 			break;
 
 		case COMM_GET_MAGIC:
 			reply.code = REPLY_MAGIC;
 			reply.nr = req.nr;
 			reply.info = NETCONSOLE_VERSION;
-			dump_send_skb(dump_ndev, (char *)&dump_magic,
-					sizeof(dump_magic), &reply);
+			sprintf((netdump_membuf + HEADER_LEN), 
+				(char *)&dump_magic, sizeof(dump_magic));
+			str_len = strlen(netdump_membuf + HEADER_LEN);
+			netdump_send_packet(&net_dev->np, &reply, str_len);
 			break;
 
 		default:
 			reply.code = REPLY_ERROR;
 			reply.nr = req.nr;
 			reply.info = req.command;
-			sprintf(tmp, "Got unknown command code %d!\n",
-					req.command);
-			dump_send_skb(dump_ndev, tmp, strlen(tmp), &reply);
+			sprintf((netdump_membuf + HEADER_LEN), 
+				"Got unknown command code %d!\n", req.command);
+			str_len = strlen(netdump_membuf + HEADER_LEN);
+			netdump_send_packet(&net_dev->np, &reply, str_len);
 			break;
 		}
 	}
@@ -588,47 +322,43 @@ out:
 }
 
 static int
-dump_validate_config(void)
+dump_validate_config(struct netpoll *np)
 {
-	source_ip = dump_in_dev->ifa_list->ifa_local;
-	if (!source_ip) {
+	if (!np->local_ip) {
 		printk("network device %s has no local address, "
-				"aborting.\n", device_name);
+				"aborting.\n", np->name);
 		return -1;
 	}
 
-#define IP(x) ((unsigned char *)&source_ip)[x]
+#define IP(x) ((unsigned char *)&np->local_ip)[x]
 	printk("Source %d.%d.%d.%d", IP(0), IP(1), IP(2), IP(3));
 #undef IP
 
-	if (!source_port) {
+	if (!np->local_port) {
 		printk("source_port parameter not specified, aborting.\n");
 		return -1;
 	}
-	printk(":%i\n", source_port);
-	source_port = htons(source_port);
 
-	if (!target_ip) {
+	if (!np->remote_ip) {
 		printk("target_ip parameter not specified, aborting.\n");
 		return -1;
 	}
 
-#define IP(x) ((unsigned char *)&target_ip)[x]
+	np->remote_ip = ntohl(np->remote_ip);
+#define IP(x) ((unsigned char *)&np->remote_ip)[x]
 	printk("Target %d.%d.%d.%d", IP(0), IP(1), IP(2), IP(3));
 #undef IP
 
-	if (!target_port) {
+	if (!np->remote_port) {
 		printk("target_port parameter not specified, aborting.\n");
 		return -1;
 	}
-	printk(":%i\n", target_port);
-	target_port = htons(target_port);
-
 	printk("Target Ethernet Address %02x:%02x:%02x:%02x:%02x:%02x",
-		daddr[0], daddr[1], daddr[2], daddr[3], daddr[4], daddr[5]);
+		np->remote_mac[0], np->remote_mac[1], np->remote_mac[2], 
+		np->remote_mac[3], np->remote_mac[4], np->remote_mac[5]);
 
-	if ((daddr[0] & daddr[1] & daddr[2] & daddr[3] & daddr[4] & 
-				daddr[5]) == 255)
+	if ((np->remote_mac[0] & np->remote_mac[1] & np->remote_mac[2] & 
+		np->remote_mac[3] & np->remote_mac[4] & np->remote_mac[5]) == 255)
 		printk("(Broadcast)");
 	printk("\n");
 	return 0;
@@ -646,40 +376,15 @@ dump_net_open(struct dump_dev *net_dev, 
 	int retval = 0;
 
 	/* get the interface name */
-	if (copy_from_user(device_name, (void *)arg, IFNAMSIZ))
+	if (copy_from_user(net_dev->np.dev_name, (void *)arg, IFNAMSIZ))
 		return -EFAULT;
+	net_dev->np.rx_hook = rx_hook;	
+	retval = netpoll_setup(&net_dev->np);
 
-	if (!(dump_ndev = dev_get_by_name(device_name))) {
-		printk("network device %s does not exist, aborting.\n",
-				device_name);
-		return -ENODEV;
-	}
-
-	if (!dump_ndev->poll_controller) {
-		printk("network device %s does not implement polling yet, "
-				"aborting.\n", device_name);
-		retval = -1; /* return proper error */
-		goto err1;
-	}
-
-	if (!(dump_in_dev = in_dev_get(dump_ndev))) {
-		printk("network device %s is not an IP protocol device, "
-				"aborting.\n", device_name);
-		retval = -EINVAL;
-		goto err1;
-	}
-
-	if ((retval = dump_validate_config()) < 0)
-		goto err2;
-
+	dump_validate_config(&net_dev->np);
 	net_dev->curr_offset = 0;
 	printk("Network device %s successfully configured for dumping\n",
-			device_name);
-	return retval;
-err2:
-	in_dev_put(dump_in_dev);
-err1:
-	dev_put(dump_ndev);	
+			net_dev->np.dev_name);
 	return retval;
 }
 
@@ -690,10 +395,7 @@ err1:
 static int
 dump_net_release(struct dump_dev *net_dev)
 {
-	if (dump_in_dev)
-		in_dev_put(dump_in_dev);
-	if (dump_ndev)
-		dev_put(dump_ndev);
+	netpoll_cleanup(&net_dev->np);
 	return 0;
 }
 
@@ -705,10 +407,9 @@ static int
 dump_net_silence(struct dump_dev *net_dev)
 {
 	local_irq_save(flags_global);
-	dump_ndev->rx_hook = dump_rx_hook;
         startup_handshake = 1;
 	net_dev->curr_offset = 0;
-	printk("Dumping to network device %s on CPU %d ...\n", device_name,
+	printk("Dumping to network device %s on CPU %d ...\n", net_dev->np.name,
 			smp_processor_id());
 	return 0;
 }
@@ -722,22 +423,19 @@ static int
 dump_net_resume(struct dump_dev *net_dev)
 {
 	int indx;
+	size_t str_len;
 	reply_t reply;
-	char tmp[200];
 
-        if (!dump_ndev)
-		return (0);
-
-	sprintf(tmp, "NETDUMP end.\n");
+	sprintf((netdump_membuf + HEADER_LEN), "NETDUMP end.\n");
+	str_len = strlen(netdump_membuf + HEADER_LEN);
 	for( indx = 0; indx < 6; indx++) {
 		reply.code = REPLY_END_NETDUMP;
 		reply.nr = 0;
 		reply.info = 0;
-		dump_send_skb(dump_ndev, tmp, strlen(tmp), &reply);
+		netdump_send_packet(&net_dev->np, &reply, str_len);
 	}
 	printk("NETDUMP END!\n");
 	local_irq_restore(flags_global);
-	dump_ndev->rx_hook = NULL;
 	startup_handshake = 0;
 	return 0;
 }
@@ -749,11 +447,6 @@ dump_net_resume(struct dump_dev *net_dev
 static  int
 dump_net_seek(struct dump_dev *net_dev, loff_t off)
 {
-	/*
-	 * For now using DUMP_HEADER_OFFSET as hard coded value,
-	 * See dump_block_seekin dump_blockdev.c to know how to
-	 * do this properly.
-	 */
 	net_dev->curr_offset = off;
 	return 0;
 }
@@ -796,16 +489,16 @@ dump_net_ioctl(struct dump_dev *net_dev,
 {
 	switch (cmd) {
 	case DIOSTARGETIP:
-		target_ip = arg;
+		net_dev->np.remote_ip= arg;
 		break;
 	case DIOSTARGETPORT:
-		target_port = (u16)arg;
+		net_dev->np.remote_port = (u16)arg;
 		break;
 	case DIOSSOURCEPORT:
-		source_port = (u16)arg;
+		net_dev->np.local_port = (u16)arg;
 		break;
 	case DIOSETHADDR:
-		return copy_from_user(daddr, (void *)arg, 6);
+		return copy_from_user(net_dev->np.remote_mac, (void *)arg, 6);
 		break;
 	case DIOGTARGETIP:
 	case DIOGTARGETPORT:
@@ -833,13 +526,19 @@ struct dump_dev_ops dump_netdev_ops = {
 static struct dump_dev default_dump_netdev = {
 	.type_name = "networkdev", 
 	.ops = &dump_netdev_ops, 
-	.curr_offset = 0
+	.curr_offset = 0,
+	.np.name = "netdump",
+	.np.dev_name = "eth0",
+	.np.rx_hook = rx_hook,
+	.np.local_port = 6688,
+	.np.remote_port = 6688,
+	.np.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
 };
 
 static int __init
 dump_netdev_init(void)
 {
-        default_dump_netdev.curr_offset = 0;
+	default_dump_netdev.curr_offset = 0;
 
 	if (dump_register_device(&default_dump_netdev) < 0) {
 		printk("network dump device driver registration failed\n");
Binary files linux.orig/drivers/dump/.dump_netdev.c.swp and linux+np/drivers/dump/.dump_netdev.c.swp differ
diff -urNp linux.orig/include/linux/dumpdev.h linux+np/include/linux/dumpdev.h
--- linux.orig/include/linux/dumpdev.h	2003-11-13 05:56:17.000000000 +0530
+++ linux+np/include/linux/dumpdev.h	2003-11-13 05:57:07.000000000 +0530
@@ -21,6 +21,7 @@
 
 #include <linux/kernel.h>
 #include <linux/wait.h>
+#include <linux/netpoll.h>
 #include <linux/bio.h>
 
 /* Determined by the dump target (device) type */
@@ -48,6 +49,7 @@ struct dump_dev {
 	struct dump_dev_ops *ops;
 	struct list_head list;
 	loff_t curr_offset;
+	struct netpoll np;
 };
 
 /*
Binary files linux.orig/index.1 and linux+np/index.1 differ
diff -urNp linux.orig/net/Kconfig linux+np/net/Kconfig
--- linux.orig/net/Kconfig	2003-11-13 05:56:14.000000000 +0530
+++ linux+np/net/Kconfig	2003-11-13 05:57:07.000000000 +0530
@@ -671,7 +671,7 @@ source "net/irda/Kconfig"
 source "net/bluetooth/Kconfig"
 
 config NETPOLL
-	def_bool NETCONSOLE
+	def_bool NETCONSOLE || CRASH_DUMP_NETDEV
 
 config NETPOLL_RX
 	bool "Netpoll support for trapping incoming packets"

-- 
Thanks & Regards
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-5044632

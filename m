Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTIVSp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbTIVSp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:45:59 -0400
Received: from waste.org ([209.173.204.2]:25279 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261602AbTIVSpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:45:33 -0400
Date: Mon, 22 Sep 2003 13:45:26 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, Robert Walsh <rjwalsh@durables.org>,
       wangdi <wangdi@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] netpoll-core
Message-ID: <20030922184526.GL2414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides an interface for polling NICs with interrupts
disabled, for both send and receive. It also provides an option parser
for configuring network parameters for subsystems that use the polling
interface. This functionality should be common between netconsole,
netdump, and kgdb-over-ethernet.

Changes:
- use arch hook for finding device irq handler
- added support for NAPI drivers with no driver modification
- pulled "trapped" logic into netpoll (also used by netdump)
- fixed lockup on SMP reboot with netconsole
- fixed source mac address handling
- added waiting for carrier detect (6sec timeout) to NIC startup code
- use list.h for rx_hook list
- proper cleanup function


 l-mpm/arch/i386/kernel/irq.c    |   15 
 l-mpm/include/asm/irq.h         |    1 
 l-mpm/include/linux/netdevice.h |   22 -
 l-mpm/include/linux/netpoll.h   |   37 ++
 l-mpm/net/Kconfig               |    3 
 l-mpm/net/core/Makefile         |    1 
 l-mpm/net/core/dev.c            |   22 -
 l-mpm/net/core/netpoll.c        |  632 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 707 insertions(+), 26 deletions(-)

diff -puN /dev/null net/core/netpoll.c
--- /dev/null	2003-09-12 12:14:37.000000000 -0500
+++ l-mpm/net/core/netpoll.c	2003-09-22 13:15:31.000000000 -0500
@@ -0,0 +1,632 @@
+/*
+ * Common framework for low-level network console, dump, and debugger code
+ *
+ * Sep 8 2003  Matt Mackall <mpm@selenic.com>
+ */
+
+#include <linux/smp_lock.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/string.h>
+#include <linux/inetdevice.h>
+#include <linux/inet.h>
+#include <linux/interrupt.h>
+#include <linux/netpoll.h>
+#include <linux/sched.h>
+#include <net/tcp.h>
+#include <net/udp.h>
+
+/*
+ * We maintain a small pool of fully-sized skbs, to make sure the
+ * message gets out even in extreme OOM situations.
+ */
+
+#define MAX_SKBS 32
+#define MAX_UDP_CHUNK 1460
+
+static spinlock_t skb_list_lock = SPIN_LOCK_UNLOCKED;
+static int nr_skbs;
+static struct sk_buff *skbs;
+
+static spinlock_t rx_list_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(rx_list);
+
+static int trapped;
+
+#define MAX_SKB_SIZE \
+		(MAX_UDP_CHUNK + sizeof(struct udphdr) + \
+				sizeof(struct iphdr) + sizeof(struct ethhdr))
+
+static int checksum_udp(struct sk_buff *skb, struct udphdr *uh,
+			     unsigned short ulen, u32 saddr, u32 daddr)
+{
+	if (uh->check == 0)
+		return 0;
+
+	if (skb->ip_summed == CHECKSUM_HW)
+		return csum_tcpudp_magic(
+			saddr, daddr, ulen, IPPROTO_UDP, skb->csum);
+
+	skb->csum = csum_tcpudp_nofold(saddr, daddr, ulen, IPPROTO_UDP, 0);
+
+	return csum_fold(skb_checksum(skb, 0, skb->len, skb->csum));
+}
+
+void netpoll_poll(struct netpoll *np)
+{
+	int budget = 1;
+
+	if(!np || !np->dev || !(np->dev->flags & IFF_UP))
+		return;
+
+	disable_irq(np->dev->irq);
+
+	/* Process pending work on NIC */
+	np->irqfunc(np->dev->irq, np->dev, 0);
+
+	/* If scheduling is stopped, tickle NAPI bits */
+	if(trapped && np->dev->poll &&
+	   test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
+		np->dev->poll(np->dev, &budget);
+
+	enable_irq(np->dev->irq);
+}
+
+static void refill_skbs(void)
+{
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	spin_lock_irqsave(&skb_list_lock, flags);
+	while (nr_skbs < MAX_SKBS) {
+		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
+		if (!skb)
+			break;
+
+		skb->next = skbs;
+		skbs = skb;
+		nr_skbs++;
+	}
+	spin_unlock_irqrestore(&skb_list_lock, flags);
+}
+
+static void zap_completion_queue(void)
+{
+	unsigned long flags;
+	struct softnet_data *sd = &get_cpu_var(softnet_data);
+
+	if (sd->completion_queue) {
+		struct sk_buff *clist;
+
+		local_irq_save(flags);
+		clist = sd->completion_queue;
+		sd->completion_queue = NULL;
+		local_irq_save(flags);
+
+		while (clist != NULL) {
+			struct sk_buff *skb = clist;
+			clist = clist->next;
+			__kfree_skb(skb);
+		}
+	}
+
+	put_cpu_var(softnet_data);
+}
+
+static struct sk_buff * find_skb(struct netpoll *np, int len, int reserve)
+{
+	int once = 1, count = 0;
+	unsigned long flags;
+	struct sk_buff *skb = NULL;
+
+repeat:
+	zap_completion_queue();
+	if (nr_skbs < MAX_SKBS)
+		refill_skbs();
+
+	skb = alloc_skb(len, GFP_ATOMIC);
+
+	if (!skb) {
+		spin_lock_irqsave(&skb_list_lock, flags);
+		skb = skbs;
+		if (skb)
+			skbs = skb->next;
+		skb->next = NULL;
+		nr_skbs--;
+		spin_unlock_irqrestore(&skb_list_lock, flags);
+	}
+
+	if(!skb) {
+		count++;
+		if (once && (count == 1000000)) {
+			printk("out of netpoll skbs!\n");
+			once = 0;
+		}
+		netpoll_poll(np);
+		goto repeat;
+	}
+
+	atomic_set(&skb->users, 1);
+	skb_reserve(skb, reserve);
+	return skb;
+}
+
+void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
+{
+	int status;
+
+repeat:
+	if(!np || !np->dev || !(np->dev->flags & IFF_UP)) {
+		__kfree_skb(skb);
+		return;
+	}
+
+	spin_lock(&np->dev->xmit_lock);
+	np->dev->xmit_lock_owner = smp_processor_id();
+
+	if (netif_queue_stopped(np->dev)) {
+		np->dev->xmit_lock_owner = -1;
+		spin_unlock(&np->dev->xmit_lock);
+
+		netpoll_poll(np);
+		zap_completion_queue();
+		goto repeat;
+	}
+
+	status = np->dev->hard_start_xmit(skb, np->dev);
+	np->dev->xmit_lock_owner = -1;
+	spin_unlock(&np->dev->xmit_lock);
+
+	/* transmit busy */
+	if(status)
+		goto repeat;
+}
+
+void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
+{
+	int total_len, eth_len, ip_len, udp_len;
+	struct sk_buff *skb;
+	struct udphdr *udph;
+	struct iphdr *iph;
+	struct ethhdr *eth;
+
+	udp_len = len + sizeof(*udph);
+	ip_len = eth_len = udp_len + sizeof(*iph);
+	total_len = eth_len + ETH_HLEN;
+
+	skb = find_skb(np, total_len, total_len - len);
+	if (!skb)
+		return;
+
+	memcpy(skb->data, msg, len);
+	skb->len += len;
+
+	udph = (struct udphdr *) skb_push(skb, sizeof(*udph));
+	udph->source = htons(np->local_port);
+	udph->dest = htons(np->remote_port);
+	udph->len = htons(udp_len);
+	udph->check = 0;
+
+	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
+
+	iph->version  = 4;
+	iph->ihl      = 5;
+	iph->tos      = 0;
+	iph->tot_len  = htons(ip_len);
+	iph->id       = 0;
+	iph->frag_off = 0;
+	iph->ttl      = 64;
+	iph->protocol = IPPROTO_UDP;
+	iph->check    = 0;
+	iph->saddr    = htonl(np->local_ip);
+	iph->daddr    = htonl(np->remote_ip);
+	iph->check    = ip_fast_csum((unsigned char *)iph, iph->ihl);
+
+	eth = (struct ethhdr *) skb_push(skb, ETH_HLEN);
+
+	eth->h_proto = htons(ETH_P_IP);
+	memcpy(eth->h_source, np->local_mac, 6);
+	memcpy(eth->h_dest, np->remote_mac, 6);
+
+	netpoll_send_skb(np, skb);
+}
+
+static void arp_reply(struct sk_buff *skb)
+{
+	struct in_device *in_dev = (struct in_device *) skb->dev->ip_ptr;
+	struct arphdr *arp;
+	unsigned char *arp_ptr, *sha, *tha;
+	int size, type = ARPOP_REPLY, ptype = ETH_P_ARP;
+	u32 sip, tip;
+	struct sk_buff *send_skb;
+	unsigned long flags;
+	struct list_head *p;
+	struct netpoll *np = 0;
+
+	spin_lock_irqsave(&rx_list_lock, flags);
+	list_for_each(p, &rx_list) {
+		np = list_entry(p, struct netpoll, rx_list);
+		if ( np->dev == skb->dev )
+			break;
+		np = 0;
+	}
+	spin_unlock_irqrestore(&rx_list_lock, flags);
+
+	if (!np) return;
+
+	/* No arp on this interface */
+	if (!in_dev || skb->dev->flags & IFF_NOARP)
+		return;
+
+	if (!pskb_may_pull(skb, (sizeof(struct arphdr) +
+				 (2 * skb->dev->addr_len) +
+				 (2 * sizeof(u32)))))
+		return;
+
+	skb->h.raw = skb->nh.raw = skb->data;
+	arp = skb->nh.arph;
+
+	if ((arp->ar_hrd != htons(ARPHRD_ETHER) &&
+	     arp->ar_hrd != htons(ARPHRD_IEEE802)) ||
+	    arp->ar_pro != htons(ETH_P_IP) ||
+	    arp->ar_op != htons(ARPOP_REQUEST))
+		return;
+
+	arp_ptr= (unsigned char *)(arp+1);
+	sha = arp_ptr;
+	arp_ptr += skb->dev->addr_len;
+	memcpy(&sip, arp_ptr, 4);
+	arp_ptr += 4;
+	tha = arp_ptr;
+	arp_ptr += skb->dev->addr_len;
+	memcpy(&tip, arp_ptr, 4);
+
+	/* Should we ignore arp? */
+	if (tip != in_dev->ifa_list->ifa_address ||
+	    LOOPBACK(tip) || MULTICAST(tip))
+		return;
+
+
+	size = sizeof(struct arphdr) + 2 * (skb->dev->addr_len + 4);
+	send_skb = find_skb(np, size + LL_RESERVED_SPACE(np->dev),
+			    LL_RESERVED_SPACE(np->dev));
+
+	if (!send_skb)
+		return;
+
+	send_skb->nh.raw = send_skb->data;
+	arp = (struct arphdr *) skb_put(send_skb, size);
+	send_skb->dev = skb->dev;
+	send_skb->protocol = htons(ETH_P_ARP);
+
+	/* Fill the device header for the ARP frame */
+
+	if (np->dev->hard_header &&
+	    np->dev->hard_header(send_skb, skb->dev, ptype,
+				       np->remote_mac, np->local_mac,
+				       send_skb->len) < 0) {
+		kfree_skb(send_skb);
+		return;
+	}
+
+	/*
+	 * Fill out the arp protocol part.
+	 *
+	 * we only support ethernet device type,
+	 * which (according to RFC 1390) should always equal 1 (Ethernet).
+	 */
+
+	arp->ar_hrd = htons(np->dev->type);
+	arp->ar_pro = htons(ETH_P_IP);
+	arp->ar_hln = np->dev->addr_len;
+	arp->ar_pln = 4;
+	arp->ar_op = htons(type);
+
+	arp_ptr=(unsigned char *)(arp + 1);
+	memcpy(arp_ptr, np->dev->dev_addr, np->dev->addr_len);
+	arp_ptr += np->dev->addr_len;
+	memcpy(arp_ptr, &tip, 4);
+	arp_ptr += 4;
+	memcpy(arp_ptr, np->local_mac, np->dev->addr_len);
+	arp_ptr += np->dev->addr_len;
+	memcpy(arp_ptr, &sip, 4);
+
+	netpoll_send_skb(np, send_skb);
+}
+
+static int rx_hook(struct sk_buff *skb)
+{
+	int proto, len, ulen;
+	struct iphdr *iph;
+	struct udphdr *uh;
+	struct netpoll *np;
+	struct list_head *p;
+	unsigned long flags;
+
+	if (skb->dev->type != ARPHRD_ETHER)
+		goto out;
+
+	/* check if netpoll clients need ARP */
+	if (skb->protocol == __constant_htons(ETH_P_ARP) && trapped) {
+		arp_reply(skb);
+		return 1;
+	}
+
+	proto = ntohs(skb->mac.ethernet->h_proto);
+	if (proto != ETH_P_IP)
+		goto out;
+	if (skb->pkt_type == PACKET_OTHERHOST)
+		goto out;
+	if (skb_shared(skb))
+		goto out;
+
+	iph = (struct iphdr *)skb->data;
+	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		goto out;
+	if (iph->ihl < 5 || iph->version != 4)
+		goto out;
+	if (!pskb_may_pull(skb, iph->ihl*4))
+		goto out;
+	if (ip_fast_csum((u8 *)iph, iph->ihl) != 0)
+		goto out;
+
+	len = ntohs(iph->tot_len);
+	if (skb->len < len || len < iph->ihl*4)
+		goto out;
+
+	if (iph->protocol != IPPROTO_UDP)
+		goto out;
+
+	len -= iph->ihl*4;
+	uh = (struct udphdr *)(((char *)iph) + iph->ihl*4);
+	ulen = ntohs(uh->len);
+
+	if (ulen != len)
+		goto out;
+	if (checksum_udp(skb, uh, ulen, iph->saddr, iph->daddr) < 0)
+		goto out;
+
+	spin_lock_irqsave(&rx_list_lock, flags);
+	list_for_each(p, &rx_list) {
+		np = list_entry(p, struct netpoll, rx_list);
+		if (np->dev && np->dev != skb->dev)
+			continue;
+		if (np->local_ip && np->local_ip != ntohl(iph->daddr))
+			continue;
+		if (np->remote_ip && np->remote_ip != ntohl(iph->saddr))
+			continue;
+		if (np->local_port && np->local_port != ntohs(uh->dest))
+			continue;
+
+		spin_unlock_irqrestore(&rx_list_lock, flags);
+
+		if (np->rx_hook)
+			np->rx_hook(np, ntohs(uh->source),
+				    (char *)(uh+1), ulen-sizeof(uh)-4);
+
+		return 1;
+	}
+	spin_unlock_irqrestore(&rx_list_lock, flags);
+
+out:
+	return trapped;
+}
+
+int netpoll_parse_options(struct netpoll *np, char *opt)
+{
+	char *cur=opt, *delim;
+
+	if(*cur != '@') {
+		if ((delim = strchr(cur, '@')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		np->local_port=simple_strtol(cur, 0, 10);
+		cur=delim;
+	}
+	cur++;
+	printk(KERN_INFO "%s: local port %d\n", np->name, np->local_port);
+
+	if(*cur != '/') {
+		if ((delim = strchr(cur, '/')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		np->local_ip=ntohl(in_aton(cur));
+		cur=delim;
+
+		printk(KERN_INFO "%s: local IP %d.%d.%d.%d\n",
+		       np->name, HIPQUAD(np->local_ip));
+	}
+	cur++;
+
+	if ( *cur != ',') {
+		/* parse out dev name */
+		if ((delim = strchr(cur, ',')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		strlcpy(np->dev_name, cur, sizeof(np->dev_name));
+		cur=delim;
+	}
+	cur++;
+
+	printk(KERN_INFO "%s: interface %s\n", np->name, np->dev_name);
+
+	if ( *cur != '@' ) {
+		/* dst port */
+		if ((delim = strchr(cur, '@')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		np->remote_port=simple_strtol(cur, 0, 10);
+		cur=delim;
+	}
+	cur++;
+	printk(KERN_INFO "%s: remote port %d\n", np->name, np->remote_port);
+
+	/* dst ip */
+	if ((delim = strchr(cur, '/')) == NULL)
+		goto parse_failed;
+	*delim=0;
+	np->remote_ip=ntohl(in_aton(cur));
+	cur=delim+1;
+
+	printk(KERN_INFO "%s: remote IP %d.%d.%d.%d\n",
+		       np->name, HIPQUAD(np->remote_ip));
+
+	if( *cur != 0 )
+	{
+		/* MAC address */
+		if ((delim = strchr(cur, ':')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		np->remote_mac[0]=simple_strtol(cur, 0, 16);
+		cur=delim+1;
+		if ((delim = strchr(cur, ':')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		np->remote_mac[1]=simple_strtol(cur, 0, 16);
+		cur=delim+1;
+		if ((delim = strchr(cur, ':')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		np->remote_mac[2]=simple_strtol(cur, 0, 16);
+		cur=delim+1;
+		if ((delim = strchr(cur, ':')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		np->remote_mac[3]=simple_strtol(cur, 0, 16);
+		cur=delim+1;
+		if ((delim = strchr(cur, ':')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		np->remote_mac[4]=simple_strtol(cur, 0, 16);
+		cur=delim+1;
+		np->remote_mac[5]=simple_strtol(cur, 0, 16);
+	}
+
+	printk(KERN_INFO "%s: remote ethernet address "
+	       "%02x:%02x:%02x:%02x:%02x:%02x\n",
+	       np->name,
+	       np->remote_mac[0],
+	       np->remote_mac[1],
+	       np->remote_mac[2],
+	       np->remote_mac[3],
+	       np->remote_mac[4],
+	       np->remote_mac[5]);
+
+	return 0;
+
+ parse_failed:
+	printk(KERN_INFO "%s: couldn't parse config at %s!\n",
+	       np->name, cur);
+	return -1;
+}
+
+int netpoll_setup(struct netpoll *np)
+{
+	struct net_device *ndev = NULL;
+	struct in_device *in_dev;
+	struct irqaction *a;
+
+	if (np->dev_name)
+		ndev = dev_get_by_name(np->dev_name);
+	if (!ndev) {
+		printk(KERN_ERR "%s: %s doesn't exist, aborting.\n",
+		       np->name, np->dev_name);
+		return -1;
+	}
+
+	if (!(ndev->flags & IFF_UP)) {
+		unsigned short oflags;
+		unsigned long jiff;
+
+		printk(KERN_INFO "%s: device %s not up yet, forcing it\n",
+		       np->name, np->dev_name);
+
+		oflags = ndev->flags;
+
+		rtnl_shlock();
+		if (dev_change_flags(ndev, oflags | IFF_UP) < 0) {
+			printk(KERN_ERR "%s: failed to open %s\n",
+			       np->name, np->dev_name);
+			rtnl_shunlock();
+			return -1;
+		}
+		rtnl_shunlock();
+
+		jiff = jiffies + 6*HZ;
+		while(!netif_carrier_ok(ndev)) {
+			if (!time_before(jiffies, jiff)) {
+				printk(KERN_NOTICE
+				       "%s: timeout waiting for carrier\n",
+				       np->name);
+				break;
+			}
+			cond_resched();
+		}
+
+	}
+
+	if (!memcmp(np->local_mac, "\0\0\0\0\0\0", 6) && ndev->dev_addr)
+		memcpy(np->local_mac, ndev->dev_addr, 6);
+
+	if (!np->local_ip)
+	{
+		in_dev = in_dev_get(ndev);
+
+		if (!in_dev) {
+			printk(KERN_ERR "%s: no IP address for %s, aborting\n",
+			       np->name, np->dev_name);
+			return -1;
+		}
+
+		np->local_ip = ntohl(in_dev->ifa_list->ifa_local);
+		in_dev_put(in_dev);
+		printk(KERN_INFO "%s: local IP %d.%d.%d.%d\n",
+		       np->name, HIPQUAD(np->local_ip));
+	}
+
+	a=find_irq_action(ndev->irq, ndev);
+	if (!a) {
+		printk(KERN_ERR "%s: couldn't find irq handler for %s, "
+		       "aborting\n", np->name, np->dev_name);
+		return -1;
+	}
+
+	np->irqfunc = a->handler;
+	np->dev = ndev;
+
+	if(np->rx_hook) {
+		unsigned long flags;
+
+		np->dev->rx_hook = rx_hook;
+
+		spin_lock_irqsave(&rx_list_lock, flags);
+		list_add(&np->rx_list, &rx_list);
+		spin_unlock_irqrestore(&rx_list_lock, flags);
+	}
+
+	return 0;
+}
+
+void netpoll_cleanup(struct netpoll *np)
+{
+	if(np->rx_hook) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&rx_list_lock, flags);
+		list_del(&np->rx_list);
+		np->dev->rx_hook = 0;
+		spin_unlock_irqrestore(&rx_list_lock, flags);
+	}
+
+	np->dev = 0;
+}
+
+int netpoll_trap()
+{
+	return trapped;
+}
+
+void netpoll_set_trap(int trap)
+{
+	trapped = trap;
+}
diff -puN /dev/null include/linux/netpoll.h
--- /dev/null	2003-09-12 12:14:37.000000000 -0500
+++ l-mpm/include/linux/netpoll.h	2003-09-22 13:15:31.000000000 -0500
@@ -0,0 +1,37 @@
+/*
+ * Common code for low-level network console, dump, and debugger code
+ *
+ * Derived from netconsole, kgdb-over-ethernet, and netdump patches
+ */
+
+#ifndef _LINUX_NETPOLL_H
+#define _LINUX_NETPOLL_H
+
+#include <linux/netdevice.h>
+#include <linux/irq.h>
+#include <linux/list.h>
+
+struct netpoll;
+
+struct netpoll {
+	struct net_device *dev;
+	char dev_name[16], *name;
+	irqreturn_t (*irqfunc)(int, void *, struct pt_regs *);
+	void (*rx_hook)(struct netpoll *, int, char *, int);
+	u32 local_ip, remote_ip;
+	u16 local_port, remote_port;
+	unsigned char local_mac[6], remote_mac[6];
+	struct list_head rx_list;
+};
+
+void netpoll_poll(struct netpoll *np);
+void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
+void netpoll_send_udp(struct netpoll *np, const char *msg, int len);
+int netpoll_parse_options(struct netpoll *np, char *opt);
+int netpoll_setup(struct netpoll *np);
+int netpoll_trap(void);
+void netpoll_set_trap(int trap);
+void netpoll_cleanup(struct netpoll *np);
+
+
+#endif
diff -puN net/core/Makefile~netpoll-core net/core/Makefile
--- l/net/core/Makefile~netpoll-core	2003-09-22 13:15:31.000000000 -0500
+++ l-mpm/net/core/Makefile	2003-09-22 13:15:31.000000000 -0500
@@ -13,3 +13,4 @@ obj-$(CONFIG_NETFILTER) += netfilter.o
 obj-$(CONFIG_NET_DIVERT) += dv.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
 obj-$(CONFIG_NET_RADIO) += wireless.o
+obj-$(CONFIG_NETPOLL) += netpoll.o
diff -puN net/Kconfig~netpoll-core net/Kconfig
--- l/net/Kconfig~netpoll-core	2003-09-22 13:15:31.000000000 -0500
+++ l-mpm/net/Kconfig	2003-09-22 13:15:31.000000000 -0500
@@ -689,4 +689,7 @@ endmenu
 
 source "drivers/net/Kconfig"
 
+config NETPOLL
+	def_bool KGDB
+
 endmenu
diff -puN include/linux/netdevice.h~netpoll-core include/linux/netdevice.h
--- l/include/linux/netdevice.h~netpoll-core	2003-09-22 13:15:31.000000000 -0500
+++ l-mpm/include/linux/netdevice.h	2003-09-22 13:15:31.000000000 -0500
@@ -452,13 +452,13 @@ struct net_device
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
+#ifdef CONFIG_NETPOLL
+	int			(*rx_hook)(struct sk_buff *skb);
+#endif
 
 	/* bridge stuff */
 	struct net_bridge_port	*br_port;
 
-#ifdef CONFIG_KGDB
-	int			kgdb_is_trapped;
-#endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	void			(*poll_controller)(struct net_device *);
 #endif
@@ -536,10 +536,8 @@ extern int		dev_new_index(void);
 extern struct net_device	*dev_get_by_index(int ifindex);
 extern struct net_device	*__dev_get_by_index(int ifindex);
 extern int		dev_restart(struct net_device *dev);
-#ifdef CONFIG_KGDB
-extern int		kgdb_eth_is_trapped(void);
-extern int		kgdb_net_interrupt(struct sk_buff *skb);
-extern void		kgdb_send_arp_request(void);
+#ifdef CONFIG_NETPOLL
+extern int		netpoll_trap(void);
 #endif
 
 typedef int gifconf_func_t(struct net_device * dev, char * bufptr, int len);
@@ -599,10 +597,9 @@ static inline void netif_start_queue(str
 
 static inline void netif_wake_queue(struct net_device *dev)
 {
-#ifdef CONFIG_KGDB
-	if (kgdb_eth_is_trapped()) {
+#ifdef CONFIG_NETPOLL
+	if (netpoll_trap())
 		return;
-	}
 #endif
 	if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state))
 		__netif_schedule(dev);
@@ -610,10 +607,9 @@ static inline void netif_wake_queue(stru
 
 static inline void netif_stop_queue(struct net_device *dev)
 {
-#ifdef CONFIG_KGDB
-	if (kgdb_eth_is_trapped()) {
+#ifdef CONFIG_NETPOLL
+	if (netpoll_trap())
 		return;
-	}
 #endif
 	set_bit(__LINK_STATE_XOFF, &dev->state);
 }
diff -puN net/core/dev.c~netpoll-core net/core/dev.c
--- l/net/core/dev.c~netpoll-core	2003-09-22 13:15:31.000000000 -0500
+++ l-mpm/net/core/dev.c	2003-09-22 13:16:34.000000000 -0500
@@ -184,9 +184,6 @@ int netdev_fastroute_obstacles;
 extern int netdev_sysfs_init(void);
 extern int netdev_register_sysfs(struct net_device *);
 extern int netdev_unregister_sysfs(struct net_device *);
-#ifdef CONFIG_KGDB
-extern int kgdb_net_interrupt(struct sk_buff *skb);
-#endif
 
 
 /*******************************************************************************
@@ -1353,16 +1350,8 @@ int netif_rx(struct sk_buff *skb)
 	struct softnet_data *queue;
 	unsigned long flags;
 
-#ifdef CONFIG_KGDB
-	/* See if kgdb_eth wants this packet */
-	if (!kgdb_net_interrupt(skb)) {
-		/* No.. if we're 'trapped' then junk it */
-		if (kgdb_eth_is_trapped()) {
-			kfree_skb(skb);
-			return NET_RX_DROP;
-		}
-	} else {
-		/* kgdb_eth ate the packet... drop it silently */
+#ifdef CONFIG_NETPOLL
+	if (skb->dev->rx_hook && skb->dev->rx_hook(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
 	}
@@ -1552,6 +1541,13 @@ int netif_receive_skb(struct sk_buff *sk
 	int ret = NET_RX_DROP;
 	unsigned short type = skb->protocol;
 
+#ifdef CONFIG_NETPOLL
+	if (skb->dev->rx_hook && skb->dev->rx_hook(skb)) {
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
+#endif
+
 	if (!skb->stamp.tv_sec)
 		do_gettimeofday(&skb->stamp);
 
diff -puN include/asm/irq.h~netpoll-core include/asm/irq.h
--- l/include/asm/irq.h~netpoll-core	2003-09-22 13:15:31.000000000 -0500
+++ l-mpm/include/asm/irq.h	2003-09-22 13:15:31.000000000 -0500
@@ -24,6 +24,7 @@ extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
 extern void release_x86_irqs(struct task_struct *);
+struct irqaction *find_irq_action(unsigned int irq, void *dev_id);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
diff -puN arch/i386/kernel/irq.c~netpoll-core arch/i386/kernel/irq.c
--- l/arch/i386/kernel/irq.c~netpoll-core	2003-09-22 13:15:31.000000000 -0500
+++ l-mpm/arch/i386/kernel/irq.c	2003-09-22 13:15:31.000000000 -0500
@@ -896,6 +896,21 @@ int setup_irq(unsigned int irq, struct i
 	return 0;
 }
 
+struct irqaction *find_irq_action(unsigned int irq, void *dev_id)
+{
+	struct irqaction *a, *r=0;
+
+	spin_lock_irq(&irq_desc[irq].lock);
+	for(a=irq_desc[irq].action; a; a=a->next) {
+		if(a->dev_id == dev_id) {
+			r=a;
+			break;
+		}
+	}
+	spin_unlock_irq(&irq_desc[irq].lock);
+	return r;
+}
+
 static struct proc_dir_entry * root_irq_dir;
 static struct proc_dir_entry * irq_dir [NR_IRQS];
 

_


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon

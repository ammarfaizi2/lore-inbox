Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTILUAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTILUAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:00:40 -0400
Received: from waste.org ([209.173.204.2]:19175 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261828AbTILT7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:59:43 -0400
Date: Fri, 12 Sep 2003 14:59:33 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Robert Walsh <rjwalsh@durables.org>
Subject: Re: [PATCH 1/3] netpoll api
Message-ID: <20030912195933.GY4489@waste.org>
References: <20030910074030.GC4489@waste.org> <20030910004907.67b90bd1.akpm@osdl.org> <20030910081845.GF4489@waste.org> <20030910083935.GG1532@krispykreme> <20030910090846.GI4489@waste.org> <20030910094259.1e176300.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910094259.1e176300.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 09:42:59AM -0700, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > Well I'll come up with something for x86 tomorrow and when helper
> > macros materialize, I'll use them.
> 
> Please use the `try_to_find_handler()' thing for this.

Sorry, I got distracted by a shiny object for a couple days. Ok, here's take
2, which adds a find_irq_action for i386 (though should work for most
other arches) and fixes broken locking in rx_hook. The netconsole and
kgdb patches are unaffected.

8<

This patch provides an interface for polling NICs with interrupts
disabled, for both send and receive. It also provides an option parser
for configuring network parameters for subsystems that use the polling
interface. This functionality should be common between netconsole,
netdump, and kgdb-over-ethernet.


 l-mpm/arch/i386/kernel/irq.c    |   15 +
 l-mpm/include/asm/irq.h         |    1 
 l-mpm/include/linux/netdevice.h |    3 
 l-mpm/include/linux/netpoll.h   |   33 ++
 l-mpm/net/Kconfig               |    3 
 l-mpm/net/core/Makefile         |    1 
 l-mpm/net/core/dev.c            |   12 
 l-mpm/net/core/netpoll.c        |  572 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 630 insertions(+), 10 deletions(-)

diff -puN /dev/null net/core/netpoll.c
--- /dev/null	2003-02-25 20:03:23.000000000 -0600
+++ l-mpm/net/core/netpoll.c	2003-09-12 14:33:00.000000000 -0500
@@ -0,0 +1,572 @@
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
+static struct netpoll *receive_hooks;
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
+	disable_irq(np->dev->irq);
+	np->irqfunc(np->dev->irq, np->dev, 0);
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
+static void arp_reply(struct netpoll *np, struct sk_buff *skb)
+{
+	struct in_device *in_dev = (struct in_device *) np->dev->ip_ptr;
+	struct arphdr *arp;
+	unsigned char *arp_ptr, *sha, *tha;
+	int size, type = ARPOP_REPLY, ptype = ETH_P_ARP;
+	u32 sip, tip;
+	struct sk_buff *send_skb;
+
+	/* No arp on this interface */
+	if (!in_dev || np->dev->flags & IFF_NOARP)
+		return;
+
+	if (!pskb_may_pull(skb, (sizeof(struct arphdr) +
+				 (2 * np->dev->addr_len) +
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
+	arp_ptr += np->dev->addr_len;
+	memcpy(&sip, arp_ptr, 4);
+	arp_ptr += 4;
+	tha = arp_ptr;
+	arp_ptr += np->dev->addr_len;
+	memcpy(&tip, arp_ptr, 4);
+
+	/* Should we ignore arp? */
+	if (tip != in_dev->ifa_list->ifa_address ||
+	    np->remote_ip != ntohl(sip) ||
+	    LOOPBACK(tip) || MULTICAST(tip))
+		return;
+
+	size = sizeof(struct arphdr) + 2 * (np->dev->addr_len + 4);
+	send_skb = find_skb(np, size + LL_RESERVED_SPACE(np->dev),
+			    LL_RESERVED_SPACE(np->dev));
+
+	if (!send_skb)
+		return;
+
+	send_skb->nh.raw = send_skb->data;
+	arp = (struct arphdr *) skb_put(send_skb, size);
+	send_skb->dev = np->dev;
+	send_skb->protocol = htons(ETH_P_ARP);
+
+	/* Fill the device header for the ARP frame */
+
+	if (np->dev->hard_header &&
+	    np->dev->hard_header(send_skb, np->dev, ptype,
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
+	unsigned long flags;
+
+	if (skb->dev->type != ARPHRD_ETHER)
+		goto out;
+
+	/* check if netpoll clients need ARP */
+	if (skb->protocol == __constant_htons(ETH_P_ARP)) {
+		for (np = receive_hooks; np; np = np->next) {
+			if ( np->need_arp && np->dev == skb->dev ) {
+				arp_reply(np, skb);
+				goto out;
+			}
+		}
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
+
+	for (np = receive_hooks; np; np = np->next) {
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
+		return NET_RX_DROP;
+	}
+
+	spin_unlock_irqrestore(&rx_list_lock, flags);
+
+out:
+	return NET_RX_SUCCESS;
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
+		printk(KERN_ERR "%s: device %s not up yet, forcing it\n",
+		       np->name, np->dev_name);
+
+		oflags = ndev->flags;
+
+		rtnl_shlock();
+		if (dev_change_flags(ndev, oflags | IFF_UP) < 0) {
+			printk(KERN_ERR "netconsole: failed to open %s\n",
+			       np->dev_name);
+			rtnl_shunlock();
+			return -1;
+		}
+		rtnl_shunlock();
+
+		/* Give driver a chance to settle */
+		jiff = jiffies + 2*HZ;
+		while (time_before(jiffies, jiff))
+			;
+	}
+
+	if(!np->local_ip)
+	{
+		in_dev = in_dev_get(ndev);
+
+		if(!in_dev) {
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
+	if(!a) {
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
+		spin_lock_irqsave(&rx_list_lock, flags);
+		np->next = receive_hooks;
+		receive_hooks = np;
+		np->dev->rx_hook = rx_hook;
+		spin_unlock_irqrestore(&rx_list_lock, flags);
+	}
+
+	return 0;
+}
+
diff -puN /dev/null include/linux/netpoll.h
--- /dev/null	2003-02-25 20:03:23.000000000 -0600
+++ l-mpm/include/linux/netpoll.h	2003-09-10 00:14:23.000000000 -0500
@@ -0,0 +1,33 @@
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
+	int need_arp;
+	unsigned char local_mac[6], remote_mac[6];
+	struct netpoll *next;
+};
+
+void netpoll_poll(struct netpoll *np);
+void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
+void netpoll_send_udp(struct netpoll *np, const char *msg, int len);
+int netpoll_parse_options(struct netpoll *np, char *opt);
+int netpoll_setup(struct netpoll *np);
+
+#endif
diff -puN net/core/Makefile~netpoll-core net/core/Makefile
--- l/net/core/Makefile~netpoll-core	2003-09-10 00:14:23.000000000 -0500
+++ l-mpm/net/core/Makefile	2003-09-10 00:14:23.000000000 -0500
@@ -13,3 +13,4 @@ obj-$(CONFIG_NETFILTER) += netfilter.o
 obj-$(CONFIG_NET_DIVERT) += dv.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
 obj-$(CONFIG_NET_RADIO) += wireless.o
+obj-$(CONFIG_NETPOLL) += netpoll.o
diff -puN net/Kconfig~netpoll-core net/Kconfig
--- l/net/Kconfig~netpoll-core	2003-09-10 00:14:23.000000000 -0500
+++ l-mpm/net/Kconfig	2003-09-12 13:48:45.000000000 -0500
@@ -703,4 +703,7 @@ endmenu
 
 source "drivers/net/Kconfig"
 
+config NETPOLL
+	def_bool KGDB
+
 endmenu
diff -puN include/linux/netdevice.h~netpoll-core include/linux/netdevice.h
--- l/include/linux/netdevice.h~netpoll-core	2003-09-10 00:14:23.000000000 -0500
+++ l-mpm/include/linux/netdevice.h	2003-09-12 13:48:43.000000000 -0500
@@ -452,6 +452,9 @@ struct net_device
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
+#ifdef CONFIG_NETPOLL
+	int			(*rx_hook)(struct sk_buff *skb);
+#endif
 
 	/* bridge stuff */
 	struct net_bridge_port	*br_port;
diff -puN net/core/dev.c~netpoll-core net/core/dev.c
--- l/net/core/dev.c~netpoll-core	2003-09-10 00:14:23.000000000 -0500
+++ l-mpm/net/core/dev.c	2003-09-10 00:14:23.000000000 -0500
@@ -1346,16 +1346,8 @@ int netif_rx(struct sk_buff *skb)
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
+	if (skb->dev->rx_hook && skb->dev->rx_hook(skb) == NET_RX_DROP) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
 	}
diff -puN include/asm/irq.h~netpoll-core include/asm/irq.h
--- l/include/asm/irq.h~netpoll-core	2003-09-12 13:53:24.000000000 -0500
+++ l-mpm/include/asm/irq.h	2003-09-12 14:18:21.000000000 -0500
@@ -24,6 +24,7 @@ extern void disable_irq(unsigned int);
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
 extern void release_x86_irqs(struct task_struct *);
+struct irqaction *find_irq_action(unsigned int irq, void *dev_id);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
diff -puN arch/i386/kernel/irq.c~netpoll-core arch/i386/kernel/irq.c
--- l/arch/i386/kernel/irq.c~netpoll-core	2003-09-12 13:53:50.000000000 -0500
+++ l-mpm/arch/i386/kernel/irq.c	2003-09-12 14:23:18.000000000 -0500
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

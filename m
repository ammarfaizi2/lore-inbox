Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272318AbTHKIz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 04:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272325AbTHKIz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 04:55:58 -0400
Received: from waste.org ([209.173.204.2]:58571 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272318AbTHKIzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 04:55:09 -0400
Date: Mon, 11 Aug 2003 03:55:08 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] Netconsole debugging tool for 2.6
Message-ID: <20030811085508.GH31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because my development box makes the room it's in uncomfortably warm,
I've decided to take a stab at resurrecting Ingo's netconsole patch.

For those who missed it the first time around (for 2.4.10), this
module is a "serial console over networks" which lets you catch kernel
messages, oopses and so on that can't be caught by syslog.

Since I thought the biggest problem with the first version was
configuration, I went ahead and wrote some reasonable option parsing
and made it also work as built-in so you can now boot with:

  linux netconsole=2525@10.0.0.1/eth1,9353@10.0.0.2/12:34:56:78:9a:bc

    or just

  linux netconsole=@10.0.0.1/,@10.0.0.2/

I've also added support for a third NIC (TLAN). Accepting patches for
other cards (only about 10 lines of code each).

Issues:
 Probably better ways to handle device locking these days
 SMP-safe? 
 Would like to get logging up much earlier in the boot process
 Need support for more cards

diff -urN -X dontdiff orig/Documentation/networking/netlogging.txt work/Documentation/networking/netlogging.txt
--- orig/Documentation/networking/netlogging.txt	1969-12-31 18:00:00.000000000 -0600
+++ work/Documentation/networking/netlogging.txt	2003-08-11 02:55:56.000000000 -0500
@@ -0,0 +1,54 @@
+
+started by Ingo Molnar <mingo@redhat.com>, 2001.09.17
+2.6 port by Matt Mackall <mpm@selenic.com>, 2003.08.11
+
+This module logs kernel printk messages over UDP allowing debugging of
+problem where disk logging fails and serial consoles are impractical.
+
+It can be used either built-in or as a module. It takes a string
+configuration parameter "netconsole" in the following format:
+
+ netconsole=[src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
+
+   where
+        src-port      source for UDP packets (defaults to 6666)
+        src-ip        source IP to use (interface address)
+        dev           network interface (eth0)
+        tgt-port      port for logging agent (6666)
+        tgt-ip        IP address for logging agent
+        tgt-macaddr   ethernet MAC address for logging agent (broadcast)
+ 
+Examples:
+
+ linux netconsole=@10.0.0.1/eth1,9353@10.0.0.2/12:34:56:78:9a:bc
+
+  or
+
+ insmod netconsole netconsole=@/,@10.0.0.2/
+
+If the module is loaded then all kernel messages are sent to the
+target host via UDP packets. The remote host should run the
+client-side 'netconsole' daemon to display & log the messages.
+Alternately, netcat can be used in a pinch.
+
+WARNING: the default target ethernet setting uses the broadcast
+ethernet address to send packets, which can cause increased load on
+other systems on the same ethernet segment.
+
+NOTE: the network device (eth0 in the above case) can run any kind
+of other network traffic, netconsole is not intrusive. Netconsole
+might cause slight delays in other traffic if the volume of kernel
+messages is high, but should have no other impact.
+
+Netconsole was designed to be as instantaneous as possible, to
+enable the logging of even the most critical kernel bugs. It works
+from IRQ contexts as well, and does not enable interrupts while
+sending packets. Due to these unique needs, configuration can not
+be more automatic, and some fundamental limitations will remain:
+only IP networks, UDP packets and ethernet devices are supported.
+
+Currently supported network drivers:
+
+ eepro100
+ tulip
+ tlan
diff -urN -X dontdiff orig/drivers/net/Kconfig work/drivers/net/Kconfig
--- orig/drivers/net/Kconfig	2003-08-10 18:13:47.000000000 -0500
+++ work/drivers/net/Kconfig	2003-08-10 18:29:48.000000000 -0500
@@ -2711,3 +2711,11 @@
 source "drivers/atm/Kconfig"
 
 source "drivers/s390/net/Kconfig"
+
+config NETCONSOLE
+	tristate "Network console logging support"
+	depends on NETDEVICES
+	---help---
+	  If you want to log kernel messages over the network, then say
+	  "M" here. See Documentation/networking/netlogging.txt for details.
+
diff -urN -X dontdiff orig/drivers/net/Makefile work/drivers/net/Makefile
--- orig/drivers/net/Makefile	2003-08-01 21:44:13.000000000 -0500
+++ work/drivers/net/Makefile	2003-08-10 18:21:38.000000000 -0500
@@ -56,6 +56,8 @@
 obj-$(CONFIG_VIA_RHINE) += via-rhine.o mii.o
 obj-$(CONFIG_ADAPTEC_STARFIRE) += starfire.o mii.o
 
+obj-$(CONFIG_NETCONSOLE) += netconsole.o
+
 #
 # end link order section
 #
diff -urN -X dontdiff orig/drivers/net/eepro100.c work/drivers/net/eepro100.c
--- orig/drivers/net/eepro100.c	2003-08-10 18:13:47.000000000 -0500
+++ work/drivers/net/eepro100.c	2003-08-10 18:22:50.000000000 -0500
@@ -543,6 +543,7 @@
 static int speedo_rx(struct net_device *dev);
 static void speedo_tx_buffer_gc(struct net_device *dev);
 static irqreturn_t speedo_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static void poll_speedo (struct net_device *dev);
 static int speedo_close(struct net_device *dev);
 static struct net_device_stats *speedo_get_stats(struct net_device *dev);
 static int speedo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
@@ -885,6 +886,9 @@
 	dev->get_stats = &speedo_get_stats;
 	dev->set_multicast_list = &set_rx_mode;
 	dev->do_ioctl = &speedo_ioctl;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &poll_speedo;
+#endif
 
 	if (register_netdevice(dev))
 		goto err_free_unlock;
@@ -1675,6 +1679,23 @@
 	return IRQ_RETVAL(handled);
 }
 
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void poll_speedo (struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	speedo_interrupt (dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+
+#endif
+
 static inline struct RxFD *speedo_rx_alloc(struct net_device *dev, int entry)
 {
 	struct speedo_private *sp = (struct speedo_private *)dev->priv;
diff -urN -X dontdiff orig/drivers/net/netconsole.c work/drivers/net/netconsole.c
--- orig/drivers/net/netconsole.c	1969-12-31 18:00:00.000000000 -0600
+++ work/drivers/net/netconsole.c	2003-08-11 03:09:12.000000000 -0500
@@ -0,0 +1,457 @@
+/*
+ *  linux/drivers/net/netconsole.c
+ *
+ *  Copyright (C) 2001  Ingo Molnar <mingo@redhat.com>
+ *
+ *  This file contains the implementation of an IRQ-safe, crash-safe
+ *  kernel console implementation that outputs kernel messages to the
+ *  network.
+ *
+ * Modification history:
+ *
+ * 2001-09-17    started by Ingo Molnar.
+ * 2003-08-11    2.6 port by Matt Mackall
+ *               simplified options
+ *               added TLAN
+ *               works non-modular
+ */
+
+/****************************************************************
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation; either version 2, or (at your option)
+ *      any later version.
+ *
+ *      This program is distributed in the hope that it will be useful,
+ *      but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *      GNU General Public License for more details.
+ *
+ *      You should have received a copy of the GNU General Public License
+ *      along with this program; if not, write to the Free Software
+ *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ ****************************************************************/
+
+#include <net/tcp.h>
+#include <net/udp.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <asm/unaligned.h>
+#include <linux/console.h>
+#include <linux/smp_lock.h>
+#include <linux/netdevice.h>
+#include <linux/tty_driver.h>
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/string.h>
+#include <linux/inetdevice.h>
+#include <linux/delay.h>
+
+static struct net_device *netconsole_dev;
+static u16 source_port=6666, target_port=6666;
+static u32 source_ip, target_ip;
+static unsigned char daddr[6] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff} ;
+
+#define NETCONSOLE_VERSION 0x01
+#define HEADER_LEN 5
+
+#define MAX_UDP_CHUNK 1460
+#define MAX_PRINT_CHUNK (MAX_UDP_CHUNK-HEADER_LEN)
+
+/*
+ * We maintain a small pool of fully-sized skbs,
+ * to make sure the message gets out even in
+ * extreme OOM situations.
+ */
+#define MAX_NETCONSOLE_SKBS 32
+
+static spinlock_t netconsole_lock = SPIN_LOCK_UNLOCKED;
+static int nr_netconsole_skbs;
+static struct sk_buff *netconsole_skbs;
+
+#define MAX_SKB_SIZE \
+		(MAX_UDP_CHUNK + sizeof(struct udphdr) + \
+				sizeof(struct iphdr) + sizeof(struct ethhdr))
+
+static void __refill_netconsole_skbs(void)
+{
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	spin_lock_irqsave(&netconsole_lock, flags);
+	while (nr_netconsole_skbs < MAX_NETCONSOLE_SKBS) {
+		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
+		if (!skb)
+			break;
+		if (netconsole_skbs)
+			skb->next = netconsole_skbs;
+		else
+			skb->next = NULL;
+		netconsole_skbs = skb;
+		nr_netconsole_skbs++;
+	}
+	spin_unlock_irqrestore(&netconsole_lock, flags);
+}
+
+static struct sk_buff * get_netconsole_skb(void)
+{
+	struct sk_buff *skb;
+
+	unsigned long flags;
+
+	spin_lock_irqsave(&netconsole_lock, flags);
+	skb = netconsole_skbs;
+	if (skb)
+		netconsole_skbs = skb->next;
+	skb->next = NULL;
+	nr_netconsole_skbs--;
+	spin_unlock_irqrestore(&netconsole_lock, flags);
+
+	return skb;
+}
+
+static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
+static unsigned int offset;
+
+static void send_netconsole_skb(struct net_device *dev, const char *msg, unsigned int msg_len)
+{
+	int total_len, eth_len, ip_len, udp_len;
+	unsigned long flags;
+	struct sk_buff *skb;
+	struct udphdr *udph;
+	struct iphdr *iph;
+	struct ethhdr *eth;
+
+	udp_len = msg_len + HEADER_LEN + sizeof(*udph);
+	ip_len = eth_len = udp_len + sizeof(*iph);
+	total_len = eth_len + ETH_HLEN;
+
+	if (nr_netconsole_skbs < MAX_NETCONSOLE_SKBS)
+		__refill_netconsole_skbs();
+
+	skb = alloc_skb(total_len, GFP_ATOMIC);
+	if (!skb) {
+		skb = get_netconsole_skb();
+		if (!skb)
+			/* tough! */
+			return;
+	}
+
+	atomic_set(&skb->users, 1);
+	skb_reserve(skb, total_len - msg_len - HEADER_LEN);
+	skb->data[0] = NETCONSOLE_VERSION;
+
+	spin_lock_irqsave(&sequence_lock, flags);
+	put_unaligned(htonl(offset), (u32 *) (skb->data + 1));
+	offset += msg_len;
+	spin_unlock_irqrestore(&sequence_lock, flags);
+
+	memcpy(skb->data + HEADER_LEN, msg, msg_len);
+	skb->len += msg_len + HEADER_LEN;
+
+	udph = (struct udphdr *) skb_push(skb, sizeof(*udph));
+	udph->source = source_port;
+	udph->dest = target_port;
+	udph->len = htons(udp_len);
+	udph->check = 0;
+
+	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
+
+	iph->version  = 4;
+	iph->ihl      = 5;
+	iph->tos      = 0;
+        iph->tot_len  = htons(ip_len);
+	iph->id       = 0;
+	iph->frag_off = 0;
+	iph->ttl      = 64;
+        iph->protocol = IPPROTO_UDP;
+	iph->check    = 0;
+        iph->saddr    = source_ip;
+        iph->daddr    = target_ip;
+	iph->check    = ip_fast_csum((unsigned char *)iph, iph->ihl);
+
+	eth = (struct ethhdr *) skb_push(skb, ETH_HLEN);
+
+	eth->h_proto = htons(ETH_P_IP);
+	memcpy(eth->h_source, dev->dev_addr, dev->addr_len);
+	memcpy(eth->h_dest, daddr, dev->addr_len);
+
+repeat:
+	spin_lock(&dev->xmit_lock);
+	dev->xmit_lock_owner = smp_processor_id();
+
+	if (netif_queue_stopped(dev)) {
+		dev->xmit_lock_owner = -1;
+		spin_unlock(&dev->xmit_lock);
+
+		dev->poll_controller(dev);
+		goto repeat;
+	}
+
+	dev->hard_start_xmit(skb, dev);
+
+	dev->xmit_lock_owner = -1;
+	spin_unlock(&dev->xmit_lock);
+}
+
+static void write_netconsole_msg(struct console *con, const char *msg, unsigned int msg_len)
+{
+	int len, left;
+	struct net_device *dev;
+
+	dev = netconsole_dev;
+	if (!dev)
+		return;
+
+	if (dev->poll_controller && netif_running(dev)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		left = msg_len;
+repeat:
+		if (left > MAX_PRINT_CHUNK)
+			len = MAX_PRINT_CHUNK;
+		else
+			len = left;
+		send_netconsole_skb(dev, msg, len);
+		msg += len;
+		left -= len;
+		if (left)
+			goto repeat;
+		local_irq_restore(flags);
+	}
+}
+
+static char dev_name[16]="eth0";
+static char config[256];
+module_param_string(netconsole, config, 256, 0);
+MODULE_PARM_DESC(netconsole, " netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]\n");
+
+static struct console netconsole =
+	 { flags: CON_ENABLED, write: write_netconsole_msg };
+
+static int option_setup(char *opt)
+{
+	char *cur=opt, *delim;
+	int a,b,c,d;
+
+	printk(KERN_INFO "netconsole options: \"%s\"\n", opt);
+
+	if(*cur != '@') {
+		/* src port */
+		if ((delim = strchr(cur, '@')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		source_port=simple_strtol(cur, 0, 10);
+		cur=delim;
+	}
+	cur++;
+	printk(KERN_INFO "netconsole: source port %d\n", source_port);
+
+	if(*cur != '/') {
+		/* src ip */
+		if ((delim = strchr(cur, '.')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		a=simple_strtol(cur, 0, 10);
+		cur=delim+1;
+		if ((delim = strchr(cur, '.')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		b=simple_strtol(cur, 0, 10);
+		cur=delim+1;
+		if ((delim = strchr(cur, '.')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		c=simple_strtol(cur, 0, 10);
+		cur=delim+1;
+		if ((delim = strchr(cur, '/')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		d=simple_strtol(cur, 0, 10);
+		cur=delim;
+		
+		source_ip=(a<<24)+(b<<16)+(c<<8)+d;
+#define IP(x) ((unsigned char *)&source_ip)[x]
+		printk(KERN_INFO "netconsole: source IP %u.%u.%u.%u\n",
+		       IP(3), IP(2), IP(1), IP(0));
+#undef IP
+	}
+	cur++;
+
+	if ( *cur != ',') {
+		/* parse out dev name */
+		if ((delim = strchr(cur, ',')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		strlcpy(dev_name, cur, sizeof(dev_name));
+		cur=delim;
+	}
+	cur++;
+
+	printk(KERN_INFO "netconsole: interface %s\n", dev_name);
+
+	if ( *cur != '@' ) {
+		/* dst port */
+		if ((delim = strchr(cur, '@')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		target_port=simple_strtol(cur, 0, 10);
+		cur=delim;
+	}
+	cur++;
+	printk(KERN_INFO "netconsole: target port %d\n", target_port);
+
+	/* dst ip */
+	if ((delim = strchr(cur, '.')) == NULL)
+		goto parse_failed;
+	*delim=0;
+	a=simple_strtol(cur, 0, 10);
+	cur=delim+1;
+	if ((delim = strchr(cur, '.')) == NULL)
+		goto parse_failed;
+	*delim=0;
+	b=simple_strtol(cur, 0, 10);
+	cur=delim+1;
+	if ((delim = strchr(cur, '.')) == NULL)
+		goto parse_failed;
+	*delim=0;
+	c=simple_strtol(cur, 0, 10);
+	cur=delim+1;
+	if ((delim = strchr(cur, '/')) == NULL)
+		goto parse_failed;
+	*delim=0;
+	d=simple_strtol(cur, 0, 10);
+	cur=delim+1;
+
+	target_ip=(a<<24)+(b<<16)+(c<<8)+d;
+
+#define IP(x) ((unsigned char *)&target_ip)[x]
+		printk(KERN_INFO "netconsole: target IP %u.%u.%u.%u\n",
+		       IP(3), IP(2), IP(1), IP(0));
+#undef IP
+
+	if( *cur != 0 )
+	{
+		/* MAC address */
+		if ((delim = strchr(cur, ':')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		daddr[0]=simple_strtol(cur, 0, 16);
+		cur=delim+1;
+		if ((delim = strchr(cur, ':')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		daddr[1]=simple_strtol(cur, 0, 16);
+		cur=delim+1;
+		if ((delim = strchr(cur, ':')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		daddr[2]=simple_strtol(cur, 0, 16);
+		cur=delim+1;
+		if ((delim = strchr(cur, ':')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		daddr[3]=simple_strtol(cur, 0, 16);
+		cur=delim+1;
+		if ((delim = strchr(cur, ':')) == NULL)
+			goto parse_failed;
+		*delim=0;
+		daddr[4]=simple_strtol(cur, 0, 16);
+		cur=delim+1;
+		daddr[5]=simple_strtol(cur, 0, 16);
+	}
+
+	printk(KERN_INFO "netconsole: target ethernet address "
+	       "%02x:%02x:%02x:%02x:%02x:%02x\n", 
+	       daddr[0], daddr[1], daddr[2], daddr[3], daddr[4], daddr[5]);
+
+	return 0;
+
+ parse_failed:
+	printk(KERN_INFO "netconsole: couldn't parse config at %s!\n",cur);
+	return -1;
+}
+
+__setup("netconsole=", option_setup);
+
+static int init_netconsole(void)
+{
+	struct net_device *ndev = NULL;
+	struct in_device *in_dev;
+	int ret;
+
+	if(strlen(config)) 
+	{
+		ret=option_setup(config);
+		if(ret!=0)
+			return ret;
+	}
+
+	// this will be valid once the device goes up.
+	if (*dev_name != 0)
+		ndev = dev_get_by_name(dev_name);
+	if (!ndev) {
+		printk(KERN_ERR "netconsole: %s doesn't exist, aborting.\n", 
+		       dev_name);
+		return -1;
+	}
+	if (!ndev->poll_controller) {
+		printk(KERN_ERR "netconsole: %s's network driver does not"
+		       " implement netlogging yet, aborting.\n", dev_name);
+		return -1;
+	}
+        in_dev = in_dev_get(ndev);
+	if (!in_dev) {
+		printk(KERN_ERR "netconsole: network device %s is not an" 
+		       " IP protocol device, winging it.\n", dev_name);
+	}
+
+	if (!source_ip) {
+		source_ip = ntohl(in_dev->ifa_list->ifa_local);
+
+		if(!source_ip) {
+			printk(KERN_ERR "netconsole: network device %s has no"
+			       " local address, aborting.\n", dev_name);
+			return -1;
+		}
+
+#define IP(x) ((unsigned char *)&source_ip)[x]
+		printk(KERN_INFO "netconsole: source IP %u.%u.%u.%u\n",
+		       IP(3), IP(2), IP(1), IP(0));
+#undef IP
+	}
+
+	source_ip = htonl(source_ip);
+	source_port = htons(source_port);
+	target_ip = htonl(target_ip);
+	target_port = htons(target_port);
+
+	netconsole_dev = ndev;
+#define STARTUP_MSG "[...network console startup...]\n"
+	write_netconsole_msg(NULL, STARTUP_MSG, strlen(STARTUP_MSG));
+
+	register_console(&netconsole);
+	printk(KERN_INFO "netconsole: network logging started\n");
+
+	return 0;
+}
+
+static void cleanup_netconsole(void)
+{
+	printk(KERN_INFO "netconsole: network logging shut down.\n");
+	unregister_console(&netconsole);
+
+#define SHUTDOWN_MSG "[...network console shutdown...]\n"
+	write_netconsole_msg(NULL, SHUTDOWN_MSG, strlen(SHUTDOWN_MSG));
+	netconsole_dev = NULL;
+}
+
+module_init(init_netconsole);
+module_exit(cleanup_netconsole);
+
+int dummy = MAX_SKB_SIZE;
diff -urN -X dontdiff orig/drivers/net/tlan.c work/drivers/net/tlan.c
--- orig/drivers/net/tlan.c	2003-08-10 18:13:48.000000000 -0500
+++ work/drivers/net/tlan.c	2003-08-10 22:56:51.000000000 -0500
@@ -296,6 +296,7 @@
 static int      TLan_probe1( struct pci_dev *pdev, long ioaddr, int irq, int rev, const struct pci_device_id *ent);
 static void	TLan_tx_timeout( struct net_device *dev);
 static int 	tlan_init_one( struct pci_dev *pdev, const struct pci_device_id *ent);
+static void	TLan_Poll(struct net_device *dev);
 
 static u32	TLan_HandleInvalid( struct net_device *, u16 );
 static u32	TLan_HandleTxEOF( struct net_device *, u16 );
@@ -452,6 +453,25 @@
 	pci_set_drvdata( pdev, NULL );
 } 
 
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void TLan_Poll (struct net_device *dev)
+{
+       disable_irq(dev->irq);
+       TLan_HandleInterrupt(dev->irq, dev, NULL);
+       enable_irq(dev->irq);
+}
+
+#endif
+ 
+
+
 static struct pci_driver tlan_driver = {
 	.name		= "tlan",
 	.id_table	= tlan_pci_tbl,
@@ -892,6 +912,9 @@
 	dev->do_ioctl = &TLan_ioctl;
 	dev->tx_timeout = &TLan_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &TLan_Poll;
+#endif
 
 	return 0;
 
diff -urN -X dontdiff orig/drivers/net/tulip/tulip_core.c work/drivers/net/tulip/tulip_core.c
--- orig/drivers/net/tulip/tulip_core.c	2003-08-10 18:13:48.000000000 -0500
+++ work/drivers/net/tulip/tulip_core.c	2003-08-10 18:21:38.000000000 -0500
@@ -245,6 +245,7 @@
 static struct net_device_stats *tulip_get_stats(struct net_device *dev);
 static int private_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void set_rx_mode(struct net_device *dev);
+static void poll_tulip(struct net_device *dev);
 
 
 
@@ -1630,6 +1631,9 @@
 	dev->get_stats = tulip_get_stats;
 	dev->do_ioctl = private_ioctl;
 	dev->set_multicast_list = set_rx_mode;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &poll_tulip;
+#endif
 
 	if (register_netdev(dev))
 		goto err_out_free_ring;
@@ -1787,6 +1791,24 @@
 }
 
 
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void poll_tulip (struct net_device *dev)
+{
+       disable_irq(dev->irq);
+       tulip_interrupt (dev->irq, dev, NULL);
+       enable_irq(dev->irq);
+}
+
+#endif
+
+
 static struct pci_driver tulip_driver = {
 	.name		= DRV_NAME,
 	.id_table	= tulip_pci_tbl,
diff -urN -X dontdiff orig/include/linux/netdevice.h work/include/linux/netdevice.h
--- orig/include/linux/netdevice.h	2003-08-10 18:13:53.000000000 -0500
+++ work/include/linux/netdevice.h	2003-08-10 18:21:38.000000000 -0500
@@ -446,6 +446,8 @@
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
+#define HAVE_POLL_CONTROLLER
+	void			(*poll_controller)(struct net_device *dev);
 
 	/* bridge stuff */
 	struct net_bridge_port	*br_port;


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon

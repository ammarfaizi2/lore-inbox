Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbTIJHrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 03:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbTIJHrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 03:47:14 -0400
Received: from waste.org ([209.173.204.2]:28851 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264937AbTIJHpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 03:45:42 -0400
Date: Wed, 10 Sep 2003 02:45:32 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Robert Walsh <rjwalsh@durables.org>
Subject: [PATCH 3/3] netpoll: kgdb-over-ethernet
Message-ID: <20030910074532.GE4489@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is also against test5-mm1

This patch refactors kgdb-over-ethernet to use the netpoll API and
removes the obsoleted CONFIG_NET_POLL_CONTROLLER code. It also cleans
up some minor rough edges. Works with most NICs with no special drivers.


 l-mpm/./arch/i386/kernel/kgdb_stub.c      |   84 -----
 l-mpm/./include/asm/kgdb.h                |    7 
 l-mpm/Documentation/i386/kgdb/kgdbeth.txt |   88 +----
 l-mpm/arch/i386/lib/kgdb_serial.c         |    2 
 l-mpm/drivers/net/Makefile                |    3 
 l-mpm/drivers/net/kgdb_eth.c              |  452 ++++--------------------------
 l-mpm/include/linux/netdevice.h           |    3 
 7 files changed, 100 insertions(+), 539 deletions(-)

diff -puN drivers/net/kgdb_eth.c~kgdb-netpoll drivers/net/kgdb_eth.c
--- l/drivers/net/kgdb_eth.c~kgdb-netpoll	2003-09-10 02:34:15.000000000 -0500
+++ l-mpm/drivers/net/kgdb_eth.c	2003-09-10 02:34:16.000000000 -0500
@@ -7,36 +7,26 @@
  *
  * Twiddled for 2.6 by Robert Walsh <rjwalsh@durables.org>
  * and wangdi <wangdi@clusterfs.com>.
+ *
+ * Refactored for netpoll API by Matt Mackall <mpm@selenic.com>
+ *
  */
 
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
 #include <linux/sched.h>
-#include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/config.h>
-#include <linux/major.h>
 #include <linux/string.h>
-#include <linux/fcntl.h>
-#include <linux/termios.h>
-#include <asm/kgdb.h>
-#include <linux/if_ether.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/delay.h>
-#include <net/tcp.h>
-#include <net/udp.h>
+#include <linux/netpoll.h>
 
 #include <asm/system.h>
+#include <asm/kgdb.h>
 #include <asm/io.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/atomic.h>
 
+
 #define	GDB_BUF_SIZE	512		/* power of 2, please */
 
 static char	kgdb_buf[GDB_BUF_SIZE] ;
@@ -44,26 +34,29 @@ static int	kgdb_buf_in_inx ;
 static atomic_t	kgdb_buf_in_cnt ;
 static int	kgdb_buf_out_inx ;
 
+#define ETH_QUEUE_SIZE 256
+static char eth_queue[ETH_QUEUE_SIZE];
+static int outgoing_queue;
+
 extern void	set_debug_traps(void) ;		/* GDB routine */
 extern void	breakpoint(void);
 
-unsigned int	kgdb_remoteip = 0;
-unsigned short	kgdb_listenport = 6443;
-unsigned short	kgdb_sendport= 6442;
-int		kgdb_eth = -1; /* Default tty mode */
-unsigned char	kgdb_remotemac[6] = {0xff,0xff,0xff,0xff,0xff,0xff};
-unsigned char	kgdb_localmac[6] = {0xff,0xff,0xff,0xff,0xff,0xff};
-volatile int	kgdb_eth_is_initializing = 0;
-int		kgdb_eth_need_breakpoint[NR_CPUS];
+int kgdboe = 0; /* Default tty mode */
+int kgdb_eth_need_breakpoint[NR_CPUS];
 
-struct net_device *kgdb_netdevice = NULL;
+static void rx_hook(struct netpoll *np, int port, char *msg, int len);
 
-/*
- * Get a char if available, return -1 if nothing available.
- * Empty the receive buffer first, then look at the interface hardware.
- */
-static int
-read_char(void)
+static struct netpoll np = {
+	.name = "kgdboe",
+	.dev_name = "eth0",
+	.rx_hook = rx_hook,
+	.local_port = 6443,
+	.remote_port = 6442,
+	.local_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+};
+
+static int read_char(void)
 {
 	/* intr routine has queued chars */
 	if (atomic_read(&kgdb_buf_in_cnt) != 0)
@@ -79,283 +72,30 @@ read_char(void)
 	return -1; /* no data */
 }
 
-/*
- * Wait until the interface can accept a char, then write it.
- */
-static void
-write_buffer(char *buf, int len)
+static void write_buffer(char *buf, int len)
 {
-	int			total_len, eth_len, ip_len, udp_len;
-	struct in_device	*in_dev;
-	struct sk_buff		*skb;
-	struct udphdr		*udph;
-	struct iphdr		*iph;
-	struct ethhdr		*eth;
-
-	if (!(in_dev = (struct in_device *) kgdb_netdevice->ip_ptr)) {
-		panic("No in_device available for interface!\n");
-	}
-
-	if (!(in_dev->ifa_list)) {
-		panic("No interface address set for interface!\n");
-	}
-
-	udp_len = len + sizeof(struct udphdr);
-	ip_len = eth_len = udp_len + sizeof(struct iphdr);
-	total_len = eth_len + ETH_HLEN;
-
-	if (!(skb = alloc_skb(total_len, GFP_ATOMIC))) {
+	if (!np.dev)
 		return;
-	}
 
-	atomic_set(&skb->users, 1);
-	skb_reserve(skb, total_len - len);
-
-	memcpy(skb->data, (unsigned char *) buf, len);
-	skb->len += len;
-
-	udph = (struct udphdr *) skb_push(skb, sizeof(*udph));
-	udph->source = htons(kgdb_listenport);
-	udph->dest   = htons(kgdb_sendport);
-	udph->len    = htons(udp_len);
-	udph->check  = 0;
-
-	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
-	iph->version  = 4;
-	iph->ihl      = 5;
-	iph->tos      = 0;
-	iph->tot_len  = htons(ip_len);
-	iph->id       = 0;
-	iph->frag_off = 0;
-	iph->ttl      = 64;
-	iph->protocol = IPPROTO_UDP;
-	iph->check    = 0;
-	iph->saddr    = in_dev->ifa_list->ifa_address;
-	iph->daddr    = kgdb_remoteip;
-	iph->check    = ip_fast_csum((unsigned char *)iph, iph->ihl);
-
-	eth = (struct ethhdr *) skb_push(skb, ETH_HLEN);
-	eth->h_proto = htons(ETH_P_IP);
-	memcpy(eth->h_source, kgdb_localmac, kgdb_netdevice->addr_len);
-	memcpy(eth->h_dest, kgdb_remotemac, kgdb_netdevice->addr_len);
-
-repeat:
-	spin_lock(&kgdb_netdevice->xmit_lock);
-	kgdb_netdevice->xmit_lock_owner = smp_processor_id();
-
-	if (netif_queue_stopped(kgdb_netdevice)) {
-		kgdb_netdevice->xmit_lock_owner = -1;
-		spin_unlock(&kgdb_netdevice->xmit_lock);
-
-		kgdb_netdevice->poll_controller(kgdb_netdevice);
-		goto repeat;
-	}
-
-	kgdb_netdevice->hard_start_xmit(skb, kgdb_netdevice);
-	kgdb_netdevice->xmit_lock_owner = -1;
-	spin_unlock(&kgdb_netdevice->xmit_lock);
+	netpoll_send_udp(&np, buf, len);
 }
 
 /*
- * In the interrupt state the target machine will not respond to any
- * arp requests, so handle them here.
- */
-
-static struct sk_buff *send_skb = NULL;
-
-void
-kgdb_eth_reply_arp(void)
-{
-	if (send_skb) {
-		spin_lock(&kgdb_netdevice->xmit_lock);
-		kgdb_netdevice->xmit_lock_owner = smp_processor_id();
-	    	kgdb_netdevice->hard_start_xmit(send_skb, kgdb_netdevice);
-	    	kgdb_netdevice->xmit_lock_owner = -1;
-	    	spin_unlock(&kgdb_netdevice->xmit_lock);
-		send_skb = NULL;
-	}
-}
-
-static int
-make_arp_request(struct sk_buff *skb)
-{
-	struct arphdr *arp;
-	unsigned char *arp_ptr;
-	int type = ARPOP_REPLY;
-	int ptype = ETH_P_ARP;
-	u32 sip, tip;
-	unsigned char *sha, *tha;
-	struct in_device *in_dev = (struct in_device *) kgdb_netdevice->ip_ptr;
-
-	/* No arp on this interface */
-
-	if (kgdb_netdevice->flags & IFF_NOARP) {
-		return 0;
-	}
-
-	if (!pskb_may_pull(skb, (sizeof(struct arphdr) +
-				 (2 * kgdb_netdevice->addr_len) +
-				 (2 * sizeof(u32))))) {
-		return 0;
-	}
-
-	skb->h.raw = skb->nh.raw = skb->data;
-	arp = skb->nh.arph;
-
-	if ((arp->ar_hrd != htons(ARPHRD_ETHER) &&
-	     arp->ar_hrd != htons(ARPHRD_IEEE802)) ||
-	    arp->ar_pro != htons(ETH_P_IP)) {
-		return 0;
-	}
-
-	/* Understand only these message types */
-
-	if (arp->ar_op != htons(ARPOP_REQUEST)) {
-		return 0;
-	}
-
-	/* Extract fields */
-
-	arp_ptr= (unsigned char *)(arp+1);
-	sha = arp_ptr;
-	arp_ptr += kgdb_netdevice->addr_len;
-	memcpy(&sip, arp_ptr, 4);
-	arp_ptr += 4;
-	tha = arp_ptr;
-	arp_ptr += kgdb_netdevice->addr_len;
-	memcpy(&tip, arp_ptr, 4);
-
-	if (tip != in_dev->ifa_list->ifa_address) {
-		return 0;
-	}
-
-	if (kgdb_remoteip != sip) {
-		return 0;
-	}
-
-	/*
-	 * Check for bad requests for 127.x.x.x and requests for multicast
-	 * addresses.  If this is one such, delete it.
-	 */
-
-	if (LOOPBACK(tip) || MULTICAST(tip)) {
-		return 0;
-	}
-
-	/* reply to the ARP request */
-
-	send_skb = alloc_skb(sizeof(struct arphdr) + 2 * (kgdb_netdevice->addr_len + 4) + LL_RESERVED_SPACE(kgdb_netdevice), GFP_ATOMIC);
-
-	if (send_skb == NULL) {
-		return 0;
-	}
-
-	skb_reserve(send_skb, LL_RESERVED_SPACE(kgdb_netdevice));
-	send_skb->nh.raw = send_skb->data;
-	arp = (struct arphdr *) skb_put(send_skb, sizeof(struct arphdr) + 2 * (kgdb_netdevice->addr_len + 4));
-	send_skb->dev = kgdb_netdevice;
-	send_skb->protocol = htons(ETH_P_ARP);
-
-	/* Fill the device header for the ARP frame */
-
-	if (kgdb_netdevice->hard_header &&
-	    kgdb_netdevice->hard_header(send_skb, kgdb_netdevice, ptype,
-				       kgdb_remotemac, kgdb_localmac,
-				       send_skb->len) < 0) {
-		kfree_skb(send_skb);
-		return 0;
-	}
-
-	/*
-	 * Fill out the arp protocol part.
-	 *
-	 * we only support ethernet device type,
-	 * which (according to RFC 1390) should always equal 1 (Ethernet).
-	 */
-
-	arp->ar_hrd = htons(kgdb_netdevice->type);
-	arp->ar_pro = htons(ETH_P_IP);
-
-	arp->ar_hln = kgdb_netdevice->addr_len;
-	arp->ar_pln = 4;
-	arp->ar_op = htons(type);
-
-	arp_ptr=(unsigned char *)(arp + 1);
-
-	memcpy(arp_ptr, kgdb_netdevice->dev_addr, kgdb_netdevice->addr_len);
-	arp_ptr += kgdb_netdevice->addr_len;
-	memcpy(arp_ptr, &tip, 4);
-	arp_ptr += 4;
-	memcpy(arp_ptr, kgdb_localmac, kgdb_netdevice->addr_len);
-	arp_ptr += kgdb_netdevice->addr_len;
-	memcpy(arp_ptr, &sip, 4);
-	return 0;
-}
-
-
-/*
  * Accept an skbuff from net_device layer and add the payload onto
  * kgdb buffer
- *
- * When the kgdb stub routine getDebugChar() is called it draws characters
- * out of the buffer until it is empty and then reads directly from the
- * serial port.
- *
- * We do not attempt to write chars from the interrupt routine since
- * the stubs do all of that via putDebugChar() which writes one byte
- * after waiting for the interface to become ready.
- *
- * The debug stubs like to run with interrupts disabled since, after all,
- * they run as a consequence of a breakpoint in the kernel.
- *
- * NOTE: Return value of 1 means it was for us and is an indication to
- * the calling driver to destroy the sk_buff and not send it up the stack.
  */
-int
-kgdb_net_interrupt(struct sk_buff *skb)
+static void rx_hook(struct netpoll *np, int port, char *msg, int len)
 {
-	unsigned char	chr;
-	struct iphdr	*iph = (struct iphdr*)skb->data;
-	struct udphdr	*udph= (struct udphdr*)(skb->data+(iph->ihl<<2));
-	unsigned char	*data = (unsigned char *) udph + sizeof(struct udphdr);
-	int		len;
-	int		i;
-
-	if ((kgdb_eth != -1) && (!kgdb_netdevice) &&
-	    (iph->protocol == IPPROTO_UDP) &&
-	    (be16_to_cpu(udph->dest) == kgdb_listenport)) {
-		kgdb_sendport = be16_to_cpu(udph->source);
-
-		while (kgdb_eth_is_initializing)
-			;
-		if (!kgdb_netdevice)
-			kgdb_eth_hook();
-		if (!kgdb_netdevice) {
-			/* Lets not even try again. */
-			kgdb_eth = -1;
-			return 0;
-		}
-	}
-	if (!kgdb_netdevice) {
-		return 0;
-	}
-	if (skb->protocol == __constant_htons(ETH_P_ARP) && !send_skb) {
-		make_arp_request(skb);
-		return 0;
-	}
-	if (iph->protocol != IPPROTO_UDP) {
-		return 0;
-	}
+	int i, chr;
 
-	if (be16_to_cpu(udph->dest) != kgdb_listenport) {
-		return 0;
-	}
+	np->remote_port = port;
 
-	len = (be16_to_cpu(iph->tot_len) -
-	       (sizeof(struct udphdr) + sizeof(struct iphdr)));
+	/* This is gdb trying to attach */
+	if (!kgdb_eth_is_trapped() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
+		kgdb_eth_need_breakpoint[smp_processor_id()] = 1;
 
 	for (i = 0; i < len; i++) {
-		chr = data[i];
+		chr = msg[i];
 		if (chr == 3) {
 			kgdb_eth_need_breakpoint[smp_processor_id()] = 1;
 			continue;
@@ -371,112 +111,55 @@ kgdb_net_interrupt(struct sk_buff *skb)
 		kgdb_buf_in_inx &= (GDB_BUF_SIZE - 1);
 		atomic_inc(&kgdb_buf_in_cnt);
 	}
-
-	if (!kgdb_netdevice->kgdb_is_trapped) {
-		/*
-		 * If a new gdb instance is trying to attach, we need to
-		 * break here.
-		 */
-		if (!strncmp(data, "$Hc-1#09", 8))
-			kgdb_eth_need_breakpoint[smp_processor_id()] = 1;
-	}
-	return 1;
 }
-EXPORT_SYMBOL(kgdb_net_interrupt);
 
-int
-kgdb_eth_hook(void)
+static int option_setup(char *opt)
 {
-	char kgdb_netdev[16];
-	extern void kgdb_respond_ok(void);
-
-	if (kgdb_remotemac[0] == 0xff) {
-		panic("ERROR! 'gdbeth_remotemac' option not set!\n");
-	}
-	if (kgdb_localmac[0] == 0xff) {
-		panic("ERROR! 'gdbeth_localmac' option not set!\n");
-	}
-	if (kgdb_remoteip == 0) {
-		panic("ERROR! 'gdbeth_remoteip' option not set!\n");
-	}
+	return netpoll_parse_options(&np, opt);
+}
 
-	sprintf(kgdb_netdev,"eth%d",kgdb_eth);
+__setup("kgdboe=", option_setup);
 
+static int init_kgdboe(void)
+{
 #ifdef CONFIG_SMP
 	if (num_online_cpus() > CONFIG_NO_KGDB_CPUS) {
 		printk("kgdb: too manu cpus. Cannot enable debugger with more than %d cpus\n", CONFIG_NO_KGDB_CPUS);
 		return -1;
 	}
 #endif
-	for (kgdb_netdevice = dev_base;
-		kgdb_netdevice != NULL;
-		kgdb_netdevice = kgdb_netdevice->next) {
-		if (strncmp(kgdb_netdevice->name, kgdb_netdev, IFNAMSIZ) == 0) {
-			break;
-		}
-	}
-	if (!kgdb_netdevice) {
-		printk("KGDB NET : Unable to find interface %s\n",kgdb_netdev);
-		return -ENODEV;
-	}
 
-	/*
-	 * Call GDB routine to setup the exception vectors for the debugger
-	 */
 	set_debug_traps();
 
-	/*
-	 * Call the breakpoint() routine in GDB to start the debugging
-	 * session.
-	 */
-	kgdb_eth_is_initializing = 1;
-	kgdb_eth_need_breakpoint[smp_processor_id()] = 1;
+	if(!np.remote_ip || netpoll_setup(&np))
+		return 1;
+
+	kgdboe = 1;
+
+	printk(KERN_INFO "kgdb: debugging over ethernet enabled\n");
+
 	return 0;
 }
 
-/*
- * getDebugChar
- *
- * This is a GDB stub routine.  It waits for a character from the
- * serial interface and then returns it.  If there is no serial
- * interface connection then it returns a bogus value which will
- * almost certainly cause the system to hang.
- */
-int
-eth_getDebugChar(void)
+int eth_getDebugChar(void)
 {
-	volatile int	chr;
+	int chr;
+
+	while ((chr = read_char()) < 0)
+		netpoll_poll(&np);
 
-	while ((chr = read_char()) < 0) {
-		if (send_skb) {
-			kgdb_eth_reply_arp();
-		}
-		if (kgdb_netdevice->poll_controller) {
-			kgdb_netdevice->poll_controller(kgdb_netdevice);
-		} else {
-			printk("KGDB NET: Error - Device %s is not supported!\n", kgdb_netdevice->name);
-			panic("Please add support for kgdb net to this driver");
-		}
-	}
 	return chr;
 }
 
-#define ETH_QUEUE_SIZE 256
-static char eth_queue[ETH_QUEUE_SIZE];
-static int outgoing_queue;
-
-void
-eth_flushDebugChar(void)
+void eth_flushDebugChar(void)
 {
 	if(outgoing_queue) {
 		write_buffer(eth_queue, outgoing_queue);
-
 		outgoing_queue = 0;
 	}
 }
 
-static void
-put_char_on_queue(int chr)
+static void put_char_on_queue(int chr)
 {
 	eth_queue[outgoing_queue++] = chr;
 	if(outgoing_queue == ETH_QUEUE_SIZE)
@@ -485,33 +168,20 @@ put_char_on_queue(int chr)
 	}
 }
 
-/*
- * eth_putDebugChar
- *
- * This is a GDB stub routine.  It waits until the interface is ready
- * to transmit a char and then sends it.
- */
-void
-eth_putDebugChar(int chr)
+void eth_putDebugChar(int chr)
 {
 	put_char_on_queue(chr); /* this routine will wait */
 }
 
-void
-kgdb_eth_set_trapmode(int mode)
+void kgdb_eth_set_trapmode(int mode)
 {
-	if (!kgdb_netdevice) {
-		return;
-	}
-	kgdb_netdevice->kgdb_is_trapped = mode;
+	np.need_arp = mode;
 }
 
-int
-kgdb_eth_is_trapped()
+int kgdb_eth_is_trapped()
 {
-	if (!kgdb_netdevice) {
-		return 0;
-	}
-	return kgdb_netdevice->kgdb_is_trapped;
+	return np.need_arp;
 }
+
 EXPORT_SYMBOL(kgdb_eth_is_trapped);
+module_init(init_kgdboe);
diff -puN include/linux/netdevice.h~kgdb-netpoll include/linux/netdevice.h
--- l/include/linux/netdevice.h~kgdb-netpoll	2003-09-10 02:34:15.000000000 -0500
+++ l-mpm/include/linux/netdevice.h	2003-09-10 02:34:16.000000000 -0500
@@ -459,9 +459,6 @@ struct net_device
 	/* bridge stuff */
 	struct net_bridge_port	*br_port;
 
-#ifdef CONFIG_KGDB
-	int			kgdb_is_trapped;
-#endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	void			(*poll_controller)(struct net_device *);
 #endif
diff -puN ./arch/i386/kernel/kgdb_stub.c~kgdb-netpoll ./arch/i386/kernel/kgdb_stub.c
--- l/./arch/i386/kernel/kgdb_stub.c~kgdb-netpoll	2003-09-10 02:34:15.000000000 -0500
+++ l-mpm/./arch/i386/kernel/kgdb_stub.c	2003-09-10 02:34:16.000000000 -0500
@@ -138,8 +138,6 @@ extern int eth_getDebugChar(void);    /*
 extern void eth_flushDebugChar(void); /* flush pending characters      */
 extern void kgdb_eth_set_trapmode(int);
 extern void kgdb_eth_reply_arp(void);   /*send arp request */
-extern volatile int kgdb_eth_is_initializing;
-
 
 /************************************************************************/
 /* BUFMAX defines the maximum number of characters in inbound/outbound buffers*/
@@ -281,13 +279,13 @@ malloc(int size)
 
 /*
  * I/O dispatch functions...
- * Based upon kgdb_eth, either call the ethernet
+ * Based upon kgdboe, either call the ethernet
  * handler or the serial one..
  */
 void
 putDebugChar(int c)
 {
-	if (kgdb_eth == -1) {
+	if (!kgdboe) {
 		tty_putDebugChar(c);
 	} else {
 		eth_putDebugChar(c);
@@ -297,7 +295,7 @@ putDebugChar(int c)
 int
 getDebugChar(void)
 {
-	if (kgdb_eth == -1) {
+	if (!kgdboe) {
 		return tty_getDebugChar();
 	} else {
 		return eth_getDebugChar();
@@ -307,7 +305,7 @@ getDebugChar(void)
 void
 flushDebugChar(void)
 {
-	if (kgdb_eth == -1) {
+	if (!kgdboe) {
 		tty_flushDebugChar();
 	} else {
 		eth_flushDebugChar();
@@ -494,7 +492,7 @@ putpacket(char *buffer)
 
 	/*  $<packet info>#<checksum>. */
 
-	if (kgdb_eth == -1) {
+	if (!kgdboe) {
 		do {
 			if (remote_debug)
 				printk("T:%s\n", buffer);
@@ -1281,9 +1279,8 @@ kgdb_handle_exception(int exceptionVecto
 
 	__asm__("movl %%cr2,%0":"=r" (address));
 
-	if (kgdb_eth != -1) {
+	if (kgdboe)
 		kgdb_eth_set_trapmode(1);
-	}
 
 	kgdb_local_irq_save(flags);
 
@@ -1526,13 +1523,8 @@ kgdb_handle_exception(int exceptionVecto
 	remcomOutBuffer[2] = hexchars[signo % 16];
 	remcomOutBuffer[3] = 0;
 
-	if (kgdb_eth_is_initializing) {
-		kgdb_eth_is_initializing = 0;
-	} else {
-		putpacket(remcomOutBuffer);
-	}
+	putpacket(remcomOutBuffer);
 
-	kgdb_eth_reply_arp();
 	while (1 == 1) {
 		error = 0;
 		remcomOutBuffer[0] = 0;
@@ -1689,7 +1681,7 @@ kgdb_handle_exception(int exceptionVecto
 
 			newPC = regs.eip;
 
-			if (kgdb_eth != -1) {
+			if (kgdboe) {
 				kgdb_eth_set_trapmode(0);
 			}
 
@@ -2430,63 +2422,3 @@ typedef int gdb_debug_hook(int exception
 			   int signo, int err_code, struct pt_regs *linux_regs);
 gdb_debug_hook *linux_debug_hook = &kgdb_handle_exception;	/* histerical reasons... */
 
-static int __init kgdb_opt_kgdbeth(char *str)
-{
-	kgdb_eth = simple_strtoul(str, NULL, 10);
-	return 1;
-}
-
-static int __init kgdb_opt_kgdbeth_remoteip(char *str)
-{
-	kgdb_remoteip = in_aton(str);
-	return 1;
-}
-
-static int __init kgdb_opt_kgdbeth_listenport(char *str)
-{
-	kgdb_listenport = simple_strtoul(str, NULL, 10);
-	kgdb_sendport = kgdb_listenport - 1;
-	return 1;
-}
-
-static int __init parse_hw_addr(char *str, unsigned char *addr)
-{
-	int  i;
-	char *p;
-
-	p = str;
-	i = 0;
-	while(1)
-	{
-		unsigned int c;
-
-		sscanf(p, "%x:", &c);
-		addr[i++] = c;
-		while((*p != 0) && (*p != ':')) {
-			p++;
-		}
-		if (*p == 0) {
-			break;
-		}
-		p++;
-	}
-
-	return 1;
-}
-
-static int __init kgdb_opt_kgdbeth_remotemac(char *str)
-{
-	return parse_hw_addr(str, kgdb_remotemac);
-}
-static int __init kgdb_opt_kgdbeth_localmac(char *str)
-{
-	return parse_hw_addr(str, kgdb_localmac);
-}
-
-
-__setup("gdbeth=", kgdb_opt_kgdbeth);
-__setup("gdbeth_remoteip=", kgdb_opt_kgdbeth_remoteip);
-__setup("gdbeth_listenport=", kgdb_opt_kgdbeth_listenport);
-__setup("gdbeth_remotemac=", kgdb_opt_kgdbeth_remotemac);
-__setup("gdbeth_localmac=", kgdb_opt_kgdbeth_localmac);
-
diff -puN ./include/asm/kgdb.h~kgdb-netpoll ./include/asm/kgdb.h
--- l/./include/asm/kgdb.h~kgdb-netpoll	2003-09-10 02:34:15.000000000 -0500
+++ l-mpm/./include/asm/kgdb.h	2003-09-10 02:34:16.000000000 -0500
@@ -21,12 +21,7 @@ extern void breakpoint(void);
 
 struct sk_buff;
 
-extern int kgdb_eth;
-extern unsigned kgdb_remoteip;
-extern unsigned short kgdb_listenport;
-extern unsigned short kgdb_sendport;
-extern unsigned char kgdb_remotemac[6];
-extern unsigned char kgdb_localmac[6];
+extern int kgdboe;
 extern int kgdb_eth_need_breakpoint[];
 
 extern int kgdb_tty_hook(void);
diff -puN drivers/net/3c59x.c~kgdb-netpoll drivers/net/3c59x.c
diff -puN drivers/net/eepro100.c~kgdb-netpoll drivers/net/eepro100.c
diff -puN drivers/net/tlan.c~kgdb-netpoll drivers/net/tlan.c
diff -puN drivers/net/tulip/tulip_core.c~kgdb-netpoll drivers/net/tulip/tulip_core.c
diff -puN arch/i386/lib/kgdb_serial.c~kgdb-netpoll arch/i386/lib/kgdb_serial.c
--- l/arch/i386/lib/kgdb_serial.c~kgdb-netpoll	2003-09-10 02:34:15.000000000 -0500
+++ l-mpm/arch/i386/lib/kgdb_serial.c	2003-09-10 02:34:16.000000000 -0500
@@ -386,7 +386,7 @@ static spinlock_t one_at_atime = SPIN_LO
 static int __init
 kgdb_enable_ints(void)
 {
-	if (kgdb_eth != -1) {
+	if (kgdboe) {
 		return 0;
 	}
 	if (gdb_async_info == NULL) {
diff -puN drivers/net/Makefile~kgdb-netpoll drivers/net/Makefile
--- l/drivers/net/Makefile~kgdb-netpoll	2003-09-10 02:34:16.000000000 -0500
+++ l-mpm/drivers/net/Makefile	2003-09-10 02:34:16.000000000 -0500
@@ -32,8 +32,6 @@ obj-$(CONFIG_BMAC) += bmac.o
 
 obj-$(CONFIG_OAKNET) += oaknet.o 8390.o
 
-obj-$(CONFIG_KGDB) += kgdb_eth.o
-
 obj-$(CONFIG_DGRS) += dgrs.o
 obj-$(CONFIG_RCPCI) += rcpci.o
 obj-$(CONFIG_VORTEX) += 3c59x.o
@@ -199,3 +197,4 @@ include $(TOPDIR)/drivers/usb/net/Makefi
 
 # Must come after all NICs it might use
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+obj-$(CONFIG_KGDB) += kgdb_eth.o
diff -puN Documentation/i386/kgdb/kgdbeth.txt~kgdb-netpoll Documentation/i386/kgdb/kgdbeth.txt
--- l/Documentation/i386/kgdb/kgdbeth.txt~kgdb-netpoll	2003-09-10 02:34:16.000000000 -0500
+++ l-mpm/Documentation/i386/kgdb/kgdbeth.txt	2003-09-10 02:34:16.000000000 -0500
@@ -6,16 +6,21 @@ Authors
 
 Robert Walsh <rjwalsh@durables.org>  (2.6 port)
 wangdi <wangdi@clusterfs.com>        (2.6 port)
+Matt Mackall <mpm@selenic.com>       (netpoll api)
 San Mehat                            (original 2.4 code)
 
 
 Introduction
 ------------
 
-KGDB supports debugging over ethernet.  Only a limited set of ethernet
-devices are supported right now, but adding support for new devices
-should not be too complicated.  See "New Devices" below for details.
-
+KGDB supports debugging over ethernet (kgdboe) via polling of a given
+network interface. Most cards are supported automatically though some
+might need special attention when receiving packets. Debugging
+facilities are available as soon as the network driver and kgdboe have
+initialized. Unfortunately, this is too late in the boot process for
+debugging some issues, but works quite well for many others. This
+should not interfere with normal network usage and doesn't require a
+dedicated NIC.
 
 Terminology
 -----------
@@ -29,33 +34,25 @@ This document uses the following terms:
 Usage
 -----
 
-You need to use the following command-line options on the TARGET kernel:
-
-  gdbeth=DEVICENUM
-  gdbeth_remoteip=HOSTIPADDR
-  gdbeth_remotemac=REMOTEMAC
-  gdbeth_localmac=LOCALMAC
-
-kgdbeth=DEVICENUM sets the ethernet device number to listen on for
-debugging packets.  e.g. kgdbeth=0 listens on eth0.
-
-kgdbeth_remoteip=HOSTIPADDR sets the IP address of the HOST machine.
-Only packets originating from this IP address will be accepted by the
-debugger.  e.g. kgdbeth_remoteip=192.168.2.2
+You need to use the following command-line option on the TARGET kernel:
 
-kgdbeth_remotemac=REMOTEMAC sets the ethernet address of the HOST machine.
-e.g. kgdbeth_remotemac=00:07:70:12:4E:F5
+  kgdboe=[tgt-port]@<tgt-ip>/[dev],[host-port]@<host-ip>/[host-macaddr]
 
-kgdbeth_localmac=LOCALMAC sets the ethernet address of the TARGET machine.
-e.g. kgdbeth_localmac=00:10:9F:18:21:3C
+    where
+        tgt-port      source for UDP packets (defaults to 6443)
+        tgt-ip        source IP to use (interface address)
+        dev           network interface (eth0)
+        host-port     HOST UDP port (6442) (not really used)
+        host-ip       IP address for HOST machine
+        host-macaddr  ethernet MAC address for HOST (ff:ff:ff:ff:ff:ff)
 
-You can also set the following command-line option on the TARGET kernel:
+  examples:
 
-  kgdbeth_listenport=PORT
+    kgdboe=7000@192.168.0.1/wlan0,7001@192.168.0.2/00:05:3C:04:47:5D
+    kgdboe=@192.168.0.1/,@192.168.0.2/
 
-kgdbeth_listenport sets the UDP port to listen on for gdb debugging
-packets.  The default value is "6443".  e.g. kgdbeth_listenport=7654
-causes the kernel to listen on UDP port 7654 for debugging packets.
+Only packets originating from the configured HOST IP address will be
+accepted by the debugger.
 
 On the HOST side, run gdb as normal and use a remote UDP host as the
 target:
@@ -72,47 +69,15 @@ target:
 
 You can now continue as if you were debugging over a serial line.
 
-Observations
-------------
-
-I've used this with NFS and various other network applications (ssh,
-etc.) and it's doesn't appear to interfere with their operation in
-any way.  It doesn't seem to effect the NIC it uses - i.e. you don't
-need a dedicated NIC for this.
-
 Limitations
 -----------
 
-In the inital release of this code you _must_ break into the system with the
-debugger by hand, early after boot, as described above.
-
-Otherwise, the first time the kernel tries to enter the debugger (say, via an
-oops or a BUG), the kgdb stub will doublefault and die because things aren't
-fully set up yet.
-
-Supported devices
------------------
-
-Right now, the following drivers are supported:
-
-  e100 driver (drivers/net/e100/*)
-  3c59x driver (drivers/net/3c59x.c)
-
-
-New devices
------------
-
-Supporting a new device is straightforward.  Just add a "poll" routine to
-the driver and hook it into the poll_controller field in the netdevice
-structure.  For an example, look in drivers/net/3c59x.c and search
-for CONFIG_KGDB (two places.)
-
-The poll routine is usually quite simple - it's usually enough to just
-disable interrupts, call the device's interrupt routine and re-enable
-interrupts again.
-
+The current release of this code is exclusive of using kgdb on a
+serial interface, so you must boot without the kgdboe option to use
+serial debugging.
 
 Bug reports
 -----------
 
-Send bug reports to Robert Walsh <rjwalsh@durables.org>.
+Send bug reports to Robert Walsh <rjwalsh@durables.org> and Matt
+Mackall <mpm@selenic.com>.

_


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon

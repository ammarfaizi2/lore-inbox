Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUATNkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265506AbUATNkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:40:41 -0500
Received: from gprs214-10.eurotel.cz ([160.218.214.10]:49281 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265493AbUATNkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:40:01 -0500
Date: Tue, 20 Jan 2004 14:37:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, Steve Gonczi <steve@relicore.com>,
       Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: kgdb 2.0.5
Message-ID: <20040120133721.GA989@elf.ucw.cz>
References: <200401201743.39640.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401201743.39640.amitkale@emsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> kgdb 2.0.5 is available at 
> http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.5.tar.bz2
> 
> ChangeLog
> 2004-01-20 Amit S. Kale <amitkale@emsyssoft.com>
>         * Created a ring buffer for kgdb ethernet packets. Several
>         fixes and changes to kgdb on ethernet.
> 
> 2004-01-20 TimeSys Corporation
>         * Fixed a problem with not responding to Ctrl+C during priting of
>         console messages through gdb.
> 
> I have pasted below eth.patch for review. When using the ethernet interface, 
> gdb times out several times. It receives packets and junk instead of acks. I 
> see following type of messages out of 8139too.c on the console 
> "eth0:Out-of-sync dirty pointer, 15 vs. 20."
> 
> Any comments/suggestions/fixes on this patch are most welcome.

BTW here's 2.0.4 to 2.0.5 [pseudo]diff.

Index: patches/kgdb
===================================================================
RCS file: /home2/machek/cvsroot/misc/kernel/patches/kgdb,v
retrieving revision 1.8
diff -u -u -r1.8 kgdb
--- patches/kgdb	18 Jan 2004 19:17:34 -0000	1.8
+++ patches/kgdb	20 Jan 2004 13:32:04 -0000
@@ -2031,12 +2031,14 @@
  obj-$(CONFIG_VORTEX) += 3c59x.o
 Index: linux/drivers/net/kgdb_eth.c
 ===================================================================
---- linux.orig/drivers/net/kgdb_eth.c	2004-01-17 14:58:20.000000000 +0100
-+++ linux/drivers/net/kgdb_eth.c	2004-01-17 14:58:20.000000000 +0100
-@@ -0,0 +1,588 @@
+--- linux.orig/drivers/net/kgdb_eth.c	2004-01-20 14:29:19.000000000 +0100
++++ linux/drivers/net/kgdb_eth.c	2004-01-20 14:29:19.000000000 +0100
+@@ -0,0 +1,704 @@
 +/*
 + * Network interface GDB stub
 + *
++ * Copyright (C), 2004 Amit S. Kale 
++ *
 + * Written by San Mehat (nettwerk@biodome.org)
 + * Based upon 'gdbserial' by David Grothe (dave@gcom.com)
 + * and Scott Foehner (sfoehner@engr.sgi.com)
@@ -2045,6 +2047,8 @@
 + * and wangdi <wangdi@clusterfs.com>.
 + *
 + * Restructured for generic a gdb interface 
++ * Reveral changes to make it free of device driver changes.
++ * Added internal buffers for this interface.
 + * 	by Amit S. Kale <amitkale@emsyssoft.com>
 + * Some cleanups by Pavel Machek <pavel@suse.cz>
 + */
@@ -2100,9 +2104,107 @@
 +static int		kgdbeth_sendbufchars;
 +static irqreturn_t	(*kgdbeth_irqhandler)(int, void *, struct pt_regs *) = NULL;
 +
-+int		kgdbeth_is_trapped;
 +struct net_device *kgdb_netdevice = NULL;
 +
++/* Indicates dept of recursion for xmitlock hold */
++static int xlockholdcount = 0;
++
++/* kgdb ethernet ring buffers. Increase the space if you get panics in
++ * kgdbeth_alloc_skb.
++ * Status of send_skbs can be known from the field users.
++ * If it's 1 the buffer is free.
++ * If the count 2 or more, the buffer is in use.
++ * Keeping 1 as the initial count prevents kfree_skb from freeing it. */
++#define SEND_BUFLEN 1024
++#define NUM_SENDBUF 128
++static char *send_bufs[NUM_SENDBUF];
++static struct sk_buff *send_skbs[NUM_SENDBUF];
++static struct sk_buff *send_skb;
++static int bufnum;
++
++static char kgdb_netdevname[16];
++
++#ifdef CONFIG_KGDB_CONSOLE
++#error kgdb over ethernet is not yet ready for console messages.
++#endif
++
++/*
++ * Returns next skb from kgdb skbs.
++ * Initializes users field of the skb to 2 so that kfree_skb doesn't attempt
++ * freeing it.
++ * Always call after holding xmitlock of the ethernet device.
++ */
++
++struct sk_buff *kgdbeth_alloc_skb(int size)
++{
++	struct sk_buff *skb;
++	u8		*data;
++	int i;
++
++	i = bufnum;
++
++	do {
++		skb = send_skbs[i];
++
++		if (atomic_read(&skb->users) == 1) {
++			bufnum = i;
++			i = -1;
++			break;
++		}
++		i = (i + 1) % NUM_SENDBUF;
++	} while (i != bufnum);
++	if (i == bufnum) {
++		panic("kgdb ethernet buffer overflow\n");
++	}
++	data = (u8 *)(send_bufs[bufnum]);
++
++	size = SKB_DATA_ALIGN(size);
++	if (size + sizeof(struct skb_shared_info) > SEND_BUFLEN)
++		panic("kgdb ethernet buffer too short for this request");
++
++	memset(skb, 0, offsetof(struct sk_buff, truesize));
++	skb->truesize = size + sizeof(struct sk_buff);
++	atomic_set(&skb->users, 2);
++	skb->head = data;
++	skb->data = data;
++	skb->tail = data;
++	skb->end  = data + size;
++
++	atomic_set(&(skb_shinfo(skb)->dataref), 1);
++	skb_shinfo(skb)->nr_frags  = 0;
++	skb_shinfo(skb)->tso_size = 0;
++	skb_shinfo(skb)->tso_segs = 0;
++	skb_shinfo(skb)->frag_list = NULL;
++
++	return skb;
++}
++
++/* Holds xmitlock of the ethernet device 
++ * Recursive calls allowed */
++static void kgdbeth_holdxlock(void)
++{
++	if (spin_is_locked(&kgdb_netdevice->xmit_lock)) {
++		if (kgdb_netdevice->xmit_lock_owner == smp_processor_id()) {
++			goto gotit;
++		}
++	}
++	spin_lock(&kgdb_netdevice->xmit_lock);
++	kgdb_netdevice->xmit_lock_owner = smp_processor_id();
++
++gotit:
++	xlockholdcount++;
++}
++
++/* releases xmitlock of the ethernet device 
++ * Recursive calls allowed */
++static void kgdbeth_relxlock(void)
++{
++	if (--xlockholdcount) {
++		kgdb_netdevice->xmit_lock_owner = -1;
++		spin_unlock(&kgdb_netdevice->xmit_lock);
++	}
++}
++
 +/*
 + * Get a char if available, return -1 if nothing available.
 + * Empty the receive buffer first, then look at the interface hardware.
@@ -2143,16 +2245,14 @@
 +	if (!(in_dev->ifa_list)) {
 +		panic("No interface address set for interface!\n");
 +	}
++	kgdbeth_holdxlock();
 +
 +	udp_len = len + sizeof(struct udphdr);
 +	ip_len = eth_len = udp_len + sizeof(struct iphdr);
 +	total_len = eth_len + ETH_HLEN;
 +
-+	if (!(skb = alloc_skb(total_len, GFP_ATOMIC))) {
-+		return;
-+	}
++	skb = kgdbeth_alloc_skb(total_len);
 +
-+	atomic_set(&skb->users, 1);
 +	skb_reserve(skb, total_len - 1);
 +
 +	memcpy(skb->data, (unsigned char *) buf, len);
@@ -2183,11 +2283,11 @@
 +	memcpy(eth->h_source, kgdb_localmac, kgdb_netdevice->addr_len);
 +	memcpy(eth->h_dest, kgdb_remotemac, kgdb_netdevice->addr_len);
 +
-+	spin_lock(&kgdb_netdevice->xmit_lock);
-+	kgdb_netdevice->xmit_lock_owner = smp_processor_id();
 +	kgdb_netdevice->hard_start_xmit(skb, kgdb_netdevice);
-+	kgdb_netdevice->xmit_lock_owner = -1;
-+	spin_unlock(&kgdb_netdevice->xmit_lock);
++	if (atomic_read(&skb->users) != 1) {
++		BUG();
++	}
++	kgdbeth_relxlock();
 +}
 +
 +static void kgdbeth_flush(void)
@@ -2213,18 +2313,14 @@
 + * arp requests, so handle them here.
 + */
 +
-+static struct sk_buff *send_skb = NULL;
-+
 +static void
 +kgdb_eth_reply_arp(void)
 +{
 +	if (send_skb) {
-+		spin_lock(&kgdb_netdevice->xmit_lock);
-+		kgdb_netdevice->xmit_lock_owner = smp_processor_id();
++		kgdbeth_holdxlock();
 +	    	kgdb_netdevice->hard_start_xmit(send_skb, kgdb_netdevice);
-+	    	kgdb_netdevice->xmit_lock_owner = -1;
-+	    	spin_unlock(&kgdb_netdevice->xmit_lock);
 +		send_skb = NULL;
++		kgdbeth_relxlock();
 +	}
 +}
 +
@@ -2293,14 +2389,19 @@
 +	if (LOOPBACK(tip) || MULTICAST(tip)) {
 +		return 0;
 +	}
-+
 +	/* reply to the ARP request */
 +
-+	send_skb = alloc_skb(sizeof(struct arphdr) + 2 * (kgdb_netdevice->addr_len + 4) + LL_RESERVED_SPACE(kgdb_netdevice), GFP_ATOMIC);
-+
-+	if (send_skb == NULL) {
-+		return 0;
++	kgdbeth_holdxlock();
++	if (send_skb) {
++		/* Get rid of any previous replies to ARP request. We hope
++		 * that regular reply to ARP by network layers would have gone
++		 * out by now. */
++		kfree_skb(send_skb);
 +	}
++	send_skb = kgdbeth_alloc_skb(sizeof(struct arphdr) +
++			2 * (kgdb_netdevice->addr_len + 4) +
++			LL_RESERVED_SPACE(kgdb_netdevice));
++	kgdbeth_relxlock();
 +
 +	skb_reserve(send_skb, LL_RESERVED_SPACE(kgdb_netdevice));
 +	send_skb->nh.raw = send_skb->data;
@@ -2350,18 +2451,16 @@
 + * kgdb buffer
 + *
 + * When the kgdb stub routine read_char() is called it draws characters
-+ * out of the buffer until it is empty and then reads directly from the
-+ * serial port.
-+ *
-+ * We do not attempt to write chars from the interrupt routine since
-+ * the stubs do all of that via write_char() which writes one byte
-+ * after waiting for the interface to become ready.
-+ *
-+ * The debug stubs like to run with interrupts disabled since, after all,
-+ * they run as a consequence of a breakpoint in the kernel.
++ * out of the buffer until it is empty and then polls the hardware.
 + *
-+ * NOTE: Return value of 1 means it was for us and is an indication to
-+ * the calling driver to destroy the sk_buff and not send it up the stack.
++ * Return value of NET_RX_DROP means skb was used by this function.
++ * NET_RX_SUCCESS indicates this function didn't use it.
++
++ * Be prepared to respond to ARP requests. Let the caller also handle
++ * them if debugger is not active. We'll respond to the ARP request when
++ * a debugging session begins. It's necessary to respond to the request as the
++ * debugging session may begin even before kernel has a chance finish the
++ * response.
 + */
 +int
 +kgdb_net_interrupt(struct sk_buff *skb)
@@ -2374,18 +2473,16 @@
 +	int		i;
 +
 +	if (!kgdb_initialized || !kgdb_netdevice) {
-+		return 0;
++		goto out;
 +	}
 +	if (skb->protocol == __constant_htons(ETH_P_ARP) && !send_skb) {
 +		make_arp_request(skb);
-+		return 0;
-+	}
-+	if (iph->protocol != IPPROTO_UDP) {
-+		return 0;
-+	}
-+	if (be16_to_cpu(udph->dest) != kgdb_listenport) {
-+		return 0;
++		goto out;
 +	}
++	if (iph->protocol != IPPROTO_UDP ||
++		be16_to_cpu(udph->dest) != kgdb_listenport) 
++		goto out;
++
 +	kgdb_sendport = be16_to_cpu(udph->source);
 +
 +	len = (be16_to_cpu(iph->tot_len) -
@@ -2395,7 +2492,9 @@
 +		chr = *data++;
 +		if (chr == 3)
 +		{
-+			breakpoint();
++			if (!atomic_read(&debugger_active)) {
++				breakpoint();
++			}
 +			continue;
 +		}
 +		if (atomic_read(&kgdb_buf_in_cnt) >= GDB_BUF_SIZE) {
@@ -2409,36 +2508,49 @@
 +		kgdb_buf_in_inx &= (GDB_BUF_SIZE - 1);
 +		atomic_inc(&kgdb_buf_in_cnt) ;
 +	}
++	return NET_RX_DROP;
 +
-+	return 1;
++out:
++	if (atomic_read(&debugger_active))
++		return NET_RX_DROP;
++	return NET_RX_SUCCESS;
 +}
 +
++/*
++ * Initializes ethernet interface to kgdb.
++ * Searches the device list and finds the device specified on kernel command
++ * line.
++ * Finds the irq handler for the device and saves its reference.
++ * Initializes kgdbeth data structures.
++ */
++
 +int
 +kgdbeth_hook(void)
 +{
-+	char kgdb_netdev[16];
 +	extern void kgdb_respond_ok(void);
 +	struct irqaction *ia_ptr;
++	int i;
 +
-+	sprintf(kgdb_netdev, "eth%d", kgdb_eth);
++	sprintf(kgdb_netdevname, "eth%d", kgdb_eth);
 +
 +	for (kgdb_netdevice = dev_base;
 +		kgdb_netdevice != NULL;
 +		kgdb_netdevice = kgdb_netdevice->next) {
-+		if (strncmp(kgdb_netdevice->name, kgdb_netdev, IFNAMSIZ) == 0) {
++		if (strncmp(kgdb_netdevice->name, kgdb_netdevname, IFNAMSIZ) == 0) {
 +			break;
 +		}
 +	}
 +	if (!kgdb_netdevice) {
-+		printk("kgdbeth: Unable to find interface %s\n", kgdb_netdev);
-+		return -1;
++		printk("kgdbeth: Unable to find interface %s\n",
++				kgdb_netdevname);
++		return -ENODEV;
 +	}
 +	if (!(kgdb_netdevice->flags & IFF_UP)) {
-+		return -1;
++		return -EINVAL;
 +	}
 +	ia_ptr = irq_desc[kgdb_netdevice->irq].action;
 +	while (ia_ptr) {
-+		if (!strncmp(kgdb_netdev, ia_ptr->name, IFNAMSIZ)) {
++		if (!strncmp(kgdb_netdevname, ia_ptr->name, IFNAMSIZ)) {
 +			kgdbeth_irqhandler = ia_ptr->handler;
 +			break;
 +		}
@@ -2446,32 +2558,28 @@
 +	}
 +	if (!kgdbeth_irqhandler) {
 +		printk("kgdbeth: Interface %s doesn't have an interrupt"
-+			" handler cannot use it\n", kgdb_netdev);
-+		return -1;
++			" handler cannot use it\n", kgdb_netdevname);
++		return -EINVAL;
++	}
++	for (i = 0; i < NUM_SENDBUF; i++) {
++		send_skbs[i] = kmalloc(sizeof (struct sk_buff), GFP_KERNEL);
++		send_bufs[i] = kmalloc(SEND_BUFLEN, GFP_KERNEL);
++		if (!send_skbs[i] || !send_bufs[i]) {
++			printk("kgdbeth: not enough memory\n");
++			return -ENOMEM;
++		}
++		atomic_set(&(send_skbs[i]->users), 1);
 +	}
 +
-+	return 0;
-+}
 +
-+/*
-+ * Poll an ethernet interface for incoming characters
-+ */
-+static void kgdbeth_rx_poll(void)
-+{
-+	if (!kgdbeth_is_trapped)
-+		disable_irq(kgdb_netdevice->irq);
-+	kgdbeth_irqhandler(kgdb_netdevice->irq, (void *)kgdb_netdevice, 0);
-+	if (!kgdbeth_is_trapped)
-+		enable_irq(kgdb_netdevice->irq);
++	return 0;
 +}
 +
 +/*
 + * kgdbeth_read_char
 + *
 + * This is a GDB stub routine.  It waits for a character from the
-+ * serial interface and then returns it.  If there is no serial
-+ * interface connection then it returns a bogus value which will
-+ * almost certainly cause the system to hang.
++ * ethernet interface and then returns it.
 + */
 +static int
 +kgdbeth_read_char(void)
@@ -2482,20 +2590,28 @@
 +		if (send_skb) {
 +			kgdb_eth_reply_arp();
 +		}
-+		kgdbeth_rx_poll();
++		(*kgdbeth_irqhandler)(kgdb_netdevice->irq,
++				      (void *)kgdb_netdevice, 0);
 +	}
 +	return chr;
 +}
 +
-+static void kgdbeth_begin_session(void)
-+{
-+	kgdbeth_is_trapped = 1;
++/*
++ * Hold onto the xmitlock and keep holding till the session ends.
++ * Disable device irq and keep it disabled till this session ends.
++ * Respond to last arp request we have received. It may not not have be
++ * responded yet.
++ */
++static void kgdbeth_begin_session(void) {
++	kgdbeth_holdxlock();
++	disable_irq(kgdb_netdevice->irq);
 +	kgdb_eth_reply_arp();
 +}
 +
 +static void kgdbeth_end_session(void)
 +{
-+	kgdbeth_is_trapped = 0;
++	enable_irq(kgdb_netdevice->irq);
++	kgdbeth_relxlock();
 +}
 +
 +struct kgdb_serial kgdbeth_serial = {
@@ -2545,7 +2661,7 @@
 +
 +int kgdbeth_event(struct notifier_block * self, unsigned long val, void * data)
 +{
-+	if (strcmp(((struct net_device *)data)->name, "eth0")) {
++	if (strcmp(((struct net_device *)data)->name, kgdb_netdevname)) {
 +		goto out;
 +	}
 +	if (val!= NETDEV_UP)
@@ -2624,8 +2740,8 @@
 +__setup("kgdbeth=", kgdbeth_opt);
 Index: linux/include/asm-i386/kgdb.h
 ===================================================================
---- linux.orig/include/asm-i386/kgdb.h	2004-01-17 14:58:20.000000000 +0100
-+++ linux/include/asm-i386/kgdb.h	2004-01-17 14:58:20.000000000 +0100
+--- linux.orig/include/asm-i386/kgdb.h	2004-01-20 14:29:19.000000000 +0100
++++ linux/include/asm-i386/kgdb.h	2004-01-20 14:29:19.000000000 +0100
 @@ -0,0 +1,49 @@
 +#ifndef _ASM_KGDB_H_
 +#define _ASM_KGDB_H_
@@ -3131,49 +3247,10 @@
 +char *kgdb_mem2hex(char *mem, char *buf, int count, int can_fault);
 +
 +#endif /* _KGDB_H_ */
-Index: linux/include/linux/netdevice.h
-===================================================================
---- linux.orig/include/linux/netdevice.h	2004-01-17 14:56:40.000000000 +0100
-+++ linux/include/linux/netdevice.h	2004-01-17 14:58:20.000000000 +0100
-@@ -533,6 +533,11 @@
- extern struct net_device	*dev_get_by_index(int ifindex);
- extern struct net_device	*__dev_get_by_index(int ifindex);
- extern int		dev_restart(struct net_device *dev);
-+#ifdef CONFIG_KGDB_ETH
-+extern int		kgdb_net_interrupt(struct sk_buff *skb);
-+extern void		kgdb_send_arp_request(void);
-+extern int kgdbeth_is_trapped;
-+#endif
- 
- typedef int gifconf_func_t(struct net_device * dev, char * bufptr, int len);
- extern int		register_gifconf(unsigned int family, gifconf_func_t * gifconf);
-@@ -591,12 +596,22 @@
- 
- static inline void netif_wake_queue(struct net_device *dev)
- {
-+#ifdef CONFIG_KGDB_ETH
-+	if (kgdbeth_is_trapped) {
-+		return;
-+	}
-+#endif
- 	if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state))
- 		__netif_schedule(dev);
- }
- 
- static inline void netif_stop_queue(struct net_device *dev)
- {
-+#ifdef CONFIG_KGDB_ETH
-+	if (kgdbeth_is_trapped) {
-+		return;
-+	}
-+#endif
- 	set_bit(__LINK_STATE_XOFF, &dev->state);
- }
- 
 Index: linux/include/linux/sched.h
 ===================================================================
---- linux.orig/include/linux/sched.h	2004-01-17 14:56:40.000000000 +0100
-+++ linux/include/linux/sched.h	2004-01-17 14:58:20.000000000 +0100
+--- linux.orig/include/linux/sched.h	2004-01-20 14:28:45.000000000 +0100
++++ linux/include/linux/sched.h	2004-01-20 14:29:19.000000000 +0100
 @@ -173,7 +173,9 @@
  
  #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
@@ -3235,9 +3312,9 @@
  # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 Index: linux/kernel/kgdbstub.c
 ===================================================================
---- linux.orig/kernel/kgdbstub.c	2004-01-17 14:58:20.000000000 +0100
-+++ linux/kernel/kgdbstub.c	2004-01-17 14:58:20.000000000 +0100
-@@ -0,0 +1,1227 @@
+--- linux.orig/kernel/kgdbstub.c	2004-01-20 14:29:19.000000000 +0100
++++ linux/kernel/kgdbstub.c	2004-01-20 14:29:19.000000000 +0100
+@@ -0,0 +1,1236 @@
 +/*
 + * This program is free software; you can redistribute it and/or modify it
 + * under the terms of the GNU General Public License as published by the
@@ -3453,12 +3530,6 @@
 +		i = 0;
 +		while ((ch = kgdb_serial->read_char()) == gdbseq[i++] &&
 +		       checkconnect) {
-+			if (ch == 3) {
-+				kgdb_serial->write_char('+');
-+				if (kgdb_serial->flush)
-+					kgdb_serial->flush();
-+				breakpoint();
-+			}
 +			if (!gdbseq[i]) {
 +				kgdb_serial->write_char('+');
 +				if (kgdb_serial->flush)
@@ -3472,7 +3543,12 @@
 +				break;
 +			}
 +		}
-+
++		if (checkconnect && ch == 3) {
++			kgdb_serial->write_char('+');
++			if (kgdb_serial->flush)
++				kgdb_serial->flush();
++			breakpoint();
++		}
 +	} while (( ch & 0x7f) != '+');
 +
 +}
@@ -3793,6 +3869,11 @@
 +
 +/*
 + * This function does all command procesing for interfacing to gdb.
++ *
++ * Locking hierarchy:
++ *	interface locks, if any (begin_session)
++ *	kgdb lock (debugger_active)
++ *
 + */
 +int kgdb_handle_exception(int exVector, int signo, int err_code, 
 +                     struct pt_regs *linux_regs)
@@ -3811,6 +3892,15 @@
 +	int numshadowth = num_online_cpus() + kgdb_ops->shadowth;
 +	long kgdb_usethreadid = 0;
 +
++	/* Panic on recursive debugger calls. */
++	if (atomic_read(&debugger_active) == smp_processor_id() + 1) {
++		return 0;
++	}
++
++	/* Grab interface locks first */
++	if (kgdb_serial->begin_session)
++		kgdb_serial->begin_session();
++
 +	/* 
 +	 * Interrupts will be restored by the 'trap return' code, except when
 +	 * single stepping.
@@ -3828,9 +3918,6 @@
 +	
 +	debugger_step = 0;
 +
-+
-+	local_irq_save(flags);
-+
 +	current->thread.debuggerinfo = linux_regs;
 +
 +	if (kgdb_ops->disable_hw_debug)
@@ -3848,9 +3935,6 @@
 +	/* Master processor is completely in the debugger */
 +	if (kgdb_ops->post_master_code)
 +		kgdb_ops->post_master_code(linux_regs, exVector, err_code);
-+	if (kgdb_serial->begin_session)
-+		kgdb_serial->begin_session();
-+
 +	if (atomic_read(&kgdb_killed_or_detached) &&
 +	    atomic_read(&kgdb_might_be_resumed)) {
 +		getpacket(remcomInBuffer);
@@ -4221,9 +4305,6 @@
 +	
 +	if(kgdb_ops->handler_exit)
 +		kgdb_ops->handler_exit();
-+	if (kgdb_serial->end_session)
-+		kgdb_serial->end_session();
-+	
 +	procindebug[smp_processor_id()] = 0;	
 +	
 +	for (i = 0; i < num_online_cpus(); i++) {
@@ -4244,9 +4325,14 @@
 +	}
 +
 +	/* Free debugger_active */
-+	atomic_set(&debugger_active, 0);
 +	atomic_set(&kgdb_killed_or_detached, 1);
++	atomic_set(&debugger_active, 0);
 +	local_irq_restore(flags);
++
++	/* Release interface locks */
++	if (kgdb_serial->end_session)
++		kgdb_serial->end_session();
++	
 +	return ret;
 +}
 +
@@ -4550,8 +4636,8 @@
  			return;
 Index: linux/net/core/dev.c
 ===================================================================
---- linux.orig/net/core/dev.c	2004-01-17 14:56:40.000000000 +0100
-+++ linux/net/core/dev.c	2004-01-17 14:58:20.000000000 +0100
+--- linux.orig/net/core/dev.c	2004-01-20 14:28:45.000000000 +0100
++++ linux/net/core/dev.c	2004-01-20 14:29:19.000000000 +0100
 @@ -1380,7 +1380,6 @@
  }
  #endif
@@ -4560,25 +4646,43 @@
  /**
   *	netif_rx	-	post buffer to the network code
   *	@skb: buffer to post
-@@ -1405,6 +1404,21 @@
+@@ -1404,6 +1403,15 @@
+ 	int this_cpu;
  	struct softnet_data *queue;
  	unsigned long flags;
- 
++	int ret;
++	int kgdb_net_interrupt(struct sk_buff *skb);
++
 +#ifdef CONFIG_KGDB_ETH
 +	/* See if kgdb_eth wants this packet */
-+	if (!kgdb_net_interrupt(skb)) {
-+		/* No.. if we're 'trapped' then junk it */
-+		if (kgdbeth_is_trapped) {
-+			kfree_skb(skb);
-+			return NET_RX_DROP;
-+		}
-+	} else {
-+		/* kgdb_eth ate the packet... drop it silently */
-+		kfree_skb(skb);
-+		return NET_RX_DROP;
++	if ((ret = kgdb_net_interrupt(skb)) == NET_RX_DROP) {
++		return ret;
 +	}
 +#endif
-+
+ 
  	if (!skb->stamp.tv_sec)
  		do_gettimeofday(&skb->stamp);
+Index: linux/net/core/skbuff.c
+===================================================================
+--- linux.orig/net/core/skbuff.c	2003-11-24 17:08:33.000000000 +0100
++++ linux/net/core/skbuff.c	2004-01-20 14:29:19.000000000 +0100
+@@ -55,6 +55,7 @@
+ #include <linux/rtnetlink.h>
+ #include <linux/init.h>
+ #include <linux/highmem.h>
++#include <linux/debugger.h>
+ 
+ #include <net/protocol.h>
+ #include <net/dst.h>
+@@ -126,6 +127,11 @@
+ {
+ 	struct sk_buff *skb;
+ 	u8 *data;
++	struct sk_buff *kgdbeth_alloc_skb(int size);
++
++	if (atomic_read(&debugger_active)) {
++		return kgdbeth_alloc_skb(size);
++	}
  
+ 	/* Get the HEAD */
+ 	skb = kmem_cache_alloc(skbuff_head_cache,


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

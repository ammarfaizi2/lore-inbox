Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTJFT3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTJFT3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:29:04 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:13986 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S261297AbTJFT2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:28:01 -0400
Message-ID: <3F81C30B.7080106@terra.com.br>
Date: Mon, 06 Oct 2003 16:31:23 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>, Richard Procter <rnp@paradise.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] SMP support and perfomance improvement in 3c527 net driver
Content-Type: multipart/mixed;
 boundary="------------010003080109070003070903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010003080109070003070903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Jeff/Richard,

	Richard Procter and I worked to remove cli/sti to add proper SMP 
support (I did the original stuff and Richard did the actual current 
code :)).

	Besides that, Richard did a great jog improving the perfomance of the 
driver quite a bit:

	- Improve mc32_command by 770% (438% non-inlined) over the semaphore 
version (at a cost of 1 sem + 2 completions per driver).

	- Removed mutex covering mc32_send_packet (hard_start_xmit). This 
lets the interrupt handler operate concurrently and removes 
unnecessary locking. It makes the code only slightly more brittle

	Original post:

http://marc.theaimsgroup.com/?l=linux-netdev&m=106438449315202&w=2

	Since it didn't apply cleanly against 2.6.0-test6, I forward ported 
it. Patch attached.

	Jeff, please consider applying,

	Thanks.

Felipe

--------------010003080109070003070903
Content-Type: text/plain;
 name="3c527-cli_sti_removal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3c527-cli_sti_removal.patch"

--- linux-2.6.0-test6/drivers/net/3c527.c.orig	2003-10-06 15:21:38.000000000 -0300
+++ linux-2.6.0-test6/drivers/net/3c527.c	2003-10-06 16:18:32.000000000 -0300
@@ -1,9 +1,10 @@
-/* 3c527.c: 3Com Etherlink/MC32 driver for Linux 2.4
+/* 3c527.c: 3Com Etherlink/MC32 driver for Linux 2.4 and 2.6.
  *
  *	(c) Copyright 1998 Red Hat Software Inc
  *	Written by Alan Cox. 
  *	Further debugging by Carl Drougge.
- *      Modified by Richard Procter (rnp@netlink.co.nz)
+ *      Initial SMP support by Felipe W Damasio <felipewd@terra.com.br>
+ *      Heavily modified by Richard Procter <rnp@paradise.net.nz>
  *
  *	Based on skeleton.c written 1993-94 by Donald Becker and ne2.c
  *	(for the MCA stuff) written by Wim Dumon.
@@ -17,11 +18,11 @@
  */
 
 #define DRV_NAME		"3c527"
-#define DRV_VERSION		"0.6a"
-#define DRV_RELDATE		"2001/11/17"
+#define DRV_VERSION		"0.7-SMP"
+#define DRV_RELDATE		"2003/10/06"
 
 static const char *version =
-DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " Richard Proctor (rnp@netlink.co.nz)\n";
+DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " Richard Procter <rnp@paradise.net.nz>\n";
 
 /**
  * DOC: Traps for the unwary
@@ -100,7 +101,9 @@
 #include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/ethtool.h>
+#include <linux/completion.h>
 
+#include <asm/semaphore.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
@@ -152,8 +155,10 @@
 /* Information that needs to be kept for each board. */
 struct mc32_local 
 {
-	struct net_device_stats net_stats;
 	int slot;
+	
+	u32 base;
+	struct net_device_stats net_stats;
 	volatile struct mc32_mailbox *rx_box;
 	volatile struct mc32_mailbox *tx_box;
 	volatile struct mc32_mailbox *exec_box;
@@ -163,22 +168,22 @@
         u16 tx_len;             /* Transmit list count */ 
         u16 rx_len;             /* Receive list count */
 
-	u32 base;
-	u16 exec_pending;
-	u16 mc_reload_wait;	/* a multicast load request is pending */
+	u16 xceiver_desired_state; /* HALTED or RUNNING */ 
+	u16 cmd_nonblocking;    /* Thread is uninterested in command result */ 
+	u16 mc_reload_wait;     /* A multicast load request is pending */
 	u32 mc_list_valid;	/* True when the mclist is set */
-	u16 xceiver_state;      /* Current transceiver state. bitmapped */ 
-	u16 desired_state;      /* The state we want the transceiver to be in */ 
-	atomic_t tx_count;	/* buffers left */
-	wait_queue_head_t event;
 
 	struct mc32_ring_desc tx_ring[TX_RING_LEN];	/* Host Transmit ring */
 	struct mc32_ring_desc rx_ring[RX_RING_LEN];	/* Host Receive ring */
 
-	u16 tx_ring_tail;       /* index to tx de-queue end */
-	u16 tx_ring_head;       /* index to tx en-queue end */
-
+	atomic_t tx_count;      /* buffers left */
+	volatile u16 tx_ring_head; /* index to tx en-queue end */
+	u16 tx_ring_tail;          /* index to tx de-queue end */
 	u16 rx_ring_tail;       /* index to rx de-queue end */ 
+
+	struct semaphore cmd_mutex;    /* Serialises issuing of execute commands */
+	struct completion execution_cmd; /* Card has completed an execute command */
+	struct completion xceiver_cmd;   /* Card has completed a tx or rx command */  
 };
 
 /* The station (ethernet) address prefix, used for a sanity check. */
@@ -234,7 +239,6 @@
 {
 	static int current_mca_slot = -1;
 	int i;
-	int adapter_found = 0;
 
 	SET_MODULE_OWNER(dev);
 
@@ -245,11 +249,11 @@
 	   Autodetecting MCA cards is extremely simple. 
 	   Just search for the card. */
 
-	for(i = 0; (mc32_adapters[i].name != NULL) && !adapter_found; i++) {
+	for(i = 0; (mc32_adapters[i].name != NULL); i++) {
 		current_mca_slot = 
 			mca_find_unused_adapter(mc32_adapters[i].id, 0);
 
-		if((current_mca_slot != MCA_NOTFOUND) && !adapter_found) {
+		if(current_mca_slot != MCA_NOTFOUND) {
 			if(!mc32_probe1(dev, current_mca_slot))
 			{
 				mca_set_adapter_name(current_mca_slot, 
@@ -407,7 +411,7 @@
 	 *	Grab the IRQ
 	 */
 
-	i = request_irq(dev->irq, &mc32_interrupt, SA_SHIRQ, dev->name, dev);
+	i = request_irq(dev->irq, &mc32_interrupt, SA_SHIRQ | SA_SAMPLE_RANDOM, dev->name, dev);
 	if (i) {
 		release_region(dev->base_addr, MC32_IO_EXTENT);
 		printk(KERN_ERR "%s: unable to get IRQ %d.\n", dev->name, dev->irq);
@@ -496,7 +500,9 @@
 	lp->tx_len 		= lp->exec_box->data[9];   /* Transmit list count */ 
 	lp->rx_len 		= lp->exec_box->data[11];  /* Receive list count */
 
-	init_waitqueue_head(&lp->event);
+	init_MUTEX_LOCKED(&lp->cmd_mutex);
+	init_completion(&lp->execution_cmd);
+	init_completion(&lp->xceiver_cmd);
 	
 	printk("%s: Firmware Rev %d. %d RX buffers, %d TX buffers. Base of 0x%08X.\n",
 		dev->name, lp->exec_box->data[12], lp->rx_len, lp->tx_len, lp->base);
@@ -510,10 +516,6 @@
 	dev->watchdog_timeo	= HZ*5;	/* Board does all the work */
 	dev->ethtool_ops	= &netdev_ethtool_ops;
 	
-	lp->xceiver_state = HALTED; 
-	
-	lp->tx_ring_tail=lp->tx_ring_head=0;
-
 	/* Fill in the fields of the device structure with ethernet values. */
 	ether_setup(dev);
 	
@@ -537,7 +539,7 @@
  *	status of any pending commands and takes very little time at all.
  */
  
-static void mc32_ready_poll(struct net_device *dev)
+static inline void mc32_ready_poll(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
 	while(!(inb(ioaddr+HOST_STATUS)&HOST_STATUS_CRR));
@@ -552,31 +554,36 @@
  *	@len: Length of the data block
  *
  *	Send a command from interrupt state. If there is a command
- *	currently being executed then we return an error of -1. It simply
- *	isn't viable to wait around as commands may be slow. Providing we
- *	get in, we busy wait for the board to become ready to accept the
- *	command and issue it. We do not wait for the command to complete
- *	--- the card will interrupt us when it's done.
+ *	currently being executed then we return an error of -1. It
+ *	simply isn't viable to wait around as commands may be
+ *	slow. This can theoretically be starved on SMP, but it's hard
+ *	to see a realistic situation.  We do not wait for the command
+ *	to complete --- we rely on the interrupt handler to tidy up
+ *	after us.
  */
 
 static int mc32_command_nowait(struct net_device *dev, u16 cmd, void *data, int len)
 {
 	struct mc32_local *lp = (struct mc32_local *)dev->priv;
 	int ioaddr = dev->base_addr;
-
-	if(lp->exec_pending)
-		return -1;
+	int ret = -1;
 	
-	lp->exec_pending=3;
-	lp->exec_box->mbox=0;
-	lp->exec_box->mbox=cmd;
-	memcpy((void *)lp->exec_box->data, data, len);
-	barrier();	/* the memcpy forgot the volatile so be sure */
+	if (down_trylock(&lp->cmd_mutex) == 0) 
+	{
+		lp->cmd_nonblocking=1;
+		lp->exec_box->mbox=0;
+		lp->exec_box->mbox=cmd;
+		memcpy((void *)lp->exec_box->data, data, len);
+		barrier();      /* the memcpy forgot the volatile so be sure */
+		
+		/* Send the command */
+		mc32_ready_poll(dev);
+		outb(1<<6, ioaddr+HOST_CMD);
 
-	/* Send the command */
-	while(!(inb(ioaddr+HOST_STATUS)&HOST_STATUS_CRR));
-	outb(1<<6, ioaddr+HOST_CMD);	
-	return 0;
+		ret = 0;
+		/* Interrupt handler will signal mutex on completion */ 
+	}
+	return ret;
 }
 
 
@@ -590,7 +597,7 @@
  *	Sends exec commands in a user context. This permits us to wait around
  *	for the replies and also to wait for the command buffer to complete
  *	from a previous command before we execute our command. After our 
- *	command completes we will complete any pending multicast reload
+ *	command completes we will attempt any pending multicast reload
  *	we blocked off by hogging the exec buffer.
  *
  *	You feed the card a command, you wait, it interrupts you get a 
@@ -598,66 +605,37 @@
  *	commands for filter list changes which come in at bh level from things
  *	like IPV6 group stuff.
  *
- *	We have a simple state machine
- *
- *	0	- nothing issued
- *
- *	1	- command issued, wait reply
- *
- *	2	- reply waiting - reader then goes to state 0
- *
- *	3	- command issued, trash reply. In which case the irq
- *		  takes it back to state 0
- *
  */
   
 static int mc32_command(struct net_device *dev, u16 cmd, void *data, int len)
 {
 	struct mc32_local *lp = (struct mc32_local *)dev->priv;
 	int ioaddr = dev->base_addr;
-	unsigned long flags;
 	int ret = 0;
+
+	down(&lp->cmd_mutex);
 	
 	/*
-	 *	Wait for a command
-	 */
-	 
-	save_flags(flags);
-	cli();
-	 
-	while(lp->exec_pending)
-		sleep_on(&lp->event);
-		
-	/*
-	 *	Issue mine
+	 *	My turn
 	 */
 
-	lp->exec_pending=1;
-	
-	restore_flags(flags);
-	
+	lp->cmd_nonblocking=0;
 	lp->exec_box->mbox=0;
 	lp->exec_box->mbox=cmd;
 	memcpy((void *)lp->exec_box->data, data, len);
 	barrier();	/* the memcpy forgot the volatile so be sure */
 
-	/* Send the command */
-	while(!(inb(ioaddr+HOST_STATUS)&HOST_STATUS_CRR));
-	outb(1<<6, ioaddr+HOST_CMD);	
-
-	save_flags(flags);
-	cli();
+	mc32_ready_poll(dev);
+	outb(1<<6, ioaddr+HOST_CMD);
 
-	while(lp->exec_pending!=2)
-		sleep_on(&lp->event);
-	lp->exec_pending=0;
-	restore_flags(flags);
+	wait_for_completion(&lp->execution_cmd);
 	
 	if(lp->exec_box->mbox&(1<<13))
 		ret = -1;
 
+	up(&lp->cmd_mutex);
 	/*
-	 *	A multicast set got blocked - do it now
+	 *	A multicast set got blocked - try it now
 	 */
 		
 	if(lp->mc_reload_wait)
@@ -676,10 +654,8 @@
  *	This may be called from the interrupt state, where it is used
  *	to restart the rx ring if the card runs out of rx buffers. 
  *	
- * 	First, we check if it's ok to start the transceiver. We then show
- * 	the card where to start in the rx ring and issue the
- * 	commands to start reception and transmission. We don't wait
- * 	around for these to complete.
+ *	We must first check if it's ok to (re)start the transceiver. See
+ *	mc32_close for details.
  */ 
 
 static void mc32_start_transceiver(struct net_device *dev) {
@@ -688,24 +664,20 @@
 	int ioaddr = dev->base_addr;
 
 	/* Ignore RX overflow on device closure */ 
-	if (lp->desired_state==HALTED)  
+	if (lp->xceiver_desired_state==HALTED)  
 		return; 
 
+	/* Give the card the offset to the post-EOL-bit RX descriptor */
 	mc32_ready_poll(dev); 
-
-	lp->tx_box->mbox=0;
 	lp->rx_box->mbox=0;
-
-	/* Give the card the offset to the post-EOL-bit RX descriptor */ 
 	lp->rx_box->data[0]=lp->rx_ring[prev_rx(lp->rx_ring_tail)].p->next; 
-
 	outb(HOST_CMD_START_RX, ioaddr+HOST_CMD);      
 
 	mc32_ready_poll(dev); 
+	lp->tx_box->mbox=0;
 	outb(HOST_CMD_RESTRT_TX, ioaddr+HOST_CMD);   /* card ignores this on RX restart */ 
 	
 	/* We are not interrupted on start completion */ 
-	lp->xceiver_state=RUNNING; 
 }
 
 
@@ -725,24 +697,18 @@
 {
 	struct mc32_local *lp = (struct mc32_local *)dev->priv;
 	int ioaddr = dev->base_addr;
-	unsigned long flags;
 
 	mc32_ready_poll(dev);	
 
-	lp->tx_box->mbox=0;
 	lp->rx_box->mbox=0;
 
 	outb(HOST_CMD_SUSPND_RX, ioaddr+HOST_CMD);			
+	wait_for_completion(&lp->xceiver_cmd);
+	
 	mc32_ready_poll(dev); 
+	lp->tx_box->mbox=0;
 	outb(HOST_CMD_SUSPND_TX, ioaddr+HOST_CMD);	
-		
-	save_flags(flags);
-	cli();
-		
-	while(lp->xceiver_state!=HALTED) 
-		sleep_on(&lp->event); 
-		
-	restore_flags(flags);	
+	wait_for_completion(&lp->xceiver_cmd);
 } 
 
 
@@ -754,7 +720,7 @@
  *	the point where mc32_start_transceiver() can be called.
  *
  *	The card sets up the receive ring for us. We are required to use the
- *	ring it provides although we can change the size of the ring.
+ *	ring it provides, although the size of the ring is configurable.
  *
  * 	We allocate an sk_buff for each ring entry in turn and
  * 	initalise its house-keeping info. At the same time, we read
@@ -775,7 +741,7 @@
 	
 	rx_base=lp->rx_chain;
 
-	for(i=0;i<RX_RING_LEN;i++)
+	for(i=0; i<RX_RING_LEN; i++)
 	{
 		lp->rx_ring[i].skb=alloc_skb(1532, GFP_KERNEL);
 		skb_reserve(lp->rx_ring[i].skb, 18);  
@@ -812,21 +778,20 @@
  *
  *	Free the buffer for each ring slot. This may be called 
  *      before mc32_load_rx_ring(), eg. on error in mc32_open().
+ *      Requires rx skb pointers to point to a valid skb, or NULL. 
  */
 
 static void mc32_flush_rx_ring(struct net_device *dev)
 {
 	struct mc32_local *lp = (struct mc32_local *)dev->priv;
 	
-	struct sk_buff *skb;
 	int i; 
 
 	for(i=0; i < RX_RING_LEN; i++) 
-	{ 
-		skb = lp->rx_ring[i].skb;
-		if (skb!=NULL) {
-			kfree_skb(skb);
-			skb=NULL; 
+	{
+		if (lp->rx_ring[i].skb) {
+			dev_kfree_skb(lp->rx_ring[i].skb);
+			lp->rx_ring[i].skb = NULL;
 		}
 		lp->rx_ring[i].p=NULL; 
 	} 
@@ -858,7 +823,7 @@
 
 	tx_base=lp->tx_box->data[0]; 
 
-	for(i=0;i<lp->tx_len;i++) 
+	for(i=0 ; i<TX_RING_LEN ; i++)
 	{
 		p=isa_bus_to_virt(lp->base+tx_base);
 		lp->tx_ring[i].p=p; 
@@ -868,8 +833,8 @@
 	}
 
 	/* -1 so that tx_ring_head cannot "lap" tx_ring_tail,           */
-	/* which would be bad news for mc32_tx_ring as cur. implemented */ 
-
+	/* see mc32_tx_ring */
+	
 	atomic_set(&lp->tx_count, TX_RING_LEN-1); 
 	lp->tx_ring_head=lp->tx_ring_tail=0; 
 } 
@@ -878,45 +843,27 @@
 /**
  *	mc32_flush_tx_ring 	-	free transmit ring
  *	@lp: Local data of 3c527 to flush the tx ring of
- *
- *	We have to consider two cases here. We want to free the pending
- *	buffers only. If the ring buffer head is past the start then the
- *	ring segment we wish to free wraps through zero. The tx ring 
- *	house-keeping variables are then reset.
+ *	
+ *      If the ring is non-empty, zip over the it, freeing any
+ *      allocated skb_buffs.  The tx ring house-keeping variables are
+ *      then reset. Requires rx skb pointers to point to a valid skb,
+ *      or NULL.
  */
 
 static void mc32_flush_tx_ring(struct net_device *dev)
 {
 	struct mc32_local *lp = (struct mc32_local *)dev->priv;
+
+	int i; 
 	
-	if(lp->tx_ring_tail!=lp->tx_ring_head)
+	for (i=0; i < TX_RING_LEN; i++) 
 	{
-		int i;	
-		if(lp->tx_ring_tail < lp->tx_ring_head)
-		{
-			for(i=lp->tx_ring_tail;i<lp->tx_ring_head;i++)
-			{
-				dev_kfree_skb(lp->tx_ring[i].skb);
-				lp->tx_ring[i].skb=NULL;
-				lp->tx_ring[i].p=NULL; 
-			}
-		}
-		else
+		if (lp->tx_ring[i].skb) 
 		{
-			for(i=lp->tx_ring_tail; i<TX_RING_LEN; i++) 
-			{
-				dev_kfree_skb(lp->tx_ring[i].skb);
-				lp->tx_ring[i].skb=NULL;
-				lp->tx_ring[i].p=NULL; 
-			}
-			for(i=0; i<lp->tx_ring_head; i++) 
-			{
-				dev_kfree_skb(lp->tx_ring[i].skb);
-				lp->tx_ring[i].skb=NULL;
-				lp->tx_ring[i].p=NULL; 
-			}
-		}
-	}
+			dev_kfree_skb(lp->tx_ring[i].skb); 
+			lp->tx_ring[i].skb = NULL; 
+		} 
+	}					
 	
 	atomic_set(&lp->tx_count, 0); 
 	lp->tx_ring_tail=lp->tx_ring_head=0;
@@ -955,9 +902,14 @@
 	regs=inb(ioaddr+HOST_CTRL);
 	regs|=HOST_CTRL_INTE;
 	outb(regs, ioaddr+HOST_CTRL);
-	
 
 	/*
+	 * 	Allow ourselves to issue commands
+	 */
+
+	up(&lp->cmd_mutex);
+	
+	/*
 	 *	Send the indications on command
 	 */
 
@@ -1008,7 +960,7 @@
 		return -ENOBUFS;
 	}
 
-	lp->desired_state = RUNNING; 
+	lp->xceiver_desired_state = RUNNING;
 	
 	/* And finally, set the ball rolling... */
 	mc32_start_transceiver(dev);
@@ -1045,61 +997,64 @@
  *	Transmit a buffer. This normally means throwing the buffer onto
  *	the transmit queue as the queue is quite large. If the queue is
  *	full then we set tx_busy and return. Once the interrupt handler
- *	gets messages telling it to reclaim transmit queue entries we will
+ *	gets messages telling it to reclaim transmit queue entries, we will
  *	clear tx_busy and the kernel will start calling this again.
  *
- *	We use cli rather than spinlocks. Since I have no access to an SMP
- *	MCA machine I don't plan to change it. It is probably the top 
- *	performance hit for this driver on SMP however.
+ *	We do not disable interrupts or acquire any locks; this can
+ *	run concurrently with mc32_tx_ring(), and the function itself
+ *	is serialised at a higher layer. However, this makes it
+ *	crucial that we update lp->tx_ring_head only after we've
+ *	established a valid packet in the tx ring (and is why we mark
+ *	tx_ring_head volatile).
  */
 
 static int mc32_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mc32_local *lp = (struct mc32_local *)dev->priv;
-	unsigned long flags;
-
+	
+	u16 head = lp->tx_ring_head;
+	
 	volatile struct skb_header *p, *np;
 
 	netif_stop_queue(dev);
 
-	save_flags(flags);
-	cli();
-		
-	if(atomic_read(&lp->tx_count)==0)
-	{
-		restore_flags(flags);
+	if(atomic_read(&lp->tx_count)==0) {
 		return 1;
 	}
 
+	skb = skb_padto(skb, ETH_ZLEN);
+	if (skb == NULL) { 
+		netif_wake_queue(dev);
+		return 0;
+	}
+	
 	atomic_dec(&lp->tx_count); 
 
 	/* P is the last sending/sent buffer as a pointer */
-	p=lp->tx_ring[lp->tx_ring_head].p; 
-		
-	lp->tx_ring_head=next_tx(lp->tx_ring_head); 
-
+	p=lp->tx_ring[head].p;	
+	
+	head = next_tx(head);
+	
 	/* NP is the buffer we will be loading */
-	np=lp->tx_ring[lp->tx_ring_head].p; 
+	np=lp->tx_ring[head].p; 
+	
+	/* We will need this to flush the buffer out */
+	lp->tx_ring[head].skb=skb;
 
-   	if (skb->len < ETH_ZLEN) {
-   		skb = skb_padto(skb, ETH_ZLEN);
-   		if (skb == NULL)
-   			goto out;
-   	}
+	np->length = unlikely(skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len;
 
-	/* We will need this to flush the buffer out */
-	lp->tx_ring[lp->tx_ring_head].skb = skb;
-   	   
-	np->length = (skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len; 
-			
 	np->data	= isa_virt_to_bus(skb->data);
 	np->status	= 0;
 	np->control     = CONTROL_EOP | CONTROL_EOL;     
 	wmb();
-		
-	p->control     &= ~CONTROL_EOL;     /* Clear EOL on p */ 
-out:	
-	restore_flags(flags);
+
+	/*
+	 * The new frame has been setup; we can now
+	 * let the card and interrupt handler "see" it
+	 */
+
+	p->control     &= ~CONTROL_EOL;
+	lp->tx_ring_head= head;
 
 	netif_wake_queue(dev);
 	return 0;
@@ -1180,11 +1135,11 @@
 {
 	struct mc32_local *lp=dev->priv;		
 	volatile struct skb_header *p;
-	u16 rx_ring_tail = lp->rx_ring_tail;
-	u16 rx_old_tail = rx_ring_tail; 
-
+	u16 rx_ring_tail;
+	u16 rx_old_tail; 
 	int x=0;
-	
+
+	rx_old_tail = rx_ring_tail = lp->rx_ring_tail;
 	do
 	{ 
 		p=lp->rx_ring[rx_ring_tail].p; 
@@ -1273,8 +1228,13 @@
 	struct mc32_local *lp=(struct mc32_local *)dev->priv;
 	volatile struct skb_header *np;
 
-	/* NB: lp->tx_count=TX_RING_LEN-1 so that tx_ring_head cannot "lap" tail here */
-
+	/*
+	 * We rely on head==tail to mean 'queue empty'. 
+	 * This is why lp->tx_count=TX_RING_LEN-1: in order to prevent
+	 * tx_ring_head wrapping to tail and confusing a 'queue empty'
+	 * condition with 'queue full' 
+	 */
+	
 	while (lp->tx_ring_tail != lp->tx_ring_head)  
 	{   
 		u16 t; 
@@ -1386,8 +1346,7 @@
 				break;
 			case 3: /* Halt */
 			case 4: /* Abort */
-				lp->xceiver_state |= TX_HALTED; 
-				wake_up(&lp->event);
+				complete(&lp->xceiver_cmd);
 				break;
 			default:
 				printk("%s: strange tx ack %d\n", dev->name, status&7);
@@ -1402,8 +1361,7 @@
 				break;
 			case 3: /* Halt */
 			case 4: /* Abort */
-				lp->xceiver_state |= RX_HALTED;
-				wake_up(&lp->event);
+				complete(&lp->xceiver_cmd);
 				break;
 			case 6:
 				/* Out of RX buffers stat */
@@ -1419,26 +1377,17 @@
 		status>>=3;
 		if(status&1)
 		{
+			/*
+			 * No thread is waiting: we need to tidy
+			 * up ourself.
+			 */
 
-			/* 0=no 1=yes 2=replied, get cmd, 3 = wait reply & dump it */
-			
-			if(lp->exec_pending!=3) {
-				lp->exec_pending=2;
-				wake_up(&lp->event);
-			}
-			else 
-			{				
-			  	lp->exec_pending=0;
-
-				/* A new multicast set may have been
-				   blocked while the old one was
-				   running. If so, do it now. */
-				   
+			if (lp->cmd_nonblocking) { 
+				up(&lp->cmd_mutex);
 				if (lp->mc_reload_wait) 
 					mc32_reset_multicast_list(dev);
-				else 
-					wake_up(&lp->event);			       
 			}
+			else complete(&lp->execution_cmd);
 		}
 		if(status&2)
 		{
@@ -1496,7 +1445,7 @@
 	u8 regs;
 	u16 one=1;
 	
-	lp->desired_state = HALTED;
+	lp->xceiver_desired_state = HALTED;
 	netif_stop_queue(dev);
 
 	/*
@@ -1508,12 +1457,10 @@
 	/* Shut down the transceiver */
 
 	mc32_halt_transceiver(dev); 
+
+	/* Ensure we issue no more commands beyond this point */
+	down(&lp->cmd_mutex);
 	
-	/* Catch any waiting commands */
-	
-	while(lp->exec_pending==1)
-		sleep_on(&lp->event);
-	       
 	/* Ok the card is now stopping */	
 	
 	regs=inb(ioaddr+HOST_CTRL);
@@ -1540,12 +1487,10 @@
 
 static struct net_device_stats *mc32_get_stats(struct net_device *dev)
 {
-	struct mc32_local *lp;
+	struct mc32_local *lp = (struct mc32_local *)dev->priv;;
 	
 	mc32_update_stats(dev); 
 
-	lp = (struct mc32_local *)dev->priv;
-
 	return &lp->net_stats;
 }
 

--------------010003080109070003070903--


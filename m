Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbTDGXNV (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263863AbTDGXMm (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:12:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60288
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263824AbTDGXGP (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:06:15 -0400
Date: Tue, 8 Apr 2003 01:25:09 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080025.h380P9uA009113@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Update lp486e for 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/net/lp486e.c linux-2.5.67-ac1/drivers/net/lp486e.c
--- linux-2.5.67/drivers/net/lp486e.c	2003-02-10 18:38:11.000000000 +0000
+++ linux-2.5.67-ac1/drivers/net/lp486e.c	2003-04-07 19:14:53.000000000 +0100
@@ -56,7 +56,7 @@
 All other communication is through memory!
 */
 
-#define SLOW_DOWN_IO udelay(5);
+#define SLOW_DOWN_IO udelay(5)
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -195,7 +195,7 @@
 typedef u32 phys_addr;
 
 static inline phys_addr
-va_to_pa(volatile void *x) {
+va_to_pa(void *x) {
 	return x ? virt_to_bus(x) : I596_NULL;
 }
 
@@ -341,14 +341,15 @@
 	unsigned long tdr_stat;	/* directly follows tdr */
 
 	int last_restart;
-	volatile struct i596_rbd *rbd_list;
-	volatile struct i596_rbd *rbd_tail;
-	volatile struct i596_rfd *rx_tail;
-	volatile struct i596_cmd *cmd_tail;
-	volatile struct i596_cmd *cmd_head;
+	struct i596_rbd *rbd_list;
+	struct i596_rbd *rbd_tail;
+	struct i596_rfd *rx_tail;
+	struct i596_cmd *cmd_tail;
+	struct i596_cmd *cmd_head;
 	int cmd_backlog;
 	unsigned long last_cmd;
 	struct net_device_stats stats;
+	spinlock_t cmd_lock;
 };
 
 static char init_setup[14] = {
@@ -386,7 +387,7 @@
 
 static int
 i596_timeout(struct net_device *dev, char *msg, int ct) {
-	volatile struct i596_private *lp;
+	struct i596_private *lp;
 	int boguscnt = ct;
 
 	lp = (struct i596_private *) dev->priv;
@@ -398,13 +399,14 @@
 			return 1;
 		}
 		udelay(5);
+		barrier();
 	}
 	return 0;
 }
 
 static inline int
 init_rx_bufs(struct net_device *dev, int num) {
-	volatile struct i596_private *lp;
+	struct i596_private *lp;
 	struct i596_rfd *rfd;
 	int i;
 	// struct i596_rbd *rbd;
@@ -517,8 +519,8 @@
 /* selftest or dump */
 static void
 i596_port_do(struct net_device *dev, int portcmd, char *cmdname) {
-	volatile struct i596_private *lp = dev->priv;
-	volatile u16 *outp;
+	struct i596_private *lp = dev->priv;
+	u16 *outp;
 	int i, m;
 
 	memset((void *)&(lp->dump), 0, sizeof(struct i596_dump));
@@ -541,7 +543,7 @@
 
 static int
 i596_scp_setup(struct net_device *dev) {
-	volatile struct i596_private *lp = dev->priv;
+	struct i596_private *lp = dev->priv;
 	int boguscnt;
 
 	/* Setup SCP, ISCP, SCB */
@@ -608,6 +610,7 @@
 			return 1;
 		}
 		udelay(5);
+		barrier();
 	}
 	/* I find here boguscnt==100, so no delay was required. */
 
@@ -616,7 +619,7 @@
 
 static int
 init_i596(struct net_device *dev) {
-	volatile struct i596_private *lp;
+	struct i596_private *lp;
 
 	if (i596_scp_setup(dev))
 		return 1;
@@ -641,6 +644,8 @@
 	lp->scb.command = RX_START;
 	CA();
 
+	barrier();
+	
 	if (lp->scb.command && i596_timeout(dev, "Receive Unit start", 100))
 		return 1;
 
@@ -649,7 +654,7 @@
 
 /* Receive a single frame */
 static inline int
-i596_rx_one(struct net_device *dev, volatile struct i596_private *lp,
+i596_rx_one(struct net_device *dev, struct i596_private *lp,
 	    struct i596_rfd *rfd, int *frames) {
 
 	if (rfd->stat & RFD_STAT_OK) {
@@ -703,14 +708,14 @@
 
 static int
 i596_rx(struct net_device *dev) {
-	volatile struct i596_private *lp = (struct i596_private *) dev->priv;
+	struct i596_private *lp = (struct i596_private *) dev->priv;
 	struct i596_rfd *rfd;
 	int frames = 0;
 
 	while (1) {
 		rfd = pa_to_va(lp->scb.pa_rfd);
 		if (!rfd) {
-			printk("i596_rx: NULL rfd?\n");
+			printk(KERN_ERR "i596_rx: NULL rfd?\n");
 			return 0;
 		}
 #if 1
@@ -725,6 +730,7 @@
 		lp->rx_tail->cmd = 0;
 		lp->rx_tail = rfd;
 		lp->scb.pa_rfd = rfd->pa_next;
+		barrier();
 	}
 
 	return frames;
@@ -732,7 +738,7 @@
 
 static void
 i596_cleanup_cmd(struct net_device *dev) {
-	volatile struct i596_private *lp;
+	struct i596_private *lp;
 	struct i596_cmd *cmd;
 
 	lp = (struct i596_private *) dev->priv;
@@ -770,6 +776,7 @@
 				break;
 			}
 		}
+		barrier();
 	}
 
 	if (lp->scb.command && i596_timeout(dev, "i596_cleanup_cmd", 100))
@@ -778,9 +785,7 @@
 	lp->scb.pa_cmd = va_to_pa(lp->cmd_head);
 }
 
-static inline void
-i596_reset(struct net_device *dev,
-	   volatile struct i596_private *lp, int ioaddr) {
+static void i596_reset(struct net_device *dev, struct i596_private *lp, int ioaddr) {
 
 	if (lp->scb.command && i596_timeout(dev, "i596_reset", 100))
 		;
@@ -789,7 +794,8 @@
 
 	lp->scb.command = CUC_ABORT | RX_ABORT;
 	CA();
-
+	barrier();
+	
 	/* wait for shutdown */
 	if (lp->scb.command && i596_timeout(dev, "i596_reset(2)", 400))
 		;
@@ -803,7 +809,7 @@
 }
 
 static void i596_add_cmd(struct net_device *dev, struct i596_cmd *cmd) {
-	volatile struct i596_private *lp = dev->priv;
+	struct i596_private *lp = dev->priv;
 	int ioaddr = dev->base_addr;
 	unsigned long flags;
 
@@ -811,8 +817,8 @@
 	cmd->command |= (CMD_EOL | CMD_INTR);
 	cmd->pa_next = I596_NULL;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lp->cmd_lock, flags);
+	
 	if (lp->cmd_head) {
 		lp->cmd_tail->pa_next = va_to_pa(cmd);
 	} else {
@@ -827,64 +833,45 @@
 	lp->cmd_backlog++;
 
 	lp->cmd_head = pa_to_va(lp->scb.pa_cmd);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lp->cmd_lock, flags);
 
 	if (lp->cmd_backlog > 16) {
 		int tickssofar = jiffies - lp->last_cmd;
-		if (tickssofar < 25) return;
+		if (tickssofar < HZ/4)
+			return;
 
-		printk("%s: command unit timed out, status resetting.\n",
-		       dev->name);
+		printk(KERN_WARNING "%s: command unit timed out, status resetting.\n", dev->name);
 		i596_reset(dev, lp, ioaddr);
 	}
 }
 
-static int
-i596_open(struct net_device *dev) {
+static int i596_open(struct net_device *dev) 
+{
 	int i;
 
 	i = request_irq(dev->irq, &i596_interrupt, SA_SHIRQ, dev->name, dev);
 	if (i) {
-		printk("%s: IRQ %d not free\n", dev->name, dev->irq);
+		printk(KERN_ERR "%s: IRQ %d not free\n", dev->name, dev->irq);
 		return i;
 	}
 
 	if ((i = init_rx_bufs(dev, RX_RING_SIZE)) < RX_RING_SIZE)
-		printk("%s: only able to allocate %d receive buffers\n",
-		       dev->name, i);
+		printk(KERN_ERR "%s: only able to allocate %d receive buffers\n", dev->name, i);
 
 	if (i < 4) {
-// release buffers
 		free_irq(dev->irq, dev);
 		return -EAGAIN;
 	}
-
 	netif_start_queue(dev);
-
 	init_i596(dev);
-
 	return 0;			/* Always succeed */
 }
 
-static int
-i596_start_xmit (struct sk_buff *skb, struct net_device *dev) {
-	volatile struct i596_private *lp = dev->priv;
+static int i596_start_xmit (struct sk_buff *skb, struct net_device *dev) {
+	struct i596_private *lp = dev->priv;
 	struct tx_cmd *tx_cmd;
 	short length;
 
-	/* If some higher level thinks we've missed a tx-done interrupt
-	   we are passed NULL. n.b. dev_tint handles the cli()/sti()
-	   itself. */
-	if (skb == NULL) {
-		printk ("What about dev_tint\n");
-		/* dev_tint(dev); */
-		return 0;
-	}
-
-	/* shouldn't happen */
-	if (skb->len <= 0)
-		return 0;
-
 	length = skb->len;
 	
 	if (length < ETH_ZLEN) {
@@ -896,14 +883,10 @@
 	
 	dev->trans_start = jiffies;
 
-	tx_cmd = (struct tx_cmd *)
-	    kmalloc ((sizeof (struct tx_cmd)
-		      + sizeof (struct i596_tbd)), GFP_ATOMIC);
+	tx_cmd = (struct tx_cmd *) kmalloc ((sizeof (struct tx_cmd) + sizeof (struct i596_tbd)), GFP_ATOMIC);
 	if (tx_cmd == NULL) {
-		printk ("%s: i596_xmit Memory squeeze, dropping packet.\n",
-			dev->name);
+		printk(KERN_WARNING "%s: i596_xmit Memory squeeze, dropping packet.\n", dev->name);
 		lp->stats.tx_dropped++;
-
 		dev_kfree_skb (skb);
 	} else {
 		struct i596_tbd *tx_cmd_tbd;
@@ -934,11 +917,11 @@
 
 static void
 i596_tx_timeout (struct net_device *dev) {
-	volatile struct i596_private *lp = dev->priv;
+	struct i596_private *lp = dev->priv;
 	int ioaddr = dev->base_addr;
 
 	/* Transmitter timeout, serious problems. */
-	printk ("%s: transmit timed out, status resetting.\n", dev->name);
+	printk(KERN_WARNING "%s: transmit timed out, status resetting.\n", dev->name);
 	lp->stats.tx_errors++;
 
 	/* Try to restart the adaptor */
@@ -957,8 +940,8 @@
 	netif_wake_queue(dev);
 }
 
-static void
-print_eth(char *add) {
+static void print_eth(char *add) 
+{
 	int i;
 
 	printk ("Dest  ");
@@ -975,9 +958,8 @@
 		(unsigned char) add[12], (unsigned char) add[13]);
 }
 
-int __init
-lp486e_probe(struct net_device *dev) {
-	volatile struct i596_private *lp;
+int __init lp486e_probe(struct net_device *dev) {
+	struct i596_private *lp;
 	unsigned char eth_addr[6] = { 0, 0xaa, 0, 0, 0, 0 };
 	unsigned char *bios;
 	int i, j;
@@ -996,14 +978,14 @@
 	/*
 	 * Allocate working memory, 16-byte aligned
 	 */
-	dev->mem_start = (unsigned long)
-		kmalloc(sizeof(struct i596_private) + 0x0f, GFP_KERNEL);
+	dev->mem_start = (unsigned long) kmalloc(sizeof(struct i596_private) + 0x0f, GFP_KERNEL);
 	if (!dev->mem_start)
 		goto err_out;
 	dev->priv = (void *)((dev->mem_start + 0xf) & 0xfffffff0);
 	lp = (struct i596_private *) dev->priv;
 	memset((void *)lp, 0, sizeof(struct i596_private));
-
+	spin_lock_init(&lp->cmd_lock);
+	
 	/*
 	 * Do we really have this thing?
 	 */
@@ -1071,14 +1053,16 @@
 
 static inline void
 i596_handle_CU_completion(struct net_device *dev,
-			  volatile struct i596_private *lp,
+			  struct i596_private *lp,
 			  unsigned short status,
 			  unsigned short *ack_cmdp) {
-	volatile struct i596_cmd *cmd;
+	struct i596_cmd *cmd;
 	int frames_out = 0;
 	int commands_done = 0;
 	int cmd_val;
+	unsigned long flags;
 
+	spin_lock_irqsave(&lp->cmd_lock, flags);
 	cmd = lp->cmd_head;
 
 	while (lp->cmd_head && (lp->cmd_head->status & CMD_STAT_C)) {
@@ -1160,31 +1144,29 @@
 			lp->last_cmd = jiffies;
 			
 		}
+		barrier();
 	}
 
 	cmd = lp->cmd_head;
 	while (cmd && (cmd != lp->cmd_tail)) {
 		cmd->command &= 0x1fff;
 		cmd = pa_to_va(cmd->pa_next);
+		barrier();
 	}
 
 	if (lp->cmd_head)
 		*ack_cmdp |= CUC_START;
 	lp->scb.pa_cmd = va_to_pa(lp->cmd_head);
+	spin_unlock_irqrestore(&lp->cmd_lock, flags);
 }
 
 static void
 i596_interrupt (int irq, void *dev_instance, struct pt_regs *regs) {
 	struct net_device *dev = (struct net_device *) dev_instance;
-	volatile struct i596_private *lp;
+	struct i596_private *lp;
 	unsigned short status, ack_cmd = 0;
 	int frames_in = 0;
 
-	if (dev == NULL) {
-		printk ("i596_interrupt(): irq %d for unknown device.\n", irq);
-		return;
-	}
-
 	lp = (struct i596_private *) dev->priv;
 
 	/*
@@ -1251,7 +1233,7 @@
 }
 
 static int i596_close(struct net_device *dev) {
-	volatile struct i596_private *lp = dev->priv;
+	struct i596_private *lp = dev->priv;
 
 	netif_stop_queue(dev);
 
@@ -1284,7 +1266,7 @@
 */
 
 static void set_multicast_list(struct net_device *dev) {
-	volatile struct i596_private *lp = dev->priv;
+	struct i596_private *lp = dev->priv;
 	struct i596_cmd *cmd;
 
 	if (i596_debug > 1)
@@ -1294,12 +1276,9 @@
 	if (dev->mc_count > 0) {
 		struct dev_mc_list *dmi;
 		char *cp;
-		cmd = (struct i596_cmd *)
-			kmalloc(sizeof(struct i596_cmd)+2+dev->mc_count*6,
-				GFP_ATOMIC);
+		cmd = (struct i596_cmd *)kmalloc(sizeof(struct i596_cmd)+2+dev->mc_count*6, GFP_ATOMIC);
 		if (cmd == NULL) {
-			printk ("%s: set_multicast Memory squeeze.\n",
-				dev->name);
+			printk (KERN_ERR "%s: set_multicast Memory squeeze.\n", dev->name);
 			return;
 		}
 		cmd->command = CmdMulticastList;
@@ -1316,8 +1295,7 @@
 		if (lp->set_conf.pa_next != I596_NULL) {
 			return;
 		}
-		if (dev->mc_count == 0 &&
-		    !(dev->flags & (IFF_PROMISC | IFF_ALLMULTI))) {
+		if (dev->mc_count == 0 && !(dev->flags & (IFF_PROMISC | IFF_ALLMULTI))) {
 			if (dev->flags & IFF_ALLMULTI)
 				dev->flags |= IFF_PROMISC;
 			lp->i596_config[8] &= ~0x01;

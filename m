Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSKCNMI>; Sun, 3 Nov 2002 08:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSKCNMI>; Sun, 3 Nov 2002 08:12:08 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62734 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261854AbSKCNMB>; Sun, 3 Nov 2002 08:12:01 -0500
Message-Id: <200211031313.gA3DDap28099@Port.imtp.ilyichevsk.odessa.ua>
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: 2.5.45: patches for NIC drivers
Date: Sun, 3 Nov 2002 16:05:33 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_99I0XFDPV0R0WGBHPQJR"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_99I0XFDPV0R0WGBHPQJR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

These are still needed for my .config to compile.
Mostly cli() removal.
They compile, have no hw to actually try.
--
vda


--------------Boundary-00=_99I0XFDPV0R0WGBHPQJR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="skgepnm2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="skgepnm2.patch"

diff -u --recursive linux-2.5.40org/drivers/net/sk98lin/h/skgepnm2.h linux-2.5.40/drivers/net/sk98lin/h/skgepnm2.h
--- linux-2.5.40org/drivers/net/sk98lin/h/skgepnm2.h	Wed Oct  9 20:28:58 2002
+++ linux-2.5.40/drivers/net/sk98lin/h/skgepnm2.h	Wed Oct  9 20:29:34 2002
@@ -338,11 +338,12 @@
 /*
  * Time macros
  */
-#if SK_TICKS_PER_SEC == 100
+// vda: this generates calls to libc fp helpers :-(
+//#if SK_TICKS_PER_SEC == 100
 #define SK_PNMI_HUNDREDS_SEC(t)	(t)
-#else
-#define SK_PNMI_HUNDREDS_SEC(t)	(((t) * 100) / (SK_TICKS_PER_SEC))
-#endif
+//#else
+//#define SK_PNMI_HUNDREDS_SEC(t)	(((t) * 100) / (SK_TICKS_PER_SEC))
+//#endif
 
 /*
  * Macros to work around alignment problems

--------------Boundary-00=_99I0XFDPV0R0WGBHPQJR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ni5010.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ni5010.patch"

diff -u --recursive linux-2.5.40org/drivers/net/ni5010.c linux-2.5.40/drivers/net/ni5010.c
--- linux-2.5.40org/drivers/net/ni5010.c	Thu Oct  3 12:08:00 2002
+++ linux-2.5.40/drivers/net/ni5010.c	Wed Oct  9 09:35:26 2002
@@ -86,6 +86,8 @@
 	{ 0x300, 0x320, 0x340, 0x360, 0x380, 0x3a0, 0 };
 #endif
 
+static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+
 /* Use 0 for production, 1 for verification, >2 for debug */
 #ifndef NI5010_DEBUG
 #define NI5010_DEBUG 0
@@ -693,9 +695,8 @@
         buf_offs = NI5010_BUFSIZE - length;
         lp->o_pkt_size = length;
 
-	save_flags(flags);	
-	cli();
-
+	spin_lock_irqsave(&lock, flags);
+	
 	outb(0, EDLC_RMASK);	/* Mask all receive interrupts */
 	outb(0, IE_MMODE);	/* Put Xmit buffer on system bus */
 	outb(0xff, EDLC_RCLR);	/* Clear out pending rcv interrupts */
@@ -709,7 +710,7 @@
 	outb(MM_EN_XMT | MM_MUX, IE_MMODE); /* Begin transmission */
 	outb(XM_ALL, EDLC_XMASK); /* Cause interrupt after completion or fail */
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 
 	netif_wake_queue(dev);
 	

--------------Boundary-00=_99I0XFDPV0R0WGBHPQJR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ni65.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ni65.patch"

diff -u --recursive linux-2.5.40org/drivers/net/ni65.c linux-2.5.40/drivers/net/ni65.c
--- linux-2.5.40org/drivers/net/ni65.c	Thu Oct  3 12:08:00 2002
+++ linux-2.5.40/drivers/net/ni65.c	Wed Oct  9 10:35:18 2002
@@ -176,6 +176,9 @@
 #define writedatareg(val) { writereg(val,CSR0); }
 #endif
 
+/* Not to be confused with priv->lock */
+static spinlock_t irq_lock = SPIN_LOCK_UNLOCKED;
+
 static unsigned char ni_vendor[] = { 0x02,0x07,0x01 };
 
 static struct card {
@@ -409,7 +412,7 @@
 		p->features = 0x0;
 	}
 
-	if(test_bit(0,&cards[i].config)) {
+	if(test_bit(0,(unsigned long*)(&cards[i].config))) {
 		dev->irq = irqtab[(inw(ioaddr+L_CONFIG)>>2)&3];
 		dev->dma = dmatab[inw(ioaddr+L_CONFIG)&3];
 		printk("IRQ %d (from card), DMA %d (from card).\n",dev->irq,dev->dma);
@@ -420,7 +423,7 @@
 			int dma_channels = ((inb(DMA1_STAT_REG) >> 4) & 0x0f) | (inb(DMA2_STAT_REG) & 0xf0);
 			for(i=1;i<5;i++) {
 				int dma = dmatab[i];
-				if(test_bit(dma,&dma_channels) || request_dma(dma,"ni6510"))
+				if(test_bit(dma,(unsigned long*)&dma_channels) || request_dma(dma,"ni6510"))
 					continue;
 					
 				flags=claim_dma_lock();
@@ -1118,8 +1121,7 @@
 							 (skb->len > T_BUF_SIZE) ? T_BUF_SIZE : skb->len);
 			dev_kfree_skb (skb);
 
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&irq_lock, flags);
 
 			tmdp = p->tmdhead + p->tmdnum;
 			tmdp->u.buffer = (u32) isa_virt_to_bus(p->tmdbounce[p->tmdbouncenum]);
@@ -1128,8 +1130,7 @@
 #ifdef XMT_VIA_SKB
 		}
 		else {
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&irq_lock, flags);
 
 			tmdp = p->tmdhead + p->tmdnum;
 			tmdp->u.buffer = (u32) isa_virt_to_bus(skb->data);
@@ -1150,7 +1151,7 @@
 		p->lock = 0;
 		dev->trans_start = jiffies;
 
-		restore_flags(flags);
+		spin_unlock_irqrestore(&irq_lock, flags);
 	}
 
 	return 0;

--------------Boundary-00=_99I0XFDPV0R0WGBHPQJR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="at1700.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="at1700.patch"

diff -u --recursive linux-2.5.40org/drivers/net/at1700.c linux-2.5.40/drivers/net/at1700.c
--- linux-2.5.40org/drivers/net/at1700.c	Thu Oct  3 12:08:00 2002
+++ linux-2.5.40/drivers/net/at1700.c	Wed Oct  9 09:13:06 2002
@@ -832,12 +832,11 @@
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 			 i++, mclist = mclist->next)
 			set_bit(ether_crc_le(ETH_ALEN, mclist->dmi_addr) >> 26,
-					mc_filter);
+					(unsigned long *)mc_filter);
 		outb(0x02, ioaddr + RX_MODE);	/* Use normal mode. */
 	}
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lp->lock, flags); /* FIXME: move up before first IO? */
 	if (memcmp(mc_filter, lp->mc_filter, sizeof(mc_filter))) {
 		int saved_bank = inw(ioaddr + CONFIG_0);
 		/* Switch to bank 1 and set the multicast table. */
@@ -847,7 +846,7 @@
 		memcpy(lp->mc_filter, mc_filter, sizeof(mc_filter));
 		outw(saved_bank, ioaddr + CONFIG_0);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	return;
 }
 

--------------Boundary-00=_99I0XFDPV0R0WGBHPQJR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="82596.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="82596.patch"

diff -u --recursive linux-2.5.40org/drivers/net/82596.c linux-2.5.40/drivers/net/82596.c
--- linux-2.5.40org/drivers/net/82596.c	Thu Oct  3 12:08:00 2002
+++ linux-2.5.40/drivers/net/82596.c	Wed Oct  9 10:54:55 2002
@@ -1414,15 +1414,15 @@
 	DEB(DEB_INIT,printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.\n",
 		       dev->name, lp->scb.status));
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lp->lock, flags);
 
 	wait_cmd(dev,lp,100,"close1 timed out");
 	lp->scb.command = CUC_ABORT | RX_ABORT;
 	CA(dev);
-
 	wait_cmd(dev,lp,100,"close2 timed out");
-	restore_flags(flags);
+
+	spin_unlock_irqrestore(&lp->lock, flags);
+	
 	DEB(DEB_STRUCT,i596_display_data(dev));
 	i596_cleanup_cmd(dev,lp);
 

--------------Boundary-00=_99I0XFDPV0R0WGBHPQJR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="lp486e.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="lp486e.patch"

diff -u --recursive linux-2.5.40org/drivers/net/lp486e.c linux-2.5.40/drivers/net/lp486e.c
--- linux-2.5.40org/drivers/net/lp486e.c	Thu Oct  3 12:08:00 2002
+++ linux-2.5.40/drivers/net/lp486e.c	Wed Oct  9 10:53:26 2002
@@ -85,6 +85,8 @@
 
 static int i596_debug = 0;
 
+static spinlock_t irq_lock = SPIN_LOCK_UNLOCKED;
+
 static const char * const medianame[] = {
 	"10baseT", "AUI",
 	"10baseT-FD", "AUI-FD",
@@ -403,6 +405,7 @@
 	return 0;
 }
 
+/* Have single call site */
 static inline int
 init_rx_bufs(struct net_device *dev, int num) {
 	volatile struct i596_private *lp;
@@ -462,6 +465,7 @@
 	return (i);
 }
 
+/* Have single call site */
 static inline void
 remove_rx_bufs(struct net_device *dev) {
 	struct i596_private *lp;
@@ -812,8 +816,8 @@
 	cmd->command |= (CMD_EOL | CMD_INTR);
 	cmd->pa_next = I596_NULL;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&irq_lock, flags);
+	
 	if (lp->cmd_head) {
 		lp->cmd_tail->pa_next = va_to_pa(cmd);
 	} else {
@@ -826,9 +830,9 @@
 	}
 	lp->cmd_tail = cmd;
 	lp->cmd_backlog++;
-
 	lp->cmd_head = pa_to_va(lp->scb.pa_cmd);
-	restore_flags(flags);
+	
+	spin_unlock_irqrestore(&irq_lock, flags);
 
 	if (lp->cmd_backlog > 16) {
 		int tickssofar = jiffies - lp->last_cmd;
@@ -1179,6 +1183,8 @@
 	}
 
 	lp = (struct i596_private *) dev->priv;
+
+	/* FIXME: spinlock here! */
 
 	/*
 	 * The 82596 examines the command, performs the required action,

--------------Boundary-00=_99I0XFDPV0R0WGBHPQJR--

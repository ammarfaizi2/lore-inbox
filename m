Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTEDOA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 10:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTEDOA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 10:00:26 -0400
Received: from [66.212.224.118] ([66.212.224.118]:31242 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S263597AbTEDOAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 10:00:20 -0400
Date: Sun, 4 May 2003 10:04:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: irqreturn_t for drivers/net/pcmcia
Message-ID: <Pine.LNX.4.50.0305040919480.31537-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only the smc91c92 has been tested. The patch is against current BK/CVS

Index: linux-2.5/drivers/net/pcmcia/3c589_cs.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/pcmcia/3c589_cs.c,v
retrieving revision 1.17
diff -u -p -B -r1.17 3c589_cs.c
--- linux-2.5/drivers/net/pcmcia/3c589_cs.c	29 Apr 2003 22:46:23 -0000	1.17
+++ linux-2.5/drivers/net/pcmcia/3c589_cs.c	4 May 2003 13:09:58 -0000
@@ -159,7 +159,7 @@ static void media_check(unsigned long ar
 static int el3_config(struct net_device *dev, struct ifmap *map);
 static int el3_open(struct net_device *dev);
 static int el3_start_xmit(struct sk_buff *skb, struct net_device *dev);
-static void el3_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t el3_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static void update_stats(struct net_device *dev);
 static struct net_device_stats *el3_get_stats(struct net_device *dev);
 static int el3_rx(struct net_device *dev);
@@ -816,15 +816,16 @@ static int el3_start_xmit(struct sk_buff
 }
 
 /* The EL3 interrupt handler. */
-static void el3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t el3_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
     struct el3_private *lp = dev_id;
     struct net_device *dev = &lp->dev;
     ioaddr_t ioaddr, status;
-    int i = 0;
+    int i = 0, handled = 1;
     
     if (!netif_device_present(dev))
-	return;
+	return IRQ_NONE;
+
     ioaddr = dev->base_addr;
 
     DEBUG(3, "%s: interrupt, status %4.4x.\n",
@@ -833,9 +834,9 @@ static void el3_interrupt(int irq, void 
     spin_lock(&lp->lock);    
     while ((status = inw(ioaddr + EL3_STATUS)) &
 	(IntLatch | RxComplete | StatsFull)) {
-	if (!netif_device_present(dev) ||
-	    ((status & 0xe000) != 0x2000)) {
+	if ((status & 0xe000) != 0x2000) {
 	    DEBUG(1, "%s: interrupt from dead card\n", dev->name);
+	    handled = 0;
 	    break;
 	}
 	
@@ -897,7 +898,7 @@ static void el3_interrupt(int irq, void 
     spin_unlock(&lp->lock);    
     DEBUG(3, "%s: exiting interrupt, status %4.4x.\n",
 	  dev->name, inw(ioaddr + EL3_STATUS));
-    return;
+    return IRQ_RETVAL(handled);
 }
 
 static void media_check(unsigned long arg)
Index: linux-2.5/drivers/net/pcmcia/fmvj18x_cs.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/pcmcia/fmvj18x_cs.c,v
retrieving revision 1.20
diff -u -p -B -r1.20 fmvj18x_cs.c
--- linux-2.5/drivers/net/pcmcia/fmvj18x_cs.c	29 Apr 2003 22:46:23 -0000	1.20
+++ linux-2.5/drivers/net/pcmcia/fmvj18x_cs.c	4 May 2003 13:09:59 -0000
@@ -107,7 +107,7 @@ static int fjn_config(struct net_device 
 static int fjn_open(struct net_device *dev);
 static int fjn_close(struct net_device *dev);
 static int fjn_start_xmit(struct sk_buff *skb, struct net_device *dev);
-static void fjn_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t fjn_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static void fjn_rx(struct net_device *dev);
 static void fjn_reset(struct net_device *dev);
 static struct net_device_stats *fjn_get_stats(struct net_device *dev);
@@ -845,7 +845,7 @@ module_exit(exit_fmvj18x_cs);
 
 /*====================================================================*/
 
-static void fjn_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t fjn_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
     local_info_t *lp = dev_id;
     struct net_device *dev = &lp->dev;
@@ -855,7 +855,7 @@ static void fjn_interrupt(int irq, void 
     if (lp == NULL) {
         printk(KERN_NOTICE "fjn_interrupt(): irq %d for "
 	       "unknown device.\n", irq);
-        return;
+        return IRQ_NONE;
     }
     ioaddr = dev->base_addr;
 
@@ -899,6 +899,7 @@ static void fjn_interrupt(int irq, void 
 
     outb(D_TX_INTR, ioaddr + TX_INTR);
     outb(D_RX_INTR, ioaddr + RX_INTR);
+    return IRQ_HANDLED;
 
 } /* fjn_interrupt */
 
Index: linux-2.5/drivers/net/pcmcia/ibmtr_cs.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/pcmcia/ibmtr_cs.c,v
retrieving revision 1.13
diff -u -p -B -r1.13 ibmtr_cs.c
--- linux-2.5/drivers/net/pcmcia/ibmtr_cs.c	29 Apr 2003 22:46:23 -0000	1.13
+++ linux-2.5/drivers/net/pcmcia/ibmtr_cs.c	4 May 2003 13:09:59 -0000
@@ -127,7 +127,7 @@ static dev_link_t *dev_list;
 
 extern int ibmtr_probe(struct net_device *dev);
 extern int trdev_init(struct net_device *dev);
-extern void tok_interrupt (int irq, void *dev_id, struct pt_regs *regs);
+extern irqreturn_t tok_interrupt (int irq, void *dev_id, struct pt_regs *regs);
 
 /*====================================================================*/
 
Index: linux-2.5/drivers/net/pcmcia/nmclan_cs.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/pcmcia/nmclan_cs.c,v
retrieving revision 1.14
diff -u -p -B -r1.14 nmclan_cs.c
--- linux-2.5/drivers/net/pcmcia/nmclan_cs.c	29 Apr 2003 22:46:23 -0000	1.14
+++ linux-2.5/drivers/net/pcmcia/nmclan_cs.c	4 May 2003 13:10:00 -0000
@@ -431,7 +431,7 @@ static int mace_open(struct net_device *
 static int mace_close(struct net_device *dev);
 static int mace_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void mace_tx_timeout(struct net_device *dev);
-static void mace_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t mace_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static struct net_device_stats *mace_get_stats(struct net_device *dev);
 static int mace_rx(struct net_device *dev, unsigned char RxCnt);
 static void restore_multicast_list(struct net_device *dev);
@@ -1143,7 +1143,7 @@ static int mace_start_xmit(struct sk_buf
 mace_interrupt
 	The interrupt handler.
 ---------------------------------------------------------------------------- */
-static void mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mace_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
   mace_private *lp = (mace_private *)dev_id;
   struct net_device *dev = &lp->dev;
@@ -1154,7 +1154,7 @@ static void mace_interrupt(int irq, void
   if (dev == NULL) {
     DEBUG(2, "mace_interrupt(): irq 0x%X for unknown device.\n",
 	  irq);
-    return;
+    return IRQ_NONE;
   }
 
   if (lp->tx_irq_disabled) {
@@ -1169,12 +1169,12 @@ static void mace_interrupt(int irq, void
       inb(ioaddr + AM2150_MACE_BASE + MACE_IMR)
     );
     /* WARNING: MACE_IR has been read! */
-    return;
+    return IRQ_NONE;
   }
 
   if (!netif_device_present(dev)) {
     DEBUG(2, "%s: interrupt from dead card\n", dev->name);
-    goto exception;
+    return IRQ_NONE;
   }
 
   do {
@@ -1279,8 +1279,7 @@ static void mace_interrupt(int irq, void
 
   } while ((status & ~MACE_IMR_DEFAULT) && (--IntrCnt));
 
-exception:
-  return;
+  return IRQ_HANDLED;
 } /* mace_interrupt */
 
 /* ----------------------------------------------------------------------------
Index: linux-2.5/drivers/net/pcmcia/smc91c92_cs.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/pcmcia/smc91c92_cs.c,v
retrieving revision 1.18
diff -u -p -B -r1.18 smc91c92_cs.c
--- linux-2.5/drivers/net/pcmcia/smc91c92_cs.c	29 Apr 2003 22:46:23 -0000	1.18
+++ linux-2.5/drivers/net/pcmcia/smc91c92_cs.c	4 May 2003 13:10:02 -0000
@@ -293,7 +293,7 @@ static int smc_close(struct net_device *
 static int smc_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void smc_tx_timeout(struct net_device *dev);
 static int smc_start_xmit(struct sk_buff *skb, struct net_device *dev);
-static void smc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t smc_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static void smc_rx(struct net_device *dev);
 static struct net_device_stats *smc_get_stats(struct net_device *dev);
 static void set_rx_mode(struct net_device *dev);
@@ -1574,16 +1574,18 @@ static void smc_eph_irq(struct net_devic
 
 /*====================================================================*/
 
-static void smc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t smc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
     struct smc_private *smc = dev_id;
     struct net_device *dev = &smc->dev;
     ioaddr_t ioaddr;
     u_short saved_bank, saved_pointer, mask, status;
+    unsigned int handled = 1;
     char bogus_cnt = INTR_WORK;		/* Work we are willing to do. */
 
     if (!netif_device_present(dev))
-	return;
+	return IRQ_NONE;
+
     ioaddr = dev->base_addr;
 
     DEBUG(3, "%s: SMC91c92 interrupt %d at %#x.\n", dev->name,
@@ -1596,6 +1598,7 @@ static void smc_interrupt(int irq, void 
 	   maybe it has been ejected. */
 	DEBUG(1, "%s: SMC91c92 interrupt %d for non-existent"
 	      "/ejected device.\n", dev->name, irq);
+	handled = 0;
 	goto irq_done;
     }
 
@@ -1609,9 +1612,11 @@ static void smc_interrupt(int irq, void 
 	status = inw(ioaddr + INTERRUPT) & 0xff;
 	DEBUG(3, "%s: Status is %#2.2x (mask %#2.2x).\n", dev->name,
 	      status, mask);
-	if ((status & mask) == 0)
+	if ((status & mask) == 0) {
+	    if (bogus_cnt == INTR_WORK)
+		handled = 0;
 	    break;
-	
+	}
 	if (status & IM_RCV_INT) {
 	    /* Got a packet(s). */
 	    smc_rx(dev);
@@ -1683,6 +1688,7 @@ irq_done:
 	readb(smc->base+MEGAHERTZ_ISR);
     }
 #endif
+    return IRQ_RETVAL(handled);
 }
 
 /*====================================================================*/
Index: linux-2.5/drivers/net/pcmcia/xirc2ps_cs.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/net/pcmcia/xirc2ps_cs.c,v
retrieving revision 1.18
diff -u -p -B -r1.18 xirc2ps_cs.c
--- linux-2.5/drivers/net/pcmcia/xirc2ps_cs.c	29 Apr 2003 22:46:23 -0000	1.18
+++ linux-2.5/drivers/net/pcmcia/xirc2ps_cs.c	4 May 2003 13:10:02 -0000
@@ -317,7 +317,7 @@ static void xirc2ps_detach(dev_link_t *)
  * less on other parts of the kernel.
  */
 
-static void xirc2ps_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t xirc2ps_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 /*
  * The dev_info variable is the "key" that is used to match up this
@@ -1296,7 +1296,7 @@ xirc2ps_event(event_t event, int priorit
 /****************
  * This is the Interrupt service route.
  */
-static void
+static irqreturn_t
 xirc2ps_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
     struct net_device *dev = (struct net_device *)dev_id;
@@ -1305,14 +1305,14 @@ xirc2ps_interrupt(int irq, void *dev_id,
     u_char saved_page;
     unsigned bytes_rcvd;
     unsigned int_status, eth_status, rx_status, tx_status;
-    unsigned rsr, pktlen;
+    unsigned rsr, pktlen, handled = 1;
     ulong start_ticks = jiffies; /* fixme: jiffies rollover every 497 days
 				  * is this something to worry about?
 				  * -- on a laptop?
 				  */
 
     if (!netif_device_present(dev))
-	return;
+	return IRQ_NONE;
 
     ioaddr = dev->base_addr;
     if (lp->mohawk) { /* must disable the interrupt */
@@ -1330,6 +1330,7 @@ xirc2ps_interrupt(int irq, void *dev_id,
   loop_entry:
     if (int_status == 0xff) { /* card may be ejected */
 	DEBUG(3, "%s: interrupt %d for dead card\n", dev->name, irq);
+	handled = 0;
 	goto leave;
     }
     eth_status = GetByte(XIRCREG_ESR);
@@ -1514,6 +1515,7 @@ xirc2ps_interrupt(int irq, void *dev_id,
      * force an interrupt with this command:
      *	  PutByte(XIRCREG_CR, EnableIntr|ForceIntr);
      */
+    return IRQ_RETVAL(handled);
 } /* xirc2ps_interrupt */
 
 /*====================================================================*/

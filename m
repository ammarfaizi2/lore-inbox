Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313581AbSDHIGd>; Mon, 8 Apr 2002 04:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313583AbSDHIGd>; Mon, 8 Apr 2002 04:06:33 -0400
Received: from stingr.net ([212.193.32.15]:39048 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313581AbSDHIG2>;
	Mon, 8 Apr 2002 04:06:28 -0400
Date: Mon, 8 Apr 2002 12:06:22 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][CLEANUP] task->state cleanups part 8
Message-ID: <20020408080622.GO839@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	William Lee Irwin III <wli@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2Marcelo: the whole cleanup tree derived from yours available at
linux-stingr.bkbits.net/taskstate

2others: people says that it is nice patch, howewer it is completely
untested. But I dunno what can be broken such way so ...

This is task->state cleanup. Big part seems to be eaten my Matti Aarnio so
splitted goes below.

If you want to blame me for incorrect using of set instead of __set - feel
free to mail me and point where I should to change. Or mail me a patch.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.317   -> 1.318  
#	drivers/net/wan/cosa.c	1.7     -> 1.8    
#	drivers/mtd/devices/blkmtd.c	1.3     -> 1.4    
#	drivers/net/sb1000.c	1.7     -> 1.8    
#	drivers/net/irda/irport.c	1.9     -> 1.10   
#	drivers/net/irda/irtty.c	1.6     -> 1.7    
#	drivers/net/sis900.c	1.21    -> 1.22   
#	drivers/net/wireless/airport.c	1.7     -> 1.8    
#	drivers/net/tokenring/lanstreamer.c	1.11    -> 1.12   
#	   drivers/net/tun.c	1.7     -> 1.8    
#	drivers/net/mac89x0.c	1.6     -> 1.7    
#	drivers/net/tokenring/ibmtr.c	1.9     -> 1.10   
#	drivers/net/gt96100eth.c	1.4     -> 1.5    
#	drivers/net/cs89x0.c	1.8     -> 1.9    
#	drivers/net/sungem.c	1.24    -> 1.25   
#	drivers/net/wireless/orinoco_plx.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/08	stingray@stingr.net	1.318
# task->state cleanup part 8
# --------------------------------------------
#
diff -Nru a/drivers/mtd/devices/blkmtd.c b/drivers/mtd/devices/blkmtd.c
--- a/drivers/mtd/devices/blkmtd.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/mtd/devices/blkmtd.c	Mon Apr  8 01:23:52 2002
@@ -493,11 +493,11 @@
   if(write_queue_cnt == write_queue_sz) {
     spin_unlock(&mbd_writeq_lock);
     DEBUG(3, "blkmtd: queue_page: Queue full\n");
-    current->state = TASK_UNINTERRUPTIBLE;
+    set_current_state(TASK_UNINTERRUPTIBLE);
     add_wait_queue(&mtbd_sync_wq, &wait);
     wake_up_interruptible(&thr_wq);
     schedule();
-    current->state = TASK_RUNNING;
+    set_current_state(TASK_RUNNING);
     remove_wait_queue(&mtbd_sync_wq, &wait);
     DEBUG(3, "blkmtd: queue_page_write: Queue has %d items in it\n", write_queue_cnt);
     goto test_lock;
@@ -873,12 +873,12 @@
   spin_lock(&mbd_writeq_lock);
   if(write_queue_cnt) {
     spin_unlock(&mbd_writeq_lock);
-    current->state = TASK_UNINTERRUPTIBLE;
+    set_current_state(TASK_UNINTERRUPTIBLE);
     add_wait_queue(&mtbd_sync_wq, &wait);
     DEBUG(3, "blkmtd: sync: waking up task\n");
     wake_up_interruptible(&thr_wq);
     schedule();
-    current->state = TASK_RUNNING;
+    set_current_state(TASK_RUNNING);
     remove_wait_queue(&mtbd_sync_wq, &wait);
     DEBUG(3, "blkmtd: sync: waking up after write task\n");
     goto stuff_inq;
diff -Nru a/drivers/net/cs89x0.c b/drivers/net/cs89x0.c
--- a/drivers/net/cs89x0.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/cs89x0.c	Mon Apr  8 01:23:52 2002
@@ -813,7 +813,7 @@
 	writereg(dev, PP_SelfCTL, readreg(dev, PP_SelfCTL) | POWER_ON_RESET);
 
 	/* wait 30 ms */
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(30*HZ/1000);
 
 	if (lp->chip_type != CS8900) {
diff -Nru a/drivers/net/gt96100eth.c b/drivers/net/gt96100eth.c
--- a/drivers/net/gt96100eth.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/gt96100eth.c	Mon Apr  8 01:23:52 2002
@@ -214,7 +214,7 @@
 	if (in_interrupt())
 		return;
 	else {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(ms*HZ/1000);
 	}
 }
diff -Nru a/drivers/net/irda/irport.c b/drivers/net/irda/irport.c
--- a/drivers/net/irda/irport.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/irda/irport.c	Mon Apr  8 01:23:52 2002
@@ -864,7 +864,7 @@
 	/* Wait until Tx FIFO is empty */
 	while (!(inb(iobase+UART_LSR) & UART_LSR_THRE)) {
 		IRDA_DEBUG(2, __FUNCTION__ "(), waiting!\n");
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(MSECS_TO_JIFFIES(60));
 	}
 }
diff -Nru a/drivers/net/irda/irtty.c b/drivers/net/irda/irtty.c
--- a/drivers/net/irda/irtty.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/irda/irtty.c	Mon Apr  8 01:23:52 2002
@@ -844,7 +844,7 @@
 
 	/* Wait for the requested amount of data to arrive */
 	while (len < self->rx_buff.len) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(MSECS_TO_JIFFIES(10));
 
 		if (!timeout--)
diff -Nru a/drivers/net/mac89x0.c b/drivers/net/mac89x0.c
--- a/drivers/net/mac89x0.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/mac89x0.c	Mon Apr  8 01:23:52 2002
@@ -302,7 +302,7 @@
 	writereg(dev, PP_SelfCTL, readreg(dev, PP_SelfCTL) | POWER_ON_RESET);
 
 	/* wait 30 ms */
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(30*HZ/1000);
 
 	/* Wait until the chip is reset */
diff -Nru a/drivers/net/sb1000.c b/drivers/net/sb1000.c
--- a/drivers/net/sb1000.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/sb1000.c	Mon Apr  8 01:23:52 2002
@@ -280,7 +280,7 @@
 
 static inline void nicedelay(unsigned long usecs)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(HZ);
 	return;
 }
@@ -296,7 +296,7 @@
 	timeout = jiffies + TimeOutJiffies;
 	while (a & 0x80 || a & 0x40) {
 		/* a little sleep */
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(0);
 		a = inb(ioaddr[0] + 7);
 		if (jiffies >= timeout) {
@@ -320,7 +320,7 @@
 	timeout = jiffies + TimeOutJiffies;
 	while (a & 0x80 || !(a & 0x40)) {
 		/* a little sleep */
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(0);
 		a = inb(ioaddr[1] + 6);
 		if (jiffies >= timeout) {
diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/sis900.c	Mon Apr  8 01:23:52 2002
@@ -536,7 +536,7 @@
 
 	if(status & MII_STAT_LINK){
 		while (poll_bit) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(0);
 			poll_bit ^= (mdio_read(net_dev, sis_priv->cur_phy, MII_STATUS) & poll_bit);
 			if (jiffies >= timeout) {
diff -Nru a/drivers/net/sungem.c b/drivers/net/sungem.c
--- a/drivers/net/sungem.c	Mon Apr  8 01:23:53 2002
+++ b/drivers/net/sungem.c	Mon Apr  8 01:23:53 2002
@@ -2150,7 +2150,7 @@
 
 	pmac_call_feature(PMAC_FTR_GMAC_ENABLE, gp->of_node, 0, 1);
 
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout((21 * HZ) / 1000);
 
 	pci_read_config_word(gp->pdev, PCI_COMMAND, &cmd);
diff -Nru a/drivers/net/tokenring/ibmtr.c b/drivers/net/tokenring/ibmtr.c
--- a/drivers/net/tokenring/ibmtr.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/tokenring/ibmtr.c	Mon Apr  8 01:23:52 2002
@@ -840,7 +840,7 @@
 	writeb(~INT_ENABLE, ti->mmio + ACA_OFFSET + ACA_RESET + ISRP_EVEN);
 	outb(0, PIOaddr + ADAPTRESET);
 
-	current->state=TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(TR_RST_TIME); /* wait 50ms */
 
 	outb(0, PIOaddr + ADAPTRESETREL);
@@ -894,7 +894,7 @@
 			DPRINTK("Adapter is up and running\n");
 			return 0;
 		}
-		current->state=TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		i=schedule_timeout(TR_RETRY_INTERVAL); /* wait 30 seconds */
 		if(i!=0) break; /*prob. a signal, like the i>24*HZ case above */
 	}
diff -Nru a/drivers/net/tokenring/lanstreamer.c b/drivers/net/tokenring/lanstreamer.c
--- a/drivers/net/tokenring/lanstreamer.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/tokenring/lanstreamer.c	Mon Apr  8 01:23:52 2002
@@ -438,7 +438,7 @@
 	writew(readw(streamer_mmio + BCTL) | BCTL_SOFTRESET, streamer_mmio + BCTL);
 	t = jiffies;
 	/* Hold soft reset bit for a while */
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ);
 	
 	writew(readw(streamer_mmio + BCTL) & ~BCTL_SOFTRESET,
@@ -493,7 +493,7 @@
 	writew(SISR_MI, streamer_mmio + SISR_MASK_SUM);
 
 	while (!((readw(streamer_mmio + SISR)) & SISR_SRB_REPLY)) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ/10);
 		if (jiffies - t > 40 * HZ) {
 			printk(KERN_ERR
diff -Nru a/drivers/net/tun.c b/drivers/net/tun.c
--- a/drivers/net/tun.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/tun.c	Mon Apr  8 01:23:52 2002
@@ -293,7 +293,7 @@
 
 	add_wait_queue(&tun->read_wait, &wait);
 	while (count) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 
 		/* Read frames from the queue */
 		if (!(skb=skb_dequeue(&tun->readq))) {
@@ -321,7 +321,7 @@
 		break;
 	}
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tun->read_wait, &wait);
 
 	return ret;
diff -Nru a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/wan/cosa.c	Mon Apr  8 01:23:52 2002
@@ -513,10 +513,10 @@
 		 * FIXME: When this code is not used as module, we should
 		 * probably call udelay() instead of the interruptible sleep.
 		 */
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		cosa_putstatus(cosa, SR_TX_INT_ENA);
 		schedule_timeout(30);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		irq = probe_irq_off(irqs);
 		/* Disable all IRQs from the card */
 		cosa_putstatus(cosa, 0);
@@ -803,21 +803,21 @@
 	spin_lock_irqsave(&cosa->lock, flags);
 	add_wait_queue(&chan->rxwaitq, &wait);
 	while(!chan->rx_status) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irqrestore(&cosa->lock, flags);
 		schedule();
 		spin_lock_irqsave(&cosa->lock, flags);
 		if (signal_pending(current) && chan->rx_status == 0) {
 			chan->rx_status = 1;
 			remove_wait_queue(&chan->rxwaitq, &wait);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			spin_unlock_irqrestore(&cosa->lock, flags);
 			up(&chan->rsem);
 			return -ERESTARTSYS;
 		}
 	}
 	remove_wait_queue(&chan->rxwaitq, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	kbuf = chan->rxdata;
 	count = chan->rxsize;
 	spin_unlock_irqrestore(&cosa->lock, flags);
@@ -888,21 +888,21 @@
 	spin_lock_irqsave(&cosa->lock, flags);
 	add_wait_queue(&chan->txwaitq, &wait);
 	while(!chan->tx_status) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irqrestore(&cosa->lock, flags);
 		schedule();
 		spin_lock_irqsave(&cosa->lock, flags);
 		if (signal_pending(current) && chan->tx_status == 0) {
 			chan->tx_status = 1;
 			remove_wait_queue(&chan->txwaitq, &wait);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			chan->tx_status = 1;
 			spin_unlock_irqrestore(&cosa->lock, flags);
 			return -ERESTARTSYS;
 		}
 	}
 	remove_wait_queue(&chan->txwaitq, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	up(&chan->wsem);
 	spin_unlock_irqrestore(&cosa->lock, flags);
 	kfree(kbuf);
@@ -1528,9 +1528,9 @@
 	cosa_getdata8(cosa);
 	cosa_putstatus(cosa, SR_RST);
 #ifdef MODULE
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(HZ/2);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 #else
 	udelay(5*100000);
 #endif
@@ -1583,7 +1583,7 @@
 			return r;
 		}
 		/* sleep if not ready to read */
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 	printk(KERN_INFO "cosa: timeout in get_wait_data (status 0x%x)\n",
@@ -1610,7 +1610,7 @@
 		}
 #if 0
 		/* sleep if not ready to read */
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 #endif
 	}
diff -Nru a/drivers/net/wireless/airport.c b/drivers/net/wireless/airport.c
--- a/drivers/net/wireless/airport.c	Mon Apr  8 01:23:52 2002
+++ b/drivers/net/wireless/airport.c	Mon Apr  8 01:23:52 2002
@@ -225,7 +225,7 @@
 		
 	/* Power up card */
 	pmac_call_feature(PMAC_FTR_AIRPORT_ENABLE, card->node, 0, 1);
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ);
 
 	/* Reset it before we get the interrupt */
@@ -290,7 +290,7 @@
 	release_OF_resource(card->node, 0);
 	
 	pmac_call_feature(PMAC_FTR_AIRPORT_ENABLE, card->node, 0, 0);
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ);
 	
 	kfree(card);
diff -Nru a/drivers/net/wireless/orinoco_plx.c b/drivers/net/wireless/orinoco_plx.c
--- a/drivers/net/wireless/orinoco_plx.c	Mon Apr  8 01:23:53 2002
+++ b/drivers/net/wireless/orinoco_plx.c	Mon Apr  8 01:23:53 2002
@@ -407,7 +407,7 @@
 extern void __exit orinoco_plx_exit(void)
 {
 	pci_unregister_driver(&orinoco_plx_driver);
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ);
 }
 

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4

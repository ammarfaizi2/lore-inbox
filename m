Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263744AbTIBVor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTIBVoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:44:46 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:47067 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S263744AbTIBVoe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:44:34 -0400
Message-ID: <3F54FC95.7080304@terra.com.br>
Date: Tue, 02 Sep 2003 17:24:53 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: rnp@paradise.net.nz
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix SMP support on 3c527 net driver, take 2
Content-Type: multipart/mixed;
 boundary="------------060306080407070505080604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060306080407070505080604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Richard,

	This is second version of the patch (against 2.6-test4) to fix SMP 
support on the 3c527 net driver, by removing cli/sti calls and 
replacing them with local locks.

	This one includes Manfred's idea of using wait_event instead of 
sleep_on, and releasing the lock to prevent the driver from going 
bezerk..it also uses spinlocks, since on some situations we are in 
bottom half context.

	Compiles fine, but I don't have the hardware to test it.

	Could you please see if this works for you?

	Manfred, could you take a look at this too?

	Comments are welcome so can get this fix right,

	Thanks.

Felipe

--------------060306080407070505080604
Content-Type: text/plain;
 name="3c527-cli_sti_removal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3c527-cli_sti_removal.patch"

--- linux-2.6.0-test4/drivers/net/3c527.c	Fri Aug 22 20:56:34 2003
+++ linux-2.6.0-test4-fwd/drivers/net/3c527.c	Tue Sep  2 16:21:47 2003
@@ -17,8 +17,8 @@
  */
 
 #define DRV_NAME		"3c527"
-#define DRV_VERSION		"0.6a"
-#define DRV_RELDATE		"2001/11/17"
+#define DRV_VERSION		"0.6b"
+#define DRV_RELDATE		"2003/09/2"
 
 static const char *version =
 DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " Richard Proctor (rnp@netlink.co.nz)\n";
@@ -100,6 +100,7 @@
 #include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/ethtool.h>
+#include <linux/spinlock.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -157,11 +158,11 @@
 	volatile struct mc32_mailbox *rx_box;
 	volatile struct mc32_mailbox *tx_box;
 	volatile struct mc32_mailbox *exec_box;
-        volatile struct mc32_stats *stats;    /* Start of on-card statistics */
-        u16 tx_chain;           /* Transmit list start offset */
+	volatile struct mc32_stats *stats;    /* Start of on-card statistics */
+	u16 tx_chain;           /* Transmit list start offset */
 	u16 rx_chain;           /* Receive list start offset */
-        u16 tx_len;             /* Transmit list count */ 
-        u16 rx_len;             /* Receive list count */
+	u16 tx_len;             /* Transmit list count */ 
+	u16 rx_len;             /* Receive list count */
 
 	u32 base;
 	u16 exec_pending;
@@ -179,6 +180,7 @@
 	u16 tx_ring_head;       /* index to tx en-queue end */
 
 	u16 rx_ring_tail;       /* index to rx de-queue end */ 
+	spinlock_t lock;
 };
 
 /* The station (ethernet) address prefix, used for a sanity check. */
@@ -197,7 +199,6 @@
 	{ 0x0000, NULL }
 };
 
-
 /* Macros for ring index manipulations */ 
 static inline u16 next_rx(u16 rx) { return (rx+1)&(RX_RING_LEN-1); };
 static inline u16 prev_rx(u16 rx) { return (rx-1)&(RX_RING_LEN-1); };
@@ -536,7 +537,7 @@
  *	command register. This tells us nothing about the completion
  *	status of any pending commands and takes very little time at all.
  */
- 
+
 static void mc32_ready_poll(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
@@ -579,6 +580,24 @@
 	return 0;
 }
 
+/**
+ *	wait_pending - sleep until a field reaches a certain value 
+ *	@lp: m32_local structure describing the target card
+ *
+ *	The caller must acquire lp->lock before calling this function, it
+ *	temporarily drops the lock when it sleeps (SMP-safe).
+ */
+
+static inline void wait_pending(struct mc32_local *lp)
+{
+	DEFINE_WAIT(wait);
+
+	prepare_to_wait(&lp->event, &wait, TASK_UNINTERRUPTIBLE);
+	spin_unlock_irq(&lp->lock);
+	schedule();
+	finish_wait(&lp->event, &wait);
+	spin_lock_irq(&lp->lock);
+}
 
 /**
  *	mc32_command	-	send a command and sleep until completion
@@ -619,14 +638,12 @@
 	int ret = 0;
 	
 	/*
-	 *	Wait for a command
+	 *	Wait until there are no more pending commands
 	 */
 	 
-	save_flags(flags);
-	cli();
-	 
-	while(lp->exec_pending)
-		sleep_on(&lp->event);
+	spin_lock_irqsave(&lp->lock, flags);
+	while (lp->exec_pending)
+		wait_pending(lp);
 		
 	/*
 	 *	Issue mine
@@ -634,7 +651,7 @@
 
 	lp->exec_pending=1;
 	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	
 	lp->exec_box->mbox=0;
 	lp->exec_box->mbox=cmd;
@@ -645,13 +662,11 @@
 	while(!(inb(ioaddr+HOST_STATUS)&HOST_STATUS_CRR));
 	outb(1<<6, ioaddr+HOST_CMD);	
 
-	save_flags(flags);
-	cli();
-
-	while(lp->exec_pending!=2)
-		sleep_on(&lp->event);
+	spin_lock_irqsave(&lp->lock, flags);
+	while (lp->exec_pending != 2)
+		wait_pending (lp);
 	lp->exec_pending=0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lp->lock, flags);
 	
 	if(lp->exec_box->mbox&(1<<13))
 		ret = -1;
@@ -735,15 +750,14 @@
 	outb(HOST_CMD_SUSPND_RX, ioaddr+HOST_CMD);			
 	mc32_ready_poll(dev); 
 	outb(HOST_CMD_SUSPND_TX, ioaddr+HOST_CMD);	
-		
-	save_flags(flags);
-	cli();
-		
+
+	spin_lock_irqsave (&lp->lock, flags);
+
 	while(lp->xceiver_state!=HALTED) 
 		sleep_on(&lp->event); 
-		
-	restore_flags(flags);	
-} 
+
+	spin_unlock_irqrestore (&lp->lock, flags);
+}
 
 
 /**
@@ -1062,12 +1076,11 @@
 
 	netif_stop_queue(dev);
 
-	save_flags(flags);
-	cli();
-		
+	spin_lock_irqsave (&lp->lock, flags);
+
 	if(atomic_read(&lp->tx_count)==0)
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore (&lp->lock, flags);
 		return 1;
 	}
 
@@ -1098,7 +1111,7 @@
 		
 	p->control     &= ~CONTROL_EOL;     /* Clear EOL on p */ 
 out:	
-	restore_flags(flags);
+	spin_unlock_irqrestore (&lp->lock, flags);
 
 	netif_wake_queue(dev);
 	return 0;

--------------060306080407070505080604--


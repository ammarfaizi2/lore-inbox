Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266360AbUGOVPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266360AbUGOVPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUGOVPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:15:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27102 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266360AbUGOVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:15:02 -0400
Date: Thu, 15 Jul 2004 23:14:52 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: hamish@zot.apana.org.au
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/seeq8005.c: fix inline compile error
Message-ID: <20040715211452.GL25633@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile drivers/net/seeq8005.c in 2.6.8-rc1-mm1 using gcc 3.4 
results in the following compile error:

<--  snip  -->

...
  CC      drivers/net/seeq8005.o
drivers/net/seeq8005.c: In function `seeq8005_rx':
drivers/net/seeq8005.c:95: sorry, unimplemented: inlining failed in call to 'wait_for_buffer': function body not available
drivers/net/seeq8005.c:479: sorry, unimplemented: called from here
make[2]: *** [drivers/net/seeq8005.o] Error 1

<--  snip  -->


The patch below moves wait_for_buffer above the place where it is called 
the first time.

An alternative approach would be to remove the inline.


diffstat output:
 drivers/net/seeq8005.c |   45 ++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 23 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-mm1-full-3.4/drivers/net/seeq8005.c.old	2004-07-15 22:59:55.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full-3.4/drivers/net/seeq8005.c	2004-07-15 23:00:46.000000000 +0200
@@ -83,6 +83,7 @@
 static void seeq8005_timeout(struct net_device *dev);
 static int seeq8005_send_packet(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t seeq8005_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static inline void wait_for_buffer(struct net_device *dev);
 static void seeq8005_rx(struct net_device *dev);
 static int seeq8005_close(struct net_device *dev);
 static struct net_device_stats *seeq8005_get_stats(struct net_device *dev);
@@ -92,7 +93,6 @@
 #define tx_done(dev)	(inw(SEEQ_STATUS) & SEEQSTAT_TX_ON)
 static void hardware_send_packet(struct net_device *dev, char *buf, int length);
 extern void seeq8005_init(struct net_device *dev, int startp);
-static inline void wait_for_buffer(struct net_device *dev);
 
 
 /* Check for a network adaptor of this type, and return '0' iff one exists.
@@ -459,6 +459,27 @@
 	return IRQ_RETVAL(handled);
 }
 
+/*
+ * wait_for_buffer
+ *
+ * This routine waits for the SEEQ chip to assert that the FIFO is ready
+ * by checking for a window interrupt, and then clearing it. This has to
+ * occur in the interrupt handler!
+ */
+inline void wait_for_buffer(struct net_device * dev)
+{
+	int ioaddr = dev->base_addr;
+	unsigned long tmp;
+	int status;
+	
+	tmp = jiffies + HZ;
+	while ( ( ((status=inw(SEEQ_STATUS)) & SEEQSTAT_WINDOW_INT) != SEEQSTAT_WINDOW_INT) && time_before(jiffies, tmp))
+		cpu_relax();
+		
+	if ( (status & SEEQSTAT_WINDOW_INT) == SEEQSTAT_WINDOW_INT)
+		outw( SEEQCMD_WINDOW_INT_ACK | (status & SEEQCMD_INT_MASK), SEEQ_CMD);
+}
+	
 /* We have a good packet(s), get it/them out of the buffers. */
 static void seeq8005_rx(struct net_device *dev)
 {
@@ -711,28 +732,6 @@
 	
 }
 
-
-/*
- * wait_for_buffer
- *
- * This routine waits for the SEEQ chip to assert that the FIFO is ready
- * by checking for a window interrupt, and then clearing it. This has to
- * occur in the interrupt handler!
- */
-inline void wait_for_buffer(struct net_device * dev)
-{
-	int ioaddr = dev->base_addr;
-	unsigned long tmp;
-	int status;
-	
-	tmp = jiffies + HZ;
-	while ( ( ((status=inw(SEEQ_STATUS)) & SEEQSTAT_WINDOW_INT) != SEEQSTAT_WINDOW_INT) && time_before(jiffies, tmp))
-		cpu_relax();
-		
-	if ( (status & SEEQSTAT_WINDOW_INT) == SEEQSTAT_WINDOW_INT)
-		outw( SEEQCMD_WINDOW_INT_ACK | (status & SEEQCMD_INT_MASK), SEEQ_CMD);
-}
-	
 #ifdef MODULE
 
 static struct net_device *dev_seeq;


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbTDVLkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 07:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTDVLkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 07:40:43 -0400
Received: from hera.cwi.nl ([192.16.191.8]:59057 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263079AbTDVLki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 07:40:38 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 22 Apr 2003 13:52:41 +0200 (MEST)
Message-Id: <UTC200304221152.h3MBqfv21160.aeb@smtp.cwi.nl>
To: jgarzik@pobox.com, torvalds@transmeta.com
Subject: [PATCH] unsigned long for jiffies use in 3c505
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> compilation fix

> Would you be open to changing your $subject in the future?
> I think it is a bit misleading to call warning fixes "compilation fixes"

As you wish. Of course also warnings need to be fixed.

Below warning fixes for 3c505.[ch], all for arguments
of time_{before,after}.

Andries

--------------------------------------------------------------
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/net/3c505.c b/drivers/net/3c505.c
--- a/drivers/net/3c505.c	Sun Apr 20 12:59:32 2003
+++ b/drivers/net/3c505.c	Tue Apr 22 13:42:49 2003
@@ -259,11 +259,12 @@
 
 static inline int get_status(unsigned int base_addr)
 {
-	int timeout = jiffies + 10*HZ/100;
+	unsigned long timeout = jiffies + 10*HZ/100;
 	register int stat1;
 	do {
 		stat1 = inb_status(base_addr);
-	} while (stat1 != inb_status(base_addr) && time_before(jiffies, timeout));
+	} while (stat1 != inb_status(base_addr) &&
+		 time_before(jiffies, timeout));
 	if (time_after_eq(jiffies, timeout))
 		TIMEOUT_MSG(__LINE__);
 	return stat1;
@@ -283,7 +284,7 @@
 
 inline static void adapter_reset(struct net_device *dev)
 {
-	int timeout;
+	unsigned long timeout;
 	elp_device *adapter = dev->priv;
 	unsigned char orig_hcr = adapter->hcr_val;
 
@@ -322,7 +323,9 @@
 static inline void check_3c505_dma(struct net_device *dev)
 {
 	elp_device *adapter = dev->priv;
-	if (adapter->dmaing && time_after(jiffies, adapter->current_dma.start_time + 10)) {
+
+	if (adapter->dmaing &&
+	    time_after(jiffies, adapter->current_dma.start_time + 10)) {
 		unsigned long flags, f;
 		printk("%s: DMA %s timed out, %d bytes left\n", dev->name, adapter->current_dma.direction ? "download" : "upload", get_dma_residue(dev->dma));
 		spin_lock_irqsave(&adapter->lock, flags);
@@ -343,7 +346,7 @@
 /* Primitive functions used by send_pcb() */
 static inline unsigned int send_pcb_slow(unsigned int base_addr, unsigned char byte)
 {
-	unsigned int timeout;
+	unsigned long timeout;
 	outb_command(byte, base_addr);
 	for (timeout = jiffies + 5*HZ/100; time_before(jiffies, timeout);) {
 		if (inb_status(base_addr) & HCRE)
@@ -402,7 +405,7 @@
 static int send_pcb(struct net_device *dev, pcb_struct * pcb)
 {
 	int i;
-	int timeout;
+	unsigned long timeout;
 	elp_device *adapter = dev->priv;
 	unsigned long flags;
 
@@ -488,7 +491,7 @@
 	int i, j;
 	int total_length;
 	int stat;
-	int timeout;
+	unsigned long timeout;
 	unsigned long flags;
 
 	elp_device *adapter = dev->priv;
@@ -497,7 +500,8 @@
 
 	/* get the command code */
 	timeout = jiffies + 2*HZ/100;
-	while (((stat = get_status(dev->base_addr)) & ACRF) == 0 && time_before(jiffies, timeout));
+	while (((stat = get_status(dev->base_addr)) & ACRF) == 0 &&
+	       time_before(jiffies, timeout));
 	if (time_after_eq(jiffies, timeout)) {
 		TIMEOUT_MSG(__LINE__);
 		return FALSE;
@@ -506,7 +510,8 @@
 
 	/* read the data length */
 	timeout = jiffies + 3*HZ/100;
-	while (((stat = get_status(dev->base_addr)) & ACRF) == 0 && time_before(jiffies, timeout));
+	while (((stat = get_status(dev->base_addr)) & ACRF) == 0 &&
+	       time_before(jiffies, timeout));
 	if (time_after_eq(jiffies, timeout)) {
 		TIMEOUT_MSG(__LINE__);
 		printk("%s: status %02x\n", dev->name, stat);
@@ -669,7 +674,7 @@
 	int icount = 0;
 	struct net_device *dev;
 	elp_device *adapter;
-	int timeout;
+	unsigned long timeout;
 
 	dev = dev_id;
 	adapter = (elp_device *) dev->priv;
@@ -723,10 +728,10 @@
 		 * receive a PCB from the adapter
 		 */
 		timeout = jiffies + 3*HZ/100;
-		while ((inb_status(dev->base_addr) & ACRF) != 0 && time_before(jiffies, timeout)) {
+		while ((inb_status(dev->base_addr) & ACRF) != 0 &&
+		       time_before(jiffies, timeout)) {
 			if (receive_pcb(dev, &adapter->irx_pcb)) {
-				switch (adapter->irx_pcb.command) 
-				{
+				switch (adapter->irx_pcb.command) {
 				case 0:
 					break;
 					/*
@@ -947,8 +952,9 @@
 	if (!send_pcb(dev, &adapter->tx_pcb))
 		printk("%s: couldn't send memory configuration command\n", dev->name);
 	else {
-		int timeout = jiffies + TIMEOUT;
-		while (adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] == 0 && time_before(jiffies, timeout));
+		unsigned long timeout = jiffies + TIMEOUT;
+		while (adapter->got[CMD_CONFIGURE_ADAPTER_MEMORY] == 0 &&
+		       time_before(jiffies, timeout));
 		if (time_after_eq(jiffies, timeout))
 			TIMEOUT_MSG(__LINE__);
 	}
@@ -966,8 +972,9 @@
 	if (!send_pcb(dev, &adapter->tx_pcb))
 		printk("%s: couldn't send 82586 configure command\n", dev->name);
 	else {
-		int timeout = jiffies + TIMEOUT;
-		while (adapter->got[CMD_CONFIGURE_82586] == 0 && time_before(jiffies, timeout));
+		unsigned long timeout = jiffies + TIMEOUT;
+		while (adapter->got[CMD_CONFIGURE_82586] == 0 &&
+		       time_before(jiffies, timeout));
 		if (time_after_eq(jiffies, timeout))
 			TIMEOUT_MSG(__LINE__);
 	}
@@ -1150,8 +1157,9 @@
 	if (!send_pcb(dev, &adapter->tx_pcb))
 		printk("%s: couldn't send get statistics command\n", dev->name);
 	else {
-		int timeout = jiffies + TIMEOUT;
-		while (adapter->got[CMD_NETWORK_STATISTICS] == 0 && time_before(jiffies, timeout));
+		unsigned long timeout = jiffies + TIMEOUT;
+		while (adapter->got[CMD_NETWORK_STATISTICS] == 0 &&
+		       time_before(jiffies, timeout));
 		if (time_after_eq(jiffies, timeout)) {
 			TIMEOUT_MSG(__LINE__);
 			return &adapter->stats;
@@ -1317,8 +1325,9 @@
 		if (!send_pcb(dev, &adapter->tx_pcb))
 			printk("%s: couldn't send set_multicast command\n", dev->name);
 		else {
-			int timeout = jiffies + TIMEOUT;
-			while (adapter->got[CMD_LOAD_MULTICAST_LIST] == 0 && time_before(jiffies, timeout));
+			unsigned long timeout = jiffies + TIMEOUT;
+			while (adapter->got[CMD_LOAD_MULTICAST_LIST] == 0 &&
+			       time_before(jiffies, timeout));
 			if (time_after_eq(jiffies, timeout)) {
 				TIMEOUT_MSG(__LINE__);
 			}
@@ -1344,9 +1353,10 @@
 		printk("%s: couldn't send 82586 configure command\n", dev->name);
 	}
 	else {
-		int timeout = jiffies + TIMEOUT;
+		unsigned long timeout = jiffies + TIMEOUT;
 		spin_unlock_irqrestore(&adapter->lock, flags);
-		while (adapter->got[CMD_CONFIGURE_82586] == 0 && time_before(jiffies, timeout));
+		while (adapter->got[CMD_CONFIGURE_82586] == 0 &&
+		       time_before(jiffies, timeout));
 		if (time_after_eq(jiffies, timeout))
 			TIMEOUT_MSG(__LINE__);
 	}
@@ -1396,10 +1406,8 @@
 
 static int __init elp_sense(struct net_device *dev)
 {
-	int timeout;
 	int addr = dev->base_addr;
 	const char *name = dev->name;
-	unsigned long flags;
 	byte orig_HSR;
 
 	if (!request_region(addr, ELP_IO_EXTENT, "3c505"))
@@ -1506,8 +1514,9 @@
 int __init elplus_probe(struct net_device *dev)
 {
 	elp_device *adapter;
-	int i, tries, tries1, timeout, okay;
+	int i, tries, tries1, okay;
 	unsigned long cookie = 0;
+	unsigned long timeout;
 
 	SET_MODULE_OWNER(dev);
 
@@ -1537,11 +1546,13 @@
 		 */
 		timeout = jiffies + 5*HZ/100;
 		okay = 0;
-		while (time_before(jiffies, timeout) && !(inb_status(dev->base_addr) & HCRE));
+		while (time_before(jiffies, timeout) &&
+		       !(inb_status(dev->base_addr) & HCRE));
 		if ((inb_status(dev->base_addr) & HCRE)) {
 			outb_command(0, dev->base_addr);	/* send a spurious byte */
 			timeout = jiffies + 5*HZ/100;
-			while (time_before(jiffies, timeout) && !(inb_status(dev->base_addr) & HCRE));
+			while (time_before(jiffies, timeout) &&
+			       !(inb_status(dev->base_addr) & HCRE));
 			if (inb_status(dev->base_addr) & HCRE)
 				okay = 1;
 		}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/net/3c505.h b/drivers/net/3c505.h
--- a/drivers/net/3c505.h	Fri Nov 22 22:40:53 2002
+++ b/drivers/net/3c505.h	Tue Apr 22 13:44:54 2003
@@ -279,7 +279,7 @@
 		unsigned int length;
 		struct sk_buff *skb;
 	        void *target;
-		long int start_time;
+		unsigned long start_time;
 	} current_dma;
 
 	/* flags */

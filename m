Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbTISTxr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbTISTwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:52:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:38794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261713AbTISTtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:49:36 -0400
Date: Fri, 19 Sep 2003 12:49:25 -0700
From: Chris Wright <chrisw@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH 7/13] use cpu_relax() in busy loop
Message-ID: <20030919124925.C27079@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net> <20030918163311.I16499@osdlab.pdx.osdl.net> <20030918163408.J16499@osdlab.pdx.osdl.net> <20030918163523.K16499@osdlab.pdx.osdl.net> <1063957044.5394.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1063957044.5394.7.camel@laptop.fenrus.com>; from arjanv@redhat.com on Fri, Sep 19, 2003 at 09:37:25AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 7/13] use cpu_relax() in busy loop, or mdelay instead of busy loop
                                                                                
Replace busy loop nop with cpu_relax(), and just use mdelay where it's better.
                                                                                
These look ok?
-chris

===== drivers/net/3c501.c 1.19 vs edited =====
--- 1.19/drivers/net/3c501.c	Tue Aug 26 13:21:28 2003
+++ edited/drivers/net/3c501.c	Fri Sep 19 11:06:57 2003
@@ -123,6 +123,7 @@
 #include <linux/config.h>	/* for CONFIG_IP_MULTICAST */
 #include <linux/spinlock.h>
 #include <linux/ethtool.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -241,7 +242,7 @@
 
 	if (dev->irq < 2)
 	{
-		unsigned long irq_mask, delay;
+		unsigned long irq_mask;
 
 		irq_mask = probe_irq_on();
 		inb(RX_STATUS);		/* Clear pending interrupts. */
@@ -250,8 +251,7 @@
 
 		outb(0x00, AX_CMD);
 
-		delay = jiffies + HZ/50;
-		while (time_before(jiffies, delay)) ;
+		mdelay(20);
 		autoirq = probe_irq_off(irq_mask);
 
 		if (autoirq == 0)
===== drivers/net/3c505.c 1.25 vs edited =====
--- 1.25/drivers/net/3c505.c	Tue Aug 26 13:29:32 2003
+++ edited/drivers/net/3c505.c	Fri Sep 19 11:13:10 2003
@@ -298,17 +298,13 @@
 		set_hsf(dev, HSF_PCB_NAK);
 	}
 	outb_control(adapter->hcr_val | ATTN | DIR, dev);
-	timeout = jiffies + 1*HZ/100;
-	while (time_before_eq(jiffies, timeout));
+	mdelay(10);
 	outb_control(adapter->hcr_val & ~ATTN, dev);
-	timeout = jiffies + 1*HZ/100;
-	while (time_before_eq(jiffies, timeout));
+	mdelay(10);
 	outb_control(adapter->hcr_val | FLSH, dev);
-	timeout = jiffies + 1*HZ/100;
-	while (time_before_eq(jiffies, timeout));
+	mdelay(10);
 	outb_control(adapter->hcr_val & ~FLSH, dev);
-	timeout = jiffies + 1*HZ/100;
-	while (time_before_eq(jiffies, timeout));
+	mdelay(10);
 
 	outb_control(orig_hcr, dev);
 	if (!start_receive(dev, &adapter->tx_pcb))
===== drivers/net/acenic.c 1.39 vs edited =====
--- 1.39/drivers/net/acenic.c	Thu Sep  4 00:36:29 2003
+++ edited/drivers/net/acenic.c	Fri Sep 19 11:38:34 2003
@@ -1757,7 +1757,8 @@
 	 * Wait for the firmware to spin up - max 3 seconds.
 	 */
 	myjif = jiffies + 3 * HZ;
-	while (time_before(jiffies, myjif) && !ap->fw_running);
+	while (time_before(jiffies, myjif) && !ap->fw_running)
+		cpu_relax();
 
 	if (!ap->fw_running) {
 		printk(KERN_ERR "%s: Firmware NOT running!\n", dev->name);
===== drivers/net/eepro.c 1.19 vs edited =====
--- 1.19/drivers/net/eepro.c	Tue Jul 15 10:01:29 2003
+++ edited/drivers/net/eepro.c	Fri Sep 19 11:18:47 2003
@@ -897,14 +897,12 @@
 		eepro_sw2bank0(ioaddr); /* Switch back to Bank 0 */
 
 		if (request_irq (*irqp, NULL, SA_SHIRQ, "bogus", dev) != EBUSY) {
-			unsigned long irq_mask, delay;
+			unsigned long irq_mask;
 			/* Twinkle the interrupt, and check if it's seen */
 			irq_mask = probe_irq_on();
 
 			eepro_diag(ioaddr); /* RESET the 82595 */
-
-			delay = jiffies + HZ/50;
-			while (time_before(jiffies, delay)) ;
+			mdelay(20);
 
 			if (*irqp == probe_irq_off(irq_mask))  /* It's a good IRQ line */
 				break;
===== drivers/net/ewrk3.c 1.26 vs edited =====
--- 1.26/drivers/net/ewrk3.c	Tue Aug 19 20:53:15 2003
+++ edited/drivers/net/ewrk3.c	Fri Sep 19 11:21:50 2003
@@ -564,7 +564,7 @@
 								if (dev->irq < 2) {
 #ifndef MODULE
 									u_char irqnum;
-									unsigned long irq_mask, delay;
+									unsigned long irq_mask;
 			
 
 									irq_mask = probe_irq_on();
@@ -578,8 +578,7 @@
 
 									irqnum = irq[((icr & IRQ_SEL) >> 4)];
 
-									delay = jiffies + HZ/50;
-									while (time_before(jiffies, delay)) ;
+									mdelay(20);
 									dev->irq = probe_irq_off(irq_mask);
 									if ((dev->irq) && (irqnum == dev->irq)) {
 										printk(" and uses IRQ%d.\n", dev->irq);
===== drivers/net/lance.c 1.18 vs edited =====
--- 1.18/drivers/net/lance.c	Sun Apr 20 22:41:09 2003
+++ edited/drivers/net/lance.c	Fri Sep 19 11:25:56 2003
@@ -543,7 +543,7 @@
 	if (dev->irq >= 2)
 		printk(" assigned IRQ %d", dev->irq);
 	else if (lance_version != 0)  {	/* 7990 boards need DMA detection first. */
-		unsigned long irq_mask, delay;
+		unsigned long irq_mask;
 
 		/* To auto-IRQ we enable the initialization-done and DMA error
 		   interrupts. For ISA boards we get a DMA error, but VLB and PCI
@@ -553,8 +553,7 @@
 		/* Trigger an initialization just for the interrupt. */
 		outw(0x0041, ioaddr+LANCE_DATA);
 
-		delay = jiffies + HZ/50;
-		while (time_before(jiffies, delay)) ;
+		mdelay(20);
 		dev->irq = probe_irq_off(irq_mask);
 		if (dev->irq)
 			printk(", probed IRQ %d", dev->irq);
@@ -621,13 +620,12 @@
 	if (lance_version == 0 && dev->irq == 0) {
 		/* We may auto-IRQ now that we have a DMA channel. */
 		/* Trigger an initialization just for the interrupt. */
-		unsigned long irq_mask, delay;
+		unsigned long irq_mask;
 
 		irq_mask = probe_irq_on();
 		outw(0x0041, ioaddr+LANCE_DATA);
 
-		delay = jiffies + HZ/25;
-		while (time_before(jiffies, delay)) ;
+		mdelay(40);
 		dev->irq = probe_irq_off(irq_mask);
 		if (dev->irq == 0) {
 			printk("  Failed to detect the 7990 IRQ line.\n");
===== drivers/net/ni5010.c 1.11 vs edited =====
--- 1.11/drivers/net/ni5010.c	Sun Aug 31 16:14:15 2003
+++ edited/drivers/net/ni5010.c	Fri Sep 19 11:27:11 2003
@@ -255,14 +255,13 @@
 	if (dev->irq == 0xff)
 		;
 	else if (dev->irq < 2) {
-		unsigned long irq_mask, delay;
+		unsigned long irq_mask;
 
 		PRINTK2((KERN_DEBUG "%s: I/O #5 passed!\n", dev->name));
 
 		irq_mask = probe_irq_on();
 		trigger_irq(ioaddr);
-		delay = jiffies + HZ/50;
-		while (time_before(jiffies, delay)) ;
+		mdelay(20);
 		dev->irq = probe_irq_off(irq_mask);
 
 		PRINTK2((KERN_DEBUG "%s: I/O #6 passed!\n", dev->name));
===== drivers/net/ni52.c 1.11 vs edited =====
--- 1.11/drivers/net/ni52.c	Sun Apr 20 23:00:41 2003
+++ edited/drivers/net/ni52.c	Fri Sep 19 11:29:49 2003
@@ -492,14 +492,13 @@
 
 	if(dev->irq < 2)
 	{
-		unsigned long irq_mask, delay;
+		unsigned long irq_mask;
 
 		irq_mask = probe_irq_on();
 		ni_reset586();
 		ni_attn586();
 
-		delay = jiffies + HZ/50;
-		while (time_before(jiffies, delay)) ;
+		mdelay(20);
 		dev->irq = probe_irq_off(irq_mask);
 		if(!dev->irq)
 		{
===== drivers/net/rrunner.c 1.21 vs edited =====
--- 1.21/drivers/net/rrunner.c	Tue Aug 19 20:53:16 2003
+++ edited/drivers/net/rrunner.c	Fri Sep 19 11:38:50 2003
@@ -721,7 +721,8 @@
 	 * Give the FirmWare time to chew on the `get running' command.
 	 */
 	myjif = jiffies + 5 * HZ;
-	while (time_before(jiffies, myjif) && !rrpriv->fw_running);
+	while (time_before(jiffies, myjif) && !rrpriv->fw_running)
+		cpu_relax();
 
 	netif_start_queue(dev);
 
===== drivers/net/wan/sbni.c 1.22 vs edited =====
--- 1.22/drivers/net/wan/sbni.c	Thu Sep  4 00:40:48 2003
+++ edited/drivers/net/wan/sbni.c	Fri Sep 19 11:32:45 2003
@@ -53,6 +53,7 @@
 #include <linux/skbuff.h>
 #include <linux/timer.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <net/arp.h>
 
@@ -337,13 +338,12 @@
 	outb( 0, ioaddr + CSR0 );
 
 	if( irq < 2 ) {
-		unsigned long irq_mask, delay;
+		unsigned long irq_mask;
 
 		irq_mask = probe_irq_on();
 		outb( EN_INT | TR_REQ, ioaddr + CSR0 );
 		outb( PR_RES, ioaddr + CSR1 );
-		delay = jiffies + HZ/20;
-		while (time_before(jiffies, delay)) ;
+		mdelay(50);
 		irq = probe_irq_off(irq_mask);
 		outb( 0, ioaddr + CSR0 );
 
===== drivers/net/wd.c 1.12 vs edited =====
--- 1.12/drivers/net/wd.c	Thu Nov 21 14:06:13 2002
+++ edited/drivers/net/wd.c	Fri Sep 19 11:34:22 2003
@@ -235,7 +235,7 @@
 		int reg4 = inb(ioaddr+4);
 		if (ancient || reg1 == 0xff) {	/* Ack!! No way to read the IRQ! */
 			short nic_addr = ioaddr+WD_NIC_OFFSET;
-			unsigned long irq_mask, delay;
+			unsigned long irq_mask;
 
 			/* We have an old-style ethercard that doesn't report its IRQ
 			   line.  Do autoirq to find the IRQ line. Note that this IS NOT
@@ -248,8 +248,7 @@
 			outb_p(0x00, nic_addr + EN0_RCNTLO);
 			outb_p(0x00, nic_addr + EN0_RCNTHI);
 			outb(E8390_RREAD+E8390_START, nic_addr); /* Trigger it... */
-			delay = jiffies + HZ/50;
-			while (time_before(jiffies, delay)) ;
+			mdelay(20);
 			dev->irq = probe_irq_off(irq_mask);
 			
 			outb_p(0x00, nic_addr+EN0_IMR);	/* Mask all intrs. again. */

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTIRXgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbTIRXgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:36:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:48344 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262197AbTIRXfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:35:25 -0400
Date: Thu, 18 Sep 2003 16:35:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, torvalds@osdl.org
Subject: [PATCH 7/13] use cpu_relax() in busy loop
Message-ID: <20030918163523.K16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net> <20030918163311.I16499@osdlab.pdx.osdl.net> <20030918163408.J16499@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030918163408.J16499@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 18, 2003 at 04:34:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace busy loop nop with cpu_relax().

Jeff, here's a batch for net drivers.  They all look pretty straight
forward.

===== drivers/net/3c501.c 1.19 vs edited =====
--- 1.19/drivers/net/3c501.c	Tue Aug 26 13:21:28 2003
+++ edited/drivers/net/3c501.c	Thu Sep 18 11:30:18 2003
@@ -251,7 +251,8 @@
 		outb(0x00, AX_CMD);
 
 		delay = jiffies + HZ/50;
-		while (time_before(jiffies, delay)) ;
+		while (time_before(jiffies, delay))
+			cpu_relax();
 		autoirq = probe_irq_off(irq_mask);
 
 		if (autoirq == 0)
===== drivers/net/3c505.c 1.25 vs edited =====
--- 1.25/drivers/net/3c505.c	Tue Aug 26 13:29:32 2003
+++ edited/drivers/net/3c505.c	Thu Sep 18 11:32:26 2003
@@ -299,16 +299,20 @@
 	}
 	outb_control(adapter->hcr_val | ATTN | DIR, dev);
 	timeout = jiffies + 1*HZ/100;
-	while (time_before_eq(jiffies, timeout));
+	while (time_before_eq(jiffies, timeout))
+		cpu_relax();
 	outb_control(adapter->hcr_val & ~ATTN, dev);
 	timeout = jiffies + 1*HZ/100;
-	while (time_before_eq(jiffies, timeout));
+	while (time_before_eq(jiffies, timeout))
+		cpu_relax();
 	outb_control(adapter->hcr_val | FLSH, dev);
 	timeout = jiffies + 1*HZ/100;
-	while (time_before_eq(jiffies, timeout));
+	while (time_before_eq(jiffies, timeout))
+		cpu_relax();
 	outb_control(adapter->hcr_val & ~FLSH, dev);
 	timeout = jiffies + 1*HZ/100;
-	while (time_before_eq(jiffies, timeout));
+	while (time_before_eq(jiffies, timeout))
+		cpu_relax();
 
 	outb_control(orig_hcr, dev);
 	if (!start_receive(dev, &adapter->tx_pcb))
===== drivers/net/acenic.c 1.39 vs edited =====
--- 1.39/drivers/net/acenic.c	Thu Sep  4 00:36:29 2003
+++ edited/drivers/net/acenic.c	Thu Sep 18 11:33:14 2003
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
+++ edited/drivers/net/eepro.c	Thu Sep 18 11:33:52 2003
@@ -904,7 +904,8 @@
 			eepro_diag(ioaddr); /* RESET the 82595 */
 
 			delay = jiffies + HZ/50;
-			while (time_before(jiffies, delay)) ;
+			while (time_before(jiffies, delay))
+				cpu_relax();
 
 			if (*irqp == probe_irq_off(irq_mask))  /* It's a good IRQ line */
 				break;
===== drivers/net/ewrk3.c 1.26 vs edited =====
--- 1.26/drivers/net/ewrk3.c	Tue Aug 19 20:53:15 2003
+++ edited/drivers/net/ewrk3.c	Thu Sep 18 11:34:50 2003
@@ -579,7 +579,8 @@
 									irqnum = irq[((icr & IRQ_SEL) >> 4)];
 
 									delay = jiffies + HZ/50;
-									while (time_before(jiffies, delay)) ;
+									while (time_before(jiffies, delay))
+										cpu_relax();
 									dev->irq = probe_irq_off(irq_mask);
 									if ((dev->irq) && (irqnum == dev->irq)) {
 										printk(" and uses IRQ%d.\n", dev->irq);
===== drivers/net/lance.c 1.18 vs edited =====
--- 1.18/drivers/net/lance.c	Sun Apr 20 22:41:09 2003
+++ edited/drivers/net/lance.c	Thu Sep 18 11:37:30 2003
@@ -554,7 +554,8 @@
 		outw(0x0041, ioaddr+LANCE_DATA);
 
 		delay = jiffies + HZ/50;
-		while (time_before(jiffies, delay)) ;
+		while (time_before(jiffies, delay))
+			cpu_relax();
 		dev->irq = probe_irq_off(irq_mask);
 		if (dev->irq)
 			printk(", probed IRQ %d", dev->irq);
@@ -627,7 +628,8 @@
 		outw(0x0041, ioaddr+LANCE_DATA);
 
 		delay = jiffies + HZ/25;
-		while (time_before(jiffies, delay)) ;
+		while (time_before(jiffies, delay))
+			cpu_relax();
 		dev->irq = probe_irq_off(irq_mask);
 		if (dev->irq == 0) {
 			printk("  Failed to detect the 7990 IRQ line.\n");
===== drivers/net/ni5010.c 1.11 vs edited =====
--- 1.11/drivers/net/ni5010.c	Sun Aug 31 16:14:15 2003
+++ edited/drivers/net/ni5010.c	Thu Sep 18 11:40:18 2003
@@ -262,7 +262,8 @@
 		irq_mask = probe_irq_on();
 		trigger_irq(ioaddr);
 		delay = jiffies + HZ/50;
-		while (time_before(jiffies, delay)) ;
+		while (time_before(jiffies, delay))
+			cpu_relax();
 		dev->irq = probe_irq_off(irq_mask);
 
 		PRINTK2((KERN_DEBUG "%s: I/O #6 passed!\n", dev->name));
===== drivers/net/ni52.c 1.11 vs edited =====
--- 1.11/drivers/net/ni52.c	Sun Apr 20 23:00:41 2003
+++ edited/drivers/net/ni52.c	Thu Sep 18 11:42:57 2003
@@ -499,7 +499,8 @@
 		ni_attn586();
 
 		delay = jiffies + HZ/50;
-		while (time_before(jiffies, delay)) ;
+		while (time_before(jiffies, delay))
+			cpu_relax();
 		dev->irq = probe_irq_off(irq_mask);
 		if(!dev->irq)
 		{
===== drivers/net/rrunner.c 1.21 vs edited =====
--- 1.21/drivers/net/rrunner.c	Tue Aug 19 20:53:16 2003
+++ edited/drivers/net/rrunner.c	Thu Sep 18 11:44:53 2003
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
+++ edited/drivers/net/wan/sbni.c	Thu Sep 18 11:29:36 2003
@@ -343,7 +343,8 @@
 		outb( EN_INT | TR_REQ, ioaddr + CSR0 );
 		outb( PR_RES, ioaddr + CSR1 );
 		delay = jiffies + HZ/20;
-		while (time_before(jiffies, delay)) ;
+		while (time_before(jiffies, delay))
+			cpu_relax();
 		irq = probe_irq_off(irq_mask);
 		outb( 0, ioaddr + CSR0 );
 
===== drivers/net/wd.c 1.12 vs edited =====
--- 1.12/drivers/net/wd.c	Thu Nov 21 14:06:13 2002
+++ edited/drivers/net/wd.c	Thu Sep 18 11:45:49 2003
@@ -249,7 +249,8 @@
 			outb_p(0x00, nic_addr + EN0_RCNTHI);
 			outb(E8390_RREAD+E8390_START, nic_addr); /* Trigger it... */
 			delay = jiffies + HZ/50;
-			while (time_before(jiffies, delay)) ;
+			while (time_before(jiffies, delay))
+				cpu_relax();
 			dev->irq = probe_irq_off(irq_mask);
 			
 			outb_p(0x00, nic_addr+EN0_IMR);	/* Mask all intrs. again. */


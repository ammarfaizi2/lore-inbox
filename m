Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289170AbSAMMrO>; Sun, 13 Jan 2002 07:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289171AbSAMMrF>; Sun, 13 Jan 2002 07:47:05 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:12385 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289170AbSAMMqx>; Sun, 13 Jan 2002 07:46:53 -0500
Date: Sun, 13 Jan 2002 12:46:50 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.18-pre3: fix PLIP
Message-ID: <20020113124650.O31314@redhat.com>
In-Reply-To: <20020111233009.29852.qmail@web20207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020111233009.29852.qmail@web20207.mail.yahoo.com>; from vasvir@yahoo.gr on Fri, Jan 11, 2002 at 03:30:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This patch from Niels fixes the problem with PLIP.

Tim.
*/

--- linux/drivers/parport/parport_pc.c.ecr2	Sun Jan 13 12:44:52 2002
+++ linux/drivers/parport/parport_pc.c	Sun Jan 13 12:45:08 2002
@@ -128,7 +128,6 @@
 static int change_mode(struct parport *p, int m)
 {
 	const struct parport_pc_private *priv = p->physport->private_data;
-	int ecr = ECONTROL(p);
 	unsigned char oecr;
 	int mode;
 
@@ -140,7 +139,7 @@
 	}
 
 	/* Bits <7:5> contain the mode. */
-	oecr = inb (ecr);
+	oecr = inb (ECONTROL (p));
 	mode = (oecr >> 5) & 0x7;
 	if (mode == m) return 0;
 
@@ -631,7 +630,7 @@
 			/* FIFO is full. Wait for interrupt. */
 
 			/* Clear serviceIntr */
-			outb (ecrval & ~(1<<2), ECONTROL (port));
+			ECR_WRITE (port, ecrval & ~(1<<2));
 		false_alarm:
 			ret = parport_wait_event (port, HZ);
 			if (ret < 0) break;
@@ -859,7 +858,7 @@
 		printk (KERN_DEBUG "%s: FIFO is stuck\n", port->name);
 
 		/* Prevent further data transfer. */
-		frob_econtrol (port, 0xe0, ECR_TST << 5);
+		frob_set_mode (port, ECR_TST);
 
 		/* Adjust for the contents of the FIFO. */
 		for (written -= priv->fifo_depth; ; written++) {
@@ -956,7 +955,7 @@
 		printk (KERN_DEBUG "%s: FIFO is stuck\n", port->name);
 
 		/* Prevent further data transfer. */
-		frob_econtrol (port, 0xe0, ECR_TST << 5);
+		frob_set_mode (port, ECR_TST);
 
 		/* Adjust for the contents of the FIFO. */
 		for (written -= priv->fifo_depth; ; written++) {
@@ -1135,7 +1134,7 @@
 			}
 
 			/* Clear serviceIntr */
-			outb (ecrval & ~(1<<2), ECONTROL (port));
+			ECR_WRITE (port, ecrval & ~(1<<2));
 		false_alarm:
 dump_parport_state ("waiting", port);
 			ret = parport_wait_event (port, HZ);
@@ -1738,7 +1737,7 @@
 	if ((inb (ECONTROL (pb)) & 0x3 ) != 0x1)
 		goto no_reg;
 
-	outb (0x34, ECONTROL (pb));
+	ECR_WRITE (pb, 0x34);
 	if (inb (ECONTROL (pb)) != 0x35)
 		goto no_reg;
 
@@ -1816,8 +1815,8 @@
 		return 0;
 
 	/* Find out FIFO depth */
-	frob_set_mode (pb, ECR_SPP); /* Reset FIFO */
-	frob_set_mode (pb, ECR_TST); /* TEST FIFO */
+	ECR_WRITE (pb, ECR_SPP << 5); /* Reset FIFO */
+	ECR_WRITE (pb, ECR_TST << 5); /* TEST FIFO */
 	for (i=0; i < 1024 && !(inb (ECONTROL (pb)) & 0x02); i++)
 		outb (0xaa, FIFO (pb));
 
@@ -1826,7 +1825,7 @@
 	 * it doesn't support ECP or FIFO MODE
 	 */
 	if (i == 1024) {
-		frob_set_mode (pb, ECR_SPP);
+		ECR_WRITE (pb, ECR_SPP << 5);
 		return 0;
 	}
 
@@ -1877,8 +1876,8 @@
 
 	priv->readIntrThreshold = i;
 
-	frob_set_mode (pb, ECR_SPP); /* Reset FIFO */
-	outb (0xf4, ECONTROL (pb)); /* Configuration mode */
+	ECR_WRITE (pb, ECR_SPP << 5); /* Reset FIFO */
+	ECR_WRITE (pb, 0xf4); /* Configuration mode */
 	config = inb (CONFIGA (pb));
 	pword = (config >> 4) & 0x7;
 	switch (pword) {
@@ -1939,7 +1938,7 @@
 		return 0;
 
 	oecr = inb (ECONTROL (pb));
-	frob_set_mode (pb, ECR_PS2);
+	ECR_WRITE (pb, ECR_PS2 << 5);
 	result = parport_PS2_supported(pb);
 	ECR_WRITE (pb, oecr);
 	return result;
@@ -1972,8 +1971,8 @@
 	/* Check for Intel bug. */
 	if (priv->ecr) {
 		unsigned char i;
-		for (i = 0; i < 4; i++) {
-			frob_set_mode (pb, i);
+		for (i = 0x00; i < 0x80; i += 0x20) {
+			ECR_WRITE (pb, i);
 			if (clear_epp_timeout (pb)) {
 				/* Phony EPP in ECP. */
 				return 0;
@@ -2004,7 +2003,7 @@
 
 	oecr = inb (ECONTROL (pb));
 	/* Search for SMC style EPP+ECP mode */
-	frob_set_mode (pb, ECR_EPP);
+	ECR_WRITE (pb, 0x80);
 	outb (0x04, CONTROL (pb));
 	result = parport_EPP_supported(pb);
 
@@ -2045,7 +2044,7 @@
 		PARPORT_IRQ_NONE, 7, 9, 10, 11, 14, 15, 5
 	};
 
-	frob_set_mode (pb, ECR_CNF); /* Configuration MODE */
+	ECR_WRITE (pb, ECR_CNF << 5); /* Configuration MODE */
 
 	intrLine = (inb (CONFIGB (pb)) >> 3) & 0x07;
 	irq = lookup[intrLine];
@@ -2062,16 +2061,16 @@
 	sti();
 	irqs = probe_irq_on();
 		
-	frob_set_mode (pb, ECR_SPP); /* Reset FIFO */
-	frob_econtrol (pb, ECR_MODE_MASK | 0x04, (ECR_TST << 5) | 0x04);
-	frob_set_mode (pb, ECR_TST);
+	ECR_WRITE (pb, ECR_SPP << 5); /* Reset FIFO */
+	ECR_WRITE (pb, (ECR_TST << 5) | 0x04);
+	ECR_WRITE (pb, ECR_TST << 5);
 
 	/* If Full FIFO sure that writeIntrThreshold is generated */
 	for (i=0; i < 1024 && !(inb (ECONTROL (pb)) & 0x02) ; i++) 
 		outb (0xaa, FIFO (pb));
 		
 	pb->irq = probe_irq_off(irqs);
-	frob_set_mode (pb, ECR_SPP);
+	ECR_WRITE (pb, ECR_SPP << 5);
 
 	if (pb->irq <= 0)
 		pb->irq = PARPORT_IRQ_NONE;
--- linux/drivers/parport/ChangeLog.ecr2	Sun Jan 13 12:44:52 2002
+++ linux/drivers/parport/ChangeLog	Sun Jan 13 12:45:08 2002
@@ -1,3 +1,8 @@
+2002-01-13  Niels Kristian Bech Jensen  <nkbj@image.dk>
+
+	* parport_pc.c: Change some occurrences of frob_set_mode to
+	ECR_WRITE.  This fixes PLIP.
+
 2002-01-04  Tim Waugh  <twaugh@redhat.com>
 
 	* share.c (parport_claim_or_block): Sleep interruptibly to prevent

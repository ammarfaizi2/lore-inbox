Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281218AbRKEQcA>; Mon, 5 Nov 2001 11:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281217AbRKEQbu>; Mon, 5 Nov 2001 11:31:50 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:51958 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281215AbRKEQbj>;
	Mon, 5 Nov 2001 11:31:39 -0500
Date: Sat, 3 Nov 2001 19:27:42 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, becker@scyld.com, p_gortmaker@yahoo.com
Subject: [PATCH] ne2k-pci jiffies cleanup
Message-ID: <20011103192741.G12523@lynx.no>
Mail-Followup-To: torvalds@transmeta.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	becker@scyld.com, p_gortmaker@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more cleanups of jiffies wrap problems, nothing unusual (includes a
couple of long line reformats, and moving jiffies calcs outside the loop).

Cheers, Andreas
===========================================================================
--- linux.orig/drivers/net/ne2k-pci.c	Thu Oct 25 02:02:09 2001
+++ linux/drivers/net/ne2k-pci.c	Sat Nov  3 19:08:50 2001
@@ -268,17 +268,18 @@
 
 	/* Reset card. Who knows what dain-bramaged state it was left in. */
 	{
-		unsigned long reset_start_time = jiffies;
+		unsigned long reset_end_time = jiffies + 2;
 
 		outb(inb(ioaddr + NE_RESET), ioaddr + NE_RESET);
 
-		/* This looks like a horrible timing loop, but it should never take
-		   more than a few cycles.
-		*/
+		/* This looks like a horrible timing loop, but it should never
+		 * take more than a few cycles.
+		 */
 		while ((inb(ioaddr + EN0_ISR) & ENISR_RESET) == 0)
-			/* Limit wait: '2' avoids jiffy roll-over. */
-			if (jiffies - reset_start_time > 2) {
-				printk(KERN_ERR PFX "Card failure (no reset ack).\n");
+			/* Limit wait */
+			if (time_after(jiffies, reset_end_time)) {
+				printk(KERN_ERR PFX
+				       "Card failure (no reset ack).\n");
 				goto err_out_free_netdev;
 			}
 
@@ -417,10 +418,10 @@
    8390 reset command required, but that shouldn't be necessary. */
 static void ne2k_pci_reset_8390(struct net_device *dev)
 {
-	unsigned long reset_start_time = jiffies;
+	unsigned long reset_end_time = jiffies + 2;
 
-	if (debug > 1) printk("%s: Resetting the 8390 t=%ld...",
-						  dev->name, jiffies);
+	if (debug > 1)
+		printk("%s: Resetting the 8390 t=%ld...", dev->name, jiffies);
 
 	outb(inb(NE_BASE + NE_RESET), NE_BASE + NE_RESET);
 
@@ -429,8 +430,9 @@
 
 	/* This check _should_not_ be necessary, omit eventually. */
 	while ((inb(NE_BASE+EN0_ISR) & ENISR_RESET) == 0)
-		if (jiffies - reset_start_time > 2) {
-			printk("%s: ne2k_pci_reset_8390() did not complete.\n", dev->name);
+		if (time_after(jiffies, reset_end_time)) {
+			printk("%s: ne2k_pci_reset_8390() did not complete.\n",
+			       dev->name);
 			break;
 		}
 	outb(ENISR_RESET, NE_BASE + EN0_ISR);	/* Ack intr. */
@@ -524,7 +526,7 @@
 				  const unsigned char *buf, const int start_page)
 {
 	long nic_base = NE_BASE;
-	unsigned long dma_start;
+	unsigned long dma_end;
 
 	/* On little-endian it's always safe to round the count up for
 	   word writes. */
@@ -575,11 +577,12 @@
 		}
 	}
 
-	dma_start = jiffies;
+	dma_end = jiffies + 2;
 
 	while ((inb(nic_base + EN0_ISR) & ENISR_RDC) == 0)
-		if (jiffies - dma_start > 2) {			/* Avoid clock roll-over. */
-			printk(KERN_WARNING "%s: timeout waiting for Tx RDC.\n", dev->name);
+		if (time_after(jiffies, dma_end)) {
+			printk(KERN_WARNING "%s: timeout waiting for Tx RDC.\n",
+			       dev->name);
 			ne2k_pci_reset_8390(dev);
 			NS8390_init(dev,1);
 			break;
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


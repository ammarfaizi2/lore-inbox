Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUHMTHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUHMTHO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUHMTFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:05:21 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:54493 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S266825AbUHMS7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:59:17 -0400
Message-ID: <411D0F4F.1080203@ttnet.net.tr>
Date: Fri, 13 Aug 2004 21:58:23 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] applicom fixes from 2.6
Content-Type: multipart/mixed;
	boundary="------------040008080201040206090502"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040008080201040206090502
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: quoted-printable

Leak and copy*user in cli fixes from 2.6
(by akpm iirc).

=D6zkan Sezer


--------------040008080201040206090502
Content-Type: text/plain;
	name="applicom.c-2.6-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="applicom.c-2.6-fixes.diff"

--- 27rc5~/drivers/char/applicom.c	2002-08-03 03:39:43.000000000 +0300
+++ 27rc5/drivers/char/applicom.c	2004-08-07 15:52:02.000000000 +0300
@@ -222,6 +222,7 @@
 
 		if (!RamIO) {
 			printk(KERN_INFO "ac.o: Failed to ioremap PCI memory space at 0x%lx\n", PCI_BASE_ADDRESS(dev));
+			pci_disable_device(dev);
 			return -EIO;
 		}
 
@@ -233,12 +234,14 @@
 						  (unsigned long)RamIO,0))) {
 			printk(KERN_INFO "ac.o: PCI Applicom device doesn't have correct signature.\n");
 			iounmap(RamIO);
+			pci_disable_device(dev);
 			continue;
 		}
 
 		if (request_irq(dev->irq, &ac_interrupt, SA_SHIRQ, "Applicom PCI", &dummy)) {
 			printk(KERN_INFO "Could not allocate IRQ %d for PCI Applicom device.\n", dev->irq);
 			iounmap(RamIO);
+			pci_disable_device(dev);
 			apbs[boardno - 1].RamIO = 0;
 			continue;
 		}
@@ -265,12 +268,6 @@
 
 	/* Now try the specified ISA cards */
 
-#warning "LEAK"
-	RamIO = ioremap(mem, LEN_RAM_IO * MAX_ISA_BOARD);
-
-	if (!RamIO) 
-		printk(KERN_INFO "ac.o: Failed to ioremap ISA memory space at 0x%lx\n", mem);
-
 	for (i = 0; i < MAX_ISA_BOARD; i++) {
 		RamIO = ioremap(mem + (LEN_RAM_IO * i), LEN_RAM_IO);
 
@@ -293,7 +290,8 @@
 				iounmap((void *) RamIO);
 				apbs[boardno - 1].RamIO = 0;
 			}
-			apbs[boardno - 1].irq = irq;
+			else
+				apbs[boardno - 1].irq = irq;
 		}
 		else
 			apbs[boardno - 1].irq = 0;
@@ -368,7 +366,7 @@
 	if (count != sizeof(struct st_ram_io) + sizeof(struct mailbox)) {
 		static int warncount = 5;
 		if (warncount) {
-			printk(KERN_INFO "Hmmm. write() of Applicom card, length %d != expected %d\n",
+			printk(KERN_INFO "Hmmm. write() of Applicom card, length %zd != expected %zd\n",
 			       count, sizeof(struct st_ram_io) + sizeof(struct mailbox));
 			warncount--;
 		}
@@ -476,18 +474,17 @@
 	return 0;
 }
 
-static int do_ac_read(int IndexCard, char *buf)
+static int do_ac_read(int IndexCard, char *buf,
+		struct st_ram_io *st_loc, struct mailbox *mailbox)
 {
-	struct st_ram_io st_loc;
-	struct mailbox tmpmailbox;	/* bounce buffer - can't copy to user space with cli() */
 	unsigned long from = (unsigned long)apbs[IndexCard].RamIO + RAM_TO_PC;
-	unsigned char *to = (unsigned char *)&tmpmailbox;
+	unsigned char *to = (unsigned char *)&mailbox;
 #ifdef DEBUG
 	int c;
 #endif
 
-	st_loc.tic_owner_to_pc = readb(apbs[IndexCard].RamIO + TIC_OWNER_TO_PC);
-	st_loc.numcard_owner_to_pc = readb(apbs[IndexCard].RamIO + NUMCARD_OWNER_TO_PC);
+	st_loc->tic_owner_to_pc = readb(apbs[IndexCard].RamIO + TIC_OWNER_TO_PC);
+	st_loc->numcard_owner_to_pc = readb(apbs[IndexCard].RamIO + NUMCARD_OWNER_TO_PC);
 
 
 	{
@@ -510,32 +507,24 @@
 		printk("Read from applicom card #%d. struct st_ram_io follows:", NumCard);
 
 		for (c = 0; c < sizeof(struct st_ram_io);) {
-			printk("\n%5.5X: %2.2X", c, ((unsigned char *) &st_loc)[c]);
+			printk("\n%5.5X: %2.2X", c, ((unsigned char *)st_loc)[c]);
 
 			for (c++; c % 8 && c < sizeof(struct st_ram_io); c++) {
-				printk(" %2.2X", ((unsigned char *) &st_loc)[c]);
+				printk(" %2.2X", ((unsigned char *)st_loc)[c]);
 			}
 		}
 
 		printk("\nstruct mailbox follows:");
 
 		for (c = 0; c < sizeof(struct mailbox);) {
-			printk("\n%5.5X: %2.2X", c, ((unsigned char *) &tmpmailbox)[c]);
+			printk("\n%5.5X: %2.2X", c, ((unsigned char *)mailbox)[c]);
 
 			for (c++; c % 8 && c < sizeof(struct mailbox); c++) {
-				printk(" %2.2X", ((unsigned char *) &tmpmailbox)[c]);
+				printk(" %2.2X", ((unsigned char *)mailbox)[c]);
 			}
 		}
 		printk("\n");
 #endif
-
-#warning "Je suis stupide. DW. - copy*user in cli"
-
-	if (copy_to_user(buf, &st_loc, sizeof(struct st_ram_io)))
-		return -EFAULT;
-	if (copy_to_user(&buf[sizeof(struct st_ram_io)], &tmpmailbox, sizeof(struct mailbox)))
-		return -EFAULT;
-
 	return (sizeof(struct st_ram_io) + sizeof(struct mailbox));
 }
 
@@ -551,7 +540,7 @@
 #endif
 	/* No need to ratelimit this. Only root can trigger it anyway */
 	if (count != sizeof(struct st_ram_io) + sizeof(struct mailbox)) {
-		printk( KERN_WARNING "Hmmm. read() of Applicom card, length %d != expected %d\n",
+		printk( KERN_WARNING "Hmmm. read() of Applicom card, length %zd != expected %zd\n",
 			count,sizeof(struct st_ram_io) + sizeof(struct mailbox));
 		return -EINVAL;
 	}
@@ -570,11 +559,19 @@
 			tmp = readb(apbs[i].RamIO + DATA_TO_PC_READY);
 			
 			if (tmp == 2) {
+				struct st_ram_io st_loc;
+				struct mailbox mailbox;
+
 				/* Got a packet for us */
-				ret = do_ac_read(i, buf);
+				ret = do_ac_read(i, buf, &st_loc, &mailbox);
 				spin_unlock_irqrestore(&apbs[i].mutex, flags);
 				set_current_state(TASK_RUNNING);
 				remove_wait_queue(&FlagSleepRec, &wait);
+
+				if (copy_to_user(buf, &st_loc, sizeof(st_loc)))
+					return -EFAULT;
+				if (copy_to_user(buf + sizeof(st_loc), &mailbox, sizeof(mailbox)))
+					return -EFAULT;
 				return tmp;
 			}
 			


--------------040008080201040206090502--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbTFXBim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 21:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265623AbTFXBil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 21:38:41 -0400
Received: from remt28.cluster1.charter.net ([209.225.8.38]:41144 "EHLO
	remt28.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S265619AbTFXBi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 21:38:27 -0400
Subject: [PATCH] 2.5.73: drivers/char/ip2main.c
From: Josh Boyer <jwboyer@charter.net>
To: torvalds@transmeta.com
Cc: mhw@wittsend.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1056419552.3662.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2003 20:52:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch for the Computone Intelliport mulitiport driver against
2.5.73.  Fixed the compile error.  Also changed cli() calls to
spin_lock_irqsave/spin_unlock_irqrestore.  

Thx,
josh


--- linux-2.5.73.orig/drivers/char/ip2main.c	2003-06-22
13:33:36.000000000 -0500
+++ linux-2.5.73/drivers/char/ip2main.c	2003-06-23 20:39:17.000000000
-0500
@@ -114,6 +114,7 @@
 #include <linux/cdk.h>
 #include <linux/comstats.h>
 #include <linux/delay.h>
+#include <linux/spinlock.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -707,40 +708,42 @@
 				} 
 			} 
 #else /* LINUX_VERSION_CODE > 2.1.99 */
-			struct pci_dev *pci_dev_i = NULL;
-			pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
-						  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
-			if (pci_dev_i != NULL) {
-				unsigned int addr;
-				unsigned char pci_irq;
-
-				ip2config.type[i] = PCI;
-				status =
-				pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
-				if ( addr & 1 ) {
-					ip2config.addr[i]=(USHORT)(addr&0xfffe);
-				} else {
-					printk( KERN_ERR "IP2: PCI I/O address error\n");
-				}
-				status =
-				pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
+			{
+				struct pci_dev *pci_dev_i = NULL;
+				pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
+						PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
+				if (pci_dev_i != NULL) {
+					unsigned int addr;
+					unsigned char pci_irq;
 
-//		If the PCI BIOS assigned it, lets try and use it.  If we
-//		can't acquire it or it screws up, deal with it then.
+					ip2config.type[i] = PCI;
+					status =
+						pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
+					if ( addr & 1 ) {
+						ip2config.addr[i]=(USHORT)(addr&0xfffe);
+					} else {
+						printk( KERN_ERR "IP2: PCI I/O address error\n");
+					}
+					status =
+						pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
 
-//				if (!is_valid_irq(pci_irq)) {
-//					printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
-//					pci_irq = 0;
-//				}
-				ip2config.irq[i] = pci_irq;
-			} else {	// ann error
-				ip2config.addr[i] = 0;
-				if (status == PCIBIOS_DEVICE_NOT_FOUND) {
-					printk( KERN_ERR "IP2: PCI board %d not found\n", i );
-				} else {
-					pcibios_strerror(status);
+					//	If the PCI BIOS assigned it, lets try and use it.  If we
+					//	can't acquire it or it screws up, deal with it then.
+
+					//	if (!is_valid_irq(pci_irq)) {
+					//		printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
+					//		pci_irq = 0;
+					//	}
+					ip2config.irq[i] = pci_irq;
+				} else {	// ann error
+					ip2config.addr[i] = 0;
+					if (status == PCIBIOS_DEVICE_NOT_FOUND) {
+						printk( KERN_ERR "IP2: PCI board %d not found\n", i );
+					} else {
+						pcibios_strerror(status);
+					}
 				}
-			} 
+			}
 #endif	/* ! 2_0_X */
 #else
 			printk( KERN_ERR "IP2: PCI card specified but PCI support not\n");
@@ -2101,6 +2104,7 @@
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct *p_cuser;	/* user space */
 	int rc = 0;
+	spinlock_t lock = SPIN_LOCK_UNLOCKED;
 	unsigned long flags;
 
 	if ( pCh == NULL ) {
@@ -2265,9 +2269,9 @@
 	 * for masking). Caller should use TIOCGICOUNT to see which one it was
 	 */
 	case TIOCMIWAIT:
-		save_flags(flags);cli();
+		spin_lock_irqsave(&lock, flags);
 		cprev = pCh->icount;	 /* note the counters on entry */
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock, flags);
 		i2QueueCommands(PTYPE_BYPASS, pCh, 100, 4, 
 						CMD_DCD_REP, CMD_CTS_REP, CMD_DSR_REP, CMD_RI_REP);
 		init_waitqueue_entry(&wait, current);
@@ -2287,9 +2291,9 @@
 				rc = -ERESTARTSYS;
 				break;
 			}
-			save_flags(flags);cli();
+			spin_lock_irqsave(&lock, flags);
 			cnow = pCh->icount; /* atomic copy */
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock, flags);
 			if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr &&
 				cnow.dcd == cprev.dcd && cnow.cts == cprev.cts) {
 				rc =  -EIO; /* no change => rc */
@@ -2327,9 +2331,9 @@
 	case TIOCGICOUNT:
 		ip2trace (CHANN, ITRC_IOCTL, 11, 1, rc );
 
-		save_flags(flags);cli();
+		spin_lock_irqsave(&lock, flags);
 		cnow = pCh->icount;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock, flags);
 		p_cuser = (struct serial_icounter_struct *) arg;
 		PUT_USER(rc,cnow.cts, &p_cuser->cts);
 		PUT_USER(rc,cnow.dsr, &p_cuser->dsr);




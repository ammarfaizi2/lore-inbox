Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271428AbRHPEXg>; Thu, 16 Aug 2001 00:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271430AbRHPEX0>; Thu, 16 Aug 2001 00:23:26 -0400
Received: from trained-monkey.org ([209.217.122.11]:31224 "EHLO
	savage.trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271428AbRHPEXK>; Thu, 16 Aug 2001 00:23:10 -0400
Date: Thu, 16 Aug 2001 00:21:23 -0400
Message-Id: <200108160421.f7G4LNJ19413@savage.trained-monkey.org>
From: <jes@trained-monkey.org>
To: linux@3ware.com
CC: alan@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [patch] 3Ware 64 bit locking issues
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The 3Ware driver was using 32 bit data types for cpu flags arguments
to spin_lock_irqsave which isn't safe. Here is a patch, which also
gets rid of the redundant flag saving in one instance in the interrupt
handler where the flags had just been saved anyway.

I also noticed that the driver does spin_lock() in the error handling
functions, without disabling interrupts on the local cpu. Is this
safe? Ie. are the error handling functions guaranteed to be called
from interrupt context or with interrupts disabled? Note that I didn't
make any changes to this bit.

Jes

--- drivers/scsi/3w-xxxx.c~	Wed Jun 27 20:10:55 2001
+++ drivers/scsi/3w-xxxx.c	Thu Aug 16 00:17:00 2001
@@ -1202,15 +1202,14 @@
 	int do_attention_interrupt=0;
 	int do_host_interrupt=0;
 	int do_command_interrupt=0;
-	int flags = 0;
-	int flags2 = 0;
+	unsigned long flags = 0;
 	TW_Command *command_packet;
 	if (test_and_set_bit(TW_IN_INTR, &tw_dev->flags))
 		return;
 	spin_lock_irqsave(&io_request_lock, flags);
 
 	if (tw_dev->tw_pci_dev->irq == irq) {
-		spin_lock_irqsave(&tw_dev->tw_lock, flags2);
+		spin_lock(&tw_dev->tw_lock);
 		dprintk(KERN_NOTICE "3w-xxxx: tw_interrupt()\n");
 
 		/* Read the registers */
@@ -1349,7 +1348,7 @@
 				}
 			}
 		}
-		spin_unlock_irqrestore(&tw_dev->tw_lock, flags2);
+		spin_unlock(&tw_dev->tw_lock);
 	}
 	spin_unlock_irqrestore(&io_request_lock, flags);
 	clear_bit(TW_IN_INTR, &tw_dev->flags);
@@ -1918,7 +1917,7 @@
 	unsigned char *command = SCpnt->cmnd;
 	int request_id = 0;
 	int error = 0;
-	int flags = 0;
+	unsigned long flags = 0;
 	TW_Device_Extension *tw_dev = (TW_Device_Extension *)SCpnt->host->hostdata;
 
 	if (tw_dev == NULL) {

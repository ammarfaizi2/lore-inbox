Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbSIWXma>; Mon, 23 Sep 2002 19:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261470AbSIWXma>; Mon, 23 Sep 2002 19:42:30 -0400
Received: from transport.cksoft.de ([62.111.66.27]:44043 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S261460AbSIWXmZ>; Mon, 23 Sep 2002 19:42:25 -0400
Date: Tue, 24 Sep 2002 01:40:01 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: linux-kernel@vger.kernel.org
Cc: patch@zabbadoz.net
Subject: [PATCH] sym53c416 2.5-bk cli() replacement
Message-ID: <Pine.BSF.4.44.0209240136340.13460-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

tried to remove cli() from sym53c416 driver. please review. Patch
should cleanly apply against latest BK-2.5.


--- linux-20020923-211332/drivers/scsi/sym53c416.c.orig	Mon Sep 23 23:10:59 2002
+++ linux-20020923-211332/drivers/scsi/sym53c416.c	Mon Sep 23 22:18:32 2002
@@ -180,6 +180,8 @@
 #define READ_TIMEOUT              150
 #define WRITE_TIMEOUT             150

+#define SG_ADDRESS(buffer)	((char *) (page_address((buffer)->page)+(buffer)->offset))
+
 #ifdef MODULE

 #define sym53c416_base sym53c416
@@ -246,6 +248,8 @@
 	outb((len & 0xFF0000) >> 16, base + TC_HIGH);
 }

+static spinlock_t sym53c416_lock = SPIN_LOCK_UNLOCKED;
+
 /* Returns the number of bytes read */
 static __inline__ unsigned int sym53c416_read(int base, unsigned char *buffer, unsigned int len)
 {
@@ -256,8 +260,7 @@
 	int timeout = READ_TIMEOUT;

 	/* Do transfer */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&sym53c416_lock, flags);
 	while(len && timeout)
 	{
 		bytes_left = inb(base + PIO_FIFO_CNT); /* Number of bytes in the PIO FIFO */
@@ -276,17 +279,16 @@
 		else
 		{
 			i = jiffies + timeout;
-			restore_flags(flags);
+			spin_unlock_irqrestore(&sym53c416_lock, flags);
 			while(jiffies < i && (inb(base + PIO_INT_REG) & EMPTY) && timeout)
 				if(inb(base + PIO_INT_REG) & SCI)
 					timeout = 0;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&sym53c416_lock, flags);
 			if(inb(base + PIO_INT_REG) & EMPTY)
 				timeout = 0;
 		}
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&sym53c416_lock, flags);
 	return orig_len - len;
 }

@@ -300,8 +302,7 @@
 	unsigned int timeout = WRITE_TIMEOUT;

 	/* Do transfer */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&sym53c416_lock, flags);
 	while(len && timeout)
 	{
 		bufferfree = PIO_SIZE - inb(base + PIO_FIFO_CNT);
@@ -322,16 +323,15 @@
 		else
 		{
 			i = jiffies + timeout;
-			restore_flags(flags);
+			spin_unlock_irqrestore(&sym53c416_lock, flags);
 			while(jiffies < i && (inb(base + PIO_INT_REG) & FULL) && timeout)
 				;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&sym53c416_lock, flags);
 			if(inb(base + PIO_INT_REG) & FULL)
 				timeout = 0;
 		}
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&sym53c416_lock, flags);
 	return orig_len - len;
 }

@@ -449,7 +449,7 @@
 					sglist = current_command->request_buffer;
 					while(sgcount--)
 					{
-						tot_trans += sym53c416_write(base, sglist->address, sglist->length);
+						tot_trans += sym53c416_write(base, SG_ADDRESS(sglist), sglist->length);
 						sglist++;
 					}
 				}
@@ -475,7 +475,7 @@
 					sglist = current_command->request_buffer;
 					while(sgcount--)
 					{
-						tot_trans += sym53c416_read(base, sglist->address, sglist->length);
+						tot_trans += sym53c416_read(base, SG_ADDRESS(sglist), sglist->length);
 						sglist++;
 					}
 				}
@@ -716,13 +716,12 @@
 				shpnt = scsi_register(tpnt, 0);
 				if(shpnt==NULL)
 					continue;
-				save_flags(flags);
-				cli();
+				spin_lock_irqsave(&sym53c416_lock, flags);
 				/* FIXME: Request_irq with CLI is not safe */
 				/* Request for specified IRQ */
 				if(request_irq(hosts[i].irq, sym53c416_intr_handle, 0, ID, shpnt))
 				{
-					restore_flags(flags);
+					spin_unlock_irqrestore(&sym53c416_lock, flags);
 					printk(KERN_ERR "sym53c416: Unable to assign IRQ %d\n", hosts[i].irq);
 					scsi_unregister(shpnt);
 				}
@@ -737,7 +736,7 @@
 					shpnt->this_id = hosts[i].scsi_id;
 					sym53c416_init(hosts[i].base, hosts[i].scsi_id);
 					count++;
-					restore_flags(flags);
+					spin_unlock_irqrestore(&sym53c416_lock, flags);
 				}
 			}
 		}
@@ -774,8 +773,7 @@
 	current_command->SCp.Status = 0;
 	current_command->SCp.Message = 0;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&sym53c416_lock, flags);
 	outb(SCpnt->target, base + DEST_BUS_ID); /* Set scsi id target        */
 	outb(FLUSH_FIFO, base + COMMAND_REG);    /* Flush SCSI and PIO FIFO's */
 	/* Write SCSI command into the SCSI fifo */
@@ -784,7 +782,7 @@
 	/* Start selection sequence */
 	outb(SEL_WITHOUT_ATN_SEQ, base + COMMAND_REG);
 	/* Now an interrupt will be generated which we will catch in out interrupt routine */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&sym53c416_lock, flags);
 	return 0;
 }


-- 
Greetings

Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262047AbSJITJZ>; Wed, 9 Oct 2002 15:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262050AbSJITJZ>; Wed, 9 Oct 2002 15:09:25 -0400
Received: from transport.cksoft.de ([62.111.66.27]:23568 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S262047AbSJITJL>; Wed, 9 Oct 2002 15:09:11 -0400
Date: Wed, 9 Oct 2002 19:06:41 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch] SCSI sym53c416 (&isapnp) [1/2]
Message-ID: <Pine.BSF.4.44.0210091853510.717-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this one removes cli()s and adds another chip with ISAPnP support.
Autoconfig still fails here but I suspect this to be another prob.
Perhaps this is s.th. for -ac first.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.717, 2002-10-09 14:20:59+00:00, bzeeb@zabbadoz.net
  sym53c416.c:
    SCSI: Added another card with ISAPnP support to sym53c416
  isapnp.h:
    PNP: add more designated initializers to ISAPNP_DEVICE_SINGLE_END
  sym53c416.c:
    SCSI: initial irq locking fixes in sym53c416


 drivers/scsi/sym53c416.c |  113 ++++++++++++++++++++++-------------------------
 include/linux/isapnp.h   |    2
 2 files changed, 55 insertions(+), 60 deletions(-)


diff -Nru a/drivers/scsi/sym53c416.c b/drivers/scsi/sym53c416.c
--- a/drivers/scsi/sym53c416.c	Wed Oct  9 14:23:46 2002
+++ b/drivers/scsi/sym53c416.c	Wed Oct  9 14:23:46 2002
@@ -9,6 +9,8 @@
  *  Alan Cox <alan@redhat.com> : Cleaned up code formatting
  *				 Fixed an irq locking bug
  *				 Added ISAPnP support
+ *  Bjoern A. Zeeb <bzeeb@zabbadoz.net> : Initial irq locking updates
+ *					  Added another card with ISAPnP support
  *
  *  LILO command line usage: sym53c416=<PORTBASE>[,<IRQ>]
  *
@@ -27,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/init.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>
@@ -194,18 +197,10 @@

 #endif

-/* #define DEBUG */
-
-/* Macro for debugging purposes */
-
-#ifdef DEBUG
-#define DEB(x) x
-#else
-#define DEB(x)
-#endif
-
 #define MAXHOSTS 4

+#define SG_ADDRESS(buffer)     ((char *) (page_address((buffer)->page)+(buffer)->offset))
+
 enum phases
 {
 	idle,
@@ -246,6 +241,8 @@
 	outb((len & 0xFF0000) >> 16, base + TC_HIGH);
 }

+static spinlock_t sym53c416_lock = SPIN_LOCK_UNLOCKED;
+
 /* Returns the number of bytes read */
 static __inline__ unsigned int sym53c416_read(int base, unsigned char *buffer, unsigned int len)
 {
@@ -256,8 +253,7 @@
 	int timeout = READ_TIMEOUT;

 	/* Do transfer */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&sym53c416_lock, flags);
 	while(len && timeout)
 	{
 		bytes_left = inb(base + PIO_FIFO_CNT); /* Number of bytes in the PIO FIFO */
@@ -276,17 +272,16 @@
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

@@ -300,8 +295,7 @@
 	unsigned int timeout = WRITE_TIMEOUT;

 	/* Do transfer */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&sym53c416_lock, flags);
 	while(len && timeout)
 	{
 		bufferfree = PIO_SIZE - inb(base + PIO_FIFO_CNT);
@@ -322,16 +316,15 @@
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

@@ -449,7 +442,7 @@
 					sglist = current_command->request_buffer;
 					while(sgcount--)
 					{
-						tot_trans += sym53c416_write(base, sglist->address, sglist->length);
+						tot_trans += sym53c416_write(base, SG_ADDRESS(sglist), sglist->length);
 						sglist++;
 					}
 				}
@@ -475,7 +468,7 @@
 					sglist = current_command->request_buffer;
 					while(sgcount--)
 					{
-						tot_trans += sym53c416_read(base, sglist->address, sglist->length);
+						tot_trans += sym53c416_read(base, SG_ADDRESS(sglist), sglist->length);
 						sglist++;
 					}
 				}
@@ -562,7 +555,7 @@
 	i = jiffies + 20;
 	while(i > jiffies && !(inb(base + STATUS_REG) & SCI))
 		barrier();
-	if(i <= jiffies) /* timed out */
+	if(time_before_eq(i, jiffies))	/* timed out */
 		return 0;
 	/* Get occurred irq */
 	irq = probe_irq_off(irqs);
@@ -611,10 +604,12 @@
 }


-static struct isapnp_device_id id_table[] = {
+static struct isapnp_device_id id_table[] __devinitdata = {
+	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
+		ISAPNP_VENDOR('S','L','I'), ISAPNP_FUNCTION(0x4161), 0 },
 	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('S','L','I'), ISAPNP_FUNCTION(0x4163), 0 },
-	{0}
+	{	ISAPNP_DEVICE_SINGLE_END }
 };

 MODULE_DEVICE_TABLE(isapnp, id_table);
@@ -635,7 +630,7 @@
 	}
 }

-int sym53c416_detect(Scsi_Host_Template *tpnt)
+int __init sym53c416_detect(Scsi_Host_Template *tpnt)
 {
 	unsigned long flags;
 	struct Scsi_Host * shpnt = NULL;
@@ -674,29 +669,31 @@
 #endif
 	printk(KERN_INFO "sym53c416.c: %s\n", VERSION_STRING);

-	while((idev=isapnp_find_dev(NULL, ISAPNP_VENDOR('S','L','I'),
-				ISAPNP_FUNCTION(0x4163), idev))!=NULL)
-	{
-		int i[3];
-
-		if(idev->prepare(idev)<0)
-		{
-			printk(KERN_WARNING "sym53c416: unable to prepare PnP card.\n");
-			continue;
-		}
-		if(idev->activate(idev)<0)
-		{
-			printk(KERN_WARNING "sym53c416: unable to activate PnP card.\n");
-			continue;
+	for (i=0; id_table[i].vendor != 0; i++) {
+		while((idev=isapnp_find_dev(NULL, id_table[i].vendor,
+					id_table[i].function, idev))!=NULL)
+		{
+			int i[3];
+
+			if(idev->prepare(idev)<0)
+			{
+				printk(KERN_WARNING "sym53c416: unable to prepare PnP card.\n");
+				continue;
+			}
+			if(idev->activate(idev)<0)
+			{
+				printk(KERN_WARNING "sym53c416: unable to activate PnP card.\n");
+				continue;
+			}
+
+			i[0] = 2;
+			i[1] = idev->resource[0].start;
+			i[2] = idev->irq_resource[0].start;
+
+			printk(KERN_INFO "sym53c416: ISAPnP card found and configured at 0x%X, IRQ %d.\n",
+				i[1], i[2]);
+			sym53c416_setup(NULL, i);
 		}
-
-		i[0] = 2;
-		i[1] = idev->resource[0].start;
-		i[2] = idev->irq_resource[0].start;
-
-		printk(KERN_INFO "sym53c416: ISAPnP card found and configured at 0x%X, IRQ %d.\n",
-			i[1], i[2]);
-		sym53c416_setup(NULL, i);
 	}
 	sym53c416_probe();

@@ -716,13 +713,12 @@
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
@@ -737,7 +733,7 @@
 					shpnt->this_id = hosts[i].scsi_id;
 					sym53c416_init(hosts[i].base, hosts[i].scsi_id);
 					count++;
-					restore_flags(flags);
+					spin_unlock_irqrestore(&sym53c416_lock, flags);
 				}
 			}
 		}
@@ -774,8 +770,7 @@
 	current_command->SCp.Status = 0;
 	current_command->SCp.Message = 0;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&sym53c416_lock, flags);
 	outb(SCpnt->target, base + DEST_BUS_ID); /* Set scsi id target        */
 	outb(FLUSH_FIFO, base + COMMAND_REG);    /* Flush SCSI and PIO FIFO's */
 	/* Write SCSI command into the SCSI fifo */
@@ -784,7 +779,7 @@
 	/* Start selection sequence */
 	outb(SEL_WITHOUT_ATN_SEQ, base + COMMAND_REG);
 	/* Now an interrupt will be generated which we will catch in out interrupt routine */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&sym53c416_lock, flags);
 	return 0;
 }

@@ -804,7 +799,7 @@

 static int sym53c416_abort(Scsi_Cmnd *SCpnt)
 {
-	//printk("sym53c416_abort\n");
+	/* printk("sym53c416_abort\n"); */
 	/* We don't know how to abort for the moment */
 	return SCSI_ABORT_SNOOZE;
 }
@@ -815,7 +810,7 @@
 	int scsi_id = -1;
 	int i;

-	//printk("sym53c416_reset\n");
+	/* printk("sym53c416_reset\n"); */
 	base = SCpnt->host->io_port;
 	/* search scsi_id */
 	for(i = 0; i < host_index && scsi_id != -1; i++)
diff -Nru a/include/linux/isapnp.h b/include/linux/isapnp.h
--- a/include/linux/isapnp.h	Wed Oct  9 14:23:46 2002
+++ b/include/linux/isapnp.h	Wed Oct  9 14:23:46 2002
@@ -154,7 +154,7 @@
 		.card_vendor = ISAPNP_VENDOR(_cva, _cvb, _cvc), .card_device =  ISAPNP_DEVICE(_cdevice), \
 		.vendor = ISAPNP_VENDOR(_dva, _dvb, _dvc), .function = ISAPNP_FUNCTION(_dfunction)
 #define ISAPNP_DEVICE_SINGLE_END \
-		.card_vendor = 0, .card_device = 0
+		.card_vendor = 0, .card_device = 0, .vendor = 0, .function = 0, .driver_data = 0

 struct isapnp_device_id {
 	unsigned short card_vendor, card_device;

===================================================================


This BitKeeper patch contains the following changesets:
1.717
## Wrapped with gzip_uu ##


begin 664 bkpatch601
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
A506#18HFRU^\H@F+WA7E1=>)7=]W"='_`V[M[HE7$P``
`
end

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/


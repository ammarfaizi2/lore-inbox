Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWBYQUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWBYQUE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWBYQUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:20:04 -0500
Received: from rtr.ca ([64.26.128.89]:62676 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964771AbWBYQUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:20:01 -0500
Message-ID: <440083B4.3030307@rtr.ca>
Date: Sat, 25 Feb 2006 11:20:04 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: David Greaves <david@dgreaves.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com>
In-Reply-To: <440040B4.8030808@dgreaves.com>
Content-Type: multipart/mixed;
 boundary="------------040508050805070107090902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040508050805070107090902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Greaves wrote:
..
> Thanks Mark - I've finally gotten this patch applied.
> 
> With smartd disabled and no smart commands issued, a readonly badblocks
> scan of /dev/sdb2 shows no problems and now gives:
> Feb 25 10:38:31 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
> Error }
> Feb 25 10:38:32 haze kernel: ata2: no sense translation for op=0x28
> status: 0x51
> Feb 25 10:38:32 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
> Error }
> Feb 25 10:38:35 haze kernel: ata2: no sense translation for op=0x28
> status: 0x51
> hundreds of times.
..

Mmmm.. okay, it's happening due to a SCSI READ_10 opcode,
which means it isn't being triggered by any of the FUA stuff.

But there's still no obvious reason for the error.
The drive is basically just saying "command rejected",
and libata-scsi is translating that into "medium error"
for some unknown reason.

Unfortunately, the design of the current libata is such that
we no longer have access to the actual ATA opcode that was rejected.
It gets overwritten by the returned drive status on completion.

So.. I need to generate another patch for you now, to save/show
the real ATA opcode that was used to cause the errors.
My theory is that we'll discover that it is one that your drive
legitimately is rejecting (unsupported LBA48 or something..).

But we won't know until we see the output.

Second patch is attached:  apply *in addition* to the first one.

Cheers


--------------040508050805070107090902
Content-Type: text/x-patch;
 name="12_libata_ata_opcode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="12_libata_ata_opcode.patch"

--- linux/drivers/scsi/libata-core.c.orig	2006-02-23 16:15:52.000000000 -0500
+++ linux/drivers/scsi/libata-core.c	2006-02-25 11:17:42.000000000 -0500
@@ -253,10 +253,11 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-static void ata_exec_command_pio(struct ata_port *ap, const struct ata_taskfile *tf)
+static void ata_exec_command_pio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
 
+	tf->saved_command = tf->command;
        	outb(tf->command, ap->ioaddr.command_addr);
 	ata_pause(ap);
 }
@@ -274,10 +275,11 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-static void ata_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf)
+static void ata_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
 
+	tf->saved_command = tf->command;
        	writeb(tf->command, (void __iomem *) ap->ioaddr.command_addr);
 	ata_pause(ap);
 }
@@ -294,7 +296,7 @@
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
-void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
+void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	if (ap->flags & ATA_FLAG_MMIO)
 		ata_exec_command_mmio(ap, tf);
@@ -316,7 +318,7 @@
  */
 
 static inline void ata_tf_to_host(struct ata_port *ap,
-				  const struct ata_taskfile *tf)
+				  struct ata_taskfile *tf)
 {
 	ap->ops->tf_load(ap, tf);
 	ap->ops->exec_command(ap, tf);
@@ -506,12 +508,13 @@
  *	Inherited from caller.
  */
 
-void ata_tf_to_fis(const struct ata_taskfile *tf, u8 *fis, u8 pmp)
+void ata_tf_to_fis(struct ata_taskfile *tf, u8 *fis, u8 pmp)
 {
 	fis[0] = 0x27;	/* Register - Host to Device FIS */
 	fis[1] = (pmp & 0xf) | (1 << 7); /* Port multiplier number,
 					    bit 7 indicates Command FIS */
 	fis[2] = tf->command;
+	tf->saved_command = tf->command;
 	fis[3] = tf->feature;
 
 	fis[4] = tf->lbal;
@@ -631,6 +634,7 @@
 	cmd = ata_rw_cmds[index + fua + lba48 + write];
 	if (cmd) {
 		tf->command = cmd;
+		tf->saved_command = cmd;
 		return 0;
 	}
 	return -1;
--- linux/drivers/scsi/libata-scsi.c.orig	2006-02-25 10:58:41.000000000 -0500
+++ linux/drivers/scsi/libata-scsi.c	2006-02-25 11:16:07.000000000 -0500
@@ -438,7 +438,7 @@
  *	spin_lock_irqsave(host_set lock)
  */
 void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc, 
-			u8 *ascq, u8 opcode)
+			u8 *ascq, u8 opcode, u8 cmd)
 {
 	int i;
 
@@ -517,8 +517,8 @@
 		}
 	}
 	/* No error?  Undecoded? */
-	printk(KERN_WARNING "ata%u: no sense translation for op=0x%02x status: 0x%02x\n", 
-	       id, opcode, drv_stat);
+	printk(KERN_WARNING "ata%u: no sense translation for op=0x%02x cmd=0x%02x status: 0x%02x\n", 
+	       id, opcode, cmd, drv_stat);
 
 	/* For our last chance pick, use medium read error because
 	 * it's much more common than an ATA drive telling you a write
@@ -529,8 +529,8 @@
 	*ascq = 0x04; /*  "auto-reallocation failed" */
 
  translate_done:
-	DPRINTK(KERN_ERR "ata%u: translated op=0x%02x ATA stat/err 0x%02x/%02x to "
-	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, opcode, drv_stat, drv_err,
+	DPRINTK(KERN_ERR "ata%u: translated op=0x%02x cmd=0x%02x ATA stat/err 0x%02x/%02x to "
+	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, opcode, cmd, drv_stat, drv_err,
 	       *sk, *asc, *ascq);
 	return;
 }
@@ -571,7 +571,7 @@
 	 */
 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
-				   &sb[1], &sb[2], &sb[3], cmd->cmnd[0]);
+				   &sb[1], &sb[2], &sb[3], cmd->cmnd[0], tf->saved_command);
 		sb[1] &= 0x0f;
 	}
 
@@ -646,7 +646,7 @@
 	 */
 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
-				   &sb[2], &sb[12], &sb[13], cmd->cmnd[0]);
+				   &sb[2], &sb[12], &sb[13], cmd->cmnd[0], tf->saved_command);
 		sb[2] &= 0x0f;
 	}
 
@@ -1337,6 +1337,7 @@
 		goto early_finish;
 
 	/* select device, send command to hardware */
+	qc->tf.saved_command = qc->tf.command;
 	if (ata_qc_issue(qc))
 		goto err_did;
 
--- linux/include/linux/ata.h.orig	2006-02-17 17:23:45.000000000 -0500
+++ linux/include/linux/ata.h	2006-02-25 11:09:53.000000000 -0500
@@ -244,6 +244,7 @@
 	u8			device;
 
 	u8			command;	/* IO operation */
+	u8			saved_command;	/* IO operation */
 };
 
 #define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
--- linux/include/linux/libata.h.orig	2006-02-23 16:15:53.000000000 -0500
+++ linux/include/linux/libata.h	2006-02-25 11:17:14.000000000 -0500
@@ -420,7 +420,7 @@
 	void (*tf_load) (struct ata_port *ap, const struct ata_taskfile *tf);
 	void (*tf_read) (struct ata_port *ap, struct ata_taskfile *tf);
 
-	void (*exec_command)(struct ata_port *ap, const struct ata_taskfile *tf);
+	void (*exec_command)(struct ata_port *ap, struct ata_taskfile *tf);
 	u8   (*check_status)(struct ata_port *ap);
 	u8   (*check_altstatus)(struct ata_port *ap);
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
@@ -512,13 +512,13 @@
  */
 extern void ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
 extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
-extern void ata_tf_to_fis(const struct ata_taskfile *tf, u8 *fis, u8 pmp);
+extern void ata_tf_to_fis(struct ata_taskfile *tf, u8 *fis, u8 pmp);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
 extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
 extern u8 ata_check_status(struct ata_port *ap);
 extern u8 ata_altstatus(struct ata_port *ap);
-extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
+extern void ata_exec_command(struct ata_port *ap, struct ata_taskfile *tf);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
 extern void ata_host_stop (struct ata_host_set *host_set);

--------------040508050805070107090902--

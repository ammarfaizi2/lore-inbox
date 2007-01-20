Return-Path: <linux-kernel-owner+w=401wt.eu-S932874AbXATClx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbXATClx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 21:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932876AbXATClw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 21:41:52 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:4088 "EHLO
	pd3mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932874AbXATClv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 21:41:51 -0500
Date: Fri, 19 Jan 2007 20:41:36 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <200701191505.33480.s0348365@sms.ed.ac.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Jeff Garzik <jeff@garzik.org>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
Message-id: <45B18160.9020602@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------010906080301090205090405
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no>
 <45AC1DA3.5040104@shaw.ca> <45AC3006.9070705@garzik.org>
 <200701191505.33480.s0348365@sms.ed.ac.uk>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010906080301090205090405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alistair John Strachan wrote:
> On Tuesday 16 January 2007 01:53, Jeff Garzik wrote:
>> Robert Hancock wrote:
>>> I'll try your stress test when I get a chance, but I doubt I'll run into
>>> the same problem and I haven't seen any similar reports. Perhaps it's
>>> some kind of wierd timing issue or incompatibility between the
>>> controller and that drive when running in ADMA mode? I seem to remember
>>> various reports of issues with certain Maxtor drives and some nForce
>>> SATA controllers under Windows at least..
>> Just to eliminate things, has disabling ADMA been attempted?
>>
>> It can be disabled using the sata_nv.adma module parameter.
> 
> Setting this option fixes the problem for me. I suggest that ADMA defaults off 
> in 2.6.20, if there's still time to do that.
> 

Can you guys that are having this problem try the attached debug patch? 
It's possible it will fix the problem, as I'm trying a private 
exec_command implementation that flushes the write by reading a 
controller register instead of reading altstatus from the drive like the 
libata core code does.

If the problem still happens, I also added some more debugging in to 
help figure out what is going on, so please post full dmesg.

By the way, I assume that you guys are using reiserfs or xfs, as it 
appears no other file systems issue flush commands automatically. I had 
to test this by "echo 1 > delete" on the SCSI disk in sysfs, as I am 
using ext3.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


--------------010906080301090205090405
Content-Type: text/plain;
 name="sata_nv-debug-flushes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_nv-debug-flushes.patch"

--- linux-2.6.20-rc5/drivers/ata/sata_nv.c	2007-01-19 19:18:53.000000000 -0600
+++ linux-2.6.20-rc5debug/drivers/ata/sata_nv.c	2007-01-19 20:25:31.000000000 -0600
@@ -245,6 +245,7 @@ static void nv_adma_bmdma_setup(struct a
 static void nv_adma_bmdma_start(struct ata_queued_cmd *qc);
 static void nv_adma_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 nv_adma_bmdma_status(struct ata_port *ap);
+static void nv_adma_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
 
 enum nv_host_type
 {
@@ -409,7 +410,7 @@ static const struct ata_port_operations 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
 	.check_atapi_dma	= nv_adma_check_atapi_dma,
-	.exec_command		= ata_exec_command,
+	.exec_command		= nv_adma_exec_command,
 	.check_status		= ata_check_status,
 	.dev_select		= ata_std_dev_select,
 	.bmdma_setup		= nv_adma_bmdma_setup,
@@ -617,6 +618,14 @@ static int nv_adma_check_atapi_dma(struc
 	return !(pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE);
 }
 
+static void nv_adma_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
+{
+	void __iomem* mmio = nv_adma_ctl_block(ap);
+	writeb(tf->command, (void __iomem *) ap->ioaddr.command_addr);
+	readw(mmio + NV_ADMA_CTL); /* flush */
+	ndelay(400);
+}
+
 static unsigned int nv_adma_tf_to_cpb(struct ata_taskfile *tf, __le16 *cpb)
 {
 	unsigned int idx = 0;
@@ -701,6 +710,9 @@ static int nv_host_intr(struct ata_port 
 {
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	int handled;
+	u8 cmd = 0;
+	if(qc)
+		cmd = qc->tf.command;
 
 	/* freeze if hotplugged */
 	if (unlikely(irq_stat & (NV_INT_ADDED | NV_INT_REMOVED))) {
@@ -709,8 +721,11 @@ static int nv_host_intr(struct ata_port 
 	}
 
 	/* bail out if not our interrupt */
-	if (!(irq_stat & NV_INT_DEV))
+	if (!(irq_stat & NV_INT_DEV)) {
+		if( cmd == ATA_CMD_FLUSH || cmd == ATA_CMD_FLUSH_EXT )
+			ata_port_printk(ap, KERN_NOTICE, "cmd 0x%x active but stat 0x%x\n", cmd, irq_stat);
 		return 0;
+	}
 
 	/* DEV interrupt w/ no active qc? */
 	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
@@ -720,6 +735,8 @@ static int nv_host_intr(struct ata_port 
 
 	/* handle interrupt */
 	handled = ata_host_intr(ap, qc);
+	if( cmd == ATA_CMD_FLUSH || cmd == ATA_CMD_FLUSH_EXT )
+		ata_port_printk(ap, KERN_NOTICE, "cmd 0x%x active, stat = 0x%x, handled = 0x%x\n", cmd, irq_stat, handled);
 	if (unlikely(!handled)) {
 		/* spurious, clear it */
 		ata_check_status(ap);
@@ -870,7 +887,7 @@ static void nv_adma_bmdma_setup(struct a
 	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
 	/* issue r/w command */
-	ata_exec_command(ap, &qc->tf);
+	nv_adma_exec_command(ap, &qc->tf);
 }
 
 static void nv_adma_bmdma_start(struct ata_queued_cmd *qc)
@@ -1161,6 +1178,9 @@ static unsigned int nv_adma_qc_issue(str
 		/* use ATA register mode */
 		VPRINTK("no dmamap or ATAPI, using ATA register mode: 0x%lx\n", qc->flags);
 		nv_adma_register_mode(qc->ap);
+		if(qc->tf.command == ATA_CMD_FLUSH ||
+		   qc->tf.command == ATA_CMD_FLUSH_EXT )
+			ata_port_printk(qc->ap, KERN_NOTICE, "issue flush cmd 0x%x\n", qc->tf.command);
 		return ata_qc_issue_prot(qc);
 	} else
 		nv_adma_mode(qc->ap);

--------------010906080301090205090405--


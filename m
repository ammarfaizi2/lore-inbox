Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270218AbTGRLZX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271609AbTGRLZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:25:23 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:7607 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S270218AbTGRLZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:25:02 -0400
Date: Fri, 18 Jul 2003 13:39:50 +0200
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com
Subject: Re: 2.6.0-test1 gets corrupted data when loading init
Message-ID: <20030718113950.GF5964@h55p111.delphi.afb.lu.se>
References: <20030718083458.GC5964@h55p111.delphi.afb.lu.se> <20030718095108.GE5964@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718095108.GE5964@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19dTaY-0003s0-00*Kb3tcmQ6ojA*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 11:51:08AM +0200, Anders Gustafsson wrote:
> On Fri, Jul 18, 2003 at 10:34:58AM +0200, Anders Gustafsson wrote:
> > It breaks between 2.5.70 and 2.5.70-bk1, which contains a update in the
> > aic79xx-drivers, so my guess is related to that.
> 
> http://linux.bkbits.net:8080/linux-2.5/cset@1.1127.6.4 is the changeset that
> makes it stop working.

Yeah, and reversing that on 2.6.0-test+bk with the attached patch makes it
work on 2.6.0-test1.

But I get these messages:

(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (72 of 96 bytes). Treated as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (72 of 96 bytes). Treated as error
(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT|IU|QAS, 16bit)
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (72 of 96 bytes). Treated as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (72 of 96 bytes). Treated as error
(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, 16bit)
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (72 of 96 bytes). Treated as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (72 of 96 bytes). Treated as error
(scsi1:A:0): 80.000MB/s transfers (40.000MHz DT, 16bit)
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (72 of 96 bytes). Treated as error


-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

--- a/drivers/scsi/aic7xxx/aic79xx.seq	Fri Jul 18 19:34:59 2003
+++ b/drivers/scsi/aic7xxx/aic79xx.seq	Fri Jul 18 19:34:59 2003
@@ -261,15 +261,6 @@
 	clr	A;
 	add	CMDS_PENDING, 1;
 	adc	CMDS_PENDING[1], A;
-	if ((ahd->bugs & AHD_PKT_LUN_BUG) != 0) {
-		/*
-		 * "Short Luns" are not placed into outgoing LQ
-		 * packets in the correct byte order.  Use a full
-		 * sized lun field instead and fill it with the
-		 * one byte of lun information we support.
-		 */
-		mov	SCB_PKT_LUN[6], SCB_LUN;
-	}
 	/*
 	 * The FIFO use count field is shared with the
 	 * tag set by the host so that our SCB dma engine
--- a/drivers/scsi/aic7xxx/aic79xx_core.c	Fri Jul 18 19:34:59 2003
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c	Fri Jul 18 19:34:59 2003
@@ -8272,6 +8272,8 @@
 	download_consts[PKT_OVERRUN_BUFOFFSET] =
 		(ahd->overrun_buf - (uint8_t *)ahd->qoutfifo) / 256;
 	download_consts[SCB_TRANSFER_SIZE] = SCB_TRANSFER_SIZE_1BYTE_LUN;
+	if ((ahd->bugs & AHD_PKT_LUN_BUG) != 0)
+		download_consts[SCB_TRANSFER_SIZE] = SCB_TRANSFER_SIZE_FULL_LUN;
 	cur_patch = patches;
 	downloaded = 0;
 	skip_addr = 0;
--- a/drivers/scsi/aic7xxx/aic79xx_inline.h	Fri Jul 18 19:34:59 2003
+++ b/drivers/scsi/aic7xxx/aic79xx_inline.h	Fri Jul 18 19:34:59 2003
@@ -272,6 +272,10 @@
 	if ((scb->flags & SCB_PACKETIZED) != 0) {
 		/* XXX what about ACA??  It is type 4, but TAG_TYPE == 0x3. */
 		scb->hscb->task_attribute = scb->hscb->control & SCB_TAG_TYPE;
+		/*
+		 * For Rev A short lun workaround.
+		 */
+		scb->hscb->pkt_long_lun[6] = scb->hscb->lun;
 	} else {
 		if (ahd_get_transfer_length(scb) & 0x01)
 			scb->hscb->task_attribute = SCB_XFERLEN_ODD;

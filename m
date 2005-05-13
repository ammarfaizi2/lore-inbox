Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVEMTFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVEMTFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVEMTDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:03:01 -0400
Received: from kanga.kvack.org ([66.96.29.28]:37268 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262487AbVEMS4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:56:40 -0400
Date: Fri, 13 May 2005 14:58:50 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [rfc/patch] libata -- port configurable delays
Message-ID: <20050513185850.GA5777@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff et al,

The patch below makes the delays in ata_pause() and ata_busy_wait() 
configurable on a per-port basis, and enables the no delay flag on 
the one chipset I've tested on.  Getting rid of the delays is worth 
quite a bit: doing sequential 512 byte O_DIRECT AIO reads results in 
a drop from 35.743s to 29.205s using simple-aio-min_nr 20480 10 (a copy 
is available at http://www.kvack.org/~bcrl/simple-aio-min_nr.c).  
Before this patch __delay() is the number one entry in oprofile 
results for this workload.  Does this look like a reasonable approach 
for chipsets that aren't completely braindead?  Cheers,

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler

CPU: P4 / Xeon with 2 hyper-threads, speed 2994.52 MHz (estimated)
Counted INSTR_RETIRED events (retired instructions) with a unit mask of 0x03 (mu
ltiple flags) count 90000
samples  %        app name                 symbol name
6676     19.5011  vmlinux                  __delay
923       2.6962  vmlinux                  __blockdev_direct_IO
733       2.1411  vmlinux                  memset
711       2.0769  vmlinux                  kmem_cache_alloc
698       2.0389  vmlinux                  kmem_cache_free
639       1.8666  vmlinux                  mempool_alloc
455       1.3291  vmlinux                  as_insert_request
440       1.2853  vmlinux                  scsi_request_fn
404       1.1801  vmlinux                  ext3_get_branch
404       1.1801  vmlinux                  mempool_free
374       1.0925  vmlinux                  scsi_dispatch_cmd
356       1.0399  vmlinux                  __mod_timer
352       1.0282  vmlinux                  __make_request
...

Signed-off-by: Benjamin LaHaise <benjamin.c.lahaise@intel.com>
diff -purN v2.6.12-rc4/drivers/scsi/ata_piix.c libata-rc4/drivers/scsi/ata_piix.c
--- v2.6.12-rc4/drivers/scsi/ata_piix.c	2005-04-28 11:01:54.000000000 -0400
+++ libata-rc4/drivers/scsi/ata_piix.c	2005-05-13 13:30:39.000000000 -0400
@@ -228,6 +228,7 @@ static struct ata_port_info piix_port_in
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
 				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
+				  ATA_FLAG_NO_UDELAY |
 				  ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
diff -purN v2.6.12-rc4/include/linux/libata.h libata-rc4/include/linux/libata.h
--- v2.6.12-rc4/include/linux/libata.h	2005-04-06 17:28:10.000000000 -0400
+++ libata-rc4/include/linux/libata.h	2005-05-13 13:32:15.000000000 -0400
@@ -113,6 +113,7 @@ enum {
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
+	ATA_FLAG_NO_UDELAY	= (1 << 9), /* don't udelay on port access */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -469,7 +470,8 @@ static inline u8 ata_chk_status(struct a
 static inline void ata_pause(struct ata_port *ap)
 {
 	ata_altstatus(ap);
-	ndelay(400);
+	if (!(ap->flags & ATA_FLAG_NO_UDELAY))
+		ndelay(400);
 }
 
 static inline u8 ata_busy_wait(struct ata_port *ap, unsigned int bits,
@@ -478,7 +480,8 @@ static inline u8 ata_busy_wait(struct at
 	u8 status;
 
 	do {
-		udelay(10);
+		if (!(ap->flags & ATA_FLAG_NO_UDELAY))
+			udelay(10);
 		status = ata_chk_status(ap);
 		max--;
 	} while ((status & bits) && (max > 0));

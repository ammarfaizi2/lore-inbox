Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWGYG3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWGYG3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWGYG3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:29:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60098 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751443AbWGYG3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:29:31 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2 Intermittent failures to detect sata disks 
In-reply-to: Your message of "Tue, 25 Jul 2006 01:57:08 -0400."
             <44C5B2B4.4090300@pobox.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jul 2006 16:27:34 +1000
Message-ID: <9927.1153808854@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik (on Tue, 25 Jul 2006 01:57:08 -0400) wrote:
>Keith Owens wrote:
>> Keith Owens (on Fri, 21 Jul 2006 16:18:47 +1000) wrote:
>>> I am seeing an intermittent failures to detect sata disks on
>>> 2.6.18-rc2.  Dell SC1425, PIIX chipset, gcc 4.1.0 (opensuse 10.1).
>>> Sometimes it will detect both disks, sometimes only one, sometimes none
>>> at all.  AFAICT it only occurs after a soft reboot, and possibly only
>>> after an emergency reboot.  Alas the problem is so intermittent that it
>>> is hard to tell what conditions will trigger it.
>> 
>> I applied the debug patch below, turn on prink timing and set
>> initdefault to 6 so the machine was in a continual soft reboot cycle.
>> After multiple cycles I got this trace.  piix_sata_prereset() reads a
>> zero config byte for almost 15 seconds then it changes to 0x11,
>> followed by a hang.  Why is the config byte initially zero, and what
>> makes it change?  The normal value for pcs is 0x33.
>
>Can you try 2.6.18-rc2-git3?
>
>	Jeff

Running now, with the trivial bug fix below plus my debug patch.  I
will leave it running overnight, this problem is very intermittent.

Trivial bug fix:

---
 drivers/scsi/ata_piix.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/scsi/ata_piix.c
===================================================================
--- linux.orig/drivers/scsi/ata_piix.c
+++ linux/drivers/scsi/ata_piix.c
@@ -567,8 +567,8 @@ static int piix_sata_prereset(struct ata
 			present = 1;
 	}
 
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
-		ap->id, pcs, present_mask);
+	DPRINTK("ata%u: LEAVE, pcs=0x%x present=0x%x\n",
+		ap->id, pcs, present);
 
 	if (!present) {
 		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");

Debug patch:

---
 drivers/scsi/ata_piix.c |    5 +++++
 include/linux/libata.h  |    4 ++++
 2 files changed, 9 insertions(+)

Index: linux/drivers/scsi/ata_piix.c
===================================================================
--- linux.orig/drivers/scsi/ata_piix.c
+++ linux/drivers/scsi/ata_piix.c
@@ -529,6 +529,7 @@ static void piix_pata_error_handler(stru
 	ata_bmdma_drive_eh(ap, piix_pata_prereset, ata_std_softreset, NULL,
 			   ata_std_postreset);
 }
+int ata_debug = 1;
 
 /**
  *	piix_sata_prereset - prereset for SATA host controller
@@ -555,6 +556,7 @@ static int piix_sata_prereset(struct ata
 	int port, i;
 	u16 pcs;
 
+repeat:
 	pci_read_config_word(pdev, ICH5_PCS, &pcs);
 	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
 
@@ -569,6 +571,9 @@ static int piix_sata_prereset(struct ata
 
 	DPRINTK("ata%u: LEAVE, pcs=0x%x present=0x%x\n",
 		ap->id, pcs, present);
+	if (pcs == 0)
+		goto repeat;
+	ata_debug = 0;
 
 	if (!present) {
 		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
Index: linux/include/linux/libata.h
===================================================================
--- linux.orig/include/linux/libata.h
+++ linux/include/linux/libata.h
@@ -61,6 +61,10 @@
 #define VPRINTK(fmt, args...)
 #endif	/* ATA_DEBUG */
 
+extern int ata_debug;
+#undef DPRINTK
+#define DPRINTK(fmt, args...) if (ata_debug) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+
 #define BPRINTK(fmt, args...) if (ap->flags & ATA_FLAG_DEBUGMSG) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
 
 /* NEW: debug levels */


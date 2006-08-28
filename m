Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWH1PYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWH1PYF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 11:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWH1PYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 11:24:05 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:8764 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751060AbWH1PYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 11:24:02 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Tejun Heo <htejun@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux v2.6.18-rc5 
In-reply-to: Your message of "Mon, 28 Aug 2006 17:42:22 +0900."
             <44F2AC6E.90608@gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 Aug 2006 01:24:12 +1000
Message-ID: <6353.1156778652@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo (on Mon, 28 Aug 2006 17:42:22 +0900) wrote:
>Keith Owens wrote:
>> Two hours of continuous reboots on an ICH5 chipset passed without any
>> problems.  Couple of caveats though -
>> 
>> (1) The "fix" for this bug is to skip the pcs test for SATA ports on
>>     ICH5 chipsets.  This results in spurious warning messages for ICH5
>>     SATA ports with no disks attached.
>> 
>>     ATA: abnormal status 0x7F on port 0xCCA7
>
>This is a known annoyance and will be fixed in time.
>
>> (2) I have seen the same intermittent bug on ICH7 SATA but
>>     PIIX_FLAG_IGNORE_PCS is only set for ich5 and i6300esb_sata.  It
>>     probably needs to be set for ich7 as well.
>
>No, ICH7 up to this point has been believed to have well-behaving PCS. 
>If you report PCS problem, you'll be the first.  Also, note that ICH7 
>suffers from ghost device probing problem if PCS is not honored exactly. 
>  Are you sure it's the same problem?

It definitely looks like it.  Stock 2.6.18-rc5 plus this patch to
activate ata_debug from boot until just after probing drives.

---
 drivers/scsi/ata_piix.c |    5 ++++-
 include/linux/libata.h  |    4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Index: linux/drivers/scsi/ata_piix.c
===================================================================
--- linux.orig/drivers/scsi/ata_piix.c
+++ linux/drivers/scsi/ata_piix.c
@@ -536,6 +536,8 @@ static void piix_pata_error_handler(stru
 			   ata_std_postreset);
 }
 
+int ata_debug = 1;
+
 /**
  *	piix_sata_present_mask - determine present mask for SATA host controller
  *	@ap: Target port
@@ -615,6 +617,7 @@ static void piix_sata_error_handler(stru
 {
 	ata_bmdma_drive_eh(ap, ata_std_prereset, piix_sata_softreset, NULL,
 			   ata_std_postreset);
+	ata_debug = 0;
 }
 
 /**
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


Typical debug messages from a series of boots

<3>piix_sata_present_mask: ata1: ENTER, pcs=0x15 base=0
<3>piix_sata_present_mask: ata1: LEAVE, pcs=0x15 present_mask=0x3
<3>piix_sata_present_mask: ata1: ENTER, pcs=0x0 base=0
<3>piix_sata_present_mask: ata1: LEAVE, pcs=0x0 present_mask=0x3
<3>piix_sata_present_mask: ata1: ENTER, pcs=0x15 base=0
<3>piix_sata_present_mask: ata1: LEAVE, pcs=0x15 present_mask=0x3
<3>piix_sata_present_mask: ata1: ENTER, pcs=0x0 base=0
<3>piix_sata_present_mask: ata1: LEAVE, pcs=0x0 present_mask=0x3
<3>piix_sata_present_mask: ata1: ENTER, pcs=0x15 base=0

Note the pcs=0x0 values.  Adding PIIX_FLAG_IGNORE_PCS to
ich6m_sata_ahci gets past the failure to detect pcs, with no sign of
any ghost devices.  BTW, dropping down to 2.6.17 with the same config
has no problem detecting the disk, even without PIIX_FLAG_IGNORE_PCS on
ich6m_sata_ahci.

lspci extract, this is an ICH7M.

00:1f.0 Class 0601: 8086:27b9 (rev 02)
	Subsystem: 1033:832c
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:1f.2 Class 0101: 8086:27c4 (rev 02) (prog-if 80)
	Subsystem: 1033:832c
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 18b0 [size=16]
	Capabilities: [70] Power Management version 2

00:1f.3 Class 0c05: 8086:27da (rev 02)
	Subsystem: 1033:832c
	Flags: medium devsel, IRQ 11
	I/O ports at 18c0 [size=32]


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUCVNX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 08:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUCVNX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 08:23:56 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:2688 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S261978AbUCVNXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 08:23:45 -0500
Date: Mon, 22 Mar 2004 14:23:38 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: ata_piix doesn't work in combined mode if master is missing.
Message-ID: <20040322132336.GA12460@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I have a supermicro 1U server with 2 SATA swappable drives.
The chipset is Intel ICH5, and I'm using the ata_piix.c libata
driver. Works fine!

Except that if I remove the first drive, the second drive isn't
detected anymore. Now I have those drives set up with partitioned
RAID5, and if the first drive is missing or dead the system is
supposed to boot from the second disk - the BIOS does that, but
libata doesn't see the second drive.

A normal boot looks like this (dmesg output):

libata version 1.01 loaded.
ata_piix version 1.01
ata_piix: combined mode detected
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 160086528 sectors
ata1: dev 1 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata1: dev 1 ATA, max UDMA/133, 160086528 sectors
ata1: dev 0 configured for UDMA/133
ata1: dev 1 configured for UDMA/133
scsi0 : ata_piix

A boot with the first disk removed looks like this:

ata_piix: combined mode detected
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata1: SATA port has no device. disabling.
scsi0 : ata_piix

(Note that this is serial console output, it apparently doesn't show
 the "cfg" line on the serial console).

If I patch ata_piix.c to just ifdef out the "disabled" code, then I
can actually boot and run from the second disk, dmesg output:

ata_piix version 1.01
ata_piix: combined mode detected
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata1: dev 1 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:407f
ata1: dev 1 ATA, max UDMA/133, 160086528 sectors
ata1: dev 1 configured for UDMA/133
scsi0 : ata_piix

If I enable "enhanced mode" instead of "combined mode" in the BIOS,
there is no problem - but as the system normally works in both modes,
and only fails in combined mode with the first disk missing, this
is risky - if you forget to put the BIOS in enhanced mode, you'll
only find out when it's too late.

The hack I used to reckognize the second disk is below. Is it
possible to fix this properly (i.e. check for slave in combined mode) ?

Thanks,

Mike.

--- linux-2.6.5-rc1.orig/drivers/scsi/ata_piix.c	2004-03-11 03:55:27.000000000 +0100
+++ linux-2.6.5-rc1/drivers/scsi/ata_piix.c	2004-03-22 13:14:59.000000000 +0100
@@ -342,6 +342,7 @@
 		return;
 	}
 
+#if 0 /* XXX miquels */
 	/* if port enabled but no device, disable port and exit */
 	if (!have_dev) {
 		piix_sata_port_disable(ap);
@@ -349,6 +350,7 @@
 		       ap->id);
 		return;
 	}
+#endif
 
 	ap->cbl = ATA_CBL_SATA;
 

Mike.
-- 
Netu, v qba'g yvxr gur cynvagrkg :)

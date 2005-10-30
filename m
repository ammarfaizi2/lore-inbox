Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVJ3M7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVJ3M7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 07:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVJ3M7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 07:59:45 -0500
Received: from mail.dvmed.net ([216.237.124.58]:40841 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751232AbVJ3M7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 07:59:44 -0500
Message-ID: <4364C3B8.1010909@pobox.com>
Date: Sun, 30 Oct 2005 07:59:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Kellermann <max@duempel.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.14-rc4-mm1 and later: second ata_piix controller is invisible
References: <20051025095646.GA24977@roonstrasse.net>
In-Reply-To: <20051025095646.GA24977@roonstrasse.net>
Content-Type: multipart/mixed;
 boundary="------------000009040008050903040107"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000009040008050903040107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Max Kellermann wrote:
> Hi Andrew,
> 
> since 2.6.14-rc4-mm1, my second ata_piix (SATA) controller does not
> show up in dmesg, effectively hiding /dev/sdb.  2.6.14-rc2-mm2 and
> older (with the same kernel config) were ok, the same for Linus'
> kernels: 2.6.14-rc5 without -mm1 has /dev/sdb, too.

Attached is the patch I just checked in, which should play a bit more 
nicely with Alan's PATA drivers than the last patch.

I was able to reproduce your (Max's) problem locally, and verified that 
the attached patch fixed it.

	Jeff



--------------000009040008050903040107
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

fbf30fbaa61595e9026f628f3913888b0df2b288
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index b7fbf11..7f8aa1b 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -622,7 +622,7 @@ static int piix_init_one (struct pci_dev
 {
 	static int printed_version;
 	struct ata_port_info *port_info[2];
-	unsigned int combined = 0, n_ports = 1;
+	unsigned int combined = 0;
 	unsigned int pata_chan = 0, sata_chan = 0;
 
 	if (!printed_version++)
@@ -634,7 +634,7 @@ static int piix_init_one (struct pci_dev
 		return -ENODEV;
 
 	port_info[0] = &piix_port_info[ent->driver_data];
-	port_info[1] = NULL;
+	port_info[1] = &piix_port_info[ent->driver_data];
 
 	if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
 		u8 tmp;
@@ -672,14 +672,13 @@ static int piix_init_one (struct pci_dev
 		port_info[sata_chan] = &piix_port_info[ent->driver_data];
 		port_info[sata_chan]->host_flags |= ATA_FLAG_SLAVE_POSS;
 		port_info[pata_chan] = &piix_port_info[ich5_pata];
-		n_ports++;
 
 		dev_printk(KERN_WARNING, &pdev->dev,
 			   "combined mode detected (p=%u, s=%u)\n",
 			   pata_chan, sata_chan);
 	}
 
-	return ata_pci_init_one(pdev, port_info, n_ports);
+	return ata_pci_init_one(pdev, port_info, 2);
 }
 
 static int __init piix_init(void)

--------------000009040008050903040107--

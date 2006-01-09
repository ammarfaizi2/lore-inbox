Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWAIRMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWAIRMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWAIRMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:12:39 -0500
Received: from [81.2.110.250] ([81.2.110.250]:24214 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030186AbWAIRMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:12:38 -0500
Subject: PATCH: Pre UDMA EIDE PIO mode selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 17:14:40 +0000
Message-Id: <1136826880.6659.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I misread the spec when doing the original. I've tested the corrected
version with pre UDMA drives and it now picks the right modes. This is a
specific bug fix rather than an update or new feature item.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-mm2/drivers/scsi/libata-core.c linux-2.6.15-mm2/drivers/scsi/libata-core.c
--- linux.vanilla-2.6.15-mm2/drivers/scsi/libata-core.c	2006-01-09 14:33:45.000000000 +0000
+++ linux-2.6.15-mm2/drivers/scsi/libata-core.c	2006-01-09 15:19:14.000000000 +0000
@@ -1052,18 +1057,22 @@
 {
 	u16 modes;
 
-	/* Usual case. Word 53 indicates word 88 is valid */
-	if (adev->id[ATA_ID_FIELD_VALID] & (1 << 2)) {
+	/* Usual case. Word 53 indicates word 64 is valid */
+	if (adev->id[ATA_ID_FIELD_VALID] & (1 << 1)) {
 		modes = adev->id[ATA_ID_PIO_MODES] & 0x03;
 		modes <<= 3;
 		modes |= 0x7;
 		return modes;
 	}
 
-	/* If word 88 isn't valid then Word 51 holds the PIO timing number
-	   for the maximum. Turn it into a mask and return it */
-	modes = (2 << (adev->id[ATA_ID_OLD_PIO_MODES] & 0xFF)) - 1 ;
+	/* If word 64 isn't valid then Word 51 high byte holds the PIO timing
+	   number for the maximum. Turn it into a mask and return it */
+	modes = (2 << ((adev->id[ATA_ID_OLD_PIO_MODES] >> 8) & 0xFF)) - 1 ;
 	return modes;
+	/* But wait.. there's more. Design your standards by committee and
+	   you too can get a free iordy field to process. However its the 
+	   speeds not the modes that are supported... Note drivers using the
+	   timing API will get this right anyway */
 }
 
 struct ata_exec_internal_arg {


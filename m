Return-Path: <linux-kernel-owner+w=401wt.eu-S965444AbWLPOX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965444AbWLPOX7 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 09:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965442AbWLPOX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 09:23:59 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37441 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965444AbWLPOX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 09:23:58 -0500
Date: Sat, 16 Dec 2006 14:32:21 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] pata_via: Cable detect error
Message-ID: <20061216143221.47c5e7f3@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The UDMA66 VIA hardware has no controller side cable detect bits we can
use. This patch minimally fixes the problem by reporting unknown in this
case and using drive side detection.

The old drivers/ide code does some additional tricks but those aren't
appropriate now we are in -rc.

Without this update UDMA66 via controllers run slowly. They don't fail so
it's a borderline call whether this is -rc material or not.

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.20-rc1/drivers/ata/pata_via.c	2006-12-14 17:23:30.000000000 +0000
+++ linux-2.6.20-rc1/drivers/ata/pata_via.c	2006-12-16 14:05:12.044300968 +0000
@@ -161,10 +161,15 @@
 			return -ENOENT;
 	}
 
-	if ((config->flags & VIA_UDMA) >= VIA_UDMA_66)
+	if ((config->flags & VIA_UDMA) >= VIA_UDMA_100)
 		ap->cbl = via_cable_detect(ap);
-	else
+	/* The UDMA66 series has no cable detect so do drive side detect */
+	else if ((config->flags & VIA_UDMA) < VIA_UDMA_66)
 		ap->cbl = ATA_CBL_PATA40;
+	else
+		ap->cbl = ATA_CBL_PATA_UNK;
+		
+
 	return ata_std_prereset(ap);
 }
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWJPPA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWJPPA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWJPPA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:00:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24777 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750740AbWJPPA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:00:56 -0400
Subject: [PATCH] libata-sff: Allow for wacky systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:24:50 +0100
Message-Id: <1161012290.24237.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are some Linux supported platforms that simply cannot hit the low
I/O addresses used by ATA legacy mode PCI mappings. These platforms have
a window for PCI space that is fixed by the board logic and doesn't
include the neccessary locations.

Provide a config option so that such platforms faced with a controller
that they cannot support simply error it and punt

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/ata/libata-sff.c linux-2.6.19-rc1-mm1/drivers/ata/libata-sff.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/ata/libata-sff.c	2006-10-13 15:09:23.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/ata/libata-sff.c	2006-10-13 17:15:57.000000000 +0100
@@ -981,6 +981,15 @@
 		mask = (1 << 2) | (1 << 0);
 		if ((tmp8 & mask) != mask)
 			legacy_mode = (1 << 3);
+#if defined(CONFIG_NO_ATA_LEGACY)
+		/* Some platforms with PCI limits cannot address compat
+		   port space. In that case we punt if their firmware has
+		   left a device in compatibility mode */
+		if (legacy_mode) {
+			printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
+			return -EOPNOTSUPP;
+		}
+#endif
 	}
 
 	rc = pci_request_regions(pdev, DRV_NAME);


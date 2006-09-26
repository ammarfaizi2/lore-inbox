Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWIZQNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWIZQNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWIZQNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:13:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63451 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932338AbWIZQNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:13:50 -0400
Subject: [PATCH] libata: refuse to register IRQless ports
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 17:35:32 +0100
Message-Id: <1159288532.11049.250.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't currently support pure polled operation so when we meet a BIOS
which forgot to assign an IRQ to a PCI device it all goes a little pear
shaped. Trap this case properly.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/libata-core.c linux-2.6.18-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/libata-core.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/libata-core.c	2006-09-26 11:47:57.041010560 +0100
@@ -5460,6 +5460,11 @@
 	int rc;
 
 	DPRINTK("ENTER\n");
+	
+	if (ent->irq == 0) {
+		dev_printk(KERN_ERR, dev, "is not available: No interrupt assigned.\n");
+		return 0;
+	}
 	/* alloc a container for our list of ATA ports (buses) */
 	host = kzalloc(sizeof(struct ata_host) +
 		       (ent->n_ports * sizeof(void *)), GFP_KERNEL);


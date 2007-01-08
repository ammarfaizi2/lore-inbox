Return-Path: <linux-kernel-owner+w=401wt.eu-S1751470AbXAHL7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbXAHL7g (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 06:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbXAHL7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 06:59:35 -0500
Received: from [81.2.110.250] ([81.2.110.250]:60699 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751470AbXAHL7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 06:59:35 -0500
Date: Mon, 8 Jan 2007 12:10:05 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [PATCH] libata-sff: Don't try and activate channels which are not
 in use
Message-ID: <20070108121005.4ab3fb79@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An ATA controller in native mode may have one or more channels disabled
and not assigned resources. In that case the existing code crashes trying
to access I/O ports 0-7.

Add the neccessary check.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc3-mm1/drivers/ata/libata-sff.c linux-2.6.20-rc3-mm1/drivers/ata/libata-sff.c
--- linux.vanilla-2.6.20-rc3-mm1/drivers/ata/libata-sff.c	2007-01-05 13:09:36.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ata/libata-sff.c	2007-01-05 14:08:32.000000000 +0000
@@ -831,6 +831,21 @@
 }
 
 #ifdef CONFIG_PCI
+
+static int ata_resources_present(struct pci_dev *pdev, int port)
+{
+	int i;
+	
+	/* Check the PCI resources for this channel are enabled */
+	port = port * 2;
+	for (i = 0; i < 2; i ++) {
+		if (pci_resource_start(pdev, port + i) == 0 ||
+			pci_resource_len(pdev, port + i) == 0)
+		return 0;
+	}
+	return 1;
+}
+		
 /**
  *	ata_pci_init_native_mode - Initialize native-mode driver
  *	@pdev:  pci device to be initialized
@@ -862,6 +877,13 @@
 
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = IRQF_SHARED;
+	
+	/* Discard disabled ports. Some controllers show their
+	   unused channels this way */
+	if (ata_resources_present(pdev, 0) == 0)
+		ports &= ~ATA_PORT_PRIMARY;
+	if (ata_resources_present(pdev, 1) == 0)
+		ports &= ~ATA_PORT_SECONDARY;
 
 	if (ports & ATA_PORT_PRIMARY) {
 		probe_ent->port[p].cmd_addr = pci_resource_start(pdev, 0);

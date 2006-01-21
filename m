Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWAUIci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWAUIci (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWAUIci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:32:38 -0500
Received: from mail.dvmed.net ([216.237.124.58]:51671 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751135AbWAUIcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:32:36 -0500
Message-ID: <43D1F192.3060406@pobox.com>
Date: Sat, 21 Jan 2006 03:32:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>
CC: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, greg@kroah.com,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       neilb@cse.unsw.edu.au, linux-acpi@vger.kernel.org
Subject: [PATCH] Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt
 bug]
References: <Pine.LNX.4.44L0.0601152243330.1929-100000@netrider.rowland.org>	<43D1C4E9.7030901@reub.net> <20060120214723.79111715.akpm@osdl.org> <43D1E9A4.8090504@reub.net>
In-Reply-To: <43D1E9A4.8090504@reub.net>
Content-Type: multipart/mixed;
 boundary="------------040803060803060209030702"
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On the libata side of things, does this patch produce
	any useful results? Jeff diff --git a/drivers/scsi/libata-core.c
	b/drivers/scsi/libata-core.c index 46c4cdb..4691f8d 100644 ---
	a/drivers/scsi/libata-core.c +++ b/drivers/scsi/libata-core.c @@
	-4794,7 +4794,14 @@ ata_pci_init_native_mode(struct pci_dev
	pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
	probe_ent->port[p].bmdma_addr = pci_resource_start(pdev, 4);
	ata_std_ports(&probe_ent->port[p]); - p++; + + if
	(pci_resource_start(pdev, 0) && + pci_resource_len(pdev, 0) && +
	pci_resource_start(pdev, 1) && + pci_resource_len(pdev, 1) && +
	pci_resource_start(pdev, 4) && + pci_resource_len(pdev, 4)) + p++; }
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040803060803060209030702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


On the libata side of things, does this patch produce any useful results?

	Jeff




--------------040803060803060209030702
Content-Type: text/plain;
 name="patch.pci-region-check"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.pci-region-check"

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 46c4cdb..4691f8d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4794,7 +4794,14 @@ ata_pci_init_native_mode(struct pci_dev 
 			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
 		probe_ent->port[p].bmdma_addr = pci_resource_start(pdev, 4);
 		ata_std_ports(&probe_ent->port[p]);
-		p++;
+
+		if (pci_resource_start(pdev, 0) &&
+		    pci_resource_len(pdev, 0) &&
+		    pci_resource_start(pdev, 1) &&
+		    pci_resource_len(pdev, 1) &&
+		    pci_resource_start(pdev, 4) &&
+		    pci_resource_len(pdev, 4))
+			p++;
 	}
 
 	if (ports & ATA_PORT_SECONDARY) {
@@ -4804,10 +4811,23 @@ ata_pci_init_native_mode(struct pci_dev 
 			pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
 		probe_ent->port[p].bmdma_addr = pci_resource_start(pdev, 4) + 8;
 		ata_std_ports(&probe_ent->port[p]);
-		p++;
+
+		if (pci_resource_start(pdev, 2) &&
+		    pci_resource_len(pdev, 2) &&
+		    pci_resource_start(pdev, 3) &&
+		    pci_resource_len(pdev, 3) &&
+		    pci_resource_start(pdev, 4) &&
+		    pci_resource_len(pdev, 4) > 8)
+			p++;
 	}
 
 	probe_ent->n_ports = p;
+
+	if (p == 0) {
+		kfree(probe_ent);
+		probe_ent = NULL;
+	}
+
 	return probe_ent;
 }
 
@@ -4815,6 +4835,10 @@ static struct ata_probe_ent *ata_pci_ini
 {
 	struct ata_probe_ent *probe_ent;
 
+	if (!pci_resource_start(pdev, 4) ||
+	    !pci_resource_len(pdev, 4))
+		return NULL;
+
 	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
 	if (!probe_ent)
 		return NULL;

--------------040803060803060209030702--

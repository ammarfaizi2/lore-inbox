Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWJWDsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWJWDsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWJWDsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:48:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:51614 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751415AbWJWDsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:48:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jsjFIRoVg/9TMNoqH/2RszTpBH5QVuKwFohSKbpy2TW4B+rMr56a28FXiW0rN7+FqW/ACdjT5JKfhhwbvXAqYS7lZn/Vye99KTZc62JGdjGsbBarxnMsRCafgI5iiLUqn6SVUObgfi3zvrJSceYGQ8N5oHHh0VrkfRD45/hUmhw=
Date: Mon, 23 Oct 2006 12:48:21 +0900
From: Tejun Heo <htejun@gmail.com>
To: jeff@garzik.org
Cc: Patrick McHardy <kaber@trash.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: [PATCH] sata_sis: fix flags handling for the secondary port
Message-ID: <20061023034821.GI13677@htj.dyndns.org>
References: <453A3F0C.3000406@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453A3F0C.3000406@trash.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sis_init_one() modifies probe_ent->port_flags after allocating and
initializing it using ata_pci_init_native_mode().  This makes
port_flags for the secondary port (probe_ent->pinfo2->flags) go out of
sync resulting in misdetection of device due to incorrectly
initialized SCR access flag.

This patch make probe_ent alloc/init happen after the final port flags
value is determined.  This is fragile but probe_ent and all the
related mess are scheduled to go away soon for exactly this reason.
We just need to hold everything together till then.

This has been spotted and diagnosed by Patrick McHardy.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Patric McHardy <kaber@trash.net>
---
Patrick, can you test this patch and post result?

Jeff, please don't apply this patch till Patrick acks it.

Thanks.

--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -240,7 +240,7 @@ static int sis_init_one (struct pci_dev 
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 	u32 genctl;
-	struct ata_port_info *ppi[2];
+	struct ata_port_info pi = sis_port_info, *ppi[2] = { &pi, &pi };
 	int pci_dev_busy = 0;
 	u8 pmr;
 	u8 port2_start;
@@ -265,27 +265,20 @@ static int sis_init_one (struct pci_dev 
 	if (rc)
 		goto err_out_regions;
 
-	ppi[0] = ppi[1] = &sis_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-	if (!probe_ent) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
-
 	/* check and see if the SCRs are in IO space or PCI cfg space */
 	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
 	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
-		probe_ent->port_flags |= SIS_FLAG_CFGSCR;
+		pi.flags |= SIS_FLAG_CFGSCR;
 
 	/* if hardware thinks SCRs are in IO space, but there are
 	 * no IO resources assigned, change to PCI cfg space.
 	 */
-	if ((!(probe_ent->port_flags & SIS_FLAG_CFGSCR)) &&
+	if ((!(pi.flags & SIS_FLAG_CFGSCR)) &&
 	    ((pci_resource_start(pdev, SIS_SCR_PCI_BAR) == 0) ||
 	     (pci_resource_len(pdev, SIS_SCR_PCI_BAR) < 128))) {
 		genctl &= ~GENCTL_IOMAPPED_SCR;
 		pci_write_config_dword(pdev, SIS_GENCTL, genctl);
-		probe_ent->port_flags |= SIS_FLAG_CFGSCR;
+		pi.flags |= SIS_FLAG_CFGSCR;
 	}
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
@@ -306,6 +299,12 @@ static int sis_init_one (struct pci_dev 
 		port2_start = 0x20;
 	}
 
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	if (!probe_ent) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+
 	if (!(probe_ent->port_flags & SIS_FLAG_CFGSCR)) {
 		probe_ent->port[0].scr_addr =
 			pci_resource_start(pdev, SIS_SCR_PCI_BAR);

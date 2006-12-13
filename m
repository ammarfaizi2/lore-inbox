Return-Path: <linux-kernel-owner+w=401wt.eu-S932661AbWLMLL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWLMLL7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWLMLL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:11:59 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45425 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932661AbWLMLL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:11:58 -0500
Date: Wed, 13 Dec 2006 11:20:04 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "David Shirley" <tephra@gmail.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: SATA DMA problem (sata_uli)
Message-ID: <20061213112004.59cb186c@localhost.localdomain>
In-Reply-To: <f0e65c090612122102o327ac693u2f24a74a9ba973ef@mail.gmail.com>
References: <f0e65c090612122102o327ac693u2f24a74a9ba973ef@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tracked it down to one of the drives being forced into PIO4 mode
> rather than UDMA mode; dmesg bits:
> ata4.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 0/32)
> ata4.00: ata4: dev 0 multi count 16
> ata4.00: simplex DMA is claimed by other device, disabling DMA

Your ULi controller is reporting that it supports UDMA upon only one
channel at a time. The kernel is honouring this information. The older
ULi (was ALi) PATA devices report simplex but let you turn it off so see 
if the following does the trick. Test carefully as always with disk driver
changes.

(Jeff probably best to check the docs before merging this but I believe
it is sane)

Signed-off-by: Alan Cox <alan@redhat.com>

--- drivers/ata/sata_uli.c~	2006-12-13 10:53:58.848881256 +0000
+++ drivers/ata/sata_uli.c	2006-12-13 10:53:58.848881256 +0000
@@ -211,6 +211,8 @@
 	if (rc)
 		goto err_out_regions;
 
+	ata_pci_clear_simplex(pdev);
+
 	ppi[0] = ppi[1] = &uli_port_info;
 	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent) {

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVBWUpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVBWUpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVBWUpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:45:46 -0500
Received: from mx1.mail.ru ([194.67.23.121]:24615 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261566AbVBWUp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:45:26 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [BK PATCHES] 2.6.x libata fixes (mostly)
Date: Wed, 23 Feb 2005 23:45:23 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mark Lord <mlord@pobox.com>
References: <421CE018.5030007@pobox.com>
In-Reply-To: <421CE018.5030007@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200502232345.23666.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 February 2005 21:57, Jeff Garzik wrote:

> This BK push includes additional hardware support, but that's only 
> because it's (a) obviously low impact and (b) it was in the queue.

> --- a/drivers/scsi/ahci.c
> +++ b/drivers/scsi/ahci.c

> +static u8 ahci_check_err(struct ata_port *ap)
> +{
> +	void *mmio = (void *) ap->ioaddr.cmd_addr;

void __iomem *

> +	return (readl(mmio + PORT_TFDATA) >> 8) & 0xFF;

> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c

> + *	ata_qc_free - free unused ata_queued_cmd
> + *	@qc: Command to complete

"Command to free"?

--- /dev/null
+++ b/drivers/scsi/sata_qstor.c

> +	u8 *prd = pp->pkt + QS_CPB_BYTES;

> +	for (nelem = 0; nelem < qc->n_elem; nelem++,sg++) {
> +		u64 addr;
> +		u32 len;

> +		addr = sg_dma_address(sg);
> +		*(u64 *)prd = cpu_to_le64(addr);

*(__le64 *) prd

> +		prd += sizeof(u64);

> +		len = sg_dma_len(sg);
> +		*(u32 *)prd = cpu_to_le32(len);

*(__le32 *) prd

> +		prd += sizeof(u64);

Should this be "prd += sizeof(u32)"? Looks suspicious.

> +static void qs_qc_prep(struct ata_queued_cmd *qc)
> +{

> +	*(u32 *)(&buf[ 4]) = cpu_to_le32(qc->nsect * ATA_SECT_SIZE);
> +	*(u32 *)(&buf[ 8]) = cpu_to_le32(qc->n_elem);

> +	*(u64 *)(&buf[16]) = cpu_to_le64(addr);

__le* again...

> +static void qs_ata_setup_port(struct ata_ioports *port, unsigned long base)
> +{
> +	port->cmd_addr		=

> +	port->error_addr	=

> +	port->status_addr	=

> +	port->altstatus_addr	=

Oo-oops...

> +static int qs_set_dma_masks(struct pci_dev *pdev, void __iomem *mmio_base)
> +{

> +	if (have_64bit_bus &&
> +	    !pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
> +		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
> +		if (rc) {
> +			rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);

We already have DMA_{32,64}BIT_MASK.

> +	} else {
> +		rc = pci_set_dma_mask(pdev, 0xffffffffULL);

> +		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);

	Alexey

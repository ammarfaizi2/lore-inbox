Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbUBELKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 06:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUBELKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 06:10:31 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:12557 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264510AbUBELK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 06:10:27 -0500
Date: Thu, 5 Feb 2004 11:10:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: mikem@beardog.cca.cpqcorp.net
Cc: axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cciss updates for 2.6 [1 of 11]
Message-ID: <20040205111022.A31248@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	mikem@beardog.cca.cpqcorp.net, axboe@suse.de, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402041737080.18320@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0402041737080.18320@beardog.cca.cpqcorp.net>; from mikem@beardog.cca.cpqcorp.net on Wed, Feb 04, 2004 at 06:04:46PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 06:04:46PM -0600, mikem@beardog.cca.cpqcorp.net wrote:
> +static int find_PCI_BAR_index(struct pci_dev *pdev,
> +				unsigned long pci_bar_addr)
> +{
> +	int i, offset, mem_type, bar_type;
> +	if (pci_bar_addr == PCI_BASE_ADDRESS_0) /* looking for BAR zero? */
> +		return 0;
> +	offset = 0;
> +	for (i=0; i<DEVICE_COUNT_RESOURCE; i++) {
> +		bar_type = pci_resource_flags(pdev, i) &
> +			PCI_BASE_ADDRESS_SPACE;
> +		if (bar_type == PCI_BASE_ADDRESS_SPACE_IO)
> +			offset += 4;
> +		else {
> +			mem_type = pci_resource_flags(pdev, i) &
> +				PCI_BASE_ADDRESS_MEM_TYPE_MASK;
> +			switch (mem_type) {
> +				case PCI_BASE_ADDRESS_MEM_TYPE_32:
> +				case PCI_BASE_ADDRESS_MEM_TYPE_1M:
> +					offset += 4; /* 32 bit */
> +					break;
> +				case PCI_BASE_ADDRESS_MEM_TYPE_64:
> +					offset += 8;
> +					break;
> +				default: /* reserved in PCI 2.2 */
> +					printk(KERN_WARNING "Base address is invalid\n");
> +			       		return -1;
> +				break;
> +			}
> +		}
> + 		if (offset == pci_bar_addr - PCI_BASE_ADDRESS_0)
> +			return i+1;
> +	}
> +	return -1;
> +}

Urgg, this stuff looks extremly kludgy.  What's missing from pci_request_regions
for you?


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUANJZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUANJYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:24:23 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:33038 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265294AbUANJWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:22:10 -0500
Date: Wed, 14 Jan 2004 09:22:05 +0000
From: "'hch@infradead.org'" <hch@infradead.org>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'hch@infradead.org'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       "'marcelo.tosatti@cyclades.com'" <marcelo.tosatti@cyclades.com>,
       Matt_Domsch@dell.com
Subject: Re: ANNOUNCE: megaraid driver version 2.10.1
Message-ID: <20040114092205.B28333@infradead.org>
Mail-Followup-To: "'hch@infradead.org'" <hch@infradead.org>,
	"Mukker, Atul" <Atulm@lsil.com>,
	'James Bottomley' <James.Bottomley@SteelEye.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org,
	"'marcelo.tosatti@cyclades.com'" <marcelo.tosatti@cyclades.com>,
	Matt_Domsch@dell.com
References: <0E3FA95632D6D047BA649F95DAB60E57033BC2C3@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC2C3@exa-atlanta.se.lsil.com>; from Atulm@lsil.com on Tue, Jan 13, 2004 at 04:39:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 04:39:12PM -0500, Mukker, Atul wrote:
> The changes in 2.6.1 are rather extensive, so it would be sometime before
> kernel 2.6.1 version of megaraid is sync'ed against megaraid-2.10.1. Also,
> we would like to backport the PCI hotplug changes to 2.4.x kernel megaraid
> as well.

The problem with backporting is that the 2.4 scsi layer is not hot-plug aware,
so while you can make the driver detect a newly inserted or removed HBA there's
no way to tell the SCSI midlayer.

> +#ifdef SCSI_HAS_HOST_LOCK
> +#  if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,9)
> +		/* This is the Red Hat AS2.1 kernel */
> +		adapter->host_lock = &adapter->lock;
> +		host->lock = adapter->host_lock;
> +#  elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
> +		/* This is the later Red Hat 2.4 kernels */
> +		adapter->host_lock = &adapter->lock;
> +		host->host_lock = adapter->host_lock;
> +#  else
> +		/* This is the 2.6 and later kernel series */
> +		adapter->host_lock = &adapter->lock;
> +		scsi_set_host_lock(&adapter->lock);
> +#  endif
> +#else
> +		/* And this is the remainder of the 2.4 kernel series */
>  		adapter->host_lock = &io_request_lock;
> +#endif

This is horribly ugly, but not your faul.  Any chance you could hide
it into some macro ala megaraid_set_host_lock(adapter, host).

Also note that in 2.6 scsi_set_host_lock should and could easily be avoided,
just let your adapter->host_lock point to host->host_lock.

>  		if((adapter->flag & BOARD_64BIT)&&(sizeof(dma_addr_t) == 8))
> {
> -			pci_set_dma_mask(pdev, 0xffffffffffffffff);
> +			pci_set_dma_mask(pdev, 0xffffffffffffffffULL);

This needs error return checking.  Again this no regression from the previous
version, could you please fix it in the next update?


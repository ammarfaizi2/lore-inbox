Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUEVQCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUEVQCK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 12:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUEVQCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 12:02:10 -0400
Received: from canuck.infradead.org ([205.233.217.7]:35337 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261604AbUEVQCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 12:02:07 -0400
Date: Sat, 22 May 2004 12:02:05 -0400
From: hch@infradead.org
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com, akpm@osdl.org
Subject: Re: PATCH: Stop megaraid trashing other i960 based devices
Message-ID: <20040522160205.GA8643@infradead.org>
Mail-Followup-To: hch@infradead.org, Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com,
	akpm@osdl.org
References: <20040522154659.GA17320@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522154659.GA17320@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 11:46:59AM -0400, Alan Cox wrote:
> --- drivers/scsi/megaraid.c~	2004-05-22 16:34:01.976198176 +0100
> +++ drivers/scsi/megaraid.c	2004-05-22 16:38:58.176168936 +0100
> @@ -4609,6 +4609,21 @@
>  
>  	pci_bus = pdev->bus->number;
>  	pci_dev_func = pdev->devfn;
> +	
> +	if(pdev->vendor == PCI_VENDOR_ID_INTEL)		/* The megaraid3 stuff reports the id of the intel
> +							   part which is not remotely specific to the megaraid */
> +	{
> +		u16 magic;
> +		/* Don't fall over the Compaq management cards using the same PCI identifier */
> +		if(pdev->subsystem_vendor == PCI_VENDOR_ID_COMPAQ &&
> +		   pdev->subsystem_device == 0xC000)
> +		   	return -ENODEV;
> +		/* Now check the magic signature byte */
> +		pci_read_config_word(pdev, PCI_CONF_AMISIG, &magic);
> +		if(magic != HBA_SIGNATURE_471 && magic != HBA_SIGNATURE)
> +			return -ENODEV;
> +		/* Ok it is probably a megaraid */
> +	}

I think we should add all valid subvendor ids to the pci_id table instead.
Especially to not consude the hotplug package.


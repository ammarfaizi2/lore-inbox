Return-Path: <linux-kernel-owner+w=401wt.eu-S1751107AbXACT76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbXACT76 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbXACT76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:59:58 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:58075 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751107AbXACT75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:59:57 -0500
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
	v2.6.20-rc3 released))
From: Steve Wise <swise@opengridcomputing.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20070102115834.1e7644b2@localhost.localdomain>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	 <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	 <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
	 <459973F6.2090201@pobox.com>
	 <20070102115834.1e7644b2@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 13:59:57 -0600
Message-Id: <1167854397.4187.49.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 11:58 +0000, Alan wrote:

...

> 
> I'm sending this now rather than after running full test suites so that
> it can get the maximal testing in a short time. I'll be running tests on
> this after lunch. 
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> --- linux.vanilla-2.6.20-rc3/drivers/ata/libata-sff.c	2007-01-01 21:43:27.000000000 +0000
> +++ linux-2.6.20-rc3/drivers/ata/libata-sff.c	2007-01-02 11:15:53.000000000 +0000
> @@ -1027,13 +1027,15 @@
>  #endif
>  	}
>  
> -	rc = pci_request_regions(pdev, DRV_NAME);
> -	if (rc) {
> -		disable_dev_on_err = 0;
> -		goto err_out;
> -	}
> -
> -	if (legacy_mode) {
> +	if (!legacy_mode) {
> +		rc = pci_request_regions(pdev, DRV_NAME);
> +		if (rc) {
> +			disable_dev_on_err = 0;
> +			goto err_out;
> +		}
> +	} else {
> +		/* Deal with combined mode hack. This side of the logic all
> +		   goes away once the combined mode hack is killed in 2.6.21 */
>  		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
>  			struct resource *conflict, res;
>  			res.start = ATA_PRIMARY_CMD;
> @@ -1071,6 +1073,13 @@
>  			}
>  		} else
>  			legacy_mode |= ATA_PORT_SECONDARY;
> +
> +		if (legacy_mode & ATA_PORT_PRIMARY)
> +			pci_request_region(pdev, 1, DRV_NAME);
> +		if (legacy_mode & ATA_PORT_SECONDARY)
> +			pci_request_region(pdev, 3, DRV_NAME);
> +		/* If there is a DMA resource, allocate it */
> +		pci_request_region(pdev, 4, DRV_NAME);
>  	}
>  
>  	/* we have legacy mode, but all ports are unavailable */
> @@ -1114,11 +1123,20 @@
>  err_out_ent:
>  	kfree(probe_ent);
>  err_out_regions:
> -	if (legacy_mode & ATA_PORT_PRIMARY)
> -		release_region(ATA_PRIMARY_CMD, 8);
> -	if (legacy_mode & ATA_PORT_SECONDARY)
> -		release_region(ATA_SECONDARY_CMD, 8);
> -	pci_release_regions(pdev);
> +	/* All this conditional stuff is needed for the combined mode hack
> +	   until 2.6.21 when it can go */
> +	if (legacy_mode) {
> +		pci_release_region(pdev, 4);
> +		if (legacy_mode & ATA_PORT_PRIMARY) {
> +			release_region(ATA_PRIMARY_CMD, 8);
> +			pci_release_region(pdev, 1);
> +		}
> +		if (legacy_mode & ATA_PORT_SECONDARY) {
> +			release_region(ATA_SECONDARY_CMD, 8);
> +			pci_release_region(pdev, 3);
> +		}
> +	} else
> +		pci_release_regions(pdev);
>  err_out:
>  	if (disable_dev_on_err)
>  		pci_disable_device(pdev);

This patch works for me too.

Steve.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbVLRMEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbVLRMEz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 07:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVLRMEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 07:04:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:32393 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932694AbVLRMEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 07:04:54 -0500
Subject: Re: IT821x driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kernel - Noah Blumenfeld <kernel@fireether.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43A54683.3030202@fireether.net>
References: <43A54683.3030202@fireether.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Dec 2005 12:05:08 +0000
Message-Id: <1134907508.26141.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-12-18 at 06:22 -0500, Kernel - Noah Blumenfeld wrote:
> As far as I can tell - and from the information within the driver's file 
>   /drivers/ide/pci/it821x.c - the current driver does not support mwdma 
> or dma, only udma. It also says that if - and I quote Alan Cox -

The 2.6.14 kernel has a version of the driver built in that should
support all modes properly. In hardware raid mode DMA mode selection is
handled by the controller and we actually don't deal with it.

In pass through/atapi supporting mode we handle the mode selection and
support MWDMA/UDMA. The chip is really designed to be best for UDMA (as
you'd expect) but does handle other modes.

> Is there a way to restrict the size of the files being written by the 
> kernel to a hardware device? I.e. make it so it will not write LBA48 


We do the following in init_hwif_it821x already

    if(conf & 1) {
                idev->smart = 1;
                hwif->atapi_dma = 0;
                /* Long I/O's although allowed in LBA48 space cause the
                   onboard firmware to enter the twighlight zone */
                hwif->rqsize = 256;
        }

So the driver should be doing this correctly. Also for DMA on the smart
mode, use hdparm -d1, but don't try and program the drives - that is
handled by the controller and that may be upsetting it. Let me know if
that helps.

If you are doing raid0 btw its faster in non-raid mode and using
software raid. In raid1 it seems to be faster to use the chip in smart
mode.

Alan


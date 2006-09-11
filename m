Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbWIKXxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWIKXxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWIKXxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:53:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:65123 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965176AbWIKXxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:53:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TXCQ0DAFhS5zagZ+7bG2NrlVSmp/Pb13yonwoT4cBUPWH8IIM45fqRrS1kt6blqR2XjLGIowim1M7pIWMAFN8Loqy4G40HWQlkMv8rLSe3EgGqOW/O7Ht0DvEyb5vK8izK6u12zxUZWSoQa7oLSsD7c8DvK4KDltsZs6Oy11VPU=
Message-ID: <e9c3a7c20609111653v29cd4609hd0584ae300b735b7@mail.gmail.com>
Date: Mon, 11 Sep 2006 16:53:01 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
Cc: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
In-Reply-To: <4505F358.3040204@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	 <4505F358.3040204@garzik.org>
X-Google-Sender-Auth: dbee0d040e22c362
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/06, Jeff Garzik <jeff@garzik.org> wrote:
> Dan Williams wrote:
> > Neil,
> >
> > The following patches implement hardware accelerated raid5 for the Intel
> > Xscale(r) series of I/O Processors.  The MD changes allow stripe
> > operations to run outside the spin lock in a work queue.  Hardware
> > acceleration is achieved by using a dma-engine-aware work queue routine
> > instead of the default software only routine.
> >
> > Since the last release of the raid5 changes many bug fixes and other
> > improvements have been made as a result of stress testing.  See the per
> > patch change logs for more information about what was fixed.  This
> > release is the first release of the full dma implementation.
> >
> > The patches touch 3 areas, the md-raid5 driver, the generic dmaengine
> > interface, and a platform device driver for IOPs.  The raid5 changes
> > follow your comments concerning making the acceleration implementation
> > similar to how the stripe cache handles I/O requests.  The dmaengine
> > changes are the second release of this code.  They expand the interface
> > to handle more than memcpy operations, and add a generic raid5-dma
> > client.  The iop-adma driver supports dma memcpy, xor, xor zero sum, and
> > memset across all IOP architectures (32x, 33x, and 13xx).
> >
> > Concerning the context switching performance concerns raised at the
> > previous release, I have observed the following.  For the hardware
> > accelerated case it appears that performance is always better with the
> > work queue than without since it allows multiple stripes to be operated
> > on simultaneously.  I expect the same for an SMP platform, but so far my
> > testing has been limited to IOPs.  For a single-processor
> > non-accelerated configuration I have not observed performance
> > degradation with work queue support enabled, but in the Kconfig option
> > help text I recommend disabling it (CONFIG_MD_RAID456_WORKQUEUE).
> >
> > Please consider the patches for -mm.
> >
> > -Dan
> >
> > [PATCH 01/19] raid5: raid5_do_soft_block_ops
> > [PATCH 02/19] raid5: move write operations to a workqueue
> > [PATCH 03/19] raid5: move check parity operations to a workqueue
> > [PATCH 04/19] raid5: move compute block operations to a workqueue
> > [PATCH 05/19] raid5: move read completion copies to a workqueue
> > [PATCH 06/19] raid5: move the reconstruct write expansion operation to a workqueue
> > [PATCH 07/19] raid5: remove compute_block and compute_parity5
> > [PATCH 08/19] dmaengine: enable multiple clients and operations
> > [PATCH 09/19] dmaengine: reduce backend address permutations
> > [PATCH 10/19] dmaengine: expose per channel dma mapping characteristics to clients
> > [PATCH 11/19] dmaengine: add memset as an asynchronous dma operation
> > [PATCH 12/19] dmaengine: dma_async_memcpy_err for DMA engines that do not support memcpy
> > [PATCH 13/19] dmaengine: add support for dma xor zero sum operations
> > [PATCH 14/19] dmaengine: add dma_sync_wait
> > [PATCH 15/19] dmaengine: raid5 dma client
> > [PATCH 16/19] dmaengine: Driver for the Intel IOP 32x, 33x, and 13xx RAID engines
> > [PATCH 17/19] iop3xx: define IOP3XX_REG_ADDR[32|16|8] and clean up DMA/AAU defs
> > [PATCH 18/19] iop3xx: Give Linux control over PCI (ATU) initialization
> > [PATCH 19/19] iop3xx: IOP 32x and 33x support for the iop-adma driver
>
> Can devices like drivers/scsi/sata_sx4.c or drivers/scsi/sata_promise.c
> take advantage of this?  Promise silicon supports RAID5 XOR offload.
>
> If so, how?  If not, why not?  :)
This is a frequently asked question, Alan Cox had the same one at OLS.
 The answer is "probably."  The only complication I currently see is
where/how the stripe cache is maintained.  With the IOPs its easy
because the DMA engines operate directly on kernel memory.  With the
Promise card I believe they have memory on the card and it's not clear
to me if the XOR engines on the card can deal with host memory.  Also,
MD would need to be modified to handle a stripe cache located on a
device, or somehow synchronize its local cache with card in a manner
that is still able to beat software only MD.

>         Jeff

Dan

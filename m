Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWIKXAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWIKXAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWIKXAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:00:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:31088 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S932316AbWIKXAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:00:34 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="128862105:sNHT109520978"
Subject: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
From: Dan Williams <dan.j.williams@intel.com>
To: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Sep 2006 16:00:32 -0700
Message-Id: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

The following patches implement hardware accelerated raid5 for the Intel
Xscale® series of I/O Processors.  The MD changes allow stripe
operations to run outside the spin lock in a work queue.  Hardware
acceleration is achieved by using a dma-engine-aware work queue routine
instead of the default software only routine.

Since the last release of the raid5 changes many bug fixes and other
improvements have been made as a result of stress testing.  See the per
patch change logs for more information about what was fixed.  This
release is the first release of the full dma implementation.

The patches touch 3 areas, the md-raid5 driver, the generic dmaengine
interface, and a platform device driver for IOPs.  The raid5 changes
follow your comments concerning making the acceleration implementation
similar to how the stripe cache handles I/O requests.  The dmaengine
changes are the second release of this code.  They expand the interface
to handle more than memcpy operations, and add a generic raid5-dma
client.  The iop-adma driver supports dma memcpy, xor, xor zero sum, and
memset across all IOP architectures (32x, 33x, and 13xx).

Concerning the context switching performance concerns raised at the
previous release, I have observed the following.  For the hardware
accelerated case it appears that performance is always better with the
work queue than without since it allows multiple stripes to be operated
on simultaneously.  I expect the same for an SMP platform, but so far my
testing has been limited to IOPs.  For a single-processor
non-accelerated configuration I have not observed performance
degradation with work queue support enabled, but in the Kconfig option
help text I recommend disabling it (CONFIG_MD_RAID456_WORKQUEUE).

Please consider the patches for -mm.

-Dan

[PATCH 01/19] raid5: raid5_do_soft_block_ops
[PATCH 02/19] raid5: move write operations to a workqueue
[PATCH 03/19] raid5: move check parity operations to a workqueue
[PATCH 04/19] raid5: move compute block operations to a workqueue
[PATCH 05/19] raid5: move read completion copies to a workqueue
[PATCH 06/19] raid5: move the reconstruct write expansion operation to a workqueue
[PATCH 07/19] raid5: remove compute_block and compute_parity5
[PATCH 08/19] dmaengine: enable multiple clients and operations
[PATCH 09/19] dmaengine: reduce backend address permutations
[PATCH 10/19] dmaengine: expose per channel dma mapping characteristics to clients
[PATCH 11/19] dmaengine: add memset as an asynchronous dma operation
[PATCH 12/19] dmaengine: dma_async_memcpy_err for DMA engines that do not support memcpy
[PATCH 13/19] dmaengine: add support for dma xor zero sum operations
[PATCH 14/19] dmaengine: add dma_sync_wait
[PATCH 15/19] dmaengine: raid5 dma client
[PATCH 16/19] dmaengine: Driver for the Intel IOP 32x, 33x, and 13xx RAID engines
[PATCH 17/19] iop3xx: define IOP3XX_REG_ADDR[32|16|8] and clean up DMA/AAU defs
[PATCH 18/19] iop3xx: Give Linux control over PCI (ATU) initialization
[PATCH 19/19] iop3xx: IOP 32x and 33x support for the iop-adma driver

Note, the iop3xx patches apply against the iop3xx platform code
re-factoring done by Lennert Buytenhek.  His patches are reproduced,
with permission, on the Xscale IOP SourceForge site.

Also available on SourceForge:

Linux Symposium Paper: MD RAID Acceleration Support for Asynchronous
DMA/XOR Engines
http://prdownloads.sourceforge.net/xscaleiop/ols_paper_2006.pdf?download

Tar archive of the patch set
http://prdownloads.sourceforge.net/xscaleiop/md_raid_accel-2.6.18-rc6.tar.gz?download

[PATCH 01/19] http://prdownloads.sourceforge.net/xscaleiop/md-add-raid5-do-soft-block-ops.patch?download
[PATCH 02/19] http://prdownloads.sourceforge.net/xscaleiop/md-move-write-operations-to-a-workqueue.patch?download
[PATCH 03/19] http://prdownloads.sourceforge.net/xscaleiop/md-move-check-parity-operations-to-a-workqueue.patch?download
[PATCH 04/19] http://prdownloads.sourceforge.net/xscaleiop/md-move-compute-block-operations-to-a-workqueue.patch?download
[PATCH 05/19] http://prdownloads.sourceforge.net/xscaleiop/md-move-read-completion-copies-to-a-workqueue.patch?download
[PATCH 06/19] http://prdownloads.sourceforge.net/xscaleiop/md-move-expansion-operations-to-a-workqueue.patch?download
[PATCH 07/19] http://prdownloads.sourceforge.net/xscaleiop/md-remove-compute_block-and-compute_parity5.patch?download
[PATCH 08/19] http://prdownloads.sourceforge.net/xscaleiop/dmaengine-multiple-clients-and-multiple-operations.patch?download
[PATCH 09/19] http://prdownloads.sourceforge.net/xscaleiop/dmaengine-unite-backend-address-types.patch?download
[PATCH 10/19] http://prdownloads.sourceforge.net/xscaleiop/dmaengine-dma-async-map-page.patch?download
[PATCH 11/19] http://prdownloads.sourceforge.net/xscaleiop/dmaengine-dma-async-memset.patch?download
[PATCH 12/19] http://prdownloads.sourceforge.net/xscaleiop/dmaengine-dma-async-memcpy-err.patch?download
[PATCH 13/19] http://prdownloads.sourceforge.net/xscaleiop/dmaengine-dma-async-zero-sum.patch?download
[PATCH 14/19] http://prdownloads.sourceforge.net/xscaleiop/dmaengine-dma-sync-wait.patch?download
[PATCH 15/19] http://prdownloads.sourceforge.net/xscaleiop/md-raid5-dma-client.patch?download
[PATCH 16/19] http://prdownloads.sourceforge.net/xscaleiop/iop-adma-device-driver.patch?download
[PATCH 17/19] http://prdownloads.sourceforge.net/xscaleiop/iop3xx-register-macro-cleanup.patch?download
[PATCH 18/19] http://prdownloads.sourceforge.net/xscaleiop/iop3xx-pci-initialization.patch?download
[PATCH 19/19] http://prdownloads.sourceforge.net/xscaleiop/iop3xx-adma-support.patch?download

Optimal performance on IOPs is obtained with:
CONFIG_MD_RAID456_WORKQUEUE=y
CONFIG_MD_RAID5_HW_OFFLOAD=y
CONFIG_RAID5_DMA=y
CONFIG_INTEL_IOP_ADMA=y

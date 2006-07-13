Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWGMXwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWGMXwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWGMXwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:52:41 -0400
Received: from aun.it.uu.se ([130.238.12.36]:34278 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1161053AbWGMXwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:52:40 -0400
Date: Fri, 14 Jul 2006 01:52:34 +0200 (MEST)
Message-Id: <200607132352.k6DNqYJJ005697@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: jgarzik@pobox.com
Subject: [BUG] sata_promise unaligned PCI accesses on sparc64
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After installing a Promise SATA300 TX2 PLUS PCI card
in a sparc64 (Ultra5) machine, the kernel complains
about three unaligned accesses during boot:

Kernel unaligned access at TPC[55c050] pdc_host_init+0x84/0xe8
Kernel unaligned access at TPC[55c074] pdc_host_init+0xa8/0xe8
Kernel unaligned access at TPC[55c094] pdc_host_init+0xc8/0xe8

Those unaligned accesses are the reads from and write to
PDC_TBG_MODE in sata_promise.c:pdc_host_init():

	/* reduce TBG clock to 133 Mhz. */
	tmp = readl(mmio + PDC_TBG_MODE);
	tmp &= ~0x30000; /* clear bit 17, 16*/
	tmp |= 0x10000;  /* set bit 17:16 = 0:1 */
	writel(tmp, mmio + PDC_TBG_MODE);

	readl(mmio + PDC_TBG_MODE);	/* flush */

Looking into this I found two strange facts:
- PDC_TBG_MODE is at offset 0x41, which clearly can never
  be 32-bit aligned.
- The 4-byte range for PDC_TBG_MODE intersects both
  PDC_INT_SEQMASK and PDC_FLASH_CTL.

Admittedly I know very little about PCI device programming,
but this doesn't look right.

/Mikael

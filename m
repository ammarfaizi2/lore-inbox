Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVJ0Rrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVJ0Rrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 13:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVJ0Rrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 13:47:40 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:15050 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751347AbVJ0Rrk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 13:47:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=htHe1czxAuOSSih8rEgR2KO/huGVJVuQ9w7ibdMLwBy9dpHKi89zf01/2WvvQJYTEreyQihOhg53GicygLHNrMzOipAY/pUqdcKVP1BEj7o99Wwx1cOby3Lz1bKsIaOQVPeIubthFaKte0W3N73Hn3UUaRuGI70hhQReDPQGq7M=
Message-ID: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com>
Date: Thu, 27 Oct 2005 10:47:38 -0700
From: Michael Madore <michael.madore@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PCI-DMA: high address but no IOMMU
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing the following errors in /var/log/messages when booting
2.6.14-rc5 on a dual Opteron nforce4 motherboard with 8GB of RAM:

Checking aperture...
CPU 0: aperture @ be8c000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000

...

PCI-DMA: Disabling AGP.
PCI-DMA: More than 4GB of RAM and no IOMMU
PCI-DMA: 32bit PCI IO may malfunction.<6>PCI-DMA: Disabling IOMMU.

...

Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
Kernel panic - not syncing: PCI-DMA: high address but no IOMMU.

With 2.6.13, the systems boots OK with these messages in the log:

Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000

...

PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture

Using git bisect, I narrowed the problem down to the following commit:

6142891a0c0209c91aa4a98f725de0d6e2ed4918 is first bad commit
diff-tree 6142891a0c0209c91aa4a98f725de0d6e2ed4918 (from
357e11d4cbbbb959a88a9bdbbf33a10f160b0823)
Author: Andi Kleen <ak@suse.de>
Date:   Mon Sep 12 18:49:24 2005 +0200

    [PATCH] x86-64: Avoid unnecessary double bouncing for swiotlb

    PCI_DMA_BUS_IS_PHYS has to be zero even when the GART IOMMU is disabled
    and the swiotlb is used. Otherwise the block layer does unnecessary
    double bouncing.

    Signed-off-by: Andi Kleen <ak@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 d704d51d1e05f508f09c4388d3199cafbb9e3018
6a40204fd8b954634f2f7ea8f84861ed0a4bd88e M      include

Reverting this change allows 2.6.14-rc5 to boot.

Mike

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWD1ATJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWD1ATJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWD1ATI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:19:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28117 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751818AbWD1ATF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:19:05 -0400
Date: Thu, 27 Apr 2006 17:17:32 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       mikew@google.com, Andi Kleen <ak@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 05/24] x86_64: Fix a race in the free_iommu path.
Message-ID: <20060428001732.GF18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="x86_64-fix-a-race-in-the-free_iommu-path.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Mike Waychison <mikew@google.com>

We do this by removing a micro-optimization that tries to avoid grabbing
the iommu_bitmap_lock spinlock and using a bus-locked operation.

This still races with other simultaneous alloc_iommu or free_iommu(size
> 1) which both use bus-unlocked operations. 

The end result of this race is eventually ending
up with an iommu_gart_bitmap that has bits errornously set all over,
making large contiguous iommu space allocations fail with 'PCI-DMA:
Out of IOMMU space'.

Signed-off-by: Mike Waychison <mikew@google.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/x86_64/kernel/pci-gart.c |    4 ----
 1 file changed, 4 deletions(-)

--- linux-2.6.16.11.orig/arch/x86_64/kernel/pci-gart.c
+++ linux-2.6.16.11/arch/x86_64/kernel/pci-gart.c
@@ -114,10 +114,6 @@ static unsigned long alloc_iommu(int siz
 static void free_iommu(unsigned long offset, int size)
 { 
 	unsigned long flags;
-	if (size == 1) { 
-		clear_bit(offset, iommu_gart_bitmap); 
-		return;
-	}
 	spin_lock_irqsave(&iommu_bitmap_lock, flags);
 	__clear_bit_string(iommu_gart_bitmap, offset, size);
 	spin_unlock_irqrestore(&iommu_bitmap_lock, flags);

--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423437AbWJZGG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423437AbWJZGG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 02:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423439AbWJZGG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 02:06:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26538
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423437AbWJZGG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 02:06:56 -0400
Date: Wed, 25 Oct 2006 23:06:52 -0700 (PDT)
Message-Id: <20061025.230652.71090033.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 oops on shutdown
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061025.005134.74748405.davem@davemloft.net>
References: <20061024.175751.07640578.davem@davemloft.net>
	<20061025.005134.74748405.davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 25 Oct 2006 00:51:34 -0700 (PDT)

> It's probably some sparc64 issue, maybe even some error wrt.  freeing
> up init memory.  I'll try to track it down.  I'm actually quite
> curious what this bug is :-)

Yep, a sparc64 bug, I'll push this to Linus shortly...

commit 2506be0657c7bd1befdb616fb0e86d87c6a288cd
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Wed Oct 25 22:33:07 2006 -0700

    [SPARC64]: Fix memory corruption in pci_4u_free_consistent().
    
    The second argument to free_npages() was being incorrectly
    calculated, which would thus access far past the end of the
    arena->map[] bitmap.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/kernel/pci_iommu.c b/arch/sparc64/kernel/pci_iommu.c
index 82e5455..2e7f142 100644
--- a/arch/sparc64/kernel/pci_iommu.c
+++ b/arch/sparc64/kernel/pci_iommu.c
@@ -281,7 +281,7 @@ static void pci_4u_free_consistent(struc
 
 	spin_lock_irqsave(&iommu->lock, flags);
 
-	free_npages(iommu, dvma, npages);
+	free_npages(iommu, dvma - iommu->page_table_map_base, npages);
 
 	spin_unlock_irqrestore(&iommu->lock, flags);
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWG1Dkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWG1Dkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWG1Dkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:40:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6814
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751865AbWG1Dke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:40:34 -0400
Date: Thu, 27 Jul 2006 20:38:59 -0700 (PDT)
Message-Id: <20060727.203859.74749067.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060727.181356.71087770.davem@davemloft.net>
References: <200607060937.k669bZT3017256@harpo.it.uu.se>
	<20060707.000524.112600047.davem@davemloft.net>
	<20060727.181356.71087770.davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 27 Jul 2006 18:13:56 -0700 (PDT)

> If the process actually tries to write to the mapping, the page fault
> path will set the two bits that actually enable writes, namely the
> HW-writable bit and the SW-dirty bit.
> 
> This occurs when pte_mkdirty() is called on the PTE during the
> execution of mm/memory.c:handle_pte_fault(), right here:
> 
> 	if (write_access) {
> 		if (!pte_write(entry))
> 			return do_wp_page(mm, vma, address,
> 					pte, pmd, ptl, entry);
> 		entry = pte_mkdirty(entry);
> 	}
> 
> pte_write() will return true, since the SW-writable bit is set.  So we
> don't should not invoke do_wp_page(), and we'll just set the dirty bit
> on the existing PTE.

I just confirmed that this is working properly with a debugging
patch included below.

Mikael, can you put this debugging patch into a kernel that exhibits
the problem and post all the "FAULT: " debugging messages that appear
in your kernel log when the problem happens?

Thanks a lot.

diff --git a/mm/memory.c b/mm/memory.c
index 109e986..b129ae4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2270,6 +2270,12 @@ static inline int handle_pte_fault(struc
 	spinlock_t *ptl;
 
 	old_entry = entry = *pte;
+#if 1
+	if (pte_val(old_entry) & _PAGE_E_4U) {
+		printk("FAULT: write(%d) old_entry[%016lx]\n",
+		       write_access, pte_val(old_entry));
+	}
+#endif
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
 			if (!vma->vm_ops || !vma->vm_ops->nopage)
@@ -2311,6 +2317,12 @@ static inline int handle_pte_fault(struc
 			flush_tlb_page(vma, address);
 	}
 unlock:
+#if 1
+	if (pte_val(old_entry) & _PAGE_E_4U) {
+		printk("FAULT: After, entry[%016lx]\n",
+		       pte_val(entry));
+	}
+#endif
 	pte_unmap_unlock(pte, ptl);
 	return VM_FAULT_MINOR;
 }

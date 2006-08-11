Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWHKJRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWHKJRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWHKJRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:17:06 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:53933 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750975AbWHKJRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:17:05 -0400
Date: Fri, 11 Aug 2006 02:17:04 -0700
Message-Id: <200608110917.k7B9H3Zw023324@zach-dev.vmware.com>
Subject: [PATCH 1/9] 00mm1 remove read hazard from cow.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:17:04.0301 (UTC) FILETIME=[E90D55D0:01C6BD26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to read PTEs directly like this after they have been
modified, as a lazy MMU implementation of direct page tables may not
have written the updated PTE back to memory yet.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: linux-mm@kvack.org

---
 mm/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


===================================================================
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -466,7 +466,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	 */
 	if (is_cow_mapping(vm_flags)) {
 		ptep_set_wrprotect(src_mm, addr, src_pte);
-		pte = *src_pte;
+		pte = pte_wrprotect(pte);
 	}
 
 	/*

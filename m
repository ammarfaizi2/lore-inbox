Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWHKJ3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWHKJ3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWHKJ3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:29:51 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:43919 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751060AbWHKJ3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:29:50 -0400
Date: Fri, 11 Aug 2006 02:15:19 -0700
Message-Id: <200608110915.k7B9FJxV023257@zach-dev.vmware.com>
Subject: [PATCH 1/9] 00mm1 remove read hazard from cow.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, ":"@vmware.com,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:29:49.0486 (UTC) FILETIME=[B1234CE0:01C6BD28]
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

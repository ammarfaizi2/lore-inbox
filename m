Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbUDQFuq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 01:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbUDQFuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 01:50:46 -0400
Received: from holomorphy.com ([207.189.100.168]:34441 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263684AbUDQFug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 01:50:36 -0400
Date: Fri, 16 Apr 2004 22:50:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rmk@arm.linux.org.uk, elf@buici.com
Subject: ARM-related ptep_to_address() fix
Message-ID: <20040417055033.GA5197@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, rmk@arm.linux.org.uk,
	elf@buici.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmk mentioned that ARM was borked as the relation, assumed by generic rmap,
PTRS_PER_PTE*sizeof(pte_t) == PAGE_SIZE, fails to hold. The following patch,
developed jointly with him (or depending on POV, by him with me acting as
codemonkey), is reported to resolve the issue.

Specifically, while ARM dedicates an entire PAGE_SIZE -sized block of
memory to each PTE table, the PTE table itself only spans half that,
the remainder being dedicated to hardware-interpreted structures. As the
hardware structure must be contiguous, wider ptes can't be used. So the
core-visible PTE table only spans PAGE_SIZE/2 bytes, violating the
assumption. This corrects masking and scaling done in ptep_to_address().

I'm aware hugh and andrea's patches address this by blowing away the
dependence on this address calculation altogether, so if anything this
should be considered a stopgap measure if not dropped on account of the
imminent merging of hugh and/or andrea's code.


-- wli


Index: wli-2.6.5-mm6/include/asm-generic/rmap.h
===================================================================
--- wli-2.6.5-mm6.orig/include/asm-generic/rmap.h	2004-04-03 19:37:24.000000000 -0800
+++ wli-2.6.5-mm6/include/asm-generic/rmap.h	2004-04-16 12:21:18.000000000 -0700
@@ -57,7 +57,8 @@
 {
 	struct page * page = kmap_atomic_to_page(ptep);
 	unsigned long low_bits;
-	low_bits = ((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE;
+	low_bits = ((unsigned long)ptep & (PTRS_PER_PTE*sizeof(pte_t) - 1))
+			* (PAGE_SIZE/sizeof(pte_t));
 	return page->index + low_bits;
 }
 

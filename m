Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWE3CyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWE3CyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 22:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWE3CyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 22:54:15 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:57571 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932067AbWE3CyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 22:54:15 -0400
Date: Mon, 29 May 2006 22:52:02 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.17-rc5] i386: fix get_segment_eip() with vm86
  segments
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Zachary Amsden <zach@vmware.com>
Message-ID: <200605292253_MC3-1-C118-FB59@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to check for vm86 mode first before looking at selector
privilege bits.

Segment limit is always base + 64k and only the low 16 bits of
EIP are significant in vm86 mode.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-rc5-32.orig/arch/i386/mm/fault.c
+++ 2.6.17-rc5-32/arch/i386/mm/fault.c
@@ -77,12 +77,15 @@ static inline unsigned long get_segment_
 	unsigned seg = regs->xcs & 0xffff;
 	u32 seg_ar, seg_limit, base, *desc;
 
+	/* Unlikely, but must come before segment checks. */
+	if (unlikely(regs->eflags & VM_MASK)) {
+		base = seg << 4;
+		*eip_limit = base + 0xffff;
+		return base + (eip & 0xffff);
+	}
+
 	/* The standard kernel/user address space limit. */
 	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
-
-	/* Unlikely, but must come before segment checks. */
-	if (unlikely((regs->eflags & VM_MASK) != 0))
-		return eip + (seg << 4);
 	
 	/* By far the most common cases. */
 	if (likely(seg == __USER_CS || seg == __KERNEL_CS))
-- 
Chuck

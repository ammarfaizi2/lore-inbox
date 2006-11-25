Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757833AbWKYFkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757833AbWKYFkv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 00:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757834AbWKYFkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 00:40:51 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:61877 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1757832AbWKYFku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 00:40:50 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       davem@davemloft.net, tom@opengridcomputing.com
Subject: [PATCH] Avoid truncating to 'long' in ALIGN() macro
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 24 Nov 2006 21:40:14 -0800
Message-ID: <adazmag5bk1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Nov 2006 05:40:14.0782 (UTC) FILETIME=[2E8FC5E0:01C71054]
Authentication-Results: sj-dkim-4; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4c8bd7ee ("Do not truncate to 'int' in ALIGN() macro.") was
merged to fix the case of code like the following:

	unsigned long addr;
	unsigned int alignment;
	addr = ALIGN(addr, alignment);

The original ALIGN macro calculated a mask as ~(alignment - 1), and
when alignment is just an int, this creates an int mask.  If alignment
is also unsigned, then this mask will not be sign extended when
promoted to a long, which leads to the code above chopping off the top
half of addr when long is 64 bits.

However, the changed ALIGN macro, which computes the mask as
~(alignment - 1UL) actually breaks code like the following when long
is 32 bits:

	u64 addr;
        int alignment;
        addr = ALIGN(addr, alignment);

The reason this breaks is pretty much the same as the original bug
that the change was supposed to fix: ~(alignment - 1UL) creates a mask
that is an unsigned long, which is unsigned and therefore not sign
extended when promoted to u64 (if long is 32 bits).

I think the right fix is to use 1L instead of 1UL, to avoid the
possibility of turning the mask unsigned by accident.  This will still
fix the original problem, without breaking code that uses ALIGN() the
second way.

This second construct is actually used in the amso1100 driver, so that
driver does not work on 32-bit architectures right now.  Unfortunately
almost everyone using it runs 64-bit kernels, so this regression was
not noticed until now.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---
If it's too late to merge this for 2.6.19, I can work around this in
the amso1100 driver by doing ALIGN(addr, (u64) alignment) instead.
Let me know if I should send that patch.

However I think this should go in for 2.6.20 at least, since I see
only danger with no benefit from having the constant 1 be unsigned.

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 24b6111..cc542d3 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -31,7 +31,7 @@ #define ULLONG_MAX	(~0ULL)
 #define STACK_MAGIC	0xdeadbeef
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#define ALIGN(x,a) (((x)+(a)-1UL)&~((a)-1UL))
+#define ALIGN(x,a) (((x)+(a)-1L)&~((a)-1L))
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))

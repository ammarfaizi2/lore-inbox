Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935546AbWKZTK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935546AbWKZTK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 14:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935549AbWKZTKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 14:10:25 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:52517 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S935546AbWKZTKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 14:10:24 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, tom@opengridcomputing.com
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
X-Message-Flag: Warning: May contain useful information
References: <adazmag5bk1.fsf@cisco.com>
	<20061124.220746.57445336.davem@davemloft.net>
	<adaodqv5e5l.fsf@cisco.com>
	<20061125.150500.14841768.davem@davemloft.net>
	<adak61j5djh.fsf@cisco.com> <20061125164118.de53d1cf.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 26 Nov 2006 11:10:23 -0800
In-Reply-To: <20061125164118.de53d1cf.akpm@osdl.org> (Andrew Morton's message of "Sat, 25 Nov 2006 16:41:18 -0800")
Message-ID: <ada64d23ty8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Nov 2006 19:10:24.0033 (UTC) FILETIME=[86589910:01C7118E]
Authentication-Results: sj-dkim-1; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1002 verified; ); 
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
that is an unsigned long, which is not sign extended when promoted to
u64 (if long is 32 bits).

As suggested by Dave Miller and Al Viro, I fixed this by having the
ALIGN macro make sure the alignment is promoted to the same type as
the value being aligned before doing the negation.

This second construct is actually used in the amso1100 driver, so that
driver does not work on 32-bit architectures right now.  Unfortunately
almost everyone using it runs 64-bit kernels, so this regression was
not noticed until now.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---
Patch updated as suggested by Dave Miller and Al Viro...

can we merge this for 2.6.20?

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 24b6111..80955b3 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -31,7 +31,7 @@ #define ULLONG_MAX	(~0ULL)
 #define STACK_MAGIC	0xdeadbeef
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#define ALIGN(x,a) (((x)+(a)-1UL)&~((a)-1UL))
+#define ALIGN(x,a) ((typeof(x)) (((x) + (a) - 1) & ~((typeof(x)) (a) - 1)))
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))

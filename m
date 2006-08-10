Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWHJUVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWHJUVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWHJUPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:28139 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932121AbWHJTfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:55 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [40/145] i386: Remove const case for rwlocks
Message-Id: <20060810193554.5333A13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:54 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

rwlocks are now out of line, so it near never triggers.  Also it was
incompatible with the new dwarf2 unwinder because it had unannotiatable
push/pops.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-i386/rwlock.h |   40 ++--------------------------------------
 1 files changed, 2 insertions(+), 38 deletions(-)

Index: linux/include/asm-i386/rwlock.h
===================================================================
--- linux.orig/include/asm-i386/rwlock.h
+++ linux/include/asm-i386/rwlock.h
@@ -20,7 +20,7 @@
 #define RW_LOCK_BIAS		 0x01000000
 #define RW_LOCK_BIAS_STR	"0x01000000"
 
-#define __build_read_lock_ptr(rw, helper)   \
+#define __build_read_lock(rw, helper)   \
 	alternative_smp("lock; subl $1,(%0)\n\t" \
 			"jns 1f\n" \
 			"call " helper "\n\t" \
@@ -28,25 +28,7 @@
 			"subl $1,(%0)\n\t", \
 			:"a" (rw) : "memory")
 
-#define __build_read_lock_const(rw, helper)   \
-	alternative_smp("lock; subl $1,%0\n\t" \
-			"jns 1f\n" \
-			"pushl %%eax\n\t" \
-			"leal %0,%%eax\n\t" \
-			"call " helper "\n\t" \
-			"popl %%eax\n\t" \
-			"1:\n", \
-			"subl $1,%0\n\t", \
-			"+m" (*(volatile int *)rw) : : "memory")
-
-#define __build_read_lock(rw, helper)	do { \
-						if (__builtin_constant_p(rw)) \
-							__build_read_lock_const(rw, helper); \
-						else \
-							__build_read_lock_ptr(rw, helper); \
-					} while (0)
-
-#define __build_write_lock_ptr(rw, helper) \
+#define __build_write_lock(rw, helper) \
 	alternative_smp("lock; subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 			"jz 1f\n" \
 			"call " helper "\n\t" \
@@ -54,22 +36,4 @@
 			"subl $" RW_LOCK_BIAS_STR ",(%0)\n\t", \
 			:"a" (rw) : "memory")
 
-#define __build_write_lock_const(rw, helper) \
-	alternative_smp("lock; subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
-			"jz 1f\n" \
-			"pushl %%eax\n\t" \
-			"leal %0,%%eax\n\t" \
-			"call " helper "\n\t" \
-			"popl %%eax\n\t" \
-			"1:\n", \
-			"subl $" RW_LOCK_BIAS_STR ",%0\n\t", \
-			"+m" (*(volatile int *)rw) : : "memory")
-
-#define __build_write_lock(rw, helper)	do { \
-						if (__builtin_constant_p(rw)) \
-							__build_write_lock_const(rw, helper); \
-						else \
-							__build_write_lock_ptr(rw, helper); \
-					} while (0)
-
 #endif

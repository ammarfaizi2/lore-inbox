Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWHaHuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWHaHuc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 03:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWHaHuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 03:50:32 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5507 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751218AbWHaHub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 03:50:31 -0400
Date: Thu, 31 Aug 2006 00:53:22 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i386: rwlock.h fix smp alternatives fix
Message-ID: <20060831075322.GA20873@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This last patch smp alternatives code did not actually compile on
x86 with CONFIG_SMP.  This fixes the __build_read/write_lock helpers.
I've boot tested on SMP.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-i386/rwlock.h |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/include/asm-i386/rwlock.h	Thu Aug 31 06:05:15 2006 +0700
+++ b/include/asm-i386/rwlock.h	Thu Aug 31 03:23:20 2006 -0400
@@ -21,21 +21,21 @@
 #define RW_LOCK_BIAS_STR	"0x01000000"
 
 #define __build_read_lock_ptr(rw, helper)   \
-	asm volatile(LOCK_PREFIX " ; subl $1,(%0)\n\t" \
+	asm volatile(LOCK_PREFIX " subl $1,(%0)\n\t" \
 			"jns 1f\n" \
 			"call " helper "\n\t" \
 			"1:\n" \
-			:"a" (rw) : "memory")
+			::"a" (rw) : "memory")
 
 #define __build_read_lock_const(rw, helper)   \
-	asm volatile(LOCK_PREFIX " ; subl $1,%0\n\t" \
+	asm volatile(LOCK_PREFIX " subl $1,%0\n\t" \
 			"jns 1f\n" \
 			"pushl %%eax\n\t" \
 			"leal %0,%%eax\n\t" \
 			"call " helper "\n\t" \
 			"popl %%eax\n\t" \
-			"1:\n" : \
-			"+m" (*(volatile int *)rw) : : "memory")
+			"1:\n" \
+			:"+m" (*(volatile int *)rw) : : "memory")
 
 #define __build_read_lock(rw, helper)	do { \
 						if (__builtin_constant_p(rw)) \
@@ -45,23 +45,21 @@
 					} while (0)
 
 #define __build_write_lock_ptr(rw, helper) \
-	asm volatile(LOCK_PREFIX " ; subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
+	asm volatile(LOCK_PREFIX " subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 			"jz 1f\n" \
 			"call " helper "\n\t" \
-			"1:\n", \
-			"subl $" RW_LOCK_BIAS_STR ",(%0)\n\t", \
-			:"a" (rw) : "memory")
+			"1:\n" \
+			::"a" (rw) : "memory")
 
 #define __build_write_lock_const(rw, helper) \
-	asm volatile(LOCK_PREFIX " ; subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
+	asm volatile(LOCK_PREFIX " subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
 			"jz 1f\n" \
 			"pushl %%eax\n\t" \
 			"leal %0,%%eax\n\t" \
 			"call " helper "\n\t" \
 			"popl %%eax\n\t" \
-			"1:\n", \
-			"subl $" RW_LOCK_BIAS_STR ",%0\n\t", \
-			"+m" (*(volatile int *)rw) : : "memory")
+			"1:\n" \
+			:"+m" (*(volatile int *)rw) : : "memory")
 
 #define __build_write_lock(rw, helper)	do { \
 						if (__builtin_constant_p(rw)) \

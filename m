Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUETFk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUETFk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 01:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264978AbUETFk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 01:40:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:8384 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264851AbUETFky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 01:40:54 -0400
Subject: [PATCH] ppc64: Fix readq & writeq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085031196.27000.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 May 2004 15:33:16 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew !

This fixes busted asm constraints for readq & writeq implementation
on ppc64 that resulted in garbage beeing generated for writeq (plus
an obvious mistake in the prototype).

Please, apply
Ben.


===== include/asm-ppc64/io.h 1.17 vs edited =====
--- 1.17/include/asm-ppc64/io.h	Sat May 15 12:00:27 2004
+++ edited/include/asm-ppc64/io.h	Wed May 19 16:27:43 2004
@@ -326,7 +326,7 @@
 			     "rldicl %1,%1,32,0\n"
 			     "rlwimi %0,%1,8,8,31\n"
 			     "rlwimi %0,%1,24,16,23\n"
-			     : "=r" (ret), "=r" (tmp) : "b" (addr) , "m" (*addr));
+			     : "=r" (ret) , "=r" (tmp) : "b" (addr) , "m" (*addr));
 	return ret;
 }

@@ -339,7 +339,7 @@
 	return ret;
 }

-static inline void out_le64(volatile unsigned long *addr, int val)
+static inline void out_le64(volatile unsigned long *addr, unsigned long val)
 {
 	unsigned long tmp;

@@ -351,9 +351,9 @@
 			     "rldicl %1,%1,32,0\n"
 			     "rlwimi %0,%1,8,8,31\n"
 			     "rlwimi %0,%1,24,16,23\n"
-			     "std %0,0(%2)\n"
+			     "std %0,0(%3)\n"
 			     "sync"
-			     : "=r" (tmp) : "r" (val), "b" (addr) , "m" (*addr));
+			     : "=&r" (tmp) , "=&r" (val) : "1" (val) , "b" (addr) , "m" (*addr));
 }

 static inline void out_be64(volatile unsigned long *addr, int val)


** Sent via the linuxppc64-dev mail list. See http://lists.linuxppc.org/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>


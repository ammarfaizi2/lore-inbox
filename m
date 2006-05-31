Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWEaBGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWEaBGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWEaBGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:06:12 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:34269 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932552AbWEaBGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:06:11 -0400
Date: Tue, 30 May 2006 20:59:51 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.17-rc5 2/2] i386 memcpy: minor optimization
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200605302103_MC3-1-BF0E-59C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip an additional instruction if memcpy size is divisible by four.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-rc5-32.orig/include/asm-i386/string.h
+++ 2.6.17-rc5-32/include/asm-i386/string.h
@@ -203,20 +203,20 @@ return __res;
 
 static __always_inline void * __memcpy(void * to, const void * from, size_t n)
 {
-int d0, d1, d2;
+int d0, d1, d2, d3;
 __asm__ __volatile__(
 	"rep ; movsl\n\t"
-	"movl %4,%%ecx\n\t"
-	"andl $3,%%ecx\n\t"
-#if 1	/* want to pay 2 byte penalty for a chance to skip microcoded rep? */
+	"andl $3,%3\n\t"
+#if 1	/* want to pay 2 byte penalty for a chance to skip a mov and a microcoded rep? */
 	"jz 1f\n\t"
 #endif
+	"movl %3,%%ecx\n\t"
 	"rep ; movsb\n\t"
 	"1:"
-	: "=&c" (d0), "=&D" (d1), "=&S" (d2)
-	: "0" (n/4), "g" (n), "1" ((long) to), "2" ((long) from)
+	: "=&c" (d0), "=&D" (d1), "=&S" (d2), "=&g" (d3)
+	: "0" (n/4), "1" ((long) to), "2" ((long) from), "3" (n)
 	: "memory");
-return (to);
+return to;
 }
 
 /*
-- 
Chuck

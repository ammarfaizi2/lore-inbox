Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161311AbWBUDsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbWBUDsd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161307AbWBUDsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:48:17 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:10941 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1161306AbWBUDsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:48:09 -0500
Message-Id: <20060221034750.352424000@localhost.localdomain>
References: <20060221034628.799606000@localhost.localdomain>
Date: Tue, 21 Feb 2006 12:46:34 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [-mm patch 6/8] arm: fix undefined reference to generic_fls
Content-Disposition: inline; filename=arm-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines constant_fls() instead of removed generic_fls().

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
Cc: Russell King <rmk@arm.linux.org.uk>

 include/asm-arm/bitops.h |   31 ++++++++++++++++++++++++++++++-
 1 files changed, 30 insertions(+), 1 deletion(-)

Index: 2.6-mm/include/asm-arm/bitops.h
===================================================================
--- 2.6-mm.orig/include/asm-arm/bitops.h
+++ 2.6-mm/include/asm-arm/bitops.h
@@ -239,13 +239,42 @@ extern int _find_next_bit_be(const unsig
 
 #else
 
+static inline int constant_fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000u)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
 /*
  * On ARMv5 and above those functions can be implemented around
  * the clz instruction for much better code efficiency.
  */
 
 #define fls(x) \
-	( __builtin_constant_p(x) ? generic_fls(x) : \
+	( __builtin_constant_p(x) ? constant_fls(x) : \
 	  ({ int __r; asm("clz\t%0, %1" : "=r"(__r) : "r"(x) : "cc"); 32-__r; }) )
 #define ffs(x) ({ unsigned long __t = (x); fls(__t & -__t); })
 #define __ffs(x) (ffs(x) - 1)

--

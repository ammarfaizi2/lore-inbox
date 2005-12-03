Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVLCAYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVLCAYp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 19:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVLCAYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 19:24:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751093AbVLCAYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 19:24:45 -0500
Date: Fri, 2 Dec 2005 16:22:40 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fls in asm for i386
Message-ID: <20051202162240.746c436e@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a single instruction on i386 to find largest set bit;
so it makes sense to use it (like we use bfs for ffs()).

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- orig/include/asm-i386/bitops.h
+++ new/include/asm-i386/bitops.h
@@ -367,12 +367,6 @@ static inline unsigned long ffz(unsigned
 	return word;
 }
 
-/*
- * fls: find last bit set.
- */
-
-#define fls(x) generic_fls(x)
-
 #ifdef __KERNEL__
 
 /*
@@ -414,6 +408,23 @@ static inline int ffs(int x)
 }
 
 /**
+ * fls - find last bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as ffs.
+ */
+static inline int fls(int x)
+{
+	int r;
+
+	__asm__("bsrl %1,%0\n\t"
+		"jnz 1f\n\t"
+		"movl $-1,%0\n"
+		"1:" : "=r" (r) : "rm" (x));
+	return r+1;
+}
+
+/**
  * hweightN - returns the hamming weight of a N-bit word
  * @x: the word to weigh
  *

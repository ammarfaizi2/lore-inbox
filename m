Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTE0Wjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTE0Wjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:39:55 -0400
Received: from dp.samba.org ([66.70.73.150]:49814 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264326AbTE0Wjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:39:53 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16083.60374.284044.751867@nanango.paulus.ozlabs.org>
Date: Wed, 28 May 2003 08:51:02 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Proposed patch to kernel.h
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

PowerPC has a conditional trap instruction that I would like to use
for BUG_ON.  I would like to make BUG_ON for ppc look like this:

#define BUG_ON(x) do {						\
	__asm__ __volatile__(					\
		"1:	twnei %0,0\n"				\
		".section __bug_table,\"a\"\n"			\
		"	.long 1b,%1,%2\n"			\
		".previous"					\
		: : "r" (x), "i" (__LINE__), "i" (__FILE__));	\
} while (0)

This avoids a conditional branch and is nice and compact.  (The twnei
instruction takes an exception if the register operand is not equal
to the immediate operand - trap word not equal immediate.)

However, at the moment BUG_ON is unconditionally defined in kernel.h.
The patch below is the simplest way I can see to make it possible for
architectures to supply their own BUG_ON.  Please apply.

Thanks,
Paul.

diff -urN linux-2.5/include/linux/kernel.h pmac-2.5/include/linux/kernel.h
--- linux-2.5/include/linux/kernel.h	2003-05-21 08:27:25.000000000 +1000
+++ pmac-2.5/include/linux/kernel.h	2003-05-26 22:01:54.000000000 +1000
@@ -228,7 +228,9 @@
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
 
+#ifndef BUG_ON
 #define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+#endif
 #define WARN_ON(condition) do { \
 	if (unlikely((condition)!=0)) { \
 		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \

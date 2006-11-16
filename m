Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162257AbWKPCw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162257AbWKPCw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162237AbWKPCoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:44:02 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:12175 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162236AbWKPCnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:43:40 -0500
Message-Id: <20061116024424.830473000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:35 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>
Subject: [patch 03/30] SPARC64: Fix futex_atomic_cmpxchg_inatomic implementation.
Content-Disposition: inline; filename=sparc64-fix-futex_atomic_cmpxchg_inatomic-implementation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

I copied the logic from ll/sc arch implementations, but that
was wrong and makes no sense at all.  Just do a straight
compare-exchange instruction, just like x86.

Based upon bug reports from Dennis Gilmore and Fabio Massimo.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-sparc64/futex.h |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- linux-2.6.18.2.orig/include/asm-sparc64/futex.h
+++ linux-2.6.18.2/include/asm-sparc64/futex.h
@@ -87,24 +87,22 @@ static inline int
 futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldval, int newval)
 {
 	__asm__ __volatile__(
-	"\n1:	lduwa	[%2] %%asi, %0\n"
-	"2:	casa	[%2] %%asi, %0, %1\n"
-	"3:\n"
+	"\n1:	casa	[%3] %%asi, %2, %0\n"
+	"2:\n"
 	"	.section .fixup,#alloc,#execinstr\n"
 	"	.align	4\n"
-	"4:	ba	3b\n"
-	"	 mov	%3, %0\n"
+	"3:	ba	2b\n"
+	"	 mov	%4, %0\n"
 	"	.previous\n"
 	"	.section __ex_table,\"a\"\n"
 	"	.align	4\n"
-	"	.word	1b, 4b\n"
-	"	.word	2b, 4b\n"
+	"	.word	1b, 3b\n"
 	"	.previous\n"
-	: "=&r" (oldval)
-	: "r" (newval), "r" (uaddr), "i" (-EFAULT)
+	: "=r" (newval)
+	: "0" (newval), "r" (oldval), "r" (uaddr), "i" (-EFAULT)
 	: "memory");
 
-	return oldval;
+	return newval;
 }
 
 #endif /* !(_SPARC64_FUTEX_H) */

--

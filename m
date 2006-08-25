Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWHYNtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWHYNtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWHYNtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:49:21 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:17887 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932229AbWHYNtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:49:20 -0400
Date: Fri, 25 Aug 2006 15:49:09 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] AVR32: Fix output constraints in asm/bitops.h
Message-ID: <20060825154909.3096827e@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When copying a few files from one nfs-mounted directory to another,
I suddenly saw this:

Unable to handle kernel paging request at virtual address 00100028
[ 1001.372000] pc = 9002bed0
[ 1001.376000] ptbr = 90438610 pgd = 10400c66 pte = 00000000
[ 1001.380000]
[ 1001.380000] Oops in arch/avr32/mm/fault.c::do_page_fault, line 247[#3]:
[ 1001.380000] Modules linked in:
[ 1001.380000] PC is at page_cache_readahead_adaptive+0x32/0x90a
[ 1001.380000] LR is at 0x63
[ 1001.380000] pc : [<9002bed0>]    lr : [<00000063>]    Not tainted
[ 1001.380000] sp : 90495d34  r12: 90240c68  r11: 90495df4
[ 1001.380000] r10: 90497870  r9 : 00000028  r8 : 00100028
[ 1001.380000] r7 : 90495d80  r6 : 00000063  r5 : 90495df4  r4 : 00000000
[ 1001.380000] r3 : 00000000  r2 : 00000064  r1 : 00000063  r0 : 90497870

caused by the following invalid code in page_cache_readahead_adaptive():

9002bec8:       d2 53           ssrf 0x5
9002beca:       70 09           ld.w r9,r8[0x0]
9002becc:       12 98           mov r8,r9
9002bece:       b5 c9           cbr r9,0x14
9002bed0:       f1 79 00 00     stcond r8[0],r9

This is an inline assembly block from test_and_clear_bit(). Here, r8
is used both as "old" and as the memory address of *p because "old"
isn't marked as an earlyclobber operand.

Fix this and similar bugs by making all similar output constraints in
asm/bitops.h earlyclobber.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 include/asm-avr32/bitops.h |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

Index: linux-2.6.18-rc4-mm2/include/asm-avr32/bitops.h
===================================================================
--- linux-2.6.18-rc4-mm2.orig/include/asm-avr32/bitops.h	2006-08-25 15:18:10.000000000 +0200
+++ linux-2.6.18-rc4-mm2/include/asm-avr32/bitops.h	2006-08-25 15:19:47.000000000 +0200
@@ -40,7 +40,7 @@ static inline void set_bit(int nr, volat
 			"	sbr	%0, %3\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=o"(*p)
+			: "=&r"(tmp), "=o"(*p)
 			: "m"(*p), "i"(nr)
 			: "cc");
 	} else {
@@ -51,7 +51,7 @@ static inline void set_bit(int nr, volat
 			"	or	%0, %3\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=o"(*p)
+			: "=&r"(tmp), "=o"(*p)
 			: "m"(*p), "r"(mask)
 			: "cc");
 	}
@@ -79,7 +79,7 @@ static inline void clear_bit(int nr, vol
 			"	cbr	%0, %3\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=o"(*p)
+			: "=&r"(tmp), "=o"(*p)
 			: "m"(*p), "i"(nr)
 			: "cc");
 	} else {
@@ -90,7 +90,7 @@ static inline void clear_bit(int nr, vol
 			"	andn	%0, %3\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=o"(*p)
+			: "=&r"(tmp), "=o"(*p)
 			: "m"(*p), "r"(mask)
 			: "cc");
 	}
@@ -117,7 +117,7 @@ static inline void change_bit(int nr, vo
 		"	eor	%0, %3\n"
 		"	stcond	%1, %0\n"
 		"	brne	1b"
-		: "=r"(tmp), "=o"(*p)
+		: "=&r"(tmp), "=o"(*p)
 		: "m"(*p), "r"(mask)
 		: "cc");
 }
@@ -144,7 +144,7 @@ static inline int test_and_set_bit(int n
 			"	sbr	%0, %4\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=o"(*p), "=r"(old)
+			: "=&r"(tmp), "=o"(*p), "=&r"(old)
 			: "m"(*p), "i"(nr)
 			: "memory", "cc");
 	} else {
@@ -154,7 +154,7 @@ static inline int test_and_set_bit(int n
 			"	or	%0, %2, %4\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=o"(*p), "=r"(old)
+			: "=&r"(tmp), "=o"(*p), "=&r"(old)
 			: "m"(*p), "r"(mask)
 			: "memory", "cc");
 	}
@@ -184,7 +184,7 @@ static inline int test_and_clear_bit(int
 			"	cbr	%0, %4\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=o"(*p), "=r"(old)
+			: "=&r"(tmp), "=o"(*p), "=&r"(old)
 			: "m"(*p), "i"(nr)
 			: "memory", "cc");
 	} else {
@@ -195,7 +195,7 @@ static inline int test_and_clear_bit(int
 			"	andn	%0, %4\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=o"(*p), "=r"(old)
+			: "=&r"(tmp), "=o"(*p), "=&r"(old)
 			: "m"(*p), "r"(mask)
 			: "memory", "cc");
 	}
@@ -223,7 +223,7 @@ static inline int test_and_change_bit(in
 		"	eor	%0, %2, %4\n"
 		"	stcond	%1, %0\n"
 		"	brne	1b"
-		: "=r"(tmp), "=o"(*p), "=r"(old)
+		: "=&r"(tmp), "=o"(*p), "=&r"(old)
 		: "m"(*p), "r"(mask)
 		: "memory", "cc");
 
@@ -239,7 +239,7 @@ static inline unsigned long __ffs(unsign
 
 	asm("brev %1\n\t"
 	    "clz %0,%1"
-	    : "=r"(result), "=r"(word)
+	    : "=r"(result), "=&r"(word)
 	    : "1"(word));
 	return result;
 }

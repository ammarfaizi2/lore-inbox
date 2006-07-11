Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWGKMoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWGKMoD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWGKMnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:43:43 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:43209 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751255AbWGKMnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:43:40 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 2/7] AVR32: Fix invalid constraints for stcond
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 11 Jul 2006 14:43:17 +0200
Message-Id: <11526218024091-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11526218022840-git-send-email-hskinnemoen@atmel.com>
References: <11526218021728-git-send-email-hskinnemoen@atmel.com> <11526218022840-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because gcc doesn't seem to like arch-dependent constraints in inline
asm, we ended up using "m" as constraint for the stcond instruction.
This is wrong since stcond doesn't support indexed addressing, but
it did seem to work on all the configurations we tried out.

When trying to build an allyesconfig, however, things broke in the
ocfs2 filesystem as the compiler used indexed addressing for the
stcond instruction and the assembler panic'ed.

Using the vaguely documented "o" constraint seems to fix the problem.
This only allows "offsetable" memory operands, and since
(reg + reg + constant) is not possible with any AVR32 instruction,
gcc is forced to disallow indexed addressing.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 include/asm-avr32/atomic.h |   10 +++++-----
 include/asm-avr32/bitops.h |   20 ++++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/asm-avr32/atomic.h b/include/asm-avr32/atomic.h
index fa53d53..e0b9c44 100644
--- a/include/asm-avr32/atomic.h
+++ b/include/asm-avr32/atomic.h
@@ -40,7 +40,7 @@ static inline int atomic_sub_return(int 
 		"	sub	%0, %3\n"
 		"	stcond	%1, %0\n"
 		"	brne	1b"
-		: "=&r"(result), "=m"(v->counter)
+		: "=&r"(result), "=o"(v->counter)
 		: "m"(v->counter), "ir"(i)
 		: "cc");
 
@@ -68,7 +68,7 @@ static inline int atomic_add_return(int 
 			"	add	%0, %3\n"
 			"	stcond	%2, %0\n"
 			"	brne	1b"
-			: "=&r"(result), "=m"(v->counter)
+			: "=&r"(result), "=o"(v->counter)
 			: "m"(v->counter), "r"(i)
 			: "cc", "memory");
 
@@ -100,7 +100,7 @@ static inline int atomic_sub_unless(atom
 		"	brne	1b\n"
 		"	mov	%1, 1\n"
 		"1:"
-		: "=&r"(tmp), "=&r"(result), "=m"(v->counter)
+		: "=&r"(tmp), "=&r"(result), "=o"(v->counter)
 		: "m"(v->counter), "ir"(a), "ir"(u)
 		: "cc", "memory");
 
@@ -136,7 +136,7 @@ static inline int atomic_add_unless(atom
 			"	brne	1b\n"
 			"	mov	%1, 1\n"
 			"1:"
-			: "=&r"(tmp), "=&r"(result), "=m"(v->counter)
+			: "=&r"(tmp), "=&r"(result), "=o"(v->counter)
 			: "m"(v->counter), "r"(a), "ir"(u)
 			: "cc", "memory");
 	}
@@ -165,7 +165,7 @@ static inline int atomic_sub_if_positive
 		"	stcond	%1, %0\n"
 		"	brne	1b\n"
 		"1:"
-		: "=&r"(result), "=m"(v->counter)
+		: "=&r"(result), "=o"(v->counter)
 		: "m"(v->counter), "ir"(i)
 		: "cc", "memory");
 
diff --git a/include/asm-avr32/bitops.h b/include/asm-avr32/bitops.h
index f0d7bc7..4d47b07 100644
--- a/include/asm-avr32/bitops.h
+++ b/include/asm-avr32/bitops.h
@@ -40,7 +40,7 @@ static inline void set_bit(int nr, volat
 			"	sbr	%0, %3\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=m"(*p)
+			: "=r"(tmp), "=o"(*p)
 			: "m"(*p), "i"(nr)
 			: "cc");
 	} else {
@@ -51,7 +51,7 @@ static inline void set_bit(int nr, volat
 			"	or	%0, %3\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=m"(*p)
+			: "=r"(tmp), "=o"(*p)
 			: "m"(*p), "r"(mask)
 			: "cc");
 	}
@@ -79,7 +79,7 @@ static inline void clear_bit(int nr, vol
 			"	cbr	%0, %3\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=m"(*p)
+			: "=r"(tmp), "=o"(*p)
 			: "m"(*p), "i"(nr)
 			: "cc");
 	} else {
@@ -90,7 +90,7 @@ static inline void clear_bit(int nr, vol
 			"	andn	%0, %3\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=m"(*p)
+			: "=r"(tmp), "=o"(*p)
 			: "m"(*p), "r"(mask)
 			: "cc");
 	}
@@ -117,7 +117,7 @@ static inline void change_bit(int nr, vo
 		"	eor	%0, %3\n"
 		"	stcond	%1, %0\n"
 		"	brne	1b"
-		: "=r"(tmp), "=m"(*p)
+		: "=r"(tmp), "=o"(*p)
 		: "m"(*p), "r"(mask)
 		: "cc");
 }
@@ -144,7 +144,7 @@ static inline int test_and_set_bit(int n
 			"	sbr	%0, %4\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=m"(*p), "=r"(old)
+			: "=r"(tmp), "=o"(*p), "=r"(old)
 			: "m"(*p), "i"(nr)
 			: "memory", "cc");
 	} else {
@@ -154,7 +154,7 @@ static inline int test_and_set_bit(int n
 			"	or	%0, %2, %4\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=m"(*p), "=r"(old)
+			: "=r"(tmp), "=o"(*p), "=r"(old)
 			: "m"(*p), "r"(mask)
 			: "memory", "cc");
 	}
@@ -184,7 +184,7 @@ static inline int test_and_clear_bit(int
 			"	cbr	%0, %4\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=m"(*p), "=r"(old)
+			: "=r"(tmp), "=o"(*p), "=r"(old)
 			: "m"(*p), "i"(nr)
 			: "memory", "cc");
 	} else {
@@ -195,7 +195,7 @@ static inline int test_and_clear_bit(int
 			"	andn	%0, %4\n"
 			"	stcond	%1, %0\n"
 			"	brne	1b"
-			: "=r"(tmp), "=m"(*p), "=r"(old)
+			: "=r"(tmp), "=o"(*p), "=r"(old)
 			: "m"(*p), "r"(mask)
 			: "memory", "cc");
 	}
@@ -223,7 +223,7 @@ static inline int test_and_change_bit(in
 		"	eor	%0, %2, %4\n"
 		"	stcond	%1, %0\n"
 		"	brne	1b"
-		: "=r"(tmp), "=m"(*p), "=r"(old)
+		: "=r"(tmp), "=o"(*p), "=r"(old)
 		: "m"(*p), "r"(mask)
 		: "memory", "cc");
 
-- 
1.4.0


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWJXIPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWJXIPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWJXINv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:13:51 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:1530 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932438AbWJXIN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:26 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 4/8] AVR32: Fix oversize immediates in atomic.h
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 24 Oct 2006 10:12:42 +0200
Message-Id: <11616775661978-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11616775661390-git-send-email-hskinnemoen@atmel.com>
References: <1161677566706-git-send-email-hskinnemoen@atmel.com> <11616775663220-git-send-email-hskinnemoen@atmel.com> <11616775662194-git-send-email-hskinnemoen@atmel.com> <11616775661390-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When calling e.g. atomic_sub_return with a large constant, the
compiler may output an immediate that is too large for the sub
instruction in the middle of the loop.

Fix this by explicitly specifying the number of bits allowed in the
constraint. Also stop atomic_add_return() and friends from falling
back to their respective "sub" variants if the constant is too large
to fit in an immediate.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 include/asm-avr32/atomic.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-avr32/atomic.h b/include/asm-avr32/atomic.h
index e0b9c44..c40b603 100644
--- a/include/asm-avr32/atomic.h
+++ b/include/asm-avr32/atomic.h
@@ -41,7 +41,7 @@ static inline int atomic_sub_return(int 
 		"	stcond	%1, %0\n"
 		"	brne	1b"
 		: "=&r"(result), "=o"(v->counter)
-		: "m"(v->counter), "ir"(i)
+		: "m"(v->counter), "rKs21"(i)
 		: "cc");
 
 	return result;
@@ -58,7 +58,7 @@ static inline int atomic_add_return(int 
 {
 	int result;
 
-	if (__builtin_constant_p(i))
+	if (__builtin_constant_p(i) && (i >= -1048575) && (i <= 1048576))
 		result = atomic_sub_return(-i, v);
 	else
 		asm volatile(
@@ -101,7 +101,7 @@ static inline int atomic_sub_unless(atom
 		"	mov	%1, 1\n"
 		"1:"
 		: "=&r"(tmp), "=&r"(result), "=o"(v->counter)
-		: "m"(v->counter), "ir"(a), "ir"(u)
+		: "m"(v->counter), "rKs21"(a), "rKs21"(u)
 		: "cc", "memory");
 
 	return result;
@@ -121,7 +121,7 @@ static inline int atomic_add_unless(atom
 {
 	int tmp, result;
 
-	if (__builtin_constant_p(a))
+	if (__builtin_constant_p(a) && (a >= -1048575) && (a <= 1048576))
 		result = atomic_sub_unless(v, -a, u);
 	else {
 		result = 0;
-- 
1.4.1.1


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWJXIO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWJXIO3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWJXINz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:13:55 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:43773 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932436AbWJXINY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:24 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 6/8] AVR32: Implement and export __raw_{read,write}s[bwl]
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 24 Oct 2006 10:12:44 +0200
Message-Id: <11616775662032-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <1161677566524-git-send-email-hskinnemoen@atmel.com>
References: <1161677566706-git-send-email-hskinnemoen@atmel.com> <11616775663220-git-send-email-hskinnemoen@atmel.com> <11616775662194-git-send-email-hskinnemoen@atmel.com> <11616775661390-git-send-email-hskinnemoen@atmel.com> <11616775661978-git-send-email-hskinnemoen@atmel.com> <1161677566524-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement __raw_readsb and __raw_writesb. Export __raw_reads[bwl]
and __raw_writes[bwl] for use by modules.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/kernel/avr32_ksyms.c |    9 +++++++
 arch/avr32/lib/Makefile         |    1 +
 arch/avr32/lib/io-readsb.S      |   47 +++++++++++++++++++++++++++++++++++
 arch/avr32/lib/io-writesb.S     |   52 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/kernel/avr32_ksyms.c b/arch/avr32/kernel/avr32_ksyms.c
index 04f767a..372e3f8 100644
--- a/arch/avr32/kernel/avr32_ksyms.c
+++ b/arch/avr32/kernel/avr32_ksyms.c
@@ -7,6 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/io.h>
 #include <linux/module.h>
 
 #include <asm/checksum.h>
@@ -53,3 +54,11 @@ EXPORT_SYMBOL(find_next_zero_bit);
 EXPORT_SYMBOL(find_first_bit);
 EXPORT_SYMBOL(find_next_bit);
 EXPORT_SYMBOL(generic_find_next_zero_le_bit);
+
+/* I/O primitives (lib/io-*.S) */
+EXPORT_SYMBOL(__raw_readsb);
+EXPORT_SYMBOL(__raw_readsw);
+EXPORT_SYMBOL(__raw_readsl);
+EXPORT_SYMBOL(__raw_writesb);
+EXPORT_SYMBOL(__raw_writesw);
+EXPORT_SYMBOL(__raw_writesl);
diff --git a/arch/avr32/lib/Makefile b/arch/avr32/lib/Makefile
index 09ac43e..084d95b 100644
--- a/arch/avr32/lib/Makefile
+++ b/arch/avr32/lib/Makefile
@@ -7,4 +7,5 @@ lib-y	+= strncpy_from_user.o strnlen_use
 lib-y	+= delay.o memset.o memcpy.o findbit.o
 lib-y	+= csum_partial.o csum_partial_copy_generic.o
 lib-y	+= io-readsw.o io-readsl.o io-writesw.o io-writesl.o
+lib-y	+= io-readsb.o io-writesb.o
 lib-y	+= __avr32_lsl64.o __avr32_lsr64.o __avr32_asr64.o
diff --git a/arch/avr32/lib/io-readsb.S b/arch/avr32/lib/io-readsb.S
new file mode 100644
index 0000000..b319d5e
--- /dev/null
+++ b/arch/avr32/lib/io-readsb.S
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2004-2006 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+	.text
+.Lnot_word_aligned:
+1:	ld.ub	r8, r12[0]
+	sub	r10, 1
+	st.b	r11++, r8
+	reteq	r12
+	tst	r11, r9
+	brne	1b
+
+	/* fall through */
+
+	.global	__raw_readsb
+	.type	__raw_readsb,@function
+__raw_readsb:
+	cp.w	r10, 0
+	mov	r9, 3
+	reteq	r12
+
+	tst	r11, r9
+	brne	.Lnot_word_aligned
+
+	sub	r10, 4
+	brlt	2f
+
+1:	ldins.b	r8:t, r12[0]
+	ldins.b	r8:u, r12[0]
+	ldins.b	r8:l, r12[0]
+	ldins.b r8:b, r12[0]
+	st.w	r11++, r8
+	sub	r10, 4
+	brge	1b
+
+2:	sub	r10, -4
+	reteq	r12
+
+3:	ld.uh	r8, r12[0]
+	sub	r10, 1
+	st.b	r11++, r8
+	brne	3b
diff --git a/arch/avr32/lib/io-writesb.S b/arch/avr32/lib/io-writesb.S
new file mode 100644
index 0000000..b4ebaac
--- /dev/null
+++ b/arch/avr32/lib/io-writesb.S
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2004-2006 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+	.text
+.Lnot_word_aligned:
+1:	ld.ub	r8, r11++
+	sub	r10, 1
+	st.b	r12[0], r8
+	reteq	r12
+	tst	r11, r9
+	brne	1b
+
+	/* fall through */
+
+	.global	__raw_writesb
+	.type	__raw_writesb,@function
+__raw_writesb:
+	cp.w	r10, 0
+	mov	r9, 3
+	reteq	r12
+
+	tst	r11, r9
+	brne	.Lnot_word_aligned
+
+	sub	r10, 4
+	brlt	2f
+
+1:	ld.w	r8, r11++
+	bfextu	r9, r8, 24, 8
+	st.b	r12[0], r9
+	bfextu	r9, r8, 16, 8
+	st.b	r12[0], r9
+	bfextu	r9, r8, 8, 8
+	st.b	r12[0], r9
+	st.b	r12[0], r8
+	sub	r10, 4
+	brge	1b
+
+2:	sub	r10, -4
+	reteq	r12
+
+3:	ld.ub	r8, r11++
+	sub	r10, 1
+	st.b	r12[0], r8
+	brne	3b
+
+	retal	r12
-- 
1.4.1.1


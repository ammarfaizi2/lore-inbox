Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVDQTUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVDQTUp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVDQTUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:20:45 -0400
Received: from hermes.domdv.de ([193.102.202.1]:34833 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261418AbVDQTUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:20:00 -0400
Message-ID: <4262B6DE.8030907@domdv.de>
Date: Sun, 17 Apr 2005 21:19:58 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com, davem@davemloft.net, ak@suse.de
Subject: [RFC][PATCH 1/4] AES assembler implementation for x86_64
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090306030300010508090906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090306030300010508090906
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

The attached patch contains my AES assembler implementation for x86_64.
This includes only encrypt/decrypt as Gladman's in-kernel code is used
for key schedule and table generation.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------090306030300010508090906
Content-Type: text/plain;
 name="aes-assembler.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aes-assembler.diff"

diff -rNu linux-2.6.11.2.orig/arch/x86_64/crypto/aes-x86_64-asm.S linux-2.6.11.2/arch/x86_64/crypto/aes-x86_64-asm.S
--- linux-2.6.11.2.orig/arch/x86_64/crypto/aes-x86_64-asm.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11.2/arch/x86_64/crypto/aes-x86_64-asm.S	2005-04-17 12:56:05.000000000 +0200
@@ -0,0 +1,186 @@
+/* AES (Rijndael) implementation (FIPS PUB 197) for x86_64
+ *
+ * Copyright (C) 2005 Andreas Steinmetz, <ast@domdv.de>
+ *
+ * License:
+ * This code can be distributed under the terms of the GNU General Public
+ * License (GPL) Version 2 provided that the above header down to and
+ * including this sentence is retained in full.
+ */
+
+.extern aes_ft_tab
+.extern aes_it_tab
+.extern aes_fl_tab
+.extern aes_il_tab
+
+.text
+
+#define R1	%rax
+#define R1E	%eax
+#define R1X	%ax
+#define R1H	%ah
+#define R1L	%al
+#define R2	%rbx
+#define R2E	%ebx
+#define R2X	%bx
+#define R2H	%bh
+#define R2L	%bl
+#define R3	%rcx
+#define R3E	%ecx
+#define R3X	%cx
+#define R3H	%ch
+#define R3L	%cl
+#define R4	%rdx
+#define R4E	%edx
+#define R4X	%dx
+#define R4H	%dh
+#define R4L	%dl
+#define R5	%rsi
+#define R5E	%esi
+#define R6	%rdi
+#define R6E	%edi
+#define R7	%rbp
+#define R7E	%ebp
+#define R8	%r8
+#define R9	%r9
+#define R10	%r10
+#define R11	%r11
+
+#define prologue(FUNC,BASE,B128,B192,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11) \
+	.global	FUNC;			\
+	.type	FUNC,@function;		\
+	.align	8;			\
+FUNC:	movq	r1,r2;			\
+	movq	r3,r4;			\
+	leaq	BASE+52(r8),r9;		\
+	movq	r10,r11;		\
+	movl	(r7),r5 ## E;		\
+	movl	4(r7),r1 ## E;		\
+	movl	8(r7),r6 ## E;		\
+	movl	12(r7),r7 ## E;		\
+	movl	(r8),r10 ## E;		\
+	xorl	-48(r9),r5 ## E;	\
+	xorl	-44(r9),r1 ## E;	\
+	xorl	-40(r9),r6 ## E;	\
+	xorl	-36(r9),r7 ## E;	\
+	cmpl	$24,r10 ## E;		\
+	jb	B128;			\
+	leaq	32(r9),r9;		\
+	je	B192;			\
+	leaq	32(r9),r9;
+
+#define epilogue(r1,r2,r3,r4,r5,r6,r7,r8,r9) \
+	movq	r1,r2;			\
+	movq	r3,r4;			\
+	movl	r5 ## E,(r9);		\
+	movl	r6 ## E,4(r9);		\
+	movl	r7 ## E,8(r9);		\
+	movl	r8 ## E,12(r9);		\
+	ret;
+
+#define round(TAB,OFFSET,r1,r2,r3,r4,r5,r6,r7,r8,ra,rb,rc,rd) \
+	movzbl	r2 ## H,r5 ## E;	\
+	movzbl	r2 ## L,r6 ## E;	\
+	movl	TAB+1024(,r5,4),r5 ## E;\
+	movw	r4 ## X,r2 ## X;	\
+	movl	TAB(,r6,4),r6 ## E;	\
+	roll	$16,r2 ## E;		\
+	shrl	$16,r4 ## E;		\
+	movzbl	r4 ## H,r7 ## E;	\
+	movzbl	r4 ## L,r4 ## E;	\
+	xorl	OFFSET(r8),ra ## E;	\
+	xorl	OFFSET+4(r8),rb ## E;	\
+	xorl	TAB+3072(,r7,4),r5 ## E;\
+	xorl	TAB+2048(,r4,4),r6 ## E;\
+	movzbl	r1 ## L,r7 ## E;	\
+	movzbl	r1 ## H,r4 ## E;	\
+	movl	TAB+1024(,r4,4),r4 ## E;\
+	movw	r3 ## X,r1 ## X;	\
+	roll	$16,r1 ## E;		\
+	shrl	$16,r3 ## E;		\
+	xorl	TAB(,r7,4),r5 ## E;	\
+	movzbl	r3 ## H,r7 ## E;	\
+	movzbl	r3 ## L,r3 ## E;	\
+	xorl	TAB+3072(,r7,4),r4 ## E;\
+	xorl	TAB+2048(,r3,4),r5 ## E;\
+	movzbl	r1 ## H,r7 ## E;	\
+	movzbl	r1 ## L,r3 ## E;	\
+	shrl	$16,r1 ## E;		\
+	xorl	TAB+3072(,r7,4),r6 ## E;\
+	movl	TAB+2048(,r3,4),r3 ## E;\
+	movzbl	r1 ## H,r7 ## E;	\
+	movzbl	r1 ## L,r1 ## E;	\
+	xorl	TAB+1024(,r7,4),r6 ## E;\
+	xorl	TAB(,r1,4),r3 ## E;	\
+	movzbl	r2 ## H,r1 ## E;	\
+	movzbl	r2 ## L,r7 ## E;	\
+	shrl	$16,r2 ## E;		\
+	xorl	TAB+3072(,r1,4),r3 ## E;\
+	xorl	TAB+2048(,r7,4),r4 ## E;\
+	movzbl	r2 ## H,r1 ## E;	\
+	movzbl	r2 ## L,r2 ## E;	\
+	xorl	OFFSET+8(r8),rc ## E;	\
+	xorl	OFFSET+12(r8),rd ## E;	\
+	xorl	TAB+1024(,r1,4),r3 ## E;\
+	xorl	TAB(,r2,4),r4 ## E;
+
+#define move_regs(r1,r2,r3,r4) \
+	movl	r3 ## E,r1 ## E;	\
+	movl	r4 ## E,r2 ## E;
+
+#define entry(FUNC,BASE,B128,B192) \
+	prologue(FUNC,BASE,B128,B192,R2,R8,R7,R9,R1,R3,R4,R6,R10,R5,R11)
+
+#define return epilogue(R8,R2,R9,R7,R5,R6,R3,R4,R11)
+
+#define encrypt_round(TAB,OFFSET) \
+	round(TAB,OFFSET,R1,R2,R3,R4,R5,R6,R7,R10,R5,R6,R3,R4) \
+	move_regs(R1,R2,R5,R6)
+
+#define encrypt_final(TAB,OFFSET) \
+	round(TAB,OFFSET,R1,R2,R3,R4,R5,R6,R7,R10,R5,R6,R3,R4)
+
+#define decrypt_round(TAB,OFFSET) \
+	round(TAB,OFFSET,R2,R1,R4,R3,R6,R5,R7,R10,R5,R6,R3,R4) \
+	move_regs(R1,R2,R5,R6)
+
+#define decrypt_final(TAB,OFFSET) \
+	round(TAB,OFFSET,R2,R1,R4,R3,R6,R5,R7,R10,R5,R6,R3,R4)
+
+/* void aes_encrypt(void *ctx, u8 *out, const u8 *in) */
+
+	entry(aes_encrypt,0,enc128,enc192)
+	encrypt_round(aes_ft_tab,-96)
+	encrypt_round(aes_ft_tab,-80)
+enc192:	encrypt_round(aes_ft_tab,-64)
+	encrypt_round(aes_ft_tab,-48)
+enc128:	encrypt_round(aes_ft_tab,-32)
+	encrypt_round(aes_ft_tab,-16)
+	encrypt_round(aes_ft_tab,  0)
+	encrypt_round(aes_ft_tab, 16)
+	encrypt_round(aes_ft_tab, 32)
+	encrypt_round(aes_ft_tab, 48)
+	encrypt_round(aes_ft_tab, 64)
+	encrypt_round(aes_ft_tab, 80)
+	encrypt_round(aes_ft_tab, 96)
+	encrypt_final(aes_fl_tab,112)
+	return
+
+/* void aes_decrypt(void *ctx, u8 *out, const u8 *in) */
+
+	entry(aes_decrypt,240,dec128,dec192)
+	decrypt_round(aes_it_tab,-96)
+	decrypt_round(aes_it_tab,-80)
+dec192:	decrypt_round(aes_it_tab,-64)
+	decrypt_round(aes_it_tab,-48)
+dec128:	decrypt_round(aes_it_tab,-32)
+	decrypt_round(aes_it_tab,-16)
+	decrypt_round(aes_it_tab,  0)
+	decrypt_round(aes_it_tab, 16)
+	decrypt_round(aes_it_tab, 32)
+	decrypt_round(aes_it_tab, 48)
+	decrypt_round(aes_it_tab, 64)
+	decrypt_round(aes_it_tab, 80)
+	decrypt_round(aes_it_tab, 96)
+	decrypt_final(aes_il_tab,112)
+	return

--------------090306030300010508090906--

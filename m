Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbVKXKna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbVKXKna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbVKXKna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:43:30 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:654 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1030371AbVKXKn3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:43:29 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andreas Steinmetz <ast@domdv.de>
Subject: [PATCH] tiny improvement to x86_64 asm aes encryption
Date: Thu, 24 Nov 2005 12:42:35 +0200
User-Agent: KMail/1.8.2
Cc: Linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bkZhDiQget9BBBG"
Message-Id: <200511241242.35294.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_bkZhDiQget9BBBG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Basically, when de do:

        encrypt_round(aes_ft_tab,-96)
        encrypt_round(aes_ft_tab,-80)

first encrypt_round produces results in R5,R6,R3,R4,
and then moves R5->R1, R6->R2 for use in second one:

#define encrypt_round(TAB,OFFSET) \
        round(TAB,OFFSET,R1,R2,R3,R4,R5,R6,R7,R10,R5,R6,R3,R4) \
        move_regs(R1,R2,R5,R6)


But since we _always_ call them in pairs, we can just
swap arguments in second one, eliminating move_regs!


#define encrypt_round1(TAB,OFFSET) \
        round(TAB,OFFSET,R1,R2,R3,R4,R5,R6,R7,R10,R5,R6,R3,R4)
                         ^^^^^                    ^^^^^
#define encrypt_round2(TAB,OFFSET) \
        round(TAB,OFFSET,R5,R6,R3,R4,R1,R2,R7,R10,R1,R2,R3,R4)
                         ^^^^^                    ^^^^^
...
        encrypt_round1(aes_ft_tab,-96)
        encrypt_round2(aes_ft_tab,-80)

"encrypt_final" and "return" macros are changed accordingly.

Of course same thing is done on decrypt path.

Patch is not tested.
--
vda

--Boundary-00=_bkZhDiQget9BBBG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="z.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="z.diff"

--- aes-x86_64-asm.S.org	Mon Aug 29 02:41:01 2005
+++ aes-x86_64-asm.S	Thu Nov 24 12:34:35 2005
@@ -124,63 +124,63 @@
 	xorl	TAB+1024(,r1,4),r3 ## E;\
 	xorl	TAB(,r2,4),r4 ## E;
 
-#define move_regs(r1,r2,r3,r4) \
-	movl	r3 ## E,r1 ## E;	\
-	movl	r4 ## E,r2 ## E;
-
 #define entry(FUNC,BASE,B128,B192) \
 	prologue(FUNC,BASE,B128,B192,R2,R8,R7,R9,R1,R3,R4,R6,R10,R5,R11)
 
-#define return epilogue(R8,R2,R9,R7,R5,R6,R3,R4,R11)
-
-#define encrypt_round(TAB,OFFSET) \
-	round(TAB,OFFSET,R1,R2,R3,R4,R5,R6,R7,R10,R5,R6,R3,R4) \
-	move_regs(R1,R2,R5,R6)
+#define return epilogue(R8,R6,R9,R7,R1,R2,R3,R4,R11)
 
-#define encrypt_final(TAB,OFFSET) \
+#define encrypt_round1(TAB,OFFSET) \
 	round(TAB,OFFSET,R1,R2,R3,R4,R5,R6,R7,R10,R5,R6,R3,R4)
 
-#define decrypt_round(TAB,OFFSET) \
-	round(TAB,OFFSET,R2,R1,R4,R3,R6,R5,R7,R10,R5,R6,R3,R4) \
-	move_regs(R1,R2,R5,R6)
+#define encrypt_round2(TAB,OFFSET) \
+	round(TAB,OFFSET,R5,R6,R3,R4,R1,R2,R7,R10,R1,R2,R3,R4)
+
+#define encrypt_final2(TAB,OFFSET) \
+	round(TAB,OFFSET,R5,R6,R3,R4,R1,R2,R7,R10,R1,R2,R3,R4)
 
-#define decrypt_final(TAB,OFFSET) \
+#define decrypt_round1(TAB,OFFSET) \
 	round(TAB,OFFSET,R2,R1,R4,R3,R6,R5,R7,R10,R5,R6,R3,R4)
 
+#define decrypt_round2(TAB,OFFSET) \
+	round(TAB,OFFSET,R6,R5,R4,R3,R2,R1,R7,R10,R1,R2,R3,R4)
+
+#define decrypt_final2(TAB,OFFSET) \
+	round(TAB,OFFSET,R6,R5,R4,R3,R2,R1,R7,R10,R1,R2,R3,R4)
+
 /* void aes_encrypt(void *ctx, u8 *out, const u8 *in) */
 
 	entry(aes_encrypt,0,enc128,enc192)
-	encrypt_round(aes_ft_tab,-96)
-	encrypt_round(aes_ft_tab,-80)
-enc192:	encrypt_round(aes_ft_tab,-64)
-	encrypt_round(aes_ft_tab,-48)
-enc128:	encrypt_round(aes_ft_tab,-32)
-	encrypt_round(aes_ft_tab,-16)
-	encrypt_round(aes_ft_tab,  0)
-	encrypt_round(aes_ft_tab, 16)
-	encrypt_round(aes_ft_tab, 32)
-	encrypt_round(aes_ft_tab, 48)
-	encrypt_round(aes_ft_tab, 64)
-	encrypt_round(aes_ft_tab, 80)
-	encrypt_round(aes_ft_tab, 96)
-	encrypt_final(aes_fl_tab,112)
+	encrypt_round1(aes_ft_tab,-96)
+	encrypt_round2(aes_ft_tab,-80)
+enc192:	encrypt_round1(aes_ft_tab,-64)
+	encrypt_round2(aes_ft_tab,-48)
+enc128:	encrypt_round1(aes_ft_tab,-32)
+	encrypt_round2(aes_ft_tab,-16)
+	encrypt_round1(aes_ft_tab,  0)
+	encrypt_round2(aes_ft_tab, 16)
+	encrypt_round1(aes_ft_tab, 32)
+	encrypt_round2(aes_ft_tab, 48)
+	encrypt_round1(aes_ft_tab, 64)
+	encrypt_round2(aes_ft_tab, 80)
+	encrypt_round1(aes_ft_tab, 96)
+	encrypt_final2(aes_fl_tab,112)
 	return
 
 /* void aes_decrypt(void *ctx, u8 *out, const u8 *in) */
 
 	entry(aes_decrypt,240,dec128,dec192)
-	decrypt_round(aes_it_tab,-96)
-	decrypt_round(aes_it_tab,-80)
-dec192:	decrypt_round(aes_it_tab,-64)
-	decrypt_round(aes_it_tab,-48)
-dec128:	decrypt_round(aes_it_tab,-32)
-	decrypt_round(aes_it_tab,-16)
-	decrypt_round(aes_it_tab,  0)
-	decrypt_round(aes_it_tab, 16)
-	decrypt_round(aes_it_tab, 32)
-	decrypt_round(aes_it_tab, 48)
-	decrypt_round(aes_it_tab, 64)
-	decrypt_round(aes_it_tab, 80)
-	decrypt_round(aes_it_tab, 96)
-	decrypt_final(aes_il_tab,112)
+	decrypt_round1(aes_it_tab,-96)
+	decrypt_round2(aes_it_tab,-80)
+dec192:	decrypt_round1(aes_it_tab,-64)
+	decrypt_round2(aes_it_tab,-48)
+dec128:	decrypt_round1(aes_it_tab,-32)
+	decrypt_round2(aes_it_tab,-16)
+	decrypt_round1(aes_it_tab,  0)
+	decrypt_round2(aes_it_tab, 16)
+	decrypt_round1(aes_it_tab, 32)
+	decrypt_round2(aes_it_tab, 48)
+	decrypt_round1(aes_it_tab, 64)
+	decrypt_round2(aes_it_tab, 80)
+	decrypt_round1(aes_it_tab, 96)
+	decrypt_final2(aes_il_tab,112)
 	return

--Boundary-00=_bkZhDiQget9BBBG--

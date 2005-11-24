Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbVKXNIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVKXNIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbVKXNIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:08:11 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:40110 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750798AbVKXNIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:08:10 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] i386 aes asm typo fix
Date: Thu, 24 Nov 2005 15:07:01 +0200
User-Agent: KMail/1.8.2
Cc: Linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1rbhDQJ8AsQF5Kr"
Message-Id: <200511241507.01668.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_1rbhDQJ8AsQF5Kr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

* fix typo (128 -> 192,256 bits)
* nano-optimization (copied from x86_86)

Run tested.
--
vda

--Boundary-00=_1rbhDQJ8AsQF5Kr
Content-Type: text/x-diff;
  charset="us-ascii";
  name="aes-i586-asm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aes-i586-asm.patch"

* fix typo (128 -> 192,256 bits)
* nano-optimization (taken from x86_86)

Run tested:

2005-11-24_12:51:47.65292 kern.info: testing tnepres ECB decryption across pages (chunking)
2005-11-24_12:51:47.65295 kern.info:
2005-11-24_12:51:47.65298 kern.info: testing aes ECB encryption
2005-11-24_12:51:47.91579 kern.info: test 1 (128 bit key):
2005-11-24_12:51:47.91599 kern.info: 69c4e0d86a7b0430d8cdb78070b4c55a
2005-11-24_12:51:47.91602 kern.info: pass
2005-11-24_12:51:47.91605 kern.info: test 2 (192 bit key):
2005-11-24_12:51:47.91608 kern.info: dda97ca4864cdfe06eaf70a0ec0d7191
2005-11-24_12:51:47.91611 kern.info: pass
2005-11-24_12:51:47.91613 kern.info: test 3 (256 bit key):
2005-11-24_12:51:47.91616 kern.info: 8ea2b7ca516745bfeafc49904b496089
2005-11-24_12:51:47.91620 kern.info: pass
2005-11-24_12:51:47.91622 kern.info:
2005-11-24_12:51:47.91625 kern.info: testing aes ECB encryption across pages (chunking)
2005-11-24_12:51:47.91629 kern.info:
2005-11-24_12:51:47.91631 kern.info: testing aes ECB decryption
2005-11-24_12:51:47.91634 kern.info: test 1 (128 bit key):
2005-11-24_12:51:47.91637 kern.info: 00112233445566778899aabbccddeeff
2005-11-24_12:51:47.91640 kern.info: pass
2005-11-24_12:51:47.91643 kern.info: test 2 (192 bit key):
2005-11-24_12:51:47.91646 kern.info: 00112233445566778899aabbccddeeff
2005-11-24_12:51:47.91649 kern.info: pass
2005-11-24_12:51:47.91652 kern.info: test 3 (256 bit key):
2005-11-24_12:51:47.91655 kern.info: 00112233445566778899aabbccddeeff
2005-11-24_12:51:47.91658 kern.info: pass
2005-11-24_12:51:47.91660 kern.info:
2005-11-24_12:51:47.91663 kern.info: testing aes ECB decryption across pages (chunking)
2005-11-24_12:51:47.91667 kern.info:
2005-11-24_12:51:47.91669 kern.info: testing cast5 ECB encryption

--- linux-2.6.14.org/arch/i386/crypto/aes-i586-asm.S.org	Mon Aug 29 02:41:01 2005
+++ linux-2.6.14.org/arch/i386/crypto/aes-i586-asm.S	Thu Nov 24 12:44:52 2005
@@ -255,18 +255,17 @@ aes_enc_blk:
 	xor     8(%ebp),%r4
 	xor     12(%ebp),%r5
 
-	sub     $8,%esp           // space for register saves on stack
-	add     $16,%ebp          // increment to next round key
-	sub     $10,%r3          
-	je      4f              // 10 rounds for 128-bit key
-	add     $32,%ebp
-	sub     $2,%r3
-	je      3f              // 12 rounds for 128-bit key
-	add     $32,%ebp
+	sub     $8,%esp		// space for register saves on stack
+	add     $16,%ebp	// increment to next round key
+	cmp     $12,%r3
+	jb      4f		// 10 rounds for 128-bit key
+	lea     32(%ebp),%ebp
+	je      3f		// 12 rounds for 192-bit key
+	lea     32(%ebp),%ebp
 
-2:	fwd_rnd1( -64(%ebp) ,ft_tab)	// 14 rounds for 128-bit key
+2:	fwd_rnd1( -64(%ebp) ,ft_tab)	// 14 rounds for 256-bit key
 	fwd_rnd2( -48(%ebp) ,ft_tab)
-3:	fwd_rnd1( -32(%ebp) ,ft_tab)	// 12 rounds for 128-bit key
+3:	fwd_rnd1( -32(%ebp) ,ft_tab)	// 12 rounds for 192-bit key
 	fwd_rnd2( -16(%ebp) ,ft_tab)
 4:	fwd_rnd1(    (%ebp) ,ft_tab)	// 10 rounds for 128-bit key
 	fwd_rnd2( +16(%ebp) ,ft_tab)
@@ -334,18 +333,17 @@ aes_dec_blk:
 	xor     8(%ebp),%r4
 	xor     12(%ebp),%r5
 
-	sub     $8,%esp         // space for register saves on stack
-	sub     $16,%ebp        // increment to next round key
-	sub     $10,%r3          
-	je      4f              // 10 rounds for 128-bit key
-	sub     $32,%ebp
-	sub     $2,%r3
-	je      3f              // 12 rounds for 128-bit key
-	sub     $32,%ebp
+	sub     $8,%esp		// space for register saves on stack
+	sub     $16,%ebp	// increment to next round key
+	cmp     $12,%r3
+	jb      4f		// 10 rounds for 128-bit key
+	lea     -32(%ebp),%ebp
+	je      3f		// 12 rounds for 192-bit key
+	lea     -32(%ebp),%ebp
 
-2:	inv_rnd1( +64(%ebp), it_tab)	// 14 rounds for 128-bit key
+2:	inv_rnd1( +64(%ebp), it_tab)	// 14 rounds for 256-bit key
 	inv_rnd2( +48(%ebp), it_tab)
-3:	inv_rnd1( +32(%ebp), it_tab)	// 12 rounds for 128-bit key
+3:	inv_rnd1( +32(%ebp), it_tab)	// 12 rounds for 192-bit key
 	inv_rnd2( +16(%ebp), it_tab)
 4:	inv_rnd1(    (%ebp), it_tab)	// 10 rounds for 128-bit key
 	inv_rnd2( -16(%ebp), it_tab)

--Boundary-00=_1rbhDQJ8AsQF5Kr--

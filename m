Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVJXSF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVJXSF5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJXSF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:05:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20269 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751212AbVJXSF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:05:56 -0400
Date: Mon, 24 Oct 2005 14:05:50 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/5] crypto/sha1.c: avoid successively shifting a long long
In-reply-to: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0510241405270.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Shifting a long long about 7 times to store the length bits is suboptimal
on most 32-bit architectures.  Use a 32 bit scratch instead.

This provides an appreciable code reduction considering the _whole_
of the sha1_final() function:

	arch		old size	new size	reduction
	---------------------------------------------------------
	i386		0xe0		0xc4		12.5%
	arm		0x15c		0xe8		33.3%

Smaller code in this case is of course faster code.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/crypto/sha1.c
===================================================================
--- linux-2.6.orig/crypto/sha1.c
+++ linux-2.6/crypto/sha1.c
@@ -75,8 +75,8 @@
 static void sha1_final(void* ctx, u8 *out)
 {
 	struct sha1_ctx *sctx = ctx;
-	u32 i, j, index, padlen;
-	u64 t, count = sctx->count;
+	u64 count = sctx->count;
+	u32 i, j, index, padlen, t;
 	u8 bits[8];
 	static const u8 padding[64] = { 0x80, };
 
@@ -90,7 +90,8 @@
 	bits[7] = 0xff & t; t>>=8;
 	bits[6] = 0xff & t; t>>=8;
 	bits[5] = 0xff & t; t>>=8;
-	bits[4] = 0xff & t; t>>=8;
+	bits[4] = 0xff & t;
+	t = count >> (32 - 3);
 	bits[3] = 0xff & t; t>>=8;
 	bits[2] = 0xff & t; t>>=8;
 	bits[1] = 0xff & t; t>>=8;

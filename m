Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVJXR5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVJXR5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVJXR5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:57:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38637 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751203AbVJXR5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:57:06 -0400
Date: Mon, 24 Oct 2005 13:57:06 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/5] crypto/sha1.c: avoid shifting count left and right
In-reply-to: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0510241356270.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0510241347081.5288@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch avoids shifting the count left and right needlessly for each
call to sha1_update().  It instead can be done only once at the end in
sha1_final().

Keeping the previous test example (sha1_update() successively called with
len=64), a 1.3% performance increase can be observed on i386, or 0.2% on
ARM.  The generated code is also smaller on ARM.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/crypto/sha1.c
===================================================================
--- linux-2.6.orig/crypto/sha1.c
+++ linux-2.6/crypto/sha1.c
@@ -51,8 +51,8 @@
 	unsigned int partial, done;
 	u32 temp[SHA_WORKSPACE_WORDS];
 
-	partial = (sctx->count >> 3) & 0x3f;
-	sctx->count += len << 3;
+	partial = sctx->count & 0x3f;
+	sctx->count += len;
 	done = 0;
 
 	if ((partial + len) > 63) {
@@ -80,7 +80,7 @@
 	u8 bits[8] = { 0, };
 	static const u8 padding[64] = { 0x80, };
 
-	t = sctx->count;
+	t = sctx->count << 3;
 	bits[7] = 0xff & t; t>>=8;
 	bits[6] = 0xff & t; t>>=8;
 	bits[5] = 0xff & t; t>>=8;
@@ -91,7 +91,7 @@
 	bits[0] = 0xff & t;
 
 	/* Pad out to 56 mod 64 */
-	index = (sctx->count >> 3) & 0x3f;
+	index = sctx->count & 0x3f;
 	padlen = (index < 56) ? (56 - index) : ((64+56) - index);
 	sha1_update(sctx, padding, padlen);
 

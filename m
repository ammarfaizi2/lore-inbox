Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUA3Qgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUA3Qgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:36:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22402 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261881AbUA3Qgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:36:39 -0500
Date: Fri, 30 Jan 2004 11:35:20 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jakub Jelinek <jakub@redhat.com>
cc: Dave Paris <dparis@w3works.com>, <linux-kernel@vger.kernel.org>,
       <rspchan@starhub.net.sg>, "David S. Miller" <davem@redhat.com>
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
In-Reply-To: <20040130152835.GN31589@devserv.devel.redhat.com>
Message-ID: <Xine.LNX.4.44.0401301133350.16128-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, Jakub Jelinek wrote:

> The problematic line in sha256.c is:
> static void sha256_final(void* ctx, u8 *out)
> {
> ...
> 	const u8 padding[64] = { 0x80, };
> 
> where if you are unlucky, scheduler will with various different GCC versions
> on various architectures reorder instructions so that store of 0x80 into the
> struct is before clearing of the 64 bytes.
> 
> On the other side, doing this in sha256.c seems quite inefficient, IMHO much
> better would be to have there static u8 padding[64] = { 0x80 };
> because that will not mean clearing 64 bytes and writing another one on top
> of it every time the routine is executed.

Proposed patch below.  I think sha512 would have been ok, but might as 
well make them the same.

R Chan, please test and let us know if it fixes the problem for you.


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.2-rc2-mm2.o/crypto/sha256.c linux-2.6.2-rc2-mm2.w/crypto/sha256.c
--- linux-2.6.2-rc2-mm2.o/crypto/sha256.c	2003-09-27 20:50:15.000000000 -0400
+++ linux-2.6.2-rc2-mm2.w/crypto/sha256.c	2004-01-30 11:27:26.465531792 -0500
@@ -295,7 +295,7 @@
 	u8 bits[8];
 	unsigned int index, pad_len, t;
 	int i, j;
-	const u8 padding[64] = { 0x80, };
+	static u8 padding[64] = { 0x80, };
 
 	/* Save number of bits */
 	t = sctx->count[0];
diff -urN -X dontdiff linux-2.6.2-rc2-mm2.o/crypto/sha512.c linux-2.6.2-rc2-mm2.w/crypto/sha512.c
--- linux-2.6.2-rc2-mm2.o/crypto/sha512.c	2003-09-27 20:51:04.000000000 -0400
+++ linux-2.6.2-rc2-mm2.w/crypto/sha512.c	2004-01-30 11:32:16.182488120 -0500
@@ -249,7 +249,7 @@
 {
         struct sha512_ctx *sctx = ctx;
 	
-        const static u8 padding[128] = { 0x80, };
+        static u8 padding[128] = { 0x80, };
 
         u32 t;
 	u64 t2;


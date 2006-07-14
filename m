Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161177AbWGNCOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWGNCOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWGNCOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:14:24 -0400
Received: from maxipes.logix.cz ([217.11.251.249]:13700 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S1161167AbWGNCOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:14:23 -0400
Message-ID: <44B6FDF7.2030801@logix.cz>
Date: Fri, 14 Jul 2006 14:14:15 +1200
From: Michal Ludvig <michal@logix.cz>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CRYPTO] padlock: Fix alignment after aes_ctx rearrange
References: <44B6FC90.2060501@logix.cz>
In-Reply-To: <44B6FC90.2060501@logix.cz>
Content-Type: multipart/mixed;
 boundary="------------020803050400050404080801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020803050400050404080801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Michal Ludvig wrote:
> Hi Herbert,
> 
> I just recently discovered that your patch that rearranges struct
> aes_ctx in padlock-aes.c breaks the alignment rules for xcrypt leading
> to GPF Oopses.
> 
> Note that *all* addresses passed to xcrypt must be 16-Bytes aligned for
> VIA C3 (including IV and Key - the latter one was not aligned and
> triggered this Oops).
> 
> As the rearrange patch made it to 2.6.18-rc1 it must be fixed before
> 2.6.18 is out. Attached is a patch.

Ehrm, ... now it is attached ;-)

Michal

--------------020803050400050404080801
Content-Type: text/x-patch;
 name="fix-alignment-of-aes_ctx.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-alignment-of-aes_ctx.diff"

Subject: padlock: Fix alignment after aes_ctx rearrange

Herbert's patch 82062c72cd643c99a9e1c231270acbab986fd23f 
in cryptodev-2.6 tree breaks alignment rules for PadLock 
xcrypt instruction leading to General protection Oopses.

This patch fixes the problem.

Signed-off-by: Michal Ludvig <michal@logix.cz>

Index: linux-2.6.16.13-xenU/drivers/crypto/padlock-aes.c
===================================================================
--- linux-2.6.16.13-xenU.orig/drivers/crypto/padlock-aes.c
+++ linux-2.6.16.13-xenU/drivers/crypto/padlock-aes.c
@@ -59,6 +59,9 @@
 #define AES_EXTENDED_KEY_SIZE	64	/* in uint32_t units */
 #define AES_EXTENDED_KEY_SIZE_B	(AES_EXTENDED_KEY_SIZE * sizeof(uint32_t))
 
+/* Whenever making any changes to the following
+ * structure *make sure* you keep E, d_data
+ * and cword aligned on 16 Bytes boundaries!!! */
 struct aes_ctx {
 	struct {
 		struct cword encrypt;
@@ -66,8 +69,10 @@ struct aes_ctx {
 	} cword;
 	u32 *D;
 	int key_length;
-	u32 E[AES_EXTENDED_KEY_SIZE];
-	u32 d_data[AES_EXTENDED_KEY_SIZE];
+	u32 E[AES_EXTENDED_KEY_SIZE]
+		__attribute__ ((__aligned__(PADLOCK_ALIGNMENT)));
+	u32 d_data[AES_EXTENDED_KEY_SIZE]
+		__attribute__ ((__aligned__(PADLOCK_ALIGNMENT)));
 };
 
 /* ====== Key management routines ====== */

--------------020803050400050404080801--

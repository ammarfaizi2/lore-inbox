Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751608AbWDDH4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWDDH4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 03:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWDDH4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 03:56:03 -0400
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:49218 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1751608AbWDDH4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 03:56:01 -0400
Date: Tue, 04 Apr 2006 16:55:52 +0900 (JST)
Message-Id: <20060404.165552.52129978.nemoto@toshiba-tops.co.jp>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] crypto: fix unaligned access in khazad module
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060403231122.GA32271@gondor.apana.org.au>
References: <20060309.122638.07642914.nemoto@toshiba-tops.co.jp>
	<20060404.000518.126141927.anemo@mba.ocn.ne.jp>
	<20060403231122.GA32271@gondor.apana.org.au>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2006 09:11:22 +1000, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > -	K2 = be64_to_cpu(key[0]);
> > -	K1 = be64_to_cpu(key[1]);
> > +	K2 = be64_to_cpu(get_unaligned(&key[0]));
> > +	K1 = be64_to_cpu(get_unaligned(&key[1]));
> 
> Would it be possible to turn these into two 32-bit aligned reads instead?

Done now.  I've missed your comment on 10 Mar, sorry for duplication.


On 64-bit platform, reading 64-bit keys (which is supposed to be
32-bit aligned) at a time will result in unaligned access.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/crypto/khazad.c b/crypto/khazad.c
index 807f2bf..5b8dc9a 100644
--- a/crypto/khazad.c
+++ b/crypto/khazad.c
@@ -758,7 +758,7 @@ static int khazad_setkey(void *ctx_arg, 
                        unsigned int key_len, u32 *flags)
 {
 	struct khazad_ctx *ctx = ctx_arg;
-	const __be64 *key = (const __be64 *)in_key;
+	const __be32 *key = (const __be32 *)in_key;
 	int r;
 	const u64 *S = T7;
 	u64 K2, K1;
@@ -769,8 +769,9 @@ static int khazad_setkey(void *ctx_arg, 
 		return -EINVAL;
 	}
 
-	K2 = be64_to_cpu(key[0]);
-	K1 = be64_to_cpu(key[1]);
+	/* key is supposed to be 32-bit aligned */
+	K2 = ((u64)be32_to_cpu(key[0]) << 32) | be32_to_cpu(key[1]);
+	K1 = ((u64)be32_to_cpu(key[2]) << 32) | be32_to_cpu(key[3]);
 
 	/* setup the encrypt key */
 	for (r = 0; r <= KHAZAD_ROUNDS; r++) {

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVDNXNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVDNXNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVDNXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:13:24 -0400
Received: from mail.dif.dk ([193.138.115.101]:59265 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261636AbVDNXNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:13:10 -0400
Date: Fri, 15 Apr 2005 01:15:58 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@intercode.com.au>, linux-crypto@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: resource release functions ought to check for NULL
 (crypto_free_tfm)
Message-ID: <Pine.LNX.4.62.0504150106420.3466@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As far as I'm aware there's a general concensus that functions that are 
responsible for freeing resources should be able to cope with being passed 
a NULL pointer. This makes sense as it removes the need for all callers to 
check for NULL, thus elliminating the bugs that happen when some forget 
(safer to just check centrally in the freeing function) and it also makes 
for smaller code all over due to the lack of all those NULL checks.
This patch makes it safe to pass the crypto_free_tfm() function a NULL 
pointer. Once this patch is applied we can start removing the NULL checks 
from the callers.  
Please consider applying.

Please CC: me on replies as I'm not subscribed to linux-crypto


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 api.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/crypto/api.c	2005-04-11 21:20:39.000000000 +0200
+++ linux-2.6.12-rc2-mm3/crypto/api.c	2005-04-15 01:05:52.000000000 +0200
@@ -163,8 +163,14 @@ out:
 
 void crypto_free_tfm(struct crypto_tfm *tfm)
 {
-	struct crypto_alg *alg = tfm->__crt_alg;
-	int size = sizeof(*tfm) + alg->cra_ctxsize;
+	struct crypto_alg *alg;
+	int size;
+
+	if (!tfm)
+		return;
+
+	alg = tfm->__crt_alg;
+	size = sizeof(*tfm) + alg->cra_ctxsize;
 
 	crypto_exit_ops(tfm);
 	crypto_alg_put(alg);



-- 
Jesper Juhl

PS. Please CC: me on replies to linux-crypto as I'm not subscribed to that 
list.



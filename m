Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbUKLIq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbUKLIq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 03:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbUKLIq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 03:46:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27525 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262491AbUKLIpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 03:45:40 -0500
Date: Fri, 12 Nov 2004 03:45:26 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Zbigniew Szmek <zjedrzejewski-szmek@wp.pl>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] make crypto modular
In-Reply-To: <200411090102.27288.zjedrzejewski-szmek@wp.pl>
Message-ID: <Xine.LNX.4.44.0411120338420.3502-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, Zbigniew Szmek wrote:

> Fixed as proposed above. Updated patch below. -Zbyszek

The airo driver and xfrm_probe_algs need to be updated to handle modular 
crypto: both are expecting a static crypto API.

xfrm_probe_algs needs crypto_alg_available, which means that either
xfrm_algo.c needs to be made modular, or selecting XFRM forces a static
crypto module.  I've implemented the latter below.

Also, a couple of cosmetic fixes.


---

diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/crypto/hmac.c linux-2.6.10-rc1-mm1.w/crypto/hmac.c
--- linux-2.6.10-rc1-mm1.p/crypto/hmac.c	2004-11-12 03:06:32.000000000 -0500
+++ linux-2.6.10-rc1-mm1.w/crypto/hmac.c	2004-11-12 03:11:13.000000000 -0500
@@ -130,6 +130,5 @@ EXPORT_SYMBOL_GPL(crypto_hmac_init);
 EXPORT_SYMBOL_GPL(crypto_hmac_update);
 EXPORT_SYMBOL_GPL(crypto_hmac_final);
 EXPORT_SYMBOL_GPL(crypto_hmac);
-
 EXPORT_SYMBOL_GPL(crypto_alloc_hmac_block);
 EXPORT_SYMBOL_GPL(crypto_free_hmac_block);
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/crypto/proc.c linux-2.6.10-rc1-mm1.w/crypto/proc.c
--- linux-2.6.10-rc1-mm1.p/crypto/proc.c	2004-11-12 03:06:32.000000000 -0500
+++ linux-2.6.10-rc1-mm1.w/crypto/proc.c	2004-11-12 03:14:53.000000000 -0500
@@ -108,12 +108,10 @@ int __init crypto_init_proc(void)
 	int ret = 0;
 	
 	proc = create_proc_entry("crypto", 0, NULL);
-	if (proc) {
+	if (proc)
 		proc->proc_fops = &proc_crypto_ops;
-	} else {
+	else
 		ret = -ENOMEM;
-	}
-
 	return ret;
 }
 
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/drivers/net/wireless/airo.c linux-2.6.10-rc1-mm1.w/drivers/net/wireless/airo.c
--- linux-2.6.10-rc1-mm1.p/drivers/net/wireless/airo.c	2004-10-27 01:55:49.000000000 -0400
+++ linux-2.6.10-rc1-mm1.w/drivers/net/wireless/airo.c	2004-11-12 03:07:36.000000000 -0500
@@ -88,7 +88,7 @@ static struct pci_driver airo_driver = {
 /* Support Cisco MIC feature */
 #define MICSUPPORT
 
-#if defined(MICSUPPORT) && !defined(CONFIG_CRYPTO)
+#if defined(MICSUPPORT) && !(defined(CONFIG_CRYPTO) || defined(CONFIG_CRYPTO_MODULE))
 #warning MIC support requires Crypto API
 #undef MICSUPPORT
 #endif
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/net/xfrm/Kconfig linux-2.6.10-rc1-mm1.w/net/xfrm/Kconfig
--- linux-2.6.10-rc1-mm1.p/net/xfrm/Kconfig	2004-08-14 01:36:58.000000000 -0400
+++ linux-2.6.10-rc1-mm1.w/net/xfrm/Kconfig	2004-11-12 03:38:33.836574288 -0500
@@ -3,6 +3,7 @@
 #
 config XFRM
        bool
+       select CRYPTO
        depends on NET
 
 config XFRM_USER
diff -purN -X dontdiff linux-2.6.10-rc1-mm1.p/net/xfrm/xfrm_algo.c linux-2.6.10-rc1-mm1.w/net/xfrm/xfrm_algo.c
--- linux-2.6.10-rc1-mm1.p/net/xfrm/xfrm_algo.c	2004-08-14 01:36:56.000000000 -0400
+++ linux-2.6.10-rc1-mm1.w/net/xfrm/xfrm_algo.c	2004-11-12 03:38:15.808315000 -0500
@@ -431,7 +431,6 @@ struct xfrm_algo_desc *xfrm_calg_get_byi
  */
 void xfrm_probe_algs(void)
 {
-#ifdef CONFIG_CRYPTO
 	int i, status;
 	
 	BUG_ON(in_softirq());
@@ -453,7 +452,6 @@ void xfrm_probe_algs(void)
 		if (calg_list[i].available != status)
 			calg_list[i].available = status;
 	}
-#endif
 }
 
 int xfrm_count_auth_supported(void)


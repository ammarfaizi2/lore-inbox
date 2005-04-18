Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVDRPXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVDRPXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVDRPXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:23:51 -0400
Received: from mail.dif.dk ([193.138.115.101]:64166 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262101AbVDRPUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:20:41 -0400
Date: Mon, 18 Apr 2005 17:23:31 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
       James Morris <jmorris@intercode.com.au>, linux-crypto@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: resource release functions ought to check for
 NULL (crypto_free_tfm)
In-Reply-To: <20050418114925.GA6854@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.62.0504181718540.2480@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504150106420.3466@dragon.hyggekrogen.localhost>
 <20050418114925.GA6854@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005, Herbert Xu wrote:

> On Fri, Apr 15, 2005 at 01:15:58AM +0200, Jesper Juhl wrote:
> > 
> > As far as I'm aware there's a general concensus that functions that are 
> > responsible for freeing resources should be able to cope with being passed 
> > a NULL pointer. This makes sense as it removes the need for all callers to 
> 
> In general I'd only do this when most of the callers are doing the
> NULL check.  As that seems to be the case here, I agree with your
> change.  I've applied it to my tree.
> 
Great, thank you.

Next step is to then clean up the callers of crypto_free_tfm so they no 
longer do the redundant NULL check. Below is a patch to do that.


Signed-off-by: Jesper Juhl <juhl
---

 drivers/net/wireless/airo.c                     |    3 --
 drivers/net/wireless/hostap/hostap_crypt_ccmp.c |    5 +---
 drivers/net/wireless/hostap/hostap_crypt_tkip.c |   10 +++-----
 drivers/net/wireless/hostap/hostap_crypt_wep.c  |    5 +---
 net/ieee80211/ieee80211_crypt_ccmp.c            |    5 +---
 net/ieee80211/ieee80211_crypt_tkip.c            |   10 +++-----
 net/ieee80211/ieee80211_crypt_wep.c             |    5 +---
 net/ipv4/ah4.c                                  |   18 +++++----------
 net/ipv4/esp4.c                                 |   28 ++++++++++--------------
 net/ipv4/ipcomp.c                               |    3 --
 net/ipv6/addrconf.c                             |    6 +----
 net/ipv6/ah6.c                                  |   20 ++++++-----------
 net/ipv6/esp6.c                                 |   28 ++++++++++--------------
 net/ipv6/ipcomp6.c                              |    3 --
 net/sctp/endpointola.c                          |    3 --
 net/sctp/socket.c                               |    3 --
 net/sunrpc/auth_gss/gss_krb5_crypto.c           |    3 --
 net/sunrpc/auth_gss/gss_krb5_mech.c             |    9 ++-----
 net/sunrpc/auth_gss/gss_spkm3_mech.c            |   12 +++-------
 19 files changed, 69 insertions(+), 110 deletions(-)


--- linux-2.6.12-rc2-mm3-orig/drivers/net/wireless/airo.c	2005-04-11 21:20:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/net/wireless/airo.c	2005-04-18 16:57:57.000000000 +0200
@@ -2406,8 +2406,7 @@ void stop_airo_card( struct net_device *
 		}
         }
 #ifdef MICSUPPORT
-	if (ai->tfm)
-		crypto_free_tfm(ai->tfm);
+	crypto_free_tfm(ai->tfm);
 #endif
 	del_airo_dev( dev );
 	free_netdev( dev );
--- linux-2.6.12-rc2-mm3-orig/drivers/net/wireless/hostap/hostap_crypt_ccmp.c	2005-04-11 21:20:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/net/wireless/hostap/hostap_crypt_ccmp.c	2005-04-18 16:58:36.000000000 +0200
@@ -109,8 +109,7 @@ static void * hostap_ccmp_init(int key_i
 
 fail:
 	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
+		crypto_free_tfm(priv->tfm);
 		kfree(priv);
 	}
 	module_put(THIS_MODULE);
@@ -121,7 +120,7 @@ fail:
 static void hostap_ccmp_deinit(void *priv)
 {
 	struct hostap_ccmp_data *_priv = priv;
-	if (_priv && _priv->tfm)
+	if (_priv)
 		crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 	module_put(THIS_MODULE);
--- linux-2.6.12-rc2-mm3-orig/drivers/net/wireless/hostap/hostap_crypt_tkip.c	2005-04-11 21:20:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/net/wireless/hostap/hostap_crypt_tkip.c	2005-04-18 16:59:44.000000000 +0200
@@ -102,10 +102,8 @@ static void * hostap_tkip_init(int key_i
 
 fail:
 	if (priv) {
-		if (priv->tfm_michael)
-			crypto_free_tfm(priv->tfm_michael);
-		if (priv->tfm_arc4)
-			crypto_free_tfm(priv->tfm_arc4);
+		crypto_free_tfm(priv->tfm_michael);
+		crypto_free_tfm(priv->tfm_arc4);
 		kfree(priv);
 	}
 	module_put(THIS_MODULE);
@@ -116,10 +114,10 @@ fail:
 static void hostap_tkip_deinit(void *priv)
 {
 	struct hostap_tkip_data *_priv = priv;
-	if (_priv && _priv->tfm_michael)
+	if (_priv) {
 		crypto_free_tfm(_priv->tfm_michael);
-	if (_priv && _priv->tfm_arc4)
 		crypto_free_tfm(_priv->tfm_arc4);
+	}
 	kfree(priv);
 	module_put(THIS_MODULE);
 }
--- linux-2.6.12-rc2-mm3-orig/drivers/net/wireless/hostap/hostap_crypt_wep.c	2005-04-11 21:20:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/net/wireless/hostap/hostap_crypt_wep.c	2005-04-18 17:00:28.000000000 +0200
@@ -69,8 +69,7 @@ static void * prism2_wep_init(int keyidx
 
 fail:
 	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
+		crypto_free_tfm(priv->tfm);
 		kfree(priv);
 	}
 	module_put(THIS_MODULE);
@@ -81,7 +80,7 @@ fail:
 static void prism2_wep_deinit(void *priv)
 {
 	struct prism2_wep_data *_priv = priv;
-	if (_priv && _priv->tfm)
+	if (_priv)
 		crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 	module_put(THIS_MODULE);
--- linux-2.6.12-rc2-mm3-orig/net/ieee80211/ieee80211_crypt_ccmp.c	2005-04-11 21:20:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/ieee80211/ieee80211_crypt_ccmp.c	2005-04-18 17:01:27.000000000 +0200
@@ -96,8 +96,7 @@ static void * ieee80211_ccmp_init(int ke
 
 fail:
 	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
+		crypto_free_tfm(priv->tfm);
 		kfree(priv);
 	}
 
@@ -108,7 +107,7 @@ fail:
 static void ieee80211_ccmp_deinit(void *priv)
 {
 	struct ieee80211_ccmp_data *_priv = priv;
-	if (_priv && _priv->tfm)
+	if (_priv)
 		crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 }
--- linux-2.6.12-rc2-mm3-orig/net/ieee80211/ieee80211_crypt_tkip.c	2005-04-11 21:20:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/ieee80211/ieee80211_crypt_tkip.c	2005-04-18 17:01:58.000000000 +0200
@@ -90,10 +90,8 @@ static void * ieee80211_tkip_init(int ke
 
 fail:
 	if (priv) {
-		if (priv->tfm_michael)
-			crypto_free_tfm(priv->tfm_michael);
-		if (priv->tfm_arc4)
-			crypto_free_tfm(priv->tfm_arc4);
+		crypto_free_tfm(priv->tfm_michael);
+		crypto_free_tfm(priv->tfm_arc4);
 		kfree(priv);
 	}
 
@@ -104,10 +102,10 @@ fail:
 static void ieee80211_tkip_deinit(void *priv)
 {
 	struct ieee80211_tkip_data *_priv = priv;
-	if (_priv && _priv->tfm_michael)
+	if (_priv) {
 		crypto_free_tfm(_priv->tfm_michael);
-	if (_priv && _priv->tfm_arc4)
 		crypto_free_tfm(_priv->tfm_arc4);
+	}
 	kfree(priv);
 }
 
--- linux-2.6.12-rc2-mm3-orig/net/ieee80211/ieee80211_crypt_wep.c	2005-04-11 21:20:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/ieee80211/ieee80211_crypt_wep.c	2005-04-18 17:02:24.000000000 +0200
@@ -64,8 +64,7 @@ static void * prism2_wep_init(int keyidx
 
 fail:
 	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
+		crypto_free_tfm(priv->tfm);
 		kfree(priv);
 	}
 	return NULL;
@@ -75,7 +74,7 @@ fail:
 static void prism2_wep_deinit(void *priv)
 {
 	struct prism2_wep_data *_priv = priv;
-	if (_priv && _priv->tfm)
+	if (_priv)
 		crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 }
--- linux-2.6.12-rc2-mm3-orig/net/ipv4/ah4.c	2005-04-05 21:21:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/ipv4/ah4.c	2005-04-18 17:03:36.000000000 +0200
@@ -263,10 +263,8 @@ static int ah_init_state(struct xfrm_sta
 
 error:
 	if (ahp) {
-		if (ahp->work_icv)
-			kfree(ahp->work_icv);
-		if (ahp->tfm)
-			crypto_free_tfm(ahp->tfm);
+		kfree(ahp->work_icv);
+		crypto_free_tfm(ahp->tfm);
 		kfree(ahp);
 	}
 	return -EINVAL;
@@ -279,14 +277,10 @@ static void ah_destroy(struct xfrm_state
 	if (!ahp)
 		return;
 
-	if (ahp->work_icv) {
-		kfree(ahp->work_icv);
-		ahp->work_icv = NULL;
-	}
-	if (ahp->tfm) {
-		crypto_free_tfm(ahp->tfm);
-		ahp->tfm = NULL;
-	}
+	kfree(ahp->work_icv);
+	ahp->work_icv = NULL;
+	crypto_free_tfm(ahp->tfm);
+	ahp->tfm = NULL;
 	kfree(ahp);
 }
 
--- linux-2.6.12-rc2-mm3-orig/net/ipv4/esp4.c	2005-04-05 21:21:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/ipv4/esp4.c	2005-04-18 17:09:26.000000000 +0200
@@ -343,22 +343,18 @@ static void esp_destroy(struct xfrm_stat
 	if (!esp)
 		return;
 
-	if (esp->conf.tfm) {
-		crypto_free_tfm(esp->conf.tfm);
-		esp->conf.tfm = NULL;
-	}
-	if (esp->conf.ivec) {
-		kfree(esp->conf.ivec);
-		esp->conf.ivec = NULL;
-	}
-	if (esp->auth.tfm) {
-		crypto_free_tfm(esp->auth.tfm);
-		esp->auth.tfm = NULL;
-	}
-	if (esp->auth.work_icv) {
-		kfree(esp->auth.work_icv);
-		esp->auth.work_icv = NULL;
-	}
+	crypto_free_tfm(esp->conf.tfm);
+	esp->conf.tfm = NULL;
+
+	kfree(esp->conf.ivec);
+	esp->conf.ivec = NULL;
+
+	crypto_free_tfm(esp->auth.tfm);
+	esp->auth.tfm = NULL;
+
+	kfree(esp->auth.work_icv);
+	esp->auth.work_icv = NULL;
+
 	kfree(esp);
 }
 
--- linux-2.6.12-rc2-mm3-orig/net/ipv4/ipcomp.c	2005-04-05 21:21:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/ipv4/ipcomp.c	2005-04-18 17:09:42.000000000 +0200
@@ -350,8 +350,7 @@ static void ipcomp_free_tfms(struct cryp
 
 	for_each_cpu(cpu) {
 		struct crypto_tfm *tfm = *per_cpu_ptr(tfms, cpu);
-		if (tfm)
-			crypto_free_tfm(tfm);
+		crypto_free_tfm(tfm);
 	}
 	free_percpu(tfms);
 }
--- linux-2.6.12-rc2-mm3-orig/net/ipv6/addrconf.c	2005-04-11 21:20:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/ipv6/addrconf.c	2005-04-18 17:10:08.000000000 +0200
@@ -3604,10 +3604,8 @@ void __exit addrconf_cleanup(void)
 	rtnl_unlock();
 
 #ifdef CONFIG_IPV6_PRIVACY
-	if (likely(md5_tfm != NULL)) {
-		crypto_free_tfm(md5_tfm);
-		md5_tfm = NULL;
-	}
+	crypto_free_tfm(md5_tfm);
+	md5_tfm = NULL;
 #endif
 
 #ifdef CONFIG_PROC_FS
--- linux-2.6.12-rc2-mm3-orig/net/ipv6/ah6.c	2005-04-05 21:21:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/ipv6/ah6.c	2005-04-18 17:10:50.000000000 +0200
@@ -402,10 +402,8 @@ static int ah6_init_state(struct xfrm_st
 
 error:
 	if (ahp) {
-		if (ahp->work_icv)
-			kfree(ahp->work_icv);
-		if (ahp->tfm)
-			crypto_free_tfm(ahp->tfm);
+		kfree(ahp->work_icv);
+		crypto_free_tfm(ahp->tfm);
 		kfree(ahp);
 	}
 	return -EINVAL;
@@ -418,14 +416,12 @@ static void ah6_destroy(struct xfrm_stat
 	if (!ahp)
 		return;
 
-	if (ahp->work_icv) {
-		kfree(ahp->work_icv);
-		ahp->work_icv = NULL;
-	}
-	if (ahp->tfm) {
-		crypto_free_tfm(ahp->tfm);
-		ahp->tfm = NULL;
-	}
+	kfree(ahp->work_icv);
+	ahp->work_icv = NULL;
+
+	crypto_free_tfm(ahp->tfm);
+	ahp->tfm = NULL;
+
 	kfree(ahp);
 }
 
--- linux-2.6.12-rc2-mm3-orig/net/ipv6/esp6.c	2005-04-05 21:21:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/ipv6/esp6.c	2005-04-18 17:11:29.000000000 +0200
@@ -277,22 +277,18 @@ static void esp6_destroy(struct xfrm_sta
 	if (!esp)
 		return;
 
-	if (esp->conf.tfm) {
-		crypto_free_tfm(esp->conf.tfm);
-		esp->conf.tfm = NULL;
-	}
-	if (esp->conf.ivec) {
-		kfree(esp->conf.ivec);
-		esp->conf.ivec = NULL;
-	}
-	if (esp->auth.tfm) {
-		crypto_free_tfm(esp->auth.tfm);
-		esp->auth.tfm = NULL;
-	}
-	if (esp->auth.work_icv) {
-		kfree(esp->auth.work_icv);
-		esp->auth.work_icv = NULL;
-	}
+	crypto_free_tfm(esp->conf.tfm);
+	esp->conf.tfm = NULL;
+
+	kfree(esp->conf.ivec);
+	esp->conf.ivec = NULL;
+
+	crypto_free_tfm(esp->auth.tfm);
+	esp->auth.tfm = NULL;
+
+	kfree(esp->auth.work_icv);
+	esp->auth.work_icv = NULL;
+
 	kfree(esp);
 }
 
--- linux-2.6.12-rc2-mm3-orig/net/ipv6/ipcomp6.c	2005-04-05 21:21:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/ipv6/ipcomp6.c	2005-04-18 17:11:40.000000000 +0200
@@ -346,8 +346,7 @@ static void ipcomp6_free_tfms(struct cry
 
 	for_each_cpu(cpu) {
 		struct crypto_tfm *tfm = *per_cpu_ptr(tfms, cpu);
-		if (tfm)
-			crypto_free_tfm(tfm);
+		crypto_free_tfm(tfm);
 	}
 	free_percpu(tfms);
 }
--- linux-2.6.12-rc2-mm3-orig/net/sctp/endpointola.c	2005-04-05 21:21:58.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/sctp/endpointola.c	2005-04-18 17:12:15.000000000 +0200
@@ -194,8 +194,7 @@ static void sctp_endpoint_destroy(struct
 	sctp_unhash_endpoint(ep);
 
 	/* Free up the HMAC transform. */
-	if (sctp_sk(ep->base.sk)->hmac)
-		sctp_crypto_free_tfm(sctp_sk(ep->base.sk)->hmac);
+	sctp_crypto_free_tfm(sctp_sk(ep->base.sk)->hmac);
 
 	/* Cleanup. */
 	sctp_inq_free(&ep->base.inqueue);
--- linux-2.6.12-rc2-mm3-orig/net/sctp/socket.c	2005-04-05 21:21:59.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/sctp/socket.c	2005-04-18 17:12:28.000000000 +0200
@@ -4005,8 +4005,7 @@ out:
 	sctp_release_sock(sk);
 	return err;
 cleanup:
-	if (tfm)
-		sctp_crypto_free_tfm(tfm);
+	sctp_crypto_free_tfm(tfm);
 	goto out;
 }
 
--- linux-2.6.12-rc2-mm3-orig/net/sunrpc/auth_gss/gss_krb5_crypto.c	2005-03-02 08:37:47.000000000 +0100
+++ linux-2.6.12-rc2-mm3/net/sunrpc/auth_gss/gss_krb5_crypto.c	2005-04-18 17:12:36.000000000 +0200
@@ -201,8 +201,7 @@ make_checksum(s32 cksumtype, char *heade
 	crypto_digest_final(tfm, cksum->data);
 	code = 0;
 out:
-	if (tfm)
-		crypto_free_tfm(tfm);
+	crypto_free_tfm(tfm);
 	return code;
 }
 
--- linux-2.6.12-rc2-mm3-orig/net/sunrpc/auth_gss/gss_krb5_mech.c	2005-04-05 21:21:59.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/sunrpc/auth_gss/gss_krb5_mech.c	2005-04-18 17:13:20.000000000 +0200
@@ -185,12 +185,9 @@ static void
 gss_delete_sec_context_kerberos(void *internal_ctx) {
 	struct krb5_ctx *kctx = internal_ctx;
 
-	if (kctx->seq)
-		crypto_free_tfm(kctx->seq);
-	if (kctx->enc)
-		crypto_free_tfm(kctx->enc);
-	if (kctx->mech_used.data)
-		kfree(kctx->mech_used.data);
+	crypto_free_tfm(kctx->seq);
+	crypto_free_tfm(kctx->enc);
+	kfree(kctx->mech_used.data);
 	kfree(kctx);
 }
 
--- linux-2.6.12-rc2-mm3-orig/net/sunrpc/auth_gss/gss_spkm3_mech.c	2005-04-05 21:21:59.000000000 +0200
+++ linux-2.6.12-rc2-mm3/net/sunrpc/auth_gss/gss_spkm3_mech.c	2005-04-18 17:13:45.000000000 +0200
@@ -214,14 +214,10 @@ static void
 gss_delete_sec_context_spkm3(void *internal_ctx) {
 	struct spkm3_ctx *sctx = internal_ctx;
 
-	if(sctx->derived_integ_key)
-		crypto_free_tfm(sctx->derived_integ_key);
-	if(sctx->derived_conf_key)
-		crypto_free_tfm(sctx->derived_conf_key);
-	if(sctx->share_key.data)
-		kfree(sctx->share_key.data);
-	if(sctx->mech_used.data)
-		kfree(sctx->mech_used.data);
+	crypto_free_tfm(sctx->derived_integ_key);
+	crypto_free_tfm(sctx->derived_conf_key);
+	kfree(sctx->share_key.data);
+	kfree(sctx->mech_used.data);
 	kfree(sctx);
 }
 



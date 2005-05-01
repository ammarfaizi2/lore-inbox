Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVEABqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVEABqq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 21:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVEABqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 21:46:46 -0400
Received: from mail.dif.dk ([193.138.115.101]:22951 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261495AbVEABo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 21:44:58 -0400
Date: Sun, 1 May 2005 03:48:16 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: acme@ghostprotocols.net, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Jouni Malinen <jkmaline@cc.hut.fi>,
       James Morris <jmorris@intercode.com.au>,
       Pedro Roque <roque@di.fc.ul.pt>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Kunihiro Ishiguro <kunihiro@ipinfusion.com>,
       Mitsuru KANDA <mk@linux-ipv6.org>,
       lksctp-developers@lists.sourceforge.net,
       Andy Adamson <andros@umich.edu>, Bruce Fields <bfields@umich.edu>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] resource release cleanup in net/ (take 2)
In-Reply-To: <Pine.LNX.4.62.0505010341560.2094@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0505010346280.2094@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504302219520.2094@dragon.hyggekrogen.localhost>
 <39e6f6c705043014264eb4c0c5@mail.gmail.com>
 <Pine.LNX.4.62.0505010341560.2094@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2005, Jesper Juhl wrote:

> On Sat, 30 Apr 2005, Arnaldo Carvalho de Melo wrote:
> 
> > On 4/30/05, Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > > Hi David,
> > > 
> > > Since Andrew merged the patch that makes calling crypto_free_tfm() with a
> > > NULL pointer safe into 2.6.12-rc3-mm1, I made a patch to remove checks for
> > > NULL before calling that function, and while I was at it I removed similar
> > > redundant checks before calls to kfree() and vfree() in the same files.
> > > There are also a few tiny whitespace cleanups in there.
> > 
> > Jesper, I'd suggest that you left whitespaces for a separate patch, it
> > is always,
> > IMHO, better to have as small a patch as possible for reviewing.
> > 
> Sure thing. I've split the patches, and I believe that me going through 
> them a second time did them good, there are a few tiny changes over the 
> first version.
> 
> I split the patch in 4 parts (will send as replies to this mail) : 
> 	1) crypto_free_tfm related changes
> 	2) kfree related changes
> 	3) vfree related changes
> 	4) whitespace changes
> The whitespace changes ended up fairly bigger than initially. I expanded 
> the cleanup a bit. It's not a perfect, 100% complete cleanup, but it's IMO 
> a lot better than the originals.
> 

Here are the crypto_free_tfm changes.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/net/wireless/airo.c                     |    3 +--
 drivers/net/wireless/hostap/hostap_crypt_ccmp.c |    5 ++---
 drivers/net/wireless/hostap/hostap_crypt_tkip.c |   10 ++++------
 drivers/net/wireless/hostap/hostap_crypt_wep.c  |    5 ++---
 net/ieee80211/ieee80211_crypt_ccmp.c            |    5 ++---
 net/ieee80211/ieee80211_crypt_tkip.c            |   10 ++++------
 net/ieee80211/ieee80211_crypt_wep.c             |    5 ++---
 net/ipv4/ah4.c                                  |    9 +++------
 net/ipv4/esp4.c                                 |   12 ++++--------
 net/ipv4/ipcomp.c                               |    3 +--
 net/ipv6/addrconf.c                             |    6 ++----
 net/ipv6/ah6.c                                  |    9 +++------
 net/ipv6/esp6.c                                 |   12 ++++--------
 net/ipv6/ipcomp6.c                              |    3 +--
 net/sctp/endpointola.c                          |    3 +--
 net/sctp/socket.c                               |    3 +--
 net/sunrpc/auth_gss/gss_krb5_crypto.c           |    3 +--
 net/sunrpc/auth_gss/gss_krb5_mech.c             |    6 ++----
 net/sunrpc/auth_gss/gss_spkm3_mech.c            |    6 ++----
 19 files changed, 42 insertions(+), 76 deletions(-)

--- linux-2.6.12-rc3-mm1-orig/drivers/net/wireless/airo.c	2005-04-30 18:37:01.000000000 +0200
+++ linux-2.6.12-rc3-mm1/drivers/net/wireless/airo.c	2005-05-01 01:43:45.000000000 +0200
@@ -2406,8 +2406,7 @@
 		}
         }
 #ifdef MICSUPPORT
-	if (ai->tfm)
-		crypto_free_tfm(ai->tfm);
+	crypto_free_tfm(ai->tfm);
 #endif
 	del_airo_dev( dev );
 	free_netdev( dev );
--- linux-2.6.12-rc3-mm1-orig/drivers/net/wireless/hostap/hostap_crypt_ccmp.c	2005-04-30 18:37:01.000000000 +0200
+++ linux-2.6.12-rc3-mm1/drivers/net/wireless/hostap/hostap_crypt_ccmp.c	2005-05-01 01:44:07.000000000 +0200
@@ -109,8 +109,7 @@
 
 fail:
 	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
+		crypto_free_tfm(priv->tfm);
 		kfree(priv);
 	}
 	module_put(THIS_MODULE);
@@ -121,7 +120,7 @@
 static void hostap_ccmp_deinit(void *priv)
 {
 	struct hostap_ccmp_data *_priv = priv;
-	if (_priv && _priv->tfm)
+	if (_priv)
 		crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 	module_put(THIS_MODULE);
--- linux-2.6.12-rc3-mm1-orig/drivers/net/wireless/hostap/hostap_crypt_tkip.c	2005-04-30 18:37:01.000000000 +0200
+++ linux-2.6.12-rc3-mm1/drivers/net/wireless/hostap/hostap_crypt_tkip.c	2005-05-01 01:44:54.000000000 +0200
@@ -102,10 +102,8 @@
 
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
@@ -116,10 +114,10 @@
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
--- linux-2.6.12-rc3-mm1-orig/drivers/net/wireless/hostap/hostap_crypt_wep.c	2005-04-30 18:37:01.000000000 +0200
+++ linux-2.6.12-rc3-mm1/drivers/net/wireless/hostap/hostap_crypt_wep.c	2005-05-01 01:45:11.000000000 +0200
@@ -69,8 +69,7 @@
 
 fail:
 	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
+		crypto_free_tfm(priv->tfm);
 		kfree(priv);
 	}
 	module_put(THIS_MODULE);
@@ -81,7 +80,7 @@
 static void prism2_wep_deinit(void *priv)
 {
 	struct prism2_wep_data *_priv = priv;
-	if (_priv && _priv->tfm)
+	if (_priv)
 		crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 	module_put(THIS_MODULE);
--- linux-2.6.12-rc3-mm1-orig/net/ieee80211/ieee80211_crypt_ccmp.c	2005-04-30 18:37:16.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ieee80211/ieee80211_crypt_ccmp.c	2005-05-01 01:45:28.000000000 +0200
@@ -96,8 +96,7 @@
 
 fail:
 	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
+		crypto_free_tfm(priv->tfm);
 		kfree(priv);
 	}
 
@@ -108,7 +107,7 @@
 static void ieee80211_ccmp_deinit(void *priv)
 {
 	struct ieee80211_ccmp_data *_priv = priv;
-	if (_priv && _priv->tfm)
+	if (_priv)
 		crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 }
--- linux-2.6.12-rc3-mm1-orig/net/ieee80211/ieee80211_crypt_tkip.c	2005-04-30 18:37:17.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ieee80211/ieee80211_crypt_tkip.c	2005-05-01 01:47:04.000000000 +0200
@@ -90,10 +90,8 @@
 
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
 
@@ -104,10 +102,10 @@
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
 
--- linux-2.6.12-rc3-mm1-orig/net/ieee80211/ieee80211_crypt_wep.c	2005-04-30 18:37:17.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ieee80211/ieee80211_crypt_wep.c	2005-05-01 01:47:24.000000000 +0200
@@ -64,8 +64,7 @@
 
 fail:
 	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
+		crypto_free_tfm(priv->tfm);
 		kfree(priv);
 	}
 	return NULL;
@@ -75,7 +74,7 @@
 static void prism2_wep_deinit(void *priv)
 {
 	struct prism2_wep_data *_priv = priv;
-	if (_priv && _priv->tfm)
+	if (_priv)
 		crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 }
--- linux-2.6.12-rc3-mm1-orig/net/ipv4/ah4.c	2005-04-30 18:25:32.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv4/ah4.c	2005-05-01 01:48:11.000000000 +0200
@@ -265,8 +265,7 @@
 	if (ahp) {
 		if (ahp->work_icv)
 			kfree(ahp->work_icv);
-		if (ahp->tfm)
-			crypto_free_tfm(ahp->tfm);
+		crypto_free_tfm(ahp->tfm);
 		kfree(ahp);
 	}
 	return -EINVAL;
@@ -283,10 +282,8 @@
 		kfree(ahp->work_icv);
 		ahp->work_icv = NULL;
 	}
-	if (ahp->tfm) {
-		crypto_free_tfm(ahp->tfm);
-		ahp->tfm = NULL;
-	}
+	crypto_free_tfm(ahp->tfm);
+	ahp->tfm = NULL;
 	kfree(ahp);
 }
 
--- linux-2.6.12-rc3-mm1-orig/net/ipv4/esp4.c	2005-04-30 18:25:32.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv4/esp4.c	2005-05-01 01:48:36.000000000 +0200
@@ -343,18 +343,14 @@
 	if (!esp)
 		return;
 
-	if (esp->conf.tfm) {
-		crypto_free_tfm(esp->conf.tfm);
-		esp->conf.tfm = NULL;
-	}
+	crypto_free_tfm(esp->conf.tfm);
+	esp->conf.tfm = NULL;
 	if (esp->conf.ivec) {
 		kfree(esp->conf.ivec);
 		esp->conf.ivec = NULL;
 	}
-	if (esp->auth.tfm) {
-		crypto_free_tfm(esp->auth.tfm);
-		esp->auth.tfm = NULL;
-	}
+	crypto_free_tfm(esp->auth.tfm);
+	esp->auth.tfm = NULL;
 	if (esp->auth.work_icv) {
 		kfree(esp->auth.work_icv);
 		esp->auth.work_icv = NULL;
--- linux-2.6.12-rc3-mm1-orig/net/ipv4/ipcomp.c	2005-04-30 18:25:32.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv4/ipcomp.c	2005-05-01 01:49:25.000000000 +0200
@@ -350,8 +350,7 @@
 
 	for_each_cpu(cpu) {
 		struct crypto_tfm *tfm = *per_cpu_ptr(tfms, cpu);
-		if (tfm)
-			crypto_free_tfm(tfm);
+		crypto_free_tfm(tfm);
 	}
 	free_percpu(tfms);
 }
--- linux-2.6.12-rc3-mm1-orig/net/ipv6/addrconf.c	2005-04-30 18:37:17.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/addrconf.c	2005-05-01 01:50:00.000000000 +0200
@@ -3604,10 +3604,8 @@
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
--- linux-2.6.12-rc3-mm1-orig/net/ipv6/ah6.c	2005-04-30 18:25:32.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/ah6.c	2005-05-01 01:50:22.000000000 +0200
@@ -404,8 +404,7 @@
 	if (ahp) {
 		if (ahp->work_icv)
 			kfree(ahp->work_icv);
-		if (ahp->tfm)
-			crypto_free_tfm(ahp->tfm);
+		crypto_free_tfm(ahp->tfm);
 		kfree(ahp);
 	}
 	return -EINVAL;
@@ -422,10 +421,8 @@
 		kfree(ahp->work_icv);
 		ahp->work_icv = NULL;
 	}
-	if (ahp->tfm) {
-		crypto_free_tfm(ahp->tfm);
-		ahp->tfm = NULL;
-	}
+	crypto_free_tfm(ahp->tfm);
+	ahp->tfm = NULL;
 	kfree(ahp);
 }
 
--- linux-2.6.12-rc3-mm1-orig/net/ipv6/esp6.c	2005-04-30 18:25:32.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/esp6.c	2005-05-01 01:50:37.000000000 +0200
@@ -277,18 +277,14 @@
 	if (!esp)
 		return;
 
-	if (esp->conf.tfm) {
-		crypto_free_tfm(esp->conf.tfm);
-		esp->conf.tfm = NULL;
-	}
+	crypto_free_tfm(esp->conf.tfm);
+	esp->conf.tfm = NULL;
 	if (esp->conf.ivec) {
 		kfree(esp->conf.ivec);
 		esp->conf.ivec = NULL;
 	}
-	if (esp->auth.tfm) {
-		crypto_free_tfm(esp->auth.tfm);
-		esp->auth.tfm = NULL;
-	}
+	crypto_free_tfm(esp->auth.tfm);
+	esp->auth.tfm = NULL;
 	if (esp->auth.work_icv) {
 		kfree(esp->auth.work_icv);
 		esp->auth.work_icv = NULL;
--- linux-2.6.12-rc3-mm1-orig/net/ipv6/ipcomp6.c	2005-04-30 18:25:33.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/ipcomp6.c	2005-05-01 01:50:46.000000000 +0200
@@ -346,8 +346,7 @@
 
 	for_each_cpu(cpu) {
 		struct crypto_tfm *tfm = *per_cpu_ptr(tfms, cpu);
-		if (tfm)
-			crypto_free_tfm(tfm);
+		crypto_free_tfm(tfm);
 	}
 	free_percpu(tfms);
 }
--- linux-2.6.12-rc3-mm1-orig/net/sctp/endpointola.c	2005-04-30 18:37:17.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/sctp/endpointola.c	2005-05-01 01:51:03.000000000 +0200
@@ -195,8 +195,7 @@
 	sctp_unhash_endpoint(ep);
 
 	/* Free up the HMAC transform. */
-	if (sctp_sk(ep->base.sk)->hmac)
-		sctp_crypto_free_tfm(sctp_sk(ep->base.sk)->hmac);
+	sctp_crypto_free_tfm(sctp_sk(ep->base.sk)->hmac);
 
 	/* Cleanup. */
 	sctp_inq_free(&ep->base.inqueue);
--- linux-2.6.12-rc3-mm1-orig/net/sctp/socket.c	2005-04-30 18:37:17.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/sctp/socket.c	2005-05-01 01:51:11.000000000 +0200
@@ -4022,8 +4022,7 @@
 	sctp_release_sock(sk);
 	return err;
 cleanup:
-	if (tfm)
-		sctp_crypto_free_tfm(tfm);
+	sctp_crypto_free_tfm(tfm);
 	goto out;
 }
 
--- linux-2.6.12-rc3-mm1-orig/net/sunrpc/auth_gss/gss_krb5_crypto.c	2005-03-02 08:37:47.000000000 +0100
+++ linux-2.6.12-rc3-mm1/net/sunrpc/auth_gss/gss_krb5_crypto.c	2005-05-01 01:51:19.000000000 +0200
@@ -201,8 +201,7 @@
 	crypto_digest_final(tfm, cksum->data);
 	code = 0;
 out:
-	if (tfm)
-		crypto_free_tfm(tfm);
+	crypto_free_tfm(tfm);
 	return code;
 }
 
--- linux-2.6.12-rc3-mm1-orig/net/sunrpc/auth_gss/gss_krb5_mech.c	2005-04-30 18:25:34.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/sunrpc/auth_gss/gss_krb5_mech.c	2005-05-01 01:51:41.000000000 +0200
@@ -185,10 +185,8 @@
 gss_delete_sec_context_kerberos(void *internal_ctx) {
 	struct krb5_ctx *kctx = internal_ctx;
 
-	if (kctx->seq)
-		crypto_free_tfm(kctx->seq);
-	if (kctx->enc)
-		crypto_free_tfm(kctx->enc);
+	crypto_free_tfm(kctx->seq);
+	crypto_free_tfm(kctx->enc);
 	if (kctx->mech_used.data)
 		kfree(kctx->mech_used.data);
 	kfree(kctx);
--- linux-2.6.12-rc3-mm1-orig/net/sunrpc/auth_gss/gss_spkm3_mech.c	2005-04-30 18:25:34.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/sunrpc/auth_gss/gss_spkm3_mech.c	2005-05-01 01:52:04.000000000 +0200
@@ -214,10 +214,8 @@
 gss_delete_sec_context_spkm3(void *internal_ctx) {
 	struct spkm3_ctx *sctx = internal_ctx;
 
-	if(sctx->derived_integ_key)
-		crypto_free_tfm(sctx->derived_integ_key);
-	if(sctx->derived_conf_key)
-		crypto_free_tfm(sctx->derived_conf_key);
+	crypto_free_tfm(sctx->derived_integ_key);
+	crypto_free_tfm(sctx->derived_conf_key);
 	if(sctx->share_key.data)
 		kfree(sctx->share_key.data);
 	if(sctx->mech_used.data)



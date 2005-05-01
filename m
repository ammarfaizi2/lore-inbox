Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVD3WvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVD3WvP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 18:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVD3WvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 18:51:15 -0400
Received: from mx2.mail.ru ([194.67.23.122]:39809 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261445AbVD3Wub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 18:50:31 -0400
Date: Sun, 1 May 2005 02:53:49 +0000
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: "David S. Miller" <davem@davemloft.net>,
       Jouni Malinen <jkmaline@cc.hut.fi>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] resource release cleanup in net/
Message-ID: <20050501025349.GA9243@mipter.zuzino.mipt.ru>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	"David S. Miller" <davem@davemloft.net>,
	Jouni Malinen <jkmaline@cc.hut.fi>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0504302219520.2094@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504302219520.2094@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 30, 2005 at 10:36:00PM +0200, Jesper Juhl wrote:
> Since Andrew merged the patch that makes calling crypto_free_tfm() with a 
> NULL pointer safe into 2.6.12-rc3-mm1, I made a patch to remove checks for 
> NULL before calling that function

>  drivers/net/wireless/hostap/hostap_crypt_ccmp.c |    5 -
>  drivers/net/wireless/hostap/hostap_crypt_tkip.c |   10 +-
>  drivers/net/wireless/hostap/hostap_crypt_wep.c  |    5 -
>  net/ieee80211/ieee80211_crypt_ccmp.c            |    5 -
>  net/ieee80211/ieee80211_crypt_tkip.c            |   10 +-
>  net/ieee80211/ieee80211_crypt_wep.c             |    5 -

I think I have a better one for these.

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hostap_free.patch"

--- linux-2.6.12-rc3-mm1/drivers/net/wireless/hostap/hostap_crypt_ccmp.c	2005-05-01 01:53:50.000000000 +0000
+++ linux-2.6.12-rc3-mm1-hostap/drivers/net/wireless/hostap/hostap_crypt_ccmp.c	2005-05-01 02:21:10.000000000 +0000
@@ -102,17 +102,14 @@ static void * hostap_ccmp_init(int key_i
 	if (priv->tfm == NULL) {
 		printk(KERN_DEBUG "hostap_crypt_ccmp: could not allocate "
 		       "crypto API aes\n");
-		goto fail;
+		goto fail_free;
 	}
 
 	return priv;
 
+fail_free:
+	kfree(priv);
 fail:
-	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
-		kfree(priv);
-	}
 	module_put(THIS_MODULE);
 	return NULL;
 }
@@ -121,8 +118,7 @@ fail:
 static void hostap_ccmp_deinit(void *priv)
 {
 	struct hostap_ccmp_data *_priv = priv;
-	if (_priv && _priv->tfm)
-		crypto_free_tfm(_priv->tfm);
+	crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 	module_put(THIS_MODULE);
 }
--- linux-2.6.12-rc3-mm1/drivers/net/wireless/hostap/hostap_crypt_tkip.c	2005-05-01 01:53:50.000000000 +0000
+++ linux-2.6.12-rc3-mm1-hostap/drivers/net/wireless/hostap/hostap_crypt_tkip.c	2005-05-01 02:27:18.000000000 +0000
@@ -88,26 +88,23 @@ static void * hostap_tkip_init(int key_i
 	if (priv->tfm_arc4 == NULL) {
 		printk(KERN_DEBUG "hostap_crypt_tkip: could not allocate "
 		       "crypto API arc4\n");
-		goto fail;
+		goto fail_arc4;
 	}
 
 	priv->tfm_michael = crypto_alloc_tfm("michael_mic", 0);
 	if (priv->tfm_michael == NULL) {
 		printk(KERN_DEBUG "hostap_crypt_tkip: could not allocate "
 		       "crypto API michael_mic\n");
-		goto fail;
+		goto fail_michael;
 	}
 
 	return priv;
 
+fail_michael:
+	crypto_free_tfm(priv->tfm_arc4);
+fail_arc4:
+	kfree(priv);
 fail:
-	if (priv) {
-		if (priv->tfm_michael)
-			crypto_free_tfm(priv->tfm_michael);
-		if (priv->tfm_arc4)
-			crypto_free_tfm(priv->tfm_arc4);
-		kfree(priv);
-	}
 	module_put(THIS_MODULE);
 	return NULL;
 }
@@ -116,10 +113,8 @@ fail:
 static void hostap_tkip_deinit(void *priv)
 {
 	struct hostap_tkip_data *_priv = priv;
-	if (_priv && _priv->tfm_michael)
-		crypto_free_tfm(_priv->tfm_michael);
-	if (_priv && _priv->tfm_arc4)
-		crypto_free_tfm(_priv->tfm_arc4);
+	crypto_free_tfm(_priv->tfm_michael);
+	crypto_free_tfm(_priv->tfm_arc4);
 	kfree(priv);
 	module_put(THIS_MODULE);
 }
--- linux-2.6.12-rc3-mm1/drivers/net/wireless/hostap/hostap_crypt_wep.c	2005-05-01 01:53:50.000000000 +0000
+++ linux-2.6.12-rc3-mm1-hostap/drivers/net/wireless/hostap/hostap_crypt_wep.c	2005-05-01 02:30:08.000000000 +0000
@@ -59,7 +59,7 @@ static void * prism2_wep_init(int keyidx
 	if (priv->tfm == NULL) {
 		printk(KERN_DEBUG "hostap_crypt_wep: could not allocate "
 		       "crypto API arc4\n");
-		goto fail;
+		goto fail_tfm;
 	}
 
 	/* start WEP IV from a random value */
@@ -67,12 +67,9 @@ static void * prism2_wep_init(int keyidx
 
 	return priv;
 
+fail_tfm:
+	kfree(priv);
 fail:
-	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
-		kfree(priv);
-	}
 	module_put(THIS_MODULE);
 	return NULL;
 }
@@ -81,8 +78,7 @@ fail:
 static void prism2_wep_deinit(void *priv)
 {
 	struct prism2_wep_data *_priv = priv;
-	if (_priv && _priv->tfm)
-		crypto_free_tfm(_priv->tfm);
+	crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 	module_put(THIS_MODULE);
 }
--- linux-2.6.12-rc3-mm1/net/ieee80211/ieee80211_crypt_ccmp.c	2005-05-01 01:53:57.000000000 +0000
+++ linux-2.6.12-rc3-mm1-hostap/net/ieee80211/ieee80211_crypt_ccmp.c	2005-05-01 02:31:22.000000000 +0000
@@ -89,18 +89,14 @@ static void * ieee80211_ccmp_init(int ke
 	if (priv->tfm == NULL) {
 		printk(KERN_DEBUG "ieee80211_crypt_ccmp: could not allocate "
 		       "crypto API aes\n");
-		goto fail;
+		goto fail_tfm;
 	}
 
 	return priv;
 
+fail_tfm:
+	kfree(priv);
 fail:
-	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
-		kfree(priv);
-	}
-
 	return NULL;
 }
 
@@ -108,8 +104,7 @@ fail:
 static void ieee80211_ccmp_deinit(void *priv)
 {
 	struct ieee80211_ccmp_data *_priv = priv;
-	if (_priv && _priv->tfm)
-		crypto_free_tfm(_priv->tfm);
+	crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 }
 
--- linux-2.6.12-rc3-mm1/net/ieee80211/ieee80211_crypt_tkip.c	2005-05-01 01:53:57.000000000 +0000
+++ linux-2.6.12-rc3-mm1-hostap/net/ieee80211/ieee80211_crypt_tkip.c	2005-05-01 02:34:04.000000000 +0000
@@ -76,27 +76,23 @@ static void * ieee80211_tkip_init(int ke
 	if (priv->tfm_arc4 == NULL) {
 		printk(KERN_DEBUG "ieee80211_crypt_tkip: could not allocate "
 		       "crypto API arc4\n");
-		goto fail;
+		goto fail_arc4;
 	}
 
 	priv->tfm_michael = crypto_alloc_tfm("michael_mic", 0);
 	if (priv->tfm_michael == NULL) {
 		printk(KERN_DEBUG "ieee80211_crypt_tkip: could not allocate "
 		       "crypto API michael_mic\n");
-		goto fail;
+		goto fail_michael;
 	}
 
 	return priv;
 
+fail_michael:
+	crypto_free_tfm(priv->tfm_arc4);
+fail_arc4:
+	kfree(priv);
 fail:
-	if (priv) {
-		if (priv->tfm_michael)
-			crypto_free_tfm(priv->tfm_michael);
-		if (priv->tfm_arc4)
-			crypto_free_tfm(priv->tfm_arc4);
-		kfree(priv);
-	}
-
 	return NULL;
 }
 
@@ -104,10 +100,8 @@ fail:
 static void ieee80211_tkip_deinit(void *priv)
 {
 	struct ieee80211_tkip_data *_priv = priv;
-	if (_priv && _priv->tfm_michael)
-		crypto_free_tfm(_priv->tfm_michael);
-	if (_priv && _priv->tfm_arc4)
-		crypto_free_tfm(_priv->tfm_arc4);
+	crypto_free_tfm(_priv->tfm_michael);
+	crypto_free_tfm(_priv->tfm_arc4);
 	kfree(priv);
 }
 
--- linux-2.6.12-rc3-mm1/net/ieee80211/ieee80211_crypt_wep.c	2005-05-01 01:53:57.000000000 +0000
+++ linux-2.6.12-rc3-mm1-hostap/net/ieee80211/ieee80211_crypt_wep.c	2005-05-01 02:35:18.000000000 +0000
@@ -54,7 +54,7 @@ static void * prism2_wep_init(int keyidx
 	if (priv->tfm == NULL) {
 		printk(KERN_DEBUG "ieee80211_crypt_wep: could not allocate "
 		       "crypto API arc4\n");
-		goto fail;
+		goto fail_tfm;
 	}
 
 	/* start WEP IV from a random value */
@@ -62,12 +62,9 @@ static void * prism2_wep_init(int keyidx
 
 	return priv;
 
+fail_tfm:
+	kfree(priv);
 fail:
-	if (priv) {
-		if (priv->tfm)
-			crypto_free_tfm(priv->tfm);
-		kfree(priv);
-	}
 	return NULL;
 }
 
@@ -75,8 +72,7 @@ fail:
 static void prism2_wep_deinit(void *priv)
 {
 	struct prism2_wep_data *_priv = priv;
-	if (_priv && _priv->tfm)
-		crypto_free_tfm(_priv->tfm);
+	crypto_free_tfm(_priv->tfm);
 	kfree(priv);
 }
 

--4Ckj6UjgE2iN1+kY--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVD3Umr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVD3Umr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVD3UmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:42:09 -0400
Received: from mail.dif.dk ([193.138.115.101]:22943 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261420AbVD3Ucn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:32:43 -0400
Date: Sat, 30 Apr 2005 22:36:00 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH] resource release cleanup in net/
Message-ID: <Pine.LNX.4.62.0504302219520.2094@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Since Andrew merged the patch that makes calling crypto_free_tfm() with a 
NULL pointer safe into 2.6.12-rc3-mm1, I made a patch to remove checks for 
NULL before calling that function, and while I was at it I removed similar 
redundant checks before calls to kfree() and vfree() in the same files. 
There are also a few tiny whitespace cleanups in there.

I believe you are the maintainer in charge of the code I've changed, so 
that's why I'm sending this to you. Sorry about the long CC list, but I 
wanted to make sure that people whos code I've changed got informed.

Since the changes I'm making are very similar for both kfree, vfree & 
crypto_free_tfm, I've lumped it all into one single patch. If you'd prefer 
it split into 3-4 patches instead then just let me know and I can do that 
instead.

If the patch is acceptable then please let me know if you'll merge it into 
your tree or if you'd like me to send on to Andrew myself for future -mm 
inclusion.
If the patch is not OK, then feedback is of course very welcome.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/net/wireless/airo.c                     |   95 ++++++++++--------------
 drivers/net/wireless/hostap/hostap_crypt_ccmp.c |    5 -
 drivers/net/wireless/hostap/hostap_crypt_tkip.c |   10 +-
 drivers/net/wireless/hostap/hostap_crypt_wep.c  |    5 -
 net/ieee80211/ieee80211_crypt_ccmp.c            |    5 -
 net/ieee80211/ieee80211_crypt_tkip.c            |   10 +-
 net/ieee80211/ieee80211_crypt_wep.c             |    5 -
 net/ipv4/ah4.c                                  |   18 +---
 net/ipv4/esp4.c                                 |   28 +++----
 net/ipv4/ipcomp.c                               |    6 -
 net/ipv6/addrconf.c                             |    9 --
 net/ipv6/ah6.c                                  |   28 ++-----
 net/ipv6/esp6.c                                 |   28 +++----
 net/ipv6/ipcomp6.c                              |    9 --
 net/sctp/endpointola.c                          |    3
 net/sctp/socket.c                               |    3
 net/sunrpc/auth_gss/gss_krb5_crypto.c           |    3
 net/sunrpc/auth_gss/gss_krb5_mech.c             |    9 --
 net/sunrpc/auth_gss/gss_spkm3_mech.c            |   16 +---
 19 files changed, 119 insertions(+), 176 deletions(-)

--- linux-2.6.12-rc3-mm1-orig/drivers/net/wireless/airo.c	2005-04-30 18:37:01.000000000 +0200
+++ linux-2.6.12-rc3-mm1/drivers/net/wireless/airo.c	2005-04-30 19:55:57.000000000 +0200
@@ -2383,14 +2383,10 @@ void stop_airo_card( struct net_device *
 			dev_kfree_skb(skb);
 	}
 
-	if (ai->flash)
-		kfree(ai->flash);
-	if (ai->rssi)
-		kfree(ai->rssi);
-	if (ai->APList)
-		kfree(ai->APList);
-	if (ai->SSID)
-		kfree(ai->SSID);
+	kfree(ai->flash);
+	kfree(ai->rssi);
+	kfree(ai->APList);
+	kfree(ai->SSID);
 	if (freeres) {
 		/* PCMCIA frees this stuff, so only for PCI and ISA */
 	        release_region( dev->base_addr, 64 );
@@ -2406,8 +2402,7 @@ void stop_airo_card( struct net_device *
 		}
         }
 #ifdef MICSUPPORT
-	if (ai->tfm)
-		crypto_free_tfm(ai->tfm);
+	crypto_free_tfm(ai->tfm);
 #endif
 	del_airo_dev( dev );
 	free_netdev( dev );
@@ -3627,11 +3622,9 @@ static u16 setup_card(struct airo_info *
 	WepKeyRid wkr;
 	int rc;
 
-	memset( &mySsid, 0, sizeof( mySsid ) );
-	if (ai->flash) {
-		kfree (ai->flash);
-		ai->flash = NULL;
-	}
+	memset(&mySsid, 0, sizeof(mySsid));
+	kfree(ai->flash);
+	ai->flash = NULL;
 
 	/* The NOP is the first step in getting the card going */
 	cmd.cmd = NOP;
@@ -3668,14 +3661,11 @@ static u16 setup_card(struct airo_info *
 		tdsRssiRid rssi_rid;
 		CapabilityRid cap_rid;
 
-		if (ai->APList) {
-			kfree(ai->APList);
-			ai->APList = NULL;
-		}
-		if (ai->SSID) {
-			kfree(ai->SSID);
-			ai->SSID = NULL;
-		}
+		kfree(ai->APList);
+		ai->APList = NULL;
+		kfree(ai->SSID);
+		ai->SSID = NULL;
+
 		// general configuration (read/modify/write)
 		status = readConfigRid(ai, lock);
 		if ( status != SUCCESS ) return ERROR;
@@ -3689,10 +3679,8 @@ static u16 setup_card(struct airo_info *
 				memcpy(ai->rssi, (u8*)&rssi_rid + 2, 512);
 		}
 		else {
-			if (ai->rssi) {
-				kfree(ai->rssi);
-				ai->rssi = NULL;
-			}
+			kfree(ai->rssi);
+			ai->rssi = NULL;
 			if (cap_rid.softCap & 8)
 				ai->config.rmode |= RXMODE_NORMALIZED_RSSI;
 			else
@@ -4553,7 +4541,7 @@ static int proc_status_open( struct inod
 	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 2048, GFP_KERNEL )) == NULL) {
-		kfree (file->private_data);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 
@@ -4633,7 +4621,7 @@ static int proc_stats_rid_open( struct i
 	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 4096, GFP_KERNEL )) == NULL) {
-		kfree (file->private_data);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 
@@ -4899,12 +4887,12 @@ static int proc_config_open( struct inod
 	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 2048, GFP_KERNEL )) == NULL) {
-		kfree (file->private_data);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 	if ((data->wbuffer = kmalloc( 2048, GFP_KERNEL )) == NULL) {
-		kfree (data->rbuffer);
-		kfree (file->private_data);
+		kfree(data->rbuffer);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 	memset( data->wbuffer, 0, 2048 );
@@ -5174,15 +5162,15 @@ static int proc_wepkey_open( struct inod
 	memset(&wkr, 0, sizeof(wkr));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 180, GFP_KERNEL )) == NULL) {
-		kfree (file->private_data);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 	memset(data->rbuffer, 0, 180);
 	data->writelen = 0;
 	data->maxwritelen = 80;
 	if ((data->wbuffer = kmalloc( 80, GFP_KERNEL )) == NULL) {
-		kfree (data->rbuffer);
-		kfree (file->private_data);
+		kfree(data->rbuffer);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 	memset( data->wbuffer, 0, 80 );
@@ -5221,14 +5209,14 @@ static int proc_SSID_open( struct inode 
 	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 104, GFP_KERNEL )) == NULL) {
-		kfree (file->private_data);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 	data->writelen = 0;
 	data->maxwritelen = 33*3;
 	if ((data->wbuffer = kmalloc( 33*3, GFP_KERNEL )) == NULL) {
-		kfree (data->rbuffer);
-		kfree (file->private_data);
+		kfree(data->rbuffer);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 	memset( data->wbuffer, 0, 33*3 );
@@ -5265,14 +5253,14 @@ static int proc_APList_open( struct inod
 	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 104, GFP_KERNEL )) == NULL) {
-		kfree (file->private_data);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 	data->writelen = 0;
 	data->maxwritelen = 4*6*3;
 	if ((data->wbuffer = kmalloc( data->maxwritelen, GFP_KERNEL )) == NULL) {
-		kfree (data->rbuffer);
-		kfree (file->private_data);
+		kfree(data->rbuffer);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 	memset( data->wbuffer, 0, data->maxwritelen );
@@ -5315,7 +5303,7 @@ static int proc_BSSList_open( struct ino
 	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 1024, GFP_KERNEL )) == NULL) {
-		kfree (file->private_data);
+		kfree(file->private_data);
 		return -ENOMEM;
 	}
 	data->writelen = 0;
@@ -5372,10 +5360,11 @@ static int proc_BSSList_open( struct ino
 static int proc_close( struct inode *inode, struct file *file )
 {
 	struct proc_data *data = (struct proc_data *)file->private_data;
-	if ( data->on_close != NULL ) data->on_close( inode, file );
-	if ( data->rbuffer ) kfree( data->rbuffer );
-	if ( data->wbuffer ) kfree( data->wbuffer );
-	kfree( data );
+	if (data->on_close)
+		data->on_close(inode, file);
+	kfree(data->rbuffer);
+	kfree(data->wbuffer);
+	kfree(data);
 	return 0;
 }
 
@@ -7269,10 +7258,10 @@ static int readrids(struct net_device *d
 	len = comp->len;
 
 	if (copy_to_user(comp->data, iobuf, min(len, (int)RIDSIZE))) {
-		kfree (iobuf);
+		kfree(iobuf);
 		return -EFAULT;
 	}
-	kfree (iobuf);
+	kfree(iobuf);
 	return 0;
 }
 
@@ -7350,10 +7339,10 @@ static int writerids(struct net_device *
 
 		if (copy_to_user(comp->data, iobuf,
 				 min((int)comp->len, (int)RIDSIZE))) {
-			kfree (iobuf);
+			kfree(iobuf);
 			return -EFAULT;
 		}
-		kfree (iobuf);
+		kfree(iobuf);
 		return 0;
 
 	default:
@@ -7366,7 +7355,7 @@ static int writerids(struct net_device *
 		return -ENOMEM;
 
 	if (copy_from_user(iobuf,comp->data,comp->len)) {
-		kfree (iobuf);
+		kfree(iobuf);
 		return -EFAULT;
 	}
 
@@ -7383,10 +7372,10 @@ static int writerids(struct net_device *
 	}
 
 	if((*writer)(ai, ridcode, iobuf,comp->len,1)) {
-		kfree (iobuf);
+		kfree(iobuf);
 		return -EIO;
 	}
-	kfree (iobuf);
+	kfree(iobuf);
 	return 0;
 }
 
--- linux-2.6.12-rc3-mm1-orig/drivers/net/wireless/hostap/hostap_crypt_ccmp.c	2005-04-30 18:37:01.000000000 +0200
+++ linux-2.6.12-rc3-mm1/drivers/net/wireless/hostap/hostap_crypt_ccmp.c	2005-04-30 19:41:06.000000000 +0200
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
--- linux-2.6.12-rc3-mm1-orig/drivers/net/wireless/hostap/hostap_crypt_tkip.c	2005-04-30 18:37:01.000000000 +0200
+++ linux-2.6.12-rc3-mm1/drivers/net/wireless/hostap/hostap_crypt_tkip.c	2005-04-30 19:41:06.000000000 +0200
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
--- linux-2.6.12-rc3-mm1-orig/drivers/net/wireless/hostap/hostap_crypt_wep.c	2005-04-30 18:37:01.000000000 +0200
+++ linux-2.6.12-rc3-mm1/drivers/net/wireless/hostap/hostap_crypt_wep.c	2005-04-30 19:41:06.000000000 +0200
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
--- linux-2.6.12-rc3-mm1-orig/net/ieee80211/ieee80211_crypt_ccmp.c	2005-04-30 18:37:16.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ieee80211/ieee80211_crypt_ccmp.c	2005-04-30 19:41:06.000000000 +0200
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
--- linux-2.6.12-rc3-mm1-orig/net/ieee80211/ieee80211_crypt_tkip.c	2005-04-30 18:37:17.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ieee80211/ieee80211_crypt_tkip.c	2005-04-30 19:41:06.000000000 +0200
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
 
--- linux-2.6.12-rc3-mm1-orig/net/ieee80211/ieee80211_crypt_wep.c	2005-04-30 18:37:17.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ieee80211/ieee80211_crypt_wep.c	2005-04-30 19:41:06.000000000 +0200
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
--- linux-2.6.12-rc3-mm1-orig/net/ipv4/ah4.c	2005-04-30 18:25:32.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv4/ah4.c	2005-04-30 19:41:06.000000000 +0200
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
 
--- linux-2.6.12-rc3-mm1-orig/net/ipv4/esp4.c	2005-04-30 18:25:32.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv4/esp4.c	2005-04-30 19:41:06.000000000 +0200
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
 
--- linux-2.6.12-rc3-mm1-orig/net/ipv4/ipcomp.c	2005-04-30 18:25:32.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv4/ipcomp.c	2005-04-30 20:04:42.000000000 +0200
@@ -296,8 +296,7 @@ static void ipcomp_free_scratches(void)
 
 	for_each_cpu(i) {
 		void *scratch = *per_cpu_ptr(scratches, i);
-		if (scratch)
-			vfree(scratch);
+		vfree(scratch);
 	}
 
 	free_percpu(scratches);
@@ -350,8 +349,7 @@ static void ipcomp_free_tfms(struct cryp
 
 	for_each_cpu(cpu) {
 		struct crypto_tfm *tfm = *per_cpu_ptr(tfms, cpu);
-		if (tfm)
-			crypto_free_tfm(tfm);
+		crypto_free_tfm(tfm);
 	}
 	free_percpu(tfms);
 }
--- linux-2.6.12-rc3-mm1-orig/net/ipv6/addrconf.c	2005-04-30 18:37:17.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/addrconf.c	2005-04-30 19:59:34.000000000 +0200
@@ -2966,8 +2966,7 @@ static int inet6_fill_ifinfo(struct sk_b
 
 nlmsg_failure:
 rtattr_failure:
-	if (array)
-		kfree(array);
+	kfree(array);
 	skb_trim(skb, b - skb->data);
 	return -1;
 }
@@ -3604,10 +3603,8 @@ void __exit addrconf_cleanup(void)
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
+++ linux-2.6.12-rc3-mm1/net/ipv6/ah6.c	2005-04-30 20:01:39.000000000 +0200
@@ -217,12 +217,11 @@ static int ah6_output(struct xfrm_state 
 	err = 0;
 
 	memcpy(top_iph, tmp_base, sizeof(tmp_base));
-	if (tmp_ext) {
+	if (tmp_ext)
 		memcpy(&top_iph->daddr, tmp_ext, extlen);
-error_free_iph:
-		kfree(tmp_ext);
-	}
 
+error_free_iph:
+	kfree(tmp_ext);
 error:
 	return err;
 }
@@ -306,7 +305,6 @@ static int ah6_input(struct xfrm_state *
 	skb_pull(skb, hdr_len);
 	skb->h.raw = skb->data;
 
-
 	kfree(tmp_hdr);
 
 	return nexthdr;
@@ -402,10 +400,8 @@ static int ah6_init_state(struct xfrm_st
 
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
@@ -418,14 +414,12 @@ static void ah6_destroy(struct xfrm_stat
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
 
--- linux-2.6.12-rc3-mm1-orig/net/ipv6/esp6.c	2005-04-30 18:25:32.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/esp6.c	2005-04-30 19:41:06.000000000 +0200
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
 
--- linux-2.6.12-rc3-mm1-orig/net/ipv6/ipcomp6.c	2005-04-30 18:25:33.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/ipcomp6.c	2005-04-30 20:05:02.000000000 +0200
@@ -130,8 +130,7 @@ static int ipcomp6_input(struct xfrm_sta
 out_put_cpu:
 	put_cpu();
 out:
-	if (tmp_hdr)
-		kfree(tmp_hdr);
+	kfree(tmp_hdr);
 	if (err)
 		goto error_out;
 	return nexthdr;
@@ -292,8 +291,7 @@ static void ipcomp6_free_scratches(void)
 
 	for_each_cpu(i) {
 		void *scratch = *per_cpu_ptr(scratches, i);
-		if (scratch)
-			vfree(scratch);
+		vfree(scratch);
 	}
 
 	free_percpu(scratches);
@@ -346,8 +344,7 @@ static void ipcomp6_free_tfms(struct cry
 
 	for_each_cpu(cpu) {
 		struct crypto_tfm *tfm = *per_cpu_ptr(tfms, cpu);
-		if (tfm)
-			crypto_free_tfm(tfm);
+		crypto_free_tfm(tfm);
 	}
 	free_percpu(tfms);
 }
--- linux-2.6.12-rc3-mm1-orig/net/sctp/endpointola.c	2005-04-30 18:37:17.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/sctp/endpointola.c	2005-04-30 19:41:06.000000000 +0200
@@ -195,8 +195,7 @@ static void sctp_endpoint_destroy(struct
 	sctp_unhash_endpoint(ep);
 
 	/* Free up the HMAC transform. */
-	if (sctp_sk(ep->base.sk)->hmac)
-		sctp_crypto_free_tfm(sctp_sk(ep->base.sk)->hmac);
+	sctp_crypto_free_tfm(sctp_sk(ep->base.sk)->hmac);
 
 	/* Cleanup. */
 	sctp_inq_free(&ep->base.inqueue);
--- linux-2.6.12-rc3-mm1-orig/net/sctp/socket.c	2005-04-30 18:37:17.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/sctp/socket.c	2005-04-30 19:41:06.000000000 +0200
@@ -4022,8 +4022,7 @@ out:
 	sctp_release_sock(sk);
 	return err;
 cleanup:
-	if (tfm)
-		sctp_crypto_free_tfm(tfm);
+	sctp_crypto_free_tfm(tfm);
 	goto out;
 }
 
--- linux-2.6.12-rc3-mm1-orig/net/sunrpc/auth_gss/gss_krb5_crypto.c	2005-03-02 08:37:47.000000000 +0100
+++ linux-2.6.12-rc3-mm1/net/sunrpc/auth_gss/gss_krb5_crypto.c	2005-04-30 19:41:06.000000000 +0200
@@ -201,8 +201,7 @@ make_checksum(s32 cksumtype, char *heade
 	crypto_digest_final(tfm, cksum->data);
 	code = 0;
 out:
-	if (tfm)
-		crypto_free_tfm(tfm);
+	crypto_free_tfm(tfm);
 	return code;
 }
 
--- linux-2.6.12-rc3-mm1-orig/net/sunrpc/auth_gss/gss_krb5_mech.c	2005-04-30 18:25:34.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/sunrpc/auth_gss/gss_krb5_mech.c	2005-04-30 19:41:06.000000000 +0200
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
 
--- linux-2.6.12-rc3-mm1-orig/net/sunrpc/auth_gss/gss_spkm3_mech.c	2005-04-30 18:25:34.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/sunrpc/auth_gss/gss_spkm3_mech.c	2005-04-30 20:03:28.000000000 +0200
@@ -121,14 +121,14 @@ get_key(const void *p, const void *end, 
 			goto out_err_free_tfm;
 	}
 
-	if(key.len > 0)
+	if (key.len > 0)
 		kfree(key.data);
 	return p;
 
 out_err_free_tfm:
 	crypto_free_tfm(*res);
 out_err_free_key:
-	if(key.len > 0)
+	if (key.len > 0)
 		kfree(key.data);
 	p = ERR_PTR(-EINVAL);
 out_err:
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
 




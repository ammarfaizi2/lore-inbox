Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVEABs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVEABs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 21:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVEABsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 21:48:18 -0400
Received: from mail.dif.dk ([193.138.115.101]:38311 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261496AbVEABrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 21:47:07 -0400
Date: Sun, 1 May 2005 03:50:25 +0200 (CEST)
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
Subject: Re: [PATCH 2/4] resource release cleanup in net/ (take 2)
In-Reply-To: <Pine.LNX.4.62.0505010341560.2094@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0505010348260.2094@dragon.hyggekrogen.localhost>
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

These are the kfree changes. Incremental patch over patch 1.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/net/wireless/airo.c          |   41 ++++++++++++-----------------------
 net/ipv4/ah4.c                       |    9 ++-----
 net/ipv4/esp4.c                      |   12 +++-------
 net/ipv6/addrconf.c                  |    3 --
 net/ipv6/ah6.c                       |   16 +++++--------
 net/ipv6/esp6.c                      |   12 +++-------
 net/ipv6/ipcomp6.c                   |    3 --
 net/sunrpc/auth_gss/gss_krb5_mech.c  |    3 --
 net/sunrpc/auth_gss/gss_spkm3_mech.c |    6 +----
 9 files changed, 37 insertions(+), 68 deletions(-)

--- linux-2.6.12-rc3-mm1/drivers/net/wireless/airo.c.old1	2005-05-01 03:23:26.000000000 +0200
+++ linux-2.6.12-rc3-mm1/drivers/net/wireless/airo.c	2005-05-01 03:23:56.000000000 +0200
@@ -2383,14 +2383,10 @@
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
@@ -3627,10 +3623,8 @@
 	int rc;
 
 	memset( &mySsid, 0, sizeof( mySsid ) );
-	if (ai->flash) {
-		kfree (ai->flash);
-		ai->flash = NULL;
-	}
+	kfree(ai->flash);
+	ai->flash = NULL;
 
 	/* The NOP is the first step in getting the card going */
 	cmd.cmd = NOP;
@@ -3667,14 +3661,11 @@
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
@@ -3688,10 +3679,8 @@
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
@@ -5372,8 +5361,8 @@
 {
 	struct proc_data *data = (struct proc_data *)file->private_data;
 	if ( data->on_close != NULL ) data->on_close( inode, file );
-	if ( data->rbuffer ) kfree( data->rbuffer );
-	if ( data->wbuffer ) kfree( data->wbuffer );
+	kfree(data->rbuffer);
+	kfree(data->wbuffer);
 	kfree( data );
 	return 0;
 }
--- linux-2.6.12-rc3-mm1/net/ipv4/ah4.c.old1	2005-05-01 03:23:26.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv4/ah4.c	2005-05-01 03:23:56.000000000 +0200
@@ -263,8 +263,7 @@
 
 error:
 	if (ahp) {
-		if (ahp->work_icv)
-			kfree(ahp->work_icv);
+		kfree(ahp->work_icv);
 		crypto_free_tfm(ahp->tfm);
 		kfree(ahp);
 	}
@@ -278,10 +277,8 @@
 	if (!ahp)
 		return;
 
-	if (ahp->work_icv) {
-		kfree(ahp->work_icv);
-		ahp->work_icv = NULL;
-	}
+	kfree(ahp->work_icv);
+	ahp->work_icv = NULL;
 	crypto_free_tfm(ahp->tfm);
 	ahp->tfm = NULL;
 	kfree(ahp);
--- linux-2.6.12-rc3-mm1/net/ipv4/esp4.c.old1	2005-05-01 03:23:26.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv4/esp4.c	2005-05-01 03:23:56.000000000 +0200
@@ -345,16 +345,12 @@
 
 	crypto_free_tfm(esp->conf.tfm);
 	esp->conf.tfm = NULL;
-	if (esp->conf.ivec) {
-		kfree(esp->conf.ivec);
-		esp->conf.ivec = NULL;
-	}
+	kfree(esp->conf.ivec);
+	esp->conf.ivec = NULL;
 	crypto_free_tfm(esp->auth.tfm);
 	esp->auth.tfm = NULL;
-	if (esp->auth.work_icv) {
-		kfree(esp->auth.work_icv);
-		esp->auth.work_icv = NULL;
-	}
+	kfree(esp->auth.work_icv);
+	esp->auth.work_icv = NULL;
 	kfree(esp);
 }
 
--- linux-2.6.12-rc3-mm1/net/ipv6/addrconf.c.old1	2005-05-01 03:23:26.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/addrconf.c	2005-05-01 03:23:56.000000000 +0200
@@ -2966,8 +2966,7 @@
 
 nlmsg_failure:
 rtattr_failure:
-	if (array)
-		kfree(array);
+	kfree(array);
 	skb_trim(skb, b - skb->data);
 	return -1;
 }
--- linux-2.6.12-rc3-mm1/net/ipv6/ah6.c.old1	2005-05-01 03:23:26.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/ah6.c	2005-05-01 03:23:56.000000000 +0200
@@ -217,12 +217,11 @@
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
@@ -401,8 +400,7 @@
 
 error:
 	if (ahp) {
-		if (ahp->work_icv)
-			kfree(ahp->work_icv);
+		kfree(ahp->work_icv);
 		crypto_free_tfm(ahp->tfm);
 		kfree(ahp);
 	}
@@ -416,10 +414,8 @@
 	if (!ahp)
 		return;
 
-	if (ahp->work_icv) {
-		kfree(ahp->work_icv);
-		ahp->work_icv = NULL;
-	}
+	kfree(ahp->work_icv);
+	ahp->work_icv = NULL;
 	crypto_free_tfm(ahp->tfm);
 	ahp->tfm = NULL;
 	kfree(ahp);
--- linux-2.6.12-rc3-mm1/net/ipv6/esp6.c.old1	2005-05-01 03:23:26.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/esp6.c	2005-05-01 03:23:56.000000000 +0200
@@ -279,16 +279,12 @@
 
 	crypto_free_tfm(esp->conf.tfm);
 	esp->conf.tfm = NULL;
-	if (esp->conf.ivec) {
-		kfree(esp->conf.ivec);
-		esp->conf.ivec = NULL;
-	}
+	kfree(esp->conf.ivec);
+	esp->conf.ivec = NULL;
 	crypto_free_tfm(esp->auth.tfm);
 	esp->auth.tfm = NULL;
-	if (esp->auth.work_icv) {
-		kfree(esp->auth.work_icv);
-		esp->auth.work_icv = NULL;
-	}
+	kfree(esp->auth.work_icv);
+	esp->auth.work_icv = NULL;
 	kfree(esp);
 }
 
--- linux-2.6.12-rc3-mm1/net/ipv6/ipcomp6.c.old1	2005-05-01 03:23:26.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/ipv6/ipcomp6.c	2005-05-01 03:23:56.000000000 +0200
@@ -130,8 +130,7 @@
 out_put_cpu:
 	put_cpu();
 out:
-	if (tmp_hdr)
-		kfree(tmp_hdr);
+	kfree(tmp_hdr);
 	if (err)
 		goto error_out;
 	return nexthdr;
--- linux-2.6.12-rc3-mm1/net/sunrpc/auth_gss/gss_krb5_mech.c.old1	2005-05-01 03:23:26.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/sunrpc/auth_gss/gss_krb5_mech.c	2005-05-01 03:23:56.000000000 +0200
@@ -187,8 +187,7 @@
 
 	crypto_free_tfm(kctx->seq);
 	crypto_free_tfm(kctx->enc);
-	if (kctx->mech_used.data)
-		kfree(kctx->mech_used.data);
+	kfree(kctx->mech_used.data);
 	kfree(kctx);
 }
 
--- linux-2.6.12-rc3-mm1/net/sunrpc/auth_gss/gss_spkm3_mech.c.old1	2005-05-01 03:23:26.000000000 +0200
+++ linux-2.6.12-rc3-mm1/net/sunrpc/auth_gss/gss_spkm3_mech.c	2005-05-01 03:23:56.000000000 +0200
@@ -216,10 +216,8 @@
 
 	crypto_free_tfm(sctx->derived_integ_key);
 	crypto_free_tfm(sctx->derived_conf_key);
-	if(sctx->share_key.data)
-		kfree(sctx->share_key.data);
-	if(sctx->mech_used.data)
-		kfree(sctx->mech_used.data);
+	kfree(sctx->share_key.data);
+	kfree(sctx->mech_used.data);
 	kfree(sctx);
 }
 



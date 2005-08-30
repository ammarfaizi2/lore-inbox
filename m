Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVH3Uo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVH3Uo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVH3Uo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:44:58 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:15074 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932455AbVH3Uo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:44:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WxAtfuJVavZHO4E/Dyv+t8w9NzJQU1VNJ1RwE1BMVRfDH52NZGYauoXIlzypBuzKC28S193ZIf9Cc1iTfhDirNHUyLFopbbdmVwMd5XtCCiMr5+9YHCqfV+xddePlnm2ymeXrNWTew81Q1ufqCyudCefxmGGaNASS0nn1qOBY64=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto_free_tfm callers do not need to check for NULL
Date: Tue, 30 Aug 2005 22:45:54 +0200
User-Agent: KMail/1.8.2
Cc: Alexey Dobriyan <adobriyan@mail.ru>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
       "David S. Miller" <davem@davemloft.net>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Andy Adamson <andros@citi.umich.edu>, netdev@vger.kernel.org,
       lksctp developers <lksctp-developers@lists.sourceforge.net>,
       Bruce Fields <bfields@umich.edu>, Andy Adamson <andros@umich.edu>,
       linux-net@vger.kernel.org, linux-crypto@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508302245.55392.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since the patch to add a NULL short-circuit to crypto_free_tfm() went in, 
there's no longer any need for callers of that function to check for NULL.
This patch removes the redundant NULL checks and also a few similar checks
for NULL before calls to kfree() that I ran into while doing the 
crypto_free_tfm bits.

I've posted similar patches in the past, but was asked to first until the
short-circuit patch moved from -mm to mainline - and since it is now 
firmly there in 2.6.13 I assume there's no problem there anymore.
I was also asked previously to make the patch against mainline and not -mm,
so this patch is against 2.6.13.

Feedback, ACK, NACK, etc welcome. 
Sorry about the large Cc list, but I wanted to include everyone involved
with the code I change.
Please keep me on Cc.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 ./drivers/net/wireless/airo.c           |    3 +--
 ./fs/nfsd/nfs4recover.c                 |    3 +--
 ./net/ipv4/ah4.c                        |   18 ++++++------------
 ./net/ipv4/esp4.c                       |   24 ++++++++----------------
 ./net/ipv4/ipcomp.c                     |    3 +--
 ./net/ipv6/addrconf.c                   |    6 ++----
 ./net/ipv6/ah6.c                        |   18 ++++++------------
 ./net/ipv6/esp6.c                       |   24 ++++++++----------------
 ./net/ipv6/ipcomp6.c                    |    3 +--
 ./net/sctp/socket.c                     |    3 +--
 ./net/sunrpc/auth_gss/gss_krb5_crypto.c |    3 +--
 ./net/sunrpc/auth_gss/gss_krb5_mech.c   |    9 +++------
 ./net/sunrpc/auth_gss/gss_spkm3_mech.c  |   12 ++++--------
 13 files changed, 43 insertions(+), 86 deletions(-)

--- linux-2.6.13-orig/./drivers/net/wireless/airo.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./drivers/net/wireless/airo.c	2005-08-30 18:08:15.000000000 +0200
@@ -2403,8 +2403,7 @@ void stop_airo_card( struct net_device *
 		}
         }
 #ifdef MICSUPPORT
-	if (ai->tfm)
-		crypto_free_tfm(ai->tfm);
+	crypto_free_tfm(ai->tfm);
 #endif
 	del_airo_dev( dev );
 	free_netdev( dev );
--- linux-2.6.13-orig/./fs/nfsd/nfs4recover.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./fs/nfsd/nfs4recover.c	2005-08-30 18:08:25.000000000 +0200
@@ -114,8 +114,7 @@ nfs4_make_rec_clidname(char *dname, stru
 	kfree(cksum.data);
 	status = nfs_ok;
 out:
-	if (tfm)
-		crypto_free_tfm(tfm);
+	crypto_free_tfm(tfm);
 	return status;
 }
 
--- linux-2.6.13-orig/./net/ipv4/ah4.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/ipv4/ah4.c	2005-08-30 18:10:10.000000000 +0200
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
 
--- linux-2.6.13-orig/./net/ipv4/esp4.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/ipv4/esp4.c	2005-08-30 18:10:49.000000000 +0200
@@ -343,22 +343,14 @@ static void esp_destroy(struct xfrm_stat
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
+	kfree(esp->conf.ivec);
+	esp->conf.ivec = NULL;
+	crypto_free_tfm(esp->auth.tfm);
+	esp->auth.tfm = NULL;
+	kfree(esp->auth.work_icv);
+	esp->auth.work_icv = NULL;
 	kfree(esp);
 }
 
--- linux-2.6.13-orig/./net/ipv4/ipcomp.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/ipv4/ipcomp.c	2005-08-30 18:11:14.000000000 +0200
@@ -345,8 +345,7 @@ static void ipcomp_free_tfms(struct cryp
 
 	for_each_cpu(cpu) {
 		struct crypto_tfm *tfm = *per_cpu_ptr(tfms, cpu);
-		if (tfm)
-			crypto_free_tfm(tfm);
+		crypto_free_tfm(tfm);
 	}
 	free_percpu(tfms);
 }
--- linux-2.6.13-orig/./net/ipv6/addrconf.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/ipv6/addrconf.c	2005-08-30 18:11:34.000000000 +0200
@@ -3593,10 +3593,8 @@ void __exit addrconf_cleanup(void)
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
--- linux-2.6.13-orig/./net/ipv6/ah6.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/ipv6/ah6.c	2005-08-30 18:12:03.000000000 +0200
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
@@ -418,14 +416,10 @@ static void ah6_destroy(struct xfrm_stat
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
 
--- linux-2.6.13-orig/./net/ipv6/esp6.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/ipv6/esp6.c	2005-08-30 18:12:25.000000000 +0200
@@ -277,22 +277,14 @@ static void esp6_destroy(struct xfrm_sta
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
+	kfree(esp->conf.ivec);
+	esp->conf.ivec = NULL;
+	crypto_free_tfm(esp->auth.tfm);
+	esp->auth.tfm = NULL;
+	kfree(esp->auth.work_icv);
+	esp->auth.work_icv = NULL;
 	kfree(esp);
 }
 
--- linux-2.6.13-orig/./net/ipv6/ipcomp6.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/ipv6/ipcomp6.c	2005-08-30 18:12:34.000000000 +0200
@@ -341,8 +341,7 @@ static void ipcomp6_free_tfms(struct cry
 
 	for_each_cpu(cpu) {
 		struct crypto_tfm *tfm = *per_cpu_ptr(tfms, cpu);
-		if (tfm)
-			crypto_free_tfm(tfm);
+		crypto_free_tfm(tfm);
 	}
 	free_percpu(tfms);
 }
--- linux-2.6.13-orig/./net/sctp/socket.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/sctp/socket.c	2005-08-30 18:12:59.000000000 +0200
@@ -4194,8 +4194,7 @@ out:
 	sctp_release_sock(sk);
 	return err;
 cleanup:
-	if (tfm)
-		sctp_crypto_free_tfm(tfm);
+	sctp_crypto_free_tfm(tfm);
 	goto out;
 }
 
--- linux-2.6.13-orig/./net/sunrpc/auth_gss/gss_krb5_crypto.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/sunrpc/auth_gss/gss_krb5_crypto.c	2005-08-30 18:13:05.000000000 +0200
@@ -199,8 +199,7 @@ make_checksum(s32 cksumtype, char *heade
 	crypto_digest_final(tfm, cksum->data);
 	code = 0;
 out:
-	if (tfm)
-		crypto_free_tfm(tfm);
+	crypto_free_tfm(tfm);
 	return code;
 }
 
--- linux-2.6.13-orig/./net/sunrpc/auth_gss/gss_krb5_mech.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/sunrpc/auth_gss/gss_krb5_mech.c	2005-08-30 18:13:48.000000000 +0200
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
 
--- linux-2.6.13-orig/./net/sunrpc/auth_gss/gss_spkm3_mech.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/./net/sunrpc/auth_gss/gss_spkm3_mech.c	2005-08-30 18:14:18.000000000 +0200
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
 




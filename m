Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTBGVVq>; Fri, 7 Feb 2003 16:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266660AbTBGVVp>; Fri, 7 Feb 2003 16:21:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:4288 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264938AbTBGVVo>;
	Fri, 7 Feb 2003 16:21:44 -0500
Date: Fri, 7 Feb 2003 15:31:22 -0600
From: latten@austin.ibm.com
Message-Id: <200302072131.h17LVM516670@faith.austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: IPSec Patch for NULL Encryption
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was not able to get setkey to create an SA with NULL Encryption. 

setkey -c
  add 10.15.1.5 10.15.1.6 esp 0x1000 -m transport -E simple;

always fails with an error message about invalid argument. 

I did some investigating an have included a PATCH so that setkey will
create an SA with Null Encryption. 

I have also included the following note to explain...

Note:
RFC 2410 (Null Encryption Algorithm and its use with IPSEC) 
states on page 3:

  " For purposes of IKE [IKE] key extraction, the key size for this
   algorithm MUST be zero (0) bits, to facilitate interoperability and
   to avoid any potential export control problems."


Let me know if this is all ok.

Thanks,
Joy



--- /tmp/linux-2.5.59/net/ipv4/esp.c	2003-01-16 20:22:18.000000000 -0600
+++ esp.c	2003-02-07 11:34:34.000000000 -0600
@@ -595,7 +595,7 @@
 		if (x->aalg->alg_key_len == 0 || x->aalg->alg_key_len > 512)
 			goto error;
 	}
-	if (x->ealg == NULL || x->ealg->alg_key_len == 0)
+	if (x->ealg == NULL || (x->ealg->alg_key_len == 0 && x->props.ealgo != SADB_EALG_NULL))
 		goto error;
 
 	esp = kmalloc(sizeof(*esp), GFP_KERNEL);
@@ -623,7 +623,10 @@
 			goto error;
 	}
 	esp->conf.key = x->ealg->alg_key;
-	esp->conf.key_len = (x->ealg->alg_key_len+7)/8;
+	if (x->props.ealgo != SADB_EALG_NULL)
+		esp->conf.key_len = (x->ealg->alg_key_len+7)/8;
+	else
+		esp->conf.key_len = 0;
 	esp->conf.tfm = crypto_alloc_tfm(x->ealg->alg_name, CRYPTO_TFM_MODE_CBC);
 	if (esp->conf.tfm == NULL)
 		goto error;

--- /tmp/linux-2.5.59/net/key/af_key.c	2003-01-16 20:21:47.000000000 -0600
+++ af_key.c	2003-02-07 13:25:38.000000000 -0600
@@ -796,7 +796,7 @@
 	     (key->sadb_key_bits+7) / 8 > key->sadb_key_len * sizeof(uint64_t)))
 		return ERR_PTR(-EINVAL);
 	key = ext_hdrs[SADB_EXT_KEY_ENCRYPT-1];
-	if (key != NULL &&
+	if (key != NULL && sa->sadb_sa_encrypt != SADB_EALG_NULL &&
 	    ((key->sadb_key_bits+7) / 8 == 0 ||
 	     (key->sadb_key_bits+7) / 8 > key->sadb_key_len * sizeof(uint64_t)))
 		return ERR_PTR(-EINVAL);


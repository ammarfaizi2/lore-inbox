Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTHJLBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTHJLBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:01:25 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:29708 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262321AbTHJLAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:00:50 -0400
Date: Sun, 10 Aug 2003 20:00:57 +0900 (JST)
Message-Id: <20030810.200057.59582021.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] convert crypto to virt_to_pageoff()
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030810020444.48cb740b.davem@redhat.com>
References: <20030810013041.679ddc4c.davem@redhat.com>
	<20030810090556.GY31810@waste.org>
	<20030810020444.48cb740b.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[2/9] convert cryptoapi to virt_to_pageoff().

Index: linux-2.6/crypto/hmac.c
===================================================================
RCS file: /home/cvs/linux-2.5/crypto/hmac.c,v
retrieving revision 1.3
diff -u -r1.3 hmac.c
--- linux-2.6/crypto/hmac.c	19 Nov 2002 03:02:31 -0000	1.3
+++ linux-2.6/crypto/hmac.c	10 Aug 2003 08:40:52 -0000
@@ -26,7 +26,7 @@
 	struct scatterlist tmp;
 	
 	tmp.page = virt_to_page(key);
-	tmp.offset = ((long)key & ~PAGE_MASK);
+	tmp.offset = virt_to_pageoff(key);
 	tmp.length = keylen;
 	crypto_digest_digest(tfm, &tmp, 1, key);
 		
@@ -71,7 +71,7 @@
 		ipad[i] ^= 0x36;
 
 	tmp.page = virt_to_page(ipad);
-	tmp.offset = ((long)ipad & ~PAGE_MASK);
+	tmp.offset = virt_to_pageoff(ipad);
 	tmp.length = crypto_tfm_alg_blocksize(tfm);
 	
 	crypto_digest_init(tfm);
@@ -105,14 +105,14 @@
 		opad[i] ^= 0x5c;
 
 	tmp.page = virt_to_page(opad);
-	tmp.offset = ((long)opad & ~PAGE_MASK);
+	tmp.offset = virt_to_pageoff(opad);
 	tmp.length = crypto_tfm_alg_blocksize(tfm);
 
 	crypto_digest_init(tfm);
 	crypto_digest_update(tfm, &tmp, 1);
 	
 	tmp.page = virt_to_page(out);
-	tmp.offset = ((long)out & ~PAGE_MASK);
+	tmp.offset = virt_to_pageoff(out);
 	tmp.length = crypto_tfm_alg_digestsize(tfm);
 	
 	crypto_digest_update(tfm, &tmp, 1);
Index: linux-2.6/crypto/tcrypt.c
===================================================================
RCS file: /home/cvs/linux-2.5/crypto/tcrypt.c,v
retrieving revision 1.13
diff -u -r1.13 tcrypt.c
--- linux-2.6/crypto/tcrypt.c	1 Aug 2003 22:02:12 -0000	1.13
+++ linux-2.6/crypto/tcrypt.c	10 Aug 2003 08:40:52 -0000
@@ -96,7 +96,7 @@
 
 		p = md5_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = strlen(md5_tv[i].plaintext);
 
 		crypto_digest_init(tfm);
@@ -119,12 +119,12 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 13;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 13;
 
 	memset(result, 0, sizeof (result));
@@ -173,7 +173,7 @@
 
 		p = hmac_md5_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = strlen(hmac_md5_tv[i].plaintext);
 
 		klen = strlen(hmac_md5_tv[i].key);
@@ -195,12 +195,12 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 16;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 12;
 
 	memset(result, 0, sizeof (result));
@@ -250,7 +250,7 @@
 
 		p = hmac_sha1_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = strlen(hmac_sha1_tv[i].plaintext);
 
 		klen = strlen(hmac_sha1_tv[i].key);
@@ -274,12 +274,12 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 16;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 12;
 
 	memset(result, 0, sizeof (result));
@@ -329,7 +329,7 @@
 
 		p = hmac_sha256_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = strlen(hmac_sha256_tv[i].plaintext);
 
 		klen = strlen(hmac_sha256_tv[i].key);
@@ -383,7 +383,7 @@
 
 		p = md4_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = strlen(md4_tv[i].plaintext);
 
 		crypto_digest_digest(tfm, sg, 1, result);
@@ -433,7 +433,7 @@
 
 		p = sha1_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = strlen(sha1_tv[i].plaintext);
 
 		crypto_digest_init(tfm);
@@ -456,12 +456,12 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 28;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 28;
 
 	memset(result, 0, sizeof (result));
@@ -508,7 +508,7 @@
 
 		p = sha256_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = strlen(sha256_tv[i].plaintext);
 
 		crypto_digest_init(tfm);
@@ -531,12 +531,12 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 28;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 28;
 
 	memset(result, 0, sizeof (result));
@@ -584,7 +584,7 @@
 
 		p = sha384_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = strlen(sha384_tv[i].plaintext);
 
 		crypto_digest_init(tfm);
@@ -636,7 +636,7 @@
 
 		p = sha512_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = strlen(sha512_tv[i].plaintext);
 
 		crypto_digest_init(tfm);
@@ -701,7 +701,7 @@
 
 		p = des_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = len;
 		ret = crypto_cipher_encrypt(tfm, sg, sg, len);
 		if (ret) {
@@ -738,12 +738,12 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 8;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 8;
 
 	ret = crypto_cipher_encrypt(tfm, sg, sg, 16);
@@ -801,17 +801,17 @@
 
 	p = &xbuf[IDX3];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 14;
 
 	p = &xbuf[IDX4];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 10;
 
 	p = &xbuf[IDX5];
 	sg[2].page = virt_to_page(p);
-	sg[2].offset = ((long) p & ~PAGE_MASK);
+	sg[2].offset = virt_to_pageoff(p);
 	sg[2].length = 8;
 
 	ret = crypto_cipher_encrypt(tfm, sg, sg, 32);
@@ -872,22 +872,22 @@
 
 	p = &xbuf[IDX3];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 2;
 
 	p = &xbuf[IDX4];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 1;
 
 	p = &xbuf[IDX5];
 	sg[2].page = virt_to_page(p);
-	sg[2].offset = ((long) p & ~PAGE_MASK);
+	sg[2].offset = virt_to_pageoff(p);
 	sg[2].length = 3;
 
 	p = &xbuf[IDX6];
 	sg[3].page = virt_to_page(p);
-	sg[3].offset = ((long) p & ~PAGE_MASK);
+	sg[3].offset = virt_to_pageoff(p);
 	sg[3].length = 18;
 
 	ret = crypto_cipher_encrypt(tfm, sg, sg, 24);
@@ -956,27 +956,27 @@
 
 	p = &xbuf[IDX3];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 2;
 
 	p = &xbuf[IDX4];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 2;
 
 	p = &xbuf[IDX5];
 	sg[2].page = virt_to_page(p);
-	sg[2].offset = ((long) p & ~PAGE_MASK);
+	sg[2].offset = virt_to_pageoff(p);
 	sg[2].length = 2;
 
 	p = &xbuf[IDX6];
 	sg[3].page = virt_to_page(p);
-	sg[3].offset = ((long) p & ~PAGE_MASK);
+	sg[3].offset = virt_to_pageoff(p);
 	sg[3].length = 2;
 
 	p = &xbuf[IDX7];
 	sg[4].page = virt_to_page(p);
-	sg[4].offset = ((long) p & ~PAGE_MASK);
+	sg[4].offset = virt_to_pageoff(p);
 	sg[4].length = 8;
 
 	ret = crypto_cipher_encrypt(tfm, sg, sg, 16);
@@ -1040,42 +1040,42 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 1;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 1;
 
 	p = &xbuf[IDX3];
 	sg[2].page = virt_to_page(p);
-	sg[2].offset = ((long) p & ~PAGE_MASK);
+	sg[2].offset = virt_to_pageoff(p);
 	sg[2].length = 1;
 
 	p = &xbuf[IDX4];
 	sg[3].page = virt_to_page(p);
-	sg[3].offset = ((long) p & ~PAGE_MASK);
+	sg[3].offset = virt_to_pageoff(p);
 	sg[3].length = 1;
 
 	p = &xbuf[IDX5];
 	sg[4].page = virt_to_page(p);
-	sg[4].offset = ((long) p & ~PAGE_MASK);
+	sg[4].offset = virt_to_pageoff(p);
 	sg[4].length = 1;
 
 	p = &xbuf[IDX6];
 	sg[5].page = virt_to_page(p);
-	sg[5].offset = ((long) p & ~PAGE_MASK);
+	sg[5].offset = virt_to_pageoff(p);
 	sg[5].length = 1;
 
 	p = &xbuf[IDX7];
 	sg[6].page = virt_to_page(p);
-	sg[6].offset = ((long) p & ~PAGE_MASK);
+	sg[6].offset = virt_to_pageoff(p);
 	sg[6].length = 1;
 
 	p = &xbuf[IDX8];
 	sg[7].page = virt_to_page(p);
-	sg[7].offset = ((long) p & ~PAGE_MASK);
+	sg[7].offset = virt_to_pageoff(p);
 	sg[7].length = 1;
 
 	ret = crypto_cipher_encrypt(tfm, sg, sg, 8);
@@ -1117,7 +1117,7 @@
 
 		p = des_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = len;
 
 		ret = crypto_cipher_decrypt(tfm, sg, sg, sg[0].length);
@@ -1155,12 +1155,12 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 8;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 8;
 
 	ret = crypto_cipher_decrypt(tfm, sg, sg, 16);
@@ -1207,17 +1207,17 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 3;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 12;
 
 	p = &xbuf[IDX3];
 	sg[2].page = virt_to_page(p);
-	sg[2].offset = ((long) p & ~PAGE_MASK);
+	sg[2].offset = virt_to_pageoff(p);
 	sg[2].length = 1;
 
 	ret = crypto_cipher_decrypt(tfm, sg, sg, 16);
@@ -1284,7 +1284,7 @@
 		p = des_tv[i].plaintext;
 
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = len;
 
 		crypto_cipher_set_iv(tfm, des_tv[i].iv,
@@ -1339,12 +1339,12 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 13;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 11;
 
 	crypto_cipher_set_iv(tfm, des_tv[i].iv, crypto_tfm_alg_ivsize(tfm));
@@ -1392,7 +1392,7 @@
 		p = des_tv[i].plaintext;
 
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = len;
 
 		crypto_cipher_set_iv(tfm, des_tv[i].iv,
@@ -1440,12 +1440,12 @@
 
 	p = &xbuf[IDX1];
 	sg[0].page = virt_to_page(p);
-	sg[0].offset = ((long) p & ~PAGE_MASK);
+	sg[0].offset = virt_to_pageoff(p);
 	sg[0].length = 4;
 
 	p = &xbuf[IDX2];
 	sg[1].page = virt_to_page(p);
-	sg[1].offset = ((long) p & ~PAGE_MASK);
+	sg[1].offset = virt_to_pageoff(p);
 	sg[1].length = 4;
 
 	crypto_cipher_set_iv(tfm, des_tv[i].iv, crypto_tfm_alg_ivsize(tfm));
@@ -1516,7 +1516,7 @@
 
 		p = des_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = len;
 		ret = crypto_cipher_encrypt(tfm, sg, sg, len);
 		if (ret) {
@@ -1559,7 +1559,7 @@
 
 		p = des_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = len;
 		ret = crypto_cipher_decrypt(tfm, sg, sg, len);
 		if (ret) {
@@ -1622,7 +1622,7 @@
 
 		p = bf_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = bf_tv[i].plen;
 		ret = crypto_cipher_encrypt(tfm, sg, sg, sg[0].length);
 		if (ret) {
@@ -1664,7 +1664,7 @@
 
 		p = bf_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = bf_tv[i].plen;
 		ret = crypto_cipher_decrypt(tfm, sg, sg, sg[0].length);
 		if (ret) {
@@ -1713,7 +1713,7 @@
 		p = bf_tv[i].plaintext;
 
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length =  bf_tv[i].plen;
 
 		crypto_cipher_set_iv(tfm, bf_tv[i].iv,
@@ -1758,7 +1758,7 @@
 		p = bf_tv[i].plaintext;
 
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length =  bf_tv[i].plen;
 
 		crypto_cipher_set_iv(tfm, bf_tv[i].iv,
@@ -1827,7 +1827,7 @@
 
 		p = tf_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = tf_tv[i].plen;
 		ret = crypto_cipher_encrypt(tfm, sg, sg, sg[0].length);
 		if (ret) {
@@ -1869,7 +1869,7 @@
 
 		p = tf_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = tf_tv[i].plen;
 		ret = crypto_cipher_decrypt(tfm, sg, sg, sg[0].length);
 		if (ret) {
@@ -1918,7 +1918,7 @@
 		p = tf_tv[i].plaintext;
 
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length =  tf_tv[i].plen;
 
 		crypto_cipher_set_iv(tfm, tf_tv[i].iv,
@@ -1964,7 +1964,7 @@
 		p = tf_tv[i].plaintext;
 
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length =  tf_tv[i].plen;
 
 		crypto_cipher_set_iv(tfm, tf_tv[i].iv,
@@ -2028,7 +2028,7 @@
 
 		p = serp_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = sizeof(serp_tv[i].plaintext);
 		ret = crypto_cipher_encrypt(tfm, sg, sg, sg[0].length);
 		if (ret) {
@@ -2068,7 +2068,7 @@
 
 		p = serp_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = sizeof(serp_tv[i].plaintext);
 		ret = crypto_cipher_decrypt(tfm, sg, sg, sg[0].length);
 		if (ret) {
@@ -2131,7 +2131,7 @@
 
 		p = aes_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = aes_tv[i].plen;
 		ret = crypto_cipher_encrypt(tfm, sg, sg, sg[0].length);
 		if (ret) {
@@ -2173,7 +2173,7 @@
 
 		p = aes_tv[i].plaintext;
 		sg[0].page = virt_to_page(p);
-		sg[0].offset = ((long) p & ~PAGE_MASK);
+		sg[0].offset = virt_to_pageoff(p);
 		sg[0].length = aes_tv[i].plen;
 		ret = crypto_cipher_decrypt(tfm, sg, sg, sg[0].length);
 		if (ret) {

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA

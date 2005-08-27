Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbVH0Adz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbVH0Adz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 20:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVH0Adz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 20:33:55 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:63186 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S965174AbVH0Adz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 20:33:55 -0400
Date: Sat, 27 Aug 2005 02:33:41 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Use sg_init_one where appropriate
Message-ID: <20050827003340.GB9222@hansolo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same code as in sg_init_one can be found in a number of places, this 
patch changes them to call the function instead.

Signed-off-by: David Härdeman <david@2gen.com>

---

 crypto/hmac.c                         |   23 ++++++-----------------
 crypto/tcrypt.c                       |   29 ++++++++---------------------
 drivers/md/dm-crypt.c                 |   11 ++++-------
 drivers/net/wireless/airo.c           |    5 ++---
 drivers/scsi/arm/scsi.h               |    6 ++----
 drivers/scsi/libata-core.c            |   10 ++--------
 drivers/scsi/sg.c                     |    5 ++---
 drivers/usb/misc/usbtest.c            |    6 ++----
 include/linux/scatterlist.h           |    5 +++--
 net/ipv6/addrconf.c                   |    9 +++------
 net/sunrpc/auth_gss/gss_krb5_crypto.c |   22 ++++++----------------
 11 files changed, 40 insertions(+), 91 deletions(-)



Index: linux-sginitone/include/linux/scatterlist.h
===================================================================
--- linux-sginitone.orig/include/linux/scatterlist.h	2005-03-02 08:38:32.000000000 +0100
+++ linux-sginitone/include/linux/scatterlist.h	2005-08-27 00:20:53.000000000 +0200
@@ -1,8 +1,9 @@
 #ifndef _LINUX_SCATTERLIST_H
 #define _LINUX_SCATTERLIST_H
 
-static inline void sg_init_one(struct scatterlist *sg,
-			       u8 *buf, unsigned int buflen)
+static inline void sg_init_one(const struct scatterlist *sg,
+			       const u8 *buf,
+			       const unsigned int buflen)
 {
 	memset(sg, 0, sizeof(*sg));
 
Index: linux-sginitone/crypto/hmac.c
===================================================================
--- linux-sginitone.orig/crypto/hmac.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-sginitone/crypto/hmac.c	2005-08-27 00:32:26.000000000 +0200
@@ -19,17 +19,15 @@
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include "internal.h"
 
 static void hash_key(struct crypto_tfm *tfm, u8 *key, unsigned int keylen)
 {
 	struct scatterlist tmp;
-	
-	tmp.page = virt_to_page(key);
-	tmp.offset = offset_in_page(key);
-	tmp.length = keylen;
+
+	sg_init_one(tmp, key, keylen);
 	crypto_digest_digest(tfm, &tmp, 1, key);
-		
 }
 
 int crypto_alloc_hmac_block(struct crypto_tfm *tfm)
@@ -70,10 +68,7 @@
 	for (i = 0; i < crypto_tfm_alg_blocksize(tfm); i++)
 		ipad[i] ^= 0x36;
 
-	tmp.page = virt_to_page(ipad);
-	tmp.offset = offset_in_page(ipad);
-	tmp.length = crypto_tfm_alg_blocksize(tfm);
-	
+	sg_init_one(tmp, ipad, crypto_tfm_alg_blocksize(tfm));
 	crypto_digest_init(tfm);
 	crypto_digest_update(tfm, &tmp, 1);
 }
@@ -104,17 +99,11 @@
 	for (i = 0; i < crypto_tfm_alg_blocksize(tfm); i++)
 		opad[i] ^= 0x5c;
 
-	tmp.page = virt_to_page(opad);
-	tmp.offset = offset_in_page(opad);
-	tmp.length = crypto_tfm_alg_blocksize(tfm);
-
+	sg_init_one(tmp, opad, crypto_tfm_alg_blocksize(tfm));
 	crypto_digest_init(tfm);
 	crypto_digest_update(tfm, &tmp, 1);
 	
-	tmp.page = virt_to_page(out);
-	tmp.offset = offset_in_page(out);
-	tmp.length = crypto_tfm_alg_digestsize(tfm);
-	
+	sg_init_one(tmp, out, crypto_tfm_alg_blocksize(tfm));
 	crypto_digest_update(tfm, &tmp, 1);
 	crypto_digest_final(tfm, out);
 }
Index: linux-sginitone/crypto/tcrypt.c
===================================================================
--- linux-sginitone.orig/crypto/tcrypt.c	2005-08-19 22:40:05.000000000 +0200
+++ linux-sginitone/crypto/tcrypt.c	2005-08-27 00:45:05.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <linux/crypto.h>
 #include <linux/highmem.h>
@@ -109,9 +110,7 @@
 		memset (result, 0, 64);
 
 		p = hash_tv[i].plaintext;
-		sg[0].page = virt_to_page (p);
-		sg[0].offset = offset_in_page (p);
-		sg[0].length = hash_tv[i].psize;
+		sg_init_one(&sg[0], p, hash_tv[i].psize);
 
 		crypto_digest_init (tfm);
 		if (tfm->crt_u.digest.dit_setkey) {
@@ -146,9 +145,7 @@
 						hash_tv[i].tap[k]);	
 				temp += hash_tv[i].tap[k];
 				p = &xbuf[IDX[k]];
-				sg[k].page = virt_to_page (p);
-				sg[k].offset = offset_in_page (p);
-				sg[k].length = hash_tv[i].tap[k];
+				sg_init_one(&sg[k], p, hash_tv[i].tap[k]);
 			}
 
 			crypto_digest_digest (tfm, sg, hash_tv[i].np, result);
@@ -203,9 +200,7 @@
 
 		p = hmac_tv[i].plaintext;
 		klen = hmac_tv[i].ksize;
-		sg[0].page = virt_to_page(p);
-		sg[0].offset = offset_in_page(p);
-		sg[0].length = hmac_tv[i].psize;
+		sg_init_one(&sg[0], p, hmac_tv[i].psize);
 
 		crypto_hmac(tfm, hmac_tv[i].key, &klen, sg, 1, result);
 
@@ -234,9 +229,7 @@
 						hmac_tv[i].tap[k]);	
 				temp += hmac_tv[i].tap[k];
 				p = &xbuf[IDX[k]];
-				sg[k].page = virt_to_page (p);
-				sg[k].offset = offset_in_page (p);
-				sg[k].length = hmac_tv[i].tap[k];
+				sg_init_one(&sg[k], p, hmac_tv[i].tap[k]);
 			}
 
 			crypto_hmac(tfm, hmac_tv[i].key, &klen, sg, hmac_tv[i].np, 
@@ -321,9 +314,7 @@
 			}	
 
 			p = cipher_tv[i].input;
-			sg[0].page = virt_to_page(p);
-			sg[0].offset = offset_in_page(p);
-			sg[0].length = cipher_tv[i].ilen;
+			sg_init_one(&sg[0], p, cipher_tv[i].ilen);
 	
 			if (!mode) {
 				crypto_cipher_set_iv(tfm, cipher_tv[i].iv,
@@ -379,9 +370,7 @@
 						cipher_tv[i].tap[k]);	
 				temp += cipher_tv[i].tap[k];
 				p = &xbuf[IDX[k]];
-				sg[k].page = virt_to_page (p);
-				sg[k].offset = offset_in_page (p);
-				sg[k].length = cipher_tv[i].tap[k];
+				sg_init_one(&sk[k], p, cipher_tv[i].tap[k]);
 			}
 			
 			if (!mode) {
@@ -538,9 +527,7 @@
 	for (i = 0; i < NUMVEC; i++) {
 		for (j = 0; j < VECSIZE; j++) 
 			test_vec[i][j] = ++b;
-		sg[i].page = virt_to_page(test_vec[i]);
-		sg[i].offset = offset_in_page(test_vec[i]);
-		sg[i].length = VECSIZE;
+		sg_init_one(&sg[i], test_vec[i], VECSIZE);
 	}
 
 	seed = SEEDTESTVAL;
Index: linux-sginitone/drivers/md/dm-crypt.c
===================================================================
--- linux-sginitone.orig/drivers/md/dm-crypt.c	2005-08-19 22:40:06.000000000 +0200
+++ linux-sginitone/drivers/md/dm-crypt.c	2005-08-27 01:20:31.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <asm/atomic.h>
 #include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include <asm/page.h>
 
 #include "dm.h"
@@ -164,9 +165,7 @@
 		return -ENOMEM;
 	}
 
-	sg.page = virt_to_page(cc->key);
-	sg.offset = offset_in_page(cc->key);
-	sg.length = cc->key_size;
+	sg_init_one(&sg, cc->key, cc->key_size);
 	crypto_digest_digest(hash_tfm, &sg, 1, salt);
 	crypto_free_tfm(hash_tfm);
 
@@ -206,14 +205,12 @@
 
 static int crypt_iv_essiv_gen(struct crypt_config *cc, u8 *iv, sector_t sector)
 {
-	struct scatterlist sg = { NULL, };
+	struct scatterlist sg;
 
 	memset(iv, 0, cc->iv_size);
 	*(u64 *)iv = cpu_to_le64(sector);
 
-	sg.page = virt_to_page(iv);
-	sg.offset = offset_in_page(iv);
-	sg.length = cc->iv_size;
+	sg_init_one(&sg, iv, cc->iv_size);
 	crypto_cipher_encrypt((struct crypto_tfm *)cc->iv_gen_private,
 	                      &sg, &sg, cc->iv_size);
 
Index: linux-sginitone/drivers/scsi/arm/scsi.h
===================================================================
--- linux-sginitone.orig/drivers/scsi/arm/scsi.h	2005-08-19 22:40:06.000000000 +0200
+++ linux-sginitone/drivers/scsi/arm/scsi.h	2005-08-27 01:15:07.000000000 +0200
@@ -11,6 +11,7 @@
  */
 
 #define BELT_AND_BRACES
+#include <linux/scatterlist.h>
 
 /*
  * The scatter-gather list handling.  This contains all
@@ -22,10 +23,7 @@
 
 	BUG_ON(bufs + 1 > max);
 
-	sg->page   = virt_to_page(SCp->ptr);
-	sg->offset = offset_in_page(SCp->ptr);
-	sg->length = SCp->this_residual;
-
+        sg_init_one(sg, SCp->ptr, SCp->this_residual);
 	if (bufs)
 		memcpy(sg + 1, SCp->buffer + 1,
 		       sizeof(struct scatterlist) * bufs);
Index: linux-sginitone/drivers/scsi/sg.c
===================================================================
--- linux-sginitone.orig/drivers/scsi/sg.c	2005-08-19 22:40:07.000000000 +0200
+++ linux-sginitone/drivers/scsi/sg.c	2005-08-27 01:09:38.000000000 +0200
@@ -49,6 +49,7 @@
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
+#include <linux/scatterlist.h>
 
 #include "scsi.h"
 #include <scsi/scsi_dbg.h>
@@ -1993,9 +1994,7 @@
 				if (!p)
 					break;
 			}
-			sclp->page = virt_to_page(p);
-			sclp->offset = offset_in_page(p);
-			sclp->length = ret_sz;
+			sg_init_one(sclp, p, ret_sz);
 
 			SCSI_LOG_TIMEOUT(5, printk("sg_build_build: k=%d, a=0x%p, len=%d\n",
 					  k, sg_scatg2virt(sclp), ret_sz));
Index: linux-sginitone/drivers/usb/misc/usbtest.c
===================================================================
--- linux-sginitone.orig/drivers/usb/misc/usbtest.c	2005-08-19 22:40:07.000000000 +0200
+++ linux-sginitone/drivers/usb/misc/usbtest.c	2005-08-27 01:20:09.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 
 #include <linux/usb.h>
 
@@ -381,7 +382,6 @@
 	sg = kmalloc (nents * sizeof *sg, SLAB_KERNEL);
 	if (!sg)
 		return NULL;
-	memset (sg, 0, nents * sizeof *sg);
 
 	for (i = 0; i < nents; i++) {
 		char		*buf;
@@ -394,9 +394,7 @@
 		memset (buf, 0, size);
 
 		/* kmalloc pages are always physically contiguous! */
-		sg [i].page = virt_to_page (buf);
-		sg [i].offset = offset_in_page (buf);
-		sg [i].length = size;
+		sg_init_one(&sg[i], buf, size);
 
 		if (vary) {
 			size += vary;
Index: linux-sginitone/net/ipv6/addrconf.c
===================================================================
--- linux-sginitone.orig/net/ipv6/addrconf.c	2005-08-19 22:40:37.000000000 +0200
+++ linux-sginitone/net/ipv6/addrconf.c	2005-08-27 00:47:56.000000000 +0200
@@ -75,6 +75,7 @@
 #include <linux/random.h>
 #include <linux/crypto.h>
 #include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #endif
 
 #include <asm/uaccess.h>
@@ -1217,12 +1218,8 @@
 	struct net_device *dev;
 	struct scatterlist sg[2];
 
-	sg[0].page = virt_to_page(idev->entropy);
-	sg[0].offset = offset_in_page(idev->entropy);
-	sg[0].length = 8;
-	sg[1].page = virt_to_page(idev->work_eui64);
-	sg[1].offset = offset_in_page(idev->work_eui64);
-	sg[1].length = 8;
+	sg_init_one(&sg[0], idev->entropy, 8);
+	sg_init_one(&sg[1], idev->work_eui64, 8);
 
 	dev = idev->dev;
 
Index: linux-sginitone/net/sunrpc/auth_gss/gss_krb5_crypto.c
===================================================================
--- linux-sginitone.orig/net/sunrpc/auth_gss/gss_krb5_crypto.c	2005-03-02 08:37:47.000000000 +0100
+++ linux-sginitone/net/sunrpc/auth_gss/gss_krb5_crypto.c	2005-08-27 00:54:09.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include <linux/crypto.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
@@ -75,9 +76,7 @@
 		memcpy(local_iv, iv, crypto_tfm_alg_ivsize(tfm));
 
 	memcpy(out, in, length);
-	sg[0].page = virt_to_page(out);
-	sg[0].offset = offset_in_page(out);
-	sg[0].length = length;
+	sg_init_one(&sg[0], out, length);
 
 	ret = crypto_cipher_encrypt_iv(tfm, sg, sg, length, local_iv);
 
@@ -117,9 +116,7 @@
 		memcpy(local_iv,iv, crypto_tfm_alg_ivsize(tfm));
 
 	memcpy(out, in, length);
-	sg[0].page = virt_to_page(out);
-	sg[0].offset = offset_in_page(out);
-	sg[0].length = length;
+	sg_init_one(&sg[0], out, length);
 
 	ret = crypto_cipher_decrypt_iv(tfm, sg, sg, length, local_iv);
 
@@ -132,13 +129,6 @@
 
 EXPORT_SYMBOL(krb5_decrypt);
 
-static void
-buf_to_sg(struct scatterlist *sg, char *ptr, int len) {
-	sg->page = virt_to_page(ptr);
-	sg->offset = offset_in_page(ptr);
-	sg->length = len;
-}
-
 /* checksum the plaintext data and hdrlen bytes of the token header */
 s32
 make_checksum(s32 cksumtype, char *header, int hdrlen, struct xdr_buf *body,
@@ -167,10 +157,10 @@
 		goto out;
 
 	crypto_digest_init(tfm);
-	buf_to_sg(sg, header, hdrlen);
+	sg_init_one(sg, header, hdrlen);
 	crypto_digest_update(tfm, sg, 1);
 	if (body->head[0].iov_len) {
-		buf_to_sg(sg, body->head[0].iov_base, body->head[0].iov_len);
+		sg_init_one(sg, body->head[0].iov_base, body->head[0].iov_len);
 		crypto_digest_update(tfm, sg, 1);
 	}
 
@@ -195,7 +185,7 @@
 		} while(len != 0);
 	}
 	if (body->tail[0].iov_len) {
-		buf_to_sg(sg, body->tail[0].iov_base, body->tail[0].iov_len);
+		sg_init_one(sg, body->tail[0].iov_base, body->tail[0].iov_len);
 		crypto_digest_update(tfm, sg, 1);
 	}
 	crypto_digest_final(tfm, cksum->data);
Index: linux-sginitone/drivers/net/wireless/airo.c
===================================================================
--- linux-sginitone.orig/drivers/net/wireless/airo.c	2005-08-19 22:40:06.000000000 +0200
+++ linux-sginitone/drivers/net/wireless/airo.c	2005-08-27 01:27:51.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/in.h>
 #include <linux/bitops.h>
+#include <linux/scatterlist.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -1589,9 +1590,7 @@
 		aes_counter[12] = (u8)(counter >> 24);
 		counter++;
 		memcpy (plain, aes_counter, 16);
-		sg[0].page = virt_to_page(plain);
-		sg[0].offset = ((long) plain & ~PAGE_MASK);
-		sg[0].length = 16;
+		sg_init_one(&sg[0], plain, 16);
 		crypto_cipher_encrypt(tfm, sg, sg, 16);
 		cipher = kmap(sg[0].page) + sg[0].offset;
 		for (j=0; (j<16) && (i< (sizeof(context->coeff)/sizeof(context->coeff[0]))); ) {
Index: linux-sginitone/drivers/scsi/libata-core.c
===================================================================
--- linux-sginitone.orig/drivers/scsi/libata-core.c	2005-08-19 22:40:07.000000000 +0200
+++ linux-sginitone/drivers/scsi/libata-core.c	2005-08-27 01:38:56.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/completion.h>
 #include <linux/suspend.h>
 #include <linux/workqueue.h>
+#include <linux/scatterlist.h>
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include "scsi_priv.h"
@@ -2251,19 +2252,12 @@
  */
 void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf, unsigned int buflen)
 {
-	struct scatterlist *sg;
-
 	qc->flags |= ATA_QCFLAG_SINGLE;
 
-	memset(&qc->sgent, 0, sizeof(qc->sgent));
 	qc->sg = &qc->sgent;
 	qc->n_elem = 1;
 	qc->buf_virt = buf;
-
-	sg = qc->sg;
-	sg->page = virt_to_page(buf);
-	sg->offset = (unsigned long) buf & ~PAGE_MASK;
-	sg->length = buflen;
+	sg_init_one(qc->sg, buf, buflen);
 }
 
 /**

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVIQH6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVIQH6o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 03:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbVIQH6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 03:58:44 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:53648 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S1751001AbVIQH6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 03:58:43 -0400
Date: Sat, 17 Sep 2005 17:58:28 +1000
To: akpm@osdl.org
Cc: david@2gen.com, davem@davemloft.net, greg@kroah.com,
       James.Bottomley@steeleye.com, jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: use-sg_init_one-where-appropriate.patch added to -mm tree
Message-ID: <20050917075828.GA25261@gondor.apana.org.au>
References: <200508292323.j7TNNU6J030938@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <200508292323.j7TNNU6J030938@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 29, 2005 at 04:25:57PM -0700, akpm@osdl.org wrote:
> 
> From: David Hardeman <david@2gen.com>
> 
> This patch uses sg_init_one in some places where it was duplicated.

Thanks for the patch.

In most of the places where a scatterlist is used, we don't care about
the DMA attributes.  Hence there is no need to zero the entire scatterlist
structure for them.

I've added a new sg_set_buf function to initialise the address and length
without zeroing the structure.  I've also adapted the patch to use it
where appropriate.  There were a couple of typos in the crypto code
which I fixed up.

I'll put them into the cryptodev tree.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p1

[PATCH] Introduce sg_set_buf

sg_init_one is a nice tool for the block layer.  However, users
of struct scatterlist in other subsystems don't usually need the
DMA attributes.  For them it's a waste of time and space to
initialise the whole struct scatterlist structure.

Therefore this patch adds a new function sg_set_buf to initialise
a scatterlist without zeroing the DMA attributes.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -1,14 +1,23 @@
 #ifndef _LINUX_SCATTERLIST_H
 #define _LINUX_SCATTERLIST_H
 
-static inline void sg_init_one(struct scatterlist *sg,
-			       u8 *buf, unsigned int buflen)
-{
-	memset(sg, 0, sizeof(*sg));
+#include <asm/scatterlist.h>
+#include <linux/mm.h>
+#include <linux/string.h>
 
+static inline void sg_set_buf(struct scatterlist *sg, void *buf,
+			      unsigned int buflen)
+{
 	sg->page = virt_to_page(buf);
 	sg->offset = offset_in_page(buf);
 	sg->length = buflen;
 }
 
+static inline void sg_init_one(struct scatterlist *sg, void *buf,
+			       unsigned int buflen)
+{
+	memset(sg, 0, sizeof(*sg));
+	sg_set_buf(sg, buf, buflen);
+}
+
 #endif /* _LINUX_SCATTERLIST_H */

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p2

[PATCH] Use sg_set_buf/sg_init_one where applicable

This patch uses sg_set_buf/sg_init_one in some places where it was
duplicated.

Signed-off-by: David Hardeman <david@2gen.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>
Cc: Greg KH <greg@kroah.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/hmac.c b/crypto/hmac.c
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -18,18 +18,15 @@
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
-#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include "internal.h"
 
 static void hash_key(struct crypto_tfm *tfm, u8 *key, unsigned int keylen)
 {
 	struct scatterlist tmp;
 	
-	tmp.page = virt_to_page(key);
-	tmp.offset = offset_in_page(key);
-	tmp.length = keylen;
+	sg_set_buf(&tmp, key, keylen);
 	crypto_digest_digest(tfm, &tmp, 1, key);
-		
 }
 
 int crypto_alloc_hmac_block(struct crypto_tfm *tfm)
@@ -69,9 +66,7 @@ void crypto_hmac_init(struct crypto_tfm 
 	for (i = 0; i < crypto_tfm_alg_blocksize(tfm); i++)
 		ipad[i] ^= 0x36;
 
-	tmp.page = virt_to_page(ipad);
-	tmp.offset = offset_in_page(ipad);
-	tmp.length = crypto_tfm_alg_blocksize(tfm);
+	sg_set_buf(&tmp, ipad, crypto_tfm_alg_blocksize(tfm));
 	
 	crypto_digest_init(tfm);
 	crypto_digest_update(tfm, &tmp, 1);
@@ -103,16 +98,12 @@ void crypto_hmac_final(struct crypto_tfm
 	for (i = 0; i < crypto_tfm_alg_blocksize(tfm); i++)
 		opad[i] ^= 0x5c;
 
-	tmp.page = virt_to_page(opad);
-	tmp.offset = offset_in_page(opad);
-	tmp.length = crypto_tfm_alg_blocksize(tfm);
+	sg_set_buf(&tmp, opad, crypto_tfm_alg_blocksize(tfm));
 
 	crypto_digest_init(tfm);
 	crypto_digest_update(tfm, &tmp, 1);
 	
-	tmp.page = virt_to_page(out);
-	tmp.offset = offset_in_page(out);
-	tmp.length = crypto_tfm_alg_digestsize(tfm);
+	sg_set_buf(&tmp, out, crypto_tfm_alg_digestsize(tfm));
 	
 	crypto_digest_update(tfm, &tmp, 1);
 	crypto_digest_final(tfm, out);
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -21,7 +21,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <linux/crypto.h>
 #include <linux/highmem.h>
@@ -86,7 +86,6 @@ static void hexdump(unsigned char *buf, 
 static void test_hash(char *algo, struct hash_testvec *template,
 		      unsigned int tcount)
 {
-	char *p;
 	unsigned int i, j, k, temp;
 	struct scatterlist sg[8];
 	char result[64];
@@ -116,10 +115,7 @@ static void test_hash(char *algo, struct
 		printk("test %u:\n", i + 1);
 		memset(result, 0, 64);
 
-		p = hash_tv[i].plaintext;
-		sg[0].page = virt_to_page(p);
-		sg[0].offset = offset_in_page(p);
-		sg[0].length = hash_tv[i].psize;
+		sg_set_buf(&sg[0], hash_tv[i].plaintext, hash_tv[i].psize);
 
 		crypto_digest_init(tfm);
 		if (tfm->crt_u.digest.dit_setkey) {
@@ -154,10 +150,8 @@ static void test_hash(char *algo, struct
 				       hash_tv[i].plaintext + temp,
 				       hash_tv[i].tap[k]);
 				temp += hash_tv[i].tap[k];
-				p = &xbuf[IDX[k]];
-				sg[k].page = virt_to_page(p);
-				sg[k].offset = offset_in_page(p);
-				sg[k].length = hash_tv[i].tap[k];
+				sg_set_buf(&sg[k], &xbuf[IDX[k]],
+					    hash_tv[i].tap[k]);
 			}
 
 			crypto_digest_digest(tfm, sg, hash_tv[i].np, result);
@@ -179,7 +173,6 @@ static void test_hash(char *algo, struct
 static void test_hmac(char *algo, struct hmac_testvec *template,
 		      unsigned int tcount)
 {
-	char *p;
 	unsigned int i, j, k, temp;
 	struct scatterlist sg[8];
 	char result[64];
@@ -210,11 +203,8 @@ static void test_hmac(char *algo, struct
 		printk("test %u:\n", i + 1);
 		memset(result, 0, sizeof (result));
 
-		p = hmac_tv[i].plaintext;
 		klen = hmac_tv[i].ksize;
-		sg[0].page = virt_to_page(p);
-		sg[0].offset = offset_in_page(p);
-		sg[0].length = hmac_tv[i].psize;
+		sg_set_buf(&sg[0], hmac_tv[i].plaintext, hmac_tv[i].psize);
 
 		crypto_hmac(tfm, hmac_tv[i].key, &klen, sg, 1, result);
 
@@ -243,10 +233,8 @@ static void test_hmac(char *algo, struct
 				       hmac_tv[i].plaintext + temp,
 				       hmac_tv[i].tap[k]);
 				temp += hmac_tv[i].tap[k];
-				p = &xbuf[IDX[k]];
-				sg[k].page = virt_to_page(p);
-				sg[k].offset = offset_in_page(p);
-				sg[k].length = hmac_tv[i].tap[k];
+				sg_set_buf(&sg[k], &xbuf[IDX[k]],
+					    hmac_tv[i].tap[k]);
 			}
 
 			crypto_hmac(tfm, hmac_tv[i].key, &klen, sg,
@@ -270,7 +258,7 @@ static void test_cipher(char *algo, int 
 {
 	unsigned int ret, i, j, k, temp;
 	unsigned int tsize;
-	char *p, *q;
+	char *q;
 	struct crypto_tfm *tfm;
 	char *key;
 	struct cipher_testvec *cipher_tv;
@@ -330,10 +318,8 @@ static void test_cipher(char *algo, int 
 					goto out;
 			}
 
-			p = cipher_tv[i].input;
-			sg[0].page = virt_to_page(p);
-			sg[0].offset = offset_in_page(p);
-			sg[0].length = cipher_tv[i].ilen;
+			sg_set_buf(&sg[0], cipher_tv[i].input,
+				   cipher_tv[i].ilen);
 
 			if (!mode) {
 				crypto_cipher_set_iv(tfm, cipher_tv[i].iv,
@@ -389,10 +375,8 @@ static void test_cipher(char *algo, int 
 				       cipher_tv[i].input + temp,
 				       cipher_tv[i].tap[k]);
 				temp += cipher_tv[i].tap[k];
-				p = &xbuf[IDX[k]];
-				sg[k].page = virt_to_page(p);
-				sg[k].offset = offset_in_page(p);
-				sg[k].length = cipher_tv[i].tap[k];
+				sg_set_buf(&sg[k], &xbuf[IDX[k]],
+					   cipher_tv[i].tap[k]);
 			}
 
 			if (!mode) {
@@ -436,9 +420,7 @@ static int test_cipher_jiffies(struct cr
 	int bcount;
 	int ret;
 
-	sg[0].page = virt_to_page(p);
-	sg[0].offset = offset_in_page(p);
-	sg[0].length = blen;
+	sg_set_buf(&sg[0], p, blen);
 
 	for (start = jiffies, end = start + sec * HZ, bcount = 0;
 	     time_before(jiffies, end); bcount++) {
@@ -464,9 +446,7 @@ static int test_cipher_cycles(struct cry
 	int ret = 0;
 	int i;
 
-	sg[0].page = virt_to_page(p);
-	sg[0].offset = offset_in_page(p);
-	sg[0].length = blen;
+	sg_set_buf(&sg[0], p, blen);
 
 	local_bh_disable();
 	local_irq_disable();
@@ -709,9 +689,7 @@ static void test_crc32c(void)
 	for (i = 0; i < NUMVEC; i++) {
 		for (j = 0; j < VECSIZE; j++)
 			test_vec[i][j] = ++b;
-		sg[i].page = virt_to_page(test_vec[i]);
-		sg[i].offset = offset_in_page(test_vec[i]);
-		sg[i].length = VECSIZE;
+		sg_set_buf(&sg[i], test_vec[i], VECSIZE);
 	}
 
 	seed = SEEDTESTVAL;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -15,7 +15,7 @@
 #include <linux/crypto.h>
 #include <linux/workqueue.h>
 #include <asm/atomic.h>
-#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include <asm/page.h>
 
 #include "dm.h"
@@ -164,9 +164,7 @@ static int crypt_iv_essiv_ctr(struct cry
 		return -ENOMEM;
 	}
 
-	sg.page = virt_to_page(cc->key);
-	sg.offset = offset_in_page(cc->key);
-	sg.length = cc->key_size;
+	sg_set_buf(&sg, cc->key, cc->key_size);
 	crypto_digest_digest(hash_tfm, &sg, 1, salt);
 	crypto_free_tfm(hash_tfm);
 
@@ -207,14 +205,12 @@ static void crypt_iv_essiv_dtr(struct cr
 
 static int crypt_iv_essiv_gen(struct crypt_config *cc, u8 *iv, sector_t sector)
 {
-	struct scatterlist sg = { NULL, };
+	struct scatterlist sg;
 
 	memset(iv, 0, cc->iv_size);
 	*(u64 *)iv = cpu_to_le64(sector);
 
-	sg.page = virt_to_page(iv);
-	sg.offset = offset_in_page(iv);
-	sg.length = cc->iv_size;
+	sg_set_buf(&sg, iv, cc->iv_size);
 	crypto_cipher_encrypt((struct crypto_tfm *)cc->iv_gen_private,
 	                      &sg, &sg, cc->iv_size);
 
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/in.h>
 #include <linux/bitops.h>
+#include <linux/scatterlist.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
@@ -1596,9 +1597,7 @@ static void emmh32_setseed(emmh32_contex
 		aes_counter[12] = (u8)(counter >> 24);
 		counter++;
 		memcpy (plain, aes_counter, 16);
-		sg[0].page = virt_to_page(plain);
-		sg[0].offset = ((long) plain & ~PAGE_MASK);
-		sg[0].length = 16;
+		sg_set_buf(&sg[0], plain, 16);
 		crypto_cipher_encrypt(tfm, sg, sg, 16);
 		cipher = kmap(sg[0].page) + sg[0].offset;
 		for (j=0; (j<16) && (i< (sizeof(context->coeff)/sizeof(context->coeff[0]))); ) {
diff --git a/drivers/scsi/arm/scsi.h b/drivers/scsi/arm/scsi.h
--- a/drivers/scsi/arm/scsi.h
+++ b/drivers/scsi/arm/scsi.h
@@ -10,6 +10,8 @@
  *  Commonly used scsi driver functions.
  */
 
+#include <linux/scatterlist.h>
+
 #define BELT_AND_BRACES
 
 /*
@@ -22,9 +24,7 @@ static inline int copy_SCp_to_sg(struct 
 
 	BUG_ON(bufs + 1 > max);
 
-	sg->page   = virt_to_page(SCp->ptr);
-	sg->offset = offset_in_page(SCp->ptr);
-	sg->length = SCp->this_residual;
+	sg_set_buf(sg, SCp->ptr, SCp->this_residual);
 
 	if (bufs)
 		memcpy(sg + 1, SCp->buffer + 1,
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -48,6 +48,7 @@
 #include <linux/completion.h>
 #include <linux/suspend.h>
 #include <linux/workqueue.h>
+#include <linux/scatterlist.h>
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include "scsi_priv.h"
@@ -2284,19 +2285,12 @@ void ata_qc_prep(struct ata_queued_cmd *
 
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
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -49,6 +49,7 @@ static int sg_version_num = 30533;	/* 2 
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
+#include <linux/scatterlist.h>
 
 #include "scsi.h"
 #include <scsi/scsi_dbg.h>
@@ -1992,9 +1993,7 @@ sg_build_indirect(Sg_scatter_hold * schp
 				if (!p)
 					break;
 			}
-			sclp->page = virt_to_page(p);
-			sclp->offset = offset_in_page(p);
-			sclp->length = ret_sz;
+			sg_set_buf(sclp, p, ret_sz);
 
 			SCSI_LOG_TIMEOUT(5, printk("sg_build_build: k=%d, a=0x%p, len=%d\n",
 					  k, sg_scatg2virt(sclp), ret_sz));
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -9,7 +9,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 
 #include <linux/usb.h>
 
@@ -381,7 +381,6 @@ alloc_sglist (int nents, int max, int va
 	sg = kmalloc (nents * sizeof *sg, SLAB_KERNEL);
 	if (!sg)
 		return NULL;
-	memset (sg, 0, nents * sizeof *sg);
 
 	for (i = 0; i < nents; i++) {
 		char		*buf;
@@ -394,9 +393,7 @@ alloc_sglist (int nents, int max, int va
 		memset (buf, 0, size);
 
 		/* kmalloc pages are always physically contiguous! */
-		sg [i].page = virt_to_page (buf);
-		sg [i].offset = offset_in_page (buf);
-		sg [i].length = size;
+		sg_init_one(&sg[i], buf, size);
 
 		if (vary) {
 			size += vary;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -75,7 +75,7 @@
 #ifdef CONFIG_IPV6_PRIVACY
 #include <linux/random.h>
 #include <linux/crypto.h>
-#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #endif
 
 #include <asm/uaccess.h>
@@ -1217,12 +1217,8 @@ static int __ipv6_regen_rndid(struct ine
 	struct net_device *dev;
 	struct scatterlist sg[2];
 
-	sg[0].page = virt_to_page(idev->entropy);
-	sg[0].offset = offset_in_page(idev->entropy);
-	sg[0].length = 8;
-	sg[1].page = virt_to_page(idev->work_eui64);
-	sg[1].offset = offset_in_page(idev->work_eui64);
-	sg[1].length = 8;
+	sg_set_buf(&sg[0], idev->entropy, 8);
+	sg_set_buf(&sg[1], idev->work_eui64, 8);
 
 	dev = idev->dev;
 
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -37,7 +37,7 @@
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include <linux/crypto.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
@@ -75,9 +75,7 @@ krb5_encrypt(
 		memcpy(local_iv, iv, crypto_tfm_alg_ivsize(tfm));
 
 	memcpy(out, in, length);
-	sg[0].page = virt_to_page(out);
-	sg[0].offset = offset_in_page(out);
-	sg[0].length = length;
+	sg_set_buf(&sg[0], out, length);
 
 	ret = crypto_cipher_encrypt_iv(tfm, sg, sg, length, local_iv);
 
@@ -117,9 +115,7 @@ krb5_decrypt(
 		memcpy(local_iv,iv, crypto_tfm_alg_ivsize(tfm));
 
 	memcpy(out, in, length);
-	sg[0].page = virt_to_page(out);
-	sg[0].offset = offset_in_page(out);
-	sg[0].length = length;
+	sg_set_buf(&sg[0], out, length);
 
 	ret = crypto_cipher_decrypt_iv(tfm, sg, sg, length, local_iv);
 
@@ -132,13 +128,6 @@ out:
 
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
@@ -167,10 +156,10 @@ make_checksum(s32 cksumtype, char *heade
 		goto out;
 
 	crypto_digest_init(tfm);
-	buf_to_sg(sg, header, hdrlen);
+	sg_set_buf(sg, header, hdrlen);
 	crypto_digest_update(tfm, sg, 1);
 	if (body->head[0].iov_len) {
-		buf_to_sg(sg, body->head[0].iov_base, body->head[0].iov_len);
+		sg_set_buf(sg, body->head[0].iov_base, body->head[0].iov_len);
 		crypto_digest_update(tfm, sg, 1);
 	}
 
@@ -193,7 +182,7 @@ make_checksum(s32 cksumtype, char *heade
 		} while(len != 0);
 	}
 	if (body->tail[0].iov_len) {
-		buf_to_sg(sg, body->tail[0].iov_base, body->tail[0].iov_len);
+		sg_set_buf(sg, body->tail[0].iov_base, body->tail[0].iov_len);
 		crypto_digest_update(tfm, sg, 1);
 	}
 	crypto_digest_final(tfm, cksum->data);

--vkogqOf2sHV7VnPd--

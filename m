Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTJANbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTJANbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:31:49 -0400
Received: from johanna5.ux.his.no ([152.94.1.25]:62365 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP id S262114AbTJANbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:31:03 -0400
Date: Wed, 1 Oct 2003 15:30:39 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Steve French <sfrench@samba.org>
Cc: Samba Technical Mailing List <samba-technical@samba.org>,
       James Morris <jmorris@intercode.com.au>
Subject: [PATCH CIFS] use CryptoAPI MD4/MD5
Message-ID: <20031001133039.GA32610@badne3.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
References: <20030902203041.GA25675@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20030902203041.GA25675@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On 09/02/03 22:30, Erlend Aasland wrote:
> ...
> I've cleaned up my first patch (there were a lot of wrong code in it).
> This patch compiles on i386, but it is not tested yet.
> ...
I've looked over this code once more, modified it a little bit, and now
it not only compiles, _but_ I've also tested mounting against samba-3.0.0.

If this patch looks ok, we can remove the current CIFS implementation of
md4/md5 (I've attached a seperate (booted & tested) patch for this).

Both patches apply clean against linux-2.6.0-test6-bk[23].
Diffstat of the two patches:

add crypto-md[45] patch:
 fs/Kconfig            |    2 
 fs/cifs/Makefile      |    2 
 fs/cifs/cifsencrypt.c |   89 ++++++--
 fs/cifs/cifsencrypt.h |   18 +
 fs/cifs/cifsfs.c      |   23 ++
 fs/cifs/smbencrypt.c  |  148 +++++++++++--
remove old cifs md[45] patch:
 fs/cifs/md4.c         |  209 -------------------
 fs/cifs/md5.c         |  363 ---------------------------------
 fs/cifs/md5.h         |   38 ---
 9 files changed, 239 insertions(+), 653 deletions(-)

Regards
	Erlend Aasland

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cifs-add-crypto-md5.patch"

diff -urN linux-2.6.0-test6-bk2/fs/Kconfig linux-2.6.0-test6-bk2-dirty/fs/Kconfig
--- linux-2.6.0-test6-bk2/fs/Kconfig	Tue Sep 30 15:59:09 2003
+++ linux-2.6.0-test6-bk2-dirty/fs/Kconfig	Wed Oct  1 14:57:08 2003
@@ -1470,6 +1470,8 @@
 config CIFS
 	tristate "CIFS support (advanced network filesystem for Samba, Window and other CIFS compliant servers)(EXPERIMENTAL)"
 	depends on INET
+	select CRYPTO_MD4
+	select CRYPTO_MD5
 	help
 	  This is the client VFS module for the Common Internet File System
 	  (CIFS) protocol which is the successor to the Server Message Block 
diff -urN linux-2.6.0-test6-bk2/fs/cifs/cifsencrypt.c linux-2.6.0-test6-bk2-dirty/fs/cifs/cifsencrypt.c
--- linux-2.6.0-test6-bk2/fs/cifs/cifsencrypt.c	Sun Sep 28 02:50:30 2003
+++ linux-2.6.0-test6-bk2-dirty/fs/cifs/cifsencrypt.c	Wed Oct  1 10:35:24 2003
@@ -20,32 +20,45 @@
  */
 
 #include <linux/fs.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+#include "cifsencrypt.h"
 #include "cifspdu.h"
 #include "cifsglob.h" 
 #include "cifs_debug.h"
-#include "md5.h"
 #include "cifs_unicode.h"
 
+struct crypto_tfm *md5_tfm;
+struct crypto_tfm *md4_tfm;
+spinlock_t md5_tfm_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t md4_tfm_lock = SPIN_LOCK_UNLOCKED;
+
 /* Calculate and return the CIFS signature based on the mac key and the smb pdu */
 /* the 16 byte signature must be allocated by the caller  */
 /* Note we only use the 1st eight bytes */
 /* Note that the smb header signature field on input contains the  
 	sequence number before this function is called */
 
-extern void mdfour(unsigned char *out, unsigned char *in, int n);
-extern void E_md4hash(const unsigned char *passwd, unsigned char *p16);
-	
 static int cifs_calculate_signature(const struct smb_hdr * cifs_pdu, const char * key, char * signature)
 {
-	struct	MD5Context context;
+	struct scatterlist sg[2];
 
 	if((cifs_pdu == NULL) || (signature == NULL))
 		return -EINVAL;
 
-	MD5Init(&context);
-	MD5Update(&context,key,CIFS_SESSION_KEY_SIZE+16);
-	MD5Update(&context,cifs_pdu->Protocol,cifs_pdu->smb_buf_length);
-	MD5Final(signature,&context);
+	sg[0].page = virt_to_page(key);
+	sg[0].offset = offset_in_page(key);
+	sg[0].length = CIFS_SESSION_KEY_SIZE+16;
+	sg[1].page = virt_to_page(cifs_pdu->Protocol);
+	sg[1].offset = offset_in_page(cifs_pdu->Protocol);
+	sg[1].length = cifs_pdu->smb_buf_length;
+
+	spin_lock(&md5_tfm_lock);
+	crypto_digest_init(md5_tfm);
+	crypto_digest_update(md5_tfm, sg, 2);
+	crypto_digest_final(md5_tfm, signature);
+	spin_unlock(&md5_tfm_lock);
+
 	return 0;
 }
 
@@ -136,29 +149,42 @@
 int cifs_calculate_mac_key(char * key, const char * rn, const char * password)
 {
 	char temp_key[16];
+	struct scatterlist sg;
+
 	if ((key == NULL) || (rn == NULL) || (password == NULL))
 		return -EINVAL;
 
+	sg.page = virt_to_page(temp_key);
+	sg.offset = offset_in_page(temp_key);
+	sg.length = 16;
+
 	E_md4hash(password, temp_key);
-	mdfour(key,temp_key,16);
+
+	spin_lock(&md4_tfm_lock);
+	crypto_digest_init(md4_tfm);
+	crypto_digest_update(md4_tfm, &sg, 1);
+	crypto_digest_final(md4_tfm, key);
+	spin_unlock(&md4_tfm_lock);
 	memcpy(key+16,rn, CIFS_SESSION_KEY_SIZE);
+
 	return 0;
 }
 
 int CalcNTLMv2_partial_mac_key(struct cifsSesInfo * ses, struct nls_table * nls_info)
 {
 	char temp_hash[16];
-	struct HMACMD5Context ctx;
 	char * ucase_buf;
 	wchar_t * unicode_buf;
 	unsigned int i,user_name_len,dom_name_len;
+	u8 ipad[65], opad[65];
+	struct scatterlist sg[2];
 
 	if(ses)
 		return -EINVAL;
 
 	E_md4hash(ses->password_with_pad, temp_hash);
 
-	hmac_md5_init_limK_to_64(temp_hash, 16, &ctx);
+	SMBencrypt_prepare_keypads(ipad, opad, temp_hash, 16);
 	user_name_len = strlen(ses->userName);
 	if(user_name_len > MAX_USERNAME_SIZE)
 		return -EINVAL;
@@ -183,24 +209,49 @@
         dom_name_len = cifs_strtoUCS(unicode_buf+user_name_len, ucase_buf, MAX_USERNAME_SIZE*2, nls_info);
 
 	unicode_buf[user_name_len + dom_name_len] = 0;
-	hmac_md5_update((const unsigned char *) unicode_buf,
-		(user_name_len+dom_name_len)*2,&ctx);
 
-	hmac_md5_final(ses->mac_signing_key,&ctx);
+	sg[0].page = virt_to_page(ipad);
+	sg[0].offset = offset_in_page(ipad);
+	sg[0].length = 64;
+	sg[1].page = virt_to_page(unicode_buf);
+	sg[1].offset = offset_in_page(unicode_buf);
+	sg[1].length = (user_name_len+dom_name_len)*2;
+
+	spin_lock(&md5_tfm_lock);
+	crypto_digest_init(md5_tfm);
+	crypto_digest_update(md5_tfm, sg, 2);
+	crypto_digest_final(md5_tfm, ses->mac_signing_key);
+	spin_unlock(&md5_tfm_lock);
+
+	SMBencrypt_update_with_opad(opad, ses->mac_signing_key);
+
 	kfree(ucase_buf);
 	kfree(unicode_buf);
 	return 0;
 }
 void CalcNTLMv2_response(const struct cifsSesInfo * ses,char * v2_session_response)
 {
-	struct HMACMD5Context context;
+	u8 ipad[65], opad[65];
+	struct scatterlist sg[2];
+
 	memcpy(v2_session_response + 8, ses->server->cryptKey,8);
 	/* gen_blob(v2_session_response + 16); */
-	hmac_md5_init_limK_to_64(ses->mac_signing_key, 16, &context);
 
-	hmac_md5_update(ses->server->cryptKey,8,&context);
+	SMBencrypt_prepare_keypads(ipad, opad, ses->mac_signing_key, 16);
+
+	sg[0].page = virt_to_page(ipad);
+	sg[0].offset = offset_in_page(ipad);
+	sg[0].length = 64;
+	sg[1].page = virt_to_page(ses->server->cryptKey);
+	sg[1].offset = offset_in_page(ses->server->cryptKey);
+	sg[1].length = 8;
 /*	hmac_md5_update(v2_session_response+16)client thing,8,&context); */ /* BB fix */
 
+	spin_lock(&md5_tfm_lock);
+	crypto_digest_init(md5_tfm);
+	crypto_digest_update(md5_tfm, sg, 2);
+	crypto_digest_final(md5_tfm, v2_session_response);
+	spin_unlock(&md5_tfm_lock);
 
-	hmac_md5_final(v2_session_response,&context);
+	SMBencrypt_update_with_opad(opad, v2_session_response);
 }
diff -urN linux-2.6.0-test6-bk2/fs/cifs/cifsencrypt.h linux-2.6.0-test6-bk2-dirty/fs/cifs/cifsencrypt.h
--- linux-2.6.0-test6-bk2/fs/cifs/cifsencrypt.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.0-test6-bk2-dirty/fs/cifs/cifsencrypt.h	Wed Oct  1 10:35:24 2003
@@ -0,0 +1,18 @@
+#ifndef CIFSENCRYPT_H
+#define CIFSENCRYPT_H
+
+#include <linux/crypto.h>
+#include <linux/spinlock.h>
+#include <asm/types.h>
+
+extern struct crypto_tfm *md5_tfm;
+extern struct crypto_tfm *md4_tfm;
+extern spinlock_t md5_tfm_lock;
+extern spinlock_t md4_tfm_lock;
+
+void E_md4hash(const unsigned char *passwd, unsigned char *p16);
+
+extern void SMBencrypt_prepare_keypads(u8 *ipad, u8 *opad, const u8 *key, int len);
+extern void SMBencrypt_update_with_opad(u8 *pad, u8 *digest);
+
+#endif
diff -urN linux-2.6.0-test6-bk2/fs/cifs/cifsfs.c linux-2.6.0-test6-bk2-dirty/fs/cifs/cifsfs.c
--- linux-2.6.0-test6-bk2/fs/cifs/cifsfs.c	Sun Sep 28 02:50:25 2003
+++ linux-2.6.0-test6-bk2-dirty/fs/cifs/cifsfs.c	Wed Oct  1 10:35:24 2003
@@ -31,6 +31,8 @@
 #include <linux/list.h>
 #include <linux/seq_file.h>
 #include <linux/vfs.h>
+#include <linux/crypto.h>
+#include "cifsencrypt.h"
 #include "cifsfs.h"
 #include "cifspdu.h"
 #define DECLARE_GLOBALS_HERE
@@ -644,6 +646,18 @@
 
 	rc = cifs_init_inodecache();
 	if (!rc) {
+		md5_tfm = crypto_alloc_tfm("md5", 0);
+		if (unlikely(md5_tfm == NULL)) {
+			printk(KERN_ERR "failed to load transform for md5\n");
+			rc = 0;
+		}
+		md4_tfm = crypto_alloc_tfm("md4", 0);
+		if (unlikely(md4_tfm == NULL)) {
+			printk(KERN_ERR "failed to load transform for md4\n");
+			rc = 0;
+		}
+	}
+	if (!rc) {
 		rc = cifs_init_mids();
 		if (!rc) {
 			rc = cifs_init_request_bufs();
@@ -660,6 +674,7 @@
 		}
 		cifs_destroy_inodecache();
 	}
+
 #ifdef CONFIG_PROC_FS
 	cifs_proc_clean();
 #endif
@@ -680,6 +695,14 @@
 	if(oplockThread) {
 		send_sig(SIGTERM, oplockThread, 1);
 		wait_for_completion(&cifs_oplock_exited);
+	}
+	if (likely(md5_tfm != NULL)) {
+		crypto_free_tfm(md5_tfm);
+		md5_tfm = NULL;
+	}
+	if (likely(md4_tfm != NULL)) {
+		crypto_free_tfm(md4_tfm);
+		md4_tfm = NULL;
 	}
 }
 
diff -urN linux-2.6.0-test6-bk2/fs/cifs/smbencrypt.c linux-2.6.0-test6-bk2-dirty/fs/cifs/smbencrypt.c
--- linux-2.6.0-test6-bk2/fs/cifs/smbencrypt.c	Sun Sep 28 02:50:20 2003
+++ linux-2.6.0-test6-bk2-dirty/fs/cifs/smbencrypt.c	Wed Oct  1 10:35:24 2003
@@ -30,10 +30,12 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/random.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
 #include "cifs_unicode.h"
 #include "cifspdu.h"
-#include "md5.h"
 #include "cifs_debug.h"
+#include "cifsencrypt.h"
 
 #ifndef FALSE
 #define FALSE 0
@@ -49,10 +51,6 @@
 #define SSVAL(buf,pos,val) SSVALX((buf),(pos),((__u16)(val)))
 #define SIVAL(buf,pos,val) SIVALX((buf),(pos),((__u32)(val)))
 
-/*The following definitions come from  lib/md4.c  */
-
-void mdfour(unsigned char *out, unsigned char *in, int n);
-
 /*The following definitions come from  libsmb/smbdes.c  */
 
 void E_P16(unsigned char *p14, unsigned char *p16);
@@ -68,7 +66,6 @@
 /*The following definitions come from  libsmb/smbencrypt.c  */
 
 void SMBencrypt(unsigned char *passwd, unsigned char *c8, unsigned char *p24);
-void E_md4hash(const unsigned char *passwd, unsigned char *p16);
 void nt_lm_owf_gen(char *pwd, unsigned char nt_p16[16], unsigned char p16[16]);
 void SMBOWFencrypt(unsigned char passwd[16], unsigned char *c8,
 		   unsigned char p24[24]);
@@ -109,6 +106,46 @@
 	memset(p21,0,21);
 }
 
+void
+SMBencrypt_prepare_keypads(u8 *ipad, u8 *opad, const u8 *key, int len)
+{
+	int i;
+
+	/* if key is longer than 64 bytes, truncate it */
+	len &= 0x3f;
+
+	/* start out by storing key in pads */
+	memset(ipad, 0, 64);
+	memset(opad, 0, 64);
+	memcpy(ipad, key, len);
+	memcpy(opad, key, len);
+
+	/* XOR key with ipad and opad values */
+	for (i = 0; i < 64; i++) {
+		ipad[i] ^= 0x36;
+		opad[i] ^= 0x5c;
+	}
+}
+
+void
+SMBencrypt_update_with_opad(u8 *pad, u8 *digest)
+{
+	struct scatterlist sg[2];
+
+	sg[0].page = virt_to_page(pad);
+	sg[0].offset = offset_in_page(pad);
+	sg[0].length = 64;
+	sg[1].page = virt_to_page(digest);
+	sg[1].offset = offset_in_page(digest);
+	sg[1].length = 16;
+    
+	spin_lock(&md5_tfm_lock);
+	crypto_digest_init(md5_tfm);
+	crypto_digest_update(md5_tfm, sg, 2);
+	crypto_digest_final(md5_tfm, digest);
+	spin_unlock(&md5_tfm_lock);
+}
+	
 /* Routines for Windows NT MD4 Hash functions. */
 static int
 _my_wcslen(__u16 * str)
@@ -152,6 +189,7 @@
 {
 	int len;
 	__u16 wpwd[129];
+	struct scatterlist sg;
 
 	/* Password cannot be longer than 128 characters */
 	len = strlen((char *) passwd);
@@ -163,7 +201,15 @@
 	/* Calculate length in bytes */
 	len = _my_wcslen(wpwd) * sizeof (__u16);
 
-	mdfour(p16, (unsigned char *) wpwd, len);
+	sg.page = virt_to_page(wpwd);
+	sg.offset = offset_in_page(wpwd);
+	sg.length = len;
+
+	spin_lock(&md4_tfm_lock);
+	crypto_digest_init(md4_tfm);
+	crypto_digest_update(md4_tfm, &sg, 1);
+	crypto_digest_final(md4_tfm, p16);
+	spin_unlock(&md4_tfm_lock);
 	memset(wpwd,0,129 * 2);
 }
 
@@ -212,17 +258,18 @@
 		const char *domain_n, unsigned char kr_buf[16],
 		const struct nls_table *nls_codepage)
 {
+	struct scatterlist sg[3];
 	wchar_t * user_u;
 	wchar_t * dom_u;
 	int user_l, domain_l;
-	struct HMACMD5Context ctx;
+	u8 ipad[65], opad[65];
 
 	/* might as well do one alloc to hold both (user_u and dom_u) */
 	user_u = kmalloc(2048 * sizeof(wchar_t),GFP_KERNEL); 
 	if(user_u == NULL)
 		return;
 	dom_u = user_u + 1024;
-    
+
 	/* push_ucs2(NULL, user_u, user_n, (user_l+1)*2, STR_UNICODE|STR_NOALIGN|STR_TERMINATE|STR_UPPER);
 	   push_ucs2(NULL, dom_u, domain_n, (domain_l+1)*2, STR_UNICODE|STR_NOALIGN|STR_TERMINATE|STR_UPPER); */
 
@@ -233,10 +280,25 @@
 	user_l++;		/* trailing null */
 	domain_l++;
 
-	hmac_md5_init_limK_to_64(owf, 16, &ctx);
-	hmac_md5_update((const unsigned char *) user_u, user_l * 2, &ctx);
-	hmac_md5_update((const unsigned char *) dom_u, domain_l * 2, &ctx);
-	hmac_md5_final(kr_buf, &ctx);
+	SMBencrypt_prepare_keypads(ipad, opad, owf, 16);
+
+	sg[0].page = virt_to_page(ipad);
+	sg[0].offset = offset_in_page(ipad);
+	sg[0].length = 64;
+	sg[1].page = virt_to_page(user_u);
+	sg[1].offset = offset_in_page(user_u);
+	sg[1].length = user_l;
+	sg[2].page = virt_to_page(dom_u);
+	sg[2].offset = offset_in_page(dom_u);
+	sg[2].length = domain_l;
+    
+	spin_lock(&md5_tfm_lock);
+	crypto_digest_init(md5_tfm);
+	crypto_digest_update(md5_tfm, sg, 3);
+	crypto_digest_final(md5_tfm, kr_buf);
+	spin_unlock(&md5_tfm_lock);
+
+	SMBencrypt_update_with_opad(opad, kr_buf);
 
 #ifdef DEBUG_PASSWORD
 	DEBUG(100, ("ntv2_owf_gen: user, domain, owfkey, kr\n"));
@@ -307,12 +369,28 @@
                    const struct data_blob * srv_chal,
                    const struct data_blob * cli_chal, unsigned char resp_buf[16])
 {
-        struct HMACMD5Context ctx;
+        struct scatterlist sg[3];
+	u8 ipad[65], opad[65];
+
+	SMBencrypt_prepare_keypads(ipad, opad, kr, 16);
+
+	sg[0].page = virt_to_page(ipad);
+	sg[0].offset = offset_in_page(ipad);
+	sg[0].length = 64;
+	sg[1].page = virt_to_page(srv_chal->data);
+	sg[1].offset = offset_in_page(srv_chal->data);
+	sg[1].length = srv_chal->length;
+	sg[2].page = virt_to_page(cli_chal->data);
+	sg[2].offset = offset_in_page(cli_chal->data);
+	sg[2].length = cli_chal->length;
+
+	spin_lock(&md5_tfm_lock);
+        crypto_digest_init(md5_tfm);
+	crypto_digest_update(md5_tfm, sg, 3);
+	crypto_digest_final(md5_tfm, resp_buf);
+	spin_unlock(&md5_tfm_lock);
 
-        hmac_md5_init_limK_to_64(kr, 16, &ctx);
-        hmac_md5_update(srv_chal->data, srv_chal->length, &ctx);
-        hmac_md5_update(cli_chal->data, cli_chal->length, &ctx);
-        hmac_md5_final(resp_buf, &ctx);
+	SMBencrypt_update_with_opad(opad, resp_buf);
 
 #ifdef DEBUG_PASSWORD
         DEBUG(100, ("SMBOWFencrypt_ntv2: srv_chal, cli_chal, resp_buf\n"));
@@ -390,11 +468,25 @@
 SMBsesskeygen_ntv2(const unsigned char kr[16],
 		   const unsigned char *nt_resp, __u8 sess_key[16])
 {
-	struct HMACMD5Context ctx;
+	struct scatterlist sg[2];
+	u8 ipad[65], opad[65];
 
-	hmac_md5_init_limK_to_64(kr, 16, &ctx);
-	hmac_md5_update(nt_resp, 16, &ctx);
-	hmac_md5_final((unsigned char *) sess_key, &ctx);
+	SMBencrypt_prepare_keypads(ipad, opad, kr, 16);
+
+	sg[0].page = virt_to_page(ipad);
+	sg[0].offset = offset_in_page(ipad);
+	sg[0].length = 64;
+	sg[1].page = virt_to_page(nt_resp);
+	sg[1].offset = offset_in_page(nt_resp);
+	sg[1].length = 16;
+
+	spin_lock(&md5_tfm_lock);
+	crypto_digest_init(md5_tfm);
+	crypto_digest_update(md5_tfm, sg, 2);
+	crypto_digest_final(md5_tfm, sess_key);
+	spin_unlock(&md5_tfm_lock);
+
+	SMBencrypt_update_with_opad(opad, sess_key);
 
 #ifdef DEBUG_PASSWORD
 	DEBUG(100, ("SMBsesskeygen_ntv2:\n"));
@@ -406,7 +498,17 @@
 SMBsesskeygen_ntv1(const unsigned char kr[16],
 		   const unsigned char *nt_resp, __u8 sess_key[16])
 {
-	mdfour((unsigned char *) sess_key, (unsigned char *) kr, 16);
+	struct scatterlist sg;
+
+	sg.page = virt_to_page(kr);
+	sg.offset = offset_in_page(kr);
+	sg.length = 16;
+
+	spin_lock(&md4_tfm_lock);
+	crypto_digest_init(md4_tfm);
+	crypto_digest_update(md4_tfm, &sg, 1);
+	crypto_digest_final(md4_tfm, sess_key);
+	spin_unlock(&md4_tfm_lock);
 
 #ifdef DEBUG_PASSWORD
 	DEBUG(100, ("SMBsesskeygen_ntv1:\n"));

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cifs-remove-old-md5.patch"

diff -urN linux-2.6.0-test6-bk2/fs/cifs/Makefile linux-2.6.0-test6-bk2-dirty/fs/cifs/Makefile
--- linux-2.6.0-test6-bk2/fs/cifs/Makefile	Sun Sep 28 02:50:13 2003
+++ linux-2.6.0-test6-bk2-dirty/fs/cifs/Makefile	Wed Oct  1 10:29:55 2003
@@ -3,4 +3,4 @@
 #
 obj-$(CONFIG_CIFS) += cifs.o
 
-cifs-objs := cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o inode.o link.o misc.o netmisc.o smbdes.o smbencrypt.o transport.o asn1.o md4.o md5.o cifs_unicode.o nterr.o xattr.o cifsencrypt.o
+cifs-objs := cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o inode.o link.o misc.o netmisc.o smbdes.o smbencrypt.o transport.o asn1.o cifs_unicode.o nterr.o xattr.o cifsencrypt.o
diff -urN linux-2.6.0-test6-bk2/fs/cifs/md4.c linux-2.6.0-test6-bk2-dirty/fs/cifs/md4.c
--- linux-2.6.0-test6-bk2/fs/cifs/md4.c	Sun Sep 28 02:50:38 2003
+++ linux-2.6.0-test6-bk2-dirty/fs/cifs/md4.c	Thu Jan  1 01:00:00 1970
@@ -1,209 +0,0 @@
-/* 
-   Unix SMB/Netbios implementation.
-   Version 1.9.
-   a implementation of MD4 designed for use in the SMB authentication protocol
-   Copyright (C) Andrew Tridgell 1997-1998.
-   Modified by Steve French (sfrench@us.ibm.com) 2002
-   
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-   
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-   
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-#include <linux/module.h>
-#include <linux/fs.h>
-
-/* NOTE: This code makes no attempt to be fast! 
-
-   It assumes that a int is at least 32 bits long
-*/
-
-static __u32 A, B, C, D;
-
-static __u32
-F(__u32 X, __u32 Y, __u32 Z)
-{
-	return (X & Y) | ((~X) & Z);
-}
-
-static __u32
-G(__u32 X, __u32 Y, __u32 Z)
-{
-	return (X & Y) | (X & Z) | (Y & Z);
-}
-
-static __u32
-H(__u32 X, __u32 Y, __u32 Z)
-{
-	return X ^ Y ^ Z;
-}
-
-static __u32
-lshift(__u32 x, int s)
-{
-	x &= 0xFFFFFFFF;
-	return ((x << s) & 0xFFFFFFFF) | (x >> (32 - s));
-}
-
-#define ROUND1(a,b,c,d,k,s) a = lshift(a + F(b,c,d) + X[k], s)
-#define ROUND2(a,b,c,d,k,s) a = lshift(a + G(b,c,d) + X[k] + (__u32)0x5A827999,s)
-#define ROUND3(a,b,c,d,k,s) a = lshift(a + H(b,c,d) + X[k] + (__u32)0x6ED9EBA1,s)
-
-/* this applies md4 to 64 byte chunks */
-static void
-mdfour64(__u32 * M)
-{
-	int j;
-	__u32 AA, BB, CC, DD;
-	__u32 X[16];
-
-	for (j = 0; j < 16; j++)
-		X[j] = M[j];
-
-	AA = A;
-	BB = B;
-	CC = C;
-	DD = D;
-
-	ROUND1(A, B, C, D, 0, 3);
-	ROUND1(D, A, B, C, 1, 7);
-	ROUND1(C, D, A, B, 2, 11);
-	ROUND1(B, C, D, A, 3, 19);
-	ROUND1(A, B, C, D, 4, 3);
-	ROUND1(D, A, B, C, 5, 7);
-	ROUND1(C, D, A, B, 6, 11);
-	ROUND1(B, C, D, A, 7, 19);
-	ROUND1(A, B, C, D, 8, 3);
-	ROUND1(D, A, B, C, 9, 7);
-	ROUND1(C, D, A, B, 10, 11);
-	ROUND1(B, C, D, A, 11, 19);
-	ROUND1(A, B, C, D, 12, 3);
-	ROUND1(D, A, B, C, 13, 7);
-	ROUND1(C, D, A, B, 14, 11);
-	ROUND1(B, C, D, A, 15, 19);
-
-	ROUND2(A, B, C, D, 0, 3);
-	ROUND2(D, A, B, C, 4, 5);
-	ROUND2(C, D, A, B, 8, 9);
-	ROUND2(B, C, D, A, 12, 13);
-	ROUND2(A, B, C, D, 1, 3);
-	ROUND2(D, A, B, C, 5, 5);
-	ROUND2(C, D, A, B, 9, 9);
-	ROUND2(B, C, D, A, 13, 13);
-	ROUND2(A, B, C, D, 2, 3);
-	ROUND2(D, A, B, C, 6, 5);
-	ROUND2(C, D, A, B, 10, 9);
-	ROUND2(B, C, D, A, 14, 13);
-	ROUND2(A, B, C, D, 3, 3);
-	ROUND2(D, A, B, C, 7, 5);
-	ROUND2(C, D, A, B, 11, 9);
-	ROUND2(B, C, D, A, 15, 13);
-
-	ROUND3(A, B, C, D, 0, 3);
-	ROUND3(D, A, B, C, 8, 9);
-	ROUND3(C, D, A, B, 4, 11);
-	ROUND3(B, C, D, A, 12, 15);
-	ROUND3(A, B, C, D, 2, 3);
-	ROUND3(D, A, B, C, 10, 9);
-	ROUND3(C, D, A, B, 6, 11);
-	ROUND3(B, C, D, A, 14, 15);
-	ROUND3(A, B, C, D, 1, 3);
-	ROUND3(D, A, B, C, 9, 9);
-	ROUND3(C, D, A, B, 5, 11);
-	ROUND3(B, C, D, A, 13, 15);
-	ROUND3(A, B, C, D, 3, 3);
-	ROUND3(D, A, B, C, 11, 9);
-	ROUND3(C, D, A, B, 7, 11);
-	ROUND3(B, C, D, A, 15, 15);
-
-	A += AA;
-	B += BB;
-	C += CC;
-	D += DD;
-
-	A &= 0xFFFFFFFF;
-	B &= 0xFFFFFFFF;
-	C &= 0xFFFFFFFF;
-	D &= 0xFFFFFFFF;
-
-	for (j = 0; j < 16; j++)
-		X[j] = 0;
-}
-
-static void
-copy64(__u32 * M, unsigned char *in)
-{
-	int i;
-
-	for (i = 0; i < 16; i++)
-		M[i] = (in[i * 4 + 3] << 24) | (in[i * 4 + 2] << 16) |
-		    (in[i * 4 + 1] << 8) | (in[i * 4 + 0] << 0);
-}
-
-static void
-copy4(unsigned char *out, __u32 x)
-{
-	out[0] = x & 0xFF;
-	out[1] = (x >> 8) & 0xFF;
-	out[2] = (x >> 16) & 0xFF;
-	out[3] = (x >> 24) & 0xFF;
-}
-
-/* produce a md4 message digest from data of length n bytes */
-void
-mdfour(unsigned char *out, unsigned char *in, int n)
-{
-	unsigned char buf[128];
-	__u32 M[16];
-	__u32 b = n * 8;
-	int i;
-
-	A = 0x67452301;
-	B = 0xefcdab89;
-	C = 0x98badcfe;
-	D = 0x10325476;
-
-	while (n > 64) {
-		copy64(M, in);
-		mdfour64(M);
-		in += 64;
-		n -= 64;
-	}
-
-	for (i = 0; i < 128; i++)
-		buf[i] = 0;
-	memcpy(buf, in, n);
-	buf[n] = 0x80;
-
-	if (n <= 55) {
-		copy4(buf + 56, b);
-		copy64(M, buf);
-		mdfour64(M);
-	} else {
-		copy4(buf + 120, b);
-		copy64(M, buf);
-		mdfour64(M);
-		copy64(M, buf + 64);
-		mdfour64(M);
-	}
-
-	for (i = 0; i < 128; i++)
-		buf[i] = 0;
-	copy64(M, buf);
-
-	copy4(out, A);
-	copy4(out + 4, B);
-	copy4(out + 8, C);
-	copy4(out + 12, D);
-
-	A = B = C = D = 0;
-}
diff -urN linux-2.6.0-test6-bk2/fs/cifs/md5.c linux-2.6.0-test6-bk2-dirty/fs/cifs/md5.c
--- linux-2.6.0-test6-bk2/fs/cifs/md5.c	Sun Sep 28 02:50:31 2003
+++ linux-2.6.0-test6-bk2-dirty/fs/cifs/md5.c	Thu Jan  1 01:00:00 1970
@@ -1,363 +0,0 @@
-/*
- * This code implements the MD5 message-digest algorithm.
- * The algorithm is due to Ron Rivest.  This code was
- * written by Colin Plumb in 1993, no copyright is claimed.
- * This code is in the public domain; do with it what you wish.
- *
- * Equivalent code is available from RSA Data Security, Inc.
- * This code has been tested against that, and is equivalent,
- * except that you don't need to include two pages of legalese
- * with every copy.
- *
- * To compute the message digest of a chunk of bytes, declare an
- * MD5Context structure, pass it to MD5Init, call MD5Update as
- * needed on buffers full of bytes, and then call MD5Final, which
- * will fill a supplied 16-byte array with the digest.
- */
-
-/* This code slightly modified to fit into Samba by 
-   abartlet@samba.org Jun 2001 
-   and to fit the cifs vfs by 
-   Steve French sfrench@us.ibm.com */
-
-#include <linux/string.h>
-#include "md5.h"
-
-static void MD5Transform(__u32 buf[4], __u32 const in[16]);
-
-/*
- * Note: this code is harmless on little-endian machines.
- */
-static void
-byteReverse(unsigned char *buf, unsigned longs)
-{
-	__u32 t;
-	do {
-		t = (__u32) ((unsigned) buf[3] << 8 | buf[2]) << 16 |
-		    ((unsigned) buf[1] << 8 | buf[0]);
-		*(__u32 *) buf = t;
-		buf += 4;
-	} while (--longs);
-}
-
-/*
- * Start MD5 accumulation.  Set bit count to 0 and buffer to mysterious
- * initialization constants.
- */
-void
-MD5Init(struct MD5Context *ctx)
-{
-	ctx->buf[0] = 0x67452301;
-	ctx->buf[1] = 0xefcdab89;
-	ctx->buf[2] = 0x98badcfe;
-	ctx->buf[3] = 0x10325476;
-
-	ctx->bits[0] = 0;
-	ctx->bits[1] = 0;
-}
-
-/*
- * Update context to reflect the concatenation of another buffer full
- * of bytes.
- */
-void
-MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
-{
-	register __u32 t;
-
-	/* Update bitcount */
-
-	t = ctx->bits[0];
-	if ((ctx->bits[0] = t + ((__u32) len << 3)) < t)
-		ctx->bits[1]++;	/* Carry from low to high */
-	ctx->bits[1] += len >> 29;
-
-	t = (t >> 3) & 0x3f;	/* Bytes already in shsInfo->data */
-
-	/* Handle any leading odd-sized chunks */
-
-	if (t) {
-		unsigned char *p = (unsigned char *) ctx->in + t;
-
-		t = 64 - t;
-		if (len < t) {
-			memmove(p, buf, len);
-			return;
-		}
-		memmove(p, buf, t);
-		byteReverse(ctx->in, 16);
-		MD5Transform(ctx->buf, (__u32 *) ctx->in);
-		buf += t;
-		len -= t;
-	}
-	/* Process data in 64-byte chunks */
-
-	while (len >= 64) {
-		memmove(ctx->in, buf, 64);
-		byteReverse(ctx->in, 16);
-		MD5Transform(ctx->buf, (__u32 *) ctx->in);
-		buf += 64;
-		len -= 64;
-	}
-
-	/* Handle any remaining bytes of data. */
-
-	memmove(ctx->in, buf, len);
-}
-
-/*
- * Final wrapup - pad to 64-byte boundary with the bit pattern 
- * 1 0* (64-bit count of bits processed, MSB-first)
- */
-void
-MD5Final(unsigned char digest[16], struct MD5Context *ctx)
-{
-	unsigned int count;
-	unsigned char *p;
-
-	/* Compute number of bytes mod 64 */
-	count = (ctx->bits[0] >> 3) & 0x3F;
-
-	/* Set the first char of padding to 0x80.  This is safe since there is
-	   always at least one byte free */
-	p = ctx->in + count;
-	*p++ = 0x80;
-
-	/* Bytes of padding needed to make 64 bytes */
-	count = 64 - 1 - count;
-
-	/* Pad out to 56 mod 64 */
-	if (count < 8) {
-		/* Two lots of padding:  Pad the first block to 64 bytes */
-		memset(p, 0, count);
-		byteReverse(ctx->in, 16);
-		MD5Transform(ctx->buf, (__u32 *) ctx->in);
-
-		/* Now fill the next block with 56 bytes */
-		memset(ctx->in, 0, 56);
-	} else {
-		/* Pad block to 56 bytes */
-		memset(p, 0, count - 8);
-	}
-	byteReverse(ctx->in, 14);
-
-	/* Append length in bits and transform */
-	((__u32 *) ctx->in)[14] = ctx->bits[0];
-	((__u32 *) ctx->in)[15] = ctx->bits[1];
-
-	MD5Transform(ctx->buf, (__u32 *) ctx->in);
-	byteReverse((unsigned char *) ctx->buf, 4);
-	memmove(digest, ctx->buf, 16);
-	memset(ctx, 0, sizeof(*ctx));	/* In case it's sensitive */
-}
-
-/* The four core functions - F1 is optimized somewhat */
-
-/* #define F1(x, y, z) (x & y | ~x & z) */
-#define F1(x, y, z) (z ^ (x & (y ^ z)))
-#define F2(x, y, z) F1(z, x, y)
-#define F3(x, y, z) (x ^ y ^ z)
-#define F4(x, y, z) (y ^ (x | ~z))
-
-/* This is the central step in the MD5 algorithm. */
-#define MD5STEP(f, w, x, y, z, data, s) \
-	( w += f(x, y, z) + data,  w = w<<s | w>>(32-s),  w += x )
-
-/*
- * The core of the MD5 algorithm, this alters an existing MD5 hash to
- * reflect the addition of 16 longwords of new data.  MD5Update blocks
- * the data and converts bytes into longwords for this routine.
- */
-static void
-MD5Transform(__u32 buf[4], __u32 const in[16])
-{
-	register __u32 a, b, c, d;
-
-	a = buf[0];
-	b = buf[1];
-	c = buf[2];
-	d = buf[3];
-
-	MD5STEP(F1, a, b, c, d, in[0] + 0xd76aa478, 7);
-	MD5STEP(F1, d, a, b, c, in[1] + 0xe8c7b756, 12);
-	MD5STEP(F1, c, d, a, b, in[2] + 0x242070db, 17);
-	MD5STEP(F1, b, c, d, a, in[3] + 0xc1bdceee, 22);
-	MD5STEP(F1, a, b, c, d, in[4] + 0xf57c0faf, 7);
-	MD5STEP(F1, d, a, b, c, in[5] + 0x4787c62a, 12);
-	MD5STEP(F1, c, d, a, b, in[6] + 0xa8304613, 17);
-	MD5STEP(F1, b, c, d, a, in[7] + 0xfd469501, 22);
-	MD5STEP(F1, a, b, c, d, in[8] + 0x698098d8, 7);
-	MD5STEP(F1, d, a, b, c, in[9] + 0x8b44f7af, 12);
-	MD5STEP(F1, c, d, a, b, in[10] + 0xffff5bb1, 17);
-	MD5STEP(F1, b, c, d, a, in[11] + 0x895cd7be, 22);
-	MD5STEP(F1, a, b, c, d, in[12] + 0x6b901122, 7);
-	MD5STEP(F1, d, a, b, c, in[13] + 0xfd987193, 12);
-	MD5STEP(F1, c, d, a, b, in[14] + 0xa679438e, 17);
-	MD5STEP(F1, b, c, d, a, in[15] + 0x49b40821, 22);
-
-	MD5STEP(F2, a, b, c, d, in[1] + 0xf61e2562, 5);
-	MD5STEP(F2, d, a, b, c, in[6] + 0xc040b340, 9);
-	MD5STEP(F2, c, d, a, b, in[11] + 0x265e5a51, 14);
-	MD5STEP(F2, b, c, d, a, in[0] + 0xe9b6c7aa, 20);
-	MD5STEP(F2, a, b, c, d, in[5] + 0xd62f105d, 5);
-	MD5STEP(F2, d, a, b, c, in[10] + 0x02441453, 9);
-	MD5STEP(F2, c, d, a, b, in[15] + 0xd8a1e681, 14);
-	MD5STEP(F2, b, c, d, a, in[4] + 0xe7d3fbc8, 20);
-	MD5STEP(F2, a, b, c, d, in[9] + 0x21e1cde6, 5);
-	MD5STEP(F2, d, a, b, c, in[14] + 0xc33707d6, 9);
-	MD5STEP(F2, c, d, a, b, in[3] + 0xf4d50d87, 14);
-	MD5STEP(F2, b, c, d, a, in[8] + 0x455a14ed, 20);
-	MD5STEP(F2, a, b, c, d, in[13] + 0xa9e3e905, 5);
-	MD5STEP(F2, d, a, b, c, in[2] + 0xfcefa3f8, 9);
-	MD5STEP(F2, c, d, a, b, in[7] + 0x676f02d9, 14);
-	MD5STEP(F2, b, c, d, a, in[12] + 0x8d2a4c8a, 20);
-
-	MD5STEP(F3, a, b, c, d, in[5] + 0xfffa3942, 4);
-	MD5STEP(F3, d, a, b, c, in[8] + 0x8771f681, 11);
-	MD5STEP(F3, c, d, a, b, in[11] + 0x6d9d6122, 16);
-	MD5STEP(F3, b, c, d, a, in[14] + 0xfde5380c, 23);
-	MD5STEP(F3, a, b, c, d, in[1] + 0xa4beea44, 4);
-	MD5STEP(F3, d, a, b, c, in[4] + 0x4bdecfa9, 11);
-	MD5STEP(F3, c, d, a, b, in[7] + 0xf6bb4b60, 16);
-	MD5STEP(F3, b, c, d, a, in[10] + 0xbebfbc70, 23);
-	MD5STEP(F3, a, b, c, d, in[13] + 0x289b7ec6, 4);
-	MD5STEP(F3, d, a, b, c, in[0] + 0xeaa127fa, 11);
-	MD5STEP(F3, c, d, a, b, in[3] + 0xd4ef3085, 16);
-	MD5STEP(F3, b, c, d, a, in[6] + 0x04881d05, 23);
-	MD5STEP(F3, a, b, c, d, in[9] + 0xd9d4d039, 4);
-	MD5STEP(F3, d, a, b, c, in[12] + 0xe6db99e5, 11);
-	MD5STEP(F3, c, d, a, b, in[15] + 0x1fa27cf8, 16);
-	MD5STEP(F3, b, c, d, a, in[2] + 0xc4ac5665, 23);
-
-	MD5STEP(F4, a, b, c, d, in[0] + 0xf4292244, 6);
-	MD5STEP(F4, d, a, b, c, in[7] + 0x432aff97, 10);
-	MD5STEP(F4, c, d, a, b, in[14] + 0xab9423a7, 15);
-	MD5STEP(F4, b, c, d, a, in[5] + 0xfc93a039, 21);
-	MD5STEP(F4, a, b, c, d, in[12] + 0x655b59c3, 6);
-	MD5STEP(F4, d, a, b, c, in[3] + 0x8f0ccc92, 10);
-	MD5STEP(F4, c, d, a, b, in[10] + 0xffeff47d, 15);
-	MD5STEP(F4, b, c, d, a, in[1] + 0x85845dd1, 21);
-	MD5STEP(F4, a, b, c, d, in[8] + 0x6fa87e4f, 6);
-	MD5STEP(F4, d, a, b, c, in[15] + 0xfe2ce6e0, 10);
-	MD5STEP(F4, c, d, a, b, in[6] + 0xa3014314, 15);
-	MD5STEP(F4, b, c, d, a, in[13] + 0x4e0811a1, 21);
-	MD5STEP(F4, a, b, c, d, in[4] + 0xf7537e82, 6);
-	MD5STEP(F4, d, a, b, c, in[11] + 0xbd3af235, 10);
-	MD5STEP(F4, c, d, a, b, in[2] + 0x2ad7d2bb, 15);
-	MD5STEP(F4, b, c, d, a, in[9] + 0xeb86d391, 21);
-
-	buf[0] += a;
-	buf[1] += b;
-	buf[2] += c;
-	buf[3] += d;
-}
-
-/***********************************************************************
- the rfc 2104 version of hmac_md5 initialisation.
-***********************************************************************/
-void
-hmac_md5_init_rfc2104(unsigned char *key, int key_len,
-		      struct HMACMD5Context *ctx)
-{
-	int i;
-
-	/* if key is longer than 64 bytes reset it to key=MD5(key) */
-	if (key_len > 64) {
-		unsigned char tk[16];
-		struct MD5Context tctx;
-
-		MD5Init(&tctx);
-		MD5Update(&tctx, key, key_len);
-		MD5Final(tk, &tctx);
-
-		key = tk;
-		key_len = 16;
-	}
-
-	/* start out by storing key in pads */
-	memset(ctx->k_ipad, 0, sizeof (ctx->k_ipad));
-	memset(ctx->k_opad, 0, sizeof (ctx->k_opad));
-	memcpy(ctx->k_ipad, key, key_len);
-	memcpy(ctx->k_opad, key, key_len);
-
-	/* XOR key with ipad and opad values */
-	for (i = 0; i < 64; i++) {
-		ctx->k_ipad[i] ^= 0x36;
-		ctx->k_opad[i] ^= 0x5c;
-	}
-
-	MD5Init(&ctx->ctx);
-	MD5Update(&ctx->ctx, ctx->k_ipad, 64);
-}
-
-/***********************************************************************
- the microsoft version of hmac_md5 initialisation.
-***********************************************************************/
-void
-hmac_md5_init_limK_to_64(const unsigned char *key, int key_len,
-			 struct HMACMD5Context *ctx)
-{
-	int i;
-
-	/* if key is longer than 64 bytes truncate it */
-	if (key_len > 64) {
-		key_len = 64;
-	}
-
-	/* start out by storing key in pads */
-	memset(ctx->k_ipad, 0, sizeof (ctx->k_ipad));
-	memset(ctx->k_opad, 0, sizeof (ctx->k_opad));
-	memcpy(ctx->k_ipad, key, key_len);
-	memcpy(ctx->k_opad, key, key_len);
-
-	/* XOR key with ipad and opad values */
-	for (i = 0; i < 64; i++) {
-		ctx->k_ipad[i] ^= 0x36;
-		ctx->k_opad[i] ^= 0x5c;
-	}
-
-	MD5Init(&ctx->ctx);
-	MD5Update(&ctx->ctx, ctx->k_ipad, 64);
-}
-
-/***********************************************************************
- update hmac_md5 "inner" buffer
-***********************************************************************/
-void
-hmac_md5_update(const unsigned char *text, int text_len,
-		struct HMACMD5Context *ctx)
-{
-	MD5Update(&ctx->ctx, text, text_len);	/* then text of datagram */
-}
-
-/***********************************************************************
- finish off hmac_md5 "inner" buffer and generate outer one.
-***********************************************************************/
-void
-hmac_md5_final(unsigned char *digest, struct HMACMD5Context *ctx)
-{
-	struct MD5Context ctx_o;
-
-	MD5Final(digest, &ctx->ctx);
-
-	MD5Init(&ctx_o);
-	MD5Update(&ctx_o, ctx->k_opad, 64);
-	MD5Update(&ctx_o, digest, 16);
-	MD5Final(digest, &ctx_o);
-}
-
-/***********************************************************
- single function to calculate an HMAC MD5 digest from data.
- use the microsoft hmacmd5 init method because the key is 16 bytes.
-************************************************************/
-void
-hmac_md5(unsigned char key[16], unsigned char *data, int data_len,
-	 unsigned char *digest)
-{
-	struct HMACMD5Context ctx;
-	hmac_md5_init_limK_to_64(key, 16, &ctx);
-	if (data_len != 0) {
-		hmac_md5_update(data, data_len, &ctx);
-	}
-	hmac_md5_final(digest, &ctx);
-}
diff -urN linux-2.6.0-test6-bk2/fs/cifs/md5.h linux-2.6.0-test6-bk2-dirty/fs/cifs/md5.h
--- linux-2.6.0-test6-bk2/fs/cifs/md5.h	Sun Sep 28 02:50:06 2003
+++ linux-2.6.0-test6-bk2-dirty/fs/cifs/md5.h	Thu Jan  1 01:00:00 1970
@@ -1,38 +0,0 @@
-#ifndef MD5_H
-#define MD5_H
-#ifndef HEADER_MD5_H
-/* Try to avoid clashes with OpenSSL */
-#define HEADER_MD5_H
-#endif
-
-struct MD5Context {
-	__u32 buf[4];
-	__u32 bits[2];
-	unsigned char in[64];
-};
-#endif				/* !MD5_H */
-
-#ifndef _HMAC_MD5_H
-struct HMACMD5Context {
-	struct MD5Context ctx;
-	unsigned char k_ipad[65];
-	unsigned char k_opad[65];
-};
-#endif				/* _HMAC_MD5_H */
-
-void MD5Init(struct MD5Context *context);
-void MD5Update(struct MD5Context *context, unsigned char const *buf,
-			unsigned len);
-void MD5Final(unsigned char digest[16], struct MD5Context *context);
-
-/* The following definitions come from lib/hmacmd5.c  */
-
-void hmac_md5_init_rfc2104(unsigned char *key, int key_len,
-			struct HMACMD5Context *ctx);
-void hmac_md5_init_limK_to_64(const unsigned char *key, int key_len,
-			struct HMACMD5Context *ctx);
-void hmac_md5_update(const unsigned char *text, int text_len,
-			struct HMACMD5Context *ctx);
-void hmac_md5_final(unsigned char *digest, struct HMACMD5Context *ctx);
-void hmac_md5(unsigned char key[16], unsigned char *data, int data_len,
-			unsigned char *digest);

--vkogqOf2sHV7VnPd--

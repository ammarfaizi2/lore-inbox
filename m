Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTIAUkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTIAUkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:40:52 -0400
Received: from badne3.ux.his.no ([152.94.1.63]:2176 "EHLO badne3.ux.his.no")
	by vger.kernel.org with ESMTP id S263277AbTIAUkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:40:37 -0400
Date: Mon, 1 Sep 2003 22:40:35 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] 1st try to convert cifs to use CryptoAPI
Message-ID: <20030901204035.GA2626@badne3.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to learn a thing or two about the new CryptoAPI, and I
thought a good way to learn was to try to accomplish one of the minor
items on the Crypto-TODO list. So:

CIFS currently use it's own MD4/MD5 code. I've started to convert it
to using the CryptoAPI, but I'm far from an CIFS/CryptoAPI expert, so my
question is: is this patch totally bogus, or am I doing something
right?

I haven't tested it, it's not beautiful, it's probably broken, but I
hope I'm using the CryptoAPI correct... (yup, I know the extern things
are ugly, should create a cifsencrypt.h header or something...)

(If there is some meaning in this patch, I'd like to improve it and
try to continue to convert the rest of CIFS to the CryptoAPI)

Here it is:

diff -urN linux-2.6.0-test4-bk2/fs/cifs/cifsencrypt.c linux-2.6.0-test4-bk2-cifs-crypto/fs/cifs/cifsencrypt.c
--- linux-2.6.0-test4-bk2/fs/cifs/cifsencrypt.c	2003-08-23 01:57:13.000000000 +0200
+++ linux-2.6.0-test4-bk2-cifs-crypto/fs/cifs/cifsencrypt.c	2003-08-29 10:51:39.000000000 +0200
@@ -20,10 +20,11 @@
  */
 
 #include <linux/fs.h>
+#include <linux/crypto.h>
+#include <asm/scattelist.h>
 #include "cifspdu.h"
 #include "cifsglob.h" 
 #include "cifs_debug.h"
-#include "md5.h"
 #include "cifs_unicode.h"
 
 /* Calculate and return the CIFS signature based on the mac key and the smb pdu */
@@ -32,20 +33,37 @@
 /* Note that the smb header signature field on input contains the  
 	sequence number before this function is called */
 
-extern void mdfour(unsigned char *out, unsigned char *in, int n);
 extern void E_md4hash(const unsigned char *passwd, unsigned char *p16);
-	
+/* smbencrypt.c */
+extern void SMBencrypt_prepare_keys(u8 *ikey, u8 *okey, u8 *in, int len);
+extern void SMBencrypt_finish_md5(u8 *key, u8 *digest);
+
+/* cifsfs.c */
+extern spinlock_t md5_tfm_lock;
+extern spinlock_t md4_tfm_lock;
+extern struct crypto_tfm *md5_tfm;
+extern struct crypto_tfm *md4_tfm;
+
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
 
@@ -136,29 +154,42 @@
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
+	crypto_digest_update(md4_tfm, sg, 1);
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
+	u8 ikey[65], okey[65];
+	struct scatterlist sg[2];
 
 	if(ses)
 		return -EINVAL;
 
 	E_md4hash(ses->password_with_pad, temp_hash);
 
-	hmac_md5_init_limK_to_64(temp_hash, 16, &ctx);
+	SMBencrypt_prepare_keys(ikey, okey, temp_hash, 16);
 	user_name_len = strlen(ses->userName);
 	if(user_name_len > MAX_USERNAME_SIZE)
 		return -EINVAL;
@@ -183,24 +214,50 @@
         dom_name_len = cifs_strtoUCS(unicode_buf+user_name_len, ucase_buf, MAX_USERNAME_SIZE*2, nls_info);
 
 	unicode_buf[user_name_len + dom_name_len] = 0;
-	hmac_md5_update((const unsigned char *) unicode_buf,
-		(user_name_len+dom_name_len)*2,&ctx);
 
-	hmac_md5_final(ses->mac_signing_key,&ctx);
+	sg[0].page = virt_to_page(ikey);
+	sg[0].offset = offset_in_page(ikey);
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
+	SMBencrypt_finish_md5(okey, ses->mac_signing_key);
+
 	kfree(ucase_buf);
 	kfree(unicode_buf);
 	return 0;
 }
 void CalcNTLMv2_response(const struct cifsSesInfo * ses,char * v2_session_response)
 {
+	u8 ikey[65], okey[65];
+	struct scatterlist sg[2];
 	struct HMACMD5Context context;
+
 	memcpy(v2_session_response + 8, ses->server->cryptKey,8);
 	/* gen_blob(v2_session_response + 16); */
-	hmac_md5_init_limK_to_64(ses->mac_signing_key, 16, &context);
 
-	hmac_md5_update(ses->server->cryptKey,8,&context);
+	SMBencrypt_prepare_keys(ikey, okey, ses->mac_signing_key, 16);
+
+	sg[0].page = virt_to_page(ikey);
+	sg[0].offset = offset_in_page(ikey);
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
+	SMBencrypt_finish_md5(okey, v2_session_response);
 }
diff -urN linux-2.6.0-test4-bk2/fs/cifs/cifsfs.c linux-2.6.0-test4-bk2-cifs-crypto/fs/cifs/cifsfs.c
--- linux-2.6.0-test4-bk2/fs/cifs/cifsfs.c	2003-08-23 01:56:30.000000000 +0200
+++ linux-2.6.0-test4-bk2-cifs-crypto/fs/cifs/cifsfs.c	2003-08-29 10:22:17.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/list.h>
 #include <linux/seq_file.h>
 #include <linux/vfs.h>
+#include <linux/crypto.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
 #define DECLARE_GLOBALS_HERE
@@ -60,6 +61,10 @@
 unsigned int sign_CIFS_PDUs = 1;
 unsigned int CIFSMaximumBufferSize = CIFS_MAX_MSGSIZE;
 struct task_struct * oplockThread = NULL;
+static struct crypto_tfm *md5_tfm;
+static struct crypto_tfm *md4_tfm;
+static spinlock_t md5_tfm_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t md4_tfm_lock = SPIN_LOCK_UNLOCKED;
 
 extern int cifs_mount(struct super_block *, struct cifs_sb_info *, char *,
 			const char *);
@@ -643,6 +648,18 @@
 
 	rc = cifs_init_inodecache();
 	if (!rc) {
+		md5_tfm = crypto_alloc_tfm("md5", 0);
+		if (unlikely(md5_tfm == NULL)) {
+			printk(KERN_ERROR "failed to load transform for md5\n");
+			rc = 0;
+		}
+		md4_tfm = crypto_alloc_tfm("md4", 0);
+		if (unlikely(md4_tfm == NULL)) {
+			printk(KERN_ERROR "failed to load transform for md4\n");
+			rc = 0;
+		}
+	}
+	if (!rc) {
 		rc = cifs_init_mids();
 		if (!rc) {
 			rc = cifs_init_request_bufs();
@@ -659,6 +676,7 @@
 		}
 		cifs_destroy_inodecache();
 	}
+
 #ifdef CONFIG_PROC_FS
 	cifs_proc_clean();
 #endif
@@ -680,6 +698,14 @@
 		send_sig(SIGTERM, oplockThread, 1);
 		wait_for_completion(&cifs_oplock_exited);
 	}
+	if (likely(md5_tfm != NULL)) {
+		crypto_free_tfm(md5_tfm);
+		md5_tfm = NULL;
+	}
+	if (likely(md4_tfm != NULL)) {
+		crypto_free_tfm(md4_tfm);
+		md4_tfm = NULL;
+	}
 }
 
 MODULE_AUTHOR("Steve French <sfrench@us.ibm.com>");
diff -urN linux-2.6.0-test4-bk2/fs/cifs/smbencrypt.c linux-2.6.0-test4-bk2-cifs-crypto/fs/cifs/smbencrypt.c
--- linux-2.6.0-test4-bk2/fs/cifs/smbencrypt.c	2003-08-23 01:55:42.000000000 +0200
+++ linux-2.6.0-test4-bk2-cifs-crypto/fs/cifs/smbencrypt.c	2003-08-29 10:51:46.000000000 +0200
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
+#include "cifs_encrypt.h"
 
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
@@ -80,6 +78,12 @@
 int decode_pw_buffer(char in_buffer[516], char *new_pwrd,
 		     int new_pwrd_size, __u32 * new_pw_len);
 
+/* cifsfs.c */
+extern spinlock_t md5_tfm_lock;
+extern spinlock_t md4_tfm_lock;
+extern struct crypto_tfm *md5_tfm;
+extern struct crypto_tfm *md4_tfm;
+
 /*
    This implements the X/Open SMB password encryption
    It takes a password, a 8 byte "crypt key" and puts 24 bytes of 
@@ -109,6 +113,43 @@
 	memset(p21,0,21);
 }
 
+void
+SMBencrypt_prepare_keys(u8 *ikey, u8 *okey, const u8 *in, int len)
+{
+	int i;
+
+	len &= 0x2f;
+
+	memset(ikey, 0, 64);
+	memset(okey, 0, 64);
+	memcpy(ikey, in, len);
+	memcpy(okey, in, len);
+
+	for (i = 0; i < 64; i++) {
+		ikey[i] ^= 0x36;
+		okey[i] ^= 0x5c;
+	}
+}
+
+void
+SMBencrypt_finish_md5(u8 *key, u8 *digest)
+{
+	struct scatterlist[2];
+
+	sg[0].page = virt_to_page(key);
+	sg[0].offset = offset_in_page(key);
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
@@ -152,6 +193,7 @@
 {
 	int len;
 	__u16 wpwd[129];
+	struct scatterlist sg;
 
 	/* Password cannot be longer than 128 characters */
 	len = strlen((char *) passwd);
@@ -163,7 +205,15 @@
 	/* Calculate length in bytes */
 	len = _my_wcslen(wpwd) * sizeof (__u16);
 
-	mdfour(p16, (unsigned char *) wpwd, len);
+	sg.page = virt_to_page(wpwd);
+	sg.offset = offset_in_page(wpwd);
+	sg.length = len;
+
+	spin_lock(&md4_tfm_lock);
+	crypto_digest_init(md4_tfm);
+	crypto_digest_update(md4_tfm, sg, 1);
+	crypto_digest_final(md4_tfm, p16);
+	spin_unlock(&md4_tfm_lock);
 	memset(wpwd,0,129 * 2);
 }
 
@@ -212,17 +262,18 @@
 		const char *domain_n, unsigned char kr_buf[16],
 		const struct nls_table *nls_codepage)
 {
+	struct scatterlist sg[3];
 	wchar_t * user_u;
 	wchar_t * dom_u;
 	int user_l, domain_l;
-	struct HMACMD5Context ctx;
+	u8 ikey[65], okey[65];
 
 	/* might as well do one alloc to hold both (user_u and dom_u) */
 	user_u = kmalloc(2048 * sizeof(wchar_t),GFP_KERNEL); 
 	if(user_u == NULL)
 		return;
 	dom_u = user_u + 1024;
-    
+
 	/* push_ucs2(NULL, user_u, user_n, (user_l+1)*2, STR_UNICODE|STR_NOALIGN|STR_TERMINATE|STR_UPPER);
 	   push_ucs2(NULL, dom_u, domain_n, (domain_l+1)*2, STR_UNICODE|STR_NOALIGN|STR_TERMINATE|STR_UPPER); */
 
@@ -233,10 +284,25 @@
 	user_l++;		/* trailing null */
 	domain_l++;
 
-	hmac_md5_init_limK_to_64(owf, 16, &ctx);
-	hmac_md5_update((const unsigned char *) user_u, user_l * 2, &ctx);
-	hmac_md5_update((const unsigned char *) dom_u, domain_l * 2, &ctx);
-	hmac_md5_final(kr_buf, &ctx);
+	SMBencrypt_prepare_keys(ikey, okey, owf, 16);
+
+	sg[0].page = virt_to_page(ikey);
+	sg[0].offset = offset_in_page(ikey);
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
+	SMBencrypt_finish_md5(okey, kr_buf);
 
 #ifdef DEBUG_PASSWORD
 	DEBUG(100, ("ntv2_owf_gen: user, domain, owfkey, kr\n"));
@@ -307,12 +373,28 @@
                    const struct data_blob * srv_chal,
                    const struct data_blob * cli_chal, unsigned char resp_buf[16])
 {
-        struct HMACMD5Context ctx;
+        struct scatterlist sg[3];
+	u8 ikey[65], okey[65];
+
+	SMBencrypt_prepare_keys(ikey, okey, kr, 16);
+
+	sg[0].page = virt_to_page(ikey);
+	sg[0].offset = offset_in_page(ikey);
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
+	SMBencrypt_finish_md5(okey, resp_buf);
 
 #ifdef DEBUG_PASSWORD
         DEBUG(100, ("SMBOWFencrypt_ntv2: srv_chal, cli_chal, resp_buf\n"));
@@ -390,11 +472,25 @@
 SMBsesskeygen_ntv2(const unsigned char kr[16],
 		   const unsigned char *nt_resp, __u8 sess_key[16])
 {
-	struct HMACMD5Context ctx;
+	struct scatterlist sg[2];
+	u8 ikey[65], okey[65];
 
-	hmac_md5_init_limK_to_64(kr, 16, &ctx);
-	hmac_md5_update(nt_resp, 16, &ctx);
-	hmac_md5_final((unsigned char *) sess_key, &ctx);
+	SMBencrypt_prepare_keys(ikey, okey, kr, 16);
+
+	sg[0].page = virt_to_page(ikey);
+	sg[0].offset = offset_in_page(ikey);
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
+	SMBencrypt_finish_md5(okey, sess_key);
 
 #ifdef DEBUG_PASSWORD
 	DEBUG(100, ("SMBsesskeygen_ntv2:\n"));
@@ -406,7 +502,17 @@
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
+	crypto_digest_update(md4_tfm, sg, 1);
+	crypto_digest_final(md4_tfm, sess_key);
+	spin_unlock(&md4_tfm_lock);
 
 #ifdef DEBUG_PASSWORD
 	DEBUG(100, ("SMBsesskeygen_ntv1:\n"));

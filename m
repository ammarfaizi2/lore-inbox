Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTJBLjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 07:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbTJBLjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 07:39:20 -0400
Received: from johanna5.ux.his.no ([152.94.1.25]:11171 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP id S263333AbTJBLin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 07:38:43 -0400
Date: Thu, 2 Oct 2003 13:37:59 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: Steven French <sfrench@us.ibm.com>
Cc: James Morris <jmorris@intercode.com.au>, Matt Mackall <mpm@selenic.com>,
       Samba Technical Mailing List <samba-technical@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH CIFS] use CryptoAPI MD4/MD5
Message-ID: <20031002113759.GA19824@badne3.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
References: <OF9C1504BB.5FB00D5A-ON87256DB3.0015672E-86256DB3.001798AE@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <OF9C1504BB.5FB00D5A-ON87256DB3.0015672E-86256DB3.001798AE@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Thanks for your reply

On 10/01/03 23:17, Steven French wrote:
> Lots of locks to choose among - per tcp session or per smb session e.g.
Ok, the attached patch allocates tfms per session. There are more
than 30 calls to SendReceive() in cifssmb.c, and almost none of them are
protected by connection/session-semaphores, so I think the right thing
would be to use the session-semaphores: put down()/up() around
SendReceive(), correct?

Patch is against test6-bk3, it compiles and is tested
(mounting and ls'ing) with /proc/fs/cifs/{PacketSigning,NTLMv2}Enable
set to 1.

Regards
	Erlend

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cifs-add-crypto-md5.patch"

diff -urN linux-2.6.0-test6-bk3/fs/Kconfig linux-2.6.0-test6-bk3-dirty/fs/Kconfig
--- linux-2.6.0-test6-bk3/fs/Kconfig	Tue Sep 30 15:59:09 2003
+++ linux-2.6.0-test6-bk3-dirty/fs/Kconfig	Wed Oct  1 15:14:00 2003
@@ -1470,6 +1470,8 @@
 config CIFS
 	tristate "CIFS support (advanced network filesystem for Samba, Window and other CIFS compliant servers)(EXPERIMENTAL)"
 	depends on INET
+	select CRYPTO_MD4
+	select CRYPTO_MD5
 	help
 	  This is the client VFS module for the Common Internet File System
 	  (CIFS) protocol which is the successor to the Server Message Block 
diff -urN linux-2.6.0-test6-bk3/fs/cifs/cifsencrypt.c linux-2.6.0-test6-bk3-dirty/fs/cifs/cifsencrypt.c
--- linux-2.6.0-test6-bk3/fs/cifs/cifsencrypt.c	Sun Sep 28 02:50:30 2003
+++ linux-2.6.0-test6-bk3-dirty/fs/cifs/cifsencrypt.c	Thu Oct  2 11:45:15 2003
@@ -20,10 +20,10 @@
  */
 
 #include <linux/fs.h>
+#include "cifsencrypt.h"
 #include "cifspdu.h"
 #include "cifsglob.h" 
 #include "cifs_debug.h"
-#include "md5.h"
 #include "cifs_unicode.h"
 
 /* Calculate and return the CIFS signature based on the mac key and the smb pdu */
@@ -32,20 +32,23 @@
 /* Note that the smb header signature field on input contains the  
 	sequence number before this function is called */
 
-extern void mdfour(unsigned char *out, unsigned char *in, int n);
-extern void E_md4hash(const unsigned char *passwd, unsigned char *p16);
-	
-static int cifs_calculate_signature(const struct smb_hdr * cifs_pdu, const char * key, char * signature)
+static int cifs_calculate_signature(const struct smb_hdr * cifs_pdu, struct crypto_tfm *md5_tfm,
+	const char * key, char * signature)
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
+	cifs_do_hash(md5_tfm, sg, 2, signature);
+
 	return 0;
 }
 
@@ -72,7 +75,7 @@
 	ses->sequence_number++;
 	write_unlock(&GlobalMid_Lock);
 
-	rc = cifs_calculate_signature(cifs_pdu, ses->mac_signing_key,smb_signature);
+	rc = cifs_calculate_signature(cifs_pdu, ses->md5_tfm, ses->mac_signing_key,smb_signature);
 	if(rc)
                 memset(cifs_pdu->Signature.SecuritySignature, 0, 8);
 	else
@@ -81,8 +84,8 @@
 	return rc;
 }
 
-int cifs_verify_signature(struct smb_hdr * cifs_pdu, const char * mac_key,
-	__u32 expected_sequence_number)
+int cifs_verify_signature(struct smb_hdr * cifs_pdu, const struct cifsSesInfo * ses,
+	const char * mac_key, __u32 expected_sequence_number)
 {
 	unsigned int rc;
 	char server_response_sig[8];
@@ -116,7 +119,7 @@
         cifs_pdu->Signature.Sequence.SequenceNumber = expected_sequence_number;
         cifs_pdu->Signature.Sequence.Reserved = 0;
 
-        rc = cifs_calculate_signature(cifs_pdu, mac_key,
+        rc = cifs_calculate_signature(cifs_pdu, ses->md5_tfm, mac_key,
 		what_we_think_sig_should_be);
 
 	if(rc)
@@ -133,32 +136,84 @@
 }
 
 /* We fill in key by putting in 40 byte array which was allocated by caller */
-int cifs_calculate_mac_key(char * key, const char * rn, const char * password)
+int cifs_calculate_mac_key(const struct cifsSesInfo * ses, char * key, const char * rn,
+	const char * password)
 {
 	char temp_key[16];
+	struct scatterlist sg;
+
 	if ((key == NULL) || (rn == NULL) || (password == NULL))
 		return -EINVAL;
 
-	E_md4hash(password, temp_key);
-	mdfour(key,temp_key,16);
+	sg.page = virt_to_page(temp_key);
+	sg.offset = offset_in_page(temp_key);
+	sg.length = 16;
+
+	E_md4hash(ses->md4_tfm, password, temp_key);
+	cifs_do_hash(ses->md4_tfm, &sg, 1, key);
+
 	memcpy(key+16,rn, CIFS_SESSION_KEY_SIZE);
+
 	return 0;
 }
 
+void cifs_prepare_keypads(u8 *ipad, u8 *opad, const u8 *key, int len)
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
+/* a simple wrapper for crypto hashing */
+void cifs_do_hash(struct crypto_tfm *tfm, struct scatterlist *sg, int n, u8 *digest)
+{
+	crypto_digest_init(tfm);
+	crypto_digest_update(tfm, sg, n);
+	crypto_digest_final(tfm, digest);
+}
+
+void cifs_update_with_opad(struct crypto_tfm *md5_tfm, u8 *pad, u8 *digest)
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
+	cifs_do_hash(md5_tfm, sg, 2, digest);
+}
+
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
 
-	E_md4hash(ses->password_with_pad, temp_hash);
+	E_md4hash(ses->md4_tfm, ses->password_with_pad, temp_hash);
 
-	hmac_md5_init_limK_to_64(temp_hash, 16, &ctx);
+	cifs_prepare_keypads(ipad, opad, temp_hash, 16);
 	user_name_len = strlen(ses->userName);
 	if(user_name_len > MAX_USERNAME_SIZE)
 		return -EINVAL;
@@ -183,24 +238,39 @@
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
+	cifs_do_hash(ses->md5_tfm, sg, 2, ses->mac_signing_key);
+	cifs_update_with_opad(ses->md5_tfm, opad, ses->mac_signing_key);
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
-/*	hmac_md5_update(v2_session_response+16)client thing,8,&context); */ /* BB fix */
+	cifs_prepare_keypads(ipad, opad, ses->mac_signing_key, 16);
 
+	sg[0].page = virt_to_page(ipad);
+	sg[0].offset = offset_in_page(ipad);
+	sg[0].length = 64;
+	sg[1].page = virt_to_page(ses->server->cryptKey);
+	sg[1].offset = offset_in_page(ses->server->cryptKey);
+	sg[1].length = 8;
+/*	hmac_md5_update(v2_session_response+16)client thing,8,&context); */ /* BB fix */
 
-	hmac_md5_final(v2_session_response,&context);
+	cifs_do_hash(ses->md5_tfm, sg, 2, v2_session_response);
+	cifs_update_with_opad(ses->md5_tfm, opad, v2_session_response);
 }
diff -urN linux-2.6.0-test6-bk3/fs/cifs/cifsencrypt.h linux-2.6.0-test6-bk3-dirty/fs/cifs/cifsencrypt.h
--- linux-2.6.0-test6-bk3/fs/cifs/cifsencrypt.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.0-test6-bk3-dirty/fs/cifs/cifsencrypt.h	Thu Oct  2 11:39:55 2003
@@ -0,0 +1,15 @@
+#ifndef CIFSENCRYPT_H
+#define CIFSENCRYPT_H
+
+#include <linux/crypto.h>
+#include <linux/spinlock.h>
+#include <asm/scatterlist.h>
+#include <asm/types.h>
+
+void E_md4hash(struct crypto_tfm *md4_tfm, const unsigned char *passwd, unsigned char *p16);
+
+extern void cifs_prepare_keypads(u8 *ipad, u8 *opad, const u8 *key, int len);
+extern void cifs_update_with_opad(struct crypto_tfm *md5_tfm, u8 *pad, u8 *digest);
+extern void cifs_do_hash(struct crypto_tfm *tfm, struct scatterlist *sg, int n, u8 *digest);
+
+#endif
diff -urN linux-2.6.0-test6-bk3/fs/cifs/cifsfs.c linux-2.6.0-test6-bk3-dirty/fs/cifs/cifsfs.c
--- linux-2.6.0-test6-bk3/fs/cifs/cifsfs.c	Sun Sep 28 02:50:25 2003
+++ linux-2.6.0-test6-bk3-dirty/fs/cifs/cifsfs.c	Thu Oct  2 11:25:15 2003
@@ -31,6 +31,7 @@
 #include <linux/list.h>
 #include <linux/seq_file.h>
 #include <linux/vfs.h>
+#include "cifsencrypt.h"
 #include "cifsfs.h"
 #include "cifspdu.h"
 #define DECLARE_GLOBALS_HERE
@@ -660,6 +661,7 @@
 		}
 		cifs_destroy_inodecache();
 	}
+
 #ifdef CONFIG_PROC_FS
 	cifs_proc_clean();
 #endif
diff -urN linux-2.6.0-test6-bk3/fs/cifs/cifsglob.h linux-2.6.0-test6-bk3-dirty/fs/cifs/cifsglob.h
--- linux-2.6.0-test6-bk3/fs/cifs/cifsglob.h	Sun Sep 28 02:50:10 2003
+++ linux-2.6.0-test6-bk3-dirty/fs/cifs/cifsglob.h	Thu Oct  2 09:59:23 2003
@@ -162,6 +162,8 @@
 	char userName[MAX_USERNAME_SIZE + 1];
 	char domainName[MAX_USERNAME_SIZE + 1];
 	char password_with_pad[CIFS_ENCPWD_SIZE];
+	struct crypto_tfm *md5_tfm; /* crypto transform for md5 hashing */
+	struct crypto_tfm *md4_tfm; /* crypto transform for md4 hashing */
 };
 
 /*
diff -urN linux-2.6.0-test6-bk3/fs/cifs/cifsproto.h linux-2.6.0-test6-bk3-dirty/fs/cifs/cifsproto.h
--- linux-2.6.0-test6-bk3/fs/cifs/cifsproto.h	Sun Sep 28 02:50:06 2003
+++ linux-2.6.0-test6-bk3-dirty/fs/cifs/cifsproto.h	Thu Oct  2 11:35:04 2003
@@ -228,9 +228,10 @@
 extern int cifs_reconnect(struct TCP_Server_Info *server);
 
 extern int cifs_sign_smb(struct smb_hdr *, struct cifsSesInfo *,__u32 *);
-extern int cifs_verify_signature(const struct smb_hdr *, const char * mac_key,
-	__u32 expected_sequence_number);
-extern int cifs_calculate_mac_key(char * key,const char * rn,const char * pass);
+extern int cifs_verify_signature(const struct smb_hdr *, const struct cifsSesInfo * ses,
+	const char * mac_key, __u32 expected_sequence_number);
+extern int cifs_calculate_mac_key(const struct cifsSesInfo * ses, char * key,const char * rn,
+	const char * pass);
 extern void CalcNTLMv2_partial_mac_key(struct cifsSesInfo *, struct nls_table *);
 extern void CalcNTLMv2_response(const struct cifsSesInfo *,char * );
 
diff -urN linux-2.6.0-test6-bk3/fs/cifs/connect.c linux-2.6.0-test6-bk3-dirty/fs/cifs/connect.c
--- linux-2.6.0-test6-bk3/fs/cifs/connect.c	Sun Sep 28 02:50:59 2003
+++ linux-2.6.0-test6-bk3-dirty/fs/cifs/connect.c	Thu Oct  2 11:36:10 2003
@@ -18,6 +18,7 @@
  *   along with this library; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 
  */
+#include <linux/crypto.h>
 #include <linux/fs.h>
 #include <linux/net.h>
 #include <linux/string.h>
@@ -42,7 +43,7 @@
 
 extern void SMBencrypt(unsigned char *passwd, unsigned char *c8,
 		       unsigned char *p24);
-extern void SMBNTencrypt(unsigned char *passwd, unsigned char *c8,
+extern void SMBNTencrypt(const struct cifsSesInfo *ses, unsigned char *passwd, unsigned char *c8,
 			 unsigned char *p24);
 extern int inet_addr(char *);
 
@@ -679,11 +680,11 @@
 						rc = -ENOMEM;
 
 				} else {
-					SMBNTencrypt(pSesInfo->password_with_pad,
+					SMBNTencrypt(pSesInfo, pSesInfo->password_with_pad,
 						pSesInfo->server->cryptKey,
 						ntlm_session_key);
 
-					cifs_calculate_mac_key(pSesInfo->mac_signing_key,
+					cifs_calculate_mac_key(pSesInfo, pSesInfo->mac_signing_key,
 						ntlm_session_key,
 						pSesInfo->password_with_pad);
 				}
@@ -697,11 +698,11 @@
 					nls_info);
 			}
 		} else { /* old style NTLM 0.12 session setup */
-			SMBNTencrypt(pSesInfo->password_with_pad,
+			SMBNTencrypt(pSesInfo, pSesInfo->password_with_pad,
 				pSesInfo->server->cryptKey,
 				ntlm_session_key);
 
-			cifs_calculate_mac_key(pSesInfo->mac_signing_key, 
+			cifs_calculate_mac_key(pSesInfo, pSesInfo->mac_signing_key, 
 				ntlm_session_key, pSesInfo->password_with_pad);
 			rc = CIFSSessSetup(xid, pSesInfo,
 				ntlm_session_key, nls_info);
@@ -917,7 +918,18 @@
 			sprintf(pSesInfo->serverName, "%u.%u.%u.%u",
 				NIPQUAD(sin_server.sin_addr.s_addr));
 		}
-
+		if (!rc) {
+			pSesInfo->md5_tfm = crypto_alloc_tfm("md5", 0);
+			if (unlikely(pSesInfo->md5_tfm == NULL)) {
+				printk(KERN_WARNING "failed to load transform for md5\n");
+				rc = -ENOMEM;
+			}
+			pSesInfo->md4_tfm = crypto_alloc_tfm("md4", 0);
+			if (unlikely(pSesInfo->md4_tfm == NULL)) {
+				printk(KERN_WARNING "failed to load transform for md4\n");
+				rc = -ENOMEM;
+			}
+		}
 		if (!rc){   
 			if (volume_info.password)
 				strncpy(pSesInfo->password_with_pad,
@@ -999,6 +1011,14 @@
 
 /* on error free sesinfo and tcon struct if needed */
 	if (rc) {
+		if (pSesInfo->md5_tfm != NULL) {
+			crypto_free_tfm(pSesInfo->md5_tfm);
+			pSesInfo->md5_tfm = NULL;
+		}
+		if (pSesInfo->md4_tfm != NULL) {
+			crypto_free_tfm(pSesInfo->md4_tfm);
+			pSesInfo->md4_tfm = NULL;
+		}
 		           /* If find_unc succeeded then rc == 0 so we can not end */
 		if (tcon)  /* up here accidently freeing someone elses tcon struct */
 			tconInfoFree(tcon);
@@ -2422,6 +2442,14 @@
 	if (ses) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ / 2);
+	}
+	if (ses->md5_tfm != NULL) {
+		crypto_free_tfm(ses->md5_tfm);
+		ses->md5_tfm = NULL;
+	}
+	if (ses->md4_tfm != NULL) {
+		crypto_free_tfm(ses->md4_tfm);
+		ses->md4_tfm = NULL;
 	}
 	if (ses)
 		sesInfoFree(ses);
diff -urN linux-2.6.0-test6-bk3/fs/cifs/smbencrypt.c linux-2.6.0-test6-bk3-dirty/fs/cifs/smbencrypt.c
--- linux-2.6.0-test6-bk3/fs/cifs/smbencrypt.c	Sun Sep 28 02:50:20 2003
+++ linux-2.6.0-test6-bk3-dirty/fs/cifs/smbencrypt.c	Thu Oct  2 11:43:42 2003
@@ -30,10 +30,11 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/random.h>
+#include "cifsglob.h"
 #include "cifs_unicode.h"
 #include "cifspdu.h"
-#include "md5.h"
 #include "cifs_debug.h"
+#include "cifsencrypt.h"
 
 #ifndef FALSE
 #define FALSE 0
@@ -49,10 +50,6 @@
 #define SSVAL(buf,pos,val) SSVALX((buf),(pos),((__u16)(val)))
 #define SIVAL(buf,pos,val) SIVALX((buf),(pos),((__u32)(val)))
 
-/*The following definitions come from  lib/md4.c  */
-
-void mdfour(unsigned char *out, unsigned char *in, int n);
-
 /*The following definitions come from  libsmb/smbdes.c  */
 
 void E_P16(unsigned char *p14, unsigned char *p16);
@@ -68,13 +65,14 @@
 /*The following definitions come from  libsmb/smbencrypt.c  */
 
 void SMBencrypt(unsigned char *passwd, unsigned char *c8, unsigned char *p24);
-void E_md4hash(const unsigned char *passwd, unsigned char *p16);
-void nt_lm_owf_gen(char *pwd, unsigned char nt_p16[16], unsigned char p16[16]);
+void nt_lm_owf_gen(const struct cifsSesInfo *ses, char *pwd, unsigned char nt_p16[16],
+	unsigned char p16[16]);
 void SMBOWFencrypt(unsigned char passwd[16], unsigned char *c8,
 		   unsigned char p24[24]);
 void NTLMSSPOWFencrypt(unsigned char passwd[8],
 		       unsigned char *ntlmchalresp, unsigned char p24[24]);
-void SMBNTencrypt(unsigned char *passwd, unsigned char *c8, unsigned char *p24);
+void SMBNTencrypt(const struct cifsSesInfo *ses, unsigned char *passwd,
+	unsigned char *c8, unsigned char *p24);
 int make_oem_passwd_hash(char data[516], const char *passwd,
 			 unsigned char old_pw_hash[16], int unicode);
 int decode_pw_buffer(char in_buffer[516], char *new_pwrd,
@@ -148,10 +146,11 @@
  */
 
 void
-E_md4hash(const unsigned char *passwd, unsigned char *p16)
+E_md4hash(struct crypto_tfm *md4_tfm, const unsigned char *passwd, unsigned char *p16)
 {
 	int len;
 	__u16 wpwd[129];
+	struct scatterlist sg;
 
 	/* Password cannot be longer than 128 characters */
 	len = strlen((char *) passwd);
@@ -163,13 +162,17 @@
 	/* Calculate length in bytes */
 	len = _my_wcslen(wpwd) * sizeof (__u16);
 
-	mdfour(p16, (unsigned char *) wpwd, len);
+	sg.page = virt_to_page(wpwd);
+	sg.offset = offset_in_page(wpwd);
+	sg.length = len;
+
+	cifs_do_hash(md4_tfm, &sg, 1, p16);
 	memset(wpwd,0,129 * 2);
 }
 
 /* Does both the NT and LM owfs of a user's password */
 void
-nt_lm_owf_gen(char *pwd, unsigned char nt_p16[16], unsigned char p16[16])
+nt_lm_owf_gen(const struct cifsSesInfo *ses, char *pwd, unsigned char nt_p16[16], unsigned char p16[16])
 {
 	char passwd[514];
 
@@ -180,7 +183,7 @@
 		memcpy(passwd, pwd, 512);
 	/* Calculate the MD4 hash (NT compatible) of the password */
 	memset(nt_p16, '\0', 16);
-	E_md4hash(passwd, nt_p16);
+	E_md4hash(ses->md4_tfm, passwd, nt_p16);
 
 #ifdef DEBUG_PASSWORD
 	DEBUG(100, ("nt_lm_owf_gen: pwd, nt#\n"));
@@ -208,21 +211,22 @@
 
 /* Does the NTLMv2 owfs of a user's password */
 void
-ntv2_owf_gen(const unsigned char owf[16], const char *user_n,
+ntv2_owf_gen(struct crypto_tfm *md5_tfm, const unsigned char owf[16], const char *user_n,
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
 
@@ -233,10 +237,20 @@
 	user_l++;		/* trailing null */
 	domain_l++;
 
-	hmac_md5_init_limK_to_64(owf, 16, &ctx);
-	hmac_md5_update((const unsigned char *) user_u, user_l * 2, &ctx);
-	hmac_md5_update((const unsigned char *) dom_u, domain_l * 2, &ctx);
-	hmac_md5_final(kr_buf, &ctx);
+	cifs_prepare_keypads(ipad, opad, owf, 16);
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
+	cifs_do_hash(md5_tfm, sg, 3, kr_buf);
+	cifs_update_with_opad(md5_tfm, opad, kr_buf);
 
 #ifdef DEBUG_PASSWORD
 	DEBUG(100, ("ntv2_owf_gen: user, domain, owfkey, kr\n"));
@@ -284,13 +298,14 @@
 /* Does the NT MD4 hash then des encryption. */
 
 void
-SMBNTencrypt(unsigned char *passwd, unsigned char *c8, unsigned char *p24)
+SMBNTencrypt(const struct cifsSesInfo *ses, unsigned char *passwd, unsigned char *c8,
+	unsigned char *p24)
 {
 	unsigned char p21[21];
 
 	memset(p21, '\0', 21);
 
-	E_md4hash(passwd, p21);
+	E_md4hash(ses->md4_tfm, passwd, p21);
 	SMBOWFencrypt(p21, c8, p24);
 
 #ifdef DEBUG_PASSWORD
@@ -303,16 +318,27 @@
 
 /* Does the md5 encryption from the NT hash for NTLMv2. */
 void
-SMBOWFencrypt_ntv2(const unsigned char kr[16],
+SMBOWFencrypt_ntv2(struct crypto_tfm *md5_tfm, const unsigned char kr[16],
                    const struct data_blob * srv_chal,
                    const struct data_blob * cli_chal, unsigned char resp_buf[16])
 {
-        struct HMACMD5Context ctx;
+        struct scatterlist sg[3];
+	u8 ipad[65], opad[65];
 
-        hmac_md5_init_limK_to_64(kr, 16, &ctx);
-        hmac_md5_update(srv_chal->data, srv_chal->length, &ctx);
-        hmac_md5_update(cli_chal->data, cli_chal->length, &ctx);
-        hmac_md5_final(resp_buf, &ctx);
+	cifs_prepare_keypads(ipad, opad, kr, 16);
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
+	cifs_do_hash(md5_tfm, sg, 3, resp_buf);
+	cifs_update_with_opad(md5_tfm, opad, resp_buf);
 
 #ifdef DEBUG_PASSWORD
         DEBUG(100, ("SMBOWFencrypt_ntv2: srv_chal, cli_chal, resp_buf\n"));
@@ -322,8 +348,8 @@
 #endif
 }
 
-static struct data_blob LMv2_generate_response(const unsigned char ntlm_v2_hash[16],
-                                        const struct data_blob * server_chal)
+static struct data_blob LMv2_generate_response(struct crypto_tfm *md5_tfm,
+	const unsigned char ntlm_v2_hash[16], const struct data_blob * server_chal)
 {
         unsigned char lmv2_response[16];
 	struct data_blob lmv2_client_data/* = data_blob(NULL, 8)*/; /* BB Fix BB */
@@ -333,7 +359,7 @@
         /* client-supplied random data */
         get_random_bytes(lmv2_client_data.data, lmv2_client_data.length);
         /* Given that data, and the challenge from the server, generate a response */
-        SMBOWFencrypt_ntv2(ntlm_v2_hash, server_chal, &lmv2_client_data, lmv2_response);
+        SMBOWFencrypt_ntv2(md5_tfm, ntlm_v2_hash, server_chal, &lmv2_client_data, lmv2_response);
         memcpy(final_response.data, lmv2_response, sizeof(lmv2_response));
 
         /* after the first 16 bytes is the random data we generated above,
@@ -387,14 +413,23 @@
 }
 
 void
-SMBsesskeygen_ntv2(const unsigned char kr[16],
+SMBsesskeygen_ntv2(struct crypto_tfm *md5_tfm, const unsigned char kr[16],
 		   const unsigned char *nt_resp, __u8 sess_key[16])
 {
-	struct HMACMD5Context ctx;
+	struct scatterlist sg[2];
+	u8 ipad[65], opad[65];
+
+	cifs_prepare_keypads(ipad, opad, kr, 16);
 
-	hmac_md5_init_limK_to_64(kr, 16, &ctx);
-	hmac_md5_update(nt_resp, 16, &ctx);
-	hmac_md5_final((unsigned char *) sess_key, &ctx);
+	sg[0].page = virt_to_page(ipad);
+	sg[0].offset = offset_in_page(ipad);
+	sg[0].length = 64;
+	sg[1].page = virt_to_page(nt_resp);
+	sg[1].offset = offset_in_page(nt_resp);
+	sg[1].length = 16;
+
+	cifs_do_hash(md5_tfm, sg, 2, sess_key);
+	cifs_update_with_opad(md5_tfm, opad, sess_key);
 
 #ifdef DEBUG_PASSWORD
 	DEBUG(100, ("SMBsesskeygen_ntv2:\n"));
@@ -403,10 +438,16 @@
 }
 
 void
-SMBsesskeygen_ntv1(const unsigned char kr[16],
+SMBsesskeygen_ntv1(struct crypto_tfm *md4_tfm, const unsigned char kr[16],
 		   const unsigned char *nt_resp, __u8 sess_key[16])
 {
-	mdfour((unsigned char *) sess_key, (unsigned char *) kr, 16);
+	struct scatterlist sg;
+
+	sg.page = virt_to_page(kr);
+	sg.offset = offset_in_page(kr);
+	sg.length = 16;
+
+	cifs_do_hash(md4_tfm, &sg, 1, sess_key);
 
 #ifdef DEBUG_PASSWORD
 	DEBUG(100, ("SMBsesskeygen_ntv1:\n"));
@@ -434,7 +475,7 @@
 	return TRUE;
 }
 
-int SMBNTLMv2encrypt(const char *user, const char *domain, const char *password,
+int SMBNTLMv2encrypt(const struct cifsSesInfo* ses, const char *user, const char *domain, const char *password,
                       const struct data_blob *server_chal,
                       const struct data_blob *names_blob,
                       struct data_blob *lm_response, struct data_blob *nt_response,
@@ -442,13 +483,13 @@
 {
         unsigned char nt_hash[16];
         unsigned char ntlm_v2_hash[16];
-        E_md4hash(password, nt_hash);
+        E_md4hash(ses->md4_tfm, password, nt_hash);
 
         /* We don't use the NT# directly.  Instead we use it mashed up with
            the username and domain.
            This prevents username swapping during the auth exchange
         */
-        ntv2_owf_gen(nt_hash, user, domain, ntlm_v2_hash,nls_codepage);
+        ntv2_owf_gen(ses->md5_tfm, nt_hash, user, domain, ntlm_v2_hash,nls_codepage);
 
         if (nt_response) {
 /*                *nt_response = NTLMv2_generate_response(ntlm_v2_hash, server_chal,
@@ -458,14 +499,14 @@
 
                         /* The NTLMv2 calculations also provide a session key, for signing etc later */
                         /* use only the first 16 bytes of nt_response for session key */
-                        SMBsesskeygen_ntv2(ntlm_v2_hash, nt_response->data, nt_session_key->data);
+                        SMBsesskeygen_ntv2(ses->md5_tfm, ntlm_v2_hash, nt_response->data, nt_session_key->data);
                 }
         }
 
         /* LMv2 */
 
         if (lm_response) {
-                *lm_response = LMv2_generate_response(ntlm_v2_hash, server_chal);
+                *lm_response = LMv2_generate_response(ses->md5_tfm, ntlm_v2_hash, server_chal);
         }
 
         return TRUE;
diff -urN linux-2.6.0-test6-bk3/fs/cifs/transport.c linux-2.6.0-test6-bk3-dirty/fs/cifs/transport.c
--- linux-2.6.0-test6-bk3/fs/cifs/transport.c	Sun Sep 28 02:50:14 2003
+++ linux-2.6.0-test6-bk3-dirty/fs/cifs/transport.c	Thu Oct  2 09:50:42 2003
@@ -267,7 +267,7 @@
 			    be32_to_cpu(out_buf->smb_buf_length);
 			if((out_buf->smb_buf_length > 24) &&
 			   (ses->server->secMode & (SECMODE_SIGN_REQUIRED | SECMODE_SIGN_ENABLED))) {
-				rc = cifs_verify_signature(out_buf, ses->mac_signing_key,midQ->sequence_number); /* BB fix BB */
+				rc = cifs_verify_signature(out_buf, ses, ses->mac_signing_key,midQ->sequence_number); /* BB fix BB */
 				if(rc)
 					cFYI(1,("Unexpected signature received from server"));
 			}

--wRRV7LY7NUeQGEoC--

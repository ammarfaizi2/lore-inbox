Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267669AbTAMAJQ>; Sun, 12 Jan 2003 19:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267670AbTAMAJP>; Sun, 12 Jan 2003 19:09:15 -0500
Received: from mons.uio.no ([129.240.130.14]:41610 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267669AbTAMAHG>;
	Sun, 12 Jan 2003 19:07:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.1331.51764.358891@charged.uio.no>
Date: Mon, 13 Jan 2003 01:15:47 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Secure user authentication for NFS using RPCSEC_GSS [6/6]
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch provides minimal client support for the
(mandatory) Kerberos V5 authentication mechanism under RPCSEC_GSS.
See RFC2623 and RFC3010 for protocol details.

Only authentication is supported for the moment. Data integrity and/or
data privacy (encryption) will be implemented at a later stage.


diff -u --recursive --new-file linux-2.5.56-06-auth_upcall2/fs/Kconfig linux-2.5.56-07-krb5/fs/Kconfig
--- linux-2.5.56-06-auth_upcall2/fs/Kconfig	2003-01-12 22:40:13.000000000 +0100
+++ linux-2.5.56-07-krb5/fs/Kconfig	2003-01-12 22:40:33.000000000 +0100
@@ -1345,11 +1345,24 @@
 	default SUNRPC if NFS_V4=y
 	help
 	  Provides cryptographic authentication for NFS rpc requests.  To
-	  make this useful, you also need support for a gss-api mechanism
-	  (such as Kerberos).
+	  make this useful, you must also select at least one rpcsec_gss
+	  mechanism.
 	  Note: You should always select this option if you wish to use
 	  NFSv4.
 
+config RPCSEC_GSS_KRB5
+	tristate "Kerberos V mechanism for RPCSEC_GSS (EXPERIMENTAL)"
+	depends on SUNRPC_GSS && CRYPTO_DES && CRYPTO_MD5
+	default SUNRPC_GSS if NFS_V4=y
+	help
+	  Provides a gss-api mechanism based on Kerberos V5 (this is
+	  mandatory for RFC3010-compliant NFSv4 implementations).
+	  Requires a userspace daemon;
+		see http://www.citi.umich.edu/projects/nfsv4/.
+
+	  Note: If you select this option, please ensure that you also
+	  enable the MD5 and DES crypto ciphers.
+
 config LOCKD
 	tristate
 	default m if NFS_FS!=y && NFSD!=y && (NFS_FS=m || NFSD=m)
diff -u --recursive --new-file linux-2.5.56-06-auth_upcall2/include/linux/sunrpc/gss_krb5.h linux-2.5.56-07-krb5/include/linux/sunrpc/gss_krb5.h
--- linux-2.5.56-06-auth_upcall2/include/linux/sunrpc/gss_krb5.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-07-krb5/include/linux/sunrpc/gss_krb5.h	2003-01-12 22:40:33.000000000 +0100
@@ -0,0 +1,160 @@
+/*
+ *  linux/include/linux/sunrpc/gss_krb5_types.h
+ *
+ *  Adapted from MIT Kerberos 5-1.2.1 lib/include/krb5.h,
+ *  lib/gssapi/krb5/gssapiP_krb5.h, and others
+ *
+ *  Copyright (c) 2000 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Andy Adamson   <andros@umich.edu>
+ *  Bruce Fields   <bfields@umich.edu>
+ */
+
+/*
+ * Copyright 1995 by the Massachusetts Institute of Technology.
+ * All Rights Reserved.
+ *
+ * Export of this software from the United States of America may
+ *   require a specific license from the United States Government.
+ *   It is the responsibility of any person or organization contemplating
+ *   export to obtain such a license before exporting.
+ *
+ * WITHIN THAT CONSTRAINT, permission to use, copy, modify, and
+ * distribute this software and its documentation for any purpose and
+ * without fee is hereby granted, provided that the above copyright
+ * notice appear in all copies and that both that copyright notice and
+ * this permission notice appear in supporting documentation, and that
+ * the name of M.I.T. not be used in advertising or publicity pertaining
+ * to distribution of the software without specific, written prior
+ * permission.  Furthermore if you modify this software you must label
+ * your software as modified software and not distribute it in such a
+ * fashion that it might be confused with the original M.I.T. software.
+ * M.I.T. makes no representations about the suitability of
+ * this software for any purpose.  It is provided "as is" without express
+ * or implied warranty.
+ *
+ */
+
+#include <linux/sunrpc/auth_gss.h>
+#include <linux/sunrpc/gss_err.h>
+#include <linux/sunrpc/gss_asn1.h>
+
+struct krb5_ctx {
+	int			initiate; /* 1 = initiating, 0 = accepting */
+	int			seed_init;
+	unsigned char		seed[16];
+	int			signalg;
+	int			sealalg;
+	struct crypto_tfm	*enc;
+	struct crypto_tfm	*seq;
+	s32			endtime;
+	u32			seq_send;
+	u32			seq_recv;
+	struct xdr_netobj	mech_used;
+};
+
+#define KG_TOK_MIC_MSG    0x0101
+#define KG_TOK_WRAP_MSG   0x0201
+
+enum sgn_alg {
+	SGN_ALG_DES_MAC_MD5 = 0x0000,
+	SGN_ALG_MD2_5 = 0x0001,
+	SGN_ALG_DES_MAC = 0x0002,
+	SGN_ALG_3 = 0x0003,		/* not published */
+	SGN_ALG_HMAC_MD5 = 0x0011,	/* microsoft w2k; no support */
+	SGN_ALG_HMAC_SHA1_DES3_KD = 0x0004
+};
+enum seal_alg {
+	SEAL_ALG_NONE = 0xffff,
+	SEAL_ALG_DES = 0x0000,
+	SEAL_ALG_1 = 0x0001,		/* not published */
+	SEAL_ALG_MICROSOFT_RC4 = 0x0010,/* microsoft w2k; no support */
+	SEAL_ALG_DES3KD = 0x0002
+};
+
+#define RSA_MD5_CKSUM_LENGTH 16
+
+#define CKSUMTYPE_CRC32			0x0001
+#define CKSUMTYPE_RSA_MD4		0x0002
+#define CKSUMTYPE_RSA_MD4_DES		0x0003
+#define CKSUMTYPE_DESCBC		0x0004
+#define CKSUMTYPE_RSA_MD5		0x0007
+#define CKSUMTYPE_RSA_MD5_DES		0x0008
+#define CKSUMTYPE_NIST_SHA		0x0009
+#define CKSUMTYPE_HMAC_SHA1_DES3	0x000c
+
+/* from gssapi_err_krb5.h */
+#define KG_CCACHE_NOMATCH                        (39756032L)
+#define KG_KEYTAB_NOMATCH                        (39756033L)
+#define KG_TGT_MISSING                           (39756034L)
+#define KG_NO_SUBKEY                             (39756035L)
+#define KG_CONTEXT_ESTABLISHED                   (39756036L)
+#define KG_BAD_SIGN_TYPE                         (39756037L)
+#define KG_BAD_LENGTH                            (39756038L)
+#define KG_CTX_INCOMPLETE                        (39756039L)
+#define KG_CONTEXT                               (39756040L)
+#define KG_CRED                                  (39756041L)
+#define KG_ENC_DESC                              (39756042L)
+#define KG_BAD_SEQ                               (39756043L)
+#define KG_EMPTY_CCACHE                          (39756044L)
+#define KG_NO_CTYPES                             (39756045L)
+
+#define KV5M_PRINCIPAL                           (-1760647423L)
+#define KV5M_KEYBLOCK                            (-1760647421L)
+#define KV5M_CHECKSUM                            (-1760647420L)
+#define KV5M_ADDRESS                             (-1760647390L)
+#define KV5M_AUTHENTICATOR                       (-1760647410L)
+#define KV5M_AUTH_CONTEXT                        (-1760647383L)
+#define KV5M_AUTHDATA                            (-1760647414L)
+#define KV5M_GSS_OID                             (-1760647372L)
+#define KV5M_GSS_QUEUE                           (-1760647371L)
+
+/* per Kerberos v5 protocol spec crypto types from the wire. 
+ * these get mapped to linux kernel crypto routines.  
+ */
+#define ENCTYPE_NULL            0x0000
+#define ENCTYPE_DES_CBC_CRC     0x0001	/* DES cbc mode with CRC-32 */
+#define ENCTYPE_DES_CBC_MD4     0x0002	/* DES cbc mode with RSA-MD4 */
+#define ENCTYPE_DES_CBC_MD5     0x0003	/* DES cbc mode with RSA-MD5 */
+#define ENCTYPE_DES_CBC_RAW     0x0004	/* DES cbc mode raw */
+/* XXX deprecated? */
+#define ENCTYPE_DES3_CBC_SHA    0x0005	/* DES-3 cbc mode with NIST-SHA */
+#define ENCTYPE_DES3_CBC_RAW    0x0006	/* DES-3 cbc mode raw */
+#define ENCTYPE_DES_HMAC_SHA1   0x0008
+#define ENCTYPE_DES3_CBC_SHA1   0x0010
+#define ENCTYPE_UNKNOWN         0x01ff
+
+s32
+krb5_make_checksum(s32 cksumtype,
+		   struct xdr_netobj *input,
+		   struct xdr_netobj *cksum);
+
+u32
+krb5_make_token(struct krb5_ctx *context_handle, int qop_req,
+	struct xdr_netobj * input_message_buffer,
+	struct xdr_netobj * output_message_buffer, int toktype);
+
+u32
+krb5_read_token(struct krb5_ctx *context_handle,
+	  struct xdr_netobj *input_token_buffer,
+	  struct xdr_netobj *message_buffer,
+	  int *qop_state, int toktype);
+
+u32
+krb5_encrypt(struct crypto_tfm * key,
+	     void *iv, void *in, void *out, int length);
+
+u32
+krb5_decrypt(struct crypto_tfm * key,
+	     void *iv, void *in, void *out, int length); 
+
+s32
+krb5_make_seq_num(struct crypto_tfm * key,
+		int direction,
+		s32 seqnum, unsigned char *cksum, unsigned char *buf);
+
+s32
+krb5_get_seq_num(struct crypto_tfm * key,
+	       unsigned char *cksum,
+	       unsigned char *buf, int *direction, s32 * seqnum);
diff -u --recursive --new-file linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/gss_krb5_crypto.c linux-2.5.56-07-krb5/net/sunrpc/auth_gss/gss_krb5_crypto.c
--- linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/gss_krb5_crypto.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-07-krb5/net/sunrpc/auth_gss/gss_krb5_crypto.c	2003-01-12 22:40:33.000000000 +0100
@@ -0,0 +1,168 @@
+/*
+ *  linux/net/sunrpc/gss_krb5_crypto.c
+ *
+ *  Copyright (c) 2000 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Andy Adamson   <andros@umich.edu>
+ *  Bruce Fields   <bfields@umich.edu>
+ */
+
+/*
+ * Copyright (C) 1998 by the FundsXpress, INC.
+ *
+ * All rights reserved.
+ *
+ * Export of this software from the United States of America may require
+ * a specific license from the United States Government.  It is the
+ * responsibility of any person or organization contemplating export to
+ * obtain such a license before exporting.
+ *
+ * WITHIN THAT CONSTRAINT, permission to use, copy, modify, and
+ * distribute this software and its documentation for any purpose and
+ * without fee is hereby granted, provided that the above copyright
+ * notice appear in all copies and that both that copyright notice and
+ * this permission notice appear in supporting documentation, and that
+ * the name of FundsXpress. not be used in advertising or publicity pertaining
+ * to distribution of the software without specific, written prior
+ * permission.  FundsXpress makes no representations about the suitability of
+ * this software for any purpose.  It is provided "as is" without express
+ * or implied warranty.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <asm/scatterlist.h>
+#include <linux/crypto.h>
+#include <linux/sunrpc/gss_krb5.h>
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY        RPCDBG_AUTH
+#endif
+
+u32
+krb5_encrypt(
+	struct crypto_tfm *tfm,
+	void * iv,
+	void * in,
+	void * out,
+	int length)
+{
+	u32 ret = -EINVAL;
+        struct scatterlist sg[1];
+	u8 local_iv[16] = {0};
+
+	dprintk("RPC: gss_k5encrypt: TOP in %p out %p\nin data:\n", out, in);
+	print_hexl((u32 *)in, length, 0);
+
+	if (length % crypto_tfm_alg_blocksize(tfm) != 0)
+		goto out;
+
+	if (crypto_tfm_alg_ivsize(tfm) > 16) {
+		dprintk("RPC: gss_k5encrypt: tfm iv size to large %d\n",
+		         crypto_tfm_alg_ivsize(tfm));
+		goto out;
+	}
+
+	if (iv)
+		memcpy(local_iv, iv, crypto_tfm_alg_ivsize(tfm));
+	crypto_cipher_set_iv(tfm, local_iv, crypto_tfm_alg_ivsize(tfm));
+
+	memcpy(out, in, length);
+	sg[0].page = virt_to_page(out);
+	sg[0].offset = ((long)out & ~PAGE_MASK);
+	sg[0].length = length;
+
+	ret = crypto_cipher_encrypt(tfm, sg, 1);
+
+out:
+	dprintk("gss_k5encrypt returns %d\n",ret);
+	return(ret);
+}
+
+u32
+krb5_decrypt(
+     struct crypto_tfm *tfm,
+     void * iv,
+     void * in,
+     void * out,
+     int length)
+{
+	u32 ret = -EINVAL;
+	struct scatterlist sg[1];
+	u8 local_iv[16] = {0};
+
+	dprintk("RPC: gss_k5decrypt: TOP in %p out %p\nin data:\n", in, out);
+	print_hexl((u32 *)in,length,0);
+
+	if (length % crypto_tfm_alg_blocksize(tfm) != 0)
+		goto out;
+
+	if (crypto_tfm_alg_ivsize(tfm) > 16) {
+		dprintk("RPC: gss_k5decrypt: tfm iv size to large %d\n",
+			crypto_tfm_alg_ivsize(tfm));
+		goto out;
+	}
+	if (iv)
+		memcpy(local_iv,iv, crypto_tfm_alg_ivsize(tfm));
+	crypto_cipher_set_iv(tfm, local_iv, crypto_tfm_alg_blocksize(tfm));
+
+	memcpy(out, in, length);
+	sg[0].page = virt_to_page(out);
+	sg[0].offset = ((long)out  & ~PAGE_MASK);
+	sg[0].length = length;
+
+	ret = crypto_cipher_decrypt(tfm, sg, 1);
+
+out:
+	dprintk("gss_k5decrypt returns %d\n",ret);
+	return(ret);
+}
+
+s32
+krb5_make_checksum(s32 cksumtype, struct xdr_netobj *input,
+		   struct xdr_netobj *cksum)
+{
+	s32			ret = -EINVAL;
+	struct scatterlist	sg[1];
+	char			*cksumname;
+	struct crypto_tfm	*tfm;
+
+	switch (cksumtype) {
+		case CKSUMTYPE_RSA_MD5:
+			cksumname = "md5";
+			break;
+		default:
+			dprintk("RPC: krb5_make_checksum:"
+				" unsupported checksum %d", cksumtype);
+			goto out;
+	}
+	if (!(tfm = crypto_alloc_tfm(cksumname, 0)))
+		goto out;
+	cksum->len = crypto_tfm_alg_digestsize(tfm);
+
+	if ((cksum->data = kmalloc(cksum->len, GFP_KERNEL)) == NULL) {
+		ret = -ENOMEM;
+		goto out_free_tfm;
+	}
+	sg[0].page = virt_to_page(input->data);
+	sg[0].offset = ((long)input->data & ~PAGE_MASK);
+	sg[0].length = input->len;
+
+	crypto_digest_init(tfm);
+	crypto_digest_update(tfm, sg, 1);
+	crypto_digest_final(tfm, cksum->data);
+
+	ret = 0;
+
+out_free_tfm:
+	crypto_free_tfm(tfm);
+out:
+	dprintk("RPC: gss_k5cksum: returning %d\n", ret);
+	return (ret);
+}
diff -u --recursive --new-file linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/gss_krb5_mech.c linux-2.5.56-07-krb5/net/sunrpc/auth_gss/gss_krb5_mech.c
--- linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/gss_krb5_mech.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-07-krb5/net/sunrpc/auth_gss/gss_krb5_mech.c	2003-01-12 22:40:33.000000000 +0100
@@ -0,0 +1,251 @@
+/*
+ *  linux/net/sunrpc/gss_krb5_mech.c
+ *
+ *  Copyright (c) 2001 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Andy Adamson <andros@umich.edu>
+ *  J. Bruce Fields <bfields@umich.edu>
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *  1. Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *  2. Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in the
+ *     documentation and/or other materials provided with the distribution.
+ *  3. Neither the name of the University nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ *  DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ *  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ *  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/sunrpc/auth.h>
+#include <linux/sunrpc/gss_krb5.h>
+#include <linux/sunrpc/xdr.h>
+#include <linux/crypto.h>
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY	RPCDBG_AUTH
+#endif
+
+struct xdr_netobj gss_mech_krb5_oid =
+   {9, "\052\206\110\206\367\022\001\002\002"};
+
+static inline int
+get_bytes(char **ptr, const char *end, void *res, int len)
+{
+	char *p, *q;
+	p = *ptr;
+	q = p + len;
+	if (q > end || q < p)
+		return -1;
+	memcpy(res, p, len);
+	*ptr = q;
+	return 0;
+}
+
+static inline int
+get_netobj(char **ptr, const char *end, struct xdr_netobj *res)
+{
+	char *p, *q;
+	p = *ptr;
+	if (get_bytes(&p, end, &res->len, sizeof(res->len)))
+		return -1;
+	q = p + res->len;
+	if (q > end || q < p)
+		return -1;
+	if (!(res->data = kmalloc(res->len, GFP_KERNEL)))
+		return -1;
+	memcpy(res->data, p, res->len);
+	*ptr = q;
+	return 0;
+}
+
+static inline int
+get_key(char **p, char *end, struct crypto_tfm **res)
+{
+	struct xdr_netobj	key;
+	int			alg, alg_mode;
+	char			*alg_name;
+
+	if (get_bytes(p, end, &alg, sizeof(alg)))
+		goto out_err;
+	if ((get_netobj(p, end, &key)))
+		goto out_err;
+
+	switch (alg) {
+		case ENCTYPE_DES_CBC_RAW:
+			alg_name = "des";
+			alg_mode = CRYPTO_TFM_MODE_CBC;
+			break;
+		default:
+			dprintk("RPC: get_key: unsupported algorithm %d", alg);
+			goto out_err_free_key;
+	}
+	if (!(*res = crypto_alloc_tfm(alg_name, alg_mode)))
+		goto out_err_free_key;
+	if (crypto_cipher_setkey(*res, key.data, key.len))
+		goto out_err_free_tfm;
+
+	kfree(key.data);
+	return 0;
+
+out_err_free_tfm:
+	crypto_free_tfm(*res);
+out_err_free_key:
+	kfree(key.data);
+out_err:
+	return -1;
+}
+
+static u32
+gss_import_sec_context_kerberos(struct xdr_netobj *inbuf,
+				struct gss_ctx *ctx_id)
+{
+	char	*p = inbuf->data;
+	char	*end = inbuf->data + inbuf->len;
+	struct	krb5_ctx *ctx;
+
+	if (!(ctx = kmalloc(sizeof(*ctx), GFP_KERNEL)))
+		goto out_err;
+	memset(ctx, 0, sizeof(*ctx));
+
+	if (get_bytes(&p, end, &ctx->initiate, sizeof(ctx->initiate)))
+		goto out_err_free_ctx;
+	if (get_bytes(&p, end, &ctx->seed_init, sizeof(ctx->seed_init)))
+		goto out_err_free_ctx;
+	if (get_bytes(&p, end, ctx->seed, sizeof(ctx->seed)))
+		goto out_err_free_ctx;
+	if (get_bytes(&p, end, &ctx->signalg, sizeof(ctx->signalg)))
+		goto out_err_free_ctx;
+	if (get_bytes(&p, end, &ctx->sealalg, sizeof(ctx->sealalg)))
+		goto out_err_free_ctx;
+	if (get_bytes(&p, end, &ctx->endtime, sizeof(ctx->endtime)))
+		goto out_err_free_ctx;
+	if (get_bytes(&p, end, &ctx->seq_send, sizeof(ctx->seq_send)))
+		goto out_err_free_ctx;
+	if (get_netobj(&p, end, &ctx->mech_used))
+		goto out_err_free_ctx;
+	if (get_key(&p, end, &ctx->enc))
+		goto out_err_free_mech;
+	if (get_key(&p, end, &ctx->seq))
+		goto out_err_free_key1;
+	if (p != end)
+		goto out_err_free_key2;
+
+	ctx_id->internal_ctx_id = ctx;
+	dprintk("Succesfully imported new context.\n");
+	return 0;
+
+out_err_free_key2:
+	crypto_free_tfm(ctx->seq);
+out_err_free_key1:
+	crypto_free_tfm(ctx->enc);
+out_err_free_mech:
+	kfree(ctx->mech_used.data);
+out_err_free_ctx:
+	kfree(ctx);
+out_err:
+	return GSS_S_FAILURE;
+}
+
+void
+gss_delete_sec_context_kerberos(void *internal_ctx) {
+	struct krb5_ctx *kctx = internal_ctx;
+
+	if (kctx->seq)
+		crypto_free_tfm(kctx->seq);
+	if (kctx->enc)
+		crypto_free_tfm(kctx->enc);
+	if (kctx->mech_used.data)
+		kfree(kctx->mech_used.data);
+	kfree(kctx);
+}
+
+u32
+gss_verify_mic_kerberos(struct gss_ctx		*ctx,
+			struct xdr_netobj	*signbuf,
+			struct xdr_netobj	*checksum,
+			u32		*qstate) {
+	u32 maj_stat = 0;
+	int qop_state;
+	struct krb5_ctx *kctx = ctx->internal_ctx_id;
+
+	maj_stat = krb5_read_token(kctx, checksum, signbuf, &qop_state,
+				   KG_TOK_MIC_MSG);
+	if (!maj_stat && qop_state)
+	    *qstate = qop_state;
+
+	dprintk("RPC: gss_verify_mic_kerberos returning %d\n", maj_stat);
+	return maj_stat;
+}
+
+u32
+gss_get_mic_kerberos(struct gss_ctx	*ctx,
+		     u32		qop,
+		     struct xdr_netobj	*message_buffer,
+		     struct xdr_netobj	*message_token) {
+	u32 err = 0;
+	struct krb5_ctx *kctx = ctx->internal_ctx_id;
+
+	if (!message_buffer->data) return GSS_S_FAILURE;
+
+	dprintk("RPC: gss_get_mic_kerberos:"
+		" message_buffer->len %d\n",message_buffer->len);
+
+	err = krb5_make_token(kctx, qop, message_buffer,
+			      message_token, KG_TOK_MIC_MSG);
+
+	dprintk("RPC: gss_get_mic_kerberos returning %d\n",err);
+
+	return err;
+}
+
+static struct gss_api_ops gss_kerberos_ops = {
+	.name			= "krb5",
+	.gss_import_sec_context	= gss_import_sec_context_kerberos,
+	.gss_get_mic		= gss_get_mic_kerberos,
+	.gss_verify_mic		= gss_verify_mic_kerberos,
+	.gss_delete_sec_context	= gss_delete_sec_context_kerberos,
+};
+
+/* XXX error checking? reference counting? */
+static int __init init_kerberos_module(void)
+{
+	struct gss_api_mech *gm;
+
+	if (gss_mech_register(&gss_mech_krb5_oid, &gss_kerberos_ops))
+		printk("Failed to register kerberos gss mechanism!\n");
+	gm = gss_mech_get_by_OID(&gss_mech_krb5_oid);
+	gss_register_triple(RPC_AUTH_GSS_KRB5 , gm, 0, RPC_GSS_SVC_NONE);
+	gss_mech_put(gm);
+	return 0;
+}
+
+static void __exit cleanup_kerberos_module(void)
+{
+	gss_unregister_triple(RPC_AUTH_GSS_KRB5);
+}
+
+MODULE_LICENSE("GPL");
+module_init(init_kerberos_module);
+module_exit(cleanup_kerberos_module);
diff -u --recursive --new-file linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/gss_krb5_seal.c linux-2.5.56-07-krb5/net/sunrpc/auth_gss/gss_krb5_seal.c
--- linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/gss_krb5_seal.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-07-krb5/net/sunrpc/auth_gss/gss_krb5_seal.c	2003-01-12 22:40:33.000000000 +0100
@@ -0,0 +1,214 @@
+/*
+ *  linux/net/sunrpc/gss_krb5_seal.c
+ *
+ *  Adapted from MIT Kerberos 5-1.2.1 lib/gssapi/krb5/k5seal.c
+ *
+ *  Copyright (c) 2000 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Andy Adamson	<andros@umich.edu>
+ *  J. Bruce Fields	<bfields@umich.edu>
+ */
+
+/*
+ * Copyright 1993 by OpenVision Technologies, Inc.
+ *
+ * Permission to use, copy, modify, distribute, and sell this software
+ * and its documentation for any purpose is hereby granted without fee,
+ * provided that the above copyright notice appears in all copies and
+ * that both that copyright notice and this permission notice appear in
+ * supporting documentation, and that the name of OpenVision not be used
+ * in advertising or publicity pertaining to distribution of the software
+ * without specific, written prior permission. OpenVision makes no
+ * representations about the suitability of this software for any
+ * purpose.  It is provided "as is" without express or implied warranty.
+ *
+ * OPENVISION DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
+ * EVENT SHALL OPENVISION BE LIABLE FOR ANY SPECIAL, INDIRECT OR
+ * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
+ * USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
+ * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
+ * PERFORMANCE OF THIS SOFTWARE.
+ */
+
+/*
+ * Copyright (C) 1998 by the FundsXpress, INC.
+ *
+ * All rights reserved.
+ *
+ * Export of this software from the United States of America may require
+ * a specific license from the United States Government.  It is the
+ * responsibility of any person or organization contemplating export to
+ * obtain such a license before exporting.
+ *
+ * WITHIN THAT CONSTRAINT, permission to use, copy, modify, and
+ * distribute this software and its documentation for any purpose and
+ * without fee is hereby granted, provided that the above copyright
+ * notice appear in all copies and that both that copyright notice and
+ * this permission notice appear in supporting documentation, and that
+ * the name of FundsXpress. not be used in advertising or publicity pertaining
+ * to distribution of the software without specific, written prior
+ * permission.  FundsXpress makes no representations about the suitability of
+ * this software for any purpose.  It is provided "as is" without express
+ * or implied warranty.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/sunrpc/gss_krb5.h>
+#include <linux/random.h>
+#include <linux/crypto.h>
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY        RPCDBG_AUTH
+#endif
+
+#define CKSUM_SIZE	8
+
+static inline int
+gss_krb5_padding(int blocksize, int length) {
+	/* Most of the code is block-size independent but in practice we
+	 * use only 8: */
+	BUG_ON(blocksize != 8);
+	return 8 - (length & 7);
+}
+
+/* checksum the plaintext data and the first 8 bytes of the krb5 token header,
+ * as specified by the rfc: */
+static u32
+compute_checksum(s32 checksum_type, char *header, char *body, int body_len,
+		 struct xdr_netobj *md5cksum) {
+	char			*data_ptr;
+	struct xdr_netobj	plaind;
+	u32			code = GSS_S_FAILURE;
+
+	if (!(data_ptr = kmalloc(8 + body_len, GFP_KERNEL)))
+		goto out;
+	memcpy(data_ptr, header, 8);
+	memcpy(data_ptr + 8, body, body_len);
+	plaind.len = 8 + body_len;
+	plaind.data = data_ptr;
+	code = krb5_make_checksum(checksum_type, &plaind, md5cksum);
+	kfree(data_ptr);
+	code = 0;
+
+out:
+	return code;
+}
+
+u32
+krb5_make_token(struct krb5_ctx *ctx, int qop_req,
+		   struct xdr_netobj * text, struct xdr_netobj * token,
+		   int toktype)
+{
+	s32			checksum_type;
+	struct xdr_netobj	md5cksum = {.len = 0, .data = NULL};
+	int			blocksize = 0, tmsglen;
+	unsigned char		*ptr, *krb5_hdr, *msg_start;
+	s32			now;
+
+	dprintk("RPC: gss_krb5_seal");
+
+	now = jiffies;
+
+	if (qop_req != 0)
+		goto out_err;
+
+	switch (ctx->signalg) {
+		case SGN_ALG_DES_MAC_MD5:
+			checksum_type = CKSUMTYPE_RSA_MD5;
+			break;
+		default:
+			dprintk("RPC: gss_krb5_seal: ctx->signalg %d not"
+				" supported\n", ctx->signalg);
+			goto out_err;
+	}
+	if (ctx->sealalg != SEAL_ALG_NONE && ctx->sealalg != SEAL_ALG_DES) {
+		dprintk("RPC: gss_krb5_seal: ctx->sealalg %d not supported\n",
+			ctx->sealalg);
+		goto out_err;
+	}
+
+	if (toktype == KG_TOK_WRAP_MSG) {
+		blocksize = crypto_tfm_alg_blocksize(ctx->enc);
+		tmsglen = blocksize + text->len
+			+ gss_krb5_padding(blocksize, blocksize + text->len);
+	} else {
+		tmsglen = 0;
+	}
+
+	token->len = g_token_size(&ctx->mech_used, 22 + tmsglen);
+	if ((token->data = kmalloc(token->len, GFP_KERNEL)) == NULL)
+		goto out_err;
+
+	ptr = token->data;
+	g_make_token_header(&ctx->mech_used, 22 + tmsglen, &ptr, toktype);
+
+	/* ptr now at byte 2 of header described in rfc 1964, section 1.2.1: */
+	krb5_hdr = ptr - 2;
+	msg_start = krb5_hdr + 24;
+
+	*(u16 *)(krb5_hdr + 2) = htons(ctx->signalg);
+	memset(krb5_hdr + 4, 0xff, 4);
+	if (toktype == KG_TOK_WRAP_MSG)
+		*(u16 *)(krb5_hdr + 4) = htons(ctx->sealalg);
+
+	if (toktype == KG_TOK_WRAP_MSG) {
+		unsigned char pad = gss_krb5_padding(blocksize, text->len);
+
+		get_random_bytes(msg_start, blocksize); /* "confounder" */
+		memcpy(msg_start + blocksize, text->data, text->len);
+
+		memset(msg_start + blocksize + text->len, pad, pad);
+
+		if (compute_checksum(checksum_type, krb5_hdr, msg_start,
+				     tmsglen, &md5cksum))
+			goto out_err;
+
+		if (krb5_encrypt(ctx->enc, NULL, msg_start, msg_start,
+					tmsglen))
+			goto out_err;
+
+	} else { /* Sign only.  */
+		if (compute_checksum(checksum_type, krb5_hdr, text->data,
+					text->len, &md5cksum))
+			goto out_err;
+	}
+
+	switch (ctx->signalg) {
+	case SGN_ALG_DES_MAC_MD5:
+		if (krb5_encrypt(ctx->seq, NULL, md5cksum.data,
+				  md5cksum.data, md5cksum.len))
+			goto out_err;
+		memcpy(krb5_hdr + 16,
+		       md5cksum.data + md5cksum.len - CKSUM_SIZE, CKSUM_SIZE);
+
+		dprintk("make_seal_token: cksum data: \n");
+		print_hexl((u32 *) (krb5_hdr + 16), CKSUM_SIZE, 0);
+		break;
+	default:
+		BUG();
+	}
+
+	kfree(md5cksum.data);
+
+	if ((krb5_make_seq_num(ctx->seq, ctx->initiate ? 0 : 0xff,
+			       ctx->seq_send, krb5_hdr + 16, krb5_hdr + 8)))
+		goto out_err;
+
+	ctx->seq_send++;
+
+	return ((ctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE);
+out_err:
+	if (md5cksum.data) kfree(md5cksum.data);
+	if (token->data) kfree(token->data);
+	token->data = 0;
+	token->len = 0;
+	return GSS_S_FAILURE;
+}
diff -u --recursive --new-file linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/gss_krb5_seqnum.c linux-2.5.56-07-krb5/net/sunrpc/auth_gss/gss_krb5_seqnum.c
--- linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/gss_krb5_seqnum.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-07-krb5/net/sunrpc/auth_gss/gss_krb5_seqnum.c	2003-01-12 22:40:33.000000000 +0100
@@ -0,0 +1,88 @@
+/*
+ *  linux/net/sunrpc/gss_krb5_seqnum.c
+ *
+ *  Adapted from MIT Kerberos 5-1.2.1 lib/gssapi/krb5/util_seqnum.c
+ *
+ *  Copyright (c) 2000 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Andy Adamson   <andros@umich.edu>
+ */
+
+/*
+ * Copyright 1993 by OpenVision Technologies, Inc.
+ * 
+ * Permission to use, copy, modify, distribute, and sell this software
+ * and its documentation for any purpose is hereby granted without fee,
+ * provided that the above copyright notice appears in all copies and
+ * that both that copyright notice and this permission notice appear in
+ * supporting documentation, and that the name of OpenVision not be used
+ * in advertising or publicity pertaining to distribution of the software
+ * without specific, written prior permission. OpenVision makes no
+ * representations about the suitability of this software for any
+ * purpose.  It is provided "as is" without express or implied warranty.
+ * 
+ * OPENVISION DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
+ * EVENT SHALL OPENVISION BE LIABLE FOR ANY SPECIAL, INDIRECT OR
+ * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
+ * USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
+ * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
+ * PERFORMANCE OF THIS SOFTWARE.
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/sunrpc/gss_krb5.h>
+#include <linux/crypto.h>
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY        RPCDBG_AUTH
+#endif
+
+s32
+krb5_make_seq_num(struct crypto_tfm *key,
+		int direction,
+		s32 seqnum,
+		unsigned char *cksum, unsigned char *buf)
+{
+	unsigned char plain[8];
+
+	plain[0] = (unsigned char) (seqnum & 0xff);
+	plain[1] = (unsigned char) ((seqnum >> 8) & 0xff);
+	plain[2] = (unsigned char) ((seqnum >> 16) & 0xff);
+	plain[3] = (unsigned char) ((seqnum >> 24) & 0xff);
+
+	plain[4] = direction;
+	plain[5] = direction;
+	plain[6] = direction;
+	plain[7] = direction;
+
+	return krb5_encrypt(key, cksum, plain, buf, 8);
+}
+
+s32
+krb5_get_seq_num(struct crypto_tfm *key,
+	       unsigned char *cksum,
+	       unsigned char *buf,
+	       int *direction, s32 * seqnum)
+{
+	s32 code;
+	unsigned char plain[8];
+
+	dprintk("krb5_get_seq_num: \n");
+
+	if ((code = krb5_decrypt(key, cksum, buf, plain, 8)))
+		return code;
+
+	if ((plain[4] != plain[5]) || (plain[4] != plain[6])
+				   || (plain[4] != plain[7]))
+		return (s32)KG_BAD_SEQ;
+
+	*direction = plain[4];
+
+	*seqnum = ((plain[0]) |
+		   (plain[1] << 8) | (plain[2] << 16) | (plain[3] << 24));
+
+	return (0);
+}
diff -u --recursive --new-file linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/gss_krb5_unseal.c linux-2.5.56-07-krb5/net/sunrpc/auth_gss/gss_krb5_unseal.c
--- linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/gss_krb5_unseal.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.56-07-krb5/net/sunrpc/auth_gss/gss_krb5_unseal.c	2003-01-12 22:40:33.000000000 +0100
@@ -0,0 +1,306 @@
+/*
+ *  linux/net/sunrpc/gss_krb5_unseal.c
+ *
+ *  Adapted from MIT Kerberos 5-1.2.1 lib/gssapi/krb5/k5unseal.c
+ *
+ *  Copyright (c) 2000 The Regents of the University of Michigan.
+ *  All rights reserved.
+ *
+ *  Andy Adamson   <andros@umich.edu>
+ */
+
+/*
+ * Copyright 1993 by OpenVision Technologies, Inc.
+ *
+ * Permission to use, copy, modify, distribute, and sell this software
+ * and its documentation for any purpose is hereby granted without fee,
+ * provided that the above copyright notice appears in all copies and
+ * that both that copyright notice and this permission notice appear in
+ * supporting documentation, and that the name of OpenVision not be used
+ * in advertising or publicity pertaining to distribution of the software
+ * without specific, written prior permission. OpenVision makes no
+ * representations about the suitability of this software for any
+ * purpose.  It is provided "as is" without express or implied warranty.
+ *
+ * OPENVISION DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
+ * EVENT SHALL OPENVISION BE LIABLE FOR ANY SPECIAL, INDIRECT OR
+ * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
+ * USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
+ * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
+ * PERFORMANCE OF THIS SOFTWARE.
+ */
+
+/*
+ * Copyright (C) 1998 by the FundsXpress, INC.
+ *
+ * All rights reserved.
+ *
+ * Export of this software from the United States of America may require
+ * a specific license from the United States Government.  It is the
+ * responsibility of any person or organization contemplating export to
+ * obtain such a license before exporting.
+ *
+ * WITHIN THAT CONSTRAINT, permission to use, copy, modify, and
+ * distribute this software and its documentation for any purpose and
+ * without fee is hereby granted, provided that the above copyright
+ * notice appear in all copies and that both that copyright notice and
+ * this permission notice appear in supporting documentation, and that
+ * the name of FundsXpress. not be used in advertising or publicity pertaining
+ * to distribution of the software without specific, written prior
+ * permission.  FundsXpress makes no representations about the suitability of
+ * this software for any purpose.  It is provided "as is" without express
+ * or implied warranty.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/sunrpc/gss_krb5.h>
+#include <linux/crypto.h>
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY        RPCDBG_AUTH
+#endif
+
+
+/* message_buffer is an input if MIC and an output if WRAP. */
+
+u32
+krb5_read_token(struct krb5_ctx *ctx,
+		struct xdr_netobj *read_token,
+		struct xdr_netobj *message_buffer,
+		int *qop_state, int toktype)
+{
+	s32			code;
+	int			tmsglen = 0;
+	int			conflen = 0;
+	int			signalg;
+	int			sealalg;
+	struct xdr_netobj	token = {.len = 0, .data = NULL};
+	s32			checksum_type;
+	struct xdr_netobj	cksum;
+	struct xdr_netobj	md5cksum = {.len = 0, .data = NULL};
+	struct xdr_netobj	plaind;
+	char			*data_ptr;
+	s32			now;
+	unsigned char		*plain = NULL;
+	int			cksum_len = 0;
+	int			plainlen = 0;
+	int			direction;
+	s32			seqnum;
+	unsigned char		*ptr = (unsigned char *)read_token->data;
+	int			bodysize;
+	u32			ret = GSS_S_DEFECTIVE_TOKEN;
+
+	dprintk("RPC: krb5_read_token\n");
+
+	if (g_verify_token_header((struct xdr_netobj *) &ctx->mech_used,
+					&bodysize, &ptr, toktype,
+					read_token->len))
+		goto out;
+
+	if (toktype == KG_TOK_WRAP_MSG) {
+		message_buffer->len = 0;
+		message_buffer->data = NULL;
+	}
+
+	/* get the sign and seal algorithms */
+
+	signalg = ptr[0] + (ptr[1] << 8);
+	sealalg = ptr[2] + (ptr[3] << 8);
+
+	/* Sanity checks */
+
+	if ((ptr[4] != 0xff) || (ptr[5] != 0xff))
+		goto out;
+
+	if (((toktype != KG_TOK_WRAP_MSG) && (sealalg != 0xffff)) ||
+	    ((toktype == KG_TOK_WRAP_MSG) && (sealalg == 0xffff)))
+		goto out;
+
+	/* in the current spec, there is only one valid seal algorithm per
+	   key type, so a simple comparison is ok */
+
+	if ((toktype == KG_TOK_WRAP_MSG) && !(sealalg == ctx->sealalg))
+		goto out;
+
+	/* there are several mappings of seal algorithms to sign algorithms,
+	   but few enough that we can try them all. */
+
+	if ((ctx->sealalg == SEAL_ALG_NONE && signalg > 1) ||
+	    (ctx->sealalg == SEAL_ALG_1 && signalg != SGN_ALG_3) ||
+	    (ctx->sealalg == SEAL_ALG_DES3KD &&
+	     signalg != SGN_ALG_HMAC_SHA1_DES3_KD))
+		goto out;
+
+	/* starting with a single alg */
+	switch (signalg) {
+	case SGN_ALG_DES_MAC_MD5:
+		cksum_len = 8;
+		break;
+	default:
+		goto out;
+	}
+
+	if (toktype == KG_TOK_WRAP_MSG)
+		tmsglen = bodysize - (14 + cksum_len);
+
+	/* get the token parameters */
+
+	/* decode the message, if WRAP */
+
+	if (toktype == KG_TOK_WRAP_MSG) {
+		dprintk("RPC: krb5_read_token KG_TOK_WRAP_MSG\n");
+
+		plain = kmalloc(tmsglen, GFP_KERNEL);
+		ret = GSS_S_FAILURE;
+		if (plain ==  NULL)
+			goto out;
+
+		code = krb5_decrypt(ctx->enc, NULL,
+				   ptr + 14 + cksum_len, plain,
+				   tmsglen);
+		if (code)
+			goto out;
+
+		plainlen = tmsglen;
+
+		conflen = crypto_tfm_alg_blocksize(ctx->enc);
+		token.len = tmsglen - conflen - plain[tmsglen - 1];
+
+		if (token.len) {
+			token.data = kmalloc(token.len, GFP_KERNEL);
+			if (token.data == NULL)
+				goto out;
+			memcpy(token.data, plain + conflen, token.len);
+		}
+
+	} else if (toktype == KG_TOK_MIC_MSG) {
+		dprintk("RPC: krb5_read_token KG_TOK_MIC_MSG\n");
+		token = *message_buffer;
+		plain = token.data;
+		plainlen = token.len;
+	} else {
+		token.len = 0;
+		token.data = NULL;
+		plain = token.data;
+		plainlen = token.len;
+	}
+
+	dprintk("RPC krb5_read_token: token.len %d plainlen %d\n", token.len,
+		plainlen);
+
+	/* compute the checksum of the message */
+
+	/* initialize the the cksum */
+	switch (signalg) {
+	case SGN_ALG_DES_MAC_MD5:
+		checksum_type = CKSUMTYPE_RSA_MD5;
+		break;
+	default:
+		ret = GSS_S_DEFECTIVE_TOKEN;
+		goto out;
+	}
+
+	switch (signalg) {
+	case SGN_ALG_DES_MAC_MD5:
+		dprintk("RPC krb5_read_token SGN_ALG_DES_MAC_MD5\n");
+		/* compute the checksum of the message.
+		 * 8 = bytes of token body to be checksummed according to spec 
+		 */
+
+		data_ptr = kmalloc(8 + plainlen, GFP_KERNEL);
+		ret = GSS_S_FAILURE;
+		if (!data_ptr)
+			goto out;
+
+		memcpy(data_ptr, ptr - 2, 8);
+		memcpy(data_ptr + 8, plain, plainlen);
+
+		plaind.len = 8 + plainlen;
+		plaind.data = data_ptr;
+
+		code = krb5_make_checksum(checksum_type,
+					    &plaind, &md5cksum);
+
+		kfree(data_ptr);
+
+		if (code)
+			goto out;
+
+		code = krb5_encrypt(ctx->seq, NULL, md5cksum.data,
+					  md5cksum.data, 16);
+		if (code)
+			goto out;
+
+		if (signalg == 0)
+			cksum.len = 8;
+		else
+			cksum.len = 16;
+		cksum.data = md5cksum.data + 16 - cksum.len;
+
+		dprintk
+		    ("RPC: krb5_read_token: memcmp digest cksum.len %d:\n",
+		     cksum.len);
+		dprintk("          md5cksum.data\n");
+		print_hexl((u32 *) md5cksum.data, 16, 0);
+		dprintk("          cksum.data:\n");
+		print_hexl((u32 *) cksum.data, cksum.len, 0);
+		{
+			u32 *p;
+
+			(u8 *) p = ptr + 14;
+			dprintk("          ptr+14:\n");
+			print_hexl(p, cksum.len, 0);
+		}
+
+		code = memcmp(cksum.data, ptr + 14, cksum.len);
+		break;
+	default:
+		ret = GSS_S_DEFECTIVE_TOKEN;
+		goto out;
+	}
+
+	ret = GSS_S_BAD_SIG;
+	if (code)
+		goto out;
+
+	/* it got through unscathed.  Make sure the context is unexpired */
+
+	if (toktype == KG_TOK_WRAP_MSG)
+		*message_buffer = token;
+
+	if (qop_state)
+		*qop_state = GSS_C_QOP_DEFAULT;
+
+	now = jiffies;
+
+	ret = GSS_S_CONTEXT_EXPIRED;
+	if (now > ctx->endtime)
+		goto out;
+
+	/* do sequencing checks */
+
+	ret = GSS_S_BAD_SIG;
+	if ((code = krb5_get_seq_num(ctx->seq, ptr + 14, ptr + 6, &direction,
+				   &seqnum)))
+		goto out;
+
+	if ((ctx->initiate && direction != 0xff) ||
+	    (!ctx->initiate && direction != 0))
+		goto out;
+
+	ret = GSS_S_COMPLETE;
+out:
+	if (md5cksum.data) kfree(md5cksum.data);
+	if (toktype == KG_TOK_WRAP_MSG) {
+		if (plain) kfree(plain);
+		if (ret && token.data) kfree(token.data);
+	}
+	return ret;
+}
diff -u --recursive --new-file linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/Makefile linux-2.5.56-07-krb5/net/sunrpc/auth_gss/Makefile
--- linux-2.5.56-06-auth_upcall2/net/sunrpc/auth_gss/Makefile	2003-01-12 22:40:13.000000000 +0100
+++ linux-2.5.56-07-krb5/net/sunrpc/auth_gss/Makefile	2003-01-12 22:40:33.000000000 +0100
@@ -9,3 +9,8 @@
 auth_rpcgss-objs := auth_gss.o gss_pseudoflavors.o gss_generic_token.o \
 	sunrpcgss_syms.o gss_mech_switch.o
 
+obj-$(CONFIG_RPCSEC_GSS_KRB5) += rpcsec_gss_krb5.o
+
+rpcsec_gss_krb5-objs := gss_krb5_mech.o gss_krb5_seal.o gss_krb5_unseal.o \
+	gss_krb5_crypto.o gss_krb5_seqnum.o
+

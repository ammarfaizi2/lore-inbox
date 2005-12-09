Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVLIP1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVLIP1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbVLIP1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:27:24 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:26588 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932373AbVLIP1V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:27:21 -0500
Date: Fri, 9 Dec 2005 16:27:19 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 10/17] s390: in-kernel crypto test vectors.
Message-ID: <20051209152719.GK6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

[patch 10/17] s390: in-kernel crypto test vectors.

Add new test vectors to the AES test suite for AES CBC and AES with
plaintext larger than AES blocksize.

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 crypto/tcrypt.c |    4 +++
 crypto/tcrypt.h |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff -urpN linux-2.6/crypto/tcrypt.c linux-2.6-patched/crypto/tcrypt.c
--- linux-2.6/crypto/tcrypt.c	2005-12-09 14:21:39.000000000 +0100
+++ linux-2.6-patched/crypto/tcrypt.c	2005-12-09 14:25:49.000000000 +0100
@@ -805,6 +805,8 @@ static void do_test(void)
 		//AES
 		test_cipher ("aes", MODE_ECB, ENCRYPT, aes_enc_tv_template, AES_ENC_TEST_VECTORS);
 		test_cipher ("aes", MODE_ECB, DECRYPT, aes_dec_tv_template, AES_DEC_TEST_VECTORS);
+		test_cipher ("aes", MODE_CBC, ENCRYPT, aes_cbc_enc_tv_template, AES_CBC_ENC_TEST_VECTORS);
+		test_cipher ("aes", MODE_CBC, DECRYPT, aes_cbc_dec_tv_template, AES_CBC_DEC_TEST_VECTORS);
 
 		//CAST5
 		test_cipher ("cast5", MODE_ECB, ENCRYPT, cast5_enc_tv_template, CAST5_ENC_TEST_VECTORS);
@@ -910,6 +912,8 @@ static void do_test(void)
 	case 10:
 		test_cipher ("aes", MODE_ECB, ENCRYPT, aes_enc_tv_template, AES_ENC_TEST_VECTORS);
 		test_cipher ("aes", MODE_ECB, DECRYPT, aes_dec_tv_template, AES_DEC_TEST_VECTORS);
+		test_cipher ("aes", MODE_CBC, ENCRYPT, aes_cbc_enc_tv_template, AES_CBC_ENC_TEST_VECTORS);
+		test_cipher ("aes", MODE_CBC, DECRYPT, aes_cbc_dec_tv_template, AES_CBC_DEC_TEST_VECTORS);
 		break;
 
 	case 11:
diff -urpN linux-2.6/crypto/tcrypt.h linux-2.6-patched/crypto/tcrypt.h
--- linux-2.6/crypto/tcrypt.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/crypto/tcrypt.h	2005-12-09 14:25:49.000000000 +0100
@@ -1836,6 +1836,8 @@ static struct cipher_testvec cast6_dec_t
  */
 #define AES_ENC_TEST_VECTORS 3
 #define AES_DEC_TEST_VECTORS 3
+#define AES_CBC_ENC_TEST_VECTORS 2
+#define AES_CBC_DEC_TEST_VECTORS 2
 
 static struct cipher_testvec aes_enc_tv_template[] = {
 	{ /* From FIPS-197 */
@@ -1911,6 +1913,68 @@ static struct cipher_testvec aes_dec_tv_
 	},
 };
 
+static struct cipher_testvec aes_cbc_enc_tv_template[] = {
+	{ /* From RFC 3602 */
+		.key    = { 0x06, 0xa9, 0x21, 0x40, 0x36, 0xb8, 0xa1, 0x5b,
+			    0x51, 0x2e, 0x03, 0xd5, 0x34, 0x12, 0x00, 0x06 },
+		.klen   = 16,
+		.iv	= { 0x3d, 0xaf, 0xba, 0x42, 0x9d, 0x9e, 0xb4, 0x30,
+			    0xb4, 0x22, 0xda, 0x80, 0x2c, 0x9f, 0xac, 0x41 },
+		.input	= { "Single block msg" },
+		.ilen   = 16,
+		.result = { 0xe3, 0x53, 0x77, 0x9c, 0x10, 0x79, 0xae, 0xb8,
+			    0x27, 0x08, 0x94, 0x2d, 0xbe, 0x77, 0x18, 0x1a },
+		.rlen   = 16,
+	}, {
+		.key    = { 0xc2, 0x86, 0x69, 0x6d, 0x88, 0x7c, 0x9a, 0xa0,
+			    0x61, 0x1b, 0xbb, 0x3e, 0x20, 0x25, 0xa4, 0x5a },
+		.klen   = 16,
+		.iv     = { 0x56, 0x2e, 0x17, 0x99, 0x6d, 0x09, 0x3d, 0x28,
+			    0xdd, 0xb3, 0xba, 0x69, 0x5a, 0x2e, 0x6f, 0x58 },
+		.input  = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+			    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+			    0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+			    0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f },
+		.ilen   = 32,
+		.result = { 0xd2, 0x96, 0xcd, 0x94, 0xc2, 0xcc, 0xcf, 0x8a,
+			    0x3a, 0x86, 0x30, 0x28, 0xb5, 0xe1, 0xdc, 0x0a,
+			    0x75, 0x86, 0x60, 0x2d, 0x25, 0x3c, 0xff, 0xf9,
+			    0x1b, 0x82, 0x66, 0xbe, 0xa6, 0xd6, 0x1a, 0xb1 },
+		.rlen   = 32,
+	},
+};
+
+static struct cipher_testvec aes_cbc_dec_tv_template[] = {
+	{ /* From RFC 3602 */
+		.key    = { 0x06, 0xa9, 0x21, 0x40, 0x36, 0xb8, 0xa1, 0x5b,
+			    0x51, 0x2e, 0x03, 0xd5, 0x34, 0x12, 0x00, 0x06 },
+		.klen   = 16,
+		.iv     = { 0x3d, 0xaf, 0xba, 0x42, 0x9d, 0x9e, 0xb4, 0x30,
+			    0xb4, 0x22, 0xda, 0x80, 0x2c, 0x9f, 0xac, 0x41 },
+		.input  = { 0xe3, 0x53, 0x77, 0x9c, 0x10, 0x79, 0xae, 0xb8,
+			    0x27, 0x08, 0x94, 0x2d, 0xbe, 0x77, 0x18, 0x1a },
+		.ilen   = 16,
+		.result = { "Single block msg" },
+		.rlen   = 16,
+	}, {
+		.key    = { 0xc2, 0x86, 0x69, 0x6d, 0x88, 0x7c, 0x9a, 0xa0,
+			    0x61, 0x1b, 0xbb, 0x3e, 0x20, 0x25, 0xa4, 0x5a },
+		.klen   = 16,
+		.iv     = { 0x56, 0x2e, 0x17, 0x99, 0x6d, 0x09, 0x3d, 0x28,
+			    0xdd, 0xb3, 0xba, 0x69, 0x5a, 0x2e, 0x6f, 0x58 },
+		.input  = { 0xd2, 0x96, 0xcd, 0x94, 0xc2, 0xcc, 0xcf, 0x8a,
+			    0x3a, 0x86, 0x30, 0x28, 0xb5, 0xe1, 0xdc, 0x0a,
+			    0x75, 0x86, 0x60, 0x2d, 0x25, 0x3c, 0xff, 0xf9,
+			    0x1b, 0x82, 0x66, 0xbe, 0xa6, 0xd6, 0x1a, 0xb1 },
+		.ilen   = 32,
+		.result = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+			    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+			    0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+			    0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f },
+		.rlen   = 32,
+	},
+};
+
 /* Cast5 test vectors from RFC 2144 */
 #define CAST5_ENC_TEST_VECTORS	3
 #define CAST5_DEC_TEST_VECTORS	3

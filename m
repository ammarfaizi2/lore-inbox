Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbWEPLm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWEPLm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWEPLm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:42:56 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:32264 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751792AbWEPLmx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:42:53 -0400
Date: Tue, 16 May 2006 21:42:44 +1000
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: [CRYPTO] all: Pass tfm instead of ctx to algorithms
Message-ID: <20060516114244.GC25936@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

Up until now algorithms have been happy to get a context pointer since
they know everything that's in the tfm already (e.g., alignment, block
size).

However, once we have parameterised algorithms, such information could
be specific to each tfm.  So the algorithm API needs to be changed to
pass the tfm structure instead of the context pointer.

This patch is basically a text substitution.  The only tricky bit is
the assembly routines that need to get the context pointer offset
through asm-offsets.h.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="p3.patch"

diff --git a/arch/i386/crypto/aes-i586-asm.S b/arch/i386/crypto/aes-i586-asm.S
--- a/arch/i386/crypto/aes-i586-asm.S
+++ b/arch/i386/crypto/aes-i586-asm.S
@@ -36,19 +36,19 @@
 .file "aes-i586-asm.S"
 .text
 
-#define tlen 1024   // length of each of 4 'xor' arrays (256 32-bit words)
-
-// offsets to parameters with one register pushed onto stack
+#include <asm/asm-offsets.h>
 
-#define in_blk   16  // input byte array address parameter
-#define out_blk  12  // output byte array address parameter
-#define ctx       8  // AES context structure
-
-// offsets in context structure
+#define tlen 1024   // length of each of 4 'xor' arrays (256 32-bit words)
 
-#define ekey     0   // encryption key schedule base address
-#define nrnd   256   // number of rounds
-#define dkey   260   // decryption key schedule base address
+/* offsets to parameters with one register pushed onto stack */
+#define tfm 8
+#define out_blk 12
+#define in_blk 16
+
+/* offsets in crypto_tfm structure */
+#define ekey (crypto_tfm_ctx_offset + 0)
+#define nrnd (crypto_tfm_ctx_offset + 256)
+#define dkey (crypto_tfm_ctx_offset + 260)
 
 // register mapping for encrypt and decrypt subroutines
 
@@ -217,7 +217,7 @@
 	do_col (table, r5,r0,r1,r4, r2,r3);		/* idx=r5 */
 
 // AES (Rijndael) Encryption Subroutine
-/* void aes_enc_blk(void *ctx, u8 *out_blk, const u8 *in_blk) */
+/* void aes_enc_blk(struct crypto_tfm *tfm, u8 *out_blk, const u8 *in_blk) */
 
 .global  aes_enc_blk
 
@@ -228,7 +228,7 @@
 
 aes_enc_blk:
 	push    %ebp
-	mov     ctx(%esp),%ebp      // pointer to context
+	mov     tfm(%esp),%ebp
 
 // CAUTION: the order and the values used in these assigns 
 // rely on the register mappings
@@ -293,7 +293,7 @@ aes_enc_blk:
 	ret
 
 // AES (Rijndael) Decryption Subroutine
-/* void aes_dec_blk(void *ctx, u8 *out_blk, const u8 *in_blk) */
+/* void aes_dec_blk(struct crypto_tfm *tfm, u8 *out_blk, const u8 *in_blk) */
 
 .global  aes_dec_blk
 
@@ -304,7 +304,7 @@ aes_enc_blk:
 
 aes_dec_blk:
 	push    %ebp
-	mov     ctx(%esp),%ebp       // pointer to context
+	mov     tfm(%esp),%ebp
 
 // CAUTION: the order and the values used in these assigns 
 // rely on the register mappings
diff --git a/arch/i386/crypto/aes.c b/arch/i386/crypto/aes.c
--- a/arch/i386/crypto/aes.c
+++ b/arch/i386/crypto/aes.c
@@ -45,8 +45,8 @@
 #include <linux/crypto.h>
 #include <linux/linkage.h>
 
-asmlinkage void aes_enc_blk(void *ctx, u8 *dst, const u8 *src);
-asmlinkage void aes_dec_blk(void *ctx, u8 *dst, const u8 *src);
+asmlinkage void aes_enc_blk(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
+asmlinkage void aes_dec_blk(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
 
 #define AES_MIN_KEY_SIZE	16
 #define AES_MAX_KEY_SIZE	32
@@ -378,12 +378,12 @@ static void gen_tabs(void)
 	k[8*(i)+11] = ss[3];						\
 }
 
-static int
-aes_set_key(void *ctx_arg, const u8 *in_key, unsigned int key_len, u32 *flags)
+static int aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
+		       unsigned int key_len, u32 *flags)
 {
 	int i;
 	u32 ss[8];
-	struct aes_ctx *ctx = ctx_arg;
+	struct aes_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *key = (const __le32 *)in_key;
 
 	/* encryption schedule */
diff --git a/arch/i386/kernel/asm-offsets.c b/arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c
+++ b/arch/i386/kernel/asm-offsets.c
@@ -4,6 +4,7 @@
  * to extract and format the required data.
  */
 
+#include <linux/crypto.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
@@ -69,4 +70,6 @@ void foo(void)
 
 	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
 	DEFINE(VSYSCALL_BASE, __fix_to_virt(FIX_VSYSCALL));
+
+	OFFSET(crypto_tfm_ctx_offset, crypto_tfm, __crt_ctx);
 }
diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -37,10 +37,10 @@ struct s390_aes_ctx {
 	int key_len;
 };
 
-static int aes_set_key(void *ctx, const u8 *in_key, unsigned int key_len,
-		       u32 *flags)
+static int aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
+		       unsigned int key_len, u32 *flags)
 {
-	struct s390_aes_ctx *sctx = ctx;
+	struct s390_aes_ctx *sctx = crypto_tfm_ctx(tfm);
 
 	switch (key_len) {
 	case 16:
@@ -70,9 +70,9 @@ fail:
 	return -EINVAL;
 }
 
-static void aes_encrypt(void *ctx, u8 *out, const u8 *in)
+static void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	const struct s390_aes_ctx *sctx = ctx;
+	const struct s390_aes_ctx *sctx = crypto_tfm_ctx(tfm);
 
 	switch (sctx->key_len) {
 	case 16:
@@ -90,9 +90,9 @@ static void aes_encrypt(void *ctx, u8 *o
 	}
 }
 
-static void aes_decrypt(void *ctx, u8 *out, const u8 *in)
+static void aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	const struct s390_aes_ctx *sctx = ctx;
+	const struct s390_aes_ctx *sctx = crypto_tfm_ctx(tfm);
 
 	switch (sctx->key_len) {
 	case 16:
diff --git a/arch/s390/crypto/des_s390.c b/arch/s390/crypto/des_s390.c
--- a/arch/s390/crypto/des_s390.c
+++ b/arch/s390/crypto/des_s390.c
@@ -44,10 +44,10 @@ struct crypt_s390_des3_192_ctx {
 	u8 key[DES3_192_KEY_SIZE];
 };
 
-static int des_setkey(void *ctx, const u8 *key, unsigned int keylen,
-		      u32 *flags)
+static int des_setkey(struct crypto_tfm *tfm, const u8 *key,
+		      unsigned int keylen, u32 *flags)
 {
-	struct crypt_s390_des_ctx *dctx = ctx;
+	struct crypt_s390_des_ctx *dctx = crypto_tfm_ctx(tfm);
 	int ret;
 
 	/* test if key is valid (not a weak key) */
@@ -57,16 +57,16 @@ static int des_setkey(void *ctx, const u
 	return ret;
 }
 
-static void des_encrypt(void *ctx, u8 *out, const u8 *in)
+static void des_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	struct crypt_s390_des_ctx *dctx = ctx;
+	struct crypt_s390_des_ctx *dctx = crypto_tfm_ctx(tfm);
 
 	crypt_s390_km(KM_DEA_ENCRYPT, dctx->key, out, in, DES_BLOCK_SIZE);
 }
 
-static void des_decrypt(void *ctx, u8 *out, const u8 *in)
+static void des_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	struct crypt_s390_des_ctx *dctx = ctx;
+	struct crypt_s390_des_ctx *dctx = crypto_tfm_ctx(tfm);
 
 	crypt_s390_km(KM_DEA_DECRYPT, dctx->key, out, in, DES_BLOCK_SIZE);
 }
@@ -166,11 +166,11 @@ static struct crypto_alg des_alg = {
  *   Implementers MUST reject keys that exhibit this property.
  *
  */
-static int des3_128_setkey(void *ctx, const u8 *key, unsigned int keylen,
-			   u32 *flags)
+static int des3_128_setkey(struct crypto_tfm *tfm, const u8 *key,
+			   unsigned int keylen, u32 *flags)
 {
 	int i, ret;
-	struct crypt_s390_des3_128_ctx *dctx = ctx;
+	struct crypt_s390_des3_128_ctx *dctx = crypto_tfm_ctx(tfm);
 	const u8* temp_key = key;
 
 	if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE))) {
@@ -186,17 +186,17 @@ static int des3_128_setkey(void *ctx, co
 	return 0;
 }
 
-static void des3_128_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void des3_128_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct crypt_s390_des3_128_ctx *dctx = ctx;
+	struct crypt_s390_des3_128_ctx *dctx = crypto_tfm_ctx(tfm);
 
 	crypt_s390_km(KM_TDEA_128_ENCRYPT, dctx->key, dst, (void*)src,
 		      DES3_128_BLOCK_SIZE);
 }
 
-static void des3_128_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void des3_128_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct crypt_s390_des3_128_ctx *dctx = ctx;
+	struct crypt_s390_des3_128_ctx *dctx = crypto_tfm_ctx(tfm);
 
 	crypt_s390_km(KM_TDEA_128_DECRYPT, dctx->key, dst, (void*)src,
 		      DES3_128_BLOCK_SIZE);
@@ -302,11 +302,11 @@ static struct crypto_alg des3_128_alg = 
  *   property.
  *
  */
-static int des3_192_setkey(void *ctx, const u8 *key, unsigned int keylen,
-			   u32 *flags)
+static int des3_192_setkey(struct crypto_tfm *tfm, const u8 *key,
+			   unsigned int keylen, u32 *flags)
 {
 	int i, ret;
-	struct crypt_s390_des3_192_ctx *dctx = ctx;
+	struct crypt_s390_des3_192_ctx *dctx = crypto_tfm_ctx(tfm);
 	const u8* temp_key = key;
 
 	if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE) &&
@@ -325,17 +325,17 @@ static int des3_192_setkey(void *ctx, co
 	return 0;
 }
 
-static void des3_192_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void des3_192_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct crypt_s390_des3_192_ctx *dctx = ctx;
+	struct crypt_s390_des3_192_ctx *dctx = crypto_tfm_ctx(tfm);
 
 	crypt_s390_km(KM_TDEA_192_ENCRYPT, dctx->key, dst, (void*)src,
 		      DES3_192_BLOCK_SIZE);
 }
 
-static void des3_192_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void des3_192_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct crypt_s390_des3_192_ctx *dctx = ctx;
+	struct crypt_s390_des3_192_ctx *dctx = crypto_tfm_ctx(tfm);
 
 	crypt_s390_km(KM_TDEA_192_DECRYPT, dctx->key, dst, (void*)src,
 		      DES3_192_BLOCK_SIZE);
diff --git a/arch/s390/crypto/sha1_s390.c b/arch/s390/crypto/sha1_s390.c
--- a/arch/s390/crypto/sha1_s390.c
+++ b/arch/s390/crypto/sha1_s390.c
@@ -40,9 +40,9 @@ struct crypt_s390_sha1_ctx {
 	u8 buffer[2 * SHA1_BLOCK_SIZE];
 };
 
-static void sha1_init(void *ctx_arg) 
+static void sha1_init(struct crypto_tfm *tfm)
 {
-	struct crypt_s390_sha1_ctx *ctx = ctx_arg;
+	struct crypt_s390_sha1_ctx *ctx = crypto_tfm_ctx(tfm);
 	static const u32 initstate[5] = {
 		0x67452301,
 		0xEFCDAB89,
@@ -53,13 +53,13 @@ static void sha1_init(void *ctx_arg) 
 	memcpy(ctx->state, &initstate, sizeof(initstate));
 }
 
-static void
-sha1_update(void *ctx, const u8 *data, unsigned int len)
+static void sha1_update(struct crypto_tfm *tfm, const u8 *data,
+			unsigned int len)
 {
 	struct crypt_s390_sha1_ctx *sctx;
 	long imd_len;
 
-	sctx = ctx;
+	sctx = crypto_tfm_ctx(tfm);
 	sctx->count += len * 8; //message bit length
 
 	//anything in buffer yet? -> must be completed
@@ -108,10 +108,9 @@ pad_message(struct crypt_s390_sha1_ctx* 
 }
 
 /* Add padding and return the message digest. */
-static void
-sha1_final(void* ctx, u8 *out)
+static void sha1_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct crypt_s390_sha1_ctx *sctx = ctx;
+	struct crypt_s390_sha1_ctx *sctx = crypto_tfm_ctx(tfm);
 
 	//must perform manual padding
 	pad_message(sctx);
diff --git a/arch/s390/crypto/sha256_s390.c b/arch/s390/crypto/sha256_s390.c
--- a/arch/s390/crypto/sha256_s390.c
+++ b/arch/s390/crypto/sha256_s390.c
@@ -31,9 +31,9 @@ struct s390_sha256_ctx {
 	u8 buf[2 * SHA256_BLOCK_SIZE];
 };
 
-static void sha256_init(void *ctx)
+static void sha256_init(struct crypto_tfm *tfm)
 {
-	struct s390_sha256_ctx *sctx = ctx;
+	struct s390_sha256_ctx *sctx = crypto_tfm_ctx(tfm);
 
 	sctx->state[0] = 0x6a09e667;
 	sctx->state[1] = 0xbb67ae85;
@@ -45,9 +45,10 @@ static void sha256_init(void *ctx)
 	sctx->state[7] = 0x5be0cd19;
 }
 
-static void sha256_update(void *ctx, const u8 *data, unsigned int len)
+static void sha256_update(struct crypto_tfm *tfm, const u8 *data,
+			  unsigned int len)
 {
-	struct s390_sha256_ctx *sctx = ctx;
+	struct s390_sha256_ctx *sctx = crypto_tfm_ctx(tfm);
 	unsigned int index;
 	int ret;
 
@@ -106,9 +107,9 @@ static void pad_message(struct s390_sha2
 }
 
 /* Add padding and return the message digest */
-static void sha256_final(void* ctx, u8 *out)
+static void sha256_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct s390_sha256_ctx *sctx = ctx;
+	struct s390_sha256_ctx *sctx = crypto_tfm_ctx(tfm);
 
 	/* must perform manual padding */
 	pad_message(sctx);
diff --git a/arch/x86_64/crypto/aes-x86_64-asm.S b/arch/x86_64/crypto/aes-x86_64-asm.S
--- a/arch/x86_64/crypto/aes-x86_64-asm.S
+++ b/arch/x86_64/crypto/aes-x86_64-asm.S
@@ -15,6 +15,10 @@
 
 .text
 
+#include <asm/asm-offsets.h>
+
+#define BASE crypto_tfm_ctx_offset
+
 #define R1	%rax
 #define R1E	%eax
 #define R1X	%ax
@@ -46,19 +50,19 @@
 #define R10	%r10
 #define R11	%r11
 
-#define prologue(FUNC,BASE,B128,B192,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11) \
+#define prologue(FUNC,KEY,B128,B192,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11) \
 	.global	FUNC;			\
 	.type	FUNC,@function;		\
 	.align	8;			\
 FUNC:	movq	r1,r2;			\
 	movq	r3,r4;			\
-	leaq	BASE+52(r8),r9;		\
+	leaq	BASE+KEY+52(r8),r9;	\
 	movq	r10,r11;		\
 	movl	(r7),r5 ## E;		\
 	movl	4(r7),r1 ## E;		\
 	movl	8(r7),r6 ## E;		\
 	movl	12(r7),r7 ## E;		\
-	movl	(r8),r10 ## E;		\
+	movl	BASE(r8),r10 ## E;	\
 	xorl	-48(r9),r5 ## E;	\
 	xorl	-44(r9),r1 ## E;	\
 	xorl	-40(r9),r6 ## E;	\
@@ -128,8 +132,8 @@ FUNC:	movq	r1,r2;			\
 	movl	r3 ## E,r1 ## E;	\
 	movl	r4 ## E,r2 ## E;
 
-#define entry(FUNC,BASE,B128,B192) \
-	prologue(FUNC,BASE,B128,B192,R2,R8,R7,R9,R1,R3,R4,R6,R10,R5,R11)
+#define entry(FUNC,KEY,B128,B192) \
+	prologue(FUNC,KEY,B128,B192,R2,R8,R7,R9,R1,R3,R4,R6,R10,R5,R11)
 
 #define return epilogue(R8,R2,R9,R7,R5,R6,R3,R4,R11)
 
@@ -147,7 +151,7 @@ FUNC:	movq	r1,r2;			\
 #define decrypt_final(TAB,OFFSET) \
 	round(TAB,OFFSET,R2,R1,R4,R3,R6,R5,R7,R10,R5,R6,R3,R4)
 
-/* void aes_encrypt(void *ctx, u8 *out, const u8 *in) */
+/* void aes_encrypt(stuct crypto_tfm *tfm, u8 *out, const u8 *in) */
 
 	entry(aes_encrypt,0,enc128,enc192)
 	encrypt_round(aes_ft_tab,-96)
@@ -166,7 +170,7 @@ enc128:	encrypt_round(aes_ft_tab,-32)
 	encrypt_final(aes_fl_tab,112)
 	return
 
-/* void aes_decrypt(void *ctx, u8 *out, const u8 *in) */
+/* void aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in) */
 
 	entry(aes_decrypt,240,dec128,dec192)
 	decrypt_round(aes_it_tab,-96)
diff --git a/arch/x86_64/crypto/aes.c b/arch/x86_64/crypto/aes.c
--- a/arch/x86_64/crypto/aes.c
+++ b/arch/x86_64/crypto/aes.c
@@ -227,10 +227,10 @@ static void __init gen_tabs(void)
 	t ^= E_KEY[8 * i + 7]; E_KEY[8 * i + 15] = t;	\
 }
 
-static int aes_set_key(void *ctx_arg, const u8 *in_key, unsigned int key_len,
-		       u32 *flags)
+static int aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
+		       unsigned int key_len, u32 *flags)
 {
-	struct aes_ctx *ctx = ctx_arg;
+	struct aes_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *key = (const __le32 *)in_key;
 	u32 i, j, t, u, v, w;
 
@@ -283,8 +283,8 @@ static int aes_set_key(void *ctx_arg, co
 	return 0;
 }
 
-extern void aes_encrypt(void *ctx_arg, u8 *out, const u8 *in);
-extern void aes_decrypt(void *ctx_arg, u8 *out, const u8 *in);
+extern void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in);
+extern void aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in);
 
 static struct crypto_alg aes_alg = {
 	.cra_name		=	"aes",
diff --git a/arch/x86_64/kernel/asm-offsets.c b/arch/x86_64/kernel/asm-offsets.c
--- a/arch/x86_64/kernel/asm-offsets.c
+++ b/arch/x86_64/kernel/asm-offsets.c
@@ -4,6 +4,7 @@
  * and format the required data.
  */
 
+#include <linux/crypto.h>
 #include <linux/sched.h> 
 #include <linux/stddef.h>
 #include <linux/errno.h> 
@@ -68,5 +69,7 @@ int main(void)
 	DEFINE(pbe_next, offsetof(struct pbe, next));
 	BLANK();
 	DEFINE(TSS_ist, offsetof(struct tss_struct, ist));
+	BLANK();
+	DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
 	return 0;
 }
diff --git a/crypto/aes.c b/crypto/aes.c
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -248,10 +248,10 @@ gen_tabs (void)
     t ^= E_KEY[8 * i + 7]; E_KEY[8 * i + 15] = t;   \
 }
 
-static int
-aes_set_key(void *ctx_arg, const u8 *in_key, unsigned int key_len, u32 *flags)
+static int aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
+		       unsigned int key_len, u32 *flags)
 {
-	struct aes_ctx *ctx = ctx_arg;
+	struct aes_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *key = (const __le32 *)in_key;
 	u32 i, t, u, v, w;
 
@@ -318,9 +318,9 @@ aes_set_key(void *ctx_arg, const u8 *in_
     f_rl(bo, bi, 2, k);     \
     f_rl(bo, bi, 3, k)
 
-static void aes_encrypt(void *ctx_arg, u8 *out, const u8 *in)
+static void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	const struct aes_ctx *ctx = ctx_arg;
+	const struct aes_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *src = (const __le32 *)in;
 	__le32 *dst = (__le32 *)out;
 	u32 b0[4], b1[4];
@@ -373,9 +373,9 @@ static void aes_encrypt(void *ctx_arg, u
     i_rl(bo, bi, 2, k);     \
     i_rl(bo, bi, 3, k)
 
-static void aes_decrypt(void *ctx_arg, u8 *out, const u8 *in)
+static void aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	const struct aes_ctx *ctx = ctx_arg;
+	const struct aes_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *src = (const __le32 *)in;
 	__le32 *dst = (__le32 *)out;
 	u32 b0[4], b1[4];
diff --git a/crypto/anubis.c b/crypto/anubis.c
--- a/crypto/anubis.c
+++ b/crypto/anubis.c
@@ -460,16 +460,15 @@ static const u32 rc[] = {
 	0xf726ffedU, 0xe89d6f8eU, 0x19a0f089U,
 };
 
-static int anubis_setkey(void *ctx_arg, const u8 *in_key,
+static int anubis_setkey(struct crypto_tfm *tfm, const u8 *in_key,
 			 unsigned int key_len, u32 *flags)
 {
+	struct anubis_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __be32 *key = (const __be32 *)in_key;
 	int N, R, i, r;
 	u32 kappa[ANUBIS_MAX_N];
 	u32 inter[ANUBIS_MAX_N];
 
-	struct anubis_ctx *ctx = ctx_arg;
-
 	switch (key_len)
 	{
 		case 16: case 20: case 24: case 28:
@@ -660,15 +659,15 @@ static void anubis_crypt(u32 roundKey[AN
 		dst[i] = cpu_to_be32(inter[i]);
 }
 
-static void anubis_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
+static void anubis_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct anubis_ctx *ctx = ctx_arg;
+	struct anubis_ctx *ctx = crypto_tfm_ctx(tfm);
 	anubis_crypt(ctx->E, dst, src, ctx->R);
 }
 
-static void anubis_decrypt(void *ctx_arg, u8 *dst, const u8 *src)
+static void anubis_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct anubis_ctx *ctx = ctx_arg;
+	struct anubis_ctx *ctx = crypto_tfm_ctx(tfm);
 	anubis_crypt(ctx->D, dst, src, ctx->R);
 }
 
diff --git a/crypto/arc4.c b/crypto/arc4.c
--- a/crypto/arc4.c
+++ b/crypto/arc4.c
@@ -24,9 +24,10 @@ struct arc4_ctx {
 	u8 x, y;
 };
 
-static int arc4_set_key(void *ctx_arg, const u8 *in_key, unsigned int key_len, u32 *flags)
+static int arc4_set_key(struct crypto_tfm *tfm, const u8 *in_key,
+			unsigned int key_len, u32 *flags)
 {
-	struct arc4_ctx *ctx = ctx_arg;
+	struct arc4_ctx *ctx = crypto_tfm_ctx(tfm);
 	int i, j = 0, k = 0;
 
 	ctx->x = 1;
@@ -48,9 +49,9 @@ static int arc4_set_key(void *ctx_arg, c
 	return 0;
 }
 
-static void arc4_crypt(void *ctx_arg, u8 *out, const u8 *in)
+static void arc4_crypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	struct arc4_ctx *ctx = ctx_arg;
+	struct arc4_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	u8 *const S = ctx->S;
 	u8 x = ctx->x;
diff --git a/crypto/blowfish.c b/crypto/blowfish.c
--- a/crypto/blowfish.c
+++ b/crypto/blowfish.c
@@ -349,7 +349,7 @@ static void encrypt_block(struct bf_ctx 
 	dst[1] = yl;
 }
 
-static void bf_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void bf_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
 	const __be32 *in_blk = (const __be32 *)src;
 	__be32 *const out_blk = (__be32 *)dst;
@@ -357,17 +357,18 @@ static void bf_encrypt(void *ctx, u8 *ds
 
 	in32[0] = be32_to_cpu(in_blk[0]);
 	in32[1] = be32_to_cpu(in_blk[1]);
-	encrypt_block(ctx, out32, in32);
+	encrypt_block(crypto_tfm_ctx(tfm), out32, in32);
 	out_blk[0] = cpu_to_be32(out32[0]);
 	out_blk[1] = cpu_to_be32(out32[1]);
 }
 
-static void bf_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void bf_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
+	struct bf_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __be32 *in_blk = (const __be32 *)src;
 	__be32 *const out_blk = (__be32 *)dst;
-	const u32 *P = ((struct bf_ctx *)ctx)->p;
-	const u32 *S = ((struct bf_ctx *)ctx)->s;
+	const u32 *P = ctx->p;
+	const u32 *S = ctx->s;
 	u32 yl = be32_to_cpu(in_blk[0]);
 	u32 yr = be32_to_cpu(in_blk[1]);
 
@@ -398,12 +399,14 @@ static void bf_decrypt(void *ctx, u8 *ds
 /* 
  * Calculates the blowfish S and P boxes for encryption and decryption.
  */
-static int bf_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+static int bf_setkey(struct crypto_tfm *tfm, const u8 *key,
+		     unsigned int keylen, u32 *flags)
 {
+	struct bf_ctx *ctx = crypto_tfm_ctx(tfm);
+	u32 *P = ctx->p;
+	u32 *S = ctx->s;
 	short i, j, count;
 	u32 data[2], temp;
-	u32 *P = ((struct bf_ctx *)ctx)->p;
-	u32 *S = ((struct bf_ctx *)ctx)->s;
 
 	/* Copy the initialization s-boxes */
 	for (i = 0, count = 0; i < 256; i++)
diff --git a/crypto/cast5.c b/crypto/cast5.c
--- a/crypto/cast5.c
+++ b/crypto/cast5.c
@@ -577,9 +577,9 @@ static const u32 sb8[256] = {
     (((s1[I >> 24] + s2[(I>>16)&0xff]) ^ s3[(I>>8)&0xff]) - s4[I&0xff]) )
 
 
-static void cast5_encrypt(void *ctx, u8 * outbuf, const u8 * inbuf)
+static void cast5_encrypt(struct crypto_tfm *tfm, u8 *outbuf, const u8 *inbuf)
 {
-	struct cast5_ctx *c = (struct cast5_ctx *) ctx;
+	struct cast5_ctx *c = crypto_tfm_ctx(tfm);
 	const __be32 *src = (const __be32 *)inbuf;
 	__be32 *dst = (__be32 *)outbuf;
 	u32 l, r, t;
@@ -642,9 +642,9 @@ static void cast5_encrypt(void *ctx, u8 
 	dst[1] = cpu_to_be32(l);
 }
 
-static void cast5_decrypt(void *ctx, u8 * outbuf, const u8 * inbuf)
+static void cast5_decrypt(struct crypto_tfm *tfm, u8 *outbuf, const u8 *inbuf)
 {
-	struct cast5_ctx *c = (struct cast5_ctx *) ctx;
+	struct cast5_ctx *c = crypto_tfm_ctx(tfm);
 	const __be32 *src = (const __be32 *)inbuf;
 	__be32 *dst = (__be32 *)outbuf;
 	u32 l, r, t;
@@ -769,15 +769,15 @@ static void key_schedule(u32 * x, u32 * 
 }
 
 
-static int
-cast5_setkey(void *ctx, const u8 * key, unsigned key_len, u32 * flags)
+static int cast5_setkey(struct crypto_tfm *tfm, const u8 *key,
+			unsigned key_len, u32 *flags)
 {
+	struct cast5_ctx *c = crypto_tfm_ctx(tfm);
 	int i;
 	u32 x[4];
 	u32 z[4];
 	u32 k[16];
 	__be32 p_key[4];
-	struct cast5_ctx *c = (struct cast5_ctx *) ctx;
 	
 	if (key_len < 5 || key_len > 16) {
 		*flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
diff --git a/crypto/cast6.c b/crypto/cast6.c
--- a/crypto/cast6.c
+++ b/crypto/cast6.c
@@ -381,13 +381,13 @@ static inline void W(u32 *key, unsigned 
 	key[7] ^= F2(key[0], Tr[i % 4][7], Tm[i][7]);
 }
 
-static int
-cast6_setkey(void *ctx, const u8 * in_key, unsigned key_len, u32 * flags)
+static int cast6_setkey(struct crypto_tfm *tfm, const u8 *in_key,
+			unsigned key_len, u32 *flags)
 {
 	int i;
 	u32 key[8];
 	__be32 p_key[8]; /* padded key */
-	struct cast6_ctx *c = (struct cast6_ctx *) ctx;
+	struct cast6_ctx *c = crypto_tfm_ctx(tfm);
 
 	if (key_len < 16 || key_len > 32 || key_len % 4 != 0) {
 		*flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
@@ -444,8 +444,9 @@ static inline void QBAR (u32 * block, u8
         block[2] ^= F1(block[3], Kr[0], Km[0]);
 }
 
-static void cast6_encrypt (void * ctx, u8 * outbuf, const u8 * inbuf) {
-	struct cast6_ctx * c = (struct cast6_ctx *)ctx;
+static void cast6_encrypt(struct crypto_tfm *tfm, u8 *outbuf, const u8 *inbuf)
+{
+	struct cast6_ctx *c = crypto_tfm_ctx(tfm);
 	const __be32 *src = (const __be32 *)inbuf;
 	__be32 *dst = (__be32 *)outbuf;
 	u32 block[4];
@@ -476,8 +477,8 @@ static void cast6_encrypt (void * ctx, u
 	dst[3] = cpu_to_be32(block[3]);
 }	
 
-static void cast6_decrypt (void * ctx, u8 * outbuf, const u8 * inbuf) {
-	struct cast6_ctx * c = (struct cast6_ctx *)ctx;
+static void cast6_decrypt(struct crypto_tfm *tfm, u8 *outbuf, const u8 *inbuf) {
+	struct cast6_ctx * c = crypto_tfm_ctx(tfm);
 	const __be32 *src = (const __be32 *)inbuf;
 	__be32 *dst = (__be32 *)outbuf;
 	u32 block[4];
diff --git a/crypto/cipher.c b/crypto/cipher.c
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -187,7 +187,7 @@ static unsigned int cbc_process_encrypt(
 	void (*xor)(u8 *, const u8 *) = tfm->crt_u.cipher.cit_xor_block;
 	int bsize = crypto_tfm_alg_blocksize(tfm);
 
-	void (*fn)(void *, u8 *, const u8 *) = desc->crfn;
+	void (*fn)(struct crypto_tfm *, u8 *, const u8 *) = desc->crfn;
 	u8 *iv = desc->info;
 	unsigned int done = 0;
 
@@ -195,7 +195,7 @@ static unsigned int cbc_process_encrypt(
 
 	do {
 		xor(iv, src);
-		fn(crypto_tfm_ctx(tfm), dst, iv);
+		fn(tfm, dst, iv);
 		memcpy(iv, dst, bsize);
 
 		src += bsize;
@@ -218,7 +218,7 @@ static unsigned int cbc_process_decrypt(
 	u8 *buf = (u8 *)ALIGN((unsigned long)stack, alignmask + 1);
 	u8 **dst_p = src == dst ? &buf : &dst;
 
-	void (*fn)(void *, u8 *, const u8 *) = desc->crfn;
+	void (*fn)(struct crypto_tfm *, u8 *, const u8 *) = desc->crfn;
 	u8 *iv = desc->info;
 	unsigned int done = 0;
 
@@ -227,7 +227,7 @@ static unsigned int cbc_process_decrypt(
 	do {
 		u8 *tmp_dst = *dst_p;
 
-		fn(crypto_tfm_ctx(tfm), tmp_dst, src);
+		fn(tfm, tmp_dst, src);
 		xor(tmp_dst, iv);
 		memcpy(iv, src, bsize);
 		if (tmp_dst != dst)
@@ -245,13 +245,13 @@ static unsigned int ecb_process(const st
 {
 	struct crypto_tfm *tfm = desc->tfm;
 	int bsize = crypto_tfm_alg_blocksize(tfm);
-	void (*fn)(void *, u8 *, const u8 *) = desc->crfn;
+	void (*fn)(struct crypto_tfm *, u8 *, const u8 *) = desc->crfn;
 	unsigned int done = 0;
 
 	nbytes -= bsize;
 
 	do {
-		fn(crypto_tfm_ctx(tfm), dst, src);
+		fn(tfm, dst, src);
 
 		src += bsize;
 		dst += bsize;
@@ -268,7 +268,7 @@ static int setkey(struct crypto_tfm *tfm
 		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
 		return -EINVAL;
 	} else
-		return cia->cia_setkey(crypto_tfm_ctx(tfm), key, keylen,
+		return cia->cia_setkey(tfm, key, keylen,
 		                       &tfm->crt_flags);
 }
 
diff --git a/crypto/compress.c b/crypto/compress.c
--- a/crypto/compress.c
+++ b/crypto/compress.c
@@ -22,8 +22,7 @@ static int crypto_compress(struct crypto
                             const u8 *src, unsigned int slen,
                             u8 *dst, unsigned int *dlen)
 {
-	return tfm->__crt_alg->cra_compress.coa_compress(crypto_tfm_ctx(tfm),
-	                                                 src, slen, dst,
+	return tfm->__crt_alg->cra_compress.coa_compress(tfm, src, slen, dst,
 	                                                 dlen);
 }
 
@@ -31,8 +30,7 @@ static int crypto_decompress(struct cryp
                              const u8 *src, unsigned int slen,
                              u8 *dst, unsigned int *dlen)
 {
-	return tfm->__crt_alg->cra_compress.coa_decompress(crypto_tfm_ctx(tfm),
-	                                                   src, slen, dst,
+	return tfm->__crt_alg->cra_compress.coa_decompress(tfm, src, slen, dst,
 	                                                   dlen);
 }
 
diff --git a/crypto/crc32c.c b/crypto/crc32c.c
--- a/crypto/crc32c.c
+++ b/crypto/crc32c.c
@@ -31,9 +31,9 @@ struct chksum_ctx {
  * crc using table.
  */
 
-static void chksum_init(void *ctx)
+static void chksum_init(struct crypto_tfm *tfm)
 {
-	struct chksum_ctx *mctx = ctx;
+	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
 
 	mctx->crc = ~(u32)0;			/* common usage */
 }
@@ -43,10 +43,10 @@ static void chksum_init(void *ctx)
  * If your algorithm starts with ~0, then XOR with ~0 before you set
  * the seed.
  */
-static int chksum_setkey(void *ctx, const u8 *key, unsigned int keylen,
-	                  u32 *flags)
+static int chksum_setkey(struct crypto_tfm *tfm, const u8 *key,
+			 unsigned int keylen, u32 *flags)
 {
-	struct chksum_ctx *mctx = ctx;
+	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
 
 	if (keylen != sizeof(mctx->crc)) {
 		if (flags)
@@ -57,9 +57,10 @@ static int chksum_setkey(void *ctx, cons
 	return 0;
 }
 
-static void chksum_update(void *ctx, const u8 *data, unsigned int length)
+static void chksum_update(struct crypto_tfm *tfm, const u8 *data,
+			  unsigned int length)
 {
-	struct chksum_ctx *mctx = ctx;
+	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
 	u32 mcrc;
 
 	mcrc = crc32c(mctx->crc, data, (size_t)length);
@@ -67,9 +68,9 @@ static void chksum_update(void *ctx, con
 	mctx->crc = mcrc;
 }
 
-static void chksum_final(void *ctx, u8 *out)
+static void chksum_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct chksum_ctx *mctx = ctx;
+	struct chksum_ctx *mctx = crypto_tfm_ctx(tfm);
 	u32 mcrc = (mctx->crc ^ ~(u32)0);
 	
 	*(u32 *)out = __le32_to_cpu(mcrc);
diff --git a/crypto/crypto_null.c b/crypto/crypto_null.c
--- a/crypto/crypto_null.c
+++ b/crypto/crypto_null.c
@@ -27,8 +27,8 @@
 #define NULL_BLOCK_SIZE		1
 #define NULL_DIGEST_SIZE	0
 
-static int null_compress(void *ctx, const u8 *src, unsigned int slen,
-                         u8 *dst, unsigned int *dlen)
+static int null_compress(struct crypto_tfm *tfm, const u8 *src,
+			 unsigned int slen, u8 *dst, unsigned int *dlen)
 {
 	if (slen > *dlen)
 		return -EINVAL;
@@ -37,20 +37,21 @@ static int null_compress(void *ctx, cons
 	return 0;
 }
 
-static void null_init(void *ctx)
+static void null_init(struct crypto_tfm *tfm)
 { }
 
-static void null_update(void *ctx, const u8 *data, unsigned int len)
+static void null_update(struct crypto_tfm *tfm, const u8 *data,
+			unsigned int len)
 { }
 
-static void null_final(void *ctx, u8 *out)
+static void null_final(struct crypto_tfm *tfm, u8 *out)
 { }
 
-static int null_setkey(void *ctx, const u8 *key,
-                       unsigned int keylen, u32 *flags)
+static int null_setkey(struct crypto_tfm *tfm, const u8 *key,
+		       unsigned int keylen, u32 *flags)
 { return 0; }
 
-static void null_crypt(void *ctx, u8 *dst, const u8 *src)
+static void null_crypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
 	memcpy(dst, src, NULL_BLOCK_SIZE);
 }
diff --git a/crypto/deflate.c b/crypto/deflate.c
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -102,8 +102,9 @@ static void deflate_decomp_exit(struct d
 	kfree(ctx->decomp_stream.workspace);
 }
 
-static int deflate_init(void *ctx)
+static int deflate_init(struct crypto_tfm *tfm)
 {
+	struct deflate_ctx *ctx = crypto_tfm_ctx(tfm);
 	int ret;
 	
 	ret = deflate_comp_init(ctx);
@@ -116,17 +117,19 @@ out:
 	return ret;
 }
 
-static void deflate_exit(void *ctx)
+static void deflate_exit(struct crypto_tfm *tfm)
 {
+	struct deflate_ctx *ctx = crypto_tfm_ctx(tfm);
+
 	deflate_comp_exit(ctx);
 	deflate_decomp_exit(ctx);
 }
 
-static int deflate_compress(void *ctx, const u8 *src, unsigned int slen,
-	                    u8 *dst, unsigned int *dlen)
+static int deflate_compress(struct crypto_tfm *tfm, const u8 *src,
+			    unsigned int slen, u8 *dst, unsigned int *dlen)
 {
 	int ret = 0;
-	struct deflate_ctx *dctx = ctx;
+	struct deflate_ctx *dctx = crypto_tfm_ctx(tfm);
 	struct z_stream_s *stream = &dctx->comp_stream;
 
 	ret = zlib_deflateReset(stream);
@@ -151,12 +154,12 @@ out:
 	return ret;
 }
  
-static int deflate_decompress(void *ctx, const u8 *src, unsigned int slen,
-                              u8 *dst, unsigned int *dlen)
+static int deflate_decompress(struct crypto_tfm *tfm, const u8 *src,
+			      unsigned int slen, u8 *dst, unsigned int *dlen)
 {
 	
 	int ret = 0;
-	struct deflate_ctx *dctx = ctx;
+	struct deflate_ctx *dctx = crypto_tfm_ctx(tfm);
 	struct z_stream_s *stream = &dctx->decomp_stream;
 
 	ret = zlib_inflateReset(stream);
diff --git a/crypto/des.c b/crypto/des.c
--- a/crypto/des.c
+++ b/crypto/des.c
@@ -783,9 +783,10 @@ static void dkey(u32 *pe, const u8 *k)
 	}
 }
 
-static int des_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+static int des_setkey(struct crypto_tfm *tfm, const u8 *key,
+		      unsigned int keylen, u32 *flags)
 {
-	struct des_ctx *dctx = ctx;
+	struct des_ctx *dctx = crypto_tfm_ctx(tfm);
 	u32 tmp[DES_EXPKEY_WORDS];
 	int ret;
 
@@ -803,9 +804,10 @@ static int des_setkey(void *ctx, const u
 	return 0;
 }
 
-static void des_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void des_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	const u32 *K = ((struct des_ctx *)ctx)->expkey;
+	struct des_ctx *ctx = crypto_tfm_ctx(tfm);
+	const u32 *K = ctx->expkey;
 	const __le32 *s = (const __le32 *)src;
 	__le32 *d = (__le32 *)dst;
 	u32 L, R, A, B;
@@ -825,9 +827,10 @@ static void des_encrypt(void *ctx, u8 *d
 	d[1] = cpu_to_le32(L);
 }
 
-static void des_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void des_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	const u32 *K = ((struct des_ctx *)ctx)->expkey + DES_EXPKEY_WORDS - 2;
+	struct des_ctx *ctx = crypto_tfm_ctx(tfm);
+	const u32 *K = ctx->expkey + DES_EXPKEY_WORDS - 2;
 	const __le32 *s = (const __le32 *)src;
 	__le32 *d = (__le32 *)dst;
 	u32 L, R, A, B;
@@ -860,11 +863,11 @@ static void des_decrypt(void *ctx, u8 *d
  *   property.
  *
  */
-static int des3_ede_setkey(void *ctx, const u8 *key,
+static int des3_ede_setkey(struct crypto_tfm *tfm, const u8 *key,
 			   unsigned int keylen, u32 *flags)
 {
 	const u32 *K = (const u32 *)key;
-	struct des3_ede_ctx *dctx = ctx;
+	struct des3_ede_ctx *dctx = crypto_tfm_ctx(tfm);
 	u32 *expkey = dctx->expkey;
 
 	if (unlikely(!((K[0] ^ K[2]) | (K[1] ^ K[3])) ||
@@ -881,9 +884,9 @@ static int des3_ede_setkey(void *ctx, co
 	return 0;
 }
 
-static void des3_ede_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void des3_ede_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct des3_ede_ctx *dctx = ctx;
+	struct des3_ede_ctx *dctx = crypto_tfm_ctx(tfm);
 	const u32 *K = dctx->expkey;
 	const __le32 *s = (const __le32 *)src;
 	__le32 *d = (__le32 *)dst;
@@ -912,9 +915,9 @@ static void des3_ede_encrypt(void *ctx, 
 	d[1] = cpu_to_le32(L);
 }
 
-static void des3_ede_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void des3_ede_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct des3_ede_ctx *dctx = ctx;
+	struct des3_ede_ctx *dctx = crypto_tfm_ctx(tfm);
 	const u32 *K = dctx->expkey + DES3_EDE_EXPKEY_WORDS - 2;
 	const __le32 *s = (const __le32 *)src;
 	__le32 *d = (__le32 *)dst;
diff --git a/crypto/digest.c b/crypto/digest.c
--- a/crypto/digest.c
+++ b/crypto/digest.c
@@ -20,7 +20,7 @@
 
 static void init(struct crypto_tfm *tfm)
 {
-	tfm->__crt_alg->cra_digest.dia_init(crypto_tfm_ctx(tfm));
+	tfm->__crt_alg->cra_digest.dia_init(tfm);
 }
 
 static void update(struct crypto_tfm *tfm,
@@ -46,16 +46,14 @@ static void update(struct crypto_tfm *tf
 				unsigned int bytes =
 					alignmask + 1 - (offset & alignmask);
 				bytes = min(bytes, bytes_from_page);
-				tfm->__crt_alg->cra_digest.dia_update
-						(crypto_tfm_ctx(tfm), p,
-						 bytes);
+				tfm->__crt_alg->cra_digest.dia_update(tfm, p,
+								      bytes);
 				p += bytes;
 				bytes_from_page -= bytes;
 				l -= bytes;
 			}
-			tfm->__crt_alg->cra_digest.dia_update
-					(crypto_tfm_ctx(tfm), p,
-					 bytes_from_page);
+			tfm->__crt_alg->cra_digest.dia_update(tfm, p,
+							      bytes_from_page);
 			crypto_kunmap(src, 0);
 			crypto_yield(tfm);
 			offset = 0;
@@ -83,8 +81,7 @@ static int setkey(struct crypto_tfm *tfm
 	u32 flags;
 	if (tfm->__crt_alg->cra_digest.dia_setkey == NULL)
 		return -ENOSYS;
-	return tfm->__crt_alg->cra_digest.dia_setkey(crypto_tfm_ctx(tfm),
-						     key, keylen, &flags);
+	return tfm->__crt_alg->cra_digest.dia_setkey(tfm, key, keylen, &flags);
 }
 
 static void digest(struct crypto_tfm *tfm,
diff --git a/crypto/khazad.c b/crypto/khazad.c
--- a/crypto/khazad.c
+++ b/crypto/khazad.c
@@ -754,10 +754,10 @@ static const u64 c[KHAZAD_ROUNDS + 1] = 
 	0xccc41d14c363da5dULL, 0x5fdc7dcd7f5a6c5cULL, 0xf726ffede89d6f8eULL
 };
 
-static int khazad_setkey(void *ctx_arg, const u8 *in_key,
-                       unsigned int key_len, u32 *flags)
+static int khazad_setkey(struct crypto_tfm *tfm, const u8 *in_key,
+			 unsigned int key_len, u32 *flags)
 {
-	struct khazad_ctx *ctx = ctx_arg;
+	struct khazad_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __be32 *key = (const __be32 *)in_key;
 	int r;
 	const u64 *S = T7;
@@ -841,15 +841,15 @@ static void khazad_crypt(const u64 round
 	*dst = cpu_to_be64(state);
 }
 
-static void khazad_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
+static void khazad_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct khazad_ctx *ctx = ctx_arg;
+	struct khazad_ctx *ctx = crypto_tfm_ctx(tfm);
 	khazad_crypt(ctx->E, dst, src);
 }
 
-static void khazad_decrypt(void *ctx_arg, u8 *dst, const u8 *src)
+static void khazad_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct khazad_ctx *ctx = ctx_arg;
+	struct khazad_ctx *ctx = crypto_tfm_ctx(tfm);
 	khazad_crypt(ctx->D, dst, src);
 }
 
diff --git a/crypto/md4.c b/crypto/md4.c
--- a/crypto/md4.c
+++ b/crypto/md4.c
@@ -152,9 +152,9 @@ static inline void md4_transform_helper(
 	md4_transform(ctx->hash, ctx->block);
 }
 
-static void md4_init(void *ctx)
+static void md4_init(struct crypto_tfm *tfm)
 {
-	struct md4_ctx *mctx = ctx;
+	struct md4_ctx *mctx = crypto_tfm_ctx(tfm);
 
 	mctx->hash[0] = 0x67452301;
 	mctx->hash[1] = 0xefcdab89;
@@ -163,9 +163,9 @@ static void md4_init(void *ctx)
 	mctx->byte_count = 0;
 }
 
-static void md4_update(void *ctx, const u8 *data, unsigned int len)
+static void md4_update(struct crypto_tfm *tfm, const u8 *data, unsigned int len)
 {
-	struct md4_ctx *mctx = ctx;
+	struct md4_ctx *mctx = crypto_tfm_ctx(tfm);
 	const u32 avail = sizeof(mctx->block) - (mctx->byte_count & 0x3f);
 
 	mctx->byte_count += len;
@@ -193,9 +193,9 @@ static void md4_update(void *ctx, const 
 	memcpy(mctx->block, data, len);
 }
 
-static void md4_final(void *ctx, u8 *out)
+static void md4_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct md4_ctx *mctx = ctx;
+	struct md4_ctx *mctx = crypto_tfm_ctx(tfm);
 	const unsigned int offset = mctx->byte_count & 0x3f;
 	char *p = (char *)mctx->block + offset;
 	int padding = 56 - (offset + 1);
diff --git a/crypto/md5.c b/crypto/md5.c
--- a/crypto/md5.c
+++ b/crypto/md5.c
@@ -147,9 +147,9 @@ static inline void md5_transform_helper(
 	md5_transform(ctx->hash, ctx->block);
 }
 
-static void md5_init(void *ctx)
+static void md5_init(struct crypto_tfm *tfm)
 {
-	struct md5_ctx *mctx = ctx;
+	struct md5_ctx *mctx = crypto_tfm_ctx(tfm);
 
 	mctx->hash[0] = 0x67452301;
 	mctx->hash[1] = 0xefcdab89;
@@ -158,9 +158,9 @@ static void md5_init(void *ctx)
 	mctx->byte_count = 0;
 }
 
-static void md5_update(void *ctx, const u8 *data, unsigned int len)
+static void md5_update(struct crypto_tfm *tfm, const u8 *data, unsigned int len)
 {
-	struct md5_ctx *mctx = ctx;
+	struct md5_ctx *mctx = crypto_tfm_ctx(tfm);
 	const u32 avail = sizeof(mctx->block) - (mctx->byte_count & 0x3f);
 
 	mctx->byte_count += len;
@@ -188,9 +188,9 @@ static void md5_update(void *ctx, const 
 	memcpy(mctx->block, data, len);
 }
 
-static void md5_final(void *ctx, u8 *out)
+static void md5_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct md5_ctx *mctx = ctx;
+	struct md5_ctx *mctx = crypto_tfm_ctx(tfm);
 	const unsigned int offset = mctx->byte_count & 0x3f;
 	char *p = (char *)mctx->block + offset;
 	int padding = 56 - (offset + 1);
diff --git a/crypto/michael_mic.c b/crypto/michael_mic.c
--- a/crypto/michael_mic.c
+++ b/crypto/michael_mic.c
@@ -45,16 +45,17 @@ do {				\
 } while (0)
 
 
-static void michael_init(void *ctx)
+static void michael_init(struct crypto_tfm *tfm)
 {
-	struct michael_mic_ctx *mctx = ctx;
+	struct michael_mic_ctx *mctx = crypto_tfm_ctx(tfm);
 	mctx->pending_len = 0;
 }
 
 
-static void michael_update(void *ctx, const u8 *data, unsigned int len)
+static void michael_update(struct crypto_tfm *tfm, const u8 *data,
+			   unsigned int len)
 {
-	struct michael_mic_ctx *mctx = ctx;
+	struct michael_mic_ctx *mctx = crypto_tfm_ctx(tfm);
 	const __le32 *src;
 
 	if (mctx->pending_len) {
@@ -90,9 +91,9 @@ static void michael_update(void *ctx, co
 }
 
 
-static void michael_final(void *ctx, u8 *out)
+static void michael_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct michael_mic_ctx *mctx = ctx;
+	struct michael_mic_ctx *mctx = crypto_tfm_ctx(tfm);
 	u8 *data = mctx->pending;
 	__le32 *dst = (__le32 *)out;
 
@@ -121,10 +122,10 @@ static void michael_final(void *ctx, u8 
 }
 
 
-static int michael_setkey(void *ctx, const u8 *key, unsigned int keylen,
-			  u32 *flags)
+static int michael_setkey(struct crypto_tfm *tfm, const u8 *key,
+			  unsigned int keylen, u32 *flags)
 {
-	struct michael_mic_ctx *mctx = ctx;
+	struct michael_mic_ctx *mctx = crypto_tfm_ctx(tfm);
 	const __le32 *data = (const __le32 *)key;
 
 	if (keylen != 8) {
diff --git a/crypto/serpent.c b/crypto/serpent.c
--- a/crypto/serpent.c
+++ b/crypto/serpent.c
@@ -215,9 +215,11 @@ struct serpent_ctx {
 };
 
 
-static int serpent_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+static int serpent_setkey(struct crypto_tfm *tfm, const u8 *key,
+			  unsigned int keylen, u32 *flags)
 {
-	u32 *k = ((struct serpent_ctx *)ctx)->expkey;
+	struct serpent_ctx *ctx = crypto_tfm_ctx(tfm);
+	u32 *k = ctx->expkey;
 	u8  *k8 = (u8 *)k;
 	u32 r0,r1,r2,r3,r4;
 	int i;
@@ -365,10 +367,11 @@ static int serpent_setkey(void *ctx, con
 	return 0;
 }
 
-static void serpent_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void serpent_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
+	struct serpent_ctx *ctx = crypto_tfm_ctx(tfm);
 	const u32
-		*k = ((struct serpent_ctx *)ctx)->expkey,
+		*k = ctx->expkey,
 		*s = (const u32 *)src;
 	u32	*d = (u32 *)dst,
 		r0, r1, r2, r3, r4;
@@ -423,8 +426,9 @@ static void serpent_encrypt(void *ctx, u
 	d[3] = cpu_to_le32(r3);
 }
 
-static void serpent_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void serpent_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
+	struct serpent_ctx *ctx = crypto_tfm_ctx(tfm);
 	const u32
 		*k = ((struct serpent_ctx *)ctx)->expkey,
 		*s = (const u32 *)src;
@@ -492,7 +496,8 @@ static struct crypto_alg serpent_alg = {
 	.cia_decrypt  		=	serpent_decrypt } }
 };
 
-static int tnepres_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+static int tnepres_setkey(struct crypto_tfm *tfm, const u8 *key,
+			  unsigned int keylen, u32 *flags)
 {
 	u8 rev_key[SERPENT_MAX_KEY_SIZE];
 	int i;
@@ -506,10 +511,10 @@ static int tnepres_setkey(void *ctx, con
 	for (i = 0; i < keylen; ++i)
 		rev_key[keylen - i - 1] = key[i];
  
-	return serpent_setkey(ctx, rev_key, keylen, flags);
+	return serpent_setkey(tfm, rev_key, keylen, flags);
 }
 
-static void tnepres_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void tnepres_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
 	const u32 * const s = (const u32 * const)src;
 	u32 * const d = (u32 * const)dst;
@@ -521,7 +526,7 @@ static void tnepres_encrypt(void *ctx, u
 	rs[2] = swab32(s[1]);
 	rs[3] = swab32(s[0]);
 
-	serpent_encrypt(ctx, (u8 *)rd, (u8 *)rs);
+	serpent_encrypt(tfm, (u8 *)rd, (u8 *)rs);
 
 	d[0] = swab32(rd[3]);
 	d[1] = swab32(rd[2]);
@@ -529,7 +534,7 @@ static void tnepres_encrypt(void *ctx, u
 	d[3] = swab32(rd[0]);
 }
 
-static void tnepres_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void tnepres_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
 	const u32 * const s = (const u32 * const)src;
 	u32 * const d = (u32 * const)dst;
@@ -541,7 +546,7 @@ static void tnepres_decrypt(void *ctx, u
 	rs[2] = swab32(s[1]);
 	rs[3] = swab32(s[0]);
 
-	serpent_decrypt(ctx, (u8 *)rd, (u8 *)rs);
+	serpent_decrypt(tfm, (u8 *)rd, (u8 *)rs);
 
 	d[0] = swab32(rd[3]);
 	d[1] = swab32(rd[2]);
diff --git a/crypto/sha1.c b/crypto/sha1.c
--- a/crypto/sha1.c
+++ b/crypto/sha1.c
@@ -34,9 +34,9 @@ struct sha1_ctx {
         u8 buffer[64];
 };
 
-static void sha1_init(void *ctx)
+static void sha1_init(struct crypto_tfm *tfm)
 {
-	struct sha1_ctx *sctx = ctx;
+	struct sha1_ctx *sctx = crypto_tfm_ctx(tfm);
 	static const struct sha1_ctx initstate = {
 	  0,
 	  { 0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0 },
@@ -46,9 +46,10 @@ static void sha1_init(void *ctx)
 	*sctx = initstate;
 }
 
-static void sha1_update(void *ctx, const u8 *data, unsigned int len)
+static void sha1_update(struct crypto_tfm *tfm, const u8 *data,
+			unsigned int len)
 {
-	struct sha1_ctx *sctx = ctx;
+	struct sha1_ctx *sctx = crypto_tfm_ctx(tfm);
 	unsigned int partial, done;
 	const u8 *src;
 
@@ -80,9 +81,9 @@ static void sha1_update(void *ctx, const
 
 
 /* Add padding and return the message digest. */
-static void sha1_final(void* ctx, u8 *out)
+static void sha1_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct sha1_ctx *sctx = ctx;
+	struct sha1_ctx *sctx = crypto_tfm_ctx(tfm);
 	__be32 *dst = (__be32 *)out;
 	u32 i, index, padlen;
 	__be64 bits;
@@ -93,10 +94,10 @@ static void sha1_final(void* ctx, u8 *ou
 	/* Pad out to 56 mod 64 */
 	index = sctx->count & 0x3f;
 	padlen = (index < 56) ? (56 - index) : ((64+56) - index);
-	sha1_update(sctx, padding, padlen);
+	sha1_update(tfm, padding, padlen);
 
 	/* Append length */
-	sha1_update(sctx, (const u8 *)&bits, sizeof(bits));
+	sha1_update(tfm, (const u8 *)&bits, sizeof(bits));
 
 	/* Store state in digest */
 	for (i = 0; i < 5; i++)
diff --git a/crypto/sha256.c b/crypto/sha256.c
--- a/crypto/sha256.c
+++ b/crypto/sha256.c
@@ -230,9 +230,9 @@ static void sha256_transform(u32 *state,
 	memset(W, 0, 64 * sizeof(u32));
 }
 
-static void sha256_init(void *ctx)
+static void sha256_init(struct crypto_tfm *tfm)
 {
-	struct sha256_ctx *sctx = ctx;
+	struct sha256_ctx *sctx = crypto_tfm_ctx(tfm);
 	sctx->state[0] = H0;
 	sctx->state[1] = H1;
 	sctx->state[2] = H2;
@@ -243,9 +243,10 @@ static void sha256_init(void *ctx)
 	sctx->state[7] = H7;
 }
 
-static void sha256_update(void *ctx, const u8 *data, unsigned int len)
+static void sha256_update(struct crypto_tfm *tfm, const u8 *data,
+			  unsigned int len)
 {
-	struct sha256_ctx *sctx = ctx;
+	struct sha256_ctx *sctx = crypto_tfm_ctx(tfm);
 	unsigned int i, index, part_len;
 
 	/* Compute number of bytes mod 128 */
@@ -275,9 +276,9 @@ static void sha256_update(void *ctx, con
 	memcpy(&sctx->buf[index], &data[i], len-i);
 }
 
-static void sha256_final(void* ctx, u8 *out)
+static void sha256_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct sha256_ctx *sctx = ctx;
+	struct sha256_ctx *sctx = crypto_tfm_ctx(tfm);
 	__be32 *dst = (__be32 *)out;
 	__be32 bits[2];
 	unsigned int index, pad_len;
@@ -291,10 +292,10 @@ static void sha256_final(void* ctx, u8 *
 	/* Pad out to 56 mod 64. */
 	index = (sctx->count[0] >> 3) & 0x3f;
 	pad_len = (index < 56) ? (56 - index) : ((64+56) - index);
-	sha256_update(sctx, padding, pad_len);
+	sha256_update(tfm, padding, pad_len);
 
 	/* Append length (before padding) */
-	sha256_update(sctx, (const u8 *)bits, sizeof(bits));
+	sha256_update(tfm, (const u8 *)bits, sizeof(bits));
 
 	/* Store state in digest */
 	for (i = 0; i < 8; i++)
diff --git a/crypto/sha512.c b/crypto/sha512.c
--- a/crypto/sha512.c
+++ b/crypto/sha512.c
@@ -161,9 +161,9 @@ sha512_transform(u64 *state, u64 *W, con
 }
 
 static void
-sha512_init(void *ctx)
+sha512_init(struct crypto_tfm *tfm)
 {
-        struct sha512_ctx *sctx = ctx;
+	struct sha512_ctx *sctx = crypto_tfm_ctx(tfm);
 	sctx->state[0] = H0;
 	sctx->state[1] = H1;
 	sctx->state[2] = H2;
@@ -175,9 +175,9 @@ sha512_init(void *ctx)
 }
 
 static void
-sha384_init(void *ctx)
+sha384_init(struct crypto_tfm *tfm)
 {
-        struct sha512_ctx *sctx = ctx;
+	struct sha512_ctx *sctx = crypto_tfm_ctx(tfm);
         sctx->state[0] = HP0;
         sctx->state[1] = HP1;
         sctx->state[2] = HP2;
@@ -189,9 +189,9 @@ sha384_init(void *ctx)
 }
 
 static void
-sha512_update(void *ctx, const u8 *data, unsigned int len)
+sha512_update(struct crypto_tfm *tfm, const u8 *data, unsigned int len)
 {
-        struct sha512_ctx *sctx = ctx;
+	struct sha512_ctx *sctx = crypto_tfm_ctx(tfm);
 
 	unsigned int i, index, part_len;
 
@@ -229,9 +229,9 @@ sha512_update(void *ctx, const u8 *data,
 }
 
 static void
-sha512_final(void *ctx, u8 *hash)
+sha512_final(struct crypto_tfm *tfm, u8 *hash)
 {
-        struct sha512_ctx *sctx = ctx;
+	struct sha512_ctx *sctx = crypto_tfm_ctx(tfm);
         static u8 padding[128] = { 0x80, };
 	__be64 *dst = (__be64 *)hash;
 	__be32 bits[4];
@@ -247,10 +247,10 @@ sha512_final(void *ctx, u8 *hash)
 	/* Pad out to 112 mod 128. */
 	index = (sctx->count[0] >> 3) & 0x7f;
 	pad_len = (index < 112) ? (112 - index) : ((128+112) - index);
-	sha512_update(sctx, padding, pad_len);
+	sha512_update(tfm, padding, pad_len);
 
 	/* Append length (before padding) */
-	sha512_update(sctx, (const u8 *)bits, sizeof(bits));
+	sha512_update(tfm, (const u8 *)bits, sizeof(bits));
 
 	/* Store state in digest */
 	for (i = 0; i < 8; i++)
@@ -260,12 +260,11 @@ sha512_final(void *ctx, u8 *hash)
 	memset(sctx, 0, sizeof(struct sha512_ctx));
 }
 
-static void sha384_final(void *ctx, u8 *hash)
+static void sha384_final(struct crypto_tfm *tfm, u8 *hash)
 {
-        struct sha512_ctx *sctx = ctx;
         u8 D[64];
 
-        sha512_final(sctx, D);
+	sha512_final(tfm, D);
 
         memcpy(hash, D, 48);
         memset(D, 0, 64);
diff --git a/crypto/tea.c b/crypto/tea.c
--- a/crypto/tea.c
+++ b/crypto/tea.c
@@ -45,10 +45,10 @@ struct xtea_ctx {
 	u32 KEY[4];
 };
 
-static int tea_setkey(void *ctx_arg, const u8 *in_key,
-                       unsigned int key_len, u32 *flags)
-{ 
-	struct tea_ctx *ctx = ctx_arg;
+static int tea_setkey(struct crypto_tfm *tfm, const u8 *in_key,
+		      unsigned int key_len, u32 *flags)
+{
+	struct tea_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *key = (const __le32 *)in_key;
 	
 	if (key_len != 16)
@@ -66,12 +66,11 @@ static int tea_setkey(void *ctx_arg, con
 
 }
 
-static void tea_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
-{ 
+static void tea_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
 	u32 y, z, n, sum = 0;
 	u32 k0, k1, k2, k3;
-
-	struct tea_ctx *ctx = ctx_arg;
+	struct tea_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *in = (const __le32 *)src;
 	__le32 *out = (__le32 *)dst;
 
@@ -95,11 +94,11 @@ static void tea_encrypt(void *ctx_arg, u
 	out[1] = cpu_to_le32(z);
 }
 
-static void tea_decrypt(void *ctx_arg, u8 *dst, const u8 *src)
-{ 
+static void tea_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
 	u32 y, z, n, sum;
 	u32 k0, k1, k2, k3;
-	struct tea_ctx *ctx = ctx_arg;
+	struct tea_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *in = (const __le32 *)src;
 	__le32 *out = (__le32 *)dst;
 
@@ -125,10 +124,10 @@ static void tea_decrypt(void *ctx_arg, u
 	out[1] = cpu_to_le32(z);
 }
 
-static int xtea_setkey(void *ctx_arg, const u8 *in_key,
-                       unsigned int key_len, u32 *flags)
-{ 
-	struct xtea_ctx *ctx = ctx_arg;
+static int xtea_setkey(struct crypto_tfm *tfm, const u8 *in_key,
+		       unsigned int key_len, u32 *flags)
+{
+	struct xtea_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *key = (const __le32 *)in_key;
 	
 	if (key_len != 16)
@@ -146,12 +145,11 @@ static int xtea_setkey(void *ctx_arg, co
 
 }
 
-static void xtea_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
-{ 
+static void xtea_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
 	u32 y, z, sum = 0;
 	u32 limit = XTEA_DELTA * XTEA_ROUNDS;
-
-	struct xtea_ctx *ctx = ctx_arg;
+	struct xtea_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *in = (const __le32 *)src;
 	__le32 *out = (__le32 *)dst;
 
@@ -168,10 +166,10 @@ static void xtea_encrypt(void *ctx_arg, 
 	out[1] = cpu_to_le32(z);
 }
 
-static void xtea_decrypt(void *ctx_arg, u8 *dst, const u8 *src)
-{ 
+static void xtea_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
 	u32 y, z, sum;
-	struct tea_ctx *ctx = ctx_arg;
+	struct tea_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *in = (const __le32 *)src;
 	__le32 *out = (__le32 *)dst;
 
@@ -191,12 +189,11 @@ static void xtea_decrypt(void *ctx_arg, 
 }
 
 
-static void xeta_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
-{ 
+static void xeta_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
 	u32 y, z, sum = 0;
 	u32 limit = XTEA_DELTA * XTEA_ROUNDS;
-
-	struct xtea_ctx *ctx = ctx_arg;
+	struct xtea_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *in = (const __le32 *)src;
 	__le32 *out = (__le32 *)dst;
 
@@ -213,10 +210,10 @@ static void xeta_encrypt(void *ctx_arg, 
 	out[1] = cpu_to_le32(z);
 }
 
-static void xeta_decrypt(void *ctx_arg, u8 *dst, const u8 *src)
-{ 
+static void xeta_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
 	u32 y, z, sum;
-	struct tea_ctx *ctx = ctx_arg;
+	struct tea_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *in = (const __le32 *)src;
 	__le32 *out = (__le32 *)dst;
 
diff --git a/crypto/tgr192.c b/crypto/tgr192.c
--- a/crypto/tgr192.c
+++ b/crypto/tgr192.c
@@ -496,9 +496,9 @@ static void tgr192_transform(struct tgr1
 	tctx->c = c;
 }
 
-static void tgr192_init(void *ctx)
+static void tgr192_init(struct crypto_tfm *tfm)
 {
-	struct tgr192_ctx *tctx = ctx;
+	struct tgr192_ctx *tctx = crypto_tfm_ctx(tfm);
 
 	tctx->a = 0x0123456789abcdefULL;
 	tctx->b = 0xfedcba9876543210ULL;
@@ -508,9 +508,10 @@ static void tgr192_init(void *ctx)
 
 /* Update the message digest with the contents
  * of INBUF with length INLEN. */
-static void tgr192_update(void *ctx, const u8 * inbuf, unsigned int len)
+static void tgr192_update(struct crypto_tfm *tfm, const u8 *inbuf,
+			  unsigned int len)
 {
-	struct tgr192_ctx *tctx = ctx;
+	struct tgr192_ctx *tctx = crypto_tfm_ctx(tfm);
 
 	if (tctx->count == 64) {	/* flush the buffer */
 		tgr192_transform(tctx, tctx->hash);
@@ -524,7 +525,7 @@ static void tgr192_update(void *ctx, con
 		for (; len && tctx->count < 64; len--) {
 			tctx->hash[tctx->count++] = *inbuf++;
 		}
-		tgr192_update(tctx, NULL, 0);
+		tgr192_update(tfm, NULL, 0);
 		if (!len) {
 			return;
 		}
@@ -546,15 +547,15 @@ static void tgr192_update(void *ctx, con
 
 
 /* The routine terminates the computation */
-static void tgr192_final(void *ctx, u8 * out)
+static void tgr192_final(struct crypto_tfm *tfm, u8 * out)
 {
-	struct tgr192_ctx *tctx = ctx;
+	struct tgr192_ctx *tctx = crypto_tfm_ctx(tfm);
 	__be64 *dst = (__be64 *)out;
 	__be64 *be64p;
 	__le32 *le32p;
 	u32 t, msb, lsb;
 
-	tgr192_update(tctx, NULL, 0); /* flush */ ;
+	tgr192_update(tfm, NULL, 0); /* flush */ ;
 
 	msb = 0;
 	t = tctx->nblocks;
@@ -582,7 +583,7 @@ static void tgr192_final(void *ctx, u8 *
 		while (tctx->count < 64) {
 			tctx->hash[tctx->count++] = 0;
 		}
-		tgr192_update(tctx, NULL, 0); /* flush */ ;
+		tgr192_update(tfm, NULL, 0); /* flush */ ;
 		memset(tctx->hash, 0, 56);    /* fill next block with zeroes */
 	}
 	/* append the 64 bit count */
@@ -598,22 +599,20 @@ static void tgr192_final(void *ctx, u8 *
 	dst[2] = be64p[2] = cpu_to_be64(tctx->c);
 }
 
-static void tgr160_final(void *ctx, u8 * out)
+static void tgr160_final(struct crypto_tfm *tfm, u8 * out)
 {
-	struct tgr192_ctx *wctx = ctx;
 	u8 D[64];
 
-	tgr192_final(wctx, D);
+	tgr192_final(tfm, D);
 	memcpy(out, D, TGR160_DIGEST_SIZE);
 	memset(D, 0, TGR192_DIGEST_SIZE);
 }
 
-static void tgr128_final(void *ctx, u8 * out)
+static void tgr128_final(struct crypto_tfm *tfm, u8 * out)
 {
-	struct tgr192_ctx *wctx = ctx;
 	u8 D[64];
 
-	tgr192_final(wctx, D);
+	tgr192_final(tfm, D);
 	memcpy(out, D, TGR128_DIGEST_SIZE);
 	memset(D, 0, TGR192_DIGEST_SIZE);
 }
diff --git a/crypto/twofish.c b/crypto/twofish.c
--- a/crypto/twofish.c
+++ b/crypto/twofish.c
@@ -643,11 +643,11 @@ struct twofish_ctx {
 };
 
 /* Perform the key setup. */
-static int twofish_setkey(void *cx, const u8 *key,
-                          unsigned int key_len, u32 *flags)
+static int twofish_setkey(struct crypto_tfm *tfm, const u8 *key,
+			  unsigned int key_len, u32 *flags)
 {
 	
-	struct twofish_ctx *ctx = cx;
+	struct twofish_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	int i, j, k;
 
@@ -802,9 +802,9 @@ static int twofish_setkey(void *cx, cons
 }
 
 /* Encrypt one block.  in and out may be the same. */
-static void twofish_encrypt(void *cx, u8 *out, const u8 *in)
+static void twofish_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	struct twofish_ctx *ctx = cx;
+	struct twofish_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *src = (const __le32 *)in;
 	__le32 *dst = (__le32 *)out;
 
@@ -839,9 +839,9 @@ static void twofish_encrypt(void *cx, u8
 }
 
 /* Decrypt one block.  in and out may be the same. */
-static void twofish_decrypt(void *cx, u8 *out, const u8 *in)
+static void twofish_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	struct twofish_ctx *ctx = cx;
+	struct twofish_ctx *ctx = crypto_tfm_ctx(tfm);
 	const __le32 *src = (const __le32 *)in;
 	__le32 *dst = (__le32 *)out;
   
diff --git a/crypto/wp512.c b/crypto/wp512.c
--- a/crypto/wp512.c
+++ b/crypto/wp512.c
@@ -981,14 +981,15 @@ static void wp512_process_buffer(struct 
 
 }
 
-static void wp512_init(void *ctx)
+static void wp512_init(struct crypto_tfm *tfm)
 {
 }
 
-static void wp512_update(void *ctx, const u8 *source, unsigned int len)
+static void wp512_update(struct crypto_tfm *tfm, const u8 *source,
+			 unsigned int len)
 {
 
-	struct wp512_ctx *wctx = ctx;
+	struct wp512_ctx *wctx = crypto_tfm_ctx(tfm);
 	int sourcePos    = 0;
 	unsigned int bits_len = len * 8; // convert to number of bits
 	int sourceGap    = (8 - ((int)bits_len & 7)) & 7;
@@ -1046,9 +1047,9 @@ static void wp512_update(void *ctx, cons
 
 }
 
-static void wp512_final(void *ctx, u8 *out)
+static void wp512_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct wp512_ctx *wctx = ctx;
+	struct wp512_ctx *wctx = crypto_tfm_ctx(tfm);
 	int i;
    	u8 *buffer      = wctx->buffer;
    	u8 *bitLength   = wctx->bitLength;
@@ -1079,22 +1080,20 @@ static void wp512_final(void *ctx, u8 *o
    	wctx->bufferPos    = bufferPos;
 }
 
-static void wp384_final(void *ctx, u8 *out)
+static void wp384_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct wp512_ctx *wctx = ctx;
 	u8 D[64];
 
-	wp512_final (wctx, D);
+	wp512_final(tfm, D);
 	memcpy (out, D, WP384_DIGEST_SIZE);
 	memset (D, 0, WP512_DIGEST_SIZE);
 }
 
-static void wp256_final(void *ctx, u8 *out)
+static void wp256_final(struct crypto_tfm *tfm, u8 *out)
 {
-	struct wp512_ctx *wctx = ctx;
 	u8 D[64];
 
-	wp512_final (wctx, D);
+	wp512_final(tfm, D);
 	memcpy (out, D, WP256_DIGEST_SIZE);
 	memset (D, 0, WP512_DIGEST_SIZE);
 }
diff --git a/drivers/crypto/padlock-aes.c b/drivers/crypto/padlock-aes.c
--- a/drivers/crypto/padlock-aes.c
+++ b/drivers/crypto/padlock-aes.c
@@ -282,19 +282,20 @@ aes_hw_extkey_available(uint8_t key_len)
 	return 0;
 }
 
-static inline struct aes_ctx *aes_ctx(void *ctx)
+static inline struct aes_ctx *aes_ctx(struct crypto_tfm *tfm)
 {
+	unsigned long addr = (unsigned long)crypto_tfm_ctx(tfm);
 	unsigned long align = PADLOCK_ALIGNMENT;
 
 	if (align <= crypto_tfm_ctx_alignment())
 		align = 1;
-	return (struct aes_ctx *)ALIGN((unsigned long)ctx, align);
+	return (struct aes_ctx *)ALIGN(addr, align);
 }
 
-static int
-aes_set_key(void *ctx_arg, const uint8_t *in_key, unsigned int key_len, uint32_t *flags)
+static int aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
+		       unsigned int key_len, u32 *flags)
 {
-	struct aes_ctx *ctx = aes_ctx(ctx_arg);
+	struct aes_ctx *ctx = aes_ctx(tfm);
 	const __le32 *key = (const __le32 *)in_key;
 	uint32_t i, t, u, v, w;
 	uint32_t P[AES_EXTENDED_KEY_SIZE];
@@ -414,24 +415,22 @@ static inline u8 *padlock_xcrypt_cbc(con
 	return iv;
 }
 
-static void
-aes_encrypt(void *ctx_arg, uint8_t *out, const uint8_t *in)
+static void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	struct aes_ctx *ctx = aes_ctx(ctx_arg);
+	struct aes_ctx *ctx = aes_ctx(tfm);
 	padlock_xcrypt_ecb(in, out, ctx->E, &ctx->cword.encrypt, 1);
 }
 
-static void
-aes_decrypt(void *ctx_arg, uint8_t *out, const uint8_t *in)
+static void aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-	struct aes_ctx *ctx = aes_ctx(ctx_arg);
+	struct aes_ctx *ctx = aes_ctx(tfm);
 	padlock_xcrypt_ecb(in, out, ctx->D, &ctx->cword.decrypt, 1);
 }
 
 static unsigned int aes_encrypt_ecb(const struct cipher_desc *desc, u8 *out,
 				    const u8 *in, unsigned int nbytes)
 {
-	struct aes_ctx *ctx = aes_ctx(crypto_tfm_ctx(desc->tfm));
+	struct aes_ctx *ctx = aes_ctx(desc->tfm);
 	padlock_xcrypt_ecb(in, out, ctx->E, &ctx->cword.encrypt,
 			   nbytes / AES_BLOCK_SIZE);
 	return nbytes & ~(AES_BLOCK_SIZE - 1);
@@ -440,7 +439,7 @@ static unsigned int aes_encrypt_ecb(cons
 static unsigned int aes_decrypt_ecb(const struct cipher_desc *desc, u8 *out,
 				    const u8 *in, unsigned int nbytes)
 {
-	struct aes_ctx *ctx = aes_ctx(crypto_tfm_ctx(desc->tfm));
+	struct aes_ctx *ctx = aes_ctx(desc->tfm);
 	padlock_xcrypt_ecb(in, out, ctx->D, &ctx->cword.decrypt,
 			   nbytes / AES_BLOCK_SIZE);
 	return nbytes & ~(AES_BLOCK_SIZE - 1);
@@ -449,7 +448,7 @@ static unsigned int aes_decrypt_ecb(cons
 static unsigned int aes_encrypt_cbc(const struct cipher_desc *desc, u8 *out,
 				    const u8 *in, unsigned int nbytes)
 {
-	struct aes_ctx *ctx = aes_ctx(crypto_tfm_ctx(desc->tfm));
+	struct aes_ctx *ctx = aes_ctx(desc->tfm);
 	u8 *iv;
 
 	iv = padlock_xcrypt_cbc(in, out, ctx->E, desc->info,
@@ -462,7 +461,7 @@ static unsigned int aes_encrypt_cbc(cons
 static unsigned int aes_decrypt_cbc(const struct cipher_desc *desc, u8 *out,
 				    const u8 *in, unsigned int nbytes)
 {
-	struct aes_ctx *ctx = aes_ctx(crypto_tfm_ctx(desc->tfm));
+	struct aes_ctx *ctx = aes_ctx(desc->tfm);
 	padlock_xcrypt_cbc(in, out, ctx->D, desc->info, &ctx->cword.decrypt,
 			   nbytes / AES_BLOCK_SIZE);
 	return nbytes & ~(AES_BLOCK_SIZE - 1);
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -67,7 +67,7 @@ struct crypto_tfm;
 
 struct cipher_desc {
 	struct crypto_tfm *tfm;
-	void (*crfn)(void *ctx, u8 *dst, const u8 *src);
+	void (*crfn)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
 	unsigned int (*prfn)(const struct cipher_desc *desc, u8 *dst,
 			     const u8 *src, unsigned int nbytes);
 	void *info;
@@ -80,10 +80,10 @@ struct cipher_desc {
 struct cipher_alg {
 	unsigned int cia_min_keysize;
 	unsigned int cia_max_keysize;
-	int (*cia_setkey)(void *ctx, const u8 *key,
+	int (*cia_setkey)(struct crypto_tfm *tfm, const u8 *key,
 	                  unsigned int keylen, u32 *flags);
-	void (*cia_encrypt)(void *ctx, u8 *dst, const u8 *src);
-	void (*cia_decrypt)(void *ctx, u8 *dst, const u8 *src);
+	void (*cia_encrypt)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
+	void (*cia_decrypt)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
 
 	unsigned int (*cia_encrypt_ecb)(const struct cipher_desc *desc,
 					u8 *dst, const u8 *src,
@@ -101,20 +101,21 @@ struct cipher_alg {
 
 struct digest_alg {
 	unsigned int dia_digestsize;
-	void (*dia_init)(void *ctx);
-	void (*dia_update)(void *ctx, const u8 *data, unsigned int len);
-	void (*dia_final)(void *ctx, u8 *out);
-	int (*dia_setkey)(void *ctx, const u8 *key,
+	void (*dia_init)(struct crypto_tfm *tfm);
+	void (*dia_update)(struct crypto_tfm *tfm, const u8 *data,
+			   unsigned int len);
+	void (*dia_final)(struct crypto_tfm *tfm, u8 *out);
+	int (*dia_setkey)(struct crypto_tfm *tfm, const u8 *key,
 	                  unsigned int keylen, u32 *flags);
 };
 
 struct compress_alg {
-	int (*coa_init)(void *ctx);
-	void (*coa_exit)(void *ctx);
-	int (*coa_compress)(void *ctx, const u8 *src, unsigned int slen,
-	                    u8 *dst, unsigned int *dlen);
-	int (*coa_decompress)(void *ctx, const u8 *src, unsigned int slen,
-	                      u8 *dst, unsigned int *dlen);
+	int (*coa_init)(struct crypto_tfm *tfm);
+	void (*coa_exit)(struct crypto_tfm *tfm);
+	int (*coa_compress)(struct crypto_tfm *tfm, const u8 *src,
+			    unsigned int slen, u8 *dst, unsigned int *dlen);
+	int (*coa_decompress)(struct crypto_tfm *tfm, const u8 *src,
+			      unsigned int slen, u8 *dst, unsigned int *dlen);
 };
 
 #define cra_cipher	cra_u.cipher

--OBd5C1Lgu00Gd/Tn--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUCJDm7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 22:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbUCJDm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 22:42:59 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:9344 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S261658AbUCJDmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 22:42:46 -0500
Date: Tue, 9 Mar 2004 19:40:14 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: James Morris <jmorris@redhat.com>
Cc: Clay Haapala <chaapala@cisco.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
Message-ID: <20040310034014.GA3739@jm.kir.nu>
References: <yquj7jxuudvn.fsf@chaapala-lnx2.cisco.com> <Xine.LNX.4.44.0403091532020.27586-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0403091532020.27586-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 9 Mar 2004, Clay Haapala wrote:
> > I had the same thought in my attempt at adding CRC32C to the crypto
> > routines, that what was needed was "digests + setkey".  But I didn't
> > want to add the key baggage to digests, and so created a new alg type
> > (CHKSUM), with pretty much identical code to digest, but with a
> > modified init and a new setkey interface.

On Tue, Mar 09, 2004 at 03:32:58PM -0500, James Morris wrote:
> I think that adding a setkey method for digests is the simplest approach.


I took a quick look at the CRC32C patch and it looked like the only
needed change for the digest type was the new handler for setting a
32-bit seed. I used setkey handler that takes an arbitrary key data and
length (Michael MIC uses 64-bit key/seed). As far as I could tell, this
setkey function should be enough for CRC32C needs, too. Clay, please let
me know if I missed something here. James, please consider merging this
into Linux 2.6 tree if there are no issues with CRC32C.

The patch below includes only the setkey addition from my previous
patch. This is against current linus-2.5 BK tree. I will re-diff and
send Michael MIC portion of the patch separately. Re-diffing was needed
anyway, since ARC4 addition had a small conflict with the Michael MIC
patch.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1689, 2004-03-09 18:54:50-08:00, jkmaline@cc.hut.fi
  Added support for using keyed digest with an optional dit_setkey handler.
  This does not change the behavior of the existing digest algorithms, but
  allows new ones to add setkey handler that can be used to initialize the
  algorithm with a key or seed. setkey is to be called after init, but before
  any of the update call(s).


 crypto/digest.c        |   10 ++++++++++
 crypto/tcrypt.c        |    4 ++++
 crypto/tcrypt.h        |    2 ++
 include/linux/crypto.h |   13 +++++++++++++
 4 files changed, 29 insertions(+)


diff -Nru a/crypto/digest.c b/crypto/digest.c
--- a/crypto/digest.c	Tue Mar  9 18:58:22 2004
+++ b/crypto/digest.c	Tue Mar  9 18:58:22 2004
@@ -42,6 +42,15 @@
 	tfm->__crt_alg->cra_digest.dia_final(crypto_tfm_ctx(tfm), out);
 }
 
+static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
+{
+	u32 flags;
+	if (tfm->__crt_alg->cra_digest.dia_setkey == NULL)
+		return -1;
+	return tfm->__crt_alg->cra_digest.dia_setkey(crypto_tfm_ctx(tfm),
+						     key, keylen, &flags);
+}
+
 static void digest(struct crypto_tfm *tfm,
                    struct scatterlist *sg, unsigned int nsg, u8 *out)
 {
@@ -72,6 +81,7 @@
 	ops->dit_update	= update;
 	ops->dit_final	= final;
 	ops->dit_digest	= digest;
+	ops->dit_setkey	= setkey;
 	
 	return crypto_alloc_hmac_block(tfm);
 }
diff -Nru a/crypto/tcrypt.c b/crypto/tcrypt.c
--- a/crypto/tcrypt.c	Tue Mar  9 18:58:22 2004
+++ b/crypto/tcrypt.c	Tue Mar  9 18:58:22 2004
@@ -112,6 +112,10 @@
 		sg[0].length = hash_tv[i].psize;
 
 		crypto_digest_init (tfm);
+		if (tfm->crt_u.digest.dit_setkey) {
+			crypto_digest_setkey (tfm, hash_tv[i].key,
+					      hash_tv[i].ksize);
+		}
 		crypto_digest_update (tfm, sg, 1);
 		crypto_digest_final (tfm, result);
 
diff -Nru a/crypto/tcrypt.h b/crypto/tcrypt.h
--- a/crypto/tcrypt.h	Tue Mar  9 18:58:22 2004
+++ b/crypto/tcrypt.h	Tue Mar  9 18:58:22 2004
@@ -30,6 +30,8 @@
 	char digest[MAX_DIGEST_SIZE];
 	unsigned char np;
 	unsigned char tap[MAX_TAP];		
+	char key[128]; /* only used with keyed hash algorithms */
+	unsigned char ksize;
 };
 
 struct hmac_testvec {	
diff -Nru a/include/linux/crypto.h b/include/linux/crypto.h
--- a/include/linux/crypto.h	Tue Mar  9 18:58:22 2004
+++ b/include/linux/crypto.h	Tue Mar  9 18:58:22 2004
@@ -76,6 +76,8 @@
 	void (*dia_init)(void *ctx);
 	void (*dia_update)(void *ctx, const u8 *data, unsigned int len);
 	void (*dia_final)(void *ctx, u8 *out);
+	int (*dia_setkey)(void *ctx, const u8 *key,
+	                  unsigned int keylen, u32 *flags);
 };
 
 struct compress_alg {
@@ -157,6 +159,8 @@
 	void (*dit_final)(struct crypto_tfm *tfm, u8 *out);
 	void (*dit_digest)(struct crypto_tfm *tfm, struct scatterlist *sg,
 	                   unsigned int nsg, u8 *out);
+	int (*dit_setkey)(struct crypto_tfm *tfm,
+	                  const u8 *key, unsigned int keylen);
 #ifdef CONFIG_CRYPTO_HMAC
 	void *dit_hmac_block;
 #endif
@@ -280,6 +284,15 @@
 {
 	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST);
 	tfm->crt_digest.dit_digest(tfm, sg, nsg, out);
+}
+
+static inline int crypto_digest_setkey(struct crypto_tfm *tfm,
+                                       const u8 *key, unsigned int keylen)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST);
+	if (tfm->crt_digest.dit_setkey == NULL)
+		return -1;
+	return tfm->crt_digest.dit_setkey(tfm, key, keylen);
 }
 
 static inline int crypto_cipher_setkey(struct crypto_tfm *tfm,

===================================================================


This BitKeeper patch contains the following changesets:
1.1689
## Wrapped with gzip_uu ##


M'XL( $Z$3D   ]586T_C.!1^CG^%5R.MVBY-[<1IDR(0<T$L&C0@!AY&LZ/(
M==PFT,;=V(%AI_/?]^324B!<=QX6ETOK.-_Y?/R=2_H&GVJ9#:VS\QF?)JE$
M;_"?2INA)80=Y\8>)S!SK!3,]/[NG<UZH_.>3OE<Q\IT'=M#</F(&Q'C"YGI
MH45M=S5CKN9R:!WO[IT>O#U&:&L+OX]Y.I&?I<%;6\BH[()/([W#33Q5J6TR
MGNJ9--P6:K98+5TXA#CP\NC )5Y_0?N$#1:"1I1R1F5$'.;WV37:?"Z" ;&5
MCJ:VRB8W@1AQ*2&4N)ZWH)X[<-$'3&W:]P-,6(^X/1)@Z@\]-O1(E_A#0O#2
M,SLKC^ _&.X2] [_VAV\1P*_C2(989W/YRHS>*PRG.LDG>!S>07S43*1VN#+
MQ,28IUC-3:)2/H5Y$VII8!$&F]%49C9@G<2)QI&2&J?*8%&RP2:6>"1C?I$ 
MMAJ7G^7W1)O"2HW/IQ.5@8V9WL"CW  4GT[5)>#(2ZQ2 #0*\PAXWK )6!SL
M +&1!-K %Y8E:6(2\-\_I>D2J@:OMU%L#0,7+65D+Q&3T@3 "+ ,0'QL +_ 
M*AG!%7!-B99>+7>1SR-NJCM:NFVCCYBR@3- 1]>J0]UG#H0()V@;1_Q"SG;2
MW&@[3=)S;J=PJB*[FAO5,^5_.RY/F<)94CAC%BR<XMW"8](+N.SW)1UY;M D
MIR:@2J<."URV8(/ "^XCD:1BFD>R!Y#Y]UZ%=(L+*,YA ]=;^"0@A 14B&@D
M/"&;N-R/MT[)<3S7?<0OE9AL<<<OQ'/I(G $%1!VCO <'OG. WY9!UHGT:>>
M\QB)VJ=W25 WH LN!9R*&(]&Q.4C-G[\<.Z0 #_X3IG;;K$M,MRO<P\ZFZDL
M2_1.DD(D"!7)(L78/&^"<XGK!)32ON<OW $E09WD;J0X%@Q=]D"*H^3_G^,^
MXDH#A[B;7=8_$.^W7/*"J-]G# =(&VX2 6G'U'FII4V6"U,;",UXACOP9P,+
ME0+GW,<=6+6!\U0GDQ0V4]P*,U.9MM$/9.6N@\=3/M&;R$K&N 7W=K?#4&0F
MA+38W189#VO64<*7VP5M?3H].&@CR\JDR;,4=RD U.^?A-&Z9AP*\[TPW-X 
MO&+@8I2T*Z8;^/>28WL3_41_H?T!PQ19:JZ[V]=G8&W5+ME<U_XR2![3_O.B
M$IVI=&>L(+''JCA/D%US4,*O3QES%PQBTB]%#PY_CNA?05W_B*N4TZSYI4=>
MHGE*&68@BI4R"TWE]DI,2RYM_*.03BVIZO*29JL,AYCK.#077Y-O=B$L=*VS
M&Y<T= 6@,LOZV2"B^(DB>F+=?51$\1T108X?5)DS>):(G-<@HJJI>%!$\4M$
M! 'G( N:S:R@]94Z_K=-W.M VSB]JIK"DF!%N1##6K>).SW(D<O<66$4&JER
M3'-G<J]*_DMCA&97._-")KD!+VM;RP?@7-"+3ZM'"O#JH$X\Y'G5UGT-HJG:
MOENB:?;,2[0S\ OM%#6SU;FN7>W6A4HBW(&Z=;O0HCJIK(^&V@L%&63965:U
M?>H%ZX96>>V^\MYDY@D5'RPYT-@&91E=]1+%R9>KFO+GO0SN$F@<3^Q#WIWN
MA8>?UIL"",*P>%PO.P/\&SRI'W\Y.CD,WQ[LA2=?CG;##_M[NY]/VNN-2U$>
I[A2'IW0KC3=6E6.M#P%;JV\21"S%N<YG6R/6'Y$Q<=&_I7&6K[@0    
 

-- 
Jouni Malinen                                            PGP id EFC895FA

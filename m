Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUCJEGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 23:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCJEGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 23:06:30 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:3456 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S262006AbUCJEEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 23:04:49 -0500
Date: Tue, 9 Mar 2004 20:02:25 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Crypto API and Michael MIC
Message-ID: <20040310040225.GA4346@jm.kir.nu>
References: <yquj7jxuudvn.fsf@chaapala-lnx2.cisco.com> <Xine.LNX.4.44.0403091532020.27586-100000@thoron.boston.redhat.com> <20040310034014.GA3739@jm.kir.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310034014.GA3739@jm.kir.nu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 07:40:14PM -0800, Jouni Malinen wrote:

> The patch below includes only the setkey addition from my previous
> patch. This is against current linus-2.5 BK tree. I will re-diff and
> send Michael MIC portion of the patch separately. Re-diffing was needed
> anyway, since ARC4 addition had a small conflict with the Michael MIC
> patch.

And here's the re-diffed patch for adding Michael MIC. This requires the
setkey patch for digest type that I just sent. I tested this new patch
of Michael MIC with Linux 2.6.4-rc3 and Host AP driver. The patch is
against linus-2.5 BK tree. Please consider merging into Linux 2.6.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1690, 2004-03-09 19:17:59-08:00, jkmaline@cc.hut.fi
  Added Michael MIC keyed digest for TKIP (IEEE 802.11i/WPA). This algorithm
  is quite weak due to the requirements for compatibility with old legacy
  wireless LAN hardware that does not have much CPU power. Consequently, this
  should not really be used with anything else than TKIP.
  
  Michael MIC is calculated over the payload of the IEEE 802.11 header which
  makes it easier to add TKIP support for old wireless LAN cards. An additional
  authenticated data area is used (but not send separately) to authenticate
  source and destination addresses.


 Documentation/crypto/api-intro.txt |    1 
 crypto/Kconfig                     |    9 +
 crypto/Makefile                    |    1 
 crypto/michael_mic.c               |  193 +++++++++++++++++++++++++++++++++++++
 crypto/tcrypt.c                    |    8 +
 crypto/tcrypt.h                    |   50 +++++++++
 6 files changed, 261 insertions(+), 1 deletion(-)


diff -Nru a/Documentation/crypto/api-intro.txt b/Documentation/crypto/api-intro.txt
--- a/Documentation/crypto/api-intro.txt	Tue Mar  9 19:20:04 2004
+++ b/Documentation/crypto/api-intro.txt	Tue Mar  9 19:20:04 2004
@@ -187,6 +187,7 @@
   Brian Gladman (AES)
   Kartikey Mahendra Bhatt (CAST6)
   Jon Oberheide (ARC4)
+  Jouni Malinen (Michael MIC)
 
 SHA1 algorithm contributors:
   Jean-Francois Dive
diff -Nru a/crypto/Kconfig b/crypto/Kconfig
--- a/crypto/Kconfig	Tue Mar  9 19:20:04 2004
+++ b/crypto/Kconfig	Tue Mar  9 19:20:04 2004
@@ -161,6 +161,15 @@
 	  
 	  You will most probably want this if using IPSec.
 
+config CRYPTO_MICHAEL_MIC
+	tristate "Michael MIC keyed digest algorithm"
+	depends on CRYPTO
+	help
+	  Michael MIC is used for message integrity protection in TKIP
+	  (IEEE 802.11i). This algorithm is required for TKIP, but it
+	  should not be used for other purposes because of the weakness
+	  of the algorithm.
+
 config CRYPTO_TEST
 	tristate "Testing module"
 	depends on CRYPTO
diff -Nru a/crypto/Makefile b/crypto/Makefile
--- a/crypto/Makefile	Tue Mar  9 19:20:04 2004
+++ b/crypto/Makefile	Tue Mar  9 19:20:04 2004
@@ -23,5 +23,6 @@
 obj-$(CONFIG_CRYPTO_CAST6) += cast6.o
 obj-$(CONFIG_CRYPTO_ARC4) += arc4.o
 obj-$(CONFIG_CRYPTO_DEFLATE) += deflate.o
+obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 
 obj-$(CONFIG_CRYPTO_TEST) += tcrypt.o
diff -Nru a/crypto/michael_mic.c b/crypto/michael_mic.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/crypto/michael_mic.c	Tue Mar  9 19:20:04 2004
@@ -0,0 +1,193 @@
+/*
+ * Cryptographic API
+ *
+ * Michael MIC (IEEE 802.11i/TKIP) keyed digest
+ *
+ * Copyright (c) 2004 Jouni Malinen <jkmaline@cc.hut.fi>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/crypto.h>
+
+
+struct michael_mic_ctx {
+	u8 pending[4];
+	size_t pending_len;
+
+	u32 l, r;
+};
+
+
+static inline u32 rotl(u32 val, int bits)
+{
+	return (val << bits) | (val >> (32 - bits));
+}
+
+
+static inline u32 rotr(u32 val, int bits)
+{
+	return (val >> bits) | (val << (32 - bits));
+}
+
+
+static inline u32 xswap(u32 val)
+{
+	return ((val & 0x00ff00ff) << 8) | ((val & 0xff00ff00) >> 8);
+}
+
+
+#define michael_block(l, r)	\
+do {				\
+	r ^= rotl(l, 17);	\
+	l += r;			\
+	r ^= xswap(l);		\
+	l += r;			\
+	r ^= rotl(l, 3);	\
+	l += r;			\
+	r ^= rotr(l, 2);	\
+	l += r;			\
+} while (0)
+
+
+static inline u32 get_le32(const u8 *p)
+{
+	return p[0] | (p[1] << 8) | (p[2] << 16) | (p[3] << 24);
+}
+
+
+static inline void put_le32(u8 *p, u32 v)
+{
+	p[0] = v;
+	p[1] = v >> 8;
+	p[2] = v >> 16;
+	p[3] = v >> 24;
+}
+
+
+static void michael_init(void *ctx)
+{
+	struct michael_mic_ctx *mctx = ctx;
+	mctx->pending_len = 0;
+}
+
+
+static void michael_update(void *ctx, const u8 *data, unsigned int len)
+{
+	struct michael_mic_ctx *mctx = ctx;
+
+	if (mctx->pending_len) {
+		int flen = 4 - mctx->pending_len;
+		if (flen > len)
+			flen = len;
+		memcpy(&mctx->pending[mctx->pending_len], data, flen);
+		mctx->pending_len += flen;
+		data += flen;
+		len -= flen;
+
+		if (mctx->pending_len < 4)
+			return;
+
+		mctx->l ^= get_le32(mctx->pending);
+		michael_block(mctx->l, mctx->r);
+		mctx->pending_len = 0;
+	}
+
+	while (len >= 4) {
+		mctx->l ^= get_le32(data);
+		michael_block(mctx->l, mctx->r);
+		data += 4;
+		len -= 4;
+	}
+
+	if (len > 0) {
+		mctx->pending_len = len;
+		memcpy(mctx->pending, data, len);
+	}
+}
+
+
+static void michael_final(void *ctx, u8 *out)
+{
+	struct michael_mic_ctx *mctx = ctx;
+	u8 *data = mctx->pending;
+
+	/* Last block and padding (0x5a, 4..7 x 0) */
+	switch (mctx->pending_len) {
+	case 0:
+		mctx->l ^= 0x5a;
+		break;
+	case 1:
+		mctx->l ^= data[0] | 0x5a00;
+		break;
+	case 2:
+		mctx->l ^= data[0] | (data[1] << 8) | 0x5a0000;
+		break;
+	case 3:
+		mctx->l ^= data[0] | (data[1] << 8) | (data[2] << 16) |
+			0x5a000000;
+		break;
+	}
+	michael_block(mctx->l, mctx->r);
+	/* l ^= 0; */
+	michael_block(mctx->l, mctx->r);
+
+	put_le32(out, mctx->l);
+	put_le32(out + 4, mctx->r);
+}
+
+
+static int michael_setkey(void *ctx, const u8 *key, unsigned int keylen,
+			  u32 *flags)
+{
+	struct michael_mic_ctx *mctx = ctx;
+	if (keylen != 8) {
+		if (flags)
+			*flags = CRYPTO_TFM_RES_BAD_KEY_LEN;
+		return -1;
+	}
+	mctx->l = get_le32(key);
+	mctx->r = get_le32(key + 4);
+	return 0;
+}
+
+
+static struct crypto_alg michael_mic_alg = {
+	.cra_name	= "michael_mic",
+	.cra_flags	= CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize	= 8,
+	.cra_ctxsize	= sizeof(struct michael_mic_ctx),
+	.cra_module	= THIS_MODULE,
+	.cra_list	= LIST_HEAD_INIT(michael_mic_alg.cra_list),
+	.cra_u		= { .digest = {
+	.dia_digestsize	= 8,
+	.dia_init	= michael_init,
+	.dia_update	= michael_update,
+	.dia_final	= michael_final,
+	.dia_setkey	= michael_setkey } }
+};
+
+
+static int __init michael_mic_init(void)
+{
+	return crypto_register_alg(&michael_mic_alg);
+}
+
+
+static void __exit michael_mic_exit(void)
+{
+	crypto_unregister_alg(&michael_mic_alg);
+}
+
+
+module_init(michael_mic_init);
+module_exit(michael_mic_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Michael MIC");
+MODULE_AUTHOR("Jouni Malinen <jkmaline@cc.hut.fi>");
diff -Nru a/crypto/tcrypt.c b/crypto/tcrypt.c
--- a/crypto/tcrypt.c	Tue Mar  9 19:20:04 2004
+++ b/crypto/tcrypt.c	Tue Mar  9 19:20:04 2004
@@ -61,7 +61,7 @@
 static char *check[] = {
 	"des", "md5", "des3_ede", "rot13", "sha1", "sha256", "blowfish",
 	"twofish", "serpent", "sha384", "sha512", "md4", "aes", "cast6", 
-	"arc4", "deflate", NULL
+	"arc4", "michael_mic", "deflate", NULL
 };
 
 static void
@@ -572,6 +572,8 @@
 		test_hmac("sha1", hmac_sha1_tv_template, HMAC_SHA1_TEST_VECTORS);		
 		test_hmac("sha256", hmac_sha256_tv_template, HMAC_SHA256_TEST_VECTORS);
 #endif		
+
+		test_hash("michael_mic", michael_mic_tv_template, MICHAEL_MIC_TEST_VECTORS);
 		break;
 
 	case 1:
@@ -649,6 +651,10 @@
 	case 16:
 		test_cipher ("arc4", MODE_ECB, ENCRYPT, arc4_enc_tv_template, ARC4_ENC_TEST_VECTORS);
 		test_cipher ("arc4", MODE_ECB, DECRYPT, arc4_dec_tv_template, ARC4_DEC_TEST_VECTORS);
+		break;
+
+	case 17:
+		test_hash("michael_mic", michael_mic_tv_template, MICHAEL_MIC_TEST_VECTORS);
 		break;
 
 #ifdef CONFIG_CRYPTO_HMAC
diff -Nru a/crypto/tcrypt.h b/crypto/tcrypt.h
--- a/crypto/tcrypt.h	Tue Mar  9 19:20:04 2004
+++ b/crypto/tcrypt.h	Tue Mar  9 19:20:04 2004
@@ -1721,4 +1721,54 @@
 	},
 };
 
+/*
+ * Michael MIC test vectors from IEEE 802.11i
+ */
+#define MICHAEL_MIC_TEST_VECTORS 6
+
+struct hash_testvec michael_mic_tv_template[] =
+{
+	{
+		.key = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+		.ksize = 8,
+		.plaintext = { },
+		.psize = 0,
+		.digest = { 0x82, 0x92, 0x5c, 0x1c, 0xa1, 0xd1, 0x30, 0xb8 }
+	},
+	{
+		.key = { 0x82, 0x92, 0x5c, 0x1c, 0xa1, 0xd1, 0x30, 0xb8 },
+		.ksize = 8,
+		.plaintext = { 'M' },
+		.psize = 1,
+		.digest = { 0x43, 0x47, 0x21, 0xca, 0x40, 0x63, 0x9b, 0x3f }
+	},
+	{
+		.key = { 0x43, 0x47, 0x21, 0xca, 0x40, 0x63, 0x9b, 0x3f },
+		.ksize = 8,
+		.plaintext = { 'M', 'i' },
+		.psize = 2,
+		.digest = { 0xe8, 0xf9, 0xbe, 0xca, 0xe9, 0x7e, 0x5d, 0x29 }
+	},
+	{
+		.key = { 0xe8, 0xf9, 0xbe, 0xca, 0xe9, 0x7e, 0x5d, 0x29 },
+		.ksize = 8,
+		.plaintext = { 'M', 'i', 'c' },
+		.psize = 3,
+		.digest = { 0x90, 0x03, 0x8f, 0xc6, 0xcf, 0x13, 0xc1, 0xdb }
+	},
+	{
+		.key = { 0x90, 0x03, 0x8f, 0xc6, 0xcf, 0x13, 0xc1, 0xdb },
+		.ksize = 8,
+		.plaintext = { 'M', 'i', 'c', 'h' },
+		.psize = 4,
+		.digest = { 0xd5, 0x5e, 0x10, 0x05, 0x10, 0x12, 0x89, 0x86 }
+	},
+	{
+		.key = { 0xd5, 0x5e, 0x10, 0x05, 0x10, 0x12, 0x89, 0x86 },
+		.ksize = 8,
+		.plaintext = { 'M', 'i', 'c', 'h', 'a', 'e', 'l' },
+		.psize = 7,
+		.digest = { 0x0a, 0x94, 0x2b, 0x12, 0x4e, 0xca, 0xa5, 0x46 },
+	}
+};
 #endif	/* _CRYPTO_TCRYPT_H */

===================================================================


This BitKeeper patch contains the following changesets:
1.1690
## Wrapped with gzip_uu ##


M'XL( &2)3D   ]U:>5/;2!;_V_H4;\G6C,U@6Z</"%08<(@W7 5F=J=(UM66
M6K:"+&ET )Z8[[[OM61;OL!0DZJIY9#=U^^=_?IUJ]_!3<3#W<*WNR%S'8]+
M[^"3'\6[!=.L#)*X8CM8<^7[6%/]H_IM6.W=52./!=' C\MJQ9"P^9+%Y@#N
M>1CM%I2*-JV)1P'?+5RU3FY.#Z\D:7\?C@;,Z_-K'L/^OA3[X3USK>@#BP>N
M[U7BD'G1D,>L8OK#\;3K6)5E%7\-I:[)1FVLU&2]/C852U&8KG!+5O5&39<F
M GR8,CX/H<N:@D"&;LAC1:^K=>D8E(I2:\H@ZU59J\I-4)J[2GW7:);EQJXL
MPS(D_%*#LBS]"G\M[T>2"8>6Q2TX<\P!XRZ<M8_@CH^PQG+Z/(K!]D/H?&Y?
M0K'=:K6@(:L517&J_[X\+%6@,W B8&[?#YUX,$0P+/Z1.#&'!\[NP$HX,@SQ
M@$/(L3[D0^[%D<!$=@,6.SW'=>(1/.!X\%T+7-YGY@B1'K"WRZ,(3@_/8<!"
MZX&%B#9@,5@^C\#S8ZR^YS!,T.)'ES<0^ \\K,"1[T5(# FYHQT<X$2(AEZ3
M(#H-"CESW1'T."01BBDH,V^$';T^<#<21#PA<P5'XE]>-RB@R5PS<5F,@WWT
M/2%>P$:NS[#"%L6<JF# F86]'@:(@F!#=H?<.S%P%CDTV@=F6:F*HR0(_##5
M.2EC3@<FZB"JP*%'_9W8\3WF(AY+D* 7.Z9@R&(Q U04(T:%?,5>$@NY(^Y9
M^ A8B#W=44E0S@TF+?E):'+4!@*A[1V/$1FB%R(7/*I(GT&M*:HF7<YFE%1^
MY8\DR4R6#E9X^=@,1T'L5X>IPKOX63%G<TA3ZC2'ZGJS-M;LAF9:6MVL:0U+
M,^IO0U/&JMJ4:\B,A:XT_. E<53Q'.^.53R<1!E +#XK S&I%)PZ"DXIO8EC
M\=O8T+G19+Q6XTK/T)JK9N\JH+Q(LJ(H&C+QIQ,$W/V @Y/'\K#6N*OX8?]V
M,N6_3F ^F[YG._V,'0VQ-%5KC)6&WFR,C5I-J<N&H=E*LZY;VC/LY'#FN-%T
M57M!)6?HQ;;C\D65* W-4,<-;O;JNEHS=,O06>,9%O(X>1YJNEY;R\.Q;R84
M2(1W5C,D%CAEQXM#OQ(_QA.VFHJ"]E709QI*<VSWM)Y=MPQ5MU7-UE>QM1ET
MGE.CB:%],P<REQQ(T9K*F'$3/<>T>SU98SW=?MF!EN:$K)$7TT+WL@"T OY(
MM4K??.^#[6.4'.!Z+I:EC;6*_PU%US7TXD9=3A?*YM(R*3^S3"I_PV42HV;J
M)1=0#A^R/PRA+ZOE#;&UK31041+ O_S$<^!,:,B#8H[SDO"4A1FXUBW>,N-7
M^,#J"3\U>$VNR:G!5>W_P>!I %LP^((.WF)=U4#C^KUOY7\6CR[./[9/ND=7
MOU]V+KK(X*?#UBE]EN"7?<BO>G[>X),8\I+!7Q>T5J7!:X.6JC<U?6QH6D,5
M)M=>9_(ZE)6_H<E%#%YM\8D*WF#QXYJ.%F^+9V&+A::^M0-;.>M2T>(V):3X
M]?SF]%1J&W4=5.F+5"C$R'AWP*)!<6%,KM2-[[LQ'P8$L0,Y1^IV6M>=[F^M
MH\[%U75I#[DP%- 1M8<9YMT>$3 9)LQHL+^:U++##C9TV W3M)<==K#HL'J]
M:333&+6\=WO.80WY1P6IO*^2_G$S;"(5W&*%_C"_#7'(0T6:^:R'#MZTXM0Q
M9ANR5-V68/L5+&'OJO0.?1?5M=87H(9N%L5A8M)^+QIT"1,AUWG5[5?8E[Y+
M!?PK5'#ZPCY\!_E1EG<V?L+3CA@<.7_BL@@-44)P7)8YY4\(F/8(LAZR*&51
M(J774 FK*9Z&24]%/)E"3TL\-4&OUX GJ4" "RR_#N)%EG\^^WF!;669;5TC
M/+U.3U50,)FH$71JHK79$Y3M-6R_#F(3MG?@9V>1=W69=]X@4+LI-,)GA+FH
MJ8L:PQ)L-=?P_CJ(C7G'A[DH@+8L0#/U/Z&AABVHU\13?%=$O9D:O[=&@-=!
MO$X ? P6I="7I; ,H26A*R5EQYA]5X0[-X0^&[4U4KP.X@U2X(/1@]/#712J
MOBR4+-R@J0O3]V9<Z#DG88)'/>7H27J:6\3F#B%H)3OG#T!)X.[*'I(-'%?:
MW_#_F87J#><D8OEZW>KU0Q8O$WYUXL^<!SP4:H"5A[S5E;K!A8QDFRU>\\U7
ML"3T?T0X5=ZPN/T [2NOV]\TM1^3/'S$A/(SI.=?LYR@7%ZGUC<D!C(*J&5I
MP9' [(<L&#B8:5^VL7(Q79C/JRG5+LUEX-F0(S\8A4Y_$$/1+ $I?F&S^WY9
MD0?96'%B'83$R)#.2.V0<XA\.Z;CY3T8^0F8S(.06PXF'4XOB3D=UC+/JF+V
M/_0MQQX1#M8EGI6=_L8\'$:3L]^3\QLXX1X/F0N72<]%:4\=DWN8)].;"CI0
M58%%!!)0<S1 ^7HC,?8C<7.=<0,?42A+' Y41*KT17KG>*:;6!S>BS/"JN,Y
MF+,=+-4CGXG+5[604%Y_54MJ=&KY,LNX\DF6&3\"!NJD 0'W+$2YU;_N204*
MFMUX4M=UN2<V!HFF@KL#X1X%PA0113'!\<@P0,VA'[M%^H)^O8,-,?2<."I1
M]A;R. D]*&(+O'^?UL,X+1\<0!$'E=-:W"L\K<</-\!'O#E\I+<9_F/TP(()
M@3E8@?.32"9MF_Y+A-H0)*9M:8LLEXB#QI3.)"&>J+[G^N9=D519*GR1+!^^
M%_ '-1S"?_=3'6*C4B_M4:5+>_]P+]<CY=+%YM7M$P1M'8!0(W90ESL\T6L-
M#-Y%N;1&1WT>HTMH:M'T/5Q-T7FV@[RJ@EOY*VDEN%6^SG04W*JBI-2RHB:*
MJK[&&O>^8^%LRD@)(CN"_+V@)8CLP_T>?57$5Z%S45:G9:4F*K1IA:HOD!-T
M)H:AR5<4-=LX-02A-;-F>TA/S 7B1Z1 A?)!;K[0#N(Y0DF 48#/2.W 3)GT
MP@=%]2*G[V$<(2='Q(V907LZ-A276"K13"\0FITRJ.-\6.JU1WUPN.ASD!)&
MO\B&9!V&?&@&H^)/<Z-OE["^[D J"XTNB8%+>D+'LS-4\:(K5Z;F\J3X)>-K
M&>$]Z(+%U/O2GFDOEUQ]ZJUS(U-NYJ9C-F8GTTFXAF%AV )9MI!-%*$I5&>J
MX%6D2;)-*4ZTH.=4H$\HD@92P\AY:O/\S1MIKL?$()D]GI[Q4 Q8S,T[*+FF
MG\2;3XJ)+V/%'!/"1-5M.&7H\$(3XO5D0.] O3X&GD<#6=0KE3H\DIRX3!:B
M!X=N :SQ:G%B)>_.:Y]@]F8'6]FQUD(GXB\-5]1=EI<&J&L'"*OF0UR*L )#
MVQPCK<A%2O+L"? \-.ZS7G8G5'.JC#VAQA<'H&6F,1>-/6ER"2O? +_@/C$W
M;B&"SUPCXC&F>ZL#'38LQ#FL09O27JT (MAOVR[K1YO['$V0% 3^L4\J_3Z-
M9P('@5-(')&=LG<^GG6O6M?=7P^/NY];OW=/6^>DYFPQ*RN9JC/SY68UTBE-
M8W^XT$(*HM8,9G$QR(1)$[0N<_MS<E%YGUBOF"'K>FS("_L+!\19FY"E,)7E
M\/2DV_G]LM4];I^TKCN37L+<E-05TMVTJ$2VLRKZ\.WB:@67)OW3!!2[=SZU
MK[MG%\<WIZU)&Z:\,;:<MJ\[W4\M5&3[O-TI+H@T[3F%3 H%VHOG]N42;=)9
M-ZW(<TRUM#H7]N<6ZTE3NI[F&M.*2;,(9KE649XTIBZ::TTKX F>EA+=&+J"
M[IR6IEE#/@O*3!OR/DK,0U( +ICS&EF<.&*6=+O\<8$ 5<P(9,B)MQEV:K>4
MR46NL5/6+$@LTA0!(;5T][1]U#J_;A6W3BY/X5[=PK:LY;AU?735ONRT+\Z+
M6[F]7Z[+X4WGT\55<>OE/=W6_(N"[#X#G:[\B)L4ZU]JSE^DF+[3U-6:KJ7O
M"]17[?F;?\]WFN)>R.JC@DP#;WI[4-.@*66F6WZ9*15PQTHNSV%K+>/3*VA;
M4L'BM.+C=MS+T*3"@+N!A(O$PD4N<3^*9![R*&)]3E.6]T.ZCQ;@IH>;XO:3
MD]X%H_%S:EFZ_D:0V34W:ZK*':#[5TY,PW.7T":WS\1-+]SYA[A["0,_XA$V
MF0S;)L<)=)'.0_X((*N:4JS@C)M>>C0''.-V,MRORS;7ZCU3^A\%*@6E8RD 
!    
 

-- 
Jouni Malinen                                            PGP id EFC895FA

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262502AbSJGCvB>; Sun, 6 Oct 2002 22:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262503AbSJGCvB>; Sun, 6 Oct 2002 22:51:01 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:55947 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262502AbSJGCu5>; Sun, 6 Oct 2002 22:50:57 -0400
To: torvalds@transmeta.com
Subject: [PATCH] Use kernel crc32 for BlueZ BNEP
Cc: linux-kernel@vger.kernel.org, maxk@qualcomm.com, marcel@holtmann.org
Message-Id: <E17yO3f-0002MM-00@pegasus>
From: Marcel Holtmann <marcel@holtmann.org>
Date: Mon, 07 Oct 2002 04:55:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.773, 2002-10-07 04:49:50+02:00, marcel@holtmann.org
  Use kernel crc32 for BlueZ BNEP
  
  This patch modifies the BlueZ BNEP layer to use the CRC32 code from
  the lib/ directory and it makes some cosmetic changes to the BNEP code.


 b/lib/Makefile                    |    1 
 b/net/bluetooth/bnep/Makefile     |    2 -
 b/net/bluetooth/bnep/Makefile.lib |    1 
 b/net/bluetooth/bnep/bnep.h       |    5 +--
 b/net/bluetooth/bnep/core.c       |   20 ++++--------
 net/bluetooth/bnep/crc32.c        |   59 --------------------------------------
 net/bluetooth/bnep/crc32.h        |   10 ------
 7 files changed, 12 insertions(+), 86 deletions(-)


diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Mon Oct  7 04:53:23 2002
+++ b/lib/Makefile	Mon Oct  7 04:53:23 2002
@@ -29,5 +29,6 @@
 include $(TOPDIR)/drivers/net/Makefile.lib
 include $(TOPDIR)/drivers/usb/class/Makefile.lib
 include $(TOPDIR)/fs/Makefile.lib
+include $(TOPDIR)/net/bluetooth/bnep/Makefile.lib
 
 include $(TOPDIR)/Rules.make
diff -Nru a/net/bluetooth/bnep/Makefile b/net/bluetooth/bnep/Makefile
--- a/net/bluetooth/bnep/Makefile	Mon Oct  7 04:53:23 2002
+++ b/net/bluetooth/bnep/Makefile	Mon Oct  7 04:53:23 2002
@@ -4,6 +4,6 @@
 
 obj-$(CONFIG_BLUEZ_BNEP) += bnep.o
 
-bnep-objs := core.o sock.o netdev.o crc32.o
+bnep-objs := core.o sock.o netdev.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/net/bluetooth/bnep/Makefile.lib b/net/bluetooth/bnep/Makefile.lib
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/net/bluetooth/bnep/Makefile.lib	Mon Oct  7 04:53:23 2002
@@ -0,0 +1 @@
+obj-$(CONFIG_BLUEZ_BNEP)	+= crc32.o
diff -Nru a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
--- a/net/bluetooth/bnep/bnep.h	Mon Oct  7 04:53:23 2002
+++ b/net/bluetooth/bnep/bnep.h	Mon Oct  7 04:53:23 2002
@@ -24,10 +24,9 @@
 #define _BNEP_H
 
 #include <linux/types.h>
+#include <linux/crc32.h>
 #include <net/bluetooth/bluetooth.h>
 
-#include "crc32.h"
-
 // Limits
 #define BNEP_MAX_PROTO_FILTERS     5
 #define BNEP_MAX_MULTICAST_FILTERS 20
@@ -179,7 +178,7 @@
 
 static inline int bnep_mc_hash(__u8 *addr)
 {
-        return (bnep_crc32(~0, addr, ETH_ALEN) >> 26);
+        return (crc32_be(~0, addr, ETH_ALEN) >> 26);
 }
 
 #endif
diff -Nru a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
--- a/net/bluetooth/bnep/core.c	Mon Oct  7 04:53:23 2002
+++ b/net/bluetooth/bnep/core.c	Mon Oct  7 04:53:23 2002
@@ -675,17 +675,13 @@
 
 static int __init bnep_init_module(void)
 {
-	BT_INFO("BNEP: BNEP2 ver %s\n"
-		"BNEP: Copyright (C) 2002 Inventel\n"
-		"BNEP: Written 2001,2002 by\n"
-		"BNEP: \tClement Moreau <clement.moreau@inventel.fr> "
-			"David Libault <david.libault@inventel.fr>\n"
-		"BNEP: Copyright (C) 2002 Maxim Krasnyanskiy <maxk@qualcomm.com>",
-			VERSION);
-
 	bnep_sock_init();
 
-	bnep_crc32_init();
+	BT_INFO("BlueZ BNEP ver %s", VERSION);
+	BT_INFO("Copyright (C) 2001,2002 Inventel Systemes");
+	BT_INFO("Written 2001,2002 by Clement Moreau <clement.moreau@inventel.fr>");
+	BT_INFO("Written 2001,2002 by David Libault <david.libault@inventel.fr>");
+	BT_INFO("Copyright (C) 2002 Maxim Krasnyanskiy <maxk@qualcomm.com>");
 
 	return 0;
 }
@@ -693,13 +689,11 @@
 static void __exit bnep_cleanup_module(void)
 {
 	bnep_sock_cleanup();
-
-	bnep_crc32_cleanup();
 }
 
 module_init(bnep_init_module);
 module_exit(bnep_cleanup_module);
 
-MODULE_DESCRIPTION("BNEP ver " VERSION);
-MODULE_AUTHOR("David Libault <david.libault@inventel.fr> Maxim Krasnyanskiy <maxk@qualcomm.com>");
+MODULE_DESCRIPTION("BlueZ BNEP ver " VERSION);
+MODULE_AUTHOR("David Libault <david.libault@inventel.fr>, Maxim Krasnyanskiy <maxk@qualcomm.com>");
 MODULE_LICENSE("GPL");
diff -Nru a/net/bluetooth/bnep/crc32.c b/net/bluetooth/bnep/crc32.c
--- a/net/bluetooth/bnep/crc32.c	Mon Oct  7 04:53:23 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,59 +0,0 @@
-/* 
- * Based on linux-2.5/lib/crc32 by Matt Domsch <Matt_Domsch@dell.com>
- *
- * FIXME: Remove in 2.5  
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <asm/atomic.h>
-
-#include "crc32.h"
-
-#define CRCPOLY_BE 0x04c11db7
-#define CRC_BE_BITS 8
-
-static u32 *bnep_crc32_table;
-
-/*
- * This code is in the public domain; copyright abandoned.
- * Liability for non-performance of this code is limited to the amount
- * you paid for it.  Since it is distributed for free, your refund will
- * be very very small.  If it breaks, you get to keep both pieces.
- */
-u32 bnep_crc32(u32 crc, unsigned char const *p, size_t len)
-{
-	while (len--)
-		crc = (crc << 8) ^ bnep_crc32_table[(crc >> 24) ^ *p++];
-	
-	return crc;
-}
-
-int __init bnep_crc32_init(void)
-{
-	unsigned i, j;
-	u32 crc = 0x80000000;
-
-	bnep_crc32_table = kmalloc((1 << CRC_BE_BITS) * sizeof(u32), GFP_KERNEL);
-	if (!bnep_crc32_table)
-		return -ENOMEM;
-
-	bnep_crc32_table[0] = 0;
-
-	for (i = 1; i < 1 << CRC_BE_BITS; i <<= 1) {
-		crc = (crc << 1) ^ ((crc & 0x80000000) ? CRCPOLY_BE : 0);
-		for (j = 0; j < i; j++)
-			bnep_crc32_table[i + j] = crc ^ bnep_crc32_table[j];
-	}
-	return 0;
-}
-
-void __exit bnep_crc32_cleanup(void)
-{
-	if (bnep_crc32_table)
-		kfree(bnep_crc32_table);
-	bnep_crc32_table = NULL;
-}
diff -Nru a/net/bluetooth/bnep/crc32.h b/net/bluetooth/bnep/crc32.h
--- a/net/bluetooth/bnep/crc32.h	Mon Oct  7 04:53:23 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,10 +0,0 @@
-/*
- * crc32.h
- * See crc32.c for license and changes
- *
- * FIXME: Remove in 2.5
- */
-
-int  bnep_crc32_init(void);
-void bnep_crc32_cleanup(void);
-u32  bnep_crc32(u32 crc, unsigned char const *p, size_t len);

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch8971
M'XL(`"/WH#T``\U8;4_;2!#^C'_%B/:DH!)G=_V>`T1)TC8J$!2@=[HOR"\;
MXHMC<[9#R<GJ;[]9&VA(4FRG15R(O-A9/SOS/+,[L_L&+A,>M[>F=NSR0'H#
MGZ(D;6^-HR"=VF$H1_$U/AQ&$3YLC:,I;SW\U'+\=,+Y#8];3C#C_S:9K$G8
M]\Q.W3'<\CAI;U%9>7R2SF]X>VO8^WAY_'XH2?O[T!G;X34_YRGL[TMI%-_:
M@9<<VNDXB$(YC>TPF?+4EMUHFCUVS1@A#/\T:BA$TS.J$]7(7.I1:JN4>X2I
MIJY*A3N'BVXL85!"#+R:FID19BJ*U`4J&X8"A+4H:1$#B-I6K;9&WA'6)@36
M0,([`YI$.H)?:WQ'<H4J,.%QR`-P8U=A,(IB.$*>_X*CT]X9]L#OQ=A/X"9G
M=QIY_LCG":1COM`/`GO.8[0/9@@H?NL,.XCF1AZ'41Q-$44\#7RG!9X?<Q==
MF8,=>N"GZ/($$1-4'5\0_O@NN+DSB8#,AQ*#"#19^@R,4FI(9]^%E9HU/Y)$
M;"(=X,AWD\-;'X-+;H11R'>RD*=YG*48BN.6$_*;5DZ,[#[(J3)%L1C-5%VQ
M:&:,=,.R5*:JE&B*O5:_[,A//Q<A[/&`I]QKR?A/\Q[XVS+&0N"HIM#/8JI>
MS]KQJK6:HF7,-`DAGFJ[NNX:-J]O[?C;,L:RM4S!(=':YX-51,()ZC[R`[X8
MKY9B93I5B)&-/-TD+C%TQQZY*LZ8=;:NP.2&J(PH"H:]2<VJM"V#//*FF8:6
M.=3@3!]IJNYJMDO7JUP!59B&+&64,4W+3:L%(Z.[JW1KAIEI7%,US7*XPBW;
M,T<_CVS@>J41JRI_XK(NZA`DLRS+U.B(>,[(<@RV7LE2S$)6%;FC>F6SW"CF
MZZ8N-<T,UT:'C#@U=(L3JE86]2EF+BG3,]4P#9KGFQ*:118ZY5]!W+?+.DM?
M0)76IIE?$B9Y-B)/<Y'9UO3G<A%YB5SDPN.JDQ,#Y45`JXPZ3!3":4P493V'
ML$+,GT#N3$8WR"POK!:MIQ9]F<KA`U#!KU@@!M",O^9?]+Z<Z_J$]@D.%CE_
M-]\V.H/3#_V/5T?'E[V_KD1-L+/U;K^H7.2H;/*)B?<"N:"NWM^U5JA!**YG
MN-CFTBX6A7J;L;9JE$A+7Z4H+,0O<EAU]3=0OFO@2'UQ$4A-C($$VJBW6(`C
M+!C="38XI,=O?RQ_D44JBU\GD6V.R#(L8562R\Z>RD[:BO*<[`R:RJO*+M)O
MN>R%UYM,=Z;C0&_\T`UFN'O8"_QP=O=0UAY(768!D[K49"(VB@;N/S%/9W$(
MC;SSE<,;W\@NV)X7[T+OXM/5^^/>Z0X<'`#3=W[_4;@4V;URN-0I,*JN%,L%
MAJ)03<M4$ZE?OTXPK63S2%\S8HK*J#QB"K<W629TPP03&],4,2$:3=HZNKCJ
MGWX8-+87MJFW6%[\EFSOPI?>\+P_.,4P^-ZO$]W,8_]ZG$*CLP/(`MT55$`_
MO.5ABCZ>SY.43WFR_>2U/V(_37FX\((SATZ`'<,43M`G>P9[;G$O3_/[0_\>
M4A[%!Q70NO:M[\&Q[]BS((4]3]R*9"ING\%:<8C!B7WG3^%S;"?A'-6?^'/8
MR^/\GYD=8!A,12SD,%W=TL5$P_##IH]E+C8G@^[E<>^JVSOO#/MG%\C@"KW;
M"]S>=W]_>?%I,&QL5W9CMX:=8AK7W%]7G]QU=OX_`<DR!+382C9XK6I<S.UN
MSN3:#<J]#R(9Y"<32U.[IAJ;E-AEFJ^>4M34O.+YR4]`8@6@,V.U`OA?:S[.
M-U7B?*>.YJMJ;*CYXFE/^6%N_2,FR9[<3`\]_YI'/T"PD#U-0Q&Q;%?,0CVJ
MKA1P[!6V9)4+N/Q8;$F_14\WJ=D4BM@/)=O;QL7@K-L?[I1NT1]/[=TQ=R?)
2;+I/*3&H[NK2?TM"EF@R&```
`
end

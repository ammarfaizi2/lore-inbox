Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263382AbSJFL0A>; Sun, 6 Oct 2002 07:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263383AbSJFL0A>; Sun, 6 Oct 2002 07:26:00 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:10396 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263382AbSJFLZ4>; Sun, 6 Oct 2002 07:25:56 -0400
To: torvalds@transmeta.com
Subject: [PATCH] Use kernel crc32 for BlueZ BNEP
Cc: linux-kernel@vger.kernel.org, maxk@qualcomm.com, marcel@holtmann.org
Message-Id: <E17y9cT-0003Nk-00@pegasus>
From: Marcel Holtmann <marcel@holtmann.org>
Date: Sun, 06 Oct 2002 13:30:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.755, 2002-10-06 13:06:09+02:00, marcel@holtmann.org
  Use kernel crc32 for BlueZ BNEP


 b/lib/Makefile                    |    1 
 b/net/bluetooth/bnep/Makefile     |    2 -
 b/net/bluetooth/bnep/Makefile.lib |    1 
 b/net/bluetooth/bnep/bnep.h       |    5 +--
 b/net/bluetooth/bnep/core.c       |    4 --
 net/bluetooth/bnep/crc32.c        |   59 --------------------------------------
 net/bluetooth/bnep/crc32.h        |   10 ------
 7 files changed, 5 insertions(+), 77 deletions(-)


diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Sun Oct  6 13:11:11 2002
+++ b/lib/Makefile	Sun Oct  6 13:11:11 2002
@@ -29,5 +29,6 @@
 include $(TOPDIR)/drivers/net/Makefile.lib
 include $(TOPDIR)/drivers/usb/class/Makefile.lib
 include $(TOPDIR)/fs/Makefile.lib
+include $(TOPDIR)/net/bluetooth/bnep/Makefile.lib
 
 include $(TOPDIR)/Rules.make
diff -Nru a/net/bluetooth/bnep/Makefile b/net/bluetooth/bnep/Makefile
--- a/net/bluetooth/bnep/Makefile	Sun Oct  6 13:11:11 2002
+++ b/net/bluetooth/bnep/Makefile	Sun Oct  6 13:11:11 2002
@@ -4,7 +4,7 @@
 
 O_TARGET := bnep.o
 
-obj-y	 := core.o sock.o netdev.o crc32.o
+obj-y	 := core.o sock.o netdev.o
 obj-m    += $(O_TARGET)
 
 include $(TOPDIR)/Rules.make
diff -Nru a/net/bluetooth/bnep/Makefile.lib b/net/bluetooth/bnep/Makefile.lib
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/net/bluetooth/bnep/Makefile.lib	Sun Oct  6 13:11:11 2002
@@ -0,0 +1 @@
+obj-$(CONFIG_BLUEZ_BNEP)	+= crc32.o
diff -Nru a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
--- a/net/bluetooth/bnep/bnep.h	Sun Oct  6 13:11:11 2002
+++ b/net/bluetooth/bnep/bnep.h	Sun Oct  6 13:11:11 2002
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
--- a/net/bluetooth/bnep/core.c	Sun Oct  6 13:11:11 2002
+++ b/net/bluetooth/bnep/core.c	Sun Oct  6 13:11:11 2002
@@ -685,16 +685,12 @@
 
 	bnep_sock_init();
 
-	bnep_crc32_init();
-
 	return 0;
 }
 
 static void __exit bnep_cleanup_module(void)
 {
 	bnep_sock_cleanup();
-
-	bnep_crc32_cleanup();
 }
 
 module_init(bnep_init_module);
diff -Nru a/net/bluetooth/bnep/crc32.c b/net/bluetooth/bnep/crc32.c
--- a/net/bluetooth/bnep/crc32.c	Sun Oct  6 13:11:11 2002
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
--- a/net/bluetooth/bnep/crc32.h	Sun Oct  6 13:11:11 2002
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


begin 664 bkpatch12876
M'XL(`%`:H#T``]6874_;2!2&KS._8B1Z`:*QY]L?NT$4`BTJ"X@MJU5OD#T>
MDQ#'1HY#:67QVW=LDRPD`=MA$=J`,#'FS9GW.3[GC#?@Q42E;F?LI5)%8`-^
M22:9VQDD43;VXMA(TBM]\CQ)]$ESD(R5.?N3Z0^SD5(W*C7]:*I^=8G!@;[V
MS,OD`-ZJ=.)VL$'G9[*?-\KMG!]\OCC^=`Y`KP?W!UY\I?Y4&>SU0):DMUX4
M3':];!`EL9&E7CP9J\PS9#+.YY?F!"&BOSBV*.(BQP(Q*Y<XP-AC6`6(,%LP
M<*VN_=WQ-+I*O5ME;,9)K+861#!"0LL@3'/,]'^!/L2&Q3E$Q,3(1`)BZB+A
M(F<;$1<A6%FT^]@:N&W!+@)[\+^-?A_(`@L<J316$92II`2&20KWM-'?X=[)
MP1GX"BE%M@/._K41=%N^`$`>`CMZ97>CW=NA1CFS*E992373X`>F'ZL;LXS"
MD#/O&*'4(3AG@CHXMT)A.8ZVD6'$J;?2K'QOF'VM$B90D<I48!KZE^Z#\/VB
MQIP2UN_U)Q$A.&L7[6`Y6DYY3FP;(10P3PHA+4^UCW9POZBQ&"U%EE-X^W)F
M1$/?_,,;J7`8J<?)X5`G%UAKY&$@;"21)7POE,RB*V-=DID'0G2.V=AN:MNB
MR-PW;EL\][&EB`@Y$Y)[$J^FW$!U'AKB3A5:*QE#+W?);LSUG62%"MDLH$Q*
M'M)0O%Z9Y(APY#3UK_BQ*NNT2.XXCLUQB`(_='R+K"99JSGWCF#1."R9I&K5
MK8MM6R<J]U&HL"4<A3!K#/6IYBPL1C!'976OL;FH^2?J!RS>NW47@[\@`^#-
MTJ0L_>AIX><NP2\5?O06A5_">=4IC8'U+=>LLTXWBF+1NE'477D.EXSY&Z([
MF^`U.LL;T\+M:.&W:=.'$&M_RP)Q"KOIC_);K[[>Z_:&'B']88E_W?VPN7]Z
M<GCT^7+O^.+@^V4Q#6QUMGO5F&`D=3=?<>.]02]XC::N9EB?*,&2&5A>@&6X
M9O[28/&[S%^'T&:$4XV_ZF+-^:_!OF]I]D?60P+\[$!7XR[J;P(GB1SI@_Z\
M0-T^3[]J(HW9M^ECZRL6W"VVDCMSD?T2=P*[]-VX(XL5W,L.7,^]6ODZ=SS1
MQ0UL#&,930,%?X^&\?1N-MGN@#YQ(`%];),B.:H#?'BE*INF,=PL+[[TU>8]
M^@B]($@_PH-O7RX_'1^<;,&='4C$UF_/I4S5X!NG3)L98WU%/6%P"XM5*<-=
MC&HZ-GN_E,%$ITPU'=6G3+7R=0J%L.TB*80C]*$`VW+3U1QWF^W@*R1)K@4=
M\A3X.XYH!?!^Z>3*J?5A#<544&Y7%UBWI+'.W%7'?'GKVI)YPTWU*R2+32NQ
MT/^+^:"8M,M-?QOFRS369/[X$4#]\[3VSQV`-[H9[P;#*Y4\H^!H]SC7$/7>
ME-H5/<R>UFCB4OH.<WJS&EVT<]W6R^<E"PP?KW:=3DZQ;LZS1OYA\]OI6?_H
??*MV[S9_>"H'2HXFTW%/.A9FNI&#?P#S4[-0N14`````
`
end

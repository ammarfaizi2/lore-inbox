Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318932AbSHSRET>; Mon, 19 Aug 2002 13:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318934AbSHSRET>; Mon, 19 Aug 2002 13:04:19 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:5785 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318932AbSHSRER>;
	Mon, 19 Aug 2002 13:04:17 -0400
Date: Mon, 19 Aug 2002 19:07:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Add support for vt8235 IDE for 2.4
Message-ID: <20020819190711.A8059@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds support for the vt8235 IDE to the 2.4 kernel. Very needed,
because the chip is now starting to sell.

Same patch should also apply to 2.5.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.853, 2002-08-19 19:03:38+02:00, vojtech@suse.cz
  Add support for the vt8235 ATA/133 IDE.


 drivers/ide/via82cxxx.c |   67 ++++++++++--------------------------------------
 include/linux/pci_ids.h |    1 
 2 files changed, 16 insertions(+), 52 deletions(-)


diff -Nru a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
--- a/drivers/ide/via82cxxx.c	Mon Aug 19 19:06:14 2002
+++ b/drivers/ide/via82cxxx.c	Mon Aug 19 19:06:14 2002
@@ -1,61 +1,24 @@
 /*
- * $Id: via82cxxx.c,v 3.34 2002/02/12 11:26:11 vojtech Exp $
+ * Version 3.35
  *
- *  Copyright (c) 2000-2001 Vojtech Pavlik
- *
- *  Based on the work of:
- *	Michel Aubry
- *	Jeff Garzik
- *	Andre Hedrick
- */
-
-/*
- * VIA IDE driver for Linux. Supports
+ * VIA IDE driver for Linux. Supported southbridges:
  *
  *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
- *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233, vt8233c, vt8233a
- *
- * southbridges, which can be found in
- *
- *  VIA Apollo Master, VP, VP2, VP2/97, VP3, VPX, VPX/97, MVP3, MVP4, P6, Pro,
- *    ProII, ProPlus, Pro133, Pro133+, Pro133A, Pro133A Dual, Pro133T, Pro133Z,
- *    PLE133, PLE133T, Pro266, Pro266T, ProP4X266, PM601, PM133, PN133, PL133T,
- *    PX266, PM266, KX133, KT133, KT133A, KT133E, KLE133, KT266, KX266, KM133,
- *    KM133A, KL133, KN133, KM266
- *  PC-Chips VXPro, VXPro+, VXTwo, TXPro-III, TXPro-AGP, AGPPro, ViaGra, BXToo,
- *    BXTel, BXpert
- *  AMD 640, 640 AGP, 750 IronGate, 760, 760MP
- *  ETEQ 6618, 6628, 6629, 6638
- *  Micron Samurai
+ *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233, vt8233c, vt8233a,
+ *   vt8235
  *
- * chipsets. Supports
+ * Copyright (c) 2000-2002 Vojtech Pavlik
  *
- *   PIO 0-5, MWDMA 0-2, SWDMA 0-2 and UDMA 0-6
- *
- * (this includes UDMA33, 66, 100 and 133) modes. UDMA66 and higher modes are
- * autoenabled only in case the BIOS has detected a 80 wire cable. To ignore
- * the BIOS data and assume the cable is present, use 'ide0=ata66' or
- * 'ide1=ata66' on the kernel command line.
+ * Based on the work of:
+ *	Michel Aubry
+ *	Jeff Garzik
+ *	Andre Hedrick
  */
 
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #include <linux/config.h>
@@ -105,8 +68,8 @@
 } via_isa_bridges[] = {
 #ifdef FUTURE_BRIDGES
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
-	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
 #endif
+	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },
@@ -163,7 +126,7 @@
 
 	via_print("----------VIA BusMastering IDE Configuration----------------");
 
-	via_print("Driver Version:                     3.34");
+	via_print("Driver Version:                     3.35");
 	via_print("South Bridge:                       VIA %s", via_config->name);
 
 	pci_read_config_byte(isa_dev, PCI_REVISION_ID, &t);
@@ -414,7 +377,7 @@
 		}
 
 	if (!via_config->id) {
-		printk(KERN_WARNING "VP_IDE: Unknown VIA SouthBridge, contact Vojtech Pavlik <vojtech@ucw.cz>\n");
+		printk(KERN_WARNING "VP_IDE: Unknown VIA SouthBridge, disabling DMA.\n");
 		return -ENODEV;
 	}
 
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Mon Aug 19 19:06:14 2002
+++ b/include/linux/pci_ids.h	Mon Aug 19 19:06:14 2002
@@ -981,6 +981,7 @@
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
+#define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch8093
M'XL(`(8E83T``[5677/:.!1]QK_B3O*2;L'HPY]TLA,::,JFS3))DWW9&4;(
M<NS%V(QL$^BR_WVO#`V=-&FV[=8PEF19AW///;KB$*Y+I7NM9?%7I61B'<+;
MHJQZK;(NE2T_XOBR*'#<38JYZN[>ZDYGW;G04F6%A6^,12436"I=]EK4YO=/
MJO5"]5J7P[/K=_U+RSH^AM-$Y+?J2E5P?&Q5A5Z*+"I/1)5D16Y76N3E7%7"
MEL5\<__JAA'"\.-2GQ/7VU"/./Y&THA2X5`5$>8$GF/M^)PLLEK.UG:4EI4N
M$"E7LDJ7XB%>0#W&N,OIQ@VIPZP!4#MP.1#6)4&7AD##'N$]'KPDK$<(["(_
MV>D"+QETB/4:_M\@3BT)_2B"LEXL"EU!7&BH$@7+*D"RT/_0[U+.8308VM8Y
MN`$CH37>JVIUOO&R+"*(]>LS440Z-<GMIA$Z(!4!DZO5RI:?Q>00BC&AG.Y&
M>"2FCF!2,3_DTGVHW-?1`AI2GW#.-AX-B?,LM32768U`69K7J^Y"II,T*NWD
M<[E#AV](&%*RD;'P`RICWV6^](,OF'T5;,^,,>;3QLY/A/*\N7](4>N;%.4L
MI('#68!&=SEIC!Y^87/VE,VI"QV7_12CGZ=99IRN=)S515T"`LU57I7V([M@
MNP.,Z[?&^!TZ^J[YHHO'3V7B.S;$@`&U1N8&O\`-8J9%#MSFKC5P@!)K1/EN
M;M0W&W'WTPW)=\8X-EQM>2N,H*BK9*K3Z%:5/6M`/:`.@H?`#`(T44DO\-KW
M/;'O3K==3G<M_]3*3QW1WL,8@IP:[LT=GY\6B[5.;Y,*CN0+P+R0CDD.W&QS
MC$5ZF:4S7,7!PU4!.&;5:U$B<8S9U)V[0L^@B'LXT7J?RD1ET*^G>FW&OZDX
MAC.A/R(&#OMYI!6\52B'1%`'%?2MD1L`-Z@?DK2$A2YNM9@#=F.M%*H35W="
MJU>P+FJ0(@>MFKJ=3NM*05J!R*,NZCHOHC1>XP,#5>>1VE;%2NEYB?2:P=G%
M-9RI7&F1P;B>9JG$=$B5EZHYF4P6&0@D8>;*!&.<FC":M6\,FZL=&WA3X$^(
M"E?8F#(2&$TIP:UBM?Z&@ZW6!^W6^'0T&0QO1J?#R6@P03=,S$0;S$56A+3Q
MSN*V\<GD>O"^/S&5^Y^V<8'70#9-"]TZ6>@TKXX.!ELG[4S7@\<NX\2#%Z]0
M8.H;E&W3:C40LZ/SX>7%Y(_^Y<7HX@P.;L9(;=B#ZWR6%W=Y8]DK8\G7C27;
M@&H+E"._!21H_YD;9%/8GJB$SQ>V'ZG'UDRD)]6"VKI.=*?.T\ZTD$D]MR/U
M3&DF'B$.I^&&AJZ_/<O1?_^]QOW,HWQ?N+;GQH/"]41@WU&X1F%@*M-AI.(T
D5_"X/5LMLN+4]_=_VW!3RUE9SX^G`5-1@+7^7WI?9@T3"@``
`
end

-- 
Vojtech Pavlik
SuSE Labs


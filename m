Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319127AbSH2HXs>; Thu, 29 Aug 2002 03:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319128AbSH2HXr>; Thu, 29 Aug 2002 03:23:47 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:12212 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319127AbSH2HXp>;
	Thu, 29 Aug 2002 03:23:45 -0400
Date: Thu, 29 Aug 2002 09:27:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [IDE patch] Support for VIA vt8235 IDE for 2.5
Message-ID: <20020829092752.A806@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.554, 2002-08-29 09:26:21+02:00, vojtech@suse.cz
  Add support for the VIA vt8235 IDE, already approved by Alan.


 drivers/ide/via82cxxx.c |   67 ++++++++++--------------------------------------
 include/linux/pci_ids.h |    1 
 2 files changed, 16 insertions(+), 52 deletions(-)


diff -Nru a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
--- a/drivers/ide/via82cxxx.c	Thu Aug 29 09:26:48 2002
+++ b/drivers/ide/via82cxxx.c	Thu Aug 29 09:26:48 2002
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
--- a/include/linux/pci_ids.h	Thu Aug 29 09:26:48 2002
+++ b/include/linux/pci_ids.h	Thu Aug 29 09:26:48 2002
@@ -987,6 +987,7 @@
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


begin 664 bkpatch797
M'XL(`+C,;3T``[U676_;-A1]EG[%1?*2KHY,4I]6D2%.[*9>V]1(ENQE@$%1
M5*19E@Q*<NQ.^^^]E-UXZYH4;=?)ADB*XO'AN>=>^A!N*JE"8U7^44N1FH?P
MJJSJT*B:2EKB/8ZORA+'_;1<R/[NK7XT[V>Q-'%VRFN1PDJJ*C2H93\\J3=+
M&1I7XXN;-\,KTSPY@?.4%W?R6M9P<F+6I5KQ/*Y.>9WF96'5BA?50M;<$N6B
M?7BU980P_+C4MXGKM=0CCM\*&E/*'2ICPIS`<_9HFN336`$;8..0H+5]RJ@Y
M`FJYK@.$]4G09P,@@Y!Y(://"0L)@=V.3W=ZP',&Q\0\@_]V`^>F@&$<0]4L
MEZ6J(2D5U*F$V\D05G7`;!<FHW$/>*XDCS?`ETM5KF0,T0:&.2\L\S78+AD,
MS.E>9_/X*R_3))R8/P-?1Z4\C1I55%:GZ%RJ0N96/&]CE>E8Z^CW5QD/F%BO
MUY;8:4L]RHA/_=;U_2!H6>P&#F<2-VOC-J-/Q?P"&D;*9Z[CMAZS`P]Y/:UY
M5HB\0:`\*YIU?RFR618C_[]'8.#8+8I$22L2[@=4)+[+?.$'_V+V)-B>F4TH
M,M/N?F0KVNL_2L[O!@Y:CQ#*NAQ@_\P`-W3<QS*`NG#LLO\M![;^UP[?^N`=
M'*O[[HN.G3XF_#>8?\2`FA-]@Y_@%C&SL@#;LEUSY``EYH3:NSG,2DS'W4]W
M1-]HGUAPO>6.B5F539U&*HOO9!6:(^H!=1!\`$PC0+<KX05>[Z'']]UHV[7I
MKK4_MN)CA_?V,)J@337W[H[/S\OE1F5W:0U'XAF@_.18QP!NMZ'$$KW*LSFN
MLL'#50$X>M49KY`X[EFK?E^J.91)B!/&VTRD,H=A$ZF-'O\BDP0NN'J/&#@<
M%K&2\$JB'`)!'530-R=N`+9&_37-*L!J=:?X`K";*"E1G:2^YTJ^@$W9@.`%
M*!EG5:VRJ*DE9#7P(NZCKHLRSI(-/M!031'+K2=JJ185TNL&%Y<W<"$+J7@.
MTR;*,X'A$+*H9'<NZ2@RX$A"SU5I5S4UG%[[4K.YWK&!ER7^!*]QA84A(X'6
ME)(!-L:?<+#5^J!G3,\GL]'X=G(^GDU&,W3#3$_T0%]D34@/[RSI:9_,;D9O
MAS.*0O_5TR[P.LBN,="MLZ7*BOKH8+1UTLYT(7SNTDX\>/8"!::^1MDVAM%!
MS(]>CZ\N9[\-KRXGEQ=P<#M%:N,0;HIY4=X7G66OM27/.DOV`-7F*$=Q!TC0
M^KW0R+J./5+XOGQF?T_Y?:J2/5V)NTH6X&G.?"?PMZ>Y\Q6E[$<>YOOB!5G<
MG=#=:?%)_7ID?]]0OR:#0%OU,)9)5DCXO$L-@ZQMZOO[_VZ8VV)>-8L3YD<B
-'CC4_`"-`75Y%`H`````
`
end
-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293722AbSD1MN0>; Sun, 28 Apr 2002 08:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSD1MNZ>; Sun, 28 Apr 2002 08:13:25 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:27776 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S293722AbSD1MNY>;
	Sun, 28 Apr 2002 08:13:24 -0400
Date: Sun, 28 Apr 2002 14:13:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: [bk+patch] Support for UDMA133 on ICH2, ICH3 and C-ICH
Message-ID: <20020428141321.A10570@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet@1.570, 2002-04-28 14:11:19+02:00, vojtech@twilight.ucw.cz
  This patch adds experimental support for enabling UDMA133 modes even on
  ICH2, ICH2-M, ICH3, ICH3-M, ICH3-S and C-ICH chips, which can support the 133 MB/sec
  mode, even though the specs deny it. It's marked experimental, because it's beyond
  the specs, and also not really tested yet. 


 Config.help |    9 +++++++++
 Config.in   |    3 +++
 piix.c      |    9 +++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)


diff -Nru a/drivers/ide/Config.help b/drivers/ide/Config.help
--- a/drivers/ide/Config.help	Sun Apr 28 14:11:40 2002
+++ b/drivers/ide/Config.help	Sun Apr 28 14:11:40 2002
@@ -431,6 +431,15 @@
   the kernel to change PIO, DMA and UDMA speeds and to configure
   the chip to optimum performance.
 
+CONFIG_BLK_DEV_PIIX_TRY133
+  The ICH2, ICH2-M, ICH3, ICH3-M, ICH3-S and CICH chips can support
+  UDMA133 in hardware, even though the specifications of the chips
+  say otherwise. By enabling this option, you allow the driver to
+  enable the UDMA133 mode on these chips.
+
+  If you want to stay on the safe side, say N here.
+  If you prefer maximum performance, say Y here.
+
 CONFIG_BLK_DEV_PDC202XX
   Promise Ultra33 or PDC20246
   Promise Ultra66 or PDC20262
diff -Nru a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	Sun Apr 28 14:11:40 2002
+++ b/drivers/ide/Config.in	Sun Apr 28 14:11:40 2002
@@ -61,6 +61,9 @@
 	 dep_mbool '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
 	 dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    Intel and Efar (SMsC) chipset support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
+	 if [ "$CONFIG_BLK_DEV_PIIX" = "y" ]; then
+	    dep_bool '      Use UDMA133 even on ICH2, ICH3 and CICH chips (EXPERIMENTAL)' CONFIG_BLK_DEV_PIIX_TRY133 $CONFIG_EXPERIMENTAL
+	 fi
 	 if [ "$CONFIG_MIPS_ITE8172" = "y" -o "$CONFIG_MIPS_IVR" = "y" ]; then
 	    dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool '      IT8172 IDE Tuning support' CONFIG_IT8172_TUNING $CONFIG_BLK_DEV_IT8172 $CONFIG_IDEDMA_PCI_AUTO
diff -Nru a/drivers/ide/piix.c b/drivers/ide/piix.c
--- a/drivers/ide/piix.c	Sun Apr 28 14:11:40 2002
+++ b/drivers/ide/piix.c	Sun Apr 28 14:11:40 2002
@@ -69,6 +69,11 @@
 #define PIIX_CHECK_REV		0x40	/* May be a buggy revision of PIIX */
 #define PIIX_NODMA		0x80	/* Don't do DMA with this chip */
 
+#ifdef CONFIG_BLK_DEV_PIIX_TRY133	/* I think even the older ICHs should be able to do UDMA133 */
+#undef PIIX_UDMA_100
+#define PIIX_UDMA_100 PIIX_UDMA_133
+#endif
+
 /*
  * Intel IDE chips
  */
@@ -78,7 +83,7 @@
 	unsigned char flags;
 } piix_ide_chips[] = {
 	{ PCI_DEVICE_ID_INTEL_82801DB_9,	PIIX_UDMA_133 | PIIX_PINGPONG },                    /* Intel 82801DB ICH4 */
-	{ PCI_DEVICE_ID_INTEL_82801CA_11,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CA ICH3 */
+	{ PCI_DEVICE_ID_INTEL_82801CA_11,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CA ICH3/ICH3-S */
 	{ PCI_DEVICE_ID_INTEL_82801CA_10,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CAM ICH3-M */
 	{ PCI_DEVICE_ID_INTEL_82801E_9,		PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801E C-ICH */
 	{ PCI_DEVICE_ID_INTEL_82801BA_9,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BA ICH2 */
@@ -87,7 +92,7 @@
 	{ PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66  | PIIX_PINGPONG },                    /* Intel 82801AA ICH */
 	{ PCI_DEVICE_ID_INTEL_82372FB_1,	PIIX_UDMA_66 },	                                    /* Intel 82372FB PIIX5 */
 	{ PCI_DEVICE_ID_INTEL_82443MX_1,	PIIX_UDMA_33 },                                     /* Intel 82443MX MPIIX4 */
-	{ PCI_DEVICE_ID_INTEL_82371AB,		PIIX_UDMA_33 },                                     /* Intel 82371AB/EB PIIX4/4E */
+	{ PCI_DEVICE_ID_INTEL_82371AB,		PIIX_UDMA_33 },                                     /* Intel 82371AB/EB PIIX4/PIIX4E */
 	{ PCI_DEVICE_ID_INTEL_82371SB_1,	PIIX_UDMA_NONE },                                   /* Intel 82371SB PIIX3 */
 	{ PCI_DEVICE_ID_INTEL_82371FB_1,	PIIX_UDMA_NONE | PIIX_NO_SITRE | PIIX_CHECK_REV },  /* Intel 82371FB PIIX */
 	{ PCI_DEVICE_ID_EFAR_SLC90E66_1,	PIIX_UDMA_66 | PIIX_VICTORY },                      /* Efar Victory66 */

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch10557
M'XL(`/SFRSP``[57?V_;-A#]V_H4AV1`M]:614G6#P\9FCA>*C1)C30=6JR#
M04M4Q$46#5&.Z\W[[CM2MN,V<5)GB^+0T.'X[O%X]TCOPP?)RF[C1OQ9L3@S
M]N&-D%6W4<UXSJ^RRIS&,S/^"^T70J"]G8DQ:R^]VZ/K-D]8RS8[!GH,:!5G
M<,-*V6T0TUE;JOF$=1L7_9,/IX<7AG%P`+V,%E?L/:O@X,"H1'E#\T2^IE66
MB\*L2EK(,:NH&8OQ8NVZL"W+QK\.\1VKXRV(9[G^(B8)(=0E++%L-_!<8TGM
M]3<+^!;'M0-"-([K!F%H'`,Q.[X%EMVVW+8=`'&[A'1)^,JRNY8%6V#AE0,M
MRSB"_W<1/2.&RXQ+F.@$TB21P+Y,6,G'K*AH#G(ZF8BR@E24P`HZRGEQ!1^.
MSPZ)X\!8)`S];U@!HD"DJ/?&;NJQ=::_G7I<O;7>`RT2Z+7P!>*,3V039AG'
MP#$MUJ&JC(%"/SMJ2Q8CK`K3K,-4F9A>9=I%3E@L(6'%''AE0E2]D#"FY35+
MOEI!$T8LIE/)T`L]1FPNB@1!UQ!-S8GF4D`A*B@9S?,Y5$Q6B#1G"&V\!=<)
M@M`8W-:3T=KQ,0R+6L8O=:+OW[RDY*JF5:6W>Z)(^969L7RRVDK/LHA/G(45
M6KZ]H`&C[@C_O9CZ`=E6-P^#JN*T"2'^PNWX@8WT'BZO3;`)YU_,>*/.7(M@
MG5F.'2Y2+R6QWW&H3XGG6_9WL=L$O"7FA)W`VXG8<I6\N,/-"6UGX9"0NF%,
M,`AQW)#NDKD5Y@8]UW)#+35;$JV$YYGVW$AHSN)K_IK=<,E%T<(.J:8EDX\C
MNW;'MAR/!`OBAF&@58FX=T3)?TR4PN<2I<,D`9T^7%(YU?*C.O;RXI.2!C&I
M<+VF:DQ=M^^@5<[T!QMML&TKGM"SD8O10J/W[OS7Z&1X=/IV>-S_;3B(HH_#
MFHH!J)_LNY5O+7R;BH<8*T7E!62T3&:TW*)X/.4Q58N7(%)MU7`((>D<!!K*
M&9?,A*/YK5Y72N'KG#5A+J:H=KF8Z=EUJG`#$4'[,VW>5'C4=F63RU"F\1E]
MHU0#S6B!@BU`5BIZ4=.D*0Y<:;;B=([[6#+S=LZD9"F&'-,O?#P=`THU[NZ8
M%O%RPJ?EA,_;V@J3].AI_A\$8>>VNE6%55/9Q/.<NJG\W9OJV4YZU52:<ZJ3
MJ%IKOKVU:FE[O+5X\93&\AQPC`;P%'Z'O1_N:;`].("]^1[\\;.B5Z`O/@F;
M#$="Y/`"](-WRG6M+N\AM[WH?-MS/_8_#OH7T5G__/+P]*<7L+VM8<5H<P92
M2/F=HJR/K=TJ<I>S<^M%\Z&S4]TXW87M=3I$EZ']!&WWH64_6QG>J;C53;`6
M(7EG5Y>JF5,^1DE#%.V`_`4*B%9$],KG)ARJFURL:4F0^","D*>Z"TI=U/HZ
M\4!1UYE\2D7[!#K&/D\3ECY068WV2XB4(A?7*X%'A<T35$0L5&2,>I\G>$^%
M6HP%)&*=C)=M8W]:J``:49F'F`-C'TV\8%];-]_PH-IG1<)35-5CO"T2(])C
MXV\8]"+%,>KUA]'Q,#J_[)\.`SNP2`_GD6;C:\Q%C3J(SD\&[\Y/X)\FW/.H
M-185RV$)I+NQO3P(<1''H:4HZ'$K!<<GAT?-Q@8!S,#]\1XBH&':_2--W&WK
>L:](K'\VQAG*O9R.#]+4\EW7'AG_`@7(\2:M#@``
`
end

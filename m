Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSJIIHU>; Wed, 9 Oct 2002 04:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJIIHU>; Wed, 9 Oct 2002 04:07:20 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:41865 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261456AbSJIIHS>;
	Wed, 9 Oct 2002 04:07:18 -0400
Date: Wed, 9 Oct 2002 10:12:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Input - Make i8042.c less picky about AUX ports [1/3]
Message-ID: <20021009101256.A10748@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.597.3.1, 2002-10-08 17:36:32+02:00, vojtech@suse.cz
  Make i8042.c even less picky about detecting an AUX port because of
  broken chipsets that don't support the LOOP command or report failure
  on the TEST command. Hopefully this won't screw any old 386/486
  systems without the AUX port.


 i8042.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Wed Oct  9 10:11:12 2002
+++ b/drivers/input/serio/i8042.c	Wed Oct  9 10:11:12 2002
@@ -654,24 +654,26 @@
 	i8042_flush();
 
 /*
- * Internal loopback test - filters out AT-type i8042's
+ * Internal loopback test - filters out AT-type i8042's. Unfortunately
+ * SiS screwed up and their 5597 doesn't support the LOOP command even
+ * though it has an AUX port.
  */
 
 	param = 0x5a;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa5)
-		return -1;
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa5) {
 
 /*
  * External connection test - filters out AT-soldered PS/2 i8042's
  * 0x00 - no error, 0x01-0x03 - clock/data stuck, 0xff - general error
  * 0xfa - no error on some notebooks which ignore the spec
- * We ignore general error, since some chips report it even under normal
- * operation.
+ * Because it's common for chipsets to return error on perfectly functioning
+ * AUX ports, we test for this only when the LOOP command failed.
  */
 
-	if (i8042_command(&param, I8042_CMD_AUX_TEST)
-	    || (param && param != 0xfa && param != 0xff))
-		return -1;
+		if (i8042_command(&param, I8042_CMD_AUX_TEST)
+		    	|| (param && param != 0xfa && param != 0xff))
+				return -1;
+	}
 
 /*
  * Bit assignment test - filters out PS/2 i8042's in AT mode

===================================================================

This BitKeeper patch contains the following changesets:
1.597.3.1
## Wrapped with gzip_uu ##


begin 664 bkpatch10681
M'XL(`*#DHST``\U5;6_;-A#^+/Z*&PKD9:UEDGJU!P]-DZ(+UB)!7H!]"VB)
MBC3+I"!2<=UI_WU'V4DS%TNZH@,F&Q#$NWOTW-USIQ=P;60[]>[T[U9F)7D!
MOVACIY[IC/2S3_A\H34^CTN]E..MUWB^&%>JZ2Q!^[FP60EWLC53C_G!PXE=
M-W+J7;Q]=_W^Z(*0V0R.2Z%NY:6T,)L1J]L[4>?FM;!EK95O6Z',4EKA9WK9
M/[CVG%*.OX@E`8WBGL4T3/J,Y8R)D,F<\C"-0[(E]GI+>R>>49HRQF(^Z:-T
M,HG)"3`_FB1^X#.@?,SHF*;`DFD03P/^DO(II;`#"2\9C"AY`]^7^#')X(-8
M2*A2&G(_`WDG%=32&&BJ;+$&,=>=A5PB%UNI6Q`*CJY_@T:W%N8R$\@.=($H
M\U8O,#0KJ\9(:\"6`N.TVK=@NF;PMZ6$]V=GYX!,ET+EH%MHY6`J1%5WK40<
MK0:_J[>75_=^/HJBD457UVNT5096&]BLE2LDM`9=YQ"D\1A30@2S-E8NT:NR
MI2/OX.XY^^17B":44G+^60]D]"\O0JB@Y.>''ME555>WI?6[;.7:G[>5$^1&
MI&,4>*7'VP)O^I+0@/$H9G$?H#IXGU#7$L$R24-6T'RW^\\B#A*+@IBG?1@&
M23H(_HD@-P+_&?LOQN$KV">,\TG$>SY)4SH,"(MW9X.G_S@;%$;I_VHX'FD6
M49Y3[;.:W33U#$;M:OBC!L^?ZN\W2/HDCA)@Y-3=`@(_PJFRLE6BAEKK9BZR
M!5AI+(R@J&JT&'!$CZY&;M-N2K1O?+A6!7+NE+`24T>8R^IRD[3,H6O`S3UF
M5[40X0K$#2'-DSO"U=S!N+K<EE!9*(7Y6Z61><R`(_.88P)>5<#!0.=FBW&P
MUXA6+%_!Z7!Z_.'D!H-OW&L.H>]AL,(/,Z`?170(?SC`=`,XP1N^_,UVTU5V
MWPS,<$MAFH^VG<9-9KM6@6Q;-*"]D6V!NL"=570*]:$52L2!W1,WKV`E-S5U
M6(-&M$+_52G5EX5P*U+F+MN$8X-.XR2$D'A?G:[;J(?H#WAYF/7!)NV]O<?Y
J%V+WH#AT09ZW36_$?B+>GY\_O%DILX7IEK,@C^9AQ"GY"_?0R^/3!P``
`
end

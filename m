Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319520AbSH3Jmr>; Fri, 30 Aug 2002 05:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319521AbSH3Jmr>; Fri, 30 Aug 2002 05:42:47 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:45972 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319520AbSH3Jmq>;
	Fri, 30 Aug 2002 05:42:46 -0400
Date: Fri, 30 Aug 2002 11:46:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [patch] Ignore bad result of i8042 AUX test - happens on Dell machines
Message-ID: <20020830114652.B20483@ucw.cz>
References: <20020829202903.A2428@ucw.cz> <20020829222424.A3919@ucw.cz> <20020829222909.B3919@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020829222909.B3919@ucw.cz>; from vojtech@suse.cz on Thu, Aug 29, 2002 at 10:29:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.543, 2002-08-30 11:22:23+02:00, vojtech@suse.cz
  Ignore error 0xff - 'general error' in AUX wire test in i8042.c,
  some mainboards (Andrew Morton's Dell) report that even when everything
  is okay with AUX. Also remove a check for very old AMI i8042's, which
  could generate false positives on modern buggy mainboards.


 i8042.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Fri Aug 30 11:25:07 2002
+++ b/drivers/input/serio/i8042.c	Fri Aug 30 11:25:07 2002
@@ -576,9 +576,12 @@
 
 /*
  * External connection test - filters out AT-soldered PS/2 i8042's
+ * 0x00 - no error, 0x01-0x03 - clock/data stuck, 0xff - general error
+ * We ignore general error, since some chips report it even under normal
+ * operation.
  */
 
-	if (i8042_command(&param, I8042_CMD_AUX_TEST) || param)
+	if (i8042_command(&param, I8042_CMD_AUX_TEST) || (param && param != 0xff))
 		return -1;
 
 /*
@@ -587,23 +590,11 @@
 	
 	if (i8042_command(&param, I8042_CMD_AUX_DISABLE))
 		return -1;
-
 	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (~param & I8042_CTR_AUXDIS))
 		return -1;	
 
-	if (i8042_command(&param, I8042_CMD_AUX_TEST) || param) {
-
-/*
- * We've got an old AMI i8042 with 'Bad Cache' commands.
- */
-
-		i8042_command(&param, I8042_CMD_AUX_ENABLE);
-		return -1;
-	}
-
 	if (i8042_command(&param, I8042_CMD_AUX_ENABLE))
 		return -1;
-
 	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (param & I8042_CTR_AUXDIS))
 		return -1;	
 

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch20470
M'XL(`/,Y;ST``^U576_;-A1]-G_%'0KD8[4EDI(_9,!#O+CH@BU8D#;8W@*&
MHBW.$FF0E+T,^O&[DMQT+=`&+=JWV89D7I*']YYSKO0"[KQR\\'>_A64+,@+
M^,7Z,!_XVJM(_H/C6VMQ'!>V4O%Q5?RPC;79U8'@_(T(LH"]<GX^8%'R%`F/
M.S4?W+YZ???;\I:0Q0(N"V$VZHT*L%B08-U>E+F_$*$HK8F"$\97*HA(VJIY
M6MIP2CE^QVR:T/&D81.:3AO)<L9$RE1.>3J;I._1=LIL:OT,W(QGG+%QRAN>
MC+.,K(!%XS0!RF,ZBQ,*C,TYG_/D)>5S2N%8]L61%'C)8$3)S_!M:[@D$JXV
MQCH%RCGK@/Z]7L,(3C?**"?*/GH*VL#R[D\X:%P8E`]M0,]HRB,Y1`B/0D$E
MM'FPPN4>SI8F=^H`U]8%:TX]K%19GH-3.PQ`*$0`M5>FO;C'4&BS01#MP6[%
M(QX2BO:T"):EM[BILGL%`F2AY!;6F&2["VR9P_+ZJD_CU`_A4&@TDP1I:YSJ
M"P@*UJ+T"G;6ZZ#W"L\P4-E<.0,/]6;S^)^T(_(K\(3QC-R\]PT9?>&'$"HH
M^>E)P'#0I=X4(:KE`85L<J=;X_9FCK$1M(V/5/:B32GF,)ZP29-P1GDSI:U>
M@DE%4[:F^<?6>!YQEE":<<ZR)DE8RKO&^,RFME6^6_8D%WM579@Z^,AHLQ61
M0;<^7P+/$#9I2\`Z6-<^C'_</2S[5/>D,&+)_^WSR?9IO=^;XW<8N4/W0R_?
M?,XG7]$:5^/I#!("/R)3*-,(C.TY&K8!-L)+@E%96KF-<Q$$^%#+[?`=L1_P
MVL+\H4#W`GPP-02OC50]L[+0._^./7WDKC;X#,#C727*%LCNVL>%1DN0U7C&
M@&&NW6V@UW#657R/%JF$R<].=L*):@A77?3R>G6/?-^_??7F[3DT#9QUTW!R
M`OV?'Q9=^N?GB)RA5=M;"HR2U81.</CT^NHD\G6U$.ET@EH(\B]2^K^_*P<`
!````
`
end

-- 
Vojtech Pavlik
SuSE Labs

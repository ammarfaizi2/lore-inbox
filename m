Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbSKOIGk>; Fri, 15 Nov 2002 03:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSKOIFd>; Fri, 15 Nov 2002 03:05:33 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:46209 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265895AbSKOIEb>;
	Fri, 15 Nov 2002 03:04:31 -0500
Date: Fri, 15 Nov 2002 09:11:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Only check for SET_LEDS in atkbd.c when really needed [4/13]
Message-ID: <20021115091119.C16779@ucw.cz>
References: <20021115090818.A16761@ucw.cz> <20021115090922.A16779@ucw.cz> <20021115091011.B16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115091011.B16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:10:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.781.10.6, 2002-10-19 23:17:51+02:00, vojtech@suse.cz
  atkbd.c: Only issue the set LED command during probe when absolutely needed.


 atkbd.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Fri Nov 15 08:31:42 2002
+++ b/drivers/input/keyboard/atkbd.c	Fri Nov 15 08:31:42 2002
@@ -380,30 +380,39 @@
 			printk(KERN_WARNING "atkbd.c: keyboard reset failed\n");
 
 /*
- * Next we check we can set LEDs on the keyboard. This should work on every
- * keyboard out there. It also turns the LEDs off, which we want anyway.
- */
-
-	param[0] = 0;
-	if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
-		return -1;
-
-/*
  * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
  * Some keyboards report different values, but the first byte is always 0xab or
  * 0xac. Some old AT keyboards don't report anything.
  */
 
 	if (atkbd_command(atkbd, param, ATKBD_CMD_GETID)) {
+
+/*
+ * If the get ID command failed, we check if we can at least set the LEDs on
+ * the keyboard. This should work on every keyboard out there. It also turns
+ * the LEDs off, which we want anyway.
+ */
+		param[0] = 0;
+		if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
+			return -1;
 		atkbd->id = 0xabba;
 		return 0;
 	}
+
 	if (param[0] != 0xab && param[0] != 0xac)
 		return -1;
 	atkbd->id = param[0] << 8;
 	if (atkbd_command(atkbd, param, ATKBD_CMD_GETID2))
 		return -1;
 	atkbd->id |= param[0];
+
+/*
+ * Set the LEDs to a defined state.
+ */
+
+	param[0] = 0;
+	if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
+		return -1;
 
 /*
  * Disable autorepeat. We don't need it, as we do it in software anyway,

===================================================================

This BitKeeper patch contains the following changesets:
1.781.10.6
## Wrapped with gzip_uu ##


begin 664 bkpatch16496
M'XL(`-ZBU#T``[5576^;0!!\]OV*E?+2-#'<`09#Y"H?CEHKJ1+%R5-310>W
M&&K,6=P1RY5_?`_L.%&JMDG4`-*QL+O,S`ZP`S<*JZAS+W]H3#*R`U^DTE%'
MU0JMY*>)KZ0TL9W)&=J;+#N>VGDYKS4Q]R^Y3C*XQTI%'6:YVRMZ.<>H<W7Z
M^>;\Z(J0P0!.,EY.<(P:!@.B977/"Z$.N<X*65JZXJ6:H>96(F>K;>K*H=0Q
M>X\%+NWY*^93+U@E3##&/8:".E[?]\@&V.$&]K-Z1EE(`R]LZFFO[Y(A,"OH
M,XM1RP?JV(S:+`3'C5@0]=@>=2)*X5E/V&/0I>08_B_R$Y(`U]-86$D$%V6Q
MA%RI&D%G",I(=7XZ!--WQDL!HJ[R<@+S2L8(BPQ+X+&21:W1E)6(`H5%SB`,
MPAZY?)2;=%^Y$4(Y)9^V"NA%7N233%MULFC4%57>S'OM`7N*RUCR2M@;&FOB
M`7692_L>7;&PS]@JCD6(#D7!7#\,W.?JOJ1G,T:'L<#(V//"(&A-]?>ZQFGO
MR()4.CL44ELJC?G2JE!D7+<V>!D=9I:@YZP\A_IAZTKG-S]ZP1_]V(=N^"Z&
M?+4/'\VWGLP%=*M%>Q@W7?YC2&_PY]#MNQ"2D1L&9KDE]D<"'V&4MG`G!N[H
M$6W*\P+%/BP0D@R3*>1I>\[-ZZ.A0*YTR[`I-2P5R+)IUH0/2"VXSG(%*I-U
M(6`AJZE)`C2<EML<D'7;HT(+1AIXH23HNBK50[-U[S0U2++<?"`-A@4O36:Y
M7!CSF#2;=#IS7O'9-_H=!D`/3&S`?FAUNMOP64?[T";NP]'UV?'P[N3K\&Y\
M>FT>,=[=-56="IMG0Y<=D)%GS,.,2.;$A_Y6K?%3SEH"!X%I7J(`I;G&-:!;
?\AS1VP`]P;/]0[334/5LD/;0%VGBDU]P3G%4C@8`````
`
end

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261537AbSJIKzw>; Wed, 9 Oct 2002 06:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSJIKzw>; Wed, 9 Oct 2002 06:55:52 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:7040 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261537AbSJIKzq>;
	Wed, 9 Oct 2002 06:55:46 -0400
Date: Wed, 9 Oct 2002 13:01:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Input - Only try to enable extra keys if user requested it [2/3]
Message-ID: <20021009130123.B367@ucw.cz>
References: <20021009101256.A10748@ucw.cz> <20021009130035.A367@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021009130035.A367@ucw.cz>; from vojtech@suse.cz on Wed, Oct 09, 2002 at 01:00:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.719, 2002-10-09 12:49:06+02:00, vojtech@suse.cz
  Don't try to enable extra keys on IBM/Chicony keyboards as this upsets
  several notebook keyboards. Until we find a better solution how to detect
  who are we talking to, we rely on the kernel command line. Use
  atkbd_set=4 to gain access to the extra keys.


 atkbd.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Wed Oct  9 13:00:24 2002
+++ b/drivers/input/keyboard/atkbd.c	Wed Oct  9 13:00:24 2002
@@ -280,6 +280,7 @@
 				param[1] = (test_bit(LED_COMPOSE, dev->led) ? 0x01 : 0)
 					 | (test_bit(LED_SLEEP,   dev->led) ? 0x02 : 0)
 					 | (test_bit(LED_SUSPEND, dev->led) ? 0x04 : 0)
+				         | (test_bit(LED_MISC,    dev->led) ? 0x10 : 0);
 				         | (test_bit(LED_MUTE,    dev->led) ? 0x20 : 0);
 				atkbd_command(atkbd, param, ATKBD_CMD_EX_SETLEDS);
 			}
@@ -309,8 +310,8 @@
 
 /*
  * For known special keyboards we can go ahead and set the correct set.
- * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and IBM RapidAccess
- * keyboards.
+ * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and
+ * IBM RapidAccess / IBM EzButton / Chicony KBP-8993 keyboards.
  */
 
 	if (atkbd->id == 0xaca1) {
@@ -319,14 +320,17 @@
 		return 3;
 	}
 
-	if (!atkbd_command(atkbd, param, ATKBD_CMD_OK_GETID)) {
-		atkbd->id = param[0] << 8 | param[1];
-		return 2;
-	}
+	if (atkbd_set != 2) 
+		if (!atkbd_command(atkbd, param, ATKBD_CMD_OK_GETID)) {
+			atkbd->id = param[0] << 8 | param[1];
+			return 2;
+		}
 
-	param[0] = 0x71;
-	if (!atkbd_command(atkbd, param, ATKBD_CMD_EX_ENABLE))
-		return 4;
+	if (atkbd_set == 4) {
+		param[0] = 0x71;
+		if (!atkbd_command(atkbd, param, ATKBD_CMD_EX_ENABLE))
+			return 4;
+	}
 
 /*
  * Try to set the set we want.
@@ -505,7 +509,7 @@
 	}
 
 	if (atkbd->set == 4) {
-		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE);
+		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
 		sprintf(atkbd->name, "AT Set 2 Extended keyboard");
 	} else
 		sprintf(atkbd->name, "AT Set %d keyboard", atkbd->set);

===================================================================

This BitKeeper patch contains the following changesets:
1.719
## Wrapped with gzip_uu ##


begin 664 bkpatch487
M'XL(`$@,I#T``[55;6_B1A#^C'_%G.Y#0P_LW;6-,3FG%\!*$2&@$-1*U0DM
M]B;V86QD+^&XNO^]LSB0-UU[5_4,DC6S,\\^L_/,^BW,"I%W:O?9)RF"2'L+
MOV:%[-2*32'TX`O:UUF&MA%E*V$\1!F+I1&GZXW4<'W"91#!O<B+3HWJYM$C
M=VO1J5W[%[/+\VM-\SSH13R]$U,AP?,TF>7W/`F+#UQ&29;J,N=IL1*2ZT&V
M*H^A)2.$X<^FCDGL5DE;Q'+*@(:4<HN*D#"KW;*T!V(?'FB_R*>$N)109MLE
M<6S'U?I`=8>Z0)A!B4%<H*QCN1W2>D=8AQ!X`0?O*#2)UH7_EW1/"Z"?I3])
MD/D.L4&D?)$($)\1%Y9B5T"6PJ`[,GI1'&3I3OD6&<_#`G@!,HH+V*P+(0L$
M*@2V@">09E(LLFSY&*O#+)5Q`EL!MW$:`H>%D%+D4&3)1L:X191MU?:AP*(E
M8FVC#'@N5(;DR3).[W"YH<Q<)#M%2D8"-\A3D0!6ON((F\2IT)6:$(#+Y2*<
M(S//4L!W/$Z!!X$H"F6JY,<:=6T(CMUVM,FC0+3F=SZ:1CC1SHZ-D]LXB>\B
MJ6^"K=)#F,=*H95JC</1&'N>>E#URR$F-4G;(B5UVY26BT7H"D9$2,V6ZY@O
M1?$MF)7P+)?0TJ+,8OLQ^.<\-1L_L(I7D_)M5;11SI21$N5LT_WX,//5]-"O
M3H\%3?ICYF><HB"_.C[;2*10K$40W\8B/`CWF6)1?55KQM#,M_L_RFGR+UWZ
M#P(=L#8#JM7P@<-3PHD4A9PO8GERZ??GH\&TUU`+H;AOGB4BK,,O0#Y3`AT@
M]5.M;U(&3!M@B_$%/\-O6$TD@B7<9CE<]?HPF1H,IINT`5=9+J,++@6,5VD\
M%#O`*Q"P;I6'EPI<\W4<GE=3:>P]_I?N1DH\)0,.-\ZP.VFV7==\<IT@"\;`
M0A;,!ENKQ;=P<AQX>.,!JP.6J=QO*O_#@5=1#5CSG*\:<'XS[/;GO5%_/A[.
M+_R;0;]>AS_5`>WCFF=Q"%X5_`?Y"._?0QL/K++IQU,5F`NYR5-@ROA+\7+`
M5+S<U[QP\*P*_HCHX=$Z]/3[N/J_S_VK\^ZE7Z\_86`A"A*P21M;/*A>QSJP
MF3KV$INL=BT]Z`YN]NWNC4>3\=2O8UD'UW0VG?A7_6>N2]^?/'6,9C?/<I1J
;4!S'+^]>$<5FY;F<WEHD-+6_`?/.$N7F!P``
`
end

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262391AbSJKKlk>; Fri, 11 Oct 2002 06:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSJKKks>; Fri, 11 Oct 2002 06:40:48 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:10372 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262394AbSJKKkf>;
	Fri, 11 Oct 2002 06:40:35 -0400
Date: Fri, 11 Oct 2002 12:46:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Fix keyboard autorepeat ioctl [5/5]
Message-ID: <20021011124615.D1763@ucw.cz>
References: <20021011124406.A1677@ucw.cz> <20021011124452.A1763@ucw.cz> <20021011124526.B1763@ucw.cz> <20021011124550.C1763@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021011124550.C1763@ucw.cz>; from vojtech@suse.cz on Fri, Oct 11, 2002 at 12:45:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.743, 2002-10-11 12:02:20+02:00, Andries.Brouwer@cwi.nl
  Since 2.5.32 the keyboard repeat code was broken.
  The reason Vojtech broke it was the stupid name of a field
  in struct kbd_repeat, namely "rate".  Every sane person
  expects that a rate has dimension [1/sec], but here the
  "rate" is a time period measured in msec.
  
  So, the patch below first of all fixes the code,
  and secondly changes the name.
  Since Vojtech used PERIOD as index, I also used period
  as field name in the struct.
  
  Half of the stuff below is actually from Alan Stern.
  
  Andries


 drivers/char/keyboard.c   |   31 +++++++++++++++++++++----------
 drivers/char/vt_ioctl.c   |    6 ++++--
 drivers/sbus/char/uctrl.c |    2 +-
 include/linux/kd.h        |    3 ++-
 4 files changed, 28 insertions(+), 14 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Fri Oct 11 12:43:20 2002
+++ b/drivers/char/keyboard.c	Fri Oct 11 12:43:20 2002
@@ -264,23 +264,34 @@
 /*
  * Setting the keyboard rate.
  */
+static inline unsigned int ms_to_jiffies(unsigned int ms) {
+	unsigned int j;
+
+	j = (ms * HZ + 500) / 1000;
+	return (j > 0) ? j : 1;
+}
+
 int kbd_rate(struct kbd_repeat *rep)
 {
-	struct list_head * node;
-
-	if (rep->rate < 0 || rep->delay < 0)
-		return -EINVAL;
+	struct list_head *node;
+	unsigned int d = 0;
+	unsigned int p = 0;
 
 	list_for_each(node,&kbd_handler.h_list) {
 		struct input_handle *handle = to_handle_h(node);
-		if (test_bit(EV_REP, handle->dev->evbit)) {
-			if (rep->rate > HZ) rep->rate = HZ;
-			handle->dev->rep[REP_PERIOD] = rep->rate ? (HZ / rep->rate) : 0;
-			handle->dev->rep[REP_DELAY] = rep->delay * HZ / 1000;
-			if (handle->dev->rep[REP_DELAY] < handle->dev->rep[REP_PERIOD])
-				handle->dev->rep[REP_DELAY] = handle->dev->rep[REP_PERIOD];
+		struct input_dev *dev = handle->dev;
+
+		if (test_bit(EV_REP, dev->evbit)) {
+			if (rep->delay > 0)
+				dev->rep[REP_DELAY] = ms_to_jiffies(rep->delay);
+			if (rep->period > 0)
+				dev->rep[REP_PERIOD] = ms_to_jiffies(rep->period);
+			d = dev->rep[REP_DELAY]  * 1000 / HZ;
+			p = dev->rep[REP_PERIOD] * 1000 / HZ;
 		}
 	}
+	rep->delay  = d;
+	rep->period = p;
 	return 0;
 }
 
diff -Nru a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
--- a/drivers/char/vt_ioctl.c	Fri Oct 11 12:43:20 2002
+++ b/drivers/char/vt_ioctl.c	Fri Oct 11 12:43:20 2002
@@ -430,6 +430,7 @@
 	case KDKBDREP:
 	{
 		struct kbd_repeat kbrep;
+		int err;
 		
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
@@ -437,8 +438,9 @@
 		if (copy_from_user(&kbrep, (void *)arg,
 				   sizeof(struct kbd_repeat)))
 			return -EFAULT;
-		if ((i = kbd_rate( &kbrep )))
-			return i;
+		err = kbd_rate(&kbrep);
+		if (err)
+			return err;
 		if (copy_to_user((void *)arg, &kbrep,
 				 sizeof(struct kbd_repeat)))
 			return -EFAULT;
diff -Nru a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
--- a/drivers/sbus/char/uctrl.c	Fri Oct 11 12:43:20 2002
+++ b/drivers/sbus/char/uctrl.c	Fri Oct 11 12:43:20 2002
@@ -107,7 +107,7 @@
 	u8 speaker_volume; /* 0x23 */
 	u8 control_tft_brightness; /* 0x24 */
 	u8 control_kbd_repeat_delay; /* 0x28 */
-	u8 control_kbd_repeat_rate; /* 0x29 */
+	u8 control_kbd_repeat_period; /* 0x29 */
 	u8 control_screen_contrast; /* 0x2F */
 };
 
diff -Nru a/include/linux/kd.h b/include/linux/kd.h
--- a/include/linux/kd.h	Fri Oct 11 12:43:20 2002
+++ b/include/linux/kd.h	Fri Oct 11 12:43:20 2002
@@ -134,7 +134,8 @@
 
 struct kbd_repeat {
 	int delay;	/* in msec; <= 0: don't change */
-	int rate;	/* in msec; <= 0: don't change */
+	int period;	/* in msec; <= 0: don't change */
+			/* earlier this field was misnamed "rate" */
 };
 
 #define KDKBDREP        0x4B52  /* set keyboard delay/repeat rate;

===================================================================

This BitKeeper patch contains the following changesets:
1.743
## Wrapped with gzip_uu ##


begin 664 bkpatch1749
M'XL(`$BKICT``\58>V_;-A#_V_H4AQ;8DC212;TLV7.6M$F78`4:I&N!M2L,
M6J)CV1)ED%02=]YWWU%27G;=/+9U=B!#Y-WQ=^]CGL-[Q66W=5Y,-(_'UG,X
M*I3NME2IN!U_P??3HL#W]KC(>;NA:@^G[53,2FWA_@G3\1C.N53=%K7=ZQ4]
MG_%NZ_3PE_=O]D\MJ]^'5V,FSO@[KJ'?MW0ASUF6J#VFQUDA;"V94#G7S(Z+
M?'%-NG`(<?#KTXY+_&!!`^)U%C%-*&4>Y0EQO##PK`;87@-[B9\22BDAU'$6
M;M0AU#H`:G<\%XC3IJ1-*5"G2YRN0U[@DQ#8%XE,N;)?RJ*\X'(OODAMD<$+
M#W:(]1+^7>ROK!C>I2+FX-B^[3J@QQRF?#XLF$Q`\AEG&N(BX7#!%`QE,>7"
M1I[?D$QRI@H!'VKUZTU(=45IQ"A=SM($!,LY%"-@,$IYEB!S*G!/EK&&Z3`9
MU(=L5W39')Y)IODS&^`0W3H'Q02'&3JX$,C)+V<\UD8\PF)@2&&,QR5ISH5*
M$<TGVE8\_KP-PU+#F$MNH"!G+192A6P:J8W,M$@@1R5*R1,#*D=.HYRQ2;%=
MZ3"KPFG(L^("X4NE*TVR#%\N>:VFL<XVLC"1``HH1():Q)4?:@*CF'UMYRMS
M8;`D<')X>OSV`%"#5"3\<AN.4;@JZLT:H9&L:M/5ID2@M76-!1NX1RP;&62-
MV4>C!K)1-]8E`I[#2!8Y[&=,P#O-I6@XFVBS?@4W<J/0.KG)%&OGD1_+(HQ8
MN_>$*)YG$K:-)I+M<VW'MT+5(\1;!"[FS,(/@L`=,>HSCU#FKLN+97&#M(AU
MU@AM<L^AWL*+"(D>A^TJ#581^GY$HP7WXH3P8.@D(SX:N<&#$"X)O860>AX-
M'HQ0#<M&(D:!S)8P4BPV3N0[BRB,8RP[H<N"P`^=Z#Z,7Q=["Z7OX>=>E!CI
M69GP=I:*\K(]3>SQ[7H4>61!?>J'"R\9AF[HCX8D]I@7N.O@K9%W&U<8=(*J
MTJ\Q]_UU_Q\Y?Z4+?-OK)#1?ERP(!J97]00:+;<$ZMW3$AP*._2_:0JOT\M;
M?<#46<6U3L69C:6B#M6WL",OJC],_9-U=G]"%3EV@@`ZEM),IZ9;H-<YE%C?
MST15J#56ZH$N!I-TA'51;2QM;<*?5NO.VJ1G_6&U)M"'C5S!%AQ]A!?@$[()
M;4!?D)[5DER74L#&!'8!UW^&"72!]JR_D//`"2+P$%;'`==J-;TK2Y4>C#E+
M8$M@"^@MG9G@:61Y<58O'CB=``(4&%*(K-:5Q&JL&23\'+;,HX^M#9L)W]G%
MMTJ#5CJ"#<WQW&&J-PX_#$X/3[8!=W=V^3DN;5:JUV385@UCQN:51F:Y55'B
MQB?D&QP<OMG__3.><M>8-WR;O3NRFH;Y=6%U(ULCK>:LQ1FS?`T&>L5X`AUR
M]+$BG"T37AUQAQ!-Z()CW'>MK>'K-2L-YC[,>JNUX:99/+(V/+QI61.5YGDA
MU%[.+B]XEMF<292?BJDM,!^_U;Q(1#LT=#JNO_`Z/JT'1QH^NDC@W.A\_Q)1
M]]MOE8@;=9]2(CR<5:G)",PJ+B7FE.<1C(1C+$TF25NXB'ZO!DR$MO'#=(@1
M4<6@B6C<K:*X2?M*PNT`6>F##P^1)W9F2Y9*S_?,,R[DS(BT67F?U`Z-2$"I
M'V%C=E"(B9'']Q'31KY_B-2CQ)H06='W"4%R@,,!!LEQ_=,J0YS5A99%-KBY
M=PSJ$M&#]A:02QR0MMI5(*Q.'/='P%.G'NM+.IOQ;*_BV\F#<&H7\FRM.!^]
MWJ$X1:#/`]^M?.X]?G;X?WQ>C6E+/E]5]$G.=CN5L_$'&T+5;6O7MM"US>VN
M!S]A`^Y"4H@?=7-),Q['2H!$6)NSE$N\1:57-RYSE\U392Y>R=4=TD3(U3\:
7XC&/IZK,^\Q+T$1#8OT-CH##&-40````
`
end

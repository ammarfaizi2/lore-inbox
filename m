Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSG3K0B>; Tue, 30 Jul 2002 06:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSG3K0B>; Tue, 30 Jul 2002 06:26:01 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:9121 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318131AbSG3KZ7>;
	Tue, 30 Jul 2002 06:25:59 -0400
Date: Tue, 30 Jul 2002 12:29:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: [patch] Small input fixes for 2.5.29 [2/2]
Message-ID: <20020730122918.A11248@ucw.cz>
References: <20020730122638.A11153@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020730122638.A11153@ucw.cz>; from vojtech@suse.cz on Tue, Jul 30, 2002 at 12:26:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.527, 2002-07-30 11:54:26+02:00, vojtech@suse.cz
  This simplifies the software autorepeat code in input/input.c,
  also killing a race which could be the cause of autorepeat not
  stopping after a key was released.


===================================================================

 input.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Tue Jul 30 12:26:59 2002
+++ b/drivers/input/input.c	Tue Jul 30 12:26:59 2002
@@ -100,18 +100,14 @@
 			if (code > KEY_MAX || !test_bit(code, dev->keybit) || !!test_bit(code, dev->key) == value)
 				return;
 
-			if (value == 2) break;
+			if (value == 2)
+				break;
 
 			change_bit(code, dev->key);
 
-			if (test_bit(EV_REP, dev->evbit) && dev->timer.function) {
-				if (value) {
-					mod_timer(&dev->timer, jiffies + dev->rep[REP_DELAY]);
-					dev->repeat_key = code;
-					break;
-				}
-				if (dev->repeat_key == code)
-					del_timer(&dev->timer);
+			if (test_bit(EV_REP, dev->evbit) && value) {
+				dev->repeat_key = code;
+				mod_timer(&dev->timer, jiffies + dev->rep[REP_DELAY]);
 			}
 
 			break;
@@ -204,8 +200,13 @@
 static void input_repeat_key(unsigned long data)
 {
 	struct input_dev *dev = (void *) data;
+
+	if (!test_bit(dev->repeat_key, dev->key))
+		return;
+
 	input_event(dev, EV_KEY, dev->repeat_key, 2);
 	input_sync(dev);
+
 	mod_timer(&dev->timer, jiffies + dev->rep[REP_PERIOD]);
 }
 
@@ -268,6 +269,7 @@
  *
  *     Returns nothing.
  */
+
 #define input_find_and_remove(type, initval, targ, next)		\
 	do {								\
 		type **ptr;						\
@@ -513,7 +515,7 @@
  * Kill any pending repeat timers.
  */
 
-	del_timer(&dev->timer);
+	del_timer_sync(&dev->timer);
 
 /*
  * Notify handlers.

===================================================================

This BitKeeper patch contains the following changesets:
1.527
## Wrapped with gzip_uu ##


begin 664 bkpatch11222
M'XL(`/-I1CT``[54?V_:,!#]&W^*FRI5185@.TY"J:C:#;15JS1$UTG3-B&3
M7)J4D+#8`;'EP\\)E'6H6[5?222?[;OG=W?/.8`;A7FOL<SN-/H1.8!7F=*]
MABH46OX7,Q]GF9EWHFR.G:U79SKKQ.FBT,3LCZ3V(UABKGH-9MF[%;U>8*\Q
M'KZ\N;H8$]+OPXM(IK=XC1KZ?:*S?"F30)U+'259:NE<IFJ.6EI^-B]WKB6G
ME)O789Y-';=D+A5>Z;.`,2D8!I2+KBO(EMCYEO9^O(FE7<I,O*!".&0`S'*X
M!Y1WJ->Q*3#6<T2/N\>4]RB%/3@X9M"FY#G\6](OB`]OHUB!BN>+)`YC5*`C
M!)6%>B5S!%F8`W&!4H.?!0AQ"G79-\6W_)8!D(G*8!8G29S>@H1<^@BK*#8-
M\+,B"6"*-:8O32J0A0\QTTP;`*6SQ:(.#C7F!F*&:UA)!3DF*!4&%GD-]HEK
M"S+ZWD+2_LV'$"HI.7NBA$$>5TKJ_)#F@W(*,Y2N<$^<D@==FP=!Z`6FLQBR
M_:;]"JO2PXDCF%T*P;E3J_-1]Z>5^A>,=ZK5JSB);R-M%?[J*>;<84;'7)3"
MHQZME<SXOI"9_5,A<VBS_R/EZXV*U_NR;8'Z7$@5W:O3R#''2E2;VK^!=KZJ
M/R.2T>-M^`.U#1BU@9'+:N"DT6C$(1R9C`LT/07>K)8:TQSE[+3R]:!K?)D`
M^]Y7H]*3::R/AN\FX^&H!0$NVV>X-$M-.#R$&JL)7VN@>F^3\Z2Z/_TZ\]-Z
M;YX%$QW/,3\ZK-UJNP5W<5C?^&.X#_Y@CID,AE<7[S\U3\DEIRX(\I'4;)[M
MZ.P=M>5EK&:54XZZR--3$V;BNZ8`E>'1VA@XS*U*LAD,YV3#:Z+6J?^0G#E]
9]QOW(_1GJICW`S>8^HQ2\@UFTX*M,P8`````
`
end

-- 
Vojtech Pavlik
SuSE Labs

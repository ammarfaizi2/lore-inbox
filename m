Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSHZJLl>; Mon, 26 Aug 2002 05:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSHZJLl>; Mon, 26 Aug 2002 05:11:41 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:59331 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318022AbSHZJLj>;
	Mon, 26 Aug 2002 05:11:39 -0400
Date: Mon, 26 Aug 2002 11:15:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Stricter checks in [gs]etkeycode, recompute keybit there also
Message-ID: <20020826111549.A9447@ucw.cz>
References: <20020820153813.A13034@ucw.cz> <20020821191034.A6014@ucw.cz> <20020821191227.B6014@ucw.cz> <20020821223222.A19016@ucw.cz> <20020822110918.A25229@ucw.cz> <20020825152557.A26662@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020825152557.A26662@ucw.cz>; from vojtech@suse.cz on Sun, Aug 25, 2002 at 03:25:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.542, 2002-08-26 11:13:55+02:00, vojtech@suse.cz
  Shorten the keycode handling code in keyboard.c and evdev.c.
  Recompute keybit when keycode table changes.
  Stricter checks on input keycode/scancode values.


===================================================================

 drivers/char/keyboard.c |   39 ++++++++++++++++++++++-----------------
 drivers/input/evdev.c   |   29 ++++++++++++-----------------
 include/linux/input.h   |    3 +++
 3 files changed, 37 insertions(+), 34 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Mon Aug 26 11:14:16 2002
+++ b/drivers/char/keyboard.c	Mon Aug 26 11:14:16 2002
@@ -131,39 +131,44 @@
 int getkeycode(unsigned int scancode)
 {
 	struct input_handle *handle;
-	unsigned int keycode;
+	struct input_dev *dev = NULL;
 
 	for (handle = kbd_handler.handle; handle; handle = handle->hnext) 
-		if (handle->dev->keycodesize) break;
+		if (handle->dev->keycodesize) { dev = handle->dev; break; }
 
-	if (!handle->dev->keycodesize)
+	if (!dev)
 		return -ENODEV;
 
-	switch (handle->dev->keycodesize) {
-		case 1: keycode = *(u8*)(handle->dev->keycode + scancode); break;
-		case 2: keycode = *(u16*)(handle->dev->keycode + scancode * 2); break;
-		case 4: keycode = *(u32*)(handle->dev->keycode + scancode * 4); break;
-		default: return -EINVAL;
-	}
+	if (scancode < 0 || scancode >= dev->keycodemax)
+		return -EINVAL;
 
-	return keycode;
+	return INPUT_KEYCODE(dev, scancode);
 }
 
 int setkeycode(unsigned int scancode, unsigned int keycode)
 {
 	struct input_handle *handle;
+	struct input_dev *dev = NULL;
+	int i, oldkey;
 
 	for (handle = kbd_handler.handle; handle; handle = handle->hnext) 
-		if (handle->dev->keycodesize) break;
+		if (handle->dev->keycodesize) { dev = handle->dev; break; }
 
-	if (!handle->dev->keycodesize)
+	if (!dev)
 		return -ENODEV;
 
-	switch (handle->dev->keycodesize) {
-		case 1: *(u8*)(handle->dev->keycode + scancode) = keycode; break;
-		case 2: *(u16*)(handle->dev->keycode + scancode * 2) = keycode; break;
-		case 4: *(u32*)(handle->dev->keycode + scancode * 4) = keycode; break;
-	}
+	if (scancode < 0 || scancode >= dev->keycodemax)
+		return -EINVAL;
+
+	oldkey = INPUT_KEYCODE(dev, scancode);
+	INPUT_KEYCODE(dev, scancode) = keycode;
+
+	for (i = 0; i < dev->keycodemax; i++)
+		if(INPUT_KEYCODE(dev, scancode) == oldkey)
+			break;
+	if (i == dev->keycodemax)
+		clear_bit(oldkey, dev->keybit);
+	set_bit(keycode, dev->keybit);
 	
 	return 0;
 }
diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Mon Aug 26 11:14:16 2002
+++ b/drivers/input/evdev.c	Mon Aug 26 11:14:16 2002
@@ -234,7 +234,7 @@
 	struct evdev *evdev = list->evdev;
 	struct input_dev *dev = evdev->handle.dev;
 	struct input_absinfo abs;
-	int t, u;
+	int i, t, u;
 
 	if (!evdev->exist) return -ENODEV;
 
@@ -258,26 +258,21 @@
 
 		case EVIOCGKEYCODE:
 			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
-			if (t < 0 || t > dev->keycodemax) return -EINVAL;
-			switch (dev->keycodesize) {
-				case 1: u = *(u8*)(dev->keycode + t); break;
-				case 2: u = *(u16*)(dev->keycode + t * 2); break;
-				case 4: u = *(u32*)(dev->keycode + t * 4); break;
-				default: return -EINVAL;
-			}
-			if (put_user(u, ((int *) arg) + 1)) return -EFAULT;
+			if (t < 0 || t > dev->keycodemax || !dev->keycodesize) return -EINVAL;
+			if (put_user(INPUT_KEYCODE(dev, t), ((int *) arg) + 1)) return -EFAULT;
 			return 0;
 
 		case EVIOCSKEYCODE:
 			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
-			if (t < 0 || t > dev->keycodemax) return -EINVAL;
-			if (get_user(u, ((int *) arg) + 1)) return -EFAULT;
-			switch (dev->keycodesize) {
-				case 1: *(u8*)(dev->keycode + t) = u; break;
-				case 2: *(u16*)(dev->keycode + t * 2) = u; break;
-				case 4: *(u32*)(dev->keycode + t * 4) = u; break;
-				default: return -EINVAL;
-			}
+			if (t < 0 || t > dev->keycodemax || !dev->keycodesize) return -EINVAL;
+			u = INPUT_KEYCODE(dev, t);
+			if (get_user(INPUT_KEYCODE(dev, t), ((int *) arg) + 1)) return -EFAULT;
+
+			for (i = 0; i < dev->keycodemax; i++)
+				if(INPUT_KEYCODE(dev, t) == u) break;
+			if (i == dev->keycodemax) clear_bit(u, dev->keybit);
+			set_bit(INPUT_KEYCODE(dev, t), dev->keybit);
+
 			return 0;
 
 		case EVIOCSFF:
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Mon Aug 26 11:14:16 2002
+++ b/include/linux/input.h	Mon Aug 26 11:14:16 2002
@@ -757,6 +757,9 @@
 #define BIT(x)	(1UL<<((x)%BITS_PER_LONG))
 #define LONG(x) ((x)/BITS_PER_LONG)
 
+#define INPUT_KEYCODE(dev, scancode) ((dev->keycodesize == 1) ? ((u8*)dev->keycode)[scancode] : \
+	((dev->keycodesize == 1) ? ((u16*)dev->keycode)[scancode] : (((u32*)dev->keycode)[scancode])))
+
 struct input_dev {
 
 	void *private;

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch9436
M'XL(`&CQ:3T``]U8:T_C1A3];/^*N]HO,1!G9OP.#5T*M$6+6`1+I:I4R+''
MQ$MB(WN<?=3][[WC24+("PJTE1JBC#SW,6?NW'-L\Q8N2UYTM7'^2?!HH+^%
MG_-2=+6R*KD9?</K\SS'Z\X@'_'.Q*O3O^VDV5TE=+2?A2(:P)@795>CIC6;
M$5_O>%<[/_KI\F3_7-=[/3@8A-D-O^`">CU=Y,4X',;ENU`,AGEFBB+,RA$7
MH1GEHWKF6C-"&/XYU+.(X];4);971S2F-+0ICPFS?=?6)\#>36`OQOO,H1;S
MF%?;5A`P_1"HZ=@,".L0O\-<H+1+K:[C;!/6)006TL&V!6VB_P"O"_I`C^!B
MD!>"9R`&'&[YURB/.6":>)AF-]!<I9DT]/.PB,T(T`1\'/.Q&9D8?LYQ83R(
M)KB?"O@\X-DLD0C[0PY1`ZN4[A>B2"/!"YSCT6T)>0;-.4XC.F449DTH;K.2
M,>_!MFS/T<_N3T]O_\V/KI.0Z'N/5"_-HF&%$'#GU1?57N9@OI*!36O7MJE?
M)Q;K^\QRW803'A)_\;PVY?*92P)J.:RV**6/PXJ+5/:V2M*9E'X.EHU#[2(\
MK^:!G]`@LOMQ%-I>D"S!VI#K'I:+B>F38>'A%IW[_G@`C-BUXP0TJ+D=Q82[
M?18G/$DL=RVPE=FFT&C-`@\K)JF\)N!Q8K\(]Q+-'\$M24^Q7RR;(-TDZ2E=
MXCQ=QWG&H$V]_X;U_Q*WU8%^@';QN?DB5\_6G>TS:'](+1NH?JP&K11%%0F%
MZAI['[;D3P].+T].=J6SIYSEH&EI`JVF)KR]AW[MO<D^RO0;-^`/4+%S'KO0
M+WAXNPM_RER!RB6')M4;]##0@*KOHL'V@"G#K"S?`8&ZAMGU7@_FUQV%7PR$
M57!1%1FTCXY/?]EO8-MJJ6:8FH]/SRX_7K\_^O7@P^%1"]/LS/(:N^CLV'+Y
MS071T@QM.Y`/8X0@5W)4@9S7*)"C4#M+!7(9.&APD2"O4Z$K75-;0#2;ZZ)M
M,F/T9)TF99(7T$IQDNQ"BL@6@.#D]K;15*FU.6MO4F#IK*D"J6VGTK9B?]&0
MA\4U$K*E`G=F3C@G=U%RT9@G88OV>?U\<"=XNGH^XV:D]Y'.F+>?WMSE66QF
M7)AAM2DCJABU9.::V(RX2C_=)?UDZ_23_O_U4]VKU^CG@Y(^1SV9$D0U3-5`
M[$"%6L!<"C[:7%\*B1(#,26H@+W%QI73;Y958I&KDTQ2C_`8BU74$<8.M%H2
MS98!87%CP#908R[5C_N7)Q\E1,]J(/H$@M>%6*U6DH9\:IT;_O(-7,ED3Y69
M=4(C&H6I#)@JB[9>6^!>6:HE4=%FLK)F2P_]KQJ96?D<_+C,O.!1?.D1;>.C
M^/0!C3J.K][*J/=T@?G'7LKVXWBAOPP8A5&12\ZKUX8%SJ_<Y3,X?^SA#1G?
MH6.>I!G?>+O$'EXDBVPJ:L#W:*K\+6/>;/PV#?P=NH"MO3F:NIO"6^AAL;4>
<AF'(_IO^(T#I:37J6<0E<>(Z^E]T]1+!=1``````
`
end
-- 
Vojtech Pavlik
SuSE Labs

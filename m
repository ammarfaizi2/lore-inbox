Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318257AbSG3NTk>; Tue, 30 Jul 2002 09:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSG3NTk>; Tue, 30 Jul 2002 09:19:40 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:57801 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318257AbSG3NTi>;
	Tue, 30 Jul 2002 09:19:38 -0400
Date: Tue, 30 Jul 2002 15:22:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: [patch] Input cleanups for 2.5.29 [1/2]
Message-ID: <20020730152255.A20071@ucw.cz>
References: <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020730122918.A11248@ucw.cz>; from vojtech@suse.cz on Tue, Jul 30, 2002 at 12:29:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 12:29:18PM +0200, Vojtech Pavlik wrote:

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.528, 2002-07-30 15:02:05+02:00, bhards@bigpond.net.au
  Change the EVIOC?ABS ioctls to use structs rather than arrays of ints.


===================================================================

 drivers/input/evdev.c |   27 +++++++++++++++++----------
 include/linux/input.h |   12 ++++++++++--
 2 files changed, 27 insertions(+), 12 deletions(-)

===================================================================

diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Tue Jul 30 15:21:38 2002
+++ b/drivers/input/evdev.c	Tue Jul 30 15:21:38 2002
@@ -233,6 +233,7 @@
 	struct evdev_list *list = file->private_data;
 	struct evdev *evdev = list->evdev;
 	struct input_dev *dev = evdev->handle.dev;
+	struct input_absinfo abs;
 	int t, u;
 
 	if (!evdev->exist) return -ENODEV;
@@ -378,11 +379,14 @@
 
 				int t = _IOC_NR(cmd) & ABS_MAX;
 
-				if (put_user(dev->abs[t],     ((int *) arg) + 0)) return -EFAULT;
-				if (put_user(dev->absmin[t],  ((int *) arg) + 1)) return -EFAULT;
-				if (put_user(dev->absmax[t],  ((int *) arg) + 2)) return -EFAULT;
-				if (put_user(dev->absfuzz[t], ((int *) arg) + 3)) return -EFAULT;
-				if (put_user(dev->absflat[t], ((int *) arg) + 4)) return -EFAULT;
+				abs.value = dev->abs[t];
+				abs.minimum = dev->absmin[t];
+				abs.maximum = dev->absmax[t];
+				abs.fuzz = dev->absfuzz[t];
+				abs.flat = dev->absflat[t];
+
+				if (copy_to_user((void *) arg, &abs, sizeof(struct input_absinfo)))
+					return -EFAULT;
 
 				return 0;
 			}
@@ -391,11 +395,14 @@
 
 				int t = _IOC_NR(cmd) & ABS_MAX;
 
-				if (get_user(dev->abs[t],     ((int *) arg) + 0)) return -EFAULT;
-				if (get_user(dev->absmin[t],  ((int *) arg) + 1)) return -EFAULT;
-				if (get_user(dev->absmax[t],  ((int *) arg) + 2)) return -EFAULT;
-				if (get_user(dev->absfuzz[t], ((int *) arg) + 3)) return -EFAULT;
-				if (get_user(dev->absflat[t], ((int *) arg) + 4)) return -EFAULT;
+				if (copy_from_user(&abs, (void *) arg, sizeof(struct input_absinfo)))
+					return -EFAULT;
+
+				dev->abs[t] = abs.value;
+				dev->absmin[t] = abs.minimum;
+				dev->absmax[t] = abs.maximum;
+				dev->absfuzz[t] = abs.fuzz;
+				dev->absflat[t] = abs.flat;
 
 				return 0;
 			}
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Tue Jul 30 15:21:38 2002
+++ b/include/linux/input.h	Tue Jul 30 15:21:38 2002
@@ -63,6 +63,14 @@
 	__u16 version;
 };
 
+struct input_absinfo {
+	int value;
+	int minimum;
+	int maximum;
+	int fuzz;
+	int flat;
+};
+
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
 #define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
 #define EVIOCGREP		_IOR('E', 0x03, int[2])			/* get repeat settings */
@@ -79,8 +87,8 @@
 #define EVIOCGSND(len)		_IOC(_IOC_READ, 'E', 0x1a, len)		/* get all sounds status */
 
 #define EVIOCGBIT(ev,len)	_IOC(_IOC_READ, 'E', 0x20 + ev, len)	/* get event bits */
-#define EVIOCGABS(abs)		_IOR('E', 0x40 + abs, int[5])		/* get abs value/limits */
-#define EVIOCSABS(abs)		_IOW('E', 0xc0 + abs, int[5])		/* set abs value/limits */
+#define EVIOCGABS(abs)		_IOR('E', 0x40 + abs, struct input_absinfo)		/* get abs value/limits */
+#define EVIOCSABS(abs)		_IOW('E', 0xc0 + abs, struct input_absinfo)		/* set abs value/limits */
 
 #define EVIOCSFF		_IOC(_IOC_WRITE, 'E', 0x80, sizeof(struct ff_effect))	/* send a force effect to a force feedback device */
 #define EVIOCRMFF		_IOW('E', 0x81, int)			/* Erase a force effect */

===================================================================

This BitKeeper patch contains the following changesets:
1.528
## Wrapped with gzip_uu ##


begin 664 bkpatch20030
M'XL(`.*21CT``\U6;6_;-A#^+/Z*`P*L=A)+)/7NP%W2).V,%4C@+-N';0AH
MB;+8VI(A48Z3:?]]U$L<VW.=-=V`R8:DXQV/#Q\]=](!W.8\ZVN+])/D08P.
MX(<TEWTM+W*N!X_*'J6ILHTXG7&CC3+&GPV1S`N)E/^:R2"&!<_ROD9T<S4B
M'^:\KXTN/]Q^/!LA-!C`><R2";_A$@8#)--LP:9A?LID/$T3768LR6=<,CU(
M9^4JM*084_6SB6MBVRF)@RVW#$A("+,(#S&U/,="+;#3%O;V?#47^[9%G=+T
M'=-"%T!TFWJ`J8%=P\1`[#ZF?6P?56<,XYAE"MI83.9I$NH)ESHKX(A"#Z-W
M\.]"/T=!RPS(F,/ES\.K\^_/WMV`2`,YS=5JH#8%N<R*0.:0J45YID)9`BS+
MV$,.:00BD;F.?@33I]1'U\]4H]Y7'@AAAM';%S8IDF!:A-R8BJ18-EK0X_4-
M^Q8I'<LB7AF9=.Q1TW$BCCG#WFYR]V54]!&SRJPHM'SW17!A)BHY-DD,O@CY
M0@_6P%GJ4CH*I%MRWXN('UCC,&"6ZT=?`+<GXS,X;%'LU$+?&?ZRZ+\!]ZH`
MY+V8BDDL]2*XKPIA'W)J$\MT*EJI;^.Z*(C]MYJ@^VN"N-`C_TU5C+@LLD0D
M$V"M_-MBR/(Y"SB('!(1\*P2?LW]%?2R^_JO='R]^S&\HB"&U+2!(*W%4*>[
M8^-<)%$*ZGJ"+DR/@(V&IF>#AS1UJ&%=T5%P4'+@B]Y;-?"K_/UDY9R)1,R*
MV9I;C6Q&L.5V!%MN1$3%X^.:NS(W_5,FU_W*K/V_U1$B@DZ0SA_N9'I7D=KI
M+%(1PF%7]97),7RG9AQ#+AYY&G5V;;W;[=9YM*Q^3M"[?']V^_&GB@W?JMGP
MO9:-U5)1ELZ:Q9KTFTN^9K%F+VL4JPVOR#_9<#8$M_Z6_ZV(FN"GB(;_S8B6
MXS:DLK;\#<=/?F6=U"UA9WM[N25\0Y]%GU)5<XD>\H07RU.A6D*AYWQOHZ4>
M(=C"7HEMUW>:CF!^=4?`T*/_[]=D\Q[9:A<[B7E-NW"J)K"S6?R!-`4!GK19
MW3_KL+96FJNL5E[U;:VD/RN]7W@4*!IZICH?A#P224O'!T5'1RW5U;2[X=6H
M\^;RS3'@I87A")IBWE58FF8<PD1]E*F!!IEB8"84AX?&9OZ;C?R_/.4/_D'^
=_`OY5U^+0<R#SWDQ&[B1XY*0,_07/W.9&9H*````
`
end

-- 
Vojtech Pavlik
SuSE Labs

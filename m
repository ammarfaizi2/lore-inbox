Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbSKOIKX>; Fri, 15 Nov 2002 03:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbSKOIJa>; Fri, 15 Nov 2002 03:09:30 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:56961 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265982AbSKOIIo>;
	Fri, 15 Nov 2002 03:08:44 -0500
Date: Fri, 15 Nov 2002 09:15:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - handle return values from interface_register() [10/13]
Message-ID: <20021115091532.I16779@ucw.cz>
References: <20021115090818.A16761@ucw.cz> <20021115090922.A16779@ucw.cz> <20021115091011.B16779@ucw.cz> <20021115091119.C16779@ucw.cz> <20021115091214.D16779@ucw.cz> <20021115091247.E16779@ucw.cz> <20021115091347.F16779@ucw.cz> <20021115091422.G16779@ucw.cz> <20021115091448.H16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115091448.H16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:14:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.798.1.3, 2002-11-09 11:00:34+01:00, mikal@stillhq.com
  Handle return values from interface_register() and misc_register()
  in the input drivers.


 evbug.c    |    9 +++++++--
 evdev.c    |    9 +++++++--
 joydev.c   |    7 ++++++-
 mousedev.c |   14 +++++++++++---
 4 files changed, 31 insertions(+), 8 deletions(-)

===================================================================

diff -Nru a/drivers/input/evbug.c b/drivers/input/evbug.c
--- a/drivers/input/evbug.c	Fri Nov 15 08:30:48 2002
+++ b/drivers/input/evbug.c	Fri Nov 15 08:30:48 2002
@@ -95,7 +95,12 @@
 
 int __init evbug_init(void)
 {
-	interface_register(&evbug_intf);
+	int retval;
+
+	retval = interface_register(&evbug_intf);
+	if(retval < 0)
+		return retval;
+
 	input_register_handler(&evbug_handler);
 	return 0;
 }
@@ -103,7 +108,7 @@
 void __exit evbug_exit(void)
 {
 	input_unregister_handler(&evbug_handler);
-	interface_register(&evbug_intf);
+	interface_unregister(&evbug_intf);
 }
 
 module_init(evbug_init);
diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Fri Nov 15 08:30:48 2002
+++ b/drivers/input/evdev.c	Fri Nov 15 08:30:48 2002
@@ -442,7 +442,12 @@
 
 static int __init evdev_init(void)
 {
-	interface_register(&evdev_intf);
+	int retval;
+
+	retval = interface_register(&evdev_intf);
+	if(retval < 0)
+		return retval;
+
 	input_register_handler(&evdev_handler);
 	return 0;
 }
@@ -450,7 +455,7 @@
 static void __exit evdev_exit(void)
 {
 	input_unregister_handler(&evdev_handler);
-	interface_register(&evdev_intf);
+	interface_unregister(&evdev_intf);
 }
 
 module_init(evdev_init);
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	Fri Nov 15 08:30:48 2002
+++ b/drivers/input/joydev.c	Fri Nov 15 08:30:48 2002
@@ -499,7 +499,12 @@
 
 static int __init joydev_init(void)
 {
-	interface_register(&joydev_intf);
+	int retval;
+
+	retval = interface_register(&joydev_intf);
+	if(retval < 0)
+		return retval;
+
 	input_register_handler(&joydev_handler);
 	return 0;
 }
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Fri Nov 15 08:30:48 2002
+++ b/drivers/input/mousedev.c	Fri Nov 15 08:30:48 2002
@@ -41,6 +41,7 @@
 	int exist;
 	int open;
 	int minor;
+	int misc;
 	char name[16];
 	wait_queue_head_t wait;
 	struct list_head list;
@@ -489,7 +490,11 @@
 
 static int __init mousedev_init(void)
 {
-	interface_register(&mousedev_intf);
+	int retval;
+
+	if((retval = interface_register(&mousedev_intf)) < 0)
+		return retval;
+
 	input_register_handler(&mousedev_handler);
 
 	memset(&mousedev_mix, 0, sizeof(struct mousedev));
@@ -499,8 +504,10 @@
 	mousedev_mix.exist = 1;
 	mousedev_mix.minor = MOUSEDEV_MIX;
 	mousedev_mix.devfs = input_register_minor("mice", MOUSEDEV_MIX, MOUSEDEV_MINOR_BASE);
+
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
-	misc_register(&psaux_mouse);
+	if (!(mousedev_mix.misc = !misc_register(&psaux_mouse)))
+		printk(KERN_WARNING "mice: could not misc_register the device\n");
 #endif
 
 	printk(KERN_INFO "mice: PS/2 mouse device common for all mice\n");
@@ -511,7 +518,8 @@
 static void __exit mousedev_exit(void)
 {
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
-	misc_deregister(&psaux_mouse);
+	if (mousedev_mix.misc)
+		misc_deregister(&psaux_mouse);
 #endif
 	input_unregister_minor(mousedev_mix.devfs);
 	input_unregister_handler(&mousedev_handler);

===================================================================

This BitKeeper patch contains the following changesets:
1.798.1.3
## Wrapped with gzip_uu ##


begin 664 bkpatch16321
M'XL(`*BBU#T``]5776_:2!1]9G[%M)4J4(6Y,QY_D665;E.U4:LT8E7M2Z1H
ML,?@QMBI/TB[\H_?.S8$$@BLV3YD`3&V&9][?.?<<X=7]&NNLF%GD7XKE#\C
MK^C'-"^&G;S,E>'_C>?C-,7SP2R=J\%RUF!R,XB2V[(@^/NE+/P97:@L'W:8
M8=Y?*7[>JF%G_/[#U\]OQX2,1O3=3"93]:<JZ&A$BC1;R#C(3V4QB]/$*#*9
MY'-52,-/Y]7]U(H#<'Q;S#'!LBMF@W`JGP6,2<%4`%RXMB!+8J=+VH_N9PP\
M\`1GHF*>YS%R1IGA>*Z!?"GP`6,#\"AC0X"A*=Z`/J#SZ$;&IWD1Q?'LNR9%
MWPC:!_('_;74WQ&??I1)$"N:J:+,$HK@I<IIF&',*"E4%DI?76=J&N5XTNU1
MG(WT<G_C&H)$"2UFBM8+0X,LTDMBD$^4@P,NN5RGG_1;O@@!">3W`P^^#-DH
M8Z`6@5H8_D82!`Z5C<EP*N6Y(?-\,0E\*1POW$[V'C2]F@P`3*B$XUI62V+S
M%#6RFYN)&JE\:8:26T("L_AD(@]R>P2X2<]B)FM)[UOZ<S<Y+FR!%&$B0I,'
MRI?<A\/D'L!M4&,:#JFM"J>XB^)H.BN,TK_3!?0X_9-RNN+D@,E,<`54IN.8
M7L6="9<6EPQ"RQ;B7ZSE&FR#$6"%BMHG=B[]8<_X#_K;\H\]6!ZWF`7"<BMA
M,LNNO81Y6S8"3]N(0_O\&=B(]H:F@+[0?G97?[#6+W?G_PC3.!/"HHR<Z\$F
M'>2@J2&M$W)%.LTA'>WB]KH.>HV_A+T3O#/L+F?_1J%'.IWE$Z[1SH1EUJ'J
MH;.&+),G0+>%MBJ5MDIK5[$'I/80;*TU<#R/-UK;;EE[M&;3/GLF6FLL9Z_6
M5D]_C-@LX%H!>F@IMB9J"[5M:V?=`]JJIVT[.J"?QW`>MSD(QLW*1(/E1[@5
M8[1O/@,)[=KUU!96-]F]LEHGY0AAG8N5I=313]!KO%II>K"VE(;JZ>Y5VXI,
MH[?>DR)#)3,,<Z65;3;*-BG7`6CW1?<>91[],#0OC/;B879>W^:R_'%=S^SU
M=(S;#&/>=#^]'U]<__5V?'%^\8&^G$>^&E(_+>.`)FGQ,,7UCA+#X)RKY"56
MQYG%1$T&AR69+2HZ5(T2J-UD=KGO<E>@R^?7[TG(//5G*CY-\R`VTFRZ#\K%
MBF&`FQ*]5W";_PK6_[2]ZQW5@>9>/_DQ?NNY6@?XW;JU8\@VK9V!K2,UPY.M
<?0/T_B\HKKE_DY?SD0W@.*'@Y!\-Y5#L[PX`````
`
end
